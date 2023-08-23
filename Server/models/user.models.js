const mongoose = require('mongoose')
const Schema = mongoose.Schema


const timeSchema = new mongoose.Schema({
      fromTime: String,
      toTime: String
  });

const userSchema = new Schema({
    name:String,
    email:String,
    phone:String,
    password:String
})

module.exports = mongoose.model('user', userSchema)