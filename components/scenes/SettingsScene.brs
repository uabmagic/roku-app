sub init()
  m.button_group = m.top.findNode("button_group")

  m.refresh_credentials_button = m.top.findNode("refresh_credentials_button")
  m.refresh_credentials_button.observeField("buttonSelected", "onRefreshCredentialsPressed")

  m.top.observeField("visible", "onGetFocus")
end sub

sub onRefreshCredentialsPressed()
  refreshCredentials()
end sub

sub onGetFocus()
  if m.top.visible = true
    m.button_group.setFocus(true)
  end if
end sub
