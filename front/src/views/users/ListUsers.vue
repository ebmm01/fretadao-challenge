<template>
    <section>
        <v-overlay :value="loading">
            <v-progress-circular indeterminate size="64" />
        </v-overlay>
        <div 
            v-for="user in userList"
            :key="user.id">
            <UserItem :user=user />
        </div>
    </section>
</template>

<script>
import UserService from "../../services/UserService";
import UserItem from "../../components/UserItem";
import { mapState } from "vuex";

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
        await this.listUsers()
    }
}
</script>