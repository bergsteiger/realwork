unit MonitoringsMainKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/MonitoringsMainKeywordsPack.pas"
// Начат: 10.09.2009 17:48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Утилита Прайм::Monitoring::Monitorings::MonitoringsMainKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы MonitoringsMain
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(Nemesis)}
  ,
  nscNavigator
  {$IfEnd} //Nemesis
  ,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  tfwScriptingInterfaces
  {$If defined(Nemesis)}
  ,
  nscStatusBar
  {$IfEnd} //Nemesis
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  MonitoringsMain_Form,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //Monitorings AND not Admin AND not NoScripts

implementation

{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 Tkw_Form_MonitoringsMain = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора формы MonitoringsMain
----
*Пример использования*:
[code]
'aControl' форма::MonitoringsMain TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_MonitoringsMain

// start class Tkw_Form_MonitoringsMain

class function Tkw_Form_MonitoringsMain.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::MonitoringsMain';
end;//Tkw_Form_MonitoringsMain.GetWordNameForRegister

function Tkw_Form_MonitoringsMain.GetString: AnsiString;
 {-}
begin
 Result := 'MonitoringsMainForm';
end;//Tkw_Form_MonitoringsMain.GetString

type
 Tkw_MonitoringsMain_Control_StatusBar = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола StatusBar
----
*Пример использования*:
[code]
контрол::StatusBar TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MonitoringsMain_Control_StatusBar

// start class Tkw_MonitoringsMain_Control_StatusBar

class function Tkw_MonitoringsMain_Control_StatusBar.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::StatusBar';
end;//Tkw_MonitoringsMain_Control_StatusBar.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_StatusBar.GetString: AnsiString;
 {-}
begin
 Result := 'StatusBar';
end;//Tkw_MonitoringsMain_Control_StatusBar.GetString

class procedure Tkw_MonitoringsMain_Control_StatusBar.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscStatusBar);
end;//Tkw_MonitoringsMain_Control_StatusBar.RegisterInEngine

type
 Tkw_MonitoringsMain_Control_StatusBar_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола StatusBar
----
*Пример использования*:
[code]
контрол::StatusBar:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_StatusBar_Push

// start class Tkw_MonitoringsMain_Control_StatusBar_Push

procedure Tkw_MonitoringsMain_Control_StatusBar_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('StatusBar');
 inherited;
end;//Tkw_MonitoringsMain_Control_StatusBar_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_StatusBar_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::StatusBar:push';
end;//Tkw_MonitoringsMain_Control_StatusBar_Push.GetWordNameForRegister

type
 Tkw_MonitoringsMain_Control_ClientZone = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ClientZone
----
*Пример использования*:
[code]
контрол::ClientZone TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MonitoringsMain_Control_ClientZone

// start class Tkw_MonitoringsMain_Control_ClientZone

class function Tkw_MonitoringsMain_Control_ClientZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ClientZone';
end;//Tkw_MonitoringsMain_Control_ClientZone.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_ClientZone.GetString: AnsiString;
 {-}
begin
 Result := 'ClientZone';
end;//Tkw_MonitoringsMain_Control_ClientZone.GetString

class procedure Tkw_MonitoringsMain_Control_ClientZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MonitoringsMain_Control_ClientZone.RegisterInEngine

type
 Tkw_MonitoringsMain_Control_ClientZone_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола ClientZone
----
*Пример использования*:
[code]
контрол::ClientZone:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_ClientZone_Push

// start class Tkw_MonitoringsMain_Control_ClientZone_Push

procedure Tkw_MonitoringsMain_Control_ClientZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ClientZone');
 inherited;
end;//Tkw_MonitoringsMain_Control_ClientZone_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_ClientZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ClientZone:push';
end;//Tkw_MonitoringsMain_Control_ClientZone_Push.GetWordNameForRegister

type
 Tkw_MonitoringsMain_Control_MainZone = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола MainZone
----
*Пример использования*:
[code]
контрол::MainZone TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MonitoringsMain_Control_MainZone

// start class Tkw_MonitoringsMain_Control_MainZone

class function Tkw_MonitoringsMain_Control_MainZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::MainZone';
end;//Tkw_MonitoringsMain_Control_MainZone.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_MainZone.GetString: AnsiString;
 {-}
begin
 Result := 'MainZone';
end;//Tkw_MonitoringsMain_Control_MainZone.GetString

class procedure Tkw_MonitoringsMain_Control_MainZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_MonitoringsMain_Control_MainZone.RegisterInEngine

type
 Tkw_MonitoringsMain_Control_MainZone_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола MainZone
----
*Пример использования*:
[code]
контрол::MainZone:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_MainZone_Push

// start class Tkw_MonitoringsMain_Control_MainZone_Push

procedure Tkw_MonitoringsMain_Control_MainZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('MainZone');
 inherited;
end;//Tkw_MonitoringsMain_Control_MainZone_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_MainZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::MainZone:push';
end;//Tkw_MonitoringsMain_Control_MainZone_Push.GetWordNameForRegister

type
 Tkw_MonitoringsMain_Control_ParentZonePanel = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ParentZonePanel
----
*Пример использования*:
[code]
контрол::ParentZonePanel TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MonitoringsMain_Control_ParentZonePanel

// start class Tkw_MonitoringsMain_Control_ParentZonePanel

class function Tkw_MonitoringsMain_Control_ParentZonePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ParentZonePanel';
end;//Tkw_MonitoringsMain_Control_ParentZonePanel.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_ParentZonePanel.GetString: AnsiString;
 {-}
begin
 Result := 'ParentZonePanel';
end;//Tkw_MonitoringsMain_Control_ParentZonePanel.GetString

class procedure Tkw_MonitoringsMain_Control_ParentZonePanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MonitoringsMain_Control_ParentZonePanel.RegisterInEngine

type
 Tkw_MonitoringsMain_Control_ParentZonePanel_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола ParentZonePanel
----
*Пример использования*:
[code]
контрол::ParentZonePanel:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_ParentZonePanel_Push

// start class Tkw_MonitoringsMain_Control_ParentZonePanel_Push

procedure Tkw_MonitoringsMain_Control_ParentZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ParentZonePanel');
 inherited;
end;//Tkw_MonitoringsMain_Control_ParentZonePanel_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_ParentZonePanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ParentZonePanel:push';
end;//Tkw_MonitoringsMain_Control_ParentZonePanel_Push.GetWordNameForRegister

type
 Tkw_MonitoringsMain_Control_ChildZonePanel = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ChildZonePanel
----
*Пример использования*:
[code]
контрол::ChildZonePanel TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MonitoringsMain_Control_ChildZonePanel

// start class Tkw_MonitoringsMain_Control_ChildZonePanel

class function Tkw_MonitoringsMain_Control_ChildZonePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ChildZonePanel';
end;//Tkw_MonitoringsMain_Control_ChildZonePanel.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_ChildZonePanel.GetString: AnsiString;
 {-}
begin
 Result := 'ChildZonePanel';
end;//Tkw_MonitoringsMain_Control_ChildZonePanel.GetString

class procedure Tkw_MonitoringsMain_Control_ChildZonePanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_MonitoringsMain_Control_ChildZonePanel.RegisterInEngine

type
 Tkw_MonitoringsMain_Control_ChildZonePanel_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола ChildZonePanel
----
*Пример использования*:
[code]
контрол::ChildZonePanel:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_ChildZonePanel_Push

// start class Tkw_MonitoringsMain_Control_ChildZonePanel_Push

procedure Tkw_MonitoringsMain_Control_ChildZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ChildZonePanel');
 inherited;
end;//Tkw_MonitoringsMain_Control_ChildZonePanel_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_ChildZonePanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ChildZonePanel:push';
end;//Tkw_MonitoringsMain_Control_ChildZonePanel_Push.GetWordNameForRegister

type
 Tkw_MonitoringsMain_Control_BaseSearchPanel = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BaseSearchPanel
----
*Пример использования*:
[code]
контрол::BaseSearchPanel TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MonitoringsMain_Control_BaseSearchPanel

// start class Tkw_MonitoringsMain_Control_BaseSearchPanel

class function Tkw_MonitoringsMain_Control_BaseSearchPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BaseSearchPanel';
end;//Tkw_MonitoringsMain_Control_BaseSearchPanel.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_BaseSearchPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BaseSearchPanel';
end;//Tkw_MonitoringsMain_Control_BaseSearchPanel.GetString

class procedure Tkw_MonitoringsMain_Control_BaseSearchPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MonitoringsMain_Control_BaseSearchPanel.RegisterInEngine

type
 Tkw_MonitoringsMain_Control_BaseSearchPanel_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола BaseSearchPanel
----
*Пример использования*:
[code]
контрол::BaseSearchPanel:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_BaseSearchPanel_Push

// start class Tkw_MonitoringsMain_Control_BaseSearchPanel_Push

procedure Tkw_MonitoringsMain_Control_BaseSearchPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BaseSearchPanel');
 inherited;
end;//Tkw_MonitoringsMain_Control_BaseSearchPanel_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_BaseSearchPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BaseSearchPanel:push';
end;//Tkw_MonitoringsMain_Control_BaseSearchPanel_Push.GetWordNameForRegister

type
 Tkw_MonitoringsMain_Control_LeftNavigator = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LeftNavigator
----
*Пример использования*:
[code]
контрол::LeftNavigator TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MonitoringsMain_Control_LeftNavigator

// start class Tkw_MonitoringsMain_Control_LeftNavigator

class function Tkw_MonitoringsMain_Control_LeftNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LeftNavigator';
end;//Tkw_MonitoringsMain_Control_LeftNavigator.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_LeftNavigator.GetString: AnsiString;
 {-}
begin
 Result := 'LeftNavigator';
end;//Tkw_MonitoringsMain_Control_LeftNavigator.GetString

class procedure Tkw_MonitoringsMain_Control_LeftNavigator.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscNavigator);
end;//Tkw_MonitoringsMain_Control_LeftNavigator.RegisterInEngine

type
 Tkw_MonitoringsMain_Control_LeftNavigator_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола LeftNavigator
----
*Пример использования*:
[code]
контрол::LeftNavigator:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_LeftNavigator_Push

// start class Tkw_MonitoringsMain_Control_LeftNavigator_Push

procedure Tkw_MonitoringsMain_Control_LeftNavigator_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('LeftNavigator');
 inherited;
end;//Tkw_MonitoringsMain_Control_LeftNavigator_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_LeftNavigator_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LeftNavigator:push';
end;//Tkw_MonitoringsMain_Control_LeftNavigator_Push.GetWordNameForRegister
{$If defined(HasRightNavigator) AND defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}

type
 Tkw_MonitoringsMain_Control_RightNavigator = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RightNavigator
----
*Пример использования*:
[code]
контрол::RightNavigator TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MonitoringsMain_Control_RightNavigator
{$IfEnd} //HasRightNavigator AND Monitorings AND not Admin AND not NoScripts

{$If defined(HasRightNavigator) AND defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_MonitoringsMain_Control_RightNavigator

class function Tkw_MonitoringsMain_Control_RightNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RightNavigator';
end;//Tkw_MonitoringsMain_Control_RightNavigator.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_RightNavigator.GetString: AnsiString;
 {-}
begin
 Result := 'RightNavigator';
end;//Tkw_MonitoringsMain_Control_RightNavigator.GetString

class procedure Tkw_MonitoringsMain_Control_RightNavigator.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscNavigator);
end;//Tkw_MonitoringsMain_Control_RightNavigator.RegisterInEngine

{$IfEnd} //HasRightNavigator AND Monitorings AND not Admin AND not NoScripts
{$If defined(HasRightNavigator) AND defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}

type
 Tkw_MonitoringsMain_Control_RightNavigator_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола RightNavigator
----
*Пример использования*:
[code]
контрол::RightNavigator:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_RightNavigator_Push
{$IfEnd} //HasRightNavigator AND Monitorings AND not Admin AND not NoScripts

{$If defined(HasRightNavigator) AND defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_MonitoringsMain_Control_RightNavigator_Push

procedure Tkw_MonitoringsMain_Control_RightNavigator_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('RightNavigator');
 inherited;
end;//Tkw_MonitoringsMain_Control_RightNavigator_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_RightNavigator_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RightNavigator:push';
end;//Tkw_MonitoringsMain_Control_RightNavigator_Push.GetWordNameForRegister

{$IfEnd} //HasRightNavigator AND Monitorings AND not Admin AND not NoScripts

type
 TkwMonitoringsMainFormStatusBar = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMonitoringsMainForm.StatusBar
[panel]Контрол StatusBar формы TMonitoringsMainForm[panel]
*Тип результата:* TnscStatusBar
*Пример:*
[code]
OBJECT VAR l_TnscStatusBar
 aMonitoringsMainForm .TMonitoringsMainForm.StatusBar >>> l_TnscStatusBar
[code]  }
 private
 // private methods
   function StatusBar(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TnscStatusBar;
     {* Реализация слова скрипта .TMonitoringsMainForm.StatusBar }
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
 end;//TkwMonitoringsMainFormStatusBar

// start class TkwMonitoringsMainFormStatusBar

function TkwMonitoringsMainFormStatusBar.StatusBar(const aCtx: TtfwContext;
  aMonitoringsMainForm: TMonitoringsMainForm): TnscStatusBar;
 {-}
begin
 Result := aMonitoringsMainForm.StatusBar;
end;//TkwMonitoringsMainFormStatusBar.StatusBar

procedure TkwMonitoringsMainFormStatusBar.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMonitoringsMainForm : TMonitoringsMainForm;
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
 aCtx.rEngine.PushObj((StatusBar(aCtx, l_aMonitoringsMainForm)));
end;//TkwMonitoringsMainFormStatusBar.DoDoIt

class function TkwMonitoringsMainFormStatusBar.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMonitoringsMainForm.StatusBar';
end;//TkwMonitoringsMainFormStatusBar.GetWordNameForRegister

procedure TkwMonitoringsMainFormStatusBar.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству StatusBar', aCtx);
end;//TkwMonitoringsMainFormStatusBar.SetValuePrim

function TkwMonitoringsMainFormStatusBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscStatusBar);
end;//TkwMonitoringsMainFormStatusBar.GetResultTypeInfo

function TkwMonitoringsMainFormStatusBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMonitoringsMainFormStatusBar.GetAllParamsCount

function TkwMonitoringsMainFormStatusBar.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMonitoringsMainForm)]);
end;//TkwMonitoringsMainFormStatusBar.ParamsTypes

type
 TkwMonitoringsMainFormClientZone = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMonitoringsMainForm.ClientZone
[panel]Контрол ClientZone формы TMonitoringsMainForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMonitoringsMainForm .TMonitoringsMainForm.ClientZone >>> l_TvtPanel
[code]  }
 private
 // private methods
   function ClientZone(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TvtPanel;
     {* Реализация слова скрипта .TMonitoringsMainForm.ClientZone }
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
 end;//TkwMonitoringsMainFormClientZone

// start class TkwMonitoringsMainFormClientZone

function TkwMonitoringsMainFormClientZone.ClientZone(const aCtx: TtfwContext;
  aMonitoringsMainForm: TMonitoringsMainForm): TvtPanel;
 {-}
begin
 Result := aMonitoringsMainForm.ClientZone;
end;//TkwMonitoringsMainFormClientZone.ClientZone

procedure TkwMonitoringsMainFormClientZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMonitoringsMainForm : TMonitoringsMainForm;
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
 aCtx.rEngine.PushObj((ClientZone(aCtx, l_aMonitoringsMainForm)));
end;//TkwMonitoringsMainFormClientZone.DoDoIt

class function TkwMonitoringsMainFormClientZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMonitoringsMainForm.ClientZone';
end;//TkwMonitoringsMainFormClientZone.GetWordNameForRegister

procedure TkwMonitoringsMainFormClientZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ClientZone', aCtx);
end;//TkwMonitoringsMainFormClientZone.SetValuePrim

function TkwMonitoringsMainFormClientZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMonitoringsMainFormClientZone.GetResultTypeInfo

function TkwMonitoringsMainFormClientZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMonitoringsMainFormClientZone.GetAllParamsCount

function TkwMonitoringsMainFormClientZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMonitoringsMainForm)]);
end;//TkwMonitoringsMainFormClientZone.ParamsTypes

type
 TkwMonitoringsMainFormMainZone = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMonitoringsMainForm.MainZone
[panel]Контрол MainZone формы TMonitoringsMainForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aMonitoringsMainForm .TMonitoringsMainForm.MainZone >>> l_TvtProportionalPanel
[code]  }
 private
 // private methods
   function MainZone(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TvtProportionalPanel;
     {* Реализация слова скрипта .TMonitoringsMainForm.MainZone }
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
 end;//TkwMonitoringsMainFormMainZone

// start class TkwMonitoringsMainFormMainZone

function TkwMonitoringsMainFormMainZone.MainZone(const aCtx: TtfwContext;
  aMonitoringsMainForm: TMonitoringsMainForm): TvtProportionalPanel;
 {-}
begin
 Result := aMonitoringsMainForm.MainZone;
end;//TkwMonitoringsMainFormMainZone.MainZone

procedure TkwMonitoringsMainFormMainZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMonitoringsMainForm : TMonitoringsMainForm;
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
 aCtx.rEngine.PushObj((MainZone(aCtx, l_aMonitoringsMainForm)));
end;//TkwMonitoringsMainFormMainZone.DoDoIt

class function TkwMonitoringsMainFormMainZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMonitoringsMainForm.MainZone';
end;//TkwMonitoringsMainFormMainZone.GetWordNameForRegister

procedure TkwMonitoringsMainFormMainZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству MainZone', aCtx);
end;//TkwMonitoringsMainFormMainZone.SetValuePrim

function TkwMonitoringsMainFormMainZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwMonitoringsMainFormMainZone.GetResultTypeInfo

function TkwMonitoringsMainFormMainZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMonitoringsMainFormMainZone.GetAllParamsCount

function TkwMonitoringsMainFormMainZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMonitoringsMainForm)]);
end;//TkwMonitoringsMainFormMainZone.ParamsTypes

type
 TkwMonitoringsMainFormParentZonePanel = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMonitoringsMainForm.ParentZonePanel
[panel]Контрол ParentZonePanel формы TMonitoringsMainForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMonitoringsMainForm .TMonitoringsMainForm.ParentZonePanel >>> l_TvtPanel
[code]  }
 private
 // private methods
   function ParentZonePanel(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TvtPanel;
     {* Реализация слова скрипта .TMonitoringsMainForm.ParentZonePanel }
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
 end;//TkwMonitoringsMainFormParentZonePanel

// start class TkwMonitoringsMainFormParentZonePanel

function TkwMonitoringsMainFormParentZonePanel.ParentZonePanel(const aCtx: TtfwContext;
  aMonitoringsMainForm: TMonitoringsMainForm): TvtPanel;
 {-}
begin
 Result := aMonitoringsMainForm.ParentZonePanel;
end;//TkwMonitoringsMainFormParentZonePanel.ParentZonePanel

procedure TkwMonitoringsMainFormParentZonePanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMonitoringsMainForm : TMonitoringsMainForm;
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
 aCtx.rEngine.PushObj((ParentZonePanel(aCtx, l_aMonitoringsMainForm)));
end;//TkwMonitoringsMainFormParentZonePanel.DoDoIt

class function TkwMonitoringsMainFormParentZonePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMonitoringsMainForm.ParentZonePanel';
end;//TkwMonitoringsMainFormParentZonePanel.GetWordNameForRegister

procedure TkwMonitoringsMainFormParentZonePanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ParentZonePanel', aCtx);
end;//TkwMonitoringsMainFormParentZonePanel.SetValuePrim

function TkwMonitoringsMainFormParentZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMonitoringsMainFormParentZonePanel.GetResultTypeInfo

function TkwMonitoringsMainFormParentZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMonitoringsMainFormParentZonePanel.GetAllParamsCount

function TkwMonitoringsMainFormParentZonePanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMonitoringsMainForm)]);
end;//TkwMonitoringsMainFormParentZonePanel.ParamsTypes

type
 TkwMonitoringsMainFormChildZonePanel = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMonitoringsMainForm.ChildZonePanel
[panel]Контрол ChildZonePanel формы TMonitoringsMainForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aMonitoringsMainForm .TMonitoringsMainForm.ChildZonePanel >>> l_TvtSizeablePanel
[code]  }
 private
 // private methods
   function ChildZonePanel(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TvtSizeablePanel;
     {* Реализация слова скрипта .TMonitoringsMainForm.ChildZonePanel }
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
 end;//TkwMonitoringsMainFormChildZonePanel

// start class TkwMonitoringsMainFormChildZonePanel

function TkwMonitoringsMainFormChildZonePanel.ChildZonePanel(const aCtx: TtfwContext;
  aMonitoringsMainForm: TMonitoringsMainForm): TvtSizeablePanel;
 {-}
begin
 Result := aMonitoringsMainForm.ChildZonePanel;
end;//TkwMonitoringsMainFormChildZonePanel.ChildZonePanel

procedure TkwMonitoringsMainFormChildZonePanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMonitoringsMainForm : TMonitoringsMainForm;
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
 aCtx.rEngine.PushObj((ChildZonePanel(aCtx, l_aMonitoringsMainForm)));
end;//TkwMonitoringsMainFormChildZonePanel.DoDoIt

class function TkwMonitoringsMainFormChildZonePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMonitoringsMainForm.ChildZonePanel';
end;//TkwMonitoringsMainFormChildZonePanel.GetWordNameForRegister

procedure TkwMonitoringsMainFormChildZonePanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ChildZonePanel', aCtx);
end;//TkwMonitoringsMainFormChildZonePanel.SetValuePrim

function TkwMonitoringsMainFormChildZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwMonitoringsMainFormChildZonePanel.GetResultTypeInfo

function TkwMonitoringsMainFormChildZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMonitoringsMainFormChildZonePanel.GetAllParamsCount

function TkwMonitoringsMainFormChildZonePanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMonitoringsMainForm)]);
end;//TkwMonitoringsMainFormChildZonePanel.ParamsTypes

type
 TkwMonitoringsMainFormBaseSearchPanel = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMonitoringsMainForm.BaseSearchPanel
[panel]Контрол BaseSearchPanel формы TMonitoringsMainForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMonitoringsMainForm .TMonitoringsMainForm.BaseSearchPanel >>> l_TvtPanel
[code]  }
 private
 // private methods
   function BaseSearchPanel(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TvtPanel;
     {* Реализация слова скрипта .TMonitoringsMainForm.BaseSearchPanel }
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
 end;//TkwMonitoringsMainFormBaseSearchPanel

// start class TkwMonitoringsMainFormBaseSearchPanel

function TkwMonitoringsMainFormBaseSearchPanel.BaseSearchPanel(const aCtx: TtfwContext;
  aMonitoringsMainForm: TMonitoringsMainForm): TvtPanel;
 {-}
begin
 Result := aMonitoringsMainForm.BaseSearchPanel;
end;//TkwMonitoringsMainFormBaseSearchPanel.BaseSearchPanel

procedure TkwMonitoringsMainFormBaseSearchPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMonitoringsMainForm : TMonitoringsMainForm;
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
 aCtx.rEngine.PushObj((BaseSearchPanel(aCtx, l_aMonitoringsMainForm)));
end;//TkwMonitoringsMainFormBaseSearchPanel.DoDoIt

class function TkwMonitoringsMainFormBaseSearchPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMonitoringsMainForm.BaseSearchPanel';
end;//TkwMonitoringsMainFormBaseSearchPanel.GetWordNameForRegister

procedure TkwMonitoringsMainFormBaseSearchPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству BaseSearchPanel', aCtx);
end;//TkwMonitoringsMainFormBaseSearchPanel.SetValuePrim

function TkwMonitoringsMainFormBaseSearchPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMonitoringsMainFormBaseSearchPanel.GetResultTypeInfo

function TkwMonitoringsMainFormBaseSearchPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMonitoringsMainFormBaseSearchPanel.GetAllParamsCount

function TkwMonitoringsMainFormBaseSearchPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMonitoringsMainForm)]);
end;//TkwMonitoringsMainFormBaseSearchPanel.ParamsTypes

type
 TkwMonitoringsMainFormLeftNavigator = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMonitoringsMainForm.LeftNavigator
[panel]Контрол LeftNavigator формы TMonitoringsMainForm[panel]
*Тип результата:* TnscNavigator
*Пример:*
[code]
OBJECT VAR l_TnscNavigator
 aMonitoringsMainForm .TMonitoringsMainForm.LeftNavigator >>> l_TnscNavigator
[code]  }
 private
 // private methods
   function LeftNavigator(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TnscNavigator;
     {* Реализация слова скрипта .TMonitoringsMainForm.LeftNavigator }
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
 end;//TkwMonitoringsMainFormLeftNavigator

// start class TkwMonitoringsMainFormLeftNavigator

function TkwMonitoringsMainFormLeftNavigator.LeftNavigator(const aCtx: TtfwContext;
  aMonitoringsMainForm: TMonitoringsMainForm): TnscNavigator;
 {-}
begin
 Result := aMonitoringsMainForm.LeftNavigator;
end;//TkwMonitoringsMainFormLeftNavigator.LeftNavigator

procedure TkwMonitoringsMainFormLeftNavigator.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMonitoringsMainForm : TMonitoringsMainForm;
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
 aCtx.rEngine.PushObj((LeftNavigator(aCtx, l_aMonitoringsMainForm)));
end;//TkwMonitoringsMainFormLeftNavigator.DoDoIt

class function TkwMonitoringsMainFormLeftNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMonitoringsMainForm.LeftNavigator';
end;//TkwMonitoringsMainFormLeftNavigator.GetWordNameForRegister

procedure TkwMonitoringsMainFormLeftNavigator.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству LeftNavigator', aCtx);
end;//TkwMonitoringsMainFormLeftNavigator.SetValuePrim

function TkwMonitoringsMainFormLeftNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwMonitoringsMainFormLeftNavigator.GetResultTypeInfo

function TkwMonitoringsMainFormLeftNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMonitoringsMainFormLeftNavigator.GetAllParamsCount

function TkwMonitoringsMainFormLeftNavigator.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMonitoringsMainForm)]);
end;//TkwMonitoringsMainFormLeftNavigator.ParamsTypes
{$If defined(HasRightNavigator) AND defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}

type
 TkwMonitoringsMainFormRightNavigator = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMonitoringsMainForm.RightNavigator
[panel]Контрол RightNavigator формы TMonitoringsMainForm[panel]
*Тип результата:* TnscNavigator
*Пример:*
[code]
OBJECT VAR l_TnscNavigator
 aMonitoringsMainForm .TMonitoringsMainForm.RightNavigator >>> l_TnscNavigator
[code]  }
 private
 // private methods
   function RightNavigator(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TnscNavigator;
     {* Реализация слова скрипта .TMonitoringsMainForm.RightNavigator }
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
 end;//TkwMonitoringsMainFormRightNavigator
{$IfEnd} //HasRightNavigator AND Monitorings AND not Admin AND not NoScripts

{$If defined(HasRightNavigator) AND defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}

// start class TkwMonitoringsMainFormRightNavigator

function TkwMonitoringsMainFormRightNavigator.RightNavigator(const aCtx: TtfwContext;
  aMonitoringsMainForm: TMonitoringsMainForm): TnscNavigator;
 {-}
begin
 Result := aMonitoringsMainForm.RightNavigator;
end;//TkwMonitoringsMainFormRightNavigator.RightNavigator

procedure TkwMonitoringsMainFormRightNavigator.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMonitoringsMainForm : TMonitoringsMainForm;
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
 aCtx.rEngine.PushObj((RightNavigator(aCtx, l_aMonitoringsMainForm)));
end;//TkwMonitoringsMainFormRightNavigator.DoDoIt

class function TkwMonitoringsMainFormRightNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMonitoringsMainForm.RightNavigator';
end;//TkwMonitoringsMainFormRightNavigator.GetWordNameForRegister

procedure TkwMonitoringsMainFormRightNavigator.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству RightNavigator', aCtx);
end;//TkwMonitoringsMainFormRightNavigator.SetValuePrim

function TkwMonitoringsMainFormRightNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwMonitoringsMainFormRightNavigator.GetResultTypeInfo

function TkwMonitoringsMainFormRightNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMonitoringsMainFormRightNavigator.GetAllParamsCount

function TkwMonitoringsMainFormRightNavigator.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMonitoringsMainForm)]);
end;//TkwMonitoringsMainFormRightNavigator.ParamsTypes

{$IfEnd} //HasRightNavigator AND Monitorings AND not Admin AND not NoScripts
{$IfEnd} //Monitorings AND not Admin AND not NoScripts

initialization
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_Form_MonitoringsMain
 Tkw_Form_MonitoringsMain.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_MonitoringsMain_Control_StatusBar
 Tkw_MonitoringsMain_Control_StatusBar.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_MonitoringsMain_Control_StatusBar_Push
 Tkw_MonitoringsMain_Control_StatusBar_Push.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_MonitoringsMain_Control_ClientZone
 Tkw_MonitoringsMain_Control_ClientZone.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_MonitoringsMain_Control_ClientZone_Push
 Tkw_MonitoringsMain_Control_ClientZone_Push.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_MonitoringsMain_Control_MainZone
 Tkw_MonitoringsMain_Control_MainZone.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_MonitoringsMain_Control_MainZone_Push
 Tkw_MonitoringsMain_Control_MainZone_Push.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_MonitoringsMain_Control_ParentZonePanel
 Tkw_MonitoringsMain_Control_ParentZonePanel.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_MonitoringsMain_Control_ParentZonePanel_Push
 Tkw_MonitoringsMain_Control_ParentZonePanel_Push.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_MonitoringsMain_Control_ChildZonePanel
 Tkw_MonitoringsMain_Control_ChildZonePanel.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_MonitoringsMain_Control_ChildZonePanel_Push
 Tkw_MonitoringsMain_Control_ChildZonePanel_Push.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_MonitoringsMain_Control_BaseSearchPanel
 Tkw_MonitoringsMain_Control_BaseSearchPanel.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_MonitoringsMain_Control_BaseSearchPanel_Push
 Tkw_MonitoringsMain_Control_BaseSearchPanel_Push.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_MonitoringsMain_Control_LeftNavigator
 Tkw_MonitoringsMain_Control_LeftNavigator.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_MonitoringsMain_Control_LeftNavigator_Push
 Tkw_MonitoringsMain_Control_LeftNavigator_Push.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(HasRightNavigator) AND defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_MonitoringsMain_Control_RightNavigator
 Tkw_MonitoringsMain_Control_RightNavigator.RegisterInEngine;
{$IfEnd} //HasRightNavigator AND Monitorings AND not Admin AND not NoScripts
{$If defined(HasRightNavigator) AND defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_MonitoringsMain_Control_RightNavigator_Push
 Tkw_MonitoringsMain_Control_RightNavigator_Push.RegisterInEngine;
{$IfEnd} //HasRightNavigator AND Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация MonitoringsMainForm_StatusBar
 TkwMonitoringsMainFormStatusBar.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация MonitoringsMainForm_ClientZone
 TkwMonitoringsMainFormClientZone.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация MonitoringsMainForm_MainZone
 TkwMonitoringsMainFormMainZone.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация MonitoringsMainForm_ParentZonePanel
 TkwMonitoringsMainFormParentZonePanel.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация MonitoringsMainForm_ChildZonePanel
 TkwMonitoringsMainFormChildZonePanel.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация MonitoringsMainForm_BaseSearchPanel
 TkwMonitoringsMainFormBaseSearchPanel.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация MonitoringsMainForm_LeftNavigator
 TkwMonitoringsMainFormLeftNavigator.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(HasRightNavigator) AND defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация MonitoringsMainForm_RightNavigator
 TkwMonitoringsMainFormRightNavigator.RegisterInEngine;
{$IfEnd} //HasRightNavigator AND Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа MonitoringsMain
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMonitoringsMainForm));
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TnscStatusBar
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscStatusBar));
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TvtProportionalPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TvtSizeablePanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TnscNavigator
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscNavigator));
{$IfEnd} //Monitorings AND not Admin AND not NoScripts

end.