program checkpng;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  hyieutils,
  ImageEnIO;

const
 gSkip300: Boolean = False;

var
 gFoundCount: Integer;

procedure CheckFile(aFileName: string);
var
 l_PngFileName: string;
 l_IO : TImageEnIO;
 l_Bmp: TIEBitmap;
begin
 l_Bmp := TIEBitmap.Create;
 try
  l_IO := TImageEnIO.Create(nil);
  try
   l_IO.IEBitmap := l_Bmp;
   l_IO.LoadFromFilePNG(aFileName);
   if (l_IO.Params.Dpi <> 300) then
   begin
    Writeln(Format('%s (dpi = %d)',[aFileName, l_IO.Params.Dpi]));
    Inc(gFoundCount);
   end;
  finally
   l_IO.Free;
  end;
 finally
  l_Bmp.Free;
 end;
end;


procedure IterateFilesInDir(aDir: string);
var
 l_SR: TSearchRec;
 l_Res : Integer;
 l_CurDir: string;
 l_FileToConvert: string;
begin
 l_CurDir := IncludeTrailingPathDelimiter(aDir);
 l_Res := FindFirst(l_CurDir+'*.*',
              faAnyFile and not faVolumeID, l_SR);
 try
  while l_Res = 0 do
  begin
   l_FileToConvert := l_CurDir + l_SR.Name;
   if (l_SR.Attr and faDirectory <> 0) and (l_SR.Name[1] <> '.') then
    IterateFilesInDir(l_FileToConvert)
   else
    if UpperCase(ExtractFileExt(l_SR.Name)) = '.PNG' then
     CheckFile(l_FileToConvert);
   l_Res := FindNext(l_SR)
  end;
 finally
  FindClose(l_SR);
 end;
end;

procedure OutTheHelp;
begin
 Writeln('Usage: checkpng <directory containing PNG files>');
 Halt(1);
end;

var
 l_Dir: string;
begin
 Writeln('BMP to PNG converter'#10#13);
 if ParamCount = 0 then
  OutTheHelp;
 l_Dir := ParamStr(1);
 if not DirectoryExists(l_Dir) then
 begin
  Writeln(Format('Directory %s not found!', [l_Dir]));
  Halt(1);
 end;
 gFoundCount := 0;
 IterateFilesInDir(l_Dir);
 Writeln(Format('%d files found.', [gFoundCount]));
end.
