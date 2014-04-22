onEvent 'assetsLoaded', ->


  entities.push @github = github =
    x: 0
    y: 0

    a         : sprites.scenery.actions.github.frames
    f         : 0
    s         : 'off' # off, hover

    update: ->
      @x = gameCanvas.width - (@a[@f].width * 2) / 2 - 20
      @y = (@a[@f].height * 2) - 15

      @mouseOver = hasMouseHit(
        @x
        @y
        @a[@f].width * 2
        @a[@f].height * 2
      )

    draw: (ctx) ->

      @s = 'off'
      if @mouseOver
        @s = 'hover'

        if mouse.up
          document.location.href = 'http://github.com/wilfredjamesgodfrey/hector'




      if @s is 'hover'
        @f = 1
      else
        @f = 0

      # return
      ctx # go forth and draw

      .save()
      .translate(
        @x - @a[@f].width * 2 / 2
        @y - @a[@f].height * 2 / 2
      )
      .drawImage(
        @a[@f]
        0, 0, @a[@f].width, @a[@f].height
        0, 0, @a[@f].width * 2, @a[@f].height * 2
      )
      .restore()