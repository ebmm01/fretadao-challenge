import Vue from 'vue'
import VueRouter from 'vue-router'
import ListUsers from '../views/users/ListUsers.vue'
import UserDetails from '../views/users/UserDetails.vue'

Vue.use(VueRouter)

  const routes = [
    {
        path: '/',
        name: 'listUsers',
        component: ListUsers
    },
    {
        path: '/details',
        name: 'userDetails',
        component: UserDetails
    },

]

const router = new VueRouter({
    routes
})

export default router
