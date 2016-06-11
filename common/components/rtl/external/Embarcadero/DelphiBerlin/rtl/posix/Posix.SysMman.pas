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

unit Posix.SysMman;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses
  Posix.Base, Posix.SysTypes;

{$IFDEF MACOS}
{$I osx/SysMmanTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/SysMmanTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/SysMmanTypes.inc}
{$ENDIF}

{$I SysMmanAPI.inc}

implementation

end.
