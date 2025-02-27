@echo off
setlocal EnableDelayedExpansion

:MainLoop
cls
:: Prompt for the folder path
set /p folder="Enter the folder path containing your images: "
if not exist "%folder%" (
    echo Folder "%folder%" does not exist.
    pause
    goto MainLoop
)

:: Prompt for comma-separated GPS coordinates (lat, long)
set /p coords="Enter GPS coordinates (lat, long): "

:: Remove any spaces from the input
set "coords=%coords: =%"

:: Split the coordinate string into latitude and longitude
for /f "tokens=1,2 delims=," %%a in ("%coords%") do (
    set "lat=%%a"
    set "lon=%%b"
)

:: Derive GPS Latitude Ref and absolute value
if "%lat:~0,1%"=="-" (
    set "latRef=S"
    set "latVal=%lat:~1%"
) else (
    set "latRef=N"
    set "latVal=%lat%"
)

:: Derive GPS Longitude Ref and absolute value
if "%lon:~0,1%"=="-" (
    set "lonRef=W"
    set "lonVal=%lon:~1%"
) else (
    set "lonRef=E"
    set "lonVal=%lon%"
)

echo.
echo Using GPS Latitude: %latVal% (%latRef%) and Longitude: %lonVal% (%lonRef%)
echo.

pushd "%folder%"
for %%F in (*.jpg *.jpeg) do (
    echo Checking "%%F"...
    rem Check if the file already contains GPS data
    exiftool -GPSLatitude "%%F" | findstr /i "GPS Latitude" >nul
    if errorlevel 1 (
         echo   No GPS data found. Adding coordinates...
         exiftool -overwrite_original -GPSLatitude=%latVal% -GPSLatitudeRef=%latRef% -GPSLongitude=%lonVal% -GPSLongitudeRef=%lonRef% "%%F"
         echo   Done.
    ) else (
         echo   GPS data already exists. Skipping.
    )
    echo.
)
popd

echo.
echo Folder processing complete.
echo.

choice /C CQ /N /M "Press C to continue with another folder, or Q to quit: "
if errorlevel 2 goto Quit
if errorlevel 1 goto MainLoop

:Quit
echo Exiting...
pause
exit /b 0