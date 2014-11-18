# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('#plan_resources_funding').change ->
    if this.checked
      $(".plan_funding_how").fadeOut()
    else
      $(".plan_funding_how").fadeIn()

  $('#plan_resources_people').change ->
    if this.checked
      $(".plan_recruit_volunteers").fadeOut()
    else
      $(".plan_recruit_volunteers").fadeIn()

  $("#plan_role").change ->
    value = $(this).val()
    # $('#plan_partnerships').empty()
    # for role in ["","architect", "resident", "community group", "politician"]
    #   $("#plan_partnerships").append("<option value='"+ role + "'>" + role + "</option>")
    # $('#plan_partnerships').find("[value='" + value + "']" ).remove()

    if value == "other"
      $(".plan_role_other").fadeIn()
    else
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

  addOportunityOptions = (list) ->
    $("#plan_opportunity").empty()
    for size in list
      $("#plan_opportunity").append("<option value='"+ size + "'>" + size + "</option>")

  checkScaleValue()

$(document).ready(ready)
$(document).on('page:load', ready)