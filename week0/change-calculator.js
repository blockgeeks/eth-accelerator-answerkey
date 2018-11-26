var calculateChange = function(total, cash) {
  var changeBack = {}
  var change = cash - total;

  while (change > 0) {
    switch (true) {
      case (change >= 2000):
        changeBack["twenty"] = (changeBack["twenty"] + 1) || 1;
        change -= 2000;
        break;
      case (change >= 1000):
        changeBack["ten"] = (changeBack["ten"] + 1) || 1;
        change -= 1000;
        break;
      case (change >= 500):
        changeBack["five"] = (changeBack["five"] + 1) || 1;
        change -= 500;
        break;
      case (change >= 200):
        changeBack["twoDollar"] = (changeBack["twoDollar"] + 1) || 1;
        change -= 200;
        break;
      case (change >= 100):
        changeBack["dollar"] = (changeBack["dollar"] + 1) || 1;
        change -= 100;
        break;
      case (change >= 25):
        changeBack["quarter"] = (changeBack["quarter"] + 1) || 1;
        change -= 25;
        break;
      case (change >= 10):
        changeBack["dime"] = (changeBack["dime"] + 1) || 1;
        change -= 10;
        break;
      case (change >= 5):
        changeBack["nickle"] = (changeBack["nickle"] + 1) || 1;
        change -= 5;
        break;
      case (change >= 1):
        changeBack["penny"] = (changeBack["penny"] + 1) || 1;
        change -= 1;
        break;
    }
  }

  return changeBack;
};

console.log(calculateChange(1787, 2000));
console.log(calculateChange(2623, 4000));
console.log(calculateChange(501, 1000));
