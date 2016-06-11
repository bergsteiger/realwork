{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{
  This function is not what users will generally call.  The true errno API is
  defined in PosixErrno.pas.
}

function __error: PInteger; cdecl;
{$IFDEF MACOS}
external libc name _PU + '__error';
{$ENDIF}
{$IFDEF LINUX}
external libc name _PU + '__errno_location';
{$ENDIF}
{$IFDEF ANDROID}
external libc name _PU + '__errno';
{$ENDIF}
{$EXTERNALSYM __error}

