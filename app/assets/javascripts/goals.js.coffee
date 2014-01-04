# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
    $('#goal_owner').change ->
        goal_owner = $('#goal_owner option:selected').val()
        if goal_owner == "project"
            $('#task').hide()
        else
            $task = $('#task')

            $task.show()

    $('#project').change ->
        $task = $('#task')
        $task.empty()

        project_id = $('#project option:selected').val()
        url = document.location.origin + '/project' + '/' + project_id + '/tasks.json'
        $.getJSON(url, (tasks) ->
            $.each(tasks, (i, task) ->
                $option = $('<option>')
                $option.val(task.id)
                $option.text(task.name)
                $task.append($option)
            )
        )

    $('#goal_owner').change()
