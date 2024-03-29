if (Get-Command fnm -ErrorAction SilentlyContinue) {
    fnm env --use-on-cd | Out-String | Invoke-Expression
}
if (Test-Path -Path "$PROFILE\..\Completions" -PathType Container) {
    Get-ChildItem "$PROFILE\..\Completions\" | ForEach-Object {
        . $_.FullName
    }
}
if (Test-Path -Path "$PROFILE\..\Local\" -PathType Container) {
    Get-ChildItem "$PROFILE\..\Local\" | ForEach-Object {
        . $_.FullName
    }
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

function Get-Git-Status {
    git status
}
Set-Alias -Name gs -Value Get-Git-Status


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
Import-Module PSFzf
Enable-PsFzfAliases
Import-Module ZLocation

Start-Service ssh-agent
ssh-add $env:USERPROFILE/.ssh/id_ed25519
