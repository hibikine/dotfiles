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
$($(Get-Content "C:\Windows\System32\drivers\etc\hosts" -Raw) -replace "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\s*$domain", $($(wsl ip a | wsl grep --extended-regexp "172\.\[0-9]\{1,3}\.\[0-9]\{1,3}\.\[0-9]\{1,3\}" -m1 -o | wsl head -n 1) + " $domain") | out-string).trim() | Set-Content -Path "C:\Windows\System32\drivers\etc\hosts"

Stop-Process -Name "powershell"