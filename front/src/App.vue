<template>
    <v-app>
        <v-overlay :value="loading">
            <v-progress-circular indeterminate size="64" />
        </v-overlay>
        <v-app-bar
            id="navbar"
            app
            color="primary">
            <v-btn 
                depressed
                large
                color="transparent"
                class=" d-flex align-center">
                <v-icon 
                    color="white"
                    x-large>
                    mdi-github
                </v-icon>
                <h3 class="text-h4 white--text text-capitalize"> Github Scrapper</h3>
            </v-btn>

            <v-fade-transition>
                <v-text-field 
                    id="search"
                    v-if="showSearch"
                    v-model="search"
                    class="mx-auto limit-size"
                    hide-details
                    prepend-inner-icon="mdi-magnify"
                    max-width="500px"
                    @change="emitSearchText"
                    solo/>
            </v-fade-transition>
            
            <v-btn 
                depressed
                large
                color="transparent"
                @click.native="createUserDialog = true"
                class="ml-auto d-flex align-center">
                <v-icon 
                    color="white"
                    x-large>
                    mdi-plus
                </v-icon>
                <h3 class="white--text"> Adicionar perfil</h3>
            </v-btn>
        </v-app-bar>

        <v-main>
            <h1 class="text-h3 text-center mt-8 font-weight-light"> Github profile Scrapper</h1>
            <v-fade-transition mode="out-in">
                <router-view />
            </v-fade-transition>
        </v-main>

        <CreateUserDialog 
            :dialog="createUserDialog"
            @createUser="createUser"
            @closeDialog="createUserDialog = false"/>
        
        <notifications group="foo" />
    </v-app>
</template>

<script>
import { mapActions } from "vuex";
import CreateUserDialog from "./views/CreateUserDialog";
import UserService from './services/UserService';

const userService = new UserService();

export default {
    name: 'App',
    components: {
        CreateUserDialog
    },
    data: () => ({
        showSearch: true,
        search: "",
        createUserDialog: false,
        loading: false
    }),
    watch: {
        '$route' (to) {
            console.log(to)
            if(to.path == "/" ) {
                this.showSearch = true
            }
            else {
                this.showSearch = false
                this.search = ""
            }
        }
    },
    methods: {
        ...mapActions(['setSearchText']),
        emitSearchText(value) {
            this.setSearchText(value)
        },
        async createUser(payload) {
            this.loading = true
            this.createUserDialog = false
            try {
                await userService.createUser({ 
                    name: payload.name,
                    url: payload.url
                })
                this.$notify({
                    group: 'foo',
                    title: 'Usuário criado com sucesso!',
                    type: 'success'
                });
            } catch(e) {
                if(e.response.status === 500) {
                    this.$notify({
                        group: 'foo',
                        title: 'Erro ao criar usuário',
                        text: 'Esse usuário já está cadastrado!',
                        type: 'error'
                    });
                }
                if(e.response.status === 422) {
                    this.$notify({
                        group: 'foo',
                        title: 'Erro ao criar usuário',
                        text: 'Perfil no github não encontrado!',
                        type: 'error'
                    });
                }
            }

            this.loading = false
        }
    }
};
</script>

<style lang="scss">
#navbar {
    .v-toolbar__content {
        width: 100%;
    }

    .limit-size {
        max-width: 450px;
    }
}
</style>
