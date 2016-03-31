unit pgDataProviderFactory;

// Модуль: "w:\common\components\rtl\Garant\PG\pgDataProviderFactory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TpgDataProviderFactory" MUID: (55D6E2FB025D)

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , daDataProviderFactory
 , daDataProviderParams
 , ddAppConfig
 , daInterfaces
;

type
 TpgDataProviderFactory = class(TdaDataProviderFactory)
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
 end;//TpgDataProviderFactory
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , pgDataProviderParams
 , pgDataProvider
 , pgInterfaces
 , ddAppConfigTypes
 , l3Base
 , SysUtils
 , l3IniFile
 , l3FileUtils
;

class function TpgDataProviderFactory.Key: AnsiString;
//#UC START# *54F8635B023E_55D6E2FB025D_var*
//#UC END# *54F8635B023E_55D6E2FB025D_var*
begin
//#UC START# *54F8635B023E_55D6E2FB025D_impl*
 Result := 'Postgress';
//#UC END# *54F8635B023E_55D6E2FB025D_impl*
end;//TpgDataProviderFactory.Key

function TpgDataProviderFactory.MakeFromConfig: TdaDataProviderParams;
//#UC START# *54FEB57302B0_55D6E2FB025D_var*
var
 l_Storage: IpgParamsStorage;
//#UC END# *54FEB57302B0_55D6E2FB025D_var*
begin
//#UC START# *54FEB57302B0_55D6E2FB025D_impl*
 Result := TpgDataProviderParams.Create;

 LoadCommonParams(Result);

 l_Storage := ParamsStorage as IpgParamsStorage;
 try
  TpgDataProviderParams(Result).DataServerHostName := l_Storage.DataServerHostName; // Invalid
  TpgDataProviderParams(Result).DataServerPort := l_Storage.DataServerPort; // Инвалид
 finally
  l_Storage := nil;
 end;
//#UC END# *54FEB57302B0_55D6E2FB025D_impl*
end;//TpgDataProviderFactory.MakeFromConfig

procedure TpgDataProviderFactory.SaveToConfig(aParams: TdaDataProviderParams);
//#UC START# *550AAD0101F9_55D6E2FB025D_var*
var
 l_Storage: IpgParamsStorage;
//#UC END# *550AAD0101F9_55D6E2FB025D_var*
begin
//#UC START# *550AAD0101F9_55D6E2FB025D_impl*
 Assert(aParams is TpgDataProviderParams);

 SaveCommonParams(aParams);

 l_Storage := ParamsStorage as IpgParamsStorage;
 try
  l_Storage.DataServerHostName := TpgDataProviderParams(aParams).DataServerHostName;
  l_Storage.DataServerPort := TpgDataProviderParams(aParams).DataServerPort;
 finally
  l_Storage := nil;
 end;
//#UC END# *550AAD0101F9_55D6E2FB025D_impl*
end;//TpgDataProviderFactory.SaveToConfig

function TpgDataProviderFactory.ParamType: TdaDataProviderParamsClass;
//#UC START# *550FD49301BF_55D6E2FB025D_var*
//#UC END# *550FD49301BF_55D6E2FB025D_var*
begin
//#UC START# *550FD49301BF_55D6E2FB025D_impl*
 Result := TpgDataProviderParams;
//#UC END# *550FD49301BF_55D6E2FB025D_impl*
end;//TpgDataProviderFactory.ParamType

procedure TpgDataProviderFactory.FillOutConfig(aConfig: TddAppConfiguration;
 aEtalon: TdaDataProviderParams;
 out aParams: TdaDataProviderParams);
//#UC START# *5512BAB20128_55D6E2FB025D_var*
//#UC END# *5512BAB20128_55D6E2FB025D_var*
begin
//#UC START# *5512BAB20128_55D6E2FB025D_impl*
 if ParamsStorage.OuterConfigEdit then
  aParams := MakeFromConfig
 else
 begin
  aParams := TpgDataProviderParams.Create;
  aParams.AssignParams(aEtalon);
  with aConfig do
  begin
   aParams.Login := AsString['Login'];
   aParams.Password := AsString['Password'];
   TpgDataProviderParams(aParams).DataServerHostName := AsString['DataServerHostName'];
   TpgDataProviderParams(aParams).DataServerPort := AsInteger['DataServerPort'];
  end;
 end;
//#UC END# *5512BAB20128_55D6E2FB025D_impl*
end;//TpgDataProviderFactory.FillOutConfig

procedure TpgDataProviderFactory.FillInConfig(aConfig: TddAppConfiguration;
 aParams: TdaDataProviderParams;
 ForInfoOnly: Boolean = False);
//#UC START# *5512BB030346_55D6E2FB025D_var*
var
 l_Params: TpgDataProviderParams;
//#UC END# *5512BB030346_55D6E2FB025D_var*
begin
//#UC START# *5512BB030346_55D6E2FB025D_impl*
 if ParamsStorage.OuterConfigEdit then
  Exit;

 Assert(aParams is TpgDataProviderParams);
 l_Params :=  aParams as TpgDataProviderParams;

 with aConfig do
 begin
  if ForInfoOnly then
  begin
   AsString['DataConnectParams'] := Format('%s:%d', [l_Params.DataServerHostName, l_Params.DataServerPort]);
  end
  else
  begin
   AsString['DataServerHostName'] := l_Params.DataServerHostName;
   AsInteger['DataServerPort'] := l_Params.DataServerPort;
  end;
 end;
//#UC END# *5512BB030346_55D6E2FB025D_impl*
end;//TpgDataProviderFactory.FillInConfig

procedure TpgDataProviderFactory.BuildConfig(aConfig: TddAppConfiguration;
 const aProviderKey: AnsiString = '';
 ForInfoOnly: Boolean = False);
//#UC START# *5512BB1F023F_55D6E2FB025D_var*
var
 l_Item: TddBaseConfigItem;
//#UC END# *5512BB1F023F_55D6E2FB025D_var*
begin
//#UC START# *5512BB1F023F_55D6E2FB025D_impl*
 if ParamsStorage.OuterConfigEdit then
  ParamsStorage.BuildConfig(aConfig, Key)
 else
 begin
  if ForInfoOnly then
  begin
   l_Item := aConfig.AddStringItem('DataConnectParams', 'Подключено');
    aConfig.Hint:= 'Параметры подключения к Серверу БД';
    l_Item.ReadOnly := True;
  end
  else
  begin
   aConfig.AddStringItem('DataServerHostName', 'Адрес сервера БД', '');
   aConfig.AddIntegerItem(l3CStr('DataServerPort'), l3CStr('Порт сервера БД'), c_DefaultPostgresPort);
  end;
 end;
//#UC END# *5512BB1F023F_55D6E2FB025D_impl*
end;//TpgDataProviderFactory.BuildConfig

procedure TpgDataProviderFactory.LoadDBVersion(aParams: TdaDataProviderParams);
//#UC START# *551904FC039A_55D6E2FB025D_var*
var
 l_BaseIni: TCfgList;
//#UC END# *551904FC039A_55D6E2FB025D_var*
begin
//#UC START# *551904FC039A_55D6E2FB025D_impl*
 l_BaseIni := aParams.MakeBaseIni;
 try
  l_BaseIni.Section:= 'Tables';
  aParams.DocBaseVersion := l_BaseIni.ReadParamIntDef('Version', c_BadVersion);
  aParams.AdminBaseVersion := aParams.DocBaseVersion;
 finally
  FreeAndNil(l_BaseIni);
 end;
//#UC END# *551904FC039A_55D6E2FB025D_impl*
end;//TpgDataProviderFactory.LoadDBVersion

function TpgDataProviderFactory.DoMakeProvider(aParams: TdaDataProviderParams;
 ForCheckLogin: Boolean;
 AllowClearLocks: Boolean;
 SetGlobalProvider: Boolean = True): IdaDataProvider;
//#UC START# *551D06D402AF_55D6E2FB025D_var*
//#UC END# *551D06D402AF_55D6E2FB025D_var*
begin
//#UC START# *551D06D402AF_55D6E2FB025D_impl*
 Assert(aParams is TpgDataProviderParams);
 Result := TpgDataProvider.Make(TpgDataProviderParams(aParams), ForCheckLogin, AllowClearLocks, SetGlobalProvider);
//#UC END# *551D06D402AF_55D6E2FB025D_impl*
end;//TpgDataProviderFactory.DoMakeProvider

procedure TpgDataProviderFactory.LoginCheckSucceed(aParams: TdaDataProviderParams);
//#UC START# *55D706D201C3_55D6E2FB025D_var*
//#UC END# *55D706D201C3_55D6E2FB025D_var*
begin
//#UC START# *55D706D201C3_55D6E2FB025D_impl*
// Do nothing
//#UC END# *55D706D201C3_55D6E2FB025D_impl*
end;//TpgDataProviderFactory.LoginCheckSucceed

procedure TpgDataProviderFactory.CorrectByClient(aParams: TdaDataProviderParams);
//#UC START# *55110FBB00E5_55D6E2FB025D_var*
var
 l_Storage: IpgParamsStorage;
//#UC END# *55110FBB00E5_55D6E2FB025D_var*
begin
//#UC START# *55110FBB00E5_55D6E2FB025D_impl*
 Exit;
 l_Storage := ParamsStorage as IpgParamsStorage;
 try
  TpgDataProviderParams(aParams).DataServerHostName := l_Storage.DataServerHostName;
  TpgDataProviderParams(aParams).DataServerPort := l_Storage.DataServerPort;
 finally
  l_Storage := nil;
 end;
//#UC END# *55110FBB00E5_55D6E2FB025D_impl*
end;//TpgDataProviderFactory.CorrectByClient

function TpgDataProviderFactory.IsParamsValid(aParams: TdaDataProviderParams;
 Quiet: Boolean = False): Boolean;
//#UC START# *551166B40046_55D6E2FB025D_var*
var
 l_Result: Boolean;
 l_Storage: IpgParamsStorage;
//#UC END# *551166B40046_55D6E2FB025D_var*
begin
//#UC START# *551166B40046_55D6E2FB025D_impl*
 l_Result := inherited IsParamsValid(aParams);

 Result := False;

 if TpgDataProviderParams(aParams).DataServerHostName = '' then
 begin
  if not Quiet then
   l3System.Msg2Log('Не задан сервер БД!');
  Exit;
 end;

 Result := l_Result;
//#UC END# *551166B40046_55D6E2FB025D_impl*
end;//TpgDataProviderFactory.IsParamsValid
{$IfEnd} // Defined(UsePostgres)

end.
