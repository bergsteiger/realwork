Unit ddNSRCUtils;

{$I ddDefine.inc }

interface

Uses
 SysUtils, Classes;

function CopyNSRCFile(Sour,Dest : TFileName): Boolean;

//function CheckNSRCFile(aFileName: AnsiString; theList: TStrings): Boolean;

implementation

Uses
 StrUtils,
 l3FileUtils, l3Stream, l3Types, l3Base, ddSegmentScanner, l3String,
 evNSRCConst, l3Const,

 ddNSRCSegments
 ;

const
 cPicToken = ev_NSRCFormula + 'pic:';
 cObjToken = '!OBJPATH ';
 cTopicToken = '!TOPIC ';
 cObjTopicToken = '!OBJTOPIC ';

function CopyNSRCFile(Sour,Dest : TFileName): Boolean;
var
 l_Stream: Tl3TextStream;
 S, S2, l_ObjFileName: AnsiString;
 l_PicPos: Integer;
 l_Scanner: TddSegmentScanner;
 l_IDX: Integer;
 l_S: Tl3String;
 l_Checked: Boolean;
begin
 Result := False;
 if FileExists(Sour) then
 try
  CopyFile(Sour, Dest);
  l_Scanner := TddSegmentScanner.Create;
  try
   l_Stream:= Tl3TextStream.Create(Sour, l3_fmRead);
   try
     l_Checked := False;
     while not l_Stream.IsEOF do
     begin
       S:= l_Stream.GetLine;
       if not l_Checked and (Trim(S) <> '') and not AnsiStartsText(';', S) then
       begin
        l_Checked := True;
        if not AnsiStartsText(cTopicToken, S) and not AnsiStartsText(cObjTopicToken, S) then
        begin
         Result := True;
         Exit;
        end;
       end;
       if AnsiStartsText('!OBJPATH', S) then
       begin // Теперь осталось скопировать файл с созданием каталога
        S:= Copy(S, Pos(' ', S)+1, Length(S));
        S2:= ConcatDirName(ExtractFileDir(Dest), ExtractFilePath(S));
        l_ObjFileName:= ConcatDirName(ExtractFilePath(Sour), S);
        if FileExists(l_ObjFileName) then
        begin
         ForceDirectories(S2);
         try
          CopyFile(l_ObjFileName,
                   ConcatDirName(S2, ExtractFileName(S)));
         except
          on E: Exception do
          begin
           l3System.Msg2Log(Format('Ошибка копирования "файла-картинки" (%s)',
                                  [ConcatDirName(ExtractFilePath(Sour), S)]));
           l3System.Exception2Log(E);
          end; // on E
         end; // try..except
        end // FileExists
        else
         l3System.Msg2Log(Format('Файл (%s), указанный в !OBJPATH отсутствует',
                                 [l_ObjFileName]));
       end; // if Pos
       l_PicPos := l3Pos(l3CStr(S), cPicToken);
       if l_PicPos <> l3NotFound then
       begin
        l_S := Tl3String.Make(l3PCharLen(Copy(S, l_PicPos + 1, Length(S))));
        try
         Assert(l_Scanner <> nil);
         l_Scanner.Scan(l_S, False, #13);
         for l_IDX := 0 to l_Scanner.Objects.Count - 1 do
          if l_Scanner.Objects[l_IDX] is TsegPicture then
          begin
           S2:= ConcatDirName(ExtractFileDir(Dest), ExtractFilePath(TsegPicture(l_Scanner.Objects[l_IDX]).FileName));
           l_ObjFileName:= ConcatDirName(ExtractFilePath(Sour), TsegPicture(l_Scanner.Objects[l_IDX]).FileName);
           if FileExists(l_ObjFileName) then
           begin
            ForceDirectories(S2);
            try
             CopyFile(l_ObjFileName,
                      ConcatDirName(S2, ExtractFileName(TsegPicture(l_Scanner.Objects[l_IDX]).FileName)));
            except
             on E: Exception do
             begin
              l3System.Msg2Log(Format('Ошибка копирования "файла-картинки" (%s)',
                                     [ConcatDirName(ExtractFilePath(Sour), TsegPicture(l_Scanner.Objects[l_IDX]).FileName)]));
              l3System.Exception2Log(E);
             end; // on E
            end; // try..except
           end // FileExists
           else
            l3System.Msg2Log(Format('Файл (%s), указанный в !!Pic отсутствует',
                                    [l_ObjFileName]));
          end;
        finally
         l3Free(l_S);
        end;
       end;
     end; // while not l_Stream.IsEOF
   finally
    l3Free(l_Stream);
   end; // try..finally
  finally
   l3Free(l_Scanner);
  end;
  Result:= True;
 except
  on E: Exception do
  begin
   Result:= False;
   l3System.Msg2Log(Format('Ошибка копирования файла %s', [Sour]));
   l3System.Exception2Log(E);
  end; // on E
 end // try except
 else
  l3System.Msg2Log(Format('Указанный файл (%s) отсутствует', [Sour]));
end;
(*
{ TODO : Использование на клиенте надо убирать - перенося логику в Task.SourceFiles }
function CheckNSRCFile(aFileName: AnsiString; theList: TStrings): Boolean;
var
 l_Stream: Tl3TextStream;
 l_Text, l_Folder, l_ObjFileName: AnsiString;
 l_PicPos: Integer;
 l_Scanner: TddSegmentScanner;
 l_IDX: Integer;
 l_S: Tl3String;
begin
 if FileExists(aFileName) then
 begin
  Result := True;
  theList.Add(aFileName);
  l_Folder := ExtractFilePath(aFileName);
  l_Scanner := TddSegmentScanner.Create;    
  try
    l_Stream:= Tl3TextStream.Create(aFileName, l3_fmRead);
    try
      while not l_Stream.IsEOF do
      begin
        l_Text:= l_Stream.GetLine;
        if AnsiStartsText('!OBJPATH', l_Text) then
        begin // Теперь осталось скопировать файл с созданием каталога
         l_ObjFileName:= ConcatDirName(l_Folder, Copy(l_Text, Pos(' ', l_Text)+1, Length(l_Text)));
         if FileExists(l_ObjFileName) then
          theList.Add('###'+l_ObjFileName)
         else
          l3System.Msg2Log(Format('Файл (%s), указанный в !OBJPATH отсутствует', [l_ObjFileName]));
        end; // if Pos
        l_PicPos := l3Pos(l3CStr(l_Text), cPicToken);
        if l_PicPos <> l3NotFound then
        begin
         l_S := Tl3String.Make(l3PCharLen(Copy(l_Text, l_PicPos + 1, Length(l_Text))));
         try
           l_Scanner.Scan(l_S, False, #13);
         finally
           l3Free(l_S);
         end;
        end;
      end; // while not l_Stream.IsEOF
      for l_IDX := 0 to l_Scanner.Objects.Count - 1 do
        if l_Scanner.Objects[l_IDX] is TsegPicture then
        begin
         l_ObjFileName:= ConcatDirName(l_Folder, TsegPicture(l_Scanner.Objects[l_IDX]).FileName);
         if FileExists(l_ObjFileName) then
          theList.Add('###'+l_ObjFileName)
         else
          l3System.Msg2Log(Format('Файл (%s), указанный в Pic: отсутствует', [l_ObjFileName]));
        end;
    finally
     l3Free(l_Stream);
    end; // try..finally
  finally
    l3Free(l_Scanner);
  end;
 end
 else
 begin
  l3System.Msg2Log(Format('Указанный файл (%s) отсутствует', [aFileName]));
  Result := False;
 end;
end;
*)
end.
