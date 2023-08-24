const availability = require('../helpers/availability');
const express = require('express')
const Meeting = require('../models/meeting.models.js')
const router = express.Router()


router.post('/createMeeting', async (req, res) => {
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
        const meetings = await Meeting.find({participants: decodeURIComponent(searchTerm)});
        
        const transformedData = {};

        // Iterate through each event
        meetings.forEach(event => {

        // If the date doesn't exist in transformedData, create it
        if (!transformedData[event.date]) {
            transformedData[event.date] = { date: Date, meeting: [] };
            transformedData[event.date].date = event.date
        }

        // Push the event details to the corresponding date's meeting array
        transformedData[event.date].meeting.push(event);
        });

        // Convert the transformedData object to an array
        const result = Object.values(transformedData);

        // Output the final result
        console.log(result);

      res.json(result);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Server error' });
    }
});

router.post('/getAvailability', async (req, res) => {
    try {
        participants = req.body.participants;
        meetDate = new Date(req.body.date);

        allTimes = []
        //console.log(meetDate);
        
        for (const participant of participants) {
            //console.log(participant);
            const meetings = await Meeting.find({participants: participant, date:meetDate});
            defaultblock = availability.timeBlockToSeconds(["09:00 AM","05:00 PM"]) //default for everyone is 9-5 
            timeBlocks = [defaultblock]
            for (const meet of meetings){
                block = [meet.fromTime, meet.toTime];
                console.log(block);
                timeBlock = availability.timeBlockToSeconds(block);
                timeBlocks = availability.splitBlock(timeBlocks, timeBlock)
            }
            //console.log(timeBlocks);
            allTimes = allTimes.concat(timeBlocks);
          }

          available = availability.lineSweep(participants.length, allTimes);
          availableBlocks = availability.secondsArrayToTime(available);
          console.log(availableBlocks, meetDate)
        res.status(200).json({ availability: availableBlocks });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router