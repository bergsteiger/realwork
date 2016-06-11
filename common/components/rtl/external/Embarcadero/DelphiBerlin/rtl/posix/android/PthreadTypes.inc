{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

const
  PTHREAD_CANCEL_ASYNCHRONOUS = $1;
  {$EXTERNALSYM PTHREAD_CANCEL_ASYNCHRONOUS}
  PTHREAD_CANCEL_ENABLE = $0;
  {$EXTERNALSYM PTHREAD_CANCEL_ENABLE}
  PTHREAD_CANCEL_DEFERRED = $0;
  {$EXTERNALSYM PTHREAD_CANCEL_DEFERRED}
  PTHREAD_CANCEL_DISABLE = $1;
  {$EXTERNALSYM PTHREAD_CANCEL_DISABLE}
  PTHREAD_CANCELED = $ffffffff;
  {$EXTERNALSYM PTHREAD_CANCELED}
  PTHREAD_CREATE_DETACHED = $1;
  {$EXTERNALSYM PTHREAD_CREATE_DETACHED}
  PTHREAD_CREATE_JOINABLE = $0;
  {$EXTERNALSYM PTHREAD_CREATE_JOINABLE}
  PTHREAD_EXPLICIT_SCHED = $1;
  {$EXTERNALSYM PTHREAD_EXPLICIT_SCHED}
  PTHREAD_INHERIT_SCHED = $0;
  {$EXTERNALSYM PTHREAD_INHERIT_SCHED}
  PTHREAD_PROCESS_SHARED = $1;
  {$EXTERNALSYM PTHREAD_PROCESS_SHARED}
  PTHREAD_PROCESS_PRIVATE = $0;
  {$EXTERNALSYM PTHREAD_PROCESS_PRIVATE}
  PTHREAD_SCOPE_PROCESS = $1;
  {$EXTERNALSYM PTHREAD_SCOPE_PROCESS}
  PTHREAD_SCOPE_SYSTEM = $0;
  {$EXTERNALSYM PTHREAD_SCOPE_SYSTEM}
  PTHREAD_MUTEX_RECURSIVE = 1;
  {$EXTERNALSYM PTHREAD_MUTEX_RECURSIVE}

type
  TInitOnceProc = procedure; cdecl;
  TKeyValueDestructor = procedure(ValueInKey: Pointer); cdecl;
  TPThreadFunc = function(Parameter: Pointer): Pointer; cdecl;
