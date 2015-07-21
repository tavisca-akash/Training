
window.ball = window.ball || {
    xPosition: 0,
    yPosition: 0,
    dx: 10,
    dy: 10
};

ball.bounce = function ()
{
    var element = document.getElementById('circle');
    element.style.left = ball.xPosition + "px";
    element.style.top = ball.yPosition + "px";
    ball.container();
    ball.xPosition += ball.dx;
    ball.yPosition += ball.dy;
}
window.ball.start = function () {
    setInterval(ball.bounce, 10);
}