@ECHO OFF

SETLOCAL

FOR %%I IN (%1.bat %1.exe %1) DO (
            IF NOT "%%~$PATH:I"=="" (
                        SET f=%%~$PATH:I
                            )
        )

IF NOT "%f%"=="" (
            echo %f%
        )

ENDLOCAL

