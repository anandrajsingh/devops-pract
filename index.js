const express = require("express")
const { randomUUID } = require('crypto');   

const app = express()
app.use(express.json())

let users = []

app.get("/health", (_req, res) => {
    res.status(200).json({ status: "up" })
})

app.get("/api/users", (_req, res) => {
    res.json(users)
})

app.post("/api/adduser", (req, res) => {
    const {name, age} = req.body;
    if(!name || !age){
        return res.status(400).json({error: "Both field are required"})
    }
    const user = {id: randomUUID(), name, age}
    console.log(user)

    users.push(user)
    res.status(201).json(user)
})

app.delete("/api/users/:id", (req, res) => {
    const id = req.params.id;

    const userIndex = users.findIndex(user => user.id === id);

    if(userIndex === -1){
        return res.status(400).json({error: "User not found for this id"})
    }

    const deletedUser = users.splice(userIndex, 1)
    res.status(200).json(deletedUser)
})

app.listen(3000, () => console.log("App listening on port 3000"))