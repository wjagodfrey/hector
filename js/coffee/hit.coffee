checkHit = (A, i, delta, time) ->
  if A.hit
    for B in entities
      if B.hit and
      A isnt B
        col = 
          x : (A.right  >= B.left     and A.left    <= B.right)
          z : (A.front  >= B.back     and A.back    <= B.front)
          y : (A.top    >= B.bottom   and A.bottom  <= B.top)

        if col.x and col.z and col.y

          A.onHit?({
            other     : B
          }, i, delta, time)
          B.onHit?({
            other: A
          }, i, delta, time)