{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.SysTime;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base, Posix.SysTypes, Posix.Time;

{$HPPEMIT '#include <sys/time.h>' }

{$IFDEF MACOS}
{$I osx/SysTimeTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/SysTimeTypes.inc}
{$ENDIF LINUX}

type
  time_t = Posix.SysTypes.time_t;
  {$EXTERNALSYM time_t}
  suseconds_t = Posix.SysTypes.suseconds_t;
  {$EXTERNALSYM suseconds_t}

{$I SysTimeAPI.inc}

implementation

end.
