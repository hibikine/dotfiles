@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
%ALLUSERSPROFILE%\chocolatey\bin\choco install firefox -y
%ALLUSERSPROFILE%\chocolatey\bin\choco install git.install -y
%ALLUSERSPROFILE%\chocolatey\bin\choco install googlechrome -y
%ALLUSERSPROFILE%\chocolatey\bin\choco install javaruntime -y
%ALLUSERSPROFILE%\chocolatey\bin\choco install nodejs.install -y
%ALLUSERSPROFILE%\chocolatey\bin\choco install composer -y
composer global require friendsofphp/php-cs-fixer

