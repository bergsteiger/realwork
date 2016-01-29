program bmp2png;

{$APPTYPE CONSOLE}

uses
  Graphics,
  SysUtils,
  hyieutils,
  ImageEnIO;

const
 gSkip300: Boolean = False;

var
 gConvertedCount: Integer;

procedure ConvertFile(aFileName: string);
var
 l_PngFileName: string;
 l_IO : TImageEnIO;
 l_Bmp: TIEBitmap;
begin
 l_PngFileName := ChangeFileExt(aFileName, '.png');

 //if not FileExists(l_PngFileName) then
 begin
  l_Bmp := TIEBitmap.Create;
  try
   l_IO := TImageEnIO.Create(nil);
   try
    //l_IO.IEBitmap := l_Bmp;
    l_IO.LoadFromFileBMP(aFileName);
    if (l_IO.Params.Dpi <> 300) or (not gSkip300) then
    begin
     Writeln(aFileName);
     l_IO.Params.PNG_Compression := 9;
     //l_IO.SaveToFileBMP('c:\temp.bmp');
     l_IO.SaveToFilePNG(l_PngFileName);
     Inc(gConvertedCount);
    end;
   finally
    l_IO.Free;
   end;
  finally
   l_Bmp.Free;
  end;
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
    if UpperCase(ExtractFileExt(l_SR.Name)) = '.BMP' then
     ConvertFile(l_FileToConvert);
   l_Res := FindNext(l_SR)
  end;
 finally
  FindClose(l_SR);
 end;
end;

procedure OutTheHelp;
begin
 Writeln('Usage: bmp2png <directory containing BMP files>');
 //Writeln('-300 - Skip bmp files with 300 dpi (do not convert)');
 Halt(1);
end;

var
 l_Dir: string;
begin
 Writeln('BMP to PNG converter'#10#13);
 if ParamCount = 0 then
  OutTheHelp;
 l_Dir := ParamStr(1);
 gSkip300 := True;
 {
 if l_Dir[1] = '-' then
 begin
  gSkip300 := True;
  l_Dir := ParamStr(2);
 end;
 }
 if l_Dir = '' then
  OutTheHelp;
 if not DirectoryExists(l_Dir) then
 begin
  Writeln(Format('Directory %s not found!', [l_Dir]));
  Halt(1);
 end;
 gConvertedCount := 0;
 IterateFilesInDir(l_Dir);
 Writeln(Format('%d files converted.', [gConvertedCount]));
end.
