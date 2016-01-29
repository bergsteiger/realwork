{==============================================================================|
| Project : Delphree - Synapse                                   | 001.000.003 |
|==============================================================================|
| Content: Inline MIME support procedures and functions                        |
|==============================================================================|
| Copyright (c)1999-2002, Lukas Gebauer                                        |
| All rights reserved.                                                         |
|                                                                              |
| Redistribution and use in source and binary forms, with or without           |
| modification, are permitted provided that the following conditions are met:  |
|                                                                              |
| Redistributions of source code must retain the above copyright notice, this  |
| list of conditions and the following disclaimer.                             |
|                                                                              |
| Redistributions in binary form must reproduce the above copyright notice,    |
| this list of conditions and the following disclaimer in the documentation    |
| and/or other materials provided with the distribution.                       |
|                                                                              |
| Neither the name of Lukas Gebauer nor the names of its contributors may      |
| be used to endorse or promote products derived from this software without    |
| specific prior written permission.                                           |
|                                                                              |
| THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"  |
| AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE    |
| IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE   |
| ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR  |
| ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL       |
| DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR   |
| SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER   |
| CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT           |
| LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY    |
| OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH  |
| DAMAGE.                                                                      |
|==============================================================================|
| The Initial Developer of the Original Code is Lukas Gebauer (Czech Republic).|
| Portions created by Lukas Gebauer are Copyright (c)2000,2001.                |
| All Rights Reserved.                                                         |
|==============================================================================|
| Contributor(s):                                                              |
|==============================================================================|
| History: see HISTORY.HTM from distribution package                           |
|          (Found at URL: http://www.ararat.cz/synapse/)                       |
|==============================================================================}

{$WEAKPACKAGEUNIT ON}

unit MIMEinLn;

interface

uses
  SysUtils, Classes,
  SynaChar, SynaCode, SynaUtil;

function InlineDecode(const Value: string; CP: TMimeChar): string;
function InlineEncode(const Value: string; CP, MimeP: TMimeChar): string;
function NeedInline(const Value: string): boolean;
function InlineCode(const Value: string): string;
function InlineEmail(const Value: string): string;

implementation

{==============================================================================}

function InlineDecode(const Value: string; CP: TMimeChar): string;
var
  s, su: string;
  x, y, z, n: Integer;
  ichar: TMimeChar;
  c: Char;

  function SearchEndInline(const Value: string; be: Integer): Integer;
  var
    n, q: Integer;
  begin
    q := 0;
    Result := 0;
    for n := be + 2 to Length(Value) - 1 do
      if Value[n] = '?' then
      begin
        Inc(q);
        if (q > 2) and (Value[n + 1] = '=') then
        begin
          Result := n;
          Break;
        end;
      end;
  end;

begin
  Result := Value;
  x := Pos('=?', Result);
  y := SearchEndInline(Result, x);
  while (y > x) and (x > 0) do  //fix by Marcus Moennig (minibbjd@gmx.de)
  begin
    s := Copy(Result, x, y - x + 2);
    su := Copy(s, 3, Length(s) - 4);
    ichar := GetCPFromID(su);
    z := Pos('?', su);
    if (Length(su) >= (z + 2)) and (su[z + 2] = '?') then
    begin
      c := UpperCase(su)[z + 1];
      su := Copy(su, z + 3, Length(su) - z - 2);
      if c = 'B' then
      begin
        s := DecodeBase64(su);
        s := CharsetConversion(s, ichar, CP);
      end;
      if c = 'Q' then
      begin
        s := '';
        for n := 1 to Length(su) do
          if su[n] = '_' then
            s := s + ' '
          else
            s := s + su[n];
        s := DecodeQuotedPrintable(s);
        s := CharsetConversion(s, ichar, CP);
      end;
    end;
    Result := Copy(Result, 1, x - 1) + s +
      Copy(Result, y + 2, Length(Result) - y - 1);
    x := Pos('=?', Result);
    y := SearchEndInline(Result, x);
  end;
end;

{==============================================================================}

function InlineEncode(const Value: string; CP, MimeP: TMimeChar): string;
var
  s, s1: string;
  n: Integer;
begin
  s := CharsetConversion(Value, CP, MimeP);
  s := EncodeQuotedPrintable(s);
  s1 := '';
  for n := 1 to Length(s) do
    if s[n] = ' ' then
      s1 := s1 + '=20'
    else
      s1 := s1 + s[n];
  Result := '=?' + GetIdFromCP(MimeP) + '?Q?' + s1 + '?=';
end;

{==============================================================================}

function NeedInline(const Value: string): boolean;
var
  n: Integer;
begin
  Result := False;
  for n := 1 to Length(Value) do
    if Value[n] in (SpecialChar + [Char(1)..Char(31), Char(128)..Char(255)]) then
    begin
      Result := True;
      Break;
    end;
end;

{==============================================================================}

function InlineCode(const Value: string): string;
var
  c: TMimeChar;
begin
  if NeedInline(Value) then
  begin
    c := IdealCharsetCoding(Value, GetCurCP,
      [ISO_8859_1, ISO_8859_2, ISO_8859_3, ISO_8859_4, ISO_8859_5,
      ISO_8859_6, ISO_8859_7, ISO_8859_8, ISO_8859_9, ISO_8859_10]);
    Result := InlineEncode(Value, GetCurCP, c);
  end
  else
    Result := Value;
end;

{==============================================================================}

function InlineEmail(const Value: string): string;
var
  sd, se: string;
begin
  sd := GetEmailDesc(Value);
  se := GetEmailAddr(Value);
  if sd = '' then
    Result := se
  else
    Result := '"' + InlineCode(sd) + '"<' + se + '>';
end;

end.
