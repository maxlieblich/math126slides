//initializations, called either at first load or whenever content changes
window.LoadedMathModels = null;

var VIDEO_WIDTH = 720;

// the following changes according to the quarter
var CURRENT_START = "3/28/2016";
var FIRST_MIDTERM = "4/26/2016";
var SECOND_MIDTERM = "5/24/2016";
var FINAL_EXAM = "6/4/2016";

// in reading mode, the step-throughs are disabled; in presentation mode they aren't!
var mode = 0; // 0 for reading mode, 1 for presentation mode

function near(model, to){
    if (!Detector.webgl){
        return false;
    }
    var container = model.container;
    var target = '#slide-' + to;
    var bigcontainer = $(target).closest("section");
    return bigcontainer.find($(container)).length;
}

// only run render loop of a model if that model is nearby. saves CPU/GPU work
function controlAnimation (event, from, to) {
    if (window.LoadedMathModels != null){
        for (var i = 0; i < window.LoadedMathModels.length; i++){
            var model = window.LoadedMathModels[i];
            if (near(model, to)){
                if (model.live == false) model.renderloop();
            } else {
                model.live = false;
            }
        }
    }
}

initializeSlides = function(){
    if (mode == 0){
        $('.incremental').removeClass('incremental');
        $('.slide').removeClass('slide');
        $('section').addClass('slide');
    } else {
        $('section').addClass('slide');
        $('.incremental').children().addClass('slide');
        $('.incremental.slide').removeClass('slide');
    }
}

initialize = function () {
    initializeSlides();
// this calls the deck function to make the love happen
    $.deck('.slide', {
        keys : {
            scale : 87
        }
    });
    //w key turns scaling on and off, off by default
    $.deck('disableScale');
    $('#deck').fadeTo(10, 0.1)
    try {
        MathJax.Hub.Queue(["Typeset",MathJax.Hub]);
        MathJax.Hub.queue.Push(stopspinning);
    } catch(e) {
        stopspinningTest();
    }
}
var born = function () {
    // bigger swipe needed to move, so manipulating models works with fingers.
    // a better fix: stop swiping from working in a model, but that will take work
    $.deck.defaults.touch.swipeTolerance = 100;
    initialize();
    $(document).bind('deck.change', function (event, from, to) {
        //  console.log("changed");
        controlAnimation(event, from , to);
    });
}

// lecture-specific behavior

var selectedIndex = 0;
var lectures = [[0, "Welcome!"],
    [1.1,"Introduction"],
    [1.2,"Coordinates"],
    [2.1,"Vectors: geometry"],
    [2.2,"Vectors: components"],
    [3.1,"Dot products"],
    [3.2,"Dot products: angles"],
    [3.3,"Dot products: lengths and projections"],
    [3.4,"Dot products: wrap up"],
    [4.1,"Cross products: mechanics"],
    [4.2,"Cross products: geometry"],
    [5.1,"Lines and planes: introduction"],
    [5.2,"Lines and planes: doing it"],
    [6,"Surfaces"],
    [7.1,"Vector valued functions: theory"],
    [7.2,"Vector valued functions: practice"],
    [8.1,"Vector calculus: derivatives"],
    [8.2,"Vector derivatives in practice"],
    [8.3,"Vector integrals"],
    [9,"Polar coordinates"],
    [10.1,"Distance"],
    [10.2,"Arc length"],
    [10.3,"Curvature"],
    [11,"Tangents, normals, binormals"],
    [12,"Tangential and normal acceleration"],
    [13,"Multivariable functions"],
    [14.1,"Partial derivatives"],
    [14.2,"Tangent planes"],
    [15.1,"Differentials"],
    [15.2, "Optimization"],
    [16.1,"Local max/min: theory"],
    [16.2,"Local max/min: examples"],
    [17.1,"Double integrals: Riemann sums"],
    [17.2,"Double integrals: first examples"],
    [17.3,"Double integrals: iterated integrals"],
    [18,"Double integrals over regions"],
    [19,"Double integrals in polar coordinates"],
    [20.1, "Area"],
    [20.2,"Center of mass"],
    [21,"Errors in linear approximation"],
    [22,"Higher order approximation, Taylor polynomials"],
    [23,"Even higher order approximation"],
    [24,"Making new Taylor series from old ones"],
    [25,"Taylor summary"]]
for (var j = 0; j < lectures.length; j++) {
    $("#lectureList").append('<li id="' + lectures[j][0] + '"><a href="#">' + lectures[j][0] + ': ' + lectures[j][1] + '</a></li>');
}

var activeLecture = function(){
    $("#lectureList > li").removeClass("active");
    $($("#lectureList > li")[selectedIndex]).addClass("active");
}

activeLecture();

var setButtonVisibility = function(condition, button){
    if (condition)
        button.removeClass('disabled');
    else
        button.addClass('disabled');
}

// this is a function so that conditions are evaluated when called, in case parameters change
// maybe this is unnecessary, but I don't feel like doing the experiment now
var buttonsConditions = function(){
    return [
        [selectedIndex > 0 && selectedIndex < lectures.length - 1, $('#pdfButton')],
        [selectedIndex > 0, $('#prevLectureButton')],
        [selectedIndex < lectures.length - 1, $('#nextLectureButton')],
        [selectedIndex > 0, $('#videoButton')]
    ];
}

// only make buttons enabled when they can do something
var buttonVisibility = function(){
    var bC = buttonsConditions();
    for (var i = 0; i < bC.length; i++){
        setButtonVisibility(bC[i][0], bC[i][1]);
    }
}

$("#lectureList > li").click(function (e){
    e.preventDefault();
    selectedIndex = $(this).index();
    loadLectureByIndex(selectedIndex);
});

var nextLecture = function(){
    if (selectedIndex < lectures.length) {
        selectedIndex += 1;
        loadLectureByIndex(selectedIndex);
    }
}

$('#nextLectureButton').click(function (e){
    e.preventDefault();
    nextLecture();
});

var prevLecture = function() {
    if (selectedIndex > 0) {
        selectedIndex -= 1;
        loadLectureByIndex(selectedIndex);
    }
}

$('#prevLectureButton').click(function (e){
    e.preventDefault();
    prevLecture();
});

$('#videoButton').click(function (e){
    e.preventDefault();
    var vid = document.getElementById('videoPlayer');
    $('#videoModal > div').width(VIDEO_WIDTH + 60);
    vid.width = VIDEO_WIDTH;
    $(vid).css('display', 'block');
    vid.src = "video/" + lectures[selectedIndex][0].toString().replace(".", "-") + ".mp4";
});

$('#videoClose').click(function (e){
    e.preventDefault();
    var vid = document.getElementById('videoPlayer');
    vid.pause();
    vid.src = "";
});

var loadLecture = function(s, callback) {
    buttonVisibility();

    $("#loadStatus").text("Loading...");
    $.get(s + "/lecture.html", function (data){
        var content = $('#contentStart').nextUntil('#contentEnd').andSelf(); // change to addBack() with jQ 1.8 eventually

        content.remove();
        $('#seedDiv').replaceWith("<div id='seedDiv'></div><div id='contentStart'></div><div id='divider'></div>");
        $('#divider').replaceWith($(data).html());

        initialize()
        $("#loadStatus").text("");

        //There is some kind of memory leak catastrophe I don't understand, related to not being able to dispose
        //of WebGL contexts properly. Things bog down, etc. The following DOES NOT FIX IT!
        if (window.LoadedMathModels != null){
//                delete window.LoadedMathModels;
            for (var i = 0; i < window.LoadedMathModels.length; i++){
                //window.LoadedMathModels[i].renderer = null //  WebGLContexts not unloading for some reason....
                window.LoadedMathModels[i] = null;
            }
            window.LoadedMathModels = null;
        }

        try {
            $.getScript(s + "/models.js");
        } catch (e) {} // no models.js file, that's ok. Do this without try/catch eventually
        if (callback != null)
            callback()
        else
            window.location = "#slide-0";

    });
}

var loadLectureByIndex = function(i) {
    selectedIndex = i;
    var s = $('#lectureList').children()[i].id;
    loadLecture(s, null);
    activeLecture();
}

$('#pdfButton').click(function (e){
    if ($('#pdfButton').hasClass('disabled'))
        return;
    e.preventDefault()
    var s = lectures[selectedIndex][0];
    window.open(s + "/PDF/Lecture " + s.toString().replace(".","-") + ".pdf");
});

// handle mode dropdown

$("#modeList > li").click(function (e){
    e.preventDefault();
    mode = $(this).index();
    var lis = $("#modeList > li");
    lis.removeClass("active");
    if (mode == 0){
        lis.first().addClass("active");
    } else {
        lis.last().addClass("active");
    }
    loadLectureByIndex(selectedIndex);
});

// now start everything
var startingContent = 0;
var loc = location.hash.slice(1);

if (!isNaN(loc) && 0 <= parseInt(loc) && parseInt(loc) <= lectures.length){
    startingContent = parseInt(loc);
}
console.log(startingContent);

$('li').tooltip();

loadLectureByIndex(startingContent);

$(born());

// populate the week in the schedule popup
var mil = Math.floor(new Date() - new Date(CURRENT_START));
var seconds = (mil / 1000) | 0;
mil -= seconds * 1000;

var minutes = (seconds / 60) | 0;
seconds -= minutes * 60;

var hours = (minutes / 60) | 0;
minutes -= hours * 60;

var days = (hours / 24) | 0;
hours -= days * 24;

var weeks = 1 + (days / 7) | 0;

$('#currentWeek').text("The currently running course is in week " + weeks + ".");
$('#currentWeek').css('visibility', 'visible');

// populate the exam dates in the schedule popup
$('#firstMidterm').text('The first midterm covers material through week 4 and will be held on ' + FIRST_MIDTERM + ".");
$('#secondMidterm').text('The second midterm covers material through week 8 and will be held on ' + SECOND_MIDTERM + ".");
$('#finalExam').text('The enjoyable final exam will be held on ' + FINAL_EXAM + ".");

