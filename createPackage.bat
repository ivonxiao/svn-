@echo off

setlocal EnableDelayedExpansion


set SVN_DEV_PATH=".\trunk\node"

set SVN_TOOL= ".\Apache-Subversion-1.9.4\bin\svn.exe"

set ZIP_FILE_LIST="svn_modify_list.dat"

set PKG_FILE="change_file_path.dat"

set PKG_DIR="Packages"

.\Apache-Subversion-1.9.4\bin\svn.exe status  %SVN_DEV_PATH% > %ZIP_FILE_LIST%

echo. > %PKG_FILE%

FOR /f "tokens=1,2 delims= " %%A in (%ZIP_FILE_LIST:"=%) do (
    dir/ad %%B >nul 2>nul&& cd || echo %%B >> %PKG_FILE%
)


::get time

set datetime=%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%%time:~6,2%

7za a -tzip %PKG_DIR%\node_pkg_%datetime%.zip -i@%PKG_FILE%

pause