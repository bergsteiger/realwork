{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFSet.h                                }
{          Copyright (c) 1999-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


{$IFNDEF __COREFOUNDATION_CFSOCKET__}

{$DEFINE __COREFOUNDATION_CFSOCKET__}

{$I CFData.inc}
{$I CFRunLoop.inc}


type
  CFSocketNativeHandle = Integer;
  {$EXTERNALSYM CFSocketNativeHandle}

  PCFSocketRef = ^CFSocketRef;
  CFSocketRef = ^__CFSocket;
  {$EXTERNALSYM CFSocketRef}
  __CFSocket = record
  end;
  {$EXTERNALSYM __CFSocket}

{ A CFSocket contains a native socket within a structure that can 
be used to read from the socket in the background and make the data
thus read available using a runloop source.  The callback used for
this may be of three types, as specified by the callBackTypes
argument when creating the CFSocket.

If kCFSocketReadCallBack is used, then data will not be
automatically read, but the callback will be called when data
is available to be read, or a new child socket is waiting to be
accepted.
    
If kCFSocketAcceptCallBack is used, then new child sockets will be
accepted and passed to the callback, with the data argument being
a pointer to a CFSocketNativeHandle.  This is usable only with
connection rendezvous sockets.

If kCFSocketDataCallBack is used, then data will be read in chunks
in the background and passed to the callback, with the data argument
being a CFDataRef.

These three types are mutually exclusive, but any one of them may
have kCFSocketConnectCallBack added to it, if the socket will be
used to connect in the background.  Connect in the background occurs
if CFSocketConnectToAddress is called with a negative timeout
value, in which case the call returns immediately, and a
kCFSocketConnectCallBack is generated when the connect finishes.
In this case the data argument is either NULL, or a pointer to
an SInt32 error code if the connect failed.  kCFSocketConnectCallBack
will never be sent more than once for a given socket.

The callback types may also have kCFSocketWriteCallBack added to
them, if large amounts of data are to be sent rapidly over the 
socket and notification is desired when there is space in the
kernel buffers so that the socket is writable again.  

With a connection-oriented socket, if the connection is broken from the
other end, then one final kCFSocketReadCallBack or kCFSocketDataCallBack 
will occur.  In the case of kCFSocketReadCallBack, the underlying socket 
will have 0 bytes available to read.  In the case of kCFSocketDataCallBack,
the data argument will be a CFDataRef of length 0.

There are socket flags that may be set to control whether callbacks of 
a given type are automatically reenabled after they are triggered, and 
whether the underlying native socket will be closed when the CFSocket
is invalidated.  By default read, accept, and data callbacks are 
automatically reenabled; write callbacks are not, and connect callbacks
may not be, since they are sent once only.  Be careful about automatically
reenabling read and write callbacks, since this implies that the 
callbacks will be sent repeatedly if the socket remains readable or
writable respectively.  Be sure to set these flags only for callbacks
that your CFSocket actually possesses; the result of setting them for
other callback types is undefined.

Individual callbacks may also be enabled and disabled manually, whether 
they are automatically reenabled or not.  If they are not automatically 
reenabled, then they will need to be manually reenabled when the callback 
is ready to be received again (and not sooner).  Even if they are 
automatically reenabled, there may be occasions when it will be useful
to be able to manually disable them temporarily and then reenable them.
Be sure to enable and disable only callbacks that your CFSocket actually
possesses; the result of enabling and disabling other callback types is
undefined.

By default the underlying native socket will be closed when the CFSocket 
is invalidated, but it will not be if kCFSocketCloseOnInvalidate is 
turned off.  This can be useful in order to destroy a CFSocket but 
continue to use the underlying native socket.  The CFSocket must 
still be invalidated when it will no longer be used.  Do not in 
either case close the underlying native socket without invalidating 
the CFSocket.

Addresses are stored as CFDatas containing a struct sockaddr
appropriate for the protocol family; make sure that all fields are
filled in properly when passing in an address.  

 }

{ Values for CFSocketError }
const
  kCFSocketSuccess = 0;
  {$EXTERNALSYM kCFSocketSuccess}
  kCFSocketError   = -1;
  {$EXTERNALSYM kCFSocketError}
  kCFSocketTimeout = -2;
  {$EXTERNALSYM kCFSocketTimeout}
type
  CFSocketError = CFIndex;
  {$EXTERNALSYM CFSocketError}

  PCFSocketSignature = ^CFSocketSignature;
  CFSocketSignature = record
    protocolFamily: SInt32;
    socketType: SInt32;
    protocol: SInt32;
    address: CFDataRef;
  end;
  {$EXTERNALSYM CFSocketSignature}

{ Values for CFSocketCallBackType }
const
  kCFSocketNoCallBack      = 0;
  {$EXTERNALSYM kCFSocketNoCallBack}
  kCFSocketReadCallBack    = 1;
  {$EXTERNALSYM kCFSocketReadCallBack}
  kCFSocketAcceptCallBack  = 2;
  {$EXTERNALSYM kCFSocketAcceptCallBack}
  kCFSocketDataCallBack    = 3;
  {$EXTERNALSYM kCFSocketDataCallBack}
  kCFSocketConnectCallBack = 4;
  {$EXTERNALSYM kCFSocketConnectCallBack}
  kCFSocketWriteCallBack   = 8;
  {$EXTERNALSYM kCFSocketWriteCallBack}
type
  CFSocketCallBackType = CFOptionFlags;
  {$EXTERNALSYM CFSocketCallBackType}

{ Socket flags }
const
  kCFSocketAutomaticallyReenableReadCallBack   = 1;
  {$EXTERNALSYM kCFSocketAutomaticallyReenableReadCallBack}
  kCFSocketAutomaticallyReenableAcceptCallBack = 2;
  {$EXTERNALSYM kCFSocketAutomaticallyReenableAcceptCallBack}
  kCFSocketAutomaticallyReenableDataCallBack   = 3;
  {$EXTERNALSYM kCFSocketAutomaticallyReenableDataCallBack}
  kCFSocketAutomaticallyReenableWriteCallBack  = 8;
  {$EXTERNALSYM kCFSocketAutomaticallyReenableWriteCallBack}
  kCFSocketLeaveErrors                         = 64;
  {$EXTERNALSYM kCFSocketLeaveErrors}
  kCFSocketCloseOnInvalidate                   = 128;
  {$EXTERNALSYM kCFSocketCloseOnInvalidate}

type
  CFSocketCallBack = procedure(s: CFSocketRef; &type: CFSocketCallBackType;
    address: CFDataRef; data: Pointer; info: Pointer); cdecl;
  {$EXTERNALSYM CFSocketCallBack}
{ If the callback wishes to keep hold of address or data after the point that it returns, then it must copy them. }

  PCFSocketContext = ^CFSocketContext;
  CFSocketContext = record
    version: CFIndex;
    info: Pointer;
    retain: CFAllocatorRetainCallback;
    release: CFAllocatorReleaseCallBack;
    copyDescription: CFAllocatorCopyDescriptionCallback;
  end;
  {$EXTERNALSYM CFSocketContext}

function CFSocketGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketGetTypeID';
{$EXTERNALSYM CFSocketGetTypeID}

function CFSocketCreate(allocator: CFAllocatorRef; protocolFamily: SInt32; 
  socketType: SInt32; protocol: SInt32; callBackTypes: CFOptionFlags; 
  callout: CFSocketCallBack; context: PCFSocketContext): CFSocketRef; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketCreate';
{$EXTERNALSYM CFSocketCreate}
function CFSocketCreateWithNative(allocator: CFAllocatorRef;
  sock: CFSocketNativeHandle; callBackTypes: CFOptionFlags;
  callout: CFSocketCallBack; context: PCFSocketContext): CFSocketRef; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketCreateWithNative';
{$EXTERNALSYM CFSocketCreateWithNative}
function CFSocketCreateWithSocketSignature(allocator: CFAllocatorRef;
  signature: PCFSocketSignature; callBackTypes: CFOptionFlags;
  callout: CFSocketCallBack; context: PCFSocketContext): CFSocketRef; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketCreateWithSocketSignature';
{$EXTERNALSYM CFSocketCreateWithSocketSignature}
function CFSocketCreateConnectedToSocketSignature(allocator: CFAllocatorRef;
  signature: PCFSocketSignature; callBackTypes: CFOptionFlags;
  callout: CFSocketCallBack; context: PCFSocketContext;
  timeout: CFTimeInterval): CFSocketRef; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketCreateConnectedToSocketSignature';
{$EXTERNALSYM CFSocketCreateConnectedToSocketSignature}
{ CFSocketCreateWithSignature creates a socket of the requested type and binds
  its address (using CFSocketSetAddress) to the requested address.  If this
  fails, it returns NULL.  CFSocketCreateConnectedToSignature creates a socket
  suitable for connecting to the requested type and address, and connects it
  (using CFSocketConnectToAddress).  If this fails, it returns NULL. }

function CFSocketSetAddress(s: CFSocketRef;
  address: CFDataRef): CFSocketError; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketSetAddress';
{$EXTERNALSYM CFSocketSetAddress}
function CFSocketConnectToAddress(s: CFSocketRef; address: CFDataRef;
  timeout: CFTimeInterval): CFSocketError; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketConnectToAddress';
{$EXTERNALSYM CFSocketConnectToAddress}
procedure CFSocketInvalidate(s: CFSocketRef); cdecl;
  external CoreFoundationLib name _PU + 'CFSocketInvalidate';
{$EXTERNALSYM CFSocketInvalidate}

function CFSocketIsValid(s: CFSocketRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketIsValid';
{$EXTERNALSYM CFSocketIsValid}
function CFSocketCopyAddress(s: CFSocketRef): CFDataRef; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketCopyAddress';
{$EXTERNALSYM CFSocketCopyAddress}
function CFSocketCopyPeerAddress(s: CFSocketRef): CFDataRef; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketCopyPeerAddress';
{$EXTERNALSYM CFSocketCopyPeerAddress}
procedure CFSocketGetContext(s: CFSocketRef; context: PCFSocketContext); cdecl;
  external CoreFoundationLib name _PU + 'CFSocketGetContext';
{$EXTERNALSYM CFSocketGetContext}
function CFSocketGetNative(s: CFSocketRef): CFSocketNativeHandle; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketGetNative';
{$EXTERNALSYM CFSocketGetNative}

function CFSocketCreateRunLoopSource(allocator: CFAllocatorRef; s: CFSocketRef;
  order: CFIndex): CFRunLoopSourceRef; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketCreateRunLoopSource';
{$EXTERNALSYM CFSocketCreateRunLoopSource}

function CFSocketGetSocketFlags(s: CFSocketRef): CFOptionFlags; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketGetSocketFlags';
{$EXTERNALSYM CFSocketGetSocketFlags}
procedure CFSocketSetSocketFlags(s: CFSocketRef; flags: CFOptionFlags); cdecl;
  external CoreFoundationLib name _PU + 'CFSocketSetSocketFlags';
{$EXTERNALSYM CFSocketSetSocketFlags}
procedure CFSocketDisableCallBacks(s: CFSocketRef;
  callBackTypes: CFOptionFlags); cdecl;
  external CoreFoundationLib name _PU + 'CFSocketDisableCallBacks';
{$EXTERNALSYM CFSocketDisableCallBacks}
procedure CFSocketEnableCallBacks(s: CFSocketRef;
  callBackTypes: CFOptionFlags); cdecl;
  external CoreFoundationLib name _PU + 'CFSocketEnableCallBacks';
{$EXTERNALSYM CFSocketEnableCallBacks}

{ For convenience, a function is provided to send data using the socket with
  a timeout.  The timeout will be used only if the specified value is positive.
  The address should be left NULL if the socket is already connected. }
function CFSocketSendData(s: CFSocketRef; address: CFDataRef; data: CFDataRef; 
  timeout: CFTimeInterval): CFSocketError; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketSendData';
{$EXTERNALSYM CFSocketSendData}

{ Generic name registry functionality (CFSocketRegisterValue, 
CFSocketCopyRegisteredValue) allows the registration of any property
list type.  Functions specific to CFSockets (CFSocketRegisterSocketData,
CFSocketCopyRegisteredSocketData) register a CFData containing the
components of a socket signature (protocol family, socket type,
protocol, and address).  In each function the nameServerSignature
may be NULL, or any component of it may be 0, to use default values
(TCP, INADDR_LOOPBACK, port as set).  Name registration servers might
not allow registration with other than TCP and INADDR_LOOPBACK.
The actual address of the server responding to a query may be obtained
by using the nameServerAddress argument.  This address, the address
returned by CFSocketCopyRegisteredSocketSignature, and the value
returned by CFSocketCopyRegisteredValue must (if non-null) be released
by the caller.  CFSocketUnregister removes any registration associated
with the specified name.
 }

function CFSocketRegisterValue(nameServerSignature: PCFSocketSignature;
  timeout: CFTimeInterval; name: CFStringRef; 
  value: CFPropertyListRef): CFSocketError; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketRegisterValue';
{$EXTERNALSYM CFSocketRegisterValue}
function CFSocketCopyRegisteredValue(
  nameServerSignature: PCFSocketSignature; timeout: CFTimeInterval;
  name: CFStringRef; value: PCFPropertyListRef;
  nameServerAddress: PCFDataRef): CFSocketError; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketCopyRegisteredValue';
{$EXTERNALSYM CFSocketCopyRegisteredValue}

function CFSocketRegisterSocketSignature(
  nameServerSignature: PCFSocketSignature; timeout: CFTimeInterval;
  name: CFStringRef; signature: PCFSocketSignature): CFSocketError; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketRegisterSocketSignature';
{$EXTERNALSYM CFSocketRegisterSocketSignature}
function CFSocketCopyRegisteredSocketSignature(
  nameServerSignature: PCFSocketSignature; timeout: CFTimeInterval;
  name: CFStringRef; signature: PCFSocketSignature;
  nameServerAddress: PCFDataRef): CFSocketError; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketCopyRegisteredSocketSignature';
{$EXTERNALSYM CFSocketCopyRegisteredSocketSignature}

function CFSocketUnregister(nameServerSignature: PCFSocketSignature;
  timeout: CFTimeInterval; name: CFStringRef): CFSocketError; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketUnregister';
{$EXTERNALSYM CFSocketUnregister}

procedure CFSocketSetDefaultNameRegistryPortNumber(port: UInt16); cdecl;
  external CoreFoundationLib name _PU + 'CFSocketSetDefaultNameRegistryPortNumber';
{$EXTERNALSYM CFSocketSetDefaultNameRegistryPortNumber}
function CFSocketGetDefaultNameRegistryPortNumber: UInt16; cdecl;
  external CoreFoundationLib name _PU + 'CFSocketGetDefaultNameRegistryPortNumber';
{$EXTERNALSYM CFSocketGetDefaultNameRegistryPortNumber}

{ Constants used in name registry server communications }


{$ENDIF !__COREFOUNDATION_CFSOCKET__}


