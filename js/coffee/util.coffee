hasMouseHit = (x, y, width, height) ->
  col = 
    x : (x + width / 2  >= mouse.x and x - width / 2  <= mouse.x)
    y : (y + height / 2 >= mouse.y and y - height / 2 <= mouse.y)

  if col.x and col.y
    return true
  else
    return false