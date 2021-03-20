function executeTask() as void
  urlTransfer = createUrlTransfer("https://uabmagic-api.now.sh/api/songs/nowplaying")
  json = getJson(urlTransfer)

  nowplaying_info = CreateObject("roAssociativeArray")
  current_info = CreateObject("roSGNode", "NowPlayingNode")

  current_info.themeParkAndLand = json.themeParkAndLand
  current_info.attractionAndSong = json.attractionAndSong
  current_info.schedule = json.schedule
  current_info.requestor = json.requestor

  current_info.blurredImageUrl = json["images"].blurredUrl
  current_info.imageUrl = json["images"].url
  current_info.uabImageUrl = json["images"].uabUrl

  current_info.upNext = json.upNext

  current_info.durationDisplay = json["playback"].durationDisplay
  current_info.duration = json["playback"].duration
  current_info.timeLeft = json["playback"].timeLeft

  nowplaying_info.AddReplace("nowplaying", current_info)

  m.top.current_info = nowplaying_info
end function
