# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  $("form").append($(".question-slide").get().reverse())

  $('.create').click ->
    $('.restart-plan').fadeIn()

  $('.restart-plan').click ->
    window.location.reload()

  $('#plan_resources_funding').change ->
    if this.checked
      $(".plan_funding_how").fadeOut()
    else
      $(".plan_funding_how").fadeIn()

  $('#plan_resources_people').change ->
    if this.checked
      $(".plan_recruit_volunteers").parent().fadeOut()
      $(".plan_recruit_volunteers").fadeOut()
    else
      $(".plan_recruit_volunteers").fadeIn()
      $(".plan_recruit_volunteers").parent().fadeIn()


  $("#plan_role").change ->
    value = $(this).val()
    # $('#plan_partnerships').empty()
    # for role in ["","architect", "resident", "community group", "politician"]
    #   $("#plan_partnerships").append("<option value='"+ role + "'>" + role + "</option>")
    # $('#plan_partnerships').find("[value='" + value + "']" ).remove()

    if value == "other"
      $(".plan_role_other").parent().fadeIn()
      $(".plan_role_other").fadeIn()
    else
      $(".plan_role_other").parent().fadeOut()
      $(".plan_role_other").fadeOut()

  $("#plan_scale").change ->
    checkScaleValue()

  checkScaleValue = () ->
    xs = ["", "providing access", "safety", "improvement/refurbishment", "new build", "engaging local stakeholders"]
    s = ["", "design and construction", "improvement/refurbishment"]
    m = ["", "engaging local stakeholders"]
    l = ["", "master plan"]
    xl = ["", "master plan"]
    switch $("#plan_scale").val()
      when "extra small" then addOportunityOptions(xs)
      when "small" then addOportunityOptions(s)
      when "medium" then addOportunityOptions(m)
      when "large" then addOportunityOptions(l)
      when "extra large" then addOportunityOptions(xl)

  checkScaleValue()

  addOportunityOptions = (list) ->
    $("#plan_opportunity").empty()
    for size in list
      $("#plan_opportunity").append("<option value='"+ size + "'>" + size + "</option>")


  $('.next-q').click ->
    $(this).parent().fadeOut()

  $('.prev-q').click ->
    $(this).parent().next().fadeIn()
    $(this).parent().next().addClass("test")


$(document).ready(ready)
$(document).on('page:load', ready)