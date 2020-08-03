<template>
    <v-card
        :ripple="false"
        class="user-item">
        <img 
            class="elevation-4"
            :src="user.profile_image"/>

        <div class="text-area text-center pb-9">
            <h2 class="title">{{ user.name }}</h2>
            <p><b>Usuário github: </b> {{ user.github_username }}</p> 
            <p><b>Url:</b> {{ user.url }}</p> 
        </div>

        <div class="actions">
            <v-tooltip bottom>
                <template v-slot:activator="{ on, attrs }">
                     <v-btn
                        fab
                        class="mx-2"
                        v-bind="attrs"
                        v-on="on"
                        @click="emitUser">
                        <v-icon>mdi-plus</v-icon>
                    </v-btn>
                </template>
                <span>Ver detalhes</span>
            </v-tooltip>
            <v-tooltip bottom>
                <template v-slot:activator="{ on, attrs }">
                     <v-btn
                        fab
                        class="mx-2"
                        v-bind="attrs"
                        v-on="on"
                        @click="editUser">
                        <v-icon>mdi-pencil</v-icon>
                    </v-btn>
                </template>
                <span>Editar usuário</span>
            </v-tooltip>
        </div>
    </v-card>
</template>

<script>
export default {
    props: {
        user: {
            type: Object,
            required: true
        }
    },
    methods: {
        emitUser() {
            this.$emit("select", this.user)
        },
        editUser() {
            this.$emit("edit", this.user)
        }
    }
}
</script>

<style lang="scss">
.user-item {
    width: 300px;
    margin: 15px;
    margin-top: 30px;
    text-align: center;
    position: relative;
    
    img {
        object-fit: cover;
        width: 95%;
        transform: translateY(-15px);
        border-radius: 10px;
        object-position: center;
        max-height: 250px;
    }

    .text-area {
        padding: 0 15px 15px 15px;
        margin-top: -10px;
        p {
            margin-bottom: 5px;
        }
    }

    .actions {
        position: absolute;
        bottom: -25px;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
    }
}
</style>