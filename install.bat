del /Q "%userprofile%\.vimrc"
mklink "%userprofile%\.vimrc" "%userprofile%\dotfiles\.vimrc"
rmdir /s /q "%userprofile%\.vim" 
mklink /d "%userprofile%\.vim" "%userprofile%\dotfiles\.vim"
del /Q "%userprofile%\.hyper.js" 
mklink "%userprofile%\.hyper.js" "%userprofile%\dotfiles\.hyper.js"
del /Q "%userprofile%\.gitconfig"
mklink "%userprofile%\.gitconfig" "%userprofile%\dotfiles\.gitconfig-win"
if exist "%userprofile%\dotfiles\dotfiles-priv\" (goto DOTFILES_TRUE) else goto DOTFILES_FALSE

:DOTFILES_TRUE
del /Q "%appdata%\Code\User\settings.json" 
mklink "%appdata%\Code\User\settings.json" "%userprofile%\dotfiles\dotfiles-priv\vscode\ms-settings.json"
del /Q "%appdata%\Code\User\keybindings.json" 
mklink "%appdata%\Code\User\keybindings.json" "%userprofile%\dotfiles\dotfiles-priv\vscode\ms-keybindings.json"
rmdir /Q "%appdata%\Code\User\snippets"
mklink /d "%appdata%\Code\User\snippets" "%userprofile%\dotfiles\dotfiles-priv\vscode\snippets"
:DOTFILES_FALSE

del /Q "%appdata%\Notepad++\config.xml"
mklink "%appdata%\Notepad++\config.xml" "%userprofile%\dotfiles\Notepad++\config.xml"
del /Q "%userprofile%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
mklink /D "%userprofile%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" "%userprofile%\dotfiles\Microsoft.PowerShell_profile.ps1"
