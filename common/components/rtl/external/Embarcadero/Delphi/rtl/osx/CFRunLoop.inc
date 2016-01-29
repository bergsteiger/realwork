{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFPreferences.h                        }
{          Copyright (c) 1998-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IFNDEF __COREFOUNDATION_CFRUNLOOP__}

{$DEFINE __COREFOUNDATION_CFRUNLOOP__}

{$I CFArray.inc}
{$I CFBase.inc}
{$I CFDate.inc}
{$I CFString.inc}

type
  PCFRunLoopRef = ^CFRunLoopRef;
  CFRunLoopRef = ^__CFRunLoop;
  {$EXTERNALSYM CFRunLoopRef}
  __CFRunLoop = record
  end;
  {$EXTERNALSYM __CFRunLoop}

  PCFRunLoopSourceRef = ^CFRunLoopSourceRef;
  CFRunLoopSourceRef = ^__CFRunLoopSource;
  {$EXTERNALSYM CFRunLoopSourceRef}
  __CFRunLoopSource = record
  end;
  {$EXTERNALSYM __CFRunLoopSource}

  PCFRunLoopObserverRef = ^CFRunLoopObserverRef;
  CFRunLoopObserverRef = ^__CFRunLoopObserver;
  {$EXTERNALSYM CFRunLoopObserverRef}
  __CFRunLoopObserver = record
  end;
  {$EXTERNALSYM __CFRunLoopObserver}

  PCFRunLoopTimerRef = ^CFRunLoopTimerRef;
  CFRunLoopTimerRef = ^__CFRunLoopTimer;
  {$EXTERNALSYM CFRunLoopTimerRef}
  __CFRunLoopTimer = record
  end;
  {$EXTERNALSYM __CFRunLoopTimer}

{ Reasons for CFRunLoopRunInMode() to Return }
const
  kCFRunLoopRunFinished      = 1;
  {$EXTERNALSYM kCFRunLoopRunFinished}
  kCFRunLoopRunStopped       = 2;
  {$EXTERNALSYM kCFRunLoopRunStopped}
  kCFRunLoopRunTimedOut      = 3;
  {$EXTERNALSYM kCFRunLoopRunTimedOut}
  kCFRunLoopRunHandledSource = 4;
  {$EXTERNALSYM kCFRunLoopRunHandledSource}

{ Run Loop Observer Activities }
const
  kCFRunLoopEntry         = 1 shl 0;
  {$EXTERNALSYM kCFRunLoopEntry}
  kCFRunLoopBeforeTimers  = 1 shl 1;
  {$EXTERNALSYM kCFRunLoopBeforeTimers}
  kCFRunLoopBeforeSources = 1 shl 2;
  {$EXTERNALSYM kCFRunLoopBeforeSources}
  kCFRunLoopBeforeWaiting = 1 shl 5;
  {$EXTERNALSYM kCFRunLoopBeforeWaiting}
  kCFRunLoopAfterWaiting  = 1 shl 6;
  {$EXTERNALSYM kCFRunLoopAfterWaiting}
  kCFRunLoopExit          = 1 shl 7;
  {$EXTERNALSYM kCFRunLoopExit}
  kCFRunLoopAllActivities = $0FFFFFFF; 
  {$EXTERNALSYM kCFRunLoopAllActivities}
type
  CFRunLoopActivity = CFOptionFlags; 
  {$EXTERNALSYM CFRunLoopActivity}

function kCFRunLoopDefaultMode: CFStringRef;
{$EXTERNALSYM kCFRunLoopDefaultMode}

function kCFRunLoopCommonModes: CFStringRef;
{$EXTERNALSYM kCFRunLoopCommonModes}

function CFRunLoopGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopGetTypeID';
{$EXTERNALSYM CFRunLoopGetTypeID}

function CFRunLoopGetCurrent: CFRunLoopRef; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopGetCurrent';
{$EXTERNALSYM CFRunLoopGetCurrent}
function CFRunLoopGetMain: CFRunLoopRef; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopGetMain';
{$EXTERNALSYM CFRunLoopGetMain}

function CFRunLoopCopyCurrentMode(rl: CFRunLoopRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopCopyCurrentMode';
{$EXTERNALSYM CFRunLoopCopyCurrentMode}

function CFRunLoopCopyAllModes(rl: CFRunLoopRef): CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopCopyAllModes';
{$EXTERNALSYM CFRunLoopCopyAllModes}

procedure CFRunLoopAddCommonMode(rl: CFRunLoopRef; mode: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopAddCommonMode';
{$EXTERNALSYM CFRunLoopAddCommonMode}

function CFRunLoopGetNextTimerFireDate(rl: CFRunLoopRef;
  mode: CFStringRef): CFAbsoluteTime; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopGetNextTimerFireDate';
{$EXTERNALSYM CFRunLoopGetNextTimerFireDate}

procedure CFRunLoopRun; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopRun';
{$EXTERNALSYM CFRunLoopRun}
function CFRunLoopRunInMode(mode: CFStringRef; seconds: CFTimeInterval;
  returnAfterSourceHandled: Boolean): SInt32; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopRunInMode';
{$EXTERNALSYM CFRunLoopRunInMode}
function CFRunLoopIsWaiting(rl: CFRunLoopRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopIsWaiting';
{$EXTERNALSYM CFRunLoopIsWaiting}
procedure CFRunLoopWakeUp(rl: CFRunLoopRef); cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopWakeUp';
{$EXTERNALSYM CFRunLoopWakeUp}
procedure CFRunLoopStop(rl: CFRunLoopRef); cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopStop';
{$EXTERNALSYM CFRunLoopStop}

procedure CFRunLoopPerformBlock(rl: CFRunLoopRef; mode: CFTypeRef;
  block: Pointer); cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopPerformBlock';
{$EXTERNALSYM CFRunLoopPerformBlock}

function CFRunLoopContainsSource(rl: CFRunLoopRef; source: CFRunLoopSourceRef;
  mode: CFStringRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopContainsSource';
{$EXTERNALSYM CFRunLoopContainsSource}
procedure CFRunLoopAddSource(rl: CFRunLoopRef; source: CFRunLoopSourceRef;
  mode: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopAddSource';
{$EXTERNALSYM CFRunLoopAddSource}
procedure CFRunLoopRemoveSource(rl: CFRunLoopRef; source: CFRunLoopSourceRef;
  mode: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopRemoveSource';
{$EXTERNALSYM CFRunLoopRemoveSource}

function CFRunLoopContainsObserver(rl: CFRunLoopRef;
  observer: CFRunLoopObserverRef; mode: CFStringRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopContainsObserver';
{$EXTERNALSYM CFRunLoopContainsObserver}
procedure CFRunLoopAddObserver(rl: CFRunLoopRef; observer: CFRunLoopObserverRef;
  mode: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopAddObserver';
{$EXTERNALSYM CFRunLoopAddObserver}
procedure CFRunLoopRemoveObserver(rl: CFRunLoopRef;
  observer: CFRunLoopObserverRef; mode: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopRemoveObserver';
{$EXTERNALSYM CFRunLoopRemoveObserver}

function CFRunLoopContainsTimer(rl: CFRunLoopRef; timer: CFRunLoopTimerRef;
  mode: CFStringRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopContainsTimer';
{$EXTERNALSYM CFRunLoopContainsTimer}
procedure CFRunLoopAddTimer(rl: CFRunLoopRef; timer: CFRunLoopTimerRef;
  mode: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopAddTimer';
{$EXTERNALSYM CFRunLoopAddTimer}
procedure CFRunLoopRemoveTimer(rl: CFRunLoopRef; timer: CFRunLoopTimerRef;
  mode: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopRemoveTimer';
{$EXTERNALSYM CFRunLoopRemoveTimer}

type
  CFRunLoopEqualCallback = function(info1, info2: Pointer): Boolean; cdecl;
  CFRunLoopHashCallback = function(info: Pointer): CFHashCode; cdecl;
  CFRunLoopSheduleCallback = procedure(info: Pointer; r1: CFRunLoopRef; mode: CFStringRef); cdecl;
  CFRunLoopCancelCallback = procedure(info: Pointer; r1: CFRunLoopRef; mode: CFStringRef); cdecl;
  CFRunLoopPerformCallback = procedure(info: Pointer); cdecl;

  PCFRunLoopSourceContext = ^CFRunLoopSourceContext;
  CFRunLoopSourceContext = record
    version: CFIndex;
    info: Pointer;
    retain: CFAllocatorRetainCallback;
    release: CFAllocatorReleaseCallBack;
    copyDescription: CFAllocatorCopyDescriptionCallback;
    equal: CFRunLoopEqualCallback;
    hash: CFRunLoopHashCallback;
    schedule: CFRunLoopSheduleCallback;
    cancel: CFRunLoopCancelCallback;
    perform: CFRunLoopPerformCallback;
  end;
  {$EXTERNALSYM CFRunLoopSourceContext}

  CFRunLoopGetPortCallBack= function(info: Pointer): mach_port_t; cdecl;
  CFRunLoopMachPerformCallBack = function(msg: Pointer; size: CFIndex;
    allocator: CFAllocatorRef; info: Pointer): Pointer; cdecl;

  PCFRunLoopSourceContext1 = ^CFRunLoopSourceContext1;
  CFRunLoopSourceContext1 = record
    version: CFIndex;
    info: Pointer;
    retain: CFAllocatorRetainCallback;
    release: CFAllocatorReleaseCallBack;
    copyDescription: CFAllocatorCopyDescriptionCallback;
    equal: CFRunLoopEqualCallback;
    hash: CFRunLoopHashCallback;
    getPort: CFRunLoopGetPortCallBack;
    perform: CFRunLoopMachPerformCallBack;
  end;
  {$EXTERNALSYM CFRunLoopSourceContext1}

function CFRunLoopSourceGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopSourceGetTypeID';
{$EXTERNALSYM CFRunLoopSourceGetTypeID}

function CFRunLoopSourceCreate(allocator: CFAllocatorRef; order: CFIndex;
  context: PCFRunLoopSourceContext): CFRunLoopSourceRef; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopSourceCreate';
{$EXTERNALSYM CFRunLoopSourceCreate}

function CFRunLoopSourceGetOrder(source: CFRunLoopSourceRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopSourceGetOrder';
{$EXTERNALSYM CFRunLoopSourceGetOrder}
procedure CFRunLoopSourceInvalidate(source: CFRunLoopSourceRef); cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopSourceInvalidate';
{$EXTERNALSYM CFRunLoopSourceInvalidate}
function CFRunLoopSourceIsValid(source: CFRunLoopSourceRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopSourceIsValid';
{$EXTERNALSYM CFRunLoopSourceIsValid}
procedure CFRunLoopSourceGetContext(source: CFRunLoopSourceRef;
  context: PCFRunLoopSourceContext); cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopSourceGetContext';
{$EXTERNALSYM CFRunLoopSourceGetContext}
procedure CFRunLoopSourceSignal(source: CFRunLoopSourceRef); cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopSourceSignal';
{$EXTERNALSYM CFRunLoopSourceSignal}

type
  PCFRunLoopObserverContext = ^CFRunLoopObserverContext;
  CFRunLoopObserverContext = record
    version: CFIndex;
    info: Pointer;
    retain: CFAllocatorRetainCallback;
    release: CFAllocatorReleaseCallBack;
    copyDescription: CFAllocatorCopyDescriptionCallback;
  end;
  {$EXTERNALSYM CFRunLoopObserverContext}

  CFRunLoopObserverCallBack = procedure(observer: CFRunLoopObserverRef;
    activity: CFRunLoopActivity; info: Pointer); cdecl;
  {$EXTERNALSYM CFRunLoopObserverCallBack}

function CFRunLoopObserverGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopObserverGetTypeID';
{$EXTERNALSYM CFRunLoopObserverGetTypeID}

function CFRunLoopObserverCreate(allocator: CFAllocatorRef;
  activities: CFOptionFlags; repeats: Boolean; order: CFIndex;
  callout: CFRunLoopObserverCallBack;
  context: PCFRunLoopObserverContext): CFRunLoopObserverRef; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopObserverCreate';
{$EXTERNALSYM CFRunLoopObserverCreate}

function CFRunLoopObserverGetActivities(
  observer: CFRunLoopObserverRef): CFOptionFlags; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopObserverGetActivities';
{$EXTERNALSYM CFRunLoopObserverGetActivities}
function CFRunLoopObserverDoesRepeat(
  observer: CFRunLoopObserverRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopObserverDoesRepeat';
{$EXTERNALSYM CFRunLoopObserverDoesRepeat}
function CFRunLoopObserverGetOrder(
  observer: CFRunLoopObserverRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopObserverGetOrder';
{$EXTERNALSYM CFRunLoopObserverGetOrder}
procedure CFRunLoopObserverInvalidate(observer: CFRunLoopObserverRef); cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopObserverInvalidate';
{$EXTERNALSYM CFRunLoopObserverInvalidate}
function CFRunLoopObserverIsValid(
  observer: CFRunLoopObserverRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopObserverIsValid';
{$EXTERNALSYM CFRunLoopObserverIsValid}
procedure CFRunLoopObserverGetContext(observer: CFRunLoopObserverRef;
  context: PCFRunLoopObserverContext); cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopObserverGetContext';
{$EXTERNALSYM CFRunLoopObserverGetContext}

type
  PCFRunLoopTimerContext = ^CFRunLoopTimerContext;
  CFRunLoopTimerContext = record
    version: CFIndex;
    info: Pointer;
    retain: CFAllocatorRetainCallback;
    release: CFAllocatorReleaseCallBack;
    copyDescription: CFAllocatorCopyDescriptionCallback;
  end;
  {$EXTERNALSYM CFRunLoopTimerContext}

  CFRunLoopTimerCallBack = procedure(timer: CFRunLoopTimerRef; info: Pointer); cdecl;
  {$EXTERNALSYM CFRunLoopTimerCallBack}

function CFRunLoopTimerGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopTimerGetTypeID';
{$EXTERNALSYM CFRunLoopTimerGetTypeID}

function CFRunLoopTimerCreate(allocator: CFAllocatorRef;
  fireDate: CFAbsoluteTime; interval: CFTimeInterval; flags: CFOptionFlags;
  order: CFIndex; callout: CFRunLoopTimerCallBack;
  context: PCFRunLoopTimerContext): CFRunLoopTimerRef; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopTimerCreate';
{$EXTERNALSYM CFRunLoopTimerCreate}
function CFRunLoopTimerGetNextFireDate(
  timer: CFRunLoopTimerRef): CFAbsoluteTime; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopTimerGetNextFireDate';
{$EXTERNALSYM CFRunLoopTimerGetNextFireDate}
procedure CFRunLoopTimerSetNextFireDate(timer: CFRunLoopTimerRef;
  fireDate: CFAbsoluteTime); cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopTimerSetNextFireDate';
{$EXTERNALSYM CFRunLoopTimerSetNextFireDate}
function CFRunLoopTimerGetInterval(
  timer: CFRunLoopTimerRef): CFTimeInterval; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopTimerGetInterval';
{$EXTERNALSYM CFRunLoopTimerGetInterval}
function CFRunLoopTimerDoesRepeat(timer: CFRunLoopTimerRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopTimerDoesRepeat';
{$EXTERNALSYM CFRunLoopTimerDoesRepeat}
function CFRunLoopTimerGetOrder(timer: CFRunLoopTimerRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopTimerGetOrder';
{$EXTERNALSYM CFRunLoopTimerGetOrder}
procedure CFRunLoopTimerInvalidate(timer: CFRunLoopTimerRef); cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopTimerInvalidate';
{$EXTERNALSYM CFRunLoopTimerInvalidate}
function CFRunLoopTimerIsValid(timer: CFRunLoopTimerRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopTimerIsValid';
{$EXTERNALSYM CFRunLoopTimerIsValid}
procedure CFRunLoopTimerGetContext(timer: CFRunLoopTimerRef;
  context: PCFRunLoopTimerContext); cdecl;
  external CoreFoundationLib name _PU + 'CFRunLoopTimerGetContext';
{$EXTERNALSYM CFRunLoopTimerGetContext}


{$ENDIF !__COREFOUNDATION_CFRUNLOOP__}


