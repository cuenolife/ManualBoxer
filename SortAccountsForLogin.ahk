/*		Author: 	CueNoLife
		Title:		Account Sorter - Sorting accounts from file into readable user:pass format for LogMeIn.ahk
		Version: 	1.0
		Twitter:	https://twitter.com/cuenolife
		Twitch:		https://twitch.tv/cuenolife
		Discord:	https://discord.gg/zXpcvBp
*/
MsgBox, WARNING - WARNING - WARNING - WARNING `nBefore pressing [F1] make sure you setup your Accounts+Passwords in their respective folders ("AltAccs.txt" and "AltPass.txt") line count must match (4 accounts + 4 passwords) if they're the same change line 27 pass[A] to pass[1] and only put 1 password in your password file then reload the script (NOT RECOMMENDED for stability)
If FileExist(AltPass.txt) {
} else {
FileAppend, 1 line per pass corresponding to AltAccs.txt
}
If FileExist (AltAccs.txt) {
} else {
FileAppend, 1 line per acc corresponding to AltPass.txt
}

F1::
MsgBox, Attempting to read files and append them locally
FileRead, aArray,AltAccs.txt
FileRead, pArray,AltPass.txt
accS := StrSplit(aArray, "`n")
pasS := StrSplit(pArray, "`n")
A=1
Loop, % accS.MaxIndex(){
FileAppend, % RegExReplace(accS[A], "\R")":",AccountsSetup.txt
If (A_Index = accS.MaxIndex()){
FileAppend, % pasS[A],AccountsSetup.txt

} else {
FileAppend, % RegExReplace(pass[A], "\R")":",AccountsSetup.txt
}
A++
}
MsgBox, % accS.MaxIndex()-1 " accounts have been successfulled added to AccountSetup.txt - Exiting App"

Return