function init()
  setupFonts()
end function

sub refreshCredentials()
  datetime = createObject("roDateTime")
  utimeNow = datetime.asSeconds()

  m.top.refreshCredentials = utimeNow
end sub

sub setupFonts()
  m.drawingStyles = {
    "Bold": {
      "fontUri": "pkg:/components/fonts/avenir_85_heavy_latin.ttf"
      "fontSize": 36
      "color": "#ffffff"
    },
    "Normal": {
      "fontUri": "pkg:/components/fonts/avenir_45_book_latin.ttf"
      "fontSize": 36
      "color": "#ffffff"
    }
  }

  m.lightFont = CreateObject("roSGNode", "Font")
  m.lightFont.uri = "pkg:/components/fonts/avenir_35_light_latin.ttf"
  m.lightFont.size = 30

  m.normalFont = CreateObject("roSGNode", "Font")
  m.normalFont.uri = "pkg:/components/fonts/avenir_45_book_latin.ttf"
  m.normalFont.size = 30

  m.romanFont = CreateObject("roSGNode", "Font")
  m.romanFont.uri = "pkg:/components/fonts/avenir_55_roman_latin.ttf"
  m.romanFont.size = 30

  m.heavyFont = CreateObject("roSGNode", "Font")
  m.heavyFont.uri = "pkg:/components/fonts/avenir_85_heavy_latin.ttf"
  m.heavyFont.size = 30

  m.blackFont = CreateObject("roSGNode", "Font")
  m.blackFont.uri = "pkg:/components/fonts/avenir_95_black_latin.ttf"
  m.blackFont.size = 30
end sub
