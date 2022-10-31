function executeTask() as void
  url = "roku/auth/login?username=" + m.top.username + "&password=" + m.top.password

  json = get(url, false)

  user_info = CreateObject("roSGNode", "LoginResponseNode")

  user_info.sid = json.sid
  user_info.userId = json.userId

  m.top.user_info = user_info
end function
