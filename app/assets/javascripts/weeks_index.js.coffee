loadModal = ->
    console.log 'loadModal'
    $("#refresh-data").click(->
        $(".loading-modal").modal(
            keyboard: false
        )
        $.post("weeks/refresh_all_data", ->
            $(".modal-body").text("Data updated!")
            $(".modal-footer").show()
        )

        $(".modal-close").click(->
            $(".modal-body").text("Please wait...")
        )
    )

# on refresh
$(document).ready(loadModal)
# on turbolinks load
$(document).on('page:load', loadModal)