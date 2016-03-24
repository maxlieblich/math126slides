var webpage = require('webpage'),
		page = webpage.create(),
//    system = require('system'),
    url = 'http://www.math.washington.edu/~lieblich/Math126/all.html',
    fs = require('fs'),
    imageSources = [],
    imageTags;

processPage = function () {
    var slideCount;

    page.viewportSize = {
        width: 1024,
        height: 768
    };

    slideCount = page.evaluate(function () {
        var $ = window.jQuery;

        $('html').removeClass('csstransitions cssreflections');
        $('html, body').css({
            'width': 1024,
            'height': 768,
            'overflow': 'hidden'
        });
        $.deck('.slide');
        return $.deck('getSlides').length;
    });

    fs.makeDirectory('temp-slides');

    for (var i = 0; i < slideCount; i++) {
        var src = 'temp-slides/output-' + i + '.png';
        imageSources.push(src);
        console.log('Rendering slide #' + i);
        page.render(src);
        page.evaluate(function () {
            var $ = window.jQuery;
            $.deck('next');
        });
    }

    imageTags = imageSources.map(function (src) {
        return '<img src="' + src + '" style="dispay:block;" width="100%">';
    });

    var output = imageTags.join('') + '<style>*{margin:0;padding:0}</style>';
    fs.write('temp-output.html', output, 'w');

    phantom.exit();
}

page.onLoadFinished = function(status) {
    var lecture = '1';

	if (status !== 'success') {
		console.log('Target file not found.');
		phantom.exit();
	}

	page.evaluate(function() {
	    var $ = window.jQuery;
	    $("#lectureList").val('1');
	    $("#webButton").click();
        console.log('Loaded lecture AJAX')
	})

	setTimeout(processPage, 120000);
};

page.open(url);