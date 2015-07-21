window.ball = window.ball || {}

ball.container = function () {

    var height = (window.innerHeight - 50);
    var width = (window.innerWidth - 50);
    if (ball.yPosition >= height) {
        ball.dy = -10;
    }
    if (ball.xPosition >= width) {
        ball.dx = -10;
    }
    if (ball.yPosition <= 0) {
        ball.dy = 10;
    }
    if (ball.xPosition <= 0) {
        ball.dx = 10;
    }
}