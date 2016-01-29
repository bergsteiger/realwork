{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{
  This function is not what users will generally call.  The true errno API is
  defined in PosixErrno.pas.
}

function __error: PInteger; cdecl
{$IFDEF MACOS}
external libc name _PU + '__error';
{$ENDIF}
{$IFDEF LINUX}
external libc name _PU + '__errno_location';
{$ENDIF}
{$EXTERNALSYM __error}
