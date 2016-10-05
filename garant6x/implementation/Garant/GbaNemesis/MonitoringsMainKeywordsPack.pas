unit MonitoringsMainKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы MonitoringsMain }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\MonitoringsMainKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "MonitoringsMainKeywordsPack" MUID: (4F7C2E78015C_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Monitorings) AND NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If Defined(Monitorings) AND NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , MonitoringsMain_Form
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
 //#UC START# *4F7C2E78015C_Packimpl_uses*
 //#UC END# *4F7C2E78015C_Packimpl_uses*
;

type
 TkwMonitoringsMainFormStatusBar = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMonitoringsMainForm.StatusBar }
  private
   function StatusBar(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TnscStatusBar;
    {* Реализация слова скрипта .TMonitoringsMainForm.StatusBar }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMonitoringsMainFormStatusBar

 TkwMonitoringsMainFormClientZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMonitoringsMainForm.ClientZone }
  private
   function ClientZone(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TvtPanel;
    {* Реализация слова скрипта .TMonitoringsMainForm.ClientZone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMonitoringsMainFormClientZone

 TkwMonitoringsMainFormMainZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMonitoringsMainForm.MainZone }
  private
   function MainZone(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TvtProportionalPanel;
    {* Реализация слова скрипта .TMonitoringsMainForm.MainZone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMonitoringsMainFormMainZone

 TkwMonitoringsMainFormParentZonePanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMonitoringsMainForm.ParentZonePanel }
  private
   function ParentZonePanel(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TvtPanel;
    {* Реализация слова скрипта .TMonitoringsMainForm.ParentZonePanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMonitoringsMainFormParentZonePanel

 TkwMonitoringsMainFormChildZonePanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMonitoringsMainForm.ChildZonePanel }
  private
   function ChildZonePanel(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TvtSizeablePanel;
    {* Реализация слова скрипта .TMonitoringsMainForm.ChildZonePanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMonitoringsMainFormChildZonePanel

 TkwMonitoringsMainFormBaseSearchPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMonitoringsMainForm.BaseSearchPanel }
  private
   function BaseSearchPanel(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TvtPanel;
    {* Реализация слова скрипта .TMonitoringsMainForm.BaseSearchPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMonitoringsMainFormBaseSearchPanel

 TkwMonitoringsMainFormLeftNavigator = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMonitoringsMainForm.LeftNavigator }
  private
   function LeftNavigator(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TnscNavigator;
    {* Реализация слова скрипта .TMonitoringsMainForm.LeftNavigator }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMonitoringsMainFormLeftNavigator

{$If Defined(HasRightNavigator)}
 TkwMonitoringsMainFormRightNavigator = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMonitoringsMainForm.RightNavigator }
  private
   function RightNavigator(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TnscNavigator;
    {* Реализация слова скрипта .TMonitoringsMainForm.RightNavigator }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMonitoringsMainFormRightNavigator
{$IfEnd} // Defined(HasRightNavigator)

 Tkw_Form_MonitoringsMain = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы MonitoringsMain
----
*Пример использования*:
[code]форма::MonitoringsMain TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_MonitoringsMain

 Tkw_MonitoringsMain_Control_StatusBar = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола StatusBar
----
*Пример использования*:
[code]контрол::StatusBar TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_StatusBar

 Tkw_MonitoringsMain_Control_StatusBar_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола StatusBar
----
*Пример использования*:
[code]контрол::StatusBar:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_StatusBar_Push

 Tkw_MonitoringsMain_Control_ClientZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ClientZone
----
*Пример использования*:
[code]контрол::ClientZone TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_ClientZone

 Tkw_MonitoringsMain_Control_ClientZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ClientZone
----
*Пример использования*:
[code]контрол::ClientZone:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_ClientZone_Push

 Tkw_MonitoringsMain_Control_MainZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола MainZone
----
*Пример использования*:
[code]контрол::MainZone TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_MainZone

 Tkw_MonitoringsMain_Control_MainZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола MainZone
----
*Пример использования*:
[code]контрол::MainZone:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_MainZone_Push

 Tkw_MonitoringsMain_Control_ParentZonePanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ParentZonePanel
----
*Пример использования*:
[code]контрол::ParentZonePanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_ParentZonePanel

 Tkw_MonitoringsMain_Control_ParentZonePanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ParentZonePanel
----
*Пример использования*:
[code]контрол::ParentZonePanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_ParentZonePanel_Push

 Tkw_MonitoringsMain_Control_ChildZonePanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ChildZonePanel
----
*Пример использования*:
[code]контрол::ChildZonePanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_ChildZonePanel

 Tkw_MonitoringsMain_Control_ChildZonePanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ChildZonePanel
----
*Пример использования*:
[code]контрол::ChildZonePanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_ChildZonePanel_Push

 Tkw_MonitoringsMain_Control_BaseSearchPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BaseSearchPanel
----
*Пример использования*:
[code]контрол::BaseSearchPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_BaseSearchPanel

 Tkw_MonitoringsMain_Control_BaseSearchPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BaseSearchPanel
----
*Пример использования*:
[code]контрол::BaseSearchPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_BaseSearchPanel_Push

 Tkw_MonitoringsMain_Control_LeftNavigator = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LeftNavigator
----
*Пример использования*:
[code]контрол::LeftNavigator TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_LeftNavigator

 Tkw_MonitoringsMain_Control_LeftNavigator_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола LeftNavigator
----
*Пример использования*:
[code]контрол::LeftNavigator:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_LeftNavigator_Push

{$If Defined(HasRightNavigator)}
 Tkw_MonitoringsMain_Control_RightNavigator = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RightNavigator
----
*Пример использования*:
[code]контрол::RightNavigator TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_RightNavigator
{$IfEnd} // Defined(HasRightNavigator)

{$If Defined(HasRightNavigator)}
 Tkw_MonitoringsMain_Control_RightNavigator_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола RightNavigator
----
*Пример использования*:
[code]контрол::RightNavigator:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_RightNavigator_Push
{$IfEnd} // Defined(HasRightNavigator)

function TkwMonitoringsMainFormStatusBar.StatusBar(const aCtx: TtfwContext;
 aMonitoringsMainForm: TMonitoringsMainForm): TnscStatusBar;
 {* Реализация слова скрипта .TMonitoringsMainForm.StatusBar }
begin
 Result := aMonitoringsMainForm.StatusBar;
end;//TkwMonitoringsMainFormStatusBar.StatusBar

class function TkwMonitoringsMainFormStatusBar.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMonitoringsMainForm.StatusBar';
end;//TkwMonitoringsMainFormStatusBar.GetWordNameForRegister

function TkwMonitoringsMainFormStatusBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscStatusBar);
end;//TkwMonitoringsMainFormStatusBar.GetResultTypeInfo

function TkwMonitoringsMainFormStatusBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMonitoringsMainFormStatusBar.GetAllParamsCount

function TkwMonitoringsMainFormStatusBar.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMonitoringsMainForm)]);
end;//TkwMonitoringsMainFormStatusBar.ParamsTypes

procedure TkwMonitoringsMainFormStatusBar.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству StatusBar', aCtx);
end;//TkwMonitoringsMainFormStatusBar.SetValuePrim

procedure TkwMonitoringsMainFormStatusBar.DoDoIt(const aCtx: TtfwContext);
var l_aMonitoringsMainForm: TMonitoringsMainForm;
begin
 try
  l_aMonitoringsMainForm := TMonitoringsMainForm(aCtx.rEngine.PopObjAs(TMonitoringsMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMonitoringsMainForm: TMonitoringsMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(StatusBar(aCtx, l_aMonitoringsMainForm));
end;//TkwMonitoringsMainFormStatusBar.DoDoIt

function TkwMonitoringsMainFormClientZone.ClientZone(const aCtx: TtfwContext;
 aMonitoringsMainForm: TMonitoringsMainForm): TvtPanel;
 {* Реализация слова скрипта .TMonitoringsMainForm.ClientZone }
begin
 Result := aMonitoringsMainForm.ClientZone;
end;//TkwMonitoringsMainFormClientZone.ClientZone

class function TkwMonitoringsMainFormClientZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMonitoringsMainForm.ClientZone';
end;//TkwMonitoringsMainFormClientZone.GetWordNameForRegister

function TkwMonitoringsMainFormClientZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMonitoringsMainFormClientZone.GetResultTypeInfo

function TkwMonitoringsMainFormClientZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMonitoringsMainFormClientZone.GetAllParamsCount

function TkwMonitoringsMainFormClientZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMonitoringsMainForm)]);
end;//TkwMonitoringsMainFormClientZone.ParamsTypes

procedure TkwMonitoringsMainFormClientZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ClientZone', aCtx);
end;//TkwMonitoringsMainFormClientZone.SetValuePrim

procedure TkwMonitoringsMainFormClientZone.DoDoIt(const aCtx: TtfwContext);
var l_aMonitoringsMainForm: TMonitoringsMainForm;
begin
 try
  l_aMonitoringsMainForm := TMonitoringsMainForm(aCtx.rEngine.PopObjAs(TMonitoringsMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMonitoringsMainForm: TMonitoringsMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ClientZone(aCtx, l_aMonitoringsMainForm));
end;//TkwMonitoringsMainFormClientZone.DoDoIt

function TkwMonitoringsMainFormMainZone.MainZone(const aCtx: TtfwContext;
 aMonitoringsMainForm: TMonitoringsMainForm): TvtProportionalPanel;
 {* Реализация слова скрипта .TMonitoringsMainForm.MainZone }
begin
 Result := aMonitoringsMainForm.MainZone;
end;//TkwMonitoringsMainFormMainZone.MainZone

class function TkwMonitoringsMainFormMainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMonitoringsMainForm.MainZone';
end;//TkwMonitoringsMainFormMainZone.GetWordNameForRegister

function TkwMonitoringsMainFormMainZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwMonitoringsMainFormMainZone.GetResultTypeInfo

function TkwMonitoringsMainFormMainZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMonitoringsMainFormMainZone.GetAllParamsCount

function TkwMonitoringsMainFormMainZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMonitoringsMainForm)]);
end;//TkwMonitoringsMainFormMainZone.ParamsTypes

procedure TkwMonitoringsMainFormMainZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству MainZone', aCtx);
end;//TkwMonitoringsMainFormMainZone.SetValuePrim

procedure TkwMonitoringsMainFormMainZone.DoDoIt(const aCtx: TtfwContext);
var l_aMonitoringsMainForm: TMonitoringsMainForm;
begin
 try
  l_aMonitoringsMainForm := TMonitoringsMainForm(aCtx.rEngine.PopObjAs(TMonitoringsMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMonitoringsMainForm: TMonitoringsMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(MainZone(aCtx, l_aMonitoringsMainForm));
end;//TkwMonitoringsMainFormMainZone.DoDoIt

function TkwMonitoringsMainFormParentZonePanel.ParentZonePanel(const aCtx: TtfwContext;
 aMonitoringsMainForm: TMonitoringsMainForm): TvtPanel;
 {* Реализация слова скрипта .TMonitoringsMainForm.ParentZonePanel }
begin
 Result := aMonitoringsMainForm.ParentZonePanel;
end;//TkwMonitoringsMainFormParentZonePanel.ParentZonePanel

class function TkwMonitoringsMainFormParentZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMonitoringsMainForm.ParentZonePanel';
end;//TkwMonitoringsMainFormParentZonePanel.GetWordNameForRegister

function TkwMonitoringsMainFormParentZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMonitoringsMainFormParentZonePanel.GetResultTypeInfo

function TkwMonitoringsMainFormParentZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMonitoringsMainFormParentZonePanel.GetAllParamsCount

function TkwMonitoringsMainFormParentZonePanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMonitoringsMainForm)]);
end;//TkwMonitoringsMainFormParentZonePanel.ParamsTypes

procedure TkwMonitoringsMainFormParentZonePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ParentZonePanel', aCtx);
end;//TkwMonitoringsMainFormParentZonePanel.SetValuePrim

procedure TkwMonitoringsMainFormParentZonePanel.DoDoIt(const aCtx: TtfwContext);
var l_aMonitoringsMainForm: TMonitoringsMainForm;
begin
 try
  l_aMonitoringsMainForm := TMonitoringsMainForm(aCtx.rEngine.PopObjAs(TMonitoringsMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMonitoringsMainForm: TMonitoringsMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ParentZonePanel(aCtx, l_aMonitoringsMainForm));
end;//TkwMonitoringsMainFormParentZonePanel.DoDoIt

function TkwMonitoringsMainFormChildZonePanel.ChildZonePanel(const aCtx: TtfwContext;
 aMonitoringsMainForm: TMonitoringsMainForm): TvtSizeablePanel;
 {* Реализация слова скрипта .TMonitoringsMainForm.ChildZonePanel }
begin
 Result := aMonitoringsMainForm.ChildZonePanel;
end;//TkwMonitoringsMainFormChildZonePanel.ChildZonePanel

class function TkwMonitoringsMainFormChildZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMonitoringsMainForm.ChildZonePanel';
end;//TkwMonitoringsMainFormChildZonePanel.GetWordNameForRegister

function TkwMonitoringsMainFormChildZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwMonitoringsMainFormChildZonePanel.GetResultTypeInfo

function TkwMonitoringsMainFormChildZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMonitoringsMainFormChildZonePanel.GetAllParamsCount

function TkwMonitoringsMainFormChildZonePanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMonitoringsMainForm)]);
end;//TkwMonitoringsMainFormChildZonePanel.ParamsTypes

procedure TkwMonitoringsMainFormChildZonePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ChildZonePanel', aCtx);
end;//TkwMonitoringsMainFormChildZonePanel.SetValuePrim

procedure TkwMonitoringsMainFormChildZonePanel.DoDoIt(const aCtx: TtfwContext);
var l_aMonitoringsMainForm: TMonitoringsMainForm;
begin
 try
  l_aMonitoringsMainForm := TMonitoringsMainForm(aCtx.rEngine.PopObjAs(TMonitoringsMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMonitoringsMainForm: TMonitoringsMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ChildZonePanel(aCtx, l_aMonitoringsMainForm));
end;//TkwMonitoringsMainFormChildZonePanel.DoDoIt

function TkwMonitoringsMainFormBaseSearchPanel.BaseSearchPanel(const aCtx: TtfwContext;
 aMonitoringsMainForm: TMonitoringsMainForm): TvtPanel;
 {* Реализация слова скрипта .TMonitoringsMainForm.BaseSearchPanel }
begin
 Result := aMonitoringsMainForm.BaseSearchPanel;
end;//TkwMonitoringsMainFormBaseSearchPanel.BaseSearchPanel

class function TkwMonitoringsMainFormBaseSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMonitoringsMainForm.BaseSearchPanel';
end;//TkwMonitoringsMainFormBaseSearchPanel.GetWordNameForRegister

function TkwMonitoringsMainFormBaseSearchPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMonitoringsMainFormBaseSearchPanel.GetResultTypeInfo

function TkwMonitoringsMainFormBaseSearchPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMonitoringsMainFormBaseSearchPanel.GetAllParamsCount

function TkwMonitoringsMainFormBaseSearchPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMonitoringsMainForm)]);
end;//TkwMonitoringsMainFormBaseSearchPanel.ParamsTypes

procedure TkwMonitoringsMainFormBaseSearchPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BaseSearchPanel', aCtx);
end;//TkwMonitoringsMainFormBaseSearchPanel.SetValuePrim

procedure TkwMonitoringsMainFormBaseSearchPanel.DoDoIt(const aCtx: TtfwContext);
var l_aMonitoringsMainForm: TMonitoringsMainForm;
begin
 try
  l_aMonitoringsMainForm := TMonitoringsMainForm(aCtx.rEngine.PopObjAs(TMonitoringsMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMonitoringsMainForm: TMonitoringsMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BaseSearchPanel(aCtx, l_aMonitoringsMainForm));
end;//TkwMonitoringsMainFormBaseSearchPanel.DoDoIt

function TkwMonitoringsMainFormLeftNavigator.LeftNavigator(const aCtx: TtfwContext;
 aMonitoringsMainForm: TMonitoringsMainForm): TnscNavigator;
 {* Реализация слова скрипта .TMonitoringsMainForm.LeftNavigator }
begin
 Result := aMonitoringsMainForm.LeftNavigator;
end;//TkwMonitoringsMainFormLeftNavigator.LeftNavigator

class function TkwMonitoringsMainFormLeftNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMonitoringsMainForm.LeftNavigator';
end;//TkwMonitoringsMainFormLeftNavigator.GetWordNameForRegister

function TkwMonitoringsMainFormLeftNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwMonitoringsMainFormLeftNavigator.GetResultTypeInfo

function TkwMonitoringsMainFormLeftNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMonitoringsMainFormLeftNavigator.GetAllParamsCount

function TkwMonitoringsMainFormLeftNavigator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMonitoringsMainForm)]);
end;//TkwMonitoringsMainFormLeftNavigator.ParamsTypes

procedure TkwMonitoringsMainFormLeftNavigator.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству LeftNavigator', aCtx);
end;//TkwMonitoringsMainFormLeftNavigator.SetValuePrim

procedure TkwMonitoringsMainFormLeftNavigator.DoDoIt(const aCtx: TtfwContext);
var l_aMonitoringsMainForm: TMonitoringsMainForm;
begin
 try
  l_aMonitoringsMainForm := TMonitoringsMainForm(aCtx.rEngine.PopObjAs(TMonitoringsMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMonitoringsMainForm: TMonitoringsMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LeftNavigator(aCtx, l_aMonitoringsMainForm));
end;//TkwMonitoringsMainFormLeftNavigator.DoDoIt

{$If Defined(HasRightNavigator)}
function TkwMonitoringsMainFormRightNavigator.RightNavigator(const aCtx: TtfwContext;
 aMonitoringsMainForm: TMonitoringsMainForm): TnscNavigator;
 {* Реализация слова скрипта .TMonitoringsMainForm.RightNavigator }
begin
 Result := aMonitoringsMainForm.RightNavigator;
end;//TkwMonitoringsMainFormRightNavigator.RightNavigator

class function TkwMonitoringsMainFormRightNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMonitoringsMainForm.RightNavigator';
end;//TkwMonitoringsMainFormRightNavigator.GetWordNameForRegister

function TkwMonitoringsMainFormRightNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwMonitoringsMainFormRightNavigator.GetResultTypeInfo

function TkwMonitoringsMainFormRightNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMonitoringsMainFormRightNavigator.GetAllParamsCount

function TkwMonitoringsMainFormRightNavigator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMonitoringsMainForm)]);
end;//TkwMonitoringsMainFormRightNavigator.ParamsTypes

procedure TkwMonitoringsMainFormRightNavigator.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству RightNavigator', aCtx);
end;//TkwMonitoringsMainFormRightNavigator.SetValuePrim

procedure TkwMonitoringsMainFormRightNavigator.DoDoIt(const aCtx: TtfwContext);
var l_aMonitoringsMainForm: TMonitoringsMainForm;
begin
 try
  l_aMonitoringsMainForm := TMonitoringsMainForm(aCtx.rEngine.PopObjAs(TMonitoringsMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMonitoringsMainForm: TMonitoringsMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RightNavigator(aCtx, l_aMonitoringsMainForm));
end;//TkwMonitoringsMainFormRightNavigator.DoDoIt
{$IfEnd} // Defined(HasRightNavigator)

function Tkw_Form_MonitoringsMain.GetString: AnsiString;
begin
 Result := 'MonitoringsMainForm';
end;//Tkw_Form_MonitoringsMain.GetString

class procedure Tkw_Form_MonitoringsMain.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TMonitoringsMainForm);
end;//Tkw_Form_MonitoringsMain.RegisterInEngine

class function Tkw_Form_MonitoringsMain.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::MonitoringsMain';
end;//Tkw_Form_MonitoringsMain.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_StatusBar.GetString: AnsiString;
begin
 Result := 'StatusBar';
end;//Tkw_MonitoringsMain_Control_StatusBar.GetString

class procedure Tkw_MonitoringsMain_Control_StatusBar.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscStatusBar);
end;//Tkw_MonitoringsMain_Control_StatusBar.RegisterInEngine

class function Tkw_MonitoringsMain_Control_StatusBar.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::StatusBar';
end;//Tkw_MonitoringsMain_Control_StatusBar.GetWordNameForRegister

procedure Tkw_MonitoringsMain_Control_StatusBar_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('StatusBar');
 inherited;
end;//Tkw_MonitoringsMain_Control_StatusBar_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_StatusBar_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::StatusBar:push';
end;//Tkw_MonitoringsMain_Control_StatusBar_Push.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_ClientZone.GetString: AnsiString;
begin
 Result := 'ClientZone';
end;//Tkw_MonitoringsMain_Control_ClientZone.GetString

class procedure Tkw_MonitoringsMain_Control_ClientZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MonitoringsMain_Control_ClientZone.RegisterInEngine

class function Tkw_MonitoringsMain_Control_ClientZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ClientZone';
end;//Tkw_MonitoringsMain_Control_ClientZone.GetWordNameForRegister

procedure Tkw_MonitoringsMain_Control_ClientZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ClientZone');
 inherited;
end;//Tkw_MonitoringsMain_Control_ClientZone_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_ClientZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ClientZone:push';
end;//Tkw_MonitoringsMain_Control_ClientZone_Push.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_MainZone.GetString: AnsiString;
begin
 Result := 'MainZone';
end;//Tkw_MonitoringsMain_Control_MainZone.GetString

class procedure Tkw_MonitoringsMain_Control_MainZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_MonitoringsMain_Control_MainZone.RegisterInEngine

class function Tkw_MonitoringsMain_Control_MainZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MainZone';
end;//Tkw_MonitoringsMain_Control_MainZone.GetWordNameForRegister

procedure Tkw_MonitoringsMain_Control_MainZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('MainZone');
 inherited;
end;//Tkw_MonitoringsMain_Control_MainZone_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_MainZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MainZone:push';
end;//Tkw_MonitoringsMain_Control_MainZone_Push.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_ParentZonePanel.GetString: AnsiString;
begin
 Result := 'ParentZonePanel';
end;//Tkw_MonitoringsMain_Control_ParentZonePanel.GetString

class procedure Tkw_MonitoringsMain_Control_ParentZonePanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MonitoringsMain_Control_ParentZonePanel.RegisterInEngine

class function Tkw_MonitoringsMain_Control_ParentZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZonePanel';
end;//Tkw_MonitoringsMain_Control_ParentZonePanel.GetWordNameForRegister

procedure Tkw_MonitoringsMain_Control_ParentZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ParentZonePanel');
 inherited;
end;//Tkw_MonitoringsMain_Control_ParentZonePanel_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_ParentZonePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZonePanel:push';
end;//Tkw_MonitoringsMain_Control_ParentZonePanel_Push.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_ChildZonePanel.GetString: AnsiString;
begin
 Result := 'ChildZonePanel';
end;//Tkw_MonitoringsMain_Control_ChildZonePanel.GetString

class procedure Tkw_MonitoringsMain_Control_ChildZonePanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_MonitoringsMain_Control_ChildZonePanel.RegisterInEngine

class function Tkw_MonitoringsMain_Control_ChildZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZonePanel';
end;//Tkw_MonitoringsMain_Control_ChildZonePanel.GetWordNameForRegister

procedure Tkw_MonitoringsMain_Control_ChildZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ChildZonePanel');
 inherited;
end;//Tkw_MonitoringsMain_Control_ChildZonePanel_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_ChildZonePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZonePanel:push';
end;//Tkw_MonitoringsMain_Control_ChildZonePanel_Push.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_BaseSearchPanel.GetString: AnsiString;
begin
 Result := 'BaseSearchPanel';
end;//Tkw_MonitoringsMain_Control_BaseSearchPanel.GetString

class procedure Tkw_MonitoringsMain_Control_BaseSearchPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MonitoringsMain_Control_BaseSearchPanel.RegisterInEngine

class function Tkw_MonitoringsMain_Control_BaseSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BaseSearchPanel';
end;//Tkw_MonitoringsMain_Control_BaseSearchPanel.GetWordNameForRegister

procedure Tkw_MonitoringsMain_Control_BaseSearchPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BaseSearchPanel');
 inherited;
end;//Tkw_MonitoringsMain_Control_BaseSearchPanel_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_BaseSearchPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BaseSearchPanel:push';
end;//Tkw_MonitoringsMain_Control_BaseSearchPanel_Push.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_LeftNavigator.GetString: AnsiString;
begin
 Result := 'LeftNavigator';
end;//Tkw_MonitoringsMain_Control_LeftNavigator.GetString

class procedure Tkw_MonitoringsMain_Control_LeftNavigator.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscNavigator);
end;//Tkw_MonitoringsMain_Control_LeftNavigator.RegisterInEngine

class function Tkw_MonitoringsMain_Control_LeftNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftNavigator';
end;//Tkw_MonitoringsMain_Control_LeftNavigator.GetWordNameForRegister

procedure Tkw_MonitoringsMain_Control_LeftNavigator_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('LeftNavigator');
 inherited;
end;//Tkw_MonitoringsMain_Control_LeftNavigator_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_LeftNavigator_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftNavigator:push';
end;//Tkw_MonitoringsMain_Control_LeftNavigator_Push.GetWordNameForRegister

{$If Defined(HasRightNavigator)}
function Tkw_MonitoringsMain_Control_RightNavigator.GetString: AnsiString;
begin
 Result := 'RightNavigator';
end;//Tkw_MonitoringsMain_Control_RightNavigator.GetString

class procedure Tkw_MonitoringsMain_Control_RightNavigator.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscNavigator);
end;//Tkw_MonitoringsMain_Control_RightNavigator.RegisterInEngine

class function Tkw_MonitoringsMain_Control_RightNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightNavigator';
end;//Tkw_MonitoringsMain_Control_RightNavigator.GetWordNameForRegister
{$IfEnd} // Defined(HasRightNavigator)

{$If Defined(HasRightNavigator)}
procedure Tkw_MonitoringsMain_Control_RightNavigator_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RightNavigator');
 inherited;
end;//Tkw_MonitoringsMain_Control_RightNavigator_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_RightNavigator_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightNavigator:push';
end;//Tkw_MonitoringsMain_Control_RightNavigator_Push.GetWordNameForRegister
{$IfEnd} // Defined(HasRightNavigator)

initialization
 TkwMonitoringsMainFormStatusBar.RegisterInEngine;
 {* Регистрация MonitoringsMainForm_StatusBar }
 TkwMonitoringsMainFormClientZone.RegisterInEngine;
 {* Регистрация MonitoringsMainForm_ClientZone }
 TkwMonitoringsMainFormMainZone.RegisterInEngine;
 {* Регистрация MonitoringsMainForm_MainZone }
 TkwMonitoringsMainFormParentZonePanel.RegisterInEngine;
 {* Регистрация MonitoringsMainForm_ParentZonePanel }
 TkwMonitoringsMainFormChildZonePanel.RegisterInEngine;
 {* Регистрация MonitoringsMainForm_ChildZonePanel }
 TkwMonitoringsMainFormBaseSearchPanel.RegisterInEngine;
 {* Регистрация MonitoringsMainForm_BaseSearchPanel }
 TkwMonitoringsMainFormLeftNavigator.RegisterInEngine;
 {* Регистрация MonitoringsMainForm_LeftNavigator }
{$If Defined(HasRightNavigator)}
 TkwMonitoringsMainFormRightNavigator.RegisterInEngine;
 {* Регистрация MonitoringsMainForm_RightNavigator }
{$IfEnd} // Defined(HasRightNavigator)
 Tkw_Form_MonitoringsMain.RegisterInEngine;
 {* Регистрация Tkw_Form_MonitoringsMain }
 Tkw_MonitoringsMain_Control_StatusBar.RegisterInEngine;
 {* Регистрация Tkw_MonitoringsMain_Control_StatusBar }
 Tkw_MonitoringsMain_Control_StatusBar_Push.RegisterInEngine;
 {* Регистрация Tkw_MonitoringsMain_Control_StatusBar_Push }
 Tkw_MonitoringsMain_Control_ClientZone.RegisterInEngine;
 {* Регистрация Tkw_MonitoringsMain_Control_ClientZone }
 Tkw_MonitoringsMain_Control_ClientZone_Push.RegisterInEngine;
 {* Регистрация Tkw_MonitoringsMain_Control_ClientZone_Push }
 Tkw_MonitoringsMain_Control_MainZone.RegisterInEngine;
 {* Регистрация Tkw_MonitoringsMain_Control_MainZone }
 Tkw_MonitoringsMain_Control_MainZone_Push.RegisterInEngine;
 {* Регистрация Tkw_MonitoringsMain_Control_MainZone_Push }
 Tkw_MonitoringsMain_Control_ParentZonePanel.RegisterInEngine;
 {* Регистрация Tkw_MonitoringsMain_Control_ParentZonePanel }
 Tkw_MonitoringsMain_Control_ParentZonePanel_Push.RegisterInEngine;
 {* Регистрация Tkw_MonitoringsMain_Control_ParentZonePanel_Push }
 Tkw_MonitoringsMain_Control_ChildZonePanel.RegisterInEngine;
 {* Регистрация Tkw_MonitoringsMain_Control_ChildZonePanel }
 Tkw_MonitoringsMain_Control_ChildZonePanel_Push.RegisterInEngine;
 {* Регистрация Tkw_MonitoringsMain_Control_ChildZonePanel_Push }
 Tkw_MonitoringsMain_Control_BaseSearchPanel.RegisterInEngine;
 {* Регистрация Tkw_MonitoringsMain_Control_BaseSearchPanel }
 Tkw_MonitoringsMain_Control_BaseSearchPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_MonitoringsMain_Control_BaseSearchPanel_Push }
 Tkw_MonitoringsMain_Control_LeftNavigator.RegisterInEngine;
 {* Регистрация Tkw_MonitoringsMain_Control_LeftNavigator }
 Tkw_MonitoringsMain_Control_LeftNavigator_Push.RegisterInEngine;
 {* Регистрация Tkw_MonitoringsMain_Control_LeftNavigator_Push }
{$If Defined(HasRightNavigator)}
 Tkw_MonitoringsMain_Control_RightNavigator.RegisterInEngine;
 {* Регистрация Tkw_MonitoringsMain_Control_RightNavigator }
{$IfEnd} // Defined(HasRightNavigator)
{$If Defined(HasRightNavigator)}
 Tkw_MonitoringsMain_Control_RightNavigator_Push.RegisterInEngine;
 {* Регистрация Tkw_MonitoringsMain_Control_RightNavigator_Push }
{$IfEnd} // Defined(HasRightNavigator)
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMonitoringsMainForm));
 {* Регистрация типа TMonitoringsMainForm }
{$If Defined(Nemesis)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscStatusBar));
 {* Регистрация типа TnscStatusBar }
{$IfEnd} // Defined(Nemesis)
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* Регистрация типа TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* Регистрация типа TvtSizeablePanel }
{$If Defined(Nemesis)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscNavigator));
 {* Регистрация типа TnscNavigator }
{$IfEnd} // Defined(Nemesis)
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
