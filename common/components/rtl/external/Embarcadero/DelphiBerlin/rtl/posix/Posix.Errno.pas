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

unit Posix.Errno;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base;

{$IFDEF MACOS}
{$I osx/ErrnoTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/ErrnoTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/ErrnoTypes.inc}
{$ENDIF LINUX}

{$I ErrnoAPI.inc}

function errno: Integer; inline;
{$EXTERNALSYM errno}

implementation

function errno: Integer;
begin
  Result := __error()^;
end;

end.
