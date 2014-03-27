var ready = function(){
    // Show list of tasks only if we're targeting a task
    $('#goal_owner').change(function(){
        goal_owner = $('#goal_owner option:selected').val();
            $taskSelect = $('#taskSelect');
        if (goal_owner == 0) {
            $taskSelect.hide();
        } else if (goal_owner == 1) {
            $taskSelect.show();
        } else {
            console.log("Bad goal type");
        }
    });

    var getTasksForProjectId = function(project_id) {
        var tasks = new Array();

        url = document.location.origin + "/projects/" + project_id + "/tasks.json";
        $.ajax({
            url: url,
            dataType: 'json'
        })
        .done(function(innerTasks) {
            innerTasks.each(function(i, task) {
                tasks.push(task);
            });
        })
        .fail(function() {
            console.log("error");
        })
        .always(function() {
        });

        return tasks;
    };

    // Display the tasks of the selected project
    $('.projectSelect').change(function() {
        $options = $('#taskOptions');

        project_id = $('.projectSelect option:selected').val();

        var tasks = getTasksForProjectId();
        $.each(tasks, function(i, task) {
            var option = new Option(task.name, task.id);
            $options.push(option);
        });
    });

    $('#goal_owner').change()
};

$(document).ready(ready)
$(document).on('page:load', ready)