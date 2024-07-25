# Null Movement Script for AutoHotkey v2
First code credit to Qiasfah on Github

/*
Changelog:
v2.1.0 (2024-07-25)
- Implemented proper SOCD (Simultaneous Opposite Cardinal Direction) handling
- Added configurable SOCD cleaning method for Left+Right inputs
- Up+Down now always results in Up (fighting game standard)

v2.0.0 (2024-07-25)
- Implemented Snap Tap behavior, prioritizing the last pressed key
- Added support for both horizontal (A/D) and vertical (W/S) movement
- Improved performance with various optimizations
- Simplified logic using functions and maps for better maintainability

v1.0.0 (Original Version)
- Initial implementation of null movement script
- Basic WASD key management to prevent opposing keys from canceling movement
*/
