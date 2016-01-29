unit MainKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/NewGen/MainKeywordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> MDProcess$NewGen$Interface::NewGen::NewGen::MainKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы Main
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\NewGen\ngDefine.inc}

interface

{$If defined(NewGen) AND not defined(NoScripts)}
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
  Main_Form,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //NewGen AND not NoScripts

implementation

{$If defined(NewGen) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 Tkw_Form_Main = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Main
----
*Пример использования*:
[code]
'aControl' форма::Main TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Main

// start class Tkw_Form_Main

class function Tkw_Form_Main.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::Main';
end;//Tkw_Form_Main.GetWordNameForRegister

function Tkw_Form_Main.GetString: AnsiString;
 {-}
begin
 Result := 'MainForm';
end;//Tkw_Form_Main.GetString

type
 Tkw_Main_Control_StatusBar = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_Main_Control_StatusBar

// start class Tkw_Main_Control_StatusBar

class function Tkw_Main_Control_StatusBar.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::StatusBar';
end;//Tkw_Main_Control_StatusBar.GetWordNameForRegister

function Tkw_Main_Control_StatusBar.GetString: AnsiString;
 {-}
begin
 Result := 'StatusBar';
end;//Tkw_Main_Control_StatusBar.GetString

class procedure Tkw_Main_Control_StatusBar.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscStatusBar);
end;//Tkw_Main_Control_StatusBar.RegisterInEngine

type
 Tkw_Main_Control_StatusBar_Push = {final scriptword} class(TkwBynameControlPush)
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
 end;//Tkw_Main_Control_StatusBar_Push

// start class Tkw_Main_Control_StatusBar_Push

procedure Tkw_Main_Control_StatusBar_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('StatusBar');
 inherited;
end;//Tkw_Main_Control_StatusBar_Push.DoDoIt

class function Tkw_Main_Control_StatusBar_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::StatusBar:push';
end;//Tkw_Main_Control_StatusBar_Push.GetWordNameForRegister

type
 Tkw_Main_Control_ClientZone = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_Main_Control_ClientZone

// start class Tkw_Main_Control_ClientZone

class function Tkw_Main_Control_ClientZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ClientZone';
end;//Tkw_Main_Control_ClientZone.GetWordNameForRegister

function Tkw_Main_Control_ClientZone.GetString: AnsiString;
 {-}
begin
 Result := 'ClientZone';
end;//Tkw_Main_Control_ClientZone.GetString

class procedure Tkw_Main_Control_ClientZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Main_Control_ClientZone.RegisterInEngine

type
 Tkw_Main_Control_ClientZone_Push = {final scriptword} class(TkwBynameControlPush)
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
 end;//Tkw_Main_Control_ClientZone_Push

// start class Tkw_Main_Control_ClientZone_Push

procedure Tkw_Main_Control_ClientZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ClientZone');
 inherited;
end;//Tkw_Main_Control_ClientZone_Push.DoDoIt

class function Tkw_Main_Control_ClientZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ClientZone:push';
end;//Tkw_Main_Control_ClientZone_Push.GetWordNameForRegister

type
 Tkw_Main_Control_MainZone = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_Main_Control_MainZone

// start class Tkw_Main_Control_MainZone

class function Tkw_Main_Control_MainZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::MainZone';
end;//Tkw_Main_Control_MainZone.GetWordNameForRegister

function Tkw_Main_Control_MainZone.GetString: AnsiString;
 {-}
begin
 Result := 'MainZone';
end;//Tkw_Main_Control_MainZone.GetString

class procedure Tkw_Main_Control_MainZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_Main_Control_MainZone.RegisterInEngine

type
 Tkw_Main_Control_MainZone_Push = {final scriptword} class(TkwBynameControlPush)
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
 end;//Tkw_Main_Control_MainZone_Push

// start class Tkw_Main_Control_MainZone_Push

procedure Tkw_Main_Control_MainZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('MainZone');
 inherited;
end;//Tkw_Main_Control_MainZone_Push.DoDoIt

class function Tkw_Main_Control_MainZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::MainZone:push';
end;//Tkw_Main_Control_MainZone_Push.GetWordNameForRegister

type
 Tkw_Main_Control_ParentZonePanel = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_Main_Control_ParentZonePanel

// start class Tkw_Main_Control_ParentZonePanel

class function Tkw_Main_Control_ParentZonePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ParentZonePanel';
end;//Tkw_Main_Control_ParentZonePanel.GetWordNameForRegister

function Tkw_Main_Control_ParentZonePanel.GetString: AnsiString;
 {-}
begin
 Result := 'ParentZonePanel';
end;//Tkw_Main_Control_ParentZonePanel.GetString

class procedure Tkw_Main_Control_ParentZonePanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Main_Control_ParentZonePanel.RegisterInEngine

type
 Tkw_Main_Control_ParentZonePanel_Push = {final scriptword} class(TkwBynameControlPush)
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
 end;//Tkw_Main_Control_ParentZonePanel_Push

// start class Tkw_Main_Control_ParentZonePanel_Push

procedure Tkw_Main_Control_ParentZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ParentZonePanel');
 inherited;
end;//Tkw_Main_Control_ParentZonePanel_Push.DoDoIt

class function Tkw_Main_Control_ParentZonePanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ParentZonePanel:push';
end;//Tkw_Main_Control_ParentZonePanel_Push.GetWordNameForRegister

type
 Tkw_Main_Control_ChildZonePanel = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_Main_Control_ChildZonePanel

// start class Tkw_Main_Control_ChildZonePanel

class function Tkw_Main_Control_ChildZonePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ChildZonePanel';
end;//Tkw_Main_Control_ChildZonePanel.GetWordNameForRegister

function Tkw_Main_Control_ChildZonePanel.GetString: AnsiString;
 {-}
begin
 Result := 'ChildZonePanel';
end;//Tkw_Main_Control_ChildZonePanel.GetString

class procedure Tkw_Main_Control_ChildZonePanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_Main_Control_ChildZonePanel.RegisterInEngine

type
 Tkw_Main_Control_ChildZonePanel_Push = {final scriptword} class(TkwBynameControlPush)
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
 end;//Tkw_Main_Control_ChildZonePanel_Push

// start class Tkw_Main_Control_ChildZonePanel_Push

procedure Tkw_Main_Control_ChildZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ChildZonePanel');
 inherited;
end;//Tkw_Main_Control_ChildZonePanel_Push.DoDoIt

class function Tkw_Main_Control_ChildZonePanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ChildZonePanel:push';
end;//Tkw_Main_Control_ChildZonePanel_Push.GetWordNameForRegister

type
 Tkw_Main_Control_BaseSearchPanel = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_Main_Control_BaseSearchPanel

// start class Tkw_Main_Control_BaseSearchPanel

class function Tkw_Main_Control_BaseSearchPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BaseSearchPanel';
end;//Tkw_Main_Control_BaseSearchPanel.GetWordNameForRegister

function Tkw_Main_Control_BaseSearchPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BaseSearchPanel';
end;//Tkw_Main_Control_BaseSearchPanel.GetString

class procedure Tkw_Main_Control_BaseSearchPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Main_Control_BaseSearchPanel.RegisterInEngine

type
 Tkw_Main_Control_BaseSearchPanel_Push = {final scriptword} class(TkwBynameControlPush)
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
 end;//Tkw_Main_Control_BaseSearchPanel_Push

// start class Tkw_Main_Control_BaseSearchPanel_Push

procedure Tkw_Main_Control_BaseSearchPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BaseSearchPanel');
 inherited;
end;//Tkw_Main_Control_BaseSearchPanel_Push.DoDoIt

class function Tkw_Main_Control_BaseSearchPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BaseSearchPanel:push';
end;//Tkw_Main_Control_BaseSearchPanel_Push.GetWordNameForRegister

type
 Tkw_Main_Control_LeftNavigator = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_Main_Control_LeftNavigator

// start class Tkw_Main_Control_LeftNavigator

class function Tkw_Main_Control_LeftNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LeftNavigator';
end;//Tkw_Main_Control_LeftNavigator.GetWordNameForRegister

function Tkw_Main_Control_LeftNavigator.GetString: AnsiString;
 {-}
begin
 Result := 'LeftNavigator';
end;//Tkw_Main_Control_LeftNavigator.GetString

class procedure Tkw_Main_Control_LeftNavigator.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscNavigator);
end;//Tkw_Main_Control_LeftNavigator.RegisterInEngine

type
 Tkw_Main_Control_LeftNavigator_Push = {final scriptword} class(TkwBynameControlPush)
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
 end;//Tkw_Main_Control_LeftNavigator_Push

// start class Tkw_Main_Control_LeftNavigator_Push

procedure Tkw_Main_Control_LeftNavigator_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('LeftNavigator');
 inherited;
end;//Tkw_Main_Control_LeftNavigator_Push.DoDoIt

class function Tkw_Main_Control_LeftNavigator_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LeftNavigator:push';
end;//Tkw_Main_Control_LeftNavigator_Push.GetWordNameForRegister
{$If defined(HasRightNavigator) AND defined(NewGen) AND not defined(NoScripts)}

type
 Tkw_Main_Control_RightNavigator = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_Main_Control_RightNavigator
{$IfEnd} //HasRightNavigator AND NewGen AND not NoScripts

{$If defined(HasRightNavigator) AND defined(NewGen) AND not defined(NoScripts)}

// start class Tkw_Main_Control_RightNavigator

class function Tkw_Main_Control_RightNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RightNavigator';
end;//Tkw_Main_Control_RightNavigator.GetWordNameForRegister

function Tkw_Main_Control_RightNavigator.GetString: AnsiString;
 {-}
begin
 Result := 'RightNavigator';
end;//Tkw_Main_Control_RightNavigator.GetString

class procedure Tkw_Main_Control_RightNavigator.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscNavigator);
end;//Tkw_Main_Control_RightNavigator.RegisterInEngine

{$IfEnd} //HasRightNavigator AND NewGen AND not NoScripts
{$If defined(HasRightNavigator) AND defined(NewGen) AND not defined(NoScripts)}

type
 Tkw_Main_Control_RightNavigator_Push = {final scriptword} class(TkwBynameControlPush)
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
 end;//Tkw_Main_Control_RightNavigator_Push
{$IfEnd} //HasRightNavigator AND NewGen AND not NoScripts

{$If defined(HasRightNavigator) AND defined(NewGen) AND not defined(NoScripts)}

// start class Tkw_Main_Control_RightNavigator_Push

procedure Tkw_Main_Control_RightNavigator_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('RightNavigator');
 inherited;
end;//Tkw_Main_Control_RightNavigator_Push.DoDoIt

class function Tkw_Main_Control_RightNavigator_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RightNavigator:push';
end;//Tkw_Main_Control_RightNavigator_Push.GetWordNameForRegister

{$IfEnd} //HasRightNavigator AND NewGen AND not NoScripts

type
 TkwMainFormStatusBar = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.StatusBar
[panel]Контрол StatusBar формы TMainForm[panel]
*Тип результата:* TnscStatusBar
*Пример:*
[code]
OBJECT VAR l_TnscStatusBar
 aMainForm .TMainForm.StatusBar >>> l_TnscStatusBar
[code]  }
 private
 // private methods
   function StatusBar(const aCtx: TtfwContext;
    aMainForm: TMainForm): TnscStatusBar;
     {* Реализация слова скрипта .TMainForm.StatusBar }
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
 end;//TkwMainFormStatusBar

// start class TkwMainFormStatusBar

function TkwMainFormStatusBar.StatusBar(const aCtx: TtfwContext;
  aMainForm: TMainForm): TnscStatusBar;
 {-}
begin
 Result := aMainForm.StatusBar;
end;//TkwMainFormStatusBar.StatusBar

procedure TkwMainFormStatusBar.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainForm : TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((StatusBar(aCtx, l_aMainForm)));
end;//TkwMainFormStatusBar.DoDoIt

class function TkwMainFormStatusBar.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMainForm.StatusBar';
end;//TkwMainFormStatusBar.GetWordNameForRegister

procedure TkwMainFormStatusBar.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству StatusBar', aCtx);
end;//TkwMainFormStatusBar.SetValuePrim

function TkwMainFormStatusBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscStatusBar);
end;//TkwMainFormStatusBar.GetResultTypeInfo

function TkwMainFormStatusBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainFormStatusBar.GetAllParamsCount

function TkwMainFormStatusBar.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormStatusBar.ParamsTypes

type
 TkwMainFormClientZone = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.ClientZone
[panel]Контрол ClientZone формы TMainForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMainForm .TMainForm.ClientZone >>> l_TvtPanel
[code]  }
 private
 // private methods
   function ClientZone(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtPanel;
     {* Реализация слова скрипта .TMainForm.ClientZone }
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
 end;//TkwMainFormClientZone

// start class TkwMainFormClientZone

function TkwMainFormClientZone.ClientZone(const aCtx: TtfwContext;
  aMainForm: TMainForm): TvtPanel;
 {-}
begin
 Result := aMainForm.ClientZone;
end;//TkwMainFormClientZone.ClientZone

procedure TkwMainFormClientZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainForm : TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ClientZone(aCtx, l_aMainForm)));
end;//TkwMainFormClientZone.DoDoIt

class function TkwMainFormClientZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMainForm.ClientZone';
end;//TkwMainFormClientZone.GetWordNameForRegister

procedure TkwMainFormClientZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ClientZone', aCtx);
end;//TkwMainFormClientZone.SetValuePrim

function TkwMainFormClientZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMainFormClientZone.GetResultTypeInfo

function TkwMainFormClientZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainFormClientZone.GetAllParamsCount

function TkwMainFormClientZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormClientZone.ParamsTypes

type
 TkwMainFormMainZone = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.MainZone
[panel]Контрол MainZone формы TMainForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aMainForm .TMainForm.MainZone >>> l_TvtProportionalPanel
[code]  }
 private
 // private methods
   function MainZone(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtProportionalPanel;
     {* Реализация слова скрипта .TMainForm.MainZone }
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
 end;//TkwMainFormMainZone

// start class TkwMainFormMainZone

function TkwMainFormMainZone.MainZone(const aCtx: TtfwContext;
  aMainForm: TMainForm): TvtProportionalPanel;
 {-}
begin
 Result := aMainForm.MainZone;
end;//TkwMainFormMainZone.MainZone

procedure TkwMainFormMainZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainForm : TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((MainZone(aCtx, l_aMainForm)));
end;//TkwMainFormMainZone.DoDoIt

class function TkwMainFormMainZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMainForm.MainZone';
end;//TkwMainFormMainZone.GetWordNameForRegister

procedure TkwMainFormMainZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству MainZone', aCtx);
end;//TkwMainFormMainZone.SetValuePrim

function TkwMainFormMainZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwMainFormMainZone.GetResultTypeInfo

function TkwMainFormMainZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainFormMainZone.GetAllParamsCount

function TkwMainFormMainZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormMainZone.ParamsTypes

type
 TkwMainFormParentZonePanel = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.ParentZonePanel
[panel]Контрол ParentZonePanel формы TMainForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMainForm .TMainForm.ParentZonePanel >>> l_TvtPanel
[code]  }
 private
 // private methods
   function ParentZonePanel(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtPanel;
     {* Реализация слова скрипта .TMainForm.ParentZonePanel }
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
 end;//TkwMainFormParentZonePanel

// start class TkwMainFormParentZonePanel

function TkwMainFormParentZonePanel.ParentZonePanel(const aCtx: TtfwContext;
  aMainForm: TMainForm): TvtPanel;
 {-}
begin
 Result := aMainForm.ParentZonePanel;
end;//TkwMainFormParentZonePanel.ParentZonePanel

procedure TkwMainFormParentZonePanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainForm : TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ParentZonePanel(aCtx, l_aMainForm)));
end;//TkwMainFormParentZonePanel.DoDoIt

class function TkwMainFormParentZonePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMainForm.ParentZonePanel';
end;//TkwMainFormParentZonePanel.GetWordNameForRegister

procedure TkwMainFormParentZonePanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ParentZonePanel', aCtx);
end;//TkwMainFormParentZonePanel.SetValuePrim

function TkwMainFormParentZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMainFormParentZonePanel.GetResultTypeInfo

function TkwMainFormParentZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainFormParentZonePanel.GetAllParamsCount

function TkwMainFormParentZonePanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormParentZonePanel.ParamsTypes

type
 TkwMainFormChildZonePanel = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.ChildZonePanel
[panel]Контрол ChildZonePanel формы TMainForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aMainForm .TMainForm.ChildZonePanel >>> l_TvtSizeablePanel
[code]  }
 private
 // private methods
   function ChildZonePanel(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtSizeablePanel;
     {* Реализация слова скрипта .TMainForm.ChildZonePanel }
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
 end;//TkwMainFormChildZonePanel

// start class TkwMainFormChildZonePanel

function TkwMainFormChildZonePanel.ChildZonePanel(const aCtx: TtfwContext;
  aMainForm: TMainForm): TvtSizeablePanel;
 {-}
begin
 Result := aMainForm.ChildZonePanel;
end;//TkwMainFormChildZonePanel.ChildZonePanel

procedure TkwMainFormChildZonePanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainForm : TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ChildZonePanel(aCtx, l_aMainForm)));
end;//TkwMainFormChildZonePanel.DoDoIt

class function TkwMainFormChildZonePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMainForm.ChildZonePanel';
end;//TkwMainFormChildZonePanel.GetWordNameForRegister

procedure TkwMainFormChildZonePanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ChildZonePanel', aCtx);
end;//TkwMainFormChildZonePanel.SetValuePrim

function TkwMainFormChildZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwMainFormChildZonePanel.GetResultTypeInfo

function TkwMainFormChildZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainFormChildZonePanel.GetAllParamsCount

function TkwMainFormChildZonePanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormChildZonePanel.ParamsTypes

type
 TkwMainFormBaseSearchPanel = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.BaseSearchPanel
[panel]Контрол BaseSearchPanel формы TMainForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMainForm .TMainForm.BaseSearchPanel >>> l_TvtPanel
[code]  }
 private
 // private methods
   function BaseSearchPanel(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtPanel;
     {* Реализация слова скрипта .TMainForm.BaseSearchPanel }
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
 end;//TkwMainFormBaseSearchPanel

// start class TkwMainFormBaseSearchPanel

function TkwMainFormBaseSearchPanel.BaseSearchPanel(const aCtx: TtfwContext;
  aMainForm: TMainForm): TvtPanel;
 {-}
begin
 Result := aMainForm.BaseSearchPanel;
end;//TkwMainFormBaseSearchPanel.BaseSearchPanel

procedure TkwMainFormBaseSearchPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainForm : TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BaseSearchPanel(aCtx, l_aMainForm)));
end;//TkwMainFormBaseSearchPanel.DoDoIt

class function TkwMainFormBaseSearchPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMainForm.BaseSearchPanel';
end;//TkwMainFormBaseSearchPanel.GetWordNameForRegister

procedure TkwMainFormBaseSearchPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству BaseSearchPanel', aCtx);
end;//TkwMainFormBaseSearchPanel.SetValuePrim

function TkwMainFormBaseSearchPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMainFormBaseSearchPanel.GetResultTypeInfo

function TkwMainFormBaseSearchPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainFormBaseSearchPanel.GetAllParamsCount

function TkwMainFormBaseSearchPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormBaseSearchPanel.ParamsTypes

type
 TkwMainFormLeftNavigator = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.LeftNavigator
[panel]Контрол LeftNavigator формы TMainForm[panel]
*Тип результата:* TnscNavigator
*Пример:*
[code]
OBJECT VAR l_TnscNavigator
 aMainForm .TMainForm.LeftNavigator >>> l_TnscNavigator
[code]  }
 private
 // private methods
   function LeftNavigator(const aCtx: TtfwContext;
    aMainForm: TMainForm): TnscNavigator;
     {* Реализация слова скрипта .TMainForm.LeftNavigator }
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
 end;//TkwMainFormLeftNavigator

// start class TkwMainFormLeftNavigator

function TkwMainFormLeftNavigator.LeftNavigator(const aCtx: TtfwContext;
  aMainForm: TMainForm): TnscNavigator;
 {-}
begin
 Result := aMainForm.LeftNavigator;
end;//TkwMainFormLeftNavigator.LeftNavigator

procedure TkwMainFormLeftNavigator.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainForm : TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LeftNavigator(aCtx, l_aMainForm)));
end;//TkwMainFormLeftNavigator.DoDoIt

class function TkwMainFormLeftNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMainForm.LeftNavigator';
end;//TkwMainFormLeftNavigator.GetWordNameForRegister

procedure TkwMainFormLeftNavigator.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству LeftNavigator', aCtx);
end;//TkwMainFormLeftNavigator.SetValuePrim

function TkwMainFormLeftNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwMainFormLeftNavigator.GetResultTypeInfo

function TkwMainFormLeftNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainFormLeftNavigator.GetAllParamsCount

function TkwMainFormLeftNavigator.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormLeftNavigator.ParamsTypes
{$If defined(HasRightNavigator) AND defined(NewGen) AND not defined(NoScripts)}

type
 TkwMainFormRightNavigator = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.RightNavigator
[panel]Контрол RightNavigator формы TMainForm[panel]
*Тип результата:* TnscNavigator
*Пример:*
[code]
OBJECT VAR l_TnscNavigator
 aMainForm .TMainForm.RightNavigator >>> l_TnscNavigator
[code]  }
 private
 // private methods
   function RightNavigator(const aCtx: TtfwContext;
    aMainForm: TMainForm): TnscNavigator;
     {* Реализация слова скрипта .TMainForm.RightNavigator }
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
 end;//TkwMainFormRightNavigator
{$IfEnd} //HasRightNavigator AND NewGen AND not NoScripts

{$If defined(HasRightNavigator) AND defined(NewGen) AND not defined(NoScripts)}

// start class TkwMainFormRightNavigator

function TkwMainFormRightNavigator.RightNavigator(const aCtx: TtfwContext;
  aMainForm: TMainForm): TnscNavigator;
 {-}
begin
 Result := aMainForm.RightNavigator;
end;//TkwMainFormRightNavigator.RightNavigator

procedure TkwMainFormRightNavigator.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainForm : TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RightNavigator(aCtx, l_aMainForm)));
end;//TkwMainFormRightNavigator.DoDoIt

class function TkwMainFormRightNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMainForm.RightNavigator';
end;//TkwMainFormRightNavigator.GetWordNameForRegister

procedure TkwMainFormRightNavigator.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству RightNavigator', aCtx);
end;//TkwMainFormRightNavigator.SetValuePrim

function TkwMainFormRightNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwMainFormRightNavigator.GetResultTypeInfo

function TkwMainFormRightNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainFormRightNavigator.GetAllParamsCount

function TkwMainFormRightNavigator.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormRightNavigator.ParamsTypes

{$IfEnd} //HasRightNavigator AND NewGen AND not NoScripts
{$IfEnd} //NewGen AND not NoScripts

initialization
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация Tkw_Form_Main
 Tkw_Form_Main.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация Tkw_Main_Control_StatusBar
 Tkw_Main_Control_StatusBar.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация Tkw_Main_Control_StatusBar_Push
 Tkw_Main_Control_StatusBar_Push.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация Tkw_Main_Control_ClientZone
 Tkw_Main_Control_ClientZone.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация Tkw_Main_Control_ClientZone_Push
 Tkw_Main_Control_ClientZone_Push.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация Tkw_Main_Control_MainZone
 Tkw_Main_Control_MainZone.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация Tkw_Main_Control_MainZone_Push
 Tkw_Main_Control_MainZone_Push.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация Tkw_Main_Control_ParentZonePanel
 Tkw_Main_Control_ParentZonePanel.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация Tkw_Main_Control_ParentZonePanel_Push
 Tkw_Main_Control_ParentZonePanel_Push.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация Tkw_Main_Control_ChildZonePanel
 Tkw_Main_Control_ChildZonePanel.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация Tkw_Main_Control_ChildZonePanel_Push
 Tkw_Main_Control_ChildZonePanel_Push.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация Tkw_Main_Control_BaseSearchPanel
 Tkw_Main_Control_BaseSearchPanel.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация Tkw_Main_Control_BaseSearchPanel_Push
 Tkw_Main_Control_BaseSearchPanel_Push.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация Tkw_Main_Control_LeftNavigator
 Tkw_Main_Control_LeftNavigator.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация Tkw_Main_Control_LeftNavigator_Push
 Tkw_Main_Control_LeftNavigator_Push.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(HasRightNavigator) AND defined(NewGen) AND not defined(NoScripts)}
// Регистрация Tkw_Main_Control_RightNavigator
 Tkw_Main_Control_RightNavigator.RegisterInEngine;
{$IfEnd} //HasRightNavigator AND NewGen AND not NoScripts
{$If defined(HasRightNavigator) AND defined(NewGen) AND not defined(NoScripts)}
// Регистрация Tkw_Main_Control_RightNavigator_Push
 Tkw_Main_Control_RightNavigator_Push.RegisterInEngine;
{$IfEnd} //HasRightNavigator AND NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация MainForm_StatusBar
 TkwMainFormStatusBar.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация MainForm_ClientZone
 TkwMainFormClientZone.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация MainForm_MainZone
 TkwMainFormMainZone.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация MainForm_ParentZonePanel
 TkwMainFormParentZonePanel.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация MainForm_ChildZonePanel
 TkwMainFormChildZonePanel.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация MainForm_BaseSearchPanel
 TkwMainFormBaseSearchPanel.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация MainForm_LeftNavigator
 TkwMainFormLeftNavigator.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts
{$If defined(HasRightNavigator) AND defined(NewGen) AND not defined(NoScripts)}
// Регистрация MainForm_RightNavigator
 TkwMainFormRightNavigator.RegisterInEngine;
{$IfEnd} //HasRightNavigator AND NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация типа Main
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMainForm));
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация типа TnscStatusBar
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscStatusBar));
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация типа TvtProportionalPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация типа TvtSizeablePanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация типа TnscNavigator
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscNavigator));
{$IfEnd} //NewGen AND not NoScripts

end.