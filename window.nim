import terminal
import strutils
import os

type Window = object
  width: int
  height: int
  beginX: int
  beginY: int
  cursorXPosi: int
  cursorYPosi: int
  buffer: string

proc newwin(w, h, x, y: int): Window =
  result.width = w
  result.height = h
  result.beginX = x
  result.beginY = y
  result.cursorXPosi = x
  result.cursorYPosi = y
  result.buffer = ""

proc wmove(win: var Window, x, y: int) =
  var countBufferLen = 0

  for row in y..win.height - 1:
    for col in x..win.width - 1:
      stdout.setCursorPos(win.beginX + col, win.beginY + row)
      if countBufferLen < win.buffer.len:
        stdout.write(win.buffer[countBufferLen])
        inc(countBufferLen)
      else:
        stdout.write("A")
  stdout.setCursorPos(win.beginX + x, win.beginY + y)
  win.cursorXPosi = win.beginX + x
  win.cursorYPosi = win.beginY + y

proc wgetch(win: Window): char =
  stdout.setCursorPos(win.cursorXPosi, win.cursorYPosi)
  result = getch()


when isMainModule:
  stdout.eraseScreen()
  var win = newwin(10, 10, 5, 5)
  wmove(win, 0, 0)
  var key = wgetch(win)
