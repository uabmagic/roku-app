function init()
  m.top.backgroundColor = "0x000000FF"
  m.top.backgroundUri = ""

  m.image = m.top.findNode("image")
  m.post_title = m.top.findNode("post_title")

  m.light_font = CreateObject("roSGNode", "Font")
  m.light_font.uri = "pkg:/components/fonts/avenir_45_book_latin.ttf"
  m.light_font.size = 45

  m.post_title.font = m.light_font

  m.listenTask = CreateObject("roSGNode", "ListenTask")
  m.listenTask.ObserveField("current_info", "onCurrentInfoChanged")
  m.listenTask.control = "RUN"

  m.changepost_timer = m.top.findNode("changepost_timer")
  m.changepost_timer.control = "start"
  m.changepost_timer.ObserveField("fire", "changePost")
end function

sub onCurrentInfoChanged()
  current_info = m.listenTask.current_info["nowplaying"]

  m.post_title.text = current_info.attractionAndSong
  m.image.uri = current_info.blurredImageUrl
end sub

sub changePost()
  m.listenTask.control = "RUN"
end sub
