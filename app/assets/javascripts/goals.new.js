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

    var getTasksForProjectId = function(project_id, callback) {
        var tasks = Array();

        url = document.location.origin + "/projects/" + project_id + "/tasks.json";
        $.ajax({
            url: url,
            dataType: 'json'
        })
        .done(function(innerTasks) {
            // console.log(innerTasks);
            innerTasks.forEach(function(task, index) {
                tasks.push(task);
            });

            callback(tasks);
        })
        .fail(function() {
            console.log("error");
        })
        .always(function() {
        });
    };

    // Display the tasks of the selected project
    $('.projectSelect').change(function() {
        project_id = $('.projectSelect option:selected').val();

        var updateTasks = function (tasks) {
            $("#taskOptions").empty();
            $.each(tasks, function(i, task) {
                console.log(task);
                $("<option></option>")
                    .attr("value", task.id)
                    .text(task.name)
                    .appendTo('#taskOptions')
            });
        }

        getTasksForProjectId(project_id, updateTasks)
    });

    $('#goal_owner').trigger('change');
    $('.projectSelect').trigger('change');
};

$(document).ready(ready)
$(document).on('page:load', ready)