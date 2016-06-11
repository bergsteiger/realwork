{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.Looper;

interface

(*$HPPEMIT '#include <android/looper.h>' *)

{$I Androidapi.inc}

const
{ Option for ALooper_prepare: this looper will accept calls to
  ALooper_addFd() that do not have a callback (that is provide NULL
  for the callback).  In this case the caller of ALooper_pollOnce()
  or ALooper_pollAll() MUST check the return from these functions to
  discover when data is available on such fds and process it.
}
  ALOOPER_PREPARE_ALLOW_NON_CALLBACKS = 1 shl 0;
  {$EXTERNALSYM ALOOPER_PREPARE_ALLOW_NON_CALLBACKS}

const
{ Result from ALooper_pollOnce() and ALooper_pollAll():
  The poll was awoken using wake() before the timeout expired
  and no callbacks were executed and no other file descriptors were ready.
}
  ALOOPER_POLL_WAKE = -1;
  {$EXTERNALSYM ALOOPER_POLL_WAKE}
  
{ Result from ALooper_pollOnce() and ALooper_pollAll():
  One or more callbacks were executed.
}
  ALOOPER_POLL_CALLBACK = -2;
  {$EXTERNALSYM ALOOPER_POLL_CALLBACK}
  
{ Result from ALooper_pollOnce() and ALooper_pollAll():
  The timeout expired.
}
  ALOOPER_POLL_TIMEOUT = -3;
  {$EXTERNALSYM ALOOPER_POLL_TIMEOUT}
{ Result from ALooper_pollOnce() and ALooper_pollAll():
  An error occurred.
}
  ALOOPER_POLL_ERROR = -4;
  {$EXTERNALSYM ALOOPER_POLL_ERROR}

  
{ Flags for file descriptor events that a looper can monitor.
  
  These flag bits can be combined to monitor multiple events at once.
}

const
{ The file descriptor is available for read operations.
}
  ALOOPER_EVENT_INPUT = 1 shl 0;
  {$EXTERNALSYM ALOOPER_EVENT_INPUT}
  
{ The file descriptor is available for write operations.
}
  ALOOPER_EVENT_OUTPUT = 1 shl 1;
  {$EXTERNALSYM ALOOPER_EVENT_OUTPUT}
  
{ The file descriptor has encountered an error condition.
  
  The looper always sends notifications about errors; it is not necessary
  to specify this event flag in the requested event set.
}
  ALOOPER_EVENT_ERROR = 1 shl 2;
  {$EXTERNALSYM ALOOPER_EVENT_ERROR}
  
{ The file descriptor was hung up.
  For example, indicates that the remote end of a pipe or socket was closed.
  
  The looper always sends notifications about hangups; it is not necessary
  to specify this event flag in the requested event set.
}
  ALOOPER_EVENT_HANGUP = 1 shl 3;
  {$EXTERNALSYM ALOOPER_EVENT_HANGUP}
  
{ The file descriptor is invalid.
  For example, the file descriptor was closed prematurely.
  
  The looper always sends notifications about invalid file descriptors; it is not necessary
  to specify this event flag in the requested event set.
}
  ALOOPER_EVENT_INVALID = 1 shl 4;
  {$EXTERNALSYM ALOOPER_EVENT_INVALID}
  


  

type
  ALooper = record end;
  {$EXTERNALSYM ALooper}
  
  PALooper = ^ALooper;

{ Returns the looper associated with the calling thread, or NULL if
  there is not one.
}

function ALooper_forThread: PALooper; cdecl;
  external AndroidLib name 'ALooper_forThread';
{$EXTERNALSYM ALooper_forThread}

{ Prepares a looper associated with the calling thread, and returns it.
  If the thread already has a looper, it is returned.  Otherwise, a new
  one is created, associated with the thread, and returned.
  
  The opts may be ALOOPER_PREPARE_ALLOW_NON_CALLBACKS or 0.
}

function ALooper_prepare(Options: Integer): PALooper; cdecl;
  external AndroidLib name 'ALooper_prepare';
{$EXTERNALSYM ALooper_prepare}
  
{ Acquire a reference on the given ALooper object.  This prevents the object
  from being deleted until the reference is removed.  This is only needed
  to safely hand an ALooper from one thread to another.
}

procedure ALooper_acquire(Looper: PALooper); cdecl;
  external AndroidLib name 'ALooper_acquire';
{$EXTERNALSYM ALooper_acquire}

{ Remove a reference that was previously acquired with ALooper_acquire().
}

procedure ALooper_release(Looper: PALooper); cdecl;
  external AndroidLib name 'ALooper_release';
{$EXTERNALSYM ALooper_release}

{ For callback-based event loops, this is the prototype of the function
  that is called.  It is given the file descriptor it is associated with,
  a bitmask of the poll events that were triggered (typically ALOOPER_EVENT_INPUT),
  and the data pointer that was originally supplied.
  
  Implementations should return 1 to continue receiving callbacks, or 0
  to have this file descriptor and callback unregistered from the looper.
}

type
  ALooper_callbackFunc = function(FileDescriptor, Events: Integer; Data: Pointer): Integer; cdecl;
  {$EXTERNALSYM ALooper_callbackFunc}

{ Waits for events to be available, with optional timeout in milliseconds.
  Invokes callbacks for all file descriptors on which an event occurred.
  
  If the timeout is zero, returns immediately without blocking.
  If the timeout is negative, waits indefinitely until an event appears.
  
  Returns ALOOPER_POLL_WAKE if the poll was awoken using wake() before
  the timeout expired and no callbacks were invoked and no other file
  descriptors were ready.
  
  Returns ALOOPER_POLL_CALLBACK if one or more callbacks were invoked.
  
  Returns ALOOPER_POLL_TIMEOUT if there was no data before the given
  timeout expired.
  
  Returns ALOOPER_POLL_ERROR if an error occurred.
  
  Returns a value >= 0 containing an identifier if its file descriptor has data
  and it has no callback function (requiring the caller here to handle it).
  In this (and only this) case outFd, outEvents and outData will contain the poll
  events and data associated with the fd, otherwise they will be set to NULL.
  
  This method does not return until it has finished invoking the appropriate callbacks
  for all file descriptors that were signalled.
}
function ALooper_pollOnce(TimeOutMilliSeconds: Integer; OutFileDescriptor, OutEvents: PInteger; OutData: PPointer): Integer; cdecl;
  external AndroidLib name 'ALooper_pollOnce';
{$EXTERNALSYM ALooper_pollOnce}

{ Like ALooper_pollOnce(), but performs all pending callbacks until all
  data has been consumed or a file descriptor is available with no callback.
  This function will never return ALOOPER_POLL_CALLBACK.
}
function ALooper_pollAll(TimeOutMilliSeconds: Integer; OutFileDescriptor, OutEvents: PInteger; OutData: PPointer): Integer; cdecl;
  external AndroidLib name 'ALooper_pollAll';
{$EXTERNALSYM ALooper_pollAll}

{ Wakes the poll asynchronously.
  
  This method can be called on any thread.
  This method returns immediately.
}
procedure ALooper_wake(Looper: PALooper); cdecl;
  external AndroidLib name 'ALooper_wake';
{$EXTERNALSYM ALooper_wake}

{ Adds a new file descriptor to be polled by the looper.
  If the same file descriptor was previously added, it is replaced.
  
  "fd" is the file descriptor to be added.
  "ident" is an identifier for this event, which is returned from ALooper_pollOnce().
  The identifier must be >= 0, or ALOOPER_POLL_CALLBACK if providing a non-NULL callback.
  "events" are the poll events to wake up on.  Typically this is ALOOPER_EVENT_INPUT.
  "callback" is the function to call when there is an event on the file descriptor.
  "data" is a private data pointer to supply to the callback.
  
  There are two main uses of this function:
  
  (1) If "callback" is non-NULL, then this function will be called when there is
  data on the file descriptor.  It should execute any events it has pending,
  appropriately reading from the file descriptor.  The 'ident' is ignored in this case.
  
  (2) If "callback" is NULL, the 'ident' will be returned by ALooper_pollOnce
  when its file descriptor has data available, requiring the caller to take
  care of processing it.
  
  Returns 1 if the file descriptor was added or -1 if an error occurred.
  
  This method can be called on any thread.
  This method may block briefly if it needs to wake the poll.
}
function ALooper_addFd(Looper: PALooper; FileHandler, Ident, Events: Integer; Callback: ALooper_callbackFunc; Data: Pointer): Integer; cdecl;
  external AndroidLib name 'ALooper_addFd';
{$EXTERNALSYM ALooper_addFd}

{ Removes a previously added file descriptor from the looper.
  
  When this method returns, it is safe to close the file descriptor since the looper
  will no longer have a reference to it.  However, it is possible for the callback to
  already be running or for it to run one last time if the file descriptor was already
  signalled.  Calling code is responsible for ensuring that this case is safely handled.
  For example, if the callback takes care of removing itself during its own execution either
  by returning 0 or by calling this method, then it can be guaranteed to not be invoked
  again at any later time unless registered anew.
  
  Returns 1 if the file descriptor was removed, 0 if none was previously registered
  or -1 if an error occurred.
  
  This method can be called on any thread.
  This method may block briefly if it needs to wake the poll.
}

function ALooper_removeFd(Looper: PALooper; FileHandler: Integer): Integer; cdecl;
  external AndroidLib name 'ALooper_removeFd';
{$EXTERNALSYM ALooper_removeFd}

implementation

end.
