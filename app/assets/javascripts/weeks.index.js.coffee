ready = ->
    console.log 'weeks#index'
    loadModal()

loadModal = ->
    console.log 'modal'
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
    
$(".weeks.index").ready(ready)
