var flag = true;
var win =
[
     [1, 2, 3],
     [4, 5, 6],
     [7, 8, 9],
     [1, 4, 7],
     [2, 5, 8],
     [3, 6, 9],
     [1, 5, 9],
     [3, 5, 7]
];

function play(buttonId) {
    if (flag) {
        document.getElementById(buttonId).value = "X";
        document.getElementById(buttonId).disabled = 'disabled';
        winner();
        flag = false;
    }
    else {
        document.getElementById(buttonId).value = "O";
        document.getElementById(buttonId).disabled = 'disabled';
        winner();
        flag = true;
    }

}

function winner() {
    for (var index = 0; index < win.length; index++) {
        for (var player = 0; player < 2; player++) {
            if (player === 0)
                var label = 'X';
            else
                var label = 'O';
            combination = win[index];
            if (document.getElementById(combination[0]).value == label &&
                    document.getElementById(combination[1]).value == label &&
                    document.getElementById(combination[2]).value == label) {
                document.getElementById("Winner").innerHTML = 'Player ' + label + ' Won!';
            }
        }
    }
}
function reset() {
    location.reload();
}