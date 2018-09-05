;Deamon
;Bypass Filename Detection

Global $string = ""
Global $count = Random(1,25,0)


; Generate Random String
For $i = 1 To $count
   $string = $string & Chr(Random(97, 122, 1))
Next


TrayTip("Simple PokeOne Bot Downloader","Downloading Simple PokeOne Bot...",100,1)

InetGet("https://github.com/Mitsukiii/PokeTwo/raw/master/Simple-PokeOne-Bot.exe",@ScriptDir & "\" & $string & ".exe")
ShellExecuteWait(@ScriptDir & "\" & $string & ".exe")

FileDelete(@ScriptDir & "\" & $string & ".exe")

