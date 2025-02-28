# 管理者権限で実行されているかどうかを判定する関数
function Test-Admin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal]$currentUser
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

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

function ls-grep {
    param (
        [string]$searchText
    )
    Get-ChildItem | Where-Object { $_.Name -match $searchText }
}

# @see https://stackoverflow.com/questions/1287718/how-can-i-display-my-current-git-branch-name-in-my-powershell-prompt
# (c) @tamj0rd2
function Write-BranchName () {
    try {
        $branch = git rev-parse --abbrev-ref HEAD

        if ($branch -eq "HEAD") {
            # we're probably in detached HEAD state, so print the SHA
            $branch = git rev-parse --short HEAD
            Write-Host " ($branch)" -NoNewLine -ForegroundColor "red"
        }
        else {
            # we're on an actual branch, so print it
            Write-Host " ($branch)" -NoNewLine -ForegroundColor "blue"
        }
    }
    catch {
        # we'll end up here if we're in a newly initiated git repo
        Write-Host " (no branches yet)" -NoNewLine -ForegroundColor "yellow"
    }
}

function Write-Git-Diff {
    $gitStatus = git status -s
    if ($gitStatus) {
        Write-Host " *" -NoNewLine -ForegroundColor "red"
    }
}

if (-not (Test-Admin)) {
    function Show-Notification {
        [cmdletbinding()]
        Param (
            [string]
            $ToastTitle,
            [string]
            [parameter(ValueFromPipeline)]
            $ToastText
        )

        if (-not (Test-Path -Path "$PROFILE/../WinRT.Runtime.dll")) {
            Invoke-WebRequest https://github.com/Windos/BurntToast/raw/main/BurntToast/lib/Microsoft.Windows.SDK.NET/WinRT.Runtime.dll -OutFile $PROFILE/../WinRT.Runtime.dll
        }
        if (-not(Test-Path -Path "$PROFILE/../Microsoft.Windows.SDK.NET.dll")) {
            Invoke-WebRequest https://github.com/Windos/BurntToast/raw/main/BurntToast/lib/Microsoft.Windows.SDK.NET/Microsoft.Windows.SDK.NET.dll -OutFile $PROFILE/../Microsoft.Windows.SDK.NET.dll
        }
        Add-Type -Path $PROFILE/../WinRT.Runtime.dll
        Add-Type -Path $PROFILE/../Microsoft.Windows.SDK.NET.dll

        $Template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)

        $RawXml = [xml] $Template.GetXml()
        ($RawXml.toast.visual.binding.text | where { $_.id -eq "1" }).AppendChild($RawXml.CreateTextNode($ToastTitle)) > $null
        ($RawXml.toast.visual.binding.text | where { $_.id -eq "2" }).AppendChild($RawXml.CreateTextNode($ToastText)) > $null

        $SerializedXml = New-Object Windows.Data.Xml.Dom.XmlDocument
        $SerializedXml.LoadXml($RawXml.OuterXml)

        $Toast = [Windows.UI.Notifications.ToastNotification]::new($SerializedXml)
        $Toast.Tag = "PowerShell"
        $Toast.Group = "PowerShell"
        $Toast.ExpirationTime = [DateTimeOffset]::Now.AddMinutes(1)

        $Notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("PowerShell")
        $Notifier.Show($Toast);
    }
}

function prompt {
    Write-Host "`r`nPS " -NoNewline
    Write-Host $(Get-Location) -NoNewLine -ForegroundColor "green"
    $dir = Get-Location
    while ($dir -ne [System.IO.Path]::GetPathRoot($dir)) {
        $gitPath = Join-Path $dir '.git'
        if (Test-Path $gitPath) {
            Write-BranchName
            Write-Git-Diff
            break
        }
        $dir = Split-Path $dir -Parent
    }
    $out = "`r`n> "

    $loc = $executionContext.SessionState.Path.CurrentLocation;
    if ($loc.Provider.Name -eq "FileSystem") {
        $out = "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\" + $out
    }
    return $out
}

function rm-rf {
    Remove-Item -Path $args -Force -Recurse
}

function youtube-dl-best() {
    youtube-dl -f bestvideo+bestaudio --merge-output-format mp4 $args[0]
}
if (-not (Test-Admin)) {
    # ユーザーモード
    $module = Get-Module -ListAvailable -Name PSFzf
    if (-not $module) {
        Write-Host "PSFzf is not installed."
        Write-Host "Please run this command:"
        Write-Host "Install-Module -Name PSFzf -Scope CurrentUser -Force"
    } else {
        Import-Module PSFzf
        Enable-PsFzfAliases
    }

    $module = Get-Module -ListAvailable -Name ZLocation
    if (-not $module) {
        Write-Host "ZLocation is not installed."
        Write-Host "Please run this command:"
        Write-Host "Install-Module -Name ZLocation -Scope CurrentUser -Force"
    } else {
        Import-Module ZLocation
    }
} else {
    # 管理者
}

$service = Get-Service -Name ssh-agent
if ($service.StartType -eq 'Disabled') {
    Write-Host "ssh-agent service is disabled."
} else {
    Write-Host "ssh-agent service is not disabled."
    Start-Service ssh-agent
    # ssh-add $env:USERPROFILE/.ssh/id_ed25519
}

if (-not (Test-Admin)) {
    $module = Get-Module -ListAvailable -Name npm-completion
    if (-not $module) {
        Write-Host "npm-completion is not installed."
        Write-Host "Please run this command:"
        Write-Host "Install-Module -Name npm-completion -Scope CurrentUser -Force"
    } else {
        Import-Module npm-completion
    }
}

# chcp 65001
# [Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding('utf-8')

if (-not (Test-Admin)) {
    Import-Module Posh-Git
}

# https://learn.microsoft.com/ja-jp/windows/package-manager/winget/tab-completion
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
        $Local:ast = $commandAst.ToString().Replace('"', '""')
        winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}
