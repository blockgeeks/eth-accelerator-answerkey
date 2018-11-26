var repeatNumbers = function(data) {

  var result = "";

  for (d = 0; d < data.length; d++) {
    for (i = 0; i < data[d][1]; i++) {
      result += data[d][0];
    }
    if (d < data.length - 1) {
      result+= ", "
    }
  }
    return result;
}

console.log(repeatNumbers([[1, 10]]));
console.log(repeatNumbers([[1, 2], [2, 3]]));
console.log(repeatNumbers([[10, 4], [34, 6], [92, 2]]));
