unit ncsServiceProviderParamsFactory;

// ������: "w:\common\components\rtl\Garant\cs\ncsServiceProviderParamsFactory.pas"
// ���������: "SimpleClass"
// ������� ������: "TncsServiceProviderParamsFactory" MUID: (54F04779024B)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , ncsServiceProviderParams
 , ddAppConfig
 , daGUITypes
;

type
 TncsServiceProviderParamsFactory = class(Tl3ProtoObject)
  public
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
   class function Instance: TncsServiceProviderParamsFactory;
    {* ����� ��������� ���������� ���������� TncsServiceProviderParamsFactory }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TncsServiceProviderParamsFactory
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base64
 , l3Utils
 , l3IniFile
 , ddAppConfigTypes
 , ddAppConfigStrings
 , SysUtils
 , l3Base
 //#UC START# *54F04779024Bimpl_uses*
 //#UC END# *54F04779024Bimpl_uses*
;

var g_TncsServiceProviderParamsFactory: TncsServiceProviderParamsFactory = nil;
 {* ��������� ���������� TncsServiceProviderParamsFactory }

procedure TncsServiceProviderParamsFactoryFree;
 {* ����� ������������ ���������� ���������� TncsServiceProviderParamsFactory }
begin
 l3Free(g_TncsServiceProviderParamsFactory);
end;//TncsServiceProviderParamsFactoryFree

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
    AsString['ConnectParams'] := '��������'
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
  AddNode('Common', '�����������');
   LabelTop:= False;
   if ForInfoOnly then
   begin
    l_Item := AddStringItem('Login', '��� ������������');
     Hint:= '��� ������������ ��� ����� � ���� ������';
     l_Item.ReadOnly := True;
    l_Item := AddStringItem('ConnectParams', '����������');
     Hint:= '��������� ����������� � ������� �������������';
     l_Item.ReadOnly := True;
    aCallBack(aConfig, aProviderKey, ForInfoOnly);
   end
   else
   begin
    AddStringItem('Login', '��� ������������');
     Hint:= '��� ������������ ��� ����� � ���� ������';
    AddStringItem('Password', '������ ������������');
     PAsswordChar:= '*';
     Hint:= '������ ������������ ��� ����� � ���� ������';
    AddContainerGroup('Advanced', '�������������');
     Hint:= '��������� ����������� � ������� �������������';
     l_Container := AddContainerGroup('StandAlone', '') as TddContainerConfigItem;
      l_Container.AddCase('������������ � �������');
       l_Container.Add(TddStringConfigItem.Make('ServerHostName', '����� �������', ''));
       l_Container.Add(TddIntegerConfigItem.CreateItem('ServerPort', '���� �������', 32100));
      l_Container.AddCase('�������� ���������');
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
 // �� ������� �� ������, ������ � ��������� �� ���� ������.
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
// ������ ���� �� ����� - �� �� ����� �� ����� � ����� �� ����������.
// StationConfig.WriteParamStr('UserPassword',l3EncodeBase64(l3Encrypt(aParams.Password)));
//#UC END# *54F81FA703DF_54F04779024B_impl*
end;//TncsServiceProviderParamsFactory.SaveToConfig

class function TncsServiceProviderParamsFactory.Instance: TncsServiceProviderParamsFactory;
 {* ����� ��������� ���������� ���������� TncsServiceProviderParamsFactory }
begin
 if (g_TncsServiceProviderParamsFactory = nil) then
 begin
  l3System.AddExitProc(TncsServiceProviderParamsFactoryFree);
  g_TncsServiceProviderParamsFactory := Create;
 end;
 Result := g_TncsServiceProviderParamsFactory;
end;//TncsServiceProviderParamsFactory.Instance

class function TncsServiceProviderParamsFactory.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TncsServiceProviderParamsFactory <> nil;
end;//TncsServiceProviderParamsFactory.Exists
{$IfEnd} // NOT Defined(Nemesis)

end.
