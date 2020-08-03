<template>
    <section
        class="pa-3 details">
        <v-overlay :value="loading">
            <v-progress-circular indeterminate size="64" />
        </v-overlay>
        <div class="left-section">
            <div class="img-with-actions">
                <v-btn
                    class="mx-2"
                    depressed
                    id="returnbtn"
                    color="white"
                    @click="returnPage"
                    fab>
                    <v-icon>mdi-arrow-left</v-icon>
                </v-btn>
                <img 
                    class="elevation-5"
                    :src="user.profile_image">
                <div class="actions">
                    <v-btn
                        @click="rescapperUser"
                        class="mx-2"
                        fab>
                        <v-icon>mdi-refresh</v-icon>
                    </v-btn>
                    <v-btn
                        class="mx-2"
                        @click="deleteUserDialog = true"
                        fab>
                        <v-icon>mdi-delete</v-icon>
                    </v-btn>
                    <v-btn
                        class="mx-2"
                        @click="editUserDialog=true"
                        fab>
                        <v-icon>mdi-pencil</v-icon>
                    </v-btn>
                </div>
            </div>
        </div>

        <div class="right-section">
            <h3 class="text-h3 mb-4">{{ user.github_name}}</h3>

            <span class="detais-item">
                <p>Nome:  <b class="mr-2">{{user.name}}</b></p>
            </span>
            <span class="detais-item">
                <v-icon class="mr-2" color="black">mdi-at</v-icon>
                <p> <b class="mr-2">{{user.github_username}}</b></p>
            </span>
            <span class="detais-item">
                <v-icon class="mr-2" color="black">mdi-account-group</v-icon>
                <p> <b class="mr-2">{{user.followers}}</b></p> Seguidores
            </span>
            <span class="detais-item">
                <v-icon class="mr-2" color="black">mdi-account-group</v-icon>
                <p> <b class="mr-2">{{user.following}}</b></p> Seguindo
            </span>
            <span class="detais-item">
                <v-icon class="mr-2" color="black">mdi-star</v-icon>
                <p> <b class="mr-2">{{user.stars}}</b></p> estrelas
            </span>
            <span class="detais-item">
                <v-icon class="mr-2" color="black">mdi-source-branch</v-icon>
                <p> <b class="mr-2">{{user.last_year_contributions}}</b></p> Contribuições no último ano
            </span>
            <span class="detais-item" v-if="user.location"> 
                <v-icon class="mr-2" color="black">mdi-map-marker</v-icon>
                <p> <b class="mr-2">{{user.location}}</b></p>
            </span>
            <span class="detais-item" v-if="user.organization">
                <v-icon class="mr-2" color="black">mdi-office-building</v-icon>
                <p> <b class="mr-2">{{user.organization}}</b></p>
            </span>
            <span class="detais-item">
                <v-icon class="mr-2" color="black">mdi-github</v-icon>
                <p> <a :href="user.url">{{user.url}}</a></p>
            </span>
        </div>

        <EditUserDialog
            :dialog="editUserDialog"
            :user-data="user"
            @updateUser="editUser"
            @closeDialog="editUserDialog = false" />
        <DeleteUserDialog
            :dialog="deleteUserDialog"
            @confirmDelete="deleteUser"
            @closeDialog="deleteUserDialog = false" />
    </section>
</template>

<script>
import { mapState, mapActions } from "vuex"
import UserService from '../../services/UserService'
import EditUserDialog from "./dialogs/EditUserDialog"
import DeleteUserDialog from "./dialogs/DeleteUserDialog"

const userService = new UserService();

export default {
    components: {
        EditUserDialog,
        DeleteUserDialog
    },
    data: () => ({
        loading: false,
        editUserDialog: false,
        deleteUserDialog: false
    }),
    computed: {
        ...mapState(['user'])
    },
    methods: {
        ...mapActions(['setUser']),
        returnPage() {
            this.$router.push({ path: "/"})
        },
        async editUser(payload) {
            this.loading = true

            try {
                await userService.updateUser({
                    id:this.user._id.$oid,
                    name: payload.name,
                    ...(!!payload.url && { url: payload.url})
                })

                await this.updateUser();
                
                this.$notify({
                    group: 'foo',
                    title: 'Usuário atualizado com sucesso',
                    type: 'success'
                });
            }
            catch(e) {
                this.$notify({
                    group: 'foo',
                    title: 'Erro ao editar usuário',
                    text: e.message,
                    type: 'error'
                });
            }

            this.editUserDialog = false
            this.loading = false
        },
        async deleteUser() {
            this.loading = true

            try {
                await userService.deleteUser(this.user._id.$oid)
                this.$router.push({path: "/"})
                this.$notify({
                    group: 'foo',
                    title: 'Usuário removido com sucesso',
                    type: 'success'
                });
            } catch (e) {
                this.$notify({
                    group: 'foo',
                    title: 'Erro ao remover usuário',
                    text: e.message,
                    type: 'error'
                });
            }

            this.deleteUserDialog = false
            this.loading = false
        },

        async updateUser() {
            const response = await userService.getUserById(this.user._id.$oid);

            this.setUser(response.data);
        },
        async rescapperUser() {
            this.loading = true
            
            try {
                // refaço o scrapper do usuário
                await userService.rescrapUser(this.user._id.$oid);
                this.$notify({
                    group: 'foo',
                    title: 'Usuário atualizado com sucesso',
                    type: 'success'
                });
            }catch(e) {
                this.$notify({
                    group: 'foo',
                    title: 'Erro ao refazer o scrapper',
                    text: e.message,
                    type: 'error'
                });
            }

            await this.updateUser();

            this.loading = false
        }
    }
}
</script>

<style lang="scss">
.details {
    margin-top: 50px;
    display: flex;
    justify-content: center;
    align-items: center;

    .left-section {
        width: 400px;
        .img-with-actions {
            position: relative;

            #returnbtn {
                position: absolute;
                top: 20px;
                left: -70px;
            }

            img {
                border-radius: 15px;
                object-fit: cover;
                width: 100%;
            }

            .actions {
                position: absolute;
                bottom: 8px;
                width: 100%;
                display: flex;
                left: 50%;
                transform: translateX(-50%) translateY(50%);
                align-items: center;
                justify-content: center;
            }
        }
    }

    .right-section {
        padding-left: 20px;

        .detais-item {
            display: flex;
            margin-bottom: 10px;

            p {
                margin-bottom: 0;
            }
        }
    }
}
</style>