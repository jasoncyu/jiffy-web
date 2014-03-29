ready = ->
    $(".trackable").on 'click', () ->
      $(this).toggleClass("selected")
      project_names = $('.selected').map((index, elem) ->
        $(elem).data "project-name" 
      )

      refreshChart project_names

    # prevent double click from highlighting text
    $(".trackable").mousedown -> 
        return false

    refreshChart = (project_names) ->
        # console.log "project_names: #{project_names}"
        console.log project_names
        series = $.map project_names, (name, index) ->
            data_for_project = $.map(gon.weeks, (week, index) ->
                hours = week.project_data[name]
                return 0 if hours == undefined
                return hours
            )
            return {name: name, data: data_for_project}

        week_start_days = gon.weeks.map (elem) ->
          return elem.start_day
        console.log "week_start_days: ", week_start_days

        drawChart(week_start_days, series)        

    drawChart = (week_start_days, series) ->
        # use project ids to generate each line series
        $("#compareProjectsChart").highcharts
            title:
                text: "Week by Week Comparison"
            xAxis:
                categories: week_start_days
            yAxis:
                title: "Time Spent (hours)"
            series: series
        

$(".trends.compare").ready ready
