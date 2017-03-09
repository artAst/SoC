
; #FUNCTION# ====================================================================================================================
; Name ..........: DebugImageSave
; Description ...: Saves a copy of the current BS image to the Temp Folder for later review
; Syntax ........: DebugImageSave([$TxtName = "Unknown"])
; Parameters ....: $TxtName             - [optional] text string to use as part of saved filename. Default is "Unknown".
; Return values .: None
; Author ........: KnowJack (Aug 2015)
; Modified ......: Sardo (2016-01)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func DebugImageSave($TxtName = "Unknown", $capturenew = True, $extensionpng = "png", $makesubfolder = True)

	; Debug Code to save images before zapping for later review, time stamped to align with logfile!
	;SetLog("Taking snapshot for later review", $COLOR_SUCCESS) ;Debug purposes only :)
	Local $Date = @MDAY & "-" & @MON & "-" & @YEAR
	Local $Time = @HOUR & "." & @MIN & "." & @SEC
	Local $savefolder = $g_sProfileTempDebugPath
	If $makesubfolder = True Then
		$savefolder = $g_sProfileTempDebugPath & $TxtName & "\"
		DirCreate($savefolder)
	EndIf

	Local $extension
	If $extensionpng = "png" then
		$extension = "png"
	Else
		$extension = "jpg"
	EndIf

	Local $exist = true
	local $i = 1
	Local $first = True
	Local $filename = ""
	While $exist
		If $first Then
			$first = False
			$filename = $savefolder & $TxtName & $Date & "_" & $Time & "." & $extension
			If FileExists($filename) = 1 Then
				$exist = True
			Else
				$exist = False

			EndIf
		Else
			$filename = $savefolder & $TxtName & $Date & "_" & $Time & " (" & $i & ")." & $extension
			If FileExists($filename) = 1 Then
				$i +=1
			Else
				$exist = False
			EndIf
		EndIf
	WEnd

	If $capturenew Then _CaptureRegion2()
    _GDIPlus_Startup()
	Local $EditedImage = _GDIPlus_BitmapCreateFromHBITMAP($hHBitmap2)
	ConsoleWrite("filename: " & $filename & @CRLF)
	_GDIPlus_ImageSaveToFile($EditedImage, $filename)
	If @error Then
	   ConsoleWrite("Error: Cannot save image. ")
    EndIf
	_GDIPlus_BitmapDispose($EditedImage)
	_GDIPlus_Shutdown()

	;If $g_iDebugSetlog = 1 Then Setlog($filename, $COLOR_DEBUG)

	If Sleep(200) Then Return

EndFunc   ;==>DebugImageSave

Func DebugImageFindWithSource($TxtName = "Unknown", $capturenew = True, $extensionpng = "png", $makesubfolder = True)

	; Debug Code to save images before zapping for later review, time stamped to align with logfile!
	If $extensionpng = "png" then
		$extension = "png"
	Else
		$extension = "jpg"
	EndIf

EndFunc   ;==>DebugImageFindWithSource