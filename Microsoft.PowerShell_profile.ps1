fnm env --use-on-cd | Out-String | Invoke-Expression
Get-ChildItem "$PROFILE\..\Completions\" | ForEach-Object {
    . $_.FullName
}
Get-ChildItem "$PROFILE\..\Local\" | ForEach-Object {
    . $_.FullName
}
function gcom {
  git commit -m $args
}
function gco {
  git commit $args
}

function gc {
  git checkout $args
}

function gp {
  git push $args
}

function gs {
  git status
}


# Git Alias
function Git-Checkout {
    Param($Branch)
    git checkout $Branch
}
function Git-Hyperlog {
    git log --oneline --graph --decorate=full
}
Set-Alias -Name hyperlog -Value Git-Hyperlog
function prompt { "`r`nPS " + $(Get-Location) + "`r`n> " }

function youtube-dl-best() {
  youtube-dl -f bestvideo+bestaudio --merge-output-format mp4 $args[0]
}