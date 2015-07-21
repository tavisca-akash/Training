var height = 0;
var yPositionFlag = false;
var xPositionFlag = false;
var interval;
var xPosition = 20;
var yPosition = 20;
function changePosition() {
    height = window.innerHeight - 60;
    width = window.innerWidth - 60;
    document.getElementById('circle').style.top = yPosition;
    document.getElementById('circle').style.left = xPosition;
    if (yPositionFlag)
        yPosition = yPosition + 5;
    else
        yPosition = yPosition - 5;
    if (yPosition < 0) {
        yPositionFlag = true;
        yPosition = 0;
    }
    if (yPosition >= (height)) {
        yPositionFlag = false;
        yPosition = (height);
    }
    if (xPositionFlag) {
        xPosition = xPosition + 5;
    }
    else {
        xPosition = xPosition - 5;
    }
    if (xPosition < 0) {
        xPositionFlag = true;
        xPosition = 0;
    }
    if (xPosition >= (width)) {
        xPositionFlag = false;
        xPosition = (width);
    }
}
function start() {
    interval = setInterval('changePosition()', 10);
}
