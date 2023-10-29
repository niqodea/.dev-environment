@echo off
:: We also need to remove ^M in the Windows clipboard
powershell Get-Clipboard | wsl sh -c "tr -d '\r' | tmux load-buffer -"
