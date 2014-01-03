$(document).ready ->
    $body = $('body')
    if $body.data('controller') == 'reports' and $body.data('action') == 'pick_week'
        $('#report_week_go').click ->
                index = $("#report_week_select option:selected").index()
                console.log index
                new_url = document.URL + '/' + index
                window.location = new_url