Global $battleAutoBtn = "images\battle_auto.png"

Func _battleDungeon()
   ; check if already in Dungeon or character still walking to main city
   If Not _checkIfInsideInstance() Then return False


   ; wait for dungeon run to finish
   ; check if dungeon run has finished
   If _isDungeonRunDone() Then
      return True
   Else
      return False
   EndIf
EndFunc

Func _checkIfInsideInstance()
   Local $timer = TimerInit()
   Local $isInside = _isImageVisible($battleAutoBtn)
   While Not $isInside And TimerDiff($timer) < (15 * 1000)
	  Sleep(50)
	  ; send click just in case quest story is present
	  _sendTapKey()
	  $isInside = _isImageVisible($battleAutoBtn)
   WEnd

   If $isInside Then
	  _findAndclickNoxImg($battleAutoBtn)
     return True
   Else
     ConsoleWrite("Request time out for auto battle. Could not find instance." & @CRLF)
     return False
   EndIf
EndFunc

Func _isDungeonRunDone()
   While _isImageVisible($battleAutoBtn)
	  Sleep(2000)
   WEnd

   return True

   ; possible that char is dead
   ; return False
EndFunc