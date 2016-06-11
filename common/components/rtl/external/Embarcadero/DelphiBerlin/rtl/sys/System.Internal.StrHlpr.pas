{*****************************************************************}
{                                                                 }
{           CodeGear Delphi Runtime Library                       }
{                                                                 }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.                }
{              All rights reserved                                }
{                                                                 }
{*****************************************************************}

{*****************************************************************}
{  Helpers for C++ AnsiString/WideString/UnicodeString binding.   }
{*****************************************************************}

unit System.Internal.StrHlpr;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}
{$HPPEMIT LEGACYHPP}

{$WARN IMPLICIT_STRING_CAST OFF}
{$WARN IMPLICIT_STRING_CAST_LOSS OFF}

interface

{$IFNDEF NEXTGEN}
procedure UnicodeFromAnsi(var dst: UnicodeString; var src: System.RawByteString);
procedure UnicodeFromPChar(var dst: UnicodeString; src: System.PAnsiChar; IsUTF8: Boolean = False);
procedure UnicodeFromUTF8(var dst: UnicodeString; const src: System.PAnsiChar);
procedure UnicodeFromPWideChar(var dst: UnicodeString; src: System.PWideChar);
{$ELSE}
procedure UnicodeFromAnsi(var dst: UnicodeString; CodePage: Word; src: System.Pointer; Len: Integer = -1);
procedure UnicodeFromPChar(var dst: UnicodeString; src: System.Pointer; IsUTF8: Boolean = False);
procedure UnicodeFromUTF8(var dst: UnicodeString; const src: System.Pointer);
procedure UnicodeFromPWideChar(var dst: UnicodeString; src: System.Pointer);
{$ENDIF}


function UnicodeCat(var x, y: UnicodeString): UnicodeString;
function UnicodeCopy(var src: UnicodeString; index, count: Integer): UnicodeString;
function UnicodePos(var src, sub: UnicodeString): Integer;
procedure UnicodeAppend(var dst: UnicodeString; var src: UnicodeString);
procedure UnicodeDelete(var dst: UnicodeString; index, count: Integer);
procedure UnicodeInsert(var dst: UnicodeString; var src: UnicodeString; index: Integer);
function UnicodeEqual(var x, y: UnicodeString): Boolean;
function UnicodeGreater(var x, y: UnicodeString): Boolean;
function UnicodeLess(var x, y: UnicodeString): Boolean;

procedure UnicodeSetLength(var dst: UnicodeString; len: Integer);
procedure UnicodeFree(var s: UnicodeString);
procedure UnicodeAssign(var dst: UnicodeString; var src: UnicodeString);


{$IFNDEF NEXTGEN}
function AnsiCat(var x, y: System.RawByteString): System.RawByteString;
function AnsiCopy(var src: System.RawByteString; index, count: Integer): System.RawByteString;
function AnsiPos(var src, sub: System.RawByteString): Integer;
procedure AnsiAppend(var dst: System.RawByteString; var src: System.RawByteString);
procedure AnsiInsert(var dst: System.RawByteString; var src: System.RawByteString; index: Integer);
function AnsiEqual(var x, y: System.RawByteString): Boolean;
function AnsiGreater(var x, y: System.RawByteString): Boolean;  
function AnsiLess(var x, y: System.RawByteString): Boolean;
procedure AnsiDelete(var dst: System.RawByteString; index, count: Integer);
procedure AnsiSetLength(var dst: System.RawByteString; len: Integer);
procedure AnsiFree(var s: System.RawByteString);
procedure AnsiAssign(var dst: System.RawByteString; var src: System.RawByteString);


procedure WideAppend(var dst: WideString; var src: WideString);
function WideCat(var x, y: WideString): WideString;
function WideCopy(var src: WideString; index, count: Integer): WideString;
function WideEqual(var x, y: WideString): Boolean;
function WideGreater(var x, y: WideString): Boolean;
function WideLength(var src: WideString): Integer;
function WideLess(var x, y: WideString): Boolean;
function WidePos(var src, sub: WideString): Integer;
procedure WideFromAnsi(var dst: WideString; var src: RawByteString);
procedure WideFromUnicode(var dst: WideString; var src: UnicodeString);
procedure WideInsert(var dst: WideString; var src: WideString; index: Integer);

procedure WideFromPChar(var dst: WideString; src: PAnsiChar; IsUTF8: Boolean = False);
procedure WideDelete(var dst: WideString; index, count: Integer);
procedure WideSetLength(var dst: WideString; len: Integer);
procedure WideFree(var s: WideString);

{ WideAssign is called from the C++ WideString's assignment constructor, so it
  must use pass-by-reference to avoid infinite recursion.  This will
  require const_cast<>'s in the C++ call:( }
procedure WideAssign(var dst: WideString; var src: WideString);
procedure WideFromUTF8(var dst: WideString; const src: PAnsiChar);
procedure UnicodeFromWide(var dst: UnicodeString; var src: WideString);
{$ENDIF} // !NEXTGEN



implementation

{ UnicodeString }
{$IFNDEF NEXTGEN}
procedure UnicodeFromAnsi(var dst: UnicodeString; var src: System.RawByteString);
begin
  dst := src;
end;

procedure UnicodeFromPChar(var dst: UnicodeString; src: System.PAnsiChar; IsUTF8: Boolean);
begin
  if not isUTF8 then
    dst := src
  else
    dst := UTF8String(src);
end;

procedure UnicodeFromUTF8(var dst: UnicodeString; const src: System.PAnsiChar);
begin
  dst := UTF8ToUnicodeString(src);
end;

procedure UnicodeFromPWideChar(var dst: UnicodeString; src: System.PWideChar);
begin
  dst := src;
end;

{$ELSE}

procedure UnicodeFromAnsi(var dst: UnicodeString; CodePage: Word; src: System.Pointer; Len: Integer);
begin
  dst := TMarshal.ReadStringAsAnsi(CodePage, TPtrWrapper.Create(src), Len);
end;

procedure UnicodeFromPChar(var dst: UnicodeString; src: System.Pointer; IsUTF8: Boolean = False);
begin
  if not isUTF8 then
    dst := TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(src))
  else
    dst := TMarshal.ReadStringAsAnsi(CP_UTF8, TPtrWrapper.Create(src));
end;
    
procedure UnicodeFromUTF8(var dst: UnicodeString; const src: System.Pointer);
begin
  UnicodeFromPChar(dst, src, True);
end;

procedure UnicodeFromPWideChar(var dst: UnicodeString; src: System.Pointer);
begin
  dst := TMarshal.ReadStringAsUnicode(TPtrWrapper.Create(src))
end;
{$ENDIF}  

procedure UnicodeAppend(var dst: UnicodeString; var src: UnicodeString);
begin
  dst := dst + src;
end;

function UnicodeCat(var x, y: UnicodeString): UnicodeString;
begin
  Result := x + y;
end;

procedure UnicodeDelete(var dst: UnicodeString; index, count: Integer);
begin
  Delete(dst, index, count);
end;

procedure UnicodeSetLength(var dst: UnicodeString; len: Integer);
begin
  SetLength(dst, len);
end;

function UnicodePos(var src, sub: UnicodeString): Integer;
begin
  Result := Pos(sub, src);
end;

function UnicodeCopy(var src: UnicodeString; index, count: Integer): UnicodeString;
begin
  Result := Copy(src, index, count);
end;

procedure UnicodeInsert(var dst: UnicodeString; var src: UnicodeString; index: Integer);
begin
  Insert(src, dst, index);
end;

procedure UnicodeAssign(var dst: UnicodeString; var src: UnicodeString);
begin
  dst := src;
end;

procedure UnicodeFree(var s: UnicodeString);
begin
  s := '';
end;

function UnicodeEqual(var x, y: UnicodeString): Boolean;
begin
  Result := x = y;
end;

function UnicodeLess(var x, y: UnicodeString): Boolean;
begin
  Result := x < y;
end;

function UnicodeGreater(var x, y: UnicodeString): Boolean;
begin
  Result := x > y;
end;

{$IFNDEF NEXTGEN}
{ AnsiString }
procedure AnsiAppend(var dst: System.RawByteString; var src: System.RawByteString);
begin
  dst := dst + src;
end;

function AnsiCat(var x, y: System.RawByteString): System.RawByteString;
begin
  Result := x + y;
end;

procedure AnsiDelete(var dst: System.RawByteString; index, count: Integer);
begin
  Delete(dst, index, count);
end;

procedure AnsiSetLength(var dst: System.RawByteString; len: Integer);
begin
  SetLength(dst, len);
end;

function AnsiPos(var src, sub: System.RawByteString): Integer;
begin
  Result := Pos(sub, src);
end;

function AnsiCopy(var src: System.RawByteString; index, count: Integer): System.RawByteString;
begin
  Result := Copy(src, index, count);
end;

procedure AnsiInsert(var dst: System.RawByteString; var src: System.RawByteString; index: Integer);
begin
  Insert(src, dst, index);
end;

function AnsiEqual(var x, y: System.RawByteString): Boolean;
begin
  Result := x = y;
end;

function AnsiGreater(var x, y: System.RawByteString): Boolean;
begin
  Result := x > y;
end;

function AnsiLess(var x, y: System.RawByteString): Boolean;
begin
  Result := x < y;
end;

procedure AnsiAssign(var dst: System.RawByteString; var src: System.RawByteString);
begin
  dst := src;
end;

procedure AnsiFree(var s: System.RawByteString);
begin
  s := '';
end;


{ WideString }
procedure WideAssign(var dst: WideString; var src: WideString);
begin
  dst := src;
end;

procedure WideFree(var s: WideString);
begin
  s := '';
end;

procedure WideFromAnsi(var dst: WideString; var src: RawByteString);
begin
  dst := src;
end;

procedure WideFromUnicode(var dst: WideString; var src: UnicodeString);
begin
  dst := src;
end;

procedure WideFromPChar(var dst: WideString; src: PAnsiChar; IsUTF8: Boolean);
begin
  if not isUTF8 then
    dst := src
  else
    dst := UTF8String(src);
end;

function WideEqual(var x, y: WideString): Boolean;
begin
  Result := x = y;
end;

function WideLess(var x, y: WideString): Boolean;
begin
  Result := x < y;
end;

function WideGreater(var x, y: WideString): Boolean;
begin
  Result := x > y;
end;

function WideCat(var x, y: WideString): WideString;
begin
  Result := x + y;
end;

function WideLength(var src: WideString): Integer;
begin
  Result := Length(src);
end;

function WidePos(var src, sub: WideString): Integer;
begin
  Result := Pos(sub, src);
end;

procedure WideSetLength(var dst: WideString; len: Integer);
begin
  SetLength(dst, len);
end;

procedure WideDelete(var dst: WideString; index, count: Integer);
begin
  Delete(dst, index, count);
end;

procedure WideInsert(var dst: WideString; var src: WideString; index: Integer);
begin
  Insert(src, dst, index);
end;

function WideCopy(var src: WideString; index, count: Integer): WideString;
begin
  Result := Copy(src, index, count);
end;

procedure WideAppend(var dst: WideString; var src: WideString);
begin
  dst := dst + src;
end;

procedure WideFromUTF8(var dst: WideString; const src: PAnsiChar);
begin
  dst := UTF8String(src);
end;

procedure UnicodeFromWide(var dst: UnicodeString; var src: WideString);
begin
  dst := src;
end;
{$ENDIF}  // !NEXTGEN


end.
