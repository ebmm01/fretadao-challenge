<template>
    <v-card
        :ripple="false"
        @click="emitUser"
        class="user-item">
        <img 
            class="elevation-4"
            :src="user.profile_image"/>

        <div class="text-area text-center">
            <h2 class="title">{{ user.name }}</h2>
            <p><b>Usuário github: </b> {{ user.github_username }}</p> 
            <p><b>Url:</b> {{ user.url }}</p> 
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

        .title {
        }

        p {
            margin-bottom: 5px;
        }
    }
}
</style>