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

    toggleBackToTop = (direction) ->
        if direction == 'down'
            console.log "goo"
            $('.js-back-to-top').fadeIn()
        else
            $('.js-back-to-top').fadeOut()

    $('.js-projects-waypoints').waypoint( toggleBackToTop )
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

    # Lightbox
    #  click on image open lightbox
    $('.content-inner img').click ->
        imageSrc = $(this).attr("src")

        $('.js-lightbox img').attr("src",imageSrc)

        $('.js-lightbox').fadeIn()

    $('.js-lightbox').click ->
        $(this).fadeOut()

    # end lightbox

$(document).ready(readyPages)
$(document).on('page:load', readyPages)