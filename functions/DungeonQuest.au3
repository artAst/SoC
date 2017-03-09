Global $questScrollBtn = "images\quest_scroll.png"
Global $questGoNowBtn = "images\quest_go_now.png"
Global $questNpcIcon = "images\quest_npc_icon.png"
Global $questClaimBtn = "images\quest_claim.png"
Global $questEnterDungeonBtn = "images\quest_enter_dungeon.png"

Func _dungeonQuest()
   Local $isRunning = True
   Local $i = 0
   ; start quest
   MsgBox(0, "Alert", "Started Dungeon quest!")

   While $isRunning
	  ; variables for 'Go now' button
	  Local $x = $quest_x_btns[$i]
	  Local $y = $quest_y_btns[$i]

	  ; find and click quest button
	  _findAndclickNoxImg($questScrollBtn)

	  ; find and click Quest "Go now" button"
	  _findAndclickNoxImg($questGoNowBtn)

	  ; check Quest if Requirements met (Check Quest Success)
	  ; checkLevelReqFailed() -- needs rework

	  ; check if Deputy Captain
	  If checkIfDeputyCap() Then
		 ; claim rewards button
		 claimQuestRewards()
	  Else
		 ; find and click enter dungeon
		 If _isImageVisible($questEnterDungeonBtn, 10000) Then
			; find and click Enter dungeon
			_findAndclickNoxImg($questEnterDungeonBtn)

			; Dungeon Battle
			If Not _battleDungeon() Then ContinueLoop

			; Dungeon run done
			ConsoleWrite("Dungeon will exit in 30 secs" & @CRLF)
			; find and click cards
			; find and click exit button
			; wait and check if successfully exit dungeon
			Sleep(30 * 1000)

			; claim rewards button
			claimQuestRewards()
		 Else
			ConsoleWrite("Error: Dungeon quest cannot proceed! Enter button not found after 10 secs." & @CRLF)
			Exit
			$i = $i + 1
		 EndIf
	  EndIf

	  ; sleep and repeat process
	  Sleep(500)
   WEnd
EndFunc

Func findEnterDungeonButton()
   ; define time duration to check if button appeared
   Local $timer = TimerInit()
   Local $retVal = _checkNoxPixel(937, 584, 939, 586, 0x0E1F37, 0)
   While Not $retVal And TimerDiff($timer) < (10 * 1000)
	  Sleep(100)
	  $retVal = _checkNoxPixel(937, 584, 939, 586, 0x0E1F37, 0)
   WEnd
   return $retVal
EndFunc

Func claimQuestRewards()
   ; find and click claim button
   While Not _isImageVisible($questClaimBtn)
	  ; click claim button
	  $coords = _findAndclickNoxImg($questClaimBtn)
	  Sleep(100)
	  ; click more to nullify reward window
	  ; MouseClick("left", $coords[0], $coords[1], 1, 0) -- revised to hotkey
	  _sendTapKey()
	  Sleep(500)
   WEnd
EndFunc

Func checkIfDeputyCap()
   ; sleep 5 secs for walking to deputy captain
   If _isImageVisible($questNpcIcon, 5000) Then
	  ConsoleWrite("Deputy captain quest reward!" & @CRLF);
	  Local $t2 = TimerInit()
	  ; click next
	  Local $coords = _findAndclickNoxImg($questNpcIcon)
	  While TimerDiff($t2) < 2000
		 Sleep(10)
		 ; MouseClick("left", $coords[0], $coords[1], 1, 0) -- revised to hotkey
		 _sendTapKey()
	  WEnd

	  return True
   Else
	  ; proceed to next execution
	  ConsoleWrite("Debug: Quest not deputy captain" & @CRLF)
	  return False
   EndIf
EndFunc

Func checkLevelReqFailed()
   ; define time duration
   Local $timer = TimerInit()
   While Not levelReqPixelCheck() And TimerDiff($timer) < (3 * 1000)
	  Sleep(1)
   WEnd
   MsgBox(0, "Alert", "Requirements met!!")
EndFunc

Func levelReqPixelCheck()
   Local $search = _checkNoxPixel(714, 271, 716, 273, 0xF0F0F0, 0)
   MouseMove(715, 272)
   If $search = True Then
	  MsgBox(0, "Alert", "Requirements not met!!")
	  return True
   Else
	  $pixelCol = PixelGetColor(715, 272)
	  $content = GUICtrlRead($Logs)
	  GUICtrlSetData($Logs, $content & @CRLF & Hex($pixelCol, 6) & ",")
	  return False
   EndIf
EndFunc