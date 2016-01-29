{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Dirent;

{$WEAKPACKAGEUNIT}

interface

uses
  Posix.Base, Posix.SysTypes;

{$IFDEF MACOS}
{$I osx/DirentTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/DirentTypes.inc}
{$ENDIF LINUX}

{$I DirentAPI.inc}

{$HPPEMIT '#include <dirent.h>'}

{ Convert between stat structure types and directory types.  }
function IFTODT(mode: mode_t): Integer;
{$EXTERNALSYM IFTODT}

function DTTOIF(dirtype: Integer): mode_t;
{$EXTERNALSYM DTTOIF}

implementation

function IFTODT(mode: mode_t): Integer;
begin
  Result := (mode and $F000) shr  12;
end;

function DTTOIF(dirtype: Integer): mode_t;
begin
  Result := dirtype shl 12;
end;

end.
