const express = require('express')
const Meeting = require('../models/meeting.models.js')
const router = express.Router()

router.post('/createMeeting', async (req, res) => {
    console.log(req.body);
    try {

        const newMeeting = new Meeting({
            name: req.body.name,
            description: req.body.description,
            mode: req.body.mode,
            location: req.body.location,
            participants: req.body.participants, // Array of strings
            date: new Date(req.body.date),
            fromTime: req.body.fromTime,
            toTime: req.body.toTime,
        });

        console.log(newMeeting);
        await newMeeting.save();
        res.json(newMeeting);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

router.get('/getMeetings', async (req, res) => {
    const searchTerm = req.query.q; // Get the search term from query parameter
    try {
        console.log("api called with ", searchTerm)
        const meetings = await Meeting.find({participants: searchTerm});
        console.log(meetings)
      res.json(meetings);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router