unit caDataProviderFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ComboAccess"
// Модуль: "w:/common/components/rtl/Garant/ComboAccess/caDataProviderFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::ComboAccess::Provider::TcaDataProviderFactory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\ComboAccess\caDefine.inc}

interface

{$If defined(TestComboAccess) AND defined(UsePostgres)}
uses
  daDataProviderFactory,
  htDataProviderFactory,
  pgDataProviderFactory,
  daDataProviderParams,
  ddAppConfig,
  daInterfaces
  ;
{$IfEnd} //TestComboAccess AND UsePostgres

{$If defined(TestComboAccess) AND defined(UsePostgres)}
type
 TcaDataProviderFactory = class(TdaDataProviderFactory)
 private
 // private fields
   f_HTFactory : ThtDataProviderFactory;
   f_PGFactory : TpgDataProviderFactory;
 protected
 // realized methods
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
 public
 // realized methods
   class function Key: AnsiString; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aHTFactory: ThtDataProviderFactory;
     aPGFactory: TpgDataProviderFactory); reintroduce;
 end;//TcaDataProviderFactory
{$IfEnd} //TestComboAccess AND UsePostgres

implementation

{$If defined(TestComboAccess) AND defined(UsePostgres)}
uses
  caDataProviderParams,
  caDataProvider,
  SysUtils,
  htDataProviderParams,
  pgDataProviderParams,
  ddAppConfigTypes,
  l3Base,
  pgInterfaces
  ;
{$IfEnd} //TestComboAccess AND UsePostgres

{$If defined(TestComboAccess) AND defined(UsePostgres)}

// start class TcaDataProviderFactory

constructor TcaDataProviderFactory.Create(aHTFactory: ThtDataProviderFactory;
  aPGFactory: TpgDataProviderFactory);
//#UC START# *56AB24FB0037_56A86C020121_var*
//#UC END# *56AB24FB0037_56A86C020121_var*
begin
//#UC START# *56AB24FB0037_56A86C020121_impl*
 inherited Create;
 aHTFactory.SetRefTo(f_HTFactory);
 aPGFactory.SetRefTo(f_PGFactory);
//#UC END# *56AB24FB0037_56A86C020121_impl*
end;//TcaDataProviderFactory.Create

class function TcaDataProviderFactory.Key: AnsiString;
//#UC START# *54F8635B023E_56A86C020121_var*
//#UC END# *54F8635B023E_56A86C020121_var*
begin
//#UC START# *54F8635B023E_56A86C020121_impl*
 Result := 'ComboAccess';
//#UC END# *54F8635B023E_56A86C020121_impl*
end;//TcaDataProviderFactory.Key

function TcaDataProviderFactory.MakeFromConfig: TdaDataProviderParams;
//#UC START# *54FEB57302B0_56A86C020121_var*
var
 l_HTParams: ThtDataProviderParams;
 l_PGParams: TpgDataProviderParams;
//#UC END# *54FEB57302B0_56A86C020121_var*
begin
//#UC START# *54FEB57302B0_56A86C020121_impl*
 l_HTParams := f_HTFactory.MakeFromConfig as ThtDataProviderParams;
 try
  l_PGParams := f_PGFactory.MakeFromConfig as TpgDataProviderParams;
  try
   Result := TcaDataProviderParams.Create(l_HTParams, l_PGParams);
   TcaDataProviderParams(Result).LoadFromAlienParams;
  finally
   FreeAndNil(l_PGParams);
  end;
 finally
  FreeAndNil(l_HTParams);
 end;
//#UC END# *54FEB57302B0_56A86C020121_impl*
end;//TcaDataProviderFactory.MakeFromConfig

procedure TcaDataProviderFactory.SaveToConfig(aParams: TdaDataProviderParams);
//#UC START# *550AAD0101F9_56A86C020121_var*
//#UC END# *550AAD0101F9_56A86C020121_var*
begin
//#UC START# *550AAD0101F9_56A86C020121_impl*
 (aParams as TcaDataProviderParams).SaveToAlienParams;
 f_HTFactory.SaveToConfig(TcaDataProviderParams(aParams).HTParams);
 f_PGFactory.SaveToConfig(TcaDataProviderParams(aParams).PGParams);
//#UC END# *550AAD0101F9_56A86C020121_impl*
end;//TcaDataProviderFactory.SaveToConfig

function TcaDataProviderFactory.ParamType: TdaDataProviderParamsClass;
//#UC START# *550FD49301BF_56A86C020121_var*
//#UC END# *550FD49301BF_56A86C020121_var*
begin
//#UC START# *550FD49301BF_56A86C020121_impl*
 Result := TcaDataProviderParams;
//#UC END# *550FD49301BF_56A86C020121_impl*
end;//TcaDataProviderFactory.ParamType

procedure TcaDataProviderFactory.FillOutConfig(aConfig: TddAppConfiguration;
  aEtalon: TdaDataProviderParams;
  out aParams: TdaDataProviderParams);
//#UC START# *5512BAB20128_56A86C020121_var*
var
 l_HTParams: ThtDataProviderParams;
 l_PGParams: TpgDataProviderParams;
//#UC END# *5512BAB20128_56A86C020121_var*
begin
//#UC START# *5512BAB20128_56A86C020121_impl*
 if ParamsStorage.OuterConfigEdit then
  aParams := MakeFromConfig
 else
 begin
  l_HTParams := ThtDataProviderParams.Create;
  try
   l_PGParams := TpgDataProviderParams.Create;
   try
    aParams := TcaDataProviderParams.Create(l_HTParams, l_PGParams);
   finally
    FreeAndNil(l_PGParams);
   end;
  finally
   FreeAndNil(l_HTParams);
  end;
  aParams.AssignParams(aEtalon);
  with aConfig do
  begin
   aParams.Login := AsString['Login'];
   aParams.Password := AsString['Password'];
   if aConfig.IsChanged['caBaseRoot'] and (aConfig.AsString['caBaseRoot'] <> aParams.DocStoragePath) then
    aParams.ChangeBasePath(aConfig.AsString['caBaseRoot']);
   TcaDataProviderParams(aParams).DataServerHostName := AsString['caDataServerHostName'];
   TcaDataProviderParams(aParams).DataServerPort := AsInteger['caDataServerPort'];
  end;
  TcaDataProviderParams(aParams).SaveToAlienParams;
 end;
//#UC END# *5512BAB20128_56A86C020121_impl*
end;//TcaDataProviderFactory.FillOutConfig

procedure TcaDataProviderFactory.FillInConfig(aConfig: TddAppConfiguration;
  aParams: TdaDataProviderParams;
  ForInfoOnly: Boolean = False);
//#UC START# *5512BB030346_56A86C020121_var*
var
 l_Params: TcaDataProviderParams;
//#UC END# *5512BB030346_56A86C020121_var*
begin
//#UC START# *5512BB030346_56A86C020121_impl*
 if ParamsStorage.OuterConfigEdit then
  Exit;

 Assert(aParams is TcaDataProviderParams);
 l_Params :=  aParams as TcaDataProviderParams;

 with aConfig do
 begin
  if ForInfoOnly then
  begin
   AsString['Login'] := aParams.Login;
   AsString['caBaseRoot'] := aParams.DocStoragePath;
   AsString['cahtHomePath'] := aParams.FullHomeDirPath;
   AsString['caDataConnectParams'] := Format('%s:%d', [l_Params.DataServerHostName, l_Params.DataServerPort]);
  end
  else
  begin
   AsString['Login'] := aParams.Login;
   AsString['Password'] := aParams.Password;
   AsString['caBaseRoot'] := aParams.DocStoragePath;
   AsString['caDataServerHostName'] := l_Params.DataServerHostName;
   AsInteger['caDataServerPort'] := l_Params.DataServerPort;
  end;
 end;
//#UC END# *5512BB030346_56A86C020121_impl*
end;//TcaDataProviderFactory.FillInConfig

procedure TcaDataProviderFactory.BuildConfig(aConfig: TddAppConfiguration;
  const aProviderKey: AnsiString = '';
  ForInfoOnly: Boolean = False);
//#UC START# *5512BB1F023F_56A86C020121_var*
var
 l_Item: TddBaseConfigItem;
//#UC END# *5512BB1F023F_56A86C020121_var*
begin
//#UC START# *5512BB1F023F_56A86C020121_impl*
 if ParamsStorage.OuterConfigEdit then
  ParamsStorage.BuildConfig(aConfig, Key)
 else
 begin
  if ForInfoOnly then
  begin
   l_Item := aConfig.AddFolderNameItem('caBaseRoot', 'База документов');
   l_Item.ReadOnly := True;
   l_Item := aConfig.AddFolderNameItem('cahtHomePath', 'Домашний каталог');
   l_Item.ReadOnly := True;
   l_Item := aConfig.AddStringItem('caDataConnectParams', 'Подключено');
    aConfig.Hint:= 'Параметры подключения к Серверу БД';
    l_Item.ReadOnly := True;
  end
  else
  begin
   aConfig.AddFolderNameItem('caBaseRoot', 'База документов');
   aConfig.AddStringItem('caDataServerHostName', 'Адрес сервера БД', '');
   aConfig.AddIntegerItem(l3CStr('caDataServerPort'), l3CStr('Порт сервера БД'), c_DefaultPostgresPort);
  end;
 end;
//#UC END# *5512BB1F023F_56A86C020121_impl*
end;//TcaDataProviderFactory.BuildConfig

procedure TcaDataProviderFactory.LoadDBVersion(aParams: TdaDataProviderParams);
//#UC START# *551904FC039A_56A86C020121_var*
var
 l_Param: TcaDataProviderParams;
//#UC END# *551904FC039A_56A86C020121_var*
begin
//#UC START# *551904FC039A_56A86C020121_impl*
 l_Param := (aParams as TcaDataProviderParams);
 l_Param.SaveToAlienParams;
 f_HTFactory.LoadDBVersion(l_Param.HTParams);
 f_PGFactory.LoadDBVersion(l_Param.PGParams);
 l_Param.LoadFromAlienParams;
//#UC END# *551904FC039A_56A86C020121_impl*
end;//TcaDataProviderFactory.LoadDBVersion

function TcaDataProviderFactory.DoMakeProvider(aParams: TdaDataProviderParams;
  ForCheckLogin: Boolean;
  AllowClearLocks: Boolean;
  SetGlobalProvider: Boolean = True): IdaDataProvider;
//#UC START# *551D06D402AF_56A86C020121_var*
var
 l_Params: TcaDataProviderParams;
 l_HTProvider: IdaDataProvider;
 l_PGProvider: IdaDataProvider;
//#UC END# *551D06D402AF_56A86C020121_var*
begin
//#UC START# *551D06D402AF_56A86C020121_impl*
 Assert(aParams is TcaDataProviderParams);
 l_Params := aParams as TcaDataProviderParams;
 l_HTProvider := f_HTFactory.DoMakeProvider(l_Params.HTParams, ForCheckLogin,  AllowClearLocks, False);
 try
  l_PGProvider := f_PGFactory.DoMakeProvider(l_Params.PGParams, ForCheckLogin,  AllowClearLocks, False);
  try
   Result := TcaDataProvider.Make(l_Params, ForCheckLogin, AllowClearLocks, l_HTProvider, l_PGProvider);
  finally
   l_PGProvider := nil;
  end;
 finally
  l_HTProvider := nil;
 end;
//#UC END# *551D06D402AF_56A86C020121_impl*
end;//TcaDataProviderFactory.DoMakeProvider

procedure TcaDataProviderFactory.LoginCheckSucceed(aParams: TdaDataProviderParams);
//#UC START# *55D706D201C3_56A86C020121_var*
var
 l_Param: TcaDataProviderParams;
//#UC END# *55D706D201C3_56A86C020121_var*
begin
//#UC START# *55D706D201C3_56A86C020121_impl*
 l_Param := (aParams as TcaDataProviderParams);
 l_Param.SaveToAlienParams;
 f_HTFactory.LoginCheckSucceed(l_Param.HTParams);
 f_PGFactory.LoginCheckSucceed(l_Param.PGParams);
 l_Param.LoadFromAlienParams;
//#UC END# *55D706D201C3_56A86C020121_impl*
end;//TcaDataProviderFactory.LoginCheckSucceed

procedure TcaDataProviderFactory.Cleanup;
//#UC START# *479731C50290_56A86C020121_var*
//#UC END# *479731C50290_56A86C020121_var*
begin
//#UC START# *479731C50290_56A86C020121_impl*
 FreeAndNil(f_HTFactory);
 FreeAndNil(f_PGFactory);
 inherited;
//#UC END# *479731C50290_56A86C020121_impl*
end;//TcaDataProviderFactory.Cleanup

{$IfEnd} //TestComboAccess AND UsePostgres

end.