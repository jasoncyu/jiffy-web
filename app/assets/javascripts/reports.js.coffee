# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
    $("#goalActualBarChart").highcharts
        chart: 
            type: 'bar'
        title:
            text: "Goal vs Actual"
        xAxis:
            categories: ['Apples', 'Bananas', 'Oranges']
        yAxis:
            title:
                text: 'Hours'
        series:
            [
                name:'School'
                data:[5,7,3]
            ]
