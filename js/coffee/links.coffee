onEvent 'assetsLoaded', ->

  linkBtns =
    github: 'http://github.com/wilfredjamesgodfrey/hector'
    twitter: 'http://twitter.com/wjagodfrey'

  for name, href of linkBtns
    do (name, href) ->
      entities.push @btns[name] = btns[name] =

        a         : sprites.buttons.actions[name].frames
        f         : 0
        s         : 'off' # off, hover

        update: ->
          @x = gameCanvas.width - (@a[@f].width * 2) / 2
          @y = (@a[@f].height * 2)

          if name is 'twitter'
            @x -= 28
            @y -= 5
          else if name is 'github'
            @x -= 20
            @y += 35

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
              document.location.href = href




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