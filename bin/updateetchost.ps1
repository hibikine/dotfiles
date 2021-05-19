# updateetchost.ps1

function Log(
    $LogString
) {

    # ログの出力先
    $LogPath = "C:\Log"

    # ログファイル名
    $LogName = "ExecutLog"

    $Now = Get-Date

    # Log 出力文字列に時刻を付加(YYYY/MM/DD HH:MM:SS.MMM $LogString)
    $Log = $Now.ToString("yyyy/MM/dd HH:mm:ss.fff") + " "
    $Log += $LogString

    # ログファイル名が設定されていなかったらデフォルトのログファイル名をつける
    if ( $LogName -eq $null ) {
        $LogName = "LOG"
    }

    # ログファイル名(XXXX_YYYY-MM-DD.log)
    $LogFile = $LogName + "_" + $Now.ToString("yyyy-MM-dd") + ".log"

    # ログフォルダーがなかったら作成
    if ( -not (Test-Path $LogPath) ) {
        New-Item $LogPath -Type Directory
    }

    # ログファイル名
    $LogFileName = Join-Path $LogPath $LogFile

    # ログ出力
    Write-Output $Log | Out-File -FilePath $LogFileName -Encoding Default -append

    # echo させるために出力したログを戻す
    Return $Log
}


param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}


if ((Test-Admin) -eq $false) {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    }
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition, $action))
    }
    exit
}

'running with full privileges'

Copy-Item C:\Windows\System32\drivers\etc\hosts ~/dotfiles/tmp/hosts
$domain = "socialdog"
$wslIp = $(wsl ip a | wsl grep --extended-regexp "172\.\[0-9]\{1,3}\.\[0-9]\{1,3}\.\[0-9]\{1,3\}" -m1 -o | wsl head -n 1)

if ([string]::IsNullOrEmpty($wslIp)) {
    Log("Error: can't get wslIp.")
    Stop-Process -Name "powershell"
    exit 1
}

$originalEtcHost = Get-Content "C:\Windows\System32\drivers\etc\hosts" -Raw

if ([string]::IsNullOrEmpty($originalEtcHost)) {
    Log("Error: can't get etc/host. Got text is empty or null.")
    Stop-Process -Name "powershell"
    exit 1
}

$replacedText = $originalEtcHost -replace "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\s*$domain", $($wslIp + " $domain")

$editedEtcHost = $($replacedText | out-string).trim()
Log($editedEtcHost)

if ([string]::IsNullOrEmpty($originalEtcHost)) {
    Log("Error: the editedEtcHost is empty.")
    Stop-Process -Name "powershell"
    exit 1
}

Set-Content -Path "C:\Windows\System32\drivers\etc\hosts" -Value $editedEtcHost

Stop-Process -Name "powershell"
