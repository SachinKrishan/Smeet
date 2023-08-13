const mongoose = require('mongoose')
const Schema = mongoose.Schema


const meetingSchema = new mongoose.Schema({
    name: String,
    description: String,
    mode: String,
    location: String,
    participants: [String], // Array of strings
    date: Date,
    fromTime: String,
    toTime: String,
  });


module.exports = mongoose.model('meetings', meetingSchema)