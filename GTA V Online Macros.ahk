;
; GTA V Online AHK-Macros v1.3 by Drascor
; Forked from 2called-chaos
; based on/inspired by GTA V Useful Macros v4.21 by twentyafterfour
;
; # Description
;
; Provides hotkeys for opening snack menu, equipping armor, entering passive mode and much more.
;
;
; # General Notes
;
;   * Read the god damn readme, please! https://github.com/Drascor/gtav-online-ahk/blob/master/README.md
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
;     https://github.com/Drascor/gtav-online-ahk        (Fork)
;     https://github.com/2called-chaos/gtav-online-ahk  (Original)
;


; ==============================
; === CONFIGURATION GOES vvv ===
; ==============================


#NoEnv
SetWorkingDir %A_ScriptDir%
CFG = GTAV.ini

; Disables hotkeys when alt-tabbed or GTA is closed.
#IfWinActive ahk_class grcWindow


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

IniRead,DoConfirmKill,%CFG%,Settings,DoConfirmKill
IniRead,DoConfirmDisconnect,%CFG%,Settings,DoConfirmDisconnect
IniRead,IntDisconnectDelay,%CFG%,Settings,IntDisconnectDelay
IniRead,IsVIPActivated,%CFG%,Settings,IsVIPActivated
IniRead,SetTransparency,%CFG%,Settings,SetTransparency
;IniRead,SetWinX,%CFG%,Settings,SetWinX
;IniRead,SetWinY,%CFG%,Settings,SetWinY
;SetWinXm             = x%SetWinX%  ; Use SpyMonitor to set position X. (A_ScreenWidth/2)-(Width/2)
;SetWinYm             = y%SetWinY%    ; Use SpyMonitor to set position Y. (A_ScreenHeight/2)-(Height/2)

; ================================================
; === Are you sure you want to scroll further? ===
; ================================================

;--Combat--
IniRead,SnackMenuKey,%CFG%,Hotkeys,SnackMenuKey,F24
IniRead,AutoHealthKey,%CFG%,Hotkeys,AutoHealthKey,F24
IniRead,ArmorMenuKey,%CFG%,Hotkeys,ArmorMenuKey,F24
IniRead,AutoArmorKey,%CFG%,Hotkeys,AutoArmorKey,F24
IniRead,TogglePassiveKey,%CFG%,Hotkeys,TogglePassiveKey,F24
;--Charapter--
IniRead,EquipScarfKey,%CFG%,Hotkeys,EquipScarfKey,F24
IniRead,CycleOutfitKey,%CFG%,Hotkeys,CycleOutfitKey,F24
IniRead,ThermalVisionKey,%CFG%,Hotkeys,ThermalVisionKey,F24
;--VIP--
IniRead,ToggleVIPKey,%CFG%,Hotkeys,ToggleVIPKey,F24
IniRead,RegisterCEOKey,%CFG%,Hotkeys,RegisterCEOKey,F24
IniRead,RegisterMCKey,%CFG%,Hotkeys,RegisterMCKey,F24
IniRead,RetireVIPKey,%CFG%,Hotkeys,RetireVIPKey,F24
IniRead,CEOBuzzardKey,%CFG%,Hotkeys,CEOBuzzardKey,F24
IniRead,StorageMCKey,%CFG%,Hotkeys,StorageMCKey,F24
;--Vehicle--
IniRead,RetrieveCarKey,%CFG%,Hotkeys,RetrieveCarKey,F24
IniRead,OpressorMKIIKey,%CFG%,Hotkeys,OpressorMKIIKey,F24
IniRead,NanoDroneKey,%CFG%,Hotkeys,NanoDroneKey,F24
IniRead,RCBanditoKey,%CFG%,Hotkeys,RCBanditoKey,F24
IniRead,RCTankKey,%CFG%,Hotkeys,RCTankKey,F24
;--Call--
IniRead,DialDialogKey,%CFG%,Hotkeys,DialDialogKey,F24
IniRead,CallMechanicKey,%CFG%,Hotkeys,CallMechanicKey,F24
IniRead,CallPegasusKey,%CFG%,Hotkeys,CallPegasusKey,F24
IniRead,CallMerryweatherKey,%CFG%,Hotkeys,CallMerryweatherKey,F24
IniRead,CallInsuranceKey,%CFG%,Hotkeys,CallInsuranceKey,F24
IniRead,CallLesterKey,%CFG%,Hotkeys,CallLesterKey,F24
;--Word--
IniRead,KillGameKey,%CFG%,Hotkeys,KillGameKey,F24
IniRead,ForceDisconnectKey,%CFG%,Hotkeys,ForceDisconnectKey,F24
IniRead,ChangeMapKey,%CFG%,Hotkeys,ChangeMapKey,F24
IniRead,RandomHeistKey,%CFG%,Hotkeys,RandomHeistKey,F24
IniRead,ChatSnippetsKey,%CFG%,Hotkeys,ChatSnippetsKey,F24
;--Macro--
IniRead,SaveMoneyKey,%CFG%,Hotkeys,SaveMoneyKey,F24
IniRead,ReloadMacroKey,%CFG%,Hotkeys,ReloadMacroKey,F24
IniRead,PauseMacroKey,%CFG%,Hotkeys,PauseMacroKey,F24
IniRead,SuspendMacroKey,%CFG%,Hotkeys,SuspendMacroKey,F24
IniRead,ExitMacroKey,%CFG%,Hotkeys,ExitMacroKey,F24
IniRead,MacroGuiKey,%CFG%,Hotkeys,MacroGuiKey,F24
IniRead,MacroEditGuiKey,%CFG%,Hotkeys,MacroEditGuiKey,F24

; Hotkey/Function mapping
;

;--Combat--
Hotkey, %SnackMenuKey%, SnackMenu
Hotkey, %AutoHealthKey%, AutoHealth
Hotkey, %ArmorMenuKey%, ArmorMenu
Hotkey, %AutoArmorKey%, AutoArmor
Hotkey, %TogglePassiveKey%, TogglePassive
;--Charapter--
Hotkey, %CycleOutfitKey%, CycleOutfit
Hotkey, %ThermalVisionKey%, ThermalVision
Hotkey, %EquipScarfKey%, EquipScarf
;--VIP--
Hotkey, %ToggleVIPKey%, ToggleVIP
Hotkey, %RegisterCEOKey%, RegisterCEO
Hotkey, %RegisterMCKey%, RegisterMC
Hotkey, %RetireVIPKey%, RetireVIP
Hotkey, %CEOBuzzardKey%, CEOBuzzard
Hotkey, %StorageMCKey%, StorageMC
;--Vehicle--
Hotkey, %RetrieveCarKey%, RetrieveCar
Hotkey, %OpressorMKIIKey%, OpressorMKII
Hotkey, %NanoDroneKey%, NanoDrone
Hotkey, %RCBanditoKey%, RCBandito
Hotkey, %RCTankKey%, RCTank
;--Call--
Hotkey, %DialDialogKey%, DialDialog
Hotkey, %CallMechanicKey%, CallMechanic
Hotkey, %CallPegasusKey%, CallPegasus
Hotkey, %CallMerryweatherKey%, CallMerryweather
Hotkey, %CallInsuranceKey%, CallInsurance
Hotkey, %CallLesterKey%, CallLester
;--Word--
Hotkey, %KillGameKey%, KillGame
Hotkey, %ForceDisconnectKey%, ForceDisconnect
Hotkey, %ChangeMapKey%, ChangeMap
Hotkey, %RandomHeistKey%, RandomHeist
Hotkey, %ChatSnippetsKey%, ChatSnippets
;--Macro--
Hotkey, %SaveMoneyKey%, SaveMoney
Hotkey, %ReloadMacroKey%, ReloadMacro
Hotkey, %PauseMacroKey%, PauseMacro
Hotkey, %SuspendMacroKey%, SuspendMacro
Hotkey, %ExitMacroKey%, ExitMacro
Hotkey, %MacroGuiKey%, MacroGui
Hotkey, %MacroEditGuiKey%, MacroEditGui

ArrayMacros := []
ArrayMacros.push(";--Combat--")
ArrayMacros.push("SnackMenu - " SnackMenuKey)
ArrayMacros.push("AutoHealth - " AutoHealthKey)
ArrayMacros.push("ArmorMenu - " ArmorMenuKey)
ArrayMacros.push("AutoArmor - " AutoArmorKey)
ArrayMacros.push("TogglePassive - " TogglePassiveKey)
ArrayMacros.push(";--Charapter--")
ArrayMacros.push("CycleOutfit - " CycleOutfitKey)
ArrayMacros.push("ThermalVision - " ThermalVisionKey)
ArrayMacros.push("EquipScarf - " EquipScarfKey)
ArrayMacros.push(";--VIP--")
ArrayMacros.push("ToggleVIP - " ToggleVIPKey)
ArrayMacros.push("RegisterCEO - " RegisterCEOKey)
ArrayMacros.push("RegisterMC - " RegisterMCKey)
ArrayMacros.push("RetireVIP - " RetireVIPKey)
ArrayMacros.push("CEOBuzzard - " CEOBuzzardKey)
ArrayMacros.push("StorageMC - " StorageMCKey)
ArrayMacros.push(";--Vehicle--")
ArrayMacros.push("RetrieveCar - " RetrieveCarKey)
ArrayMacros.push("OpressorMKII - " OpressorMKIIKey)
ArrayMacros.push("NanoDrone - " NanoDroneKey)
ArrayMacros.push("RCBandito - " RCBanditoKey)
ArrayMacros.push("RCTank - " RCTankKey)
ArrayMacros.push(";--Call--")
ArrayMacros.push("DialDialog - " DialDialogKey)
ArrayMacros.push("CallMechanic - " CallMechanicKey)
ArrayMacros.push("CallPegasus - " CallPegasusKey)
ArrayMacros.push("CallMerryweather - " CallMerryweatherKey)
ArrayMacros.push("CallInsurance - " CallInsuranceKey)
ArrayMacros.push("CallLester - " CallLesterKey)
ArrayMacros.push(";--Word--")
ArrayMacros.push("KillGame - " KillGameKey)
ArrayMacros.push("ForceDisconnect - " ForceDisconnectKey)
ArrayMacros.push("ChangeMap - " ChangeMapKey)
ArrayMacros.push("RandomHeist - " RandomHeistKey)
ArrayMacros.push("ChatSnippets - " ChatSnippetsKey)
ArrayMacros.push(";--Macro--")
ArrayMacros.push("SaveMoney - " SaveMoneyKey)
ArrayMacros.push("ReloadMacro - " ReloadMacroKey)
ArrayMacros.push("PauseMacro - " PauseMacroKey)
ArrayMacros.push("SuspendMacro - " SuspendMacroKey)
ArrayMacros.push("ExitMacro - " ExitMacroKey)
ArrayMacros.push("MacroGui - " MacroGuiKey)
ArrayMacros.push("MacroEditGui - " MacroEditGuiKey)

; Sets delay(ms) between keystrokes issued. Arguments are delay between keystrokes and press duration, respectively.
; They might be able to go lower but these values are pretty fast and work reliably.
setkeydelay, IntKeySendDelay, IntKeyPressDuration

; setup done, only functions and macros follow
Return



; =================
; === Functions ===
; =================

statusVIP(IsVIPActivated) {
  msgTitle := A_ThisLabel
  if(IsVIPActivated) {
  Progress, b ct008000 CWnwhite fs14 zh0, %A_ThisFunc% - ACTIVO, , %msgTitle%, Verdana
  } else {
  Progress, b ctred CWnwhite fs14 zh0, %A_ThisFunc% - DESABILITADO, , %msgTitle%, Verdana
  }
  setWin()
  Sleep, 700
  Progress, Off
  bringGameIntoFocus()
}

setWin() {
  msgTitle := A_ThisLabel
  global SetWinX
  global SetWinY
  global SetTransparency
  WinSet, TransColor, FFFFFF %SetTransparency%, %msgTitle%
  WinMove, %msgTitle%, , %SetWinX%, %SetWinY%
  msgTitle := ""
}

msgFunc() {
  msgTitle := A_ThisLabel
  msg00 := A_ThisLabel
  Progress, b ct000FFF CWnwhite fs14 zh0, % msg00 " - Activated", , %msgTitle%, Verdana
  setWin()
  Sleep, 700
  Progress, Off
  msgTitle := ""
  msg00 := ""
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
  msgTitle := A_ThisLabel
  Loop %seconds% {
    ; SplashTextOn 250, 20, %title%, % StrReplace(message, "%i", seconds + 1 - A_Index)
    Progress, b ct008000 CWnwhite fs14 zh0, % StrReplace(message, "%i", seconds + 1 - A_Index), , %msgTitle%, Verdana
    setWin()
    Sleep 1000
  }
  if(addZero) {
    ; SplashTextOn 250, 20, %title%, % StrReplace(message, "%i", 0)
    Progress, b ct008000 CWnwhite fs14 zh0, % StrReplace(message, "%i", 0), , %msgTitle%, Verdana
    setWin()
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

WinMoveMsgBox:
  global SetWinX
  global SetWinY
  global SetTransparency
  If WinExist(WinName)
    SetTimer, WinMoveMsgBox, OFF
  WinSet, TransColor, EEAA99 %SetTransparency%, %WinName%
  WinMove, %WinName%, , %SetWinX%, %SetWinY%
return

ForceDisconnect:
  if (DoConfirmDisconnect) {
    WinName := A_ThisLabel                ;
    SetTimer, WinMoveMsgBox, 50       ;
    Sleep 100                         ;
    MsgBox, 1, %WinName%, Force disconnect?, 5
    IfMsgBox, Cancel
      return
    IfMsgBox, Timeout
      return
  }
  Run, pssuspend gta5.exe ,,Hide
  splashCountdown("ForceDisconnect", "Hang on tight (%i)", IntDisconnectDelay, true)
  Run, pssuspend -r gta5.exe ,,Hide
  Sleep 1000
  ; SplashTextOff
  Progress, Off
  bringGameIntoFocus()
  msgFunc()
  return

; kill game process
; Requires pskill.exe (see readme)
KillGame:
  if (DoConfirmKill) {
    WinName := A_ThisLabel                ;
    SetTimer, WinMoveMsgBox, 50           ;
    Sleep 100                             ;
    MsgBox, 1, %WinName%, Kill game process?, 5
    IfMsgBox, Cancel
      return
    IfMsgBox, Timeout
      return
  }
  Run, pskill gta5.exe ,,Hide
  msgFunc()
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
  msgFunc()
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
  msgFunc()
  return

; StorageMC
StorageMC:
  if (IsVIPActivated) {
      openInteractionMenu(false)
      Send {Enter}{Enter}{%IGB_Interaction%}
    } else {
      statusVIP(IsVIPActivated)
    }
  msgFunc()
  return


; Open up snack menu for manual selection (or stock check) of snacks
SnackMenu:
  openInteractionMenu(IsVIPActivated)
  openInventory()
  Send {Down}{Down}{Enter}
  Send {Down}
  msgFunc()
  return

; Automatic snacking. Eats 2 snacks from second snack slot and close menu.
AutoHealth:
  openInteractionMenu(IsVIPActivated)
  openInventory()
  Send {Down}{Down}{Enter}
  Send {Down}{Enter}{Enter}{%IGB_Interaction%}
  msgFunc()
  return

; Open up armor menu for manual selection (or stock check) of armor
ArmorMenu:
  openInteractionMenu(IsVIPActivated)
  openInventory()
  Send {Down}{Enter}
  Send {Down}{Down}{Down}{Down}
  msgFunc()
  return

; Equips super heavy armor and exits menu automatically
AutoArmor:
  openInteractionMenu(IsVIPActivated)
  openInventory()
  Send {Down}{Enter}
  Send {Down}{Down}{Down}{Down}{Enter}{%IGB_Interaction%}
  msgFunc()
  return

; Equips scarf to allow faster running with heist armor (see readme/misc)
EquipScarf:
  openInteractionMenu(IsVIPActivated)
  openStyle()
  Send {Down}{Enter} ; Opens scarf men
  Send {Up}{Up}{Up}{Up}{Right}{%IGB_Interaction%} ; equip scarf and exit menu. This line can be changed to pick different scarfs.
  msgFunc()
  return

; Cycle between your saved outfits
CycleOutfit:
  openInteractionMenu(IsVIPActivated)
  openStyle()
  Send {Down}{Down}{Down}{Right}{Enter}{%IGB_Interaction%}
  msgFunc()
  return

; ThermalVision
ThermalVision:
  openInteractionMenu(IsVIPActivated)
  openStyle()
  Send {Down}{Enter}{Down}{Down}{Down}{Down}{Space}
  msgFunc()
  return

; Toggle passive mode
TogglePassive:
  openInteractionMenu(false) ; Ignore VIP status when going up
  Send {Up}{Enter}{%IGB_Interaction%}
  msgFunc()
  return

; Retrieve your currently active vehicle
RetrieveCar:
  openInteractionMenu(IsVIPActivated)
  Send {Down}{Down}{Down}{Down}{Enter}{Enter}{%IGB_Interaction%}
  msgFunc()
  return

; OpressorMKII
OpressorMKII:
  openInteractionMenu(IsVIPActivated)
  openVehicleOwner()
  Send {Up}{Enter}{Down}{Down} ; {Enter}{%IGB_Interaction%}
  msgFunc()
  return

; NanoDrone
NanoDrone:
  openInteractionMenu(IsVIPActivated)
  openInventory()
  Send {Up}{Up}{Up}{Up}{Up}{Enter}{%IGB_Interaction%}
  msgFunc()
  return

; RCBandito
RCBandito:
  openInteractionMenu(IsVIPActivated)
  openInventory()
  Send {Up}{Up}{Up}{Up}{Enter}{%IGB_Interaction%}
  msgFunc()
  return

; RCTank
RCTank:
  openInteractionMenu(IsVIPActivated)
  openInventory()
  Send {Up}{Up}{Up}{Enter}{%IGB_Interaction%}
  msgFunc()
  return

; ChangeMap
ChangeMap:
  openSettings()
  Send {s}{s}{s}{s}{s}
  Sleep 400
  Send {Enter}
  Sleep 400
  Send {s}{s}{s}{s}{s}
  Sleep 200
  Send {Enter}
  Sleep 100
  Send {Esc}{Esc}{Esc}{Esc}{Esc}
  Sleep 100
  msgFunc()
  return

;SaveMoney
SaveMoney:
  Sleep 400
  Send {Joy4}
  Sleep 400
  msgFunc()
  return

; Chooses on-call random heist from phone options
RandomHeist:
  makeCall(13, true, 1)
  sleep IntKeySendDelay
  scrollPhoneUp(2) ; scroll up twice to solo-q
  Send {Enter}{Enter}
  msgFunc()
  return

; Calls in free CEO buzzard (if you are CEO)
CEOBuzzard:
  openInteractionMenu(false)
  Send {Enter}{Up 2}{Enter}{Down 4}{Enter}
  msgFunc()
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
  global SetWinXm
  global SetWinYm
  global SetTransparency
  pbl := ""
  For each, item in ArrayPhonebook
    pbl .= (!pbl ? "" : "|") item
  Gui, DIAL:add, Text, , double click item
  Gui, DIAL:Font, s10, Verdana
  Gui, DIAL:add, ListBox, w500 h250 vPhoneNumberSelect g_DialDialogMakeCallFromSelect, %pbl%
  Gui, DIAL:Font, s9, Verdana
  Gui, DIAL:add, Text, , or type number:
  Gui, DIAL:add, Edit, w500 vPhoneNumber,
  Gui, DIAL:add, Button, w500 Default g_DialDialogMakeCall, make call...
  Gui +LastFound  ; Make the GUI window the last found window for use by the line below.
  WinSet, TransColor, EEAA99 %SetTransparency%,
  Gui, DIAL:show, %SetWinXm% %SetWinYm%,
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

; =====================
; === Option Script ===
; =====================

ReloadMacro:
  msgFunc()
  Reload                        ;
  Sleep 500                     ;
  WinName := "Reload Script"    ;
  SetTimer, WinMoveMsgBox, 50   ;
  Sleep 100
  MsgBox, 4, %WinName%, The script could not be reloaded. Would you like to open it for editing?
  IfMsgBox, Yes, Edit
  WinWait, %WinName%, , 3
  if ErrorLevel
  {
      MsgBox, WinWait timed out.
      return
  }
  else
      WinMinimize                ; Minimize the window found by WinWait.
  return

PauseMacro:
  Pause                         ;
  msgFunc()
  return

SuspendMacro:
  msgFunc()
  Suspend                        ;
  return

ExitMacro:
  msgFunc()
  ExitApp                        ;
  return


; ===========
; === GUI ===
; ===========

MacroGui:
  global SetWinXm
  global SetWinYm
  global SetTransparency
  mcr := ""
  ; MacroSelect := 0
  For each, item in ArrayMacros
    mcr .= (!mcr ? "" : "|") item
  Gui, Macro:add, ListBox, w200 h300 vMacroSelect g_MacroGuiDialogFromSelect, %mcr%
  Gui, Macro:Font, s9, Verdana
  Gui, Macro:add, Button, w0 Default g_MacroGuiDialogMake, ok
  ; Gui +LastFound  ; Make the GUI window the last found window for use by the line below.
  WinSet, TransColor, EEAA99 %SetTransparency%, Macro
  Gui, Macro:show, %SetWinXm% %SetWinYm%,
  ; WinWait, %Macro%,,1000
  ; bringGameIntoFocus()
  return

MacroGuiEscape:
  Gui, Macro:cancel
  Gui, Macro:destroy
  bringGameIntoFocus()
  return

MacroGuiClose:
  Gui, Macro:cancel
  Gui, Macro:destroy
  bringGameIntoFocus()
  return

_MacroGuiDialogFromSelect:
  if(A_GuiEvent = "DoubleClick")
    GoTo _MacroGuiDialogMake
  return

_MacroGuiDialogMake:
  Gui, Macro:submit
  MacroSelectClean := RegExReplace(MacroSelect, " -.*", "")
  Gui, Macro:destroy
  if IsLabel(MacroSelectClean)
  GoTo %MacroSelectClean%
  return


;_____________________________________________
MacroEditGui:
  global SetWinX
  global SetWinY
  global SetTransparency
;   mcrn := ""
;   mcrk := ""
;   For each, item in ArrayMacros
;     mcre .= (!mcre ? "" : "|") item
;     ; mcrn := RegExReplace(RegExReplace(mcre, " -.*", "")mcre, " -.*", "")
;     ; mcrk := RegExReplace(RegExReplace(mcre, ".*- ", "")mcre, " -.*", "")
;   Gui, MacroS:Add, Text,, %mcre%
;   ; Gui, MacroS:Add, Hotkey,vmcrk ym ,%mcrk%

; ;_____________________________________________
;   Gui, MacroS:Font, s9, Verdana
;   Gui, MacroS:show, x%SetWinX% y%SetWinY%,
;   Gui +LastFound  ; Make the GUI window the last found window for use by the line below.
;   WinSet, TransColor, EEAA99 %SetTransparency%, MacroS
;   MsgBox, % mcrn
;   Sleep 10000
;   Gui, MacroS:cancel
;   Gui, MacroS:destroy
  return
