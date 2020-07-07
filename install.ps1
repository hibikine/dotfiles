if (Test-Path $profile) {
  Remove-Item $profile
}
New-Item -Path ($profile -replace "\\[\w\d.]+$", "") -Name ((New-Object regex("[\w\d.]+$")).Matches($profile).Groups[0].Value) -Value (Convert-Path .\Microsoft.PowerShell_profile.ps1) -ItemType SymbolicLink
