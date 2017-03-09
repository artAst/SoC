Global $eventsBtn = "images\event_icon.png"
Global $eventsBtnTab2 = "images\event_tab_2.png"
Global $holysquareEvtImage = "images\holysquare_evt.png"
Global $holysquareEvtEnter = "images\holysquare_evt_enter.png"

Func _holy_square_event()
   Local $hsqChances = 6

   While $hsqChances > 0
	   ; find and click Events button
	   _findAndclickNoxImg($eventsBtn)

	   ; find and click Event tab 2 for Holy Square
	   _findAndclickNoxImg($eventsBtnTab2)

	   ; check if holy square event active
	   If _isImageVisible($holysquareEvtImage, 1000) Then
		  ; click holy square event
		  _findAndclickNoxImg($holysquareEvtImage)
		  ; click and enter to the event
		  _findAndclickNoxImg($holysquareEvtEnter)
		  ; battle in holy square
		  If Not _battleDungeon() Then ContinueLoop ; may have faulty instance
		  ; wait for run to finish
		  ; click claim rewards
		  Sleep(20 * 1000)
	   EndIf

	   ; reduce chances
	   $hsqChances -= 1
	WEnd
EndFunc