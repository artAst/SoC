Func _timedEvents()
   Local $isRunning = True
   ; Ini file
   Local $sFilePath = "conf\settings.ini"
   ; read ini hotkey section
   Local $aArray = IniReadSection($sFilePath, "events")

   While $isRunning
	  Local $timeNow = _NowTime(4)
	  While _inArrayEvents($aArray, $timeNow) = -1 And $isRunning
	  		Sleep(1000)
	  		$timeNow = _NowTime(4)
	  WEnd

	  ; exited while loop means event occured
	  ; login
	  _loginUser()
	  
	  ; ---- call event function ----
	  Local $idx = _inArrayEvents($aArray, $timeNow)
	  Local $event_name = $aArray[$idx][0]
	  Call($event_name)

	  ; logout
	  _logoutUser()

   WEnd
   return $retVal
EndFunc

Func _inArrayEvents($arr, $val)
   Local $idx = _ArrayBinarySearch($arr, $val, 0, 0, 1)

   If @error Then
	  ConsoleWrite("Value could not be found. " & @error)
	  return -1
   Else
	  return $idx
   EndIf
EndFunc