function lineSweep(partipantCount, participantTimes){
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
}

function timeToSeconds(time) {
    var parts = time.split(":");
    var hours = parseInt(parts[0], 10);
    var minutes = parseInt(parts[1], 10);
    var seconds = hours * 3600 + minutes * 60;
    return seconds;
}

function secondsToTime(seconds) {
    var hours = Math.floor(seconds / 3600);
    var minutes = Math.floor((seconds % 3600) / 60);
  
    var formattedHours = hours.toString().padStart(2, "0");
    var formattedMinutes = minutes.toString().padStart(2, "0");
  
    return formattedHours + ":" + formattedMinutes;
  }

function timeArrayToSeconds(timeArray){
    timesInt = [];
    for(let i = 0; i < timeArray.length; i++){
        blockInt = [];
        blockInt.push(timeToSeconds(timeArray[i][0]));
        blockInt.push(timeToSeconds(timeArray[i][1]));
        timesInt.push(blockInt);
    }
    return timesInt;
}

function secondsArrayToTime(timeArray){
    timesStr = [];
    for(let i = 0; i < timeArray.length; i++){
        blockInt = [];
        blockInt.push(secondsToTime(timeArray[i][0]));
        blockInt.push(secondsToTime(timeArray[i][1]));
        timesStr.push(blockInt);
    }
    return timesStr;
}


const times = [["00:00","03:00"], ["05:00","08:00"], ["00:00","06:00"], ["01:00", "08:00"]]
const participants = 3

timesInt = timeArrayToSeconds(times)
intervals = lineSweep(participants, timesInt)

console.log(secondsArrayToTime(intervals))