unit m3Endings;

interface

uses
 m3EndingReplaceList;

procedure InitEndings(const aBasePath: AnsiString);

implementation

Uses
 l3Memory, l3FileUtils,
 m0LngLib,
 ZipForge, SysUtils, Classes;

const
 gBasePath: AnsiString = '';

const
 cZipName    = 'scdata.zip';
 cERFileName = 'endings.txt';

function m3LoadEndings(const aList: Tm3EndingReplaceList; const aBasePath: AnsiString): Boolean;
var
 l_Path: AnsiString;
 l_MS  : Tl3MemoryStream;
 l_Zip : TZipForge;
begin
 Result := False;
 l_Path := ConcatDirName(aBasePath, cZipName);
 if FileExists(l_Path) then
 begin
  l_Zip := TZipForge.Create(nil);
  try
   l_Zip.FileName := l_Path;
   l_Zip.Password := 'Run-time error 216';
   l_Zip.OpenArchive;
   l_MS := Tl3MemoryStream.Create;
   try
    l_Zip.ExtractToStream(cERFileName, l_MS);
    l_MS.Seek(0, 0);
    aList.Load(l_MS);
    Result := True;
   finally
    FreeAndNil(l_MS);
   end;
  finally
   FreeAndNil(l_Zip);
  end;
 end;
end;

procedure InitEndingListProc(aERList: Tm3EndingReplaceList);
begin
 if not m3LoadEndings(aERList, gBasePath) then
  raise EListError.CreateFmt('Ошибка загрузки словаря окончаний из файла %s', [cZipName]);
end;


procedure InitEndings(const aBasePath: AnsiString);
begin
 gBasePath:= aBasePath;
 g_InitEndingListProc := InitEndingListProc;
end;


end.
