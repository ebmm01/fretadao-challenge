import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
    state: {
        searchText: "",
        user: {
            creationDate: "",
            followers: "",
            following: "",
            github_name: "",
            github_username: "",
            last_year_contributions: "",
            location: "",
            name: "",
            organization: "",
            profile_image: "",
            stars: "",
            url: ""
        }
    },
    mutations: {
        setSearchText(state, value) {
            state.searchText = value
        },
        setUser(state, user) {
            state.user = user
        }
    },
    actions: {
        setSearchText({commit}, value){
            commit('setSearchText', value)
        },
        setUser({commit}, user) {
            commit('setUser', user)
        }
    },
})
