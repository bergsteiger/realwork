unit ddBaseEngine;

interface

{$Include l3XE.inc}

uses
 classes,
 l3Base,
 ddAppConfig, ddAppConfigTypes, 
 IdGlobal, l3ProtoObject, daInterfaces, daDataProviderParams,
 SyncObjs
 ;

type
 TBaseEngine = class(Tl3ProtoObject)
 private
  f_BaseLockCount: Integer;
  f_Started: Boolean;
  f_StationName: AnsiString;
  f_Guard: TCriticalSection;
  f_DataParams: TdaDataProviderParams;
  f_DataProvider: IdaDataProvider;
  function LockFileName: AnsiString;
  function pm_GetIsStarted: Boolean;
  function pm_GetLogin: AnsiString;
  function pm_GetPassword: AnsiString;
  function pm_GetStationName : AnsiString;
  procedure pm_SetDataParams(const Value: TdaDataProviderParams);
 protected
  function pm_GetServerHostName: AnsiString; virtual; abstract;
  function pm_GetServerPort: Integer; virtual; abstract;
  function pm_GetWorkWithServer: Boolean; virtual; abstract;
  procedure Cleanup; override;
  procedure CreateCommunications; virtual; abstract;
  function DoStart: Boolean; virtual; abstract;
  procedure DoStop; virtual; abstract;
  procedure CreateDataProvider;
  procedure DestroyDataProvider;
  function AllowClearLocks : Boolean; virtual;
  property Guard: TCriticalSection read f_Guard;
 public
  constructor Create(aDataParams: TdaDataProviderParams);
  function GetFamilyPath(aFamily: Integer): AnsiString;
  function IsBaseLocked: Boolean; overload;
  function IsBaseLocked(var aMsg: AnsiString): Boolean; overload; virtual;
  function LockBase: Boolean; overload;
  function LockBase(const aMsg: AnsiString): Boolean; overload;
  function LockBase(aMsg: AnsiString; const aStartLock, aStopLock: TDateTime): Boolean; overload;
  function NeverExpireDate: TDateTime;
  procedure Stop;
  function Start: Boolean;
  procedure UnlockBase;
  property IsStarted: Boolean read pm_GetIsStarted;
  property Login: AnsiString read pm_GetLogin;// write pm_SetLogin;
  property Password: AnsiString read pm_GetPassword; // write pm_SetPassword;
  property ServerHostName: AnsiString read pm_GetServerHostName; // write pm_SetServerHostName;
  property ServerPort: Integer read pm_GetServerPort; // write pm_SetServerPort;
  property WorkWithServer: Boolean read pm_GetWorkWithServer;// write pm_SetWorkWithServer;
  property StationName: AnsiString read pm_GetStationName;
  property DataParams: TdaDataProviderParams read f_DataParams write pm_SetDataParams;
  property DataProvider: IdaDataProvider read f_DataProvider;
 end;

implementation

Uses
 Types,
 SysUtils,
 DateUtils,
 StrUtils,
 Math,

 l3FileUtils,
 l3IniFile,

 daDataProviderSuperFactory,
 daSchemeConsts,

 dt_Const,
 dt_Serv,
 dt_DocImages,
 dt_UserConst,

 htDataProviderParams,

 afwFacade,
 Base_CFG,

 ddAppConfigStrings,
 m3StorageHolderList
 ;

const
 dd_LockSection    = 'LockInfo';
 dd_Message        = 'Message';
 dd_ExpireDate     = 'ExpireDate';
 dd_StartDate      = 'StartDate';
 dd_DefaultMessage = 'База используется в монопольном режиме';
 ddLockFileName = 'lock.txt';
 


constructor TBaseEngine.Create(aDataParams: TdaDataProviderParams);
begin
 inherited Create;
 aDataParams.SetRefTo(f_DataParams);
 Assert(Assigned(f_DataParams));
 f_Started := False;
 f_Guard := TCriticalSection.Create;
 f_BaseLockCount := 0;
 CreateCommunications;
 f_DataParams.CorrectAfterSet;
end;

procedure TBaseEngine.Cleanup;
begin
 Stop;
 l3Free(f_Guard);
 l3Free(f_DataParams);
 inherited;
end;

function TBaseEngine.GetFamilyPath(aFamily: Integer): AnsiString;
begin
 Result := IfThen(aFamily = 0, (DataParams as ThtDataProviderParams).TablePath, ConcatDirName(DataParams.DocStoragePath, 'garant'));
end;

function TBaseEngine.IsBaseLocked: Boolean;
var
  l_S: AnsiString;
begin
 if IsStarted then
  Result:= IsBaseLocked(l_S)
 else
  Result:= True;
end;

function TBaseEngine.IsBaseLocked(var aMsg: AnsiString): Boolean;
var
 l_StartDate,
 l_ExpireDate: TDateTime;
begin
 if FileExists(LockFileName) then
 begin
  try
   with TCfgList.Create(LockFileName)do
   try
    Section:= dd_LockSection;
    aMsg:= ReadParamStrDef(dd_Message, dd_DefaultMessage);
    l_StartDate:= ReadParamDateTimeDef(dd_StartDate, 0);
    l_ExpireDate:= ReadParamDateTimeDef(dd_ExpireDate, NeverExpireDate);
    if CompareDateTime(l_ExpireDate, NeverExpireDate) = EqualsValue then
     aMsg:= aMsg + #10 + 'Базу должен открыть администратор системы.'
    else
     aMsg:= aMsg + #10 + FormatDateTime('База закрыта до hh:nn:ss dd mmm yyyy', l_ExpireDate);
   finally
    Free;
   end; // try..finally
   if CompareDateTime(Now, l_StartDate) = GreaterThanValue then
   begin
    if CompareDateTime(Now, l_ExpireDate) <> GreaterThanValue then
      Result:= True
    else
    begin
      Result:= False;
      UnlockBase;
    end;
   end
   else
    Result:= False;
  except
   Result:= False;
  end;
 end
 else
  Result:= False;
 if Result and (f_BaseLockCount = 0) then
  Inc(f_BaseLockCount);
end;

function TBaseEngine.LockBase: Boolean;
begin
  Result:= LockBase(dd_DefaultMessage, Now, NeverExpireDate);
end;

function TBaseEngine.LockBase(const aMsg: AnsiString): Boolean;
begin
  Result:= LockBase(aMsg, Now, NeverExpireDate);
end;

function TBaseEngine.LockBase(aMsg: AnsiString; const aStartLock, aStopLock: TDateTime): Boolean;
begin
 Tm3StorageHolderList.DropAll;
 if not FileExists(LockFileName) then
 try
  with TCfgList.Create(LockFileName)do
  try
   Section:= dd_LockSection;
   if aMsg = '' then aMsg:= dd_DefaultMessage;
   WriteParamStr(dd_Message, aMsg);
   WriteParamDateTime(dd_StartDate, aStartLock);
   if CompareDateTime(Now, aStopLock) = LessThanValue then
    WriteParamDateTime(dd_ExpireDate, aStopLock)
   else
    WriteParamDateTime(dd_ExpireDate, NeverExpireDate);
   Result:= True;
  finally
   Free;
  end; // try..finally
 except
  Result:= False;
 end;
 Inc(f_BaseLockCount);
end;

function TBaseEngine.LockFileName: AnsiString;
begin
  Result:= ConcatDirName(DataParams.DocStoragePath, ddLockFileName);
end;

function TBaseEngine.NeverExpireDate: TDateTime;
begin
  Result:= EncodeDateTime(9999, 1, 1, 0, 0, 0, 0);
end;

function TBaseEngine.pm_GetIsStarted: Boolean;
begin
 Result := (GlobalHtServer <> nil) and f_Started;
end;

function TBaseEngine.pm_GetLogin: AnsiString;
begin
 Result := DataParams.Login;
// Result := f_Config.AsString['Login'];
end;

function TBaseEngine.pm_GetPassword: AnsiString;
begin
 Result := DataParams.Password;
// Result := f_Config.AsString['Password'];
end;

function TBaseEngine.pm_GetStationName : AnsiString;
begin
 Result := (f_DataParams as ThtDataProviderParams).StationName;
end;

function TBaseEngine.Start: Boolean;
begin
 if IsStarted then
  Result:= True
 else
 begin
  Result:= DoStart;
  if Result then
  begin
   if DataProvider.UserID <> usSupervisor then
    InitUserConfig(ConcatDirName(DataProvider.CurHomePath, 'user.ini'))
   else
    DoneUserConfig;
   InitBaseConfig(CurrentFamily);
   f_Started:= True;
  end;
 end;
end;

procedure TBaseEngine.Stop;
begin
 DoStop;
 DestroyDataProvider;
 DoneUserConfig;
end;

procedure TBaseEngine.UnlockBase;
begin
 Dec(f_BaseLockCount);
 if FileExists(LockFileName) and (f_BaseLockCount <= 0) then
  DeleteFile(LockFileName);
end;

procedure TBaseEngine.pm_SetDataParams(const Value: TdaDataProviderParams);
begin
 Value.SetRefTo(f_DataParams);
 f_DataParams.CorrectAfterSet;
end;

procedure TBaseEngine.CreateDataProvider;
begin
 f_DataProvider := TdaDataProviderSuperFactory.Instance.MakeProvider(DataParams, AllowClearLocks);
 f_DataProvider.Start;
end;

procedure TBaseEngine.DestroyDataProvider;
begin
 if Assigned(f_DataProvider) then
  f_DataProvider.Stop;
 f_DataProvider := nil;
end;

function TBaseEngine.AllowClearLocks: Boolean;
begin
 Result := True;
end;

end.
