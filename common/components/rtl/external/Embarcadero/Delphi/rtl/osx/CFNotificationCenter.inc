{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFNotificationCenter.h                 }
{          Copyright (c) 1998-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IFNDEF __COREFOUNDATION_CFNOTIFICATIONCENTER__}

{$DEFINE __COREFOUNDATION_CFNOTIFICATIONCENTER__}

{$I CFBase.inc}
{$I CFDictionary.inc}

type
  PCFNotificationCenterRef = ^CFNotificationCenterRef;
  CFNotificationCenterRef = ^__CFNotificationCenter;
  {$EXTERNALSYM CFNotificationCenterRef}
  __CFNotificationCenter = record
  end;
  {$EXTERNALSYM __CFNotificationCenter}

  CFNotificationCallback = procedure(center: CFNotificationCenterRef; 
    observer: Pointer; name: CFStringRef; &object: Pointer;
    userInfo: CFDictionaryRef); cdecl;
  {$EXTERNALSYM CFNotificationCallback}

const
  CFNotificationSuspensionBehaviorDrop               = 1;
  {$EXTERNALSYM CFNotificationSuspensionBehaviorDrop}
        // The server will not queue any notifications with this name and object while the process/app is in the background.
  CFNotificationSuspensionBehaviorCoalesce           = 2;
  {$EXTERNALSYM CFNotificationSuspensionBehaviorCoalesce}
        // The server will only queue the last notification of the specified name and object; earlier notifications are dropped.
  CFNotificationSuspensionBehaviorHold               = 3;
  {$EXTERNALSYM CFNotificationSuspensionBehaviorHold}
        // The server will hold all matching notifications until the queue has been filled (queue size determined by the server) at which point the server may flush queued notifications.
  CFNotificationSuspensionBehaviorDeliverImmediately = 4;
  {$EXTERNALSYM CFNotificationSuspensionBehaviorDeliverImmediately}
        // The server will deliver notifications matching this registration whether or not the process is in the background.  When a notification with this suspension behavior is matched, it has the effect of first flushing any queued notifications.
type
  CFNotificationSuspensionBehavior = CFIndex;
  {$EXTERNALSYM CFNotificationSuspensionBehavior}

function CFNotificationCenterGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFNotificationCenterGetTypeID';
{$EXTERNALSYM CFNotificationCenterGetTypeID}

function CFNotificationCenterGetLocalCenter: CFNotificationCenterRef; cdecl;
  external CoreFoundationLib name _PU + 'CFNotificationCenterGetLocalCenter';
{$EXTERNALSYM CFNotificationCenterGetLocalCenter}

(* H2PAS - IF Expression: (TARGET_OS_MAC && !(TARGET_OS_EMBEDDED || TARGET_OS_IPHONE)) || TARGET_OS_WIN32 *)
{$IFDEF EXPRESSION_1}
function CFNotificationCenterGetDistributedCenter: CFNotificationCenterRef; cdecl;
  external CoreFoundationLib name _PU + 'CFNotificationCenterGetDistributedCenter';
{$EXTERNALSYM CFNotificationCenterGetDistributedCenter}
{$endif}

function CFNotificationCenterGetDarwinNotifyCenter: CFNotificationCenterRef; cdecl;
  external CoreFoundationLib name _PU + 'CFNotificationCenterGetDarwinNotifyCenter';
{$EXTERNALSYM CFNotificationCenterGetDarwinNotifyCenter}
// The Darwin Notify Center is based on the <notify.h> API.
// For this center, there are limitations in the API. There are no notification "objects",
// "userInfo" cannot be passed in the notification, and there are no suspension behaviors
// (always "deliver immediately"). Other limitations in the <notify.h> API as described in
// that header will also apply.
// - In the CFNotificationCallback, the 'object' and 'userInfo' parameters must be ignored.
// - CFNotificationCenterAddObserver(): the 'object' and 'suspensionBehavior' arguments are ignored.
// - CFNotificationCenterAddObserver(): the 'name' argument may not be NULL (for this center).
// - CFNotificationCenterRemoveObserver(): the 'object' argument is ignored.
// - CFNotificationCenterPostNotification(): the 'object', 'userInfo', and 'deliverImmediately' arguments are ignored.
// - CFNotificationCenterPostNotificationWithOptions(): the 'object', 'userInfo', and 'options' arguments are ignored.
// The Darwin Notify Center has no notion of per-user sessions, all notifications are system-wide.
// As with distributed notifications, the main thread's run loop must be running in one of the
// common modes (usually kCFRunLoopDefaultMode) for Darwin-style notifications to be delivered.
// NOTE: NULL or 0 should be passed for all ignored arguments to ensure future compatibility.


procedure CFNotificationCenterAddObserver(center: CFNotificationCenterRef; 
  observer: Pointer; callBack: CFNotificationCallback; name: CFStringRef; 
  &object: Pointer; suspensionBehavior: CFNotificationSuspensionBehavior); cdecl;
  external CoreFoundationLib name _PU + 'CFNotificationCenterAddObserver';
{$EXTERNALSYM CFNotificationCenterAddObserver}

procedure CFNotificationCenterRemoveObserver(center: CFNotificationCenterRef; 
  observer: Pointer; name: CFStringRef; &object: Pointer); cdecl;
  external CoreFoundationLib name _PU + 'CFNotificationCenterRemoveObserver';
{$EXTERNALSYM CFNotificationCenterRemoveObserver}
procedure CFNotificationCenterRemoveEveryObserver(
  center: CFNotificationCenterRef; observer: Pointer); cdecl;
  external CoreFoundationLib name _PU + 'CFNotificationCenterRemoveEveryObserver';
{$EXTERNALSYM CFNotificationCenterRemoveEveryObserver}

procedure CFNotificationCenterPostNotification(center: CFNotificationCenterRef; 
  name: CFStringRef; &object: Pointer; userInfo: CFDictionaryRef;
  deliverImmediately: Boolean); cdecl;
  external CoreFoundationLib name _PU + 'CFNotificationCenterPostNotification';
{$EXTERNALSYM CFNotificationCenterPostNotification}

const
  kCFNotificationDeliverImmediately = 1 shl 0;
  {$EXTERNALSYM kCFNotificationDeliverImmediately}
  kCFNotificationPostToAllSessions  = 1 shl 1;
  {$EXTERNALSYM kCFNotificationPostToAllSessions}

procedure CFNotificationCenterPostNotificationWithOptions(
  center: CFNotificationCenterRef; name: CFStringRef; &object: Pointer;
  userInfo: CFDictionaryRef; options: CFOptionFlags); cdecl;
  external CoreFoundationLib name _PU + 'CFNotificationCenterPostNotificationWithOptions';
{$EXTERNALSYM CFNotificationCenterPostNotificationWithOptions}


{$ENDIF !__COREFOUNDATION_CFNOTIFICATIONCENTER__}

