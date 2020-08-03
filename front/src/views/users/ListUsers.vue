<template>
    <section>
        <v-overlay :value="loading">
            <v-progress-circular indeterminate size="64" />
        </v-overlay>
        <v-fade-transition mode="out-in">

            <div v-if="userList.length"
                class="d-flex align-center justify-center">
                <div 
                    v-for="user in userList"
                    :key="user.id">
                    <UserItem 
                        @select="showUser"
                        :user=user />
                </div>
                
            </div>
            <div
                class="mt-12" 
                v-else>
                <h3 class="text-center text-h4 font-weight-ligth"> Nenhum usuário encontrado para o termo pesquisado</h3>
                <h3 class="text-center text-h5 font-weight-ligth"> Ou você não fez uma pesquisa ainda. Nesse caso é só usar a barra acima :)</h3>
            </div>
        </v-fade-transition>
    </section>
</template>

<script>
import UserService from "../../services/UserService";
import UserItem from "../../components/UserItem";
import { mapState, mapActions } from "vuex";

const userService = new UserService();

export default {
    data: () => ({
        userList: [],
        loading: false
    }),
    components: {
        UserItem
    },
    computed: {
        ...mapState(['searchText'])
    },
    methods: {
        ...mapActions(['setUser']),
        async listUsers() {
            try {
                const response = await userService.listUsers();

                this.userList = response.data
            } catch(e) {
                console.log(e)
            }
        },
        async searchUsers(value) {
            try {
                const response = await userService.searchUsers(value);

                this.userList = response.data
            } catch(e) {
                this.userList = []
            }
        },
        showUser(user) {
            this.setUser(user);
            this.$router.push({ path: '/details'})
        }
    },
    watch: {
        searchText: async function(val) {
            this.loading = true
            await this.searchUsers(val)
            this.loading = false
        }
    },
    async created() {
    }
}
</script>