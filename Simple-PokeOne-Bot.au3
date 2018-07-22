#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
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
If Not FileExists(@ScriptDir & "\Settings.ini") Then
	; Hotkeys
	IniWrite(@ScriptDir & "\Settings.ini", "HotKeys", "Start", "{F5}")
	IniWrite(@ScriptDir & "\Settings.ini", "HotKeys", "Pause", "{F6}")
	IniWrite(@ScriptDir & "\Settings.ini", "HotKeys", "Stop", "{F7}")

	; Bot Settings
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Alert_Music", "0")
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Avoid_Disconnect", "0")
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Simulate_Human_Walking", "0")
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Set_Game_Focus", "0")
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Auto_Relog", "0")
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Save_Encounters_TXT", "0")
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Bot_Mode", "1")
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Encounter", "0")
EndIf
;
; Read Settings.ini and Set Checkboxes/Radio
;
; HotKeys
;
$StartKey = IniRead(@ScriptDir & "\Settings.ini", "HotKeys", "Start", "{F5}")
$PauseKey = IniRead(@ScriptDir & "\Settings.ini", "HotKeys", "Pause", "{F6}")
$StopKey = IniRead(@ScriptDir & "\Settings.ini", "HotKeys", "Stop", "{F7}")

; Settings

$Alert_Music = IniRead(@ScriptDir & "\Settings.ini", "Bot Settings", "Alert_Music", "0")
$Avoid_Disconnect = IniRead(@ScriptDir & "\Settings.ini", "Bot Settings", "Avoid_Disconnect", "0")
$Simulate_Human_Walking = IniRead(@ScriptDir & "\Settings.ini", "Bot Settings", "Simulate_Human_Walking", "0")
$Set_Game_Focus = IniRead(@ScriptDir & "\Settings.ini", "Bot Settings", "Set_Game_Focus", "0")
$Auto_Relog = IniRead(@ScriptDir & "\Settings.ini", "Bot Settings", "Auto_Relog", "0")
$Save_Encounters_TXT = IniRead(@ScriptDir & "\Settings.ini", "Bot Settings", "Save_Encounters_TXT", "0")
$Bot_Mode = IniRead(@ScriptDir & "\Settings.ini", "Bot Settings", "Bot_Mode", "1")
$Encounter = IniRead(@ScriptDir & "\Settings.ini", "Bot Settings", "Encounters", "0")

$PokemonFainted = 0
; #############################################################################################


Global $Paused

#Region ### START Koda GUI section ### Form=c:\users\chris\documents\github\simple-pokeone-bot\gui\form1.kxf
$Form1_1 = GUICreate("Simple Bot for PokeOne v1.1.2", 678, 288, 233, 142)
$Group1 = GUICtrlCreateGroup("Bot Log:", 8, 0, 281, 281)
$Edit1 = GUICtrlCreateEdit("", 16, 16, 265, 257)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("Status", 296, 0, 177, 97)
$Label1 = GUICtrlCreateLabel("Current State", 304, 24, 66, 27)
$Label2 = GUICtrlCreateLabel("Bot not running", 384, 24, 76, 27)
$Label3 = GUICtrlCreateLabel("Start Time:", 304, 48, 55, 37)
$Label4 = GUICtrlCreateLabel("n/A", 384, 48, 42, 47)
$Label5 = GUICtrlCreateLabel("End Time:", 304, 72, 52, 27)
$Label6 = GUICtrlCreateLabel("n/A", 384, 72, 42, 27)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("Bot Settings:", 480, 0, 193, 169)
$Checkbox1 = GUICtrlCreateCheckbox("Alert when Shiny Found Music", 488, 24, 177, 17)
$Checkbox2 = GUICtrlCreateCheckbox("Avoid Disconnecting after Found", 488, 48, 177, 17)
$Checkbox3 = GUICtrlCreateCheckbox("Simulate Human-Like Walking", 488, 72, 177, 17)
$Checkbox4 = GUICtrlCreateCheckbox("Set Game on Focus", 488, 96, 177, 17)
$Checkbox5 = GUICtrlCreateCheckbox("Save Encounters in Text File", 488, 144, 177, 17)
$Checkbox6 = GUICtrlCreateCheckbox("Auto Relogging", 488, 120, 177, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup("Shiny Hunt Log:", 296, 96, 177, 73)
$Label7 = GUICtrlCreateLabel("Encounters: ", 304, 120, 64, 17)
$Label8 = GUICtrlCreateLabel("n/A", 408, 120, 42, 17)
$Label9 = GUICtrlCreateLabel("Latest Encounters: ", 304, 144, 96, 17)
$Label10 = GUICtrlCreateLabel("n/A", 408, 144, 42, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("Start", 296, 256, 379, 25)
$Group6 = GUICtrlCreateGroup("Level Bot Log", 296, 168, 177, 81)
$Label11 = GUICtrlCreateLabel("Encounters: ", 304, 192, 64, 17)
$Label12 = GUICtrlCreateLabel("n/A", 408, 192, 22, 17)
$Label13 = GUICtrlCreateLabel("Pokemon Fainted: ", 304, 216, 93, 17)
$Label14 = GUICtrlCreateLabel("n/A", 408, 216, 22, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group5 = GUICtrlCreateGroup("Bot Mode Settings", 480, 168, 193, 81)
$Radio1 = GUICtrlCreateRadio("Shiny Hunt Bot", 488, 192, 113, 17)
$Radio2 = GUICtrlCreateRadio("Level Bot (not completly finished)", 488, 216, 177, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
GUICtrlSetData($Edit1, "Version 1.1.2")
#EndRegion ### END Koda GUI section ###

; Apply Settings
;
GUICtrlSetState($Checkbox1, $Alert_Music)
GUICtrlSetState($Checkbox2, $Avoid_Disconnect)
GUICtrlSetState($Checkbox3, $Simulate_Human_Walking)
GUICtrlSetState($Checkbox4, $Set_Game_Focus)
GUICtrlSetState($Checkbox5, $Save_Encounters_TXT)
GUICtrlSetState($Checkbox6, $Auto_Relog)

GUICtrlSetData($Label10,$Encounter)
If $Bot_Mode = 1 Then
	GUICtrlSetState($Radio1, 1)
Else
	GUICtrlSetState($Radio2, 1)
EndIf
;
; Apply Hotkeys

HotKeySet($StartKey, "_go")
HotKeySet($PauseKey, "_pause")
HotKeySet($StopKey, "_stop")




UpdateLog("PokeOne Simple Bot Ready!")



While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			_Save_Settings()
			Exit
		Case $Button1
			_go()
		Case $Radio1
			$Bot_Mode = 1
		Case $Radio2
			$Bot_Mode = 2
	EndSwitch
WEnd

Func _go()
	If WinExists("PokeOne") Then
		$c = WinGetClientSize("PokeOne")
	Else
		UpdateLog("PokeOne isn't open!" & @CRLF & @CRLF & "Exit.")
		Return
	EndIf

	If $c[0] = 800 And $c[1] = 600 Then
		UpdateLog("PokeOne Resultion is Valid: " & $c[0] & "," & $c[1])

	Else
		UpdateLog("PokeOne is not 800x600 Resolution!")
		UpdateLog("Your Resolution is: " & $c[0] & "," & $c[1] & ", or not Vissible.")
		Return
	EndIf
	If $Set_Game_Focus = 1 Then
		UpdateLog("Set PokeOne always on Top.")
		WinSetOnTop("PokeOne", "", 1)
	Else
		WinSetOnTop("PokeOne", "", 0)
	EndIf
	$Startime = _NowTime()
	GUICtrlSetData($Label2, "Started")
	GUICtrlSetData($Label4, $Startime)
	GUICtrlSetData($Button1, "Bot is Running! ( Press " & $PauseKey & ") to Stop.)")
	GUICtrlSetState($Button1, $GUI_DISABLE)
	GUICtrlSetData($Label8, $Encounter)

	UpdateLog("Bot Started/Resumed")
	If Not ProcessExists("PokeOne.exe") Then
		MsgBox(0, "Error!", "PokeOne isnt open!")
		Exit
	EndIf

	$ClientPos = WinGetPos("PokeOne", "")
	$ClientPos[1] = $ClientPos[1] + "30"
	Sleep(150)
	$OldMousePos = MouseGetPos()
	MouseClick("LEFT", $ClientPos[0] + 30, $ClientPos[1] + 30, 2)
	MouseMove("LEFT", $OldMousePos[0], $OldMousePos[1])

	$Paused = True
	$i = 1
	Do
		$Hwid = WinGetHandle("PokeOne")
		$winpos = WinGetPos("PokeOne")

		Test_Logout()

		; Check for Overwold
		$overworld = PixelSearch($ClientPos[0] + "63", $ClientPos[1] + "25", $ClientPos[0] + "165", $ClientPos[1] + "41", 0xFF3232)
		If IsArray($overworld) Then
			;UpdateLog( "Overworld Detected, walking left and right to Trigger Wild Encounter!")
			Overworld()
		EndIf
		; Check for Battle
		$Battle = PixelSearch($ClientPos[0] + "345", $ClientPos[1] + "499", $ClientPos[0] + "457", $ClientPos[1] + "523", 0x962624)
		If IsArray($Battle) Then
			;UpdateLog("Fight Button Detected, Checking for Shiny")
			If $Bot_Mode = 1 Then
				Battles($Battle[0], $Battle[1])
			ElseIf $Bot_Mode = 2 Then
				Battle($Battle[0], $Battle[1])
			EndIf
		EndIf

			if $Bot_Mode = 2 Then
			$SwitchPokemon = PixelSearch($ClientPos[0] + "317", $ClientPos[1] + "138", $ClientPos[0] + "482", $ClientPos[1] + "150", 0xFFFFFF)
			If IsArray($SwitchPokemon) Then
				UpdateLog("Pokemon fainted! Switch to next Pokemon!")
				PokemonFainted()
			EndIf
			EndIf



		Sleep(50)
	Until $Paused = False
	$Paused = False
EndFunc   ;==>_go


Func Overworld()
	Test_Logout()
	GUICtrlSetData($Label2, "Overworld")
	If $Simulate_Human_Walking = 1 Then
		$rnd = Random(0, 1, 1)
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

	Else
		Send("{LEFT DOWN}")
		Sleep(700)
		Send("{LEFT UP}")
		Sleep(10)
		Send("{RIGHT DOWN}")
		Sleep(700)
		Send("{RIGHT UP}")
		Send("{RIGHT DOWN}")
		Sleep(700)
		Send("{RIGHT UP}")
		Sleep(10)
		Send("{LEFT DOWN}")
		Sleep(700)
		Send("{LEFT UP}")
	EndIf

EndFunc   ;==>Overworld


Func Battle($X, $Y)
	GUICtrlSetData($Label2, "Battle")
	$Encounter = $Encounter + 1
	GUICtrlSetData($Label12,$Encounter)
	If $Save_Encounters_TXT Then
		FileDelete(@ScriptDir & "\Encounter.txt")
		FileWrite(@ScriptDir & "\Encounter.txt", $Encounter)
	EndIf
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
	GUICtrlSetData($Label2, "Battle")

	$ClientPos = WinGetPos("PokeOne", "")
	$ClientPos[1] = $ClientPos[1] + "30"
	$ShinyColor = 0xFFF200

	$OldMousePos = MouseGetPos()
	Sleep(1000)

	$Shiny = PixelSearch($ClientPos[0] + "15", $ClientPos[1] + "5", $ClientPos[0] + "88", $ClientPos[1] + "152", 0xFFF200, 105)
	If IsArray($Shiny) Then
		MouseMove($Shiny[0], $Shiny[1])
		GUICtrlSetData($Label2, "Shiny Found :)")
		UpdateLog("Shiny found after " & $Encounter & " Encounters, Bot paused!")
		ShinyFound()

	Else
		$Encounter = $Encounter + "1"
		UpdateLog("Encounter: " & $Encounter & ", No Shiny, Flee...")
		If $Save_Encounters_TXT Then
			FileDelete(@ScriptDir & "\Encounter.txt")
			FileWrite(@ScriptDir & "\Encounter.txt", $Encounter)
			GUICtrlSetData($label8,$Encounter)
		EndIf

		MouseClick("LEFT", $ClientPos[0] + "520", $ClientPos[1] + "581", 5, 1000)
		Sleep(500)
	EndIf
EndFunc   ;==>Battles



Func PokemonFainted()
	GUICtrlSetData($Label2, "PKMN Fainted")
	$PokemonFainted = $PokemonFainted + 1
	GUICtrlSetData($Label14,$PokemonFainted)
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

	$ClientSize = WinGetClientSize("PokeOne", "")

	$OldMousePos = MouseGetPos()
	If $Auto_Relog Then
		$Logout = PixelSearch($ClientPos[0] + 657, $ClientPos[1] + 568, $ClientPos[0] + 788, $ClientPos[1] + 580, 0x5C1223, 3)
		If IsArray($Logout) Then
			UpdateLog("Login Screen Detected! Logging in...")
			GUICtrlSetData($Label2, "Relog...")
			MouseClick("LEFT", $ClientPos[0] + "422", $ClientPos[1] + "398", 5)
			MouseMove($OldMousePos[0], $OldMousePos[1])
			Sleep(10000)
		Else
			Return
		EndIf
	EndIf

EndFunc   ;==>Test_Logout



; Shiny Found Method
; Loop every 30 Seconds:
; Key Presses and a Trainer Pass Open/Close via Mouse Click,
; to avoid Auto Disconnecting.
; Play a Sound File to Alert.
; Test if Connection Lost and try to Relog.
Func ShinyFound()
	$EndTime = _NowTime()
	GUICtrlSetData($Label6, $EndTime)
	Do
		GUICtrlSetData($Label2, "Shiny Found :)")

		$ClientPos = WinGetPos("PokeOne", "")
		$ClientPos[1] = $ClientPos[1] + "30"
		Test_Logout()
		If $Avoid_Disconnect Then
			Send("{LEFT}")
			Sleep(1000)
			Send("{Right}")
			Sleep(1000)
			MouseClick("LEFT", $ClientPos[0] + "623", $ClientPos[1] + "16", 1)
			Sleep(1000)
			MouseClick("LEFT", $ClientPos[0] + "623", $ClientPos[1] + "16", 1)
			Sleep(1000)
			MouseClick("LEFT", $ClientPos[0] + "260", $ClientPos[1] + "567", 1)
			Sleep(1000)
			MouseClick("LEFT", $ClientPos[0] + "260", $ClientPos[1] + "567", 1)
		EndIf

		If $Alert_Music = 1 Then
			SoundPlay(@ScriptDir & "\Shiny.mp3")
		EndIf

		Sleep(30000)
	Until $Paused = False
	$Paused = False
	$Encounter = 0
EndFunc   ;==>ShinyFound

Func _pause()
	$EndTime = _NowTime()
	GUICtrlSetData($Label6, $EndTime)
	GUICtrlSetData($Label2, "Paused")
	GUICtrlSetData($label10,$Encounter)
	GUICtrlSetData($Button1, "Start")
	GUICtrlSetState($Button1, $GUI_ENABLE)
	$Paused = False
EndFunc   ;==>_pause

Func _stop()
	_Save_Settings()
	Exit
EndFunc   ;==>_stop

Func UpdateLog($Text)
	$Time = _NowTime()
	$CurrentTime = "[" & $Time & "]: "

	GUICtrlSetData($Edit1, GUICtrlRead($Edit1) & @CRLF & $CurrentTime & $Text)
	GUICtrlSendMsg($Edit1, $EM_LINESCROLL, 0, GUICtrlSendMsg($Edit1, $EM_GETLINECOUNT, 0, 0))
	_GUICtrlRichEdit_ScrollToCaret($Edit1)
EndFunc   ;==>UpdateLog

Func _Save_Settings()
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Alert_Music", GUICtrlRead($Checkbox1))
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Avoid_Disconnect", GUICtrlRead($Checkbox2))
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Simulate_Human_Walking", GUICtrlRead($Checkbox3))
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Set_Game_Focus", GUICtrlRead($Checkbox4))
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Auto_Relog", GUICtrlRead($Checkbox5))
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Save_Encounters_TXT", GUICtrlRead($Checkbox6))
	If $Bot_Mode = 1 Then
		IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Bot_Mode", 1)
	Else
		IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Bot_Mode", 2)
	EndIf
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Encounter", $Encounter)
EndFunc   ;==>_Save_Settings
