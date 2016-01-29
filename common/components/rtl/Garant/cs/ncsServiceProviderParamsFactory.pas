unit ncsServiceProviderParamsFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsServiceProviderParamsFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ClientSide::TncsServiceProviderParamsFactory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject,
  ddAppConfig,
  ncsServiceProviderParams,
  daGUITypes
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsServiceProviderParamsFactory = class(Tl3ProtoObject)
 public
 // public methods
   procedure FillInConfig(aConfig: TddAppConfiguration;
     aParams: TncsServiceProviderParams;
     ForInfoOnly: Boolean = False);
   procedure FillOutConfig(aConfig: TddAppConfiguration;
     aParams: TncsServiceProviderParams);
   procedure BuildConfig(aConfig: TddAppConfiguration;
     aCallBack: TBuildConfigProc;
     const aProviderKey: AnsiString = '';
     ForInfoOnly: Boolean = False);
   function MakeEmpty: TncsServiceProviderParams;
   function MakeFromConfig: TncsServiceProviderParams;
   procedure SaveToConfig(aParams: TncsServiceProviderParams);
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TncsServiceProviderParamsFactory;
    {- возвращает экземпляр синглетона. }
 end;//TncsServiceProviderParamsFactory
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Base {a},
  l3Base64,
  l3Utils,
  l3IniFile,
  ddAppConfigTypes,
  ddAppConfigStrings,
  SysUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}


// start class TncsServiceProviderParamsFactory

var g_TncsServiceProviderParamsFactory : TncsServiceProviderParamsFactory = nil;

procedure TncsServiceProviderParamsFactoryFree;
begin
 l3Free(g_TncsServiceProviderParamsFactory);
end;

class function TncsServiceProviderParamsFactory.Instance: TncsServiceProviderParamsFactory;
begin
 if (g_TncsServiceProviderParamsFactory = nil) then
 begin
  l3System.AddExitProc(TncsServiceProviderParamsFactoryFree);
  g_TncsServiceProviderParamsFactory := Create;
 end;
 Result := g_TncsServiceProviderParamsFactory;
end;


procedure TncsServiceProviderParamsFactory.FillInConfig(aConfig: TddAppConfiguration;
  aParams: TncsServiceProviderParams;
  ForInfoOnly: Boolean = False);
//#UC START# *5512C125015E_54F04779024B_var*
const
 cMap: array [Boolean] of Integer = (0, 1);
//#UC END# *5512C125015E_54F04779024B_var*
begin
//#UC START# *5512C125015E_54F04779024B_impl*
 with aConfig do
 begin
  if ForInfoOnly then
  begin
   AsString['Login'] := aParams.Login;
   if aParams.StandAlone then
    AsString['ConnectParams'] := 'Локально'
   else
    AsString['ConnectParams'] := Format('%s:%d', [aParams.ServerHostName, aParams.ServerPort]);
  end
  else
  begin
   AsString['Login'] := aParams.Login;
   AsString['Password'] := aParams.Password;
   AsInteger['StandAlone'] := cMap[aParams.StandAlone];
   AsString['ServerHostName'] := aParams.ServerHostName;
   AsInteger['ServerPort'] := aParams.ServerPort;
  end;
 end;
//#UC END# *5512C125015E_54F04779024B_impl*
end;//TncsServiceProviderParamsFactory.FillInConfig

procedure TncsServiceProviderParamsFactory.FillOutConfig(aConfig: TddAppConfiguration;
  aParams: TncsServiceProviderParams);
//#UC START# *5512C13A039D_54F04779024B_var*
//#UC END# *5512C13A039D_54F04779024B_var*
begin
//#UC START# *5512C13A039D_54F04779024B_impl*
 with aConfig do
 begin
  aParams.Login := AsString['Login'];
  aParams.Password := AsString['Password'];
  aParams.StandAlone := AsInteger['StandAlone'] = 1;
  aParams.ServerHostName := AsString['ServerHostName'];
  aParams.ServerPort := AsInteger['ServerPort'];
 end;
//#UC END# *5512C13A039D_54F04779024B_impl*
end;//TncsServiceProviderParamsFactory.FillOutConfig

procedure TncsServiceProviderParamsFactory.BuildConfig(aConfig: TddAppConfiguration;
  aCallBack: TBuildConfigProc;
  const aProviderKey: AnsiString = '';
  ForInfoOnly: Boolean = False);
//#UC START# *5512C166028C_54F04779024B_var*
var
 l_Container: TddContainerConfigItem;
 l_Item: TddBaseConfigItem;
//#UC END# *5512C166028C_54F04779024B_var*
begin
//#UC START# *5512C166028C_54F04779024B_impl*
 Assert(Assigned(aCallBack));
 with aConfig do
 begin
  AddNode('Common', 'Подключение');
   LabelTop:= False;
   if ForInfoOnly then
   begin
    l_Item := AddStringItem('Login', 'Имя пользователя');
     Hint:= 'Имя пользователя для входа в базу данных';
     l_Item.ReadOnly := True;
    l_Item := AddStringItem('ConnectParams', 'Подключено');
     Hint:= 'Параметры подключения к Серверу Автоматизации';
     l_Item.ReadOnly := True;
    aCallBack(aConfig, aProviderKey, ForInfoOnly);
   end
   else
   begin
    AddStringItem('Login', 'Имя пользователя');
     Hint:= 'Имя пользователя для входа в базу данных';
    AddStringItem('Password', 'Пароль пользователя');
     PAsswordChar:= '*';
     Hint:= 'Пароль пользователя для входа в базу данных';
    AddContainerGroup('Advanced', 'Дополнительно');
     Hint:= 'Параметры подключения к Серверу Автоматизации';
     l_Container := AddContainerGroup('StandAlone', '') as TddContainerConfigItem;
      l_Container.AddCase('Подключаться к серверу');
       l_Container.Add(TddStringConfigItem.Make('ServerHostName', 'Адрес сервера', ''));
       l_Container.Add(TddIntegerConfigItem.CreateItem('ServerPort', 'Порт сервера', 32100));
      l_Container.AddCase('Работать автономно');
       aCallBack(aConfig, aProviderKey, ForInfoOnly);
     CloseGroup;
    CloseGroup;
  end;
 end;
//#UC END# *5512C166028C_54F04779024B_impl*
end;//TncsServiceProviderParamsFactory.BuildConfig

function TncsServiceProviderParamsFactory.MakeEmpty: TncsServiceProviderParams;
//#UC START# *54F047C70145_54F04779024B_var*
//#UC END# *54F047C70145_54F04779024B_var*
begin
//#UC START# *54F047C70145_54F04779024B_impl*
 Result := TncsServiceProviderParams.Create;
//#UC END# *54F047C70145_54F04779024B_impl*
end;//TncsServiceProviderParamsFactory.MakeEmpty

function TncsServiceProviderParamsFactory.MakeFromConfig: TncsServiceProviderParams;
//#UC START# *54F047F9029C_54F04779024B_var*
//#UC END# *54F047F9029C_54F04779024B_var*
begin
//#UC START# *54F047F9029C_54F04779024B_impl*
 Result := MakeEmpty;

 if (StationConfig = nil) or (ServerConfig = nil) then
 begin
  InitStationAndServerConfig;
 end;

 with StationConfig do
 begin
  Section:= 'Preferences';
  Result.IsDeveloper := ReadParamBoolDef('Developer', False);
 end;

 with ServerConfig do
 begin
  Section:='Network';
  Result.ServerHostName   := ReadParamStrDef('ServerName', '');
  Result.ServerPort   := ReadParamIntDef('ServerPort', 32100);
  Result.StandAlone   := ReadParamBoolDef('StandAlone', True);
 end;

 StationConfig.Section:='User';
 Result.Login := StationConfig.ReadParamStrDef('UserName','');
 Result.Password := l3Decrypt(l3DecodeBase64(StationConfig.ReadParamStrDef('UserPassword','')));
//#UC END# *54F047F9029C_54F04779024B_impl*
end;//TncsServiceProviderParamsFactory.MakeFromConfig

procedure TncsServiceProviderParamsFactory.SaveToConfig(aParams: TncsServiceProviderParams);
//#UC START# *54F81FA703DF_54F04779024B_var*
//#UC END# *54F81FA703DF_54F04779024B_var*
begin
//#UC START# *54F81FA703DF_54F04779024B_impl*
 // Из конфига не читали, значит и сохранять не наша забота.
 if (StationConfig = nil) or (ServerConfig = nil) then
  Exit;

 with StationConfig do
 begin
  Section:= 'Preferences';
  WriteParamBool('Developer', aParams.IsDeveloper);
 end;

 if (StationConfig.CfgFileName = ServerConfig.CfgFileName) then
 with ServerConfig do
 begin
  Section:='Network';
  WriteParamStr('ServerName', aParams.ServerHostName);
  WriteParamInt('ServerPort', aParams.ServerPort);
  WriteParamBool('StandAlone', aParams.StandAlone);
 end;

 StationConfig.Section:='User';
 StationConfig.WriteParamStr('UserName', aParams.Login);
// Пароль пока не пишем - бо он вроде бы нигде и никак не включается.
// StationConfig.WriteParamStr('UserPassword',l3EncodeBase64(l3Encrypt(aParams.Password)));
//#UC END# *54F81FA703DF_54F04779024B_impl*
end;//TncsServiceProviderParamsFactory.SaveToConfig

class function TncsServiceProviderParamsFactory.Exists: Boolean;
 {-}
begin
 Result := g_TncsServiceProviderParamsFactory <> nil;
end;//TncsServiceProviderParamsFactory.Exists

{$IfEnd} //not Nemesis

end.