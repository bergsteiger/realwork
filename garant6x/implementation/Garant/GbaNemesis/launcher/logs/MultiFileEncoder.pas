unit MultiFileEncoder; {$WARNINGS ON}

interface

uses
 Windows
 , Classes
 , Forms
 , IniFiles
 , SysUtils
 ;

type
 TEncoder = Pointer;

 TInitEncodeEvent = procedure of object;
 TEncodeDataEvent = procedure(const a_Buffer: Pointer; const a_Size: Cardinal) of object;
 TDoneEncodeEvent = procedure of object;

 TExpandIniFileSectionItemEvent = procedure(var a_Item: string);
 TSelectFileDirEvent = procedure(var a_FileDir: string);


 EMultiFileEncoder = class(Exception)
 private
  f_ErrorCode: Integer;
 public
  class function Check(const a_ErrorCode: Integer): Integer;
 public
  constructor Create(const a_ErrorCode: Integer);
 public
  property ErrorCode: Integer read f_ErrorCode;
 end;

 TMultiFileEncoder = class
 private
  f_CryptSeed: Byte;
 private
  f_Encoder: TEncoder;
  f_FileName: string;
 private
  f_Position: Int64;
 private
  f_OnInitEncode: TInitEncodeEvent;
  f_OnEncodeData: TEncodeDataEvent;
  f_OnDoneEncode: TDoneEncodeEvent;
 private
  f_OnExpandIniFileSectionItem: TExpandIniFileSectionItemEvent;
  f_OnSelectFileDir: TSelectFileDirEvent;
 private
  function  pm_GetFileName: string;
  procedure pm_SetFileName(const a_Value: string);
 private
  procedure ExternalInitEncodeEvent;
  procedure ExternalEncodeDataEvent(const a_Buffer: Pointer; const a_Size: Cardinal);
  procedure ExternalDoneEncodeEvent;
  //
  procedure InternalInitEncodeEvent;
  procedure InternalEncodeDataEvent(const a_Buffer: Pointer; const a_Size: Cardinal);
  procedure InternalDoneEncodeEvent;
 private
  function  ExpandIniFileSectionItem(const a_Item: string): string;
 private
  procedure StoreNewCryptSeed;
  //
  procedure CryptBuffer(const a_Buffer: Pointer; const a_Size: Cardinal);
 private
  procedure InitEncoderUse;
  procedure DoneEncoderUse;
 public
  class function  Instance: TMultiFileEncoder;
  class procedure DestroyInstance;
 public
  constructor Create;
  destructor Destroy; override;
 public
  procedure NewFileHeader(const a_FileName: string; const a_Size: Int64);
 public
  procedure CryptFileData(const a_Buffer: Pointer; const a_Size: Cardinal);
  //
  procedure CryptFile(const a_FileName: string; const a_DaysToStore: TDateTime = 2958465.99999); overload;
  procedure CryptFile(const a_FileName: string; const a_Buffer: Pointer; const a_Size: Cardinal; const a_DaysToStore: TDateTime = 2958465.99999); overload;
  //
  procedure CryptIniFileItems(const a_IniFileName: string; const a_Section: string = 'MultiFileEncoder'; const a_ItemPrefix: string = 'Item');
  procedure CryptPathMask(const a_PathMask: string);
  //
 public
  property OnExpandIniFileSectionItem: TExpandIniFileSectionItemEvent read f_OnExpandIniFileSectionItem write f_OnExpandIniFileSectionItem;
  property OnSelectFileDir: TSelectFileDirEvent read f_OnSelectFileDir write f_OnSelectFileDir;
  //
  property FileName: string read pm_GetFileName write pm_SetFileName;
 end;

implementation

const
 c_DefaultBufferSize = 1024*1024; // 1 Mb

var
 g_MultiFileEncoderInstance: TMultiFileEncoder = nil;

var
 g_DllHModule: HMODULE = HMODULE(0);


function GetDllModule: HMODULE;
 //
 function GetOsDependentCatalog: string;
 begin
  if (Longint(GetVersion) < 0) then
   Result := ExtractFilePath (ParamStr(0))+'win9X'
  else
   Result := ExtractFilePath (ParamStr(0))+'winNT';
  end;
 //
const
 c_DllName: string = 'MultiFileEncoder.dll';
var
 l_CurrentDir: string;
 l_ErrorMode: UINT;
 l_OsDependentCatalog: string;
begin
 if (g_DllHModule = HMODULE(0)) then
 begin
  l_ErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
  try
   l_CurrentDir := GetCurrentDir;
   //
   l_OsDependentCatalog := GetOsDependentCatalog;
   if SetCurrentDir(l_OsDependentCatalog) then
    try
     g_DllHModule := LoadLibrary(PChar(c_DllName));
    finally
     SetCurrentDir(l_CurrentDir);
    end
   else
    g_DllHModule := LoadLibrary(PChar(Format('%s\%s', [l_OsDependentCatalog, c_DllName])));
   //
   if (g_DllHModule = HMODULE(0)) then
    g_DllHModule := LoadLibrary(PChar(c_DllName));
  finally
   SetErrorMode(l_ErrorMode);
  end;
 end;
 //
 Result := g_DllHModule;
end;

procedure GetProcedureAddress(var a_Pointer: Pointer; const a_ProcName: string);
var
 l_DllHModule: HMODULE;
begin
 if not(Assigned(a_Pointer)) then
 begin
  l_DllHModule := GetDllModule;
  //
  if (l_DllHModule <> HMODULE(0)) then
   a_Pointer := GetProcAddress(l_DllHModule, PChar(a_ProcName));
  //
  Assert(a_Pointer <> nil);
 end;
end;

{$WARNINGS OFF}
var
 g_InitEncodePtr: Pointer = nil;

function InitEncode(const a_FileName: PAnsiChar; var a_Handle: Pointer): Integer; cdecl;
begin
 GetProcedureAddress(g_InitEncodePtr, 'InitEncode');
 //
 asm
  mov esp, ebp
  pop ebp
  jmp [g_InitEncodePtr]
 end;
end;
{$WARNINGS ON}

{$WARNINGS OFF}
var
 g_EncodeDataPtr: Pointer = nil;

function EncodeData(const a_Handle: Pointer; const a_Buffer: Pointer; const a_Size: Cardinal): Integer; cdecl;
begin
 GetProcedureAddress(g_EncodeDataPtr, 'EncodeData');
 //
 asm
  mov esp, ebp
  pop ebp
  jmp [g_EncodeDataPtr]
 end;
end;
{$WARNINGS ON}

{$WARNINGS OFF}
var
 g_DoneEncodePtr: Pointer = nil;

procedure DoneEncode(var a_Handle: Pointer); cdecl;
begin
 GetProcedureAddress(g_DoneEncodePtr, 'DoneEncode');
 //
 asm
  mov esp, ebp
  pop ebp
  jmp [g_DoneEncodePtr]
 end;
end;
{$WARNINGS ON}


class function EMultiFileEncoder.Check(const a_ErrorCode: Integer): Integer;
 //
 function ReturnAddr: Pointer;
 asm
  mov eax, [ebp+ 4]
 end;
 //
begin
 Result := a_ErrorCode;
 //
 if (Result < 0) then
  raise EMultiFileEncoder.Create(Result) at ReturnAddr;
end;

constructor EMultiFileEncoder.Create(const a_ErrorCode: Integer);
begin
 inherited Create(Format('EMultiFileEncoder Internal Error: %d', [a_ErrorCode]));
 //
 f_ErrorCode := a_ErrorCode;
end;


function TMultiFileEncoder.pm_GetFileName: string;
 //
 function GetTempName: string;
  //
  function GetTempDir: string;
  var
   l_Length: Integer;
  begin
   SetLength(Result, GetTempPath(0, nil));
   //
   if (Length(Result) = 0) then
    Result := 'C:\'
   else
    SetLength(Result, Integer(GetTempPath(DWORD(Length(Result)), PChar(Result))));
   //
   l_Length := Length(Result);
   if ((l_Length > 0) and (Result[l_Length] = '\')) then
    SetLength(Result, Pred(l_Length));
  end;
  //
 var
  l_TempFileName: packed array [0..MAX_PATH] of Char;
 begin
  GetTempFileName(PChar(GetTempDir), PChar('mfe'), 0, @l_TempFileName);
  Result := l_TempFileName;
 end;
 //
begin
 if (f_FileName = '') then
  f_FileName := GetTempName;
 //
 Result := f_FileName;
end;

procedure TMultiFileEncoder.pm_SetFileName(const a_Value: string);
begin
 if (a_Value <> f_FileName) then
 begin
  DoneEncoderUse;
  //
  f_FileName := a_Value;
 end;
end;

procedure TMultiFileEncoder.ExternalInitEncodeEvent;
begin
 EMultiFileEncoder.Check(InitEncode(PChar(FileName), f_Encoder));
 //
 f_Position := 0;
end;

procedure TMultiFileEncoder.ExternalEncodeDataEvent(const a_Buffer: Pointer; const a_Size: Cardinal);
begin
 EMultiFileEncoder.Check(EncodeData(f_Encoder, a_Buffer, a_Size));
end;

procedure TMultiFileEncoder.ExternalDoneEncodeEvent;
begin
 DoneEncode(f_Encoder);
end;

procedure TMultiFileEncoder.InternalInitEncodeEvent;
begin
 f_Encoder := TFileStream.Create(FileName, fmCreate);
 //
 f_Position := 0;
end;

procedure TMultiFileEncoder.InternalEncodeDataEvent(const a_Buffer: Pointer; const a_Size: Cardinal);
begin
 TStream(f_Encoder).WriteBuffer(a_Buffer^, a_Size);
end;

procedure TMultiFileEncoder.InternalDoneEncodeEvent;
begin
 FreeAndNil(f_Encoder);
end;

function TMultiFileEncoder.ExpandIniFileSectionItem(const a_Item: string): string;
begin
 Result := a_Item;
 //
 if (Assigned(f_OnExpandIniFileSectionItem)) then
  f_OnExpandIniFileSectionItem(Result);
end;

procedure TMultiFileEncoder.StoreNewCryptSeed;
begin
 f_CryptSeed := Byte(Random(256) and Byte(-1));
 //
 f_OnEncodeData(@f_CryptSeed, SizeOf(f_CryptSeed));
 Inc(f_Position, SizeOf(f_CryptSeed));
end;

procedure TMultiFileEncoder.CryptBuffer(const a_Buffer: Pointer; const a_Size: Cardinal);
var
 c_Buffer: PAnsiChar absolute a_Buffer;
 //
 l_Buffer: PAnsiChar;
 l_Index: Cardinal;
begin
 if (a_Size > 0) then
 begin
  GetMem(l_Buffer, a_Size);
  try
   for l_Index := 0 to Pred(a_Size) do
   begin
    l_Buffer[l_Index] := Char(
     Ord(c_Buffer[l_Index])
     xor not(
      Byte(
       (
        f_Position+ (Int64(f_CryptSeed)* 3)
       )
       and Int64(Byte(-1))
      )
     )
     xor f_CryptSeed
    );
    //
    Inc(f_Position);
   end;
   //
   f_OnEncodeData(l_Buffer, a_Size);
  finally
   FreeMem(l_Buffer);
  end;
 end;
end;

procedure TMultiFileEncoder.InitEncoderUse;
begin
 if (f_Encoder = nil) then
  f_OnInitEncode;
 //
 Assert(f_Encoder <> nil);
end;

procedure TMultiFileEncoder.DoneEncoderUse;
begin
 if (f_Encoder <> nil) then
  f_OnDoneEncode;
 //
 Assert(f_Encoder = nil);
end;

class function TMultiFileEncoder.Instance: TMultiFileEncoder;
begin
 if (g_MultiFileEncoderInstance = nil) then
  g_MultiFileEncoderInstance := TMultiFileEncoder.Create;
 //
 Result := g_MultiFileEncoderInstance;
end;

class procedure TMultiFileEncoder.DestroyInstance;
begin
 FreeAndNil(g_MultiFileEncoderInstance);
end;

constructor TMultiFileEncoder.Create;
begin
 inherited Create;
 //
 if (GetDllModule <> HMODULE(0)) then
 begin
  f_OnInitEncode := ExternalInitEncodeEvent;
  f_OnEncodeData := ExternalEncodeDataEvent;
  f_OnDoneEncode := ExternalDoneEncodeEvent;
 end
 else
 begin
  f_OnInitEncode := InternalInitEncodeEvent;
  f_OnEncodeData := InternalEncodeDataEvent;
  f_OnDoneEncode := InternalDoneEncodeEvent;
 end;
end;

destructor TMultiFileEncoder.Destroy;
begin
 DoneEncoderUse;
 //
 inherited Destroy;
end;

procedure TMultiFileEncoder.NewFileHeader(const a_FileName: string; const a_Size: Int64);
 //
 procedure CryptSize(const a_Size: Byte);
 begin
  CryptBuffer(@a_Size, SizeOf(a_Size));
 end;
 //
 procedure CryptInteger(const a_Value: Integer); overload;
 begin
  CryptBuffer(@a_Value, SizeOf(a_Value));
 end;
 //
 procedure CryptInteger(const a_Value: Int64); overload;
 begin
  CryptBuffer(@a_Value, SizeOf(a_Value));
 end;
 //
 procedure CryptString(const a_String: string);
 var
  l_Length: Integer;
 begin
  l_Length := Length(a_String);
  //
  if (l_Length > 0) then
   CryptBuffer(PAnsiChar(a_String), (l_Length+ 1)* SizeOf(Char));
 end;
 //
 (*
  header format:
   crypt seed      [byte]                      |>
   sizeof(char)    [byte]                      |+ sizeof(byte)
   sizeof(integer) [byte]                      |+ sizeof(byte)+ sizeof(byte)
   length+ 1       [integer]                   |+ sizeof(byte)+ sizeof(byte)+ sizeof(byte)
   filename        [(length+ 1)* sizeof(char)] |+ sizeof(byte)+ sizeof(byte)+ sizeof(byte)+ sizeof(integer)
   size            [int64]                     |+ sizeof(byte)+ sizeof(byte)+ sizeof(byte)+ sizeof(integer)+ (length+ 1)* sizeof(char)
   data            [size]                      |+ sizeof(byte)+ sizeof(byte)+ sizeof(byte)+ sizeof(integer)+ (length+ 1)* sizeof(char)+ sizeof(int64)
 *)
 //
begin
 InitEncoderUse;
 StoreNewCryptSeed;
 //
 CryptSize(SizeOf(Char));
 CryptSize(SizeOf(Integer));
 //
 CryptInteger(Length(a_FileName));
 CryptString(a_FileName);
 //
 CryptInteger(a_Size);
end;

procedure TMultiFileEncoder.CryptFileData(const a_Buffer: Pointer; const a_Size: Cardinal);
begin
 CryptBuffer(a_Buffer, a_Size);
end;

procedure TMultiFileEncoder.CryptFile(const a_FileName: string; const a_DaysToStore: TDateTime);
var
 l_Buffer: Pointer;
begin
 GetMem(l_Buffer, c_DefaultBufferSize);
 try
  CryptFile(a_FileName, l_Buffer, c_DefaultBufferSize, a_DaysToStore);
 finally
  FreeMem(l_Buffer);
 end;
end;

procedure TMultiFileEncoder.CryptFile(const a_FileName: string; const a_Buffer: Pointer; const a_Size: Cardinal; const a_DaysToStore: TDateTime);
var
 l_FullSize: Int64;
 l_ReadSize: Int64;
 //
 l_FileAge: Integer;
begin
 if ((a_FileName <> '') and FileExists(a_FileName)) then
 begin
  l_FileAge := FileAge(a_FileName);
  //
  if ((a_DaysToStore <> MaxDateTime) and (l_FileAge <> -1) and ((Now-FileDateToDateTime(l_FileAge)) > a_DaysToStore)) then
   DeleteFile(a_FileName)
  else
   with TFileStream.Create(a_FileName, fmOpenRead or fmShareDenyNone) do
    try
     l_FullSize := Size;
     //
     NewFileHeader(a_FileName, l_FullSize);
     //
     while (l_FullSize > 0) do
     begin
      l_ReadSize := l_FullSize;
      //
      if (l_ReadSize > Int64(a_Size)) then
       l_ReadSize := Int64(a_Size);
      //
      l_ReadSize := Int64(Read(a_Buffer^, Longint(l_ReadSize and Int64(Longint(-1)))));
      //
      if ((l_ReadSize = 0) and (l_FullSize <> 0)) then
      begin
       l_ReadSize := l_FullSize;
       //
       if (l_ReadSize > Int64(a_Size)) then
        l_ReadSize := Int64(a_Size);
       //
       FillChar(a_Buffer^, Cardinal(l_ReadSize and Int64(Cardinal(-1))), $00); // zero tail, if something wrong
      end;
      //
      CryptFileData(a_Buffer, Cardinal(l_ReadSize and Int64(Cardinal(-1))));
      //
      Dec(l_FullSize, l_ReadSize);
      //
      Application.ProcessMessages;
     end;
    finally
     Free;
    end;
 end;
end;

procedure TMultiFileEncoder.CryptIniFileItems(const a_IniFileName: string; const a_Section: string; const a_ItemPrefix: string);
var
 l_Index: Integer;
 l_Items: TStrings;
 //
 l_String: string;
begin
 if ((a_IniFileName <> '') and (a_Section <> '')) then
  with TIniFile.Create(a_IniFileName) do
   if (SectionExists(a_Section)) then
    try
     l_Items := TStringList.Create;
     try
      ReadSection(a_Section, l_Items);
      //
      with l_Items do
       if (Count > 0) then
        for l_Index := 0 to Pred(Count) do
        begin
         l_String := Strings[l_Index];
         //
         if ((a_ItemPrefix = '') or (Pos(a_ItemPrefix, l_String) = 1)) then
          CryptPathMask(ExpandIniFileSectionItem(ReadString(a_Section, l_String, '')));
         //
         Application.ProcessMessages;
        end;
     finally
      FreeAndNil(l_Items);
     end;
    finally
     Free;
    end;
end;

procedure TMultiFileEncoder.CryptPathMask(const a_PathMask: string);
 //
 function ExtractPathMask(const a_PathMask: string; out a_DaysToStore: TDateTime): string;
 var
  l_Position: Integer;
  l_RestDays: Integer;
 begin
  Result := a_PathMask;
  //
  a_DaysToStore := MaxDateTime;
  //
  l_Position := Pos('|', Result);
  //
  if (l_Position <> 0) then
  begin
   l_RestDays := StrToIntDef(Copy(Result, Succ(l_Position), Length(Result)-l_Position), 0);
   //
   if ((l_RestDays > 0) and (l_RestDays < MaxDateTime)) then
    a_DaysToStore := l_RestDays;
   //
   SetLength(Result, Pred(l_Position));
  end;
 end;
 //
var
 l_DaysToStore: TDateTime;
 l_PathMask: string;
 //
 l_Buffer: Pointer;
 //
 l_RootPath: string;
 //
 l_SearchRec: TSearchRec;
 l_SearchResult: Integer;
 //
 l_FileName: string;
begin
 l_PathMask := ExtractPathMask(a_PathMask, l_DaysToStore);
 //
 if (l_PathMask <> '') then
 begin
  l_RootPath := ExtractFileDir(l_PathMask);
  //
  if (Assigned(f_OnSelectFileDir)) then
   f_OnSelectFileDir(l_RootPath);
  //
  l_PathMask := Format('%s\%s', [l_RootPath, ExtractFileName(l_PathMask)]);
  //
  l_SearchResult := FindFirst(l_PathMask, Integer(faAnyFile), l_SearchRec);
  //
  try
   if (l_SearchResult = 0) then
   begin
    GetMem(l_Buffer, c_DefaultBufferSize);
    try
     repeat
      with l_SearchRec do
       if ((Name <> '.') and (Name <> '..') and ((Attr and Integer(faDirectory)) = 0)) then
       begin
        l_FileName := Format('%s\%s', [l_RootPath, Name]);
        //
        CryptFile(l_FileName, l_Buffer, c_DefaultBufferSize, l_DaysToStore);
       end;
      //
      Application.ProcessMessages;
      //
      l_SearchResult := FindNext(l_SearchRec);
     until (l_SearchResult <> 0);
    finally
     FreeMem(l_Buffer);
    end;
   end;
  finally
   FindClose(l_SearchRec);
  end;
 end;
end;


initialization
 Randomize;
finalization
 TMultiFileEncoder.DestroyInstance;
 FreeLibrary(g_DllHModule);
end.
