# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  # move the slide on if the value of input changes
  # $('#plan_scale,
  #   #plan_opportunity,
  #   #plan_timescale,
  #   #plan_familiarity,
  #   #plan_past_projects,
  #   #plan_role,
  #   #plan_funding_how,
  #   #plan_recruit_volunteers').change ->
  #   $(this).closest('.question-slide').fadeOut()


  # switch the ordering of questions so they stack correctly
  $("form").append($(".question-slide").get().reverse())

  # when past the first slide, fade in the restart button
  $('.create').click ->
    $('.restart-plan').fadeIn()

  # have the reset button refresh the page
  $('.restart-plan').click ->
    window.location.reload()

  # if the user says they want funding show extra Question
  $('#plan_resources_funding').change ->
    if this.checked
      $(".plan_funding_how").fadeOut()
    else
      $(".plan_funding_how").fadeIn()

  # if the user says they want volunteers show extra Question
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

    if $(this).data('q-type') == 'select'
      selected = $(this).prev().find('select').find(":selected").text()

      if selected != ''
        $(this).parent().fadeOut()
      else
        $('body').append('<div class="alert alert-danger">Please answer the question before continuing</div>')
    else
      $(this).parent().fadeOut()


  $('.prev-q').click ->
    $(this).parent().next().fadeIn()
    $(this).parent().next().addClass("test")


$(document).ready(ready)
$(document).on('page:load', ready)