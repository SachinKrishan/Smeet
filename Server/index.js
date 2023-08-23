const express = require('express')
const app = express()
const port = process.env.PORT || 8080
const cors = require('cors')
const bodyParser = require('body-parser')

const mongoose = require('mongoose')
mongoose.connect("mongodb+srv://sthyahar:smeetdb@cluster0.7jtmlh9.mongodb.net/smeetdb")


app.use(cors())
app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.json())
app.use('/',require('./routes/user.route'))
app.use('/',require('./routes/meeting.route'))
app.listen(port,()=>{
    console.log('port running on '+port)
})
