@echo off
setlocal

REM ----------------------------------------------------------------
REM This version of flatten.bat expects a folder path as the first
REM argument. It will flatten that folder, moving all files out of
REM subfolders into the root folder, with *.cr2 files going to "raw".
REM ----------------------------------------------------------------

if "%~1"=="" (
    echo No folder path was provided as an argument.
    echo Usage: flatten.bat "C:\path\to\folder"
    pause
    exit /b 1
) else (
    set "TARGET=%~1"
)

if not exist "%TARGET%" (
    echo The folder "%TARGET%" does not exist.
    pause
    exit /b 1
)

REM Convert to absolute path if needed
pushd "%TARGET%"
set "TARGET=%CD%"
popd

REM Folder for CR2 files
set "RAW=%TARGET%\raw"
set "foundCR2=false"

REM Step 1: Check for any *.cr2 (case-insensitive)
for /r "%TARGET%" %%A in (*.cr2) do (
    set "foundCR2=true"
    goto :FoundCR2
)
:FoundCR2

REM Step 2: If CR2 files are found, create the raw folder
if "%foundCR2%"=="true" (
    if not exist "%RAW%" mkdir "%RAW%"
)

REM Step 3: Move files
for /r "%TARGET%" %%A in (*) do (
    if /i "%%~dpA"=="%RAW%\" (
        echo Skipping file already in raw folder: "%%~fA"
    ) else (
        if /i "%%~xA"==".cr2" (
            if "%foundCR2%"=="true" (
                move "%%~fA" "%RAW%"
            )
        ) else (
            move "%%~fA" "%TARGET%"
        )
    )
)

echo.
echo Done flattening "%TARGET%"!