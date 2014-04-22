'use strict'

hasMouseHit = (x, y, width, height) ->
  col = 
    x : (x + width / 2  >= mouse.x and x - width / 2  <= mouse.x)
    y : (y + height / 2 >= mouse.y and y - height / 2 <= mouse.y)

  if col.x and col.y
    return true
  else
    return false

getUrlSettings = ->
  url = root.document.URL
  if url.indexOf("#")+1
    settings = url.substring(url.indexOf("#")+1).split('')
    if settings.length is 4
      {
        eyebrows : if eyebrowsStates[settings[0]] then eyebrowsStates[settings[0]] else eyebrowsStates[0]
        eyelids  : if eyelidsStates[settings[1]] then eyelidsStates[settings[1]] else eyelidsStates[0]
        mouth    : if mouthStates[settings[2]] then mouthStates[settings[2]] else mouthStates[0]
        pupils   : if pupilsStates[settings[3]] then pupilsStates[settings[3]] else pupilsStates[0]
      }
setUrlSettings = ->
  url = root.document.URL
  url = url.substring(0, url.indexOf("#"))
  settings = "##{eyebrowsStates.indexOf(face.s.eyebrows)}#{eyelidsStates.indexOf(face.s.eyelids)}#{mouthStates.indexOf(face.s.mouth)}#{pupilsStates.indexOf(face.s.pupils)}"
  root.window.location.hash = settings
