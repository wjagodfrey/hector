
frame = 0
resizeFactor = 2

@mouse = mouse =
  x    : root.innerWidth/2
  y    : root.innerHeight/2
  down : false
  up   : false

touchMove    = false
touchTimeout = {}

gameCq = cq().framework(
  onresize: (width, height) ->
    if mouse.x > width then mouse.x = width
    if mouse.y > height then mouse.y = height
    @canvas.width = width
    @canvas.height = height
    wallpaper.resize()
    return

  onmouseup: mouseUpHandler = (x, y, btn) ->
    mouse.down = false
    mouse.up = true
    fireEvent 'onmouseup', x, y, btn

  onmousedown: mouseDownHandler = (x, y, btn) ->
    mouse.down = true
    fireEvent 'onmousedown', x, y, btn

  onmousemove: mouseMoveHandler = (x, y) ->
    mouse =
      x: x
      y: y


  ontouchstart: (x, y) ->
    mouseMoveHandler x, y
    clearTimeout touchTimeout
    touchTimeout = setTimeout ->
      if !touchMove
        mouseDownHandler x, y
    , 500

  ontouchmove: (x, y) ->
    touchMove = true
    mouseMoveHandler x, y

  ontouchend: (x, y) ->
    if !touchMove
      mouseUpHandler x, y
      touchMove = false

  onrender: (delta, time) ->
    # if frame < 50
      if loaded then frame++
      @clear('#c6d191')

      # make resizeds show pixel edges
      @context.mozImageSmoothingEnabled    =
      @context.webkitImageSmoothingEnabled =
      @context.msImageSmoothingEnabled     =
      @context.imageSmoothingEnabled       = false

      resizeFactor = Math.min(gameCanvas.height / 130, gameCanvas.width / 100)
      if resizeFactor < 2 then resizeFactor = 2

      # draw entities
      for i, entity of entities
        entity.update?()
        entity.draw?(@, delta, time, parseInt i)

      mouse.up = false

      return


).appendTo 'body'
gameCanvas = gameCq.canvas