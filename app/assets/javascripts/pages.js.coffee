# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

    # Waypoints
    adjustNav = (direction) ->
        if direction == 'down'
            $('.js-navbar').css('top','0')
        else
            $('.js-navbar').css('top','-75px')

    $('#about').waypoint( adjustNav , { offset : '25%' } )
    # end waypoints

    smoothScroll = (event) ->
        href = $(this).attr("href");
        section = $(href).offset().top;

        $("body, html").animate({ scrollTop: section }, 1000)

        return false

    $('.js-smooth-scroll').on('click', smoothScroll)


    $('.js-headline').delay(3000).fadeOut(500)

$(document).ready(ready)
$(document).on('page:load', ready)