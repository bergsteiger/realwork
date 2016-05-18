unit TasksPanelKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы TasksPanel }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\TasksPanelKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "TasksPanelKeywordsPack" MUID: (4ABBAC4D02D9_Pack)

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
 , TasksPanel_Form
 , tfwPropertyLike
 {$If Defined(Nemesis)}
 , nscTasksPanelView
 {$IfEnd} // Defined(Nemesis)
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwEnTasksPanelTpvMain = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TasksPanel.tpvMain }
  private
   function tpvMain(const aCtx: TtfwContext;
    aen_TasksPanel: Ten_TasksPanel): TnscTasksPanelView;
    {* Реализация слова скрипта .Ten_TasksPanel.tpvMain }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnTasksPanelTpvMain

 Tkw_Form_TasksPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы TasksPanel
----
*Пример использования*:
[code]форма::TasksPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_TasksPanel

 Tkw_TasksPanel_Control_tpvMain = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tpvMain
----
*Пример использования*:
[code]контрол::tpvMain TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TasksPanel_Control_tpvMain

 Tkw_TasksPanel_Control_tpvMain_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола tpvMain
----
*Пример использования*:
[code]контрол::tpvMain:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TasksPanel_Control_tpvMain_Push

function TkwEnTasksPanelTpvMain.tpvMain(const aCtx: TtfwContext;
 aen_TasksPanel: Ten_TasksPanel): TnscTasksPanelView;
 {* Реализация слова скрипта .Ten_TasksPanel.tpvMain }
begin
 Result := aen_TasksPanel.tpvMain;
end;//TkwEnTasksPanelTpvMain.tpvMain

class function TkwEnTasksPanelTpvMain.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TasksPanel.tpvMain';
end;//TkwEnTasksPanelTpvMain.GetWordNameForRegister

function TkwEnTasksPanelTpvMain.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTasksPanelView);
end;//TkwEnTasksPanelTpvMain.GetResultTypeInfo

function TkwEnTasksPanelTpvMain.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTasksPanelTpvMain.GetAllParamsCount

function TkwEnTasksPanelTpvMain.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TasksPanel)]);
end;//TkwEnTasksPanelTpvMain.ParamsTypes

procedure TkwEnTasksPanelTpvMain.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tpvMain', aCtx);
end;//TkwEnTasksPanelTpvMain.SetValuePrim

procedure TkwEnTasksPanelTpvMain.DoDoIt(const aCtx: TtfwContext);
var l_aen_TasksPanel: Ten_TasksPanel;
begin
 try
  l_aen_TasksPanel := Ten_TasksPanel(aCtx.rEngine.PopObjAs(Ten_TasksPanel));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_TasksPanel: Ten_TasksPanel : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tpvMain(aCtx, l_aen_TasksPanel));
end;//TkwEnTasksPanelTpvMain.DoDoIt

function Tkw_Form_TasksPanel.GetString: AnsiString;
begin
 Result := 'en_TasksPanel';
end;//Tkw_Form_TasksPanel.GetString

class procedure Tkw_Form_TasksPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(Ten_TasksPanel);
end;//Tkw_Form_TasksPanel.RegisterInEngine

class function Tkw_Form_TasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::TasksPanel';
end;//Tkw_Form_TasksPanel.GetWordNameForRegister

function Tkw_TasksPanel_Control_tpvMain.GetString: AnsiString;
begin
 Result := 'tpvMain';
end;//Tkw_TasksPanel_Control_tpvMain.GetString

class procedure Tkw_TasksPanel_Control_tpvMain.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTasksPanelView);
end;//Tkw_TasksPanel_Control_tpvMain.RegisterInEngine

class function Tkw_TasksPanel_Control_tpvMain.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tpvMain';
end;//Tkw_TasksPanel_Control_tpvMain.GetWordNameForRegister

procedure Tkw_TasksPanel_Control_tpvMain_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tpvMain');
 inherited;
end;//Tkw_TasksPanel_Control_tpvMain_Push.DoDoIt

class function Tkw_TasksPanel_Control_tpvMain_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tpvMain:push';
end;//Tkw_TasksPanel_Control_tpvMain_Push.GetWordNameForRegister

initialization
 TkwEnTasksPanelTpvMain.RegisterInEngine;
 {* Регистрация en_TasksPanel_tpvMain }
 Tkw_Form_TasksPanel.RegisterInEngine;
 {* Регистрация Tkw_Form_TasksPanel }
 Tkw_TasksPanel_Control_tpvMain.RegisterInEngine;
 {* Регистрация Tkw_TasksPanel_Control_tpvMain }
 Tkw_TasksPanel_Control_tpvMain_Push.RegisterInEngine;
 {* Регистрация Tkw_TasksPanel_Control_tpvMain_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_TasksPanel));
 {* Регистрация типа Ten_TasksPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTasksPanelView));
 {* Регистрация типа TnscTasksPanelView }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
