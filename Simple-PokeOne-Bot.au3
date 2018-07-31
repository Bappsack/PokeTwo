;=================================================================================================
; Program:			Simple PokeOne Bot
; Description:		a Simple Bot for PokeOne Based on PixelSearch
; Features:			Shiny Hunting(Grass and Fishing)
;					Leveling
;					OBS Encounter Display(.TXT)
; Requirement(s):	Window Mode
;					Resolution 800x600
;					Admin Rights ( for Sending Keys/Mouse Commands to Window
;					IQ > 80
;
; Author(s):		Mitsukiii
;=================================================================================================
#NoTrayIcon
#RequireAdmin

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\Desktop\Ledybot-master - Kopie (3)\Ledybot\Cherish Ball.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=y ; 64 Bit application

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
#include <Includes\KDMemory.au3>
;#include <Includes\KryMemory.au3>
#include <ScreenCapture.au3>
; Load Ini File
; #############################################################################################
;
; Create Settings.ini if it don't Exist
;


AutoItSetOption("MouseCoordMode", "1")
;AutoItSetOption("MouseClickDelay","-1")

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
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "AutoCatch", "0")
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "AutoCatchPokemon", "0")


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
$Auto_Catch = IniRead(@ScriptDir & "\Settings.ini", "Bot Settings", "AutoCatch", "0")
$Use_Pkmn_DB = IniRead(@ScriptDir & "\Settings.ini", "Bot Settings", "UsePKMNDB", "0")
$Speedhack = IniRead(@ScriptDir & "\Settings.ini", "Bot Settings", "Speedhack", "0")
$Auto_Catch_Pokemon = IniRead(@ScriptDir & "\Settings.ini", "Bot Settings", "AutoCatchPokemon", "Bulbasaur")

Global $RelogAttemps = 0
Global $PokemonFainted = 0

; Move Color Types

$Normal = 0x777755
$Fire = 0xB36024
$Water = 0x4B68AD
$Electric = 0xC0B200
$Grass = 0x5B983D
$Ice = 0xFFFFFF
$Fighting = 0x90241E
$Poison = 0x752F75
$Ground = 0xA48D4C
$Flying = 0x7B6AB0
$Psychic = 0xB54063
$Bug = 0x778317
$Rock = 0x807027
$Ghost = 0x503F6C
$Dragon = 0x5128B3
$Dark = 0x4F3E33
$Steel = 0xFFFFFF
$Fairy = 0xB27281

$Empty = 0x787878


; Battle Misc

$GenderMale = 0x2284E9
$GenderFemale = 0xF080E2
$CatchAttemps = 1

$New_Speed = 0
$Old_Speed = 0
; #############################################################################################

Global $Paused

#Region ### START Koda GUI section ### Form=c:\users\chris\documents\github\simple-pokeone-bot\gui\form1.kxf
$Form1_1 = GUICreate("Simple Bot for PokeOne v2.1", 787, 415, 180, 124)
$Group1 = GUICtrlCreateGroup("Bot Log:", 8, 0, 377, 409)
$Edit1 = GUICtrlCreateEdit("", 16, 16, 361, 385, BitOR($GUI_SS_DEFAULT_EDIT, $ES_READONLY))
GUICtrlSetData(-1, "Edit1")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("Status", 392, 0, 177, 97)
$Label1 = GUICtrlCreateLabel("Current State", 400, 24, 66, 17)
$Label2 = GUICtrlCreateLabel("Bot not running", 480, 24, 89, 17)
$Label3 = GUICtrlCreateLabel("Start Time:", 400, 48, 55, 17)
$Label4 = GUICtrlCreateLabel("n/A", 480, 48, 62, 17)
$Label5 = GUICtrlCreateLabel("End Time:", 400, 72, 52, 17)
$Label6 = GUICtrlCreateLabel("n/A", 480, 72, 62, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("Bot Settings:", 576, 0, 201, 305)
$Checkbox1 = GUICtrlCreateCheckbox("Alert when Shiny Found Music", 584, 24, 177, 17)
$Checkbox2 = GUICtrlCreateCheckbox("Avoid Disconnecting after Found", 584, 48, 177, 17)
$Checkbox3 = GUICtrlCreateCheckbox("Simulate Human-Like Walking", 584, 72, 177, 17)
$Checkbox4 = GUICtrlCreateCheckbox("Set Game on Focus", 584, 96, 177, 17)
$Checkbox5 = GUICtrlCreateCheckbox("Save Encounters in Text File", 584, 144, 177, 17)
$Checkbox6 = GUICtrlCreateCheckbox("Auto Relogging", 584, 120, 177, 17)
$Checkbox7 = GUICtrlCreateCheckbox("Auto Catch", 584, 168, 97, 17)
$Checkbox8 = GUICtrlCreateCheckbox("Use Pokemon Database", 584, 192, 177, 17)
$Button4 = GUICtrlCreateButton("Button4", 664, 200, 1, 9)
$Checkbox9 = GUICtrlCreateCheckbox("Speedhack ( Mount Speed )", 584, 216, 177, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup("Shiny Hunt Log:", 392, 96, 177, 73)
$Label7 = GUICtrlCreateLabel("Encounters: ", 400, 120, 64, 17)
$Label8 = GUICtrlCreateLabel("n/A", 504, 120, 22, 17)
$Label9 = GUICtrlCreateLabel("Latest Encounters: ", 400, 144, 96, 17)
$Label10 = GUICtrlCreateLabel("n/A", 504, 144, 22, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("Start", 392, 336, 179, 25)
$Group6 = GUICtrlCreateGroup("Level Bot Log", 392, 168, 177, 81)
$Label11 = GUICtrlCreateLabel("Encounters: ", 400, 192, 64, 17)
$Label12 = GUICtrlCreateLabel("n/A", 504, 192, 22, 17)
$Label13 = GUICtrlCreateLabel("Pokemon Fainted: ", 400, 216, 93, 17)
$Label14 = GUICtrlCreateLabel("n/A", 504, 216, 22, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group5 = GUICtrlCreateGroup("Bot Mode Settings", 576, 304, 201, 97)
$Radio1 = GUICtrlCreateRadio("Shiny Hunt Bot", 584, 328, 113, 17)
$Radio2 = GUICtrlCreateRadio("Level Bot (not completly finished)", 584, 352, 177, 17)
$Radio3 = GUICtrlCreateRadio("Shiny Hunt (Fishing)", 584, 376, 177, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group7 = GUICtrlCreateGroup("Shiny Hunt (Fishing)", 392, 248, 177, 81)
$Combo1 = GUICtrlCreateCombo("UP", 496, 272, 65, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "DOWN|LEFT|RIGHT")
$Label15 = GUICtrlCreateLabel("Fishing Direction", 400, 272, 82, 17)
$Button2 = GUICtrlCreateButton("Reset Coordinations", 400, 304, 163, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button3 = GUICtrlCreateButton("Quit", 392, 368, 179, 25)
$Group8 = GUICtrlCreateGroup("Auto Catch Settings", 584, 240, 185, 57)
$Label16 = GUICtrlCreateLabel("Catch Pokemon:", 592, 264, 83, 17)
$Input1 = GUICtrlCreateInput("Bulbasaur", 680, 264, 81, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
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
GUICtrlSetState($Checkbox7, $Auto_Catch)
GUICtrlSetData($Input1, $Auto_Catch_Pokemon)
GUICtrlSetData($Label10, $Encounter)
GUICtrlSetData($Label12, $BattleEncounter)
GUICtrlSetState($Checkbox8, $Use_Pkmn_DB)
GUICtrlSetState($Checkbox9, $Speedhack)
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

; Apply Hotkeys

HotKeySet($StartKey, "_Runbot")
HotKeySet($PauseKey, "_pause")
HotKeySet($StopKey, "_stop")
$Time = _NowTime()
GUICtrlSetData($Edit1, "[" & $Time & "]: PokeOne Simple Bot Ready!")
;_Speedhack()

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
			_Save_Settings()
			Exit
	EndSwitch

WEnd


Func _Runbot()
	If WinExists("PokeOne") Then
		$c = WinGetClientSize("PokeOne")
	Else
		UpdateLog("PokeOne isn't open!")
		Run(@LocalAppDataDir & "\PokeOne\files\PokeOne.exe")
		Return
	EndIf

	If $c[0] = 800 And $c[1] = 600 Then
		UpdateLog("PokeOne Resultion is Valid: " & $c[0] & "," & $c[1])

	ElseIf $c[0] > 800 Then
		UpdateLog("PokeOne is not 800x600 Resolution!")
		;Return
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
	;$ClientPos[1] = $ClientPos[1] + "30"
	Sleep(150)
	$OldMousePos = MouseGetPos()
	WinActivate("PokeOne")

	If $Speedhack = 1 Then
		_Speedhack()
	EndIf


	$Paused = True
	Do
		$Hwid = WinGetHandle("PokeOne")
		$winpos = WinGetPos("PokeOne")
		$ClientPos = WinGetPos("PokeOne")
		Test_Logout()
		GUICtrlSetData($Label2, "Checking")
		if $Speedhack = 1 Then
		Apply_Speedhack()
		EndIf
			_Reload_Settings()

		; Check for Shiny Hunt Fishing

		; OLD Overworld Detection
		; Check for Overwold
		$overworld = PixelSearch($ClientPos[0] + "15", $ClientPos[1] + "70", $ClientPos[0] + "53", $ClientPos[1] + "91", 0xC7C8C9)
		If IsArray($overworld) Then
			Overworld()
		EndIf

		#cs
			$OverworldCheck = _ReadPokemon(2)
			if $OverworldCheck = 1 Then
			Overworld()
			EndIf
		#ce

		; Check for Battle
		;		MouseMove($ClientPos[0] + "337", $ClientPos[1] + "495")
		;MouseMove($ClientPos[0] + "465", $ClientPos[1] + "534")
		$Battle = PixelSearch($ClientPos[0] + "337", $ClientPos[1] + "525", $ClientPos[0] + "465", $ClientPos[1] + "564", 0x922421)
		If IsArray($Battle) Then
			If $Bot_Mode = 1 Or $Bot_Mode = 3 Then
				ShinyHunt()
			ElseIf $Bot_Mode = 2 Then
				LevelBot()
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
	;Sleep(150)
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
			Until _IsPressed("0D") ;0D for Enter/Return
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

			_SendClick("left", $FishingCoordsX, $FishingCoordsY, 5)

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


Func LevelBot()
	GUICtrlSetData($Label2, "Battle")
	$BattleEncounter = $BattleEncounter + 1
	GUICtrlSetData($Label12, $BattleEncounter)
	$ClientPos = WinGetPos("PokeOne")
	UpdateLog("Pressing Fight Button")
	_SendClick("left", 398, 525, 5)
	Sleep(100)

	$Fight = PixelSearch($ClientPos[0] + 384, $ClientPos[1] + 497, $ClientPos[0] + 419, $ClientPos[1] + 522, 0xD38663, 10)
	If Not IsArray($Fight) Then
		UpdateLog("No Moves Detected, Abort.")
		_SendClick("left", 399, 568, 5)
		Sleep(2000)
		Return
	EndIf

	Sleep(250)

	Const $MoveTypes = _CheckMoves()

	$i = 1
	For $Moves In $MoveTypes

		If $Moves = "Empty" Then
			UpdateLog("Move" & $i & " is Empty.")
		Else
			UpdateLog("Move" & $i & ": [" & $Moves & "]")
		EndIf

		If $MoveTypes[0] = "Empty" Then
			$Move1Empty = True
		Else
			$Move1Empty = False
		EndIf
		If $MoveTypes[1] = "Empty" Then
			$Move2Empty = True
		Else
			$Move2Empty = False
		EndIf
		If $MoveTypes[2] = "Empty" Then
			$Move3Empty = True
		Else
			$Move3Empty = False
		EndIf
		If $MoveTypes[3] = "Empty" Then
			$Move4Empty = True
		Else
			$Move4Empty = False
		EndIf
		$i = $i + 1
	Next


	$Fight = PixelSearch($ClientPos[0] + 384, $ClientPos[1] + 497, $ClientPos[0] + 419, $ClientPos[1] + 522, 0xD38663, 10)
	If IsArray($Fight) Then


		If $Move1Empty = False Then
			UpdateLog("Move1:" & $MoveTypes[0] & " Selected!")
			_SendClick("left", 304, 454, 5)
		ElseIf $Move2Empty = False Then
			UpdateLog("Move2:" & $MoveTypes[1] & " Selected!")
			_SendClick("left", 498, 462, 5)
		ElseIf $Move3Empty = False Then
			UpdateLog("Move3:" & $MoveTypes[2] & " Selected!")
			_SendClick("left", 306, 537, 5)
		ElseIf $Move4Empty = False Then
			UpdateLog("Move4:" & $MoveTypes[3] & " Selected!")
			_SendClick("left", 494, 543, 5)
		EndIf
	EndIf

	Sleep(1000)


EndFunc   ;==>LevelBot


Func _CheckMoves()
	UpdateLog("Checking Moves...")
	$ClientPos = WinGetPos("PokeOne", "")
	Global $MoveColors[19] = [0x777755, 0xB36024, 0x4B68AD, 0xC0B200, 0x5B983D, 0xFFFFFF, 0x90241E, 0x752F75, 0xA48D4C, 0x7B6AB0, 0xB54063, 0x778317, 0x807027, 0x503F6C, 0x5128B3, 0x4F3E33, 0xFFFFFF, 0xB27281, 0x787878]
	Global $MoveAtributes[19] = ["Normal", "Fire", "Water", "Electric", "Grass", "Ice", "Fighting", "Poison", "Ground", "Flying", "Psychic", "Bug", "Rock", "Ghost", "Dragon", "Dark", "Steel", "Fairy", "Empty"]
	$Type1 = 0
	$Type2 = 0
	$Type3 = 0
	$Type4 = 0
	$i = 0

	For $Color In $MoveColors
		$Move1 = PixelSearch($ClientPos[0] + 224, $ClientPos[1] + 426, $ClientPos[0] + 366, $ClientPos[1] + 459, $Color, 5)
		If IsArray($Move1) Then
			$Type1 = $MoveAtributes[$i]
		EndIf

		$Move2 = PixelSearch($ClientPos[0] + 428, $ClientPos[1] + 425, $ClientPos[0] + 574, $ClientPos[1] + 460, $Color, 5)
		If IsArray($Move2) Then
			$Type2 = $MoveAtributes[$i]
		EndIf

		$Move3 = PixelSearch($ClientPos[0] + 232, $ClientPos[1] + 496, $ClientPos[0] + 363, $ClientPos[1] + 524, $Color, 5)
		If IsArray($Move3) Then
			$Type3 = $MoveAtributes[$i]
		EndIf

		$Move4 = PixelSearch($ClientPos[0] + 444, $ClientPos[1] + 498, $ClientPos[0] + 566, $ClientPos[1] + 522, $Color, 5)
		If IsArray($Move4) Then
			$Type4 = $MoveAtributes[$i]
		EndIf


		$i = $i + 1

	Next

	Const $Types[4] = [$Type1, $Type2, $Type3, $Type4]

	Return $Types

EndFunc   ;==>_CheckMoves


Func ShinyHunt()
	Test_Logout()
	If $Use_Pkmn_DB = 1 Then
		$PokemonName = _ReadPokemon(1)
		UpdateLog("Pokemon: " & $PokemonName)
		If $Auto_Catch = 1 Then
			_AutoCatch()
		EndIf
	EndIf

	$ClientPos = WinGetPos("PokeOne", "")
	$ClientPos[1] = $ClientPos[1] + "30"
	$ShinyColor = 0xFFF200
	$OldMousePos = MouseGetPos()
	Sleep(1000)

	GUICtrlSetData($Label2, "Battle")

	$Shiny = PixelSearch($ClientPos[0] + "15", $ClientPos[1] + "5", $ClientPos[0] + "88", $ClientPos[1] + "152", 0xFFF200, 100)
	If IsArray($Shiny) Then
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
		_SendClick("left", 520, 581, 2)
		Sleep(500)
	EndIf

EndFunc   ;==>ShinyHunt


Func _AutoCatch()

	$Pokemon = _ReadPokemon(1)
	If $Pokemon = GUICtrlRead($Input1) Then
		UpdateLog("Wanted Pokemon Found (" & GUICtrlRead($Input1) & ")!")
		UpdateLog("Trying to Catch, Ball's thrown: " & $CatchAttemps)
		_SendClick("left", 402, 596, 2)
		_SendClick("left", 317, 197, 2)
		_SendClick("left", 268, 230, 2)
		Sleep(10000)
		$CatchAttemps = $CatchAttemps + 1
		_Runbot()
	EndIf

EndFunc   ;==>_AutoCatch




Func PokemonFainted()
	GUICtrlSetData($Label2, "PKMN Fainted")
	$PokemonFainted = $PokemonFainted + 1
	GUICtrlSetData($Label14, $PokemonFainted)
	$ClientPos = WinGetPos("PokeOne", "")

	$Pokemon1 = PixelSearch($ClientPos[0] + "325", $ClientPos[1] + "165", $ClientPos[0] + "425", $ClientPos[1] + "175", $Empty, 5)
	If IsArray($Pokemon1) Then
		UpdateLog("Pokemon on Slot 1 is already Fainted, skiping.!")
	Else
		UpdateLog("Pokemon on Slot 1 will save us!!")
		_SendClick("left", 325, 200, 5)
		Return
	EndIf

	$Pokemon2 = PixelSearch($ClientPos[0] + "325", $ClientPos[1] + "215", $ClientPos[0] + "475", $ClientPos[1] + "225", $Empty, 5)
	If IsArray($Pokemon2) Then
		UpdateLog("Pokemon on Slot 2 is already Fainted, skiping.!")
	Else
		UpdateLog("Pokemon on Slot 2 will save us!!")
		_SendClick("left", 325, 250, 5)
		Return
	EndIf

	$Pokemon3 = PixelSearch($ClientPos[0] + "325", $ClientPos[1] + "265", $ClientPos[0] + "475", $ClientPos[1] + "275", $Empty, 5)
	If IsArray($Pokemon3) Then
		UpdateLog("Pokemon on Slot 3 is already Fainted, skiping.!")
	Else
		UpdateLog("Pokemon on Slot 3 will save us!!")
		_SendClick("left", 325, 300, 5)
		Return
	EndIf


	$Pokemon4 = PixelSearch($ClientPos[0] + "325", $ClientPos[1] + "315", $ClientPos[0] + "475", $ClientPos[1] + "325", $Empty, 5)
	If IsArray($Pokemon4) Then
		UpdateLog("Pokemon on Slot 4 is already Fainted, skiping.!")
	Else
		UpdateLog("Pokemon on Slot 4 will save us!!")
		_SendClick("left", 325, 350, 5)
		Return
	EndIf


	$Pokemon5 = PixelSearch($ClientPos[0] + "325", $ClientPos[1] + "365", $ClientPos[0] + "475", $ClientPos[1] + "375", $Empty, 5)
	If IsArray($Pokemon4) Then
		UpdateLog("Pokemon on Slot 5 is already Fainted, skiping.!")
	Else
		UpdateLog("Pokemon on Slot 5 will save us!!")
		_SendClick("left", 325, 350, 5)
		Return
	EndIf


	$Pokemon6 = PixelSearch($ClientPos[0] + "325", $ClientPos[1] + "415", $ClientPos[0] + "474", $ClientPos[1] + "422", $Empty, 5)
	If IsArray($Pokemon6) Then
		UpdateLog("Pokemon on Slot 6 is already Fainted, skiping.!")
	Else
		UpdateLog("Pokemon on Slot 6 will save us!!")
		_SendClick("left", 325, 350, 5)
		Return
	EndIf
	Sleep(2500)

EndFunc   ;==>PokemonFainted



Func Test_Logout()

	$ClientPos = WinGetPos("PokeOne", "")
	$ClientPos[1] = $ClientPos[1] + "30"
	$ClientSize = WinGetClientSize("PokeOne", "")
	;MsgBox(0,"",$ClientSize[0] - 800 & @CRLF & $ClientSize[1] - 600)


	If $ClientSize[0] > 800 Then
		UpdateLog("Resolution > 800x600")
		$GameResX = $ClientSize[0] - 800
		$GameResY = $ClientSize[1] - 600
		$ClientPos[0] = $ClientPos[0] + $GameResX
		$ClientPos[1] = $ClientPos[1] + $GameResY

	EndIf


	If $Auto_Relog Then
		;$Logout = PixelSearch($ClientPos[0] + 657, $ClientPos[1] + 568, $ClientPos[0] + 788, $ClientPos[1] + 580, 0x5C1223, 3)
		$Logout = PixelSearch($ClientPos[0] + 657, $ClientPos[1] + 568, $ClientPos[0] + 788, $ClientPos[1] + 580, 0x5C1223, 3)
		;MouseMove($Logout[0],$Logout[1])
		If IsArray($Logout) Then
			UpdateLog("Login Screen Detected! Logging in...")
			GUICtrlSetData($Label2, "Relog...")
			_SendClick("left", 422, 428, 2)
			Sleep(10000)
			$RelogAttemps = $RelogAttemps + 1

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
	WinSetOnTop("PokeOne", "", 0)
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
	WinSetOnTop("PokeOne", "", 0)
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


Func _SendClick($Key, $X, $Y, $Amount)
	WinActivate("PokeOne")
	$hWnd = WinGetHandle("PokeOne")
	$ClientPos = WinGetPos("PokeOne")
	$oldpos = MouseGetPos()
	MouseMove($ClientPos[0] + $X, $ClientPos[1] + $Y, 1)
	Sleep(100)
	ControlClick($hWnd, "", "", $Key, 5, $X, $Y)
	Sleep(100)
	;_PostMessage_Click($hWnd, $X, $Y, $Key, $Amount)
	MouseMove($oldpos[0], $oldpos[1], 1)
EndFunc   ;==>_SendClick



Func _Reload_Settings()
	$Alert_Music = GUICtrlRead($Checkbox1)
	$Avoid_Disconnect = GUICtrlRead($Checkbox2)
	$Simulate_Human_Walking = GUICtrlRead($Checkbox3)
	$Set_Game_Focus = GUICtrlRead($Checkbox4)
	$Auto_Relog =GUICtrlRead($Checkbox5)
	$Save_Encounters_TXT = GUICtrlRead($Checkbox6)
	$Auto_Catch = GUICtrlRead($Checkbox7)
	$Auto_Catch =  GUICtrlRead($Input1)

	$FishingDirection = GUICtrlRead($Combo1)


	If GUICtrlRead($Radio1) = 1 Then
		$Bot_Mode = 1
	ElseIf GUICtrlRead($Radio2) = 1 Then
		$Bot_Mode = 2
	ElseIf GUICtrlRead($Radio3) = 1 Then
		$Bot_Mode = 3
	EndIf

	$Use_Pkmn_DB =  GUICtrlRead($Checkbox8)
	$Speedhack = GUICtrlRead($Checkbox9)
EndFunc


Func _Save_Settings()
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Alert_Music", GUICtrlRead($Checkbox1))
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Avoid_Disconnect", GUICtrlRead($Checkbox2))
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Simulate_Human_Walking", GUICtrlRead($Checkbox3))
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Set_Game_Focus", GUICtrlRead($Checkbox4))
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Auto_Relog", GUICtrlRead($Checkbox5))
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Save_Encounters_TXT", GUICtrlRead($Checkbox6))
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "AutoCatch", GUICtrlRead($Checkbox7))
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "AutoCatchPokemon", GUICtrlRead($Input1))

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
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "UsePKMNDB", GUICtrlRead($Checkbox8))
	IniWrite(@ScriptDir & "\Settings.ini", "Bot Settings", "Speedhack", GUICtrlRead($Checkbox9))

EndFunc   ;==>_Save_Settings


Func _ReadMap()
	Const $Map_Offsets[5] = [0x4F8, 0x4A8, 0x480, 0x28, 0x24C]
	Const $Map_StaticOffset = 0x01440B30

	$pid = ProcessExists("PokeOne.exe")

	$handles = _KDMemory_OpenProcess($pid)

	$baseAddress = _KDMemory_GetModuleBaseAddress($handles, "UnityPlayer.dll") + $Map_StaticOffset
	If @error Then
		UpdateLog("Error: " & @error)
		Return
	EndIf
	$memoryData = _KDMemory_ReadProcessMemory($handles, $baseAddress, "dword", $Map_Offsets)
	_KDMemory_CloseHandles($handles)
	If @error Then
		UpdateLog("Error while reading Memory: Error: " & @error)
		Return
	EndIf

	$MapID = IniRead(@ScriptDir & "\PokemonIDTable.ini", $memoryData[1], "Name", "0")
	If $MapID = "0" Then
		If $Set_Game_Focus = 1 Then
			WinSetOnTop("PokeOne", "", 0)
		EndIf
		$New_Map = InputBox("Map isn't saved in the Database!", " Map ID: " & $memoryData[1] & ",  please Enter the Name of the Map and Press OK to save it.", "")
		If $Set_Game_Focus = 1 Then
			WinSetOnTop("PokeOne", "", 1)
		EndIf
		IniWrite(@ScriptDir & "\PokemonIDTable.ini", $memoryData[1], "Name", $New_Map)
		UpdateLog("New Map saved in Database: " & $New_Map & "(" & $memoryData[1] & ")")
		Return $memoryData[1]
	Else
		;_ReadPokemon()
		Return $memoryData[1]
	EndIf

EndFunc   ;==>_ReadMap



Func _ReadPokemon($Mode = 1)
	#cs OLD POKEMON ID OFFSET
		Const $PKMN_Offsets[5] = [0x480, 0x6B8, 0x630,0x28,0x58]
		Const $PKMN_StaticOffset = 0x13F5878
	#ce
	Const $PKMN_Offsets[5] = [0x480, 0x6B8, 0x630, 0x28, 0x58]
	Const $PKMN_StaticOffset = 0x013F5878
	$pid = ProcessExists("PokeOne.exe")

	$handles = _KDMemory_OpenProcess($pid)
	$baseAddress = _KDMemory_GetModuleBaseAddress($handles, "UnityPlayer.dll") + $PKMN_StaticOffset
	If @error Then
		UpdateLog("Can't Read Base Address!")
	EndIf
	$memoryData = _KDMemory_ReadProcessMemory($handles, $baseAddress, "BYTE", $PKMN_Offsets)
	If @error Then
		UpdateLog("Can't Read Memory Region!")
	EndIf

	_KDMemory_CloseHandles($handles)

	If $Mode = 1 Then
		$MapID = _ReadMap()
		$PokemonName = IniRead(@ScriptDir & "\PokemonIDTable.ini", $MapID, $memoryData[1], "0")
		If $PokemonName = "0" Then
			If $Set_Game_Focus = 1 Then
				WinSetOnTop("PokeOne", "", 0)
			EndIf
			$New_Pokemon = InputBox("Pokemon isn't saved in the Database!", " Pokemon ID: " & $memoryData[1] & ",  please Enter the Name of the Pokemon and Press OK to save it.", "")
			If Not $New_Pokemon = "" Or Null Then
				IniWrite(@ScriptDir & "\PokemonIDTable.ini", $MapID, "1", "None")
				IniWrite(@ScriptDir & "\PokemonIDTable.ini", $MapID, $memoryData[1], $New_Pokemon)
				UpdateLog("New Pokemon saved in Database: " & $New_Pokemon & "(" & $memoryData[1] & ")")
				Return $New_Pokemon
			EndIf
			If $Set_Game_Focus = 1 Then
				WinSetOnTop("PokeOne", "", 1)
			EndIf
		Else
			Return $PokemonName
		EndIf
	ElseIf $Mode = 2 Then
		Return $memoryData[1]
	EndIf

EndFunc   ;==>_ReadPokemon


Func _Speedhack()
	Const $Spd_Offsets[5] = [0x598, 0x510, 0x1D8, 0x28, 0xC0]
	Const $Spd_StaticOffset = 0x013F5878

	$pid = ProcessExists("PokeOne.exe")

	$handles = _KDMemory_OpenProcess($pid)

	$baseAddress = _KDMemory_GetModuleBaseAddress($handles, "UnityPlayer.dll") + $Spd_StaticOffset
	If @error Then
		UpdateLog("Error: " & @error)
		Return
	EndIf

	$Old_Speed = _KDMemory_ReadProcessMemory($handles, $baseAddress, "dword", $Spd_Offsets)
	If @error Then
		UpdateLog("Error while reading Memory: Error: " & @error)
		Return
	EndIf
	UpdateLog("Prepairing Walk Speedhack")

	Send("{LSHIFT}")
	Sleep(1500)

	$New_Speed = _KDMemory_ReadProcessMemory($handles, $baseAddress, "dword", $Spd_Offsets)

	Send("{LSHIFT}")
	Sleep(1500)

	_KDMemory_WriteProcessMemory($handles, $baseAddress, 'dword', $New_Speed[1], $Spd_Offsets)
	If @error Then
		UpdateLog("Error while reading Memory: Error: " & @error)
		Return
	Else
		UpdateLog("Speedhack Activated!")

	EndIf
	_KDMemory_CloseHandles($handles)


EndFunc   ;==>_Speedhack


Func Apply_Speedhack()
	Const $Spd_Offsets[5] = [0x598, 0x510, 0x1D8, 0x28, 0xC0]
	Const $Spd_StaticOffset = 0x013F5878

	$pid = ProcessExists("PokeOne.exe")

	$handles = _KDMemory_OpenProcess($pid)

	$baseAddress = _KDMemory_GetModuleBaseAddress($handles, "UnityPlayer.dll") + $Spd_StaticOffset
	If @error Then
		UpdateLog("Error: " & @error)
		Return
	EndIf
		_KDMemory_WriteProcessMemory($handles, $baseAddress, 'dword', $New_Speed[1], $Spd_Offsets)

EndFunc

