unit MainWindowKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� MainWindow }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainWindowKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "MainWindowKeywordsPack" MUID: (4AA7EA010274_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , MainWindow_Form
 , tfwPropertyLike
 {$If Defined(Nemesis)}
 , nscRemindersLine
 {$IfEnd} // Defined(Nemesis)
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 {$If Defined(Nemesis)}
 , nscReminder
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscStatusBar
 {$IfEnd} // Defined(Nemesis)
 , vtPanel
 , vtProportionalPanel
 , vtSizeablePanel
 {$If Defined(Nemesis)}
 , nscNavigator
 {$IfEnd} // Defined(Nemesis)
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwMainWindowRemindersLine = {final} class(TtfwPropertyLike)
  {* ����� ������� .TnsMainWindow.RemindersLine }
  private
   function RemindersLine(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscRemindersLine;
    {* ���������� ����� ������� .TnsMainWindow.RemindersLine }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainWindowRemindersLine

 TkwMainWindowControlledChangingWarning = {final} class(TtfwPropertyLike)
  {* ����� ������� .TnsMainWindow.ControlledChangingWarning }
  private
   function ControlledChangingWarning(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscReminder;
    {* ���������� ����� ������� .TnsMainWindow.ControlledChangingWarning }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainWindowControlledChangingWarning

 TkwMainWindowRemUnreadConsultations = {final} class(TtfwPropertyLike)
  {* ����� ������� .TnsMainWindow.remUnreadConsultations }
  private
   function remUnreadConsultations(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscReminder;
    {* ���������� ����� ������� .TnsMainWindow.remUnreadConsultations }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainWindowRemUnreadConsultations

 TkwMainWindowStatusBar = {final} class(TtfwPropertyLike)
  {* ����� ������� .TnsMainWindow.StatusBar }
  private
   function StatusBar(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscStatusBar;
    {* ���������� ����� ������� .TnsMainWindow.StatusBar }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainWindowStatusBar

 TkwMainWindowClientZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TnsMainWindow.ClientZone }
  private
   function ClientZone(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TvtPanel;
    {* ���������� ����� ������� .TnsMainWindow.ClientZone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainWindowClientZone

 TkwMainWindowMainZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TnsMainWindow.MainZone }
  private
   function MainZone(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TvtProportionalPanel;
    {* ���������� ����� ������� .TnsMainWindow.MainZone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainWindowMainZone

 TkwMainWindowParentZonePanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TnsMainWindow.ParentZonePanel }
  private
   function ParentZonePanel(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TvtPanel;
    {* ���������� ����� ������� .TnsMainWindow.ParentZonePanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainWindowParentZonePanel

 TkwMainWindowChildZonePanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TnsMainWindow.ChildZonePanel }
  private
   function ChildZonePanel(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TvtSizeablePanel;
    {* ���������� ����� ������� .TnsMainWindow.ChildZonePanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainWindowChildZonePanel

 TkwMainWindowBaseSearchPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TnsMainWindow.BaseSearchPanel }
  private
   function BaseSearchPanel(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TvtPanel;
    {* ���������� ����� ������� .TnsMainWindow.BaseSearchPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainWindowBaseSearchPanel

 TkwMainWindowLeftNavigator = {final} class(TtfwPropertyLike)
  {* ����� ������� .TnsMainWindow.LeftNavigator }
  private
   function LeftNavigator(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscNavigator;
    {* ���������� ����� ������� .TnsMainWindow.LeftNavigator }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainWindowLeftNavigator

{$If Defined(HasRightNavigator)}
 TkwMainWindowRightNavigator = {final} class(TtfwPropertyLike)
  {* ����� ������� .TnsMainWindow.RightNavigator }
  private
   function RightNavigator(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscNavigator;
    {* ���������� ����� ������� .TnsMainWindow.RightNavigator }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainWindowRightNavigator
{$IfEnd} // Defined(HasRightNavigator)

 Tkw_Form_MainWindow = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� MainWindow
----
*������ �������������*:
[code]�����::MainWindow TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_MainWindow

 Tkw_MainWindow_Control_RemindersLine = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RemindersLine
----
*������ �������������*:
[code]�������::RemindersLine TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_RemindersLine

 Tkw_MainWindow_Control_RemindersLine_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RemindersLine
----
*������ �������������*:
[code]�������::RemindersLine:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_RemindersLine_Push

 Tkw_MainWindow_Control_ControlledChangingWarning = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ControlledChangingWarning
----
*������ �������������*:
[code]�������::ControlledChangingWarning TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_ControlledChangingWarning

 Tkw_MainWindow_Control_ControlledChangingWarning_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ControlledChangingWarning
----
*������ �������������*:
[code]�������::ControlledChangingWarning:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_ControlledChangingWarning_Push

 Tkw_MainWindow_Control_remUnreadConsultations = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� remUnreadConsultations
----
*������ �������������*:
[code]�������::remUnreadConsultations TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_remUnreadConsultations

 Tkw_MainWindow_Control_remUnreadConsultations_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� remUnreadConsultations
----
*������ �������������*:
[code]�������::remUnreadConsultations:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_remUnreadConsultations_Push

 Tkw_MainWindow_Control_StatusBar = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� StatusBar
----
*������ �������������*:
[code]�������::StatusBar TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_StatusBar

 Tkw_MainWindow_Control_StatusBar_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� StatusBar
----
*������ �������������*:
[code]�������::StatusBar:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_StatusBar_Push

 Tkw_MainWindow_Control_ClientZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ClientZone
----
*������ �������������*:
[code]�������::ClientZone TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_ClientZone

 Tkw_MainWindow_Control_ClientZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ClientZone
----
*������ �������������*:
[code]�������::ClientZone:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_ClientZone_Push

 Tkw_MainWindow_Control_MainZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� MainZone
----
*������ �������������*:
[code]�������::MainZone TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_MainZone

 Tkw_MainWindow_Control_MainZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� MainZone
----
*������ �������������*:
[code]�������::MainZone:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_MainZone_Push

 Tkw_MainWindow_Control_ParentZonePanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ParentZonePanel
----
*������ �������������*:
[code]�������::ParentZonePanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_ParentZonePanel

 Tkw_MainWindow_Control_ParentZonePanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ParentZonePanel
----
*������ �������������*:
[code]�������::ParentZonePanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_ParentZonePanel_Push

 Tkw_MainWindow_Control_ChildZonePanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ChildZonePanel
----
*������ �������������*:
[code]�������::ChildZonePanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_ChildZonePanel

 Tkw_MainWindow_Control_ChildZonePanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ChildZonePanel
----
*������ �������������*:
[code]�������::ChildZonePanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_ChildZonePanel_Push

 Tkw_MainWindow_Control_BaseSearchPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BaseSearchPanel
----
*������ �������������*:
[code]�������::BaseSearchPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_BaseSearchPanel

 Tkw_MainWindow_Control_BaseSearchPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BaseSearchPanel
----
*������ �������������*:
[code]�������::BaseSearchPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_BaseSearchPanel_Push

 Tkw_MainWindow_Control_LeftNavigator = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LeftNavigator
----
*������ �������������*:
[code]�������::LeftNavigator TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_LeftNavigator

 Tkw_MainWindow_Control_LeftNavigator_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� LeftNavigator
----
*������ �������������*:
[code]�������::LeftNavigator:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_LeftNavigator_Push

{$If Defined(HasRightNavigator)}
 Tkw_MainWindow_Control_RightNavigator = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RightNavigator
----
*������ �������������*:
[code]�������::RightNavigator TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_RightNavigator
{$IfEnd} // Defined(HasRightNavigator)

{$If Defined(HasRightNavigator)}
 Tkw_MainWindow_Control_RightNavigator_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RightNavigator
----
*������ �������������*:
[code]�������::RightNavigator:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_RightNavigator_Push
{$IfEnd} // Defined(HasRightNavigator)

function TkwMainWindowRemindersLine.RemindersLine(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TnscRemindersLine;
 {* ���������� ����� ������� .TnsMainWindow.RemindersLine }
begin
 Result := aMainWindow.RemindersLine;
end;//TkwMainWindowRemindersLine.RemindersLine

class function TkwMainWindowRemindersLine.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.RemindersLine';
end;//TkwMainWindowRemindersLine.GetWordNameForRegister

function TkwMainWindowRemindersLine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscRemindersLine);
end;//TkwMainWindowRemindersLine.GetResultTypeInfo

function TkwMainWindowRemindersLine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainWindowRemindersLine.GetAllParamsCount

function TkwMainWindowRemindersLine.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowRemindersLine.ParamsTypes

procedure TkwMainWindowRemindersLine.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� RemindersLine', aCtx);
end;//TkwMainWindowRemindersLine.SetValuePrim

procedure TkwMainWindowRemindersLine.DoDoIt(const aCtx: TtfwContext);
var l_aMainWindow: TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RemindersLine(aCtx, l_aMainWindow));
end;//TkwMainWindowRemindersLine.DoDoIt

function TkwMainWindowControlledChangingWarning.ControlledChangingWarning(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TnscReminder;
 {* ���������� ����� ������� .TnsMainWindow.ControlledChangingWarning }
begin
 Result := aMainWindow.ControlledChangingWarning;
end;//TkwMainWindowControlledChangingWarning.ControlledChangingWarning

class function TkwMainWindowControlledChangingWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.ControlledChangingWarning';
end;//TkwMainWindowControlledChangingWarning.GetWordNameForRegister

function TkwMainWindowControlledChangingWarning.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscReminder);
end;//TkwMainWindowControlledChangingWarning.GetResultTypeInfo

function TkwMainWindowControlledChangingWarning.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainWindowControlledChangingWarning.GetAllParamsCount

function TkwMainWindowControlledChangingWarning.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowControlledChangingWarning.ParamsTypes

procedure TkwMainWindowControlledChangingWarning.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ControlledChangingWarning', aCtx);
end;//TkwMainWindowControlledChangingWarning.SetValuePrim

procedure TkwMainWindowControlledChangingWarning.DoDoIt(const aCtx: TtfwContext);
var l_aMainWindow: TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ControlledChangingWarning(aCtx, l_aMainWindow));
end;//TkwMainWindowControlledChangingWarning.DoDoIt

function TkwMainWindowRemUnreadConsultations.remUnreadConsultations(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TnscReminder;
 {* ���������� ����� ������� .TnsMainWindow.remUnreadConsultations }
begin
 Result := aMainWindow.remUnreadConsultations;
end;//TkwMainWindowRemUnreadConsultations.remUnreadConsultations

class function TkwMainWindowRemUnreadConsultations.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.remUnreadConsultations';
end;//TkwMainWindowRemUnreadConsultations.GetWordNameForRegister

function TkwMainWindowRemUnreadConsultations.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscReminder);
end;//TkwMainWindowRemUnreadConsultations.GetResultTypeInfo

function TkwMainWindowRemUnreadConsultations.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainWindowRemUnreadConsultations.GetAllParamsCount

function TkwMainWindowRemUnreadConsultations.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowRemUnreadConsultations.ParamsTypes

procedure TkwMainWindowRemUnreadConsultations.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� remUnreadConsultations', aCtx);
end;//TkwMainWindowRemUnreadConsultations.SetValuePrim

procedure TkwMainWindowRemUnreadConsultations.DoDoIt(const aCtx: TtfwContext);
var l_aMainWindow: TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(remUnreadConsultations(aCtx, l_aMainWindow));
end;//TkwMainWindowRemUnreadConsultations.DoDoIt

function TkwMainWindowStatusBar.StatusBar(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TnscStatusBar;
 {* ���������� ����� ������� .TnsMainWindow.StatusBar }
begin
 Result := aMainWindow.StatusBar;
end;//TkwMainWindowStatusBar.StatusBar

class function TkwMainWindowStatusBar.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.StatusBar';
end;//TkwMainWindowStatusBar.GetWordNameForRegister

function TkwMainWindowStatusBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscStatusBar);
end;//TkwMainWindowStatusBar.GetResultTypeInfo

function TkwMainWindowStatusBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainWindowStatusBar.GetAllParamsCount

function TkwMainWindowStatusBar.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowStatusBar.ParamsTypes

procedure TkwMainWindowStatusBar.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� StatusBar', aCtx);
end;//TkwMainWindowStatusBar.SetValuePrim

procedure TkwMainWindowStatusBar.DoDoIt(const aCtx: TtfwContext);
var l_aMainWindow: TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(StatusBar(aCtx, l_aMainWindow));
end;//TkwMainWindowStatusBar.DoDoIt

function TkwMainWindowClientZone.ClientZone(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TvtPanel;
 {* ���������� ����� ������� .TnsMainWindow.ClientZone }
begin
 Result := aMainWindow.ClientZone;
end;//TkwMainWindowClientZone.ClientZone

class function TkwMainWindowClientZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.ClientZone';
end;//TkwMainWindowClientZone.GetWordNameForRegister

function TkwMainWindowClientZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMainWindowClientZone.GetResultTypeInfo

function TkwMainWindowClientZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainWindowClientZone.GetAllParamsCount

function TkwMainWindowClientZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowClientZone.ParamsTypes

procedure TkwMainWindowClientZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ClientZone', aCtx);
end;//TkwMainWindowClientZone.SetValuePrim

procedure TkwMainWindowClientZone.DoDoIt(const aCtx: TtfwContext);
var l_aMainWindow: TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ClientZone(aCtx, l_aMainWindow));
end;//TkwMainWindowClientZone.DoDoIt

function TkwMainWindowMainZone.MainZone(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TvtProportionalPanel;
 {* ���������� ����� ������� .TnsMainWindow.MainZone }
begin
 Result := aMainWindow.MainZone;
end;//TkwMainWindowMainZone.MainZone

class function TkwMainWindowMainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.MainZone';
end;//TkwMainWindowMainZone.GetWordNameForRegister

function TkwMainWindowMainZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwMainWindowMainZone.GetResultTypeInfo

function TkwMainWindowMainZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainWindowMainZone.GetAllParamsCount

function TkwMainWindowMainZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowMainZone.ParamsTypes

procedure TkwMainWindowMainZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� MainZone', aCtx);
end;//TkwMainWindowMainZone.SetValuePrim

procedure TkwMainWindowMainZone.DoDoIt(const aCtx: TtfwContext);
var l_aMainWindow: TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(MainZone(aCtx, l_aMainWindow));
end;//TkwMainWindowMainZone.DoDoIt

function TkwMainWindowParentZonePanel.ParentZonePanel(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TvtPanel;
 {* ���������� ����� ������� .TnsMainWindow.ParentZonePanel }
begin
 Result := aMainWindow.ParentZonePanel;
end;//TkwMainWindowParentZonePanel.ParentZonePanel

class function TkwMainWindowParentZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.ParentZonePanel';
end;//TkwMainWindowParentZonePanel.GetWordNameForRegister

function TkwMainWindowParentZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMainWindowParentZonePanel.GetResultTypeInfo

function TkwMainWindowParentZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainWindowParentZonePanel.GetAllParamsCount

function TkwMainWindowParentZonePanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowParentZonePanel.ParamsTypes

procedure TkwMainWindowParentZonePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ParentZonePanel', aCtx);
end;//TkwMainWindowParentZonePanel.SetValuePrim

procedure TkwMainWindowParentZonePanel.DoDoIt(const aCtx: TtfwContext);
var l_aMainWindow: TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ParentZonePanel(aCtx, l_aMainWindow));
end;//TkwMainWindowParentZonePanel.DoDoIt

function TkwMainWindowChildZonePanel.ChildZonePanel(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TvtSizeablePanel;
 {* ���������� ����� ������� .TnsMainWindow.ChildZonePanel }
begin
 Result := aMainWindow.ChildZonePanel;
end;//TkwMainWindowChildZonePanel.ChildZonePanel

class function TkwMainWindowChildZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.ChildZonePanel';
end;//TkwMainWindowChildZonePanel.GetWordNameForRegister

function TkwMainWindowChildZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwMainWindowChildZonePanel.GetResultTypeInfo

function TkwMainWindowChildZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainWindowChildZonePanel.GetAllParamsCount

function TkwMainWindowChildZonePanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowChildZonePanel.ParamsTypes

procedure TkwMainWindowChildZonePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ChildZonePanel', aCtx);
end;//TkwMainWindowChildZonePanel.SetValuePrim

procedure TkwMainWindowChildZonePanel.DoDoIt(const aCtx: TtfwContext);
var l_aMainWindow: TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ChildZonePanel(aCtx, l_aMainWindow));
end;//TkwMainWindowChildZonePanel.DoDoIt

function TkwMainWindowBaseSearchPanel.BaseSearchPanel(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TvtPanel;
 {* ���������� ����� ������� .TnsMainWindow.BaseSearchPanel }
begin
 Result := aMainWindow.BaseSearchPanel;
end;//TkwMainWindowBaseSearchPanel.BaseSearchPanel

class function TkwMainWindowBaseSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.BaseSearchPanel';
end;//TkwMainWindowBaseSearchPanel.GetWordNameForRegister

function TkwMainWindowBaseSearchPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMainWindowBaseSearchPanel.GetResultTypeInfo

function TkwMainWindowBaseSearchPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainWindowBaseSearchPanel.GetAllParamsCount

function TkwMainWindowBaseSearchPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowBaseSearchPanel.ParamsTypes

procedure TkwMainWindowBaseSearchPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� BaseSearchPanel', aCtx);
end;//TkwMainWindowBaseSearchPanel.SetValuePrim

procedure TkwMainWindowBaseSearchPanel.DoDoIt(const aCtx: TtfwContext);
var l_aMainWindow: TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BaseSearchPanel(aCtx, l_aMainWindow));
end;//TkwMainWindowBaseSearchPanel.DoDoIt

function TkwMainWindowLeftNavigator.LeftNavigator(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TnscNavigator;
 {* ���������� ����� ������� .TnsMainWindow.LeftNavigator }
begin
 Result := aMainWindow.LeftNavigator;
end;//TkwMainWindowLeftNavigator.LeftNavigator

class function TkwMainWindowLeftNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.LeftNavigator';
end;//TkwMainWindowLeftNavigator.GetWordNameForRegister

function TkwMainWindowLeftNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwMainWindowLeftNavigator.GetResultTypeInfo

function TkwMainWindowLeftNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainWindowLeftNavigator.GetAllParamsCount

function TkwMainWindowLeftNavigator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowLeftNavigator.ParamsTypes

procedure TkwMainWindowLeftNavigator.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� LeftNavigator', aCtx);
end;//TkwMainWindowLeftNavigator.SetValuePrim

procedure TkwMainWindowLeftNavigator.DoDoIt(const aCtx: TtfwContext);
var l_aMainWindow: TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LeftNavigator(aCtx, l_aMainWindow));
end;//TkwMainWindowLeftNavigator.DoDoIt

{$If Defined(HasRightNavigator)}
function TkwMainWindowRightNavigator.RightNavigator(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TnscNavigator;
 {* ���������� ����� ������� .TnsMainWindow.RightNavigator }
begin
 Result := aMainWindow.RightNavigator;
end;//TkwMainWindowRightNavigator.RightNavigator

class function TkwMainWindowRightNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.RightNavigator';
end;//TkwMainWindowRightNavigator.GetWordNameForRegister

function TkwMainWindowRightNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwMainWindowRightNavigator.GetResultTypeInfo

function TkwMainWindowRightNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainWindowRightNavigator.GetAllParamsCount

function TkwMainWindowRightNavigator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowRightNavigator.ParamsTypes

procedure TkwMainWindowRightNavigator.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� RightNavigator', aCtx);
end;//TkwMainWindowRightNavigator.SetValuePrim

procedure TkwMainWindowRightNavigator.DoDoIt(const aCtx: TtfwContext);
var l_aMainWindow: TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RightNavigator(aCtx, l_aMainWindow));
end;//TkwMainWindowRightNavigator.DoDoIt
{$IfEnd} // Defined(HasRightNavigator)

function Tkw_Form_MainWindow.GetString: AnsiString;
begin
 Result := 'nsMainWindow';
end;//Tkw_Form_MainWindow.GetString

class procedure Tkw_Form_MainWindow.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnsMainWindow);
end;//Tkw_Form_MainWindow.RegisterInEngine

class function Tkw_Form_MainWindow.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::MainWindow';
end;//Tkw_Form_MainWindow.GetWordNameForRegister

function Tkw_MainWindow_Control_RemindersLine.GetString: AnsiString;
begin
 Result := 'RemindersLine';
end;//Tkw_MainWindow_Control_RemindersLine.GetString

class procedure Tkw_MainWindow_Control_RemindersLine.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscRemindersLine);
end;//Tkw_MainWindow_Control_RemindersLine.RegisterInEngine

class function Tkw_MainWindow_Control_RemindersLine.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RemindersLine';
end;//Tkw_MainWindow_Control_RemindersLine.GetWordNameForRegister

procedure Tkw_MainWindow_Control_RemindersLine_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RemindersLine');
 inherited;
end;//Tkw_MainWindow_Control_RemindersLine_Push.DoDoIt

class function Tkw_MainWindow_Control_RemindersLine_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RemindersLine:push';
end;//Tkw_MainWindow_Control_RemindersLine_Push.GetWordNameForRegister

function Tkw_MainWindow_Control_ControlledChangingWarning.GetString: AnsiString;
begin
 Result := 'ControlledChangingWarning';
end;//Tkw_MainWindow_Control_ControlledChangingWarning.GetString

class procedure Tkw_MainWindow_Control_ControlledChangingWarning.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_MainWindow_Control_ControlledChangingWarning.RegisterInEngine

class function Tkw_MainWindow_Control_ControlledChangingWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ControlledChangingWarning';
end;//Tkw_MainWindow_Control_ControlledChangingWarning.GetWordNameForRegister

procedure Tkw_MainWindow_Control_ControlledChangingWarning_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ControlledChangingWarning');
 inherited;
end;//Tkw_MainWindow_Control_ControlledChangingWarning_Push.DoDoIt

class function Tkw_MainWindow_Control_ControlledChangingWarning_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ControlledChangingWarning:push';
end;//Tkw_MainWindow_Control_ControlledChangingWarning_Push.GetWordNameForRegister

function Tkw_MainWindow_Control_remUnreadConsultations.GetString: AnsiString;
begin
 Result := 'remUnreadConsultations';
end;//Tkw_MainWindow_Control_remUnreadConsultations.GetString

class procedure Tkw_MainWindow_Control_remUnreadConsultations.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_MainWindow_Control_remUnreadConsultations.RegisterInEngine

class function Tkw_MainWindow_Control_remUnreadConsultations.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::remUnreadConsultations';
end;//Tkw_MainWindow_Control_remUnreadConsultations.GetWordNameForRegister

procedure Tkw_MainWindow_Control_remUnreadConsultations_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('remUnreadConsultations');
 inherited;
end;//Tkw_MainWindow_Control_remUnreadConsultations_Push.DoDoIt

class function Tkw_MainWindow_Control_remUnreadConsultations_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::remUnreadConsultations:push';
end;//Tkw_MainWindow_Control_remUnreadConsultations_Push.GetWordNameForRegister

function Tkw_MainWindow_Control_StatusBar.GetString: AnsiString;
begin
 Result := 'StatusBar';
end;//Tkw_MainWindow_Control_StatusBar.GetString

class procedure Tkw_MainWindow_Control_StatusBar.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscStatusBar);
end;//Tkw_MainWindow_Control_StatusBar.RegisterInEngine

class function Tkw_MainWindow_Control_StatusBar.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::StatusBar';
end;//Tkw_MainWindow_Control_StatusBar.GetWordNameForRegister

procedure Tkw_MainWindow_Control_StatusBar_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('StatusBar');
 inherited;
end;//Tkw_MainWindow_Control_StatusBar_Push.DoDoIt

class function Tkw_MainWindow_Control_StatusBar_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::StatusBar:push';
end;//Tkw_MainWindow_Control_StatusBar_Push.GetWordNameForRegister

function Tkw_MainWindow_Control_ClientZone.GetString: AnsiString;
begin
 Result := 'ClientZone';
end;//Tkw_MainWindow_Control_ClientZone.GetString

class procedure Tkw_MainWindow_Control_ClientZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainWindow_Control_ClientZone.RegisterInEngine

class function Tkw_MainWindow_Control_ClientZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ClientZone';
end;//Tkw_MainWindow_Control_ClientZone.GetWordNameForRegister

procedure Tkw_MainWindow_Control_ClientZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ClientZone');
 inherited;
end;//Tkw_MainWindow_Control_ClientZone_Push.DoDoIt

class function Tkw_MainWindow_Control_ClientZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ClientZone:push';
end;//Tkw_MainWindow_Control_ClientZone_Push.GetWordNameForRegister

function Tkw_MainWindow_Control_MainZone.GetString: AnsiString;
begin
 Result := 'MainZone';
end;//Tkw_MainWindow_Control_MainZone.GetString

class procedure Tkw_MainWindow_Control_MainZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_MainWindow_Control_MainZone.RegisterInEngine

class function Tkw_MainWindow_Control_MainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::MainZone';
end;//Tkw_MainWindow_Control_MainZone.GetWordNameForRegister

procedure Tkw_MainWindow_Control_MainZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('MainZone');
 inherited;
end;//Tkw_MainWindow_Control_MainZone_Push.DoDoIt

class function Tkw_MainWindow_Control_MainZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::MainZone:push';
end;//Tkw_MainWindow_Control_MainZone_Push.GetWordNameForRegister

function Tkw_MainWindow_Control_ParentZonePanel.GetString: AnsiString;
begin
 Result := 'ParentZonePanel';
end;//Tkw_MainWindow_Control_ParentZonePanel.GetString

class procedure Tkw_MainWindow_Control_ParentZonePanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainWindow_Control_ParentZonePanel.RegisterInEngine

class function Tkw_MainWindow_Control_ParentZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZonePanel';
end;//Tkw_MainWindow_Control_ParentZonePanel.GetWordNameForRegister

procedure Tkw_MainWindow_Control_ParentZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ParentZonePanel');
 inherited;
end;//Tkw_MainWindow_Control_ParentZonePanel_Push.DoDoIt

class function Tkw_MainWindow_Control_ParentZonePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZonePanel:push';
end;//Tkw_MainWindow_Control_ParentZonePanel_Push.GetWordNameForRegister

function Tkw_MainWindow_Control_ChildZonePanel.GetString: AnsiString;
begin
 Result := 'ChildZonePanel';
end;//Tkw_MainWindow_Control_ChildZonePanel.GetString

class procedure Tkw_MainWindow_Control_ChildZonePanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_MainWindow_Control_ChildZonePanel.RegisterInEngine

class function Tkw_MainWindow_Control_ChildZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZonePanel';
end;//Tkw_MainWindow_Control_ChildZonePanel.GetWordNameForRegister

procedure Tkw_MainWindow_Control_ChildZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ChildZonePanel');
 inherited;
end;//Tkw_MainWindow_Control_ChildZonePanel_Push.DoDoIt

class function Tkw_MainWindow_Control_ChildZonePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZonePanel:push';
end;//Tkw_MainWindow_Control_ChildZonePanel_Push.GetWordNameForRegister

function Tkw_MainWindow_Control_BaseSearchPanel.GetString: AnsiString;
begin
 Result := 'BaseSearchPanel';
end;//Tkw_MainWindow_Control_BaseSearchPanel.GetString

class procedure Tkw_MainWindow_Control_BaseSearchPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainWindow_Control_BaseSearchPanel.RegisterInEngine

class function Tkw_MainWindow_Control_BaseSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BaseSearchPanel';
end;//Tkw_MainWindow_Control_BaseSearchPanel.GetWordNameForRegister

procedure Tkw_MainWindow_Control_BaseSearchPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BaseSearchPanel');
 inherited;
end;//Tkw_MainWindow_Control_BaseSearchPanel_Push.DoDoIt

class function Tkw_MainWindow_Control_BaseSearchPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BaseSearchPanel:push';
end;//Tkw_MainWindow_Control_BaseSearchPanel_Push.GetWordNameForRegister

function Tkw_MainWindow_Control_LeftNavigator.GetString: AnsiString;
begin
 Result := 'LeftNavigator';
end;//Tkw_MainWindow_Control_LeftNavigator.GetString

class procedure Tkw_MainWindow_Control_LeftNavigator.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscNavigator);
end;//Tkw_MainWindow_Control_LeftNavigator.RegisterInEngine

class function Tkw_MainWindow_Control_LeftNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LeftNavigator';
end;//Tkw_MainWindow_Control_LeftNavigator.GetWordNameForRegister

procedure Tkw_MainWindow_Control_LeftNavigator_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('LeftNavigator');
 inherited;
end;//Tkw_MainWindow_Control_LeftNavigator_Push.DoDoIt

class function Tkw_MainWindow_Control_LeftNavigator_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LeftNavigator:push';
end;//Tkw_MainWindow_Control_LeftNavigator_Push.GetWordNameForRegister

{$If Defined(HasRightNavigator)}
function Tkw_MainWindow_Control_RightNavigator.GetString: AnsiString;
begin
 Result := 'RightNavigator';
end;//Tkw_MainWindow_Control_RightNavigator.GetString

class procedure Tkw_MainWindow_Control_RightNavigator.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscNavigator);
end;//Tkw_MainWindow_Control_RightNavigator.RegisterInEngine

class function Tkw_MainWindow_Control_RightNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RightNavigator';
end;//Tkw_MainWindow_Control_RightNavigator.GetWordNameForRegister
{$IfEnd} // Defined(HasRightNavigator)

{$If Defined(HasRightNavigator)}
procedure Tkw_MainWindow_Control_RightNavigator_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RightNavigator');
 inherited;
end;//Tkw_MainWindow_Control_RightNavigator_Push.DoDoIt

class function Tkw_MainWindow_Control_RightNavigator_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RightNavigator:push';
end;//Tkw_MainWindow_Control_RightNavigator_Push.GetWordNameForRegister
{$IfEnd} // Defined(HasRightNavigator)

initialization
 TkwMainWindowRemindersLine.RegisterInEngine;
 {* ����������� MainWindow_RemindersLine }
 TkwMainWindowControlledChangingWarning.RegisterInEngine;
 {* ����������� MainWindow_ControlledChangingWarning }
 TkwMainWindowRemUnreadConsultations.RegisterInEngine;
 {* ����������� MainWindow_remUnreadConsultations }
 TkwMainWindowStatusBar.RegisterInEngine;
 {* ����������� MainWindow_StatusBar }
 TkwMainWindowClientZone.RegisterInEngine;
 {* ����������� MainWindow_ClientZone }
 TkwMainWindowMainZone.RegisterInEngine;
 {* ����������� MainWindow_MainZone }
 TkwMainWindowParentZonePanel.RegisterInEngine;
 {* ����������� MainWindow_ParentZonePanel }
 TkwMainWindowChildZonePanel.RegisterInEngine;
 {* ����������� MainWindow_ChildZonePanel }
 TkwMainWindowBaseSearchPanel.RegisterInEngine;
 {* ����������� MainWindow_BaseSearchPanel }
 TkwMainWindowLeftNavigator.RegisterInEngine;
 {* ����������� MainWindow_LeftNavigator }
{$If Defined(HasRightNavigator)}
 TkwMainWindowRightNavigator.RegisterInEngine;
 {* ����������� MainWindow_RightNavigator }
{$IfEnd} // Defined(HasRightNavigator)
 Tkw_Form_MainWindow.RegisterInEngine;
 {* ����������� Tkw_Form_MainWindow }
 Tkw_MainWindow_Control_RemindersLine.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_RemindersLine }
 Tkw_MainWindow_Control_RemindersLine_Push.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_RemindersLine_Push }
 Tkw_MainWindow_Control_ControlledChangingWarning.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_ControlledChangingWarning }
 Tkw_MainWindow_Control_ControlledChangingWarning_Push.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_ControlledChangingWarning_Push }
 Tkw_MainWindow_Control_remUnreadConsultations.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_remUnreadConsultations }
 Tkw_MainWindow_Control_remUnreadConsultations_Push.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_remUnreadConsultations_Push }
 Tkw_MainWindow_Control_StatusBar.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_StatusBar }
 Tkw_MainWindow_Control_StatusBar_Push.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_StatusBar_Push }
 Tkw_MainWindow_Control_ClientZone.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_ClientZone }
 Tkw_MainWindow_Control_ClientZone_Push.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_ClientZone_Push }
 Tkw_MainWindow_Control_MainZone.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_MainZone }
 Tkw_MainWindow_Control_MainZone_Push.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_MainZone_Push }
 Tkw_MainWindow_Control_ParentZonePanel.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_ParentZonePanel }
 Tkw_MainWindow_Control_ParentZonePanel_Push.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_ParentZonePanel_Push }
 Tkw_MainWindow_Control_ChildZonePanel.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_ChildZonePanel }
 Tkw_MainWindow_Control_ChildZonePanel_Push.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_ChildZonePanel_Push }
 Tkw_MainWindow_Control_BaseSearchPanel.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_BaseSearchPanel }
 Tkw_MainWindow_Control_BaseSearchPanel_Push.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_BaseSearchPanel_Push }
 Tkw_MainWindow_Control_LeftNavigator.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_LeftNavigator }
 Tkw_MainWindow_Control_LeftNavigator_Push.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_LeftNavigator_Push }
{$If Defined(HasRightNavigator)}
 Tkw_MainWindow_Control_RightNavigator.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_RightNavigator }
{$IfEnd} // Defined(HasRightNavigator)
{$If Defined(HasRightNavigator)}
 Tkw_MainWindow_Control_RightNavigator_Push.RegisterInEngine;
 {* ����������� Tkw_MainWindow_Control_RightNavigator_Push }
{$IfEnd} // Defined(HasRightNavigator)
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnsMainWindow));
 {* ����������� ���� TnsMainWindow }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscRemindersLine));
 {* ����������� ���� TnscRemindersLine }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscReminder));
 {* ����������� ���� TnscReminder }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscStatusBar));
 {* ����������� ���� TnscStatusBar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* ����������� ���� TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* ����������� ���� TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscNavigator));
 {* ����������� ���� TnscNavigator }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
