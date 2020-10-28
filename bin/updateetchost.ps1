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


$(Get-Content "C:\Windows\System32\drivers\etc\hosts" -Raw) -replace "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\s*socialdog", $($(wsl /home/hibikine/dotfiles/bin/getwslip.sh) + " socialdog") | Set-Content -Path "C:\Windows\System32\drivers\etc\hosts"

Stop-Process -Name "powershell"