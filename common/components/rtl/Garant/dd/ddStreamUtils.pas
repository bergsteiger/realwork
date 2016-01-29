unit ddStreamUtils;

interface
Uses
 Classes;

procedure ReadFile(aStream: TStream; aFolderName: AnsiString);

procedure WriteStrings(aStream: TStream; aStrings: TStrings);

procedure ReadFolder(aStream: TStream; aFolderName: AnsiString);

procedure ReadString(aStream: TStream; out aStr: AnsiString); overload;

procedure ReadStrings(aStream: TStream; aStrings: TStrings);

procedure WriteFile(aStream: TStream; aFileName: AnsiString; const aLocalName: AnsiString = '');

procedure WriteFolder(aStream: TStream; aFolderName: AnsiString; aWithPath: Boolean = False);

procedure WriteString(aStream: TStream; const Str: Shortstring); overload;

procedure ReadString(aStream: TStream; out aStr: ShortString); overload;

procedure WriteString(aStream: TStream; const Str: AnsiString); overload;

implementation

Uses
 SysUtils, StrUtils,
 l3FileUtils, l3Stream, l3Types, l3Base;

procedure ReadFile(aStream: TStream; aFolderName: AnsiString);
var
  l_Stream: TStream;
  l_FileName: AnsiString;
  l_Len: Int64;
begin
 // Создавать резервные копии файлов!!!!
 ReadString(aStream, l_FileName);
 if l_FileName <> '' then
 begin
  ForceDirectories(aFolderName);
  l_FileName := ConcatDirName(aFolderName, l_FileName);
  if FileExists(l_FileName) then
   RenameToBack(l_FileName);
  ForceDirectories(ExtractFilePath(l_FileName));
  aStream.Read(l_Len, SizeOf(Int64));
  l_Stream := Tl3FileStream.Create(l_FileName, l3_fmWrite);
  try
   l_Stream.CopyFrom(aStream, l_Len);
  finally
   l3Free(l_Stream);
  end;
 end; // l_FileName <> ''
end;

procedure WriteStrings(aStream: TStream; aStrings: TStrings);
var
 i, l_Count: Integer;
begin
 l_Count := aStrings.Count;
 aStream.Write(l_Count, SizeOf(l_Count));
 for i:= 0 to Pred(l_Count) do
  WriteString(aStream, aStrings[i]);
end;

procedure ReadFolder(aStream: TStream; aFolderName: AnsiString);
var
 l_FileList: TStrings;
 l_Name, l_FolderName : AnsiString;
 i: Integer;
begin
 l_FileList := TStringList.Create;
 try
  ReadString(aStream, l_FolderName);
  if l_FolderName <> '' then
  begin
   l_FolderName := ConcatDirName(aFolderName, l_FolderName);
   ForceDirectories(l_FolderName);
  end
  else
   l_FolderName := aFolderName;
  ReadStrings(aStream, l_FileList);
  for i:= 0 to Pred(l_FileList.Count) do
  begin
   l_Name := l_FileList.Strings[i];
   if AnsiStartsText('###', l_Name) then  
    ReadFolder(aStream, ConcatDirName(aFolderName, ExtractFileName(l_Name)))
   else
    ReadFile(aStream, l_FolderName);
  end; // for i
 finally
  l3Free(l_FileList);
 end;
end;

procedure ReadString(aStream: TStream; out aStr: AnsiString);
var
  l_Len: Integer;
begin
 aStr := '';
 if (aStream.Position+SizeOf(Integer)) < aStream.Size then
 begin
  aStream.Read(l_Len, SizeOf(l_Len));
  SetLength(aStr, l_Len);
  if l_Len > 0 then
   aStream.Read(aStr[1], l_Len);
 end; // (aStream.Position+SizeOf(Integer)) < aStream.Size
end;

procedure ReadStrings(aStream: TStream; aStrings: TStrings);
var
 i, l_Count: Integer;
 l_S: AnsiString;
begin
 if (aStream.Position+SizeOf(Integer)) < aStream.Size then
 begin
  aStream.Read(l_Count, SizeOf(l_Count));
  aStrings.Clear;
  for i:= 0 to Pred(l_Count) do
  begin
   ReadString(aStream, l_S);
   aStrings.Add(l_S);
  end; // for i
 end; // (aStream.Position+SizeOf(Integer)) < aStream.Size
end;

procedure WriteFile(aStream: TStream; aFileName: AnsiString; const aLocalName: AnsiString = '');
var
  l_Stream: TStream;
  l_Len: Int64;
begin
  if aLocalName = '' then
   WriteString(aStream, ExtractFileName(aFileName))
  else
   WriteString(aStream, aLocalName);
  l_Len := GetFileSize(aFileName);
  aStream.Write(l_Len, SizeOf(Int64));
  l_Stream := Tl3FileStream.Create(aFileName, l3_fmRead);
  try
   aStream.CopyFrom(l_Stream, l_Len);
  finally
   l3Free(l_Stream);
  end;
end;

procedure WriteFolder(aStream: TStream; aFolderName: AnsiString; aWithPath: Boolean = False);
var
 l_FileList: TStrings;
 l_SR : TSearchRec;
 l_Name : AnsiString;
 i: Integer;
begin
 l_FileList := TStringList.Create;
 try
  if FindFirst(ConcatDirName(aFolderName, '\*.*'), faAnyFile, l_SR) = 0 then
  begin
   repeat
    if l_SR.Name[1] <> '.' then
    begin
     l_Name := ConcatDirName(aFolderName, l_SR.Name);
     if l_SR.Attr and faDirectory = faDirectory then
      l_Name := '###' + l_Name;
     l_FileList.Add(l_Name);
    end; // l_SR.Name[1] <> '.'
   until FindNext(l_sr) <> 0;
   FindClose(l_SR);
  end; // FindFirst(aFolder, faAnyFile, l_SR)
  if aWithPath then
   WriteString(aStream, ExtractFileName(aFolderName))
  else
   WriteString(aStream, '');
  WriteStrings(aStream, l_FileList);
  for i:= 0 to Pred(l_FileList.Count) do
  begin
   l_Name := l_FileList.Strings[i];
   if AnsiStartsText('###', l_Name) then
    WriteFolder(aStream, Copy(l_Name, 4, Length(l_Name)))
   else
    WriteFile(aStream, l_Name);
  end; // for i
 finally
  l3Free(l_FileList);
 end;
end;

procedure WriteString(aStream: TStream; const Str: Shortstring);
begin
 WriteString(aStream, String(Str));
end;

procedure ReadString(aStream: TStream; out aStr: ShortString);
var
 l_S: AnsiString;
begin
 ReadString(aStream, l_S);
 aStr:= ShortString(l_S);
end;

procedure WriteString(aStream: TStream; const Str: AnsiString);
var
  l_Len: Integer;
begin
  l_Len := Length(Str);
  aStream.Write(l_Len, SizeOf(l_Len));
  if l_Len > 0 then
   aStream.Write(Str[1], l_Len);
end;

end.
