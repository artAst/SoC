Func _ImageSearch($findImage, $resultPosition, ByRef $x, ByRef $y, $Tolerance)
	Return _ImageSearchArea($findImage, $resultPosition, 0, 0, $res_width, $res_width, $x, $y, $Tolerance)
EndFunc   ;==>_ImageSearch

Func _ImageSearchArea($findImage, $resultPosition, $x1, $y1, $right, $bottom, ByRef $x, ByRef $y, $Tolerance)
	;Global $HBMP = $hHBitmap
	;If $g_bChkBackgroundMode = False Then
	;	$HBMP = 0
	;	$x1 += $g_aiBSpos[0]
	;	$y1 += $g_aiBSpos[1]
	;	$right += $g_aiBSpos[0]
	;	$bottom += $g_aiBSpos[1]
	;EndIf
	;MsgBox(0,"asd","" & $x1 & " " & $y1 & " " & $right & " " & $bottom)

	Local $result
	If IsString($findImage) Then
		If $Tolerance > 0 Then $findImage = "*" & $Tolerance & " " & $findImage
		If $hHBitmap = 0 Then
			$result = DllCall($g_sLibImageSearchPath, "str", "ImageSearch", "int", $x1, "int", $y1, "int", $right, "int", $bottom, "str", $findImage)
		Else
			$result = DllCall($g_sLibImageSearchPath, "str", "ImageSearchEx", "int", $x1, "int", $y1, "int", $right, "int", $bottom, "str", $findImage, "ptr", $HBMP)
		EndIf
	;Else
	;	$result = DllCall($g_sLibImageSearchPath, "str", "ImageSearchExt", "int", $x1, "int", $y1, "int", $right, "int", $bottom, "int", $Tolerance, "ptr", $findImage, "ptr", $HBMP)
	EndIf
	;If @error Then _logErrorDLLCall($g_sLibImageSearchPath, @error)

	; If error exit
	If IsArray($result) Then
		If $result[0] = "0" Then Return 0
	Else
		ConsoleWrite("Error: Image Search not working...")
		Return 1
	EndIf


	; Otherwise get the x,y location of the match and the size of the image to
	; compute the centre of search
	Local $array = StringSplit($result[0], "|")
	If (UBound($array) >= 4) Then
		$x = Int(Number($array[2]))
		$y = Int(Number($array[3]))
		If $resultPosition = 1 Then
			$x = $x + Int(Number($array[4]) / 2)
			$y = $y + Int(Number($array[5]) / 2)
		EndIf
		;If $Hide = False Then
			$x -= $x1
			$y -= $y1
		;EndIf
		Return 1
	EndIf
EndFunc   ;==>_ImageSearchArea

Func _ImageSearchAreaImgLoc($findImage, $resultPosition, $x1, $y1, $right, $bottom, ByRef $x, ByRef $y, $hHBMP = $hHBitmap)

	Local $sArea = Int($x1) & "," & Int($y1) & "|" & Int($right) & "," & Int($y1) & "|" & Int($right) & "," & Int($bottom) & "|" & Int($x1) & "," & Int($bottom)
	Local $MaxReturnPoints = 1

	Local $res = DllCall($g_sLibImgLocPath, "str", "FindTile", "handle", $hHBMP, "str", $findImage,  "str", $sArea, "Int", $MaxReturnPoints)
	;If @error Then _logErrorDLLCall($g_sLibImgLocPath, @error)
	Local $exterr = @extended
	If @error Then ConsoleWrite("Error: " & exterr & @CRLF)
	If IsArray($res) Then
		;If $g_iDebugSetlog = 1 Then SetLog("_ImageSearchAreaImgLoc " & $findImage & " succeeded " & $res[0] & ",$sArea=" & $sArea & ",$ToleranceImgLoc=" & $ToleranceImgLoc , $COLOR_ERROR)
		If $res[0] = "0" Or $res[0] = "" Then
			;SetLog($findImage & " not found", $COLOR_GREEN)
		ElseIf StringLeft($res[0], 2) = "-1" Then
			;SetLog("DLL Error: " & $res[0] & ", " & $findImage, $COLOR_ERROR)
			ConsoleWrite("DLL Error: " & $res[0] & ", " & $findImage & @CRLF)
		Else
			Local $expRet = StringSplit($res[0], "|", $STR_NOCOUNT)
			;$expret contains 2 positions; 0 is the total objects; 1 is the point in X,Y format
			Local $posPoint = StringSplit($expRet[1], ",", $STR_NOCOUNT)
			If UBound($posPoint) >= 2 Then
				$x = Int($posPoint[0])
				$y = Int($posPoint[1])
				If $resultPosition <> 1 Then ; ImgLoc is always centered, convert to upper-left
					Local $sImgInfo = _ImageGetInfo($findImage)
					Local $iTileWidth = _ImageGetParam($sImgInfo, "Width")
					Local $iTileHeight = _ImageGetParam($sImgInfo, "Height")
					$x -= Int(Number($iTileWidth) / 2)
					$y -= Int(Number($iTileHeight) / 2)
				EndIf
				$x -= $x1
				$y -= $y1
				Return 1
			Else
				;SetLog($findImage & " not found: " & $expRet[1], $COLOR_GREEN)
				ConsoleWrite("Error: " & $findImage & " not found: " & $expRet[1] & @CRLF)
			EndIf
		EndIf
	EndIf

	Return 0
EndFunc   ;==>_ImageSearchAreaImgLoc