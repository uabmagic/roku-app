sub init()
  m.resultList = m.top.findNode("resultList")
  m.resultList.observeField("itemSelected", "onItemSelect")

  m.top.observeField("visible", "onGetFocus")

  m.getFavoritesTask = CreateObject("roSGNode", "GetFavoritesTask")
  m.getFavoritesTask.ObserveField("results", "onResultsChanged")
end sub

sub onGetFocus()
  if m.top.visible
    ' refreshCredentials()

    m.getFavoritesTask.control = "run"
    m.resultList.setFocus(true)
  end if
end sub

function onItemSelect()
  selectedSongId = m.resultList.content.getChild(m.resultList.itemSelected).id
  m.top.selectedSongId = 0
  m.top.selectedSongId = selectedSongId
end function

sub onResultsChanged()
  m.resultList.content = m.getFavoritesTask.results
end sub
