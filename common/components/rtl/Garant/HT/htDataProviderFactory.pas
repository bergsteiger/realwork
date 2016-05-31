unit htDataProviderFactory;

// Модуль: "w:\common\components\rtl\Garant\HT\htDataProviderFactory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "ThtDataProviderFactory" MUID: (54FEAD4402AB)

{$Include w:\common\components\rtl\Garant\HT\htDefineDA.inc}

interface

uses
 l3IntfUses
 , daDataProviderFactory
 , daDataProviderParams
 , daInterfaces
 , ddAppConfig
;

type
 ThtDataProviderFactory = class(TdaDataProviderFactory)
  public
   class function Key: AnsiString; override;
   function MakeFromConfig: TdaDataProviderParams; override;
   procedure SaveToConfig(aParams: TdaDataProviderParams); override;
   function ParamType: TdaDataProviderParamsClass; override;
   procedure FillOutConfig(aConfig: TddAppConfiguration;
    aEtalon: TdaDataProviderParams;
    out aParams: TdaDataProviderParams); override;
   procedure FillInConfig(aConfig: TddAppConfiguration;
    aParams: TdaDataProviderParams;
    ForInfoOnly: Boolean = False); override;
   procedure BuildConfig(aConfig: TddAppConfiguration;
    const aProviderKey: AnsiString = '';
    ForInfoOnly: Boolean = False); override;
   procedure LoadDBVersion(aParams: TdaDataProviderParams); override;
   function DoMakeProvider(aParams: TdaDataProviderParams;
    ForCheckLogin: Boolean;
    AllowClearLocks: Boolean;
    SetGlobalProvider: Boolean = True): IdaDataProvider; override;
   procedure LoginCheckSucceed(aParams: TdaDataProviderParams); override;
   procedure CorrectByClient(aParams: TdaDataProviderParams); override;
   function IsParamsValid(aParams: TdaDataProviderParams;
    Quiet: Boolean = False): Boolean; override;
 end;//ThtDataProviderFactory

implementation

uses
 l3ImplUses
 , htDataProviderParams
 , htInterfaces
 , ddUtils
 , SysUtils
 , l3Base
 , ddAppConfigStrings
 , l3IniFile
 , l3FileUtils
 , StrUtils
 , htDataProvider
 , ddAppConfigTypes
;

class function ThtDataProviderFactory.Key: AnsiString;
//#UC START# *54F8635B023E_54FEAD4402AB_var*
//#UC END# *54F8635B023E_54FEAD4402AB_var*
begin
//#UC START# *54F8635B023E_54FEAD4402AB_impl*
 Result := 'HyTech';
//#UC END# *54F8635B023E_54FEAD4402AB_impl*
end;//ThtDataProviderFactory.Key

function ThtDataProviderFactory.MakeFromConfig: TdaDataProviderParams;
//#UC START# *54FEB57302B0_54FEAD4402AB_var*
var
 l_Storage: IhtParamsStorage;
//#UC END# *54FEB57302B0_54FEAD4402AB_var*
begin
//#UC START# *54FEB57302B0_54FEAD4402AB_impl*
 Result := ThtDataProviderParams.Create;

 LoadCommonParams(Result);

 l_Storage := ParamsStorage as IhtParamsStorage;
 try
  ThtDataProviderParams(Result).StationName := l_Storage.StationName; // Invalid
  ThtDataProviderParams(Result).TablePath := l_Storage.TablePath; // Инвалид
  ThtDataProviderParams(Result).LockPath := l_Storage.LockPath; // Инвалид
  // Assert(LockPath <> TablePath);
  ThtDataProviderParams(Result).TmpDirPath := l_Storage.TempPath; // Инвалид
 finally
  l_Storage := nil;
 end;
//#UC END# *54FEB57302B0_54FEAD4402AB_impl*
end;//ThtDataProviderFactory.MakeFromConfig

procedure ThtDataProviderFactory.SaveToConfig(aParams: TdaDataProviderParams);
//#UC START# *550AAD0101F9_54FEAD4402AB_var*
var
 l_Storage: IhtParamsStorage;
//#UC END# *550AAD0101F9_54FEAD4402AB_var*
begin
//#UC START# *550AAD0101F9_54FEAD4402AB_impl*
 Assert(aParams is ThtDataProviderParams);

 SaveCommonParams(aParams);

 l_Storage := ParamsStorage as IhtParamsStorage;
 try
  l_Storage.TablePath := ThtDataProviderParams(aParams).TablePath;
  l_Storage.LockPath := ThtDataProviderParams(aParams).LockPath;
  l_Storage.TempPath := ThtDataProviderParams(aParams).TmpDirPath;
 finally
  l_Storage := nil;
 end;
//#UC END# *550AAD0101F9_54FEAD4402AB_impl*
end;//ThtDataProviderFactory.SaveToConfig

function ThtDataProviderFactory.ParamType: TdaDataProviderParamsClass;
//#UC START# *550FD49301BF_54FEAD4402AB_var*
//#UC END# *550FD49301BF_54FEAD4402AB_var*
begin
//#UC START# *550FD49301BF_54FEAD4402AB_impl*
 Result := ThtDataProviderParams
//#UC END# *550FD49301BF_54FEAD4402AB_impl*
end;//ThtDataProviderFactory.ParamType

procedure ThtDataProviderFactory.FillOutConfig(aConfig: TddAppConfiguration;
 aEtalon: TdaDataProviderParams;
 out aParams: TdaDataProviderParams);
//#UC START# *5512BAB20128_54FEAD4402AB_var*
//#UC END# *5512BAB20128_54FEAD4402AB_var*
begin
//#UC START# *5512BAB20128_54FEAD4402AB_impl*
 if ParamsStorage.OuterConfigEdit then
  aParams := MakeFromConfig
 else
 begin
  aParams := ThtDataProviderParams.Create;
  aParams.AssignParams(aEtalon);
  with aConfig do
  begin
   aParams.Login := AsString['Login'];
   aParams.Password := AsString['Password'];
   if aConfig.IsChanged['BaseRoot'] and (aConfig.AsString['BaseRoot'] <> aParams.DocStoragePath) then
   begin
    aParams.ChangeBasePath(aConfig.AsString['BaseRoot']);
   end; 
  end;
 end;
//#UC END# *5512BAB20128_54FEAD4402AB_impl*
end;//ThtDataProviderFactory.FillOutConfig

procedure ThtDataProviderFactory.FillInConfig(aConfig: TddAppConfiguration;
 aParams: TdaDataProviderParams;
 ForInfoOnly: Boolean = False);
//#UC START# *5512BB030346_54FEAD4402AB_var*
//#UC END# *5512BB030346_54FEAD4402AB_var*
begin
//#UC START# *5512BB030346_54FEAD4402AB_impl*
 if ParamsStorage.OuterConfigEdit then
  Exit;
 with aConfig do
 begin
  if ForInfoOnly then
  begin
   AsString['Login'] := aParams.Login;
   AsString['BaseRoot'] := aParams.DocStoragePath;
   AsString['htHomePath'] := aParams.FullHomeDirPath;
  end
  else
  begin
   AsString['Login'] := aParams.Login;
   AsString['Password'] := aParams.Password;
   AsString['BaseRoot'] := aParams.DocStoragePath;
  end;
 end;
//#UC END# *5512BB030346_54FEAD4402AB_impl*
end;//ThtDataProviderFactory.FillInConfig

procedure ThtDataProviderFactory.BuildConfig(aConfig: TddAppConfiguration;
 const aProviderKey: AnsiString = '';
 ForInfoOnly: Boolean = False);
//#UC START# *5512BB1F023F_54FEAD4402AB_var*
var
 l_Item: TddBaseConfigItem;
//#UC END# *5512BB1F023F_54FEAD4402AB_var*
begin
//#UC START# *5512BB1F023F_54FEAD4402AB_impl*
 if ParamsStorage.OuterConfigEdit then
  ParamsStorage.BuildConfig(aConfig, Key)
 else
 begin
  if ForInfoOnly then
  begin
   l_Item := aConfig.AddFolderNameItem('BaseRoot', 'База документов');
   l_Item.ReadOnly := True;
   l_Item := aConfig.AddFolderNameItem('htHomePath', 'Домашний каталог');
   l_Item.ReadOnly := True;
  end
  else
  begin
   aConfig.AddFolderNameItem('BaseRoot', 'База документов');
  end;
 end;
//#UC END# *5512BB1F023F_54FEAD4402AB_impl*
end;//ThtDataProviderFactory.BuildConfig

procedure ThtDataProviderFactory.LoadDBVersion(aParams: TdaDataProviderParams);
//#UC START# *551904FC039A_54FEAD4402AB_var*
var
 l_BaseIni: TCfgList;
 l_BaseIniPath: AnsiString;
 l_DbPath: AnsiString;
{$IFDEF TestDb}
 l_PathToFlagFile : AnsiString;
{$EndIF TestDb}
//#UC END# *551904FC039A_54FEAD4402AB_var*
begin
//#UC START# *551904FC039A_54FEAD4402AB_impl*
 Assert(aParams is ThtDataProviderParams);
 if DirectoryExists(aParams.DocStoragePath) and DirectoryExists(ThtDataProviderParams(aParams).TablePath) then
 begin
  l_BaseIni := aParams.MakeBaseIni;
  try
   l_BaseIni.Section:= 'Tables';
   aParams.DocBaseVersion := l_BaseIni.ReadParamIntDef('Version', c_BadVersion);
  finally
   l_BaseIni.Free;
  end;

  l_DbPath := NormalizedPath(ThtDataProviderParams(aParams).TablePath);
  if l_DbPath = '' then
   raise Exception.Create('Не указано расположение БД (админ.)');

  l_BaseIniPath := ConcatDirName(l_DbPath, 'base.ini');
  if not FileExists(l_BaseIniPath) then
   raise Exception.Create('Не найден файл ' + l_BaseIniPath);

  l_BaseIni := TCfgList.Create(l_BaseIniPath);
  try
   l_BaseIni.Section:= 'Tables';
   aParams.AdminBaseVersion := l_BaseIni.ReadParamIntDef('Version', c_BadVersion);
  finally
   l_BaseIni.Free;
  end;
 end // DirectoryExists(DocBaseFolder) and DirectoryExists(AdminBaseFolder)
 else
  l3System.Msg2Log('Не найдена папка %s', [IfThen(DirectoryExists(aParams.DocStoragePath), ThtDataProviderParams(aParams).TablePath, aParams.DocStoragePath)])
//#UC END# *551904FC039A_54FEAD4402AB_impl*
end;//ThtDataProviderFactory.LoadDBVersion

function ThtDataProviderFactory.DoMakeProvider(aParams: TdaDataProviderParams;
 ForCheckLogin: Boolean;
 AllowClearLocks: Boolean;
 SetGlobalProvider: Boolean = True): IdaDataProvider;
//#UC START# *551D06D402AF_54FEAD4402AB_var*
//#UC END# *551D06D402AF_54FEAD4402AB_var*
begin
//#UC START# *551D06D402AF_54FEAD4402AB_impl*
 Assert(aParams is ThtDataProviderParams);
 Result := ThtDataProvider.Make(ThtDataProviderParams(aParams), ForCheckLogin, AllowClearLocks, SetGlobalProvider);
//#UC END# *551D06D402AF_54FEAD4402AB_impl*
end;//ThtDataProviderFactory.DoMakeProvider

procedure ThtDataProviderFactory.LoginCheckSucceed(aParams: TdaDataProviderParams);
//#UC START# *55D706D201C3_54FEAD4402AB_var*
//#UC END# *55D706D201C3_54FEAD4402AB_var*
begin
//#UC START# *55D706D201C3_54FEAD4402AB_impl*
 if (ThtDataProviderParams(aParams).StationName = '') and (aParams.UserId > 0) then
  ThtDataProviderParams(aParams).StationName := IntToHex(aParams.UserId, 8);
//#UC END# *55D706D201C3_54FEAD4402AB_impl*
end;//ThtDataProviderFactory.LoginCheckSucceed

procedure ThtDataProviderFactory.CorrectByClient(aParams: TdaDataProviderParams);
//#UC START# *55110FBB00E5_54FEAD4402AB_var*
var
 l_Storage: IhtParamsStorage;
//#UC END# *55110FBB00E5_54FEAD4402AB_var*
begin
//#UC START# *55110FBB00E5_54FEAD4402AB_impl*
 l_Storage := ParamsStorage as IhtParamsStorage;
 try
  ThtDataProviderParams(aParams).StationName := l_Storage.StationName;
  ThtDataProviderParams(aParams).TmpDirPath := l_Storage.TempPath;
  if ThtDataProviderParams(aParams).TmpDirPath = '' then
   ThtDataProviderParams(aParams).TmpDirPath := GetWindowsTempFolder;
  if (ThtDataProviderParams(aParams).StationName = '') and (aParams.UserId > 0) then
   ThtDataProviderParams(aParams).StationName := IntToHex(aParams.UserId, 8);
 finally
  l_Storage := nil;
 end;
//#UC END# *55110FBB00E5_54FEAD4402AB_impl*
end;//ThtDataProviderFactory.CorrectByClient

function ThtDataProviderFactory.IsParamsValid(aParams: TdaDataProviderParams;
 Quiet: Boolean = False): Boolean;
//#UC START# *551166B40046_54FEAD4402AB_var*
var
 l_Storage: IhtParamsStorage;
 l_Result: Boolean;

const
 ddMinTempSpace = 10000000; // 10 Mb

 function lp_CheckTempFolder(const aPath : AnsiString; aMinFreeSpace: Int64): Boolean;
 var
  lMsg : AnsiString;
  l_Free: Int64;
  l_Total: Int64;
 begin
  if GetDiskFreeSpaceEx(PAnsiChar(IncludeTrailingBackslash(aPath)), l_Free, l_Total, nil) then
  begin
   Result := l_Free > aMinFreeSpace;
   if not Result then
   begin
    lMsg := Format('На диске %s необходимо освободить минимум %s',
                   [ExtractFileDrive(aPath), Bytes2Str(aMinFreeSpace - l_Free)]);
    l3System.Msg2Log(lMsg);
   end; 
  end
  else
   Result := False;
 end;

//#UC END# *551166B40046_54FEAD4402AB_var*
begin
//#UC START# *551166B40046_54FEAD4402AB_impl*
 l_Result := inherited IsParamsValid(aParams);
 Result := False;

 l_Storage := ParamsStorage as IhtParamsStorage;
 try

  if not Quiet and (ThtDataProviderParams(aParams).StationName = '') then
  begin
   if not Quiet then
    l3System.Msg2Log(l_Storage.StationErrorMessage);
   Exit;
  end;

  if ThtDataProviderParams(aParams).TablePath = '' then
  begin
   if not Quiet then
    l3System.Msg2Log(l_Storage.TablePathErrorMessage);
   Exit;
  end;

  if ThtDataProviderParams(aParams).LockPath = '' then
  begin
   if not Quiet then
    l3System.Msg2Log(l_Storage.LockPathErrorMessage);
   Exit;
  end;

 finally
  l_Storage := nil;
 end;

 If (AnsiCompareFileName(ThtDataProviderParams(aParams).LockPath, ThtDataProviderParams(aParams).TablePath) = 0) then
 begin
  if not Quiet then
   l3System.Msg2Log('Недопустимый путь к разделяемым ресурсам! Параметр LockPath = TablePath.');
  Exit;
 end;

 if not Quiet then
 begin
  if ThtDataProviderParams(aParams).TmpDirPath = '' then
   Exit;

  if not lp_CheckTempFolder(ThtDataProviderParams(aParams).TmpDirPath, ddMinTempSpace) then
   Exit;
 end;

 Result := l_Result;
//#UC END# *551166B40046_54FEAD4402AB_impl*
end;//ThtDataProviderFactory.IsParamsValid

end.
