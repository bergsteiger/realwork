{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFUserNotification.h                   }
{          Copyright (c) 2000-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IFNDEF __COREFOUNDATION_CFUSERNOTIFICATION__}

{$DEFINE __COREFOUNDATION_CFUSERNOTIFICATION__}

{$I CFBase.inc}
{$I CFDate.inc}
{$I CFDictionary.inc}
{$I CFRunLoop.inc}
{$I CFString.inc}
{$I CFURL.inc}

type
  PCFUserNotificationRef = ^CFUserNotificationRef;
  CFUserNotificationRef = ^__CFUserNotification;
  {$EXTERNALSYM CFUserNotificationRef}
  __CFUserNotification = record
  end;
  {$EXTERNALSYM __CFUserNotification}

{ A CFUserNotification is a notification intended to be presented to a 
user at the console (if one is present).  This is for the use of processes
that do not otherwise have user interfaces, but may need occasional
interaction with a user.  There is a parallel API for this functionality
at the System framework level, described in UNCUserNotification.h.

The contents of the notification can include a header, a message, textfields,
a popup button, radio buttons or checkboxes, a progress indicator, and up to
three ordinary buttons.  All of these items are optional, but a default
button will be supplied even if not specified unless the
kCFUserNotificationNoDefaultButtonFlag is set.

The contents of the notification are specified in the dictionary used to
create the notification, whose keys should be taken from the list of constants
below, and whose values should be either strings or arrays of strings
(except for kCFUserNotificationProgressIndicatorValueKey, in which case the
value should be a number between 0 and 1, for a "definite" progress indicator,
or a boolean, for an "indefinite" progress indicator).  Additionally, URLs can
optionally be supplied for an icon, a sound, and a bundle whose Localizable.strings
files will be used to localize strings.
    
Certain request flags are specified when a notification is created.
These specify an alert level for the notification, determine whether
radio buttons or check boxes are to be used, specify which if any of these
are checked by default, specify whether any of the textfields are to
be secure textfields, and determine which popup item should be selected
by default.  A timeout is also specified, which determines how long the
notification should be supplied to the user (if zero, it will not timeout).
    
A CFUserNotification is dispatched for presentation when it is created.
If any reply is required, it may be awaited in one of two ways:  either
synchronously, using CFUserNotificationReceiveResponse, or asynchronously,
using a run loop source.  CFUserNotificationReceiveResponse has a timeout
parameter that determines how long it will block (zero meaning indefinitely)
and it may be called as many times as necessary until a response arrives.
If a notification has not yet received a response, it may be updated with
new information, or it may be cancelled.  Notifications may not be reused.
    
When a response arrives, it carries with it response flags that describe
which button was used to dismiss the notification, which checkboxes or
radio buttons were checked, and what the selection of the popup was.
It also carries a response dictionary, which describes the contents
of the textfields.  }

  CFUserNotificationCallBack = procedure(
    userNotification: CFUserNotificationRef;
    responseFlags: CFOptionFlags); cdecl;
  {$EXTERNALSYM CFUserNotificationCallBack}

function CFUserNotificationGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFUserNotificationGetTypeID';
{$EXTERNALSYM CFUserNotificationGetTypeID}

function CFUserNotificationCreate(allocator: CFAllocatorRef; 
  timeout: CFTimeInterval; flags: CFOptionFlags; out error: SInt32;
  dictionary: CFDictionaryRef): CFUserNotificationRef; cdecl;
  external CoreFoundationLib name _PU + 'CFUserNotificationCreate';
{$EXTERNALSYM CFUserNotificationCreate}

function CFUserNotificationReceiveResponse(
  userNotification: CFUserNotificationRef; timeout: CFTimeInterval; 
  out responseFlags: CFOptionFlags): SInt32; cdecl;
  external CoreFoundationLib name _PU + 'CFUserNotificationReceiveResponse';
{$EXTERNALSYM CFUserNotificationReceiveResponse}

function CFUserNotificationGetResponseValue(
  userNotification: CFUserNotificationRef; key: CFStringRef;
  idx: CFIndex): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFUserNotificationGetResponseValue';
{$EXTERNALSYM CFUserNotificationGetResponseValue}

function CFUserNotificationGetResponseDictionary(
  userNotification: CFUserNotificationRef): CFDictionaryRef; cdecl;
  external CoreFoundationLib name _PU + 'CFUserNotificationGetResponseDictionary';
{$EXTERNALSYM CFUserNotificationGetResponseDictionary}

function CFUserNotificationUpdate(userNotification: CFUserNotificationRef;
  timeout: CFTimeInterval; flags: CFOptionFlags;
  dictionary: CFDictionaryRef): SInt32; cdecl;
  external CoreFoundationLib name _PU + 'CFUserNotificationUpdate';
{$EXTERNALSYM CFUserNotificationUpdate}

function CFUserNotificationCancel(
  userNotification: CFUserNotificationRef): SInt32; cdecl;
  external CoreFoundationLib name _PU + 'CFUserNotificationCancel';
{$EXTERNALSYM CFUserNotificationCancel}

function CFUserNotificationCreateRunLoopSource(allocator: CFAllocatorRef;
  userNotification: CFUserNotificationRef; callout: CFUserNotificationCallBack;
  order: CFIndex): CFRunLoopSourceRef; cdecl;
  external CoreFoundationLib name _PU + 'CFUserNotificationCreateRunLoopSource';
{$EXTERNALSYM CFUserNotificationCreateRunLoopSource}

{ Convenience functions for handling the simplest and most common cases:  
a one-way notification, and a notification with up to three buttons. }

function CFUserNotificationDisplayNotice(timeout: CFTimeInterval;
  flags: CFOptionFlags; iconURL: CFURLRef; soundURL: CFURLRef;
  localizationURL: CFURLRef; alertHeader: CFStringRef;
  alertMessage: CFStringRef; defaultButtonTitle: CFStringRef): SInt32; cdecl;
  external CoreFoundationLib name _PU + 'CFUserNotificationDisplayNotice';
{$EXTERNALSYM CFUserNotificationDisplayNotice}

function CFUserNotificationDisplayAlert(timeout: CFTimeInterval; 
  flags: CFOptionFlags; iconURL: CFURLRef; soundURL: CFURLRef; 
  localizationURL: CFURLRef; alertHeader: CFStringRef; 
  alertMessage: CFStringRef; defaultButtonTitle: CFStringRef; 
  alternateButtonTitle: CFStringRef; otherButtonTitle: CFStringRef; 
  out responseFlags: CFOptionFlags): SInt32; cdecl;
  external CoreFoundationLib name _PU + 'CFUserNotificationDisplayAlert';
{$EXTERNALSYM CFUserNotificationDisplayAlert}


{ Flags }

const
  kCFUserNotificationStopAlertLevel    = 0;
  {$EXTERNALSYM kCFUserNotificationStopAlertLevel}
  kCFUserNotificationNoteAlertLevel    = 1;
  {$EXTERNALSYM kCFUserNotificationNoteAlertLevel}
  kCFUserNotificationCautionAlertLevel = 2;
  {$EXTERNALSYM kCFUserNotificationCautionAlertLevel}
  kCFUserNotificationPlainAlertLevel   = 3;
  {$EXTERNALSYM kCFUserNotificationPlainAlertLevel}

const
  kCFUserNotificationDefaultResponse   = 0;
  {$EXTERNALSYM kCFUserNotificationDefaultResponse}
  kCFUserNotificationAlternateResponse = 1;
  {$EXTERNALSYM kCFUserNotificationAlternateResponse}
  kCFUserNotificationOtherResponse     = 2;
  {$EXTERNALSYM kCFUserNotificationOtherResponse}
  kCFUserNotificationCancelResponse    = 3;
  {$EXTERNALSYM kCFUserNotificationCancelResponse}

const
  kCFUserNotificationNoDefaultButtonFlag = 1 shl 5;
  {$EXTERNALSYM kCFUserNotificationNoDefaultButtonFlag}
  kCFUserNotificationUseRadioButtonsFlag = 1 shl 6;
  {$EXTERNALSYM kCFUserNotificationUseRadioButtonsFlag}

function CFUserNotificationCheckBoxChecked(i: CFIndex): CFOptionFlags; inline;
{$EXTERNALSYM CFUserNotificationCheckBoxChecked}
function CFUserNotificationSecureTextField(i: CFIndex): CFOptionFlags; inline;
{$EXTERNALSYM CFUserNotificationSecureTextField}
function CFUserNotificationPopUpSelection(n: CFIndex): CFOptionFlags; inline;
{$EXTERNALSYM CFUserNotificationPopUpSelection}


{ Keys }

function kCFUserNotificationIconURLKey: CFStringRef;
{$EXTERNALSYM kCFUserNotificationIconURLKey}

function kCFUserNotificationSoundURLKey: CFStringRef;
{$EXTERNALSYM kCFUserNotificationSoundURLKey}

function kCFUserNotificationLocalizationURLKey: CFStringRef;
{$EXTERNALSYM kCFUserNotificationLocalizationURLKey}

function kCFUserNotificationAlertHeaderKey: CFStringRef;
{$EXTERNALSYM kCFUserNotificationAlertHeaderKey}

function kCFUserNotificationAlertMessageKey: CFStringRef;
{$EXTERNALSYM kCFUserNotificationAlertMessageKey}

function kCFUserNotificationDefaultButtonTitleKey: CFStringRef;
{$EXTERNALSYM kCFUserNotificationDefaultButtonTitleKey}

function kCFUserNotificationAlternateButtonTitleKey: CFStringRef;
{$EXTERNALSYM kCFUserNotificationAlternateButtonTitleKey}

function kCFUserNotificationOtherButtonTitleKey: CFStringRef;
{$EXTERNALSYM kCFUserNotificationOtherButtonTitleKey}

function kCFUserNotificationProgressIndicatorValueKey: CFStringRef;
{$EXTERNALSYM kCFUserNotificationProgressIndicatorValueKey}

function kCFUserNotificationPopUpTitlesKey: CFStringRef;
{$EXTERNALSYM kCFUserNotificationPopUpTitlesKey}

function kCFUserNotificationTextFieldTitlesKey: CFStringRef;
{$EXTERNALSYM kCFUserNotificationTextFieldTitlesKey}

function kCFUserNotificationCheckBoxTitlesKey: CFStringRef;
{$EXTERNALSYM kCFUserNotificationCheckBoxTitlesKey}

function kCFUserNotificationTextFieldValuesKey: CFStringRef;
{$EXTERNALSYM kCFUserNotificationTextFieldValuesKey}

function kCFUserNotificationPopUpSelectionKey: CFStringRef;
{$EXTERNALSYM kCFUserNotificationPopUpSelectionKey}

(*
{$IF DEFINED(TARGET_OS_EMBEDDED) OR DEFINED(TARGET_OS_IPHONE)}
function kCFUserNotificationAlertTopMostKey: CFStringRef;
{$EXTERNALSYM kCFUserNotificationAlertTopMostKey}

function kCFUserNotificationKeyboardTypesKey: CFStringRef;
{$EXTERNALSYM kCFUserNotificationKeyboardTypesKey}
{$ENDIF}
*)

{$ENDIF !__COREFOUNDATION_CFUSERNOTIFICATION__}

