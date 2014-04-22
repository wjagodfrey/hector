btns = {}
root.btns = {}

btnGap = 20
btnNames = ['eyebrows','eyelids','mouth','pupils']

onEvent 'assetsLoaded', =>

  for i, name of btnNames
    do (i, name) =>
      entities.push root.btns[name] = btns[name] =
        x: 0
        y: 0

        a         : sprites.buttons.actions[name].frames
        f         : 0
        s         : 'up' # up, down, hover
        yOffset   : 43
        mouseOver : false

        update: ->
          @x = gameCanvas.width / 2 + (btnGap * resizeFactor * i) - (btnGap * resizeFactor * ((btnNames.length - 1) / 2))
          @y = gameCanvas.height/2 + (@yOffset * resizeFactor)

          @mouseOver = hasMouseHit(
            @x
            @y
            @a[@f].width * resizeFactor
            @a[@f].height * resizeFactor
          )

        draw: (ctx) ->

          @s = 'up'
          if @mouseOver
            if mouse.down
              @s = 'down'
            else
              @s = 'hover'

            if mouse.up

              if name is 'pupils'
                states = pupilsStates
                index = states.indexOf(face.s.pupils)+1
                if index >= states.length
                  index = 0
                face.s.pupils = states[index]

              else if name is 'eyebrows'
                states = eyebrowsStates
                index = states.indexOf(face.s.eyebrows)+1
                if index >= states.length
                  index = 0
                face.s.eyebrows = states[index]

              else if name is 'eyelids'
                states = eyelidsStates
                index = states.indexOf(face.s.eyelids)+1
                if index >= states.length
                  index = 0
                face.s.eyelids = states[index]

              else if name is 'mouth'
                states = mouthStates
                index = states.indexOf(face.s.mouth)+1
                if index >= states.length
                  index = 0
                face.s.mouth = states[index]

              setUrlSettings()




          if @s is 'down'
            @f = 2
          else if @s is 'hover'
            @f = 1
          else
            @f = 0

          # return
          ctx # go forth and draw

          .save()
          .translate(
            @x - @a[@f].width * resizeFactor / 2
            @y - @a[@f].height * resizeFactor / 2
          )
          .drawImage(
            @a[@f]
            0, 0, @a[@f].width, @a[@f].height
            0, 0, @a[@f].width * resizeFactor, @a[@f].height * resizeFactor
          )
          .restore()