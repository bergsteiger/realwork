unit atGblAdapterWorker;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/AdapterHelpers/atGblAdapterWorker.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x_test::AdapterTest::AdapterHelpers::atGblAdapterWorker
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  StartUnit,
  FoldersUnit,
  DynamicTreeUnit,
  NotifyUnit,
  SettingsUnit,
  UnderControlUnit,
  l3_Base,
  atInterfaces,
  atNotifier,
  GblAdapter,
  atChatWorker
  ;

type
 TatNotifierFacade = class
 private
 // private fields
   F_LongOperationStart : IatNotifier;
   F_LongOperationEnd : IatNotifier;
   F_PredefinedDataLogout : IatNotifier;
   F_Shutdown : IatNotifier;
   F_BaseUpdateStart : IatNotifier;
   F_BasesUpdateEnd : IatNotifier;
   F_BaseUpdateFailed : IatNotifier;
   F_ConsultationReceived : IatNotifier;
   F_ConsultationNotSent : IatNotifier;
   F_NoSubscription : IatNotifier;
   F_Logout : IatNotifier;
 public
 // public methods
   constructor Create(const aNotifyManager: INotifyManager); reintroduce;
 end;//TatNotifierFacade

 TatLoggedAs = (
   tlasGuest
 , tlasCommonUser
 );//TatLoggedAs

 TatGblAdapterWorker = class(TObject)
 private
 // private fields
   f_Configuration : IConfiguration;
   f_ConfigurationManager : IConfigurationManager;
   f_IsLoggedIn : Boolean;
    {* ���� ��� �������� IsLoggedIn}
   f_GblAdapterDll : IGblAdapterDll;
    {* ���� ��� �������� GblAdapterDll}
   f_NotifierFacade : TatNotifierFacade;
    {* ���� ��� �������� NotifierFacade}
   f_Authorization : IAuthorization;
    {* ���� ��� �������� Authorization}
   f_Common : ICommon;
    {* ���� ��� �������� Common}
   f_Folders : IFolders;
    {* ���� ��� �������� Folders}
   f_MyDocuments : IFoldersNode;
    {* ���� ��� �������� MyDocuments}
   f_CRTreeRoot : INodeBase;
    {* ���� ��� �������� CRTreeRoot}
   f_SettingsManager : ISettingsManager;
    {* ���� ��� �������� SettingsManager}
   f_LoggedAs : TatLoggedAs;
    {* ���� ��� �������� LoggedAs}
   f_ChatWorker : TatChatWorker;
    {* ���� ��� �������� ChatWorker}
   f_MainMenuRoot : INodeBase;
    {* ���� ��� �������� MainMenuRoot}
   f_ControlManager : IControlManager;
    {* ���� ��� �������� ControlManager}
 private
 // private methods
   constructor Create; reintroduce;
   procedure InitFieldsAfterLogin; virtual;
   procedure InitAdapter; virtual;
   procedure CloseAdapter; virtual;
 protected
 // property methods
   function pm_GetCommon: ICommon; virtual;
   function pm_GetMyDocuments: IFoldersNode; virtual;
   function pm_GetCRTreeRoot: INodeBase; virtual;
   function pm_GetMainMenuRoot: INodeBase; virtual;
 public
 // overridden public methods
   destructor Destroy; override;
 public
 // public methods
   class function Instance: TatGblAdapterWorker; virtual;
   class procedure InstanceFree; virtual;
   procedure Logout; virtual;
   function ForceLogin(const anUserName: AnsiString;
    const aPassword: AnsiString): Boolean; virtual;
   function GuestLogin: AnsiString; virtual;
 public
 // public properties
   property IsLoggedIn: Boolean
     read f_IsLoggedIn;
   property GblAdapterDll: IGblAdapterDll
     read f_GblAdapterDll;
   property NotifierFacade: TatNotifierFacade
     read f_NotifierFacade;
   property Authorization: IAuthorization
     read f_Authorization;
   property Common: ICommon
     read pm_GetCommon;
   property Folders: IFolders
     read f_Folders;
   property MyDocuments: IFoldersNode
     read pm_GetMyDocuments;
   property CRTreeRoot: INodeBase
     read pm_GetCRTreeRoot;
   property SettingsManager: ISettingsManager
     read f_SettingsManager;
   property LoggedAs: TatLoggedAs
     read f_LoggedAs;
   property ChatWorker: TatChatWorker
     read f_ChatWorker;
   property MainMenuRoot: INodeBase
     read pm_GetMainMenuRoot;
   property ControlManager: IControlManager
     read f_ControlManager;
 end;//TatGblAdapterWorker

const
  { UserName }
 TAT_USER_NAME = 'Console Adapter Test';

type
 TatControlledChangeNotifier = class(Tl3_Base, IControlledChangeNotifier)
 protected
 // realized methods
   procedure Fire; stdcall;
     {* �������� � ��� ��� �������������� ������� ����������. }
 public
 // public methods
   class function Make: IControlledChangeNotifier; reintroduce;
 end;//TatControlledChangeNotifier

implementation

uses
  SysUtils,
  atFoldersHelper,
  SecurityUnit,
  atNotification,
  atUserJournalHelper,
  atLogger,
  IOUnit
  ;

var gbl_AdapterWorkerInstance : TatGblAdapterWorker;

type
  TatFromShellNotifier = class(TatNotifier, IListener)
  private
  // private fields
   f_NotifyType : TNotifyType;
  protected
  // realized methods
   procedure Fire(const aNotify: INotification); stdcall;
  public
  // public methods
   constructor Create(aNotifyType: TNotifyType); reintroduce;
  end;//TatFromShellNotifier

// start class TatFromShellNotifier

constructor TatFromShellNotifier.Create(aNotifyType: TNotifyType);
//#UC START# *4AC2018D006C_4AC200650301_var*
//#UC END# *4AC2018D006C_4AC200650301_var*
begin
//#UC START# *4AC2018D006C_4AC200650301_impl*
  inherited Create;
  f_NotifyType := aNotifyType;
//#UC END# *4AC2018D006C_4AC200650301_impl*
end;//TatFromShellNotifier.Create

procedure TatFromShellNotifier.Fire(const aNotify: INotification);
//#UC START# *45EEDE9D01C5_4AC200650301_var*
  function NTTypeToStr : String;
  begin
    case f_NotifyType of
      NT_LONG_OPERATION_START   : Result := 'NT_LONG_OPERATION_START';
      NT_LONG_OPERATION_END     : Result := 'NT_LONG_OPERATION_END';
      NT_MONITORING_UPDATE      : Result := 'NT_MONITORING_UPDATE';
      NT_SHUTDOWN               : Result := 'NT_SHUTDOWN';
      NT_LOGOUT                 : Result := 'NT_LOGOUT';
      NT_BASE_UPDATE_START      : Result := 'NT_BASE_UPDATE_START';
      NT_BASE_UPDATE_END        : Result := 'NT_BASE_UPDATE_END';
      NT_BASE_UPDATE_FAILED     : Result := 'NT_BASE_UPDATE_FAILED';
      NT_CONSULTATION_RECEIVED  : Result := 'NT_CONSULTATION_RECEIVED';
      NT_CONSULTATION_NOT_SENT  : Result := 'NT_CONSULTATION_NOT_SENT';
      NT_NO_SUBSCRIPTION        : Result := 'NT_NO_SUBSCRIPTION';
    end;
  end;

  var
    l_Notification : IatNotification;
//#UC END# *45EEDE9D01C5_4AC200650301_var*
begin
//#UC START# *45EEDE9D01C5_4AC200650301_impl*
  if (aNotify.GetId = f_NotifyType) then
  begin
    if f_NotifyType = NT_BASE_UPDATE_END then // �����
      TatGblAdapterWorker.Instance.ControlManager.UpdateStatus(false);
    //  
    Logger.Info('����������� � ����� ' + NTTypeToStr + ' ��������.');
    l_Notification := TatNotification.Create(aNotify);
    Trigger(Self, l_Notification);
  end;
//#UC END# *45EEDE9D01C5_4AC200650301_impl*
end;//TatFromShellNotifier.Fire

constructor TatNotifierFacade.Create(const aNotifyManager: INotifyManager);
//#UC START# *4AC20023031C_4AC2000A021C_var*
  function RegisterNotifier(const aNotifyType : TNotifyType) : IatNotifier;
  begin
    Result := TatFromShellNotifier.Create(aNotifyType);
    aNotifyManager.RegisterListenerForNotify(aNotifyType, Result as IListener);
  end;
//#UC END# *4AC20023031C_4AC2000A021C_var*
begin
//#UC START# *4AC20023031C_4AC2000A021C_impl*
  inherited Create;
  //
  F_LongOperationStart    := RegisterNotifier(NT_LONG_OPERATION_START);
  F_LongOperationEnd      := RegisterNotifier(NT_LONG_OPERATION_END);
  F_PredefinedDataLogout  := RegisterNotifier(NT_MONITORING_UPDATE);
  F_Shutdown              := RegisterNotifier(NT_SHUTDOWN);
  F_Logout                := RegisterNotifier(NT_LOGOUT);
  F_BaseUpdateStart       := RegisterNotifier(NT_BASE_UPDATE_START);
  F_BasesUpdateEnd        := RegisterNotifier(NT_BASE_UPDATE_END);
  F_BaseUpdateFailed      := RegisterNotifier(NT_BASE_UPDATE_FAILED);
  F_ConsultationReceived  := RegisterNotifier(NT_CONSULTATION_RECEIVED);
  F_ConsultationNotSent   := RegisterNotifier(NT_CONSULTATION_NOT_SENT);
  F_NoSubscription        := RegisterNotifier(NT_NO_SUBSCRIPTION);
//#UC END# *4AC20023031C_4AC2000A021C_impl*
end;//TatNotifierFacade.Create
// start class TatGblAdapterWorker

function TatGblAdapterWorker.pm_GetCommon: ICommon;
//#UC START# *4AC218D80016_483C0B6B0167get_var*
//#UC END# *4AC218D80016_483C0B6B0167get_var*
begin
//#UC START# *4AC218D80016_483C0B6B0167get_impl*
  if (f_Common = nil) then
    Raise Exception.Create('f_Common = nil');
  Result := f_Common;
//#UC END# *4AC218D80016_483C0B6B0167get_impl*
end;//TatGblAdapterWorker.pm_GetCommon

function TatGblAdapterWorker.pm_GetMyDocuments: IFoldersNode;
//#UC START# *4AC21946039A_483C0B6B0167get_var*
//#UC END# *4AC21946039A_483C0B6B0167get_var*
begin
//#UC START# *4AC21946039A_483C0B6B0167get_impl*
  if NOT Assigned(f_MyDocuments) then
    f_MyDocuments := TatFoldersHelper.GetMyDocuments(Folders);
  Assert(f_MyDocuments <> nil, 'f_MyDocuments <> nil');
  Result := f_MyDocuments;
//#UC END# *4AC21946039A_483C0B6B0167get_impl*
end;//TatGblAdapterWorker.pm_GetMyDocuments

function TatGblAdapterWorker.pm_GetCRTreeRoot: INodeBase;
//#UC START# *4AC2196C0042_483C0B6B0167get_var*
//#UC END# *4AC2196C0042_483C0B6B0167get_var*
begin
//#UC START# *4AC2196C0042_483C0B6B0167get_impl*
  if (f_CRTreeRoot = nil) then
  begin
    f_CRTreeRoot := GblAdapterDll.MakeNodeBase('CRTree');
    Assert(f_CRTreeRoot <> nil, 'f_CRTreeRoot <> nil');
  end;
  Result := f_CRTreeRoot;
//#UC END# *4AC2196C0042_483C0B6B0167get_impl*
end;//TatGblAdapterWorker.pm_GetCRTreeRoot

function TatGblAdapterWorker.pm_GetMainMenuRoot: INodeBase;
//#UC START# *4B97915302A2_483C0B6B0167get_var*
//#UC END# *4B97915302A2_483C0B6B0167get_var*
begin
//#UC START# *4B97915302A2_483C0B6B0167get_impl*
  if (f_MainMenuRoot = nil) then
  begin
    f_MainMenuRoot := GblAdapterDll.MakeNodeBase('MainMenu');
    Assert(f_MainMenuRoot <> nil, 'f_MainMenuRoot <> nil');
  end;
  Result := f_MainMenuRoot;
//#UC END# *4B97915302A2_483C0B6B0167get_impl*
end;//TatGblAdapterWorker.pm_GetMainMenuRoot

constructor TatGblAdapterWorker.Create;
//#UC START# *4AC21A0B028E_483C0B6B0167_var*
//#UC END# *4AC21A0B028E_483C0B6B0167_var*
begin
//#UC START# *4AC21A0B028E_483C0B6B0167_impl*
  inherited;
  //
  InitAdapter;
  f_NotifierFacade := TatNotifierFacade.Create(f_GblAdapterDll.MakeNotifyManager);
  //
  while f_Authorization = nil do
    try
      f_Authorization := f_GblAdapterDll.MakeAuthorization;
    except
      on EXMLImportRunning do Sleep(100);
      else
        Raise;
    end;
  assert(f_Authorization <> nil, 'f_Authorization <> nil');
  f_IsLoggedIn := false;
//#UC END# *4AC21A0B028E_483C0B6B0167_impl*
end;//TatGblAdapterWorker.Create

procedure TatGblAdapterWorker.InitFieldsAfterLogin;
//#UC START# *4AC21A1E02DC_483C0B6B0167_var*
//#UC END# *4AC21A1E02DC_483C0B6B0167_var*
begin
//#UC START# *4AC21A1E02DC_483C0B6B0167_impl*
  Logger.Info('�������� Common');
  f_Common := f_GblAdapterDll.MakeCommon;
  assert(f_Common <> nil, 'Common <> nil!');
  Logger.Info('�������� Common');
  //
  Logger.Info('�������� ConfigurationManager');
  f_ConfigurationManager := f_GblAdapterDll.MakeConfigurationManager;
  assert(f_ConfigurationManager <> nil, 'f_ConfigurationManager <> nil');
  Logger.Info('�������� ConfigurationManager');
  //
  Logger.Info('�������� ConfigurationManager.GetActive');
  f_ConfigurationManager.GetActive(f_Configuration);
  assert(f_Configuration <> nil, 'f_Configuration <> nil');
  Logger.Info('������� ConfigurationManager.GetActive');
  //
  Logger.Info('�������� Configuration.GetSettings');
  f_Configuration.GetSettings(f_SettingsManager);
  assert(f_SettingsManager <> nil, 'f_SettingsManager <> nil');
  Logger.Info('������� Configuration.GetSettings');
  //
  Logger.Info('�������� Folders');
  f_Folders := f_GblAdapterDll.MakeFolders;
  assert(f_Folders <> nil, 'Folders <> nil');
  Logger.Info('�������� Folders');
  //
  if (NOT GblAdapterDll.MakeChatManager.IsEmbedChatEnabled) then
  begin
    Logger.Info('��� �� ��������');
    f_ChatWorker := nil;
  end
  else
  begin
    Logger.Info('��� ��������');
    f_ChatWorker := TatChatWorker.Create();
  end;
  //
  f_ControlManager := GblAdapterDll.MakeControlManager;
  ControlManager.SetControlledChangeNotifier(TatControlledChangeNotifier.Make);
  ControlManager.UpdateStatus(false);
//#UC END# *4AC21A1E02DC_483C0B6B0167_impl*
end;//TatGblAdapterWorker.InitFieldsAfterLogin

procedure TatGblAdapterWorker.InitAdapter;
//#UC START# *4AC21A3200BA_483C0B6B0167_var*
//#UC END# *4AC21A3200BA_483C0B6B0167_var*
begin
//#UC START# *4AC21A3200BA_483C0B6B0167_impl*
  Logger.Info('������ ���������������� �������');
  //
  f_GblAdapterDll := TGblAdapterDll.Make;
  //
  Logger.Info('������� MakeComponentManager.Start');
  f_GblAdapterDll.MakeComponentManager.Start;
  Logger.Info('������� MakeComponentManager.Start');
  //
  Logger.Info('��������� ���������������� �������');
//#UC END# *4AC21A3200BA_483C0B6B0167_impl*
end;//TatGblAdapterWorker.InitAdapter

procedure TatGblAdapterWorker.CloseAdapter;
//#UC START# *4AC21A3A02B0_483C0B6B0167_var*
//#UC END# *4AC21A3A02B0_483C0B6B0167_var*
begin
//#UC START# *4AC21A3A02B0_483C0B6B0167_impl*
  f_Authorization := nil;
  f_GblAdapterDll.MakeComponentManager.Stop;
//#UC END# *4AC21A3A02B0_483C0B6B0167_impl*
end;//TatGblAdapterWorker.CloseAdapter

class function TatGblAdapterWorker.Instance: TatGblAdapterWorker;
//#UC START# *4AC21A4903B0_483C0B6B0167_var*
//#UC END# *4AC21A4903B0_483C0B6B0167_var*
begin
//#UC START# *4AC21A4903B0_483C0B6B0167_impl*
  if NOT Assigned(gbl_AdapterWorkerInstance) then
    gbl_AdapterWorkerInstance := TatGblAdapterWorker.Create;
  Result := gbl_AdapterWorkerInstance;
//#UC END# *4AC21A4903B0_483C0B6B0167_impl*
end;//TatGblAdapterWorker.Instance

class procedure TatGblAdapterWorker.InstanceFree;
//#UC START# *4AC21A5D00D2_483C0B6B0167_var*
//#UC END# *4AC21A5D00D2_483C0B6B0167_var*
begin
//#UC START# *4AC21A5D00D2_483C0B6B0167_impl*
  if Assigned(gbl_AdapterWorkerInstance) then
    FreeAndNil(gbl_AdapterWorkerInstance);
//#UC END# *4AC21A5D00D2_483C0B6B0167_impl*
end;//TatGblAdapterWorker.InstanceFree

procedure TatGblAdapterWorker.Logout;
//#UC START# *4AC21A700102_483C0B6B0167_var*
//#UC END# *4AC21A700102_483C0B6B0167_var*
begin
//#UC START# *4AC21A700102_483C0B6B0167_impl*
  if NOT f_IsLoggedIn then Exit;
  Logger.Info('������ ������');
  //
  f_IsLoggedIn := false;
  FreeAndNil(f_ChatWorker);
  f_Common := nil;
  f_Folders := nil;
  f_MyDocuments := nil;
  f_SettingsManager := nil;
  f_ConfigurationManager := nil;
  f_Configuration := nil;
  f_SettingsManager := nil;
  f_CRTreeRoot := nil;
  f_MainMenuRoot := nil;
  f_ControlManager := nil;
  //
  if f_LoggedAs = tlasGuest then
    Authorization.LogoutWithoutXmlBackup
  else
    Authorization.Logout;
  //
  Logger.Info('������� ������� ������.');
//#UC END# *4AC21A700102_483C0B6B0167_impl*
end;//TatGblAdapterWorker.Logout

function TatGblAdapterWorker.ForceLogin(const anUserName: AnsiString;
  const aPassword: AnsiString): Boolean;
//#UC START# *4AC21A7F01E4_483C0B6B0167_var*
//#UC END# *4AC21A7F01E4_483C0B6B0167_var*
begin
//#UC START# *4AC21A7F01E4_483C0B6B0167_impl*
  if f_IsLoggedIn then
    if (f_LoggedAs <> tlasCommonUser) then
    begin
      Logger.Warning('��� ����������, �� �� ������� �������������. ���������� ������.');
      Logout;
    end
    else
    begin
      Result := f_IsLoggedIn;
      Exit;
    end;
  //
  Logger.Info('�������� ����������� � ������ "' + anUserName + '" � ������� "' + aPassword + '"');
  f_Common := nil;
  //
  try
    // �������� ������������������, � ������� ��� ����� ������������ ����
    Logger.Info('������� IAuthorization.Login');
    Authorization.Login( PAnsiChar(anUserName), PAnsiChar(aPassword) );
    Logger.Info('������� IAuthorization.Login');
    Logger.Info('������� ������������ ������������ �������������.');
  except
    on EWrongAuthentication do
    begin // ������ ������������ ����
      Logger.Info('������ ������������ ����, ����� ���������.');
      // ��������������
      Logger.Info('������� IAuthorization.Autoregistration');
      Authorization.Autoregistration(TAT_USER_NAME, PAnsiChar(anUserName), PAnsiChar(aPassword), '');
      Logger.Info('������� IAuthorization.Autoregistration');
      Logger.Info('������� �������.');
    end;
    on ex : EAlreadyLogged do
    begin // ��� ������������
      Logger.Error('����� ������������ ��� ���������. ����������: ' + ex.Message);
       Raise;
    end;
    else
      Raise;
  end;
  //
  InitFieldsAfterLogin;
  //
  TatUserJournalHelper.ReadHistory(5);
  //
  f_IsLoggedIn := true;
  f_LoggedAs := tlasCommonUser;
  Result := f_IsLoggedIn;
//#UC END# *4AC21A7F01E4_483C0B6B0167_impl*
end;//TatGblAdapterWorker.ForceLogin

function TatGblAdapterWorker.GuestLogin: AnsiString;
//#UC START# *4AC21AC9018C_483C0B6B0167_var*
  function GetLogin : String;
    var
      l_UserManager : IUserManager;
      l_UserProfile : IUserProfile;
      l_Login : IString;
  begin
    Logger.Info('�������� UserManager');
    l_UserManager := GblAdapterDll.MakeUserManager;
    Assert(l_UserManager <> nil, 'l_UserManager <> nil');
    Logger.Info('�������� UserManager');
    //
    Logger.Info('�������� UserManager.GetSelfProfile');
    l_UserManager.GetSelfProfile(l_UserProfile);
    Assert(l_UserProfile <> nil, 'l_UserProfile <> nil');
    Logger.Info('������� UserManager.GetSelfProfile');
    //
    Logger.Info('�������� UserProfile.GetLogin');
    l_UserProfile.GetLogin(l_Login);
    Assert(l_Login <> nil, 'l_Login <> nil');
    Result := String(l_Login.GetData);
    Logger.Info('������� UserProfile.GetLogin. ���������: %s', [Result]);
  end;
//#UC END# *4AC21AC9018C_483C0B6B0167_var*
begin
//#UC START# *4AC21AC9018C_483C0B6B0167_impl*
  Result := '';
  if f_IsLoggedIn then
    if f_LoggedAs <> tlasGuest then
    begin
      Logger.Warning('��� ����������, �� �� ������. ���������� ������.');
      Logout;
    end
    else
    begin
      Result := GetLogin;
      Exit;
    end;

  f_Common := nil;
  //
  Logger.Info('��������� ������');
  try
    Authorization.GuestLogin;
    Logger.Info('������� Authorization.GuestLogin');
  except
    Logger.Error('�� ���������� ������������ ������.');
    Raise;
  end;

  //
  Result := GetLogin;
  //
  InitFieldsAfterLogin;
  //
  Logger.Info('������� ������������ ������.');
  f_IsLoggedIn := true;
  f_LoggedAs := tlasGuest;
//#UC END# *4AC21AC9018C_483C0B6B0167_impl*
end;//TatGblAdapterWorker.GuestLogin

destructor TatGblAdapterWorker.Destroy;
//#UC START# *48077504027E_483C0B6B0167_var*
//#UC END# *48077504027E_483C0B6B0167_var*
begin
//#UC START# *48077504027E_483C0B6B0167_impl*
  Logout;
  //
  FreeAndNil(f_NotifierFacade);
  //
  CloseAdapter;
  inherited;
//#UC END# *48077504027E_483C0B6B0167_impl*
end;//TatGblAdapterWorker.Destroy
// start class TatControlledChangeNotifier

class function TatControlledChangeNotifier.Make: IControlledChangeNotifier;
var
 l_Inst : TatControlledChangeNotifier;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TatControlledChangeNotifier.Fire;
//#UC START# *45F118D40054_504FB0DC0131_var*
//#UC END# *45F118D40054_504FB0DC0131_var*
begin
//#UC START# *45F118D40054_504FB0DC0131_impl*
  Logger.Info('�����������: ��������� �� �������� ����������');
//#UC END# *45F118D40054_504FB0DC0131_impl*
end;//TatControlledChangeNotifier.Fire

initialization
//#UC START# *4AC224FF02C0*
//#UC END# *4AC224FF02C0*

finalization
//#UC START# *4AC1FEB6028B*
  TatGblAdapterWorker.InstanceFree;
//#UC END# *4AC1FEB6028B*

end.