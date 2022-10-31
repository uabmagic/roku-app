function init()
  m.currentScene = "listen"

  m.container = m.top.findNode("container")
  m.navBar = m.top.findNode("navBar")
  m.navbar_background = m.top.findNode("navbar_background")

  m.lightFont = CreateObject("roSGNode", "Font")
  m.lightFont.uri = "pkg:/components/fonts/avenir_35_light_latin.ttf"
  m.lightFont.size = 30

  m.romanFont = CreateObject("roSGNode", "Font")
  m.romanFont.uri = "pkg:/components/fonts/avenir_55_roman_latin.ttf"
  m.romanFont.size = 30

  m.blackFont = CreateObject("roSGNode", "Font")
  m.blackFont.uri = "pkg:/components/fonts/avenir_95_black_latin.ttf"
  m.blackFont.size = 30

  m.navBar.observeField("createNextPanelIndex", "setPanel")

  m.favoritesScene = m.top.findNode("favoritesScene")
  m.listenScene = m.top.findNode("listenScene")
  m.requestsScene = m.top.findNode("requestsScene")
  m.searchScene = m.top.findNode("searchScene")
  m.settingsScene = m.top.findNode("settingsScene")
  m.songScene = m.top.findNode("songScene")

  ' Scene field observations
  m.listenScene.observeField("showDialog", "onShowWhatsNextDialog")

  m.searchScene.observeField("selectedSongId", "onSearchSongSelected")

  m.favoritesScene.observeField("selectedSongId", "onFavoriteSongSelected")
  m.favoritesScene.observeField("refreshCredentials", "onRefreshCredentials")

  m.settingsScene.observeField("refreshCredentials", "onRefreshCredentials")

  buildTasks()
end function

function onShowWhatsNextDialog()
  if m.listenScene.showDialog = true
    dialog = createObject("roSGNode", "Dialog")
    dialog.observeField("wasClosed", "onWhatsNextDialogClosed")
    dialog.message = m.listenScene.whatsNext
    dialog.messageFont = m.lightFont
    dialog.optionsDialog = false
    dialog.title = "What's Next?"
    dialog.titleFont = m.blackFont

    m.top.dialog = dialog
  end if
end function

function onWhatsNextDialogClosed()
  m.listenScene.showDialog = false
end function

function onSearchSongSelected()
  m.currentScene = "search"
  onSongSelected(m.searchScene.selectedSongId)
end function

function onFavoriteSongSelected()
  m.currentScene = "favorites"
  onSongSelected(m.favoritesScene.selectedSongId)
end function

function onSongSelected(songId as integer)
  m.listenScene.visible = false
  m.searchScene.visible = false
  m.requestsScene.visible = false
  m.favoritesScene.visible = false
  m.settingsScene.visible = false
  m.songScene.visible = true

  m.songScene.setFocus(true)

  m.songScene.visible = true
  m.songScene.songId = songId

  m.navBar.visible = false
  m.navbar_background.visible = false
end function

sub onRefreshCredentials(event as object)
  buildTasks()
end sub

sub setPanel(event as object)
  index = event.getData()

  if index = 0
    m.currentScene = "listen"

    m.searchScene.visible = false
    m.requestsScene.visible = false
    m.favoritesScene.visible = false
    m.settingsScene.visible = false
    m.songScene.visible = false

    m.listenScene.visible = true
    m.listenScene.setFocus(true)
  else if index = 1
    m.currentScene = "search"

    m.listenScene.visible = false
    m.requestsScene.visible = false
    m.favoritesScene.visible = false
    m.settingsScene.visible = false
    m.songScene.visible = false

    m.searchScene.visible = true
    m.searchScene.setFocus(true)
  else if index = 2
    m.currentScene = "requests"

    m.listenScene.visible = false
    m.searchScene.visible = false
    m.favoritesScene.visible = false
    m.settingsScene.visible = false
    m.songScene.visible = false

    m.requestsScene.visible = true
    m.requestsScene.setFocus(true)
  else if index = 3
    m.currentScene = "favorites"

    m.listenScene.visible = false
    m.searchScene.visible = false
    m.requestsScene.visible = false
    m.settingsScene.visible = false
    m.songScene.visible = false

    m.favoritesScene.visible = true
    m.favoritesScene.setFocus(true)
  else if index = 4
    m.currentScene = "settings"

    m.listenScene.visible = false
    m.searchScene.visible = false
    m.requestsScene.visible = false
    m.favoritesScene.visible = false
    m.songScene.visible = false

    m.settingsScene.visible = true
    m.settingsScene.setFocus(true)
  end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
  handled = false

  if press
    if m.container.isInFocusChain() and m.songScene.visible = false and key = "up"
      m.navBar.setFocus(true)
      handled = true
    else if m.navBar.isInFocusChain() and (key = "down" or key = "OK")
      if m.listenScene.visible
        m.listenScene.visible = false
        m.listenScene.visible = true
        m.listenScene.setFocus(true)
      else if m.searchScene.visible
        m.searchScene.visible = false
        m.searchScene.visible = true
        m.searchScene.setFocus(true)
      else if m.requestsScene.visible
        m.requestsScene.visible = false
        m.requestsScene.visible = true
        m.requestsScene.setFocus(true)
      else if m.favoritesScene.visible
        m.favoritesScene.visible = false
        m.favoritesScene.visible = true
        m.favoritesScene.setFocus(true)
      else if m.settingsScene.visible
        m.settingsScene.visible = false
        m.settingsScene.visible = true
        m.settingsScene.setFocus(true)
      else if m.songScene.visible
        songId = m.songScene.songId
        m.songScene.songId = 0
        m.songScene.songId = songId

        m.songScene.visible = false
        m.songScene.visible = true
        m.songScene.setFocus(true)
      end if

      handled = true
    else if m.songScene.visible = true and key = "back" and m.currentScene = "search"
      m.navBar.visible = true
      m.navbar_background.visible = true

      m.songScene.visible = false
      m.searchScene.visible = false
      m.searchScene.visible = true
      m.searchScene.setFocus(true)

      handled = true
    else if m.songScene.visible = true and key = "back" and m.currentScene = "favorites"
      m.navBar.visible = true
      m.navbar_background.visible = true

      m.songScene.visible = false
      m.favoritesScene.visible = false
      m.favoritesScene.visible = true
      m.favoritesScene.setFocus(true)

      handled = true
    end if
  end if

  return handled
end function

sub buildTasks()
  m.loginTask = CreateObject("roSGNode", "LoginTask")
  m.loginTask.ObserveField("user_info", "onUserLoggedIn")

  m.loginTask.control = "run"
end sub

sub onUserLoggedIn()
  user_info = m.loginTask.user_info

  sec = createObject("roRegistrySection", "UserData")
  sec.Write("sid", user_info.sid)
  sec.Write("userId", user_info.userId.tostr())

  sec.Flush()
end sub
