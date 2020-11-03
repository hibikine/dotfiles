if (Test-Path "~\Desktop") {
  Get-ChildItem "~\Desktop\*.lnk" | Remove-Item
}

if (Test-Path "~\OneDrive\デスクトップ") {
  Get-ChildItem "~\OneDrive\デスクトップ\*.lnk" | Remove-Item
}

exit