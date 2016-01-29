{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
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
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/BaseTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/StdDefTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/StdDefTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/SysTypesTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/SysTypesTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/StdlibTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/StdlibTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/TimeTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/TimeTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/SysTimeTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/SysTimeTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/SysTimesTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/SysTimesTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/PthreadTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/PthreadTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/DlfcnTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/DlfcnTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/FcntlTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/FcntlTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/StdioTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/StdioTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/SysStatTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/SysStatTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/SysMmanTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/SysMmanTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/UnistdTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/UnistdTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/ErrnoTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/ErrnoTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/SchedTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/SchedTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/SignalTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/SignalTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/WcharTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/WcharTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/WctypeTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/WctypeTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/IconvTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/IconvTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/LocaleTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/LocaleTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I ../posix/osx/SysSysctlTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I ../posix/linux/SysSysctlTypes.inc}
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
{$I ../posix/IconvAPI.inc}
{$I ../posix/SysStatAPI.inc}
{$I ../posix/TimeAPI.inc}
{$I ../posix/SysMmanAPI.inc}
{$I ../posix/ErrnoAPI.inc}
{$I ../posix/WcharAPI.inc}
{$I ../posix/WctypeAPI.inc}
{$I ../posix/LocaleAPI.inc}
{$I ../posix/SysTimeAPI.inc}
{$I ../posix/SysTimesAPI.inc}
{$I ../posix/SysSysctlAPI.inc}

function GetCurrentThreadID: TThreadID; cdecl; inline;
begin
  Result := TThreadID(pthread_self);
end;

function Yield: Integer; inline;
begin
  Result := sched_yield;
end;

{$ENDIF POSIX}
