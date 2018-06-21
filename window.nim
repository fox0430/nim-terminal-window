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
  for i in 0..h - 1:
    result.buffer.add @[]
    for j in 0..w - 1:
      result.buffer[i].add "A".toRunes


proc wmove(win: var Window, x, y: int) =
  stdout.setCursorPos(win.beginX, win.beginY)
  for row in 0..win.height - 1:
    for cal in 0.. win.width - 1:
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
  for row in 0..win.height - 1:
    for cal in 0.. win.width - 1:
      win.buffer[row][cal] = str[countStrLen]
      inc(countStrLen)

when isMainModule:
  stdout.eraseScreen()
  var win = newwin(10, 10, 5, 5)
  wmove(win, 9, 9)
  var key = wgetch(win)
