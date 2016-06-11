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

unit Posix.Sched;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base, Posix.SysTypes;

{$HPPEMIT '#include <sched.h>' }

{$IFDEF MACOS}
{$I osx/SchedTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/SchedTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/SchedTypes.inc}
{$ENDIF}

{$I SchedAPI.inc}

implementation

end.
