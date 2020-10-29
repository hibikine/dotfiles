$SYSDATETIME = (Get-Date -Format "yyyyMMddHHmmss")
$LOGPATH = "C:\\bk\\log"
New-Item -ItemType Directory -Force -Path $LOGPATH

#$LOGFILE = $LOGPATH + "\\" + $SYSDATETIME + "_pictures_backup.log"
#robocopy E:\Pictures G:\Pictures /MIR /LOG+:$LOGFILE
$LOGFILE = $LOGPATH + "\\" + $SYSDATETIME + "_mymusics_backup.log"
robocopy F:\MyMusics G:\MyMusics /MIR /LOG+:$LOGFILE
$LOGFILE = $LOGPATH + "\\" + $SYSDATETIME + "_mycreated_backup.log"
robocopy F:\MyCreated G:\MyCreated /MIR /LOG+:$LOGFILE
$LOGFILE = $LOGPATH + "\\" + $SYSDATETIME + "_illust_backup.log"
robocopy F:\illust G:\illust /MIR /LOG+:$LOGFILE
$LOGFILE = $LOGPATH + "\\" + $SYSDATETIME + "_sozai_backup.log"
robocopy F:\sozai G:\sozai /MIR /LOG+:$LOGFILE
