import terminal
import strutils
import os
import unicode
import sequtils

type Window = object
  width: int
  height: int
  beginX: int
  beginY: int
  cursorXPosi: int
  cursorYPosi: int
  buffer: seq[seq[Rune]]
  bufferLen: int

proc newwin(w, h, x, y: int): Window =
  result.width = w
  result.height = h
  result.beginX = x
  result.beginY = y
  result.cursorXPosi = x
  result.cursorYPosi = y

  result.buffer = @[]
  for i in 0 ..< h:
    result.buffer.add @[]
    for j in 0 ..< w:
      result.buffer[i].add " ".toRunes


proc wmove(win: var Window, x, y: int) =
  stdout.setCursorPos(win.beginX, win.beginY)
  for row in 0 ..< win.height:
    for cal in 0 ..< win.width:
      stdout.setCursorPos(win.beginX + cal, win.beginY + row)
      stdout.write(win.buffer[row][cal])
  win.cursorXPosi = win.beginX + x
  win.cursorYPosi = win.beginY + y
  stdout.setCursorPos(win.cursorXPosi, win.cursorYPosi)

proc wgetch(win: Window): char =
  stdout.setCursorPos(win.cursorXPosi, win.cursorYPosi)
  result = getch()

proc waddstr(win: var Window, str: string) =
  var countStrLen = 0
  let rstr = str.toRunes
  for row in 0 ..< win.height:
    for cal in 0 ..< win.width:
      win.buffer[row][cal] = rstr[countStrLen]
      countStrLen.inc
      win.bufferLen.inc
      if  countStrLen > rstr.len - 1:
        return

when isMainModule:
  stdout.eraseScreen()
  var win = newwin(10, 10, 5, 5)
  wmove(win, 0, 0)
  waddstr(win, "Hello")
  wmove(win, 0, 0)
  var key = getch()
