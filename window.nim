import terminal

type Window = object
  h: int
  w: int
  y: int
  x: int


proc createWindow(h, w, y, x :int): Window =
  result.h = h
  result.w = w
  result.y = y
  result.x = x

when isMainModule:
  var win = createWindow(1 ,1 ,1 ,1)
  doAssert(win.h == 1)
  doAssert(win.w == 1)
  doAssert(win.y == 1)
  doAssert(win.x == 1)
