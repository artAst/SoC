Global $loginEnterBtn = "images\login_enter.png"
Global $loginEnterChar = "images\login_enter_char.png"

Func _loginUser()
   ; find and click enter server
   _findAndclickNoxImg($loginEnterBtn)

   ; wait for character selection screen
   If _isImageVisible($loginEnterChar, 10000) Then
	  ; find and click enter character
	  _findAndclickNoxImg($loginEnterChar)
	  ; get to main screen without pop-up notice
	  While Not _isImageVisible($questScrollBtn)
	  	Sleep(100)
	  WEnd
	  If _isImageVisible($questScrollBtn) Then _sendTapKey("hkey_escape")
   Else
	  ConsoleWrite("Character selection screen not found." & @CRLF)
   EndIf
EndFunc

Func _logoutUser()
   ; tap character button
   _sendTapKey("hkey_character")
   ; tap settings tab
   _sendTapKey("hkey_character_settings")
   ; tap logout
   _sendTapKey("hkey_character_logout")
   ; check if in login screen
   If _isImageVisible($loginEnterBtn, 10000) Then
	  ConsoleWrite("Successfully Logged out." & @CRLF)
	  return True
   Else
	  return False
   EndIf
EndFunc