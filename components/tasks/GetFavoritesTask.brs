function executeTask() as void
  json = getWithAuth("roku/favorites")

  results = CreateObject("roSGNode", "ContentNode")

  if json <> invalid and json.results.Count() > 0
    for each result in json.results
      item = results.CreateChild("SongResultNode")

      item.id = result.id
      item.attractionAndSong = result.attractionAndSong

      if result.doesExist("playback")
        item.durationDisplay = result.playback.durationDisplay
      end if

      item.hdPosterUrl = result.images.url
      item.themeParkAndLand = result.themeParkAndLand
      item.blurredUrl = result.images.blurredUrl
      item.url = result.images.url
    end for
  end if

  m.top.results = results
end function
