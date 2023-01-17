function executeTask() as void
  request = {
    songId: m.top.songId
  }

  json = postJson("request", request, true)

  response = CreateObject("roSGNode", "SongRequestResponseNode")

  response.requestId = json.requestId
  response.success = json.success

  m.top.response = response
end function
