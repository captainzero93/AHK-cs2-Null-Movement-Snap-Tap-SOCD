; Snap Tap Mode AutoHotkey Script with SOCD Handling
; Version: 2.1.0
; Last Updated: 2024-07-25

/*
Changelog:
v2.1.0 (2024-07-25)
- Implemented proper SOCD (Simultaneous Opposite Cardinal Direction) handling
- Added configurable SOCD cleaning method for Left+Right inputs
- Up+Down now always results in Up (fighting game standard)

v2.0.0 (2024-07-25)
- Completely refactored the script for AutoHotkey v2.0
- Implemented true Snap Tap behavior, prioritizing the last pressed key
- Added support for both horizontal (A/D) and vertical (W/S) movement
- Improved performance with various optimizations
- Simplified logic using functions and maps for better maintainability

v1.0.0 (Original Version)
- Initial implementation of null movement script
- Basic WASD key management to prevent opposing keys from canceling movement
*/

#SingleInstance Force
SetWorkingDir A_ScriptDir
#Requires AutoHotkey v2.0

; Performance optimizations
ListLines False
KeyHistory 0
ProcessSetPriority "High"
SetKeyDelay -1, -1
SetMouseDelay -1
SetDefaultMouseSpeed 0
SetWinDelay -1
SetControlDelay -1
A_MaxHotkeysPerInterval := 99000000
A_HotkeyInterval := 0

; Global variables for key states
global keys := Map("a", 0, "d", 0, "w", 0, "s", 0)
global lastPressed := Map("horizontal", "", "vertical", "")

; SOCD cleaning method for Left+Right
; Set to "Neutral" for Left+Right = Neutral, or "Last Win" for Last Input Priority
global horizontalSOCDMethod := "Last Win"

; Function to handle key presses
handleKeyPress(key, direction) {
    keys[key] := 1
    lastPressed[direction] := key
    
    if (direction == "horizontal") {
        handleHorizontalSOCD()
    } else {
        handleVerticalSOCD()
    }
}

; Function to handle key releases
handleKeyRelease(key, direction) {
    keys[key] := 0
    
    if (direction == "horizontal") {
        handleHorizontalSOCD()
    } else {
        handleVerticalSOCD()
    }
}

; Function to handle horizontal SOCD (Left + Right)
handleHorizontalSOCD() {
    if (keys["a"] && keys["d"]) {
        if (horizontalSOCDMethod == "Neutral") {
            Send "{Blind}{a up}{d up}"
        } else { ; "Last Win"
            if (lastPressed["horizontal"] == "a") {
                Send "{Blind}{d up}{a down}"
            } else {
                Send "{Blind}{a up}{d down}"
            }
        }
    } else if (keys["a"]) {
        Send "{Blind}{d up}{a down}"
    } else if (keys["d"]) {
        Send "{Blind}{a up}{d down}"
    } else {
        Send "{Blind}{a up}{d up}"
    }
}

; Function to handle vertical SOCD (Up + Down)
handleVerticalSOCD() {
    if (keys["w"] && keys["s"]) {
        Send "{Blind}{s up}{w down}" ; Up always wins
    } else if (keys["w"]) {
        Send "{Blind}{s up}{w down}"
    } else if (keys["s"]) {
        Send "{Blind}{w up}{s down}"
    } else {
        Send "{Blind}{w up}{s up}"
    }
}

; Hotkeys for WASD keys
*$a::handleKeyPress("a", "horizontal")
*$a up::handleKeyRelease("a", "horizontal")
*$d::handleKeyPress("d", "horizontal")
*$d up::handleKeyRelease("d", "horizontal")
*$w::handleKeyPress("w", "vertical")
*$w up::handleKeyRelease("w", "vertical")
*$s::handleKeyPress("s", "vertical")
*$s up::handleKeyRelease("s", "vertical")
