unit daDataProviderSuperFactory;

// Модуль: "w:\common\components\rtl\Garant\DA\daDataProviderSuperFactory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaDataProviderSuperFactory" MUID: (54F85B590251)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daDataProviderFactory
 , daDataProviderFactoryList
 , daInterfaces
 , daDataProviderParams
 , daTypes
 , Classes
 , l3Variant
 , ddAppConfig
;

type
 TdaDataProviderSuperFactory = class(Tl3ProtoObject)
  private
   f_List: TdaDataProviderFactoryList;
   f_DefaultFactory: TdaDataProviderFactory;
   f_ParamsStorage: IdaParamsStorage;
  private
   function FindFactoryByKey(const aKey: AnsiString): TdaDataProviderFactory;
   function MakeFromTaggedData(aData: Tl3Tag): TdaDataProviderParams;
   function IndexOfParamType(const aKey: AnsiString): Integer;
  protected
   procedure pm_SetDefaultFactory(aValue: TdaDataProviderFactory);
   procedure pm_SetParamsStorage(const aValue: IdaParamsStorage);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure ClearFields; override;
  public
   function FindFactoryByParamType(const aKey: AnsiString): TdaDataProviderFactory;
   procedure CorrectByClient(aParams: TdaDataProviderParams;
    CorrectTempPath: Boolean = True);
   function IsParamsValid(aParams: TdaDataProviderParams;
    Quiet: Boolean = False): Boolean;
   procedure FillInConfig(aConfig: TddAppConfiguration;
    aParams: TdaDataProviderParams;
    ForInfoOnly: Boolean = False);
   procedure FillOutConfig(aConfig: TddAppConfiguration;
    aEtalon: TdaDataProviderParams;
    out aParams: TdaDataProviderParams);
   procedure BuildConfig(aConfig: TddAppConfiguration;
    const aProviderKey: AnsiString = '';
    ForInfoOnly: Boolean = False);
   function MakeProvider(aParams: TdaDataProviderParams;
    AllowClearLocks: Boolean): IdaDataProvider;
   procedure LoadDBVersion(aParams: TdaDataProviderParams);
   function CheckLogin(aParams: TdaDataProviderParams;
    const aLogin: AnsiString;
    const aPassword: AnsiString;
    IsRequireAdminRights: Boolean;
    SuppressExceptions: Boolean = True): TdaLoginError;
   procedure Register(aFactory: TdaDataProviderFactory);
   procedure UnRegister(aFactory: TdaDataProviderFactory);
   function MakeFromConfig: TdaDataProviderParams;
   procedure SaveToConfig(aParams: TdaDataProviderParams);
   function MakeParamsFromEVD(aStream: TStream): TdaDataProviderParams;
   class function Instance: TdaDataProviderSuperFactory;
    {* Метод получения экземпляра синглетона TdaDataProviderSuperFactory }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property DefaultFactory: TdaDataProviderFactory
    read f_DefaultFactory
    write pm_SetDefaultFactory;
   property ParamsStorage: IdaParamsStorage
    read f_ParamsStorage
    write pm_SetParamsStorage;
 end;//TdaDataProviderSuperFactory

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
 , ddAppConfigTypes
 , l3Base
 //#UC START# *54F85B590251impl_uses*
 //#UC END# *54F85B590251impl_uses*
;

var g_TdaDataProviderSuperFactory: TdaDataProviderSuperFactory = nil;
 {* Экземпляр синглетона TdaDataProviderSuperFactory }

procedure TdaDataProviderSuperFactoryFree;
 {* Метод освобождения экземпляра синглетона TdaDataProviderSuperFactory }
begin
 l3Free(g_TdaDataProviderSuperFactory);
end;//TdaDataProviderSuperFactoryFree

procedure TdaDataProviderSuperFactory.pm_SetDefaultFactory(aValue: TdaDataProviderFactory);
//#UC START# *54F99D1A0219_54F85B590251set_var*
//#UC END# *54F99D1A0219_54F85B590251set_var*
begin
//#UC START# *54F99D1A0219_54F85B590251set_impl*
 if f_DefaultFactory <> aValue then
 begin
  aValue.SetRefTo(f_DefaultFactory);
  if Assigned(f_DefaultFactory) then
   Register(f_DefaultFactory);
 end;
//#UC END# *54F99D1A0219_54F85B590251set_impl*
end;//TdaDataProviderSuperFactory.pm_SetDefaultFactory

procedure TdaDataProviderSuperFactory.pm_SetParamsStorage(const aValue: IdaParamsStorage);
//#UC START# *5507E77B021F_54F85B590251set_var*
//#UC END# *5507E77B021F_54F85B590251set_var*
begin
//#UC START# *5507E77B021F_54F85B590251set_impl*
 f_ParamsStorage := aValue;
//#UC END# *5507E77B021F_54F85B590251set_impl*
end;//TdaDataProviderSuperFactory.pm_SetParamsStorage

function TdaDataProviderSuperFactory.FindFactoryByKey(const aKey: AnsiString): TdaDataProviderFactory;
//#UC START# *550A8A38018C_54F85B590251_var*
var
 l_IDX: Integer;
//#UC END# *550A8A38018C_54F85B590251_var*
begin
//#UC START# *550A8A38018C_54F85B590251_impl*
 Result := nil;
 for l_IDX := 0 to f_List.Count - 1 do
  if AnsiSameText(f_List[l_IDX].Key, aKey) then
  begin
   Result := f_List[l_IDX];
   Break;
  end;
 if Result = nil then
  Result := DefaultFactory;
 Assert(Assigned(Result));
 Result.ParamsStorage := f_ParamsStorage;
//#UC END# *550A8A38018C_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.FindFactoryByKey

function TdaDataProviderSuperFactory.FindFactoryByParamType(const aKey: AnsiString): TdaDataProviderFactory;
//#UC START# *550A8A6701F6_54F85B590251_var*
var
 l_IDX: Integer;
//#UC END# *550A8A6701F6_54F85B590251_var*
begin
//#UC START# *550A8A6701F6_54F85B590251_impl*
 Result := nil;
 for l_IDX := 0 to f_List.Count - 1 do
  if AnsiSameText(f_List[l_IDX].ParamKey, aKey) then
  begin
   Result := f_List[l_IDX];
   Break;
  end;
 Assert(Assigned(Result));
 Result.ParamsStorage := f_ParamsStorage;
//#UC END# *550A8A6701F6_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.FindFactoryByParamType

function TdaDataProviderSuperFactory.MakeFromTaggedData(aData: Tl3Tag): TdaDataProviderParams;
//#UC START# *550FD1780368_54F85B590251_var*
var
 l_ClassRef: TdaDataProviderParamsClass;
//#UC END# *550FD1780368_54F85B590251_var*
begin
//#UC START# *550FD1780368_54F85B590251_impl*
 l_ClassRef := FindFactoryByParamType(aData.TagType.AsString).ParamType;
 if Assigned(l_ClassRef) then
 begin
  Result := l_ClassRef.Create;
  try
   Result.SetTaggedData(aData);
  except
   FreeAndNil(Result);
   raise;
  end;
 end
 else
  Result := nil;
//#UC END# *550FD1780368_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.MakeFromTaggedData

procedure TdaDataProviderSuperFactory.CorrectByClient(aParams: TdaDataProviderParams;
 CorrectTempPath: Boolean = True);
//#UC START# *55100AB20241_54F85B590251_var*
//#UC END# *55100AB20241_54F85B590251_var*
begin
//#UC START# *55100AB20241_54F85B590251_impl*
 FindFactoryByParamType(aParams.ParamsKey).CorrectByClient(aParams, CorrectTempPath);
//#UC END# *55100AB20241_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.CorrectByClient

function TdaDataProviderSuperFactory.IsParamsValid(aParams: TdaDataProviderParams;
 Quiet: Boolean = False): Boolean;
//#UC START# *551166670371_54F85B590251_var*
//#UC END# *551166670371_54F85B590251_var*
begin
//#UC START# *551166670371_54F85B590251_impl*
 Result := FindFactoryByParamType(aParams.ParamsKey).IsParamsValid(aParams, Quiet);
//#UC END# *551166670371_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.IsParamsValid

procedure TdaDataProviderSuperFactory.FillInConfig(aConfig: TddAppConfiguration;
 aParams: TdaDataProviderParams;
 ForInfoOnly: Boolean = False);
//#UC START# *5512BB5D0065_54F85B590251_var*
var
 l_Param: TdaDataProviderParams;
 l_IDX: Integer;
 l_Factory: TdaDataProviderFactory;
//#UC END# *5512BB5D0065_54F85B590251_var*
begin
//#UC START# *5512BB5D0065_54F85B590251_impl*
 if not ForInfoOnly then
 begin
  for l_IDX := 0 to f_List.Count - 1 do
  begin
   l_Param := f_List[l_IDX].MakeFromConfig;
   try
    f_List[l_IDX].ParamsStorage := ParamsStorage;
    f_List[l_IDX].FillInConfig(aConfig, l_Param, ForInfoOnly);
   finally
    FreeAndNil(l_Param);
   end;
  end;
  aConfig.AsInteger['Provider'] := IndexOfParamType(aParams.ParamsKey);
 end;
 FindFactoryByParamType(aParams.ParamsKey).FillInConfig(aConfig, aParams, ForInfoOnly);
//#UC END# *5512BB5D0065_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.FillInConfig

procedure TdaDataProviderSuperFactory.FillOutConfig(aConfig: TddAppConfiguration;
 aEtalon: TdaDataProviderParams;
 out aParams: TdaDataProviderParams);
//#UC START# *5512BB8103B4_54F85B590251_var*
//#UC END# *5512BB8103B4_54F85B590251_var*
begin
//#UC START# *5512BB8103B4_54F85B590251_impl*
 f_List[aConfig.AsInteger['Provider']].FillOutConfig(aConfig, aEtalon, aParams)
//#UC END# *5512BB8103B4_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.FillOutConfig

procedure TdaDataProviderSuperFactory.BuildConfig(aConfig: TddAppConfiguration;
 const aProviderKey: AnsiString = '';
 ForInfoOnly: Boolean = False);
//#UC START# *5512BB9801EA_54F85B590251_var*
var
 l_IDX: Integer;
 l_Container: TddContainerConfigItem;
 l_Default: String;
//#UC END# *5512BB9801EA_54F85B590251_var*
begin
//#UC START# *5512BB9801EA_54F85B590251_impl*
 if ForInfoOnly then
  FindFactoryByParamType(aProviderKey).BuildConfig(aConfig, aProviderKey, ForInfoOnly)
 else
 begin
  if Assigned(DefaultFactory) then
   l_Default := DefaultFactory.Key
  else
   l_Default := '';
  l_Container := aConfig.AddContainerGroup('Provider', l_Default) as TddContainerConfigItem;
  l_Container.ForceComboBox := True;
  for l_IDX := 0 to f_List.Count - 1 do
  begin
   l_Container.AddCase(f_List[l_IDX].Key);
   f_List[l_IDX].ParamsStorage := ParamsStorage;
   f_List[l_IDX].BuildConfig(aConfig, aProviderKey, ForInfoOnly);
  end;
  aConfig.CloseGroup;
 end;
//#UC END# *5512BB9801EA_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.BuildConfig

function TdaDataProviderSuperFactory.IndexOfParamType(const aKey: AnsiString): Integer;
//#UC START# *5512C7FE0342_54F85B590251_var*
var
 l_IDX: Integer;
//#UC END# *5512C7FE0342_54F85B590251_var*
begin
//#UC START# *5512C7FE0342_54F85B590251_impl*
 Result := -1;
 for l_IDX := 0 to f_List.Count - 1 do
  if AnsiSameText(f_List[l_IDX].ParamKey, aKey) then
  begin
   Result := l_IDX;
   Break;
  end;
 Assert(Result <> -1);
 f_List[Result].ParamsStorage := ParamsStorage;
//#UC END# *5512C7FE0342_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.IndexOfParamType

function TdaDataProviderSuperFactory.MakeProvider(aParams: TdaDataProviderParams;
 AllowClearLocks: Boolean): IdaDataProvider;
//#UC START# *551543F903C6_54F85B590251_var*
//#UC END# *551543F903C6_54F85B590251_var*
begin
//#UC START# *551543F903C6_54F85B590251_impl*
 Result := FindFactoryByParamType(aParams.ParamsKey).MakeProvider(aParams, AllowClearLocks);
//#UC END# *551543F903C6_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.MakeProvider

procedure TdaDataProviderSuperFactory.LoadDBVersion(aParams: TdaDataProviderParams);
//#UC START# *551904D300A1_54F85B590251_var*
//#UC END# *551904D300A1_54F85B590251_var*
begin
//#UC START# *551904D300A1_54F85B590251_impl*
 FindFactoryByParamType(aParams.ParamsKey).LoadDBVersion(aParams);
//#UC END# *551904D300A1_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.LoadDBVersion

function TdaDataProviderSuperFactory.CheckLogin(aParams: TdaDataProviderParams;
 const aLogin: AnsiString;
 const aPassword: AnsiString;
 IsRequireAdminRights: Boolean;
 SuppressExceptions: Boolean = True): TdaLoginError;
//#UC START# *551BE37C0396_54F85B590251_var*
//#UC END# *551BE37C0396_54F85B590251_var*
begin
//#UC START# *551BE37C0396_54F85B590251_impl*
 Result := FindFactoryByParamType(aParams.ParamsKey).CheckLogin(aParams, aLogin, aPassword, IsRequireAdminRights, SuppressExceptions);
//#UC END# *551BE37C0396_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.CheckLogin

procedure TdaDataProviderSuperFactory.Register(aFactory: TdaDataProviderFactory);
//#UC START# *54F85C450279_54F85B590251_var*
//#UC END# *54F85C450279_54F85B590251_var*
begin
//#UC START# *54F85C450279_54F85B590251_impl*
 f_List.Add(aFactory);
//#UC END# *54F85C450279_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.Register

procedure TdaDataProviderSuperFactory.UnRegister(aFactory: TdaDataProviderFactory);
//#UC START# *54F85C60022E_54F85B590251_var*
//#UC END# *54F85C60022E_54F85B590251_var*
begin
//#UC START# *54F85C60022E_54F85B590251_impl*
 f_List.Remove(aFactory);
//#UC END# *54F85C60022E_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.UnRegister

function TdaDataProviderSuperFactory.MakeFromConfig: TdaDataProviderParams;
//#UC START# *54FEB4CD0070_54F85B590251_var*
//#UC END# *54FEB4CD0070_54F85B590251_var*
begin
//#UC START# *54FEB4CD0070_54F85B590251_impl*
 Assert(ParamsStorage <> nil);
 Result := FindFactoryByKey(ParamsStorage.ProviderKey).MakeFromConfig;
//#UC END# *54FEB4CD0070_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.MakeFromConfig

procedure TdaDataProviderSuperFactory.SaveToConfig(aParams: TdaDataProviderParams);
//#UC START# *550A89DC03C4_54F85B590251_var*
//#UC END# *550A89DC03C4_54F85B590251_var*
begin
//#UC START# *550A89DC03C4_54F85B590251_impl*
 Assert(ParamsStorage <> nil);

 ParamsStorage.ProviderKey := aParams.ParamsKey;

 FindFactoryByParamType(aParams.ParamsKey).SaveToConfig(aParams);
//#UC END# *550A89DC03C4_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.SaveToConfig

function TdaDataProviderSuperFactory.MakeParamsFromEVD(aStream: TStream): TdaDataProviderParams;
//#UC START# *550FCA280214_54F85B590251_var*
var
 l_Data : Tl3Tag;
//#UC END# *550FCA280214_54F85B590251_var*
begin
//#UC START# *550FCA280214_54F85B590251_impl*
 Result := nil;
 if aStream.Size = 0 then
  Exit;
 l_Data := TdaDataProviderParams.CreateTaggedDataFromEVD(aStream);
 try
  Result := MakeFromTaggedData(l_Data);
 finally
  FreeAndNil(l_Data);
 end;//try..finally
//#UC END# *550FCA280214_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.MakeParamsFromEVD

class function TdaDataProviderSuperFactory.Instance: TdaDataProviderSuperFactory;
 {* Метод получения экземпляра синглетона TdaDataProviderSuperFactory }
begin
 if (g_TdaDataProviderSuperFactory = nil) then
 begin
  l3System.AddExitProc(TdaDataProviderSuperFactoryFree);
  g_TdaDataProviderSuperFactory := Create;
 end;
 Result := g_TdaDataProviderSuperFactory;
end;//TdaDataProviderSuperFactory.Instance

class function TdaDataProviderSuperFactory.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TdaDataProviderSuperFactory <> nil;
end;//TdaDataProviderSuperFactory.Exists

procedure TdaDataProviderSuperFactory.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_54F85B590251_var*
//#UC END# *479731C50290_54F85B590251_var*
begin
//#UC START# *479731C50290_54F85B590251_impl*
 FreeAndNil(f_List);
 FreeAndNil(f_DefaultFactory);
 f_ParamsStorage := nil;
 inherited;
//#UC END# *479731C50290_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.Cleanup

procedure TdaDataProviderSuperFactory.InitFields;
//#UC START# *47A042E100E2_54F85B590251_var*
//#UC END# *47A042E100E2_54F85B590251_var*
begin
//#UC START# *47A042E100E2_54F85B590251_impl*
 inherited;
 f_List := TdaDataProviderFactoryList.MakeSorted(l3_dupIgnore);
//#UC END# *47A042E100E2_54F85B590251_impl*
end;//TdaDataProviderSuperFactory.InitFields

procedure TdaDataProviderSuperFactory.ClearFields;
begin
 ParamsStorage := nil;
 inherited;
end;//TdaDataProviderSuperFactory.ClearFields

end.
