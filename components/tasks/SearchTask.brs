function executeTask() as void
  encoded_query = CreateObject("roUrlTransfer").escape(m.top.query.trim())
  url = "search/" + encoded_query

  json = get(url, false)

  results = CreateObject("roSGNode", "ContentNode")

  if json <> invalid and json.results.Count() > 0
    for each result in json.results
      item = results.CreateChild("SongResultNode")

      item.id = result.id
      item.attractionAndSong = result.attractionAndSong
      item.durationDisplay = result.playback.durationDisplay
      item.hdPosterUrl = result.images.url
      item.themeParkAndLand = result.themeParkAndLand
      item.blurredUrl = result.images.blurredUrl
      item.url = result.images.url
    end for
  end if

  m.top.results = results
end function
