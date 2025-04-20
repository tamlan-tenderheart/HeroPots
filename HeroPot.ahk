; HeroPot.ahk
; Automated way to Craft Hero Pots on a DAOC freeshard (Eden specifically) 
; By Tamlan Tenderheart
;
; Requirements:
; The script requires that you have the Superior Draughts and Hero Pots on your current #1 quickbar at the time of use.
; Superior Strength Draught should be on the "1" button, Fortitude on the "2" button, Dexterity on the "3" button, 
; enlightenment on the "4" button, might on "5", deftness on "6", and the hero pot itself on "7".
; You can change this by changing the constants in the code.
;
; Usage: 
; 
; Target a suitable merchant in-game that sells the required resources to make the potions
; Make sure your character is standing in range of the alchemy table.
; Press F1 and enter the number of hero pots to craft
; Press Ok and watch as your pots are crafted
; Press F1 again while crafting is underway to cancel to script. Note that the currently underway item craft in game will not be canceled,
; just the script
;
; NOTE: Delay times entered are from my own observation of how long it took me to craft the items. I increased the delay by 50% to account
; for the worst-possible craftingconditions. If the delay times are execessive in your experience, feel free to adjust them down
; NOTE2: Like all AHK scripts, on Eden AHK must be run as administrator for it to work
; 
; Disclaimer:
; The use of AHK scripts on some DAOC Freeshards is prohibited, and on others the use of loops, delays, and conditional logic is prohibited.
; As this script uses these elements, you should know the terms of service of the freeshard you are playing on and use your own discretion
; whether to use this script or not.
; The author of this script makes no guarantees about the quality of legality of the script, and is not responsible for the consequences of
; your use of the script, or any damages or losses you sustain as a result of using it.
; The code is provided AS-IS and as an instructional tool for writing AHK scripts only.
; You have been warned.

#UseHook
#IfWinActive, ahk_exe game.dll
#SingleInstance, force
#MaxThreadsPerHotkey 2
#MaxHotKeysPerInterval 200
#NoEnv
StringCaseSense, On
SendMode, InputThenPlay
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
SetKeyDelay,,100

; Constants
StrengthDraughtKey      := "1"
FortitudeDraughtKey     := "2"
DexterityDraughtKey     := "3"
EnlightenmentDraughtKey := "4"
MightDraughtKey         := "5"
DeftnessDraughtKey      := "6"
HeroPotKey              := "7"

Count := 1         ; the number of hero pots to make (default is one)
IsRunning := false ; flag to check for early script termination

BuyOne(PotionKey) {
    ControlSend,,{blind}%PotionKey%,ahk_exe game.dll
    Sleep,500
    ControlSend,,{Blind}/,ahk_exe game.dll
    Sleep,50
    ControlSend,,{Blind}craftqueue buy 1`n,ahk_exe game.dll
    Sleep,500
    return
}

MakeOne(PotionKey, delay) {
    ControlSend,,{blind}%PotionKey%,ahk_exe game.dll
    Sleep,delay
    return
}
F1::
    IsRunning := !IsRunning
    If(IsRunning) {
        InputBox, Count, Hero Potion Crafter, How many hero potions to craft?,,,,,,,,1
        TrayTip,Hero Pot Crafter,Crafting is started,,1
        While(Count > 0 AND IsRunning) {
            if(IsRunning) BuyOne(StrengthDraughtKey)
            if(IsRunning) MakeOne(StrengthDraughtKey,36000)       ; 25s in my testing, using 36s    
            if(IsRunning) BuyOne(FortitudeDraughtKey)
            if(IsRunning) MakeOne(FortitudeDraughtKey, 36000)     ; 25s in my testing, using 36s 
            if(IsRunning) BuyOne(DexterityDraughtKey)
            if(IsRunning) MakeOne(DexterityDraughtKey, 36000)     ; 25s in my testing, using 36s 
            if(IsRunning) BuyOne(EnlightenmentDraughtKey)
            if(IsRunning) MakeOne(EnlightenmentDraughtKey, 36000) ; 25s in my testing, using 36s 
            if(IsRunning) BuyOne(MightDraughtKey)
            if(IsRunning) MakeOne(MightDraughtKey, 42000)         ; 28s in my testing, using 42s
            if(IsRunning) BuyOne(DeftnessDraughtKey)
            if(IsRunning) MakeOne(DeftnessDraughtKey, 42000)      ; 28s in my testing, using 42s
            if(IsRunning) MakeOne(HeroPotKey, 10000)              ; 5s in my testing, using 10s
            Count := Count - 1    
        }
        TrayTip,Hero Pot Crafter,Crafting is complete,,1
        IsRunning := false
    }
    return

#UseHook, Off