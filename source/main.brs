sub RunUserInterface()

  screen = CreateObject("roSGScreen")
  m.port = CreateObject("roMessagePort")
  screen.setMessagePort(m.port)

  scene = screen.CreateScene("MainScene")

  screen.show()

  while(true)
    msg = wait(0, m.port)
    msgType = type(msg)
    if msgType = "roSGScreenEvent"
      if msg.isScreenClosed() then
        print "EXIT " screen.getChildCount()
        return
      end if
    end if
  end while

end sub

' function GetSceneName() as string
'   return "ListenScene"
' end function

sub RunScreenSaver()
  screen = createObject("roSGScreen")
  m.port = createObject("roMessagePort")
  screen.setMessagePort(m.port)

  scene = screen.createScene("ScreensaverScene")
  screen.Show()

  while (true)
    msg = Wait(0, m.port)
    msgType = Type(msg)
    if msgType = "roSGScreenEvent"
      if msg.IsScreenClosed() then return
    end if
  end while
end sub
