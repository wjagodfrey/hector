onEvent 'assetsLoaded', ->

  img = sprites.scenery.actions.wallpaper.frames[0]


  wallpaperPattern = cq()
  .context
  .createPattern(
    img
    'repeat'
  )


  wallpaperSource = cq(1000, 1000)
  wallpaperSource
  .rect(0,0, wallpaperSource.canvas.width, wallpaperSource.canvas.height)
  .fillStyle(wallpaperPattern)
  .fill()

  entities.push @wallpaper = wallpaper =

    tile: cq()

    draw: (ctx) ->
      sourceWidth  = gameCanvas.width / resizeFactor
      sourceX      = wallpaperSource.canvas.width / 2 - sourceWidth / 2
      
      sourceHeight = gameCanvas.height / resizeFactor
      sourceY      = wallpaperSource.canvas.height / 2 - sourceHeight / 2

      ctx
      .drawImage(
        wallpaperSource.canvas
        sourceX ,sourceY, sourceWidth, sourceHeight
        0,0, gameCanvas.width, gameCanvas.height
      )