const mongoose = require('mongoose')
const Schema = mongoose.Schema


// const timeSchema = new mongoose.Schema({
//       fromTime: String,
//       toTime: String
//   });

const userSchema = new Schema({
    name:String,
    email:String,
    phone:String,
    // availability:{
    //     monday: timeSchema,
    //     tuesday: timeSchema,
    //     wednesday:timeSchema,
    //     thursday: timeSchema,
    //     friday: timeSchema,
    //     saturday: timeSchema,
    //     sunday: timeSchema
    // },
    password:String
})

module.exports = mongoose.model('user', userSchema)