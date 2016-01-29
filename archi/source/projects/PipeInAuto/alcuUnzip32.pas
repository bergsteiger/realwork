unit alcuUnzip32;

interface
Uses
 UnZip32,
 l3Base,
 Classes, Windows;

type
 TUnzip = class(Tl3Base)
 private
  f_ArchiveName: String;
  f_FileList: TStrings;
  function pm_GetCount: Integer;
  function pm_GetFiles(Index: Integer): string;
 protected
  procedure Cleanup;
 public
  constructor Create(aOwner: TObject = nil);
  constructor Make(const aArchiveFileName: String);
  procedure ExtractAllFiles(const aFolder: String);
  procedure ExtractFileToStream(const aFileName: String; aStream: TStream);
  procedure Open;
  property ArchiveName: String read f_ArchiveName write f_ArchiveName;
  property Count: Integer read pm_GetCount;
  property Files[Index: Integer]: string read pm_GetFiles;

 end;

{ global routines }
procedure UnZipDllVersionToStrings(List: TStrings);

procedure Set_UserFunctions(var Z: TUserFunctions);

{ user functions for use with the TUserFunctions structure }
function DllPrnt(Buffer: PChar; Size: ULONG): integer; stdcall;

function DllPassword(P: PChar; N: Integer; M, Name: PChar): integer; stdcall;

function DllService(CurFile: PChar; Size: ULONG): integer; stdcall;

function DllReplace(FileName: PChar): integer; stdcall;

procedure DllMessage(UnCompSize : ULONG;
                     CompSize   : ULONG;
                     Factor     : UINT;
                     Month      : UINT;
                     Day        : UINT;
                     Year       : UINT;
                     Hour       : UINT;
                     Minute     : UINT;
                     C          : Char;
                     FileName   : PChar;
                     MethBuf    : PChar;
                     CRC        : ULONG;
                     Crypt      : Char); stdcall;

procedure Set_UnZipOptions(var O: TDCL; const aFileName, aFolder: String);

function UnzipFile(const aArchiveFileName, aDestFolder: String): Integer;

function UnzipFile2Stream(const aArchiveFileName, aFileName: String; aStream: TStream): Integer;

function GetZipFileList(const aArchiveFileName: String): TStrings;

function g_ZipFileList: TStrings;



implementation

Uses
 SysUtils, l3FileUtils;

const
 _FileList: TStrings = nil;

{ global routines }

{----------------------------------------------------------------------------------}
procedure UnZipDllVersionToStrings(List: TStrings);
var
 pVer : PUzpVer;
 S    : string;
begin

  PVer := UzpVersion;

  { display the information }
  with List do
  begin
    Clear;
    Add('Flag         : ' + IntToStr(pVer^.Flag) + ' [1: is_beta, ?: uses_zlib]');
    Add('BetaLevel    : ' + pVer^.BetaLevel);
    Add('Date         : ' + pVer^.Date);
    Add('ZLib_Version : ' + pVer^.ZLib_Version);
    S := IntToStr(pVer^.UnZip.Major);
    S := S + '.' + IntToStr(pVer^.UnZip.Minor);
    Add('UnZip        : ' + S);
    S := IntToStr(pVer^.WinDll.Major);
    S := S + '.' + IntToStr(pVer^.WinDll.Minor);
    Add('WinDll       : ' + S);
  end;

end;

{ user functions for use with the TUserFunctions structure }
{----------------------------------------------------------------------------------}
function DllPrnt(Buffer: PChar; Size: ULONG): integer;
begin
  //frmMain.Memo2.Lines.Add(Buffer);
  // Куда-то деть этот буфер
  Result := Size;
end;

{----------------------------------------------------------------------------------}
function DllPassword(P: PChar; N: Integer; M, Name: PChar): integer;
begin
  Result := 1;
end;

{----------------------------------------------------------------------------------}
function DllService(CurFile: PChar; Size: ULONG): integer;
begin
  Result := 0;
  g_ZipFileList.Add(CurFile);
end;

{----------------------------------------------------------------------------------}
function DllReplace(FileName: PChar): integer;
begin
  Result := 1;  // Разрешение перезаписи файла?
end;

{----------------------------------------------------------------------------------}
procedure DllMessage(UnCompSize : ULONG;
                     CompSize   : ULONG;
                     Factor     : UINT;
                     Month      : UINT;
                     Day        : UINT;
                     Year       : UINT;
                     Hour       : UINT;
                     Minute     : UINT;
                     C          : Char;
                     FileName   : PChar;
                     MethBuf    : PChar;
                     CRC        : ULONG;
                     Crypt      : Char);
const
  sFormat = '%7u  %7u %4s  %02u-%02u-%02u  %02u:%02u  %s%s';
  cFactor = '%s%d%%';
  cFactor100 = '100%%';
var
  S       : string;
  sFactor : string;
  Sign    : Char;
begin

  if (CompSize > UnCompSize) then Sign := '-' else Sign := ' ';

  if (Factor = 100)
  then sFactor := cFactor100
  else sFactor := Format(cFactor, [Sign, Factor]);

  S := Format(sFormat, [UnCompSize, CompSize, sFactor, Month, Day, Year, Hour, Minute, C, FileName]);

 // Тут куда-нибудь это нужно вернуть

end;

{----------------------------------------------------------------------------------}
procedure Set_UserFunctions(var Z:TUserFunctions);
begin
  { prepare TUserFunctions structure }
  with Z do
  begin
    @Print                  := @DllPrnt;
    @Sound                  := nil;
    @Replace                := @DllReplace;
    @Password               := @DllPassword;
    @SendApplicationMessage := @DllMessage;
    @ServCallBk             := @DllService;
  end;
end;

{----------------------------------------------------------------------------------}
procedure Set_UnZipOptions(var O: TDCL; const aFileName, aFolder: String);
begin
  with O do
  begin
    ExtractOnlyNewer  := 1 ;
    SpaceToUnderscore := 0;
    PromptToOverwrite := 0;
    fQuiet            := 0;
    nCFlag            := 0;
    nTFlag            := 0;
    nVFlag            := 1;
    nUFlag            := 0;
    nZFlag            := 0;
    nDFlag            := 0;
    nOFlag            := 0;
    nAFlag            := 0;
    nZIFlag           := 0;
    C_flag            := 1;
    fPrivilege        := 1;
    lpszZipFN         := PChar(aFileName);
    lpszExtractDir    := PChar(aFolder);
  end;
end;

{----------------------------------------------------------------------------------}
function UnzipFile(const aArchiveFileName, aDestFolder: String): Integer;
var
  UF : TUserFunctions;
  Opt  : TDCL;
begin
 ForceDirectories(aDestFolder);
  { set user functions }
  Set_UserFunctions(UF);

  { set unzip operation options }
  Set_UnZipOptions(Opt, aArchiveFileName, aDestFolder);


  Result := Wiz_SingleEntryUnzip(0,    { number of file names being passed }
                       nil,  { file names to be unarchived }
                       0,    { number of "file names to be excluded from processing" being  passed }
                       nil,  { file names to be excluded from the unarchiving process }
                       Opt,  { pointer to a structure with the flags for setting the  various options }
                       UF);  { pointer to a structure that contains pointers to user functions }
end;

function UnzipFile2Stream(const aArchiveFileName, aFileName: String; aStream: TStream): Integer;
var
 l_Buf: TUzpBuffer;
 UF : TUserFunctions;
begin
 Set_UserFunctions(UF);
 try
  Result := Wiz_UnzipToMemory(PChar(aArchiveFileName),  PChar(StringReplace(aFileName, '\', '/', [rfReplaceAll])), UF, l_Buf);
  aStream.Write(l_Buf.StrPtr[0], l_Buf.StrLength);
 finally
  UzpFreeMemBuffer(l_Buf);
 end;
end;

function GetZipFileList(const aArchiveFileName: String): TStrings;
var
 UF : TUserFunctions;
 l_Res: Integer;
begin
 g_ZipFileList.Clear;
 Set_UserFunctions(UF);
 l_Res := Wiz_Grep(PChar(aArchiveFileName), '*.*', '', 0, 1, UF);
 Result := g_ZipFileList;
end;

function g_ZipFileList: TStrings;
begin
 if _FileList = nil then
  _FileList:= TStringList.Create;
 Result := _FileList;
end;

constructor TUnzip.Create(aOwner: TObject = nil);
begin
 inherited;
 f_FileList:= TStringList.Create;
end;

constructor TUnzip.Make(const aArchiveFileName: String);
begin
 Create;
 ArchiveName := aArchiveFileName;
 Open;
end;

procedure TUnzip.Cleanup;
begin
 l3Free(f_FileList);
 inherited;
end;

procedure TUnzip.ExtractAllFiles(const aFolder: String);
begin
 ForceDirectories(aFolder);
 UnzipFile(ArchiveName, aFolder);
end;

procedure TUnzip.ExtractFileToStream(const aFileName: String; aStream: TStream);
begin
 if f_FileList.IndexOf(aFileName) <> -1 then
  UnzipFile2Stream(ArchiveName, aFileName, aStream);
end;

procedure TUnzip.Open;
var
 i: Integer;
begin
 if FileExists(ArchiveName) then
 begin
  f_FileList.Assign(GetZipFileList(ArchiveName));
  for i:= 0 to Pred(f_FileList.Count) do
   f_FileList.Strings[i]:= StringReplace(f_FileList.Strings[i], '/', '\', [rfReplaceAll])
 end;
end;

function TUnzip.pm_GetCount: Integer;
begin
 Result := f_FileList.Count;
end;

function TUnzip.pm_GetFiles(Index: Integer): string;
begin
 Result := f_FileList.Strings[index];
end;

initialization
finalization
 l3Free(_FileList);
end.
