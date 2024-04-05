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

function Set-Touch($fileName) {
    New-Item -Path $fileName -ItemType File
}
Set-Alias -Name touch -Value Set-Touch

function Get-Less-Bat {
    bat $args
}
function Get-Less-Cat {
    cat $args
}

if (Get-Command bat -ErrorAction SilentlyContinue) {
    Set-Alias -Name less -Value Get-Less-Bat
}

if (Get-Command cat -ErrorAction SilentlyContinue) {
    Set-Alias -Name less -Value Get-Less-Cat
}

function Get-ChildItem-Sort-By-Date {
    Get-Childitem | Sort-Object -Property LastWriteTime -Descending
}
Set-Alias -Name ls-lt -Value Get-ChildItem-Sort-By-Date

function Get-ChildItem-All {
    Get-ChildItem
}
Set-Alias -Name ls-al -Value Get-ChildItem-All

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
