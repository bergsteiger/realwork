unit NOT_COMPLETED_PrimF1Res;
 {* ������� ���������� F1 }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\NOT_COMPLETED_PrimF1Res.pas"
// ���������: "VCMApplication"
// ������� ������: "PrimF1" MUID: (4A92BBDF0126)
// ��� ����: "TPrimF1Res"

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
;

const
 {* ������������ ������ NemesisTitle }
 str_NemesisTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'NemesisTitle'; rValue : '������ ����');
  {* '������ ����' }

type
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
   procedure Loaded; override;
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
 , l3ExceptionsLog
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
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
 , LoggingUnit
 , PrimMain_Form
 , PrimMainOptions_Form
 , evExtFormat
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
 {$if not defined(Monitorings)}
 TnsUserOperationEvent.Instance.Log(aKind);
 {$ifend}
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

procedure TPrimF1Res.Loaded;
begin
 inherited;
end;//TPrimF1Res.Loaded

initialization
 str_ApplicationLoading.Init;
 {* ������������� str_ApplicationLoading }
 str_FullVersionMessage.Init;
 {* ������������� str_FullVersionMessage }
 str_NemesisTitle.Init;
 {* ������������� str_NemesisTitle }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimF1Res);
 {* ����������� PrimF1 }
{$IfEnd} // NOT Defined(NoScripts)

end.
