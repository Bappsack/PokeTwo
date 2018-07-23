#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\Desktop\Ledybot-master - Kopie (3)\Ledybot\Cherish Ball.ico
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
#include <ComboConstants.au3>
#include <Misc.au3>
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
	IniWrite(@ScriptDir & "\Settings.ini", "HotKeys", "FishingCoordsKey", "{F1}")

	; Bot Settings
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Alert_Music", "0")
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Avoid_Disconnect", "0")
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Simulate_Human_Walking", "0")
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Set_Game_Focus", "0")
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Auto_Relog", "0")
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Save_Encounters_TXT", "0")
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Bot_Mode", "1")
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Encounter", "0")
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "FishingCoordinationX", "0")
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "FishingCoordinationY", "0")
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "FishingDirection", "0")
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
$Encounter = IniRead(@ScriptDir & "\Settings.ini", "Bot Settings", "Encounter", "0")
$BattleEncounter = IniRead(@ScriptDir & "\Settings.ini", "Bot Settings", "BattleEncounter", "0")
$FishingCoordsX = IniRead(@ScriptDir & "\Settings.ini", "Bot Settings", "FishingCoordinationsX", "0")
$FishingCoordsY = IniRead(@ScriptDir & "\Settings.ini", "Bot Settings", "FishingCoordinationsY", "0")
$FishingDirection = IniRead(@ScriptDir & "\Settings.ini", "Bot Settings", "FishingDirection", "0")

Global $RelogAttemps = 0
Global $PokemonFainted = 0
; #############################################################################################

Global $Paused

#Region ### START Koda GUI section ### Form=c:\users\chris\documents\github\simple-pokeone-bot\gui\form1.kxf
$Form1_1 = GUICreate("Simple Bot for PokeOne v1.1.2", 681, 336, 147, 138)
$Group1 = GUICtrlCreateGroup("Bot Log:", 8, 0, 281, 329)
$Edit1 = GUICtrlCreateEdit("", 16, 16, 265, 305)
GUICtrlSetData(-1, "Edit1")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("Status", 296, 0, 177, 97)
$Label1 = GUICtrlCreateLabel("Current State", 304, 24, 66, 17)
$Label2 = GUICtrlCreateLabel("Bot not running", 384, 24, 76, 17)
$Label3 = GUICtrlCreateLabel("Start Time:", 304, 48, 55, 17)
$Label4 = GUICtrlCreateLabel("n/A", 384, 48, 78, 17)
$Label5 = GUICtrlCreateLabel("End Time:", 304, 72, 52, 17)
$Label6 = GUICtrlCreateLabel("n/A", 384, 72, 78, 17)
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
$Label8 = GUICtrlCreateLabel("n/A", 408, 120, 54, 17)
$Label9 = GUICtrlCreateLabel("Latest Encounters: ", 304, 144, 96, 17)
$Label10 = GUICtrlCreateLabel("n/A", 408, 144, 54, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("Start", 480, 272, 195, 25)
$Group6 = GUICtrlCreateGroup("Level Bot Log", 296, 168, 177, 81)
$Label11 = GUICtrlCreateLabel("Encounters: ", 304, 192, 64, 17)
$Label12 = GUICtrlCreateLabel("n/A", 408, 192, 54, 17)
$Label13 = GUICtrlCreateLabel("Pokemon Fainted: ", 304, 216, 93, 17)
$Label14 = GUICtrlCreateLabel("n/A", 408, 216, 54, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group5 = GUICtrlCreateGroup("Bot Mode Settings", 480, 168, 193, 97)
$Radio1 = GUICtrlCreateRadio("Shiny Hunt Bot", 488, 192, 113, 17)
$Radio2 = GUICtrlCreateRadio("Level Bot (not completly finished)", 488, 216, 177, 17)
$Radio3 = GUICtrlCreateRadio("Shiny Hunt (Fishing)", 488, 240, 177, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group7 = GUICtrlCreateGroup("Shiny Hunt (Fishing)", 296, 248, 177, 81)
$Combo1 = GUICtrlCreateCombo("UP", 400, 272, 65, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "DOWN|LEFT|RIGHT")
$Label15 = GUICtrlCreateLabel("Fishing Direction", 304, 272, 82, 17)
$Button2 = GUICtrlCreateButton("Reset Coordinations", 304, 304, 163, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button3 = GUICtrlCreateButton("Quit", 480, 304, 195, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

; Apply Settings
;
GUICtrlSetState($Checkbox1, $Alert_Music)
GUICtrlSetState($Checkbox2, $Avoid_Disconnect)
GUICtrlSetState($Checkbox3, $Simulate_Human_Walking)
GUICtrlSetState($Checkbox4, $Set_Game_Focus)
GUICtrlSetState($Checkbox5, $Save_Encounters_TXT)
GUICtrlSetState($Checkbox6, $Auto_Relog)

GUICtrlSetData($Label10, $Encounter)
GUICtrlSetData($Label12, $BattleEncounter)

If $Bot_Mode = 1 Then
	GUICtrlSetState($Radio1, 1)
ElseIf $Bot_Mode = 2 Then
	GUICtrlSetState($Radio2, 1)
Else
	GUICtrlSetState($Radio3, 1)
EndIf

If $FishingDirection = "LEFT" Then
	GUICtrlSetData($Combo1, "LEFT")
ElseIf $FishingDirection = "RIGHT" Then
	GUICtrlSetData($Combo1, "RIGHT")
ElseIf $FishingDirection = "DOWN" Then
	GUICtrlSetData($Combo1, "DOWN")
EndIf


;
; Apply Hotkeys

HotKeySet($StartKey, "_Runbot")
HotKeySet($PauseKey, "_pause")
HotKeySet($StopKey, "_stop")



$Time = _NowTime()
GUICtrlSetData($Edit1, "[" & $Time & "]: PokeOne Simple Bot Ready!")



While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			_Save_Settings()
			Exit

		Case $Checkbox1
			If GUICtrlRead($Checkbox1) = $GUI_CHECKED Then
				$Alert_Music = True
			Else
				$Alert_Music = False
			EndIf

		Case $Checkbox2
			If GUICtrlRead($Checkbox2) = $GUI_CHECKED Then
				$Avoid_Disconnect = True
			Else
				$Avoid_Disconnect = False
			EndIf

		Case $Checkbox3
			If GUICtrlRead($Checkbox1) = $GUI_CHECKED Then
				$Simulate_Human_Walking = True
			Else
				$Simulate_Human_Walking = False
			EndIf

		Case $Checkbox4
			If GUICtrlRead($Checkbox1) = $GUI_CHECKED Then
				$Set_Game_Focus = True
			Else
				$Set_Game_Focus = False
			EndIf

		Case $Checkbox5
			If GUICtrlRead($Checkbox1) = $GUI_CHECKED Then
				$Auto_Relog = True
			Else
				$Auto_Relog = False
			EndIf

		Case $Checkbox6
			If GUICtrlRead($Checkbox1) = $GUI_CHECKED Then
				$Save_Encounters_TXT = True
			Else
				$Save_Encounters_TXT = False
			EndIf

		Case $Radio1
			$Bot_Mode = 1
		Case $Radio2
			$Bot_Mode = 2
		Case $Radio3
			$Bot_Mode = 3
		Case $Button1
			_Runbot()
		Case $Button2
			$FishingCoordsX = 0
			$FishingCoordsY = 0
			IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "FishingCoordinationsX", $FishingCoordsX)
			IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "FishingCoordinationsY", $FishingCoordsY)
			UpdateLog("Fishing Rod Coordinations deleted!")
		Case $Button3
			Exit
	EndSwitch
WEnd

Func _Runbot()

	If WinExists("PokeOne") Then
		$c = WinGetClientSize("PokeOne")
	Else
		UpdateLog("PokeOne isn't open!")
		Return
	EndIf

	If $c[0] = 800 And $c[1] = 600 Then
		UpdateLog("PokeOne Resultion is Valid: " & $c[0] & "," & $c[1])

	ElseIf $c[0] = 0 Then
		UpdateLog("PokeOne is not 800x600 Resolution!")
		Return
	Else

		UpdateLog("PokeOne is minimized!")
		Return
	EndIf

	If $Set_Game_Focus = 1 Then
		UpdateLog("Set PokeOne always on Top.")
		WinSetOnTop("PokeOne", "", 1)
	Else
		WinSetOnTop("PokeOne", "", 0)
	EndIf
	$Startime = _NowTime()
	$CurrentTime = "[" & $Startime & "]: "
	GUICtrlSetData($Label2, "Running")
	GUICtrlSetData($Label4, $Startime)
	GUICtrlSetData($Button1, "Bot is Running! ( Press " & $PauseKey & ") to Stop.)")
	GUICtrlSetState($Button1, $GUI_DISABLE)
	;GUICtrlSetData($Label8, $Encounter)
	_ClearLog()

	If $Bot_Mode = 1 Then
		GUICtrlSetData($Edit1, $CurrentTime & "Shiny Hunting(Wild) started")
	ElseIf $Bot_Mode = 2 Then
		GUICtrlSetData($Edit1, $CurrentTime & "Level Bot started")
	ElseIf $Bot_Mode = 3 Then
		GUICtrlSetData($Edit1, $CurrentTime & "Shiny Hunting(Fishing) started")
	EndIf

	If Not ProcessExists("PokeOne.exe") Then
		UpdateLog("PokeOne isnt open!")

		Return
	EndIf

	$ClientPos = WinGetPos("PokeOne", "")
	$ClientPos[1] = $ClientPos[1] + "30"
	Sleep(150)
	$OldMousePos = MouseGetPos()
	MouseClick("LEFT", $ClientPos[0] + 30, $ClientPos[1] + 30, 2)
	MouseMove("LEFT", $OldMousePos[0], $OldMousePos[1])

	$Paused = True
	Do
		$Hwid = WinGetHandle("PokeOne")
		$winpos = WinGetPos("PokeOne")

		Test_Logout()
		GUICtrlSetData($Label2, "Checking")

		; Check for Shiny Hunt Fishing



		; Check for Overwold
		$overworld = PixelSearch($ClientPos[0] + "63", $ClientPos[1] + "25", $ClientPos[0] + "165", $ClientPos[1] + "41", 0xFF3232)
		If IsArray($overworld) Then
			Overworld()
		EndIf
		; Check for Battle
		$Battle = PixelSearch($ClientPos[0] + "345", $ClientPos[1] + "499", $ClientPos[0] + "457", $ClientPos[1] + "523", 0x962624)
		If IsArray($Battle) Then
			If $Bot_Mode = 1 Or $Bot_Mode = 3 Then
				ShinyHunt($Battle[0], $Battle[1])
			ElseIf $Bot_Mode = 2 Then
				LevelBot($Battle[0], $Battle[1])
			EndIf
		EndIf

		If $Bot_Mode = 2 Then
			$SwitchPokemon = PixelSearch($ClientPos[0] + "317", $ClientPos[1] + "138", $ClientPos[0] + "482", $ClientPos[1] + "150", 0xFFFFFF)
			If IsArray($SwitchPokemon) Then
				UpdateLog("Pokemon fainted! Switch to next Pokemon!")
				PokemonFainted()
			EndIf
		EndIf



		Sleep(50)
	Until $Paused = False
	$Paused = False
EndFunc   ;==>_Runbot


Func Overworld()
	Test_Logout()
	$RelogAttemps = 0
	GUICtrlSetData($Label2, "Overworld")

	$ClientPos = WinGetPos("PokeOne", "")
	$ClientPos[1] = $ClientPos[1] + "30"
	Sleep(150)
	$OldMousePos = MouseGetPos()

	If $Bot_Mode = 3 Then
		If $FishingCoordsX = 0 Then
			UpdateLog("Fishing Rod Coordination Mode active!")
			UpdateLog("Place your Mouse on the Rod")
			UpdateLog("and then Press ENTER")
			UpdateLog("Waiting for Fishing Key is pressed...")
			Do
				GUICtrlSetData($Label2, "Waiting...")
				Sleep(100)
			Until _IsPressed("0D") ;71 for F2
			UpdateLog("Fishing Rod Coords. Saved!")
			;InputBox("Fishing Rod Coordinations", "Hover your Mouse over the Fishing Rod u want to Use and Press [ENTER] (Make Sure this InputBox is on Top)")
			$FishingCoords = MouseGetPos()
			$winpos = WinGetPos("PokeOne")

			$FishingCoordsX = $FishingCoords[0] - $winpos[0]
			$FishingCoordsY = $FishingCoords[1] - $winpos[1]

			If Not $FishingCoordsX = 0 Then
				IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "FishingCoordinationsX", $FishingCoordsX)
				IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "FishingCoordinationsY", $FishingCoordsY)

			EndIf
		EndIf


		$FishingCooldown = PixelSearch($ClientPos[0] + 435, $ClientPos[1] + 8, $ClientPos[0] + 460, $ClientPos[1] + 30, 0xD73028)
		If IsArray($FishingCooldown) Then
			GUICtrlSetData($Label2, "Fishing Cooldown")
			Send("{LEFT DOWN}")
			Sleep(700)
			Send("{LEFT UP}")
			Sleep(10)
			Send("{RIGHT DOWN}")
			Sleep(700)
			Send("{RIGHT UP}")
			Sleep(100)
			If $FishingDirection = "UP" Then
				Send("{UP}")
			ElseIf $FishingDirection = "DOWN" Then
				Send("{DOWN}")
			ElseIf $FishingDirection = "LEFT" Then
				Send("{LEFT}")

			ElseIf $FishingDirection = "RIGHT" Then
				Send("{RIGHT}")
			EndIf
			Sleep(1000)
		Else
			GUICtrlSetData($Label2, "Using Rod")
			If $FishingDirection = "UP" Then
				Send("{UP}")
			ElseIf $FishingDirection = "DOWN" Then
				Send("{DOWN}")
			ElseIf $FishingDirection = "LEFT" Then
				Send("{LEFT}")

			ElseIf $FishingDirection = "RIGHT" Then
				Send("{RIGHT}")
			EndIf
			MouseClick("LEFT", $ClientPos[0] + $FishingCoordsX, $ClientPos[1] - 30 + $FishingCoordsY, 5)
			Sleep(2000)
		EndIf

	Else


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
		Send("{SPACE}")
	EndIf

EndFunc   ;==>Overworld


Func LevelBot($X, $Y)
	GUICtrlSetData($Label2, "Battle")
	$BattleEncounter = $BattleEncounter + 1
	GUICtrlSetData($Label12, $BattleEncounter)
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

EndFunc   ;==>LevelBot

Func ShinyHunt($X, $Y)
	Test_Logout()
	$ClientPos = WinGetPos("PokeOne", "")
	$ClientPos[1] = $ClientPos[1] + "30"
	$ShinyColor = 0xFFF200
	$OldMousePos = MouseGetPos()
	Sleep(1000)

	GUICtrlSetData($Label2, "Battle")

	$Shiny = PixelSearch($ClientPos[0] + "15", $ClientPos[1] + "5", $ClientPos[0] + "88", $ClientPos[1] + "152", 0xFFF200, 105)
	If IsArray($Shiny) Then
		MouseMove($Shiny[0], $Shiny[1])
		GUICtrlSetData($Label2, "Shiny Found :)")
		$Encounter = 0
		IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Encounter", $Encounter)
		UpdateLog("Shiny found after " & $Encounter & " Encounters, Bot paused!")
		ShinyFound()

	Else
		$Encounter = $Encounter + "1"
		UpdateLog("Encounter: " & $Encounter & ", No Shiny, Flee...")
		If $Save_Encounters_TXT Then
			FileDelete(@ScriptDir & "\Encounter.txt")
			FileWrite(@ScriptDir & "\Encounter.txt", $Encounter)
			GUICtrlSetData($Label8, $Encounter)
		EndIf

		MouseClick("LEFT", $ClientPos[0] + "520", $ClientPos[1] + "581", 5, 1000)
		Sleep(500)
	EndIf

EndFunc   ;==>ShinyHunt



Func PokemonFainted()
	GUICtrlSetData($Label2, "PKMN Fainted")
	$PokemonFainted = $PokemonFainted + 1
	GUICtrlSetData($Label14, $PokemonFainted)
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
			$RelogAttemps = $RelogAttemps + 1
			If $RelogAttemps > 25 Then
				UpdateLog("To many Attemps to Reconnects!")
				UpdateLog("Re-Open Game...")
				ProcessClose("PokeOne.exe")
				Sleep(1000)
				Run("C:\Users\" & @UserName & "\AppData\Local\PokeOne\files\PokeOne.exe")
				Sleep(5000)
				$RelogAttemps = 0
			EndIf
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
	_ClearLog()
	$EndTime = _NowTime()
	$CurrentTime = "[" & $EndTime & "]: "
	GUICtrlSetData($Edit1, $CurrentTime & "Bot Paused!")
	GUICtrlSetData($Label6, $EndTime)
	GUICtrlSetData($Label2, "Paused")
	GUICtrlSetData($Label10, $Encounter)
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

Func _ClearLog()
	GUICtrlSetData($Edit1, "")
EndFunc   ;==>_ClearLog



Func _Save_Settings()
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Alert_Music", GUICtrlRead($Checkbox1))
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Avoid_Disconnect", GUICtrlRead($Checkbox2))
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Simulate_Human_Walking", GUICtrlRead($Checkbox3))
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Set_Game_Focus", GUICtrlRead($Checkbox4))
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Auto_Relog", GUICtrlRead($Checkbox5))
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Save_Encounters_TXT", GUICtrlRead($Checkbox6))

	If Not $FishingCoordsX = 0 Then
		IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "FishingCoordinationsX", $FishingCoordsX)
		IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "FishingCoordinationsY", $FishingCoordsY)

	EndIf
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "FishingDirection", GUICtrlRead($Combo1))


	If GUICtrlRead($Radio1) = 1 Then
		IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Bot_Mode", 1)
	ElseIf GUICtrlRead($Radio2) = 1 Then
		IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Bot_Mode", 2)
	ElseIf GUICtrlRead($Radio3) = 1 Then
		IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Bot_Mode", 3)
	EndIf
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Encounter", $Encounter)
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "BattleEncounter", $BattleEncounter)

EndFunc   ;==>_Save_Settings
