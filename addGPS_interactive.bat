@echo off
setlocal EnableDelayedExpansion

:MainLoop
cls


:: Display ASCII Logo and Information
echo    :::     :::::::::  :::::::::   ::::::::  :::::::::   ::::::::    ::::::::   ::::::::::: ::::    ::::   ::::::::  
echo  :+: :+:   :+:    :+: :+:    :+: :+:    :+: :+:    :+: :+:    :+:  :+:    :+:      :+:     +:+:+: :+:+:+ :+:    :+: 
echo  +:+   +:+  +:+    +:+ +:+    +:+ +:+        +:+    +:+ +:+               +:+       +:+     +:+ +:+:+ +:+ +:+        
echo +#++:++#++: +#+    +:+ +#+    +:+ :#:        +#++:++#+  +#++:++#++      +#+         +#+     +#+  +:+  +#+ :#:        
echo +#+     +#+ +#+    +#+ +#+    +#+ +#+   +#+# +#+               +#+    +#+           +#+     +#+       +#+ +#+   +#+# 
echo +#+     #+# #+#    #+# #+#    #+# #+#    #+# #+#        #+#    #+#   #+#            #+#     #+#       #+# #+#    #+# 
echo ###     ### #########  #########   ########  ###         ########   ##########  ########### ###       ###  ########   
echo.
echo --------------------------------------------------------------
echo This interactive script adds GPS coordinates to image files.
echo It prompts for a folder path and a comma-separated coordinate pair,
echo automatically deriving the correct GPS Latitude/Longitude References.
echo.
echo Licensed under the MIT License.
echo For commercial use or support, please contact oskar@hagen.bio.
echo Provided AS IS without any warranty.
echo -------------------------------------------------------------- 
echo.




:: Prompt for the folder path
set /p folder="Enter the folder path containing your images: "
if not exist "%folder%" (
    echo Folder "%folder%" does not exist.
    pause
    goto MainLoop
)

:: Ask if the user wants to include subfolders
set /p includeSubfolders="Include subfolders? (Press Enter for Yes, type 'n' for No): "
if /i "%includeSubfolders%"=="n" (
    set "searchOption="
) else (
    set "searchOption=/R"
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
for %searchOption% %%F in (*.jpg *.jpeg *.CR2 *.png *.tiff *.tif *.bmp *.gif *.raw *.nef *.arw *.hdr *.orf *.rw2 *.pef *.dng *.sr2 *.srw *.m4v *.mov *.mp4 *.avi *.wmf *.flv *.mkv *.mpeg *.3gp) do (
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
