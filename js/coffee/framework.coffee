
frame = 0


@mouse = mouse =
  x: root.innerWidth/2
  y: root.innerHeight/2

gameCq = cq().framework(
  onresize: (width, height) ->
    @canvas.width = width
    @canvas.height = height
    return

  onmousemove: (x, y) ->
    mouse =
      x: x
      y: y

  onkeydown: (key) ->

  onkeyup: (key) ->

  onrender: (delta, time) ->
    # if frame < 50
      if loaded then frame++
      @clear('#c6d191')

      # make resizeds show pixel edges
      @context.mozImageSmoothingEnabled    =
      @context.webkitImageSmoothingEnabled =
      @context.msImageSmoothingEnabled     =
      @context.imageSmoothingEnabled       = false


      # draw entities
      for i, entity of entities
        entity.update?()
        entity.draw?(@, delta, time, parseInt i)
      return
).appendTo 'body'
gameCanvas = gameCq.canvas