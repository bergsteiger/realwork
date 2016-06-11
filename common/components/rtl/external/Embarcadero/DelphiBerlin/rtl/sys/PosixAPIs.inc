{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$IFDEF POSIX}

{
  System.pas and SysInit.pas cannot use the POSIX units directly, so we manually
  include the type and API definitions here, along with some glue to manage conflicts
  that are inherent.
}

{$IFDEF MACOS}
{$I ../posix/osx/BaseTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/BaseTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/BaseTypes.inc}
{$ENDIF MACOS}

{$IFDEF MACOS}
{$I ../posix/osx/StdDefTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/StdDefTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/StdDefTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/SysTypesTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/SysTypesTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/SysTypesTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/StdlibTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/StdlibTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/StdlibTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/TimeTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/TimeTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/TimeTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/SysTimeTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/SysTimeTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/SysTimeTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/SysTimesTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/SysTimesTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/SysTimesTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/PthreadTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/PthreadTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/PthreadTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/DlfcnTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/DlfcnTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/DlfcnTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/FcntlTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/FcntlTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/FcntlTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/StdioTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/StdioTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/StdioTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/SysStatTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/SysStatTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/SysStatTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/SysMmanTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/SysMmanTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/SysMmanTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/UnistdTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/UnistdTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/UnistdTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/ErrnoTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/ErrnoTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/ErrnoTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/SchedTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/SchedTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/SchedTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/SignalTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/SignalTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/SignalTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/WcharTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/WcharTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/WcharTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/WctypeTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/WctypeTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/WctypeTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/IconvTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/IconvTypes.inc}
{$ENDIF LINUX}
// iconv not working on android

{$IFDEF MACOS}
{$I ../posix/osx/LocaleTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/LocaleTypes.inc}
{$ENDIF LINUX}
// locales not working on android

{$IFDEF MACOS}
{$I ../posix/osx/LanginfoTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/LanginfoTypes.inc}
{$ENDIF}
// langinfo not working on android

{$IFDEF MACOS}
{$I ../posix/osx/SysSysctlTypes.inc}
{$ELSEIF defined(LINUX)}
{$I ../posix/linux/SysSysctlTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I ../posix/android/SysSysctlTypes.inc}
{$ENDIF LINUX}

{$I ../posix/StdlibAPI.inc}
{$I ../posix/StdioAPI.inc}
{$I ../posix/StringAPI.inc}
{$I ../posix/SignalAPI.inc}
{$I ../posix/PthreadAPI.inc}
{$I ../posix/SchedAPI.inc}
{$I ../posix/DlfcnAPI.inc}
{$I ../posix/FcntlAPI.inc}
{$I ../posix/UnistdAPI.inc}
{$IFNDEF ANDROID}
{$I ../posix/IconvAPI.inc}
{$ENDIF ANDROID}
{$I ../posix/SysStatAPI.inc}
{$I ../posix/TimeAPI.inc}
{$I ../posix/SysMmanAPI.inc}
{$I ../posix/ErrnoAPI.inc}
{$I ../posix/WcharAPI.inc}
{$I ../posix/WctypeAPI.inc}
{$IFNDEF ANDROID}
{$I ../posix/LocaleAPI.inc}
{$I ../posix/LanginfoAPI.inc}
{$ENDIF ANDROID}
{$I ../posix/SysTimeAPI.inc}
{$I ../posix/SysTimesAPI.inc}
{$IFNDEF ANDROID}
{$I ../posix/SysSysctlAPI.inc}
{$ENDIF ANDROID}

function GetCurrentThreadID: TThreadID; cdecl; inline;
begin
  Result := TThreadID(pthread_self);
end;

function Yield: Integer; inline;
begin
  Result := sched_yield;
end;

{$IFDEF ANDROID}
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


{$ENDIF POSIX}
