{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

(*
	 File:       CarbonCore/Gestalt.h

	 Contains:   Gestalt Interfaces.

	 Version:    CarbonCore-859.2~178

	 Copyright:  © 1988-2008 by Apple Computer, Inc.  All rights reserved

	 Bugs?:      For bug reports, consult the following page on
				 the World Wide Web:

					 http://developer.apple.com/bugreporter/

*)

type
  SelectorFunctionProcPtr = function(selector: OSType; response: PSInt32): OSErr;
  {$EXTERNALSYM SelectorFunctionProcPtr}
  SelectorFunctionUPP = SelectorFunctionProcPtr;
  {$EXTERNALSYM SelectorFunctionUPP}
  PSelectorFunctionUPP = ^SelectorFunctionUPP;
  {$EXTERNALSYM PSelectorFunctionUPP}

(*
 *  Gestalt()
 *
 *  Summary:
 *    Gestalt returns information about the operating environment.
 *
 *  Discussion:
 *    The Gestalt function places the information requested by the
 *    selector parameter in the variable parameter response . Note that
 *    Gestalt returns the response from all selectors in an SInt32,
 *    which occupies 4 bytes. When not all 4 bytes are needed, the
 *    significant information appears in the low-order byte or bytes.
 *    Although the response parameter is declared as a variable
 *    parameter, you cannot use it to pass information to Gestalt or to
 *    a Gestalt selector function. Gestalt interprets the response
 *    parameter as an address at which it is to place the result
 *    returned by the selector function specified by the selector
 *    parameter. Gestalt ignores any information already at that
 *    address.
 *
 *    The Apple-defined selector codes fall into two categories:
 *    environmental selectors, which supply specific environmental
 *    information you can use to control the behavior of your
 *    application, and informational selectors, which supply
 *    information you can't use to determine what hardware or software
 *    features are available. You can use one of the selector codes
 *    defined by Apple (listed in the "Constants" section beginning on
 *    page 1-14 ) or a selector code defined by a third-party
 *    product.
 *
 *    The meaning of the value that Gestalt returns in the response
 *    parameter depends on the selector code with which it was called.
 *    For example, if you call Gestalt using the gestaltTimeMgrVersion
 *    selector, it returns a version code in the response parameter. In
 *    this case, a returned value of 3 indicates that the extended Time
 *    Manager is available.
 *
 *    In most cases, the last few characters in the selector's symbolic
 *    name form a suffix that indicates what type of value you can
 *    expect Gestalt to place in the response parameter. For example,
 *    if the suffix in a Gestalt selector is Size , then Gestalt
 *    returns a size in the response parameter.
 *
 *    Attr:  A range of 32 bits, the meanings of which are defined by a
 *    list of constants. Bit 0 is the least significant bit of the
 *    SInt32.
 *    Count: A number indicating how many of the indicated type of item
 *    exist.
 *    Size: A size, usually in bytes.
 *    Table: The base address of a table.
 *    Type: An index to a list of feature descriptions.
 *    Version: A version number, which can be either a constant with a
 *    defined meaning or an actual version number, usually stored as
 *    four hexadecimal digits in the low-order word of the return
 *    value. Implied decimal points may separate digits. The value
 *    $0701, for example, returned in response to the
 *    gestaltSystemVersion selector, represents system software version
 *    7.0.1.
 *
 *    Selectors that have the suffix Attr deserve special attention.
 *    They cause Gestalt to return a bit field that your application
 *    must interpret to determine whether a desired feature is present.
 *    For example, the application-defined sample function
 *    MyGetSoundAttr , defined in Listing 1-2 on page 1-6 , returns a
 *    LongInt that contains the Sound Manager attributes field
 *    retrieved from Gestalt . To determine whether a particular
 *    feature is available, you need to look at the designated bit.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.3
 *
 *  Parameters:
 *
 *    selector:
 *      The selector to return information for
 *
 *    response:
 *      On exit, the requested information whose format depends on the
 *      selector specified.
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *)
{$EXTERNALSYM Gestalt}
function Gestalt(selector: OSType; response: PSInt32): OSErr; cdecl;

(*
 *  ReplaceGestalt()   *** DEPRECATED ***
 *
 *  Deprecated:
 *    Use NewGestaltValue instead wherever possible.
 *
 *  Summary:
 *    Replaces the gestalt function associated with a selector.
 *
 *  Discussion:
 *    The ReplaceGestalt function replaces the selector function
 *    associated with an existing selector code.
 *
 *    So that your function can call the function previously associated
 *    with the selector, ReplaceGestalt places the address of the old
 *    selector function in the oldGestaltFunction parameter. If
 *    ReplaceGestalt returns an error of any type, then the value of
 *    oldGestaltFunction is undefined.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.3
 *
 *  Parameters:
 *
 *    selector:
 *      the selector to replace
 *
 *    gestaltFunction:
 *      a UPP for the new selector function
 *
 *    oldGestaltFunction:
 *      on exit, a pointer to the UPP of the previously associated with
 *      the specified selector
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.3
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *)
{$EXTERNALSYM ReplaceGestalt}
function ReplaceGestalt(selector: OSType;
  gestaltFunction: SelectorFunctionUPP;
  oldGestaltFunction: PSelectorFunctionUPP): OSErr; cdecl;

(*
 *  NewGestalt()   *** DEPRECATED ***
 *
 *  Deprecated:
 *    Use NewGestaltValue instead wherever possible.
 *
 *  Summary:
 *    Adds a selector code to those already recognized by Gestalt.
 *
 *  Discussion:
 *    The NewGestalt function registers a specified selector code with
 *    the Gestalt Manager so that when the Gestalt function is called
 *    with that selector code, the specified selector function is
 *    executed. Before calling NewGestalt, you must define a selector
 *    function callback. See SelectorFunctionProcPtr for a description
 *    of how to define your selector function.
 *
 *    Registering with the Gestalt Manager is a way for software such
 *    as system extensions to make their presence known to potential
 *    users of their services.
 *
 *    In Mac OS X, the selector and replacement value are on a
 *    per-context basis. That means they are available only to the
 *    application or other code that installs them. You cannot use this
 *    function to make information available to another process.
 *
 *    A Gestalt selector registered with NewGestalt() can not be
 *    deleted.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.3
 *
 *  Parameters:
 *
 *    selector:
 *      the selector to create
 *
 *    gestaltFunction:
 *      a UPP for the new selector function, which Gestalt executes
 *      when it receives the new selector code. See
 *      SelectorFunctionProcPtr for more information on the callback
 *      you need to provide.
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.3
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *)
{$EXTERNALSYM NewGestalt}
function NewGestalt(
  selector: OSType;
  gestaltFunction: SelectorFunctionUPP): OSErr;  cdecl;

(*
 *  NewGestaltValue()
 *
 *  Summary:
 *    Adds a selector code to those already recognized by Gestalt.
 *
 *  Discussion:
 *    The NewGestalt function registers a specified selector code with
 *    the Gestalt Manager so that when the Gestalt function is called
 *    with that selector code, the specified selector function is
 *    executed. Before calling NewGestalt, you must define a selector
 *    function callback. See SelectorFunctionProcPtr for a description
 *    of how to define your selector function.
 *
 *    Registering with the Gestalt Manager is a way for software such
 *    as system extensions to make their presence known to potential
 *    users of their services.
 *
 *    In Mac OS X, the selector and replacement value are on a
 *    per-context basis. That means they are available only to the
 *    application or other code that installs them. You cannot use this
 *    function to make information available to another process.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.3
 *
 *  Parameters:
 *
 *    selector:
 *      the selector to create
 *
 *    newValue:
 *      the value to return for the new selector code.
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *)
{$EXTERNALSYM NewGestaltValue}
function NewGestaltValue(selector: OSType; newValue: SInt32): OSErr;  cdecl;


(*
 *  ReplaceGestaltValue()
 *
 *  Summary:
 *    Replaces the value that the function Gestalt returns for a
 *    specified selector code with the value provided to the function.
 *
 *  Discussion:
 *    You use the function ReplaceGestaltValue to replace an existing
 *    value. You should not call this function to introduce a value
 *    that doesn't already exist; instead call the function
 *    NewGestaltValue.
 *
 *    In Mac OS X, the selector and replacement value are on a
 *    per-context basis. That means they are available only to the
 *    application or other code that installs them. You cannot use this
 *    function to make information available to another process.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.3
 *
 *  Parameters:
 *
 *    selector:
 *      the selector to create
 *
 *    replacementValue:
 *      the new value to return for the new selector code.
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *)
{$EXTERNALSYM ReplaceGestaltValue}
function ReplaceGestaltValue(
  selector: OSType;
  replacementValue: SInt32): OSErr; cdecl;


(*
 *  SetGestaltValue()
 *
 *  Summary:
 *    Sets the value the function Gestalt will return for a specified
 *    selector code, installing the selector if it was not already
 *    installed.
 *
 *  Discussion:
 *    You use SetGestaltValue to establish a value for a selector,
 *    without regard to whether the selector was already installed.
 *
 *    In Mac OS X, the selector and replacement value are on a
 *    per-context basis. That means they are available only to the
 *    application or other code that installs them. You cannot use this
 *    function to make information available to another process.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.3
 *
 *  Parameters:
 *
 *    selector:
 *      the selector to create
 *
 *    newValue:
 *      the new value to return for the new selector code.
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *)
{$EXTERNALSYM SetGestaltValue}
function SetGestaltValue(selector: OSType; newValue: SInt32): OSErr; cdecl;


(*
 *  DeleteGestaltValue()
 *
 *  Summary:
 *    Deletes a Gestalt selector code so that it is no longer
 *    recognized by Gestalt.
 *
 *  Discussion:
 *    After calling this function, subsequent query or replacement
 *    calls for the selector code will fail as if the selector had
 *    never been installed
 *
 *    In Mac OS X, the selector and replacement value are on a
 *    per-context basis. That means they are available only to the
 *    application or other code that installs them.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.3
 *
 *  Parameters:
 *
 *    selector:
 *      the selector to delete
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *)
{$EXTERNALSYM DeleteGestaltValue}
function DeleteGestaltValue(selector: OSType): OSErr; cdecl;

(*
 *  NewSelectorFunctionUPP()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   available as macro/inline
 *)
{$EXTERNALSYM NewSelectorFunctionUPP}
function NewSelectorFunctionUPP(userRoutine: SelectorFunctionProcPtr): SelectorFunctionUPP; cdecl;

(*
 *  DisposeSelectorFunctionUPP()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   available as macro/inline
 *)
{$EXTERNALSYM DisposeSelectorFunctionUPP}
procedure DisposeSelectorFunctionUPP(userUPP: SelectorFunctionUPP); cdecl;

(*
 *  InvokeSelectorFunctionUPP()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   available as macro/inline
 *)
{$EXTERNALSYM InvokeSelectorFunctionUPP}
function InvokeSelectorFunctionUPP(
  selector: OSType;
  response: PSInt32;
  userUPP: SelectorFunctionUPP): OSErr; cdecl;

//TODO translate
(*
#if __MACH__
  #ifdef __cplusplus
    inline SelectorFunctionUPP                                  NewSelectorFunctionUPP(SelectorFunctionProcPtr userRoutine) { return userRoutine; }
    inline void                                                 DisposeSelectorFunctionUPP(SelectorFunctionUPP) { }
    inline OSErr                                                InvokeSelectorFunctionUPP(OSType selector, SInt32 * response, SelectorFunctionUPP userUPP) { return userUPP)(selector, response); }
  #else
    #define NewSelectorFunctionUPP(userRoutine)                 ((SelectorFunctionUPP)userRoutine)
    #define DisposeSelectorFunctionUPP(userUPP)
	#define InvokeSelectorFunctionUPP(selector, response, userUPP) userUPP)(selector, response)
  #endif
#endif
*)

const
(* Environment Selectors *)

  gestaltAddressingModeAttr: Integer     = Ord('a') shl 24 + Ord('d') shl 16 + Ord('d') shl 8 + Ord('r'); (* 'addr' - addressing mode attributes *)
  {$EXTERNALSYM gestaltAddressingModeAttr}
  gestalt32BitAddressing        = 0;    (* using 32-bit addressing mode *)
  {$EXTERNALSYM gestalt32BitAddressing}
  gestalt32BitSysZone           = 1;    (* 32-bit compatible system zone *)
  {$EXTERNALSYM gestalt32BitSysZone}
  gestalt32BitCapable           = 2;     (* Machine is 32-bit capable *)
  {$EXTERNALSYM gestalt32BitCapable}



  gestaltAFPClient: Integer     = Ord('a') shl 24 + Ord('f') shl 16 + Ord('p') shl 8 + Ord('s'); (* 'afps' *)
  {$EXTERNALSYM gestaltAFPClient}
  gestaltAFPClientVersionMask   = $0000FFFF; (* low word of SInt32 is the *)
  {$EXTERNALSYM gestaltAFPClientVersionMask}
                                        (* client version $0001 -> $0007*)
  gestaltAFPClient3_5           = $0001;
  {$EXTERNALSYM gestaltAFPClient3_5}
  gestaltAFPClient3_6           = $0002;
  {$EXTERNALSYM gestaltAFPClient3_6}
  gestaltAFPClient3_6_1         = $0003;
  {$EXTERNALSYM gestaltAFPClient3_6_1}
  gestaltAFPClient3_6_2         = $0004;
  {$EXTERNALSYM gestaltAFPClient3_6_2}
  gestaltAFPClient3_6_3         = $0005; (* including 3.6.4; 3.6.5*)
  {$EXTERNALSYM gestaltAFPClient3_6_3}
  gestaltAFPClient3_7           = $0006; (* including 3.7.1*)
  {$EXTERNALSYM gestaltAFPClient3_7}
  gestaltAFPClient3_7_2         = $0007; (* including 3.7.3; 3.7.4*)
  {$EXTERNALSYM gestaltAFPClient3_7_2}
  gestaltAFPClient3_8           = $0008;
  {$EXTERNALSYM gestaltAFPClient3_8}
  gestaltAFPClient3_8_1         = $0009; (* including 3.8.2 *)
  {$EXTERNALSYM gestaltAFPClient3_8_1}
  gestaltAFPClient3_8_3         = $000A;
  {$EXTERNALSYM gestaltAFPClient3_8_3}
  gestaltAFPClient3_8_4         = $000B; (* including 3.8.5; 3.8.6 *)
  {$EXTERNALSYM gestaltAFPClient3_8_4}
  gestaltAFPClientAttributeMask = $FFFF0000; (* high word of response is a *)
  {$EXTERNALSYM gestaltAFPClientAttributeMask}
                                        (* set of attribute bits*)
  gestaltAFPClientCfgRsrc       = 16;   (* Client uses config resources*)
  {$EXTERNALSYM gestaltAFPClientCfgRsrc}
  gestaltAFPClientSupportsIP    = 29;   (* Client supports AFP over TCP/IP*)
  {$EXTERNALSYM gestaltAFPClientSupportsIP}
  gestaltAFPClientVMUI          = 30;   (* Client can put up UI from the PBVolMount trap*)
  {$EXTERNALSYM gestaltAFPClientVMUI}
  gestaltAFPClientMultiReq      = 31;    (* Client supports multiple outstanding requests*)
  {$EXTERNALSYM gestaltAFPClientMultiReq}




  gestaltAliasMgrAttr: Integer     = Ord('a') shl 24 + Ord('l') shl 16 + Ord('i') shl 8 + Ord('s'); (* 'alis' - Alias Mgr Attributes *)
  {$EXTERNALSYM gestaltAliasMgrAttr}
  gestaltAliasMgrPresent        = 0;    (* True if the Alias Mgr is present *)
  {$EXTERNALSYM gestaltAliasMgrPresent}
  gestaltAliasMgrSupportsRemoteAppletalk = 1; (* True if the Alias Mgr knows about Remote Appletalk *)
  {$EXTERNALSYM gestaltAliasMgrSupportsRemoteAppletalk}
  gestaltAliasMgrSupportsAOCEKeychain = 2; (* True if the Alias Mgr knows about the AOCE Keychain *)
  {$EXTERNALSYM gestaltAliasMgrSupportsAOCEKeychain}
  gestaltAliasMgrResolveAliasFileWithMountOptions = 3; (* True if the Alias Mgr implements gestaltAliasMgrResolveAliasFileWithMountOptions() and IsAliasFile() *)
  {$EXTERNALSYM gestaltAliasMgrResolveAliasFileWithMountOptions}
  gestaltAliasMgrFollowsAliasesWhenResolving = 4;
  {$EXTERNALSYM gestaltAliasMgrFollowsAliasesWhenResolving}
  gestaltAliasMgrSupportsExtendedCalls = 5;
  {$EXTERNALSYM gestaltAliasMgrSupportsExtendedCalls}
  gestaltAliasMgrSupportsFSCalls = 6;   (* true if Alias Mgr supports HFS+ Calls *)
  {$EXTERNALSYM gestaltAliasMgrSupportsFSCalls}
  gestaltAliasMgrPrefersPath    = 7;    (* True if the Alias Mgr prioritizes the path over file id during resolution by default *)
  {$EXTERNALSYM gestaltAliasMgrPrefersPath}
  gestaltAliasMgrRequiresAccessors = 8;  (* Set if Alias Manager requires accessors for size and usertype *)
  {$EXTERNALSYM gestaltAliasMgrRequiresAccessors}


(* Gestalt selector and values for the Appearance Manager *)

  gestaltAppearanceAttr: Integer     = Ord('a') shl 24 + Ord('p') shl 16 + Ord('p') shl 8 + Ord('r'); (* 'appr' *)
  {$EXTERNALSYM gestaltAppearanceAttr}
  gestaltAppearanceExists       = 0;
  {$EXTERNALSYM gestaltAppearanceExists}
  gestaltAppearanceCompatMode   = 1;
  {$EXTERNALSYM gestaltAppearanceCompatMode}


(* Gestalt selector for determining Appearance Manager version   *)
(* If this selector does not exist; but gestaltAppearanceAttr    *)
(* does; it indicates that the 1.0 version is installed. This    *)
(* gestalt returns a BCD number representing the version of the  *)
(* Appearance Manager that is currently running; e.g. $0101 for *)
(* version 1.0.1.                                                *)

  gestaltAppearanceVersion: Integer     = Ord('a') shl 24 + Ord('p') shl 16 + Ord('v') shl 8 + Ord('r'); (* 'apvr' *)
  {$EXTERNALSYM gestaltAppearanceVersion}



  gestaltArbitorAttr: Integer     = Ord('a') shl 24 + Ord('r') shl 16 + Ord('b') shl 8 + Ord(' '); (* 'arb ' *)
  {$EXTERNALSYM gestaltArbitorAttr}
  gestaltSerialArbitrationExists = 0;    (* this bit if the serial port arbitrator exists*)
  {$EXTERNALSYM gestaltSerialArbitrationExists}



  gestaltAppleScriptVersion: Integer     = Ord('a') shl 24 + Ord('s') shl 16 + Ord('c') shl 8 + Ord('v'); (* 'ascv' - AppleScript version*)
  {$EXTERNALSYM gestaltAppleScriptVersion}



  gestaltAppleScriptAttr: Integer     = Ord('a') shl 24 + Ord('s') shl 16 + Ord('c') shl 8 + Ord('r'); (* 'ascr' - AppleScript attributes*)
  {$EXTERNALSYM gestaltAppleScriptAttr}
  gestaltAppleScriptPresent     = 0;
  {$EXTERNALSYM gestaltAppleScriptPresent}
  gestaltAppleScriptPowerPCSupport = 1;
  {$EXTERNALSYM gestaltAppleScriptPowerPCSupport}



  gestaltATAAttr: Integer     = Ord('a') shl 24 + Ord('t') shl 16 + Ord('a') shl 8 + Ord(' '); (* 'ata ' - ATA is the driver to support IDE hard disks *)
  {$EXTERNALSYM gestaltATAAttr}
  gestaltATAPresent             = 0;     (* if set; ATA Manager is present *)
  {$EXTERNALSYM gestaltATAPresent}



  gestaltATalkVersion: Integer     = Ord('a') shl 24 + Ord('t') shl 16 + Ord('k') shl 8 + Ord('v'); (* 'atkv' - Detailed AppleTalk version; see comment above for format *)
  {$EXTERNALSYM gestaltATalkVersion}



  gestaltAppleTalkVersion: Integer     = Ord('a') shl 24 + Ord('t') shl 16 + Ord('l') shl 8 + Ord('k'); (* 'atlk' - appletalk version *)
  {$EXTERNALSYM gestaltAppleTalkVersion}


(*
    FORMAT OF gestaltATalkVersion RESPONSE
    --------------------------------------
    The version is stored in the high three bytes of the response value.  Let us number
    the bytes in the response value from 0 to 3; where 0 is the least-significant byte.

        Byte#:     3 2 1 0
        Value:  $MMNNRR00

    Byte 3 (MM) contains the major revision number; byte 2 (NN) contains the minor
    revision number; and byte 1 (RR) contains a constant that represents the release
    stage.  Byte 0 always contains $00.  The constants for the release stages are:

        development = $20
        alpha       = $40
        beta        = $60
        final       = $80
        release     = $80

    For example; if you call Gestalt with the 'atkv' selector when AppleTalk version 57
    is loaded; you receive the integer response value $39008000.
*)

  gestaltAUXVersion: Integer     = Ord('a') shl 24 + Ord('/') shl 16 + Ord('u') shl 8 + Ord('x'); (* 'a/ux' - a/ux version; if present *)
  {$EXTERNALSYM gestaltAUXVersion}



  gestaltMacOSCompatibilityBoxAttr: Integer     = Ord('b') shl 24 + Ord('b') shl 16 + Ord('o') shl 8 + Ord('x'); (* 'bbox' - Classic presence and features *)
  {$EXTERNALSYM gestaltMacOSCompatibilityBoxAttr}
  gestaltMacOSCompatibilityBoxPresent = 0; (* True if running under the Classic *)
  {$EXTERNALSYM gestaltMacOSCompatibilityBoxPresent}
  gestaltMacOSCompatibilityBoxHasSerial = 1; (* True if Classic serial support is implemented. *)
  {$EXTERNALSYM gestaltMacOSCompatibilityBoxHasSerial}
  gestaltMacOSCompatibilityBoxless = 2;  (* True if we're Boxless (screen shared with Carbon/Cocoa) *)
  {$EXTERNALSYM gestaltMacOSCompatibilityBoxless}



  gestaltBusClkSpeed: Integer     = Ord('b') shl 24 + Ord('c') shl 16 + Ord('l') shl 8 + Ord('k'); (* 'bclk' - main I/O bus clock speed in hertz *)
  {$EXTERNALSYM gestaltBusClkSpeed}



  gestaltBusClkSpeedMHz: Integer     = Ord('b') shl 24 + Ord('c') shl 16 + Ord('l') shl 8 + Ord('m'); (* 'bclm' - main I/O bus clock speed in megahertz ( a UInt32 ) *)
  {$EXTERNALSYM gestaltBusClkSpeedMHz}



  gestaltCloseViewAttr: Integer     = Ord('B') shl 24 + Ord('S') shl 16 + Ord('D') shl 8 + Ord('a'); (* 'BSDa' - CloseView attributes *)
  {$EXTERNALSYM gestaltCloseViewAttr}
  gestaltCloseViewEnabled       = 0;    (* Closeview enabled (dynamic bit - returns current state) *)
  {$EXTERNALSYM gestaltCloseViewEnabled}
  gestaltCloseViewDisplayMgrFriendly = 1; (* Closeview compatible with Display Manager (FUTURE) *)
  {$EXTERNALSYM gestaltCloseViewDisplayMgrFriendly}



  gestaltCarbonVersion: Integer     = Ord('c') shl 24 + Ord('b') shl 16 + Ord('o') shl 8 + Ord('n'); (* 'cbon' - version of Carbon API present in system *)
  {$EXTERNALSYM gestaltCarbonVersion}



  gestaltCFMAttr: Integer     = Ord('c') shl 24 + Ord('f') shl 16 + Ord('r') shl 8 + Ord('g'); (* 'cfrg' - Selector for information about the Code Fragment Manager *)
  {$EXTERNALSYM gestaltCFMAttr}
  gestaltCFMPresent             = 0;    (* True if the Code Fragment Manager is present *)
  {$EXTERNALSYM gestaltCFMPresent}
  gestaltCFMPresentMask         = $0001;
  {$EXTERNALSYM gestaltCFMPresentMask}
  gestaltCFM99Present           = 2;    (* True if the CFM-99 features are present. *)
  {$EXTERNALSYM gestaltCFM99Present}
  gestaltCFM99PresentMask       = $0004;
  {$EXTERNALSYM gestaltCFM99PresentMask}



  gestaltProcessorCacheLineSize: Integer     = Ord('c') shl 24 + Ord('s') shl 16 + Ord('i') shl 8 + Ord('z'); (* 'csiz' - The size; in bytes; of the processor cache line. *)
  {$EXTERNALSYM gestaltProcessorCacheLineSize}



  gestaltCollectionMgrVersion: Integer     = Ord('c') shl 24 + Ord('l') shl 16 + Ord('t') shl 8 + Ord('n'); (* 'cltn' - Collection Manager version *)
  {$EXTERNALSYM gestaltCollectionMgrVersion}



  gestaltColorMatchingAttr: Integer     = Ord('c') shl 24 + Ord('m') shl 16 + Ord('t') shl 8 + Ord('a'); (* 'cmta' - ColorSync attributes *)
  {$EXTERNALSYM gestaltColorMatchingAttr}
  gestaltHighLevelMatching      = 0;
  {$EXTERNALSYM gestaltHighLevelMatching}
  gestaltColorMatchingLibLoaded = 1;
  {$EXTERNALSYM gestaltColorMatchingLibLoaded}



  gestaltColorMatchingVersion: Integer     = Ord('c') shl 24 + Ord('m') shl 16 + Ord('t') shl 8 + Ord('c'); (* 'cmtc' *)
  {$EXTERNALSYM gestaltColorMatchingVersion}
  gestaltColorSync10            = $0100; (* $0100 & $0110 _Gestalt versions for 1.0-1.0.3 product *)
  {$EXTERNALSYM gestaltColorSync10}
  gestaltColorSync11            = $0110; (*   $0100 == low-level matching only *)
  {$EXTERNALSYM gestaltColorSync11}
  gestaltColorSync104           = $0104; (* Real version; by popular demand *)
  {$EXTERNALSYM gestaltColorSync104}
  gestaltColorSync105           = $0105;
  {$EXTERNALSYM gestaltColorSync105}
  gestaltColorSync20            = $0200; (* ColorSync 2.0 *)
  {$EXTERNALSYM gestaltColorSync20}
  gestaltColorSync21            = $0210;
  {$EXTERNALSYM gestaltColorSync21}
  gestaltColorSync211           = $0211;
  {$EXTERNALSYM gestaltColorSync211}
  gestaltColorSync212           = $0212;
  {$EXTERNALSYM gestaltColorSync212}
  gestaltColorSync213           = $0213;
  {$EXTERNALSYM gestaltColorSync213}
  gestaltColorSync25            = $0250;
  {$EXTERNALSYM gestaltColorSync25}
  gestaltColorSync26            = $0260;
  {$EXTERNALSYM gestaltColorSync26}
  gestaltColorSync261           = $0261;
  {$EXTERNALSYM gestaltColorSync261}
  gestaltColorSync30            = $0300;
  {$EXTERNALSYM gestaltColorSync30}



  gestaltControlMgrVersion: Integer     = Ord('c') shl 24 + Ord('m') shl 16 + Ord('v') shl 8 + Ord('r'); (* 'cmvr' - NOTE: The first version we return is 3.0.1; on Mac OS X plus update 2*)
  {$EXTERNALSYM gestaltControlMgrVersion}



  gestaltControlMgrAttr: Integer     = Ord('c') shl 24 + Ord('n') shl 16 + Ord('t') shl 8 + Ord('l'); (* 'cntl' - Control Mgr*)
  {$EXTERNALSYM gestaltControlMgrAttr}
  gestaltControlMgrPresent      = (1 shl 0); (* NOTE: this is a bit mask; whereas all other Gestalt constants of*)
  {$EXTERNALSYM gestaltControlMgrPresent}
                                        (* this type are bit index values.   Universal Interfaces 3.2 slipped*)
                                        (* out the door with this mistake.*)
  gestaltControlMgrPresentBit   = 0;    (* bit number*)
  {$EXTERNALSYM gestaltControlMgrPresentBit}
  gestaltControlMsgPresentMask  = (1 shl gestaltControlMgrPresentBit);
  {$EXTERNALSYM gestaltControlMsgPresentMask}



  gestaltConnMgrAttr: Integer     = Ord('c') shl 24 + Ord('o') shl 16 + Ord('n') shl 8 + Ord('n'); (* 'conn' - connection mgr attributes    *)
  {$EXTERNALSYM gestaltConnMgrAttr}
  gestaltConnMgrPresent         = 0;
  {$EXTERNALSYM gestaltConnMgrPresent}
  gestaltConnMgrCMSearchFix     = 1;    (* Fix to CMAddSearch?     *)
  {$EXTERNALSYM gestaltConnMgrCMSearchFix}
  gestaltConnMgrErrorString     = 2;    (* has CMGetErrorString() *)
  {$EXTERNALSYM gestaltConnMgrErrorString}
  gestaltConnMgrMultiAsyncIO    = 3;     (* CMNewIOPB; CMDisposeIOPB; CMPBRead; CMPBWrite; CMPBIOKill *)
  {$EXTERNALSYM gestaltConnMgrMultiAsyncIO}



  gestaltColorPickerVersion: Integer     = Ord('c') shl 24 + Ord('p') shl 16 + Ord('k') shl 8 + Ord('r'); (* 'cpkr' - returns version of ColorPicker *)
  {$EXTERNALSYM gestaltColorPickerVersion}
  gestaltColorPicker: Integer     = Ord('c') shl 24 + Ord('p') shl 16 + Ord('k') shl 8 + Ord('r'); (* 'cpkr' - gestaltColorPicker is old name for gestaltColorPickerVersion *)
  {$EXTERNALSYM gestaltColorPicker}



  gestaltComponentMgr: Integer     = Ord('c') shl 24 + Ord('p') shl 16 + Ord('n') shl 8 + Ord('t'); (* 'cpnt' - Component Mgr version *)
  {$EXTERNALSYM gestaltComponentMgr}
  gestaltComponentPlatform: Integer     = Ord('c') shl 24 + Ord('o') shl 16 + Ord('p') shl 8 + Ord('l'); (* 'copl' - Component Platform number *)
  {$EXTERNALSYM gestaltComponentPlatform}


(*
    The gestaltNativeCPUtype ('cput') selector can be used to determine the
    native CPU type for all Macs running System 7.5 or later.

    However; the use of these selectors for pretty much anything is discouraged.
    If you are trying to determine if you can use a particular processor or
    operating system feature; it would be much better to check directly for that
    feature using one of the apis for doing so -- like; sysctl() or sysctlbyname().
    Those apis return information directly from the operating system and kernel.  By
    using those apis you may be able to avoid linking against Frameworks which you
    otherwise don't need; and may lessen the memory and code footprint of your
    applications.

    The gestaltNativeCPUfamily ('cpuf') selector can be used to determine the
    general family the native CPU is in.

    gestaltNativeCPUfamily uses the same results as gestaltNativeCPUtype; but
    will only return certain CPU values.

    IMPORTANT NOTE: gestaltNativeCPUFamily may no longer be updated for any new
                    processor families introduced after the 970.  If there are
                    processor specific features you need to be checking for in
                    your code; use one of the appropriate apis to get for those
                    exact features instead of assuming that all members of a given
                    cpu family exhibit the same behaviour.  The most appropriate api
                    to look at is sysctl() and sysctlbyname(); which return information
                    direct from the kernel about the system.
*)

  gestaltNativeCPUtype: Integer     = Ord('c') shl 24 + Ord('p') shl 16 + Ord('u') shl 8 + Ord('t'); (* 'cput' - Native CPU type                          *)
  {$EXTERNALSYM gestaltNativeCPUtype}
  gestaltNativeCPUfamily: Integer     = Ord('c') shl 24 + Ord('p') shl 16 + Ord('u') shl 8 + Ord('f'); (* 'cpuf' - Native CPU family                      *)
  {$EXTERNALSYM gestaltNativeCPUfamily}
  gestaltCPU68000               = 0;    (* Various 68k CPUs...    *)
  {$EXTERNALSYM gestaltCPU68000}
  gestaltCPU68010               = 1;
  {$EXTERNALSYM gestaltCPU68010}
  gestaltCPU68020               = 2;
  {$EXTERNALSYM gestaltCPU68020}
  gestaltCPU68030               = 3;
  {$EXTERNALSYM gestaltCPU68030}
  gestaltCPU68040               = 4;
  {$EXTERNALSYM gestaltCPU68040}
  gestaltCPU601                 = $0101; (* IBM 601                               *)
  {$EXTERNALSYM gestaltCPU601}
  gestaltCPU603                 = $0103;
  {$EXTERNALSYM gestaltCPU603}
  gestaltCPU604                 = $0104;
  {$EXTERNALSYM gestaltCPU604}
  gestaltCPU603e                = $0106;
  {$EXTERNALSYM gestaltCPU603e}
  gestaltCPU603ev               = $0107;
  {$EXTERNALSYM gestaltCPU603ev}
  gestaltCPU750                 = $0108; (* Also 740 - "G3" *)
  {$EXTERNALSYM gestaltCPU750}
  gestaltCPU604e                = $0109;
  {$EXTERNALSYM gestaltCPU604e}
  gestaltCPU604ev               = $010A; (* Mach 5; 250Mhz and up *)
  {$EXTERNALSYM gestaltCPU604ev}
  gestaltCPUG4                  = $010C; (* Max *)
  {$EXTERNALSYM gestaltCPUG4}
  gestaltCPUG47450              = $0110; (* Vger ; Altivec *)
  {$EXTERNALSYM gestaltCPUG47450}



  gestaltCPUApollo              = $0111; (* Apollo ; Altivec; G4 7455 *)
  {$EXTERNALSYM gestaltCPUApollo}
  gestaltCPUG47447              = $0112;
  {$EXTERNALSYM gestaltCPUG47447}
  gestaltCPU750FX               = $0120; (* Sahara;G3 like thing *)
  {$EXTERNALSYM gestaltCPU750FX}
  gestaltCPU970                 = $0139; (* G5 *)
  {$EXTERNALSYM gestaltCPU970}
  gestaltCPU970FX               = $013C; (* another G5 *)
  {$EXTERNALSYM gestaltCPU970FX}
  gestaltCPU970MP               = $0144;
  {$EXTERNALSYM gestaltCPU970MP}


                                        (* x86 CPUs all start with 'i' in the high nybble *)
  gestaltCPU486: Integer     = Ord('i') shl 24 + Ord('4') shl 16 + Ord('8') shl 8 + Ord('6'); (* 'i486' *)
  {$EXTERNALSYM gestaltCPU486}
  gestaltCPUPentium: Integer     = Ord('i') shl 24 + Ord('5') shl 16 + Ord('8') shl 8 + Ord('6'); (* 'i586' *)
  {$EXTERNALSYM gestaltCPUPentium}
  gestaltCPUPentiumPro          : Integer = Ord('i') shl 24 + Ord('5') shl 16 + Ord('p') shl 8 + Ord('r'); (* 'i5pr' *)
  {$EXTERNALSYM gestaltCPUPentiumPro}
  gestaltCPUPentiumII           : Integer = Ord('i') shl 24 + Ord('5') shl 16 + Ord('i') shl 8 + Ord('i'); (* 'i5ii' *)
  {$EXTERNALSYM gestaltCPUPentiumII}
  gestaltCPUX86                 : Integer = Ord('i') shl 24 + Ord('x') shl 16 + Ord('x') shl 8 + Ord('x'); (* 'ixxx' *)
  {$EXTERNALSYM gestaltCPUX86}
  gestaltCPUPentium4            : Integer = Ord('i') shl 24 + Ord('5') shl 16 + Ord('i') shl 8 + Ord('v'); (* 'i5iv' *)
  {$EXTERNALSYM gestaltCPUPentium4}



  gestaltCRMAttr                : Integer = Ord('c') shl 24 + Ord('r') shl 16 + Ord('m') shl 8 + Ord(' '); (* 'crm ' - comm resource mgr attributes *)
  {$EXTERNALSYM gestaltCRMAttr}
  gestaltCRMPresent             = 0;
  {$EXTERNALSYM gestaltCRMPresent}
  gestaltCRMPersistentFix       = 1;    (* fix for persistent tools *)
  {$EXTERNALSYM gestaltCRMPersistentFix}
  gestaltCRMToolRsrcCalls       = 2;     (* has CRMGetToolResource/ReleaseToolResource *)
  {$EXTERNALSYM gestaltCRMToolRsrcCalls}



  gestaltControlStripVersion    : Integer = Ord('c') shl 24 + Ord('s') shl 16 + Ord('v') shl 8 + Ord('r'); (* 'csvr' - Control Strip version (was 'sdvr') *)
  {$EXTERNALSYM gestaltControlStripVersion}



  gestaltCountOfCPUs            : Integer = Ord('c') shl 24 + Ord('p') shl 16 + Ord('u') shl 8 + Ord('s'); (* 'cpus' - the number of CPUs on the computer; Mac OS X 10.4 and later *)
  {$EXTERNALSYM gestaltCountOfCPUs}



  gestaltCTBVersion             : Integer = Ord('c') shl 24 + Ord('t') shl 16 + Ord('b') shl 8 + Ord('v'); (* 'ctbv' - CommToolbox version *)
  {$EXTERNALSYM gestaltCTBVersion}



  gestaltDBAccessMgrAttr        : Integer = Ord('d') shl 24 + Ord('b') shl 16 + Ord('a') shl 8 + Ord('c'); (* 'dbac' - Database Access Mgr attributes *)
  {$EXTERNALSYM gestaltDBAccessMgrAttr}
  gestaltDBAccessMgrPresent     = 0;     (* True if Database Access Mgr present *)
  {$EXTERNALSYM gestaltDBAccessMgrPresent}



  gestaltDiskCacheSize          : Integer = Ord('d') shl 24 + Ord('c') shl 16 + Ord('s') shl 8 + Ord('z'); (* 'dcsz' - Size of disk cache's buffers; in bytes *)
  {$EXTERNALSYM gestaltDiskCacheSize}



  gestaltSDPFindVersion         : Integer = Ord('d') shl 24 + Ord('f') shl 16 + Ord('n') shl 8 + Ord('d'); (* 'dfnd' - OCE Standard Directory Panel*)
  {$EXTERNALSYM gestaltSDPFindVersion}



  gestaltDictionaryMgrAttr      : Integer = Ord('d') shl 24 + Ord('i') shl 16 + Ord('c') shl 8 + Ord('t'); (* 'dict' - Dictionary Manager attributes *)
  {$EXTERNALSYM gestaltDictionaryMgrAttr}
  gestaltDictionaryMgrPresent   = 0;     (* Dictionary Manager attributes *)
  {$EXTERNALSYM gestaltDictionaryMgrPresent}



  gestaltDITLExtAttr            : Integer = Ord('d') shl 24 + Ord('i') shl 16 + Ord('t') shl 8 + Ord('l'); (* 'ditl' - AppenDITL; etc. calls from CTB *)
  {$EXTERNALSYM gestaltDITLExtAttr}
  gestaltDITLExtPresent         = 0;    (* True if calls are present *)
  {$EXTERNALSYM gestaltDITLExtPresent}
  gestaltDITLExtSupportsIctb    = 1;     (* True if AppendDITL; ShortenDITL support 'ictb's *)
  {$EXTERNALSYM gestaltDITLExtSupportsIctb}



  gestaltDialogMgrAttr          : Integer = Ord('d') shl 24 + Ord('l') shl 16 + Ord('o') shl 8 + Ord('g'); (* 'dlog' - Dialog Mgr*)
  {$EXTERNALSYM gestaltDialogMgrAttr}
  gestaltDialogMgrPresent       = (1 shl 0); (* NOTE: this is a bit mask; whereas all other Gestalt constants of*)
  {$EXTERNALSYM gestaltDialogMgrPresent}
                                        (* this type are bit index values.   Universal Interfaces 3.2 slipped*)
                                        (* out the door with this mistake.*)
  gestaltDialogMgrPresentBit    = 0;    (* bit number*)
  {$EXTERNALSYM gestaltDialogMgrPresentBit}
  gestaltDialogMgrHasAquaAlertBit = 2;  (* bit number*)
  {$EXTERNALSYM gestaltDialogMgrHasAquaAlertBit}
  gestaltDialogMgrPresentMask   = (1 shl gestaltDialogMgrPresentBit);
  {$EXTERNALSYM gestaltDialogMgrPresentMask}
  gestaltDialogMgrHasAquaAlertMask = (1 shl gestaltDialogMgrHasAquaAlertBit);
  {$EXTERNALSYM gestaltDialogMgrHasAquaAlertMask}
  gestaltDialogMsgPresentMask   = gestaltDialogMgrPresentMask; (* compatibility mask*)
  {$EXTERNALSYM gestaltDialogMsgPresentMask}



  gestaltDesktopPicturesAttr    : Integer = Ord('d') shl 24 + Ord('k') shl 16 + Ord('p') shl 8 + Ord('x'); (* 'dkpx' - Desktop Pictures attributes *)
  {$EXTERNALSYM gestaltDesktopPicturesAttr}
  gestaltDesktopPicturesInstalled = 0;  (* True if control panel is installed *)
  {$EXTERNALSYM gestaltDesktopPicturesInstalled}
  gestaltDesktopPicturesDisplayed = 1;   (* True if a picture is currently displayed *)
  {$EXTERNALSYM gestaltDesktopPicturesDisplayed}



  gestaltDisplayMgrVers         : Integer = Ord('d') shl 24 + Ord('p') shl 16 + Ord('l') shl 8 + Ord('v'); (* 'dplv' - Display Manager version *)
  {$EXTERNALSYM gestaltDisplayMgrVers}



  gestaltDisplayMgrAttr         : Integer = Ord('d') shl 24 + Ord('p') shl 16 + Ord('l') shl 8 + Ord('y'); (* 'dply' - Display Manager attributes *)
  {$EXTERNALSYM gestaltDisplayMgrAttr}
  gestaltDisplayMgrPresent      = 0;    (* True if Display Mgr is present *)
  {$EXTERNALSYM gestaltDisplayMgrPresent}
  gestaltDisplayMgrCanSwitchMirrored = 2; (* True if Display Mgr can switch modes on mirrored displays *)
  {$EXTERNALSYM gestaltDisplayMgrCanSwitchMirrored}
  gestaltDisplayMgrSetDepthNotifies = 3; (* True SetDepth generates displays mgr notification *)
  {$EXTERNALSYM gestaltDisplayMgrSetDepthNotifies}
  gestaltDisplayMgrCanConfirm   = 4;    (* True Display Manager supports DMConfirmConfiguration *)
  {$EXTERNALSYM gestaltDisplayMgrCanConfirm}
  gestaltDisplayMgrColorSyncAware = 5;  (* True if Display Manager supports profiles for displays *)
  {$EXTERNALSYM gestaltDisplayMgrColorSyncAware}
  gestaltDisplayMgrGeneratesProfiles = 6; (* True if Display Manager will automatically generate profiles for displays *)
  {$EXTERNALSYM gestaltDisplayMgrGeneratesProfiles}
  gestaltDisplayMgrSleepNotifies = 7;    (* True if Display Mgr generates "displayWillSleep"; "displayDidWake" notifications *)
  {$EXTERNALSYM gestaltDisplayMgrSleepNotifies}



  gestaltDragMgrAttr            : Integer = Ord('d') shl 24 + Ord('r') shl 16 + Ord('a') shl 8 + Ord('g'); (* 'drag' - Drag Manager attributes *)
  {$EXTERNALSYM gestaltDragMgrAttr}
  gestaltDragMgrPresent         = 0;    (* Drag Manager is present *)
  {$EXTERNALSYM gestaltDragMgrPresent}
  gestaltDragMgrFloatingWind    = 1;    (* Drag Manager supports floating windows *)
  {$EXTERNALSYM gestaltDragMgrFloatingWind}
  gestaltPPCDragLibPresent      = 2;    (* Drag Manager PPC DragLib is present *)
  {$EXTERNALSYM gestaltPPCDragLibPresent}
  gestaltDragMgrHasImageSupport = 3;    (* Drag Manager allows SetDragImage call *)
  {$EXTERNALSYM gestaltDragMgrHasImageSupport}
  gestaltCanStartDragInFloatWindow = 4; (* Drag Manager supports starting a drag in a floating window *)
  {$EXTERNALSYM gestaltCanStartDragInFloatWindow}
  gestaltSetDragImageUpdates    = 5;     (* Drag Manager supports drag image updating via SetDragImage *)
  {$EXTERNALSYM gestaltSetDragImageUpdates}



  gestaltDrawSprocketVersion    : Integer = Ord('d') shl 24 + Ord('s') shl 16 + Ord('p') shl 8 + Ord('v'); (* 'dspv' - Draw Sprocket version (as a NumVersion) *)
  {$EXTERNALSYM gestaltDrawSprocketVersion}



  gestaltDigitalSignatureVersion : Integer = Ord('d') shl 24 + Ord('s') shl 16 + Ord('i') shl 8 + Ord('g'); (* 'dsig' - returns Digital Signature Toolbox version in low-order word*)
  {$EXTERNALSYM gestaltDigitalSignatureVersion}


(*
   Desktop Printing Feature Gestalt
   Use this gestalt to check if third-party printer driver support is available
*)

  gestaltDTPFeatures            : Integer = Ord('d') shl 24 + Ord('t') shl 16 + Ord('p') shl 8 + Ord('f');   (* 'dtpf' *)
  {$EXTERNALSYM gestaltDTPFeatures}
  kDTPThirdPartySupported       = $00000004; (* mask for checking if third-party drivers are supported*)
  {$EXTERNALSYM kDTPThirdPartySupported}



(*
   Desktop Printer Info Gestalt
   Use this gestalt to get a hold of information for all of the active desktop printers
*)

  gestaltDTPInfo                : Integer = Ord('d') shl 24 + Ord('t') shl 16 + Ord('p') shl 8 + Ord('x'); (* 'dtpx' - returns GestaltDTPInfoHdle*)
  {$EXTERNALSYM gestaltDTPInfo}



  gestaltEasyAccessAttr         : Integer = Ord('e') shl 24 + Ord('a') shl 16 + Ord('s') shl 8 + Ord('y'); (* 'easy' - Easy Access attributes *)
  {$EXTERNALSYM gestaltEasyAccessAttr}
  gestaltEasyAccessOff          = 0;    (* if Easy Access present; but off (no icon) *)
  {$EXTERNALSYM gestaltEasyAccessOff}
  gestaltEasyAccessOn           = 1;    (* if Easy Access "On" *)
  {$EXTERNALSYM gestaltEasyAccessOn}
  gestaltEasyAccessSticky       = 2;    (* if Easy Access "Sticky" *)
  {$EXTERNALSYM gestaltEasyAccessSticky}
  gestaltEasyAccessLocked       = 3;     (* if Easy Access "Locked" *)
  {$EXTERNALSYM gestaltEasyAccessLocked}



  gestaltEditionMgrAttr         : Integer = Ord('e') shl 24 + Ord('d') shl 16 + Ord('t') shl 8 + Ord('n'); (* 'edtn' - Edition Mgr attributes *)
  {$EXTERNALSYM gestaltEditionMgrAttr}
  gestaltEditionMgrPresent      = 0;    (* True if Edition Mgr present *)
  {$EXTERNALSYM gestaltEditionMgrPresent}
  gestaltEditionMgrTranslationAware = 1; (* True if edition manager is translation manager aware *)
  {$EXTERNALSYM gestaltEditionMgrTranslationAware}



  gestaltAppleEventsAttr        : Integer = Ord('e') shl 24 + Ord('v') shl 16 + Ord('n') shl 8 + Ord('t'); (* 'evnt' - Apple Events attributes *)
  {$EXTERNALSYM gestaltAppleEventsAttr}
  gestaltAppleEventsPresent     = 0;    (* True if Apple Events present *)
  {$EXTERNALSYM gestaltAppleEventsPresent}
  gestaltScriptingSupport       = 1;
  {$EXTERNALSYM gestaltScriptingSupport}
  gestaltOSLInSystem            = 2;    (* OSL is in system so don’t use the one linked in to app *)
  {$EXTERNALSYM gestaltOSLInSystem}
  gestaltSupportsApplicationURL = 4;     (* Supports the typeApplicationURL addressing mode *)
  {$EXTERNALSYM gestaltSupportsApplicationURL}



  gestaltExtensionTableVersion  : Integer = Ord('e') shl 24 + Ord('t') shl 16 + Ord('b') shl 8 + Ord('l'); (* 'etbl' - ExtensionTable version *)
  {$EXTERNALSYM gestaltExtensionTableVersion}




  gestaltFBCIndexingState       : Integer = Ord('f') shl 24 + Ord('b') shl 16 + Ord('c') shl 8 + Ord('i'); (* 'fbci' - Find By Content indexing state*)
  {$EXTERNALSYM gestaltFBCIndexingState}
  gestaltFBCindexingSafe        = 0;    (* any search will result in synchronous wait*)
  {$EXTERNALSYM gestaltFBCindexingSafe}
  gestaltFBCindexingCritical    = 1;     (* any search will execute immediately*)
  {$EXTERNALSYM gestaltFBCindexingCritical}



  gestaltFBCVersion             : Integer = Ord('f') shl 24 + Ord('b') shl 16 + Ord('c') shl 8 + Ord('v'); (* 'fbcv' - Find By Content version*)
  {$EXTERNALSYM gestaltFBCVersion}
  gestaltFBCCurrentVersion      = $0011; (* First release for OS 8/9*)
  {$EXTERNALSYM gestaltFBCCurrentVersion}
  gestaltOSXFBCCurrentVersion   = $0100; (* First release for OS X*)
  {$EXTERNALSYM gestaltOSXFBCCurrentVersion}




  gestaltFileMappingAttr        : Integer = Ord('f') shl 24 + Ord('l') shl 16 + Ord('m') shl 8 + Ord('p'); (* 'flmp' - File mapping attributes*)
  {$EXTERNALSYM gestaltFileMappingAttr}
  gestaltFileMappingPresent     = 0;    (* bit is set if file mapping APIs are present*)
  {$EXTERNALSYM gestaltFileMappingPresent}
  gestaltFileMappingMultipleFilesFix = 1; (* bit is set if multiple files per volume can be mapped*)
  {$EXTERNALSYM gestaltFileMappingMultipleFilesFix}



  gestaltFloppyAttr             : Integer = Ord('f') shl 24 + Ord('l') shl 16 + Ord('p') shl 8 + Ord('y'); (* 'flpy' - Floppy disk drive/driver attributes *)
  {$EXTERNALSYM gestaltFloppyAttr}
  gestaltFloppyIsMFMOnly        = 0;    (* Floppy driver only supports MFM disk formats *)
  {$EXTERNALSYM gestaltFloppyIsMFMOnly}
  gestaltFloppyIsManualEject    = 1;    (* Floppy drive; driver; and file system are in manual-eject mode *)
  {$EXTERNALSYM gestaltFloppyIsManualEject}
  gestaltFloppyUsesDiskInPlace  = 2;     (* Floppy drive must have special DISK-IN-PLACE output; standard DISK-CHANGED not used *)
  {$EXTERNALSYM gestaltFloppyUsesDiskInPlace}



  gestaltFinderAttr             : Integer = Ord('f') shl 24 + Ord('n') shl 16 + Ord('d') shl 8 + Ord('r'); (* 'fndr' - Finder attributes *)
  {$EXTERNALSYM gestaltFinderAttr}
  gestaltFinderDropEvent        = 0;    (* Finder recognizes drop event *)
  {$EXTERNALSYM gestaltFinderDropEvent}
  gestaltFinderMagicPlacement   = 1;    (* Finder supports magic icon placement *)
  {$EXTERNALSYM gestaltFinderMagicPlacement}
  gestaltFinderCallsAEProcess   = 2;    (* Finder calls AEProcessAppleEvent *)
  {$EXTERNALSYM gestaltFinderCallsAEProcess}
  gestaltOSLCompliantFinder     = 3;    (* Finder is scriptable and recordable *)
  {$EXTERNALSYM gestaltOSLCompliantFinder}
  gestaltFinderSupports4GBVolumes = 4;  (* Finder correctly handles 4GB volumes *)
  {$EXTERNALSYM gestaltFinderSupports4GBVolumes}
  gestaltFinderHasClippings     = 6;    (* Finder supports Drag Manager clipping files *)
  {$EXTERNALSYM gestaltFinderHasClippings}
  gestaltFinderFullDragManagerSupport = 7; (* Finder accepts 'hfs ' flavors properly *)
  {$EXTERNALSYM gestaltFinderFullDragManagerSupport}
  gestaltFinderFloppyRootComments = 8;  (* in MacOS 8 and later; will be set if Finder ever supports comments on Floppy icons *)
  {$EXTERNALSYM gestaltFinderFloppyRootComments}
  gestaltFinderLargeAndNotSavedFlavorsOK = 9; (* in MacOS 8 and later; this bit is set if drags with >1024-byte flavors and flavorNotSaved flavors work reliably *)
  {$EXTERNALSYM gestaltFinderLargeAndNotSavedFlavorsOK}
  gestaltFinderUsesExtensibleFolderManager = 10; (* Finder uses Extensible Folder Manager (for example; for Magic Routing) *)
  {$EXTERNALSYM gestaltFinderUsesExtensibleFolderManager}
  gestaltFinderUnderstandsRedirectedDesktopFolder = 11; (* Finder deals with startup disk's desktop folder residing on another disk *)
  {$EXTERNALSYM gestaltFinderUnderstandsRedirectedDesktopFolder}



  gestaltFindFolderAttr         : Integer = Ord('f') shl 24 + Ord('o') shl 16 + Ord('l') shl 8 + Ord('d'); (* 'fold' - Folder Mgr attributes *)
  {$EXTERNALSYM gestaltFindFolderAttr}
  gestaltFindFolderPresent      = 0;    (* True if Folder Mgr present *)
  {$EXTERNALSYM gestaltFindFolderPresent}
  gestaltFolderDescSupport      = 1;    (* True if Folder Mgr has FolderDesc calls *)
  {$EXTERNALSYM gestaltFolderDescSupport}
  gestaltFolderMgrFollowsAliasesWhenResolving = 2; (* True if Folder Mgr follows folder aliases *)
  {$EXTERNALSYM gestaltFolderMgrFollowsAliasesWhenResolving}
  gestaltFolderMgrSupportsExtendedCalls = 3; (* True if Folder Mgr supports the Extended calls *)
  {$EXTERNALSYM gestaltFolderMgrSupportsExtendedCalls}
  gestaltFolderMgrSupportsDomains = 4;  (* True if Folder Mgr supports domains for the first parameter to FindFolder *)
  {$EXTERNALSYM gestaltFolderMgrSupportsDomains}
  gestaltFolderMgrSupportsFSCalls = 5;   (* True if FOlder manager supports __FindFolderFSRef & __FindFolderExtendedFSRef *)
  {$EXTERNALSYM gestaltFolderMgrSupportsFSCalls}



  gestaltFindFolderRedirectionAttr : Integer = Ord('f') shl 24 + Ord('o') shl 16 + Ord('l') shl 8 + Ord('e');   (* 'fole' *)
  {$EXTERNALSYM gestaltFindFolderRedirectionAttr}




  gestaltFontMgrAttr            : Integer = Ord('f') shl 24 + Ord('o') shl 16 + Ord('n') shl 8 + Ord('t'); (* 'font' - Font Mgr attributes *)
  {$EXTERNALSYM gestaltFontMgrAttr}
  gestaltOutlineFonts           = 0;     (* True if Outline Fonts supported *)
  {$EXTERNALSYM gestaltOutlineFonts}



  gestaltFPUType                : Integer = Ord('f') shl 24 + Ord('p') shl 16 + Ord('u') shl 8 + Ord(' '); (* 'fpu ' - fpu type *)
  {$EXTERNALSYM gestaltFPUType}
  gestaltNoFPU                  = 0;    (* no FPU *)
  {$EXTERNALSYM gestaltNoFPU}
  gestalt68881                  = 1;    (* 68881 FPU *)
  {$EXTERNALSYM gestalt68881}
  gestalt68882                  = 2;    (* 68882 FPU *)
  {$EXTERNALSYM gestalt68882}
  gestalt68040FPU               = 3;     (* 68040 built-in FPU *)
  {$EXTERNALSYM gestalt68040FPU}



  gestaltFSAttr                 : Integer = Ord('f') shl 24 + Ord('s') shl 16 + Ord(' ') shl 8 + Ord(' '); (* 'fs  ' - file system attributes *)
  {$EXTERNALSYM gestaltFSAttr}
  gestaltFullExtFSDispatching   = 0;    (* has really cool new HFSDispatch dispatcher *)
  {$EXTERNALSYM gestaltFullExtFSDispatching}
  gestaltHasFSSpecCalls         = 1;    (* has FSSpec calls *)
  {$EXTERNALSYM gestaltHasFSSpecCalls}
  gestaltHasFileSystemManager   = 2;    (* has a file system manager *)
  {$EXTERNALSYM gestaltHasFileSystemManager}
  gestaltFSMDoesDynamicLoad     = 3;    (* file system manager supports dynamic loading *)
  {$EXTERNALSYM gestaltFSMDoesDynamicLoad}
  gestaltFSSupports4GBVols      = 4;    (* file system supports 4 gigabyte volumes *)
  {$EXTERNALSYM gestaltFSSupports4GBVols}
  gestaltFSSupports2TBVols      = 5;    (* file system supports 2 terabyte volumes *)
  {$EXTERNALSYM gestaltFSSupports2TBVols}
  gestaltHasExtendedDiskInit    = 6;    (* has extended Disk Initialization calls *)
  {$EXTERNALSYM gestaltHasExtendedDiskInit}
  gestaltDTMgrSupportsFSM       = 7;    (* Desktop Manager support FSM-based foreign file systems *)
  {$EXTERNALSYM gestaltDTMgrSupportsFSM}
  gestaltFSNoMFSVols            = 8;    (* file system doesn't supports MFS volumes *)
  {$EXTERNALSYM gestaltFSNoMFSVols}
  gestaltFSSupportsHFSPlusVols  = 9;    (* file system supports HFS Plus volumes *)
  {$EXTERNALSYM gestaltFSSupportsHFSPlusVols}
  gestaltFSIncompatibleDFA82    = 10;    (* VCB and FCB structures changed; DFA 8.2 is incompatible *)
  {$EXTERNALSYM gestaltFSIncompatibleDFA82}



  gestaltFSSupportsDirectIO     = 11;    (* file system supports DirectIO *)
  {$EXTERNALSYM gestaltFSSupportsDirectIO}



  gestaltHasHFSPlusAPIs         = 12;   (* file system supports HFS Plus APIs *)
  {$EXTERNALSYM gestaltHasHFSPlusAPIs}
  gestaltMustUseFCBAccessors    = 13;   (* FCBSPtr and FSFCBLen are invalid - must use FSM FCB accessor functions*)
  {$EXTERNALSYM gestaltMustUseFCBAccessors}
  gestaltFSUsesPOSIXPathsForConversion = 14; (* The path interchange routines operate on POSIX paths instead of HFS paths *)
  {$EXTERNALSYM gestaltFSUsesPOSIXPathsForConversion}
  gestaltFSSupportsExclusiveLocks = 15; (* File system uses POSIX O_EXLOCK for opens *)
  {$EXTERNALSYM gestaltFSSupportsExclusiveLocks}
  gestaltFSSupportsHardLinkDetection = 16; (* File system returns if an item is a hard link *)
  {$EXTERNALSYM gestaltFSSupportsHardLinkDetection}
  gestaltFSAllowsConcurrentAsyncIO = 17; (* File Manager supports concurrent async reads and writes *)
  {$EXTERNALSYM gestaltFSAllowsConcurrentAsyncIO}



  gestaltAdminFeaturesFlagsAttr : Integer = Ord('f') shl 24 + Ord('r') shl 16 + Ord('e') shl 8 + Ord('d'); (* 'fred' - a set of admin flags; mostly useful internally. *)
  {$EXTERNALSYM gestaltAdminFeaturesFlagsAttr}
  gestaltFinderUsesSpecialOpenFoldersFile = 0; (* the Finder uses a special file to store the list of open folders *)
  {$EXTERNALSYM gestaltFinderUsesSpecialOpenFoldersFile}



  gestaltFSMVersion             : Integer = Ord('f') shl 24 + Ord('s') shl 16 + Ord('m') shl 8 + Ord(' '); (* 'fsm ' - returns version of HFS External File Systems Manager (FSM) *)
  {$EXTERNALSYM gestaltFSMVersion}



  gestaltFXfrMgrAttr            : Integer = Ord('f') shl 24 + Ord('x') shl 16 + Ord('f') shl 8 + Ord('r'); (* 'fxfr' - file transfer manager attributes *)
  {$EXTERNALSYM gestaltFXfrMgrAttr}
  gestaltFXfrMgrPresent         = 0;
  {$EXTERNALSYM gestaltFXfrMgrPresent}
  gestaltFXfrMgrMultiFile       = 1;    (* supports FTSend and FTReceive *)
  {$EXTERNALSYM gestaltFXfrMgrMultiFile}
  gestaltFXfrMgrErrorString     = 2;    (* supports FTGetErrorString *)
  {$EXTERNALSYM gestaltFXfrMgrErrorString}
  gestaltFXfrMgrAsync           = 3;     (*supports FTSendAsync; FTReceiveAsync; FTCompletionAsync*)
  {$EXTERNALSYM gestaltFXfrMgrAsync}



  gestaltGraphicsAttr           : Integer = Ord('g') shl 24 + Ord('f') shl 16 + Ord('x') shl 8 + Ord('a'); (* 'gfxa' - Quickdraw GX attributes selector *)
  {$EXTERNALSYM gestaltGraphicsAttr}
  gestaltGraphicsIsDebugging    = $00000001;
  {$EXTERNALSYM gestaltGraphicsIsDebugging}
  gestaltGraphicsIsLoaded       = $00000002;
  {$EXTERNALSYM gestaltGraphicsIsLoaded}
  gestaltGraphicsIsPowerPC      = $00000004;
  {$EXTERNALSYM gestaltGraphicsIsPowerPC}



  gestaltGraphicsVersion        : Integer = Ord('g') shl 24 + Ord('r') shl 16 + Ord('f') shl 8 + Ord('x'); (* 'grfx' - Quickdraw GX version selector *)
  {$EXTERNALSYM gestaltGraphicsVersion}
  gestaltCurrentGraphicsVersion = $00010200; (* the version described in this set of headers *)
  {$EXTERNALSYM gestaltCurrentGraphicsVersion}



  gestaltHardwareAttr           : Integer = Ord('h') shl 24 + Ord('d') shl 16 + Ord('w') shl 8 + Ord('r'); (* 'hdwr' - hardware attributes *)
  {$EXTERNALSYM gestaltHardwareAttr}
  gestaltHasVIA1                = 0;    (* VIA1 exists *)
  {$EXTERNALSYM gestaltHasVIA1}
  gestaltHasVIA2                = 1;    (* VIA2 exists *)
  {$EXTERNALSYM gestaltHasVIA2}
  gestaltHasASC                 = 3;    (* Apple Sound Chip exists *)
  {$EXTERNALSYM gestaltHasASC}
  gestaltHasSCC                 = 4;    (* SCC exists *)
  {$EXTERNALSYM gestaltHasSCC}
  gestaltHasSCSI                = 7;    (* SCSI exists *)
  {$EXTERNALSYM gestaltHasSCSI}
  gestaltHasSoftPowerOff        = 19;   (* Capable of software power off *)
  {$EXTERNALSYM gestaltHasSoftPowerOff}
  gestaltHasSCSI961             = 21;   (* 53C96 SCSI controller on internal bus *)
  {$EXTERNALSYM gestaltHasSCSI961}
  gestaltHasSCSI962             = 22;   (* 53C96 SCSI controller on external bus *)
  {$EXTERNALSYM gestaltHasSCSI962}
  gestaltHasUniversalROM        = 24;   (* Do we have a Universal ROM? *)
  {$EXTERNALSYM gestaltHasUniversalROM}
  gestaltHasEnhancedLtalk       = 30;    (* Do we have Enhanced LocalTalk? *)
  {$EXTERNALSYM gestaltHasEnhancedLtalk}



  gestaltHelpMgrAttr            : Integer = Ord('h') shl 24 + Ord('e') shl 16 + Ord('l') shl 8 + Ord('p'); (* 'help' - Help Mgr Attributes *)
  {$EXTERNALSYM gestaltHelpMgrAttr}
  gestaltHelpMgrPresent         = 0;    (* true if help mgr is present *)
  {$EXTERNALSYM gestaltHelpMgrPresent}
  gestaltHelpMgrExtensions      = 1;    (* true if help mgr extensions are installed *)
  {$EXTERNALSYM gestaltHelpMgrExtensions}
  gestaltAppleGuideIsDebug      = 30;
  {$EXTERNALSYM gestaltAppleGuideIsDebug}
  gestaltAppleGuidePresent      = 31;    (* true if AppleGuide is installed *)
  {$EXTERNALSYM gestaltAppleGuidePresent}



  gestaltHardwareVendorCode     : Integer = Ord('h') shl 24 + Ord('r') shl 16 + Ord('a') shl 8 + Ord('d'); (* 'hrad' - Returns hardware vendor information *)
  {$EXTERNALSYM gestaltHardwareVendorCode}
  gestaltHardwareVendorApple    : Integer = Ord('A') shl 24 + Ord('p') shl 16 + Ord('p') shl 8 + Ord('l'); (* 'Appl' - Hardware built by Apple *)
  {$EXTERNALSYM gestaltHardwareVendorApple}



  gestaltCompressionMgr         : Integer = Ord('i') shl 24 + Ord('c') shl 16 + Ord('m') shl 8 + Ord('p'); (* 'icmp' - returns version of the Image Compression Manager *)
  {$EXTERNALSYM gestaltCompressionMgr}



  gestaltIconUtilitiesAttr      : Integer = Ord('i') shl 24 + Ord('c') shl 16 + Ord('o') shl 8 + Ord('n'); (* 'icon' - Icon Utilities attributes  (Note: available in System 7.0; despite gestalt) *)
  {$EXTERNALSYM gestaltIconUtilitiesAttr}
  gestaltIconUtilitiesPresent   = 0;    (* true if icon utilities are present *)
  {$EXTERNALSYM gestaltIconUtilitiesPresent}
  gestaltIconUtilitiesHas48PixelIcons = 1; (* true if 48x48 icons are supported by IconUtilities *)
  {$EXTERNALSYM gestaltIconUtilitiesHas48PixelIcons}
  gestaltIconUtilitiesHas32BitIcons = 2; (* true if 32-bit deep icons are supported *)
  {$EXTERNALSYM gestaltIconUtilitiesHas32BitIcons}
  gestaltIconUtilitiesHas8BitDeepMasks = 3; (* true if 8-bit deep masks are supported *)
  {$EXTERNALSYM gestaltIconUtilitiesHas8BitDeepMasks}
  gestaltIconUtilitiesHasIconServices = 4; (* true if IconServices is present *)
  {$EXTERNALSYM gestaltIconUtilitiesHasIconServices}



  gestaltInternalDisplay        : Integer = Ord('i') shl 24 + Ord('d') shl 16 + Ord('s') shl 8 + Ord('p'); (* 'idsp' - slot number of internal display location *)
  {$EXTERNALSYM gestaltInternalDisplay}


(*
    To obtain information about the connected keyboard(s); one should
    use the ADB Manager API.  See Technical Note OV16 for details.
*)

  gestaltKeyboardType           : Integer = Ord('k') shl 24 + Ord('b') shl 16 + Ord('d') shl 8 + Ord(' '); (* 'kbd ' - keyboard type *)
  {$EXTERNALSYM gestaltKeyboardType}
  gestaltMacKbd                 = 1;
  {$EXTERNALSYM gestaltMacKbd}
  gestaltMacAndPad              = 2;
  {$EXTERNALSYM gestaltMacAndPad}
  gestaltMacPlusKbd             = 3;    (* OBSOLETE: This pre-ADB keyboard is not supported by any Mac OS X hardware and this value now means gestaltUnknownThirdPartyKbd *)
  {$EXTERNALSYM gestaltMacPlusKbd}
  gestaltUnknownThirdPartyKbd   = 3;    (* Unknown 3rd party keyboard. *)
  {$EXTERNALSYM gestaltUnknownThirdPartyKbd}
  gestaltExtADBKbd              = 4;
  {$EXTERNALSYM gestaltExtADBKbd}
  gestaltStdADBKbd              = 5;
  {$EXTERNALSYM gestaltStdADBKbd}
  gestaltPrtblADBKbd            = 6;
  {$EXTERNALSYM gestaltPrtblADBKbd}
  gestaltPrtblISOKbd            = 7;
  {$EXTERNALSYM gestaltPrtblISOKbd}
  gestaltStdISOADBKbd           = 8;
  {$EXTERNALSYM gestaltStdISOADBKbd}
  gestaltExtISOADBKbd           = 9;
  {$EXTERNALSYM gestaltExtISOADBKbd}
  gestaltADBKbdII               = 10;
  {$EXTERNALSYM gestaltADBKbdII}
  gestaltADBISOKbdII            = 11;
  {$EXTERNALSYM gestaltADBISOKbdII}
  gestaltPwrBookADBKbd          = 12;
  {$EXTERNALSYM gestaltPwrBookADBKbd}
  gestaltPwrBookISOADBKbd       = 13;
  {$EXTERNALSYM gestaltPwrBookISOADBKbd}
  gestaltAppleAdjustKeypad      = 14;
  {$EXTERNALSYM gestaltAppleAdjustKeypad}
  gestaltAppleAdjustADBKbd      = 15;
  {$EXTERNALSYM gestaltAppleAdjustADBKbd}
  gestaltAppleAdjustISOKbd      = 16;
  {$EXTERNALSYM gestaltAppleAdjustISOKbd}
  gestaltJapanAdjustADBKbd      = 17;   (* Japan Adjustable Keyboard *)
  {$EXTERNALSYM gestaltJapanAdjustADBKbd}
  gestaltPwrBkExtISOKbd         = 20;   (* PowerBook Extended International Keyboard with function keys *)
  {$EXTERNALSYM gestaltPwrBkExtISOKbd}
  gestaltPwrBkExtJISKbd         = 21;   (* PowerBook Extended Japanese Keyboard with function keys      *)
  {$EXTERNALSYM gestaltPwrBkExtJISKbd}
  gestaltPwrBkExtADBKbd         = 24;   (* PowerBook Extended Domestic Keyboard with function keys      *)
  {$EXTERNALSYM gestaltPwrBkExtADBKbd}
  gestaltPS2Keyboard            = 27;   (* PS2 keyboard *)
  {$EXTERNALSYM gestaltPS2Keyboard}
  gestaltPwrBkSubDomKbd         = 28;   (* PowerBook Subnote Domestic Keyboard with function keys w/  inverted T  *)
  {$EXTERNALSYM gestaltPwrBkSubDomKbd}
  gestaltPwrBkSubISOKbd         = 29;   (* PowerBook Subnote International Keyboard with function keys w/  inverted T     *)
  {$EXTERNALSYM gestaltPwrBkSubISOKbd}
  gestaltPwrBkSubJISKbd         = 30;   (* PowerBook Subnote Japanese Keyboard with function keys w/ inverted T    *)
  {$EXTERNALSYM gestaltPwrBkSubJISKbd}
  gestaltPortableUSBANSIKbd     = 37;   (* Powerbook USB-based internal keyboard; ANSI layout *)
  {$EXTERNALSYM gestaltPortableUSBANSIKbd}
  gestaltPortableUSBISOKbd      = 38;   (* Powerbook USB-based internal keyboard; ISO layout *)
  {$EXTERNALSYM gestaltPortableUSBISOKbd}
  gestaltPortableUSBJISKbd      = 39;   (* Powerbook USB-based internal keyboard; JIS layout *)
  {$EXTERNALSYM gestaltPortableUSBJISKbd}
  gestaltThirdPartyANSIKbd      = 40;   (* Third party keyboard; ANSI layout.  Returned in Mac OS X Tiger and later. *)
  {$EXTERNALSYM gestaltThirdPartyANSIKbd}
  gestaltThirdPartyISOKbd       = 41;   (* Third party keyboard; ISO layout. Returned in Mac OS X Tiger and later. *)
  {$EXTERNALSYM gestaltThirdPartyISOKbd}
  gestaltThirdPartyJISKbd       = 42;   (* Third party keyboard; JIS layout. Returned in Mac OS X Tiger and later. *)
  {$EXTERNALSYM gestaltThirdPartyJISKbd}
  gestaltPwrBkEKDomKbd          = 195;  (* ($C3) PowerBook Domestic Keyboard with Embedded Keypad; function keys & inverted T    *)
  {$EXTERNALSYM gestaltPwrBkEKDomKbd}
  gestaltPwrBkEKISOKbd          = 196;  (* ($C4) PowerBook International Keyboard with Embedded Keypad; function keys & inverted T   *)
  {$EXTERNALSYM gestaltPwrBkEKISOKbd}
  gestaltPwrBkEKJISKbd          = 197;  (* ($C5) PowerBook Japanese Keyboard with Embedded Keypad; function keys & inverted T      *)
  {$EXTERNALSYM gestaltPwrBkEKJISKbd}
  gestaltUSBCosmoANSIKbd        = 198;  (* ($C6) original USB Domestic (ANSI) Keyboard *)
  {$EXTERNALSYM gestaltUSBCosmoANSIKbd}
  gestaltUSBCosmoISOKbd         = 199;  (* ($C7) original USB International (ISO) Keyboard *)
  {$EXTERNALSYM gestaltUSBCosmoISOKbd}
  gestaltUSBCosmoJISKbd         = 200;  (* ($C8) original USB Japanese (JIS) Keyboard *)
  {$EXTERNALSYM gestaltUSBCosmoJISKbd}
  gestaltPwrBk99JISKbd          = 201;  (* ($C9) '99 PowerBook JIS Keyboard with Embedded Keypad; function keys & inverted T               *)
  {$EXTERNALSYM gestaltPwrBk99JISKbd}
  gestaltUSBAndyANSIKbd         = 204;  (* ($CC) USB Pro Keyboard Domestic (ANSI) Keyboard                                 *)
  {$EXTERNALSYM gestaltUSBAndyANSIKbd}
  gestaltUSBAndyISOKbd          = 205;  (* ($CD) USB Pro Keyboard International (ISO) Keyboard                               *)
  {$EXTERNALSYM gestaltUSBAndyISOKbd}
  gestaltUSBAndyJISKbd          = 206;   (* ($CE) USB Pro Keyboard Japanese (JIS) Keyboard                                    *)
  {$EXTERNALSYM gestaltUSBAndyJISKbd}




  gestaltPortable2001ANSIKbd    = 202;  (* ($CA) PowerBook and iBook Domestic (ANSI) Keyboard with 2nd cmd key right & function key moves.     *)
  {$EXTERNALSYM gestaltPortable2001ANSIKbd}
  gestaltPortable2001ISOKbd     = 203;  (* ($CB) PowerBook and iBook International (ISO) Keyboard with 2nd cmd key right & function key moves.   *)
  {$EXTERNALSYM gestaltPortable2001ISOKbd}
  gestaltPortable2001JISKbd     = 207;   (* ($CF) PowerBook and iBook Japanese (JIS) Keyboard with function key moves.                   *)
  {$EXTERNALSYM gestaltPortable2001JISKbd}



  gestaltUSBProF16ANSIKbd       = 34;   (* ($22) USB Pro Keyboard w/ F16 key Domestic (ANSI) Keyboard *)
  {$EXTERNALSYM gestaltUSBProF16ANSIKbd}
  gestaltUSBProF16ISOKbd        = 35;   (* ($23) USB Pro Keyboard w/ F16 key International (ISO) Keyboard *)
  {$EXTERNALSYM gestaltUSBProF16ISOKbd}
  gestaltUSBProF16JISKbd        = 36;   (* ($24) USB Pro Keyboard w/ F16 key Japanese (JIS) Keyboard *)
  {$EXTERNALSYM gestaltUSBProF16JISKbd}
  gestaltProF16ANSIKbd          = 31;   (* ($1F) Pro Keyboard w/F16 key Domestic (ANSI) Keyboard *)
  {$EXTERNALSYM gestaltProF16ANSIKbd}
  gestaltProF16ISOKbd           = 32;   (* ($20) Pro Keyboard w/F16 key International (ISO) Keyboard *)
  {$EXTERNALSYM gestaltProF16ISOKbd}
  gestaltProF16JISKbd           = 33;    (* ($21) Pro Keyboard w/F16 key Japanese (JIS) Keyboard *)
  {$EXTERNALSYM gestaltProF16JISKbd}


(*
    This gestalt indicates the highest UDF version that the active UDF implementation supports.
    The value should be assembled from a read version (upper word) and a write version (lower word)
*)

  gestaltUDFSupport             : Integer = Ord('k') shl 24 + Ord('u') shl 16 + Ord('d') shl 8 + Ord('f'); (* 'kudf' -    Used for communication between UDF implementations*)
  {$EXTERNALSYM gestaltUDFSupport}



  gestaltLowMemorySize          : Integer = Ord('l') shl 24 + Ord('m') shl 16 + Ord('e') shl 8 + Ord('m'); (* 'lmem' - size of low memory area *)
  {$EXTERNALSYM gestaltLowMemorySize}



  gestaltLogicalRAMSize         : Integer = Ord('l') shl 24 + Ord('r') shl 16 + Ord('a') shl 8 + Ord('m'); (* 'lram' - logical ram size *)
  {$EXTERNALSYM gestaltLogicalRAMSize}


(*
    MACHINE TYPE CONSTANTS NAMING CONVENTION

        All future machine type constant names take the following form:

            gestalt<lineName><modelNumber>

    Line Names

        The following table contains the lines currently produced by Apple and the
        lineName substrings associated with them:

            Line                        lineName
            -------------------------   ------------
            Macintosh LC                "MacLC"
            Macintosh Performa          "Performa"
            Macintosh PowerBook         "PowerBook"
            Macintosh PowerBook Duo     "PowerBookDuo"
            Power Macintosh             "PowerMac"
            Apple Workgroup Server      "AWS"

        The following table contains lineNames for some discontinued lines:

            Line                        lineName
            -------------------------   ------------
            Macintosh Quadra            "MacQuadra" (preferred)
                                        "Quadra" (also used; but not preferred)
            Macintosh Centris           "MacCentris"

    Model Numbers

        The modelNumber is a string representing the specific model of the machine
        within its particular line.  For example; for the Power Macintosh 8100/80;
        the modelNumber is "8100".

        Some Performa & LC model numbers contain variations in the rightmost 1 or 2
        digits to indicate different RAM and Hard Disk configurations.  A single
        machine type is assigned for all variations of a specific model number.  In
        this case; the modelNumber string consists of the constant leftmost part
        of the model number with 0s for the variant digits.  For example; the
        Performa 6115 and Performa 6116 are both return the same machine type
        constant:  gestaltPerforma6100.


    OLD NAMING CONVENTIONS

    The "Underscore Speed" suffix

        In the past; Apple differentiated between machines that had the same model
        number but different speeds.  For example; the Power Macintosh 8100/80 and
        Power Macintosh 8100/100 return different machine type constants.  This is
        why some existing machine type constant names take the form:

            gestalt<lineName><modelNumber>_<speed>

        e.g.

            gestaltPowerMac8100_110
            gestaltPowerMac7100_80
            gestaltPowerMac7100_66

        It is no longer necessary to use the "underscore speed" suffix.  Starting with
        the Power Surge machines (Power Macintosh 7200; 7500; 8500 and 9500); speed is
        no longer used to differentiate between machine types.  This is why a Power
        Macintosh 7200/75 and a Power Macintosh 7200/90 return the same machine type
        constant:  gestaltPowerMac7200.

    The "Screen Type" suffix

        All PowerBook models prior to the PowerBook 190; and all PowerBook Duo models
        before the PowerBook Duo 2300 take the form:

            gestalt<lineName><modelNumber><screenType>

        Where <screenType> is "c" or the empty string.

        e.g.

            gestaltPowerBook100
            gestaltPowerBookDuo280
            gestaltPowerBookDuo280c
            gestaltPowerBook180
            gestaltPowerBook180c

        Starting with the PowerBook 190 series and the PowerBook Duo 2300 series; machine
        types are no longer differentiated based on screen type.  This is why a PowerBook
        5300cs/100 and a PowerBook 5300c/100 both return the same machine type constant:
        gestaltPowerBook5300.

        Macintosh LC 630                gestaltMacLC630
        Macintosh Performa 6200         gestaltPerforma6200
        Macintosh Quadra 700            gestaltQuadra700
        Macintosh PowerBook 5300        gestaltPowerBook5300
        Macintosh PowerBook Duo 2300    gestaltPowerBookDuo2300
        Power Macintosh 8500            gestaltPowerMac8500
*)


  gestaltMachineType            : Integer = Ord('m') shl 24 + Ord('a') shl 16 + Ord('c') shl 8 + Ord('h'); (* 'mach' - machine type *)
  {$EXTERNALSYM gestaltMachineType}
  gestaltClassic                = 1;
  {$EXTERNALSYM gestaltClassic}
  gestaltMacXL                  = 2;
  {$EXTERNALSYM gestaltMacXL}
  gestaltMac512KE               = 3;
  {$EXTERNALSYM gestaltMac512KE}
  gestaltMacPlus                = 4;
  {$EXTERNALSYM gestaltMacPlus}
  gestaltMacSE                  = 5;
  {$EXTERNALSYM gestaltMacSE}
  gestaltMacII                  = 6;
  {$EXTERNALSYM gestaltMacII}
  gestaltMacIIx                 = 7;
  {$EXTERNALSYM gestaltMacIIx}
  gestaltMacIIcx                = 8;
  {$EXTERNALSYM gestaltMacIIcx}
  gestaltMacSE030               = 9;
  {$EXTERNALSYM gestaltMacSE030}
  gestaltPortable               = 10;
  {$EXTERNALSYM gestaltPortable}
  gestaltMacIIci                = 11;
  {$EXTERNALSYM gestaltMacIIci}
  gestaltPowerMac8100_120       = 12;
  {$EXTERNALSYM gestaltPowerMac8100_120}
  gestaltMacIIfx                = 13;
  {$EXTERNALSYM gestaltMacIIfx}
  gestaltMacClassic             = 17;
  {$EXTERNALSYM gestaltMacClassic}
  gestaltMacIIsi                = 18;
  {$EXTERNALSYM gestaltMacIIsi}
  gestaltMacLC                  = 19;
  {$EXTERNALSYM gestaltMacLC}
  gestaltMacQuadra900           = 20;
  {$EXTERNALSYM gestaltMacQuadra900}
  gestaltPowerBook170           = 21;
  {$EXTERNALSYM gestaltPowerBook170}
  gestaltMacQuadra700           = 22;
  {$EXTERNALSYM gestaltMacQuadra700}
  gestaltClassicII              = 23;
  {$EXTERNALSYM gestaltClassicII}
  gestaltPowerBook100           = 24;
  {$EXTERNALSYM gestaltPowerBook100}
  gestaltPowerBook140           = 25;
  {$EXTERNALSYM gestaltPowerBook140}
  gestaltMacQuadra950           = 26;
  {$EXTERNALSYM gestaltMacQuadra950}
  gestaltMacLCIII               = 27;
  {$EXTERNALSYM gestaltMacLCIII}
  gestaltPerforma450            = gestaltMacLCIII;
  {$EXTERNALSYM gestaltPerforma450}
  gestaltPowerBookDuo210        = 29;
  {$EXTERNALSYM gestaltPowerBookDuo210}
  gestaltMacCentris650          = 30;
  {$EXTERNALSYM gestaltMacCentris650}
  gestaltPowerBookDuo230        = 32;
  {$EXTERNALSYM gestaltPowerBookDuo230}
  gestaltPowerBook180           = 33;
  {$EXTERNALSYM gestaltPowerBook180}
  gestaltPowerBook160           = 34;
  {$EXTERNALSYM gestaltPowerBook160}
  gestaltMacQuadra800           = 35;
  {$EXTERNALSYM gestaltMacQuadra800}
  gestaltMacQuadra650           = 36;
  {$EXTERNALSYM gestaltMacQuadra650}
  gestaltMacLCII                = 37;
  {$EXTERNALSYM gestaltMacLCII}
  gestaltPowerBookDuo250        = 38;
  {$EXTERNALSYM gestaltPowerBookDuo250}
  gestaltAWS9150_80             = 39;
  {$EXTERNALSYM gestaltAWS9150_80}
  gestaltPowerMac8100_110       = 40;
  {$EXTERNALSYM gestaltPowerMac8100_110}
  gestaltAWS8150_110            = gestaltPowerMac8100_110;
  {$EXTERNALSYM gestaltAWS8150_110}
  gestaltPowerMac5200           = 41;
  {$EXTERNALSYM gestaltPowerMac5200}
  gestaltPowerMac5260           = gestaltPowerMac5200;
  {$EXTERNALSYM gestaltPowerMac5260}
  gestaltPerforma5300           = gestaltPowerMac5200;
  {$EXTERNALSYM gestaltPerforma5300}
  gestaltPowerMac6200           = 42;
  {$EXTERNALSYM gestaltPowerMac6200}
  gestaltPerforma6300           = gestaltPowerMac6200;
  {$EXTERNALSYM gestaltPerforma6300}
  gestaltMacIIvi                = 44;
  {$EXTERNALSYM gestaltMacIIvi}
  gestaltMacIIvm                = 45;
  {$EXTERNALSYM gestaltMacIIvm}
  gestaltPerforma600            = gestaltMacIIvm;
  {$EXTERNALSYM gestaltPerforma600}
  gestaltPowerMac7100_80        = 47;
  {$EXTERNALSYM gestaltPowerMac7100_80}
  gestaltMacIIvx                = 48;
  {$EXTERNALSYM gestaltMacIIvx}
  gestaltMacColorClassic        = 49;
  {$EXTERNALSYM gestaltMacColorClassic}
  gestaltPerforma250            = gestaltMacColorClassic;
  {$EXTERNALSYM gestaltPerforma250}
  gestaltPowerBook165c          = 50;
  {$EXTERNALSYM gestaltPowerBook165c}
  gestaltMacCentris610          = 52;
  {$EXTERNALSYM gestaltMacCentris610}
  gestaltMacQuadra610           = 53;
  {$EXTERNALSYM gestaltMacQuadra610}
  gestaltPowerBook145           = 54;
  {$EXTERNALSYM gestaltPowerBook145}
  gestaltPowerMac8100_100       = 55;
  {$EXTERNALSYM gestaltPowerMac8100_100}
  gestaltMacLC520               = 56;
  {$EXTERNALSYM gestaltMacLC520}
  gestaltAWS9150_120            = 57;
  {$EXTERNALSYM gestaltAWS9150_120}
  gestaltPowerMac6400           = 58;
  {$EXTERNALSYM gestaltPowerMac6400}
  gestaltPerforma6400           = gestaltPowerMac6400;
  {$EXTERNALSYM gestaltPerforma6400}
  gestaltPerforma6360           = gestaltPerforma6400;
  {$EXTERNALSYM gestaltPerforma6360}
  gestaltMacCentris660AV        = 60;
  {$EXTERNALSYM gestaltMacCentris660AV}
  gestaltMacQuadra660AV         = gestaltMacCentris660AV;
  {$EXTERNALSYM gestaltMacQuadra660AV}
  gestaltPerforma46x            = 62;
  {$EXTERNALSYM gestaltPerforma46x}
  gestaltPowerMac8100_80        = 65;
  {$EXTERNALSYM gestaltPowerMac8100_80}
  gestaltAWS8150_80             = gestaltPowerMac8100_80;
  {$EXTERNALSYM gestaltAWS8150_80}
  gestaltPowerMac9500           = 67;
  {$EXTERNALSYM gestaltPowerMac9500}
  gestaltPowerMac9600           = gestaltPowerMac9500;
  {$EXTERNALSYM gestaltPowerMac9600}
  gestaltPowerMac7500           = 68;
  {$EXTERNALSYM gestaltPowerMac7500}
  gestaltPowerMac7600           = gestaltPowerMac7500;
  {$EXTERNALSYM gestaltPowerMac7600}
  gestaltPowerMac8500           = 69;
  {$EXTERNALSYM gestaltPowerMac8500}
  gestaltPowerMac8600           = gestaltPowerMac8500;
  {$EXTERNALSYM gestaltPowerMac8600}
  gestaltAWS8550                = gestaltPowerMac7500;
  {$EXTERNALSYM gestaltAWS8550}
  gestaltPowerBook180c          = 71;
  {$EXTERNALSYM gestaltPowerBook180c}
  gestaltPowerBook520           = 72;
  {$EXTERNALSYM gestaltPowerBook520}
  gestaltPowerBook520c          = gestaltPowerBook520;
  {$EXTERNALSYM gestaltPowerBook520c}
  gestaltPowerBook540           = gestaltPowerBook520;
  {$EXTERNALSYM gestaltPowerBook540}
  gestaltPowerBook540c          = gestaltPowerBook520;
  {$EXTERNALSYM gestaltPowerBook540c}
  gestaltPowerMac5400           = 74;
  {$EXTERNALSYM gestaltPowerMac5400}
  gestaltPowerMac6100_60        = 75;
  {$EXTERNALSYM gestaltPowerMac6100_60}
  gestaltAWS6150_60             = gestaltPowerMac6100_60;
  {$EXTERNALSYM gestaltAWS6150_60}
  gestaltPowerBookDuo270c       = 77;
  {$EXTERNALSYM gestaltPowerBookDuo270c}
  gestaltMacQuadra840AV         = 78;
  {$EXTERNALSYM gestaltMacQuadra840AV}
  gestaltPerforma550            = 80;
  {$EXTERNALSYM gestaltPerforma550}
  gestaltPowerBook165           = 84;
  {$EXTERNALSYM gestaltPowerBook165}
  gestaltPowerBook190           = 85;
  {$EXTERNALSYM gestaltPowerBook190}
  gestaltMacTV                  = 88;
  {$EXTERNALSYM gestaltMacTV}
  gestaltMacLC475               = 89;
  {$EXTERNALSYM gestaltMacLC475}
  gestaltPerforma47x            = gestaltMacLC475;
  {$EXTERNALSYM gestaltPerforma47x}
  gestaltMacLC575               = 92;
  {$EXTERNALSYM gestaltMacLC575}
  gestaltMacQuadra605           = 94;
  {$EXTERNALSYM gestaltMacQuadra605}
  gestaltMacQuadra630           = 98;
  {$EXTERNALSYM gestaltMacQuadra630}
  gestaltMacLC580               = 99;
  {$EXTERNALSYM gestaltMacLC580}
  gestaltPerforma580            = gestaltMacLC580;
  {$EXTERNALSYM gestaltPerforma580}
  gestaltPowerMac6100_66        = 100;
  {$EXTERNALSYM gestaltPowerMac6100_66}
  gestaltAWS6150_66             = gestaltPowerMac6100_66;
  {$EXTERNALSYM gestaltAWS6150_66}
  gestaltPowerBookDuo280        = 102;
  {$EXTERNALSYM gestaltPowerBookDuo280}
  gestaltPowerBookDuo280c       = 103;
  {$EXTERNALSYM gestaltPowerBookDuo280c}
  gestaltPowerMacLC475          = 104;  (* Mac LC 475 & PPC Processor Upgrade Card*)
  {$EXTERNALSYM gestaltPowerMacLC475}
  gestaltPowerMacPerforma47x    = gestaltPowerMacLC475;
  {$EXTERNALSYM gestaltPowerMacPerforma47x}
  gestaltPowerMacLC575          = 105;  (* Mac LC 575 & PPC Processor Upgrade Card *)
  {$EXTERNALSYM gestaltPowerMacLC575}
  gestaltPowerMacPerforma57x    = gestaltPowerMacLC575;
  {$EXTERNALSYM gestaltPowerMacPerforma57x}
  gestaltPowerMacQuadra630      = 106;  (* Quadra 630 & PPC Processor Upgrade Card*)
  {$EXTERNALSYM gestaltPowerMacQuadra630}
  gestaltPowerMacLC630          = gestaltPowerMacQuadra630; (* Mac LC 630 & PPC Processor Upgrade Card*)
  {$EXTERNALSYM gestaltPowerMacLC630}
  gestaltPowerMacPerforma63x    = gestaltPowerMacQuadra630; (* Performa 63x & PPC Processor Upgrade Card*)
  {$EXTERNALSYM gestaltPowerMacPerforma63x}
  gestaltPowerMac7200           = 108;
  {$EXTERNALSYM gestaltPowerMac7200}
  gestaltPowerMac7300           = 109;
  {$EXTERNALSYM gestaltPowerMac7300}
  gestaltPowerMac7100_66        = 112;
  {$EXTERNALSYM gestaltPowerMac7100_66}
  gestaltPowerBook150           = 115;
  {$EXTERNALSYM gestaltPowerBook150}
  gestaltPowerMacQuadra700      = 116;  (* Quadra 700 & Power PC Upgrade Card*)
  {$EXTERNALSYM gestaltPowerMacQuadra700}
  gestaltPowerMacQuadra900      = 117;  (* Quadra 900 & Power PC Upgrade Card *)
  {$EXTERNALSYM gestaltPowerMacQuadra900}
  gestaltPowerMacQuadra950      = 118;  (* Quadra 950 & Power PC Upgrade Card *)
  {$EXTERNALSYM gestaltPowerMacQuadra950}
  gestaltPowerMacCentris610     = 119;  (* Centris 610 & Power PC Upgrade Card *)
  {$EXTERNALSYM gestaltPowerMacCentris610}
  gestaltPowerMacCentris650     = 120;  (* Centris 650 & Power PC Upgrade Card *)
  {$EXTERNALSYM gestaltPowerMacCentris650}
  gestaltPowerMacQuadra610      = 121;  (* Quadra 610 & Power PC Upgrade Card *)
  {$EXTERNALSYM gestaltPowerMacQuadra610}
  gestaltPowerMacQuadra650      = 122;  (* Quadra 650 & Power PC Upgrade Card *)
  {$EXTERNALSYM gestaltPowerMacQuadra650}
  gestaltPowerMacQuadra800      = 123;  (* Quadra 800 & Power PC Upgrade Card *)
  {$EXTERNALSYM gestaltPowerMacQuadra800}
  gestaltPowerBookDuo2300       = 124;
  {$EXTERNALSYM gestaltPowerBookDuo2300}
  gestaltPowerBook500PPCUpgrade = 126;
  {$EXTERNALSYM gestaltPowerBook500PPCUpgrade}
  gestaltPowerBook5300          = 128;
  {$EXTERNALSYM gestaltPowerBook5300}
  gestaltPowerBook1400          = 310;
  {$EXTERNALSYM gestaltPowerBook1400}
  gestaltPowerBook3400          = 306;
  {$EXTERNALSYM gestaltPowerBook3400}
  gestaltPowerBook2400          = 307;
  {$EXTERNALSYM gestaltPowerBook2400}
  gestaltPowerBookG3Series      = 312;
  {$EXTERNALSYM gestaltPowerBookG3Series}
  gestaltPowerBookG3            = 313;
  {$EXTERNALSYM gestaltPowerBookG3}
  gestaltPowerBookG3Series2     = 314;
  {$EXTERNALSYM gestaltPowerBookG3Series2}
  gestaltPowerMacNewWorld       = 406;  (* All NewWorld architecture Macs (iMac; blue G3; etc.)*)
  {$EXTERNALSYM gestaltPowerMacNewWorld}
  gestaltPowerMacG3             = 510;
  {$EXTERNALSYM gestaltPowerMacG3}
  gestaltPowerMac5500           = 512;
  {$EXTERNALSYM gestaltPowerMac5500}
  gestalt20thAnniversary        = gestaltPowerMac5500;
  {$EXTERNALSYM gestalt20thAnniversary}
  gestaltPowerMac6500           = 513;
  {$EXTERNALSYM gestaltPowerMac6500}
  gestaltPowerMac4400_160       = 514;  (* slower machine has different machine ID*)
  {$EXTERNALSYM gestaltPowerMac4400_160}
  gestaltPowerMac4400           = 515;
  {$EXTERNALSYM gestaltPowerMac4400}
  gestaltMacOSCompatibility     = 1206;  (*    Mac OS Compatibility on Mac OS X (Classic)*)
  {$EXTERNALSYM gestaltMacOSCompatibility}




  gestaltQuadra605              = gestaltMacQuadra605;
  {$EXTERNALSYM gestaltQuadra605}
  gestaltQuadra610              = gestaltMacQuadra610;
  {$EXTERNALSYM gestaltQuadra610}
  gestaltQuadra630              = gestaltMacQuadra630;
  {$EXTERNALSYM gestaltQuadra630}
  gestaltQuadra650              = gestaltMacQuadra650;
  {$EXTERNALSYM gestaltQuadra650}
  gestaltQuadra660AV            = gestaltMacQuadra660AV;
  {$EXTERNALSYM gestaltQuadra660AV}
  gestaltQuadra700              = gestaltMacQuadra700;
  {$EXTERNALSYM gestaltQuadra700}
  gestaltQuadra800              = gestaltMacQuadra800;
  {$EXTERNALSYM gestaltQuadra800}
  gestaltQuadra840AV            = gestaltMacQuadra840AV;
  {$EXTERNALSYM gestaltQuadra840AV}
  gestaltQuadra900              = gestaltMacQuadra900;
  {$EXTERNALSYM gestaltQuadra900}
  gestaltQuadra950              = gestaltMacQuadra950;
  {$EXTERNALSYM gestaltQuadra950}



  kMachineNameStrID             = -16395;
  {$EXTERNALSYM kMachineNameStrID}



  gestaltSMPMailerVersion       : Integer = Ord('m') shl 24 + Ord('a') shl 16 + Ord('l') shl 8 + Ord('r'); (* 'malr' - OCE StandardMail*)
  {$EXTERNALSYM gestaltSMPMailerVersion}



  gestaltMediaBay               : Integer = Ord('m') shl 24 + Ord('b') shl 16 + Ord('e') shl 8 + Ord('h'); (* 'mbeh' - media bay driver type *)
  {$EXTERNALSYM gestaltMediaBay}
  gestaltMBLegacy               = 0;    (* media bay support in PCCard 2.0 *)
  {$EXTERNALSYM gestaltMBLegacy}
  gestaltMBSingleBay            = 1;    (* single bay media bay driver *)
  {$EXTERNALSYM gestaltMBSingleBay}
  gestaltMBMultipleBays         = 2;     (* multi-bay media bay driver *)
  {$EXTERNALSYM gestaltMBMultipleBays}



  gestaltMessageMgrVersion      : Integer = Ord('m') shl 24 + Ord('e') shl 16 + Ord('s') shl 8 + Ord('s'); (* 'mess' - GX Printing Message Manager Gestalt Selector *)
  {$EXTERNALSYM gestaltMessageMgrVersion}



(*  Menu Manager Gestalt (Mac OS 8.5 and later)*)

  gestaltMenuMgrAttr            : Integer = Ord('m') shl 24 + Ord('e') shl 16 + Ord('n') shl 8 + Ord('u'); (* 'menu' - If this Gestalt exists; the Mac OS 8.5 Menu Manager is installed *)
  {$EXTERNALSYM gestaltMenuMgrAttr}
  gestaltMenuMgrPresent         = (1 shl 0); (* NOTE: this is a bit mask; whereas all other Gestalt constants of this nature *)
  {$EXTERNALSYM gestaltMenuMgrPresent}
                                        (* are bit index values. 3.2 interfaces slipped out with this mistake unnoticed. *)
                                        (* Sincere apologies for any inconvenience.*)
  gestaltMenuMgrPresentBit      = 0;    (* bit number *)
  {$EXTERNALSYM gestaltMenuMgrPresentBit}
  gestaltMenuMgrAquaLayoutBit   = 1;    (* menus have the Aqua 1.0 layout*)
  {$EXTERNALSYM gestaltMenuMgrAquaLayoutBit}
  gestaltMenuMgrMultipleItemsWithCommandIDBit = 2; (* CountMenuItemsWithCommandID/GetIndMenuItemWithCommandID support multiple items with the same command ID*)
  {$EXTERNALSYM gestaltMenuMgrMultipleItemsWithCommandIDBit}
  gestaltMenuMgrRetainsIconRefBit = 3;  (* SetMenuItemIconHandle; when passed an IconRef; calls AcquireIconRef*)
  {$EXTERNALSYM gestaltMenuMgrRetainsIconRefBit}
  gestaltMenuMgrSendsMenuBoundsToDefProcBit = 4; (* kMenuSizeMsg and kMenuPopUpMsg have menu bounding rect information*)
  {$EXTERNALSYM gestaltMenuMgrSendsMenuBoundsToDefProcBit}
  gestaltMenuMgrMoreThanFiveMenusDeepBit = 5; (* the Menu Manager supports hierarchical menus more than five deep*)
  {$EXTERNALSYM gestaltMenuMgrMoreThanFiveMenusDeepBit}
  gestaltMenuMgrCGImageMenuTitleBit = 6; (* SetMenuTitleIcon supports CGImageRefs*)
  {$EXTERNALSYM gestaltMenuMgrCGImageMenuTitleBit}
                                        (* masks for the above bits*)
  gestaltMenuMgrPresentMask     = (1 shl gestaltMenuMgrPresentBit);
  {$EXTERNALSYM gestaltMenuMgrPresentMask}
  gestaltMenuMgrAquaLayoutMask  = (1 shl gestaltMenuMgrAquaLayoutBit);
  {$EXTERNALSYM gestaltMenuMgrAquaLayoutMask}
  gestaltMenuMgrMultipleItemsWithCommandIDMask = (1 shl gestaltMenuMgrMultipleItemsWithCommandIDBit);
  {$EXTERNALSYM gestaltMenuMgrMultipleItemsWithCommandIDMask}
  gestaltMenuMgrRetainsIconRefMask = (1 shl gestaltMenuMgrRetainsIconRefBit);
  {$EXTERNALSYM gestaltMenuMgrRetainsIconRefMask}
  gestaltMenuMgrSendsMenuBoundsToDefProcMask = (1 shl gestaltMenuMgrSendsMenuBoundsToDefProcBit);
  {$EXTERNALSYM gestaltMenuMgrSendsMenuBoundsToDefProcMask}
  gestaltMenuMgrMoreThanFiveMenusDeepMask = (1 shl gestaltMenuMgrMoreThanFiveMenusDeepBit);
  {$EXTERNALSYM gestaltMenuMgrMoreThanFiveMenusDeepMask}
  gestaltMenuMgrCGImageMenuTitleMask = (1 shl gestaltMenuMgrCGImageMenuTitleBit);
  {$EXTERNALSYM gestaltMenuMgrCGImageMenuTitleMask}




  gestaltMultipleUsersState     : Integer = Ord('m') shl 24 + Ord('f') shl 16 + Ord('d') shl 8 + Ord('r'); (* 'mfdr' - Gestalt selector returns MultiUserGestaltHandle (in Folders.h)*)
  {$EXTERNALSYM gestaltMultipleUsersState}




  gestaltMachineIcon            : Integer = Ord('m') shl 24 + Ord('i') shl 16 + Ord('c') shl 8 + Ord('n'); (* 'micn' - machine icon *)
  {$EXTERNALSYM gestaltMachineIcon}



  gestaltMiscAttr               : Integer = Ord('m') shl 24 + Ord('i') shl 16 + Ord('s') shl 8 + Ord('c'); (* 'misc' - miscellaneous attributes *)
  {$EXTERNALSYM gestaltMiscAttr}
  gestaltScrollingThrottle      = 0;    (* true if scrolling throttle on *)
  {$EXTERNALSYM gestaltScrollingThrottle}
  gestaltSquareMenuBar          = 2;     (* true if menu bar is square *)
  {$EXTERNALSYM gestaltSquareMenuBar}



(*
    The name gestaltMixedModeVersion for the 'mixd'; selector is semantically incorrect.
    The same selector has been renamed gestaltMixedModeAttr to properly reflect the
    Inside Mac: PowerPC System Software documentation.  The gestaltMixedModeVersion
    symbol has been preserved only for backwards compatibility.

    Developers are forewarned that gestaltMixedModeVersion has a limited lifespan and
    will be removed in a future release of the Interfaces.

    For the first version of Mixed Mode; both meanings of the 'mixd'; selector are
    functionally identical.  They both return $00000001.  In subsequent versions
    of Mixed Mode; however; the 'mixd'; selector will not respond with an increasing
    version number; but rather; with 32 attribute bits with various meanings.
*)

  gestaltMixedModeVersion       : Integer = Ord('m') shl 24 + Ord('i') shl 16 + Ord('x') shl 8 + Ord('d'); (* 'mixd' - returns version of Mixed Mode *)
  {$EXTERNALSYM gestaltMixedModeVersion}



  gestaltMixedModeAttr          : Integer = Ord('m') shl 24 + Ord('i') shl 16 + Ord('x') shl 8 + Ord('d'); (* 'mixd' - returns Mixed Mode attributes *)
  {$EXTERNALSYM gestaltMixedModeAttr}
  gestaltMixedModePowerPC       = 0;    (* true if Mixed Mode supports PowerPC ABI calling conventions *)
  {$EXTERNALSYM gestaltMixedModePowerPC}
  gestaltPowerPCAware           = 0;    (* old name for gestaltMixedModePowerPC *)
  {$EXTERNALSYM gestaltPowerPCAware}
  gestaltMixedModeCFM68K        = 1;    (* true if Mixed Mode supports CFM-68K calling conventions *)
  {$EXTERNALSYM gestaltMixedModeCFM68K}
  gestaltMixedModeCFM68KHasTrap = 2;    (* true if CFM-68K Mixed Mode implements _MixedModeDispatch (versions 1.0.1 and prior did not) *)
  {$EXTERNALSYM gestaltMixedModeCFM68KHasTrap}
  gestaltMixedModeCFM68KHasState = 3;    (* true if CFM-68K Mixed Mode exports Save/RestoreMixedModeState *)
  {$EXTERNALSYM gestaltMixedModeCFM68KHasState}



  gestaltQuickTimeConferencing  : Integer = Ord('m') shl 24 + Ord('t') shl 16 + Ord('l') shl 8 + Ord('k'); (* 'mtlk' - returns QuickTime Conferencing version *)
  {$EXTERNALSYM gestaltQuickTimeConferencing}



  gestaltMemoryMapAttr          : Integer = Ord('m') shl 24 + Ord('m') shl 16 + Ord('a') shl 8 + Ord('p'); (* 'mmap' - Memory map type *)
  {$EXTERNALSYM gestaltMemoryMapAttr}
  gestaltMemoryMapSparse        = 0;     (* Sparse memory is on *)
  {$EXTERNALSYM gestaltMemoryMapSparse}



  gestaltMMUType                : Integer = Ord('m') shl 24 + Ord('m') shl 16 + Ord('u') shl 8 + Ord(' '); (* 'mmu ' - mmu type *)
  {$EXTERNALSYM gestaltMMUType}
  gestaltNoMMU                  = 0;    (* no MMU *)
  {$EXTERNALSYM gestaltNoMMU}
  gestaltAMU                    = 1;    (* address management unit *)
  {$EXTERNALSYM gestaltAMU}
  gestalt68851                  = 2;    (* 68851 PMMU *)
  {$EXTERNALSYM gestalt68851}
  gestalt68030MMU               = 3;    (* 68030 built-in MMU *)
  {$EXTERNALSYM gestalt68030MMU}
  gestalt68040MMU               = 4;    (* 68040 built-in MMU *)
  {$EXTERNALSYM gestalt68040MMU}
  gestaltEMMU1                  = 5;     (* Emulated MMU type 1  *)
  {$EXTERNALSYM gestaltEMMU1}



                                        (*    On Mac OS X; the user visible machine name may something like "PowerMac3;4"; which is*)
                                        (*    a unique string for each signifigant Macintosh computer which Apple creates; but is*)
                                        (*    not terribly useful as a user visible string.*)
  gestaltUserVisibleMachineName : Integer = Ord('m') shl 24 + Ord('n') shl 16 + Ord('a') shl 8 + Ord('m'); (* 'mnam' - Coerce response into a StringPtr to get a user visible machine name *)
  {$EXTERNALSYM gestaltUserVisibleMachineName}



  gestaltMPCallableAPIsAttr     : Integer = Ord('m') shl 24 + Ord('p') shl 16 + Ord('s') shl 8 + Ord('c'); (* 'mpsc' - Bitmap of toolbox/OS managers that can be called from MPLibrary MPTasks *)
  {$EXTERNALSYM gestaltMPCallableAPIsAttr}
  gestaltMPFileManager          = 0;    (* True if File Manager calls can be made from MPTasks *)
  {$EXTERNALSYM gestaltMPFileManager}
  gestaltMPDeviceManager        = 1;    (* True if synchronous Device Manager calls can be made from MPTasks *)
  {$EXTERNALSYM gestaltMPDeviceManager}
  gestaltMPTrapCalls            = 2;     (* True if most trap-based calls can be made from MPTasks *)
  {$EXTERNALSYM gestaltMPTrapCalls}



  gestaltStdNBPAttr             : Integer = Ord('n') shl 24 + Ord('l') shl 16 + Ord('u') shl 8 + Ord('p'); (* 'nlup' - standard nbp attributes *)
  {$EXTERNALSYM gestaltStdNBPAttr}
  gestaltStdNBPPresent          = 0;
  {$EXTERNALSYM gestaltStdNBPPresent}
  gestaltStdNBPSupportsAutoPosition = 1; (* StandardNBP takes (-1;-1) to mean alert position main screen *)
  {$EXTERNALSYM gestaltStdNBPSupportsAutoPosition}



  gestaltNotificationMgrAttr    : Integer = Ord('n') shl 24 + Ord('m') shl 16 + Ord('g') shl 8 + Ord('r'); (* 'nmgr' - notification manager attributes *)
  {$EXTERNALSYM gestaltNotificationMgrAttr}
  gestaltNotificationPresent    = 0;     (* notification manager exists *)
  {$EXTERNALSYM gestaltNotificationPresent}



  gestaltNameRegistryVersion    : Integer = Ord('n') shl 24 + Ord('r') shl 16 + Ord('e') shl 8 + Ord('g'); (* 'nreg' - NameRegistryLib version number; for System 7.5.2+ usage *)
  {$EXTERNALSYM gestaltNameRegistryVersion}



  gestaltNuBusSlotCount         : Integer = Ord('n') shl 24 + Ord('u') shl 16 + Ord('b') shl 8 + Ord('s'); (* 'nubs' - count of logical NuBus slots present *)
  {$EXTERNALSYM gestaltNuBusSlotCount}



  gestaltOCEToolboxVersion      : Integer = Ord('o') shl 24 + Ord('c') shl 16 + Ord('e') shl 8 + Ord('t'); (* 'ocet' - OCE Toolbox version *)
  {$EXTERNALSYM gestaltOCEToolboxVersion}
  gestaltOCETB                  = $0102; (* OCE Toolbox version 1.02 *)
  {$EXTERNALSYM gestaltOCETB}
  gestaltSFServer               = $0100; (* S&F Server version 1.0 *)
  {$EXTERNALSYM gestaltSFServer}



  gestaltOCEToolboxAttr         : Integer = Ord('o') shl 24 + Ord('c') shl 16 + Ord('e') shl 8 + Ord('u'); (* 'oceu' - OCE Toolbox attributes *)
  {$EXTERNALSYM gestaltOCEToolboxAttr}
  gestaltOCETBPresent           = $01; (* OCE toolbox is present; not running *)
  {$EXTERNALSYM gestaltOCETBPresent}
  gestaltOCETBAvailable         = $02; (* OCE toolbox is running and available *)
  {$EXTERNALSYM gestaltOCETBAvailable}
  gestaltOCESFServerAvailable   = $04; (* S&F Server is running and available *)
  {$EXTERNALSYM gestaltOCESFServerAvailable}
  gestaltOCETBNativeGlueAvailable = $10; (* Native PowerPC Glue routines are availible *)
  {$EXTERNALSYM gestaltOCETBNativeGlueAvailable}



  gestaltOpenFirmwareInfo       : Integer = Ord('o') shl 24 + Ord('p') shl 16 + Ord('f') shl 8 + Ord('w'); (* 'opfw' - Open Firmware info *)
  {$EXTERNALSYM gestaltOpenFirmwareInfo}



  gestaltOSAttr                 = 'os  '; (* o/s attributes *)
  {$EXTERNALSYM gestaltOSAttr}
  gestaltSysZoneGrowable        = 0;    (* system heap is growable *)
  {$EXTERNALSYM gestaltSysZoneGrowable}
  gestaltLaunchCanReturn        = 1;    (* can return from launch *)
  {$EXTERNALSYM gestaltLaunchCanReturn}
  gestaltLaunchFullFileSpec     = 2;    (* can launch from full file spec *)
  {$EXTERNALSYM gestaltLaunchFullFileSpec}
  gestaltLaunchControl          = 3;    (* launch control support available *)
  {$EXTERNALSYM gestaltLaunchControl}
  gestaltTempMemSupport         = 4;    (* temp memory support *)
  {$EXTERNALSYM gestaltTempMemSupport}
  gestaltRealTempMemory         = 5;    (* temp memory handles are real *)
  {$EXTERNALSYM gestaltRealTempMemory}
  gestaltTempMemTracked         = 6;    (* temporary memory handles are tracked *)
  {$EXTERNALSYM gestaltTempMemTracked}
  gestaltIPCSupport             = 7;    (* IPC support is present *)
  {$EXTERNALSYM gestaltIPCSupport}
  gestaltSysDebuggerSupport     = 8;    (* system debugger support is present *)
  {$EXTERNALSYM gestaltSysDebuggerSupport}
  gestaltNativeProcessMgrBit    = 19;   (* the process manager itself is native *)
  {$EXTERNALSYM gestaltNativeProcessMgrBit}
  gestaltAltivecRegistersSwappedCorrectlyBit = 20; (* Altivec registers are saved correctly on process switches *)
  {$EXTERNALSYM gestaltAltivecRegistersSwappedCorrectlyBit}



  gestaltOSTable                : Integer = Ord('o') shl 24 + Ord('s') shl 16 + Ord('t') shl 8 + Ord('t'); (* 'ostt' -  OS trap table base  *)
  {$EXTERNALSYM gestaltOSTable}



(*******************************************************************************
*   Gestalt Selectors for Open Transport Network Setup
*
*   Note: possible values for the version "stage" byte are:
*   development = $20; alpha = $40; beta = $60; final & release = $80
********************************************************************************)

  gestaltOpenTptNetworkSetup    : Integer = Ord('o') shl 24 + Ord('t') shl 16 + Ord('c') shl 8 + Ord('f');  (*  'otcf' *)
  {$EXTERNALSYM gestaltOpenTptNetworkSetup}
  gestaltOpenTptNetworkSetupLegacyImport = 0;
  {$EXTERNALSYM gestaltOpenTptNetworkSetupLegacyImport}
  gestaltOpenTptNetworkSetupLegacyExport = 1;
  {$EXTERNALSYM gestaltOpenTptNetworkSetupLegacyExport}
  gestaltOpenTptNetworkSetupSupportsMultihoming = 2;
  {$EXTERNALSYM gestaltOpenTptNetworkSetupSupportsMultihoming}



  gestaltOpenTptNetworkSetupVersion : Integer = Ord('o') shl 24 + Ord('t') shl 16 + Ord('c') shl 8 + Ord('v');  (*  'otcv' *)
  {$EXTERNALSYM gestaltOpenTptNetworkSetupVersion}


(*******************************************************************************
*   Gestalt Selectors for Open Transport-based Remote Access/PPP
*
*   Note: possible values for the version "stage" byte are:
*   development = $20; alpha = $40; beta = $60; final & release = $80
********************************************************************************)

  gestaltOpenTptRemoteAccess    : Integer = Ord('o') shl 24 + Ord('t') shl 16 + Ord('r') shl 8 + Ord('a');  (*  'otra' *)
  {$EXTERNALSYM gestaltOpenTptRemoteAccess}
  gestaltOpenTptRemoteAccessPresent = 0;
  {$EXTERNALSYM gestaltOpenTptRemoteAccessPresent}
  gestaltOpenTptRemoteAccessLoaded = 1;
  {$EXTERNALSYM gestaltOpenTptRemoteAccessLoaded}
  gestaltOpenTptRemoteAccessClientOnly = 2;
  {$EXTERNALSYM gestaltOpenTptRemoteAccessClientOnly}
  gestaltOpenTptRemoteAccessPServer = 3;
  {$EXTERNALSYM gestaltOpenTptRemoteAccessPServer}
  gestaltOpenTptRemoteAccessMPServer = 4;
  {$EXTERNALSYM gestaltOpenTptRemoteAccessMPServer}
  gestaltOpenTptPPPPresent      = 5;
  {$EXTERNALSYM gestaltOpenTptPPPPresent}
  gestaltOpenTptARAPPresent     = 6;
  {$EXTERNALSYM gestaltOpenTptARAPPresent}



  gestaltOpenTptRemoteAccessVersion : Integer = Ord('o') shl 24 + Ord('t') shl 16 + Ord('r') shl 8 + Ord('v');  (*  'otrv' *)
  {$EXTERNALSYM gestaltOpenTptRemoteAccessVersion}



(* ***** Open Transport Gestalt ******)



  gestaltOpenTptVersions        : Integer = Ord('o') shl 24 + Ord('t') shl 16 + Ord('v') shl 8 + Ord('r'); (* 'otvr' - Defined by OT 1.1 and higher; response is NumVersion.*)
  {$EXTERNALSYM gestaltOpenTptVersions}



  gestaltOpenTpt                : Integer = Ord('o') shl 24 + Ord('t') shl 16 + Ord('a') shl 8 + Ord('n'); (* 'otan' - Defined by all versions; response is defined below.*)
  {$EXTERNALSYM gestaltOpenTpt}
  gestaltOpenTptPresentMask     = $00000001;
  {$EXTERNALSYM gestaltOpenTptPresentMask}
  gestaltOpenTptLoadedMask      = $00000002;
  {$EXTERNALSYM gestaltOpenTptLoadedMask}
  gestaltOpenTptAppleTalkPresentMask = $00000004;
  {$EXTERNALSYM gestaltOpenTptAppleTalkPresentMask}
  gestaltOpenTptAppleTalkLoadedMask = $00000008;
  {$EXTERNALSYM gestaltOpenTptAppleTalkLoadedMask}
  gestaltOpenTptTCPPresentMask  = $00000010;
  {$EXTERNALSYM gestaltOpenTptTCPPresentMask}
  gestaltOpenTptTCPLoadedMask   = $00000020;
  {$EXTERNALSYM gestaltOpenTptTCPLoadedMask}
  gestaltOpenTptIPXSPXPresentMask = $00000040;
  {$EXTERNALSYM gestaltOpenTptIPXSPXPresentMask}
  gestaltOpenTptIPXSPXLoadedMask = $00000080;
  {$EXTERNALSYM gestaltOpenTptIPXSPXLoadedMask}
  gestaltOpenTptPresentBit      = 0;
  {$EXTERNALSYM gestaltOpenTptPresentBit}
  gestaltOpenTptLoadedBit       = 1;
  {$EXTERNALSYM gestaltOpenTptLoadedBit}
  gestaltOpenTptAppleTalkPresentBit = 2;
  {$EXTERNALSYM gestaltOpenTptAppleTalkPresentBit}
  gestaltOpenTptAppleTalkLoadedBit = 3;
  {$EXTERNALSYM gestaltOpenTptAppleTalkLoadedBit}
  gestaltOpenTptTCPPresentBit   = 4;
  {$EXTERNALSYM gestaltOpenTptTCPPresentBit}
  gestaltOpenTptTCPLoadedBit    = 5;
  {$EXTERNALSYM gestaltOpenTptTCPLoadedBit}
  gestaltOpenTptIPXSPXPresentBit = 6;
  {$EXTERNALSYM gestaltOpenTptIPXSPXPresentBit}
  gestaltOpenTptIPXSPXLoadedBit = 7;
  {$EXTERNALSYM gestaltOpenTptIPXSPXLoadedBit}




  gestaltPCCard                 : Integer = Ord('p') shl 24 + Ord('c') shl 16 + Ord('c') shl 8 + Ord('d'); (* 'pccd' -    PC Card attributes*)
  {$EXTERNALSYM gestaltPCCard}
  gestaltCardServicesPresent    = 0;    (*    PC Card 2.0 (68K) API is present*)
  {$EXTERNALSYM gestaltCardServicesPresent}
  gestaltPCCardFamilyPresent    = 1;    (*    PC Card 3.x (PowerPC) API is present*)
  {$EXTERNALSYM gestaltPCCardFamilyPresent}
  gestaltPCCardHasPowerControl  = 2;    (*    PCCardSetPowerLevel is supported*)
  {$EXTERNALSYM gestaltPCCardHasPowerControl}
  gestaltPCCardSupportsCardBus  = 3;     (*    CardBus is supported*)
  {$EXTERNALSYM gestaltPCCardSupportsCardBus}



  gestaltProcClkSpeed           : Integer = Ord('p') shl 24 + Ord('c') shl 16 + Ord('l') shl 8 + Ord('k'); (* 'pclk' - processor clock speed in hertz (a UInt32) *)
  {$EXTERNALSYM gestaltProcClkSpeed}



  gestaltProcClkSpeedMHz        : Integer = Ord('m') shl 24 + Ord('c') shl 16 + Ord('l') shl 8 + Ord('k'); (* 'mclk' - processor clock speed in megahertz (a UInt32) *)
  {$EXTERNALSYM gestaltProcClkSpeedMHz}



  gestaltPCXAttr                : Integer = Ord('p') shl 24 + Ord('c') shl 16 + Ord('x') shl 8 + Ord('g'); (* 'pcxg' - PC Exchange attributes *)
  {$EXTERNALSYM gestaltPCXAttr}
  gestaltPCXHas8and16BitFAT     = 0;    (* PC Exchange supports both 8 and 16 bit FATs *)
  {$EXTERNALSYM gestaltPCXHas8and16BitFAT}
  gestaltPCXHasProDOS           = 1;    (* PC Exchange supports ProDOS *)
  {$EXTERNALSYM gestaltPCXHasProDOS}
  gestaltPCXNewUI               = 2;
  {$EXTERNALSYM gestaltPCXNewUI}
  gestaltPCXUseICMapping        = 3;     (* PC Exchange uses InternetConfig for file mappings *)
  {$EXTERNALSYM gestaltPCXUseICMapping}



  gestaltLogicalPageSize        : Integer = Ord('p') shl 24 + Ord('g') shl 16 + Ord('s') shl 8 + Ord('z'); (* 'pgsz' - logical page size *)
  {$EXTERNALSYM gestaltLogicalPageSize}


(*    System 7.6 and later.  If gestaltScreenCaptureMain is not implemented;
    PictWhap proceeds with screen capture in the usual way.

    The high word of gestaltScreenCaptureMain is reserved (use 0).

    To disable screen capture to disk; put zero in the low word.  To
    specify a folder for captured pictures; put the vRefNum in the
    low word of gestaltScreenCaptureMain; and put the directory ID in
    gestaltScreenCaptureDir.
*)

  gestaltScreenCaptureMain      : Integer = Ord('p') shl 24 + Ord('i') shl 16 + Ord('c') shl 8 + Ord('1'); (* 'pic1' - Zero; or vRefNum of disk to hold picture *)
  {$EXTERNALSYM gestaltScreenCaptureMain}
  gestaltScreenCaptureDir       : Integer = Ord('p') shl 24 + Ord('i') shl 16 + Ord('c') shl 8 + Ord('2'); (* 'pic2' - Directory ID of folder to hold picture *)
  {$EXTERNALSYM gestaltScreenCaptureDir}



  gestaltGXPrintingMgrVersion   : Integer = Ord('p') shl 24 + Ord('m') shl 16 + Ord('g') shl 8 + Ord('r'); (* 'pmgr' - QuickDraw GX Printing Manager Version*)
  {$EXTERNALSYM gestaltGXPrintingMgrVersion}



  gestaltPopupAttr              : Integer = Ord('p') shl 24 + Ord('o') shl 16 + Ord('p') shl 8 + Ord('!'); (* 'pop!' - popup cdef attributes *)
  {$EXTERNALSYM gestaltPopupAttr}
  gestaltPopupPresent           = 0;
  {$EXTERNALSYM gestaltPopupPresent}



  gestaltPowerMgrAttr           : Integer = Ord('p') shl 24 + Ord('o') shl 16 + Ord('w') shl 8 + Ord('r'); (* 'powr' - power manager attributes *)
  {$EXTERNALSYM gestaltPowerMgrAttr}
  gestaltPMgrExists             = 0;
  {$EXTERNALSYM gestaltPMgrExists}
  gestaltPMgrCPUIdle            = 1;
  {$EXTERNALSYM gestaltPMgrCPUIdle}
  gestaltPMgrSCC                = 2;
  {$EXTERNALSYM gestaltPMgrSCC}
  gestaltPMgrSound              = 3;
  {$EXTERNALSYM gestaltPMgrSound}
  gestaltPMgrDispatchExists     = 4;
  {$EXTERNALSYM gestaltPMgrDispatchExists}
  gestaltPMgrSupportsAVPowerStateAtSleepWake = 5;
  {$EXTERNALSYM gestaltPMgrSupportsAVPowerStateAtSleepWake}



  gestaltPowerMgrVers           : Integer = Ord('p') shl 24 + Ord('w') shl 16 + Ord('r') shl 8 + Ord('v'); (* 'pwrv' - power manager version *)
  {$EXTERNALSYM gestaltPowerMgrVers}


(*
 * PPC will return the combination of following bit fields.
 * e.g. gestaltPPCSupportsRealTime +gestaltPPCSupportsIncoming + gestaltPPCSupportsOutGoing
 * indicates PPC is cuurently is only supports real time delivery
 * and both incoming and outgoing network sessions are allowed.
 * By default local real time delivery is supported as long as PPCInit has been called.*)

  gestaltPPCToolboxAttr         : Integer = Ord('p') shl 24 + Ord('p') shl 16 + Ord('c') shl 8 + Ord(' '); (* 'ppc ' - PPC toolbox attributes *)
  {$EXTERNALSYM gestaltPPCToolboxAttr}
  gestaltPPCToolboxPresent      = $0000; (* PPC Toolbox is present  Requires PPCInit to be called *)
  {$EXTERNALSYM gestaltPPCToolboxPresent}
  gestaltPPCSupportsRealTime    = $1000; (* PPC Supports real-time delivery *)
  {$EXTERNALSYM gestaltPPCSupportsRealTime}
  gestaltPPCSupportsIncoming    = $0001; (* PPC will allow incoming network requests *)
  {$EXTERNALSYM gestaltPPCSupportsIncoming}
  gestaltPPCSupportsOutGoing    = $0002; (* PPC will allow outgoing network requests *)
  {$EXTERNALSYM gestaltPPCSupportsOutGoing}
  gestaltPPCSupportsTCP_IP      = $0004; (* PPC supports TCP/IP transport  *)
  {$EXTERNALSYM gestaltPPCSupportsTCP_IP}
  gestaltPPCSupportsIncomingAppleTalk = $0010;
  {$EXTERNALSYM gestaltPPCSupportsIncomingAppleTalk}
  gestaltPPCSupportsIncomingTCP_IP = $0020;
  {$EXTERNALSYM gestaltPPCSupportsIncomingTCP_IP}
  gestaltPPCSupportsOutgoingAppleTalk = $0100;
  {$EXTERNALSYM gestaltPPCSupportsOutgoingAppleTalk}
  gestaltPPCSupportsOutgoingTCP_IP = $0200;
  {$EXTERNALSYM gestaltPPCSupportsOutgoingTCP_IP}


(*
    Programs which need to know information about particular features of the processor should
    migrate to using sysctl() and sysctlbyname() to get this kind of information.  No new
    information will be added to the 'ppcf'; selector going forward.
*)

  gestaltPowerPCProcessorFeatures : Integer = Ord('p') shl 24 + Ord('p') shl 16 + Ord('c') shl 8 + Ord('f'); (* 'ppcf' - Optional PowerPC processor features *)
  {$EXTERNALSYM gestaltPowerPCProcessorFeatures}
  gestaltPowerPCHasGraphicsInstructions = 0; (* has fres; frsqrte; and fsel instructions *)
  {$EXTERNALSYM gestaltPowerPCHasGraphicsInstructions}
  gestaltPowerPCHasSTFIWXInstruction = 1; (* has stfiwx instruction *)
  {$EXTERNALSYM gestaltPowerPCHasSTFIWXInstruction}
  gestaltPowerPCHasSquareRootInstructions = 2; (* has fsqrt and fsqrts instructions *)
  {$EXTERNALSYM gestaltPowerPCHasSquareRootInstructions}
  gestaltPowerPCHasDCBAInstruction = 3; (* has dcba instruction *)
  {$EXTERNALSYM gestaltPowerPCHasDCBAInstruction}
  gestaltPowerPCHasVectorInstructions = 4; (* has vector instructions *)
  {$EXTERNALSYM gestaltPowerPCHasVectorInstructions}
  gestaltPowerPCHasDataStreams  = 5;    (* has dst; dstt; dstst; dss; and dssall instructions *)
  {$EXTERNALSYM gestaltPowerPCHasDataStreams}
  gestaltPowerPCHas64BitSupport = 6;    (* double word LSU/ALU; etc. *)
  {$EXTERNALSYM gestaltPowerPCHas64BitSupport}
  gestaltPowerPCHasDCBTStreams  = 7;    (* TH field of DCBT recognized *)
  {$EXTERNALSYM gestaltPowerPCHasDCBTStreams}
  gestaltPowerPCASArchitecture  = 8;    (* chip uses new 'A/S'; architecture *)
  {$EXTERNALSYM gestaltPowerPCASArchitecture}
  gestaltPowerPCIgnoresDCBST    = 9;     (* *)
  {$EXTERNALSYM gestaltPowerPCIgnoresDCBST}



  gestaltProcessorType          : Integer = Ord('p') shl 24 + Ord('r') shl 16 + Ord('o') shl 8 + Ord('c'); (* 'proc' - processor type *)
  {$EXTERNALSYM gestaltProcessorType}
  gestalt68000                  = 1;
  {$EXTERNALSYM gestalt68000}
  gestalt68010                  = 2;
  {$EXTERNALSYM gestalt68010}
  gestalt68020                  = 3;
  {$EXTERNALSYM gestalt68020}
  gestalt68030                  = 4;
  {$EXTERNALSYM gestalt68030}
  gestalt68040                  = 5;
  {$EXTERNALSYM gestalt68040}



  gestaltSDPPromptVersion       : Integer = Ord('p') shl 24 + Ord('r') shl 16 + Ord('p') shl 8 + Ord('v'); (* 'prpv' - OCE Standard Directory Panel*)
  {$EXTERNALSYM gestaltSDPPromptVersion}



  gestaltParityAttr             : Integer = Ord('p') shl 24 + Ord('r') shl 16 + Ord('t') shl 8 + Ord('y'); (* 'prty' - parity attributes *)
  {$EXTERNALSYM gestaltParityAttr}
  gestaltHasParityCapability    = 0;    (* has ability to check parity *)
  {$EXTERNALSYM gestaltHasParityCapability}
  gestaltParityEnabled          = 1;     (* parity checking enabled *)
  {$EXTERNALSYM gestaltParityEnabled}



  gestaltQD3DVersion            : Integer = Ord('q') shl 24 + Ord('3') shl 16 + Ord('v') shl 8 + Ord(' '); (* 'q3v ' - Quickdraw 3D version in pack BCD*)
  {$EXTERNALSYM gestaltQD3DVersion}



  gestaltQD3DViewer             : Integer = Ord('q') shl 24 + Ord('3') shl 16 + Ord('v') shl 8 + Ord('c'); (* 'q3vc' - Quickdraw 3D viewer attributes*)
  {$EXTERNALSYM gestaltQD3DViewer}
  gestaltQD3DViewerPresent      = 0;     (* bit 0 set if QD3D Viewer is available*)
  {$EXTERNALSYM gestaltQD3DViewerPresent}


  gestaltQuickdrawVersion       : Integer = Ord('q') shl 24 + Ord('d') shl 16 + Ord(' ') shl 8 + Ord(' '); (* 'qd  ' - quickdraw version *)
  {$EXTERNALSYM gestaltQuickdrawVersion}
  gestaltOriginalQD             = $0000; (* original 1-bit QD *)
  {$EXTERNALSYM gestaltOriginalQD}
  gestalt8BitQD                 = $0100; (* 8-bit color QD *)
  {$EXTERNALSYM gestalt8BitQD}
  gestalt32BitQD                = $0200; (* 32-bit color QD *)
  {$EXTERNALSYM gestalt32BitQD}
  gestalt32BitQD11              = $0201; (* 32-bit color QDv1.1 *)
  {$EXTERNALSYM gestalt32BitQD11}
  gestalt32BitQD12              = $0220; (* 32-bit color QDv1.2 *)
  {$EXTERNALSYM gestalt32BitQD12}
  gestalt32BitQD13              = $0230; (* 32-bit color QDv1.3 *)
  {$EXTERNALSYM gestalt32BitQD13}
  gestaltAllegroQD              = $0250; (* Allegro QD OS 8.5 *)
  {$EXTERNALSYM gestaltAllegroQD}
  gestaltMacOSXQD               = $0300; (* $310; $320 etc. for 10.x.y *)
  {$EXTERNALSYM gestaltMacOSXQD}



  gestaltQD3D                   : Integer = Ord('q') shl 24 + Ord('d') shl 16 + Ord('3') shl 8 + Ord('d'); (* 'qd3d' - Quickdraw 3D attributes*)
  {$EXTERNALSYM gestaltQD3D}
  gestaltQD3DPresent            = 0;     (* bit 0 set if QD3D available*)
  {$EXTERNALSYM gestaltQD3DPresent}


  gestaltGXVersion              : Integer = Ord('q') shl 24 + Ord('d') shl 16 + Ord('g') shl 8 + Ord('x'); (* 'qdgx' - Overall QuickDraw GX Version*)
  {$EXTERNALSYM gestaltGXVersion}



  gestaltQuickdrawFeatures      : Integer = Ord('q') shl 24 + Ord('d') shl 16 + Ord('r') shl 8 + Ord('w'); (* 'qdrw' - quickdraw features *)
  {$EXTERNALSYM gestaltQuickdrawFeatures}
  gestaltHasColor               = 0;    (* color quickdraw present *)
  {$EXTERNALSYM gestaltHasColor}
  gestaltHasDeepGWorlds         = 1;    (* GWorlds can be deeper than 1-bit *)
  {$EXTERNALSYM gestaltHasDeepGWorlds}
  gestaltHasDirectPixMaps       = 2;    (* PixMaps can be direct (16 or 32 bit) *)
  {$EXTERNALSYM gestaltHasDirectPixMaps}
  gestaltHasGrayishTextOr       = 3;    (* supports text mode grayishTextOr *)
  {$EXTERNALSYM gestaltHasGrayishTextOr}
  gestaltSupportsMirroring      = 4;    (* Supports video mirroring via the Display Manager. *)
  {$EXTERNALSYM gestaltSupportsMirroring}
  gestaltQDHasLongRowBytes      = 5;     (* Long rowBytes supported in GWorlds *)
  {$EXTERNALSYM gestaltQDHasLongRowBytes}



  gestaltQDTextVersion          : Integer = Ord('q') shl 24 + Ord('d') shl 16 + Ord('t') shl 8 + Ord('x'); (* 'qdtx' - QuickdrawText version *)
  {$EXTERNALSYM gestaltQDTextVersion}
  gestaltOriginalQDText         = $0000; (* up to and including 8.1 *)
  {$EXTERNALSYM gestaltOriginalQDText}
  gestaltAllegroQDText          = $0100; (* starting with 8.5 *)
  {$EXTERNALSYM gestaltAllegroQDText}
  gestaltMacOSXQDText           = $0200; (* we are in Mac OS X *)
  {$EXTERNALSYM gestaltMacOSXQDText}



  gestaltQDTextFeatures         : Integer = Ord('q') shl 24 + Ord('d') shl 16 + Ord('t') shl 8 + Ord('f'); (* 'qdtf' - QuickdrawText features *)
  {$EXTERNALSYM gestaltQDTextFeatures}
  gestaltWSIISupport            = 0;    (* bit 0: WSII support included *)
  {$EXTERNALSYM gestaltWSIISupport}
  gestaltSbitFontSupport        = 1;    (* sbit-only fonts supported *)
  {$EXTERNALSYM gestaltSbitFontSupport}
  gestaltAntiAliasedTextAvailable = 2;  (* capable of antialiased text *)
  {$EXTERNALSYM gestaltAntiAliasedTextAvailable}
  gestaltOFA2available          = 3;    (* OFA2 available *)
  {$EXTERNALSYM gestaltOFA2available}
  gestaltCreatesAliasFontRsrc   = 4;    (* "real" datafork font support *)
  {$EXTERNALSYM gestaltCreatesAliasFontRsrc}
  gestaltNativeType1FontSupport = 5;    (* we have scaler for Type1 fonts *)
  {$EXTERNALSYM gestaltNativeType1FontSupport}
  gestaltCanUseCGTextRendering  = 6;
  {$EXTERNALSYM gestaltCanUseCGTextRendering}




  gestaltQuickTimeConferencingInfo : Integer = Ord('q') shl 24 + Ord('t') shl 16 + Ord('c') shl 8 + Ord('i'); (* 'qtci' - returns pointer to QuickTime Conferencing information *)
  {$EXTERNALSYM gestaltQuickTimeConferencingInfo}



  gestaltQuickTimeVersion       : Integer = Ord('q') shl 24 + Ord('t') shl 16 + Ord('i') shl 8 + Ord('m'); (* 'qtim' - returns version of QuickTime *)
  {$EXTERNALSYM gestaltQuickTimeVersion}
  gestaltQuickTime              : Integer = Ord('q') shl 24 + Ord('t') shl 16 + Ord('i') shl 8 + Ord('m'); (* 'qtim' - gestaltQuickTime is old name for gestaltQuickTimeVersion *)
  {$EXTERNALSYM gestaltQuickTime}



  gestaltQuickTimeFeatures      : Integer = Ord('q') shl 24 + Ord('t') shl 16 + Ord('r') shl 8 + Ord('s');  (*  'qtrs' *)
  {$EXTERNALSYM gestaltQuickTimeFeatures}
  gestaltPPCQuickTimeLibPresent = 0;     (* PowerPC QuickTime glue library is present *)
  {$EXTERNALSYM gestaltPPCQuickTimeLibPresent}



  gestaltQuickTimeStreamingFeatures : Integer = Ord('q') shl 24 + Ord('t') shl 16 + Ord('s') shl 8 + Ord('f');  (*  'qtsf' *)
  {$EXTERNALSYM gestaltQuickTimeStreamingFeatures}



  gestaltQuickTimeStreamingVersion : Integer = Ord('q') shl 24 + Ord('t') shl 16 + Ord('s') shl 8 + Ord('t');   (* 'qtst' *)
  {$EXTERNALSYM gestaltQuickTimeStreamingVersion}



  gestaltQuickTimeThreadSafeFeaturesAttr : Integer = Ord('q') shl 24 + Ord('t') shl 16 + Ord('t') shl 8 + Ord('h'); (* 'qtth' - Quicktime thread safety attributes *)
  {$EXTERNALSYM gestaltQuickTimeThreadSafeFeaturesAttr}
  gestaltQuickTimeThreadSafeICM = 0;
  {$EXTERNALSYM gestaltQuickTimeThreadSafeICM}
  gestaltQuickTimeThreadSafeMovieToolbox = 1;
  {$EXTERNALSYM gestaltQuickTimeThreadSafeMovieToolbox}
  gestaltQuickTimeThreadSafeMovieImport = 2;
  {$EXTERNALSYM gestaltQuickTimeThreadSafeMovieImport}
  gestaltQuickTimeThreadSafeMovieExport = 3;
  {$EXTERNALSYM gestaltQuickTimeThreadSafeMovieExport}
  gestaltQuickTimeThreadSafeGraphicsImport = 4;
  {$EXTERNALSYM gestaltQuickTimeThreadSafeGraphicsImport}
  gestaltQuickTimeThreadSafeGraphicsExport = 5;
  {$EXTERNALSYM gestaltQuickTimeThreadSafeGraphicsExport}
  gestaltQuickTimeThreadSafeMoviePlayback = 6;
  {$EXTERNALSYM gestaltQuickTimeThreadSafeMoviePlayback}



  gestaltQTVRMgrAttr            : Integer = Ord('q') shl 24 + Ord('t') shl 16 + Ord('v') shl 8 + Ord('r'); (* 'qtvr' - QuickTime VR attributes                               *)
  {$EXTERNALSYM gestaltQTVRMgrAttr}
  gestaltQTVRMgrPresent         = 0;    (* QTVR API is present                                   *)
  {$EXTERNALSYM gestaltQTVRMgrPresent}
  gestaltQTVRObjMoviesPresent   = 1;    (* QTVR runtime knows about object movies                *)
  {$EXTERNALSYM gestaltQTVRObjMoviesPresent}
  gestaltQTVRCylinderPanosPresent = 2;  (* QTVR runtime knows about cylindrical panoramic movies *)
  {$EXTERNALSYM gestaltQTVRCylinderPanosPresent}
  gestaltQTVRCubicPanosPresent  = 3;     (* QTVR runtime knows about cubic panoramic movies       *)
  {$EXTERNALSYM gestaltQTVRCubicPanosPresent}



  gestaltQTVRMgrVers            : Integer = Ord('q') shl 24 + Ord('t') shl 16 + Ord('v') shl 8 + Ord('v'); (* 'qtvv' - QuickTime VR version                                  *)
  {$EXTERNALSYM gestaltQTVRMgrVers}


(*
    Because some PowerPC machines now support very large physical memory capacities; including
    some above the maximum value which can held in a 32 bit quantity; there is now a new selector;
    gestaltPhysicalRAMSizeInMegabytes; which returns the size of physical memory scaled
    in megabytes.  It is recommended that code transition to using this new selector if
    it wants to get a useful value for the amount of physical memory on the system.  Code can
    also use the sysctl() and sysctlbyname() BSD calls to get these kinds of values.

    For compatability with code which assumed that the value in returned by the
    gestaltPhysicalRAMSize selector would be a signed quantity of bytes; this selector will
    now return 2 gigabytes-1 ( INT_MAX ) if the system has 2 gigabytes of physical memory or more.
*)

  gestaltPhysicalRAMSize        : Integer = Ord('r') shl 24 + Ord('a') shl 16 + Ord('m') shl 8 + Ord(' '); (* 'ram ' - physical RAM size; in bytes *)
  {$EXTERNALSYM gestaltPhysicalRAMSize}



  gestaltPhysicalRAMSizeInMegabytes : Integer = Ord('r') shl 24 + Ord('a') shl 16 + Ord('m') shl 8 + Ord('m'); (* 'ramm' - physical RAM size; scaled in megabytes *)
  {$EXTERNALSYM gestaltPhysicalRAMSizeInMegabytes}



  gestaltRBVAddr                : Integer = Ord('r') shl 24 + Ord('b') shl 16 + Ord('v') shl 8 + Ord(' '); (* 'rbv ' - RBV base address  *)
  {$EXTERNALSYM gestaltRBVAddr}



  gestaltROMSize                : Integer = Ord('r') shl 24 + Ord('o') shl 16 + Ord('m') shl 8 + Ord(' '); (* 'rom ' - rom size *)
  {$EXTERNALSYM gestaltROMSize}



  gestaltROMVersion             : Integer = Ord('r') shl 24 + Ord('o') shl 16 + Ord('m') shl 8 + Ord('v'); (* 'romv' - rom version *)
  {$EXTERNALSYM gestaltROMVersion}



  gestaltResourceMgrAttr        : Integer = Ord('r') shl 24 + Ord('s') shl 16 + Ord('r') shl 8 + Ord('c'); (* 'rsrc' - Resource Mgr attributes *)
  {$EXTERNALSYM gestaltResourceMgrAttr}
  gestaltPartialRsrcs           = 0;    (* True if partial resources exist *)
  {$EXTERNALSYM gestaltPartialRsrcs}
  gestaltHasResourceOverrides   = 1;     (* Appears in the ROM; so put it here. *)
  {$EXTERNALSYM gestaltHasResourceOverrides}



  gestaltResourceMgrBugFixesAttrs : Integer = Ord('r') shl 24 + Ord('m') shl 16 + Ord('b') shl 8 + Ord('g'); (* 'rmbg' - Resource Mgr bug fixes *)
  {$EXTERNALSYM gestaltResourceMgrBugFixesAttrs}
  gestaltRMForceSysHeapRolledIn = 0;
  {$EXTERNALSYM gestaltRMForceSysHeapRolledIn}
  gestaltRMFakeAppleMenuItemsRolledIn = 1;
  {$EXTERNALSYM gestaltRMFakeAppleMenuItemsRolledIn}
  gestaltSanityCheckResourceFiles = 2;  (* Resource manager does sanity checking on resource files before opening them *)
  {$EXTERNALSYM gestaltSanityCheckResourceFiles}
  gestaltSupportsFSpResourceFileAlreadyOpenBit = 3; (* The resource manager supports GetResFileRefNum and FSpGetResFileRefNum and FSpResourceFileAlreadyOpen *)
  {$EXTERNALSYM gestaltSupportsFSpResourceFileAlreadyOpenBit}
  gestaltRMSupportsFSCalls      = 4;    (* The resource manager supports OpenResFileFSRef; CreateResFileFSRef and  ResourceFileAlreadyOpenFSRef *)
  {$EXTERNALSYM gestaltRMSupportsFSCalls}
  gestaltRMTypeIndexOrderingReverse = 8; (* GetIndType() calls return resource types in opposite order to original 68k resource manager *)
  {$EXTERNALSYM gestaltRMTypeIndexOrderingReverse}




  gestaltRealtimeMgrAttr        : Integer = Ord('r') shl 24 + Ord('t') shl 16 + Ord('m') shl 8 + Ord('r'); (* 'rtmr' - Realtime manager attributes         *)
  {$EXTERNALSYM gestaltRealtimeMgrAttr}
  gestaltRealtimeMgrPresent     = 0;     (* true if the Realtime manager is present    *)
  {$EXTERNALSYM gestaltRealtimeMgrPresent}




  gestaltSafeOFAttr             : Integer = Ord('s') shl 24 + Ord('a') shl 16 + Ord('f') shl 8 + Ord('e');  (*  'safe' *)
  {$EXTERNALSYM gestaltSafeOFAttr}
  gestaltVMZerosPagesBit        = 0;
  {$EXTERNALSYM gestaltVMZerosPagesBit}
  gestaltInitHeapZerosOutHeapsBit = 1;
  {$EXTERNALSYM gestaltInitHeapZerosOutHeapsBit}
  gestaltNewHandleReturnsZeroedMemoryBit = 2;
  {$EXTERNALSYM gestaltNewHandleReturnsZeroedMemoryBit}
  gestaltNewPtrReturnsZeroedMemoryBit = 3;
  {$EXTERNALSYM gestaltNewPtrReturnsZeroedMemoryBit}
  gestaltFileAllocationZeroedBlocksBit = 4;
  {$EXTERNALSYM gestaltFileAllocationZeroedBlocksBit}




  gestaltSCCReadAddr            : Integer = Ord('s') shl 24 + Ord('c') shl 16 + Ord('c') shl 8 + Ord('r'); (* 'sccr' - scc read base address  *)
  {$EXTERNALSYM gestaltSCCReadAddr}



  gestaltSCCWriteAddr           : Integer = Ord('s') shl 24 + Ord('c') shl 16 + Ord('c') shl 8 + Ord('w'); (* 'sccw' - scc read base address  *)
  {$EXTERNALSYM gestaltSCCWriteAddr}



  gestaltScrapMgrAttr           : Integer = Ord('s') shl 24 + Ord('c') shl 16 + Ord('r') shl 8 + Ord('a'); (* 'scra' - Scrap Manager attributes *)
  {$EXTERNALSYM gestaltScrapMgrAttr}
  gestaltScrapMgrTranslationAware = 0;   (* True if scrap manager is translation aware *)
  {$EXTERNALSYM gestaltScrapMgrTranslationAware}



  gestaltScriptMgrVersion       : Integer = Ord('s') shl 24 + Ord('c') shl 16 + Ord('r') shl 8 + Ord('i'); (* 'scri' - Script Manager version number     *)
  {$EXTERNALSYM gestaltScriptMgrVersion}



  gestaltScriptCount            : Integer = Ord('s') shl 24 + Ord('c') shl 16 + Ord('r') shl 8 + Ord('#'); (* 'scr#' - number of active script systems   *)
  {$EXTERNALSYM gestaltScriptCount}



  gestaltSCSI                   : Integer = Ord('s') shl 24 + Ord('c') shl 16 + Ord('s') shl 8 + Ord('i'); (* 'scsi' - SCSI Manager attributes *)
  {$EXTERNALSYM gestaltSCSI}
  gestaltAsyncSCSI              = 0;    (* Supports Asynchronous SCSI *)
  {$EXTERNALSYM gestaltAsyncSCSI}
  gestaltAsyncSCSIINROM         = 1;    (* Async scsi is in ROM (available for booting) *)
  {$EXTERNALSYM gestaltAsyncSCSIINROM}
  gestaltSCSISlotBoot           = 2;    (* ROM supports Slot-style PRAM for SCSI boots (PDM and later) *)
  {$EXTERNALSYM gestaltSCSISlotBoot}
  gestaltSCSIPollSIH            = 3;     (* SCSI Manager will poll for interrupts if Secondary Interrupts are busy. *)
  {$EXTERNALSYM gestaltSCSIPollSIH}



  gestaltControlStripAttr       : Integer = Ord('s') shl 24 + Ord('d') shl 16 + Ord('e') shl 8 + Ord('v'); (* 'sdev' - Control Strip attributes *)
  {$EXTERNALSYM gestaltControlStripAttr}
  gestaltControlStripExists     = 0;    (* Control Strip is installed *)
  {$EXTERNALSYM gestaltControlStripExists}
  gestaltControlStripVersionFixed = 1;  (* Control Strip version Gestalt selector was fixed *)
  {$EXTERNALSYM gestaltControlStripVersionFixed}
  gestaltControlStripUserFont   = 2;    (* supports user-selectable font/size *)
  {$EXTERNALSYM gestaltControlStripUserFont}
  gestaltControlStripUserHotKey = 3;     (* support user-selectable hot key to show/hide the window *)
  {$EXTERNALSYM gestaltControlStripUserHotKey}



  gestaltSDPStandardDirectoryVersion : Integer = Ord('s') shl 24 + Ord('d') shl 16 + Ord('v') shl 8 + Ord('r'); (* 'sdvr' - OCE Standard Directory Panel*)
  {$EXTERNALSYM gestaltSDPStandardDirectoryVersion}



  gestaltSerialAttr             : Integer = Ord('s') shl 24 + Ord('e') shl 16 + Ord('r') shl 8 + Ord(' '); (* 'ser ' - Serial attributes *)
  {$EXTERNALSYM gestaltSerialAttr}
  gestaltHasGPIaToDCDa          = 0;    (* GPIa connected to DCDa*)
  {$EXTERNALSYM gestaltHasGPIaToDCDa}
  gestaltHasGPIaToRTxCa         = 1;    (* GPIa connected to RTxCa clock input*)
  {$EXTERNALSYM gestaltHasGPIaToRTxCa}
  gestaltHasGPIbToDCDb          = 2;    (* GPIb connected to DCDb *)
  {$EXTERNALSYM gestaltHasGPIbToDCDb}
  gestaltHidePortA              = 3;    (* Modem port (A) should be hidden from users *)
  {$EXTERNALSYM gestaltHidePortA}
  gestaltHidePortB              = 4;    (* Printer port (B) should be hidden from users *)
  {$EXTERNALSYM gestaltHidePortB}
  gestaltPortADisabled          = 5;    (* Modem port (A) disabled and should not be used by SW *)
  {$EXTERNALSYM gestaltPortADisabled}
  gestaltPortBDisabled          = 6;     (* Printer port (B) disabled and should not be used by SW *)
  {$EXTERNALSYM gestaltPortBDisabled}



  gestaltShutdownAttributes     : Integer = Ord('s') shl 24 + Ord('h') shl 16 + Ord('u') shl 8 + Ord('t'); (* 'shut' - ShutDown Manager Attributes *)
  {$EXTERNALSYM gestaltShutdownAttributes}
  gestaltShutdownHassdOnBootVolUnmount = 0; (* True if ShutDown Manager unmounts boot & VM volume at shutdown time. *)
  {$EXTERNALSYM gestaltShutdownHassdOnBootVolUnmount}



  gestaltNuBusConnectors        : Integer = Ord('s') shl 24 + Ord('l') shl 16 + Ord('t') shl 8 + Ord('c'); (* 'sltc' - bitmap of NuBus connectors*)
  {$EXTERNALSYM gestaltNuBusConnectors}



  gestaltSlotAttr               : Integer = Ord('s') shl 24 + Ord('l') shl 16 + Ord('o') shl 8 + Ord('t'); (* 'slot' - slot attributes  *)
  {$EXTERNALSYM gestaltSlotAttr}
  gestaltSlotMgrExists          = 0;    (* true is slot mgr exists  *)
  {$EXTERNALSYM gestaltSlotMgrExists}
  gestaltNuBusPresent           = 1;    (* NuBus slots are present  *)
  {$EXTERNALSYM gestaltNuBusPresent}
  gestaltSESlotPresent          = 2;    (* SE PDS slot present  *)
  {$EXTERNALSYM gestaltSESlotPresent}
  gestaltSE30SlotPresent        = 3;    (* SE/30 slot present  *)
  {$EXTERNALSYM gestaltSE30SlotPresent}
  gestaltPortableSlotPresent    = 4;     (* Portable’s slot present  *)
  {$EXTERNALSYM gestaltPortableSlotPresent}



  gestaltFirstSlotNumber        : Integer = Ord('s') shl 24 + Ord('l') shl 16 + Ord('t') shl 8 + Ord('1'); (* 'slt1' - returns first physical slot *)
  {$EXTERNALSYM gestaltFirstSlotNumber}



  gestaltSoundAttr              : Integer = Ord('s') shl 24 + Ord('n') shl 16 + Ord('d') shl 8 + Ord(' '); (* 'snd ' - sound attributes *)
  {$EXTERNALSYM gestaltSoundAttr}
  gestaltStereoCapability       = 0;    (* sound hardware has stereo capability *)
  {$EXTERNALSYM gestaltStereoCapability}
  gestaltStereoMixing           = 1;    (* stereo mixing on external speaker *)
  {$EXTERNALSYM gestaltStereoMixing}
  gestaltSoundIOMgrPresent      = 3;    (* The Sound I/O Manager is present *)
  {$EXTERNALSYM gestaltSoundIOMgrPresent}
  gestaltBuiltInSoundInput      = 4;    (* built-in Sound Input hardware is present *)
  {$EXTERNALSYM gestaltBuiltInSoundInput}
  gestaltHasSoundInputDevice    = 5;    (* Sound Input device available *)
  {$EXTERNALSYM gestaltHasSoundInputDevice}
  gestaltPlayAndRecord          = 6;    (* built-in hardware can play and record simultaneously *)
  {$EXTERNALSYM gestaltPlayAndRecord}
  gestalt16BitSoundIO           = 7;    (* sound hardware can play and record 16-bit samples *)
  {$EXTERNALSYM gestalt16BitSoundIO}
  gestaltStereoInput            = 8;    (* sound hardware can record stereo *)
  {$EXTERNALSYM gestaltStereoInput}
  gestaltLineLevelInput         = 9;    (* sound input port requires line level *)
  {$EXTERNALSYM gestaltLineLevelInput}
                                        (* the following bits are not defined prior to Sound Mgr 3.0 *)
  gestaltSndPlayDoubleBuffer    = 10;   (* SndPlayDoubleBuffer available; set by Sound Mgr 3.0 and later *)
  {$EXTERNALSYM gestaltSndPlayDoubleBuffer}
  gestaltMultiChannels          = 11;   (* multiple channel support; set by Sound Mgr 3.0 and later *)
  {$EXTERNALSYM gestaltMultiChannels}
  gestalt16BitAudioSupport      = 12;    (* 16 bit audio data supported; set by Sound Mgr 3.0 and later *)
  {$EXTERNALSYM gestalt16BitAudioSupport}



  gestaltSplitOSAttr            : Integer = Ord('s') shl 24 + Ord('p') shl 16 + Ord('o') shl 8 + Ord('s');  (*  'spos' *)
  {$EXTERNALSYM gestaltSplitOSAttr}
  gestaltSplitOSBootDriveIsNetworkVolume = 0; (* the boot disk is a network 'disk'; from the .LANDisk drive. *)
  {$EXTERNALSYM gestaltSplitOSBootDriveIsNetworkVolume}
  gestaltSplitOSAware           = 1;    (* the system includes the code to deal with a split os situation. *)
  {$EXTERNALSYM gestaltSplitOSAware}
  gestaltSplitOSEnablerVolumeIsDifferentFromBootVolume = 2; (* the active enabler is on a different volume than the system file. *)
  {$EXTERNALSYM gestaltSplitOSEnablerVolumeIsDifferentFromBootVolume}
  gestaltSplitOSMachineNameSetToNetworkNameTemp = 3; (* The machine name was set to the value given us from the BootP server *)
  {$EXTERNALSYM gestaltSplitOSMachineNameSetToNetworkNameTemp}
  gestaltSplitOSMachineNameStartupDiskIsNonPersistent = 5; (* The startup disk ( vRefNum == -1 ) is non-persistent; meaning changes won't persist across a restart. *)
  {$EXTERNALSYM gestaltSplitOSMachineNameStartupDiskIsNonPersistent}



  gestaltSMPSPSendLetterVersion : Integer = Ord('s') shl 24 + Ord('p') shl 16 + Ord('s') shl 8 + Ord('l'); (* 'spsl' - OCE StandardMail*)
  {$EXTERNALSYM gestaltSMPSPSendLetterVersion}



  gestaltSpeechRecognitionAttr  : Integer = Ord('s') shl 24 + Ord('r') shl 16 + Ord('t') shl 8 + Ord('a'); (* 'srta' - speech recognition attributes *)
  {$EXTERNALSYM gestaltSpeechRecognitionAttr}
  gestaltDesktopSpeechRecognition = 1;  (* recognition thru the desktop microphone is available *)
  {$EXTERNALSYM gestaltDesktopSpeechRecognition}
  gestaltTelephoneSpeechRecognition = 2; (* recognition thru the telephone is available *)
  {$EXTERNALSYM gestaltTelephoneSpeechRecognition}



  gestaltSpeechRecognitionVersion : Integer = Ord('s') shl 24 + Ord('r') shl 16 + Ord('t') shl 8 + Ord('b'); (* 'srtb' - speech recognition version ($0150 is the first version that fully supports the API) *)
  {$EXTERNALSYM gestaltSpeechRecognitionVersion}



  gestaltSoftwareVendorCode     : Integer = Ord('s') shl 24 + Ord('r') shl 16 + Ord('a') shl 8 + Ord('d'); (* 'srad' - Returns system software vendor information *)
  {$EXTERNALSYM gestaltSoftwareVendorCode}
  gestaltSoftwareVendorApple    : Integer = Ord('A') shl 24 + Ord('p') shl 16 + Ord('p') shl 8 + Ord('l'); (* 'Appl' - System software sold by Apple *)
  {$EXTERNALSYM gestaltSoftwareVendorApple}
  gestaltSoftwareVendorLicensee : Integer = Ord('L') shl 24 + Ord('c') shl 16 + Ord('n') shl 8 + Ord('s'); (* 'Lcns' - System software sold by licensee *)
  {$EXTERNALSYM gestaltSoftwareVendorLicensee}



  gestaltStandardFileAttr       : Integer = Ord('s') shl 24 + Ord('t') shl 16 + Ord('d') shl 8 + Ord('f'); (* 'stdf' - Standard File attributes *)
  {$EXTERNALSYM gestaltStandardFileAttr}
  gestaltStandardFile58         = 0;    (* True if selectors 5-8 (StandardPutFile-CustomGetFile) are supported *)
  {$EXTERNALSYM gestaltStandardFile58}
  gestaltStandardFileTranslationAware = 1; (* True if standard file is translation manager aware *)
  {$EXTERNALSYM gestaltStandardFileTranslationAware}
  gestaltStandardFileHasColorIcons = 2; (* True if standard file has 16x16 color icons *)
  {$EXTERNALSYM gestaltStandardFileHasColorIcons}
  gestaltStandardFileUseGenericIcons = 3; (* Standard file LDEF to use only the system generic icons if true *)
  {$EXTERNALSYM gestaltStandardFileUseGenericIcons}
  gestaltStandardFileHasDynamicVolumeAllocation = 4; (* True if standard file supports more than 20 volumes *)
  {$EXTERNALSYM gestaltStandardFileHasDynamicVolumeAllocation}



  gestaltSysArchitecture        : Integer = Ord('s') shl 24 + Ord('y') shl 16 + Ord('s') shl 8 + Ord('a'); (* 'sysa' - Native System Architecture *)
  {$EXTERNALSYM gestaltSysArchitecture}
  gestalt68k                    = 1;    (* Motorola MC68k architecture *)
  {$EXTERNALSYM gestalt68k}
  gestaltPowerPC                = 2;    (* IBM PowerPC architecture *)
  {$EXTERNALSYM gestaltPowerPC}
  gestaltIntel                  = 10;    (* Intel x86 architecture *)
  {$EXTERNALSYM gestaltIntel}



  gestaltSystemUpdateVersion    : Integer = Ord('s') shl 24 + Ord('y') shl 16 + Ord('s') shl 8 + Ord('u'); (* 'sysu' - System Update version *)
  {$EXTERNALSYM gestaltSystemUpdateVersion}


(*
    Returns the system version as a 32 bit packed BCD ( binary coded decimal )
    version representation.  Bits 0 through 3 are the "bug fix" revision number.
    Bits 4 through 7 are the minor revision; and bits 8 through 31 are the bcd
    decimal digits of the major release version.

      Value:  $MMMMMMRB = M.R.B            Example: $00001023 = 10.2.3
                ^^^^^^     major rev                   ^^^^^^   major rev   = 10
                      ^    minor rev                         ^  minor rev   =  2
                       ^   bug fix rev                        ^ bug fix rev =  3

    If the values of the minor or bug fix revision are larger than 9; then
    gestaltSystemVersion will substitute the value 9 for them.  For example;
    Mac OS X 10.3.15 will be returned as $1039; and Mac OS X 10.10.5 will
    return $1095.

    A better way to get version information on Mac OS X would be to use the
    new gestaltSystemVersionMajor; gestaltSystemVersionMinor; and
    gestaltSystemVersionBugFix selectors; which don't have arbitrary limits
    on the values returned.

    If you want to know the product build version string; product name; or
    the user visible version string you shuold read in the system version
    information from the file /System/Library/CoreServices/SystemVersion.plist.

*)

  gestaltSystemVersion          : Integer = Ord('s') shl 24 + Ord('y') shl 16 + Ord('s') shl 8 + Ord('v'); (* 'sysv' - system version*)
  {$EXTERNALSYM gestaltSystemVersion}
  gestaltSystemVersionMajor     : Integer = Ord('s') shl 24 + Ord('y') shl 16 + Ord('s') shl 8 + Ord('1'); (* 'sys1' - The major system version number; in 10.4.17 this would be the decimal value 10 *)
  {$EXTERNALSYM gestaltSystemVersionMajor}
  gestaltSystemVersionMinor     : Integer = Ord('s') shl 24 + Ord('y') shl 16 + Ord('s') shl 8 + Ord('2'); (* 'sys2' - The minor system version number; in 10.4.17 this would be the decimal value 4 *)
  {$EXTERNALSYM gestaltSystemVersionMinor}
  gestaltSystemVersionBugFix    : Integer = Ord('s') shl 24 + Ord('y') shl 16 + Ord('s') shl 8 + Ord('3'); (* 'sys3' - The bug fix system version number; in 10.4.17 this would be the decimal value 17 *)
  {$EXTERNALSYM gestaltSystemVersionBugFix}



  gestaltToolboxTable           : Integer = Ord('t') shl 24 + Ord('b') shl 16 + Ord('t') shl 8 + Ord('t'); (* 'tbtt' -  OS trap table base  *)
  {$EXTERNALSYM gestaltToolboxTable}



  gestaltTextEditVersion        : Integer = Ord('t') shl 24 + Ord('e') shl 16 + Ord(' ') shl 8 + Ord(' '); (* 'te  ' - TextEdit version number *)
  {$EXTERNALSYM gestaltTextEditVersion}
  gestaltTE1                    = 1;    (* TextEdit in MacIIci ROM *)
  {$EXTERNALSYM gestaltTE1}
  gestaltTE2                    = 2;    (* TextEdit with 6.0.4 Script Systems on MacIIci (Script bug fixes for MacIIci) *)
  {$EXTERNALSYM gestaltTE2}
  gestaltTE3                    = 3;    (* TextEdit with 6.0.4 Script Systems all but MacIIci *)
  {$EXTERNALSYM gestaltTE3}
  gestaltTE4                    = 4;    (* TextEdit in System 7.0 *)
  {$EXTERNALSYM gestaltTE4}
  gestaltTE5                    = 5;     (* TextWidthHook available in TextEdit *)
  {$EXTERNALSYM gestaltTE5}



  gestaltTE6                    = 6;     (* TextEdit with integrated TSMTE and improved UI *)
  {$EXTERNALSYM gestaltTE6}



  gestaltTEAttr                 : Integer = Ord('t') shl 24 + Ord('e') shl 16 + Ord('a') shl 8 + Ord('t'); (* 'teat' - TextEdit attributes *)
  {$EXTERNALSYM gestaltTEAttr}
  gestaltTEHasGetHiliteRgn      = 0;    (* TextEdit has TEGetHiliteRgn *)
  {$EXTERNALSYM gestaltTEHasGetHiliteRgn}
  gestaltTESupportsInlineInput  = 1;    (* TextEdit does Inline Input *)
  {$EXTERNALSYM gestaltTESupportsInlineInput}
  gestaltTESupportsTextObjects  = 2;    (* TextEdit does Text Objects *)
  {$EXTERNALSYM gestaltTESupportsTextObjects}
  gestaltTEHasWhiteBackground   = 3;     (* TextEdit supports overriding the TERec's background to white *)
  {$EXTERNALSYM gestaltTEHasWhiteBackground}



  gestaltTeleMgrAttr            : Integer = Ord('t') shl 24 + Ord('e') shl 16 + Ord('l') shl 8 + Ord('e'); (* 'tele' - Telephone manager attributes *)
  {$EXTERNALSYM gestaltTeleMgrAttr}
  gestaltTeleMgrPresent         = 0;
  {$EXTERNALSYM gestaltTeleMgrPresent}
  gestaltTeleMgrPowerPCSupport  = 1;
  {$EXTERNALSYM gestaltTeleMgrPowerPCSupport}
  gestaltTeleMgrSoundStreams    = 2;
  {$EXTERNALSYM gestaltTeleMgrSoundStreams}
  gestaltTeleMgrAutoAnswer      = 3;
  {$EXTERNALSYM gestaltTeleMgrAutoAnswer}
  gestaltTeleMgrIndHandset      = 4;
  {$EXTERNALSYM gestaltTeleMgrIndHandset}
  gestaltTeleMgrSilenceDetect   = 5;
  {$EXTERNALSYM gestaltTeleMgrSilenceDetect}
  gestaltTeleMgrNewTELNewSupport = 6;
  {$EXTERNALSYM gestaltTeleMgrNewTELNewSupport}



  gestaltTermMgrAttr            : Integer = Ord('t') shl 24 + Ord('e') shl 16 + Ord('r') shl 8 + Ord('m'); (* 'term' - terminal mgr attributes *)
  {$EXTERNALSYM gestaltTermMgrAttr}
  gestaltTermMgrPresent         = 0;
  {$EXTERNALSYM gestaltTermMgrPresent}
  gestaltTermMgrErrorString     = 2;
  {$EXTERNALSYM gestaltTermMgrErrorString}



  gestaltThreadMgrAttr          : Integer = Ord('t') shl 24 + Ord('h') shl 16 + Ord('d') shl 8 + Ord('s'); (* 'thds' - Thread Manager attributes *)
  {$EXTERNALSYM gestaltThreadMgrAttr}
  gestaltThreadMgrPresent       = 0;    (* bit true if Thread Mgr is present *)
  {$EXTERNALSYM gestaltThreadMgrPresent}
  gestaltSpecificMatchSupport   = 1;    (* bit true if Thread Mgr supports exact match creation option *)
  {$EXTERNALSYM gestaltSpecificMatchSupport}
  gestaltThreadsLibraryPresent  = 2;     (* bit true if Thread Mgr shared library is present *)
  {$EXTERNALSYM gestaltThreadsLibraryPresent}



  gestaltTimeMgrVersion         : Integer = Ord('t') shl 24 + Ord('m') shl 16 + Ord('g') shl 8 + Ord('r'); (* 'tmgr' - time mgr version *)
  {$EXTERNALSYM gestaltTimeMgrVersion}
  gestaltStandardTimeMgr        = 1;    (* standard time mgr is present *)
  {$EXTERNALSYM gestaltStandardTimeMgr}
  gestaltRevisedTimeMgr         = 2;    (* revised time mgr is present *)
  {$EXTERNALSYM gestaltRevisedTimeMgr}
  gestaltExtendedTimeMgr        = 3;    (* extended time mgr is present *)
  {$EXTERNALSYM gestaltExtendedTimeMgr}
  gestaltNativeTimeMgr          = 4;     (* PowerPC native TimeMgr is present *)
  {$EXTERNALSYM gestaltNativeTimeMgr}



  gestaltTSMTEVersion           : Integer = Ord('t') shl 24 + Ord('m') shl 16 + Ord('T') shl 8 + Ord('V');  (*  'tmTV' *)
  {$EXTERNALSYM gestaltTSMTEVersion}
  gestaltTSMTE1                 = $0100; (* Original version of TSMTE *)
  {$EXTERNALSYM gestaltTSMTE1}
  gestaltTSMTE15                = $0150; (* System 8.0 *)
  {$EXTERNALSYM gestaltTSMTE15}
  gestaltTSMTE152               = $0152; (* System 8.2 *)
  {$EXTERNALSYM gestaltTSMTE152}



  gestaltTSMTEAttr              : Integer = Ord('t') shl 24 + Ord('m') shl 16 + Ord('T') shl 8 + Ord('E');  (*  'tmTE' *)
  {$EXTERNALSYM gestaltTSMTEAttr}
  gestaltTSMTEPresent           = 0;
  {$EXTERNALSYM gestaltTSMTEPresent}
  gestaltTSMTE                  = 0;     (* gestaltTSMTE is old name for gestaltTSMTEPresent *)
  {$EXTERNALSYM gestaltTSMTE}



  gestaltAVLTreeAttr            : Integer = Ord('t') shl 24 + Ord('r') shl 16 + Ord('e') shl 8 + Ord('e'); (* 'tree' - AVLTree utility routines attributes. *)
  {$EXTERNALSYM gestaltAVLTreeAttr}
  gestaltAVLTreePresentBit      = 0;    (* if set; then the AVL Tree routines are available. *)
  {$EXTERNALSYM gestaltAVLTreePresentBit}
  gestaltAVLTreeSupportsHandleBasedTreeBit = 1; (* if set; then the AVL Tree routines can store tree data in a single handle *)
  {$EXTERNALSYM gestaltAVLTreeSupportsHandleBasedTreeBit}
  gestaltAVLTreeSupportsTreeLockingBit = 2; (* if set; the AVLLockTree() and AVLUnlockTree() routines are available. *)
  {$EXTERNALSYM gestaltAVLTreeSupportsTreeLockingBit}



  gestaltALMAttr                : Integer = Ord('t') shl 24 + Ord('r') shl 16 + Ord('i') shl 8 + Ord('p'); (* 'trip' - Settings Manager attributes (see also gestaltALMVers) *)
  {$EXTERNALSYM gestaltALMAttr}
  gestaltALMPresent             = 0;    (* bit true if ALM is available *)
  {$EXTERNALSYM gestaltALMPresent}
  gestaltALMHasSFGroup          = 1;    (* bit true if Put/Get/Merge Group calls are implmented *)
  {$EXTERNALSYM gestaltALMHasSFGroup}
  gestaltALMHasCFMSupport       = 2;    (* bit true if CFM-based modules are supported *)
  {$EXTERNALSYM gestaltALMHasCFMSupport}
  gestaltALMHasRescanNotifiers  = 3;     (* bit true if Rescan notifications/events will be sent to clients *)
  {$EXTERNALSYM gestaltALMHasRescanNotifiers}



  gestaltALMHasSFLocation       = gestaltALMHasSFGroup;
  {$EXTERNALSYM gestaltALMHasSFLocation}



  gestaltTSMgrVersion           : Integer = Ord('t') shl 24 + Ord('s') shl 16 + Ord('m') shl 8 + Ord('v'); (* 'tsmv' - Text Services Mgr version; if present *)
  {$EXTERNALSYM gestaltTSMgrVersion}
  gestaltTSMgr15                = $0150;
  {$EXTERNALSYM gestaltTSMgr15}
  gestaltTSMgr20                = $0200; (* Version 2.0 as of MacOSX 10.0 *)
  {$EXTERNALSYM gestaltTSMgr20}
  gestaltTSMgr22                = $0220; (* Version 2.2 as of MacOSX 10.3 *)
  {$EXTERNALSYM gestaltTSMgr22}
  gestaltTSMgr23                = $0230; (* Version 2.3 as of MacOSX 10.4 *)
  {$EXTERNALSYM gestaltTSMgr23}



  gestaltTSMgrAttr              : Integer = Ord('t') shl 24 + Ord('s') shl 16 + Ord('m') shl 8 + Ord('a'); (* 'tsma' - Text Services Mgr attributes; if present *)
  {$EXTERNALSYM gestaltTSMgrAttr}
  gestaltTSMDisplayMgrAwareBit  = 0;    (* TSM knows about display manager *)
  {$EXTERNALSYM gestaltTSMDisplayMgrAwareBit}
  gestaltTSMdoesTSMTEBit        = 1;     (* TSM has integrated TSMTE *)
  {$EXTERNALSYM gestaltTSMdoesTSMTEBit}



  gestaltSpeechAttr             : Integer = Ord('t') shl 24 + Ord('t') shl 16 + Ord('s') shl 8 + Ord('c'); (* 'ttsc' - Speech Manager attributes *)
  {$EXTERNALSYM gestaltSpeechAttr}
  gestaltSpeechMgrPresent       = 0;    (* bit set indicates that Speech Manager exists *)
  {$EXTERNALSYM gestaltSpeechMgrPresent}
  gestaltSpeechHasPPCGlue       = 1;     (* bit set indicates that native PPC glue for Speech Manager API exists *)
  {$EXTERNALSYM gestaltSpeechHasPPCGlue}



  gestaltTVAttr                 : Integer = Ord('t') shl 24 + Ord('v') shl 16 + Ord(' ') shl 8 + Ord(' '); (* 'tv  ' - TV version *)
  {$EXTERNALSYM gestaltTVAttr}
  gestaltHasTVTuner             = 0;    (* supports Philips FL1236F video tuner *)
  {$EXTERNALSYM gestaltHasTVTuner}
  gestaltHasSoundFader          = 1;    (* supports Philips TEA6330 Sound Fader chip *)
  {$EXTERNALSYM gestaltHasSoundFader}
  gestaltHasHWClosedCaptioning  = 2;    (* supports Philips SAA5252 Closed Captioning *)
  {$EXTERNALSYM gestaltHasHWClosedCaptioning}
  gestaltHasIRRemote            = 3;    (* supports CyclopsII Infra Red Remote control *)
  {$EXTERNALSYM gestaltHasIRRemote}
  gestaltHasVidDecoderScaler    = 4;    (* supports Philips SAA7194 Video Decoder/Scaler *)
  {$EXTERNALSYM gestaltHasVidDecoderScaler}
  gestaltHasStereoDecoder       = 5;    (* supports Sony SBX1637A-01 stereo decoder *)
  {$EXTERNALSYM gestaltHasStereoDecoder}
  gestaltHasSerialFader         = 6;    (* has fader audio in serial with system audio *)
  {$EXTERNALSYM gestaltHasSerialFader}
  gestaltHasFMTuner             = 7;    (* has FM Tuner from donnybrook card *)
  {$EXTERNALSYM gestaltHasFMTuner}
  gestaltHasSystemIRFunction    = 8;    (* Infra Red button function is set up by system and not by Video Startup *)
  {$EXTERNALSYM gestaltHasSystemIRFunction}
  gestaltIRDisabled             = 9;    (* Infra Red remote is not disabled. *)
  {$EXTERNALSYM gestaltIRDisabled}
  gestaltINeedIRPowerOffConfirm = 10;   (* Need IR power off confirm dialog. *)
  {$EXTERNALSYM gestaltINeedIRPowerOffConfirm}
  gestaltHasZoomedVideo         = 11;    (* Has Zoomed Video PC Card video input. *)
  {$EXTERNALSYM gestaltHasZoomedVideo}




  gestaltATSUVersion            : Integer = Ord('u') shl 24 + Ord('i') shl 16 + Ord('s') shl 8 + Ord('v');  (*  'uisv' *)
  {$EXTERNALSYM gestaltATSUVersion}
  gestaltOriginalATSUVersion    = (1 shl 16); (* ATSUI version 1.0 *)
  {$EXTERNALSYM gestaltOriginalATSUVersion}
  gestaltATSUUpdate1            = (2 shl 16); (* ATSUI version 1.1 *)
  {$EXTERNALSYM gestaltATSUUpdate1}
  gestaltATSUUpdate2            = (3 shl 16); (* ATSUI version 1.2 *)
  {$EXTERNALSYM gestaltATSUUpdate2}
  gestaltATSUUpdate3            = (4 shl 16); (* ATSUI version 2.0 *)
  {$EXTERNALSYM gestaltATSUUpdate3}
  gestaltATSUUpdate4            = (5 shl 16); (* ATSUI version in Mac OS X - SoftwareUpdate 1-4 for Mac OS 10.0.1 - 10.0.4 *)
  {$EXTERNALSYM gestaltATSUUpdate4}
  gestaltATSUUpdate5            = (6 shl 16); (* ATSUI version 2.3 in MacOS 10.1 *)
  {$EXTERNALSYM gestaltATSUUpdate5}
  gestaltATSUUpdate6            = (7 shl 16); (* ATSUI version 2.4 in MacOS 10.2 *)
  {$EXTERNALSYM gestaltATSUUpdate6}
  gestaltATSUUpdate7            = (8 shl 16); (* ATSUI version 2.5 in MacOS 10.3 *)
  {$EXTERNALSYM gestaltATSUUpdate7}



  gestaltATSUFeatures           : Integer = Ord('u') shl 24 + Ord('i') shl 16 + Ord('s') shl 8 + Ord('f');  (*  'uisf' *)
  {$EXTERNALSYM gestaltATSUFeatures}
  gestaltATSUTrackingFeature    = $00000001; (* feature introduced in ATSUI version 1.1 *)
  {$EXTERNALSYM gestaltATSUTrackingFeature}
  gestaltATSUMemoryFeature      = $00000001; (* feature introduced in ATSUI version 1.1 *)
  {$EXTERNALSYM gestaltATSUMemoryFeature}
  gestaltATSUFallbacksFeature   = $00000001; (* feature introduced in ATSUI version 1.1 *)
  {$EXTERNALSYM gestaltATSUFallbacksFeature}
  gestaltATSUGlyphBoundsFeature = $00000001; (* feature introduced in ATSUI version 1.1 *)
  {$EXTERNALSYM gestaltATSUGlyphBoundsFeature}
  gestaltATSULineControlFeature = $00000001; (* feature introduced in ATSUI version 1.1 *)
  {$EXTERNALSYM gestaltATSULineControlFeature}
  gestaltATSULayoutCreateAndCopyFeature = $00000001; (* feature introduced in ATSUI version 1.1 *)
  {$EXTERNALSYM gestaltATSULayoutCreateAndCopyFeature}
  gestaltATSULayoutCacheClearFeature = $00000001; (* feature introduced in ATSUI version 1.1 *)
  {$EXTERNALSYM gestaltATSULayoutCacheClearFeature}
  gestaltATSUTextLocatorUsageFeature = $00000002; (* feature introduced in ATSUI version 1.2 *)
  {$EXTERNALSYM gestaltATSUTextLocatorUsageFeature}
  gestaltATSULowLevelOrigFeatures = $00000004; (* first low-level features introduced in ATSUI version 2.0 *)
  {$EXTERNALSYM gestaltATSULowLevelOrigFeatures}
  gestaltATSUFallbacksObjFeatures = $00000008; (* feature introduced - ATSUFontFallbacks objects introduced in ATSUI version 2.3 *)
  {$EXTERNALSYM gestaltATSUFallbacksObjFeatures}
  gestaltATSUIgnoreLeadingFeature = $00000008; (* feature introduced - kATSLineIgnoreFontLeading LineLayoutOption introduced in ATSUI version 2.3 *)
  {$EXTERNALSYM gestaltATSUIgnoreLeadingFeature}
  gestaltATSUByCharacterClusterFeature = $00000010; (* ATSUCursorMovementTypes introduced in ATSUI version 2.4 *)
  {$EXTERNALSYM gestaltATSUByCharacterClusterFeature}
  gestaltATSUAscentDescentControlsFeature = $00000010; (* attributes introduced in ATSUI version 2.4 *)
  {$EXTERNALSYM gestaltATSUAscentDescentControlsFeature}
  gestaltATSUHighlightInactiveTextFeature = $00000010; (* feature introduced in ATSUI version 2.4 *)
  {$EXTERNALSYM gestaltATSUHighlightInactiveTextFeature}
  gestaltATSUPositionToCursorFeature = $00000010; (* features introduced in ATSUI version 2.4 *)
  {$EXTERNALSYM gestaltATSUPositionToCursorFeature}
  gestaltATSUBatchBreakLinesFeature = $00000010; (* feature introduced in ATSUI version 2.4 *)
  {$EXTERNALSYM gestaltATSUBatchBreakLinesFeature}
  gestaltATSUTabSupportFeature  = $00000010; (* features introduced in ATSUI version 2.4 *)
  {$EXTERNALSYM gestaltATSUTabSupportFeature}
  gestaltATSUDirectAccess       = $00000010; (* features introduced in ATSUI version 2.4 *)
  {$EXTERNALSYM gestaltATSUDirectAccess}
  gestaltATSUDecimalTabFeature  = $00000020; (* feature introduced in ATSUI version 2.5 *)
  {$EXTERNALSYM gestaltATSUDecimalTabFeature}
  gestaltATSUBiDiCursorPositionFeature = $00000020; (* feature introduced in ATSUI version 2.5 *)
  {$EXTERNALSYM gestaltATSUBiDiCursorPositionFeature}
  gestaltATSUNearestCharLineBreakFeature = $00000020; (* feature introduced in ATSUI version 2.5 *)
  {$EXTERNALSYM gestaltATSUNearestCharLineBreakFeature}
  gestaltATSUHighlightColorControlFeature = $00000020; (* feature introduced in ATSUI version 2.5 *)
  {$EXTERNALSYM gestaltATSUHighlightColorControlFeature}
  gestaltATSUUnderlineOptionsStyleFeature = $00000020; (* feature introduced in ATSUI version 2.5 *)
  {$EXTERNALSYM gestaltATSUUnderlineOptionsStyleFeature}
  gestaltATSUStrikeThroughStyleFeature = $00000020; (* feature introduced in ATSUI version 2.5 *)
  {$EXTERNALSYM gestaltATSUStrikeThroughStyleFeature}
  gestaltATSUDropShadowStyleFeature = $00000020; (* feature introduced in ATSUI version 2.5 *)
  {$EXTERNALSYM gestaltATSUDropShadowStyleFeature}



  gestaltUSBAttr                : Integer = Ord('u') shl 24 + Ord('s') shl 16 + Ord('b') shl 8 + Ord(' '); (* 'usb ' - USB Attributes *)
  {$EXTERNALSYM gestaltUSBAttr}
  gestaltUSBPresent             = 0;    (* USB Support available *)
  {$EXTERNALSYM gestaltUSBPresent}
  gestaltUSBHasIsoch            = 1;     (* USB Isochronous features available *)
  {$EXTERNALSYM gestaltUSBHasIsoch}



  gestaltUSBVersion             : Integer = Ord('u') shl 24 + Ord('s') shl 16 + Ord('b') shl 8 + Ord('v'); (* 'usbv' - USB version *)
  {$EXTERNALSYM gestaltUSBVersion}



  gestaltVersion                : Integer = Ord('v') shl 24 + Ord('e') shl 16 + Ord('r') shl 8 + Ord('s'); (* 'vers' - gestalt version *)
  {$EXTERNALSYM gestaltVersion}
  gestaltValueImplementedVers   = 5;     (* version of gestalt where gestaltValue is implemented. *)
  {$EXTERNALSYM gestaltValueImplementedVers}



  gestaltVIA1Addr               : Integer = Ord('v') shl 24 + Ord('i') shl 16 + Ord('a') shl 8 + Ord('1'); (* 'via1' - via 1 base address  *)
  {$EXTERNALSYM gestaltVIA1Addr}



  gestaltVIA2Addr               : Integer = Ord('v') shl 24 + Ord('i') shl 16 + Ord('a') shl 8 + Ord('2'); (* 'via2' - via 2 base address  *)
  {$EXTERNALSYM gestaltVIA2Addr}



  gestaltVMAttr                 : Integer = Ord('v') shl 24 + Ord('m') shl 16 + Ord(' ') shl 8 + Ord(' '); (* 'vm  ' - virtual memory attributes *)
  {$EXTERNALSYM gestaltVMAttr}
  gestaltVMPresent              = 0;    (* true if virtual memory is present *)
  {$EXTERNALSYM gestaltVMPresent}
  gestaltVMHasLockMemoryForOutput = 1;  (* true if LockMemoryForOutput is available *)
  {$EXTERNALSYM gestaltVMHasLockMemoryForOutput}
  gestaltVMFilemappingOn        = 3;    (* true if filemapping is available *)
  {$EXTERNALSYM gestaltVMFilemappingOn}
  gestaltVMHasPagingControl     = 4;     (* true if MakeMemoryResident; MakeMemoryNonResident; FlushMemory; and ReleaseMemoryData are available *)
  {$EXTERNALSYM gestaltVMHasPagingControl}



  gestaltVMInfoType             : Integer = Ord('v') shl 24 + Ord('m') shl 16 + Ord('i') shl 8 + Ord('n'); (* 'vmin' - Indicates how the Finder should display information about VM in *)
  {$EXTERNALSYM gestaltVMInfoType}
                                        (* the Finder about box. *)
  gestaltVMInfoSizeStorageType  = 0;    (* Display VM on/off; backing store size and name *)
  {$EXTERNALSYM gestaltVMInfoSizeStorageType}
  gestaltVMInfoSizeType         = 1;    (* Display whether VM is on or off and the size of the backing store *)
  {$EXTERNALSYM gestaltVMInfoSizeType}
  gestaltVMInfoSimpleType       = 2;    (* Display whether VM is on or off *)
  {$EXTERNALSYM gestaltVMInfoSimpleType}
  gestaltVMInfoNoneType         = 3;     (* Display no VM information *)
  {$EXTERNALSYM gestaltVMInfoNoneType}



  gestaltVMBackingStoreFileRefNum : Integer = Ord('v') shl 24 + Ord('m') shl 16 + Ord('b') shl 8 + Ord('s'); (* 'vmbs' - file refNum of virtual memory's main backing store file (returned in low word of result) *)
  {$EXTERNALSYM gestaltVMBackingStoreFileRefNum}





  gestaltALMVers                : Integer = Ord('w') shl 24 + Ord('a') shl 16 + Ord('l') shl 8 + Ord('k'); (* 'walk' - Settings Manager version (see also gestaltALMAttr) *)
  {$EXTERNALSYM gestaltALMVers}



  gestaltWindowMgrAttr          : Integer = Ord('w') shl 24 + Ord('i') shl 16 + Ord('n') shl 8 + Ord('d'); (* 'wind' - If this Gestalt exists; the Mac OS 8.5 Window Manager is installed*)
  {$EXTERNALSYM gestaltWindowMgrAttr}
  gestaltWindowMgrPresent       = (1 shl 0); (* NOTE: this is a bit mask; whereas all other Gestalt constants of*)
  {$EXTERNALSYM gestaltWindowMgrPresent}
                                        (* this type are bit index values.   Universal Interfaces 3.2 slipped*)
                                        (* out the door with this mistake.*)
  gestaltWindowMgrPresentBit    = 0;    (* bit number*)
  {$EXTERNALSYM gestaltWindowMgrPresentBit}
  gestaltExtendedWindowAttributes = 1;  (* Has ChangeWindowAttributes; GetWindowAttributes works for all windows*)
  {$EXTERNALSYM gestaltExtendedWindowAttributes}
  gestaltExtendedWindowAttributesBit = 1; (* Has ChangeWindowAttributes; GetWindowAttributes works for all windows*)
  {$EXTERNALSYM gestaltExtendedWindowAttributesBit}
  gestaltHasFloatingWindows     = 2;    (* Floating window APIs work*)
  {$EXTERNALSYM gestaltHasFloatingWindows}
  gestaltHasFloatingWindowsBit  = 2;    (* Floating window APIs work*)
  {$EXTERNALSYM gestaltHasFloatingWindowsBit}
  gestaltHasWindowBuffering     = 3;    (* This system has buffering available*)
  {$EXTERNALSYM gestaltHasWindowBuffering}
  gestaltHasWindowBufferingBit  = 3;    (* This system has buffering available*)
  {$EXTERNALSYM gestaltHasWindowBufferingBit}
  gestaltWindowLiveResizeBit    = 4;    (* live resizing of windows is available*)
  {$EXTERNALSYM gestaltWindowLiveResizeBit}
  gestaltWindowMinimizeToDockBit = 5;   (* windows minimize to the dock and do not windowshade (Mac OS X)*)
  {$EXTERNALSYM gestaltWindowMinimizeToDockBit}
  gestaltHasWindowShadowsBit    = 6;    (* windows have shadows*)
  {$EXTERNALSYM gestaltHasWindowShadowsBit}
  gestaltSheetsAreWindowModalBit = 7;   (* sheet windows are modal only to their parent window*)
  {$EXTERNALSYM gestaltSheetsAreWindowModalBit}
  gestaltFrontWindowMayBeHiddenBit = 8; (* FrontWindow and related APIs will return the front window even when the app is hidden*)
  {$EXTERNALSYM gestaltFrontWindowMayBeHiddenBit}
                                        (* masks for the above bits*)
  gestaltWindowMgrPresentMask   = (1 shl gestaltWindowMgrPresentBit);
  {$EXTERNALSYM gestaltWindowMgrPresentMask}
  gestaltExtendedWindowAttributesMask = (1 shl gestaltExtendedWindowAttributesBit);
  {$EXTERNALSYM gestaltExtendedWindowAttributesMask}
  gestaltHasFloatingWindowsMask = (1 shl gestaltHasFloatingWindowsBit);
  {$EXTERNALSYM gestaltHasFloatingWindowsMask}
  gestaltHasWindowBufferingMask = (1 shl gestaltHasWindowBufferingBit);
  {$EXTERNALSYM gestaltHasWindowBufferingMask}
  gestaltWindowLiveResizeMask   = (1 shl gestaltWindowLiveResizeBit);
  {$EXTERNALSYM gestaltWindowLiveResizeMask}
  gestaltWindowMinimizeToDockMask = (1 shl gestaltWindowMinimizeToDockBit);
  {$EXTERNALSYM gestaltWindowMinimizeToDockMask}
  gestaltHasWindowShadowsMask   = (1 shl gestaltHasWindowShadowsBit);
  {$EXTERNALSYM gestaltHasWindowShadowsMask}
  gestaltSheetsAreWindowModalMask = (1 shl gestaltSheetsAreWindowModalBit);
  {$EXTERNALSYM gestaltSheetsAreWindowModalMask}
  gestaltFrontWindowMayBeHiddenMask = (1 shl gestaltFrontWindowMayBeHiddenBit);
  {$EXTERNALSYM gestaltFrontWindowMayBeHiddenMask}



  gestaltHasSingleWindowModeBit = 8;    (* This system supports single window mode*)
  {$EXTERNALSYM gestaltHasSingleWindowModeBit}
  gestaltHasSingleWindowModeMask = (1 shl gestaltHasSingleWindowModeBit);
  {$EXTERNALSYM gestaltHasSingleWindowModeMask}



(* gestaltX86Features is a convenience for 'cpuid'; instruction.  Note
   that even though the processor may support a specific feature; the
   OS may not support all of these features.  These bitfields
   correspond directly to the bits returned by cpuid *)

  gestaltX86Features            : Integer = Ord('x') shl 24 + Ord('8') shl 16 + Ord('6') shl 8 + Ord('f');  (*  'x86f' *)
  {$EXTERNALSYM gestaltX86Features}
  gestaltX86HasFPU              = 0;    (* has an FPU that supports the 387 instructions*)
  {$EXTERNALSYM gestaltX86HasFPU}
  gestaltX86HasVME              = 1;    (* supports Virtual-8086 Mode Extensions*)
  {$EXTERNALSYM gestaltX86HasVME}
  gestaltX86HasDE               = 2;    (* supports I/O breakpoints (Debug Extensions)*)
  {$EXTERNALSYM gestaltX86HasDE}
  gestaltX86HasPSE              = 3;    (* supports 4-Mbyte pages (Page Size Extension)*)
  {$EXTERNALSYM gestaltX86HasPSE}
  gestaltX86HasTSC              = 4;    (* supports RTDSC instruction (Time Stamp Counter)*)
  {$EXTERNALSYM gestaltX86HasTSC}
  gestaltX86HasMSR              = 5;    (* supports Model Specific Registers*)
  {$EXTERNALSYM gestaltX86HasMSR}
  gestaltX86HasPAE              = 6;    (* supports physical addresses > 32 bits (Physical Address Extension)*)
  {$EXTERNALSYM gestaltX86HasPAE}
  gestaltX86HasMCE              = 7;    (* supports Machine Check Exception*)
  {$EXTERNALSYM gestaltX86HasMCE}
  gestaltX86HasCX8              = 8;    (* supports CMPXCHG8 instructions (Compare Exchange 8 bytes)*)
  {$EXTERNALSYM gestaltX86HasCX8}
  gestaltX86HasAPIC             = 9;    (* contains local APIC*)
  {$EXTERNALSYM gestaltX86HasAPIC}
  gestaltX86HasSEP              = 11;   (* supports fast system call (SysEnter Present)*)
  {$EXTERNALSYM gestaltX86HasSEP}
  gestaltX86HasMTRR             = 12;   (* supports Memory Type Range Registers*)
  {$EXTERNALSYM gestaltX86HasMTRR}
  gestaltX86HasPGE              = 13;   (* supports Page Global Enable*)
  {$EXTERNALSYM gestaltX86HasPGE}
  gestaltX86HasMCA              = 14;   (* supports Machine Check Architecture*)
  {$EXTERNALSYM gestaltX86HasMCA}
  gestaltX86HasCMOV             = 15;   (* supports CMOVcc instruction (Conditional Move).*)
  {$EXTERNALSYM gestaltX86HasCMOV}
                                        (* If FPU bit is also set; supports FCMOVcc and FCOMI; too*)
  gestaltX86HasPAT              = 16;   (* supports Page Attribute Table*)
  {$EXTERNALSYM gestaltX86HasPAT}
  gestaltX86HasPSE36            = 17;   (* supports 36-bit Page Size Extension*)
  {$EXTERNALSYM gestaltX86HasPSE36}
  gestaltX86HasPSN              = 18;   (* Processor Serial Number*)
  {$EXTERNALSYM gestaltX86HasPSN}
  gestaltX86HasCLFSH            = 19;   (* CLFLUSH Instruction supported*)
  {$EXTERNALSYM gestaltX86HasCLFSH}
  gestaltX86Serviced20          = 20;   (* do not count on this bit value*)
  {$EXTERNALSYM gestaltX86Serviced20}
  gestaltX86HasDS               = 21;   (* Debug Store*)
  {$EXTERNALSYM gestaltX86HasDS}
  gestaltX86ResACPI             = 22;   (* Thermal Monitor; SW-controlled clock*)
  {$EXTERNALSYM gestaltX86ResACPI}
  gestaltX86HasMMX              = 23;   (* supports MMX instructions*)
  {$EXTERNALSYM gestaltX86HasMMX}
  gestaltX86HasFXSR             = 24;   (* Supports FXSAVE and FXRSTOR instructions (fast FP save/restore)*)
  {$EXTERNALSYM gestaltX86HasFXSR}
  gestaltX86HasSSE              = 25;   (* Streaming SIMD extensions*)
  {$EXTERNALSYM gestaltX86HasSSE}
  gestaltX86HasSSE2             = 26;   (* Streaming SIMD extensions 2*)
  {$EXTERNALSYM gestaltX86HasSSE2}
  gestaltX86HasSS               = 27;   (* Self-Snoop*)
  {$EXTERNALSYM gestaltX86HasSS}
  gestaltX86HasHTT              = 28;   (* Hyper-Threading Technology*)
  {$EXTERNALSYM gestaltX86HasHTT}
  gestaltX86HasTM               = 29;    (* Thermal Monitor*)
  {$EXTERNALSYM gestaltX86HasTM}


(* 'cpuid'; now returns a 64 bit value; and the following
    gestalt selector and field definitions apply
    to the extended form of this instruction *)

  gestaltX86AdditionalFeatures  : Integer = Ord('x') shl 24 + Ord('8') shl 16 + Ord('6') shl 8 + Ord('a');  (*  'x86a' *)
  {$EXTERNALSYM gestaltX86AdditionalFeatures}
  gestaltX86HasSSE3             = 0;    (* Prescott New Inst.*)
  {$EXTERNALSYM gestaltX86HasSSE3}
  gestaltX86HasMONITOR          = 3;    (* Monitor/mwait*)
  {$EXTERNALSYM gestaltX86HasMONITOR}
  gestaltX86HasDSCPL            = 4;    (* Debug Store CPL*)
  {$EXTERNALSYM gestaltX86HasDSCPL}
  gestaltX86HasVMX              = 5;    (* VMX*)
  {$EXTERNALSYM gestaltX86HasVMX}
  gestaltX86HasSMX              = 6;    (* SMX*)
  {$EXTERNALSYM gestaltX86HasSMX}
  gestaltX86HasEST              = 7;    (* Enhanced SpeedsTep (GV3)*)
  {$EXTERNALSYM gestaltX86HasEST}
  gestaltX86HasTM2              = 8;    (* Thermal Monitor 2*)
  {$EXTERNALSYM gestaltX86HasTM2}
  gestaltX86HasSupplementalSSE3 = 9;    (* Supplemental SSE3 instructions*)
  {$EXTERNALSYM gestaltX86HasSupplementalSSE3}
  gestaltX86HasCID              = 10;   (* L1 Context ID*)
  {$EXTERNALSYM gestaltX86HasCID}
  gestaltX86HasCX16             = 13;   (* CmpXchg16b instruction*)
  {$EXTERNALSYM gestaltX86HasCX16}
  gestaltX86HasxTPR             = 14;    (* Send Task PRiority msgs*)
  {$EXTERNALSYM gestaltX86HasxTPR}



  gestaltTranslationAttr        : Integer = Ord('x') shl 24 + Ord('l') shl 16 + Ord('a') shl 8 + Ord('t'); (* 'xlat' - Translation Manager attributes *)
  {$EXTERNALSYM gestaltTranslationAttr}
  gestaltTranslationMgrExists   = 0;    (* True if translation manager exists *)
  {$EXTERNALSYM gestaltTranslationMgrExists}
  gestaltTranslationMgrHintOrder = 1;   (* True if hint order reversal in effect *)
  {$EXTERNALSYM gestaltTranslationMgrHintOrder}
  gestaltTranslationPPCAvail    = 2;
  {$EXTERNALSYM gestaltTranslationPPCAvail}
  gestaltTranslationGetPathAPIAvail = 3;
  {$EXTERNALSYM gestaltTranslationGetPathAPIAvail}



  gestaltExtToolboxTable        : Integer = Ord('x') shl 24 + Ord('t') shl 16 + Ord('t') shl 8 + Ord('t'); (* 'xttt' - Extended Toolbox trap table base *)
  {$EXTERNALSYM gestaltExtToolboxTable}



  gestaltUSBPrinterSharingVersion : Integer = Ord('z') shl 24 + Ord('a') shl 16 + Ord('k') shl 8 + Ord(' '); (* 'zak ' - USB Printer Sharing Version*)
  {$EXTERNALSYM gestaltUSBPrinterSharingVersion}
  gestaltUSBPrinterSharingVersionMask = $0000FFFF; (* mask for bits in version*)
  {$EXTERNALSYM gestaltUSBPrinterSharingVersionMask}
  gestaltUSBPrinterSharingAttr  : Integer = Ord('z') shl 24 + Ord('a') shl 16 + Ord('k') shl 8 + Ord(' '); (* 'zak ' - USB Printer Sharing Attributes*)
  {$EXTERNALSYM gestaltUSBPrinterSharingAttr}
  gestaltUSBPrinterSharingAttrMask = $FFFF0000; (*  mask for attribute bits*)
  {$EXTERNALSYM gestaltUSBPrinterSharingAttrMask}
  gestaltUSBPrinterSharingAttrRunning = $80000000; (* printer sharing is running*)
  {$EXTERNALSYM gestaltUSBPrinterSharingAttrRunning}
  gestaltUSBPrinterSharingAttrBooted = $40000000; (* printer sharing was installed at boot time*)
  {$EXTERNALSYM gestaltUSBPrinterSharingAttrBooted}


(*WorldScript settings;*)

  gestaltWorldScriptIIVersion   : Integer = Ord('d') shl 24 + Ord('o') shl 16 + Ord('u') shl 8 + Ord('b');  (*  'doub' *)
  {$EXTERNALSYM gestaltWorldScriptIIVersion}
  gestaltWorldScriptIIAttr      : Integer = Ord('w') shl 24 + Ord('s') shl 16 + Ord('a') shl 8 + Ord('t');  (* 'wsat' *)
  {$EXTERNALSYM gestaltWorldScriptIIAttr}
  gestaltWSIICanPrintWithoutPrGeneralBit = 0; (* bit 0 is on if WS II knows about PrinterStatus callback *)
  {$EXTERNALSYM gestaltWSIICanPrintWithoutPrGeneralBit}
