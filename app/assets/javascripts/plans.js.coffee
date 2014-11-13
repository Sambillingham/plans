# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  $("#plan_role").change ->
    console.log( $(this).val() )
    $('#plan_partnerships').find("[value='" + $(this).val() + "']" ).remove()


  # $(document).on "ajax:error", (xhr, status, error)->
  #   console.log status.responseText
  #   console.log error

  # $(".js-open-modal").on "click", ->
  #   $(".modal").fadeIn()


  # $(".modal").on "click", ->
  #   $(this).fadeOut()

  # $(".modal").children().on "click", ->
  #   event.stopPropagation()

  # $('.choose-zip').click ->
  #   $('.upload-zip').fadeIn()

  # $('.js-add-custom-domain,
  #   .js-futher-domain-instructions,
  #   .js-futher-domain-instructions-new,
  #   .js-futher-domain-instructions-already-have').hide();

  # $('.js-new-domain').click ->
  #   event.stopPropagation()
  #   $('.js-add-custom-domain').fadeIn()
  #   $('.js-futher-domain-instructions-new').fadeIn()
  #   false

  # $('.js-already-have-domain').click ->
  #   event.stopPropagation()
  #   $('.js-add-custom-domain').fadeIn()
  #   $('.js-futher-domain-instructions-already-have').fadeIn()
  #   false

$(document).ready(ready)
$(document).on('page:load', ready)