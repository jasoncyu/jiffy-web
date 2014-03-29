refreshChart = (project_names) ->
    # console.log "project_names: #{project_names}"
    series = $.map project_names, (name, index) ->
        data_for_project = $.map(gon.weeks, (week, index) ->
            hours = week.project_data[name]
            return 0 if hours == undefined
            return hours
        )
        return {name: name, data: data_for_project}

    week_start_days = gon.weeks.map (elem) ->
      return elem.start_day

    drawChart(week_start_days, series)        

goToWeek = (start_day, project_name) ->
    weekId = null
    gon.weeks.forEach((elem, index, array) ->
      if elem.start_day == start_day
        weekId = elem.id
    )

    projectId = null
    gon.projects.forEach((elem, index, array) ->
        if elem.name == project_name
            projectId = elem.id
    )

    document.location.href = "#{document.location.origin}/weeks/#{weekId}/entries/filter_by_project/#{projectId}"

drawChart = (week_start_days, series) ->
    # use project ids to generate each line series
    chart = new Highcharts.Chart
        chart:
            renderTo: 'compareProjectsChart'
            type: 'line'
        title:
            text: "Week by Week Comparison"
        xAxis:
            categories: week_start_days
        yAxis:
            title: "Time Spent (hours)"
        series: series
        plotOptions:
            series:
                allowPointSelect: true
                cursor: 'pointer'
                point:
                    events:
                        click: ->
                            index = this.series.data.indexOf this
                            project_name = this.series.name
                            goToWeek this.category, project_name



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


        

$(".trends.compare").ready ready
