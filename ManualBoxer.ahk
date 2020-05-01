/*		Author: 	CueNoLife
		Title:		Manual Boxer - "Multi-boxing, but without the mouse broadcasting compatibility for OSRS"
		Version: 	1.1
		Twitter:	https://twitter.com/cuenolife
		Twitch:		https://twitch.tv/cuenolife
		Discord:	https://discord.gg/zXpcvBp
				
		DISCLAIMER: USE AT YOUR OWN RISK. By using this "Software" you agree that you accept full responsibility of any actions taken against you and I ("CueNoLife") am not liable
		for any interruptions in services you encounter. 
		
		RECOMMENDED: Do NOT run Manual Boxer unless you are 100% certain it came from CueNoLife. I will ALWAYS have !MBoxer as a command with the latest version
		in my twitch channel. If I REMOVE that command, it is recommended, unless you know me personally, or know how to read code to not run ANY new versions of Manual Boxer.
		With every new useful utility that is released, comes with imposters, and fakes designed to hack you! ManualBoxer will NEVER be converted to '.exe' so please be careful.
		
		
		Manual Boxer is a Manual Multi Box program. Unlike most Multi Box software, this software does NOT broadcast/mirror mouse input to each client. It's more of a utility
		tool to allow the stacking and easy switching of clients. With the added "login" features as well. (MainAccPass,AltPass,AltAccountUserNames). I did NOT intend for Manual
		Boxer to be used as a gold-farming, game breaking utility. It's a simple tool with a simple purpose. I intended on using it for my own personal benefit and projects, but
		I decided to allow those of you with access to it, to also use it for your own personal benefit.
		
	    README INSTRUCTIONS (for people who only have ManualBoxer.ahk and not ManualBoxer.zip):
	    -Save this file as ManualBoxer.ahk ("File" -> "Save As" -> ManualBoxer.ahk -> Save as Type -> (*.*)
	    -Run ManualBoxer.ahk once
        -Click "SHIFT+ALT+Q" to close ManualBoxer
	    -Locate ManualBoxer folder that was created. (You can move this folder wherever you want now)
        -Create a new loginR.png (Screenshot and crop the R from the login screen and make sure to save as loginR.png)
	    -Run the new ManualBoxer.ahk
	    -PROFIT???
		
		Helpful Search Feature : *CTRL+F*
		To change a HOTKEY, just edit the names behind the "::" for example: HOME:: represents the HOME KEY ... Change HOME:: to F1:: to set the script to use F1 instead of HOME
		Changing the names in this section will NOT change the hotkeys. Use CTRL+F to find where in the file each function EXAMPLE: CTRL+F -> Home:: -> Find NEXT
		
		HOME:: 	PROMPTS CLIENT NAME INPUT (EX. RuneLite, OpenOSRS, OSBuddy, Old School Runescape)			(HOME KEY)
		+!d::	LOGIN TO ALTS (Must setup: AltAccountUserNames and AltPass(only supports 1 password) first) (SHIFT + ALT + d)
		F9::	Center your Client (after using "HOME::"
		F8::	Checks to be sure you hooked the right client name into "HOME::"
		+!c::	SETS USERINPUT ClientCount / MAX_CLIENTS to be used (useful if you don't want the script interacting with windows you don't want to switch to (SHIFT + ALT + c)
		+!m::	LOGIN TO YOUR MAIN account (DEFAULT: 1) passwords here must match as well (for now until updated) (SHIFT + ALT + m)
		TAB::	TABS TO THE NEXT Client
		+TAB::	TABS TO THE PREVIOUS Client (SHIFT + TAB)
		+!q::	Closes Script (SHIFT + ALT + Q)
		`::		Suspends Script On a toggle so you can use your keyboard again. However, since ` is used as a toggle, pushing it will not give the ` it's functionality back except
				for the toggle.
		For your convenience and benefit, be sure to update this "Helpful Search Feature" with your new hotkeys if you change them in the future.
		
		WARNING: Changing this file name could cause the script to lose functionality. Changes made here MUST be made across
		he whole entire script. I am NOT obligated to help you, or show you how to fix it if you break it. However, if you ruin
		it, you can just delete the folder, and rextract to get the DEFAULT values back. :)

*/
#SingleInstance
CenterWindow(WinTitle) ;; credit to https://www.autohotkey.com/docs/commands/WinMove.htm for this function
{
    WinGetPos,,, Width, Height, %WinTitle%
    WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
}
DEFAULT_CLIENT = RuneLite ;; CHANGE to your CLIENT OF CHOICE (will default to this if you leave "HOME::" window blank
DEFAULT_MAX_CLIENTS = 4 	;; Fail-safe for how many clients to switch between (change if you think it's necessary) ;;
MAX_CLIENTS = %maxClients%  ;; DONT TOUCH THIS line 22 will handle this ;;
c := 1 ;;	DONT CHANGE THIS SETTING - Starting Index;;
a := 1 ;;	DONT CHANGE THIS SETTING - Starting Index;;

InputBox, maxClients, Client Count,How Many Clients?, ,(A_ScreenWidth/14),(A_ScreenHeight/8) ;; PROMPTS USER to set how many CLIENTS they want. DEFAULT: Line 17 ;;
If ErrorLevel {
	MsgBox, Client count set to (DEFAULT:%DEFAULT_MAX_CLIENTS%)
	MAX_CLIENTS = %DEFAULT_MAX_CLIENTS% ;; AGAIN - Defaults to LINE 34 if you "CANCEL" the prompt.
} else if (maxClients=""){
	MsgBox, Client count set to (DEFAULT:%DEFAULT_MAX_CLIENTS%)
	MAX_CLIENTS = %DEFAULT_MAX_CLIENTS%
}
else{
MsgBox, Client count set to %maxClients%
    MAX_CLIENTS = %maxClients%
}
If (A_ScriptDir == A_Desktop){ ;; Checks to make sure you didn't save to DESKTOP ... Creates a ManualBoxer folder otherwise (any folder name will do as long as it's not saved to desktop.
	MsgBox, Move your files to a seperate folder for security, and tidiness. For your convenience, the script has auto-created ManualBoxer folder. You can make a shortcut to your desktop after the new ahk file has been copied over!
	FileCreateDir, ManualBoxer
	SetWorkingDir, ManualBoxer
	FileCopy, %A_ScriptDir%\ManualBoxer.ahk , ManualBoxer.ahk
	} else {
	}
If FileExist(A_ScriptDir . "\MainAccPass.txt"){ ;; WARNING: Changing this file name could cause the script to lose functionality. Changes made here MUST be made across
												;;	the whole entire script. I am NOT obligated to help you, or show you how to fix it if you break it. However, if you ruin
												;;	it, you can just delete the folder, and rextract to get the DEFAULT values back. :)

} else {
	MsgBox, The script has created a password file called MainAccPass.txt. Edit the ChangeMe to your own password.
	FileAppend, ChangeMe, MainAccPass.txt ;; If you changed Line 5 , be sure to change the name here as well

}
If FileExist(A_ScriptDir . "\AltAccountUserNames.txt"){
	
	} else {
	MsgBox, You forgot to setup an account file for your alts or changed the name recently. 1 account per line
	FileAppend, 1 Line Per Account, AltAccountUserNames.txt
}
If FileExist(A_ScriptDir . "\AltPass.txt"){
	
	} else {
	MsgBox, You forgot to setup an alt account pass file or changed the name recently.
	FileAppend, ChangeMe, AltPass.txt
}
If FileExist(A_ScriptDir . "\loginR.png"){
} else {
	MsgBox, Create a new loginR.png (Screenshot and crop the R from the login screen and make sure to save as loginR.png)
	exitapp
	}
MsgBox, Everything found successfully! Enjoy the script!`ncreated by @CueNoLife`nOn Twitter and Twitch!
MsgBox,,IMPORTANT HOTKEY INFORMATION - PLEASE READ,DEFAULT HOTKEYS unless changed are as follows`n`nHOME:PROMPTS CLIENT NAME INPUT`n`n(EX. RuneLite, OpenOSRS, OSBuddy, Old School Runescape)`n`nTAB: swaps between all the clients going forward, assuming you have one of them active`n`nShift + Tab: swaps between all the clients going backwards, assuming you have one of them active`n`nShift + Alt + M: INPUTS MAIN PASSWORD (Must setup: MainAccPass.txt`n`nShift + Alt + D: LOGIN TO ALTS (Must setup: AltAccountUserNames.txt and AltPass.txt(only supports 1 password) first).`n`n(Shift + Alt + Q: Closes Script`n`nBe sure to read the hotkeys set above. You can also scan through the script with Notepad.`n`nRECOMMEND: Notepad++.

`::
suspend
return
+!d::
FileRead, AltPass, %A_ScriptDir%\AltPass.txt
FileRead, str, AltAccountUserNames.txt
accN := StrSplit(str, "`n")
if WinActive(titleN){
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %A_ScriptDir%\loginR.png
		if (ErrorLevel = 2){
			MsgBox, Could not conduct said search. Create a new loginR.png (Screenshot and crop the R from the login screen)
			}
		else if (ErrorLevel = 1) {
			MsgBox, I just tried typing my alts password, while logged in. What an idiot.
			}
		else {
			SendInput, % accN[a]
			SendInput, %AltPass% {enter}
			a++
			if (a>4) {
			a := 1
			}
			}
} else {
	MsgBox, Please only type your password in %titleN% clients!
}

return
+!m::
FileRead, MainAccPass, %A_ScriptDir%\MainAccPass.txt
if WinActive(titleN){
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %A_ScriptDir%\loginR.png
		if (ErrorLevel = 2){
			MsgBox, Could not conduct said search. Create a new loginR.png (Screenshot and crop the R from the login screen)
			}
		else if (ErrorLevel = 1) {
			SendInput, I just tried typing my mains password, while logged in. What an idiot.
			}
		else {
			SendInput, %MainAccPass%{enter}
			}
} else {
	sendinput, I just tried typing my mains password, without being inside of my client... What an idiot.
}

return
Home:: ;;OPENS INPUT BOX for your CLIENT_NAME - Instructions inside the box
PreviousClient = %titleN% ;;SETS PREVIOUSCLIENT as THE CURRENT CLIENT before running a LOOP to check for client change
Loop{ ;; Jenky Loop to make sure you input a client name.
InputBox, titleN,Client Name?, CASE SENSITIVE`nBLANK = %DEFAULT_CLIENT%`nOpenOSRS`nOld School RuneScape`nRuneLite`nOSBuddy.,,(A_ScreenWidth/10),(A_ScreenHeight/5)
If ErrorLevel{
	titleN = %PreviousClient%
	break
	} else if (titleN=""){
	MsgBox, You left it blank, so defaulting to %DEFAULT_CLIENT%
	titleN = %DEFAULT_CLIENT%
	break
} else	{

	break
	}
}
r:=""
WinGet windows, List, %titleN%
Loop %windows%
{
	id := windows%A_Index%
	WinGet wt, pid, ahk_id %id%
	r .= wt . "`n"
}

cPIDs := StrSplit(r, "`n")

return
Tab::
if WinActive(titleN){

	c++
	if(c>MAX_CLIENTS){
	c=1
}

WinActivate % "ahk_pid" cPIDs[c]
}
return

+Tab::
if WinActive(titleN){
c--
if(c<1){
c=%MAX_CLIENTS%
}
WinActivate % "ahk_pid" cPIDs[c]

}
return

+!c:: ;;Client Count Changer
InputBox, maxClients,,Client count,,136,131
If ErrorLevel{
	MAX_CLIENTS = %MAX_CLIENTS%
	}
else {
MsgBox, Client count set to %maxClients%
MAX_CLIENTS = %maxClients%
}
return
F8:: ;; Confirms client count and client name is accurate.
MsgBox, CLIENT COUNT:%MAX_CLIENTS%`nPIDS for %titleN%`n%r%
return
F9::
CenterWindow(titleN)
return
+!q::
exitapp
return