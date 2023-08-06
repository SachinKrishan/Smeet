const express = require('express')
const app = express()
const port = process.env.PORT || 8080
const cors = require('cors')
const bodyParser = require('body-parser')

const mongoose = require('mongoose')
mongoose.connect("mongodb://localhost:27017/smeetdb",{ useNewUrlParser: true, useUnifiedTopology: true })


app.use(cors())
app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.json())
app.use('/',require('./routes/user.route'))
app.listen(port,()=>{
    console.log('port running on '+port)
})

// const {Server} = require('ws');

// const PORT = process.env.PORT || 3000;

// const server = express().use((req, res) => res.send('Hello World')).listen(PORT, () => console.log(`Listening on ${PORT}`));

// const wss = new Server({server});

// wss.on('connection', ws => {
//   console.log('Client connected');
//   ws.on('message', message => console.log(`Received: ${message}`));
//   ws.on('close', () => console.log('Client disconnected'));
// });