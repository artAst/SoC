#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>
#include <Date.au3>
#include <File.au3>
#include "IncludeScripts.au3"
#Region ### START Koda GUI section ### Form=C:\Users\Astillero\Downloads\koda_1.7.3.0\Forms\BotWin.kxf
$BotWin = GUICreate("CroppBot", 343, 128, 299, 180)
$StartButtn = GUICtrlCreateButton("Start Quest", 10, 8, 75, 25)
$HSQBtn = GUICtrlCreateButton("Start HSQ", 10, 35, 75, 25)
$WSBtn = GUICtrlCreateButton("Start WS", 10, 62, 75, 25)
$IdolBtn = GUICtrlCreateButton("Activate False Idol", 10, 89, 95, 25)
$Logs = GUICtrlCreateEdit("", 112, 8, 217, 105)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Global $quest_x_btns[3] = [897, 897, 897]
Global $quest_y_btns[3] = [231, 394, 563]
Global $claim_pixel = 0xCFB48C
Global $go_now_pixel = 0xDEC6A5
Global $res_width = 1920
Global $res_height = 1080

Global $g_sLibImageSearchPath = "lib\ImageSearchDLL.dll"
Global $g_sImagePath = "images\"
Global $g_sProfileTempDebugPath = "log\"
;Global $g_sLibImgLocPath = "lib\MyBotRunImgLoc.dll"
;Global $g_hLibImgLoc = DllOpen($g_sLibImgLocPath)

Global $hHBitmap2 = 0
Global $g_hHBitmapTest = 0
Global $hHBitmap = 0

HotKeySet("{f2}", exitBot)

_initializeKeys()

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
	  Case $GUI_EVENT_CLOSE
		 Exit
	  Case $StartButtn
		 _activateNoxWindow()
		 _dungeonQuest()
	  Case $HSQBtn
		 _activateNoxWindow()
		 _findAndclickNoxImg($questClaimBtn)
		 ;DebugImageSave()
	  Case $WSBtn
		 testImgSearch()
		 ;testTimer()
	EndSwitch
WEnd

Func exitBot()
   Exit
EndFunc

Func testTimer()
   Local $timedMsg = '14:34'
   Local $now = _NowTime(4)

   While $timedMsg <> $now
   		ConsoleWrite($timedMsg & " = " & $now & @CRLF)
   		Sleep(1000)
   		$now = _NowTime(4)
   WEnd

   If $timedMsg = $now Then
   		MsgBox(0, "Alert", "Times up!")
   Else
   		ConsoleWrite("not equal")
   EndIf
EndFunc

Func testImgSearch()
   ConsoleWrite("WIDTH and HEIGHT before dll call: " & @DesktopWidth & "," & @DesktopHeight & @CRLF)
   If @OSVersion="WIN_10" Then
       Local $retval = DllCall("Shcore.dll","long","PROCESS_DPI_AWARENESS",1)
       ConsoleWrite("Returned: " & $retVal)
   Else
       DllCall("User32.dll","bool","SetProcessDPIAware")
   EndIf

   Local $x = 0, $y = 0
   ConsoleWrite(@OSBuild & @CRLF)
   ConsoleWrite(@DesktopWidth & "," & @DesktopHeight & @CRLF)

   Local $search = _ImageSearch("images\tst.png", 1, $x, $y, 0)
   If $search = 1 Then
     ConsoleWrite($x & "," & $y & @CRLF)
     MouseMove($x, $y, 0)
   Else
     ConsoleWrite("Could not find image." & @CRLF)
   EndIf
EndFunc