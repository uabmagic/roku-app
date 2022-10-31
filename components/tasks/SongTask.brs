function executeTask() as void
  json = get("songs/" + m.top.songId.tostr(), false)

  if json <> invalid
    result = CreateObject("roSGNode", "SongResultNode")

    result.id = json.id
    result.attractionAndSong = json.attractionAndSong
    result.canRequest = json.canRequest
    result.durationDisplay = json.playback.durationDisplay
    result.hdPosterUrl = json.images.url
    result.themeParkAndLand = json.themeParkAndLand
    result.blurredUrl = json.images.blurredUrl
    result.url = json.images.url
    result.year = json.year
    result.composer = json.composer
    result.dateAdded = json.dateAdded
    result.lastPlayed = json.lastPlayed
    result.lastRequested = json.lastRequested
    result.comments = json.comments
    result.plays = json.plays
    result.requests = json.requests

    m.top.result = result
  end if
end function
