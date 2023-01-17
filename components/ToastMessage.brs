sub init()
  m.fadeAnim = m.top.findNode("fadeAnim")
  m.messageLabel = m.top.findNode("messageLabel")

  m.display_timer = m.top.findNode("display_timer")
  m.display_timer.repeat = false
  m.display_timer.duration = 3
  m.display_timer.observeField("fire", "displayTimerFire")

  m.top.observeField("visible", "onVisible")
end sub

sub onVisible()
  if m.top.visible = true
    m.display_timer.control = "start"

    m.messageLabel.text = m.top.message
  end if
end sub

sub displayTimerFire()
  m.fadeAnim.control = "start"
end sub
