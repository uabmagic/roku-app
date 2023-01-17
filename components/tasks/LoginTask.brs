function executeTask() as void
  url = "auth/login"

  login_request = {
    password: m.top.password,
    username: m.top.username
  }

  json = postJson(url, login_request)

  user_info = CreateObject("roSGNode", "LoginResponseNode")

  user_info.sid = json.sid
  user_info.userId = json.userId

  m.top.user_info = user_info
end function
