

String.prototype.Concat = function () {

    var firstString = this;
    var counter = 0;
    for (var i = 0; i < arguments.length; i++) {
        for (var j = 0; j < arguments[i].length; j++)
            counter++;
    }
    var concatenatedFinal = [counter];
    counter = 0;
    for (var count = 0; count < arguments.length; count++)
    {
        var concatenatedString = [firstString.length + arguments[count].length];

        for (var index = 0; index < firstString.length || index < arguments[count].length; index++)
        {
            if (index < firstString.length && count == 0)
            {
                concatenatedString[index] = firstString.charAt(index);
            }
            if (index < arguments[count].length)
                concatenatedString[index + firstString.length] = arguments[count].charAt(index);
        }
        for (var k = firstString.length; k < concatenatedString.length; k++, counter++)
            concatenatedFinal[counter] = concatenatedString[k]
        concatenatedString = "";

    }

    concatenatedFinal = concatenatedFinal.join("");
    console.log(concatenatedFinal);
    return;


}
String.prototype.SubString = function (startndex, endIndex) {
    var firstString = this;
    if ((startndex > endIndex) || endIndex >= this.length) {
        console.log("Invalid Index");
        return;
    }
    var result = "";
    for (; startndex < endIndex; startndex++) {
        result += firstString.charAt(startndex);
    }
    console.log(result);
    return;
}