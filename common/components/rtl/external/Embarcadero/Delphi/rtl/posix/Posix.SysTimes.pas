{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.SysTimes;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base, Posix.SysTypes, Posix.Time;

{$HPPEMIT '#include <sys/times.h>' }

{$IFDEF MACOS}
{$I osx/SysTimesTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/SysTimesTypes.inc}
{$ENDIF LINUX}

{$I SysTimesAPI.inc}

implementation

end.
