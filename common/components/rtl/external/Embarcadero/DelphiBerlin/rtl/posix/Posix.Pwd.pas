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

unit Posix.Pwd;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base, Posix.SysTypes;

{$HPPEMIT '#include <pwd.h>' }

// Not defined on mobile platforms (IOS and ANDROID)

{$IFDEF MACOS}
  {$IFNDEF IOS}
  {$I osx/PwdTypes.inc}
  {$ENDIF !IOS}
{$ELSEIF defined(LINUX)}
{$I linux/PwdTypes.inc}
{$ENDIF}

{$IF not defined(IOS) and not defined(ANDROID)}
{$I PwdAPI.inc}
{$ENDIF !IOS and !ANDROID}

implementation

end.
