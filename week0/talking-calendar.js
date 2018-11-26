var talkingCalendar = function(date) {
  var dateArray = date.split("/");
  var months = ["January", "February", "March", "April", "May", "June", "July",
                "August",  "September", "October", "November", "December"]

  var year = dateArray[0];
  var month = months[Number(dateArray[1]) - 1]
  var day;

  if (Number(dateArray[2]) > 3) {
    day = dateArray[2] + "th";
  } else {
    switch (Number(dateArray[2])) {
      case 1:
        day = "1st";
        break;
      case 2:
        day = "2nd";
        break;
      case 3:
        day = "3rd";
        break;
    }
  }

  var fullDate = month + " " + day + ", " + year;

  return fullDate;
};

console.log(talkingCalendar("2017/12/02"));
console.log(talkingCalendar("2007/11/11"));
console.log(talkingCalendar("1987/08/24"));
