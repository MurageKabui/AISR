#include-once
#include <AutoItConstants.au3>

Const $SNORETOASTPATH = @tempdir & "\SnoreToast.exe" ; Where to extract SnoreToast if it doesnt exist.

; Return codes..
Const Enum _
    $TOAST_SUCCEEDED, _        ; Notification shown successfully.
    $TOAST_FAILED, _           ; Notification failed.
    $TOAST_HIDDEN, _           ; Notification has been hidden.
    $TOAST_DISMISSED, _        ; Notification was dismissed.
    $TOAST_TIMED_OUT, _        ; The Notification timed out.
    $TOAST_BUTTON_PRESSED, _   ; A Button was pressed.
    $TOAST_TEXT_ENTERED        ; Text entered.