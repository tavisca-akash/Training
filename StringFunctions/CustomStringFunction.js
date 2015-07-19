

String.prototype.Concat = function (secondString1) {


    var firstString = this;
    var secondString = secondString1;
    var concatenatedString = [firstString.length + secondString.length];

    for (var index = 0; index < firstString.length || index < secondString.length; index++) {
        if (index < firstString.length)
        { concatenatedString[index] = firstString.charAt(index); }
        if (index < secondString.length)
            concatenatedString[index + firstString.length] = secondString.charAt(index);
    }


    concatenatedString = concatenatedString.join("");
    console.log(concatenatedString);

}

String.prototype.SubString = function (startndex, endIndex)
{
    var firstString = this;
    var result = "";
    if (startndex > endIndex || startndex > firstString.length || endIndex > firstString.length)
        console.log("invalid index");
    for (; startndex < endIndex; startndex++)
    {
        result += firstString.charAt(startndex);
    }
    console.log(result);
}