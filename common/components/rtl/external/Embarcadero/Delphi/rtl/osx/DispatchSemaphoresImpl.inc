{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

const
{$IF NOT DECLARED(_PU)}
  {$IFDEF UNDERSCOREIMPORTNAME}
  _PU = '_';
  {$ELSE}
  _PU = '';
  {$ENDIF}
{$ENDIF}
  dispatchlib = '/usr/lib/libSystem.dylib';


function dispatch_semaphore_create(value: Integer): dispatch_semaphore_t; cdecl;
  external dispatchlib name _PU + 'dispatch_semaphore_create';

function dispatch_semaphore_wait(dsema: dispatch_semaphore_t; timeout: dispatch_time_t): Integer; cdecl;
  external dispatchlib name _PU + 'dispatch_semaphore_wait';

function dispatch_semaphore_signal(dsema: dispatch_semaphore_t): Integer; cdecl;
  external dispatchlib name _PU + 'dispatch_semaphore_signal';

procedure dispatch_release(obj: dispatch_object_t); cdecl;
  external dispatchlib name _PU + 'dispatch_release';

function dispatch_time(when: dispatch_time_t; delta: Int64): dispatch_time_t; cdecl;
  external dispatchlib name _PU + 'dispatch_time';

