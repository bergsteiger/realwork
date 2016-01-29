{*********************************************************}
{*                  TESTSTRL.DPR 1.05                    *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TestStrL;

{$IFDEF Win32}
{$APPTYPE CONSOLE}
{$ELSE}
  !! Error: 32-bit compilation only
{$ENDIF}

{$H+}

uses
  SysUtils,
  Windows,
  STBase,
  STStrL,
  tstutil in 'tstutil.pas';

var
  S, S2 : string;
  i, j : longint;
  Posn : Cardinal;
  BM   : BTable;
  Ch   : AnsiChar;
  P    : PChar absolute S;
begin
  OpenLog('TEST.LOG');
  try
    WriteLog('CharStrL test');
    for i := 1 to 10 do
      begin
        S := CharStrL('x', i);
        WriteLog(Format('[%s]', [S]));
      end;

    WriteLog('PadChL/TrimTrailL test');
    for i := 10 to 20 do
      begin
        S := 'the cat sat';
        S := PadChL(S, ' ', i);
        WriteLog(Format('Padded  [%s]', [S]));
        S := TrimTrailL(S);
        WriteLog(Format('Trimmed [%s]', [S]));
      end;

    WriteLog('LeftPadChL/TrimLeadL test');
    for i := 10 to 20 do
      begin
        S := 'the cat sat';
        S := LeftPadChL(S, ' ', i);
        WriteLog(Format('Padded  [%s]', [S]));
        S := TrimLeadL(S);
        WriteLog(Format('Trimmed [%s]', [S]));
      end;

    WriteLog('CenterChL/TrimSpacesL test');
    for i := 10 to 20 do
      begin
        S := 'the cat sat';
        S := CenterChL(S, ' ', i);
        WriteLog(Format('Padded  [%s]', [S]));
        S := TrimSpacesL(S);
        WriteLog(Format('Trimmed [%s]', [S]));
      end;

    WriteLog('EntabL/DetabL test');
    for i := 1 to 100 do
      begin
        S := LeftPadChL('the cat sat', ' ', i) + LeftPadChL(' on the mat', ' ', i);
        S2 := DetabL(EntabL(S, 8), 8);
        if (S <> S2) then
          begin
            WriteLog(Format('Error: [%s] not en/detabbed correctly (iteration %d)', [S,i]));
            S2 := EntabL(S, 8);
            WriteLogStrDump(S2);
            S2 := DetabL(S2, 8);
            WriteLogStrDump(S2);
          end
        else
          WriteLog(Format('iteration %d', [i]));
      end;

    WriteLog('SubstituteL test');
    S := 'the cat sat on the mat';
    WriteLog(Format('Original  [%s]', [S]));
    S := SubstituteL(S, 'aeiou', 'AEIOU');
    WriteLog(Format('Subs''d    [%s]', [S]));

    WriteLog('FilterL test');
    S := 'the cat sat on the mat';
    WriteLog(Format('Original string [%s]', [S]));
    S := FilterL(S, 'aeiou');
    WriteLog(Format('Filtered vowels [%s]', [S]));

    WriteLog('CharCountL test');
    S := 'the cat sat on the mat';
    WriteLog(Format('Original  [%s]', [S]));
    i := CharCountL(S, 'a');
    j := CharCountL(S, 'z');
    WriteLog(Format('Number of a''s and z''s [%d, %d]', [i, j]));

    WriteLog('HexLL/Str2LongL test');
    for i := 0 to 100000 do
      begin
        S := '$' + HexLL(i);
        Str2LongL(S, j);
        if (i <> j) then
          begin
            WriteLog(Format('Error: [%d] was converted to [%s]', [i, S]));
          end;
      end;

    WriteLog('Long2StrL/Str2LongL test');
    for i := 0 to 100000 do
      begin
        S := Long2StrL(i);
        Str2LongL(S, j);
        if (i <> j) then
          begin
            WriteLog(Format('Error: [%d] was converted to [%s]', [i, S]));
          end;
      end;

    WriteLog('CommaizeL test');
    S := CommaizeL(1);
    WriteLog(S);
    S := CommaizeL(12);
    WriteLog(S);
    S := CommaizeL(123);
    WriteLog(S);
    S := CommaizeL(1234);
    WriteLog(S);
    S := CommaizeL(12345);
    WriteLog(S);
    S := CommaizeL(123456);
    WriteLog(S);
    S := CommaizeL(1234567);
    WriteLog(S);
    S := CommaizeL(12345678);
    WriteLog(S);
    S := CommaizeL(123456789);
    WriteLog(S);
    S := CommaizeL(1234567890);
    WriteLog(S);
    S := CommaizeL(-1);
    WriteLog(S);
    S := CommaizeL(-12);
    WriteLog(S);
    S := CommaizeL(-123);
    WriteLog(S);
    S := CommaizeL(-1234);
    WriteLog(S);
    S := CommaizeL(-12345);
    WriteLog(S);
    S := CommaizeL(-123456);
    WriteLog(S);
    S := CommaizeL(-1234567);
    WriteLog(S);
    S := CommaizeL(-12345678);
    WriteLog(S);
    S := CommaizeL(-123456789);
    WriteLog(S);
    S := CommaizeL(-1234567890);
    WriteLog(S);

    WriteLog('SoundexL test');
    for i := 1 to 20 do
      begin
        S := RandomStr(Random(9) + 1);
        S2 := SoundexL(S);
        WriteLog(Format('[%s] -> [%s]', [S, S2]));
      end;

    WriteLog('Word counting tests');
    S := 'the cat sat on the mat and said ''hi,there''';
    WriteLog(Format('String: [%s]', [S]));
    j := WordCountL(S, ' ,.');
    WriteLog(Format('Word count: [%d]', [j]));
    for i := 1 to j do
      begin
        WordPositionL(i, S, ' ,.', Posn);
        S2 := ExtractWordL(i, S, ' ,.');
        WriteLog(Format('Word %d is [%s] at %d', [i, S2, Posn]));
      end;
    j := AsciiCountL(S, ' ,.', '''');
    WriteLog(Format('Ascii word count: [%d]', [j]));
    for i := 1 to j do
      begin
        AsciiPositionL(i, S, ' ,.', '''', Posn);
        S2 := ExtractAsciiL(i, S, ' ,.', '''');
        WriteLog(Format('Word %d is [%s] at %d', [i, S2, Posn]));
      end;
    S := 'somesillysingleword';
    WriteLog(Format('String: [%s]', [S]));
    j := WordCountL(S, ' ,.');
    WriteLog(Format('Word count: [%d]', [j]));
    for i := 1 to j do
      begin
        WordPositionL(i, S, ' ,.', Posn);
        S2 := ExtractWordL(i, S, ' ,.');
        WriteLog(Format('Word %d is [%s] at %d', [i, S2, Posn]));
      end;
    j := AsciiCountL(S, ' ,.', '''');
    WriteLog(Format('Ascii word count: [%d]', [j]));
    for i := 1 to j do
      begin
        AsciiPositionL(i, S, ' ,.', '''', Posn);
        S2 := ExtractAsciiL(i, S, ' ,.', '''');
        WriteLog(Format('Word %d is [%s] at %d', [i, S2, Posn]));
      end;

    WriteLog('Boyer-Moore tests');
    S := 'the cat sat on the mat';
    WriteLog(Format('Search string: [%s]', [S]));
    j := WordCountL(S, ' ');
    for i := 1 to j do
      begin
        S2 := ExtractWordL(i, S, ' ');
        BMMakeTableL(S2, BM);
        if BMSearchL(S[1], length(S), BM, S2, Posn) then
          WriteLog(Format('Word [%s] found at %d', [S2, Posn]))
        else
          WriteLog(Format('Word [%s] not found', [S2]));
        S2 := AnsiUpperCase(S2);
        BMMakeTableL(S2, BM);
        if BMSearchUCL(S[1], length(S), BM, S2, Posn) then
          WriteLog(Format('Word [%s] found at %d (UC)', [S2, Posn]))
        else
          WriteLog(Format('Word [%s] not found', [S2]));
      end;

    WriteLog('Various tests');
    S := 'the cat sat on the mat';
    WriteLog(Format('(StrChPosL) String [%s]', [S]));
    for ch := 'a' to 'z' do
      begin
        if StrChPosL(S, ch, Posn) then
          WriteLog(Format('Character [%s] found at %d', [ch, Posn]));
      end;
    S := 'the cat sat on the mat';
    WriteLog(Format('(StrStPosL) String [%s]', [S]));
    j := WordCountL(S, ' ');
    for i := 1 to j do
      begin
        S2 := ExtractWordL(i, S, ' ');
        if StrStPosL(S, S2, Posn) then
          WriteLog(Format('[%s] is at %d', [S2, Posn]))
        else
          WriteLog(Format('[%s] is not found', [S2]));
      end;
    S := 'the cat sat on the mat';
    WriteLog(Format('(StrChInsertL/StrChDeleteL) String [%s]', [S]));
    for ch := 'a' to 'z' do
      begin
        if StrChPosL(S, ch, Posn) then
          begin
            S := StrChDeleteL(S, Posn);
            S := StrChInsertL(S, Upcase(Ch), Posn);
          end
        else
          S := StrChInsertL(S, Ch, 1);
      end;
    WriteLog(Format('Converted string: [%s]', [S]));
    WriteLog('...should be      [zyxwvurqplkjigfdbTHE CAt Sat ON the Mat]');
    S := 'the cat sat on the mat';
    WriteLog(Format('(StrStInsertL/StrStDeleteL) String [%s]', [S]));
    j := WordCountL(S, ' ');
    ch := 'A';
    for i := 1 to j do
      begin
        S2 := ExtractWordL(i, S, ' ');
        if StrStPosL(S, S2, Posn) then
          begin
            S := StrStDeleteL(S, Posn, length(S2));
            S2 := CharStrL(ch, length(S2));
            inc(ch);
            S := StrStInsertL(S, S2, Posn);
          end;
      end;
    WriteLog(Format('converted string: [%s]', [S]));
    WriteLog('...should be      [AAA BBB CCC DD EEE FFF]');
  finally
    CloseLog;
  end;
end.
