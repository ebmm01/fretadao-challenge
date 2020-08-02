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
        return this.client.get("/users")
    }

    async searchUsers(text) {
        return this.client.get(`/search/${text}`)
    }
}

export default UserService