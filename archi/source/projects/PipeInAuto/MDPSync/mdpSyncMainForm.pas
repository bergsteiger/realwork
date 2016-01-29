unit mdpSyncMainForm;

interface

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, vtSpin, ComCtrls, ExtCtrls, ddProgressobj, VConst,
  AppEvnts, Menus, dtIntf, dt_DictTypes, mdpSourceSync;

type
  TMDPSyncForm = class(TForm{$IFNDEF MDP_TEST}, IDictChangeNotifyRecipient{$ENDIF})
    ImportProgress: TProgressBar;
    SyncNowButton: TButton;
    TimeoutTimer: TTimer;
    StartSyncButton: TButton;
    TimerProgress: TProgressBar;
    Button1: TButton;
    StaticText1: TStaticText;
    DoMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StartSyncButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure SyncNowButtonClick(Sender: TObject);
    procedure TimeTimer(Sender: TObject);
  private
    f_DefTimeOut: Integer;
    f_Locked: Boolean;
    f_Progressor: TddProgressObject;
    f_TimeOut: Integer;
    {$IFNDEF MDP_TEST}
    function CheckRegion: Boolean;
    {$ENDIF}
    procedure DestroyConfig;
    procedure DoWork;
    procedure MakeConfig;
    procedure pm_SetTimeOut(const Value: Integer);
    procedure ProgressProc(Sender: TObject; aTotalPercent: Integer);
    procedure SendSourceDict(const aSrcList: ISab = nil; aOperation: TmssOperation = ssoAll);
    procedure Start;
    procedure Stop;
    procedure UpdateInfo;
    procedure wmLogoff(var Message: TMessage); message wm_Logoff;
    { Private declarations }
    {$IFNDEF MDP_TEST}
    procedure dcn_DictionaryChange(const aInfo : TDictMessageRec);
    {$ENDIF}
  protected
    procedure Lock;
    procedure Unlock;
  public
    property Locked: Boolean read f_Locked;
    property TimeOut: Integer read f_TimeOut write pm_SetTimeOut;
    { Public declarations }
  end;

var
  MDPSyncForm: TMDPSyncForm;

implementation

uses
  l3Types,
  l3Stream,
  {$IFNDEF MDP_TEST}
  ddhtinit,
  ddBaseEngine,
  ddClientBaseEngine, dt_Serv, alcuMailServer, alcuUtils,
  Dt_Types, DT_DICT, DT_Const, Dt_DictConst,
  daTypes, Dt_Sab,
  {$ENDIF}

  alcuMDP, csProcessTask, ddAppConfig, l3Base, ddUtils, l3IniFile, ddAppConfigTypes,
  StrUtils, Math, csUserRequestManager, daDataProvider, vtVerInf

  

  ;

{$R *.dfm}

procedure TMDPSyncForm.ApplicationEvents1Idle(Sender: TObject; var Done:
    Boolean);
begin
 UpdateInfo;
end;

procedure TMDPSyncForm.Button1Click(Sender: TObject);
begin
 Stop;
 if ddAppConfiguration.ShowDialog() then
  ddAppConfiguration.Save;
 Start; 
end;

{$IFNDEF MDP_TEST}
function TMDPSyncForm.CheckRegion: Boolean;
var
 l_Ini: TCfgList;
begin
 Result := False;
 if GlobalDataProvider.RegionID = 0 then
 begin
  l_Ini := TCfgList.Create;
  try
   l_Ini.Section := 'Security';
   if l_Ini.ReadParamBoolDef('AllowZeroRegion', False) then
    Result := True;
  finally
   FreeAndNil(l_Ini);
  end;
 end
 else
  Result := True;
end;
{$ENDIF MDP_TEST}

{$IFNDEF MDP_TEST}
procedure TMDPSyncForm.dcn_DictionaryChange(const aInfo : TDictMessageRec);
var
 l_Sab: ISab;
 l_Op: TmssOperation;
begin
{$IFDEF MDPSyncStandAlone}
 if (aInfo.Family = CurrentFamily) and
    (aInfo.DictType = da_dlSources) and
    (aInfo.Operation in [atAdd,atDelete,atEdit,atMove]) then
 begin
  l_Sab := MakeValueSet(DictServer(CurrentFamily).DictTbl[da_dlSources], dtIDFld, @aInfo.ID, 1);
  case aInfo.Operation of
   atAdd   : l_Op := ssoNew;
   atDelete: l_Op := ssoDel;
  else
   l_Op := ssoUpd;
  end;
  SendSourceDict(l_Sab, l_Op);
 end;
{$ENDIF MDPSyncStandAlone}
end;
{$ENDIF MDP_TEST}

procedure TMDPSyncForm.DestroyConfig;
begin
 ddAppConfiguration.Save;
 FreeAndNil(ddAppConfiguration);
end;

procedure TMDPSyncForm.DoWork;
begin
 //alcuMail.SendEmail('zhuchkov@garant.ru', 'TEST', 'test message from MPDSync');
 //Exit;

{$IFDEF MDPSyncStandAlone}
 if not Locked then
 begin
  Lock;
  with TalcuMDPSyncronizer.Create do
  try
   Execute(f_Progressor, ddAppConfiguration.AsInteger['mdpMaxCount'], ddAppConfiguration.AsString['mdpMail'], ddAppConfiguration.AsString['mdpErrorMail']);
  finally
   Free;
   Unlock;
  end;
 end; // not Locked
{$ENDIF MDPSyncStandAlone}
end;

procedure TMDPSyncForm.FormCreate(Sender: TObject);
begin
{$IFDEF MDPSyncStandAlone}
 l3System.Str2Log('');
 l3System.Msg2Log('����� ����������');
 l3System.Msg2Log(vtGetProgramVersion);
 MakeConfig;
 with ddAppConfiguration do
 begin
  {$IFNDEF MDP_TEST}
  if InitBaseEngine(AsString['alcuIP'], AsInteger['alcuPort'], asString['alcuLogin'], AsString['alcuPassword'], True{aQuietMode}) then
  begin
   // ���� ���������� ��������� �� ����� �����������
   if not CheckRegion then
   begin
    MessageDlg('���������� ��� �������', mtError, [mbOk], 0);
    DestroyConfig;
    DoneClientBaseEngine;
    Application.Terminate;
    Exit;
   end;
   AsString['alcuIP']:= g_BaseEngine.ServerHostName;
   AsInteger['alcuPort']:= g_BaseEngine.ServerPort;
   AsString['alcuLogin']:= g_BaseEngine.Login;
   AsString['alcuPassword']:= g_BaseEngine.Password;
   Save;
   DictServer(CurrentFamily).AddDictChangeNotifiedObj(Self);
   SendSourceDict;
  {$ENDIF}
   f_Progressor:= TddProgressObject.Create();
   f_Progressor.OnUpdate:= ProgressProc;
   UnLock;
   UserRequestManager.ShowTextMessages:= False;
   SyncNowButton.Enabled:= True;
   StartSyncButton.Enabled:= True;
   if AsBoolean['mdpAutoSync'] then
    StartSyncButtonClick(self);
   UpdateInfo;

//   alcuMail.CheckUnsendedMail;
  {$IFNDEF MDP_TEST}
  end
  else
  begin
   DestroyConfig;
   Application.terminate;
  end;
  {$ENDIF}
 end; // with ddAppConfiguration
{$ELSE MDPSyncStandAlone}
 StaticText1.Caption := '���������� ��������� � ������ - ������������ ���';
 l3System.Msg2Log(StaticText1.Caption);
{$ENDIF MDPSyncStandAlone}
end;

procedure TMDPSyncForm.StartSyncButtonClick(Sender: TObject);
begin
 if StartSyncButton.Tag = 0 then
 begin
  StartSyncButton.Tag:= 1;
  StartSyncButton.Caption:= '����';
  Start;
 end
 else
 begin
  StartSyncButton.Tag:= 0;
  StartSyncButton.Caption:= '�����';
  Stop;
 end
end;

procedure TMDPSyncForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{$IFDEF MDPSyncStandAlone}
 Stop;
 DestroyConfig;
 {$IFNDEF MDP_TEST}
 DictServer(CurrentFamily).DelDictChangeNotifiedObj(Self);
 DoneClientBaseEngine;
 {$ENDIF}
 FreeAndNil(f_Progressor);
 l3System.Msg2Log('���������� �����������');
{$ENDIF MDPSyncStandAlone}
end;

procedure TMDPSyncForm.Lock;
begin
 f_Locked:= True;
 TimeoutTimer.Enabled:= False;
end;

procedure TMDPSyncForm.MakeConfig;
var
 l_Item: TddBaseConfigItem;
begin
 ddAppConfiguration:= TddAppConfiguration.Create();
 with ddAppConfiguration do
 begin
  // Archi
  AddNode('archi', '������ �������������');
   LabelTop:= False;
   AddStringItem('alcuIP', 'IP �������', '10.50.128.2');
   AddIntegerItem(l3CStr('alcuPort'), l3CStr('���� �������'), 32100);
   AddStringItem('alcuLogin', '�����', 'tech1');
   AddStringItem('alcuPassword', '������', '');
    PasswordChar:= '*';
   AddStringItem('BaseID', 'ID ����', '');
  // MDP
  AddNode('mdpSync', 'C������������ � MDP');
   LabelTop:= False;
  AddStringItem('mdpMail', '���������� �����������');
  AddStringItem('mdpErrorMail', '���������� ������ ������');
  AddIntegerItem(l3CStr('mdpSyncInterval'), l3CStr('������������������ ������|�����'), 10);
  AddBooleanItem(l3CStr('mdpAutoSync'), l3CStr('�������������� ����� �������������'), True);
  AddIntegerItem(l3CStr('mdpMaxCount'), l3CStr('�������� ���������� �� ���� ���'), 70);

  // ������������� ����������
  AddNode('SourceSync', 'C������������ ���');
   LabelTop:= False;
  AddStringItem('ssURL', 'URL �������������','http://gardoc.garant.ru/plugins/servlet/gar-rest/ogv-synonyms');
  l_Item := AddBooleanItem(l3CStr('ssUseProxy'), l3CStr('������������ ������'));
  //Enabled := False;
   AddStringItem('ssProxyServer', '������ ������','',l_Item);
   AddIntegerItem(l3CStr('ssProxyPort'), l3CStr('���� ������'), 8080, l_Item);
    MinValue:= 1;
    MaxValue:= 65000;
   AddStringItem('ssProxyLogin', '�����', '', l_Item);
   AddStringItem('ssProxyPassword', '������', '', l_Item);
   PasswordChar:= '*';

(*
  // ��������
  AddNode('Notification', '�����������');
  LabelTop:= False;
  AddStringItem('SMTPAddress', '�������� �����');
  AddStringItem('SMTPHost', '������ SMTP', 'smtp.garant.ru');
  LabelTop:= False;
  AddIntegerItem(l3CStr('SMTPPort'), l3CStr('���� SMTP'), 25);
   MinValue:= 1;
   MaxValue:= 65000;
  l_Item := AddBooleanItem(l3CStr('Authentication'), l3CStr('��������� �����������'));
  AddStringItem('SMTPLogin', '�����', '', l_Item);
   LabelTop:= False;
  AddStringItem('SMTPPassword', '������', '', l_Item);
   PasswordChar:= '*';
   LabelTop:= False;
  AddBooleanItem(l3CStr('SMTPRequireSSL'), l3CStr('������������ ���������� SSL'));
  AddFolderNameItem('SmtpSendQueueFolder', '����� ��� �������� �������������� �����', IncludeTrailingPathDelimiter(ChangeFileExt(ParamStr(0),'.mail')), nil, False);
   LabelTop := True;
  AddBooleanItem(l3CStr('SMTPReply'), l3CStr('����������� ������'));
  AddStringItem('SMTPForward', '����� ���������', '');
*)
  // �������
  AddNode('Debug', '�������');
  LabelTop:= False;
  AddIntegerItem(l3CStr('mdpLogMessageLevel'), l3CStr('������� ����������� �������'), 0);
   MinValue:= 0;
   MaxValue:= 5;
  Load;
 end;
end;

procedure TMDPSyncForm.N1Click(Sender: TObject);
begin
 DoWork;
end;

procedure TMDPSyncForm.N2Click(Sender: TObject);
begin
 SendSourceDict;
end;

procedure TMDPSyncForm.ProgressProc(Sender: TObject; aTotalPercent: Integer);
begin
 ImportProgress.Position:= IfThen(aTotalPercent < 100, aTotalPercent, 0);
 Application.ProcessMessages;
end;

procedure TMDPSyncForm.Start;
begin
 f_DefTimeOut:= ddAppConfiguration.AsInteger['mdpSyncInterval']*60*1000;
 TimerProgress.Max:= f_DefTimeOut;
 TimeOut:= f_DefTimeOut;
 TimeoutTimer.Enabled:= True;
 l3System.MessageLevel := ddAppConfiguration.AsInteger['mdpLogMessageLevel'];
end;

procedure TMDPSyncForm.Stop;
begin
 TimeoutTimer.Enabled:= False;
end;

procedure TMDPSyncForm.SyncNowButtonClick(Sender: TObject);
var
 l_Pos: TPoint;
begin
 l_Pos := ClientToScreen(Point(SyncNowButton.Left, SyncNowButton.Top + SyncNowButton.Height + 1));
 DoMenu.Popup(l_Pos.X, l_Pos.Y);
end;

procedure TMDPSyncForm.TimeTimer(Sender: TObject);
begin
 TimeOut:= TimeOut - TimeOutTimer.Interval;
 if TimeOut = 0 then
 begin
  DoWork;
  TimeOut:= f_DefTimeOut;
 end; // TimeOut = 0
 UpdateInfo;
end;

procedure TMDPSyncForm.pm_SetTimeOut(const Value: Integer);
begin
 f_TimeOut := Value;
 TimerProgress.Position:= f_TimeOut;
end;

procedure TMDPSyncForm.SendSourceDict(const aSrcList: ISab = nil; aOperation: TmssOperation = ssoAll);
var
 l_URL: AnsiString;
 l_ProxyRec: TmssProxySettingsRec;
 l_PProxy  : PmssProxySettingsRec;
begin
{$IFDEF MDPSyncStandAlone}
 l_URL := ddAppConfiguration.AsString['ssURL'];
 if l_URL <> '' then
 begin
  l_PProxy := nil;
  if ddAppConfiguration.AsBoolean['ssUseProxy'] then
  begin
   l_ProxyRec.rServer := ddAppConfiguration.AsString['ssProxyServer'];
   l_ProxyRec.rPort   := ddAppConfiguration.AsInteger['ssProxyPort'];
   l_ProxyRec.rLogin := ddAppConfiguration.AsString['ssProxyLogin'];
   l_ProxyRec.rPassword := ddAppConfiguration.AsString['ssProxyPassword'];
   l_PProxy := @l_ProxyRec;
  end;
  SyncSources(l_URL, l_PProxy, aOperation, aSrcList);
 end
 else
  l3System.Msg2Log('�� ���������� ��������� ������������� ���!');
{$ENDIF MDPSyncStandAlone}
end;

procedure TMDPSyncForm.Unlock;
begin
 f_Locked:= False;
 TimeoutTimer.Enabled:= True;
end;

procedure TMDPSyncForm.UpdateInfo;
begin
 UserRequestManager.ProcessNotifyList;
 StaticText1.Caption:= IfThen(StartSyncButton.tag = 0,
                               '������������� �� ��������',
                               Format('������������� ����� %s', [TimeSec2Str(TimeOut div 1000)]));
 Application.ProcessMessages;                              
end;

procedure TMDPSyncForm.wmLogoff(var Message: TMessage);
begin
 Close;
end;

end.
