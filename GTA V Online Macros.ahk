;+ = shift, ! = Alt, ^ = Control, # = Win (tecla Windows)
;Ejemplo remplazar "s.c " por "Saludos cordiales " "::s.c::Saludos cordiales"
;
; GTA V Online AHK-Macros v1.1.1 by 2called-chaos
; based on/inspired by GTA V Useful Macros v4.21 by twentyafterfour
;
; # Description
;
; Provides hotkeys for opening snack menu, equipping armor, entering passive mode and much more.
;
;
; # General Notes
;
;   * Read the god damn readme, please! https://github.com/2called-chaos/gtav-online-ahk/blob/master/README.md
;   * After cutscenes or just from time to time the interaction menu lags
;     and the macro won't work. Periodically, especially after loading/cutscenes
;     press m and backspace (aka open the menu once)
;   * If you add something consider committing a pull request so we can all enjoy (VIP stuff for example)
;
;
; # Hotkeys / Binding:
;
; To change a hotkey for a macro change the configuration section at the top of the file.
; A list of keynames for the non-alphanumeric can be found in the autohotkey help under
; the heading "Basic Usage and Syntax" with the name "Key List".
; They can also be found at https://www.autohotkey.com/docs/KeyList.htm
;
;
; # FAQ, Docs, Source, Bugs, etc.
;
; Read the wiki, propose features, fix and/or report bugs... it's all yours at
;
;     https://github.com/2called-chaos/gtav-online-ahk  (Original)
;     https://github.com/Drascor/gtav-online-ahk        (Fork)
;


; ==============================
; === CONFIGURATION GOES vvv ===
; ==============================

; Bindings (bind the desired functions to a key of your choice)
;   https://www.autohotkey.com/docs/KeyList.htm
; WARNING: If you don't want to use a certain binding use "F24"
;          or any other valid key or it will break!
SnackMenuKey         := "+F1" ; Open Snack menu (+ = shift, rtfm).
AutoHealthKey        := "F1" ; Automatic snacking. Eats 2 snacks from second snack slot.
ArmorMenuKey         := "+F2" ; Open Armor menu.
AutoArmorKey         := "F2" ; Automatic armor equip (uses super heavy armor only).
ThermalVisionKey     := "F24" ;
RetrieveCarKey       := "F3" ; Request Personal Vehicle.
OpressorMKIIKey      := "F5" ;
NanoDroneKey         := "F24" ;
RCBanditoKey         := "F24" ;
RCTankKey            := "F24" ;
TogglePassiveKey     := "F8" ; Toggle passive mode.
EquipScarfKey        := "F24" ; Equip first scarf (heist outfit glitch, see readme/misc).
CycleOutfitKey       := "F7" ; Equip next/cycle through saved outfits.
KillGameKey          := "F24" ; Kill game process, requires pskill.exe
ForceDisconnectKey   := "F24" ; Force disconnect by suspending process for 10s, requires pssuspend.exe
ChatSnippetsKey      := "F24" ; Gives you a few text snippets to put in chat (chat must be already open)
RandomHeistKey       := "F24" ; Chooses on-call random heist from phone options


ToggleVIPKey         := "F12" ; Toggle VIP mode (required when VIP/CEO/MC).
RegisterCEOKey       := "F9" ;
RegisterMCKey        := "F10" ;
RetireVIPKey         := "F11" ;
CEOBuzzardKey        := "F6" ; Spawn free CEO buzzard
StorageMCKey         := "F4" ;


DialDialogKey        := "+Delete" ; Call GUI with a list of almost all numbers
CallMechanicKey      := "F24" ; Call Mechanic
CallPegasusKey       := "F24" ; Call Pegasus
CallMerryweatherKey  := "F24" ; Call Merryweather
CallInsuranceKey     := "F24" ; Call Insurance
CallLesterKey        := "Delete" ; Call Lester
SaveMoneyKey         := "l" ; No Funciona

ChangeMapKey         := "Insert" ;Insert


; Options (should be fine out of the box)
DoConfirmKill        := true  ; If true the KillGame action will ask for confirmation before killing the process
DoConfirmDisconnect  := true  ; If true the ForceDisconnect action will ask for confirmation before suspending the process
IntDisconnectDelay   := 10    ; Amount of seconds to freeze the process for, 10 works fine
IsVIPActivated       := false ; Initial status of CEO/VIP mode (after (re)loading script)


; Chat snippets (you can add more, comment them out or remove them, the pushs that is)
ArrayChatSnippets := []
ArrayChatSnippets.push("Player saved outfits please :)")
ArrayChatSnippets.push("Yay, cheaters")
ArrayChatSnippets.push("I take that explosive sniper of yours and insert it sideways...")
ArrayChatSnippets.push("You want some cool AHK macros? github.com/2called-chaos/gtav-online-ahk")


; Delays (you normally don't want to change these, you can try to play with these values if you have a slow/fast PC)
IntFocusDelay        := 100  ; delay (in ms) after focussing game when AHK-GUI took focus.
IntMenuDelay         := 120  ; delay (in ms) after opening interaction menu.
IntPhoneMenuDelay    := 800 ; delay (in ms) after opening phone menu. default(1850)
IntPhoneMenuDelay2   := 250  ; delay (in ms) after selecting phone menu entries.
IntPhoneScrollDelay  := 75   ; delay (in ms) between scrolls in the phone menu.
IntKeySendDelay      := 25   ; delay (in ms) delay between send key commands.
IntKeyPressDuration  := 5    ; duration (in ms) each key press is held down.
IntMenuEscDelay      := 1000    ; duration (in ms) each key press is held down.


; In case you changed your ingame bindings:
IGB_Interaction := "m"
IGB_Phone := "up"


; Phone numbers for DialDialog GUI dialog (you can change the order if you want or hide entries by commenting them out)
ArrayPhonebook := []
ArrayPhonebook.push("911           - Emergency Services")
ArrayPhonebook.push("328-555-0153  - Mechanic")
ArrayPhonebook.push("611-555-0149  - Mors Mutual Insurance")
ArrayPhonebook.push("328-555-0122  - Pegasus Lifestyle Management")
ArrayPhonebook.push("273-555-0120  - Merryweather Security")
ArrayPhonebook.push("346-555-0176  - Atomic Blimp")
ArrayPhonebook.push("323-555-5555  - Downtown Cab Co.")
ArrayPhonebook.push("346-555-0102  - Lester Crest")
ArrayPhonebook.push("555-0182      - (useless) *modem* ")
ArrayPhonebook.push("1-999-9327667 - (useless) *holding music* ")
ArrayPhonebook.push("425-555-0170  - (useless) 'This mailbox is full' ")
ArrayPhonebook.push("310-555-0156  - (useless) *Pickup* .. *Hangup*")
ArrayPhonebook.push("1-999-768822  - (useless) 'This number is no longer in service'")
ArrayPhonebook.push("273-555-0155  - (useless) Truthseeker Helpline")

; ==============================
; === CONFIGURATION GOES ^^^ ===
; ==============================










; ================================================
; === Are you sure you want to scroll further? ===
; ================================================


#NoEnv
SetWorkingDir A_ScriptDir

; Disables hotkeys when alt-tabbed or GTA is closed.
#IfWinActive ahk_class grcWindow

; Hotkey/Function mapping
Hotkey, %SnackMenuKey%, SnackMenu
Hotkey, %AutoHealthKey%, AutoHealth
Hotkey, %ArmorMenuKey%, ArmorMenu
Hotkey, %AutoArmorKey%, AutoArmor
Hotkey, %TogglePassiveKey%, TogglePassive
Hotkey, %RetrieveCarKey%, RetrieveCar
Hotkey, %EquipScarfKey%, EquipScarf
Hotkey, %CycleOutfitKey%, CycleOutfit
Hotkey, %ToggleVIPKey%, ToggleVIP
Hotkey, %KillGameKey%, KillGame
Hotkey, %ForceDisconnectKey%, ForceDisconnect
Hotkey, %RandomHeistKey%, RandomHeist
Hotkey, %ChatSnippetsKey%, ChatSnippets
Hotkey, %CEOBuzzardKey%, CEOBuzzard
Hotkey, %DialDialogKey%, DialDialog
Hotkey, %CallMechanicKey%, CallMechanic
Hotkey, %CallPegasusKey%, CallPegasus
Hotkey, %CallMerryweatherKey%, CallMerryweather
Hotkey, %CallInsuranceKey%, CallInsurance
Hotkey, %CallLesterKey%, CallLester
Hotkey, %ThermalVisionKey%, ThermalVision
Hotkey, %OpressorMKIIKey%, OpressorMKII
Hotkey, %NanoDroneKey%, NanoDrone
Hotkey, %RCBanditoKey%, RCBandito
Hotkey, %RCTankKey%, RCTank
Hotkey, %RegisterCEOKey%, RegisterCEO
Hotkey, %RegisterMCKey%, RegisterMC
Hotkey, %RetireVIPKey%, RetireVIP
Hotkey, %StorageMCKey%, StorageMC
Hotkey, %ChangeMapKey%, ChangeMap
Hotkey, %SaveMoneyKey%, SaveMoney

; Sets delay(ms) between keystrokes issued. Arguments are delay between keystrokes and press duration, respectively.
; They might be able to go lower but these values are pretty fast and work reliably.
setkeydelay, IntKeySendDelay, IntKeyPressDuration

; setup done, only functions and macros follow
Return



; =================
; === Functions ===
; =================

; CenterWindow(WinTitle) {
; WinGetPos,,, Width, Height, Grand Theft Auto V
; WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
; }

statusVIP(IsVIPActivated) {
  if(IsVIPActivated) {
  Progress, b ct008000 CWnwhite fs14 zh0, VIP mode ACTIVO, , VIP mode, Verdana
  } else {
  Progress, b ctred CWnwhite fs14 zh0, VIP mode DESABILITADO, , VIP mode, Verdana
  }
WinSet, TransColor, FFFFFF 150, VIP mode
; WinMove, VIP mode, , 2810, 0 ; Use SpyMonitor to set position X, Y.
Sleep, 1000
Progress, Off
bringGameIntoFocus()
}

openInteractionMenu(isVIPActive) {
  global IntMenuDelay
  global IGB_Interaction
  Send {%IGB_Interaction%}
  sleep, IntMenuDelay
  if (isVIPActive = 1) {
    Send {Down}
  }
}

openInventory() {
  Send {Down}{Down}{Enter}
}

openStyle() {
  Send {Down}{Down}{Down}{Enter}
}

openVehicle() {
  Send {Down}{Down}{Down}{Down}{Enter}
}

openVehicleOwner() {
  Send {Down}{Down}{Down}{Down}{Down}{Enter}
}

openSettings() {
  Send {Esc}
  Sleep 700
  Send {d}{d}{d}{d}
  Sleep 400
  Send {Enter}
  Sleep 400
  Send {s}{s}{s}{s}{s}
  Sleep 400
  Send {Enter}
  Sleep 400
  Send {s}{s}{s}{s}{s}
  Sleep 200
  Send {Enter}
  Sleep 100
  Send {Esc}{Esc}{Esc}{Esc}
}

openPhone() {
  global IntPhoneMenuDelay
  global IGB_Phone

  ; Opens Phone Menu
  Send {%IGB_Phone%}

  ; Necessary delay to allow phone menu to open properly (which it often doesn't anyways)
  sleep, IntPhoneMenuDelay
}

scrollPhoneUp(by = 1) {
  global IntPhoneScrollDelay
  Loop %by% {
    MouseClick, WheelUp, , , 20, 0, D, R
    Sleep IntPhoneScrollDelay
  }
}

makeCall(scrollUp, doOpenPhone = false, menu = 2) {
  global IntPhoneMenuDelay2
  global IntKeySendDelay
  if(doOpenPhone)
    openPhone()

  ; go to contacts
  scrollPhoneUp(menu)
  sleep IntKeySendDelay
  Send {Enter}
  sleep IntPhoneMenuDelay2

  ; scroll to contact
  scrollPhoneUp(scrollUp)

  ; call it
  Send {Enter}
}

dialNumber(number, doOpenPhone = false) {
  global IntKeySendDelay
  global IntKeyPressDuration
  global IntPhoneScrollDelay
  global IntPhoneMenuDelay2

  if(doOpenPhone)
    openPhone()

  ; go to contacts
  scrollPhoneUp(2)
  Send {Enter}
  sleep IntPhoneMenuDelay2

  ; enter number screen
  Send {Space}
  sleep IntPhoneMenuDelay2

  ; change key delay for this function
  setkeydelay IntPhoneScrollDelay, IntKeyPressDuration

  ; cleanup number
  number_clean := RegExReplace(number, "[^0-9]", "")

  ; enter the actual number
  pointer := 1
  Loop, parse, number_clean
  {
    deltax := _phonePointerCol(A_LoopField) - _phonePointerCol(pointer)
    deltay := _phonePointerRow(A_LoopField) - _phonePointerRow(pointer)

    ; wrap around shortcuts
    if (deltax = 2)
      deltax := -1
    if (deltax = -2)
      deltax := 1
    if (deltay = -3)
      deltay := 1
    if (deltay = 3)
      deltay := -1

    ; move pointer
    if (deltax > 0)
      Send {right %deltax%}

    if (deltay > 0)
      Send {down %deltay%}
    
    if (deltax < 0) {
      deltax := Abs(deltax)
      Send {left %deltax%}
    }
    
    if (deltay < 0) {
      deltay := Abs(deltay)
      Send {up %deltay%}
    }

    pointer := A_LoopField
    Send {Enter}
  }

  ; reset key delay (should not be necessary)
  setkeydelay IntKeySendDelay, IntKeyPressDuration

  ; call it
  Send {Space}
}

_phonePointerRow(num) {
  if (num = 0)
    return 4
  else
    return Ceil(num / 3)
}

_phonePointerCol(num) {
  if (num = 0)
    return 2
  else
    div := Mod(num, 3)
    return div = 0 ? 3 : div
}

splashCountdown(title, message, seconds, addZero = false) {
  Loop %seconds% {
    SplashTextOn 250, 20, %title%, % StrReplace(message, "%i", seconds + 1 - A_Index)
    Sleep 1000
  }
  if(addZero) {
    SplashTextOn 250, 20, %title%, % StrReplace(message, "%i", 0)
    Sleep 1000
  }
}

bringGameIntoFocus(applyDelay = false) {
  global IntFocusDelay
  WinActivate ahk_class grcWindow
  if(applyDelay)
    Sleep IntFocusDelay
}



; ===================
; === Subroutines ===
; ===================

; Force the game to disconnect by suspending the process for 10 seconds
; Requires pssuspend.exe (see readme)
ForceDisconnect:
  if (DoConfirmDisconnect) {
    MsgBox, 1, , Force disconnect?, 5
    IfMsgBox, Cancel
      Return
    IfMsgBox, Timeout
      Return
  }
  Run, pssuspend gta5.exe ,,Hide
  splashCountdown("ForceDisconnect", "Hang on tight (%i)", IntDisconnectDelay, true)
  Run, pssuspend -r gta5.exe ,,Hide
  Sleep 1000
  SplashTextOff
  bringGameIntoFocus()
  return

; kill game process
; Requires pskill.exe (see readme)
KillGame:
  if (DoConfirmKill) {
    MsgBox, 1, , Kill game process?, 5
    IfMsgBox, Cancel
      Return
    IfMsgBox, Timeout
      Return
  }
  Run, pskill gta5.exe ,,Hide
  return

; Toggle VIP mode (if VIP/CEO/MC all interaction menu entries are offset by one)
ToggleVIP:
  IsVIPActivated := !IsVIPActivated
  statusVIP(IsVIPActivated)
  return

; RetireVIP
RetireVIP:
  if (IsVIPActivated) {
      openInteractionMenu(false)
      Send {Enter}{Up}{Enter}{%IGB_Interaction%}
      IsVIPActivated := false
      statusVIP(IsVIPActivated)
    } else {
      statusVIP(IsVIPActivated)
    }
  return

; RegisterCEO
RegisterCEO:
  if (IsVIPActivated) {
      statusVIP(IsVIPActivated)
    } else {
      openInteractionMenu(false)
      Send {Down}{Down}{Down}{Down}{Down}{Down}{Enter}{Enter}{%IGB_Interaction%}
      IsVIPActivated := true
      statusVIP(IsVIPActivated)
    }
  return

; RegisterMC
RegisterMC:
  if (IsVIPActivated) {
      statusVIP(IsVIPActivated)
    } else {
      openInteractionMenu(false)
      Send {Down}{Down}{Down}{Down}{Down}{Down}{Down}{Enter}{Enter}{%IGB_Interaction%}
      IsVIPActivated := true
      statusVIP(IsVIPActivated)
    }
  return

; StorageMC
StorageMC:
  if (IsVIPActivated) {
      openInteractionMenu(false)
      Send {Enter}{Enter}{%IGB_Interaction%}
    } else {
      statusVIP(IsVIPActivated)
    }
  return


; Open up snack menu for manual selection (or stock check) of snacks
SnackMenu:
  openInteractionMenu(IsVIPActivated)
  openInventory()
  Send {Down}{Down}{Enter}
  return

; Automatic snacking. Eats 2 snacks from second snack slot and close menu.
AutoHealth:
  openInteractionMenu(IsVIPActivated)
  openInventory()
  Send {Down}{Down}{Enter}
  Send {Down}{Enter}{Enter}{%IGB_Interaction%}
  return

; Open up armor menu for manual selection (or stock check) of armor
ArmorMenu:
  openInteractionMenu(IsVIPActivated)
  openInventory()
  Send {Down}{Enter}
  return

; Equips super heavy armor and exits menu automatically
AutoArmor:
  openInteractionMenu(IsVIPActivated)
  openInventory()
  Send {Down}{Enter}
  Send {Down}{Down}{Down}{Down}{Enter}{%IGB_Interaction%}
  return

; Equips scarf to allow faster running with heist armor (see readme/misc)
EquipScarf:
  openInteractionMenu(IsVIPActivated)
  openStyle()
  Send {Down}{Enter} ; Opens scarf men
  Send {Up}{Up}{Up}{Up}{Right}{%IGB_Interaction%} ; equip scarf and exit menu. This line can be changed to pick different scarfs.
  return

; Cycle between your saved outfits
CycleOutfit:
  openInteractionMenu(IsVIPActivated)
  openStyle()
  Send {Down}{Down}{Down}{Right}{Enter}{%IGB_Interaction%}
  return

; ThermalVision
ThermalVision:
  openInteractionMenu(IsVIPActivated)
  openStyle()
  Send {Down}{Enter}{Down}{Down}{Down}{Down}{Space}
  return

; Toggle passive mode
TogglePassive:
  openInteractionMenu(false) ; Ignore VIP status when going up
  Send {Up}{Enter}{%IGB_Interaction%}
  return

; Retrieve your currently active vehicle
RetrieveCar:
  openInteractionMenu(IsVIPActivated)
  Send {Down}{Down}{Down}{Down}{Enter}{Enter}{%IGB_Interaction%}
  return

; OpressorMKII
OpressorMKII:
  openInteractionMenu(IsVIPActivated)
  openVehicleOwner()
  Send {Up}{Enter}{Down}{Down} ; {Enter}{%IGB_Interaction%}
  return

; NanoDrone
NanoDrone:
  openInteractionMenu(IsVIPActivated)
  openInventory()
  Send {Up}{Up}{Up}{Up}{Up}{Enter}{%IGB_Interaction%}
  return

; RCBandito
RCBandito:
  openInteractionMenu(IsVIPActivated)
  openInventory()
  Send {Up}{Up}{Up}{Up}{Enter}{%IGB_Interaction%}
  return

; RCTank
RCTank:
  openInteractionMenu(IsVIPActivated)
  openInventory()
  Send {Up}{Up}{Up}{Enter}{%IGB_Interaction%}
  return

; ChangeMap
ChangeMap:
  openSettings()
  return

;SaveMoney
SaveMoney:
  Sleep 400
  Send {Joy4}
  Sleep 400
return

; Chooses on-call random heist from phone options
RandomHeist:
  makeCall(13, true, 1)
  sleep IntKeySendDelay
  scrollPhoneUp(2) ; scroll up twice to solo-q
  Send {Enter}{Enter}
  return

; Calls in free CEO buzzard (if you are CEO)
CEOBuzzard:
  openInteractionMenu(false)
  Send {Enter}{Up 2}{Enter}{Down 4}{Enter}
  return

; Show a list of chat snippets to type out (chat must be opened)
ChatSnippets:
  Gui, CSNIP:add, Text, , Choose your snippet:
  for index, element in ArrayChatSnippets
  {
    if (index = 1) {
      Gui, CSNIP:add, Radio, vSnippetChoice, %element%
    } else {
      Gui, CSNIP:add, Radio, , %element%
    }
  }

  Gui, CSNIP:add, Button, Default g_ChatSnippetsTypeout, type out...
  Gui, CSNIP:show
  Return

CSNIPGuiEscape:
  Gui, CSNIP:cancel
  Gui, CSNIP:destroy
  bringGameIntoFocus()
  return

CSNIPGuiClose:
  Gui, CSNIP:cancel
  Gui, CSNIP:destroy
  bringGameIntoFocus()
  return

_ChatSnippetsTypeout:
  Gui, CSNIP:submit
  bringGameIntoFocus(true)
  Send % ArrayChatSnippets[SnippetChoice]
  Gui, CSNIP:destroy
  Return

; Phone calls
DialDialog:
  pbl := ""
  For each, item in ArrayPhonebook
    pbl .= (!pbl ? "" : "|") item
  Gui, DIAL:add, Text, , double click item
  Gui, DIAL:Font,, Courier New
  Gui, DIAL:add, ListBox, w500 h250 vPhoneNumberSelect g_DialDialogMakeCallFromSelect, %pbl%
  Gui, DIAL:Font,, Arial
  Gui, DIAL:add, Text, , or type number:
  Gui, DIAL:add, Edit, w500 vPhoneNumber,
  Gui, DIAL:add, Button, w500 Default g_DialDialogMakeCall, make call...
  Gui, DIAL:show
  return

DIALGuiEscape:
  Gui, DIAL:cancel
  Gui, DIAL:destroy
  bringGameIntoFocus()
  return

DIALGuiClose:
  Gui, DIAL:cancel
  Gui, DIAL:destroy
  bringGameIntoFocus()
  return

_DialDialogMakeCallFromSelect:
  if(A_GuiEvent = "DoubleClick")
    GoTo _DialDialogMakeCall
  Return

_DialDialogMakeCall:
  Gui, DIAL:submit
  bringGameIntoFocus(true)
  if PhoneNumber
    dialNumber(PhoneNumber, true)
  else if PhoneNumberSelect
    dialNumber(PhoneNumberSelect, true)
  Gui, DIAL:destroy
  return

CallMechanic:
  ;makeCall(8, true)
  dialNumber("328-555-0153", true)
  return

CallPegasus:
  ;makeCall(4, true)
  dialNumber("328-555-0122", true)
  return

CallMerryweather:
  ;makeCall(7, true)
  dialNumber("273-555-0120", true)
  return

CallInsurance:
  ;makeCall(6, true)
  dialNumber("611-555-0149", true)
  return

CallLester:
  ;makeCall(12, true)
  dialNumber("346-555-0102", true)
  return
