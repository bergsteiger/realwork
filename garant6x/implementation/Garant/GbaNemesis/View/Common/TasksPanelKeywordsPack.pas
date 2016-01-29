unit TasksPanelKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/TasksPanelKeywordsPack.pas"
// Начат: 24.08.2009 20:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Core::Common::View::Common::PrimF1Common::TasksPanelKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы TasksPanel
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TasksPanel_Form
  {$If defined(Nemesis)}
  ,
  nscTasksPanelView
  {$IfEnd} //Nemesis
  ,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_TasksPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы TasksPanel
----
*Пример использования*:
[code]
'aControl' форма::TasksPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_TasksPanel

// start class Tkw_Form_TasksPanel

class function Tkw_Form_TasksPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::TasksPanel';
end;//Tkw_Form_TasksPanel.GetWordNameForRegister

function Tkw_Form_TasksPanel.GetString: AnsiString;
 {-}
begin
 Result := 'en_TasksPanel';
end;//Tkw_Form_TasksPanel.GetString

type
  Tkw_TasksPanel_Control_tpvMain = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола tpvMain
----
*Пример использования*:
[code]
контрол::tpvMain TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_TasksPanel_Control_tpvMain

// start class Tkw_TasksPanel_Control_tpvMain

class function Tkw_TasksPanel_Control_tpvMain.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::tpvMain';
end;//Tkw_TasksPanel_Control_tpvMain.GetWordNameForRegister

function Tkw_TasksPanel_Control_tpvMain.GetString: AnsiString;
 {-}
begin
 Result := 'tpvMain';
end;//Tkw_TasksPanel_Control_tpvMain.GetString

class procedure Tkw_TasksPanel_Control_tpvMain.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTasksPanelView);
end;//Tkw_TasksPanel_Control_tpvMain.RegisterInEngine

type
  Tkw_TasksPanel_Control_tpvMain_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола tpvMain
----
*Пример использования*:
[code]
контрол::tpvMain:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_TasksPanel_Control_tpvMain_Push

// start class Tkw_TasksPanel_Control_tpvMain_Push

procedure Tkw_TasksPanel_Control_tpvMain_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('tpvMain');
 inherited;
end;//Tkw_TasksPanel_Control_tpvMain_Push.DoDoIt

class function Tkw_TasksPanel_Control_tpvMain_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::tpvMain:push';
end;//Tkw_TasksPanel_Control_tpvMain_Push.GetWordNameForRegister

type
  TkwEnTasksPanelTpvMain = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_TasksPanel.tpvMain
[panel]Контрол tpvMain формы Ten_TasksPanel[panel]
*Тип результата:* TnscTasksPanelView
*Пример:*
[code]
OBJECT VAR l_TnscTasksPanelView
 aen_TasksPanel .Ten_TasksPanel.tpvMain >>> l_TnscTasksPanelView
[code]  }
  private
  // private methods
   function TpvMain(const aCtx: TtfwContext;
     aen_TasksPanel: Ten_TasksPanel): TnscTasksPanelView;
     {* Реализация слова скрипта .Ten_TasksPanel.tpvMain }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnTasksPanelTpvMain

// start class TkwEnTasksPanelTpvMain

function TkwEnTasksPanelTpvMain.TpvMain(const aCtx: TtfwContext;
  aen_TasksPanel: Ten_TasksPanel): TnscTasksPanelView;
 {-}
begin
 Result := aen_TasksPanel.tpvMain;
end;//TkwEnTasksPanelTpvMain.TpvMain

procedure TkwEnTasksPanelTpvMain.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_TasksPanel : Ten_TasksPanel;
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
 aCtx.rEngine.PushObj((TpvMain(aCtx, l_aen_TasksPanel)));
end;//TkwEnTasksPanelTpvMain.DoDoIt

class function TkwEnTasksPanelTpvMain.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_TasksPanel.tpvMain';
end;//TkwEnTasksPanelTpvMain.GetWordNameForRegister

procedure TkwEnTasksPanelTpvMain.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству tpvMain', aCtx);
end;//TkwEnTasksPanelTpvMain.SetValuePrim

function TkwEnTasksPanelTpvMain.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTasksPanelView);
end;//TkwEnTasksPanelTpvMain.GetResultTypeInfo

function TkwEnTasksPanelTpvMain.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnTasksPanelTpvMain.GetAllParamsCount

function TkwEnTasksPanelTpvMain.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TasksPanel)]);
end;//TkwEnTasksPanelTpvMain.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_TasksPanel
 Tkw_Form_TasksPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TasksPanel_Control_tpvMain
 Tkw_TasksPanel_Control_tpvMain.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TasksPanel_Control_tpvMain_Push
 Tkw_TasksPanel_Control_tpvMain_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_TasksPanel_tpvMain
 TkwEnTasksPanelTpvMain.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TasksPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_TasksPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscTasksPanelView
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTasksPanelView));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.