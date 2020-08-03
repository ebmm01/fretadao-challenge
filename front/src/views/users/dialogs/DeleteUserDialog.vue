<template>
    <v-dialog
        v-model="dialog"
        width="500">

        <v-card>
            <v-card-title class="headline grey lighten-2">
                Excluir usuário
            </v-card-title>

            <v-card-text>
                Tem certeza que deseja continuar? Essa ação é irreversível
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
                color="red"
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
        }
    }),
    methods: {
        finish() {
            this.$emit('confirmDelete')
        },
        closeDialog() {
            this.$emit('closeDialog')
        }
    }
}
</script>