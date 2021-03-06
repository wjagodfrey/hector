onEvent 'assetsLoaded', ->

  onEvent 'onmousedown', ->
    hand.f.point = 1
  onEvent 'onmouseup', ->
    hand.f.point = 0

  entities.push root.hand = hand =

    a:
      point  : sprites.hand.actions.point.frames

    f:
      point: 0

    s: 'open'

    draw: (ctx) ->

      # return
      ctx.save()
      ctx.context.globalAlpha = 0.8
      ctx
      .translate(
        mouse.x - @a.point[@f.point].width*(resizeFactor/2)/2
        mouse.y
      )
      .drawImage(
        @a.point[@f.point]
        0,0,@a.point[@f.point].width,@a.point[@f.point].height
        0,0,@a.point[@f.point].width*(resizeFactor/1.4),@a.point[@f.point].height*(resizeFactor/1.4)
      )
      .restore()