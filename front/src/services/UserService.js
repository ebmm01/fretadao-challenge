import axios from "axios";

class UserService {
    
    constructor() {
        console.log(process.env.VUE_APP_BACKEND_API)
        this.client = axios.create({
            baseURL: process.env.VUE_APP_BACKEND_API,
            headers: {
                Accept: "application/json",
                "Content-Type": "application/json"
            }
        })
    }

    async listUsers() {
        return await this.client.get("/users")
    }

    async searchUsers(text) {
        return await this.client.get(`/search/${text}`)
    }

    async rescrapUser(id) {
        return await this.client.put(`users/${id}/rescrapper`)
    }

    async getUserById(id) {
        return await this.client.get(`/users/${id}`)
    }

    async updateUser({ id, name, url = undefined}) {
        return await this.client.put(`/users/${id}`, { 
            name,
            ...(!!url && { url })
        })
    }

    async createUser({name, url}) {
        return await this.client.post(`/users`, {name, url})
    }

    async deleteUser(id) {
        return await this.client.delete(`/users/${id}`)
    }
}

export default UserService