unit PrimF1Res;
 {* ������� ���������� F1 }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimF1Res.pas"
// ���������: "VCMApplication"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , F1LikeRes
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(Admin)}
 , nsQueryInterfaces
 {$IfEnd} // NOT Defined(Admin)
 , SearchUnit
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
 , F1_Application_Template_InternalOperations_Controls
 , l3MessageID
;

const
 {* ������������ ������ Local }
 str_MayExit: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'MayExit'; rValue : '�� �������, ��� ������ ������� ������� %s?');
  {* '�� �������, ��� ������ ������� ������� %s?' }
 str_ApplicationName: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ApplicationName'; rValue : '������');
  {* '������' }
 str_MayExit_CheckCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MayExit_CheckCaption'; rValue : '������ �������� ��� �������������');
 str_MayExit_SettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MayExit_SettingsCaption'; rValue : '����� �� �������');
 str_MayExit_LongHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MayExit_LongHint'; rValue : '������������� ��� ������ �� �������');

const
 {* ������������ ������ NemesisTitle }
 str_NemesisTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'NemesisTitle'; rValue : '������ ����');
  {* '������ ����' }

type
 TPrimMainForm = class(TMainPrimForm)
  {* ������� �����. ����� ��� ���� ���������� F1 }
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* ������������� �����. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function NeedTerminateOnExit: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function AskMayExit: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCL)}
   procedure DoShow; override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure ActivateDefKeyboardLayout; override;
 end;//TPrimMainForm

 TPrimMainOptionsForm = class(TPrimMainForm)
  public
   procedure HelpTopics; override;
 end;//TPrimMainOptionsForm

 TPrimF1Res = {abstract} class(TF1LikeRes)
  {* ������� ���������� F1 }
  protected
   class procedure InitDefaults;
   class function CanRun(aLogo: TCustomForm): Boolean;
   class function GlobalInit(aLogo: TCustomForm;
    var theSplash: IUnknown): Boolean;
   class function RunOtherProcesses: Boolean; virtual;
   class function DoGlobalInit(aLogo: TCustomForm;
    var theSplash: IUnknown): Boolean; virtual;
   class procedure DoRun(var theSplash: IUnknown); virtual;
   class procedure LogUserActivity(aKind: TvcmOperationCallType);
   {$If NOT Defined(NoVCM)}
   class procedure Runner(const aTitle: Tl3StringIDEx;
    const aHelpFile: AnsiString); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   class procedure MakeResources; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(Admin)}
   class procedure OpenQuery(aQueryType: TlgQueryType;
    const aQuery: IQuery;
    const aContainer: IvcmContainer); virtual;
   {$IfEnd} // NOT Defined(Admin)
 end;//TPrimF1Res

implementation

uses
 l3ImplUses
 , nsPrimCachedEvent
 , moLiteSearch
 , moRealCommon
 , vtStdRes
 , nsStartupSupport
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , DebugStr
 , TypInfo
 {$If Defined(Nemesis)}
 , F1_Schema
 {$IfEnd} // Defined(Nemesis)
 , nsSettings
 , nsContextFilterEventListener
 , evdSchema
 , l3ConstStrings
 , l3SysUtils
 , Logo_Form
 , nsAppTitleData
 , f1StartupCompletedService
 , BaseTypesUnit
 , evDocumentsCache
 {$If NOT Defined(NoVCM)}
 , vcmHistory
 {$IfEnd} // NOT Defined(NoVCM)
 , Windows
 , afwConsts
 , afwFacade
 , l3Base
 , DataAdapter
 , StartUnit
 , SPHTMLHelp
 , GblAdapter
 , SysUtils
 , F1Like_FormDefinitions_Controls
 , nsCustomStyleProcessor
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , LoggingUnit
 {$If NOT Defined(NoVCM)}
 , vtNavigator
 {$IfEnd} // NOT Defined(NoVCM)
 , nsConst
;

type
 TnsActiviryArray = array [TvcmOperationCallType] of Cardinal;

 TnsUserOperationEvent = {final} class(TnsPrimCachedEvent)
  private
   f_Counters: TnsActiviryArray;
  private
   procedure Log(aKind: TvcmOperationCallType); virtual;
  protected
   procedure DoFireLog; override;
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TnsUserOperationEvent;
    {* ����� ��������� ���������� ���������� TnsUserOperationEvent }
 end;//TnsUserOperationEvent

var g_TnsUserOperationEvent: TnsUserOperationEvent = nil;
 {* ��������� ���������� TnsUserOperationEvent }

const
 {* �������� ������ ��� ������� MayExit }
 str_MayExit_Choice_Exit: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MayExit_Choice_Exit'; rValue : '�����');
  {* '�����' }
 str_MayExit_Choice_Stay: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MayExit_Choice_Stay'; rValue : '���������� ������');
  {* '���������� ������' }

const
 {* ������������ ������ Local }
 str_ApplicationLoading: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ApplicationLoading'; rValue : '��� ��������...');
  {* '��� ��������...' }
 str_FullVersionMessage: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'FullVersionMessage'; rValue : '������ %s');
  {* '������ %s' }

procedure TnsUserOperationEventFree;
 {* ����� ������������ ���������� ���������� TnsUserOperationEvent }
begin
 l3Free(g_TnsUserOperationEvent);
end;//TnsUserOperationEventFree

{$If NOT Defined(NoVCM)}
procedure TPrimMainForm.DoInit(aFromHistory: Boolean);
 {* ������������� �����. ��� ���������� � �������� }
//#UC START# *49803F5503AA_4A92BD85004D_var*
//#UC END# *49803F5503AA_4A92BD85004D_var*
begin
//#UC START# *49803F5503AA_4A92BD85004D_impl*
 !!! Needs to be implemented !!!
//#UC END# *49803F5503AA_4A92BD85004D_impl*
end;//TPrimMainForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimMainForm.NeedTerminateOnExit: Boolean;
//#UC START# *4ADDD31E0091_4A92BD85004D_var*
//#UC END# *4ADDD31E0091_4A92BD85004D_var*
begin
//#UC START# *4ADDD31E0091_4A92BD85004D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADDD31E0091_4A92BD85004D_impl*
end;//TPrimMainForm.NeedTerminateOnExit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimMainForm.AskMayExit: Boolean;
//#UC START# *4ADDD5A30139_4A92BD85004D_var*
//#UC END# *4ADDD5A30139_4A92BD85004D_var*
begin
//#UC START# *4ADDD5A30139_4A92BD85004D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADDD5A30139_4A92BD85004D_impl*
end;//TPrimMainForm.AskMayExit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCL)}
procedure TPrimMainForm.DoShow;
//#UC START# *4B321D1301DD_4A92BD85004D_var*
//#UC END# *4B321D1301DD_4A92BD85004D_var*
begin
//#UC START# *4B321D1301DD_4A92BD85004D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B321D1301DD_4A92BD85004D_impl*
end;//TPrimMainForm.DoShow
{$IfEnd} // NOT Defined(NoVCL)

procedure TPrimMainForm.ActivateDefKeyboardLayout;
//#UC START# *4F71FA8102BF_4A92BD85004D_var*
//#UC END# *4F71FA8102BF_4A92BD85004D_var*
begin
//#UC START# *4F71FA8102BF_4A92BD85004D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F71FA8102BF_4A92BD85004D_impl*
end;//TPrimMainForm.ActivateDefKeyboardLayout

procedure TnsUserOperationEvent.Log(aKind: TvcmOperationCallType);
//#UC START# *4B14F21C029D_4B14F1AB03A0_var*
//#UC END# *4B14F21C029D_4B14F1AB03A0_var*
begin
//#UC START# *4B14F21C029D_4B14F1AB03A0_impl*
 Inc(f_Counters[aKind]);
 RequestWrite;
//#UC END# *4B14F21C029D_4B14F1AB03A0_impl*
end;//TnsUserOperationEvent.Log

class function TnsUserOperationEvent.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsUserOperationEvent <> nil;
end;//TnsUserOperationEvent.Exists

procedure TnsUserOperationEvent.DoFireLog;
//#UC START# *4B13A1F202D9_4B14F1AB03A0_var*
var
 l_Data: InsLogEventData;
 l_NeedWrite: Boolean;
 l_IDX: TvcmOperationCallType;
//#UC END# *4B13A1F202D9_4B14F1AB03A0_var*
begin
//#UC START# *4B13A1F202D9_4B14F1AB03A0_impl*
 l_Data := MakeParamsList;
 l_NeedWrite := False;
 for l_IDX := Low(f_COunters) to High(f_Counters) do
 begin
  l_Data.AddULong(f_Counters[l_IDX]);
  if f_Counters[l_IDX] > 0 then
  begin
   f_Counters[l_IDX] := 0;
   l_NeedWrite := True;
  end;
 end;
 if l_NeedWrite then
  GetLogger.AddEvent(LE_USER_OPERATION, l_Data);
//#UC END# *4B13A1F202D9_4B14F1AB03A0_impl*
end;//TnsUserOperationEvent.DoFireLog

class function TnsUserOperationEvent.Instance: TnsUserOperationEvent;
 {* ����� ��������� ���������� ���������� TnsUserOperationEvent }
begin
 if (g_TnsUserOperationEvent = nil) then
 begin
  l3System.AddExitProc(TnsUserOperationEventFree);
  g_TnsUserOperationEvent := Create;
 end;
 Result := g_TnsUserOperationEvent;
end;//TnsUserOperationEvent.Instance

procedure TPrimMainOptionsForm.HelpTopics;
//#UC START# *4C8A27DA0087_4C8A210E018C_var*
//#UC END# *4C8A27DA0087_4C8A210E018C_var*
begin
//#UC START# *4C8A27DA0087_4C8A210E018C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A27DA0087_4C8A210E018C_impl*
end;//TPrimMainOptionsForm.HelpTopics

class procedure TPrimF1Res.InitDefaults;
//#UC START# *4AA7BAF10057_4A92BBDF0126_var*
//#UC END# *4AA7BAF10057_4A92BBDF0126_var*
begin
//#UC START# *4AA7BAF10057_4A92BBDF0126_impl*
 // �����������, ��� ������������ ���� ���������� � ���������
 g_afwPathSep := PROPERTY_PATH_DELIMITER;
 // make memory manager thread safe
 IsMultiThread := True;
 //
 g_vcmHistoryLimit := 10;
 g_evDocumentsCacheLimit := 15;
 //
 with Application do
  if (Handle <> HWND(0)) then
   SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or
     WS_EX_TOOLWINDOW);
     
  Application.HintHidePause := 15000; // ����� ������ ������ � �������
//#UC END# *4AA7BAF10057_4A92BBDF0126_impl*
end;//TPrimF1Res.InitDefaults

class function TPrimF1Res.CanRun(aLogo: TCustomForm): Boolean;
//#UC START# *4AA7D40B02F4_4A92BBDF0126_var*
//#UC END# *4AA7D40B02F4_4A92BBDF0126_var*
begin
//#UC START# *4AA7D40B02F4_4A92BBDF0126_impl*
 Result := true;
 if nsIsOtherPrimeOrShellRunning(aLogo) then
  Result := false
 else
  nsCheckRequiredFonts(aLogo);
//#UC END# *4AA7D40B02F4_4A92BBDF0126_impl*
end;//TPrimF1Res.CanRun

class function TPrimF1Res.GlobalInit(aLogo: TCustomForm;
 var theSplash: IUnknown): Boolean;
//#UC START# *4AA7DDA90337_4A92BBDF0126_var*
//#UC END# *4AA7DDA90337_4A92BBDF0126_var*
begin
//#UC START# *4AA7DDA90337_4A92BBDF0126_impl*
  Result := DoGlobalInit(aLogo, theSplash);
  Application.Initialize;
  SPCorrectHelpFileName;
//#UC END# *4AA7DDA90337_4A92BBDF0126_impl*
end;//TPrimF1Res.GlobalInit

class function TPrimF1Res.RunOtherProcesses: Boolean;
//#UC START# *4AA7C28A0113_4A92BBDF0126_var*
//#UC END# *4AA7C28A0113_4A92BBDF0126_var*
begin
//#UC START# *4AA7C28A0113_4A92BBDF0126_impl*
 Result := true;
 with TnsStartupSupport do
 begin
  repeat
   StartupPendingNotify;
   if (TryUnlockLogin or TrySwitchToOtherRunningCopy) then
   begin
    StartupCompletedNotify;
    Result := false;
    Exit;
   end;//TryUnlockLogin or TrySwitchToOtherRunningCopy
   StartupCompletedNotify;
  until (CheckAndCreateRunningCopyMutex);
  StartupPendingNotify;
 end;//with TnsStartupSupport
//#UC END# *4AA7C28A0113_4A92BBDF0126_impl*
end;//TPrimF1Res.RunOtherProcesses

class function TPrimF1Res.DoGlobalInit(aLogo: TCustomForm;
 var theSplash: IUnknown): Boolean;
//#UC START# *4AA7D7CA00FE_4A92BBDF0126_var*
//#UC END# *4AA7D7CA00FE_4A92BBDF0126_var*
begin
//#UC START# *4AA7D7CA00FE_4A92BBDF0126_impl*
 Result := true;
 try
  DataAdapter.GlobalInit(aLogo, afw.Application.LocaleInfo.Name);
  {$IfDef Monitorings}
  if not defDataAdapter.Monitoring.IsExist then
  begin
   aLogo.Hide;
   defDataAdapter.ShowMessageWithDealerInfo(err_PrimeNotAvaliable);
   Result := false;
   Exit;
  end;//not defDataAdapter.Monitoring.IsExist
  {$EndIf Monitorings}
 except
  on EAbort do
  begin
   l3System.CheckClipboard;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=121145106
   Result := false;
   Exit;
   // ����� ����� ������ ���, ����� ����������� ��� ������ ����������� (� ��������� ��, ������� ������� ��������� �����)
  end;//on EAbort
  on ECorbaException do
  begin
   aLogo.Hide;
   Application.HandleException(nil);
   TerminateProcess(GetCurrentProcess, 255);
  end;//on ECorbaException
  else
  begin
   aLogo.Hide;
   theSplash := nil;
   TerminateProcess(GetCurrentProcess, 255);
  end;
 end;//try..except
//#UC END# *4AA7D7CA00FE_4A92BBDF0126_impl*
end;//TPrimF1Res.DoGlobalInit

class procedure TPrimF1Res.DoRun(var theSplash: IUnknown);
//#UC START# *4AA7E4DC0047_4A92BBDF0126_var*
//#UC END# *4AA7E4DC0047_4A92BBDF0126_var*
begin
//#UC START# *4AA7E4DC0047_4A92BBDF0126_impl*
 // - ������ �� ������, ����� ������� �����������
//#UC END# *4AA7E4DC0047_4A92BBDF0126_impl*
end;//TPrimF1Res.DoRun

{$If NOT Defined(Admin)}
class procedure TPrimF1Res.OpenQuery(aQueryType: TlgQueryType;
 const aQuery: IQuery;
 const aContainer: IvcmContainer);
//#UC START# *4AC4A69D03B7_4A92BBDF0126_var*
//#UC END# *4AC4A69D03B7_4A92BBDF0126_var*
begin
//#UC START# *4AC4A69D03B7_4A92BBDF0126_impl*
 Assert(false);
//#UC END# *4AC4A69D03B7_4A92BBDF0126_impl*
end;//TPrimF1Res.OpenQuery
{$IfEnd} // NOT Defined(Admin)

class procedure TPrimF1Res.LogUserActivity(aKind: TvcmOperationCallType);
//#UC START# *4B14F1720053_4A92BBDF0126_var*
//#UC END# *4B14F1720053_4A92BBDF0126_var*
begin
//#UC START# *4B14F1720053_4A92BBDF0126_impl*
 TnsUserOperationEvent.Instance.Log(aKind);
//#UC END# *4B14F1720053_4A92BBDF0126_impl*
end;//TPrimF1Res.LogUserActivity

{$If NOT Defined(NoVCM)}
class procedure TPrimF1Res.Runner(const aTitle: Tl3StringIDEx;
 const aHelpFile: AnsiString);
//#UC START# *4F6AF5860291_4A92BBDF0126_var*
var
 l_Splash : IUnknown;
 l_Logo : TLogoForm;
//#UC END# *4F6AF5860291_4A92BBDF0126_var*
begin
//#UC START# *4F6AF5860291_4A92BBDF0126_impl*
 //l3SysUtils.ImmDisableIME;
 InitDefaults;
 if not RunOtherProcesses then
  Exit;

 // ������� ����� � ���������:
 l_Logo := TLogoForm.Create(nil);
 try
  l_Logo.UpdateLoadString(str_ApplicationLoading.AsCStr);
  {$IFDEF DEBUG}
  l_Logo.UpdateVerInfo(str_FullVersionMessage.AsCStr);
  {$ENDIF}
  l_Logo.Show;
  afw.ProcessMessages;

  // ��� ���� ����� ! {
  MakeResources;
  // } ��� ���� ����� !

  if not CanRun(l_Logo) then
   Exit;

  Application.HelpFile := aHelpFile;
  Application.Title := aTitle.AsStr;
  // ��� ���� �����! ����� ��� ���� ������/�����������/.. ���� �������� �� ����
  TnsAppTitleData.Instance.Title := aTitle.AsStr;
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=562594453
  if not GlobalInit(l_Logo, l_Splash) then
   Exit;
  try
   TnsContextFilterEventListener.Instance;
   DoRun(l_Splash);
   BeforeApplicationRun;
  except
   on E: ENoServer do
   begin
    if Assigned(l_Logo) then
      l_Logo.Hide;
    l_Splash := nil;
    TerminateProcess(GetCurrentProcess, 255);
   end;
   on E: Exception do
    defDataAdapter.GlobalExceptionRaised(nil, E);
  end;//try..except
 finally
  FreeAndNil(l_Logo);
 end;//try..finally

 TnsStartupSupport.StartupCompletedNotify;
 Tf1StartupCompletedService.Instance.StartupComplete;
 Application.Run;
//#UC END# *4F6AF5860291_4A92BBDF0126_impl*
end;//TPrimF1Res.Runner
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
class procedure TPrimF1Res.MakeResources;
//#UC START# *4F6AF5F00058_4A92BBDF0126_var*
//#UC END# *4F6AF5F00058_4A92BBDF0126_var*
begin
//#UC START# *4F6AF5F00058_4A92BBDF0126_impl*
 inherited;
//#UC END# *4F6AF5F00058_4A92BBDF0126_impl*
end;//TPrimF1Res.MakeResources
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_MayExit_Choice_Exit.Init;
 {* ������������� str_MayExit_Choice_Exit }
 str_MayExit_Choice_Stay.Init;
 {* ������������� str_MayExit_Choice_Stay }
 str_MayExit.Init;
!!! Lost Message ini !!!
 {* ������������� str_MayExit }
 str_ApplicationName.Init;
 {* ������������� str_ApplicationName }
 str_MayExit_CheckCaption.Init;
 {* ������������� str_MayExit_CheckCaption }
 str_MayExit_SettingsCaption.Init;
 {* ������������� str_MayExit_SettingsCaption }
 str_MayExit_LongHint.Init;
 {* ������������� str_MayExit_LongHint }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimMainForm);
 {* ����������� PrimMain }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimMainOptionsForm);
 {* ����������� PrimMainOptions }
{$IfEnd} // NOT Defined(NoScripts)
 str_ApplicationLoading.Init;
 {* ������������� str_ApplicationLoading }
 str_FullVersionMessage.Init;
 {* ������������� str_FullVersionMessage }
 str_NemesisTitle.Init;
 {* ������������� str_NemesisTitle }

end.
