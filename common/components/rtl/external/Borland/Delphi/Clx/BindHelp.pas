{ *************************************************************************** }
{                                                                             }
{ Delphi and Kylix Cross-Platform Visual Component Library                    }
{                                                                             }
{ Copyright (c) 2000, 2001 Borland Software Corporation                       }
{                                                                             }
{ Licensees holding a valid Borland No-Nonsense License for this Software may }
{ use this file in accordance with such license, which appears in the file    }
{ license.txt that came with this Software.                                   }
{                                                                             }
{ *************************************************************************** }


unit BindHelp;

interface

var
  {
    Indicates the quality of the BindHelp unit's interface.
    More is better.
  }
  BindHelp_Deluxe_Interface: Integer = 42;

procedure CopyUnicodeToPWideString(Unicode: PWideChar; var S: WideString;
  Len: Integer); cdecl; export;

implementation

uses
  {$IFDEF LINUX}
  Libc,
  {$ENDIF}
  SysUtils, Qt, Types;

// AnsiString Helpers
procedure CopyCharsToPAnsiString(Chars: PAnsiChar; var S: AnsiString); cdecl; export;
begin
  S := Chars;
end;

function CharsOfPAnsiString(var S: AnsiString): PAnsiChar; cdecl; export;
begin
  Result := PAnsiChar(Pointer(S));
end;

procedure InitPAnsiString(var S: PAnsiString); cdecl; export;
begin
  New(S);
end;

procedure FinalPAnsiString(var S: PAnsiString); cdecl; export;
begin
  Dispose(S);
end;

// WideString Helpers
procedure CopyUnicodeToPWideString(Unicode: PWideChar; var S: WideString;
  Len: Integer); cdecl; export;
{$IFDEF LINUX}
var
  I: Integer;
begin
  SetLength(S, Len);
  for I := 0 to Len - 1 do
    Word(S[I + 1]) := Swap(Word(Unicode[I]));
end;
{$ENDIF}
{$IFDEF MSWINDOWS}
begin
  SetString(S, Unicode, Len);
end;
{$ENDIF}

function UnicodeOfPWideString(var S: WideString): PWideChar; cdecl; export;
const
  cEmptyStr = '';
begin
  if @S = nil then
    Result := cEmptyStr
  else
    Result := PWideChar(Pointer(S));
end;

function LengthOfPWideString(var S: WideString): Integer; cdecl; export;
begin
  if @S <> nil then
    Result := Length(S)
  else
    Result := 0;
end;

procedure InitPWideString(var S: PWideString); cdecl; export;
begin
  New(S);
end;

procedure FinalPWideString(var S: PWideString); cdecl; export;
begin
  Dispose(S);
end;

// TPointArray helpers
function GetPointsPtr(const PA: TPointArray): Pointer; cdecl; export;
begin
  Result := @PA[0];
end;

function GetPointsLength(const PA: TPointArray): Integer; cdecl; export;
begin
  Result := Length(PA);
end;

procedure SetPointsLength(var PA: TPointArray; Len: Integer); cdecl; export;
begin
  SetLength(PA, Len);
end;

// Int array helpers
function GetIntsPtr(const PA: TIntArray): Pointer; cdecl; export;
begin
  Result := @PA[0];
end;

function GetIntsLength(const PA: TIntArray): Integer; cdecl; export;
begin
  Result := Length(PA);
end;

procedure SetIntsLength(var PA: TIntArray; Len: Integer); cdecl; export;
begin
  SetLength(PA, Len);
end;

{$IFDEF LINUX}

// fun with the Linux loader!
procedure InitLibQt;
const
  QtLibNames: array[Boolean] of string = (
    'libqt.so.2', 'libborqt-6.9-qt2.3.so' );
  QtShareNames: array[Boolean] of string = (
    'libqtintf-6.9-qt2.3.so', 'libborqt-6.9-qt2.3.so');
var
  StaticallyBound: Boolean;
  UseBorQt: Boolean;
begin
  UseBorQt := GetModuleHandle(PChar(QtShareNames[True])) <> 0;
  StaticallyBound := UseBorQt or (GetModuleHandle(PChar(QtShareNames[False])) <> 0);
  if not StaticallyBound then
  begin
    UseBorQt := GetEnvironmentVariable('CLX_USE_LIBQT') = '';
    dlopen(PChar(QtShareNames[UseBorQt]), RTLD_LAZY or RTLD_GLOBAL);
  end;
  Qt.QtIntf := QtShareNames[UseBorQt];
  Qt.QtLib := QtLibNames[UseBorQt];
end;

{$ENDIF}

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Clx\BindHelp.pas initialization enter'); {$EndIf}
{$IFDEF LINUX}
  InitLibQt;
{$ENDIF}
  Qt.InitializePAnsiString(@CopyCharsToPAnsiString, @CharsOfPAnsiString,
    @InitPAnsiString, @FinalPAnsiString);
  Qt.InitializePWideString(@CopyUnicodeToPWideString, @UnicodeOfPWideString,
    @LengthOfPWideString, @InitPWideString, @FinalPWideString);
  Qt.InitializePPointArray(@GetPointsPtr, @GetPointsLength, @SetPointsLength);
  Qt.InitializePIntArray(@GetIntsPtr, @GetIntsLength, @SetIntsLength);

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Clx\BindHelp.pas initialization leave'); {$EndIf}
end.
