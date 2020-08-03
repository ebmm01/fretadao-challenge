<template>
    <v-dialog
        v-model="dialog"
        width="500">

        <v-card>
            <v-card-title class="headline grey lighten-2">
                Editar usuário
            </v-card-title>

            <v-card-text>
                <v-form
                    ref="form">
                    <v-text-field
                        required
                        v-model="user.name"/>
                    <v-text-field
                        required
                        v-model="user.url"/>
                </v-form>
            </v-card-text>

            <v-divider></v-divider>

            <v-card-actions>
            <v-btn
                color="primary"
                text
                @click="closeDialog">
                Cancelar
            </v-btn>
            <v-spacer></v-spacer>
            <v-btn
                color="primary"
                text
                @click="finish">
                Confirmar
            </v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script>
export default {
    props: {
        dialog: {
            type: Boolean,
            required: true
        },
        userData: {
            type: Object,
            required: false,
            default: () => ({
                name: "",
                url: ""
            })
        }
    },
    data: () => ({
        user: {
            name: "",
            url: ""
        }
    }),
    methods: {
        finish() {
            if (this.$refs.form.validate()) {
                if (this.user.url == this.userData.url) {
                    this.user.url = ""

                    if (this.user.name == this.userData.name) {
                        this.closeDialog()
                    }
                }
                this.$emit('updateUser', {
                    name: this.user.name,
                    url: this.user.url
                })
            }
        },
        closeDialog() {
            this.$emit('closeDialog')
        }
    },
    watch: {
        dialog: function(val) {
            if (val && this.userData) {
                this.user = {...this.userData}
            }
        }
    }
}
</script>