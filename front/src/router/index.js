import Vue from 'vue'
import VueRouter from 'vue-router'
import ListUsers from '../views/users/ListUsers.vue'

Vue.use(VueRouter)

  const routes = [
    {
        path: '/',
        name: 'listUsers',
        component: ListUsers
    }
]

const router = new VueRouter({
    routes
})

export default router
