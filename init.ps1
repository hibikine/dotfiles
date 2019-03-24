Get-Command choco -ea SilentlyContinue | Out-Null
if ($? -eq $false) {
  Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
  $newPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
  $newPath += ";$($Env:ALLUSERSPROFILE)\"
  [System.Environment]::SetEnvironmentVariable("Path", $newPath, "User")
}
choco install firefox -y
choco install googlechrome -y
choco install javaruntime -y
choco install lhaplus -y

Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
scoop bucket add extras
scoop bucket add hibikine https://github.com/HibikineKage/scoop-bucket
scoop bucket add mushus https://github.com/mushus/scoop-bucket
scoop install git
scoop install openssh
[Environment]::SetEnvironmentVariable("GIT_SSH", (Resolve-Path (scoop which ssh)), 'USER')
scoop install php
scoop install composer
scoop install vscode
scoop install nodejs
scoop install yarn
scoop install notepadplusplus -y

composer global require friendsofphp/php-cs-fixer

