module.exports = {
    lineSweep : function(partipantCount, participantTimes){
        const events = [];
        intersections = [];
        block = [];
        for (let i = 0; i < participantTimes.length; i++) {
            const segment = participantTimes[i];
            events.push([segment[0], 1]);
            events.push([segment[1], -1]);
        }

        events.sort((a, b) => a[0] - b[0]);
        
        count = 0

        for (const event of events) {
            if(event[1] == 1){
                if(count == partipantCount-1){
                    block.push(event[0]);    
                }
                count += 1;
            }
            else{
                if(count == partipantCount){
                    block.push(event[0]);
                    intersections.push(block);
                    block = []
                }
                count -= 1
            } 
        }

        return intersections
    },

    timeToSeconds : function(timeStr) {
        const [timePart, amPm] = timeStr.split(' ');
        const [hoursStr, minutesStr] = timePart.split(':');
        
        let hours = parseInt(hoursStr, 10);
        const minutes = parseInt(minutesStr, 10);
        
        if (amPm.toUpperCase() === 'PM' && hours !== 12) {
            hours += 12;
        }
        
        return hours * 3600 + minutes * 60;
    },

    secondsToTime : function(seconds) {
        var hours = Math.floor(seconds / 3600);
        var minutes = Math.floor((seconds % 3600) / 60);
    
        var formattedHours = hours.toString().padStart(2, "0");
        var formattedMinutes = minutes.toString().padStart(2, "0");
    
        return formattedHours + ":" + formattedMinutes;
    },

    timeArrayToSeconds : function(timeArray){
        timesInt = [];
        for(let i = 0; i < timeArray.length; i++){
            blockInt = [];
            blockInt.push(this.timeToSeconds(timeArray[i][0]));
            blockInt.push(this.timeToSeconds(timeArray[i][1]));
            timesInt.push(blockInt);
        }
        return timesInt;
    },

    secondsArrayToTime : function(timeArray){
        timesStr = [];
        for(let i = 0; i < timeArray.length; i++){
            blockInt = [];
            blockInt.push(this.secondsToTime(timeArray[i][0]));
            blockInt.push(this.secondsToTime(timeArray[i][1]));
            timesStr.push(blockInt);
        }
        return timesStr;
    },

    timeBlockToSeconds : function(timeArray){
        blockInt = [];
        blockInt.push(this.timeToSeconds(timeArray[0]));
        blockInt.push(this.timeToSeconds(timeArray[1]));
        return blockInt;
    },

    splitBlock : function(blocksList, newBlock) {
        const resultBlocks = [];
    
        for (const block of blocksList) {
            if (newBlock[0] >= block[0] && newBlock[1] <= block[1]) {
                resultBlocks.push([block[0], newBlock[0]]);
                resultBlocks.push([newBlock[1], block[1]]);
            } else {
                resultBlocks.push(block);
            }
        }
        return resultBlocks;
    }

}

// const times = [["00:00","03:00"], ["05:00","08:00"], ["00:00","06:00"], ["01:00", "08:00"]]
// const participants = 3

// timesInt = timeArrayToSeconds(times)
// intervals = lineSweep(participants, timesInt)

// console.log(secondsArrayToTime(intervals))