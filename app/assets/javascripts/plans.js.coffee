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

  # hide the no button on send an email
  $('#plan_email_user_plan_false').parent().hide()

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
      $(".plan_funding_how").closest('.question-slide').fadeOut()
      $(".plan_funding_how").fadeOut()
    else
      $(".plan_funding_how").closest('.question-slide').fadeIn()
      $(".plan_funding_how").fadeIn()

  # if the user says they want volunteers show extra Question
  $('#plan_resources_people').change ->
    if this.checked
      $(".plan_recruit_volunteers").closest('.question-slide').fadeOut()
      $(".plan_recruit_volunteers").fadeOut()
    else
      $(".plan_recruit_volunteers").closest('.question-slide').fadeIn()
      $(".plan_recruit_volunteers").fadeIn()


  $("#plan_role").change ->
    value = $(this).val()
    # $('#plan_partnerships').empty()
    # for role in ["","architect", "resident", "community group", "politician"]
    #   $("#plan_partnerships").append("<option value='"+ role + "'>" + role + "</option>")
    # $('#plan_partnerships').find("[value='" + value + "']" ).remove()

    if value == "other"
      $(".plan_role_other").closest('.question-slide').fadeIn()
      $(".plan_role_other").fadeIn()
    else
      $(".plan_role_other").closest('.question-slide').fadeOut()
      $(".plan_role_other").fadeOut()

  $("#plan_scale").change ->
    checkScaleValue()

  checkScaleValue = () ->
    a = ["", "Design and Construction", "Improvement/Refurbishment"]
    b = ["", "Providing Access", "Addressing Safety", "Improvement/Refurbishment", "New Build", "Engaging Local Stakeholders"]
    c = ["", "Masterplanning", "Addressing Social Issues", "Addressing Safety", "Questioning Policy", "Engaging Stakeholders"]
    switch $("#plan_scale").val()
      when "small" then addOportunityOptions(a)
      when "medium" then addOportunityOptions(b)
      when "large" then addOportunityOptions(c)
      when "extra large" then addOportunityOptions(c)

  checkScaleValue()

  addOportunityOptions = (list) ->
    $("#plan_opportunity").empty()
    for size in list
      $("#plan_opportunity").append("<option value='"+ size + "'>" + size + "</option>")


  $('.next-q').click ->

    if $(this).data('q-type') == 'select'
      selected = $(this).prev().find('select').find(":selected").text()

      if selected != ''
        $('.alert').remove
        $(this).closest('.question-slide').fadeOut()
      else
        $(this).parent().prepend('<div class="alert alert-danger">Please answer the question before continuing</div>')
    else
      $('.alert').remove
      $(this).closest('.question-slide').fadeOut()


  $('.prev-q').click ->
    $(this).closest('.question-slide').next().fadeIn()


$(document).ready(ready)
$(document).on('page:load', ready)