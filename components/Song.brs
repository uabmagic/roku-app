sub init()
  m.image = m.top.findNode("image")
  m.attractionAndSong = m.top.findNode("attractionAndSong")
  m.themeParkAndLand = m.top.findNode("themeParkAndLand")
end sub

sub showContent()
  itemContent = m.top.itemContent

  m.itemId = itemContent.id

  m.image.uri = itemContent.url
  m.attractionAndSong.text = itemContent.attractionAndSong
  m.themeParkAndLand.text = itemContent.themeParkAndLand
end sub
