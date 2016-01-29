{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFStream.h                             }
{          Copyright (c) 2000-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IFNDEF __COREFOUNDATION_CFSTREAM__}

{$DEFINE __COREFOUNDATION_CFSTREAM__}

{$I CFBase.inc}
{$I CFDictionary.inc}
{$I CFError.inc}
{$I CFRunLoop.inc}
{$I CFSocket.inc}
{$I CFString.inc}
{$I CFURL.inc}

const
  kCFStreamStatusNotOpen = 0;
  {$EXTERNALSYM kCFStreamStatusNotOpen}
  kCFStreamStatusOpening = 1; { open is in-progress }
  {$EXTERNALSYM kCFStreamStatusOpening}
  kCFStreamStatusOpen    = 2;
  {$EXTERNALSYM kCFStreamStatusOpen}
  kCFStreamStatusReading = 3;
  {$EXTERNALSYM kCFStreamStatusReading}
  kCFStreamStatusWriting = 4;
  {$EXTERNALSYM kCFStreamStatusWriting}
  kCFStreamStatusAtEnd   = 5; { no further bytes can be read/written }
  {$EXTERNALSYM kCFStreamStatusAtEnd}
  kCFStreamStatusClosed  = 6;
  {$EXTERNALSYM kCFStreamStatusClosed}
  kCFStreamStatusError   = 7;
  {$EXTERNALSYM kCFStreamStatusError}
type
  CFStreamStatus = CFIndex;
  {$EXTERNALSYM CFStreamStatus}

const
  kCFStreamEventNone              = 0;
  {$EXTERNALSYM kCFStreamEventNone}
  kCFStreamEventOpenCompleted     = 1;
  {$EXTERNALSYM kCFStreamEventOpenCompleted}
  kCFStreamEventHasBytesAvailable = 2;
  {$EXTERNALSYM kCFStreamEventHasBytesAvailable}
  kCFStreamEventCanAcceptBytes    = 4;
  {$EXTERNALSYM kCFStreamEventCanAcceptBytes}
  kCFStreamEventErrorOccurred     = 8;
  {$EXTERNALSYM kCFStreamEventErrorOccurred}
  kCFStreamEventEndEncountered    = 16;
  {$EXTERNALSYM kCFStreamEventEndEncountered}
type
  CFStreamEventType = CFOptionFlags;
  {$EXTERNALSYM CFStreamEventType}

  PCFStreamClientContext = ^CFStreamClientContext;
  CFStreamClientContext = record 
    version: CFIndex;
    info: Pointer;
    retain: CFAllocatorRetainCallback;
    release: CFAllocatorReleaseCallBack;
    copyDescription: CFAllocatorCopyDescriptionCallback;
  end;
  {$EXTERNALSYM CFStreamClientContext}

  PCFReadStreamRef = ^CFReadStreamRef;
  CFReadStreamRef = ^__CFReadStream;
  {$EXTERNALSYM CFReadStreamRef}
  __CFReadStream = record
  end;
  {$EXTERNALSYM __CFReadStream}

  PCFWriteStreamRef = ^CFWriteStreamRef;
  CFWriteStreamRef = ^__CFWriteStream;
  {$EXTERNALSYM CFWriteStreamRef}
  __CFWriteStream = record
  end;
  {$EXTERNALSYM __CFWriteStream}

  CFReadStreamClientCallBack = procedure(stream: CFReadStreamRef; 
    &type: CFStreamEventType; clientCallBackInfo: Pointer); cdecl;
  {$EXTERNALSYM CFReadStreamClientCallBack}
  CFWriteStreamClientCallBack = procedure(stream: CFWriteStreamRef; 
    &type: CFStreamEventType; clientCallBackInfo: Pointer); cdecl;
  {$EXTERNALSYM CFWriteStreamClientCallBack}

function CFReadStreamGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFReadStreamGetTypeID';
{$EXTERNALSYM CFReadStreamGetTypeID}
function CFWriteStreamGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFWriteStreamGetTypeID';
{$EXTERNALSYM CFWriteStreamGetTypeID}

{ Memory streams }

{ Value will be a CFData containing all bytes thusfar written; used to
  recover the data written to a memory write stream. }
function kCFStreamPropertyDataWritten: CFStringRef;
{$EXTERNALSYM kCFStreamPropertyDataWritten}

{ Pass kCFAllocatorNull for bytesDeallocator to prevent CFReadStream from
  deallocating bytes; otherwise, CFReadStream will deallocate bytes when
  the stream is destroyed }
function CFReadStreamCreateWithBytesNoCopy(alloc: CFAllocatorRef; 
  bytes: PUInt8; length: CFIndex;
  bytesDeallocator: CFAllocatorRef): CFReadStreamRef; cdecl;
  external CoreFoundationLib name _PU + 'CFReadStreamCreateWithBytesNoCopy';
{$EXTERNALSYM CFReadStreamCreateWithBytesNoCopy}

{ The stream writes into the buffer given; when bufferCapacity is exhausted,
  the stream is exhausted (status becomes kCFStreamStatusAtEnd) }
function CFWriteStreamCreateWithBuffer(alloc: CFAllocatorRef; buffer: PUInt8; 
  bufferCapacity: CFIndex): CFWriteStreamRef; cdecl;
  external CoreFoundationLib name _PU + 'CFWriteStreamCreateWithBuffer';
{$EXTERNALSYM CFWriteStreamCreateWithBuffer}

{ New buffers are allocated from bufferAllocator as bytes are written to
  the stream.  At any point, you can recover the bytes thusfar written by
  asking for the property kCFStreamPropertyDataWritten, above }
function CFWriteStreamCreateWithAllocatedBuffers(alloc: CFAllocatorRef; 
  bufferAllocator: CFAllocatorRef): CFWriteStreamRef; cdecl;
  external CoreFoundationLib name _PU + 'CFWriteStreamCreateWithAllocatedBuffers';
{$EXTERNALSYM CFWriteStreamCreateWithAllocatedBuffers}

{ File streams }
function CFReadStreamCreateWithFile(alloc: CFAllocatorRef;
  fileURL: CFURLRef): CFReadStreamRef; cdecl;
  external CoreFoundationLib name _PU + 'CFReadStreamCreateWithFile';
{$EXTERNALSYM CFReadStreamCreateWithFile}
function CFWriteStreamCreateWithFile(alloc: CFAllocatorRef;
  fileURL: CFURLRef): CFWriteStreamRef; cdecl;
  external CoreFoundationLib name _PU + 'CFWriteStreamCreateWithFile';
{$EXTERNALSYM CFWriteStreamCreateWithFile}
procedure CFStreamCreateBoundPair(alloc: CFAllocatorRef; 
  out readStream: CFReadStreamRef; out writeStream: CFWriteStreamRef;
  transferBufferSize: CFIndex); cdecl;
  external CoreFoundationLib name _PU + 'CFStreamCreateBoundPair';
{$EXTERNALSYM CFStreamCreateBoundPair}

{ Property for file write streams; value should be a CFBoolean.
  Set to TRUE to append to a file, rather than to replace its contents }
function kCFStreamPropertyAppendToFile: CFStringRef;
{$EXTERNALSYM kCFStreamPropertyAppendToFile}

{ Value is a CFNumber }
function kCFStreamPropertyFileCurrentOffset: CFStringRef;
{$EXTERNALSYM kCFStreamPropertyFileCurrentOffset}

{ Socket stream properties }

{ Value will be a CFData containing the native handle }
function kCFStreamPropertySocketNativeHandle: CFStringRef;
{$EXTERNALSYM kCFStreamPropertySocketNativeHandle}

{ Value will be a CFString, or NULL if unknown }
function kCFStreamPropertySocketRemoteHostName: CFStringRef;
{$EXTERNALSYM kCFStreamPropertySocketRemoteHostName}

{ Value will be a CFNumber, or NULL if unknown }
function kCFStreamPropertySocketRemotePortNumber: CFStringRef;
{$EXTERNALSYM kCFStreamPropertySocketRemotePortNumber}

{ Socket streams; the returned streams are paired such that they use the
  same socket; pass NULL if you want only the read stream or the write stream }
procedure CFStreamCreatePairWithSocket(alloc: CFAllocatorRef; 
  sock: CFSocketNativeHandle; readStream: PCFReadStreamRef;
  writeStream: PCFWriteStreamRef); cdecl;
  external CoreFoundationLib name _PU + 'CFStreamCreatePairWithSocket';
{$EXTERNALSYM CFStreamCreatePairWithSocket}
procedure CFStreamCreatePairWithSocketToHost(alloc: CFAllocatorRef;
  host: CFStringRef; port: UInt32; readStream: PCFReadStreamRef;
  writeStream: PCFWriteStreamRef); cdecl;
  external CoreFoundationLib name _PU + 'CFStreamCreatePairWithSocketToHost';
{$EXTERNALSYM CFStreamCreatePairWithSocketToHost}
procedure CFStreamCreatePairWithPeerSocketSignature(alloc: CFAllocatorRef;
  signature: PCFSocketSignature; readStream: PCFReadStreamRef;
  writeStream: PCFWriteStreamRef); cdecl;
  external CoreFoundationLib name _PU + 'CFStreamCreatePairWithPeerSocketSignature';
{$EXTERNALSYM CFStreamCreatePairWithPeerSocketSignature}


{ Returns the current state of the stream }
function CFReadStreamGetStatus(stream: CFReadStreamRef): CFStreamStatus; cdecl;
  external CoreFoundationLib name _PU + 'CFReadStreamGetStatus';
{$EXTERNALSYM CFReadStreamGetStatus}
function CFWriteStreamGetStatus(stream: CFWriteStreamRef): CFStreamStatus; cdecl;
  external CoreFoundationLib name _PU + 'CFWriteStreamGetStatus';
{$EXTERNALSYM CFWriteStreamGetStatus}

{ Returns NULL if no error has occurred; otherwise returns the error. }
function CFReadStreamCopyError(stream: CFReadStreamRef): CFErrorRef; cdecl;
  external CoreFoundationLib name _PU + 'CFReadStreamCopyError';
{$EXTERNALSYM CFReadStreamCopyError}
function CFWriteStreamCopyError(stream: CFWriteStreamRef): CFErrorRef; cdecl;
  external CoreFoundationLib name _PU + 'CFWriteStreamCopyError';
{$EXTERNALSYM CFWriteStreamCopyError}

{ Returns success/failure.  Opening a stream causes it to reserve all the system
   resources it requires.  If the stream can open non-blocking, this will always 
   return TRUE; listen to the run loop source to find out when the open completes
   and whether it was successful, or poll using CFRead/WriteStreamGetStatus(), waiting 
   for a status of kCFStreamStatusOpen or kCFStreamStatusError.  }
function CFReadStreamOpen(stream: CFReadStreamRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFReadStreamOpen';
{$EXTERNALSYM CFReadStreamOpen}
function CFWriteStreamOpen(stream: CFWriteStreamRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFWriteStreamOpen';
{$EXTERNALSYM CFWriteStreamOpen}

{ Terminates the flow of bytes; releases any system resources required by the 
   stream.  The stream may not fail to close.  You may call CFStreamClose() to 
   effectively abort a stream. }
procedure CFReadStreamClose(stream: CFReadStreamRef); cdecl;
  external CoreFoundationLib name _PU + 'CFReadStreamClose';
{$EXTERNALSYM CFReadStreamClose}
procedure CFWriteStreamClose(stream: CFWriteStreamRef); cdecl;
  external CoreFoundationLib name _PU + 'CFWriteStreamClose';
{$EXTERNALSYM CFWriteStreamClose}

{ Whether there is data currently available for reading; returns TRUE if it's 
   impossible to tell without trying }
function CFReadStreamHasBytesAvailable(
  stream: CFReadStreamRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFReadStreamHasBytesAvailable';
{$EXTERNALSYM CFReadStreamHasBytesAvailable}

{ Returns the number of bytes read, or -1 if an error occurs preventing any 
   bytes from being read, or 0 if the stream's end was encountered.  
   It is an error to try and read from a stream that hasn't been opened first.  
   This call will block until at least one byte is available; it will NOT block
   until the entire buffer can be filled.  To avoid blocking, either poll using
   CFReadStreamHasBytesAvailable() or use the run loop and listen for the 
   kCFStreamCanRead event for notification of data available. }
function CFReadStreamRead(stream: CFReadStreamRef; buffer: PUInt8; 
  bufferLength: CFIndex): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFReadStreamRead';
{$EXTERNALSYM CFReadStreamRead}

{ Returns a pointer to an internal buffer if possible (setting *numBytesRead
   to the length of the returned buffer), otherwise returns NULL; guaranteed 
   to return in O(1).  Bytes returned in the buffer are considered read from 
   the stream; if maxBytesToRead is greater than 0, not more than maxBytesToRead
   will be returned.  If maxBytesToRead is less than or equal to zero, as many bytes
   as are readily available will be returned.  The returned buffer is good only 
   until the next stream operation called on the stream.  Caller should neither 
   change the contents of the returned buffer nor attempt to deallocate the buffer;
   it is still owned by the stream. }
function CFReadStreamGetBuffer(stream: CFReadStreamRef; maxBytesToRead: CFIndex; 
  numBytesRead: PCFIndex): PUInt8; cdecl;
  external CoreFoundationLib name _PU + 'CFReadStreamGetBuffer';
{$EXTERNALSYM CFReadStreamGetBuffer}

{ Whether the stream can currently be written to without blocking;
   returns TRUE if it's impossible to tell without trying }
function CFWriteStreamCanAcceptBytes(stream: CFWriteStreamRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFWriteStreamCanAcceptBytes';
{$EXTERNALSYM CFWriteStreamCanAcceptBytes}

{ Returns the number of bytes successfully written, -1 if an error has
   occurred, or 0 if the stream has been filled to capacity (for fixed-length
   streams).  If the stream is not full, this call will block until at least
   one byte is written.  To avoid blocking, either poll via CFWriteStreamCanAcceptBytes
   or use the run loop and listen for the kCFStreamCanWrite event. }
function CFWriteStreamWrite(stream: CFWriteStreamRef; buffer: PUInt8;
  bufferLength: CFIndex): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFWriteStreamWrite';
{$EXTERNALSYM CFWriteStreamWrite}

{ Particular streams can name properties and assign meanings to them; you
   access these properties through the following calls.  A property is any interesting
   information about the stream other than the data being transmitted itself.
   Examples include the headers from an HTTP transmission, or the expected 
   number of bytes, or permission information, etc.  Properties that can be set
   configure the behavior of the stream, and may only be settable at particular times
   (like before the stream has been opened).  See the documentation for particular 
   properties to determine their get- and set-ability. }
function CFReadStreamCopyProperty(stream: CFReadStreamRef; 
  propertyName: CFStringRef): CFTypeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFReadStreamCopyProperty';
{$EXTERNALSYM CFReadStreamCopyProperty}
function CFWriteStreamCopyProperty(stream: CFWriteStreamRef; 
  propertyName: CFStringRef): CFTypeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFWriteStreamCopyProperty';
{$EXTERNALSYM CFWriteStreamCopyProperty}

{ Returns TRUE if the stream recognizes and accepts the given property-value pair;
   FALSE otherwise. }
function CFReadStreamSetProperty(stream: CFReadStreamRef; 
  propertyName: CFStringRef; propertyValue: CFTypeRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFReadStreamSetProperty';
{$EXTERNALSYM CFReadStreamSetProperty}
function CFWriteStreamSetProperty(stream: CFWriteStreamRef; 
  propertyName: CFStringRef; propertyValue: CFTypeRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFWriteStreamSetProperty';
{$EXTERNALSYM CFWriteStreamSetProperty}

{ Asynchronous processing - If you wish to neither poll nor block, you may register 
   a client to hear about interesting events that occur on a stream.  Only one client
   per stream is allowed; registering a new client replaces the previous one.

   Once you have set a client, you need to schedule a run loop on which that client
   can be notified.  You may schedule multiple run loops (for instance, if you are 
   using a thread pool).  The client callback will be triggered via one of the scheduled
   run loops; It is the caller's responsibility to ensure that at least one of the 
   scheduled run loops is being run.

   NOTE: Unlike other CoreFoundation APIs, pasing a NULL clientContext here will remove
   the client.  If you do not care about the client context (i.e. your only concern
   is that your callback be called), you should pass in a valid context where every
   entry is 0 or NULL.

 }

function CFReadStreamSetClient(stream: CFReadStreamRef; 
  streamEvents: CFOptionFlags; clientCB: CFReadStreamClientCallBack; 
  clientContext: PCFStreamClientContext): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFReadStreamSetClient';
{$EXTERNALSYM CFReadStreamSetClient}
function CFWriteStreamSetClient(stream: CFWriteStreamRef; 
  streamEvents: CFOptionFlags; clientCB: CFWriteStreamClientCallBack; 
  clientContext: PCFStreamClientContext): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFWriteStreamSetClient';
{$EXTERNALSYM CFWriteStreamSetClient}

procedure CFReadStreamScheduleWithRunLoop(stream: CFReadStreamRef; 
  runLoop: CFRunLoopRef; runLoopMode: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFReadStreamScheduleWithRunLoop';
{$EXTERNALSYM CFReadStreamScheduleWithRunLoop}
procedure CFWriteStreamScheduleWithRunLoop(stream: CFWriteStreamRef; 
  runLoop: CFRunLoopRef; runLoopMode: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFWriteStreamScheduleWithRunLoop';
{$EXTERNALSYM CFWriteStreamScheduleWithRunLoop}

procedure CFReadStreamUnscheduleFromRunLoop(stream: CFReadStreamRef; 
  runLoop: CFRunLoopRef; runLoopMode: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFReadStreamUnscheduleFromRunLoop';
{$EXTERNALSYM CFReadStreamUnscheduleFromRunLoop}
procedure CFWriteStreamUnscheduleFromRunLoop(stream: CFWriteStreamRef; 
  runLoop: CFRunLoopRef; runLoopMode: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFWriteStreamUnscheduleFromRunLoop';
{$EXTERNALSYM CFWriteStreamUnscheduleFromRunLoop}


{ The following API is deprecated starting in 10.5; please use CFRead/WriteStreamCopyError(), above, instead }
const
  kCFStreamErrorDomainCustom      = -1;   { custom to the kind of stream in question }
  {$EXTERNALSYM kCFStreamErrorDomainCustom}
  kCFStreamErrorDomainPOSIX       = 1;    { POSIX errno; interpret using <sys/errno.h> }
  {$EXTERNALSYM kCFStreamErrorDomainPOSIX}
  kCFStreamErrorDomainMacOSStatus = 2;   { OSStatus type from Carbon APIs; interpret using <MacTypes.h> }
  {$EXTERNALSYM kCFStreamErrorDomainMacOSStatus}
type
  CFStreamErrorDomain = CFIndex; 
  {$EXTERNALSYM CFStreamErrorDomain}

  PCFStreamError = ^CFStreamError;
  CFStreamError = record
    domain: CFIndex;
    error: SInt32;
  end;
  {$EXTERNALSYM CFStreamError}
function CFReadStreamGetError(stream: CFReadStreamRef): CFStreamError; cdecl;
  external CoreFoundationLib name _PU + 'CFReadStreamGetError';
{$EXTERNALSYM CFReadStreamGetError}
function CFWriteStreamGetError(stream: CFWriteStreamRef): CFStreamError; cdecl;
  external CoreFoundationLib name _PU + 'CFWriteStreamGetError';
{$EXTERNALSYM CFWriteStreamGetError}


{$ENDIF !__COREFOUNDATION_CFSTREAM__}

