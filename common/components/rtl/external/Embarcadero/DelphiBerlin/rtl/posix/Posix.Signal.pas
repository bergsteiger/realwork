{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Signal;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base, Posix.SysTypes;

{$IFDEF MACOS}
{$I osx/SignalTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/SignalTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/SignalTypes.inc}
{$ENDIF}

{$I SignalAPI.inc}

{$IFDEF ANDROID}
function sigaddset(var SigSet: sigset_t; SigNum: Integer): Integer; inline; 
{$EXTERNALSYM sigaddset}

function sigemptyset(var SigSet: sigset_t): Integer; inline; 
{$EXTERNALSYM sigemptyset}

function sigfillset(var SigSet: sigset_t): Integer; inline; 
{$EXTERNALSYM sigfillset}

function sigdelset(var SigSet: sigset_t; SigNum: Integer): Integer; inline; 
{$EXTERNALSYM sigdelset}

function sigismember(var SigSet: sigset_t; SigNum: Integer): Integer; inline; 
{$EXTERNALSYM sigismember}

{$ENDIF  ANDROID}

(*$HPPEMIT '#include <signal.h>' *)
{$IFDEF ANDROID}
(*$HPPEMIT 'typedef struct sigaction sigaction_t;' *)
(*$HPPEMIT 'typedef struct sigcontext sigcontext_t;' *)
{$ENDIF ANDROID}
{$IFDEF MACOS}
(*$HPPEMIT 'typedef struct sigaction sigaction_t;' *)
(*$HPPEMIT 'typedef struct __darwin_i386_exception_state exception_state;' *)
(*$HPPEMIT 'typedef struct __darwin_i386_thread_state thread_state;' *)
(*$HPPEMIT 'typedef struct __darwin_mmst_reg mmst_reg;' *)
(*$HPPEMIT 'typedef struct __darwin_xmm_reg xmm_reg;' *)
(*$HPPEMIT 'typedef struct __darwin_i386_float_state float_state;' *)
{$ENDIF MACOS}

implementation

{$IFDEF ANDROID}
uses Posix.String_;

function sigaddset(var SigSet: sigset_t; SigNum: Integer): Integer;
type
{$POINTERMATH ON}
  Psigset_t = ^sigset_t;
{$POINTERMATH OFF}
var
  local_set: Psigset_t;
  Index, Offset : UInt32;
begin
  local_set := @SigSet;
  Dec(SigNum);
  Index := SigNum div LONG_BIT;
  Offset := SigNum mod LONG_BIT;
  (local_set + Index)^ := (local_set + Index)^ or ( UInt32(1) shl Offset );
  Result := 0;
end;

function sigemptyset(var SigSet: sigset_t): Integer;
begin
  memset(SigSet, 0, SizeOf(SigSet));
  Result := 0; 
end;

function sigfillset(var SigSet: sigset_t): Integer;
begin
  memset(SigSet, not 0, SizeOf(SigSet));
  Result := 0;
end;

function sigdelset(var SigSet: sigset_t; SigNum: Integer): Integer;
type
{$POINTERMATH ON}
  Psigset_t = ^sigset_t;
{$POINTERMATH OFF}
var
  local_set: Psigset_t;
  Index, Offset : UInt32;
begin
  local_set := @SigSet;
  Dec(SigNum);
  Index := SigNum div LONG_BIT;
  Offset := SigNum mod LONG_BIT;
  (local_set + Index)^ := (local_set + Index)^ and (not ( UInt32(1) shl Offset ));
  Result := 0;
end;

function sigismember(var SigSet: sigset_t; SigNum: Integer): Integer;
type
{$POINTERMATH ON}
  Psigset_t = ^sigset_t;
{$POINTERMATH OFF}
var
  local_set: Psigset_t;
  Index, Offset : UInt32;
begin
  local_set := @SigSet;
  Dec(SigNum);
  Index := SigNum div LONG_BIT;
  Offset := SigNum mod LONG_BIT;
  Result := Integer((local_set + Index)^ and ( UInt32(1) shl Offset ));
end;
{$ENDIF ANDROID}

end.
