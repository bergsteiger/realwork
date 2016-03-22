program belacut;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  l3Types,
  l3Chars,
  l3String,
  l3Base,
  l3Interfaces,
  l3Filer,
  ddUtils;

var
 FIn, FOut: Tl3DOSFiler;
 l_Topic: AnsiString;
 l_SearchStr: Il3CString;
 l_Str: Tl3WString;
 l_Flush, l_Done: Boolean;
 l_NumOfTopics: Integer;
 l_TopicCount: Integer;
begin
 Writeln('Belarus Cut-Out Util 1.0');
 l_Topic := ParamStr(2);
 l_NumOfTopics := StrToIntDef(ParamStr(3), 1);
 if l_Topic = '' then
 begin
  Writeln('Format: belacut <file> <topic> [<number of docs>]');
  Exit;
 end;
 l_SearchStr := l3Upper(l3CStr('NR '+l_Topic));
 FIn := Tl3DOSFiler.Make(ParamStr(1), l3_fmRead, False);
 try
  FOut := Tl3DOSFiler.Make(l_Topic + '.txt', l3_fmWrite, False);
  try
   FIn.Open;
   FOut.Open;
   l_Flush := False;
   l_Done  := False;
   l_TopicCount := 0;
   repeat
    l_Str := FIn.ReadLn;
    if l3Same(l_Str, l_SearchStr, True) then
     l_Flush := True;
    if l_Flush then
    begin
     FOut.WriteLn(l_Str);
     if (l_Str.SLen > 0) and (l_Str.S[0] = cc_DollarSign) then
     begin
      Inc(l_TopicCount);
      if l_TopicCount = l_NumOfTopics then
       l_Done := True;
     end;
    end;
   until l_Done or FIn.EOF;
   if l_Done then
    Writeln(Format('%s is found and saved to %s.txt', [NumSuffix(l_TopicCount, 'document', 'documents', 'documents'), l_Topic]))
   else
    if l_TopicCount = 0 then
     Writeln('Document is NOT found in source file!')
    else
     Writeln(Format('ONLY %d out of %s were found and saved to %s.txt due to unexpeted end of file!',
       [l_TopicCount, NumSuffix(l_NumOfTopics, 'document', 'documents', 'documents'), l_Topic]));
   l_SearchStr := nil;
  finally
   FreeAndNil(FOut);
  end;
 finally
  FreeAndNil(FIn);
 end;
end.
