sub init()
  m.background = m.top.findNode("background")
  m.image = m.top.findNode("image")
  m.attractionAndSong = m.top.findNode("attractionAndSong")
  m.themeParkAndLand = m.top.findNode("themeParkAndLand")

  m.duration = m.top.findNode("duration")
  m.duration.drawingStyles = m.drawingStyles

  m.lastPlayed = m.top.findNode("lastPlayed")
  m.lastPlayed.drawingStyles = m.drawingStyles

  m.year = m.top.findNode("year")
  m.year.drawingStyles = m.drawingStyles

  m.songscene_button_group = m.top.findNode("songscene_button_group")

  m.request_button = m.top.findNode("request_button")
  m.request_button.observeField("buttonSelected", "onRequestPressed")
  ' m.favorite_button = m.top.findNode("favorite_button")
  ' m.favorite_button.observeField("buttonSelected", "onFavoritePressed")

  m.spinner = m.top.findNode("spinner")
  m.toast = m.top.findNode("toast")
  m.layout_group = m.top.findNode("layout_group")

  m.top.observeField("songId", "onSongIdChange")
  m.top.observeField("visible", "onGetFocus")

  buildSongTask()
  buildRequestSongTask()
end sub

sub onGetFocus()
  ? "SongScene onGetFocus"

  if m.top.visible
    m.spinner.visible = true

    m.background.visible = false
    m.layout_group.visible = false
    m.request_button.visible = false
    ' m.favorite_button.visible = false
  end if
end sub

function buildSongTask() as void
  m.songTask = CreateObject("roSGNode", "SongTask")
  m.songTask.ObserveField("result", "onSongRetrieved")
end function

function buildRequestSongTask() as void
  m.requestSongTask = CreateObject("roSGNode", "RequestSongTask")
  m.requestSongTask.ObserveField("response", "onSongRequested")
end function

sub onSongIdChange()
  m.requestSongTask.songId = m.top.songId

  m.songTask.songId = m.top.songId
  m.songTask.control = "run"
end sub

sub onSongRetrieved()
  m.spinner.visible = false

  m.background.visible = true
  m.layout_group.visible = true

  result = m.songTask.result

  m.request_button.visible = result.canRequest
  ' m.favorite_button.visible = true

  m.background.uri = result.blurredUrl
  m.image.uri = result.url
  m.attractionAndSong.text = result.attractionAndSong
  m.themeParkAndLand.text = ucase(result.themeParkAndLand)
  m.duration.text = "<Bold>Duration:</Bold> <Normal>" + result.durationDisplay + "</Normal>"
  m.lastPlayed.text = "<Bold>Last played:</Bold> <Normal>" + result.lastPlayed + " (PST)</Normal>"
  m.year.text = "<Bold>Year:</Bold> <Normal>" + result.year + "</Normal>"

  m.songscene_button_group.setFocus(true)
end sub

sub onSongRequested()
  response = m.requestSongTask.response
  ? "onSongRequested() // success: " + response.success.tostr() + ", requestId: " + response.requestId.tostr()

  ? "here"
  message = "Please try again later"

  if response.success = true
    message = "Success!"
  end if

  m.toast.message = message
  m.toast.visible = true
end sub

sub onRequestPressed()
  m.requestSongTask.control = "run"
end sub

sub onFavoritePressed()
  ? "onFavoritePressed()"
end sub
