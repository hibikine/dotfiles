# /S サブディレクトリはコピーするが空のサブディレクトリはコピーしない
$SYSDATETIME = (Get-Date -Format "yyyyMMddHHmmss")
$LOGPATH = "C:\\bk\\log"
$LOGFILE = $LOGPATH + "\\backup-eagle-files-" + $SYSDATETIME + ".log"
New-Item -ItemType Directory -Force -Path $LOGPATH
$BACKUP_PATH = "E:\EaglePhotos"
robocopy $BACKUP_PATH "G:\\bk\\EaglePhotos" /S /LOG+:$LOGFILE
