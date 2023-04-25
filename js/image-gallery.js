$(document).ready(function () {

    $(".filter-button").click(function () {
        var value = $(this).attr('data-filter');

        if (value == "all") {
            //$('.filter').removeClass('hidden');
            $('.filter').show('1000');
        }
        else {
            //            $('.filter[filter-item="'+value+'"]').removeClass('hidden');
            //            $(".filter").not('.filter[filter-item="'+value+'"]').addClass('hidden');
            $(".filter").not('.' + value).hide('3000');
            $('.filter').filter('.' + value).show('3000');

        }
    });

    if ($(".filter-button").removeClass("active")) {
        $(this).removeClass("active");
    }
    $(this).addClass("active");

});

$(document).ready(function () {
    $('.control-software').on("mouseover", function () {
        $('#workings-image').css('background-image', 'url("./img/trackalert/trackalert.jpg")')
        $('#workings-image').css('margin-top', '10.5em')
        $('#workings-image').css('width', '98%')
        $('#workings-image').css('height', '53%')
        $('#workings-image').css('margin-left', '0')

        $('.control-software').css('background-color', '#2f3136');
        $('.host-local').css('background-color', '#354052');
        $('.panel').css('background-color', '#354052');
    });
    $('.host-local').on("mouseover", function () {
        $('#workings-image').css('background-image', 'url("./img/trackalert/dell-optiplex.jpeg")')
        $('#workings-image').css('width', '35%')
        $('#workings-image').css('height', '77%')
        $('#workings-image').css('margin-top', '5em')
        $('#workings-image').css('margin-left', '11.5em')

        $('.control-software').css('background-color', '#354052');
        $('.host-local').css('background-color', '#2f3136');
        $('.panel').css('background-color', '#354052');
    });
    $('.panel').on("mouseover", function () {
        $('#workings-image').css('background-image', 'url("./img/trackalert/trackalert-panel.jpg")')
        $('#workings-image').css('margin-top', '9.5em')
        $('#workings-image').css('width', '97%')
        $('#workings-image').css('height', '60%')
        $('#workings-image').css('margin-left', '0')

        $('.control-software').css('background-color', '#354052');
        $('.host-local').css('background-color', '#354052');
        $('.panel').css('background-color', '#2f3136');
    });
});