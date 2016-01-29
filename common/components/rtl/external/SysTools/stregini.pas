{*********************************************************}
{*                  STREGINI.PAS 3.00                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit STRegIni;
  {-Registry and INI file access}

interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, OLE2, ShellAPI, {$ENDIF}
  Graphics, Classes, SysUtils,
  {$IFDEF HStrings} STStrL, {$ELSE} STStrS, {$ENDIF}
  StDate, STConst, STBase;

type
{.Z+}
  TRegIniType = (riIniType, riRegType);
  TRegIniMode = (riSet, riGet);
  TWinVerType = (riWin31,riWin32s,riWin95,riWinNT);
{.Z-}

{$IFNDEF WIN32}
  SECURITY_INFORMATION = LongInt;
  TSecurityDescriptor = LongInt;
  TSecurityAttributes = LongInt;
  DWORD = LongInt;
{$ENDIF}

  TQueryKeyInfo = record
    QIKey       : HKey;         {Value of key being queried}
    QIClassName : string;       {Class Name associated with key}
    QINumSubKeys: DWORD;        {Number of Subkeys under queried key}
    QIMaxSKNLen : DWORD;        {Length of longest subkey name}
    QIMaxCNLen  : DWORD;        {Length of longest class name found}
    QINumValues : DWORD;        {Number of values found in queried key ONLY, i.e., values in subkeys not included}
    QIMaxVNLen  : DWORD;        {Length of longest value name}
    QIMaxDataLen: DWORD;        {Largest size (in bytes) of values in queried key}
    QISDescLen  : DWORD;        {Length of Security Descriptor}
    QIFileTime  : TFileTime;    {Time/date file/key was last modified}
  end;

const
{.Z+}
{$IFDEF WIN32}
  RI_INVALID_VALUE = -1;
  RIVOLATILE = REG_WHOLE_HIVE_VOLATILE;
{$ELSE}
  RI_INVALID_VALUE = 0;
  RIVOLATILE = 0;
{$ENDIF}
  ShortBufSize = 255;
  MaxBufSize = 8192;
  MaxByteArraySize = 127;
{.Z-}

  RIMachine = 'MACHINE';
  RIUsers   = 'USERS';
  RIRoot    = 'ROOT';
  RICUser   = 'C_USERS';


type
  TStRegIni = class(TObject)
{.Z+}
  protected {private}
    riMode           : TRegIniMode;

    riWinVer         : TWinVerType;
    riType           : TRegIniType;
    riHoldPrimary,
    riPrimaryKey     : HKey;
    riRemoteKey      : HKey;

    riCurSubKey,
    riTrueString,
    riFalseString    : PAnsiChar;

{$IFDEF ThreadSafe}
    riThreadSafe     : TRTLCriticalSection;
{$ENDIF}

    function GetAttributes : TSecurityAttributes;
      {-get security attributes record or value}
    procedure SetAttributes(Value : TSecurityAttributes);
      {-get security attributes record or value}

    function GetCurSubKey : string;
      {-get current subkey/section}
    procedure SetCurSubKey(Value : string);
      {-set current subkey/section}

    function GetIsIniFile : Boolean;
      {-get whether current instance in IniFile or no}

    procedure ParseIniFile(SList : TStrings);
      {-adds section names in an INI file to a string list}

  protected
    FCurSubKey       : string;
    FriSecAttr       : TSecurityAttributes;
    FIsIniFile       : Boolean;

    riRootName       : PAnsiChar;

    BmpText,
    BmpBinary        : TBitMap;

    {protected procedures to manage open/closing}
    function OpenRegKey : HKey;
      {-opens/creates key or ini file}
    procedure CloseRegKey(const Key : HKey);
      {-closes open key or ini file}

    procedure EnterCS;
      {- call EnterCriticalSection procedure}
    procedure LeaveCS;
      {- call LeaveCriticalSection procedure}

    function WriteIniData(const ValueName : string; Data : string) : Boolean;
      {-write data to an Ini file}

    function ReadIniData(const ValueName : string; var Value : string;
                         Default : string) : Integer;
      {-read data from an Ini file}

    function WriteRegData(Key : HKey; const ValueName : string; Data : Pointer;
                          DType : DWORD; Size : Integer) : LongInt;
      {-write data to the registry}

    function ReadRegData(Key : HKey; const ValueName : string; Data : Pointer;
                         Size : LongInt; DType : DWORD) : LongInt;
      {-read data from the registry}

{.Z-}
  public
    constructor Create(RootName : String; IsIniFile : Boolean); virtual;
    destructor Destroy; override;

    procedure SetPrimary(Value : string);
      {-change INI filename or primary key of registry}
    function GetPrimary : string;
      {-return current INI filename or primary key of registry}

    function GetDataInfo(Key : HKey; const ValueName : string;
                         var Size : LongInt; var DType : DWORD) : LongInt;
      {-get size and type of data for entry in registry}

    function BytesToString(Value : PByte; Size : Cardinal) : string;
      {-converts byte array to string with no spaces}
    function StringToBytes(const IString : string; var Value; Size : Cardinal) : Boolean;
      {-converts string (by groups of 2 char) to byte values}


    function GetFullKeyPath : string;

    procedure WriteBoolean(const ValueName : string; Value : Boolean);
      {-set boolean data in the ini file or registry}
    function  ReadBoolean(const ValueName : string; Default : Boolean) : Boolean;
      {-get boolean data in the ini file or registry}
    procedure WriteInteger(const ValueName : string; Value : DWORD);
      {-set integer data in the ini file or registry}
    function  ReadInteger(const ValueName : string; Default : DWORD) : DWORD;
      {-get integer data in the ini file or registry}
    procedure WriteString(const ValueName : string; const Value : string);
      {-set string data in the ini file or registry}
    function  ReadString(const ValueName : string; const Default : string) : string;
      {-get string data in the ini file or registry}
    procedure WriteBinaryData(const ValueName : string; const Value; Size : Integer);
      {-set byte array in the ini file or registry}
    procedure ReadBinaryData(const ValueName : string; const Default; var Value; var Size : Integer);
      {-get byte array from the ini file or registry}
    procedure WriteFloat(const ValueName : string; const Value : Double);
      {-set float value in the ini file or registry}
    function ReadFloat(const ValueName : string; const Default : TStFloat) : TStFloat;
      {-get float from the ini file or registry}
    procedure WriteDate(const ValueName : string; const Value : TStDate);
      {-set date value in the ini file or registry}
    function ReadDate(const ValueName : string; const Default : TStDate) : TStDate;
      {-get date value from the ini file or registry}
    procedure WriteDateTime(const ValueName : string; const Value : TDateTime);
      {-set datetime value in the ini file or registry}
    function ReadDateTime(const ValueName : string; const Default : TDateTime) : TDateTime;
      {-get datetime value from the ini file or registry}
    procedure WriteTime(const ValueName : string; const Value : TStTime);
      {-set time value in the ini file or registry}
    function ReadTime(const ValueName : string; const Default : TStTime) : TStTime;
      {-get time value from the ini file or registry}


    procedure CreateKey(const KeyName : string);
      {-creates Section in INI file or Key in Registry}
    procedure GetSubKeys(SK : TStrings);
      {-lists sections in INI file or subkeys of SubKey in Registry}
    procedure GetValues(SKV : TStrings);
      {-lists values in INI section or in Registry SubKey}
    procedure DeleteKey(const KeyName : string; DeleteSubKeys : Boolean);
      {-Deletes section in INI file or key in Registry file}
    procedure DeleteValue(const ValueName : string);
      {-Deletes a value from an INI section or Registry key}
    procedure QueryKey(var KeyInfo : TQueryKeyInfo);
      {-lists information about an INI section or Registry SubKey}
    function KeyExists(KeyName : string) : Boolean;
      {-checks if exists in INI file/Registry}
    function IsKeyEmpty(Primary, SubKey : string) : Boolean;
      {-checks if key has values and/or subkeys}

    procedure SaveKey(const SubKey : string; FileName : string);
      {-saves an INI Section with values or Registry Subkey with all values and
        subkeys to specified file}
    procedure LoadKey(const SubKey, FileName : string);
      {-loads an INI file section or Registry key with all subkeys/values}
    procedure UnLoadKey(const SubKey : string);
      {-same as DeleteKey for INI file; removes key/subkeys loaded with LoadKey}
    procedure ReplaceKey(const SubKey, InputFile, SaveFile : string);
      {-replaces an INI file section or Registry key/subkeys
        from InputFile, saves old data in SaveFile}
    procedure RestoreKey(const SubKey, KeyFile : string; Options : DWORD);
      {-restores an INI section or Registry key/subkeys from KeyFile}

    procedure RegOpenRemoteKey(CompName : string);
      {-connects to Registry on another computer on network}
    procedure RegCloseRemoteKey;
      {-closes connection made with RegConnectRegistry}

    property Attributes : TSecurityAttributes
      read GetAttributes
      write SetAttributes;

    property CurSubKey : string
      read GetCurSubKey
      write SetCurSubKey;

    property IsIniFile : Boolean
      read GetIsIniFile;


{$IFDEF WIN32}
    procedure RegGetKeySecurity(const SubKey : string; var SD : TSecurityDescriptor);
      {-gets KeySecurity information on WinNT machines}
    procedure RegSetKeySecurity(const SubKey : string; SD : TSecurityDescriptor);
      {-sets KeySecurity information on WinNT machines}
{$ENDIF}
  end;


implementation

{$IFDEF TRIALRUN}
uses
  {$IFDEF Win32} Registry, {$ELSE} Ver, {$ENDIF}
  Forms,
  IniFiles,
  StTrial;
{$I TRIAL00.INC} {FIX}
{$I TRIAL01.INC} {CAB}
{$I TRIAL02.INC} {CC}
{$I TRIAL03.INC} {VC}
{$I TRIAL04.INC} {TCC}
{$I TRIAL05.INC} {TVC}
{$I TRIAL06.INC} {TCCVC}
{$ENDIF}


procedure RaiseRegIniError(Code : LongInt);
var
  E : ESTRegIniError;
begin
  E := ESTRegIniError.CreateResTP(Code, 0);
  E.ErrorCode := Code;
  raise E;
end;

{==========================================================================}

procedure RaiseRegIniErrorFmt(Code : LongInt; A : array of const);
var
  E : ESTRegIniError;
begin
  E := ESTRegIniError.CreateResFmtTP(Code, A, 0);
  E.ErrorCode := Code;
  raise E;
end;

{==========================================================================}

constructor TStRegIni.Create(RootName : String; IsIniFile : Boolean);
var
  S   : string;
{$IFDEF WIN32}
  OSI : TOSVERSIONINFO;
{$ENDIF}
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
{$IFDEF ThreadSafe}
  Windows.InitializeCriticalSection(riThreadSafe);
{$ENDIF}

  {check if a primary key or ini file is specified}
  if (Length(RootName) = 0) then
    RaiseRegIniError(stscNoFileKey);
  RootName := ANSIUpperCase(RootName);

  {get False string from resource}
  S := SysToolStr[stscFalseString];
  GetMem(riFalseString,Length(S)+1);
  StrPCopy(riFalseString,S);

  {get True string from resource}
  S := SysToolStr[stscTrueString];
  GetMem(riTrueString,Length(S)+1);
  StrPCopy(riTrueString,S);

  GetMem(riCurSubKey,1);
  riCurSubKey[0] := #0;

  BmpText   := TBitMap.Create;
  BmpBinary := TBitMap.Create;

  BmpText.Handle := LoadBitmap(HInstance, 'STBMPTEXT');
  BmpBinary.Handle := LoadBitmap(HInstance, 'STBMPBINARY');

  {setup ini file/primary key via riRootName}
  if (IsIniFile) then begin
    riType := riIniType;
    GetMem(riRootName,Length(RootName)+1);
    StrPCopy(riRootName,RootName);
  end else begin
    riType := riRegType;

{$IFDEF WIN32}
    riPrimaryKey := 0;
    riHoldPrimary := 0;
    if (RootName = RIMachine) then
       riPrimaryKey := HKEY_LOCAL_MACHINE
    else if (RootName = RIUsers) then
       riPrimaryKey := HKEY_USERS
    else if (RootName = RIRoot) then
       riPrimaryKey := HKEY_CLASSES_ROOT
    else if (RootName = RICUser) then
       riPrimaryKey := HKEY_CURRENT_USER
    else
       riPrimaryKey := HKEY_CURRENT_USER;

    OSI.dwOSVersionInfoSize := SizeOf(OSI);
    if (GetVersionEX(OSI)) then begin
      case OSI.dwPlatformID of
         VER_PLATFORM_WIN32S : RaiseRegIniError(stscNoWin32S);
         VER_PLATFORM_WIN32_WINDOWS : riWinVer := riWin95;
         VER_PLATFORM_WIN32_NT : riWinVer := riWinNT;
      end;
    end;

    if (FriSecAttr.nLength <> sizeOf(TSecurityAttributes)) then begin
      FriSecAttr.nLength := sizeof(TSecurityAttributes);
      FriSecAttr.lpSecurityDescriptor := nil;
      FriSecAttr.bInheritHandle := TRUE;
    end;

{$ELSE}
    {Win31 registry has one and only one primary key}
    riPrimaryKey := HKEY_CLASSES_ROOT;
    riWinVer := riWin31;

    FriSecAttr := 0;
{$ENDIF}
  end;
end;

{==========================================================================}

destructor TStRegIni.Destroy;
begin
{$IFDEF WIN32}
  {no need to check for local key since none are kept open}
  {longer than needed for a specific method}
  if (riRemoteKey <> 0) then
    RegCloseRemoteKey;
{$ENDIF}

  if (riRootName <> nil) then
    FreeMem(riRootName,StrLen(riRootName)+1);
  if (riFalseString <> nil) then
    FreeMem(riFalseString,StrLen(riFalseString)+1);
  if (riTrueString <> nil) then
    FreeMem(riTrueString,StrLen(riTrueString)+1);
  if (riCurSubKey <> nil) then
    FreeMem(riCurSubKey,StrLen(riCurSubKey)+1);

  BmpText.Free;
  BmpBinary.Free;

{$IFDEF ThreadSafe}
  Windows.DeleteCriticalSection(riThreadSafe);
{$ENDIF}
  inherited Destroy;
end;

{==========================================================================}


procedure TStRegIni.SetPrimary(Value : string);
  {-change working Ini file or top level key in registry}
begin
  if riType = riIniType then begin
    if CompareText(Value,StrPas(riRootName)) = 0 then Exit;

    if (riRootName <> nil) then
      FreeMem(riRootName,StrLen(riRootName)+1);
    GetMem(riRootName,Length(Value)+1);
    StrPCopy(riRootName,Value);
  end else begin
{$IFDEF WIN32}
    if (riRemoteKey <> 0) then
      RegCloseRemoteKey;

    if (Value = RIMachine) then
      riPrimaryKey := HKEY_LOCAL_MACHINE
    else if (Value = RIUsers) then
       riPrimaryKey := HKEY_USERS
    else if (Value = RIRoot) then
       riPrimaryKey := HKEY_CLASSES_ROOT
    else if (Value = RICUser) then
       riPrimaryKey := HKEY_CURRENT_USER
    else
       riPrimaryKey := HKEY_CURRENT_USER;
{$ELSE}
    riPrimaryKey := HKEY_CLASSES_ROOT;
{$ENDIF}
  end;
end;

{==========================================================================}

function TStRegIni.GetPrimary : string;
  {-return working Ini file or top level registry key}
begin
  if (riType = riIniType) then
    Result := StrPas(riRootName)
  else begin
{$IFDEF WIN32}
    case riPrimaryKey of
      HKEY_LOCAL_MACHINE : Result := RIMachine;
      HKEY_USERS         : Result := RIUsers;
      HKEY_CLASSES_ROOT  : Result := RIRoot;
      HKEY_CURRENT_USER  : Result := RICUser;
    else
      Result := 'Invalid primary key'
    end;
{$ELSE}
    Result := RIRoot;
{$ENDIF}
  end;
end;

{==========================================================================}

procedure TStRegIni.EnterCS;
begin
{$IFDEF ThreadSafe}
  EnterCriticalSection(riThreadSafe);
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.LeaveCS;
begin
{$IFDEF ThreadSafe}
  LeaveCriticalSection(riThreadSafe);
{$ENDIF}
end;

{==========================================================================}

function TStRegIni.GetIsIniFile : Boolean;
  {-get whether instance is IniFile or no}
begin
  Result := riType = riIniType;
end;

{==========================================================================}

function TStRegIni.GetAttributes : TSecurityAttributes;
  {-Get current security attributes (NT Only) }
begin
{$IFDEF WIN32}
  with Result do begin
    nLength := sizeof(TSecurityAttributes);
    lpSecurityDescriptor := FriSecAttr.lpSecurityDescriptor;
    bInheritHandle := FriSecAttr.bInheritHandle;
  end;
{$ELSE}
  Result := 0;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.SetAttributes(Value : TSecurityAttributes);
  {-set security attributes (NT only) }
begin
{$IFDEF WIN32}
  FriSecAttr.nLength := sizeof(TSecurityAttributes);
  FriSecAttr.lpSecurityDescriptor := Value.lpSecurityDescriptor;
  FriSecAttr.bInheritHandle := Value.bInheritHandle;
{$ELSE}
  FriSecAttr := Value;
{$ENDIF}
end;

{==========================================================================}

function TStRegIni.GetCurSubKey : string;
  {-retrn name of working Ini file section or registry subkey}
begin
  Result := FCurSubKey;
end;

{==========================================================================}

procedure TStRegIni.SetCurSubKey(Value : string);
  {-set name of working Ini file section or registry subkey}
begin
  if (riCurSubKey <> nil) then
    FreeMem(riCurSubKey,StrLen(riCurSubKey)+1);
  FCurSubKey := Value;
  GetMem(riCurSubKey,Length(Value)+1);
  StrPCopy(riCurSubKey,Value);
end;

{==========================================================================}

function TStRegIni.OpenRegKey : HKey;
  {-open a registry key}
var
  Disposition   : DWORD;
  ECode         : LongInt;
begin
{$IFDEF WIN32}
  Disposition := 0;
  if (riMode = riSet) then begin
    {Keys are created with all key access privilages and as non-volatile}
    ECode := RegCreateKeyEx(riPrimaryKey, riCurSubKey,0,nil,
        REG_OPTION_NON_VOLATILE,KEY_ALL_ACCESS,@FriSecAttr,
        Result,@Disposition);
    if (ECode <> ERROR_SUCCESS) then
      RaiseRegIniErrorFmt(stscCreateKeyFail, [ECode]);
  end else begin
    {Read operations limit key access to read only}
    ECode := RegOpenKeyEx(riPrimaryKey,riCurSubKey, 0, KEY_READ,Result);
    if (ECode <> ERROR_SUCCESS) then
      RaiseRegIniErrorFmt(stscOpenKeyFail, [ECode]);
  end;
{$ELSE}
  {16 bit mode has no security protections}
  if (riMode = riSet) then begin
    ECode := RegCreateKey(riPrimaryKey,riCurSubKey,Result);
    if (ECode <> ERROR_SUCCESS) then
      RaiseRegIniErrorFmt(stscCreateKeyFail,[ECode]);
  end else begin
    ECode := RegOpenKey(riPrimaryKey,riCurSubKey,Result);
      if (ECode <> ERROR_SUCCESS) then
        RaiseRegIniErrorFmt(stscOpenKeyFail,[ECode]);
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.CloseRegKey(const Key : HKey);
  {-close registry key}
begin
  RegCloseKey(Key);
end;

{==========================================================================}

function TStRegIni.WriteIniData(const ValueName : string;
                                      Data      : String) : Boolean;
  {-write data to the Ini file in the working section}
var
  PData,
  PValueName : PAnsiChar;
  VNLen,                                                               
  DLen       : integer;                                                
begin
  if (ValueName = '') then
    RaiseRegIniError(stscNoValueNameSpecified);

  PData := nil;
  PValueName := nil;
  VNLen := Length(ValueName) + 1;                                      
  DLen  := Length(Data) + 1;                                           

  try
    GetMem(PValueName, VNLen);                                         
    GetMem(PData, DLen);                                               

    strPCopy(PValueName, ValueName);
    strPCopy(PData, Data);

    Result := WritePrivateProfileString(riCurSubKey, PValueName,
                                        PData, riRootName)
  finally
    if PValueName <> nil then
      FreeMem(PValueName, VNLen);                                      
    if PData <> nil then
      FreeMem(PData, DLen);                                            
  end;
end;

{==========================================================================}

function TStRegIni.ReadIniData(const ValueName : string; var Value : string;
                               Default : string) : Integer;
  {-read a value from the working section of the Ini file}
var
  PValue   : array[0..1024] of char;
  PVName,
  PDefault : PAnsiChar;
begin
  PDefault := nil;
  PVName := nil;

  try
    GetMem(PVName,Length(ValueName)+1);
    GetMem(PDefault,Length(Default)+1);

    StrPCopy(PVName,ValueName);
    StrPCopy(PDefault,Default);

    GetPrivateProfileString(riCurSubKey,PVName,PDefault,
        PValue,SizeOf(PValue)-1,riRootName);

{$IFDEF WIN32}
  {$IFOPT H-}
    if strlen(PValue) > 255
      PValue[255] := #0;
  {$ENDIF}
{$ELSE}
    if strlen(PValue) > 255 then
      PValue[255] := #0;
{$ENDIF}
    Value := StrPas(PValue);
    Result := Length(Value);
  finally
    if PVName <> nil then
      FreeMem(PVName,strlen(PVName)+1);
    if PDefault <> nil then
      FreeMem(PDefault,strlen(PDefault)+1);
  end;
end;

{==========================================================================}

function TStRegIni.WriteRegData(Key : HKey; const ValueName : string; Data : Pointer;
                                DType : DWORD; Size : Integer) : LongInt;
  {-write a value into the registry}
var
  PVName : PAnsiChar;
begin
   GetMem(PVName, Length(ValueName)+1);
   try
     StrPCopy(PVName, ValueName);
{$IFDEF WIN32}
     Result := RegSetValueEx(Key, PVName, 0, DType, Data, Size);
{$ELSE}
     {ValueName is discarded since the key gets the value, not a separate item of the key}
     Result := RegSetValue(Key, nil, DType, Data, 0);
{$ENDIF}
   finally
     FreeMem(PVName, strlen(PVName)+1);
   end;
end;

{==========================================================================}

function TStRegIni.GetDataInfo(Key : HKey; const ValueName : string;
                               var Size : LongInt; var DType : DWORD) : LongInt;
  {-get the size and type of a specific value in the registry}
var
  PVName : PAnsiChar;
  Opened : Boolean;
  TS     : string;
begin
  Opened := False;
  riMode := riGet;
  if (riType = riIniType) then begin
    TS := ReadString(ValueName,'');
    Size := Length(TS);
    DType := REG_SZ;
    Result := ERROR_SUCCESS;
    Exit;
  end;

  GetMem(PVName,Length(ValueName)+1);
  try
    StrPCopy(PVName,ValueName);
    if Key = 0 then begin
      Key := OpenRegKey;
      Opened := True;
    end;
{$IFDEF WIN32}
    Result := RegQueryValueEx(Key,PVName,nil,@DType,nil,LPDWORD(@Size));
{$ELSE}
    DType := REG_SZ;
    Result := RegQueryValue(Key,PVName,nil,Size);
{$ENDIF}
  finally
    FreeMem(PVName,strlen(PVName)+1);
  end;
  if Opened then
    RegCloseKey(Key);
end;

{==========================================================================}

function TStRegIni.ReadRegData(Key : HKey; const ValueName : string; Data : Pointer;
                               Size : LongInt; DType : DWORD) : LongInt;
  {-read a value from the registry}
var
  PVName : PAnsiChar;
begin
  GetMem(PVName,Length(ValueName)+1);
  try
    StrPCopy(PVName,ValueName);
{$IFDEF WIN32}
    DType := REG_NONE;
    Result := RegQueryValueEx(Key, PVName, nil,@DType,PByte(Data),LPDWORD(@Size));
{$ELSE}
    Result := RegQueryValue(Key,PVName,PAnsiChar(Data),Size);
{$ENDIF}
  finally
    FreeMem(PVName,strlen(PVName)+1);
  end;
end;

{==========================================================================}

function TStRegIni.GetFullKeyPath : string;
begin
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then begin
      Result := StrPas(riRootName) + '\' + StrPas(riCurSubKey);
    end else begin
      {$IFDEF WIN32}
      case riPrimaryKey of

        HKEY_LOCAL_MACHINE : Result := 'HKEY_LOCAL_MACHINE\';
        HKEY_USERS         : Result := 'HKEY_USERS\';
        HKEY_CLASSES_ROOT  : Result := 'HKEY_CLASSES_ROOT\';
        HKEY_CURRENT_USER  : Result := 'HKEY_CURRENT_USER\';
      end;
      {$ELSE}
      Result := 'HKEY_CLASSES_ROOT\';
      {$ENDIF}
      Result := Result + StrPas(riCurSubKey);
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.WriteBoolean(const ValueName : string; Value : Boolean);
  {-write Boolean value to the Ini file or registry}
var
  ECode    : LongInt;
  IValue   : DWORD;
  Key      : HKey;
  wResult  : Boolean;

begin
  riMode := riSet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then begin
      if (Value) then
        wResult := WriteIniData(ValueName, StrPas(riTrueString))
      else
        wResult := WriteIniData(ValueName, StrPas(riFalseString));
      if (NOT wResult) then
        RaiseRegIniError(stscIniWriteFail);
    end else begin
      Key := OpenRegKey;
      try
      {$IFDEF WIN32}
        IValue := Ord(Value);
        ECode := WriteRegData(Key,ValueName,@IValue,REG_DWORD,SizeOf(DWORD));
      {$ELSE}
        if Value then
          ECode := WriteRegData(Key,ValueName,riTrueString,REG_SZ,strlen(riTrueString)+1)
        else
          ECode := WriteRegData(Key,ValueName,riFalseString,REG_SZ,strlen(riFalseString)+1);
      {$ENDIF}
        if (ECode <> ERROR_SUCCESS) then
          RaiseRegIniErrorFmt(stscRegWriteFail,[ECode]);
      finally
        if (riRemoteKey = 0) then
          CloseRegKey(Key);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

function TStRegIni.ReadBoolean(const ValueName : string; Default : Boolean) : Boolean;
  {-read a Boolean value from the Ini file or registry}
var
  Value      : string;
  IVal       : Double;
  Key        : HKey;
  ECode,

  ValSize    : LongInt;
  ValType    : DWORD;
  LResult    : Pointer;
  Code       : Integer;

begin
  riMode := riGet;                                                     
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then begin
      if Default then
        ReadIniData(ValueName,Value,StrPas(riTrueString))
      else
        ReadIniData(ValueName,Value,StrPas(riFalseString));

      if (CompareText(Value,StrPas(riFalseString)) = 0) then
        Result := False
      else begin
        if (CompareText(Value,StrPas(riTrueString)) = 0) then
          Result := True
        else begin
          Val(Value,IVal,Code);
          if (Code = 0) then
            Result := IVal <> 0
          else
            Result := Default;
        end;
      end;

    end else begin
      try
        Key := OpenRegKey;
      except
        Result := Default;
        Exit;
      end;
      try
{$IFDEF WIN32}
        {get info on requested value}
        ECode := GetDataInfo(Key,ValueName,ValSize,ValType);
        if (ECode <> ERROR_SUCCESS) then begin
          Result := Default;
          Exit;
        end;

        {Size does not include null terminator for strings}
        if (ValType = REG_SZ) OR (ValType = REG_EXPAND_SZ) then
          Inc(ValSize);
        GetMem(LResult,ValSize);
        try
          ECode := ReadRegData(Key,ValueName,LResult,ValSize,ValType);
          if (ECode <> ERROR_SUCCESS) then
            Result := Default
          else begin
            {convert data, if possible, to Boolean}
            case (ValType) of
              REG_SZ,
              REG_EXPAND_SZ : Result := StrIComp(PAnsiChar(LResult),riFalseString) <> 0;
              REG_BINARY,
              REG_DWORD     : Result := (LongInt(LResult^) <> 0);
            else
              Result := Default;
            end;
          end;
        finally
          FreeMem(LResult,ValSize);
        end;
{$ELSE}
        ValSize := ShortBufSize;
        ValType := REG_SZ;
        GetMem(LResult,ValSize);
        try
          ECode := ReadRegData(Key,ValueName,LResult,ValSize,ValType);
          if (ECode <> ERROR_SUCCESS) then
            Result := Default
          else begin
            Result := Default;
            {check if returned string = True or False string}
            if (StrIComp(PAnsiChar(LResult),riFalseString) = 0) then
              Result := False
            else
              if (StrIComp(PAnsiChar(LResult),riTrueString) = 0) then
                Result := True
            else begin
              {attempt return Boolean based on numeric value}
              Value := StrPas(PAnsiChar(LResult));
              Val(Value,IVal,Code);
              if (Code = 0) then
                Result := IVal <> 0
            end;
          end;
        finally
          FreeMem(LResult,ValSize);
        end;
{$ENDIF}
      finally
        if (riRemoteKey = 0) then
          CloseRegKey(Key);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.WriteInteger(const ValueName : string; Value : DWORD);
  {-write an integer to the Ini file or the registry}
var
  ECode   : LongInt;
  Key     : HKey;
{$IFNDEF WIN32}
  PValue  : PAnsiChar;
  SValue  : string;
{$ENDIF}

begin
  riMode := riSet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then begin
      if (NOT WriteIniData(ValueName,IntToStr(Value))) then
        RaiseRegIniError(stscIniWriteFail);
    end else begin
      Key := OpenRegKey;
      try
{$IFDEF WIN32}
        ECode := WriteRegData(Key,ValueName,@Value,REG_DWORD,SizeOf(DWORD));
{$ELSE}
        Str(Value,SValue);
        GetMem(PValue,Length(SValue)+1);
        try
          StrPCopy(PValue,SValue);
          ECode := WriteRegData(Key,ValueName,PValue,REG_SZ,strlen(PValue)+1);
        finally
          FreeMem(PValue,strlen(PValue)+1);
        end;
{$ENDIF}
        if (ECode <> ERROR_SUCCESS) then
          RaiseRegIniErrorFmt(stscRegWriteFail,[ECode]);
      finally
        if (riRemoteKey = 0) then
          CloseRegKey(Key);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

function TStRegIni.ReadInteger(const ValueName : string; Default : DWORD) : DWORD;
  {-read an integer from the Ini file or registry}
var
  Value      : string;

  ECode,
  Key        : HKey;
  Len        : LongInt;
  ValSize    : LongInt;
  ValType    : DWORD;

  LResult    : Pointer;
  Code       : Integer;
begin
  riMode := riGet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then begin
      Len := ReadIniData(ValueName,Value,IntToStr(Default));
      if (Len > 0) then begin
        Val(Value,Result,Code);
        if (Code <> 0) then
          Result := Default;
      end else
        Result := Default;
    end else begin
      try
        Key := OpenRegKey;
      except
        Result := Default;
        Exit;
      end;
      try
{$IFDEF WIN32}
        {get info on requested value}
        ECode := GetDataInfo(Key,ValueName,ValSize,ValType);
        if (ECode <> ERROR_SUCCESS) then begin
          Result := Default;
          Exit;
        end;

        {Size does not include null terminator for strings}
        if (ValType = REG_SZ) OR (ValType = REG_EXPAND_SZ) then
          Inc(ValSize);
        GetMem(LResult,ValSize);
        try
          ECode := ReadRegData(Key,ValueName,LResult,ValSize,ValType);
          if (ECode <> ERROR_SUCCESS) then
            Result := Default
          else begin
            {convert data, if possible, to an integer value}
            case (ValType) of
              REG_SZ,
              REG_EXPAND_SZ : begin
                                Value := StrPas(PAnsiChar(LResult));
                                Val(Value,Result,Code);
                                if (Code <> 0) then
                                  Result := Default;
                              end;
              REG_BINARY,
              REG_DWORD     : Result := DWORD(LResult^);
            else
              Result := Default;
            end;
          end;
        finally
          FreeMem(LResult,ValSize);
        end;
{$ELSE}
        ValSize := ShortBufSize;
        ValType := REG_SZ;
        GetMem(LResult,ValSize);
        try
          ECode := ReadRegData(Key,ValueName,LResult,ValSize,ValType);
          if (ECode <> ERROR_SUCCESS) then
            Result := Default
          else begin
            Value := StrPas(PAnsiChar(LResult));
            Val(Value,Result,Code);
            if (Code <> 0) then
              Result := Default;
          end;
        finally
          FreeMem(LResult,ValSize);
        end;
{$ENDIF}
      finally
        if (riRemoteKey = 0) then
          CloseRegKey(Key);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

function TStRegIni.BytesToString(Value : PByte; Size : Cardinal) : string;
  {-convert byte array to string, no spaces or hex enunciators, e.g., '$'}
var
  I,
  Index  : Cardinal;
  S      : String[3];

begin
{$IFDEF WIN32}
  {$IFOPT H+}
  SetLength(Result,2*Size);
  {$ELSE}
  Result[0] := AnsiChar(Size*2);
  {$ENDIF}
{$ELSE}
  Result[0] := AnsiChar(Size*2);
{$ENDIF}

  for I := 1 to Size do begin
    Index := I*2;
{$IFDEF WIN32}
  {$IFOPT H+}
    S := HexBL(Byte(PAnsiChar(Value)[I-1]));
  {$ELSE}
    S := HexBS(Byte(PAnsiChar(Value)[I-1]);
  {$ENDIF}
{$ELSE}
    S := HexBS(Byte(PAnsiChar(Value)[I-1]));
{$ENDIF}
    Result[(Index)-1] := S[1];
    Result[Index] := S[2];
  end;
end;

{==========================================================================}

function TStRegIni.StringToBytes(const IString : string; var Value; Size : Cardinal) : Boolean;
  {-convert string (by groups of 2 char) to byte values}
var
  Code,
  Index,
  I     : Integer;
  Q     : array[1..MaxByteArraySize] of byte;
  S     : array[1..3] of AnsiChar;
begin
  if ((Length(IString) div 2) <> LongInt(Size)) then begin             
    Result := False;
    Exit;
  end;

  Result := True;
  for I := 1 to Size do begin
    Index := (2*(I-1))+1;
    S[1] := '$';
    S[2] := IString[Index];
    S[3] := IString[Index+1];
    Val(S,Q[I],Code);
    if (Code <> 0) then begin
      Result := False;
      Exit;
    end;
 end;
  Move(Q, Value, Size);
end;

{==========================================================================}

procedure TStRegIni.WriteBinaryData(const ValueName : string; const Value; Size : Integer);
  {-write binary data of any form to Ini file or registry}
var
  SValue : string;
  ECode  : LongInt;
  Key    : HKey;
{$IFNDEF WIN32}
  PValue : Pointer;
{$ENDIF}
begin
  riMode := riSet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then begin
      if (Size > MaxByteArraySize) then
        RaiseRegIniError(stscByteArrayTooLarge);
      SValue := BytesToString(PByte(@Value),Size);
      if (NOT WriteIniData(ValueName,SValue)) then
        RaiseRegIniError(stscIniWriteFail);
    end else begin
      Key := OpenRegKey;
      try
{$IFDEF WIN32}
        ECode := WriteRegData(Key,ValueName,@Value,REG_BINARY,Size);
{$ELSE}
        SValue := BytesToString(PByte(@Value),Size);
        GetMem(PValue,Length(SValue)+1);
        try
          StrPCopy(PValue,SValue);
          ECode := WriteRegData(Key,ValueName,PValue,REG_SZ,strlen(PValue)+1);
        finally
          FreeMem(PValue,strlen(PValue)+1);
        end;
{$ENDIF}
        if (ECode <> ERROR_SUCCESS) then
          RaiseRegIniErrorFmt(stscRegWriteFail,[ECode]);
      finally
        if (riRemoteKey = 0) then
          CloseRegKey(Key);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.ReadBinaryData(const ValueName : string; const Default;
                                     var Value; var Size : Integer);
  {-read binary data of any form from Ini file or regsitry}
var
  ECode     : LongInt;
  Key       : HKey;
  Len       : Cardinal;

  ValSize   : LongInt;
  ValType   : DWORD;

  DefVals,
  Values    : string;
{$IFNDEF WIN32}
  LResult   : Pointer;
{$ENDIF}

begin
  riMode := riGet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then begin
      DefVals := BytesToString(PByte(@Default), Size);
      Len := ReadIniData(ValueName, Values, DefVals);
      if (Len mod 2 = 0) then begin
        {covert string, if possible, to series of bytes}
        if not (StringToBytes(Values, PByte(Value), Size)) then
          Move(Default, PByte(Value), Size);
      end else
        Move(Default, PByte(Value), Size);
    end else begin
      try
        Key := OpenRegKey;
      except
        Move(Default, Value, Size);
        Exit;
      end;
      try
{$IFDEF WIN32}
        {get info on requested value}
        ECode := GetDataInfo(Key, ValueName, ValSize, ValType);
        if (ECode <> ERROR_SUCCESS) then begin
          Move(Default, Value, Size);
          Exit;
        end;

        if (ValSize <> Size) then
          RaiseRegIniErrorFmt(stscBufferDataSizesDif, [Size,ValSize])  {!!.01}
        else                                                           {!!.01}
          Size := ValSize;                                             {!!.01}

        if (ValType <> REG_BINARY) then
          Move(Default, Value, Size)
        else begin
          ECode := ReadRegData(Key, ValueName, PByte(@Value), ValSize, ValType);
          if (ECode <> ERROR_SUCCESS) then
            Move(Default, Value, Size)
        end;
{$ELSE}
        ValSize := ShortBufSize;
        ValType := REG_SZ;
        GetMem(LResult, ValSize);
        try
          ECode := ReadRegData(Key, ValueName, LResult, ValSize, ValType);
          if (ECode <> ERROR_SUCCESS) then
            Move(PAnsiChar(Default), PAnsiChar(Value), Size)
          else begin
            Values := StrPas(PAnsiChar(LResult));
            if ((Length(Values) div 2) > MaxByteArraySize) then
              Move(PAnsiChar(Default), PAnsiChar(Value), Size);
            if NOT (StringToBytes(Values, PByte(Value), Size)) then
              Move(PAnsiChar(Default), PAnsiChar(Value), Size);
          end;
        finally
          FreeMem(LResult,ValSize);
        end;
{$ENDIF}
      finally
        if (riRemoteKey = 0) then
          CloseRegKey(Key);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.WriteString(const ValueName : string; const Value : string);
  {-write a string to the Ini file or registry}
var
  ECode  : LongInt;
  Key    : HKey;
  PValue : PAnsiChar;
begin
  riMode := riSet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then begin
      if NOT WriteIniData(ValueName, Value) then
        RaiseRegIniError(stscIniWriteFail);
    end else begin
      GetMem(PValue, Length(Value)+1);
      try
{$IFDEF WIN32}
  {$IFOPT H+}
        StrCopy(PValue, PAnsiChar(Value));
  {$ELSE}
        StrPCopy(PValue, Value);
  {$ENDIF}
{$ELSE}
        StrPCopy(PValue, Value);
{$ENDIF}
        Key := OpenRegKey;
        try
          {same call for 16/32 since we're using a PChar}
          ECode := WriteRegData(Key,ValueName, PValue,REG_SZ, strlen(PValue)+1);
          if (ECode <> ERROR_SUCCESS) then
            RaiseRegIniErrorFmt(stscRegWriteFail,[ECode]);
        finally
          if (riRemoteKey = 0) then
            CloseRegKey(Key);
        end;
      finally
        FreeMem(PValue,strlen(PValue)+1);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

function TStRegIni.ReadString(const ValueName : string; const Default : string) : string;
  {-read a string from an Ini file or the registry}
var
  ECode     : LongInt;
  Len       : LongInt;
  ValSize   : LongInt;
  Key       : HKey;
  ValType   : DWORD;
  TmpVal    : DWORD;
  LResult   : Pointer;

begin
  riMode := riGet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then begin
      Len := ReadIniData(ValueName,Result,Default);
      if (Len < 1) then
        Result := Default;
    end else begin
      try
        Key := OpenRegKey;
      except
        Result := Default;
        Exit;
      end;
      try
{$IFDEF WIN32}
        {get info on requested value}
        ECode := GetDataInfo(Key,ValueName,ValSize,ValType);
        if (ECode <> ERROR_SUCCESS) then begin
          Result := Default;
          Exit;
        end;

        if (ValType = REG_SZ) OR (ValType = REG_EXPAND_SZ)then
          Inc(ValSize);
        GetMem(LResult,ValSize);
        try
          ECode := ReadRegData(Key,ValueName,LResult,ValSize,ValType);
          if (ECode <> ERROR_SUCCESS) AND (ECode <> ERROR_MORE_DATA) then
            Result := Default
          else begin
            {convert data, if possible, to string}
            case (ValType) of
              REG_SZ,
              REG_EXPAND_SZ : Result := StrPas(PAnsiChar(LResult));
              REG_BINARY   : begin
                               if (ValSize > MaxByteArraySize) then
                                 RaiseRegIniError(stscByteArrayTooLarge);
                               Result := BytesToString(PByte(@LResult),ValSize);
                             end;
              REG_DWORD    : begin
                               TmpVal := DWORD(LResult^);
                               Str(TmpVal,Result);
                             end;
            else
              Result := Default;
              end;
            end;
        finally
          FreeMem(LResult,ValSize);
        end;
{$ELSE}
        ValSize := ShortBufSize;
        ValType := REG_SZ;
        GetMem(LResult,ValSize);
        try
          ECode := ReadRegData(Key,ValueName,LResult,ValSize,ValType);
          if (ECode <> ERROR_SUCCESS) then
            Result := Default
          else
            Result := StrPas(PAnsiChar(LResult));
         finally
          FreeMem(LResult,ValSize);
        end;
{$ENDIF}
      finally
        if (riRemoteKey = 0) then
          CloseRegKey(Key);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.WriteFloat(const ValueName : string; const Value : Double);
  {-write floating point number to Ini file or registry}
var
  ECode   : LongInt;
  Key     : HKey;
{$IFNDEF WIN32}
  PValue  : PAnsiChar;
{$ENDIF}
  SValue  : string;

begin
  riMode := riSet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    Str(Value, SValue);
    while (SValue[1] = ' ') do                                         
      System.Delete(SValue, 1, 1);                                     
    if (riType = riIniType) then begin
      if (NOT WriteIniData(ValueName, SValue)) then
        RaiseRegIniError(stscIniWriteFail);
    end else begin
      Key := OpenRegKey;
      try
      {$IFDEF WIN32}
        ECode := WriteRegData(Key,ValueName,@Value,REG_BINARY,SizeOf(Double));
      {$ELSE}
        GetMem(PValue,Length(SValue)+1);
        try
          StrPCopy(PValue,SValue);
          ECode := WriteRegData(Key,ValueName,PValue,REG_SZ,strlen(PValue)+1);
        finally
          FreeMem(PValue,strlen(PValue)+1);
        end;
      {$ENDIF}
        if (ECode <> ERROR_SUCCESS) then
          RaiseRegIniErrorFmt(stscRegWriteFail,[ECode]);
      finally
        if (riRemoteKey = 0) then
          CloseRegKey(Key);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

function TStRegIni.ReadFloat(const ValueName : string; const Default : TStFloat) : TStFloat;
  {-read floating point value from Ini file or registry}
var
  SDefault,
  Value      : string;

  ECode,
  Key        : HKey;
  Len        : LongInt;
  ValSize    : LongInt;
  ValType    : DWORD;

  LResult    : Pointer;
  Code       : integer;

begin
  riMode := riGet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then begin
      Str(Default,SDefault);
      Len := ReadIniData(ValueName,Value,SDefault);
      if (Len > 0) then begin
        Val(Value,Result,Code);
        if (Code <> 0) then
          Result := Default;
      end else
        Result := Default;
    end else begin
      try
        Key := OpenRegKey;
      except
        Result := Default;
        Exit;
      end;
      try
{$IFDEF WIN32}
        ECode := GetDataInfo(Key,ValueName,ValSize,ValType);

        if (ECode <> ERROR_SUCCESS) then begin
          Result := Default;
          Exit;
        end;

        {Size does not include null terminator for strings}
        if (ValType = REG_SZ) OR (ValType = REG_EXPAND_SZ) then
          Inc(ValSize);

        GetMem(LResult,ValSize);
        try
          ECode := ReadRegData(Key,ValueName,LResult,ValSize,ValType);
          if (ECode <> ERROR_SUCCESS) then
            Result := Default
          else begin
            {convert data, if possible, to floating point number}
            case (ValType) of
              REG_SZ,
              REG_EXPAND_SZ : begin
                                Value := StrPas(PAnsiChar(LResult));
                                Val(Value,Result,Code);
                                if (Code <> 0) then
                                  Result := Default;
                              end;
              REG_BINARY,
              REG_DWORD     : Result := Double(LResult^);
            else
              Result := Default;
            end;
          end;
        finally
          FreeMem(LResult,ValSize);
        end;
{$ELSE}
        ValSize := ShortBufSize;
        ValType := REG_SZ;
        GetMem(LResult,ValSize);
        try
          ECode := ReadRegData(Key,ValueName,LResult,ValSize,ValType);
          if (ECode <> ERROR_SUCCESS) then
            Result := Default
          else begin
            Value := StrPas(PAnsiChar(LResult));
            Val(Value,Result,Code);
            if (Code <> 0) then
              Result := Default;
          end;
        finally
          FreeMem(LResult,ValSize);
        end;
{$ENDIF}
      finally
        if (riRemoteKey = 0) then
          CloseRegKey(Key);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.WriteDateTime(const ValueName : string; const Value : TDateTime);
  {-write a Delphi DateTime to Ini file or registry}
var
  ECode   : LongInt;
  Key     : HKey;
{$IFNDEF WIN32}
  PValue  : PAnsiChar;
{$ENDIF}
  SValue  : string;

begin
  riMode := riSet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    Str(Value,SValue);
    if (riType = riIniType) then begin
      if (NOT WriteIniData(ValueName,SValue)) then
        RaiseRegIniError(stscIniWriteFail);
    end else begin
      Key := OpenRegKey;
      try
      {$IFDEF WIN32}
        ECode := WriteRegData(Key,ValueName,@Value,REG_BINARY,SizeOf(TDateTime));
      {$ELSE}
        GetMem(PValue,Length(SValue)+1);
        try
          StrPCopy(PValue,SValue);
          ECode := WriteRegData(Key,ValueName,PValue,REG_SZ,strlen(PValue)+1);
        finally
          FreeMem(PValue,strlen(PValue)+1);
        end;
      {$ENDIF}
        if (ECode <> ERROR_SUCCESS) then
          RaiseRegIniErrorFmt(stscRegWriteFail,[ECode]);
      finally
        if (riRemoteKey = 0) then
          CloseRegKey(Key);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

function TStRegIni.ReadDateTime(const ValueName : string; const Default : TDateTime) : TDateTime;
  {-read a Delphi DateTime from the Ini file or registry}
var
  SDefault,
  Value      : string;

  ECode,
  Key        : HKey;
  Len        : LongInt;
  ValSize    : LongInt;
  ValType    : DWORD;

  LResult    : Pointer;
  Code       : integer;

begin
  riMode := riGet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then begin
      Str(Default,SDefault);
      Len := ReadIniData(ValueName,Value,SDefault);
      if (Len > 0) then begin
        Val(Value,Result,Code);
        if (Code <> 0) then
          Result := Default;
      end else
        Result := Default;
    end else begin
      try
        Key := OpenRegKey;
      except
        Result := Default;
        Exit;
      end;
      try
{$IFDEF WIN32}
        ECode := GetDataInfo(Key,ValueName,ValSize,ValType);

        if (ECode <> ERROR_SUCCESS) then begin
          Result := Default;
          Exit;
        end;

        {Size does not include null terminator for strings}
        if (ValType = REG_SZ) OR (ValType = REG_EXPAND_SZ) then
          Inc(ValSize);
        GetMem(LResult,ValSize);
        try
          ECode := ReadRegData(Key,ValueName,LResult,ValSize,ValType);
          if (ECode <> ERROR_SUCCESS) then
            Result := Default
          else begin
            {covert data, if possible, to DateTime value}
            case (ValType) of
              REG_SZ,
              REG_EXPAND_SZ : begin
                                Value := StrPas(PAnsiChar(LResult));
                                Val(Value,Result,Code);
                                if (Code <> 0) then
                                  Result := Default;
                              end;
              REG_BINARY,
              REG_DWORD     : Result := TDateTime(LResult^);
            else
              Result := Default;
            end;
          end;
        finally
          FreeMem(LResult,ValSize);
        end;
{$ELSE}
        ValSize := ShortBufSize;
        ValType := REG_SZ;
        GetMem(LResult,ValSize);
        try
          ECode := ReadRegData(Key,ValueName,LResult,ValSize,ValType);
          if (ECode <> ERROR_SUCCESS) then
            Result := Default
          else begin
            Value := StrPas(PAnsiChar(LResult));
            Val(Value,Result,Code);
            if (Code <> 0) then
              Result := Default;
          end;
        finally
          FreeMem(LResult,ValSize);
        end;
{$ENDIF}
      finally
        if (riRemoteKey = 0) then
          CloseRegKey(Key);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.WriteDate(const ValueName : string; const Value : TStDate);
  {-write a SysTools Date to Ini file or registry}
begin
  WriteInteger(ValueName,DWORD(Value));
end;

{==========================================================================}

function TStRegIni.ReadDate(const ValueName : string; const Default : TStDate) : TStDate;
  {-read a SysTools Date from Ini file or registry}
begin
  Result := TStDate(ReadInteger(ValueName,DWORD(Default)));
end;

{==========================================================================}

procedure TStRegIni.WriteTime(const ValueName : string; const Value : TStTime);
  {-write SysTools Time to Ini file or registry}
begin
  WriteInteger(ValueName,DWORD(Value));
end;

{==========================================================================}

function TStRegIni.ReadTime(const ValueName : string; const Default : TStTime) : TStTime;
  {-read SysTools Time from Ini file or registry}
begin
  Result := TStTime(ReadInteger(ValueName,DWORD(Default)));
end;

{==========================================================================}

procedure TStRegIni.CreateKey(const KeyName : string);
  {-create a new section in Ini file or subkey in registry}
const
  TempValueName = '$ABC123098FED';
var
  Disposition   : DWORD;
  ECode         : LongInt;
  newKey        : HKey;
  PCSKey,
  PSKey         : PAnsiChar;
  HoldKey       : HKey;
begin
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (Length(KeyName) = 0) then
      RaiseRegIniError(stscNoKeyName);

    if (riType = riIniType) then begin
      GetMem(PSKey,Length(KeyName)+1);
      try
        StrPCopy(PSKey,KeyName);
        {Create Section with temporary value}
        if (NOT WritePrivateProfileString(PSKey,TempValueName,' ',riRootName)) then
          RaiseRegIniError(stscCreateKeyFail);
        {Delete temporary value but leave section intact}
        if (NOT WritePrivateProfileString(PSKey,TempValueName,nil,riRootName)) then
          RaiseRegIniError(stscIniWriteFail);
      finally
        FreeMem(PSKey,Length(KeyName)+1);
      end;
    end else begin
      HoldKey := 0;
      GetMem(PCSKey, Length(KeyName)+1 + LongInt(strlen(riCurSubkey))+2);
      GetMem(PSKey, Length(KeyName)+1);
      try
        PCSKey[0] := #0;
        StrPCopy(PSKey,KeyName);
        if riCurSubKey[0] <> #0 then
          strcat(Strcopy(PCSKey, riCurSubKey), '\');
        strcat(PCSKey, PSKey);
{$IFDEF WIN32}
        if (riRemoteKey <> 0) then begin
          HoldKey := riPrimaryKey;
          riPrimaryKey := riRemoteKey;
        end;
        Disposition := 0;
        {creates a new key or opens an existing key}
        ECode := RegCreateKeyEx(riPrimaryKey,PCSKey,0,nil,
                 REG_OPTION_NON_VOLATILE,KEY_ALL_ACCESS,@FriSecAttr,
                 newKey,@Disposition);
        if (ECode <> ERROR_SUCCESS) then
          RaiseRegIniErrorFmt(stscCreateKeyFail,[ECode]);

        {don't leave a key open longer than it's needed}
        RegCloseKey(newKey);
{$ELSE}
        {creates a new key or opens an existing key}
        ECode := RegCreateKey(riPrimaryKey,PCSKey,newKey);
        if (ECode <> ERROR_SUCCESS) then
          RaiseRegIniErrorFmt(stscCreateKeyFail,[ECode]);

        {don't leave a key open longer than it's needed}
        RegCloseKey(newKey);
{$ENDIF}
      finally
        if (HoldKey <> 0) then
          riPrimaryKey := HoldKey;
        FreeMem(PSKey,Length(KeyName)+1);
        FreeMem(PCSKey, Length(KeyName)+1 + LongInt(strlen(riCurSubkey))+2);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.ParseIniFile(SList : TStrings);
{-procedure to read through an INI text file}
var
   F : TextFile;
   L : string;
begin
  AssignFile(F, riRootName);
  Reset(F);
  try
    Readln(F,L);
    while NOT EOF(F) do begin
      if (L[1] = '[') AND (L[Length(L)] = ']') then begin
        Delete(L, Length(L), 1);
        Delete(L, 1, 1);
        SList.Add(L);
      end;
      Readln(F,L);
    end;
  finally
    CloseFile(F);
  end;
end;

{==========================================================================}

procedure TStRegIni.GetSubKeys(SK : TStrings);
  {-get list of section names (or values) from Ini file or subkeys in registry}
  {For Ini files only: if riCurSubKey =  '', list is of section names}
  {                    if riCurSubKey <> '', list is of value names in section}
var
  ValueName     : PAnsiChar;

  Sections,
  valuePos,
  NumSubKeys,
  LongSKName,
  LongVName,
  NumVals,
  MaxSize,
  VSize         : DWORD;
  Buffer        : array[0..MaxBufSize] of AnsiChar;
  S             : string;
  ECode         : LongInt;
  Key           : HKey;

begin
  riMode := riGet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    SK.Clear;

    if (riType = riIniType) then begin
      Buffer[0] := #0;
      if (riCurSubKey[0] = #0) then begin
        {Get section names in ini file}
{$IFDEF WIN32}
        Sections := GetPrivateProfileSectionNames(Buffer,MaxBufSize,riRootName);
{$ELSE}
        {16 bit mode requires reading through the INI file}
        ParseIniFile(SK);
        Exit;
{$ENDIF}
      end else
        {get value names in specified section}
        Sections := GetPrivateProfileString(riCurSubKey,nil,#0,
                    Buffer,MaxBufSize,riRootName);

      {parse Section Names from Buffer string}
      if (Sections > 0) then begin
        valuePos := 0;
        repeat
          S := StrPas(Buffer+valuePos);
          if (Length(S) > 0) then begin
            SK.Add(S);
            Inc(valuePos,StrEnd(Buffer+valuePos)-(Buffer+valuePos)+1);
          end else
            break;
        until Length(S) = 0;
      end;
    end else begin
      Key := OpenRegKey;
      try
{$IFDEF WIN32}
        ECode := RegQueryInfoKey(Key,nil,nil,nil,@NumSubKeys,
                   @LongSKName,nil,@NumVals,@LongVName,@MaxSize,nil,nil);
        if (ECode <> ERROR_SUCCESS) then
          RaiseRegIniErrorFmt(stscQueryKeyFail,[ECode]);
        Inc(LongSKName);
        valuePos := 0;
        GetMem(ValueName,LongSKName);
        try
          while valuePos < NumSubKeys do begin
            ValueName[0] := #0;
            VSize := LongSKName;
            ECode := RegEnumKeyEx(Key,valuePos,ValueName,VSize,
                       nil,nil,nil,nil);
            if (ECode <> ERROR_SUCCESS) AND
               (ECode <> ERROR_MORE_DATA) then
              RaiseRegIniErrorFmt(stscEnumKeyFail,[ECode]);
            SK.Add(StrPas(ValueName));
            Inc(valuePos);
          end;
        finally
          FreeMem(ValueName,LongSKName);
        end;
{$ELSE}
       valuePos := 0;
       VSize := ShortBufSize;
       GetMem(ValueName,ShortBufSize);
       try
         while RegEnumKey(Key,valuePos,ValueName,VSize) = ERROR_SUCCESS do begin
           SK.Add(StrPas(ValueName));
           Inc(valuePos);
           VSize := ShortBufSize;
           ValueName[0] := #0;
         end;
       finally
         FreeMem(ValueName,ShortBufSize);
       end;
{$ENDIF}
      finally
        if (riRemoteKey = 0) then
          CloseRegKey(Key);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.GetValues(SKV : TStrings);
  {-return value names and string representation of data in}
  {Ini file section or registry subkey}
var
  ValueName    : PAnsiChar;

  valuePos,
  NumSubKeys,
  LongSKName,
  LongVName,
  NumVals,
  MaxSize,
  VSize,
  DSize        : DWORD;

  S, TS        : string;
  KeyList      : TStringList;
  ECode        : LongInt;
  Key          : HKey;

  ValType      : DWORD;
  LResult      : Pointer;

begin
  riMode := riGet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    SKV.Clear;

    if (riType = riIniType) then begin
      KeyList := TStringList.Create;
      try
        {get list of value names in section}
        GetSubKeys(KeyList);
        if (KeyList.Count > 0) then begin                              
          for valuePos := 0 to KeyList.Count-1 do begin
            S := KeyList[valuePos] + '='
               + ReadString(KeyList[valuePos],'');
            SKV.AddObject(S,BmpText);
          end;
        end;                                                           
      finally
        KeyList.Free;
      end;
    end else begin
      Key := OpenRegKey;
      try
{$IFDEF WIN32}
        {get data on specified keys}
        ECode := RegQueryInfoKey(Key,nil,nil,nil,
                   @NumSubKeys,@LongSKName,nil,@NumVals,
                   @LongVName,@MaxSize,nil,nil);
        if (ECode <> ERROR_SUCCESS) then
          RaiseRegIniErrorFmt(stscQueryKeyFail,[ECode]);
        Inc(MaxSize);
        Inc(LongVName);
        GetMem(LResult,MaxSize);
        try
          valuePos := 0;
          GetMem(ValueName,LongVName);
          try
            {step through values in subkey and get data from each}
            while valuePos < NumVals do begin
              ValueName[0] := #0;
              VSize := LongVName;
              DSize := MaxSize;
              ECode := RegEnumValue(Key,valuePos,ValueName,
                         VSize,nil,@ValType,LResult,@DSize);
              if (ECode <> ERROR_SUCCESS) AND
                 (ECode <> ERROR_MORE_DATA) then
                RaiseRegIniErrorFmt(stscEnumValueFail,[ECode]);
              if (Length(ValueName) > 0) then
                S := StrPas(ValueName) + '='
              else
                S := 'Default=';
              case ValType of
                {convert data to string representation}
                REG_SZ,
                REG_EXPAND_SZ : begin
                                  TS := StrPas(PAnsiChar(LResult));
                                  S := S + TS;
                                  SKV.AddObject(S,BmpText);
                                end;

                REG_DWORD,
                REG_BINARY     : begin
                                  if ValType = REG_DWORD then
                                    Str(LongInt(LResult^),TS)
                                  else
                                    TS := BytesToString(PByte(LResult),DSize);
                                  S := S + TS;
                                  SKV.AddObject(S,BmpBinary);
                                end;
              end;
              Inc(valuePos);
            end;
          finally
            FreeMem(ValueName,LongVName);
          end;
        finally
          FreeMem(LResult,MaxSize);
        end;
{$ELSE}
        {16 bit mode Registry has one value per key}
        if (BmpText <> nil) then
          SKV.AddObject('Default=' + ReadString('',''),BmpText)
        else
          SKV.Add('Default=' + ReadString('',''));
{$ENDIF}
      finally
        if (riRemoteKey = 0) then
          CloseRegKey(Key);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.DeleteKey(const KeyName : string; DeleteSubKeys : Boolean);
  {-delete a section from Ini file or subkey from registry}
  {if DeleteSubKeys = True  : specified section (key) and values (subkeys),}
  {                           if any, are deleted                          }
  {                 = False : specified section (key) can not be deleted   }
  {                           if there are any values (subkeys)            }
var
  PSKey      : PAnsiChar;
  NumSubKeys,
  NumValues  : DWORD;
  Key        : HKey;
  ECode      : LongInt;
  TS,
  HldKey     : ShortString;
  ASL        : TStringList;


{$IFDEF WIN32}
     procedure ClearKey(StartKey : HKey);
     var
       SL   : TStringList;
       NK   : HKey;
       NSK,
       NV   : DWORD;
       J    : LongInt;
       TS,
       HK   : ShortString;
       PSK  : array[0..255] of char;
     begin
       ECode := RegQueryInfoKey(StartKey, nil, nil, nil, @NSK,
                  nil, nil, @NV, nil, nil, nil, nil);
       if (NV > 0) then begin
         SL := TStringList.Create;
         try
           GetValues(SL);
           for J := 0 to SL.Count-1 do begin
             TS := SL.Names[J];
             if (AnsiCompareText('Default', TS) <> 0) then
               DeleteValue(TS);
           end;
         finally
           SL.Free;
         end;
       end;

       if NSK > 0 then begin
         SL := TStringList.Create;
         try
           GetSubKeys(SL);
           for J := 0 to SL.Count-1 do begin
             HK := GetCurSubKey;
             SetCurSubKey(HK + '\' + SL[J]);
             NK := OpenRegKey;
             ClearKey(NK);
             RegCloseKey(NK);
             SetCurSubKey(HK);
             StrPCopy(PSK, SL[J]);
             RegDeleteKey(StartKey, PSK);
           end;
         finally
           SL.Free;
         end;
       end;
     end;
{$ENDIF}


begin
  riMode := riSet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    GetMem(PSKey,Length(KeyName)+1);
    try
      StrPCopy(PSKey,KeyName);
      if (riType = riIniType) then begin
        ASL := TStringList.Create;
        try
          {check for values in section}
          HldKey := GetCurSubkey;
          SetCurSubKey(KeyName);
          GetSubKeys(ASL);
          SetCurSubKey(HldKey);
          NumSubKeys := ASL.Count;

          {remove section KeyName from INI file}
          if (NumSubKeys > 0) AND (NOT DeleteSubKeys) then
            RaiseRegIniErrorFmt(stscKeyHasSubKeys,[NumSubKeys]);
          if (NOT WritePrivateProfileString(PSKey,nil,nil,riRootName)) then
            RaiseRegIniError(stscIniDeleteFail);
        finally
          ASL.Free;
        end;
      end else begin
        HldKey := GetCurSubkey;
        TS := HldKey + '\' + KeyName;
        if TS[1] = '\' then
          Delete(TS, 1, 1);
        SetCurSubKey(TS);
        Key := OpenRegKey;
{$IFDEF WIN32}
        try
          {check for subkeys under key to be deleted}
          ECode := RegQueryInfoKey(Key, nil, nil, nil, @NumSubKeys,
                     nil, nil, @NumValues, nil, nil, nil, nil);

          if (ECode <> ERROR_SUCCESS) then
            RaiseRegIniErrorFmt(stscQueryKeyFail,[ECode]);

          if (NumSubKeys > 0) OR (NumValues > 0) then begin
            if (NOT DeleteSubKeys) then
              RaiseRegIniErrorFmt(stscKeyHasSubKeys,[NumSubKeys])
            else
              if (riWinVer = riWinNT) then
                ClearKey(Key);
          end;
        finally
          RegCloseKey(Key);
          SetCurSubKey(HldKey);
        end;

        Key := OpenRegKey;
        try
          ECode := RegDeleteKey(Key, PSKey);
          if (ECode <> ERROR_SUCCESS) then
            RaiseRegIniErrorFmt(stscDeleteKeyFail,[ECode]);
        finally
          if (riRemoteKey = 0) then
            RegCloseKey(Key);
        end;
{$ELSE}
        try
          ASL := TStringList.Create;
          try
            GetSubKeys(ASL);
            NumSubKeys := ASL.Count;

            ASL.Clear;
            GetValues(ASL);
            NumValues := ASL.Count;
          finally
            ASL.Free;
          end;
        finally
          RegCloseKey(Key);
          SetCurSubKey(HldKey);
        end;

        if (NumSubKeys > 0) OR (NumValues > 0) then begin
          if (NOT DeleteSubKeys) then
            RaiseRegIniErrorFmt(stscKeyHasSubKeys,[NumSubKeys]);
        end;

        Key := OpenRegKey;
        try
          ECode := RegDeleteKey(Key, PSKey);
          if (ECode <> ERROR_SUCCESS) then
            RaiseRegIniErrorFmt(stscDeleteKeyFail,[ECode]);
        finally
          if (riRemoteKey = 0) then
            RegCloseKey(Key);
        end;
{$ENDIF}
      end;
    finally
      FreeMem(PSKey,Length(KeyName)+1);
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.DeleteValue(const ValueName : string);
  {-delete value from Ini file section or registry subkey}
var
  PVName : PAnsiChar;
  ECode  : LongInt;
  Key    : HKey;
begin
  riMode := riSet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    GetMem(PVName,Length(valueName)+1);
    try
      StrPCopy(PVName,valueName);
      if (riType = riIniType) then begin
        if (NOT WritePrivateProfileString(riCurSubKey,PVName,nil,riRootName)) then
          RaiseRegIniError(stscIniDelValueFail);
      end else begin
  {$IFDEF WIN32}
        Key := OpenRegKey;
        try
          ECode := RegDeleteValue(Key,PVName);
          if (ECode <> ERROR_SUCCESS) then
            RaiseRegIniErrorFmt(stscRegDelValueFail,[ECode]);
        finally
          if (riRemoteKey = 0) then
            CloseRegKey(Key);
        end;
  {$ELSE}
        {in 16 bit, set value to empty string}
        WriteString(ValueName,'');
  {$ENDIF}
      end;
    finally
      FreeMem(PVName,Length(valueName)+1);
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.QueryKey(var KeyInfo : TQueryKeyInfo);
  {-get informatino about Ini file seciton or registry subkey}
const
  BufSize = 2048;
var
  PVName,
  PCName       : PAnsiChar;

  P,
  step         : integer;
{$IFNDEF WIN32}
  valuePos     : Integer;
  VNSize,
  SKSize       : DWORD;
{$ENDIF}

  CNSize       : DWORD;
  Key          : HKey;
  ECode        : LongInt;
  SL           : TStringList;

begin
  riMode := riGet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then begin
    {data for the specified section in the INI file}
      SL := TStringList.Create;
      try
        FillChar(KeyInfo,sizeof(KeyInfo),#0);
        {get value names/values}
        GetValues(SL);
        with KeyInfo do begin
          QIMaxVNLen   := 0;
          QIMaxDataLen := 0;
          QINumValues := SL.Count;
          if (SL.Count > 0) then begin
            for step := 0 to SL.Count-1 do begin
              {find maximum length of value names and values}
              P := pos('=',SL[step])-1;
              if (P > LongInt(QIMaxVNLen)) then                        
                QIMaxVNLen := P;

              P := Length(SL[step]) - P;
              if (P > LongInt(QIMaxDataLen)) then                      
                QIMaxDataLen := P;
            end;
          end;
        end;
      finally
        SL.Free;
      end;
    end else begin
      PVName := nil;
      PCName := nil;
      try
        GetMem(PVName,BufSize);
        GetMem(PCName,BufSize);

        Key := OpenRegKey;
        try
{$IFDEF WIN32}
          PCName[0] := #0;
          CNSize := BufSize;
          with KeyInfo do begin
            ECode := RegQueryInfoKey(Key,PCName,@CNSize,
                       nil,@QINumSubKeys,@QIMaxSKNLen,
                       @QIMaxCNLen, @QINumValues,
                       @QIMaxVNLen, @QIMaxDataLen,
                       @QISDescLen, @QIFileTime);
            if (ECode <> ERROR_SUCCESS) then
              RaiseRegIniErrorFmt(stscQueryKeyFail,[ECode]);
            QIKey := Key;
            QIClassName := StrPas(PCName);
          end;
{$ELSE}
          FillChar(KeyInfo,sizeof(KeyInfo),#0);
          with KeyInfo do begin
            QIKey := Key;
            {16 bit mode has one value per key}
            QINumValues := 1;

            PCName[0] := #0;
            valuePos := 0;
            SKSize := BufSize;
            while RegEnumKey(Key,valuePos,PCName,SKSize) = ERROR_SUCCESS do begin
              Inc(QINumSubKeys);
              if (strlen(PCName) > QIMaxSKNLen) then
                QIMaxSKNLen := strlen(PCName);

              VNSize := BufSize;
              if (RegQueryValue(Key,PCName,PVName,VNSize) = ERROR_SUCCESS) then begin
                if (strlen(PVName) > QIMaxDataLen) then
                  QIMaxDataLen := strlen(PVName);
              end;
              Inc(valuePos);
              SKSize := BufSize;
              PCName[0] := #0;
            end;
          end;
{$ENDIF}
        finally
          if (riRemoteKey = 0) then
            CloseRegKey(Key);
        end;
      finally
        if (PVName <> nil) then
          FreeMem(PVName,BufSize);
        if (PCName <> nil) then
          FreeMem(PCName,BufSize);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

function TStRegIni.KeyExists(KeyName : string) : Boolean;
  {-checks if exists in INI file/Registry}
var
  KN : PAnsiChar;
  PV : array[0..9] of char;
  HK : HKey;
begin
  riMode := riGet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    GetMem(KN, Length(KeyName)+1);
    try
      StrPCopy(KN, KeyName);
      if (riType = riIniType) then begin
        GetPrivateProfileString(KN, nil, '$KDNE1234', PV, 10, riRootName);
        Result := StrIComp(PV, '$KDNE1234') <> 0;
      end else begin                                                 
{$IFDEF WIN32}
         Result := RegOpenKeyEx(riPrimaryKey,KN,0,KEY_READ,HK) = ERROR_SUCCESS;
{$ELSE}
         Result := RegOpenKey(riPrimaryKey,KN,HK) = ERROR_SUCCESS;
{$ENDIF}
         if Result then
           RegCloseKey(HK);
      end;                                                           
    finally
      FreeMem(KN, Length(KeyName)+1);
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

function TStRegIni.IsKeyEmpty(Primary, SubKey : string) : Boolean;
var
  FindPos    : Integer;
  Key        : HKey;
  NumSubKeys,
  NumValues  : DWORD;
  ECode      : LongInt;
  HPrime,
  HSubKy     : ShortString;
  ASL        : TStringList;

begin
  riMode := riGet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    HPrime := GetPrimary;
    HSubKy := CurSubKey;

    SetPrimary(Primary);
    CurSubKey := SubKey;
    Result := True;

    if (riType = riIniType) then begin
        {check for values in section}
      ASL := TStringList.Create;
      try
        ParseIniFile(ASL);
        if not (ASL.Find( '[' + SubKey + ']', FindPos)) then
          Result := False;
      finally
        ASL.Free;
      end;
    end else begin
      try
        Key := OpenRegKey;
        try
{$IFDEF WIN32}
          ECode := RegQueryInfoKey(Key, nil, nil, nil, @NumSubKeys,
                     nil, nil, @NumValues, nil, nil, nil, nil);
          if (ECode <> ERROR_SUCCESS) or
             (NumSubKeys > 0) or (NumValues > 0) then
            Result := False;
{$ELSE}
        ASL := TStringList.Create;
        try
          GetSubKeys(ASL);
          if ASL.Count > 0 then
            Result := False
          else begin
            ASL.Clear;
            GetValues(ASL);
            if ASL.Count > 0 then
              Result := False;
          end;
        finally
          ASL.Free;
        end;
{$ENDIF}
        except
          Result := False;
        end;
        RegCloseKey(Key);
      finally
        SetPrimary(HPrime);
        SetCurSubKey(HSubKy);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.SaveKey(const SubKey : string; FileName : string);
  {-save contents of registry key to a file}
var
  SKey    : string;

  PFName  : PAnsiChar;
  I,
  DotPos  : Cardinal;
  TSL     : TStringList;
  F       : TextFile;
  Key     : HKey;
  ECode   : LongInt;

{$IFDEF WIN32}
  hToken    : THandle;
  ptp,
  tp        : TTokenPrivileges;
  luid      : TLargeInteger;
  retval    : DWORD;
{$ENDIF}

begin
  riMode := riSet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (SubKey <> FCurSubKey) then begin
      SKey := FCurSubKey;
      SetCurSubKey(SubKey);
    end;

    if (riType = riIniType) then begin
      if (FileExists(FileName)) then
        RaiseRegIniError(stscOutputFileExists);
      TSL := TStringList.Create;
      try
        {get valuenames and values from specified section}
        GetValues(TSL);
        if (TSL.Count < 1) then
          RaiseRegIniError(stscKeyIsEmptyNotExists);
        AssignFile(F,FileName);
        ReWrite(F);
        try
          writeln(F,'[' + SubKey + ']');
          for I := 0 to TSL.Count-1 do
            writeln(F,TSL[I]);
        finally
          CloseFile(F);
        end;
      finally
        TSL.Free;
      end;
    end else begin
{$IFDEF WIN32}
      if (FileExists(FileName)) then
        RaiseRegIniError(stscOutputFileExists);
{$IFOPT H+}
      if (HasExtensionL(FileName,DotPos)) then
        RaiseRegIniError(stscFileHasExtension);
{$ELSE}
      if (HasExtensionS(FileName,DotPos)) then
        RaiseRegIniError(stscFileHasExtension);
{$ENDIF}
      GetMem(PFName,Length(FileName)+1);
      try
        StrPCopy(PFName,FileName);
        Key := OpenRegKey;
        try
          if (riWinVer = riWinNT) then begin
            OpenProcessToken(GetCurrentProcess(),
                             TOKEN_ADJUST_PRIVILEGES OR TOKEN_QUERY,
                             {$IFNDEF VERSION3}
                             @hToken);
                             {$ELSE}
                             hToken);
                             {$ENDIF}
            LookupPrivilegeValue(nil,'SeBackupPrivilege',luid);
            tp.PrivilegeCount     := 1;
            tp.Privileges[0].Luid := luid;
            tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;

            AdjustTokenPrivileges(hToken, FALSE, tp,
                                  sizeOf(TTokenPrivileges),ptp,retval);
          end;

          ECode := RegSaveKey(Key,PFName,@FriSecAttr);

          if (riWinVer = riWinNT) then
            AdjustTokenPrivileges(hToken,TRUE,tp,
                                  sizeOf(TTokenPrivileges),ptp,retval);

          if (ECode <> ERROR_SUCCESS) then
            RaiseRegIniErrorFmt(stscSaveKeyFail,[ECode]);
        finally
          if (riRemoteKey = 0) then
            CloseRegKey(Key);
        end;
      finally
        FreeMem(PFName,Length(FileName)+1);
      end;
{$ELSE}
      RaiseRegIniError(stscNo16bitSupport);
{$ENDIF}
    end;

    if (SKey <> '') then
      SetCurSubKey(SKey);
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.LoadKey(const SubKey, FileName : string);
  {-load a registry key from a file created with SaveKey}
const
  BufSize = 2048;
var
  I,
  DotPos  : Cardinal;
  PVName,
  PSValue,
  PSKey,
  PFName  : PAnsiChar;

  F       : TextFile;
  TSL     : TStringList;
  S,
  SKey    : string;
  ECode   : LongInt;
  P       : LongInt;                                                   

{$IFDEF WIN32}
  hToken    : THandle;
  ptp,
  tp        : TTokenPrivileges;
  luid      : TLargeInteger;
  retval    : DWORD;
{$ENDIF}

begin
{$IFDEF ThreadSafe}
  EnterCS;
{$ENDIF}
  riMode := riSet;
  PSKey  := nil;
  PFName := nil;
  PVName := nil;
  PSValue:= nil;
  try
    GetMem(PFName,Length(FileName)+1);
    GetMem(PVName,BufSize);
    GetMem(PSValue,BufSize);
    GetMem(PSKey,Length(SubKey)+1);

    StrPCopy(PFName,FileName);
    StrPCopy(PSKey,SubKey);
    if (riType = riIniType) then begin
      if (NOT FileExists(FileName)) then
        RaiseRegIniError(stscCantFindInputFile);

      {read contents of file into a string list}
      TSL := TStringList.Create;
      try
        AssignFile(F,FileName);
        try
          ReSet(F);
          while NOT EOF(F) do begin
            Readln(F,S);
            TSL.Add(S);
          end;
        finally
          CloseFile(F);
        end;

        if (TSL.Count < 1) then
          RaiseRegIniError(stscKeyIsEmptyNotExists);

        {if section exists - delete it and all values}
        DeleteKey(SubKey,True);

        {write contents of string list to ini file}
        for I := 1 to TSL.Count-1 do begin
          S := TSL[I];
          P := pos('=',S);
          Delete(S,P,Length(S)-P+1);
          StrPCopy(PVName,S);
          StrPCopy(PSValue,TSL.Values[S]);
          WritePrivateProfileString(PSKey,PVName,PSValue,riRootName);
        end;
      finally
        TSL.Free;
      end;
    end else begin
{$IFDEF WIN32}
      if (NOT FileExists(FileName)) then
        RaiseRegIniError(stscCantFindInputFile);
{$IFOPT H+}
      if (HasExtensionL(FileName,DotPos)) then
        RaiseRegIniError(stscFileHasExtension);
{$ELSE}
      if (HasExtensionS(FileName,DotPos)) then
        RaiseRegIniError(stscFileHasExtension);
{$ENDIF}

      {save current subkey if saving another}
      if (SubKey <> FCurSubKey) then begin
        SKey := FCurSubKey;
        SetCurSubKey(SubKey);
      end;

      {get security token for NT}
      if (riWinVer = riWinNT) then begin
        OpenProcessToken(GetCurrentProcess(),
                         TOKEN_ADJUST_PRIVILEGES OR TOKEN_QUERY,
                         {$IFNDEF VERSION3}
                         @hToken);
                         {$ELSE}
                         hToken);
                         {$ENDIF}
        LookupPrivilegeValue(nil,'SeRestorePrivilege',luid);
        tp.PrivilegeCount     := 1;
        tp.Privileges[0].Luid := luid;
        tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;

        AdjustTokenPrivileges(hToken, FALSE, tp,
                                    sizeOf(TTokenPrivileges),ptp,retval);
      end;

      {can load only at top of registry}
      if (riPrimaryKey = HKEY_LOCAL_MACHINE) OR
         (riPrimaryKey = HKEY_USERS) then begin
        ECode := RegLoadKey(riPrimaryKey,PSKey,PFName);
        if (riWinVer = riWinNT) then
           AdjustTokenPrivileges(hToken,TRUE,tp,
                                 sizeOf(TTokenPrivileges),ptp,retval);
        if (ECode <> ERROR_SUCCESS) then
          RaiseRegIniErrorFmt(stscLoadKeyFail,[ECode]);
      end else begin
        if (riRemoteKey <> 0) then begin
          ECode := RegLoadKey(riRemoteKey,PSKey,PFName);
          if (riWinVer = riWinNT) then
             AdjustTokenPrivileges(hToken,TRUE,tp,
                                   sizeOf(TTokenPrivileges),ptp,retval);
          if (ECode <> ERROR_SUCCESS) then
            RaiseRegIniErrorFmt(stscLoadKeyFail,[ECode]);
        end else
          RaiseRegIniError(stscInvalidPKey);
      end;

      {restore current subkey if necessary}
      if (SKey <> '') then
        SetCurSubKey(SKey);
{$ELSE}
      RaiseRegIniError(stscNo16bitSupport);
{$ENDIF}
    end;
  finally
    if (PSKey <> nil) then
      FreeMem(PSKey,strlen(PSKey)+1);
    if (PFName <> nil) then
      FreeMem(PFName,Length(FileName)+1);
    if (PSValue <> nil) then
      FreeMem(PSValue,BufSize);
    if (PVName <> nil) then
      FreeMem(PVName,BufSize);
{$IFDEF ThreadSafe}
    LeaveCS;
{$ENDIF}
  end;
end;

{==========================================================================}

procedure TStRegIni.UnLoadKey(const SubKey : string);
  {-remove a section from Ini file or subkey from registry}
  {Registry only: SubKey must have been loaded with LoadKey}
var
  PSKey      : PAnsiChar;
  ECode      : LongInt;
  HoldKey    : HKey;

{$IFDEF WIN32}
  hToken    : THandle;
  ptp,
  tp        : TTokenPrivileges;
  luid      : TLargeInteger;
  retval    : DWORD;
{$ENDIF}

begin
  riMode := riSet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then
      DeleteKey(SubKey,TRUE)
    else begin
{$IFDEF WIN32}
      GetMem(PSKey,Length(SubKey)+1);
      try
        StrPCopy(PSkey,SubKey);
        HoldKey := 0;

        {store primary key if working on remote computer}
        if (riRemoteKey <> 0) then begin
          HoldKey := riPrimaryKey;
          riPrimaryKey := riRemoteKey;
        end;
        try
          if (riWinVer = riWinNT) then begin
            OpenProcessToken(GetCurrentProcess(),
                             TOKEN_ADJUST_PRIVILEGES OR TOKEN_QUERY,
                             {$IFNDEF VERSION3}
                             @hToken);
                             {$ELSE}
                             hToken);
                             {$ENDIF}
            LookupPrivilegeValue(nil,'SeRestorePrivilege',luid);
            tp.PrivilegeCount     := 1;
            tp.Privileges[0].Luid := luid;
            tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;

            AdjustTokenPrivileges(hToken, FALSE, tp,
                                  sizeOf(TTokenPrivileges),ptp,retval);
          end;

          ECode := RegUnLoadKey(riPrimaryKey,PSKey);

          if (riWinVer = riWinNT) then
             AdjustTokenPrivileges(hToken,TRUE,tp,
                                   sizeOf(TTokenPrivileges),ptp,retval);

          if (ECode <> ERROR_SUCCESS) then
            RaiseRegIniErrorFmt(stscUnloadKeyFail,[ECode]);
        finally
          {restore primary key if function used on remote computer}
          if (riRemoteKey <> 0) then
            riPrimaryKey := HoldKey;
        end;
      finally
        FreeMem(PSKey,Length(SubKey)+1);
      end;
{$ELSE}
        RaiseRegIniError(stscNo16bitSupport);
{$ENDIF}
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.RestoreKey(const SubKey, KeyFile : string; Options : DWORD);
  {-restore a section of Ini file or subkey of registry}
  {Registry only: key being loaded must have been stored using SaveKey}
var
  PKFile,
  PSKey   : PAnsiChar;
  ECode   : LongInt;
  Key     : HKey;

{$IFDEF WIN32}
  hToken    : THandle;
  ptp,
  tp        : TTokenPrivileges;
  luid      : TLargeInteger;
  retval    : DWORD;
{$ENDIF}

begin
  riMode := riSet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then
      LoadKey(SubKey, KeyFile)
    else begin
{$IFDEF WIN32}
      if (riWinVer <> riWinNT) then
        RaiseRegIniError(stscNotWinNTPlatform);

      PSKey  := nil;
      PKFile := nil;
      try
        GetMem(PSKey,Length(SubKey)+1);
        GetMem(PKFile,Length(KeyFile)+1);
        StrPCopy(PSKey,SubKey);
        StrPCopy(PKFile,KeyFile);

        Key := OpenRegKey;
        try
          if (Options = REG_WHOLE_HIVE_VOLATILE) AND
             (Key <> HKEY_USERS) AND
             (Key <> HKEY_LOCAL_MACHINE) then
            RaiseRegIniError(stscBadOptionsKeyCombo);

          {get process token for WinNT}
          if (riWinVer = riWinNT) then begin
            OpenProcessToken(GetCurrentProcess(),
                             TOKEN_ADJUST_PRIVILEGES OR TOKEN_QUERY,
                             {$IFNDEF VERSION3}
                             @hToken);
                             {$ELSE}
                             hToken);
                             {$ENDIF}
            LookupPrivilegeValue(nil,'SeRestorePrivilege',luid);
            tp.PrivilegeCount     := 1;
            tp.Privileges[0].Luid := luid;
            tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;

            AdjustTokenPrivileges(hToken, FALSE, tp,
                                  sizeOf(TTokenPrivileges),ptp,retval);
          end;

          ECode := RegRestoreKey(Key,PKFile,Options);

          if (riWinVer = riWinNT) then
             AdjustTokenPrivileges(hToken,TRUE,tp,
                                   sizeOf(TTokenPrivileges),ptp,retval);

          if (ECode <> ERROR_SUCCESS) then
            RaiseRegIniErrorFmt(stscRestoreKeyFail,[ECode]);
        finally
          CloseRegKey(Key);
        end;
      finally
        if (PSKey <> nil) then
          FreeMem(PSKey,Length(SubKey)+1);
        if (PKFile <> nil) then
          FreeMem(PKFile,Length(KeyFile)+1);
      end;
{$ELSE}
      RaiseRegIniError(stscNo16bitSupport);
{$ENDIF}
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.ReplaceKey(const SubKey, InputFile, SaveFile : string);
  {-replace existing section or registry subkey}
  {Registry only: key being loaded must have been stored with SaveKey}
  {               "new" key does not take affect unti re-boot}
var
  DotPos    : Cardinal;
  PIFile,
  PSFile,
  PSKey     : PAnsiChar;
  ECode     : LongInt;

{$IFDEF WIN32}
  hToken    : THandle;
  ptp,
  tp        : TTokenPrivileges;
  luid      : TLargeInteger;
  retval    : DWORD;
{$ENDIF}

begin
  riMode := riSet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then begin
      if (FileExists(SaveFile)) then
        RaiseRegIniError(stscOutputFileExists);
      SaveKey(SubKey,SaveFile);
      LoadKey(SubKey,InputFile);
    end else begin
{$IFDEF WIN32}
      if (FileExists(SaveFile)) then
        RaiseRegIniError(stscOutputFileExists);
  {$IFOPT H+}
      if (HasExtensionL(SaveFile,DotPos)) OR
         (HasExtensionL(InputFile,DotPos)) then
        RaiseRegIniError(stscFileHasExtension);
  {$ELSE}
      if (HasExtensionS(SaveFile,DotPos)) OR
         (HasExtensionS(InputFile,DotPos)) then
        RaiseRegIniError(stscFileHasExtension);
  {$ENDIF}

      PIFile := nil;
      PSFile := nil;
      PSKey  := nil;
      try
        GetMem(PSKey,Length(SubKey)+1);
        GetMem(PIFile,Length(InputFile)+1);
        GetMem(PSFile,Length(SaveFile)+1);
        StrPCopy(PSKey,SubKey);
        StrPCopy(PIFile,InputFile);
        StrPCopy(PSFile,SaveFile);

        if (riWinVer = riWinNT) then begin
          OpenProcessToken(GetCurrentProcess(),
                           TOKEN_ADJUST_PRIVILEGES OR TOKEN_QUERY,
                           {$IFNDEF VERSION3}
                           @hToken);
                           {$ELSE}
                           hToken);
                           {$ENDIF}
          LookupPrivilegeValue(nil,'SeRestorePrivilege',luid);
          tp.PrivilegeCount     := 1;
          tp.Privileges[0].Luid := luid;
          tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;

          AdjustTokenPrivileges(hToken, FALSE, tp,
                                sizeOf(TTokenPrivileges),ptp,retval);
        end;

        if (riRemoteKey <> 0) then begin
          ECode := RegReplaceKey(riRemoteKey,PSKey,PIFile,PSFile);

          if (riWinVer = riWinNT) then
             AdjustTokenPrivileges(hToken,TRUE,tp,
                                   sizeOf(TTokenPrivileges),ptp,retval);
          if (ECode <> ERROR_SUCCESS) then
            RaiseRegIniErrorFmt(stscReplaceKeyFail,[ECode]);
        end else begin
          ECode := RegReplaceKey(riPrimaryKey,PSKey,PIFile,PSFile);
          if (riWinVer = riWinNT) then
             AdjustTokenPrivileges(hToken,TRUE,tp,
                                   sizeOf(TTokenPrivileges),ptp,retval);
          if (ECode <> ERROR_SUCCESS) then
            RaiseRegIniErrorFmt(stscReplaceKeyFail,[ECode]);
        end;
      finally
        if (PIFile <> nil) then
          FreeMem(PIFile,Length(InputFile)+1);
        if (PSFile <> nil) then
          FreeMem(PSFile,Length(SaveFile)+1);
        if (PSKey <> nil) then
          FreeMem(PSKey,Length(SubKey)+1);
      end;
{$ELSE}
      RaiseRegIniError(stscNo16bitSupport);
{$ENDIF}
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.RegOpenRemoteKey(CompName : string);
  {-open a registry subkey on a remote computer}
var
  PCName   : PAnsiChar;
  ECode    : LongInt;
begin
  riMode := riSet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then
      RaiseRegIniError(stscNoIniFileSupport)
    else begin
{$IFDEF WIN32}
      if (riRemoteKey <> 0) then
        RaiseRegIniError(stscRemoteKeyIsOpen);

      if (riPrimaryKey <> HKEY_LOCAL_MACHINE) AND
         (riPrimaryKey <> HKEY_USERS) then
        RaiseRegIniError(stscInvalidPKey);

      GetMem(PCName,Length(CompName)+1);
      try
        StrPCopy(PCName,CompName);
        ECode := Windows.RegConnectRegistry(PCName,riPrimaryKey,riRemoteKey);
        if (ECode <> ERROR_SUCCESS) then
          RaiseRegIniErrorFmt(stscConnectRemoteKeyFail,[ECode]);

        {store current primary key while remote key is open}
        if (riPrimaryKey <> riRemoteKey) then
          riHoldPrimary := riPrimaryKey;
        riPrimaryKey := riRemoteKey;

      finally
        FreeMem(PCName,Length(CompName)+1);
      end;
{$ELSE}
      RaiseRegIniError(stscNo16bitSupport);
{$ENDIF}
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.RegCloseRemoteKey;
  {-close a registry key on a remote computer}
var
  ECode   : LongInt;
begin
  riMode := riSet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then
      RaiseRegIniError(stscNoIniFileSupport)
    else begin
{$IFDEF WIN32}
      if (riRemoteKey <> 0) then begin
        ECode := RegCloseKey(riRemoteKey);
        if (ECode <> ERROR_SUCCESS) then
          RaiseRegIniErrorFmt(stscCloseRemoteKeyFail,[ECode]);
        riRemoteKey := 0;

        {reset primary key if opening remote key changed it}
        if riHoldPrimary <> 0 then begin
          riPrimaryKey := riHoldPrimary;
          riHoldPrimary := 0;
        end;
      end;
{$ELSE}
      RaiseRegIniError(stscNo16bitSupport);
{$ENDIF}
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

{$IFDEF WIN32}
procedure TStRegIni.RegGetKeySecurity(const SubKey : string; var SD : TSecurityDescriptor);
  {-get security attributes for key (WinNT only) }
var
  PSKey     : PAnsiChar;
  Key       : HKey;
  ECode     : LongInt;
  SDSize    : DWORD;
  SI        : SECURITY_INFORMATION;
  QI        : TQueryKeyInfo;

  hToken    : THandle;
  ptp,
  tp        : TTokenPrivileges;
  luid      : TLargeInteger;
  retval    : DWORD;

begin
  riMode := riSet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then
      RaiseRegIniError(stscNoIniFileSupport)
    else begin
      if (riWinVer <> riWinNT) then
        RaiseRegIniError(stscNotWinNTPlatform);

      QueryKey(QI);
      GetMem(PSKey,Length(SubKey)+1);
      try
        StrPCopy(PSKey,SubKey);

        Key := OpenRegKey;
        try
          SDSize := QI.QISDescLen;
          SI := OWNER_SECURITY_INFORMATION or
                GROUP_SECURITY_INFORMATION or
                DACL_SECURITY_INFORMATION  or
                SACL_SECURITY_INFORMATION;

          OpenProcessToken(GetCurrentProcess(),
                           TOKEN_ADJUST_PRIVILEGES OR TOKEN_QUERY,
                           {$IFNDEF VERSION3}
                           @hToken);
                           {$ELSE}
                           hToken);
                           {$ENDIF}
          LookupPrivilegeValue(nil,'SeSecurityPrivilege',luid);
          tp.PrivilegeCount     := 1;
          tp.Privileges[0].Luid := luid;
          tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;

          AdjustTokenPrivileges(hToken, FALSE, tp,
                                sizeOf(TTokenPrivileges),ptp,retval);
          ECode := Windows.RegGetKeySecurity(Key,SI,@SD,SDSize);

          AdjustTokenPrivileges(hToken,TRUE,tp,
                                sizeOf(TTokenPrivileges),ptp,retval);

          if (ECode <> ERROR_SUCCESS) then
            RaiseRegIniErrorFmt(stscGetSecurityFail,[ECode]);
        finally
          CloseRegKey(Key);
        end;
      finally
        FreeMem(PSKey,Length(SubKey)+1);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

{==========================================================================}

procedure TStRegIni.RegSetKeySecurity(const SubKey : string; SD : TSecurityDescriptor);
  {-set security attributes for a registry key (WinNT only) }
var
  PSKey     : PAnsiChar;
  Key       : HKey;
  ECode     : LongInt;
  SI        : SECURITY_INFORMATION;

  hToken    : THandle;
  ptp,
  tp        : TTokenPrivileges;
  luid      : TLargeInteger;
  retval    : DWORD;

begin
  riMode := riSet;
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if (riType = riIniType) then
      RaiseRegIniError(stscNoIniFileSupport)
    else begin
      if (riWinVer <> riWinNT) then
        RaiseRegIniError(stscNotWinNTPlatform);

      GetMem(PSKey,Length(SubKey)+1);
      try
        StrPCopy(PSKey,SubKey);
        Key := OpenRegKey;
        try
          SI := OWNER_SECURITY_INFORMATION or
                GROUP_SECURITY_INFORMATION or
                DACL_SECURITY_INFORMATION  or
                SACL_SECURITY_INFORMATION;

          OpenProcessToken(GetCurrentProcess(),
                           TOKEN_ADJUST_PRIVILEGES OR TOKEN_QUERY,
                           {$IFNDEF VERSION3}
                           @hToken);
                           {$ELSE}
                           hToken);
                           {$ENDIF}
          LookupPrivilegeValue(nil,'SeSecurityName',luid);
          tp.PrivilegeCount     := 1;
          tp.Privileges[0].Luid := luid;
          tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;

          AdjustTokenPrivileges(hToken, FALSE, tp,
                                sizeOf(TTokenPrivileges),ptp,retval);

          ECode := Windows.RegSetKeySecurity(Key,SI,@SD);

          AdjustTokenPrivileges(hToken,TRUE,tp,
                                sizeOf(TTokenPrivileges),ptp,retval);

          if (ECode <> ERROR_SUCCESS) then
            RaiseRegIniErrorFmt(stscSetSecurityFail,[ECode]);
        finally
          if (riRemoteKey = 0) then
            CloseRegKey(Key);
        end;
      finally
        FreeMem(PSKey,Length(SubKey)+1);
      end;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;
{$ENDIF}


end.