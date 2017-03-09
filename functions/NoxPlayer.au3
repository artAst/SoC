Func _activateNoxWindow()
   WinActivate("Nox App Player")
EndFunc

Func _clickNox($left, $top, $right, $bottom, $hexcol)
   Sleep( 500 )
   ; find and click
   $location = PixelSearch($left, $top, $right, $bottom, $hexcol)

   If @error = 1 Then
	  $color = PixelGetColor($left+1, $top+1)
	  MsgBox(0, "Error", "Pixel was not found!! Click not executed. [" & Hex($color, 6) & "]")
   ElseIf IsArray ($location) = 1 Then
	  MouseClick ('left', $location[0], $location[1], 1, 0)
	  return True
   EndIf
EndFunc

Func _findAndclickNoxImg($findImage)
   ; variable coords
   Local $x = 0, $y = 0
   Sleep( 500 )
   ; find and click
   If _ImageSearch($findImage, 1, $x, $y, 0) Then
     ; MouseClick ('left', $x, $y, 1, 0) -- revised to hotkey
     _sendImageHotkey($findImage)
     Local $retval[2] = [$x, $y]
     return $retVal
   Else
     ConsoleWrite("Could not find image ["& $findImage &"]. Click not executed" & @CRLF)
	 Exit
     return 0
   EndIf
EndFunc

Func _isImageVisible($findImage, $duration = 0)
   ; define time duration
   Local $timer = TimerInit()
   ; variable coords
   Local $x = 0, $y = 0
   ; find with duration
   Local $img = _ImageSearch($findImage, 1, $x, $y, 0)
   ConsoleWrite($findImage & "IMG:" &$img&@CRLF)
   While Not $img And TimerDiff($timer) < $duration
     ; keep searching
     $img = _ImageSearch($findImage, 1, $x, $y, 0)
	 ConsoleWrite("IMG:" &$img&@CRLF)
  WEnd

   If @error Then return False
   If $img Then
     return True
   Else
     return False
   EndIf
EndFunc

Func _checkNoxPixel($left, $top, $right, $bottom, $hexcol, $delay)
   Sleep( $delay )
   ; find and click
   $location = PixelSearch($left, $top, $right, $bottom, $hexcol)

   If @error = 1 Then
	  return False
   ElseIf IsArray ($location) = 1 Then
	  return True
   EndIf
EndFunc