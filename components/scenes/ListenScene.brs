sub init()
  m.top.setFocus(true)

  m.is_playing = false

  m.durationDisplay = ""
  m.duration = 30
  m.elapsed_time = 30

  m.button_group = m.top.findNode("button_group")

  m.toggle_button = m.top.findNode("toggle_button")
  m.toggle_button.observeField("buttonSelected", "onTogglePressed")
  m.toggle_button.focusedTextFont = m.lightFont
  m.toggle_button.textFont = m.lightFont
  m.toggle_button.focusedTextColor = "0x000000ff"
  m.toggle_button.textColor = "0xffffffff"

  m.whatsnext_button = m.top.findNode("whatsnext_button")
  m.whatsnext_button.observeField("buttonSelected", "onWhatsNextPressed")
  m.whatsnext_button.focusedTextFont = m.lightFont
  m.whatsnext_button.textFont = m.lightFont
  m.whatsnext_button.focusedTextColor = "0x000000ff"
  m.whatsnext_button.textColor = "0xffffffff"

  setUpLabels()

  buildTasks()

  setUpElapsedTimeTimer()
  setUpRefreshTimer()

  setUpAudio()

  refreshData()

  m.top.observeField("visible", "onGetFocus")
end sub

sub onGetFocus()
  if m.top.visible = true
    m.button_group.setFocus(true)
  end if
end sub

function setUpLabels() as void
  m.title = m.top.findNode("title")

  m.current_track_title = m.top.findNode("current_track_title")
  m.current_track_artist_name = m.top.findNode("current_track_artist_name")
  m.current_show_name = m.top.findNode("current_show_name")
  m.requestor = m.top.findNode("requestor")

  m.current_show_image_path = m.top.findNode("current_show_image_path")
  m.background = m.top.findNode("background")

  m.duration_label = m.top.findNode("duration_label")
  m.elapsed_time_label = m.top.findNode("elapsed_time_label")

  m.progress_bar = m.top.findNode("progress_bar")
  m.progress_bar_background = m.top.findNode("progress_bar_background")
end function

function buildTasks() as void
  m.listenTask = CreateObject("roSGNode", "ListenTask")
  m.listenTask.ObserveField("current_info", "onCurrentInfoChanged")
end function

function setUpElapsedTimeTimer() as void
  m.elapsedTime_timer = m.top.findNode("elapsedTime_timer")

  m.elapsedTime_timer.repeat = true
  m.elapsedTime_timer.duration = 1
  m.elapsedTime_timer.control = "start"

  m.elapsedTime_timer.ObserveField("fire", "updateElapsedTime")
end function

function setUpRefreshTimer() as void
  m.refresh_timer = m.top.findNode("refresh_timer")

  m.refresh_timer.repeat = true
  m.refresh_timer.duration = 10
  m.refresh_timer.control = "start"

  m.refresh_timer.ObserveField("fire", "refreshData")
end function

function setUpAudio() as void
  audiocontent = createObject("RoSGNode", "ContentNode")
  audiocontent.url = "http://stream.uabmagic.com:8000/stream/3/"
  audiocontent.streamFormat = "mp3"

  m.audio = m.top.findNode("audio_player")
  m.audio.content = audiocontent
end function

function refreshData() as void
  m.listenTask.control = "run"
end function

function playAudio() as void
  if (m.is_playing) then
    m.audio.control = "stop"
    m.toggle_button.focusedIconUri = "pkg:/images/play_black.png"
    m.toggle_button.iconUri = "pkg:/images/play_white.png"
    m.toggle_button.text = "Play"
    m.is_playing = false
  else
    m.audio.control = "play"
    m.toggle_button.focusedIconUri = "pkg:/images/pause_black.png"
    m.toggle_button.iconUri = "pkg:/images/pause_white.png"
    m.toggle_button.text = "Pause"
    m.is_playing = true
  end if
end function

function onKeyEvent(key as string, press as boolean) as boolean
  if press then
    if key = "play" then
      playAudio()
      handled = true
    end if
  end if
end function

sub onCurrentInfoChanged()
  toggleVisibility(true)

  current_info = m.listenTask.current_info["nowplaying"]

  m.title.text = current_info.schedule

  m.current_track_title.text = current_info.attractionAndSong
  m.current_track_artist_name.text = UCase(current_info.themeParkAndLand)
  m.current_show_image_path.uri = current_info.imageUrl

  if (current_info.requestor <> "") then
    m.requestor.visible = true
    m.requestor.text = Substitute("Requested by {0}", current_info.requestor)
  else
    m.requestor.visible = false
  end if

  whatsNext = ""

  for each song in current_info.upNext
    whatsNext += (chr(10) + "- " + song)
  end for

  m.top.whatsNext = whatsNext

  m.background.uri = current_info.blurredImageUrl

  refresh_duration = current_info.timeLeft

  if refresh_duration <= 0 then
    refresh_duration = 3
  end if

  m.refresh_timer.duration = refresh_duration

  m.durationDisplay = current_info.durationDisplay
  m.duration = current_info.duration
  m.elapsed_time = refresh_duration

  m.duration_label.text = current_info.durationDisplay

  m.progress_bar.width = (1 - (m.elapsed_time / m.duration)) * 1820
end sub

sub updateElapsedTime()
  m.elapsed_time--

  if m.elapsed_time < 0 then
    m.elapsed_time = 0
  end if

  elapsedTime = m.duration - m.elapsed_time
  time_minutes = Int(elapsedTime / 60)
  time_seconds = elapsedTime mod 60

  time_seconds_formatted = time_seconds.tostr()

  if time_seconds < 10 then
    time_seconds_formatted = Substitute("0{0}", time_seconds.tostr())
  end if

  m.elapsed_time_label.text = Substitute("{0}:{1}", time_minutes.tostr(), time_seconds_formatted)

  m.progress_bar.width = (1 - (m.elapsed_time / m.duration)) * 1820
end sub

function toggleVisibility(visible as boolean)
  m.duration_label.visible = visible
  m.elapsed_time_label.visible = visible

  m.progress_bar.visible = visible
  m.progress_bar_background.visible = visible
end function

sub onTogglePressed()
  playAudio()
end sub

sub onWhatsNextPressed()
  m.top.showDialog = true
end sub
