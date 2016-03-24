var startspinner = function () {
    var spinopts = {
        lines: 12,
        length: 7,
        width: 4,
        radius: 10,
        color: "#000",
        speed: 1,
        trail: 60,
        shadow: false,
        hwaccel: true
    };
    var target = document.body//document.getElementById("deck");
    spinner = new Spinner(spinopts).spin(target);
}
startspinner();

var testModels = function () {
    if (window.LoadedMathModels == null) {
        return true;
    }
    var loaded = 0;
    for (var i = 0; i < window.LoadedMathModels.length; i++) {
        if (window.LoadedMathModels[i].ready) loaded++;
    }
    return loaded >= window.LoadedMathModels.length;
}
var stopspinning = function () {
    if (!testModels()) {
        setTimeout("stopspinning()", 500);
    } else {
        spinner.stop();
        $('#deck').fadeTo(100, 1.0)
        $("#loadinghead").text("Loaded!");
        $("#loadingtext").text("Please proceed to the calculus wonderland by pressing the right arrow key or clicking the right arrow that is visible when you move your mouse over the pig.")
    }
};

var stopspinningTest = function(){
    spinner.stop();
    $('#deck').fadeTo(100, 1.0)
}
