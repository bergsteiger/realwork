{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

const
  PTHREAD_CANCEL_ASYNCHRONOUS = $0;
  {$EXTERNALSYM PTHREAD_CANCEL_ASYNCHRONOUS}
  PTHREAD_CANCEL_ENABLE = $1;
  {$EXTERNALSYM PTHREAD_CANCEL_ENABLE}
  PTHREAD_CANCEL_DEFERRED = $2;
  {$EXTERNALSYM PTHREAD_CANCEL_DEFERRED}
  PTHREAD_CANCEL_DISABLE = $0;
  {$EXTERNALSYM PTHREAD_CANCEL_DISABLE}
  PTHREAD_CANCELED = $1;
  {$EXTERNALSYM PTHREAD_CANCELED}
  PTHREAD_CREATE_DETACHED = $2;
  {$EXTERNALSYM PTHREAD_CREATE_DETACHED}
  PTHREAD_CREATE_JOINABLE = $1;
  {$EXTERNALSYM PTHREAD_CREATE_JOINABLE}
  PTHREAD_EXPLICIT_SCHED = $2;
  {$EXTERNALSYM PTHREAD_EXPLICIT_SCHED}
  PTHREAD_INHERIT_SCHED = $1;
  {$EXTERNALSYM PTHREAD_INHERIT_SCHED}
  PTHREAD_PROCESS_SHARED = $1;
  {$EXTERNALSYM PTHREAD_PROCESS_SHARED}
  PTHREAD_PROCESS_PRIVATE = $2;
  {$EXTERNALSYM PTHREAD_PROCESS_PRIVATE}
  PTHREAD_SCOPE_PROCESS = $2;
  {$EXTERNALSYM PTHREAD_SCOPE_PROCESS}
  PTHREAD_SCOPE_SYSTEM = $1;
  {$EXTERNALSYM PTHREAD_SCOPE_SYSTEM}

type
  TInitOnceProc = procedure; cdecl;
  TKeyValueDestructor = procedure(ValueInKey: Pointer); cdecl;
