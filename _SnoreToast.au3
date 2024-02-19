#include-once

; =========================================================
; Title ...............: _OCRSpace_UDF.au3
; Author ..............: Kabue Murage
; AutoIt Version ......: 3.3.14.5
; UDF Version .........: v1.3
; OCRSpace API Version : V3.50
; Language ............: English
; Description .........: Convert image to text using the OCRSpace API version 3.50
; Forums ..............: Mr.Km
; Contact .............: dennisk at zainahtech dot com
; Remarks .............: To view all documentation go to https://ocr.space/OCRAPI
; Resources ...........: https://ocr.space/OCRAPI
; =========================================================
; Snoretify
#include "_SnoreToastConstants.au3"

; _SnoreToast_SetOptions()
; _SnoreToast_ShowNotification()

Func SnoreToast_ShowNotification($title, $message, $options = "")
	Local $snoreToastPath = "F:\Autoit Cool\UDFs\SnoreToast-UDF\.dependencies\snoreToast\SnoreToast.exe"     ; Replace with the actual path to SnoreToast.exe
	Local $command = '"' & $snoreToastPath & '" -t "' & $title & '" -m "' & $message & '" ' & $options

	; Run the SnoreToast command
	Local $result = Run(@ComSpec & " /c " & $command, @SystemDir, @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)

	; Wait for the process to finish and get the exit code

	While ProcessExists($result)
		Sleep(1000)
	WEnd
	Local $exitCode = @extended

	Return $exitCode
EndFunc   ;==>SnoreToast_ShowNotification

; Example usage:
Local $title = "Notification Title"
Local $message = "This is a sample notification message."
Local $options = "-d short -s ms-winsoundevent:Notification.Default"

; Show the notification
Local $exitCode = SnoreToast_ShowNotification($title, $message, $options)

; Check the exit code
Switch $exitCode
	Case 0
		ConsoleWrite("Notification shown successfully." & @CRLF)
	Case 1
		ConsoleWrite("Notification hidden." & @CRLF)
	Case 2
		ConsoleWrite("Notification dismissed." & @CRLF)
	Case 3
		ConsoleWrite("Notification timed out." & @CRLF)
	Case 4
		ConsoleWrite("Button pressed." & @CRLF)
	Case 5
		ConsoleWrite("Text entered." & @CRLF)
	Case Else
		ConsoleWrite("Notification failed with exit code: " & $exitCode & @CRLF)
EndSwitch
