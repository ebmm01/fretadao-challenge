<template>
    <v-app>
        <v-app-bar
            id="navbar"
            app
            color="primary">
            <div class="d-flex align-center">
                <v-icon 
                    color="white"
                    x-large>
                    mdi-github
                </v-icon>
            </div>

            <v-text-field 
                id="search"
                class="mx-auto limit-size"
                hide-details
                prepend-inner-icon="mdi-magnify"
                max-width="500px"
                @change="emitSearchText"
                solo/>

            <v-btn
                href="https://github.com/vuetifyjs/vuetify/releases/latest"
                target="_blank"
                text
            >
                <span class="mr-2">Latest Release</span>
                <v-icon>mdi-open-in-new</v-icon>
            </v-btn>
        </v-app-bar>

        <v-main>
            <v-fade-transition>
                <router-view />
            </v-fade-transition>
        </v-main>
    </v-app>
</template>

<script>
import { mapActions } from "vuex";

export default {
    name: 'App',

    data: () => ({
        //
    }),
    
    methods: {
        ...mapActions(['setSearchText']),
        emitSearchText(value) {
            this.setSearchText(value)
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
