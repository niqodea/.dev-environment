#Requires AutoHotkey v2.0

#c:: {
	UserProfile := EnvGet("UserProfile")
	Run(UserProfile "\Scripts\WslToWinClipboard.bat", , "Hide")
}
#y:: {
	UserProfile := EnvGet("UserProfile")
	Run(UserProfile "\Scripts\WinToWslClipboard.bat", , "Hide")
}