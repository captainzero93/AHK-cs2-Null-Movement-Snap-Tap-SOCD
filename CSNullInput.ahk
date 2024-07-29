; Counter-Strike Optimized Snap Tap Mode AutoHotkey Script with SOCD Handling
; Version: 2.3.0
; Last Updated: 2024-07-29

/*
Changelog:
v2.3.0 (2024-07-29)
- Added failsafe mechanism to prevent keys from getting stuck
- Implemented debug mode for logging key events
- Added error handling and logging

v2.2.0 (2024-07-25)
- Updated vertical SOCD handling for Counter-Strike: Up+Down now cancels movement
- Added game-specific SOCD handling option
- Improved comments and documentation

v2.1.0 (2024-07-25)
- Implemented proper SOCD (Simultaneous Opposite Cardinal Direction) handling
- Added configurable SOCD cleaning method for Left+Right inputs

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

; Game-specific SOCD handling
; Set to true for Counter-Strike behavior (Up+Down = No movement)
global csgoStyle := true

; Debug mode (set to true to enable logging)
global debugMode := true

; Failsafe variables
global lastKeyPressTime := A_TickCount
global stuckKeyThreshold := 5000 ; 5 seconds

; Function to handle key presses
handleKeyPress(key, direction) {
    try {
        keys[key] := 1
        lastPressed[direction] := key
        lastKeyPressTime := A_TickCount
        
        if (debugMode) {
            FileAppend "Key press: " . key . " at " . A_TickCount . "`n", "ahk_debug.txt"
        }
        
        if (direction == "horizontal") {
            handleHorizontalSOCD()
        } else {
            handleVerticalSOCD()
        }
    } catch as err {
        FileAppend "Error in handleKeyPress: " . err.Message . " at " . A_Now . "`n", "ahk_error.txt"
    }
}

; Function to handle key releases
handleKeyRelease(key, direction) {
    try {
        keys[key] := 0
        
        if (debugMode) {
            FileAppend "Key release: " . key . " at " . A_TickCount . "`n", "ahk_debug.txt"
        }
        
        if (direction == "horizontal") {
            handleHorizontalSOCD()
        } else {
            handleVerticalSOCD()
        }
    } catch as err {
        FileAppend "Error in handleKeyRelease: " . err.Message . " at " . A_Now . "`n", "ahk_error.txt"
    }
}

; Function to handle horizontal SOCD (Left + Right)
handleHorizontalSOCD() {
    try {
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
    } catch as err {
        FileAppend "Error in handleHorizontalSOCD: " . err.Message . " at " . A_Now . "`n", "ahk_error.txt"
    }
}

; Function to handle vertical SOCD (Up + Down)
handleVerticalSOCD() {
    try {
        if (keys["w"] && keys["s"]) {
            if (csgoStyle) {
                Send "{Blind}{w up}{s up}" ; Cancel movement for Counter-Strike style
            } else {
                Send "{Blind}{s up}{w down}" ; Up wins for traditional fighting game style
            }
        } else if (keys["w"]) {
            Send "{Blind}{s up}{w down}"
        } else if (keys["s"]) {
            Send "{Blind}{w up}{s down}"
        } else {
            Send "{Blind}{w up}{s up}"
        }
    } catch as err {
        FileAppend "Error in handleVerticalSOCD: " . err.Message . " at " . A_Now . "`n", "ahk_error.txt"
    }
}

; Function to check and reset if keys are stuck
checkAndResetIfStuck() {
    if (A_TickCount - lastKeyPressTime > stuckKeyThreshold) {
        resetAllKeys()
    }
}

; Function to reset all keys
resetAllKeys() {
    try {
        for key, value in keys {
            keys[key] := 0
        }
        Send "{Blind}{a up}{d up}{w up}{s up}"
        FileAppend "Keys reset due to potential stick at " . A_Now . "`n", "ahk_log.txt"
        if (debugMode) {
            FileAppend "Failsafe triggered: All keys reset at " . A_TickCount . "`n", "ahk_debug.txt"
        }
    } catch as err {
        FileAppend "Error in resetAllKeys: " . err.Message . " at " . A_Now . "`n", "ahk_error.txt"
    }
}

; Hotkeys for WASD keys
*$a::
*$d::
*$w::
*$s::
{
    checkAndResetIfStuck()
    handleKeyPress(A_ThisHotkey, (A_ThisHotkey == "a" || A_ThisHotkey == "d") ? "horizontal" : "vertical")
}

*$a up::
*$d up::
*$w up::
*$s up::
{
    handleKeyRelease(StrReplace(A_ThisHotkey, " up"), (A_ThisHotkey == "a up" || A_ThisHotkey == "d up") ? "horizontal" : "vertical")
}

; Timer to periodically check for stuck keys
SetTimer checkAndResetIfStuck, 1000 ; Check every second
