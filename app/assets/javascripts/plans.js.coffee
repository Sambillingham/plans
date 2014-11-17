# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  $("#plan_role").change ->
    console.log( $(this).val() )
    $('#plan_partnerships').find("[value='" + $(this).val() + "']" ).remove()

  $("#plan_scale").change ->
    xs = ["providing access", "safety", "improvement/refurbishment", "new build", "engaging local stakeholders"]
    s = ["design and construction", "improvement/refurbishment"]
    m = ["engaging local stakeholders"]
    l = ["master plan"]
    xl = ["master plan"]
    switch $(this).val()
      when "extra small" then addOportunityOptions(xs)
      when "small" then addOportunityOptions(s)
      when "medium" then addOportunityOptions(m)
      when "large" then addOportunityOptions(l)
      when "extra large" then addOportunityOptions(xl)

  addOportunityOptions = (list) ->
    console.log(list)
    $("#plan_opportunity").empty()
    for size in list
      $("#plan_opportunity").append("<option value='"+ size + "'>" + size + "</option>")


$(document).ready(ready)
$(document).on('page:load', ready)