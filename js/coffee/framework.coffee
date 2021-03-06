

touchMove    = false
touchTimeout = {}

@mouse = mouse =
  x    : 0
  y    : 0
  down : false
  up   : false

gameCq = cq().framework(
  onresize: (width, height) ->
    if mouse.x > width then mouse.x = width
    if mouse.y > height then mouse.y = height
    @canvas.width = width
    @canvas.height = height
    return

  onmouseup: mouseUpHandler = (x, y, btn) ->
    mouse.down = false
    mouse.up = true
    fireEvent 'onmouseup', x, y, btn

  onmousedown: mouseDownHandler = (x, y, btn) ->
    mouse.down = true
    fireEvent 'onmousedown', x, y, btn

  onmousemove: mouseMoveHandler = (x, y) ->
    mouse.x = x
    mouse.y = y


  ontouchstart: (x, y, touch) ->
    if touch.length is 1
      touchDown = true
      mouseMoveHandler x, y

  ontouchmove: (x, y, touch) ->
    touchMove = true
    mouseMoveHandler x, y

  ontouchend: (x, y, touch) ->
    touchDown = false
    if !touchMove
      mouseDownHandler x, y
      clearTimeout touchTimeout
      touchTimeout = setTimeout ->
        mouseUpHandler x, y
      , 100
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

      resizeFactor = Math.min(gameCanvas.width / 130, gameCanvas.height / 120)
      if resizeFactor < 2 then resizeFactor = 2

      # draw entities
      for i, entity of entities
        entity.update?()
        entity.draw?(@, delta, time, parseInt i)

      mouse.up = false

      return
)

gameCanvas = gameCq.canvas

onEvent 'assetsLoaded', ->

  gameCanvas.width  = root.innerWidth
  gameCanvas.height = root.innerHeight

  gameCq.appendTo 'body'

  mouse.x = gameCanvas.width / 2
  mouse.y = gameCanvas.height / 2
  mouse.up = false
  mouse.down = false