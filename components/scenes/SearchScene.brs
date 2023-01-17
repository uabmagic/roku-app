sub init()
  m.searchResultList = m.top.findNode("resultList")
  m.searchResultList.observeField("itemSelected", "onSearchItemSelect")

  m.keyboard = m.top.findNode("keyboard")
  m.keyboard.observeField("text", "onSearchChange")

  m.top.observeField("visible", "onGetFocus")

  buildSearchTask()

  ' REMOVE
  m.keyboard.text = "tomorrow's child"
end sub

sub onGetFocus()
  if m.top.visible = true
    m.keyboard.setFocus(true)
  end if
end sub

function buildSearchTask() as void
  m.searchTask = CreateObject("roSGNode", "SearchTask")
  m.searchTask.ObserveField("results", "onResultsChanged")
end function

function onSearchChange()
  if len(m.keyboard.text) > 3 then
    m.searchTask.query = m.keyboard.text
    m.searchTask.control = "run"
  end if
end function

function onSearchItemSelect()
  selectedSongId = m.searchResultList.content.getChild(m.searchResultList.itemSelected).id
  m.top.selectedSongId = 0
  m.top.selectedSongId = selectedSongId
end function

sub onResultsChanged()
  m.searchResultList.content = m.searchTask.results
end sub

function onKeyEvent(key as string, press as boolean) as boolean
  handled = false

  if press
    if m.keyboard.isInFocusChain() = true and key = "right"
      m.searchResultList.setFocus(true)
      handled = true
    else if m.searchResultList.isInFocusChain() = true and key = "left"
      m.keyboard.setFocus(true)
      handled = true
    end if
  end if

  return handled
end function
