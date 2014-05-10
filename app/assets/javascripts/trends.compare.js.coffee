refreshChart = (project_ids) ->
    # series is a list of hashes with key project name and a list of hours values ordered by date
    series = $.map project_ids, (id, index) ->
        name = null
        for project in gon.projects
            if project.id == id
                name = project.name

        data_for_project = $.map(gon.weeks, (week, index) ->
            hours = week.project_data?[id.toString()]?["hours"] ? 0
            return 0 if hours == undefined
            return hours
        )
        console.log "name: ", name
        return {name: name, data: data_for_project}

    week_start_days = gon.weeks.map (elem) ->
      return elem.start_day

    drawChart(week_start_days, series)        

goToWeek = (start_day, project_name) ->
    console.log "project_name: #{project_name}"

    weekId = _.find gon.weeks, (week) ->
        return week.start_day == start_day
    .id

    projectId = _.find gon.projects, (project) ->
        project.name == project_name
    .id

    document.location.href = "#{document.location.origin}/weeks/#{weekId}/entries/filter_by_project/#{projectId}"

drawChart = (week_start_days, name_project_data) ->
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
        series: name_project_data
        plotOptions:
            series:
                allowPointSelect: true
                cursor: 'pointer'
                point:
                    events:
                        click: ->
                            project_name = this.series.name
                            goToWeek this.category, project_name



ready = ->
    $(".trackable").on 'click', () ->
      $(this).toggleClass("selected")
      project_ids = $('.selected').map((index, elem) ->
        $(elem).data "project-id" 
      )

      refreshChart project_ids

    # prevent double click from highlighting text
    $(".trackable").mousedown -> 
        return false


        

$(".trends.compare").ready ready
