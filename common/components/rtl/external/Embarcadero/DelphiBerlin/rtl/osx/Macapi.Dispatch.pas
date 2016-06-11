{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

// Minimal interface to Apple's Grand Central Dispatch API
// for the functions needed for the AVFoundation, CoreVideo 
// and CoreMedia frameworks.
unit Macapi.Dispatch;

interface

type
  dispatch_object_t = IntPtr;
  dispatch_queue_t = dispatch_object_t;
  dispatch_function_t = procedure(context: Pointer); cdecl;

const
  libSystem = '/usr/lib/libSystem.dylib';
  libdispatch = '/usr/lib/system/libdispatch.dylib';
  DISPATCH_QUEUE_SERIAL = nil;

{$IF NOT DECLARED(_PU)}
const
  {$IFDEF UNDERSCOREIMPORTNAME}
  _PU = '_';
  {$ELSE}
  _PU = '';
  {$ENDIF}
  {$EXTERNALSYM _PU}
{$ENDIF}

//  This is a trick to be able to get the main queue in MacOs. As global variables
// are not accesible we declare a fake procedure to obtain a pointer to the variable
// and then derreference it with something like:
// mainQueue := dispatch_queue_t(@_dispatch_main_queue);
{$IF DEFINED(MACOS) AND NOT DEFINED(IOS)}
procedure _dispatch_main_queue; cdecl; external libdispatch name _PU + '_dispatch_main_q';
{$ENDIF}

function dispatch_queue_create(QueueLabel: MarshaledAString; attr: dispatch_queue_t): dispatch_queue_t; cdecl; external libSystem name _PU + 'dispatch_queue_create';
procedure dispatch_release(obj: dispatch_object_t); cdecl; external libSystem name _PU + 'dispatch_release';
procedure dispatch_async_f(queue: dispatch_queue_t; context: Pointer; work: dispatch_function_t); cdecl; external libSystem name _PU + 'dispatch_async_f';

implementation

end.
