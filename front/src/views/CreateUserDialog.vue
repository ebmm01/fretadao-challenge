<template>
    <v-dialog
        v-model="dialog"
        width="500"
        persistent>
        <v-card>
            <v-card-title class="headline grey lighten-2">
                Criar usuário
            </v-card-title>

            <v-card-text>
                <v-form
                    v-model="valid"
                    ref="form">
                    <v-text-field
                        required
                        label="Nome do usuário"
                        :rules="nameRules"
                        v-model="user.name"/>
                    <v-text-field
                        required
                        label="Url do usuário (github)"
                        :rules="nameRules"
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
    },
    data: () => ({
        user: {
            name: "",
            url: ""
        },
        valid: false,
        nameRules: [
            v => !!v || 'Campo obrigatório',
        ],
    
    }),
    methods: {
        finish() {
            if (this.$refs.form.validate()) {
                this.$emit('createUser', {
                    name: this.user.name,
                    url: this.user.url
                })
            }
        },
        closeDialog() {
            this.$emit('closeDialog')
        }
    }
}
</script>