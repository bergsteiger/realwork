{*********************************************************}
{*                  TESTSTRS.DPR 1.05                    *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TestStrS;

{$I STDEFINE.INC}

{$IFDEF Win32}
  {$APPTYPE CONSOLE}
{$ENDIF}

uses
  SysUtils,
  {$IFDEF OS32}
   {$IFDEF WIN32}
  Windows,
   {$ENDIF}
  {$ELSE}
  WinTypes, WinProcs,
  {$ENDIF}
  STBase,
  STStrS,
  tstutil;

var
  S, S2 : string[255];
  i, j : longint;
  Posn : Cardinal;
  BM   : BTable;
  Ch   : AnsiChar;

begin
  OpenLog('TEST.LOG');
  try
    WriteLog('CharStrS test');
    for i := 1 to 10 do
      begin
        S := CharStrS('x', i);
        WriteLog(Format('[%s]', [S]));
      end;

    WriteLog('PadChS/TrimTrailS test');
    for i := 10 to 20 do
      begin
        S := 'the cat sat';
        S := PadChS(S, ' ', i);
        WriteLog(Format('Padded  [%s]', [S]));
        S := TrimTrailS(S);
        WriteLog(Format('Trimmed [%s]', [S]));
      end;

    WriteLog('LeftPadChS/TrimLeadS test');
    for i := 10 to 20 do
      begin
        S := 'the cat sat';
        S := LeftPadChS(S, ' ', i);
        WriteLog(Format('Padded  [%s]', [S]));
        S := TrimLeadS(S);
        WriteLog(Format('Trimmed [%s]', [S]));
      end;

    WriteLog('CenterChS/TrimSpacesS test');
    for i := 10 to 20 do
      begin
        S := 'the cat sat';
        S := CenterChS(S, ' ', i);
        WriteLog(Format('Padded  [%s]', [S]));
        S := TrimSpacesS(S);
        WriteLog(Format('Trimmed [%s]', [S]));
      end;

    WriteLog('EntabS/DetabS test');
    for i := 1 to 100 do
      begin
        S := LeftPadChS('the cat sat', ' ', i) + LeftPadChS(' on the mat', ' ', i);
        S2 := DetabS(EntabS(S, 8), 8);
        if (S <> S2) then
          begin
            WriteLog(Format('Error: [%s] not en/detabbed correctly (iteration %d)', [S,i]));
            S2 := EntabS(S, 8);
            WriteLogStrDump(S2);
            S2 := DetabS(S2, 8);
            WriteLogStrDump(S2);
          end
        else
          WriteLog(Format('iteration %d', [i]));
      end;

    WriteLog('SubstituteS test');
    S := 'the cat sat on the mat';
    WriteLog(Format('Original  [%s]', [S]));
    S := SubstituteS(S, 'aeiou', 'AEIOU');
    WriteLog(Format('Subs''d    [%s]', [S]));

    WriteLog('FilterS test');
    S := 'the cat sat on the mat';
    WriteLog(Format('Original string [%s]', [S]));
    S := FilterS(S, 'aeiou');
    WriteLog(Format('Filtered vowels [%s]', [S]));

    WriteLog('CharCountS test');
    S := 'the cat sat on the mat';
    WriteLog(Format('Original  [%s]', [S]));
    i := CharCountS(S, 'a');
    j := CharCountS(S, 'z');
    WriteLog(Format('Number of a''s and z''s [%d, %d]', [i, j]));

    WriteLog('HexLS/Str2LongS test');
    for i := 0 to 10000 do
      begin
        S := '$' + HexLS(i);
        Str2LongS(S, j);
        if (i <> j) then
          begin
            WriteLog(Format('Error: [%d] was converted to [%s]', [i, S]));
          end;
      end;

    WriteLog('Long2StrS/Str2LongS test');
    for i := 0 to 10000 do
      begin
        S := Long2StrS(i);
        Str2LongS(S, j);
        if (i <> j) then
          begin
            WriteLog(Format('Error: [%d] was converted to [%s]', [i, S]));
          end;
      end;

    WriteLog('CommaizeS test');
    S := CommaizeS(1);
    WriteLog(S);
    S := CommaizeS(12);
    WriteLog(S);
    S := CommaizeS(123);
    WriteLog(S);
    S := CommaizeS(1234);
    WriteLog(S);
    S := CommaizeS(12345);
    WriteLog(S);
    S := CommaizeS(123456);
    WriteLog(S);
    S := CommaizeS(1234567);
    WriteLog(S);
    S := CommaizeS(12345678);
    WriteLog(S);
    S := CommaizeS(123456789);
    WriteLog(S);
    S := CommaizeS(1234567890);
    WriteLog(S);
    S := CommaizeS(-1);
    WriteLog(S);
    S := CommaizeS(-12);
    WriteLog(S);
    S := CommaizeS(-123);
    WriteLog(S);
    S := CommaizeS(-1234);
    WriteLog(S);
    S := CommaizeS(-12345);
    WriteLog(S);
    S := CommaizeS(-123456);
    WriteLog(S);
    S := CommaizeS(-1234567);
    WriteLog(S);
    S := CommaizeS(-12345678);
    WriteLog(S);
    S := CommaizeS(-123456789);
    WriteLog(S);
    S := CommaizeS(-1234567890);
    WriteLog(S);

    WriteLog('SoundexS test');
    for i := 1 to 20 do
      begin
        S := RandomStr(Random(9) + 1);
        S2 := SoundexS(S);
        WriteLog(Format('[%s] -> [%s]', [S, S2]));
      end;

    WriteLog('Word counting tests');
    S := 'the cat sat on the mat and said ''hi,there''';
    WriteLog(Format('String: [%s]', [S]));
    j := WordCountS(S, ' ,.');
    WriteLog(Format('Word count: [%d]', [j]));
    for i := 1 to j do
      begin
        WordPositionS(i, S, ' ,.', Posn);
        S2 := ExtractWordS(i, S, ' ,.');
        WriteLog(Format('Word %d is [%s] at %d', [i, S2, Posn]));
      end;
    j := AsciiCountS(S, ' ,.', '''');
    WriteLog(Format('Ascii word count: [%d]', [j]));
    for i := 1 to j do
      begin
        AsciiPositionS(i, S, ' ,.', '''', Posn);
        S2 := ExtractAsciiS(i, S, ' ,.', '''');
        WriteLog(Format('Word %d is [%s] at %d', [i, S2, Posn]));
      end;
    S := 'somesillysingleword';
    WriteLog(Format('String: [%s]', [S]));
    j := WordCountS(S, ' ,.');
    WriteLog(Format('Word count: [%d]', [j]));
    for i := 1 to j do
      begin
        WordPositionS(i, S, ' ,.', Posn);
        S2 := ExtractWordS(i, S, ' ,.');
        WriteLog(Format('Word %d is [%s] at %d', [i, S2, Posn]));
      end;
    j := AsciiCountS(S, ' ,.', '''');
    WriteLog(Format('Ascii word count: [%d]', [j]));
    for i := 1 to j do
      begin
        AsciiPositionS(i, S, ' ,.', '''', Posn);
        S2 := ExtractAsciiS(i, S, ' ,.', '''');
        WriteLog(Format('Word %d is [%s] at %d', [i, S2, Posn]));
      end;

    WriteLog('Boyer-Moore tests');
    S := 'the cat sat on the mat';
    WriteLog(Format('Search string: [%s]', [S]));
    j := WordCountS(S, ' ');
    for i := 1 to j do
      begin
        S2 := ExtractWordS(i, S, ' ');
        BMMakeTableS(S2, BM);
        if BMSearchS(S[1], length(S), BM, S2, Posn) then
          WriteLog(Format('Word [%s] found at %d', [S2, Posn]))
        else
          WriteLog(Format('Word [%s] not found', [S2]));
        S2 := AnsiUpperCase(S2);
        BMMakeTableS(S2, BM);
        if BMSearchUCS(S[1], length(S), BM, S2, Posn) then
          WriteLog(Format('Word [%s] found at %d (UC)', [S2, Posn]))
        else
          WriteLog(Format('Word [%s] not found (UC)', [S2]));
      end;

    WriteLog('Various tests');
    S := 'the cat sat on the mat';
    WriteLog(Format('(StrChPosS) String [%s]', [S]));
    for ch := 'a' to 'z' do
      begin
        if StrChPosS(S, ch, Posn) then
          WriteLog(Format('Character [%s] found at %d', [ch, Posn]));
      end;
    S := 'the cat sat on the mat';
    WriteLog(Format('(StrStPosS) String [%s]', [S]));
    j := WordCountS(S, ' ');
    for i := 1 to j do
      begin
        S2 := ExtractWordS(i, S, ' ');
        if StrStPosS(S, S2, Posn) then
          WriteLog(Format('[%s] is at %d', [S2, Posn]))
        else
          WriteLog(Format('[%s] is not found', [S2]));
      end;
    S := 'the cat sat on the mat';
    WriteLog(Format('(StrChInsertS/StrChDeleteS) String [%s]', [S]));
    for ch := 'a' to 'z' do
      begin
        if StrChPosS(S, ch, Posn) then
          begin
            S := StrChDeleteS(S, Posn);
            S := StrChInsertS(S, Upcase(Ch), Posn);
          end
        else
          S := StrChInsertS(S, Ch, 1);
      end;
    WriteLog(Format('Converted string: [%s]', [S]));
    WriteLog('...should be      [zyxwvurqplkjigfdbTHE CAt Sat ON the Mat]');
    S := 'the cat sat on the mat';
    WriteLog(Format('(StrStInsertS/StrStDeleteS) String [%s]', [S]));
    j := WordCountS(S, ' ');
    ch := 'A';
    for i := 1 to j do
      begin
        S2 := ExtractWordS(i, S, ' ');
        if StrStPosS(S, S2, Posn) then
          begin
            S := StrStDeleteS(S, Posn, length(S2));
            S2 := CharStrS(ch, length(S2));
            inc(ch);
            S := StrStInsertS(S, S2, Posn);
          end;
      end;
    WriteLog(Format('converted string: [%s]', [S]));
    WriteLog('...should be      [AAA BBB CCC DD EEE FFF]');
  finally
    CloseLog;
  end;
end.
