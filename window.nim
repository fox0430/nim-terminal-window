import terminal
import strutils
import os

type Window = object
  w: int
  h: int
  x: int
  y: int
  cursorXPosi: int
  cursorYPosi: int
  buffer: string

proc createWindow(w, h, x, y: int): Window =
  result.w = w
  result.h = h
  result.x = x
  result.y = y
  cursorXPosi = x
  cursorYPosi = y
  result.buffer = ""

proc windowWrite(win: Window, str: string): Window =
  stdout.setCursorPos(win.w, win.h)
  let buffer = [win.buffer, str]
  stdout.write(buffer.join)
  result.buffer = buffer.join

proc focusWindow(win: Window, x, y: int): Window =
  var xPosi = win.w + x
  if win.w + win.x < xPosi:
    xPosi = win.w + win.x

  var yPosi = win.h + y
  if win.h + win.y < yPosi:
    yPosi = win.h + win.y

  stdout.setCursorPos(xPosi, yPosi)

  result.cursorXPosi = xPosi
  result.cursorYPosi = yPosi

when isMainModule:
  stdout.eraseScreen()
  var win = createWindow(10, 10, 5, 5)
  win = windowWrite(win, "Hello")
