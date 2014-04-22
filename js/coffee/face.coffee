onEvent 'assetsLoaded', =>

  entities.push @face = face =
    x: 0
    y: 0

    yOffset: -20

    focal:
      x: window.innerWidth/2
      y: window.innerHeight/2
    headSpeed: 4
    a:
      backboard  : sprites.face.actions.backboard.frames
      skin       : sprites.face.actions.skin.frames
      mouth      : sprites.face.actions.mouth.frames
      ears       : sprites.face.actions.ears.frames
      nose       : sprites.face.actions.nose.frames
      eye_whites : sprites.face.actions.eye_whites.frames
      pupils     : sprites.face.actions.pupils.frames
      eyebrows   : sprites.face.actions.eyebrows.frames
      eyelids    : sprites.face.actions.eyelids.frames

    s: getUrlSettings() or {
      eyelids  : 'half'
      eyebrows : 'flat'
      mouth    : 'flat'
      pupils   : 'small'
    }

    f:
      eyebrows : 0
      pupils   : 0
      mouth    : 2
      eyelids  : 0

    b:
      blinking : true
      duration : 5
      interval : 1
      frame    : 0
      startNew : ->
        blinkTime = 3000 + (Number((Math.random()).toFixed(1))) * 10000
        @duration = 1 + (Number((Math.random()).toFixed(1))) * 5
        if (Number((Math.random()).toFixed(1))) < 0.7
          @interval = 0
        else
          @interval = (Number((Math.random()).toFixed(1))) * 5
        setTimeout =>
          @blinking = true
        , blinkTime

    update: ->
      
      if !@headSpeed then @headSpeed = 1
      @focal.x += (mouse.x - @focal.x) / @headSpeed
      @focal.y += (mouse.y - @focal.y) / (@headSpeed * 1.6)

      @x = gameCanvas.width/2
      @y = gameCanvas.height/2 + (@yOffset * resizeFactor)


    draw: (ctx) ->

      pax =
        x : (@focal.x - gameCanvas.width / 2) / gameCanvas.width / 2
        y : (@focal.y - (@yOffset * resizeFactor) - (gameCanvas.height / 2)) / gameCanvas.height / 2

      eyebrowOffset = -10*resizeFactor
      eyeOffset     = -4*resizeFactor
      noseOffset    = 5*resizeFactor
      mouthOffset   = 15*resizeFactor

      earPax = -4
      middleSkinPax = 5
      topSkinPax = 8
      eyeballPax = 10
      nosePax = 15
      pupilPax = 17

      # make sure we're using frames that exist
      if !@a.eyebrows[@f.eyebrows]? then @f.eyebrows = 0
      if !@a.pupils[@f.pupils]?     then @f.pupils   = 0
      if !@a.mouth[@f.mouth]?       then @f.mouth    = 0
      if !@a.eyelids[@f.eyelids]?   then @f.eyelids  = 0

      # display logic

      if @s.eyelids is 'open'
        @f.eyelids = 1
      else if @s.eyelids is 'closed'
        @f.eyelids = 0
      else if @s.eyelids is 'squint'
        @f.eyelids = 5
        if pax.y < -0.05
          @f.eyelids = 6
          if pax.y < -0.2
            @f.eyelids = 7
        if pax.y > 0.05
          @f.eyelids = 8
          # if pax.y > 0.2 # not needed
          #   @f.eyelids = 9
      else if @s.eyelids is 'half'
        @f.eyelids = 2
        if pax.y < -0.07
          @f.eyelids = 3
        if pax.y > 0.07
          @f.eyelids = 4

      if @s.pupils is 'small'
        @f.pupils = 0
      else if @s.pupils is 'large'
        @f.pupils = 1

      if @s.eyebrows is 'flat'
        @f.eyebrows = 0
      else if @s.eyebrows is 'peak'
        @f.eyebrows = 1
      else if @s.eyebrows is 'valley'
        @f.eyebrows = 2

      if @s.mouth is 'joyful'
        @f.mouth = 0
      else if @s.mouth is 'happy'
        @f.mouth = 1
      else if @s.mouth is 'flat'
        @f.mouth = 2
      else if @s.mouth is 'sad'
        @f.mouth = 3
      else if @s.mouth is 'sorrowful'
        @f.mouth = 4

      if @f.pupils is 1 # large pupil
        pupilPax = 13

      if @b.blinking
        @b.frame++

        if @b.frame > @b.duration * (if @b.interval then 2 else 1) + @b.interval # blink is finished
          @b.blinking = false
          @b.frame = 0
          @.b.startNew()
        else if @b.frame > @b.duration + @b.interval and @b.interval # second blink
          @f.eyelids = 0
        else if @b.frame > @b.duration # blink interval
          false
        else # first blink
          @f.eyelids = 0


      ctx # go forth and draw

      # backboard 0
      .save()
      .translate(
        @x-@a.backboard[0].width*resizeFactor/2
        @y-@a.backboard[0].height*resizeFactor/2
      )
      .drawImage(
        @a.backboard[0]
        0,0,@a.backboard[0].width,@a.backboard[0].height
        0,0,@a.backboard[0].width*resizeFactor,@a.backboard[0].height*resizeFactor
      )
      .restore()

      # ears
      .save()
      .translate(
        (@x-@a.ears[0].width*resizeFactor/2) + earPax  * resizeFactor * pax.x
        (@y-@a.ears[0].height*resizeFactor/2) + earPax  * resizeFactor * pax.y
      )
      .drawImage(
        @a.ears[0]
        0,0,@a.ears[0].width,@a.ears[0].height
        0,0,@a.ears[0].width*resizeFactor,@a.ears[0].height*resizeFactor
      )
      .restore()

      # skin 0
      .save()
      .translate(
        @x-@a.skin[0].width*resizeFactor/2
        @y-@a.skin[0].height*resizeFactor/2
      )
      .drawImage(
        @a.skin[0]
        0,0,@a.skin[0].width,@a.skin[0].height
        0,0,@a.skin[0].width*resizeFactor,@a.skin[0].height*resizeFactor
      )
      .restore()

      # skin 1
      .save()
      .translate(
        (@x-@a.skin[1].width*resizeFactor/2) + middleSkinPax  * resizeFactor * pax.x
        (@y-@a.skin[1].height*resizeFactor/2) + middleSkinPax  * resizeFactor * pax.y
      )
      .drawImage(
        @a.skin[1]
        0,0,@a.skin[1].width,@a.skin[1].height
        0,0,@a.skin[1].width*resizeFactor,@a.skin[1].height*resizeFactor
      )
      .restore()

      # skin 2
      .save()
      .translate(
        (@x-@a.skin[2].width*resizeFactor/2) + topSkinPax  * resizeFactor * pax.x
        (@y-@a.skin[2].height*resizeFactor/2) + topSkinPax  * resizeFactor * pax.y
      )
      .drawImage(
        @a.skin[2]
        0,0,@a.skin[2].width,@a.skin[2].height
        0,0,@a.skin[2].width*resizeFactor,@a.skin[2].height*resizeFactor
      )
      .restore()

      # eye whites
      .save()
      .translate(
        (@x - @a.eye_whites[0].width * resizeFactor / 2) + eyeballPax  * resizeFactor * pax.x
        (@y-@a.eye_whites[0].height*resizeFactor/2+eyeOffset) + eyeballPax  * resizeFactor * pax.y
      )
      .drawImage(
        @a.eye_whites[0]
        0,0,@a.eye_whites[0].width,@a.eye_whites[0].height
        0,0,@a.eye_whites[0].width*resizeFactor,@a.eye_whites[0].height*resizeFactor
      )
      .restore()

      # pupils
      .save()
      .translate(
        (@x-@a.pupils[@f.pupils].width*resizeFactor/2) + pupilPax  * resizeFactor * pax.x
        (@y-@a.pupils[@f.pupils].height*resizeFactor/2+eyeOffset) + pupilPax  * resizeFactor * pax.y
      )
      .drawImage(
        @a.pupils[@f.pupils]
        0,0,@a.pupils[@f.pupils].width,@a.pupils[@f.pupils].height
        0,0,@a.pupils[@f.pupils].width*resizeFactor,@a.pupils[@f.pupils].height*resizeFactor
      )
      .restore()

      # eyelids
      .save()
      .translate(
        (@x-@a.eyelids[@f.eyelids].width*resizeFactor/2) + eyeballPax  * resizeFactor * pax.x
        (@y-@a.eyelids[@f.eyelids].height*resizeFactor/2+eyeOffset) + eyeballPax  * resizeFactor * pax.y
      )
      .drawImage(
        @a.eyelids[@f.eyelids]
        0,0,@a.eyelids[@f.eyelids].width,@a.eyelids[@f.eyelids].height
        0,0,@a.eyelids[@f.eyelids].width*resizeFactor,@a.eyelids[@f.eyelids].height*resizeFactor
      )
      .restore()

      # mouth
      .save()
      .translate(
        (@x-@a.mouth[@f.mouth].width*resizeFactor/2) + topSkinPax  * resizeFactor * pax.x
        (@y-@a.mouth[@f.mouth].height*resizeFactor/2+mouthOffset) + topSkinPax  * resizeFactor * pax.y
      )
      .drawImage(
        @a.mouth[@f.mouth]
        0,0,@a.mouth[@f.mouth].width,@a.mouth[@f.mouth].height
        0,0,@a.mouth[@f.mouth].width*resizeFactor,@a.mouth[@f.mouth].height*resizeFactor
      )
      .restore()

      # nose
      .save()
      .translate(
        (@x-@a.nose[0].width*resizeFactor/2) + nosePax  * resizeFactor * pax.x
        (@y-@a.nose[0].height*resizeFactor/2+noseOffset) + nosePax  * resizeFactor * pax.y
      )
      .drawImage(
        @a.nose[0]
        0,0,@a.nose[0].width,@a.nose[0].height
        0,0,@a.nose[0].width*resizeFactor,@a.nose[0].height*resizeFactor
      )
      .restore()

      # eyebrows
      .save()
      .translate(
        (@x-@a.eyebrows[@f.eyebrows].width*resizeFactor/2) + topSkinPax  * resizeFactor * pax.x
        (@y-@a.eyebrows[@f.eyebrows].height*resizeFactor/2+eyebrowOffset) + topSkinPax  * resizeFactor * pax.y
      )
      .drawImage(
        @a.eyebrows[@f.eyebrows]
        0,0,@a.eyebrows[@f.eyebrows].width,@a.eyebrows[@f.eyebrows].height
        0,0,@a.eyebrows[@f.eyebrows].width*resizeFactor,@a.eyebrows[@f.eyebrows].height*resizeFactor
      )
      .restore()