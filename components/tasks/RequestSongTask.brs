function executeTask() as void
  songId = m.top.songId.tostr()

  json = getWithAuth("roku/request?songId=" + songId)

  response = CreateObject("roSGNode", "SongRequestResponseNode")

  response.requestId = json.requestId
  response.success = json.success

  m.top.response = response
end function
