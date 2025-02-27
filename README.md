###     :::     :::::::::  :::::::::   ::::::::  :::::::::   ::::::::    ::::::::   ::::::::::: ::::    ::::   ::::::::  
###   :+: :+:   :+:    :+: :+:    :+: :+:    :+: :+:    :+: :+:    :+:  :+:    :+:      :+:     +:+:+: :+:+:+ :+:    :+: 
###  +:+   +:+  +:+    +:+ +:+    +:+ +:+        +:+    +:+ +:+               +:+       +:+     +:+ +:+:+ +:+ +:+        
### +#++:++#++: +#+    +:+ +#+    +:+ :#:        +#++:++#+  +#++:++#++      +#+         +#+     +#+  +:+  +#+ :#:        
### +#+     +#+ +#+    +#+ +#+    +#+ +#+   +#+# +#+               +#+    +#+           +#+     +#+       +#+ +#+   +#+# 
### #+#     #+# #+#    #+# #+#    #+# #+#    #+# #+#        #+#    #+#   #+#            #+#     #+#       #+# #+#    #+# 
### ###     ### #########  #########   ########  ###         ########   ##########  ########### ###       ###  ########  



# addGPS_interactive.bat

An interactive Windows batch script that processes all JPEG images in a folder and adds GPS coordinates to those images that do not already have GPS metadata. The script prompts you to enter a folder path and comma-separated GPS coordinates (e.g., `-23.21140901769295, -47.52262398250084`). It automatically determines the proper GPS Latitude/Longitude Ref (N/S, E/W) based on the sign of the coordinates.

This tool is especially useful if you are uploading photos stored in folders to the cloud (for example, Google Photos) and need to ensure that every image contains location metadata.

## Features

- **Interactive Prompts:**  
  - Ask for the folder path containing your images.
  - Ask for GPS coordinates as a single, comma-separated entry.
- **Automatic Derivation:**  
  - Automatically derive and add the correct GPS Latitude Ref (`N`/`S`) and GPS Longitude Ref (`E`/`W`) based on the sign.
- **Batch Processing:**  
  - Iterates through all JPEG/JPEG images in the specified folder.
  - Skips images that already have GPS data.
- **Looping Control:**  
  - Once processing is complete, you can press **C** to process another folder or **Q** to quit.
- **Right-Click in Google Maps:**  
  - Easily obtain the required coordinates by opening Google Maps in your browser, right-clicking on the desired location, and selecting "What's here?" The coordinates will be displayed in the required comma-separated format.

## Prerequisites

- **Windows Operating System**
- **[ExifTool](https://exiftool.org/):**  
  ExifTool is a powerful command‑line utility for reading and writing metadata.  
  - **Installation Instructions:**  
    1. Visit the [ExifTool website](https://exiftool.org/) and download the Windows executable (typically named `exiftool(-k).exe`).
    2. Rename the file to `exiftool.exe` and place it in a directory that is included in your system's PATH.
    3. To verify installation, open Command Prompt and run:
       ```batch
       exiftool -ver
       ```
       This should display the version number of ExifTool.

## How to Use

1. **Open Command Prompt:**  
   Navigate to the folder where you saved `addGPS_interactive.bat`.

2. **Run the Script:**  
   ```batch
   addGPS_interactive.bat
   ```
   
3. Enter Folder Path:
When prompted, type the full path of the folder containing your images (e.g., C:\Users\YourName\Pictures).

4. Enter GPS Coordinates:
When prompted, enter your GPS coordinates as a comma-separated value (for example, -23.21140901769295, -47.52262398250084).
Tip:
To easily get these coordinates, open Google Maps, right-click on the desired location. The coordinates will appear in the required format, just click it (this will coppy it automatically)

5. Processing:
The script processes every .jpg and .jpeg file in the specified folder:

- If the file does not contain GPS data, the script adds the specified coordinates (using the absolute values and derived N/S or E/W references).
- If the file already contains GPS data, it skips that file.

6. Loop or Quit:
After processing, you will be prompted:

```batch
Press C to continue with another folder, or Q to quit:
```
## Customization
File Extensions:
To process additional file types (for example, PNG), modify the for loop pattern (*.jpg *.jpeg) in the script.

ExifTool Options:
Adjust the ExifTool command-line options in the script if needed. For example to avoid overwriting

## Commercial License & Support
This code is available under a dual-license model:

Open Source License:
For non-commercial use, this code is released under the MIT License.

Commercial License:
If you wish to use this code for commercial purposes, require additional support, or need customization rights, please [contact me](mailto:oskar@hagen.bio). A formal commercial license agreement can be arranged upon inquiry.

### License
Please refer to the LICENSE file for complete licensing details.

## Contributing & Support
- Issues:
If you encounter any issues or have feature requests, please open an issue in this repository.
- Pull Requests:
Contributions are welcome! Fork the repository and submit a pull request.
- Commercial Inquiries:
For commercial licensing or support, please [email me](oskar@hagen.bio).

## Disclaimer
This script is provided "as is" without any warranty. Use it at your own risk. The author is not liable for any data loss or damage resulting from the use of this script.

© 2025 Oskar Hagen. All rights reserved.
