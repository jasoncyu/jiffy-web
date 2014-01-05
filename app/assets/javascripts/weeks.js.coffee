# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
    $("#projectBarChart").highcharts
        chart: 
            type: 'bar'
        title:
            text: "Goal vs Actual"
        xAxis:
            categories: gon.project_names
        yAxis:
            title:
                text: 'Hours'
        series:
            [
                {name: 'Actual', data: gon.actual_data}
                {name: 'Positive', data: gon.pos_goal_data}
                {name: 'Negative', data: gon.neg_goal_data}
            ]
