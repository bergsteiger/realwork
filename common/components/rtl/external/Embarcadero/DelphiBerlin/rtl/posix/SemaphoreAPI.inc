{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}


function sem_close(var sem: sem_t): Integer; cdecl;
  external libc name _PU + 'sem_close';
{$EXTERNALSYM sem_close}

function sem_destroy(var sem: sem_t): Integer; cdecl;
  external libc name _PU + 'sem_destroy';
{$EXTERNALSYM sem_destroy}

{ Get current value of SEM and store it in *SVAL. }
function sem_getvalue(var sem: sem_t; var sval: Integer): Integer; cdecl;
  external libc name _PU + 'sem_getvalue';
{$EXTERNALSYM sem_getvalue}

{ Initialize semaphore object SEM to VALUE.  If PSHARED then share it
  with other processes. }
function sem_init(var sem: sem_t; pshared: Integer; value: Cardinal): Integer; cdecl;
  external libc name _PU + 'sem_init';
{$EXTERNALSYM sem_init}

//TODO -otgerdes -cHeader Translation: Add overload for O_CREAT version that takes (const char*, int, mode_t, unsigned)
function sem_open(name: MarshaledAString; oflag: Integer): Psem_t; cdecl; varargs;
  external libc name _PU + 'sem_open';
{$EXTERNALSYM sem_open}

{ Post SEM. }
function sem_post(var sem: sem_t): Integer; cdecl;
  external libc name _PU + 'sem_post';
{$EXTERNALSYM sem_post}

{ Test whether SEM is posted. }
function sem_trywait(var sem: sem_t): Integer; cdecl;
  external libc name _PU + 'sem_trywait';
{$EXTERNALSYM sem_trywait}

function sem_unlink(name: MarshaledAString): Integer; cdecl;
  external libc name _PU + 'sem_unlink';
{$EXTERNALSYM sem_unlink}

{ Wait for SEM being posted. }
function sem_wait(var sem: sem_t): Integer; cdecl;
  external libc name _PU + 'sem_wait';
{$EXTERNALSYM sem_wait}

{$IF defined(LINUX) or defined(ANDROID)}
function sem_timedwait(var sem: sem_t; var abs_timeout: timespec): Integer; cdecl;
  external libc name _PU + 'sem_timedwait';
{$EXTERNALSYM sem_wait}
{$ENDIF LINUX or ANDROID}
