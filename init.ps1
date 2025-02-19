Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
winget install -e Git.Git
winget install -e Schezo.Lhaplus
winget install
[Environment]::SetEnvironmentVariable("GIT_SSH", (Resolve-Path (scoop which ssh)), 'USER')
winget install -e Microsoft.VisualStudioCode
winget install -e Schniz.fnm
winget install -e sharkdp.bat
winget install -e Rye.Rye
winget install -e GnuPG.Gpg4win
winget install -e Google.Chrome
winget install -e Mozilla.Firefox.Nightly
winget install -e Rustlang.Rustup
winget install -e junegunn.fzf
