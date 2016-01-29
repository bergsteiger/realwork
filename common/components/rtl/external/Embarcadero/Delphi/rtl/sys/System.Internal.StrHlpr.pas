{*****************************************************************}
{                                                                 }
{           CodeGear Delphi Runtime Library                       }
{                                                                 }
{      Copyright(c) 1995-2013 Embarcadero Technologies, Inc.      }
{                                                                 }
{*****************************************************************}

{*****************************************************************}
{  Helpers for C++ AnsiString/WideString/UnicodeString binding.   }
{*****************************************************************}

unit System.Internal.StrHlpr;

{$IFDEF NEXTGEN}
{$MESSAGE ERROR 'StrHlpr not supported on this platform'}
{$ENDIF}


{$WEAKPACKAGEUNIT}

{$WARN IMPLICIT_STRING_CAST OFF}
{$WARN IMPLICIT_STRING_CAST_LOSS OFF}

{ The C++ compiler currently invokes a copy constructor on incoming
  const parameters in function prologues to mimic Delphi's call to
  [x]StrAddRef and [x]StrClr. DCC32 does *NOT* invoke the
  [x]StrAddRef and [x]StrClr routines on 'const' parameters.
  For UnicodeString and AnsiString the overhead is minor -
  a ref-count inc. and dec. However, for WideString there's significant
  overhead as the content is copied.
  To workaround we'll expose all 'const' parameter as 'var' to avoid
  this issue at the cost of requiring an ugly const_cast<> C++ code
  invoking routines in this unit }
{$DEFINE INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
(*$HPPEMIT '#define INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES'*)
{$ENDIF}

interface

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function AnsiCat(var x, y: RawByteString): RawByteString;
function AnsiCopy(var src: RawByteString; index, count: Integer): RawByteString;
function AnsiPos(var src, sub: RawByteString): Integer;
procedure AnsiAppend(var dst: RawByteString; var src: RawByteString);
procedure AnsiFromWide(var dst: RawByteString; var src: WideString);
procedure AnsiFromUnicode(var dst: RawByteString; var src: UnicodeString);
procedure AnsiInsert(var dst: RawByteString; var src: RawByteString; index: Integer);
function AnsiEqual(var x, y: RawByteString): Boolean;
function AnsiGreater(var x, y: RawByteString): Boolean;
function AnsiLess(var x, y: RawByteString): Boolean;
{$ELSE}
function AnsiCat(const x, y: RawByteString): RawByteString;
function AnsiCopy(const src: RawByteString; index, count: Integer): RawByteString;
function AnsiPos(const src, sub: RawByteString): Integer;
procedure AnsiAppend(var dst: RawByteString; const src: RawByteString);
procedure AnsiFromWide(var dst: RawByteString; const src: WideString);
procedure AnsiFromUnicode(var dst: RawByteString; const src: UnicodeString);
procedure AnsiInsert(var dst: RawByteString; const src: RawByteString; index: Integer);
function AnsiEqual(const x, y: RawByteString): Boolean;
function AnsiGreater(const x, y: RawByteString): Boolean;
function AnsiLess(const x, y: RawByteString): Boolean;
{$ENDIF}
procedure AnsiFromPWideChar(var dst: RawByteString; src: PWideChar);
procedure AnsiDelete(var dst: RawByteString; index, count: Integer);
procedure AnsiSetLength(var dst: RawByteString; len: Integer);
procedure AnsiFree(var s: RawByteString);

{ AnsiAssign is called from the C++ AnsiString's copy constructor, so it
  must use pass-by-reference to avoid infinite recursion. This will
  require const_cast<>'s on the C++ call:( }
procedure AnsiAssign(var dst: RawByteString; var src: RawByteString);


{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
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
{$ELSE}
procedure WideAppend(var dst: WideString; const src: WideString);
function WideCat(const x, y: WideString): WideString;
function WideCopy(const src: WideString; index, count: Integer): WideString;
function WideEqual(const x, y: WideString): Boolean;
function WideGreater(const x, y: WideString): Boolean;
function WideLength(const src: WideString): Integer;
function WideLess(const x, y: WideString): Boolean;
function WidePos(const src, sub: WideString): Integer;
procedure WideFromAnsi(var dst: WideString; const src: RawByteString);
procedure WideFromUnicode(var dst: WideString; const src: UnicodeString);
procedure WideInsert(var dst: WideString; const src: WideString; index: Integer);
{$ENDIF}

procedure WideFromPChar(var dst: WideString; src: PAnsiChar; IsUTF8: Boolean = False);
procedure WideDelete(var dst: WideString; index, count: Integer);
procedure WideSetLength(var dst: WideString; len: Integer);
procedure WideFree(var s: WideString);

{ WideAssign is called from the C++ WideString's assignment constructor, so it
  must use pass-by-reference to avoid infinite recursion.  This will
  require const_cast<>'s in the C++ call:( }
procedure WideAssign(var dst: WideString; var src: WideString);


{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function UnicodeCat(var x, y: UnicodeString): UnicodeString;
function UnicodeCopy(var src: UnicodeString; index, count: Integer): UnicodeString;
function UnicodePos(var src, sub: UnicodeString): Integer;
procedure UnicodeAppend(var dst: UnicodeString; var src: UnicodeString);
procedure UnicodeDelete(var dst: UnicodeString; index, count: Integer);
procedure UnicodeFromAnsi(var dst: UnicodeString; var src: RawByteString);
procedure UnicodeFromWide(var dst: UnicodeString; var src: WideString);
procedure UnicodeInsert(var dst: UnicodeString; var src: UnicodeString; index: Integer);
function UnicodeEqual(var x, y: UnicodeString): Boolean;
function UnicodeGreater(var x, y: UnicodeString): Boolean;
function UnicodeLess(var x, y: UnicodeString): Boolean;
{$ELSE}
function UnicodeCat(const x, y: UnicodeString): UnicodeString;
function UnicodeCopy(const src: UnicodeString; index, count: Integer): UnicodeString;
function UnicodePos(const src, sub: UnicodeString): Integer;
procedure UnicodeAppend(var dst: UnicodeString; const src: UnicodeString);
procedure UnicodeDelete(var dst: UnicodeString; index, count: Integer);
procedure UnicodeFromAnsi(var dst: UnicodeString; const src: RawByteString);
procedure UnicodeFromWide(var dst: UnicodeString; const src: WideString);
procedure UnicodeInsert(var dst: UnicodeString; const src: UnicodeString; index: Integer);
function UnicodeEqual(const x, y: UnicodeString): Boolean;
function UnicodeGreater(const x, y: UnicodeString): Boolean;
function UnicodeLess(const x, y: UnicodeString): Boolean;
{$ENDIF}

procedure UnicodeFromPWideChar(var dst: UnicodeString; src: PWideChar);
procedure UnicodeFromPChar(var dst: UnicodeString; src: PAnsiChar; IsUTF8: Boolean = False);
procedure UnicodeSetLength(var dst: UnicodeString; len: Integer);
procedure UnicodeFree(var s: UnicodeString);


{ UnicAssign is called from the C++ UnicodeString's copy constructor, so it
  must use pass-by-reference to avoid infinite recursion.  This will
  require const_cast<>'s on the C++ call:( }
procedure UnicodeAssign(var dst: UnicodeString; var src: UnicodeString);

procedure UnicodeFromUTF8(var dst: UnicodeString; const src: PAnsiChar);
procedure WideFromUTF8(var dst: WideString; const src: PAnsiChar);

implementation

{ AnsiString }
{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
procedure AnsiFromWide(var dst: RawByteString; var src: WideString);
{$ELSE}
procedure AnsiFromWide(var dst: RawByteString; const src: WideString);
{$ENDIF}
begin
  dst := src;
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
procedure AnsiFromUnicode(var dst: RawByteString; var src: UnicodeString);
{$ELSE}
procedure AnsiFromUnicode(var dst: RawByteString; const src: UnicodeString);
{$ENDIF}
begin
  dst := src;
end;

procedure AnsiFromPWideChar(var dst: RawByteString; src: PWideChar);
begin
  dst := src;
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
procedure AnsiAppend(var dst: RawByteString; var src: RawByteString);
{$ELSE}
procedure AnsiAppend(var dst: RawByteString; const src: RawByteString);
{$ENDIF}
begin
  dst := dst + src;
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function AnsiCat(var x, y: RawByteString): RawByteString;
{$ELSE}
function AnsiCat(const x, y: RawByteString): RawByteString;
{$ENDIF}
begin
  Result := x + y;
end;

procedure AnsiDelete(var dst: RawByteString; index, count: Integer);
begin
  Delete(dst, index, count);
end;

procedure AnsiSetLength(var dst: RawByteString; len: Integer);
begin
  SetLength(dst, len);
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function AnsiPos(var src, sub: RawByteString): Integer;
{$ELSE}
function AnsiPos(const src, sub: RawByteString): Integer;
{$ENDIF}
begin
  Result := Pos(sub, src);
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function AnsiCopy(var src: RawByteString; index, count: Integer): RawByteString;
{$ELSE}
function AnsiCopy(const src: RawByteString; index, count: Integer): RawByteString;
{$ENDIF}
begin
  Result := Copy(src, index, count);
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
procedure AnsiInsert(var dst: RawByteString; var src: RawByteString; index: Integer);
{$ELSE}
procedure AnsiInsert(var dst: RawByteString; const src: RawByteString; index: Integer);
{$ENDIF}
begin
  Insert(src, dst, index);
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function AnsiEqual(var x, y: RawByteString): Boolean;
{$ELSE}
function AnsiEqual(const x, y: RawByteString): Boolean;
{$ENDIF}
begin
  Result := x = y;
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function AnsiGreater(var x, y: RawByteString): Boolean;
{$ELSE}
function AnsiGreater(const x, y: RawByteString): Boolean;
{$ENDIF}
begin
  Result := x > y;
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function AnsiLess(var x, y: RawByteString): Boolean;
{$ELSE}
function AnsiLess(const x, y: RawByteString): Boolean;
{$ENDIF}
begin
  Result := x < y;
end;

procedure AnsiAssign(var dst: RawByteString; var src: RawByteString);
begin
  dst := src;
end;

procedure AnsiFree(var s: RawByteString);
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

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
procedure WideFromAnsi(var dst: WideString; var src: RawByteString);
{$ELSE}
procedure WideFromAnsi(var dst: WideString; const src: RawByteString);
{$ENDIF}
begin
  dst := src;
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
procedure WideFromUnicode(var dst: WideString; var src: UnicodeString);
{$ELSE}
procedure WideFromUnicode(var dst: WideString; const src: UnicodeString);
{$ENDIF}
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

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function WideEqual(var x, y: WideString): Boolean;
{$ELSE}
function WideEqual(const x, y: WideString): Boolean;
{$ENDIF}
begin
  Result := x = y;
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function WideLess(var x, y: WideString): Boolean;
{$ELSE}
function WideLess(const x, y: WideString): Boolean;
{$ENDIF}
begin
  Result := x < y;
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function WideGreater(var x, y: WideString): Boolean;
{$ELSE}
function WideGreater(const x, y: WideString): Boolean;
{$ENDIF}
begin
  Result := x > y;
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function WideCat(var x, y: WideString): WideString;
{$ELSE}
function WideCat(const x, y: WideString): WideString;
{$ENDIF}
begin
  Result := x + y;
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function WideLength(var src: WideString): Integer;
{$ELSE}
function WideLength(const src: WideString): Integer;
{$ENDIF}
begin
  Result := Length(src);
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function WidePos(var src, sub: WideString): Integer;
{$ELSE}
function WidePos(const src, sub: WideString): Integer;
{$ENDIF}
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

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
procedure WideInsert(var dst: WideString; var src: WideString; index: Integer);
{$ELSE}
procedure WideInsert(var dst: WideString; const src: WideString; index: Integer);
{$ENDIF}
begin
  Insert(src, dst, index);
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function WideCopy(var src: WideString; index, count: Integer): WideString;
{$ELSE}
function WideCopy(const src: WideString; index, count: Integer): WideString;
{$ENDIF}
begin
  Result := Copy(src, index, count);
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
procedure WideAppend(var dst: WideString; var src: WideString);
{$ELSE}
procedure WideAppend(var dst: WideString; const src: WideString);
{$ENDIF}
begin
  dst := dst + src;
end;

{ UnicString }
{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
procedure UnicodeFromWide(var dst: UnicodeString; var src: WideString);
{$ELSE}
procedure UnicodeFromWide(var dst: UnicodeString; const src: WideString);
{$ENDIF}
begin
  dst := src;
end;

procedure UnicodeFromPChar(var dst: UnicodeString; src: PAnsiChar; IsUTF8: Boolean);
begin
  if not isUTF8 then
    dst := src
  else
    dst := UTF8String(src);
end;

procedure UnicodeFromPWideChar(var dst: UnicodeString; src: PWideChar);
begin
  dst := src;
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
procedure UnicodeFromAnsi(var dst: UnicodeString; var src: RawByteString);
{$ELSE}
procedure UnicodeFromAnsi(var dst: UnicodeString; const src: RawByteString);
{$ENDIF}
begin
  dst := src;
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
procedure UnicodeAppend(var dst: UnicodeString; var src: UnicodeString);
{$ELSE}
procedure UnicodeAppend(var dst: UnicodeString; const src: UnicodeString);
{$ENDIF}
begin
  dst := dst + src;
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function UnicodeCat(var x, y: UnicodeString): UnicodeString;
{$ELSE}
function UnicodeCat(const x, y: UnicodeString): UnicodeString;
{$ENDIF}
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

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function UnicodePos(var src, sub: UnicodeString): Integer;
{$ELSE}
function UnicodePos(const src, sub: UnicodeString): Integer;
{$ENDIF}
begin
  Result := Pos(sub, src);
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function UnicodeCopy(var src: UnicodeString; index, count: Integer): UnicodeString;
{$ELSE}
function UnicodeCopy(const src: UnicodeString; index, count: Integer): UnicodeString;
{$ENDIF}
begin
  Result := Copy(src, index, count);
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
procedure UnicodeInsert(var dst: UnicodeString; var src: UnicodeString; index: Integer);
{$ELSE}
procedure UnicodeInsert(var dst: UnicodeString; const src: UnicodeString; index: Integer);
{$ENDIF}
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

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function UnicodeEqual(var x, y: UnicodeString): Boolean;
{$ELSE}
function UnicodeEqual(const x, y: UnicodeString): Boolean;
{$ENDIF}
begin
  Result := x = y;
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function UnicodeLess(var x, y: UnicodeString): Boolean;
{$ELSE}
function UnicodeLess(const x, y: UnicodeString): Boolean;
{$ENDIF}
begin
  Result := x < y;
end;

{$IFDEF INEFFICIENT_COPY_OF_CONST_DELPHIRETURN_TYPES}
function UnicodeGreater(var x, y: UnicodeString): Boolean;
{$ELSE}
function UnicodeGreater(const x, y: UnicodeString): Boolean;
{$ENDIF}
begin
  Result := x > y;
end;

procedure UnicodeFromUTF8(var dst: UnicodeString; const src: PAnsiChar);
begin
  dst := UTF8String(src);
end;

procedure WideFromUTF8(var dst: WideString; const src: PAnsiChar);
begin
  dst := UTF8String(src);
end;

end.
