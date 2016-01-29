{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFMessagePort.h                        }
{          Copyright (c) 1998-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IFNDEF __COREFOUNDATION_CFMESSAGEPORT__}

{$DEFINE __COREFOUNDATION_CFMESSAGEPORT__}

{$I CFData.inc}
{$I CFRunLoop.inc}
{$I CFString.inc}

type
  PCFMessagePortRef = ^CFMessagePortRef;
  CFMessagePortRef = ^__CFMessagePort;
  {$EXTERNALSYM CFMessagePortRef}
  __CFMessagePort = record
  end;
  {$EXTERNALSYM __CFMessagePort}

const
  kCFMessagePortSuccess            = 0;
  {$EXTERNALSYM kCFMessagePortSuccess}
  kCFMessagePortSendTimeout        = -1;
  {$EXTERNALSYM kCFMessagePortSendTimeout}
  kCFMessagePortReceiveTimeout     = -2;
  {$EXTERNALSYM kCFMessagePortReceiveTimeout}
  kCFMessagePortIsInvalid          = -3;
  {$EXTERNALSYM kCFMessagePortIsInvalid}
  kCFMessagePortTransportError     = -4;
  {$EXTERNALSYM kCFMessagePortTransportError}
  kCFMessagePortBecameInvalidError = -5;
  {$EXTERNALSYM kCFMessagePortBecameInvalidError}

type
  PCFMessagePortContext = ^CFMessagePortContext;
  CFMessagePortContext = record
    version: CFIndex;
    info: Pointer;
    retain: CFAllocatorRetainCallback;
    release: CFAllocatorReleaseCallBack;
    copyDescription: CFAllocatorCopyDescriptionCallback;
  end;
  {$EXTERNALSYM CFMessagePortContext}

  CFMessagePortCallBack = function(local: CFMessagePortRef; msgid: SInt32;
    data: CFDataRef; info: Pointer): CFDataRef; cdecl;
  {$EXTERNALSYM CFMessagePortCallBack}
{ If callout wants to keep a hold of the data past the return of the callout,
  it must COPY the data. This includes the case where the data is given to
  some routine which _might_ keep a hold of it; System will release
  returned CFData. }
  CFMessagePortInvalidationCallBack = procedure(ms: CFMessagePortRef;
    info: Pointer); cdecl;
  {$EXTERNALSYM CFMessagePortInvalidationCallBack}

function CFMessagePortGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFMessagePortGetTypeID';
{$EXTERNALSYM CFMessagePortGetTypeID}

function CFMessagePortCreateLocal(allocator: CFAllocatorRef; name: CFStringRef;
  callout: CFMessagePortCallBack; context: PCFMessagePortContext;
  shouldFreeInfo: PBoolean): CFMessagePortRef; cdecl;
  external CoreFoundationLib name _PU + 'CFMessagePortCreateLocal';
{$EXTERNALSYM CFMessagePortCreateLocal}
function CFMessagePortCreateRemote(allocator: CFAllocatorRef;
  name: CFStringRef): CFMessagePortRef; cdecl;
  external CoreFoundationLib name _PU + 'CFMessagePortCreateRemote';
{$EXTERNALSYM CFMessagePortCreateRemote}

function CFMessagePortIsRemote(ms: CFMessagePortRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFMessagePortIsRemote';
{$EXTERNALSYM CFMessagePortIsRemote}
function CFMessagePortGetName(ms: CFMessagePortRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFMessagePortGetName';
{$EXTERNALSYM CFMessagePortGetName}
function CFMessagePortSetName(ms: CFMessagePortRef;
  newName: CFStringRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFMessagePortSetName';
{$EXTERNALSYM CFMessagePortSetName}
procedure CFMessagePortGetContext(ms: CFMessagePortRef;
  context: PCFMessagePortContext); cdecl;
  external CoreFoundationLib name _PU + 'CFMessagePortGetContext';
{$EXTERNALSYM CFMessagePortGetContext}
procedure CFMessagePortInvalidate(ms: CFMessagePortRef); cdecl;
  external CoreFoundationLib name _PU + 'CFMessagePortInvalidate';
{$EXTERNALSYM CFMessagePortInvalidate}
function CFMessagePortIsValid(ms: CFMessagePortRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFMessagePortIsValid';
{$EXTERNALSYM CFMessagePortIsValid}
function CFMessagePortGetInvalidationCallBack(
  ms: CFMessagePortRef): CFMessagePortInvalidationCallBack; cdecl;
  external CoreFoundationLib name _PU + 'CFMessagePortGetInvalidationCallBack';
{$EXTERNALSYM CFMessagePortGetInvalidationCallBack}
procedure CFMessagePortSetInvalidationCallBack(ms: CFMessagePortRef;
  callout: CFMessagePortInvalidationCallBack); cdecl;
  external CoreFoundationLib name _PU + 'CFMessagePortSetInvalidationCallBack';
{$EXTERNALSYM CFMessagePortSetInvalidationCallBack}

{ NULL replyMode argument means no return value expected, dont wait for it }
function CFMessagePortSendRequest(remote: CFMessagePortRef; msgid: SInt32;
  data: CFDataRef; sendTimeout: CFTimeInterval; rcvTimeout: CFTimeInterval;
  replyMode: CFStringRef; out returnData: CFDataRef): SInt32; cdecl;
  external CoreFoundationLib name _PU + 'CFMessagePortSendRequest';
{$EXTERNALSYM CFMessagePortSendRequest}

function CFMessagePortCreateRunLoopSource(allocator: CFAllocatorRef;
  local: CFMessagePortRef; order: CFIndex): CFRunLoopSourceRef; cdecl;
  external CoreFoundationLib name _PU + 'CFMessagePortCreateRunLoopSource';
{$EXTERNALSYM CFMessagePortCreateRunLoopSource}


{$ENDIF !__COREFOUNDATION_CFMESSAGEPORT__}

