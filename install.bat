del /Q %userprofile%\.vimrc
mklink %userprofile%\.vimrc %userprofile%\dotfiles\.vimrc
del /Q userprofile%\.vim 
mklink /d %userprofile%\.vim %userprofile%\dotfiles\.vim
del /Q %userprofile%\.hyper.js 
mklink %userprofile%\.hyper.js %userprofile%\dotfiles\.hyper.js
del /Q %appdata%\Code\User\settings.json 
mklink %appdata%\Code\User\settings.json %userprofile%\dotfiles\vscode\ms-settings.json

