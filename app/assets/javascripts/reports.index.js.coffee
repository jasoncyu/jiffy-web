# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  holder = $("#holder")
  state = $("#status")

  if typeof window.FileReader is 'undefined'
    state.className = 'fail'
  else
    state.className = 'success'
    state.innerHTML = "File API & FileReader available"

  holder.ondragover = () ->
    this.className = 'hover'
    false

  holder.ondragend = () ->
    this.className = ''
    return false

  holder.ondrop = (e) ->
    this.className = ''
    e.preventDefault()

    file = e.dataTransfer.files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      console.log e.target
      holder.style.background = "url(#{e.target.result}) no-repeat center"
    
    console.log file
    reader.readAsDataURL(file)

    return false

    
$(".static_pages.index").ready ready