
; Null Movement Script for AutoHotkey v2
; First code credit to Qiasfah on Github
; Changelog:
; v2.0.0 (2024-07-25)
; - Implemented true Snap Tap behavior, prioritizing the last pressed key
; - Added support for both horizontal (A/D) and vertical (W/S) movement
; - Improved performance with various optimizations
; - Simplified logic using functions and maps for better maintainability


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

; Function to handle key presses
handleKeyPress(key, direction) {
    oppositeKey := direction == "horizontal" ? (key == "a" ? "d" : "a") : (key == "w" ? "s" : "w")
    
    keys[key] := 1
    lastPressed[direction] := key
    
    if (keys[oppositeKey]) {
        Send "{Blind}{" oppositeKey " up}"
    }
    Send "{Blind}{" key " down}"
}

; Function to handle key releases
handleKeyRelease(key, direction) {
    keys[key] := 0
    
    if (lastPressed[direction] == key) {
        Send "{Blind}{" key " up}"
        oppositeKey := direction == "horizontal" ? (key == "a" ? "d" : "a") : (key == "w" ? "s" : "w")
        if (keys[oppositeKey]) {
            lastPressed[direction] := oppositeKey
            Send "{Blind}{" oppositeKey " down}"
        } else {
            lastPressed[direction] := ""
        }
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
