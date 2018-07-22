#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <ScrollBarConstants.au3>
#include <GuiRichEdit.au3>
#include <WinAPI.au3>
#include <Date.au3>
#include <GuiEdit.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

; Load Ini File
; #############################################################################################
;
; Create Settings.ini if it don't Exist
;
if not FileExists(@ScriptDir & "\Settings.ini") Then
	; Hotkeys
	IniWrite(@ScriptDir & "\Settings.ini","HotKeys","Start","{F5}")
	IniWrite(@ScriptDir & "\Settings.ini","HotKeys","Pause","{F6}")
	IniWrite(@ScriptDir & "\Settings.ini","HotKeys","Stop","{F7}")

	; Bot Settings
	IniWrite(@ScriptDir & "\Settings.ini","Bot Settings","Alert_Music","0")
	IniWrite(@ScriptDir & "\Settings.ini","Bot Settings","Avoid_Disconnect","0")
	IniWrite(@ScriptDir & "\Settings.ini","Bot Settings","Simulate_Human_Walking","0")
	IniWrite(@ScriptDir & "\Settings.ini","Bot Settings","Set_Game_Focus","0")
	IniWrite(@ScriptDir & "\Settings.ini","Bot Settings","Auto_Relog","0")
	IniWrite(@ScriptDir & "\Settings.ini","Bot Settings","Save_Encounters_TXT","0")
	IniWrite(@ScriptDir & "\Settings.ini","Bot Settings","Bot_Mode","1")
	IniWrite(@ScriptDir & "\Settings.ini","Bot Settings","Encounter","0")
EndIf
;
; Read Settings.ini and Set Checkboxes/Radio
;
; HotKeys
;
$StartKey = IniRead(@ScriptDir & "\Settings.ini","HotKeys","Start","{F5}")
$PauseKey = IniRead(@ScriptDir & "\Settings.ini","HotKeys","Pause","{F6}")
$StopKey = IniRead(@ScriptDir & "\Settings.ini","HotKeys","Stop","{F7}")

; Settings

$Alert_Music = IniRead(@ScriptDir & "\Settings.ini","Bot Settings","Alert_Music","0")
$Avoid_Disconnect = IniRead(@ScriptDir & "\Settings.ini","Bot Settings","Avoid_Disconnect","0")
$Simulate_Human_Walking = IniRead(@ScriptDir & "\Settings.ini","Bot Settings","Simulate_Human_Walking","0")
$Set_Game_Focus = IniRead(@ScriptDir & "\Settings.ini","Bot Settings","Set_Game_Focus","0")
$Auto_Relog = IniRead(@ScriptDir & "\Settings.ini","Bot Settings","Auto_Relog","0")
$Save_Encounters_TXT = IniRead(@ScriptDir & "\Settings.ini","Bot Settings","Save_Encounters_TXT","0")
$Bot_Mode = IniRead(@ScriptDir & "\Settings.ini","Bot Settings","Bot_Mode","1")
$Encounter = IniRead(@ScriptDir & "\Settings.ini","Bot Settings","Encounters","0")

; #############################################################################################


Global $Paused


#Region ### START Koda GUI section ### Form=C:\Users\Chris\Desktop\Form1.kxf
$Form1 = GUICreate("Simple Bot for PokeOne v1.1.2", 583, 288, 233, 142)
$Group1 = GUICtrlCreateGroup("Bot Log:", 8, 0, 185, 281)
$Edit1 = GUICtrlCreateEdit("", 16, 16, 169, 257)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("Status", 200, 0, 177, 97)
$Label1 = GUICtrlCreateLabel("Current State", 208, 24, 66, 17)
$Label2 = GUICtrlCreateLabel("Bot not running", 288, 24, 76, 17)
$Label3 = GUICtrlCreateLabel("Start Time:", 208, 48, 55, 17)
$Label4 = GUICtrlCreateLabel("n/A", 288, 48, 78, 17)
$Label5 = GUICtrlCreateLabel("End Time:", 208, 72, 52, 17)
$Label6 = GUICtrlCreateLabel("n/A", 288, 72, 78, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("Bot Settings:", 384, 0, 193, 169)
$Checkbox1 = GUICtrlCreateCheckbox("Alert when Shiny Found Music", 392, 24, 177, 17)
$Checkbox2 = GUICtrlCreateCheckbox("Avoid Disconnecting after Found", 392, 48, 177, 17)
$Checkbox3 = GUICtrlCreateCheckbox("Simulate Human-Like Walking", 392, 72, 177, 17)
$Checkbox4 = GUICtrlCreateCheckbox("Set Game on Focus", 392, 96, 177, 17)
$Checkbox5 = GUICtrlCreateCheckbox("Save Encounters in Text File", 392, 144, 177, 17)
$Checkbox6 = GUICtrlCreateCheckbox("Auto Relogging", 392, 120, 177, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup("Shiny Hunt Log:", 200, 96, 177, 73)
$Label7 = GUICtrlCreateLabel("Encounters: ", 208, 120, 64, 17)
$Label8 = GUICtrlCreateLabel("n/A", 312, 120, 54, 17)
$Label9 = GUICtrlCreateLabel("Latest Encounters: ", 208, 144, 96, 17)
$Label10 = GUICtrlCreateLabel("n/A", 312, 144, 54, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("Start", 200, 256, 379, 25)
$Group6 = GUICtrlCreateGroup("Level Bot Log", 200, 168, 177, 81)
$Label11 = GUICtrlCreateLabel("Encounters: ", 208, 192, 64, 17)
$Label12 = GUICtrlCreateLabel("n/A", 312, 192, 54, 17)
$Label13 = GUICtrlCreateLabel("Pokemon Fainted: ", 208, 216, 93, 17)
$Label14 = GUICtrlCreateLabel("n/A", 312, 216, 22, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group5 = GUICtrlCreateGroup("Bot Mode Settings", 384, 168, 193, 81)
$Radio1 = GUICtrlCreateRadio("Shiny Hunt Bot", 392, 192, 113, 17)
$Radio2 = GUICtrlCreateRadio("Level Bot (not completly finished)", 392, 216, 177, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

; Apply Settings
;
GUICtrlSetState($Checkbox1,$Alert_Music)
GUICtrlSetState($Checkbox2,$Avoid_Disconnect)
GUICtrlSetState($Checkbox3,$Simulate_Human_Walking)
GUICtrlSetState($Checkbox4,$Set_Game_Focus)
GUICtrlSetState($Checkbox5,$Save_Encounters_TXT)
GUICtrlSetState($Checkbox6,$Auto_Relog)

if $Bot_Mode = 1 Then
GUICtrlSetState($Radio1,$Bot_Mode)
Else
GUICtrlSetState($Radio2,$Bot_Mode)
EndIf
;
; Apply Hotkeys

HotKeySet($StartKey, "_go")
HotKeySet($PauseKey, "_pause")
HotKeySet($StopKey, "_stop")


If WinExists("PokeOne") Then
	$c = WinGetClientSize("PokeOne")
Else
	MsgBox(48, "Error", "PokeOne isn't open!" & @CRLF & @CRLF & "Exit.")
	Exit
EndIf




While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			_Save_Settings()
			Exit
		case $Button1
			_go()
	EndSwitch
WEnd

func _go()
	$Startime = _NowTime()
	GUICtrlSetData($Label4,$Startime)
	GUICtrlSetData($Button1,"Bot is Running! ( Press " & $PauseKey & ") to Stop.)")
	GUICtrlSetState($Button1,$GUI_DISABLE)
	$Paused = true
	$i = 1
	Do
	UpdateLog($i)

	$i = $i +1
	Sleep(150)
	Until $Paused = False
	$Paused = False
EndFunc


Func Overworld()
	$rnd = Random(0, 1, 1)

	Test_Logout()
	If $rnd = 0 Then
		Send("{LEFT DOWN}")
		Sleep(700)
		Send("{LEFT UP}")
		Sleep(10)
		Send("{RIGHT DOWN}")
		Sleep(700)
		Send("{RIGHT UP}")
	ElseIf $rnd = 1 Then
		Send("{RIGHT DOWN}")
		Sleep(700)
		Send("{RIGHT UP}")
		Sleep(10)
		Send("{LEFT DOWN}")
		Sleep(700)
		Send("{LEFT UP}")

	EndIf
EndFunc   ;==>Overworld


Func _switch_mode()
	If $Bot_Mode = 1 Then
		$Bot_Mode = 2
		UpdateLog("Level Mode activated")
	ElseIf $Bot_Mode = 2 Then
		$Bot_Mode = 1
		UpdateLog("Shiny Hunt Mode activated")
	EndIf

EndFunc   ;==>_switch_mode


Func Battle($X, $Y)
	Sleep(1000)
	$ClientPos = WinGetPos("PokeOne", "")
	$ClientPos[1] = $ClientPos[1] + "30"

	$OldMousePos = MouseGetPos()
	$Move1Empty = False
	$Move2Empty = False
	$Move3Empty = False
	$Move4Empty = False
	$MovesRandom = 0
	Sleep(100)
	MouseClick("LEFT", $X, $Y)
	Sleep(500)
	UpdateLog("Checking Moves...")

	$Move1 = PixelSearch($ClientPos[0] + "237", $ClientPos[1] + "430", $ClientPos[0] + "370", $ClientPos[1] + "451", 0x797979, 3)
	If IsArray($Move1) Then
		$Move1Empty = True
		UpdateLog("Move1 has no AP left, skipping Move!")
	Else
		$Move1Empty = False
	EndIf

	$Move2 = PixelSearch($ClientPos[0] + "426", $ClientPos[1] + "430", $ClientPos[0] + "570", $ClientPos[1] + "451", 0x797979, 3)
	If IsArray($Move2) Then
		$Move2Empty = True
		UpdateLog("Move2 has no AP left, skipping Move!")
	Else
		$Move2Empty = False
	EndIf

	$Move3 = PixelSearch($ClientPos[0] + "235", $ClientPos[1] + "500", $ClientPos[0] + "370", $ClientPos[1] + "524", 0x797979, 3)
	If IsArray($Move3) Then
		$Move3Empty = True
		UpdateLog("Move3 has no AP left, skipping Move!")
	Else
		$Move3Empty = False
	EndIf

	$Move4 = PixelSearch($ClientPos[0] + "441", $ClientPos[1] + "500", $ClientPos[0] + "570", $ClientPos[1] + "520", 0x797979, 3)
	If IsArray($Move4) Then
		$Move4Empty = True
		UpdateLog("Move4 has no AP left, skipping Move!")
	Else
		$Move4Empty = False
	EndIf

	If $Move1Empty = False Then
		$MovesRandom = $MovesRandom + 1
	EndIf

	If $Move2Empty = False Then
		$MovesRandom = $MovesRandom + 1
	EndIf

	If $Move3Empty = False Then
		$MovesRandom = $MovesRandom + 1
	EndIf


	If $Move4Empty = False Then
		$MovesRandom = $MovesRandom + 1
	EndIf


	If $Move1Empty = False Then
		UpdateLog("Move1 Selected!")
		MouseClick("LEFT", $ClientPos[0] + "367", $ClientPos[1] + "459", 1)
	ElseIf $Move2Empty = False Then
		UpdateLog("Move2 Selected!")
		MouseClick("LEFT", $ClientPos[0] + "429", $ClientPos[1] + "432")
	ElseIf $Move3Empty = False Then
		UpdateLog("Move3 Selected!")
		MouseClick("LEFT", $ClientPos[0] + "235", $ClientPos[1] + "498")
	ElseIf $Move4Empty = False Then
		UpdateLog("Move4 Selected!")
		MouseClick("LEFT", $ClientPos[0] + "441", $ClientPos[1] + "501")
	Else
		UpdateLog("All Moves are Empty! Changing Pokemon")
		MouseClick("LEFT", $ClientPos[0] + "277", $ClientPos[1] + "568")
		Sleep(5000)
	EndIf

	MouseMove($OldMousePos[0], $OldMousePos[1])

EndFunc   ;==>Battle

Func Battles($X, $Y)
	Test_Logout()

	$ClientPos = WinGetPos("PokeOne", "")
	$ClientPos[1] = $ClientPos[1] + "30"
	$ShinyColor = 0xFFF200

	$OldMousePos = MouseGetPos()

	;MouseMove($ClientPos[0] + 15,$ClientPos[1] + 5)
	;Sleep(100)
	;MouseMove($ClientPos[0] + 88,$ClientPos[1] + 152)
	Sleep(1000)

	$Shiny = PixelSearch($ClientPos[0] + "15", $ClientPos[1] + "5", $ClientPos[0] + "88", $ClientPos[1] + "152", 0xFFF200, 125)
	If IsArray($Shiny) Then
		MouseMove($Shiny[0], $Shiny[1])
		UpdateLog("Shiny found after " & $Encounter & " Encounters, Bot paused!")
		;MsgBox(48,"SHINY FOUND","SHINY DETECTED! Encounters: " & $Encounter & ",  Paused Bot!")
		ShinyFound()

	Else
		$Encounter = $Encounter + "1"
		UpdateLog("Encounter: " & $Encounter & ", No Shiny, Flee...")
		FileDelete(@DesktopDir & "\Encounter.txt")
		FileWrite(@DesktopDir & "\Encounter.txt", $Encounter)
		MouseClick("LEFT", $ClientPos[0] + "520", $ClientPos[1] + "581", 5, 1000)
		;MouseMove($OldMousePos[0] ,$OldMousePos[1])
		Sleep(500)
	EndIf
EndFunc   ;==>Battles



Func PokemonFainted()

	$ClientPos = WinGetPos("PokeOne", "")
	$ClientPos[1] = $ClientPos[1] + "30"

	$Pokemon1 = PixelSearch($ClientPos[0] + "325", $ClientPos[1] + "168", $ClientPos[0] + "427", $ClientPos[1] + "204", 0x626262, 1)
	If IsArray($Pokemon1) Then
		UpdateLog("Pokemon on Slot 1 is already Fainted, skiping.!")
	Else
		UpdateLog("Pokemon on Slot 1 will save us!!")
		MouseClick("LEFT", $ClientPos[0] + "325", $ClientPos[1] + "168")
		Return
	EndIf

	$Pokemon2 = PixelSearch($ClientPos[0] + "325", $ClientPos[1] + "223", $ClientPos[0] + "476", $ClientPos[1] + "254", 0x626262, 1)
	If IsArray($Pokemon2) Then
		UpdateLog("Pokemon on Slot 2 is already Fainted, skiping.!")
	Else
		UpdateLog("Pokemon on Slot 2 will save us!!")
		MouseClick("LEFT", $ClientPos[0] + "325", $ClientPos[1] + "223")
		Return
	EndIf

	$Pokemon3 = PixelSearch($ClientPos[0] + "325", $ClientPos[1] + "269", $ClientPos[0] + "473", $ClientPos[1] + "305", 0x626262, 1)
	If IsArray($Pokemon3) Then
		UpdateLog("Pokemon on Slot 3 is already Fainted, skiping.!")
	Else
		UpdateLog("Pokemon on Slot 3 will save us!!")
		MouseClick("LEFT", $ClientPos[0] + "325", $ClientPos[1] + "269")
		Return
	EndIf


	$Pokemon4 = PixelSearch($ClientPos[0] + "325", $ClientPos[1] + "321", $ClientPos[0] + "474", $ClientPos[1] + "352", 0x626262, 1)
	If IsArray($Pokemon4) Then
		UpdateLog("Pokemon on Slot 4 is already Fainted, skiping.!")
	Else
		UpdateLog("Pokemon on Slot 4 will save us!!")
		MouseClick("LEFT", $ClientPos[0] + "325", $ClientPos[1] + "321")
		Return
	EndIf

	Sleep(2500)

EndFunc   ;==>PokemonFainted


Func Test_Logout()
	$ClientPos = WinGetPos("PokeOne", "")
	$ClientPos[1] = $ClientPos[1] + "30"
	$OldMousePos = MouseGetPos()
	$Logout = PixelSearch($ClientPos[0] + 657, $ClientPos[1] + 568, $ClientPos[0] + 788, $ClientPos[1] + 580, 0x5C1223, 3)
	If IsArray($Logout) Then
		UpdateLog("PokeOne Lost Connection! Relogging...")
		MouseClick("LEFT", $ClientPos[0] + "422", $ClientPos[1] + "398", 5)
		MouseMove($OldMousePos[0], $OldMousePos[1])
		Sleep(5000)
	Else
		Return
	EndIf

EndFunc   ;==>Test_Logout



; Shiny Found Method
; Loop every 30 Seconds:
; Key Presses and a Trainer Pass Open/Close via Mouse Click,
; to avoid Auto Disconnecting.
; Play a Sound File to Alert.
; Test if Connection Lost and try to Relog.
Func ShinyFound()
	Do
		$ClientPos = WinGetPos("PokeOne", "")
		$ClientPos[1] = $ClientPos[1] + "30"
		Test_Logout()
		Send("{LEFT}")
		Sleep(1000)
		Send("{Right}")
		Sleep(1000)
		MouseClick("LEFT", $ClientPos[0] + "623", $ClientPos[1] + "16",1)
		Sleep(1000)
		MouseClick("LEFT", $ClientPos[0] + "623", $ClientPos[1] + "16",1)
		Sleep(1000)
		MouseClick("LEFT", $ClientPos[0] + "260", $ClientPos[1] + "567",1)
		Sleep(1000)
		MouseClick("LEFT", $ClientPos[0] + "260", $ClientPos[1] + "567",1)
		;SoundPlay(@TempDir & "\Shiny.mp3")
		Sleep(30000)
	Until $Paused = False
	$Paused = False
EndFunc   ;==>ShinyFound

func _pause()
	GUICtrlSetData($Button1,"Start")
	GUICtrlSetState($Button1,$GUI_ENABLE)
$Paused = False
EndFunc

func _stop()
Exit
EndFunc

Func UpdateLog($Text)
	$Time = _NowTime()
	$CurrentTime = "[" & $Time & "]: "

	GUICtrlSetData($Edit1, GUICtrlRead($Edit1) & @CRLF & $CurrentTime & $Text)
	GUICtrlSendMsg($Edit1, $EM_LINESCROLL, 0, GUICtrlSendMsg($Edit1, $EM_GETLINECOUNT, 0, 0))
	_GUICtrlRichEdit_ScrollToCaret($Edit1)
EndFunc   ;==>UpdateLog

func _Save_Settings()
		IniWrite(@ScriptDir & "\Settings.ini","Bot Settings",$Alert_Music,"0")
	IniWrite(@ScriptDir & "\Settings.ini","Bot Settings",$Avoid_Disconnect,"0")
	IniWrite(@ScriptDir & "\Settings.ini","Bot Settings",$Simulate_Human_Walking,"0")
	IniWrite(@ScriptDir & "\Settings.ini","Bot Settings",$Set_Game_Focus,"0")
	IniWrite(@ScriptDir & "\Settings.ini","Bot Settings",$Auto_Relog,"0")
	IniWrite(@ScriptDir & "\Settings.ini","Bot Settings",$Save_Encounters_TXT,"0")
	IniWrite(@ScriptDir & "\Settings.ini","Bot Settings",$Bot_Mode,"1")
	IniWrite(@ScriptDir & "\Settings.ini","Bot Settings",$Encounter,"0")
EndFunc
