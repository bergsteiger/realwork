unit MainKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Main }

// ������: "w:\MDProcess\NewGen\MainKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "MainKeywordsPack" MUID: (4F6AEAE5007B_Pack)

{$Include w:\MDProcess\NewGen\ngDefine.inc}

interface

{$If Defined(NewGen) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(NewGen) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If Defined(NewGen) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Main_Form
 , tfwPropertyLike
 {$If Defined(Nemesis)}
 , nscStatusBar
 {$IfEnd} // Defined(Nemesis)
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
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
 //#UC START# *4F6AEAE5007B_Packimpl_uses*
 //#UC END# *4F6AEAE5007B_Packimpl_uses*
;

type
 TkwMainFormStatusBar = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.StatusBar }
  private
   function StatusBar(const aCtx: TtfwContext;
    aMainForm: TMainForm): TnscStatusBar;
    {* ���������� ����� ������� .TMainForm.StatusBar }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainFormStatusBar

 TkwMainFormClientZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.ClientZone }
  private
   function ClientZone(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtPanel;
    {* ���������� ����� ������� .TMainForm.ClientZone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainFormClientZone

 TkwMainFormMainZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.MainZone }
  private
   function MainZone(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtProportionalPanel;
    {* ���������� ����� ������� .TMainForm.MainZone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainFormMainZone

 TkwMainFormParentZonePanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.ParentZonePanel }
  private
   function ParentZonePanel(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtPanel;
    {* ���������� ����� ������� .TMainForm.ParentZonePanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainFormParentZonePanel

 TkwMainFormChildZonePanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.ChildZonePanel }
  private
   function ChildZonePanel(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TMainForm.ChildZonePanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainFormChildZonePanel

 TkwMainFormBaseSearchPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.BaseSearchPanel }
  private
   function BaseSearchPanel(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtPanel;
    {* ���������� ����� ������� .TMainForm.BaseSearchPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainFormBaseSearchPanel

 TkwMainFormLeftNavigator = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.LeftNavigator }
  private
   function LeftNavigator(const aCtx: TtfwContext;
    aMainForm: TMainForm): TnscNavigator;
    {* ���������� ����� ������� .TMainForm.LeftNavigator }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainFormLeftNavigator

{$If Defined(HasRightNavigator)}
 TkwMainFormRightNavigator = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.RightNavigator }
  private
   function RightNavigator(const aCtx: TtfwContext;
    aMainForm: TMainForm): TnscNavigator;
    {* ���������� ����� ������� .TMainForm.RightNavigator }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMainFormRightNavigator
{$IfEnd} // Defined(HasRightNavigator)

 Tkw_Form_Main = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Main
----
*������ �������������*:
[code]�����::Main TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Main

 Tkw_Main_Control_StatusBar = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� StatusBar
----
*������ �������������*:
[code]�������::StatusBar TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_StatusBar

 Tkw_Main_Control_StatusBar_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� StatusBar
----
*������ �������������*:
[code]�������::StatusBar:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_StatusBar_Push

 Tkw_Main_Control_ClientZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ClientZone
----
*������ �������������*:
[code]�������::ClientZone TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_ClientZone

 Tkw_Main_Control_ClientZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ClientZone
----
*������ �������������*:
[code]�������::ClientZone:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_ClientZone_Push

 Tkw_Main_Control_MainZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� MainZone
----
*������ �������������*:
[code]�������::MainZone TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_MainZone

 Tkw_Main_Control_MainZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� MainZone
----
*������ �������������*:
[code]�������::MainZone:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_MainZone_Push

 Tkw_Main_Control_ParentZonePanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ParentZonePanel
----
*������ �������������*:
[code]�������::ParentZonePanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_ParentZonePanel

 Tkw_Main_Control_ParentZonePanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ParentZonePanel
----
*������ �������������*:
[code]�������::ParentZonePanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_ParentZonePanel_Push

 Tkw_Main_Control_ChildZonePanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ChildZonePanel
----
*������ �������������*:
[code]�������::ChildZonePanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_ChildZonePanel

 Tkw_Main_Control_ChildZonePanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ChildZonePanel
----
*������ �������������*:
[code]�������::ChildZonePanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_ChildZonePanel_Push

 Tkw_Main_Control_BaseSearchPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BaseSearchPanel
----
*������ �������������*:
[code]�������::BaseSearchPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_BaseSearchPanel

 Tkw_Main_Control_BaseSearchPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BaseSearchPanel
----
*������ �������������*:
[code]�������::BaseSearchPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_BaseSearchPanel_Push

 Tkw_Main_Control_LeftNavigator = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LeftNavigator
----
*������ �������������*:
[code]�������::LeftNavigator TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_LeftNavigator

 Tkw_Main_Control_LeftNavigator_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� LeftNavigator
----
*������ �������������*:
[code]�������::LeftNavigator:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_LeftNavigator_Push

{$If Defined(HasRightNavigator)}
 Tkw_Main_Control_RightNavigator = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RightNavigator
----
*������ �������������*:
[code]�������::RightNavigator TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_RightNavigator
{$IfEnd} // Defined(HasRightNavigator)

{$If Defined(HasRightNavigator)}
 Tkw_Main_Control_RightNavigator_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RightNavigator
----
*������ �������������*:
[code]�������::RightNavigator:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_RightNavigator_Push
{$IfEnd} // Defined(HasRightNavigator)

function TkwMainFormStatusBar.StatusBar(const aCtx: TtfwContext;
 aMainForm: TMainForm): TnscStatusBar;
 {* ���������� ����� ������� .TMainForm.StatusBar }
begin
 Result := aMainForm.StatusBar;
end;//TkwMainFormStatusBar.StatusBar

class function TkwMainFormStatusBar.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.StatusBar';
end;//TkwMainFormStatusBar.GetWordNameForRegister

function TkwMainFormStatusBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscStatusBar);
end;//TkwMainFormStatusBar.GetResultTypeInfo

function TkwMainFormStatusBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormStatusBar.GetAllParamsCount

function TkwMainFormStatusBar.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormStatusBar.ParamsTypes

procedure TkwMainFormStatusBar.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� StatusBar', aCtx);
end;//TkwMainFormStatusBar.SetValuePrim

procedure TkwMainFormStatusBar.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(StatusBar(aCtx, l_aMainForm));
end;//TkwMainFormStatusBar.DoDoIt

function TkwMainFormClientZone.ClientZone(const aCtx: TtfwContext;
 aMainForm: TMainForm): TvtPanel;
 {* ���������� ����� ������� .TMainForm.ClientZone }
begin
 Result := aMainForm.ClientZone;
end;//TkwMainFormClientZone.ClientZone

class function TkwMainFormClientZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.ClientZone';
end;//TkwMainFormClientZone.GetWordNameForRegister

function TkwMainFormClientZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMainFormClientZone.GetResultTypeInfo

function TkwMainFormClientZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormClientZone.GetAllParamsCount

function TkwMainFormClientZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormClientZone.ParamsTypes

procedure TkwMainFormClientZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ClientZone', aCtx);
end;//TkwMainFormClientZone.SetValuePrim

procedure TkwMainFormClientZone.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ClientZone(aCtx, l_aMainForm));
end;//TkwMainFormClientZone.DoDoIt

function TkwMainFormMainZone.MainZone(const aCtx: TtfwContext;
 aMainForm: TMainForm): TvtProportionalPanel;
 {* ���������� ����� ������� .TMainForm.MainZone }
begin
 Result := aMainForm.MainZone;
end;//TkwMainFormMainZone.MainZone

class function TkwMainFormMainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.MainZone';
end;//TkwMainFormMainZone.GetWordNameForRegister

function TkwMainFormMainZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwMainFormMainZone.GetResultTypeInfo

function TkwMainFormMainZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormMainZone.GetAllParamsCount

function TkwMainFormMainZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormMainZone.ParamsTypes

procedure TkwMainFormMainZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� MainZone', aCtx);
end;//TkwMainFormMainZone.SetValuePrim

procedure TkwMainFormMainZone.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(MainZone(aCtx, l_aMainForm));
end;//TkwMainFormMainZone.DoDoIt

function TkwMainFormParentZonePanel.ParentZonePanel(const aCtx: TtfwContext;
 aMainForm: TMainForm): TvtPanel;
 {* ���������� ����� ������� .TMainForm.ParentZonePanel }
begin
 Result := aMainForm.ParentZonePanel;
end;//TkwMainFormParentZonePanel.ParentZonePanel

class function TkwMainFormParentZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.ParentZonePanel';
end;//TkwMainFormParentZonePanel.GetWordNameForRegister

function TkwMainFormParentZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMainFormParentZonePanel.GetResultTypeInfo

function TkwMainFormParentZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormParentZonePanel.GetAllParamsCount

function TkwMainFormParentZonePanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormParentZonePanel.ParamsTypes

procedure TkwMainFormParentZonePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ParentZonePanel', aCtx);
end;//TkwMainFormParentZonePanel.SetValuePrim

procedure TkwMainFormParentZonePanel.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ParentZonePanel(aCtx, l_aMainForm));
end;//TkwMainFormParentZonePanel.DoDoIt

function TkwMainFormChildZonePanel.ChildZonePanel(const aCtx: TtfwContext;
 aMainForm: TMainForm): TvtSizeablePanel;
 {* ���������� ����� ������� .TMainForm.ChildZonePanel }
begin
 Result := aMainForm.ChildZonePanel;
end;//TkwMainFormChildZonePanel.ChildZonePanel

class function TkwMainFormChildZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.ChildZonePanel';
end;//TkwMainFormChildZonePanel.GetWordNameForRegister

function TkwMainFormChildZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwMainFormChildZonePanel.GetResultTypeInfo

function TkwMainFormChildZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormChildZonePanel.GetAllParamsCount

function TkwMainFormChildZonePanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormChildZonePanel.ParamsTypes

procedure TkwMainFormChildZonePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ChildZonePanel', aCtx);
end;//TkwMainFormChildZonePanel.SetValuePrim

procedure TkwMainFormChildZonePanel.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ChildZonePanel(aCtx, l_aMainForm));
end;//TkwMainFormChildZonePanel.DoDoIt

function TkwMainFormBaseSearchPanel.BaseSearchPanel(const aCtx: TtfwContext;
 aMainForm: TMainForm): TvtPanel;
 {* ���������� ����� ������� .TMainForm.BaseSearchPanel }
begin
 Result := aMainForm.BaseSearchPanel;
end;//TkwMainFormBaseSearchPanel.BaseSearchPanel

class function TkwMainFormBaseSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.BaseSearchPanel';
end;//TkwMainFormBaseSearchPanel.GetWordNameForRegister

function TkwMainFormBaseSearchPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMainFormBaseSearchPanel.GetResultTypeInfo

function TkwMainFormBaseSearchPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormBaseSearchPanel.GetAllParamsCount

function TkwMainFormBaseSearchPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormBaseSearchPanel.ParamsTypes

procedure TkwMainFormBaseSearchPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� BaseSearchPanel', aCtx);
end;//TkwMainFormBaseSearchPanel.SetValuePrim

procedure TkwMainFormBaseSearchPanel.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BaseSearchPanel(aCtx, l_aMainForm));
end;//TkwMainFormBaseSearchPanel.DoDoIt

function TkwMainFormLeftNavigator.LeftNavigator(const aCtx: TtfwContext;
 aMainForm: TMainForm): TnscNavigator;
 {* ���������� ����� ������� .TMainForm.LeftNavigator }
begin
 Result := aMainForm.LeftNavigator;
end;//TkwMainFormLeftNavigator.LeftNavigator

class function TkwMainFormLeftNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.LeftNavigator';
end;//TkwMainFormLeftNavigator.GetWordNameForRegister

function TkwMainFormLeftNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwMainFormLeftNavigator.GetResultTypeInfo

function TkwMainFormLeftNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormLeftNavigator.GetAllParamsCount

function TkwMainFormLeftNavigator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormLeftNavigator.ParamsTypes

procedure TkwMainFormLeftNavigator.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� LeftNavigator', aCtx);
end;//TkwMainFormLeftNavigator.SetValuePrim

procedure TkwMainFormLeftNavigator.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LeftNavigator(aCtx, l_aMainForm));
end;//TkwMainFormLeftNavigator.DoDoIt

{$If Defined(HasRightNavigator)}
function TkwMainFormRightNavigator.RightNavigator(const aCtx: TtfwContext;
 aMainForm: TMainForm): TnscNavigator;
 {* ���������� ����� ������� .TMainForm.RightNavigator }
begin
 Result := aMainForm.RightNavigator;
end;//TkwMainFormRightNavigator.RightNavigator

class function TkwMainFormRightNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.RightNavigator';
end;//TkwMainFormRightNavigator.GetWordNameForRegister

function TkwMainFormRightNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwMainFormRightNavigator.GetResultTypeInfo

function TkwMainFormRightNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormRightNavigator.GetAllParamsCount

function TkwMainFormRightNavigator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormRightNavigator.ParamsTypes

procedure TkwMainFormRightNavigator.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� RightNavigator', aCtx);
end;//TkwMainFormRightNavigator.SetValuePrim

procedure TkwMainFormRightNavigator.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RightNavigator(aCtx, l_aMainForm));
end;//TkwMainFormRightNavigator.DoDoIt
{$IfEnd} // Defined(HasRightNavigator)

function Tkw_Form_Main.GetString: AnsiString;
begin
 Result := 'MainForm';
end;//Tkw_Form_Main.GetString

class procedure Tkw_Form_Main.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TMainForm);
end;//Tkw_Form_Main.RegisterInEngine

class function Tkw_Form_Main.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Main';
end;//Tkw_Form_Main.GetWordNameForRegister

function Tkw_Main_Control_StatusBar.GetString: AnsiString;
begin
 Result := 'StatusBar';
end;//Tkw_Main_Control_StatusBar.GetString

class procedure Tkw_Main_Control_StatusBar.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscStatusBar);
end;//Tkw_Main_Control_StatusBar.RegisterInEngine

class function Tkw_Main_Control_StatusBar.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::StatusBar';
end;//Tkw_Main_Control_StatusBar.GetWordNameForRegister

procedure Tkw_Main_Control_StatusBar_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('StatusBar');
 inherited;
end;//Tkw_Main_Control_StatusBar_Push.DoDoIt

class function Tkw_Main_Control_StatusBar_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::StatusBar:push';
end;//Tkw_Main_Control_StatusBar_Push.GetWordNameForRegister

function Tkw_Main_Control_ClientZone.GetString: AnsiString;
begin
 Result := 'ClientZone';
end;//Tkw_Main_Control_ClientZone.GetString

class procedure Tkw_Main_Control_ClientZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Main_Control_ClientZone.RegisterInEngine

class function Tkw_Main_Control_ClientZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ClientZone';
end;//Tkw_Main_Control_ClientZone.GetWordNameForRegister

procedure Tkw_Main_Control_ClientZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ClientZone');
 inherited;
end;//Tkw_Main_Control_ClientZone_Push.DoDoIt

class function Tkw_Main_Control_ClientZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ClientZone:push';
end;//Tkw_Main_Control_ClientZone_Push.GetWordNameForRegister

function Tkw_Main_Control_MainZone.GetString: AnsiString;
begin
 Result := 'MainZone';
end;//Tkw_Main_Control_MainZone.GetString

class procedure Tkw_Main_Control_MainZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_Main_Control_MainZone.RegisterInEngine

class function Tkw_Main_Control_MainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::MainZone';
end;//Tkw_Main_Control_MainZone.GetWordNameForRegister

procedure Tkw_Main_Control_MainZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('MainZone');
 inherited;
end;//Tkw_Main_Control_MainZone_Push.DoDoIt

class function Tkw_Main_Control_MainZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::MainZone:push';
end;//Tkw_Main_Control_MainZone_Push.GetWordNameForRegister

function Tkw_Main_Control_ParentZonePanel.GetString: AnsiString;
begin
 Result := 'ParentZonePanel';
end;//Tkw_Main_Control_ParentZonePanel.GetString

class procedure Tkw_Main_Control_ParentZonePanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Main_Control_ParentZonePanel.RegisterInEngine

class function Tkw_Main_Control_ParentZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZonePanel';
end;//Tkw_Main_Control_ParentZonePanel.GetWordNameForRegister

procedure Tkw_Main_Control_ParentZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ParentZonePanel');
 inherited;
end;//Tkw_Main_Control_ParentZonePanel_Push.DoDoIt

class function Tkw_Main_Control_ParentZonePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZonePanel:push';
end;//Tkw_Main_Control_ParentZonePanel_Push.GetWordNameForRegister

function Tkw_Main_Control_ChildZonePanel.GetString: AnsiString;
begin
 Result := 'ChildZonePanel';
end;//Tkw_Main_Control_ChildZonePanel.GetString

class procedure Tkw_Main_Control_ChildZonePanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_Main_Control_ChildZonePanel.RegisterInEngine

class function Tkw_Main_Control_ChildZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZonePanel';
end;//Tkw_Main_Control_ChildZonePanel.GetWordNameForRegister

procedure Tkw_Main_Control_ChildZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ChildZonePanel');
 inherited;
end;//Tkw_Main_Control_ChildZonePanel_Push.DoDoIt

class function Tkw_Main_Control_ChildZonePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZonePanel:push';
end;//Tkw_Main_Control_ChildZonePanel_Push.GetWordNameForRegister

function Tkw_Main_Control_BaseSearchPanel.GetString: AnsiString;
begin
 Result := 'BaseSearchPanel';
end;//Tkw_Main_Control_BaseSearchPanel.GetString

class procedure Tkw_Main_Control_BaseSearchPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Main_Control_BaseSearchPanel.RegisterInEngine

class function Tkw_Main_Control_BaseSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BaseSearchPanel';
end;//Tkw_Main_Control_BaseSearchPanel.GetWordNameForRegister

procedure Tkw_Main_Control_BaseSearchPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BaseSearchPanel');
 inherited;
end;//Tkw_Main_Control_BaseSearchPanel_Push.DoDoIt

class function Tkw_Main_Control_BaseSearchPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BaseSearchPanel:push';
end;//Tkw_Main_Control_BaseSearchPanel_Push.GetWordNameForRegister

function Tkw_Main_Control_LeftNavigator.GetString: AnsiString;
begin
 Result := 'LeftNavigator';
end;//Tkw_Main_Control_LeftNavigator.GetString

class procedure Tkw_Main_Control_LeftNavigator.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscNavigator);
end;//Tkw_Main_Control_LeftNavigator.RegisterInEngine

class function Tkw_Main_Control_LeftNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LeftNavigator';
end;//Tkw_Main_Control_LeftNavigator.GetWordNameForRegister

procedure Tkw_Main_Control_LeftNavigator_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('LeftNavigator');
 inherited;
end;//Tkw_Main_Control_LeftNavigator_Push.DoDoIt

class function Tkw_Main_Control_LeftNavigator_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LeftNavigator:push';
end;//Tkw_Main_Control_LeftNavigator_Push.GetWordNameForRegister

{$If Defined(HasRightNavigator)}
function Tkw_Main_Control_RightNavigator.GetString: AnsiString;
begin
 Result := 'RightNavigator';
end;//Tkw_Main_Control_RightNavigator.GetString

class procedure Tkw_Main_Control_RightNavigator.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscNavigator);
end;//Tkw_Main_Control_RightNavigator.RegisterInEngine

class function Tkw_Main_Control_RightNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RightNavigator';
end;//Tkw_Main_Control_RightNavigator.GetWordNameForRegister
{$IfEnd} // Defined(HasRightNavigator)

{$If Defined(HasRightNavigator)}
procedure Tkw_Main_Control_RightNavigator_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RightNavigator');
 inherited;
end;//Tkw_Main_Control_RightNavigator_Push.DoDoIt

class function Tkw_Main_Control_RightNavigator_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RightNavigator:push';
end;//Tkw_Main_Control_RightNavigator_Push.GetWordNameForRegister
{$IfEnd} // Defined(HasRightNavigator)

initialization
 TkwMainFormStatusBar.RegisterInEngine;
 {* ����������� MainForm_StatusBar }
 TkwMainFormClientZone.RegisterInEngine;
 {* ����������� MainForm_ClientZone }
 TkwMainFormMainZone.RegisterInEngine;
 {* ����������� MainForm_MainZone }
 TkwMainFormParentZonePanel.RegisterInEngine;
 {* ����������� MainForm_ParentZonePanel }
 TkwMainFormChildZonePanel.RegisterInEngine;
 {* ����������� MainForm_ChildZonePanel }
 TkwMainFormBaseSearchPanel.RegisterInEngine;
 {* ����������� MainForm_BaseSearchPanel }
 TkwMainFormLeftNavigator.RegisterInEngine;
 {* ����������� MainForm_LeftNavigator }
{$If Defined(HasRightNavigator)}
 TkwMainFormRightNavigator.RegisterInEngine;
 {* ����������� MainForm_RightNavigator }
{$IfEnd} // Defined(HasRightNavigator)
 Tkw_Form_Main.RegisterInEngine;
 {* ����������� Tkw_Form_Main }
 Tkw_Main_Control_StatusBar.RegisterInEngine;
 {* ����������� Tkw_Main_Control_StatusBar }
 Tkw_Main_Control_StatusBar_Push.RegisterInEngine;
 {* ����������� Tkw_Main_Control_StatusBar_Push }
 Tkw_Main_Control_ClientZone.RegisterInEngine;
 {* ����������� Tkw_Main_Control_ClientZone }
 Tkw_Main_Control_ClientZone_Push.RegisterInEngine;
 {* ����������� Tkw_Main_Control_ClientZone_Push }
 Tkw_Main_Control_MainZone.RegisterInEngine;
 {* ����������� Tkw_Main_Control_MainZone }
 Tkw_Main_Control_MainZone_Push.RegisterInEngine;
 {* ����������� Tkw_Main_Control_MainZone_Push }
 Tkw_Main_Control_ParentZonePanel.RegisterInEngine;
 {* ����������� Tkw_Main_Control_ParentZonePanel }
 Tkw_Main_Control_ParentZonePanel_Push.RegisterInEngine;
 {* ����������� Tkw_Main_Control_ParentZonePanel_Push }
 Tkw_Main_Control_ChildZonePanel.RegisterInEngine;
 {* ����������� Tkw_Main_Control_ChildZonePanel }
 Tkw_Main_Control_ChildZonePanel_Push.RegisterInEngine;
 {* ����������� Tkw_Main_Control_ChildZonePanel_Push }
 Tkw_Main_Control_BaseSearchPanel.RegisterInEngine;
 {* ����������� Tkw_Main_Control_BaseSearchPanel }
 Tkw_Main_Control_BaseSearchPanel_Push.RegisterInEngine;
 {* ����������� Tkw_Main_Control_BaseSearchPanel_Push }
 Tkw_Main_Control_LeftNavigator.RegisterInEngine;
 {* ����������� Tkw_Main_Control_LeftNavigator }
 Tkw_Main_Control_LeftNavigator_Push.RegisterInEngine;
 {* ����������� Tkw_Main_Control_LeftNavigator_Push }
{$If Defined(HasRightNavigator)}
 Tkw_Main_Control_RightNavigator.RegisterInEngine;
 {* ����������� Tkw_Main_Control_RightNavigator }
{$IfEnd} // Defined(HasRightNavigator)
{$If Defined(HasRightNavigator)}
 Tkw_Main_Control_RightNavigator_Push.RegisterInEngine;
 {* ����������� Tkw_Main_Control_RightNavigator_Push }
{$IfEnd} // Defined(HasRightNavigator)
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMainForm));
 {* ����������� ���� TMainForm }
{$If Defined(Nemesis)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscStatusBar));
 {* ����������� ���� TnscStatusBar }
{$IfEnd} // Defined(Nemesis)
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* ����������� ���� TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* ����������� ���� TvtSizeablePanel }
{$If Defined(Nemesis)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscNavigator));
 {* ����������� ���� TnscNavigator }
{$IfEnd} // Defined(Nemesis)
{$IfEnd} // Defined(NewGen) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
