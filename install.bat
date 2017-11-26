@echo off
for /d %%i in (.*) do (
    if not %%i == ".git" (
        echo %%i
        mklink /d %%i "%userprofile%\%%i"
    )
)
for %%i in (.*) do (
    set TRUE_FALSE=TRUE
    if %%i == ".gitignore" (
        set TRUE_FALSE=FALSE
    )
    if %TRUE_FALSE% == TRUE (
        echo %%i
        mklink %%i "%userprofile%\%%i"
    )
    if %%i == ".vimrc" (
        mklink %%i "%userprofile%\_vimrc"
    )
)
pause
