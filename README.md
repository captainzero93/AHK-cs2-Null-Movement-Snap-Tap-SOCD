# Null Movement Script for AutoHotkey v2 (CS2)

## Overview
This script implements advanced movement techniques for Counter-Strike 2 (CS2) using AutoHotkey v2. It provides features similar to those found in newer gaming keyboards, enhancing movement fluidity and responsiveness.

## Features
- **Snap Tap Mode**: Prioritizes the last pressed key for instant direction changes.
- **SOCD (Simultaneous Opposite Cardinal Direction) Handling**: Prevents unintended movement cancellation when pressing opposing keys.
- **Configurable SOCD Cleaning**: Options for horizontal (Left+Right) movement handling.
- **Game-Specific Vertical SOCD**: Tailored for Counter-Strike style movement.
- **Performance Optimizations**: Ensures smooth script execution.

## Key Benefit
Your character will no longer stop moving in the heat of battle when two opposing directional keys are pressed. Instead, you can now change directions instantly without having to release the previous key.

## Changelog
### v2.2.0 (2024-07-25)
- Updated vertical SOCD handling for Counter-Strike
- Added game-specific SOCD handling option
- Improved comments and documentation

### v2.1.0 (2024-07-25)
- Implemented proper SOCD handling
- Added configurable SOCD cleaning method for Left+Right inputs

### v2.0.0 (2024-07-25)
- Completely refactored the script for AutoHotkey v2.0
- Implemented Snap Tap behavior, prioritizing the last pressed key
- Added support for both horizontal (A/D) and vertical (W/S) movement
- Improved performance with various optimizations
- Simplified logic using functions and maps for better maintainability

### v1.0.0 (Original Version)
- Initial implementation of null movement script
- Basic WASD key management

## Installation
1. Ensure you have AutoHotkey v2.0 or later installed on your system. You can download it from the [official AutoHotkey website](https://www.autohotkey.com/).
2. Download the `CSNullInput.ahk` script from this repository.
3. Save the script to a location on your computer where you can easily access it.

## Usage
1. Double-click the `CSNullInput.ahk` file to run the script.
2. The script will run in the background, affecting your WASD key inputs in Counter-Strike 2.
3. To stop the script, right-click the AutoHotkey icon in your system tray and select "Exit".

## Configuration
You can modify the following variables in the script to customize its behavior:

- `horizontalSOCDMethod`: Set to "Neutral" for Left+Right = Neutral, or "Last Win" for Last Input Priority.
- `csgoStyle`: Set to true for Counter-Strike behavior (Up+Down = No movement), or false for traditional fighting game style (Up wins).

To change these settings:
1. Open the `CSNullInput.ahk` file in a text editor.
2. Locate the variables near the top of the script.
3. Modify the values as desired.
4. Save the file and restart the script for changes to take effect.

## Credits
- Original code credit to Qiasfah on Github
- Further development and optimization by the current maintainer

## Disclaimer
This script is an attempt to recreate features built into newer keyboards. It does not implement hardware-level actuation or rapid fire functionality. The script is designed to work within the bounds of what's typically allowed by game anti-cheat systems, but use at your own risk.

## Note on Fair Play
The maintainer acknowledges the ethical considerations of using such scripts:
- A previous version included functionality to stop stepping forward instantly when left click was pressed, but this was removed as it was deemed too close to cheating.
- There are concerns about the future of hardware automation in competitive gaming, particularly if peripheral manufacturers create integrated keyboard-mouse systems.
- The question of where Valve (and other game developers) will draw the line on hardware automation remains open.

## Contributing
Contributions to improve the script are welcome. Submit a pull request with a description of your changes.

Please ensure your code adheres to the existing style and includes appropriate comments. Also, update the README if your changes add or modify functionality.

## License
This project is licensed under the MIT License. This means:

- You can freely use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the software.
- The software is provided "as is", without warranty of any kind.
- The authors or copyright holders are not liable for any claims, damages, or other liability arising from the use of the software.

For the full license text, please see the [LICENSE](LICENSE) file in the repository.

## Support
If you encounter any issues or have questions about the script, please open an issue on the GitHub repository. While I'll do my best to address concerns, please understand that this is a community project maintained in free time.

Remember to use this script responsibly and in accordance with the terms of service of the games you play. Happy gaming!
