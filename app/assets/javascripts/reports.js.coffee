# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
    $("#project_level_report_week_go").click ->
        console.log 'click'
        project_id = $("#project_select option:selected").val()
        week = $("#week_select option:selected").val()
        document.location.href = document.location.origin + '/reports/project/' + project_id + '/week/' + week

