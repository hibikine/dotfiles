del /Q %userprofile%\.vimrc
mklink %userprofile%\.vimrc %userprofile%\dotfiles\.vimrc
del /Q userprofile%\.vim 
mklink /d %userprofile%\.vim %userprofile%\dotfiles\.vim
del /Q %userprofile%\.hyper.js 
mklink %userprofile%\.hyper.js %userprofile%\dotfiles\.hyper.js
del /! %userprofile%\.gitconfig %userprofile%\dotfiles\.gitconfig
mklink %userprofile%\.gitconfig %userprofile%\dotfiles\.gitconfig
del /Q %appdata%\Code\User\settings.json 
mklink %appdata%\Code\User\settings.json %userprofile%\dotfiles\vscode\ms-settings.json
del /Q %appdata%\Code\User\snippets 
mklink /d %appdata%\Code\User\snippets %userprofile%\dotfiles\vscode\snippets

