program mtdorb_cs_reg;
{$APPTYPE CONSOLE}
uses
  SysUtils,
  Classes,
  orbtypes;

type
  TInfoList = array of TCodesetInfo;
var
  infoList: TInfoList = nil;

function WordCount(const S: string): Integer;
var
  SLen, I: Cardinal;
begin
  Result := 0;
  I := 1;
  SLen := Length(S);
  while I <= SLen do begin
    while (I <= SLen) and (S[I] = ':') do Inc(I);
    if I <= SLen then Inc(Result);
    while (I <= SLen) and not(S[I] = ':') do Inc(I);
  end;
end;

function WordPosition(const N: Integer; const S: string): Integer;
var
  Count, I: Integer;
begin
  Count := 0;
  I := 1;
  Result := 0;
  while (I <= Length(S)) and (Count <> N) do begin
    { skip over delimiters }
    while (I <= Length(S)) and (S[I] = ':') do Inc(I);
    { if we're not beyond end of S, we're at the start of a word }
    if I <= Length(S) then Inc(Count);
    { if not finished, find the end of the current word }
    if Count <> N then
      while (I <= Length(S)) and not (S[I] = ':') do Inc(I)
    else Result := I;
  end;
end;

function ExtractWord(N: Integer; const S: string): string;
var
  I: Integer;
  Len: Integer;
begin
  Len := 0;
  I := WordPosition(N, S);
  if I <> 0 then
    { find the end of the current word }
    while (I <= Length(S)) and not(S[I] = ':') do begin
      { add the I'th character to result }
      Inc(Len);
      SetLength(Result, Len);
      Result[Len] := S[I];
      Inc(I);
    end;
  SetLength(Result, Len);
end;

procedure ReadFile(const AFile: Text);
var
  idx, len, wdCnt, wdIdx: integer;
  str, strUp: string;
  id : CodesetId;
  max_codepoints: _ushort;
  //max_codepoints: _ushort;
  charsets: string;
  desc: string;
  //name : string;
  strList: TStringList;
begin
  idx := 0;
  ReadLn(AFile, str);
  strList := TStringList.Create;
  try
    str := AdjustLineBreaks(str);
    strList.Text := str;
    while idx < strList.Count do begin
      str := strList.Strings[idx];
      if Pos('START', UpperCase(str)) = 0 then begin
        Inc(idx);
        Continue;
      end;
      desc := '';
      id := 0;
      charsets := '';
      max_codepoints := 0;
      repeat
        Inc(idx);
        str := strList.Strings[idx];
        strUp := UpperCase(str);
        if Pos('DESCRIPTION', strUp) > 0 then begin
          Delete(str, 1, Length('DESCRIPTION'));
          desc := Trim(str);
        end
        else if Pos('LOC_NAME', strUp) > 0 then begin
          Delete(str, 1, Length('LOC_NAME'));
        end
        else if Pos('RGY_VALUE', strUp) > 0 then begin
          Delete(str, 1, Length('RGY_VALUE'));
          id := StrToInt(Trim(str));
        end
        else if Pos('CHAR_VALUES', strUp) > 0 then begin
          Delete(str, 1, Length('CHAR_VALUES'));
          charsets := Trim(str);
        end
        else if Pos('MAX_BYTES', strUp) > 0 then begin
          Delete(str, 1, Length('MAX_BYTES'));
          max_codepoints := StrToInt(Trim(str));
        end;
      until (idx >= strList.Count) or (Pos('END', strUp) > 0);
      len := Length(infoList);
      SetLength(infoList, len + 1);
      infoList[len].id := id;
      infoList[len].desc := desc;
      wdCnt := WordCount(charsets);
      for wdIdx := 1 to wdCnt do
        infoList[len].charsets[wdIdx - 1] := StrToInt(ExtractWord(wdIdx, charsets));
      if Pos('UCS-2', desc) <> 0 then begin
        infoList[len].codepoint_size := 2;
        infoList[len].max_codepoints := 1;
      end
      else if Pos('UCS-4', desc) <> 0 then begin
        infoList[len].codepoint_size := 4;
        infoList[len].max_codepoints := 1;
      end
      else if Pos('UTF-16', desc) <> 0 then begin
        infoList[len].codepoint_size := 2;
        infoList[len].max_codepoints := 2;
      end
      else begin
        infoList[len].codepoint_size := 1;
        infoList[len].max_codepoints := max_codepoints;
      end;
      infoList[len].name := 'ofs' + IntToHex(id, 8);
    end; { while }
  finally
    strList.Free;
  end; { try/finally }
end;

procedure CreatePasFile;
var
  i: integer;
  f: Text;
begin
  AssignFile(f, 'codeset_ref.pas');
  Rewrite(f);
  try
    WriteLn(f, '// **********************************************************************');
    WriteLn(f, '//');
    WriteLn(f, '// Copyright (c) 2001 MT Tools.');
    WriteLn(f, '//');
    WriteLn(f, '// All Rights Reserved');
    WriteLn(f, '//');
    WriteLn(f, '// MT_DORB is based in part on the product DORB,');
    WriteLn(f, '// written by Shadrin Victor');
    WriteLn(f, '//');
    WriteLn(f, '// See Readme.txt for contact information');
    WriteLn(f, '//');
    WriteLn(f, '// **********************************************************************');
    WriteLn(f, '// automatically generated from code_set_registry.txt and mtdorb_code_set_registry.txt by mtdorb_cs_reg');
    WriteLn(f, 'unit codeset_ref;');
    WriteLn(f);
    WriteLn(f, 'interface');
    WriteLn(f);
    WriteLn(f, 'uses');
    WriteLn(f, '  orbtypes;');
    WriteLn(f);
    WriteLn(f, 'const');
    WriteLn(f, Format('  TCodesets : array[0..%d] of TCodesetInfo = (', [Length(infoList) - 1]));
    for i := 0 to Length(infoList) - 1 do begin
      with infoList[i] do
        Write(f, Format('    (id:$%8.8x; codepoint_size:%d; max_codepoints:%d; charsets:($%4.4x, $%4.4x, $%4.4x, $%4.4x, $%4.4x); desc:''%s''; name:''%s'')', [id, codepoint_size, max_codepoints, charsets[0], charsets[1], charsets[2], charsets[3], charsets[4], desc, name]));
      if i <> Length(infoList) - 1 then
        WriteLn(f, ',')
      else
        WriteLn(f);
    end;
    WriteLn(f, '  );');
    WriteLn(f);
    WriteLn(f, 'implementation');
    WriteLn(f);
    WriteLn(f, 'end.');
  finally
    CloseFile(f);
  end; { try/finally }
end;

procedure MainProc;
var
  fIdx: integer;
  f: Text;
begin
  for fIdx := 1 to ParamCount() do begin
    AssignFile(f, ParamStr(fIdx));
    Reset(f);
    try
      ReadFile(f);
    finally
      CloseFile(f);
    end; { try/finally }
  end;
  CreatePasFile;
end;

begin
  MainProc;
end.