Func _initializeKeys()
   ; Ini file
   Local $sFilePath = "conf\settings.ini"
   ; read ini hotkey section
   Local $aArray = IniReadSection($sFilePath, "hotkeys")
   If Not @error Then
      ; Assign btn vars to keys
      For $i = 1 To $aArray[0][0]
         Assign($aArray[$i][0], $aArray[$i][1], 2)
      Next
   EndIf
EndFunc

Func _sendImageHotkey($findImage)
   Local $sDrive = "", $sDir = "", $sFileName = "", $sExtension = ""
   Sleep( 500 )
   ; split find image to get filename
   _PathSplit($findImage, $sDrive, $sDir, $sFileName, $sExtension)
   If $sFileName = "" Then
	  ConsoleWrite("Error: File not found!! Click not executed.")
     return False
   Else
	  Local $sEvalString = Eval("hkey_" & $sFileName)
      If $sEvalString <> "" Then Send($sEvalString)
	  return True
   EndIf
EndFunc

Func _sendTapKey($hotkey_val = "hkey_tap_clear")
   ; Tap quest or clear screen rewards
   Local $sEvalString = Eval($hotkey_val)
   Send($sEvalString)
EndFunc