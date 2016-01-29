{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
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
  
const
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

function dispatch_queue_create(QueueLabel: MarshaledAString; attr: dispatch_queue_t): dispatch_queue_t; cdecl; external libdispatch name _PU + 'dispatch_queue_create';
procedure dispatch_release(obj: dispatch_object_t); cdecl; external libdispatch name _PU + 'dispatch_release';

implementation

end.
