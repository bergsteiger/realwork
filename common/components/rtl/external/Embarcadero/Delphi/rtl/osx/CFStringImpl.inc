{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


var
  _kCFStringTransformStripCombiningMarks: Pointer = nil;
  _kCFStringTransformToLatin: Pointer = nil;
  _kCFStringTransformFullwidthHalfwidth: Pointer = nil;
  _kCFStringTransformLatinKatakana: Pointer = nil;
  _kCFStringTransformLatinHiragana: Pointer = nil;
  _kCFStringTransformHiraganaKatakana: Pointer = nil;
  _kCFStringTransformMandarinLatin: Pointer = nil;
  _kCFStringTransformLatinHangul: Pointer = nil;
  _kCFStringTransformLatinArabic: Pointer = nil;
  _kCFStringTransformLatinHebrew: Pointer = nil;
  _kCFStringTransformLatinThai: Pointer = nil;
  _kCFStringTransformLatinCyrillic: Pointer = nil;
  _kCFStringTransformLatinGreek: Pointer = nil;
  _kCFStringTransformToXMLHex: Pointer = nil;
  _kCFStringTransformToUnicodeName: Pointer = nil;
  _kCFStringTransformStripDiacritics: Pointer = nil;

function kCFStringTransformStripCombiningMarks: CFStringRef;
begin
  if _kCFStringTransformStripCombiningMarks = nil then
    _kCFStringTransformStripCombiningMarks := dlsym(CFModule, MarshaledAString('kCFStringTransformStripCombiningMarks'));
  Result := _kCFStringTransformStripCombiningMarks;
end;

function kCFStringTransformToLatin: CFStringRef;
begin
  if _kCFStringTransformToLatin = nil then
    _kCFStringTransformToLatin := dlsym(CFModule, MarshaledAString('kCFStringTransformToLatin'));
  Result := _kCFStringTransformToLatin;
end;

function kCFStringTransformFullwidthHalfwidth: CFStringRef;
begin
  if _kCFStringTransformFullwidthHalfwidth = nil then
    _kCFStringTransformFullwidthHalfwidth := dlsym(CFModule, MarshaledAString('kCFStringTransformFullwidthHalfwidth'));
  Result := _kCFStringTransformFullwidthHalfwidth;
end;

function kCFStringTransformLatinKatakana: CFStringRef;
begin
  if _kCFStringTransformLatinKatakana = nil then
    _kCFStringTransformLatinKatakana := dlsym(CFModule, MarshaledAString('kCFStringTransformLatinKatakana'));
  Result := _kCFStringTransformLatinKatakana;
end;

function kCFStringTransformLatinHiragana: CFStringRef;
begin
  if _kCFStringTransformLatinHiragana = nil then
    _kCFStringTransformLatinHiragana := dlsym(CFModule, MarshaledAString('kCFStringTransformLatinHiragana'));
  Result := _kCFStringTransformLatinHiragana;
end;

function kCFStringTransformHiraganaKatakana: CFStringRef;
begin
  if _kCFStringTransformHiraganaKatakana = nil then
    _kCFStringTransformHiraganaKatakana := dlsym(CFModule, MarshaledAString('kCFStringTransformHiraganaKatakana'));
  Result := _kCFStringTransformHiraganaKatakana;
end;

function kCFStringTransformMandarinLatin: CFStringRef;
begin
  if _kCFStringTransformMandarinLatin = nil then
    _kCFStringTransformMandarinLatin := dlsym(CFModule, MarshaledAString('kCFStringTransformMandarinLatin'));
  Result := _kCFStringTransformMandarinLatin;
end;

function kCFStringTransformLatinHangul: CFStringRef;
begin
  if _kCFStringTransformLatinHangul = nil then
    _kCFStringTransformLatinHangul := dlsym(CFModule, MarshaledAString('kCFStringTransformLatinHangul'));
  Result := _kCFStringTransformLatinHangul;
end;

function kCFStringTransformLatinArabic: CFStringRef;
begin
  if _kCFStringTransformLatinArabic = nil then
    _kCFStringTransformLatinArabic := dlsym(CFModule, MarshaledAString('kCFStringTransformLatinArabic'));
  Result := _kCFStringTransformLatinArabic;
end;

function kCFStringTransformLatinHebrew: CFStringRef;
begin
  if _kCFStringTransformLatinHebrew = nil then
    _kCFStringTransformLatinHebrew := dlsym(CFModule, MarshaledAString('kCFStringTransformLatinHebrew'));
  Result := _kCFStringTransformLatinHebrew;
end;

function kCFStringTransformLatinThai: CFStringRef;
begin
  if _kCFStringTransformLatinThai = nil then
    _kCFStringTransformLatinThai := dlsym(CFModule, MarshaledAString('kCFStringTransformLatinThai'));
  Result := _kCFStringTransformLatinThai;
end;

function kCFStringTransformLatinCyrillic: CFStringRef;
begin
  if _kCFStringTransformLatinCyrillic = nil then
    _kCFStringTransformLatinCyrillic := dlsym(CFModule, MarshaledAString('kCFStringTransformLatinCyrillic'));
  Result := _kCFStringTransformLatinCyrillic;
end;

function kCFStringTransformLatinGreek: CFStringRef;
begin
  if _kCFStringTransformLatinGreek = nil then
    _kCFStringTransformLatinGreek := dlsym(CFModule, MarshaledAString('kCFStringTransformLatinGreek'));
  Result := _kCFStringTransformLatinGreek;
end;

function kCFStringTransformToXMLHex: CFStringRef;
begin
  if _kCFStringTransformToXMLHex = nil then
    _kCFStringTransformToXMLHex := dlsym(CFModule, MarshaledAString('kCFStringTransformToXMLHex'));
  Result := _kCFStringTransformToXMLHex;
end;

function kCFStringTransformToUnicodeName: CFStringRef;
begin
  if _kCFStringTransformToUnicodeName = nil then
    _kCFStringTransformToUnicodeName := dlsym(CFModule, MarshaledAString('kCFStringTransformToUnicodeName'));
  Result := _kCFStringTransformToUnicodeName;
end;

function kCFStringTransformStripDiacritics: CFStringRef;
begin
  if _kCFStringTransformStripDiacritics = nil then
    _kCFStringTransformStripDiacritics := dlsym(CFModule, MarshaledAString('kCFStringTransformStripDiacritics'));
  Result := _kCFStringTransformStripDiacritics;
end;

procedure CFStringInitInlineBuffer(str: CFStringRef; buf: PCFStringInlineBuffer;
  range: CFRange);
begin
  buf^.theString := str;
  buf^.rangeToBuffer := range;
  buf^.directBuffer := CFStringGetCharactersPtr(str);
  buf^.bufferedRangeStart := 0;
  buf^.bufferedRangeEnd := 0;
end;

function CFStringGetCharacterFromInlineBuffer(buf: PCFStringInlineBuffer;
  idx: CFIndex): UniChar;
begin
  if buf^.directBuffer <> nil then
  begin
    if (idx < 0) or (idx >= buf^.rangeToBuffer.length) then
      Exit(#0)
    else
      Exit(buf^.directBuffer[idx + buf^.rangeToBuffer.location]);
  end;

  if (idx >= buf^.bufferedRangeEnd) or (idx < buf^.bufferedRangeStart) then
  begin
    if (idx < 0) or (idx >= buf^.rangeToBuffer.length) then
      Exit(#0);
    buf^.bufferedRangeStart := idx - 4;
    if (buf^.bufferedRangeStart < 0) then
      buf^.bufferedRangeStart := 0;

    buf^.bufferedRangeEnd := buf^.bufferedRangeStart + __kCFStringInlineBufferLength;
    if (buf^.bufferedRangeEnd > buf^.rangeToBuffer.length) then
      buf^.bufferedRangeEnd := buf^.rangeToBuffer.length;
    CFStringGetCharacters(buf^.theString, CFRangeMake(buf^.rangeToBuffer.location +
      buf^.bufferedRangeStart, buf^.bufferedRangeEnd - buf^.bufferedRangeStart), buf^.buffer);
  end;
  Result := buf^.buffer[idx - buf^.bufferedRangeStart];
end;

function CFStringIsSurrogateHighCharacter(character: UniChar): Boolean;
begin
  Result := (Word(character) >= $D800) and (Word(character) <= $DBFF);
end;

function CFStringIsSurrogateLowCharacter(character: UniChar): Boolean;
begin
  Result := (Word(character) >= $DC00) and (Word(character) <= $DFFF);
end;

function CFStringGetLongCharacterForSurrogatePair(surrogateHigh: UniChar;
  surrogateLow: UniChar): UTF32Char;
begin
  Result := ((Word(surrogateHigh) - $D800)  shl 10) + (Word(surrogateHigh) - $DC00) + $10000;
end;

function CFStringGetSurrogatePairForLongCharacter(character: UTF32Char;
  surrogates: PUniChar): Boolean;
begin
  if (character > $FFFF) and (character < $110000) then // Non-BMP character
  begin
    Dec(character, $10000);
    if surrogates <> nil then
    begin
      surrogates[0] := UniChar((character shr 10) + $D800);
      surrogates[1] := UniChar((character and $3FF) + $DC00);
    end;
    Result := True;
  end
  else
  begin
    if (surrogates <> nil) then
      PUTF32Char(surrogates)^ := character;
    Result := False;
  end;
end;

function CFSTR(const cStr: string): CFStringRef;
begin
  Result := __CFStringMakeConstantString(MarshaledAString(UTF8Encode(cStr)));
end;

{$IFNDEF NEXTGEN}
function CFSTR(const cStr: AnsiString): CFStringRef;
begin
  Result := __CFStringMakeConstantString(PAnsiChar(UTF8Encode(cStr)));
end;

function CFSTR(const cStr: UTF8String): CFStringRef;
begin
  Result := __CFStringMakeConstantString(PAnsiChar(cStr));
end;
{$ENDIF !NEXTGEN}
