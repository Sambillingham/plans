# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

    # Waypoints
    adjustNav = (direction) ->
        if direction == 'down'
            $('nav').css('top','0')
        else
            $('nav').css('top','-75px')

    $('#about').waypoint( adjustNav , { offset : '25%' } )
    # end waypoints

    smoothScroll = (event) ->
        href = $(this).attr("href");
        section = $(href).offset().top;

        $("body, html").animate({ scrollTop: section }, 1000)

        return false

    $('.js-smooth-scroll').on('click', smoothScroll)

$(document).ready(ready)
$(document).on('page:load', ready)