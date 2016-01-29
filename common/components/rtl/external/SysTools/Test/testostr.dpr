{*********************************************************}
{*                  TESTOSTR.DPR 1.05                    *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TestOstr;

{$I STDEFINE.INC}

{$IFDEF Win32}
  {$APPTYPE CONSOLE}
{$ENDIF}

{$IFDEF VirtualPascal}
  {$R SYSUTILS.RES}
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
  STOStr,
  tstutil;

var
  S : TStString;
  Key : ShortString;
  SS : ShortString;
  i, j, k : longint;
  Posn : Cardinal;
  Ch   : AnsiChar;
  StError : Boolean;

begin
  OpenLog('TEST.LOG');
  try
    WriteLog('Testing constructors');
    WriteLog(' - Create');
    S := TStString.Create;
    try
      WriteLog(Format('Allocated size - %d', [S.AllocLength]));
      WriteLog(Format('String length - %d', [S.Length]));
    finally
      S.Free;
    end;
    WriteLog(' - CreateAlloc');
    for i := 1 to 10 do begin
      S := TStString.CreateAlloc(i * 1000);
      WriteLog(Format('Allocated size - %d', [S.AllocLength]));
      WriteLog(Format('String length - %d', [S.Length]));
      S.Free;
    end;
    WriteLog(' - CreateS');
    S := TStString.CreateS('the cat in the mat');
    WriteLog(Format('Allocated size - %d', [S.AllocLength]));
    WriteLog(Format('String length - %d', [S.Length]));
    S.AllocLength := 6;
    WriteLog(Format('Chopped - [%s]', [S.AsShortStr]));
    WriteLog(Format('Allocated size - %d', [S.AllocLength]));
    WriteLog(Format('String length - %d', [S.Length]));
    S.Free;
    WriteLog(' - CreateZ');
    S := TStString.CreateZ('the mat on the cat');
    WriteLog(Format('Allocated size - %d', [S.AllocLength]));
    WriteLog(Format('String length - %d', [S.Length]));
    S.Free;
  {$IFDEF Win32}
    WriteLog(' - CreateV');
    S := TStString.CreateV(897776676);
    WriteLog(Format('Allocated size - %d', [S.AllocLength]));
    WriteLog(Format('String length - %d', [S.Length]));
    S.Free;
  {$ENDIF}

    WriteLog('Append tests');
    S := TStString.CreateS('This is a test');
    try
      WriteLog(Format('[%s]', [S.AsShortStr]));
      WriteLog(Format('Allocated size - %d', [S.AllocLength]));
      WriteLog(Format('String length - %d', [S.Length]));
      S.AppendString(' of');
      S.AppendString(' the');
      S.AppendPChar(' emergency');
      S.AppendPChar(' broadcast');
      S.AppendString(' system.');
      WriteLog(Format('[%s]', [S.AsShortStr]));
      WriteLog(Format('Allocated size - %d', [S.AllocLength]));
      WriteLog(Format('String length - %d', [S.Length]));
    finally
      S.Free;
    end;

    WriteLog('CharStr test');
    S := TStString.CreateAlloc(10);
    try
      for i := 1 to 10 do begin
        S.CharStr('x', i);
        WriteLog(Format('[%s]', [S.AsShortStr]));
        WriteLog(Format('Allocated size - %d', [S.AllocLength]));
        WriteLog(Format('String length - %d', [S.Length]));
      end;
    finally
        S.Free;
    end;

    WriteLog('PadCh/TrimTrail test');
    for i := 10 to 20 do begin
      S := TStString.CreateS('the cat sat');
      try
        S.PadCh(' ', i);
        WriteLog(Format('Padded  [%s]', [S.AsShortStr]));
        S.TrimTrail;
        WriteLog(Format('Trimmed [%s]', [S.AsShortStr]));
      finally
        S.Free;
      end;
    end;

    WriteLog('LeftPadCh/TrimLead test');
    for i := 10 to 20 do begin
      S := TStString.CreateS('the cat sat');
      try
        S.LeftPadCh(' ', i);
        WriteLog(Format('Padded  [%s]', [S.AsShortStr]));
        S.TrimLead;
        WriteLog(Format('Trimmed [%s]', [S.AsShortStr]));
      finally
        S.Free;
      end;
    end;

    WriteLog('CenterCh/TrimSpaces test');
    for i := 10 to 20 do begin
      S := TStString.CreateS('the cat sat');
      try
        S.CenterCh(' ', i);
        WriteLog(Format('Padded  [%s]', [S.AsShortStr]));
        S.TrimSpaces;
        WriteLog(Format('Trimmed [%s]', [S.AsShortStr]));
      finally
        S.Free;
      end;
    end;

    WriteLog('Entab/Detab test');
    S := TStString.Create;
    try
      for i := 1 to 20 do begin
        SS := LeftPadChS('the cat sat', ' ', i) + LeftPadChS(' on the mat', ' ', i);
        S.AsShortStr := SS;
        S.Entab;
        S.Detab;
        if (S.AsShortStr <> SS) then begin
          WriteLog(Format('Error: [%s] not en/detabbed correctly (iteration %d)', [S.AsShortStr,i]));
          S.Entab;
          WriteLogStrDump(S.AsShortStr);
          S.Detab;
          WriteLogStrDump(S.AsShortStr);
        end
      else
        WriteLog(Format('iteration %d', [i]));
      end;
    finally
      S.Free;
    end;

    WriteLog('Substitute test');
    S := TStString.CreateS('the cat sat on the mat');
    try
      WriteLog(Format('Original  [%s]', [S.AsShortStr]));
      S.Substitute('aeiou', 'AEIOU');
      WriteLog(Format('Subs''d    [%s]', [S.AsShortStr]));
    finally
      S.Free;
    end;

    WriteLog('Filter test');
    S := TStString.CreateS('the cat sat on the mat and barked at the moon');
    try
      WriteLog(Format('Original string [%s]', [S.AsShortStr]));
      WriteLog(Format('Allocated size [%d]', [S.AllocLength]));
      S.Filter('aeiou');
      S.Pack;
      WriteLog(Format('Filtered vowels [%s]', [S.AsShortStr]));
      WriteLog(Format('Packed size [%d]', [S.AllocLength]));
    finally
      S.Free;
    end;

    WriteLog('CharCount test');
    S := TStString.CreateS('the cat sat on the mat');
    try
      WriteLog(Format('Original  [%s]', [S.AsShortStr]));
      i := S.CharCount('a');
      j := S.CharCount('t');
      k := S.CharCount('z');
      WriteLog(Format('Number of a''s, t''s and z''s [%d, %d, %d]', [i, j, k]));
    finally
      S.Free;
    end;

    WriteLog('Size test');
    S := TStString.CreateS('''This is a test'' of the emergency broadcast system');
    try
      WriteLog(Format('String  [%s]', [S.AsShortStr]));
      WriteLog(Format('Word size  [%d]', [S.SizeWordAtCursor(False)]));
      WriteLog(Format('With trailers [%d]', [S.SizeWordAtCursor(True)]));
      WriteLog(Format('Ascii size  [%d]', [S.SizeAsciiAtCursor(False)]));
      WriteLog(Format('With trailers  [%d]', [S.SizeAsciiAtCursor(True)]));
    finally
      S.Free;
    end;

    WriteLog('Soundex test');
    for i := 1 to 20 do begin
      S := TStString.CreateS(RandomStr(Random(9) + 1));
      try
        SS := S.Soundex;
        WriteLog(Format('[%s] -> [%s]', [S.AsShortStr, SS]));
      finally
        S.Free;
      end;
    end;

    WriteLog('Scramble test');
    for i := 1 to 10000 do begin
      Key := RandomStr(Random(9) + 1);
      S := TStString.CreateS(RandomStr(Random(9) + 1));
      try
        SS := S.AsShortStr;
        S.Scramble(Key);
        S.Scramble(Key);
        StError := False;
        if CompStringS(SS, S.AsShortStr) <> 0 then begin
          StError := True;
          WriteLog(Format('Error : [%s] -> [%s]', [SS, S.AsShortStr]));
        end;
      finally
        S.Free;
      end;
    end;
    if not StError then
      WriteLog('--> Passed');

    WriteLog('Word counting tests');
    S := TStString.CreateS('the cat sat on the mat and said ''hi,there''');
    try
      S.Delimiters := ' ,.';

      WriteLog('-- Zero based --');
      WriteLog(Format('String: [%s]', [S.AsShortStr]));
      j := S.WordCount;
      WriteLog(Format('Word count: [%d]', [j]));
      for i := 1 to j do begin
        if S.WordPosition(i, Posn) then
          SS := S.ExtractWord(i);
        WriteLog(Format('Word %d is [%s] at %d', [i, SS, Posn]));
      end;

      S.Quote := '''';
      j := S.AsciiCount;
      WriteLog(Format('Ascii word count: [%d]', [j]));
      for i := 1 to j do begin
        S.AsciiPosition(i, Posn);
        SS := S.ExtractAscii(i);
        WriteLog(Format('Word %d is [%s] at %d', [i, SS, Posn]));
      end;

      S.AsShortStr := 'somesillysingleword';
      WriteLog(Format('String: [%s]', [S.AsShortStr]));
      j := S.WordCount;
      WriteLog(Format('Word count: [%d]', [j]));
      for i := 1 to j do begin
        S.WordPosition(i, Posn);
        SS := S.ExtractWord(i);
        WriteLog(Format('Word %d is [%s] at %d', [i, SS, Posn]));
      end;

      j := S.AsciiCount;
      WriteLog(Format('Ascii word count: [%d]', [j]));
      for i := 1 to j do begin
        S.AsciiPosition(i, Posn);
        SS := S.ExtractAscii(i);
        WriteLog(Format('Word %d is [%s] at %d', [i, SS, Posn]));
      end;

      WriteLog('-- One based --');
      S.AsShortStr := 'the cat sat on the mat and said ''hi,there''';
      WriteLog(Format('String: [%s]', [S.AsShortStr]));
      S.OneBased := True;
      j := S.WordCount;
      WriteLog(Format('Word count: [%d]', [j]));
      for i := 1 to j do begin
        if S.WordPosition(i, Posn) then
          SS := S.ExtractWord(i);
        WriteLog(Format('Word %d is [%s] at %d', [i, SS, Posn]));
      end;

      S.Quote := '''';
      j := S.AsciiCount;
      WriteLog(Format('Ascii word count: [%d]', [j]));
      for i := 1 to j do begin
        S.AsciiPosition(i, Posn);
        SS := S.ExtractAscii(i);
        WriteLog(Format('Word %d is [%s] at %d', [i, SS, Posn]));
      end;

      S.AsShortStr := 'somesillysingleword';
      WriteLog(Format('String: [%s]', [S.AsShortStr]));
      j := S.WordCount;
      WriteLog(Format('Word count: [%d]', [j]));
      for i := 1 to j do begin
        S.WordPosition(i, Posn);
        SS := S.ExtractWord(i);
        WriteLog(Format('Word %d is [%s] at %d', [i, SS, Posn]));
      end;

      j := S.AsciiCount;
      WriteLog(Format('Ascii word count: [%d]', [j]));
      for i := 1 to j do begin
        S.AsciiPosition(i, Posn);
        SS := S.ExtractAscii(i);
        WriteLog(Format('Word %d is [%s] at %d', [i, SS, Posn]));
      end;
      S.OneBased := False;
    finally
      S.Free;
    end;

    WriteLog('Boyer-Moore tests - Zero Based');
    S := TStString.CreateS('the cat sat on the mat');
    try
      WriteLog(Format('Search string: [%s]', [S.AsShortStr]));
      j := S.WordCount;
      for i := 1 to j do begin
        SS := S.ExtractWord(i);
        if S.BMSearch(SS, Posn) then
          WriteLog(Format('Word [%s] found at %d', [SS, Posn]))
        else
          WriteLog(Format('Word [%s] not found', [SS]));
        if S.BMSearchUC(SS, Posn) then
          WriteLog(Format('Word [%s] found at %d (UC)', [SS, Posn]))
        else
          WriteLog(Format('Word [%s] not found (UC)', [SS]));
      end;
    finally
      S.Free;
    end;

    WriteLog('Boyer-Moore tests - One Based');
    S := TStString.CreateS('the cat sat on the mat');
    S.OneBased := True;
    try
      WriteLog(Format('Search string: [%s]', [S.AsShortStr]));
      j := S.WordCount;
      for i := 1 to j do begin
        SS := S.ExtractWord(i);
        if S.BMSearch(SS, Posn) then
          WriteLog(Format('Word [%s] found at %d', [SS, Posn]))
        else
          WriteLog(Format('Word [%s] not found', [SS]));
        if S.BMSearchUC(SS, Posn) then
          WriteLog(Format('Word [%s] found at %d (UC)', [SS, Posn]))
        else
          WriteLog(Format('Word [%s] not found (UC)', [SS]));
      end;
    finally
      S.Free;
    end;

    WriteLog('Various tests');
    S := TStString.CreateS('the cat sat on the mat');

    WriteLog(Format('(StrChPos - One Based) String [%s]', [S.AsShortStr]));
    S.OneBased := True;
    for ch := 'a' to 'z' do begin
      if S.StrChPos(ch, Posn) then
        WriteLog(Format('Character [%s] found at %d', [ch, Posn]));
    end;

    WriteLog(Format('(StrStPos - One Based) String [%s]', [S.AsShortStr]));
    j := S.WordCount;
    for i := 1 to j do
      begin
        SS := S.ExtractWord(i);
        if S.StrStPos(SS, Posn) then
          WriteLog(Format('[%s] is at %d', [SS, Posn]))
        else
          WriteLog(Format('[%s] is not found', [SS]));
      end;

    WriteLog(Format('(StrChPos - Zero Based) String [%s]', [S.AsShortStr]));
    S.OneBased := False;
    for ch := 'a' to 'z' do begin
      if S.StrChPos(ch, Posn) then
        WriteLog(Format('Character [%s] found at %d', [ch, Posn]));
    end;

    WriteLog(Format('(StrStPos - Zero Based) String [%s]', [S.AsShortStr]));
    S.Delimiters := ' ';
    j := S.WordCount;
    for i := 1 to j do begin
      SS := S.ExtractWord(i);
      if S.StrStPos(SS, Posn) then
        WriteLog(Format('[%s] is at %d', [SS, Posn]))
      else
        WriteLog(Format('[%s] is not found', [SS]));
    end;

    WriteLog(Format('(StrChInsert/StrChDelete - One Based) String [%s]', [S.AsShortStr]));
    S.OneBased := True;
    for ch := 'a' to 'z' do begin
      if S.StrChPos(ch, Posn) then begin
        S.StrChDelete(Posn);
        S.StrChInsert(Upcase(Ch), Posn);
      end else
        S.StrChInsert(Ch, 1);
    end;
    WriteLog(Format('Converted string: [%s]', [S.AsShortStr]));
    WriteLog('...should be      [zyxwvurqplkjigfdbTHE CAt Sat ON the Mat]');

    S.AsShortStr := 'the cat sat on the mat';
    S.RepeatValue := 5;
    S.CursorNextWord;
    WriteLog(Format('Word at cursor - [%s]', [S.GetWordAtCursor]));
    WriteLog(Format('(StrChInsert/StrChDelete - Zero Based) String [%s]', [S.AsShortStr]));
    S.OneBased := False;
    for ch := 'a' to 'z' do begin
      if S.StrChPos(ch, Posn) then begin
        S.StrChDelete(Posn);
        S.StrChInsert(Upcase(Ch), Posn);
      end else
        S.StrChInsert(Ch, 0);
    end;
    WriteLog(Format('Word at cursor - [%s]', [S.GetWordAtCursor]));
    WriteLog(Format('Converted string: [%s]', [S.AsShortStr]));
    WriteLog('...should be      [zyxwvurqplkjigfdbTHE CAt Sat ON the Mat]');

    S.AsShortStr := 'the cat sat on the mat';

    WriteLog(Format('(StrStInsert/StrStDelete) String [%s]', [S.AsShortStr]));
    S.RepeatValue := 3;
    S.CursorNextWord;
    WriteLog(Format('Word at cursor - [%s]', [S.GetWordAtCursor]));
    j := S.WordCount;
    ch := 'A';
    for i := 1 to j do
      begin
        SS := S.ExtractWord(i);
        if S.StrStPos(SS, Posn) then
          begin
            S.StrStDelete(Posn, length(SS));
            WriteLog(Format('Word at cursor (del) - [%s]', [S.GetWordAtCursor]));
            SS := CharStrS(ch, length(SS));
            inc(ch);
            S.StrStInsert(SS, Posn);
            WriteLog(Format('Word at cursor (ins) - [%s]', [S.GetWordAtCursor]));
          end;
      end;
    WriteLog(Format('Word at cursor - [%s]', [S.GetWordAtCursor]));
    WriteLog(Format('converted string: [%s]', [S.AsShortStr]));
    WriteLog('...should be      [AAA BBB CCC DD EEE FFF]');
    S.Free;
  finally
    CloseLog;
  end;
end.
