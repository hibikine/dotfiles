# /S サブディレクトリはコピーするが空のサブディレクトリはコピーしない
$SYSDATETIME = (Get-Date -Format "yyyyMMddHHmmss")
$LOGPATH = "C:\\bk\\log"
$LOGFILE = $LOGPATH + "\\backup-ni-files-" + $SYSDATETIME + ".log"
New-Item -ItemType Directory -Force -Path $LOGPATH
$BACKUP_PATH = $env:USERPROFILE + "\Documents\Native Instruments\Battery 4\Kits"
robocopy $BACKUP_PATH "E:\\bk\\Native Instruments\Battery 4\Kits" /S /LOG+:$LOGFILE
robocopy $BACKUP_PATH "F:\\bk\\Native Instruments\Battery 4\Kits" /S /LOG+:$LOGFILE
robocopy $BACKUP_PATH "G:\\bk\\Native Instruments\Battery 4\Kits" /S /LOG+:$LOGFILE
