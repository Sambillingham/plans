# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

readyPages = ->

    # Waypoints
    adjustNav = (direction) ->
        if direction == 'down'
            $('.js-navbar').css('top','0')
        else
            $('.js-navbar').css('top','-75px')

    if $(".intro")[0]
        $('#about').waypoint( adjustNav , { offset : '25%' } )
    else
        $('.js-navbar').css('top','0')

    # end waypoints

    # Smooth scrolling
    smoothScroll = (event) ->
        href = $(this).attr("href");
        section = $(href).offset().top;

        $("body, html").animate({ scrollTop: section }, 1000)

        return false

    $('.js-smooth-scroll').on('click', smoothScroll)


    # Hide title on homepage
    $('.js-headline').delay(3000).fadeOut(500)


$(document).ready(readyPages)
$(document).on('page:load', readyPages)