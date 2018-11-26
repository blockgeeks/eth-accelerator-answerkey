var calculateChange = function(total, cash) {
    var returnValue = cash - total;
    var change = {};
    var coinTypes = [2000, 1000, 500, 200, 100, 25, 10, 5, 1];
    var denominations = ["twenty", "ten", "five", "twoDollar", "dollar", "quarter", "dime", "nickel", "penny"];
    var amount;

    for (var i = 0; i < coinTypes.length; i++) {
        amount = Math.floor(returnValue/coinTypes[i]);
        if (amount > 0) {
            change[denominations[i]] = amount;
            returnValue = returnValue%coinTypes[i];
        }
    }

    return change;
};

console.log(calculateChange(1787, 2000));
console.log(calculateChange(2623, 4000));
console.log(calculateChange(501, 1000));
