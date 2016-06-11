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

unit Posix.Semaphore;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base,
{$IF defined(LINUX) or defined(ANDROID)}
  Posix.Time,
{$ENDIF LINUX or ANDROID}
  Posix.SysTypes;

{$IFDEF MACOS}
{$I osx/SemaphoreTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/SemaphoreTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/SemaphoreTypes.inc}
{$ENDIF}

{$I SemaphoreAPI.inc}

implementation

end.
