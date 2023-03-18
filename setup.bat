@echo off
echo checking if node is installed...
node -v >nul 2>nul
IF errorlevel 1 (
    echo Node is not installed, please install nodejs. https://nodejs.org/en
    pause
) ELSE (
    echo Node is installed continuing...
    mkdir %USERPROFILE%\dalai
    mkdir %USERPROFILE%\dalai\git
    
    goto git
)
:git
IF EXIST "%USERPROFILE%\dali\git\PortableGit" (
        goto git
    ) ELSE (
        goto dl  
    )

:dl
powershell "Import-Module BitsTransfer; Start-BitsTransfer 'https://github.com/git-for-windows/git/releases/download/v2.40.0.windows.1/PortableGit-2.40.0-64-bit.7z.exe' '%USERPROFILE%\dalai\git\git.exe'"
echo installing git
timeout /t 3 /nobreak > NUL
echo Re-Launch the script after you click ok on the window that pops up
timeout /t 3 /nobreak > NUL
START %USERPROFILE%\dalai\git\git.exe
pause

:git
powershell %USERPROFILE%\dalai\git\PortableGit\bin\git.exe clone https://github.com/cocktailpeanut/dalai
xcopy /s/e "%cd%\dalai\" "%USERPROFILE%\%dalai" 
cd "%USERPROFILE%\dalai"
npm i
node bin\cli.js setup
node bin\cli.js alpaca install 7B
node bin\cli.js serve
