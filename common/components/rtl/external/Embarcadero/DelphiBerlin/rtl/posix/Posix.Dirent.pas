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

unit Posix.Dirent;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses
  Posix.Base, Posix.SysTypes;

{$IFDEF MACOS}
{$I osx/DirentTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/DirentTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/DirentTypes.inc}
{$ENDIF}

{$I DirentAPI.inc}

{$HPPEMIT '#include <dirent.h>'}
{$IFNDEF ANDROID}
{ Convert between stat structure types and directory types.  }
function IFTODT(mode: mode_t): Integer;
{$EXTERNALSYM IFTODT}

function DTTOIF(dirtype: Integer): mode_t;
{$EXTERNALSYM DTTOIF}
{$ENDIF}
implementation
{$IFNDEF ANDROID}
function IFTODT(mode: mode_t): Integer;
begin
  Result := (mode and $F000) shr  12;
end;

function DTTOIF(dirtype: Integer): mode_t;
begin
  Result := dirtype shl 12;
end;
{$ENDIF}
end.
