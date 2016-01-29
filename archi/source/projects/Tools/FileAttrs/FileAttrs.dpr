program FileAttrs;

{$APPTYPE CONSOLE}

uses
 SysUtils, Windows;

var
 AttrNames: array[1..32] of String;

 function lp_Attrs(anAttr: Integer): String;
 var
  l_IDX: Integer;
 begin
  Result := '';
  for l_IDX := 1 to 32 do
  begin
   if (anAttr and 1) <> 0 then
   begin
    if AttrNames[l_IDX] <> '' then
     Result := Result + AttrNames[l_IDX]
    else
     Result := Result + IntToStr(l_IDX) + ' ';
   end;
   anAttr := anAttr shr 1;
  end;
 end;

 procedure lp_WriteOutDir(const aDir, aPrefix: String);
 var
  l_Rec: TSearchRec;
  l_Result: Integer;
 begin
  l_Result := FindFirst(aDir+aPrefix+'*.*', faAnyFile, l_Rec);
  try
   while l_Result = 0 do
   begin
    if (l_Rec.Attr and faDirectory) <> 0 then
    begin
     if (l_Rec.Name <> '.') and (l_Rec.Name <> '..') then
     begin
      WriteLn(Format('%s%s <DIR> %s', [aPrefix, l_Rec.Name, lp_Attrs(l_Rec.Attr)]));
      lp_WriteOutDir(aDir, aPrefix+l_Rec.Name+'\');
     end; 
    end
    else
    begin
     WriteLn(Format('%s%s %s', [aPrefix, l_Rec.Name, lp_Attrs(l_Rec.Attr)]));
    end;
    l_Result := FindNext(l_Rec);
   end;
  finally
   SysUtils.FindClose(l_Rec);
  end;
 end;

var
 l_Dir: String;
 l_File: String;
 l_Prefix: String;
 l_IDX: Integer;

begin
 for l_IDX := 1 to 32 do
  AttrNames[l_IDX] := '';
 AttrNames[1] := 'READONLY '; //1
 AttrNames[2] := 'HIDDEN '; //2
 AttrNames[3] := 'SYSTEM '; //4
 AttrNames[4] := 'VolumeID '; //8
 AttrNames[5] := 'DIRECTORY '; //10
 AttrNames[6] := 'ARCHIVE '; //20
 AttrNames[7] := 'DEVICE/LINK '; //40
 AttrNames[8] := 'NORMAL '; //80
 AttrNames[9] := 'TEMPORARY '; //100
 AttrNames[10] := 'SPARSE_FILE '; //200
 AttrNames[11] := 'REPARSE_POINT '; //400
 AttrNames[12] := 'COMPRESSED '; //800
 AttrNames[13] := 'OFFLINE '; //1000
 AttrNames[14] := 'NOT_CONTENT_INDEXED '; //2000
 AttrNames[15] := 'ENCRYPTED '; //4000
 AttrNames[17] := 'VIRTUAL '; //8000


 if ParamCount = 1 then
  l_Dir := ParamStr(1)
 else
  l_Dir := ExtractFilePath(ParamStr(0));
 if DirectoryExists(l_Dir) then
 begin
  l_Dir := IncludeTrailingPathDelimiter(l_Dir);
  l_Prefix := '';
  lp_WriteOutDir(l_Dir, l_Prefix);
 end
 else
  l_File := ExpandFileName(l_Dir);
  if FileExists(l_File) then
   WriteLn(Format('%s %s', [l_Dir, lp_Attrs(GetFileAttributes(PChar(l_File)))]))
  else
   WriteLn(Format('Directory %s not found', [l_Dir]));
// ReadLn;
end.
