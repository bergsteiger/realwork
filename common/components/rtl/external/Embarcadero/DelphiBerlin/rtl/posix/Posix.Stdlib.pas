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

unit Posix.Stdlib;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses
  Posix.Base, Posix.SysTypes, Posix.StdDef;

{$IFDEF MACOS}
{$I osx/StdlibTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/StdlibTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/StdlibTypes.inc}
{$ENDIF}

{$I StdlibAPI.inc}

{$IFDEF ANDROID}

function strtof(const Nptr: MarshaledAString; EndPtr: PMarshaledAString): Single;
function atof(const Nptr: MarshaledAString): Double;
function _abs(I: Integer):Integer;
function labs(I: Int32): Int32;
function llabs(I: Int64): Int64;
function rand: Integer;
procedure srand(S: Cardinal);
function _random: LongInt;
procedure srandom(S: Cardinal);
function grantpt(Fildes : Integer): Integer;
function atexit(S: TAtexitFunc): Integer;

{$ENDIF}
implementation
{$IFDEF ANDROID}

function __cxa_atexit(S: TAtexitFunc; arg,dso: Pointer):Integer; cdecl;
  external libc name _PU + '__cxa_atexit';

function atexit(S: TAtexitFunc):Integer;
begin
  Result := __cxa_atexit(S, nil, nil);
end;

function strtof(const Nptr: MarshaledAString; EndPtr: PMarshaledAString): Single;
begin
  Result := strtod(Nptr,EndPtr);
end;

function atof(const Nptr: MarshaledAString): Double;
begin
  Result := strtod(Nptr,nil);
end;

function _abs(I: Integer): Integer;
begin
  if ( I < 0) then
    Result := - I
  else
    Result := I;
end;

function labs(I: Int32): Int32;
begin
  if (I < 0) then
    Result := -I
  else
    Result := I;
end;

function llabs(I: Int64): Int64;
begin
  if (I < 0) then
    Result := -I
  else
    Result := I;
end;

function rand: Integer;
begin
  Result := lrand48();
end;

procedure srand(S: Cardinal);
begin
   srand48(S);
end;

function _random: LongInt;
begin
  Result := lrand48();
end;

procedure srandom(S: Cardinal);
begin
  srand48(S);
end;

function grantpt(Fildes: Integer):Integer;
begin
    Result := 0;
end;

{$ENDIF}

end.
