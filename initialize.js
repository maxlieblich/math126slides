$(function() {
    $('section').addClass('slide');
    $('.incremental').children().addClass('slide');
    $('.incremental.slide').removeClass('slide');
    $.deck('.slide', {
        keys : {
            scale : 87
        }
    });
    //w key turns scaling on and off, off by default
    $.deck('disableScale');
});