unit AdminMainKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/AdminMainKeywordsPack.pas"
// Начат: 07.09.2009 18:25
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Администратор::Admin$Shell::AdminApp::AdminMainKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы AdminMain
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin) AND not defined(NoScripts)}
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
  AdminMain_Form,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //Admin AND not NoScripts

implementation

{$If defined(Admin) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 Tkw_Form_AdminMain = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора формы AdminMain
----
*Пример использования*:
[code]
'aControl' форма::AdminMain TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_AdminMain

// start class Tkw_Form_AdminMain

class function Tkw_Form_AdminMain.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::AdminMain';
end;//Tkw_Form_AdminMain.GetWordNameForRegister

function Tkw_Form_AdminMain.GetString: AnsiString;
 {-}
begin
 Result := 'AdminMainForm';
end;//Tkw_Form_AdminMain.GetString

type
 Tkw_AdminMain_Control_StatusBar = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_AdminMain_Control_StatusBar

// start class Tkw_AdminMain_Control_StatusBar

class function Tkw_AdminMain_Control_StatusBar.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::StatusBar';
end;//Tkw_AdminMain_Control_StatusBar.GetWordNameForRegister

function Tkw_AdminMain_Control_StatusBar.GetString: AnsiString;
 {-}
begin
 Result := 'StatusBar';
end;//Tkw_AdminMain_Control_StatusBar.GetString

class procedure Tkw_AdminMain_Control_StatusBar.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscStatusBar);
end;//Tkw_AdminMain_Control_StatusBar.RegisterInEngine

type
 Tkw_AdminMain_Control_StatusBar_Push = {final scriptword} class(TkwBynameControlPush)
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
 end;//Tkw_AdminMain_Control_StatusBar_Push

// start class Tkw_AdminMain_Control_StatusBar_Push

procedure Tkw_AdminMain_Control_StatusBar_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('StatusBar');
 inherited;
end;//Tkw_AdminMain_Control_StatusBar_Push.DoDoIt

class function Tkw_AdminMain_Control_StatusBar_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::StatusBar:push';
end;//Tkw_AdminMain_Control_StatusBar_Push.GetWordNameForRegister

type
 Tkw_AdminMain_Control_ClientZone = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_AdminMain_Control_ClientZone

// start class Tkw_AdminMain_Control_ClientZone

class function Tkw_AdminMain_Control_ClientZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ClientZone';
end;//Tkw_AdminMain_Control_ClientZone.GetWordNameForRegister

function Tkw_AdminMain_Control_ClientZone.GetString: AnsiString;
 {-}
begin
 Result := 'ClientZone';
end;//Tkw_AdminMain_Control_ClientZone.GetString

class procedure Tkw_AdminMain_Control_ClientZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AdminMain_Control_ClientZone.RegisterInEngine

type
 Tkw_AdminMain_Control_ClientZone_Push = {final scriptword} class(TkwBynameControlPush)
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
 end;//Tkw_AdminMain_Control_ClientZone_Push

// start class Tkw_AdminMain_Control_ClientZone_Push

procedure Tkw_AdminMain_Control_ClientZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ClientZone');
 inherited;
end;//Tkw_AdminMain_Control_ClientZone_Push.DoDoIt

class function Tkw_AdminMain_Control_ClientZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ClientZone:push';
end;//Tkw_AdminMain_Control_ClientZone_Push.GetWordNameForRegister

type
 Tkw_AdminMain_Control_MainZone = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_AdminMain_Control_MainZone

// start class Tkw_AdminMain_Control_MainZone

class function Tkw_AdminMain_Control_MainZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::MainZone';
end;//Tkw_AdminMain_Control_MainZone.GetWordNameForRegister

function Tkw_AdminMain_Control_MainZone.GetString: AnsiString;
 {-}
begin
 Result := 'MainZone';
end;//Tkw_AdminMain_Control_MainZone.GetString

class procedure Tkw_AdminMain_Control_MainZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_AdminMain_Control_MainZone.RegisterInEngine

type
 Tkw_AdminMain_Control_MainZone_Push = {final scriptword} class(TkwBynameControlPush)
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
 end;//Tkw_AdminMain_Control_MainZone_Push

// start class Tkw_AdminMain_Control_MainZone_Push

procedure Tkw_AdminMain_Control_MainZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('MainZone');
 inherited;
end;//Tkw_AdminMain_Control_MainZone_Push.DoDoIt

class function Tkw_AdminMain_Control_MainZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::MainZone:push';
end;//Tkw_AdminMain_Control_MainZone_Push.GetWordNameForRegister

type
 Tkw_AdminMain_Control_ParentZonePanel = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_AdminMain_Control_ParentZonePanel

// start class Tkw_AdminMain_Control_ParentZonePanel

class function Tkw_AdminMain_Control_ParentZonePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ParentZonePanel';
end;//Tkw_AdminMain_Control_ParentZonePanel.GetWordNameForRegister

function Tkw_AdminMain_Control_ParentZonePanel.GetString: AnsiString;
 {-}
begin
 Result := 'ParentZonePanel';
end;//Tkw_AdminMain_Control_ParentZonePanel.GetString

class procedure Tkw_AdminMain_Control_ParentZonePanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AdminMain_Control_ParentZonePanel.RegisterInEngine

type
 Tkw_AdminMain_Control_ParentZonePanel_Push = {final scriptword} class(TkwBynameControlPush)
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
 end;//Tkw_AdminMain_Control_ParentZonePanel_Push

// start class Tkw_AdminMain_Control_ParentZonePanel_Push

procedure Tkw_AdminMain_Control_ParentZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ParentZonePanel');
 inherited;
end;//Tkw_AdminMain_Control_ParentZonePanel_Push.DoDoIt

class function Tkw_AdminMain_Control_ParentZonePanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ParentZonePanel:push';
end;//Tkw_AdminMain_Control_ParentZonePanel_Push.GetWordNameForRegister

type
 Tkw_AdminMain_Control_ChildZonePanel = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_AdminMain_Control_ChildZonePanel

// start class Tkw_AdminMain_Control_ChildZonePanel

class function Tkw_AdminMain_Control_ChildZonePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ChildZonePanel';
end;//Tkw_AdminMain_Control_ChildZonePanel.GetWordNameForRegister

function Tkw_AdminMain_Control_ChildZonePanel.GetString: AnsiString;
 {-}
begin
 Result := 'ChildZonePanel';
end;//Tkw_AdminMain_Control_ChildZonePanel.GetString

class procedure Tkw_AdminMain_Control_ChildZonePanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_AdminMain_Control_ChildZonePanel.RegisterInEngine

type
 Tkw_AdminMain_Control_ChildZonePanel_Push = {final scriptword} class(TkwBynameControlPush)
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
 end;//Tkw_AdminMain_Control_ChildZonePanel_Push

// start class Tkw_AdminMain_Control_ChildZonePanel_Push

procedure Tkw_AdminMain_Control_ChildZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ChildZonePanel');
 inherited;
end;//Tkw_AdminMain_Control_ChildZonePanel_Push.DoDoIt

class function Tkw_AdminMain_Control_ChildZonePanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ChildZonePanel:push';
end;//Tkw_AdminMain_Control_ChildZonePanel_Push.GetWordNameForRegister

type
 Tkw_AdminMain_Control_BaseSearchPanel = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_AdminMain_Control_BaseSearchPanel

// start class Tkw_AdminMain_Control_BaseSearchPanel

class function Tkw_AdminMain_Control_BaseSearchPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BaseSearchPanel';
end;//Tkw_AdminMain_Control_BaseSearchPanel.GetWordNameForRegister

function Tkw_AdminMain_Control_BaseSearchPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BaseSearchPanel';
end;//Tkw_AdminMain_Control_BaseSearchPanel.GetString

class procedure Tkw_AdminMain_Control_BaseSearchPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AdminMain_Control_BaseSearchPanel.RegisterInEngine

type
 Tkw_AdminMain_Control_BaseSearchPanel_Push = {final scriptword} class(TkwBynameControlPush)
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
 end;//Tkw_AdminMain_Control_BaseSearchPanel_Push

// start class Tkw_AdminMain_Control_BaseSearchPanel_Push

procedure Tkw_AdminMain_Control_BaseSearchPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BaseSearchPanel');
 inherited;
end;//Tkw_AdminMain_Control_BaseSearchPanel_Push.DoDoIt

class function Tkw_AdminMain_Control_BaseSearchPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BaseSearchPanel:push';
end;//Tkw_AdminMain_Control_BaseSearchPanel_Push.GetWordNameForRegister

type
 Tkw_AdminMain_Control_LeftNavigator = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_AdminMain_Control_LeftNavigator

// start class Tkw_AdminMain_Control_LeftNavigator

class function Tkw_AdminMain_Control_LeftNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LeftNavigator';
end;//Tkw_AdminMain_Control_LeftNavigator.GetWordNameForRegister

function Tkw_AdminMain_Control_LeftNavigator.GetString: AnsiString;
 {-}
begin
 Result := 'LeftNavigator';
end;//Tkw_AdminMain_Control_LeftNavigator.GetString

class procedure Tkw_AdminMain_Control_LeftNavigator.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscNavigator);
end;//Tkw_AdminMain_Control_LeftNavigator.RegisterInEngine

type
 Tkw_AdminMain_Control_LeftNavigator_Push = {final scriptword} class(TkwBynameControlPush)
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
 end;//Tkw_AdminMain_Control_LeftNavigator_Push

// start class Tkw_AdminMain_Control_LeftNavigator_Push

procedure Tkw_AdminMain_Control_LeftNavigator_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('LeftNavigator');
 inherited;
end;//Tkw_AdminMain_Control_LeftNavigator_Push.DoDoIt

class function Tkw_AdminMain_Control_LeftNavigator_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LeftNavigator:push';
end;//Tkw_AdminMain_Control_LeftNavigator_Push.GetWordNameForRegister
{$If defined(Admin) AND defined(HasRightNavigator) AND not defined(NoScripts)}

type
 Tkw_AdminMain_Control_RightNavigator = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_AdminMain_Control_RightNavigator
{$IfEnd} //Admin AND HasRightNavigator AND not NoScripts

{$If defined(Admin) AND defined(HasRightNavigator) AND not defined(NoScripts)}

// start class Tkw_AdminMain_Control_RightNavigator

class function Tkw_AdminMain_Control_RightNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RightNavigator';
end;//Tkw_AdminMain_Control_RightNavigator.GetWordNameForRegister

function Tkw_AdminMain_Control_RightNavigator.GetString: AnsiString;
 {-}
begin
 Result := 'RightNavigator';
end;//Tkw_AdminMain_Control_RightNavigator.GetString

class procedure Tkw_AdminMain_Control_RightNavigator.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscNavigator);
end;//Tkw_AdminMain_Control_RightNavigator.RegisterInEngine

{$IfEnd} //Admin AND HasRightNavigator AND not NoScripts
{$If defined(Admin) AND defined(HasRightNavigator) AND not defined(NoScripts)}

type
 Tkw_AdminMain_Control_RightNavigator_Push = {final scriptword} class(TkwBynameControlPush)
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
 end;//Tkw_AdminMain_Control_RightNavigator_Push
{$IfEnd} //Admin AND HasRightNavigator AND not NoScripts

{$If defined(Admin) AND defined(HasRightNavigator) AND not defined(NoScripts)}

// start class Tkw_AdminMain_Control_RightNavigator_Push

procedure Tkw_AdminMain_Control_RightNavigator_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('RightNavigator');
 inherited;
end;//Tkw_AdminMain_Control_RightNavigator_Push.DoDoIt

class function Tkw_AdminMain_Control_RightNavigator_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RightNavigator:push';
end;//Tkw_AdminMain_Control_RightNavigator_Push.GetWordNameForRegister

{$IfEnd} //Admin AND HasRightNavigator AND not NoScripts

type
 TkwAdminMainFormStatusBar = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TAdminMainForm.StatusBar
[panel]Контрол StatusBar формы TAdminMainForm[panel]
*Тип результата:* TnscStatusBar
*Пример:*
[code]
OBJECT VAR l_TnscStatusBar
 aAdminMainForm .TAdminMainForm.StatusBar >>> l_TnscStatusBar
[code]  }
 private
 // private methods
   function StatusBar(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TnscStatusBar;
     {* Реализация слова скрипта .TAdminMainForm.StatusBar }
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
 end;//TkwAdminMainFormStatusBar

// start class TkwAdminMainFormStatusBar

function TkwAdminMainFormStatusBar.StatusBar(const aCtx: TtfwContext;
  aAdminMainForm: TAdminMainForm): TnscStatusBar;
 {-}
begin
 Result := aAdminMainForm.StatusBar;
end;//TkwAdminMainFormStatusBar.StatusBar

procedure TkwAdminMainFormStatusBar.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAdminMainForm : TAdminMainForm;
begin
 try
  l_aAdminMainForm := TAdminMainForm(aCtx.rEngine.PopObjAs(TAdminMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAdminMainForm: TAdminMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((StatusBar(aCtx, l_aAdminMainForm)));
end;//TkwAdminMainFormStatusBar.DoDoIt

class function TkwAdminMainFormStatusBar.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAdminMainForm.StatusBar';
end;//TkwAdminMainFormStatusBar.GetWordNameForRegister

procedure TkwAdminMainFormStatusBar.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству StatusBar', aCtx);
end;//TkwAdminMainFormStatusBar.SetValuePrim

function TkwAdminMainFormStatusBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscStatusBar);
end;//TkwAdminMainFormStatusBar.GetResultTypeInfo

function TkwAdminMainFormStatusBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAdminMainFormStatusBar.GetAllParamsCount

function TkwAdminMainFormStatusBar.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAdminMainForm)]);
end;//TkwAdminMainFormStatusBar.ParamsTypes

type
 TkwAdminMainFormClientZone = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TAdminMainForm.ClientZone
[panel]Контрол ClientZone формы TAdminMainForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAdminMainForm .TAdminMainForm.ClientZone >>> l_TvtPanel
[code]  }
 private
 // private methods
   function ClientZone(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TvtPanel;
     {* Реализация слова скрипта .TAdminMainForm.ClientZone }
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
 end;//TkwAdminMainFormClientZone

// start class TkwAdminMainFormClientZone

function TkwAdminMainFormClientZone.ClientZone(const aCtx: TtfwContext;
  aAdminMainForm: TAdminMainForm): TvtPanel;
 {-}
begin
 Result := aAdminMainForm.ClientZone;
end;//TkwAdminMainFormClientZone.ClientZone

procedure TkwAdminMainFormClientZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAdminMainForm : TAdminMainForm;
begin
 try
  l_aAdminMainForm := TAdminMainForm(aCtx.rEngine.PopObjAs(TAdminMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAdminMainForm: TAdminMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ClientZone(aCtx, l_aAdminMainForm)));
end;//TkwAdminMainFormClientZone.DoDoIt

class function TkwAdminMainFormClientZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAdminMainForm.ClientZone';
end;//TkwAdminMainFormClientZone.GetWordNameForRegister

procedure TkwAdminMainFormClientZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ClientZone', aCtx);
end;//TkwAdminMainFormClientZone.SetValuePrim

function TkwAdminMainFormClientZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAdminMainFormClientZone.GetResultTypeInfo

function TkwAdminMainFormClientZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAdminMainFormClientZone.GetAllParamsCount

function TkwAdminMainFormClientZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAdminMainForm)]);
end;//TkwAdminMainFormClientZone.ParamsTypes

type
 TkwAdminMainFormMainZone = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TAdminMainForm.MainZone
[panel]Контрол MainZone формы TAdminMainForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aAdminMainForm .TAdminMainForm.MainZone >>> l_TvtProportionalPanel
[code]  }
 private
 // private methods
   function MainZone(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TvtProportionalPanel;
     {* Реализация слова скрипта .TAdminMainForm.MainZone }
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
 end;//TkwAdminMainFormMainZone

// start class TkwAdminMainFormMainZone

function TkwAdminMainFormMainZone.MainZone(const aCtx: TtfwContext;
  aAdminMainForm: TAdminMainForm): TvtProportionalPanel;
 {-}
begin
 Result := aAdminMainForm.MainZone;
end;//TkwAdminMainFormMainZone.MainZone

procedure TkwAdminMainFormMainZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAdminMainForm : TAdminMainForm;
begin
 try
  l_aAdminMainForm := TAdminMainForm(aCtx.rEngine.PopObjAs(TAdminMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAdminMainForm: TAdminMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((MainZone(aCtx, l_aAdminMainForm)));
end;//TkwAdminMainFormMainZone.DoDoIt

class function TkwAdminMainFormMainZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAdminMainForm.MainZone';
end;//TkwAdminMainFormMainZone.GetWordNameForRegister

procedure TkwAdminMainFormMainZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству MainZone', aCtx);
end;//TkwAdminMainFormMainZone.SetValuePrim

function TkwAdminMainFormMainZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwAdminMainFormMainZone.GetResultTypeInfo

function TkwAdminMainFormMainZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAdminMainFormMainZone.GetAllParamsCount

function TkwAdminMainFormMainZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAdminMainForm)]);
end;//TkwAdminMainFormMainZone.ParamsTypes

type
 TkwAdminMainFormParentZonePanel = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TAdminMainForm.ParentZonePanel
[panel]Контрол ParentZonePanel формы TAdminMainForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAdminMainForm .TAdminMainForm.ParentZonePanel >>> l_TvtPanel
[code]  }
 private
 // private methods
   function ParentZonePanel(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TvtPanel;
     {* Реализация слова скрипта .TAdminMainForm.ParentZonePanel }
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
 end;//TkwAdminMainFormParentZonePanel

// start class TkwAdminMainFormParentZonePanel

function TkwAdminMainFormParentZonePanel.ParentZonePanel(const aCtx: TtfwContext;
  aAdminMainForm: TAdminMainForm): TvtPanel;
 {-}
begin
 Result := aAdminMainForm.ParentZonePanel;
end;//TkwAdminMainFormParentZonePanel.ParentZonePanel

procedure TkwAdminMainFormParentZonePanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAdminMainForm : TAdminMainForm;
begin
 try
  l_aAdminMainForm := TAdminMainForm(aCtx.rEngine.PopObjAs(TAdminMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAdminMainForm: TAdminMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ParentZonePanel(aCtx, l_aAdminMainForm)));
end;//TkwAdminMainFormParentZonePanel.DoDoIt

class function TkwAdminMainFormParentZonePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAdminMainForm.ParentZonePanel';
end;//TkwAdminMainFormParentZonePanel.GetWordNameForRegister

procedure TkwAdminMainFormParentZonePanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ParentZonePanel', aCtx);
end;//TkwAdminMainFormParentZonePanel.SetValuePrim

function TkwAdminMainFormParentZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAdminMainFormParentZonePanel.GetResultTypeInfo

function TkwAdminMainFormParentZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAdminMainFormParentZonePanel.GetAllParamsCount

function TkwAdminMainFormParentZonePanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAdminMainForm)]);
end;//TkwAdminMainFormParentZonePanel.ParamsTypes

type
 TkwAdminMainFormChildZonePanel = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TAdminMainForm.ChildZonePanel
[panel]Контрол ChildZonePanel формы TAdminMainForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aAdminMainForm .TAdminMainForm.ChildZonePanel >>> l_TvtSizeablePanel
[code]  }
 private
 // private methods
   function ChildZonePanel(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TvtSizeablePanel;
     {* Реализация слова скрипта .TAdminMainForm.ChildZonePanel }
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
 end;//TkwAdminMainFormChildZonePanel

// start class TkwAdminMainFormChildZonePanel

function TkwAdminMainFormChildZonePanel.ChildZonePanel(const aCtx: TtfwContext;
  aAdminMainForm: TAdminMainForm): TvtSizeablePanel;
 {-}
begin
 Result := aAdminMainForm.ChildZonePanel;
end;//TkwAdminMainFormChildZonePanel.ChildZonePanel

procedure TkwAdminMainFormChildZonePanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAdminMainForm : TAdminMainForm;
begin
 try
  l_aAdminMainForm := TAdminMainForm(aCtx.rEngine.PopObjAs(TAdminMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAdminMainForm: TAdminMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ChildZonePanel(aCtx, l_aAdminMainForm)));
end;//TkwAdminMainFormChildZonePanel.DoDoIt

class function TkwAdminMainFormChildZonePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAdminMainForm.ChildZonePanel';
end;//TkwAdminMainFormChildZonePanel.GetWordNameForRegister

procedure TkwAdminMainFormChildZonePanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ChildZonePanel', aCtx);
end;//TkwAdminMainFormChildZonePanel.SetValuePrim

function TkwAdminMainFormChildZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwAdminMainFormChildZonePanel.GetResultTypeInfo

function TkwAdminMainFormChildZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAdminMainFormChildZonePanel.GetAllParamsCount

function TkwAdminMainFormChildZonePanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAdminMainForm)]);
end;//TkwAdminMainFormChildZonePanel.ParamsTypes

type
 TkwAdminMainFormBaseSearchPanel = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TAdminMainForm.BaseSearchPanel
[panel]Контрол BaseSearchPanel формы TAdminMainForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAdminMainForm .TAdminMainForm.BaseSearchPanel >>> l_TvtPanel
[code]  }
 private
 // private methods
   function BaseSearchPanel(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TvtPanel;
     {* Реализация слова скрипта .TAdminMainForm.BaseSearchPanel }
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
 end;//TkwAdminMainFormBaseSearchPanel

// start class TkwAdminMainFormBaseSearchPanel

function TkwAdminMainFormBaseSearchPanel.BaseSearchPanel(const aCtx: TtfwContext;
  aAdminMainForm: TAdminMainForm): TvtPanel;
 {-}
begin
 Result := aAdminMainForm.BaseSearchPanel;
end;//TkwAdminMainFormBaseSearchPanel.BaseSearchPanel

procedure TkwAdminMainFormBaseSearchPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAdminMainForm : TAdminMainForm;
begin
 try
  l_aAdminMainForm := TAdminMainForm(aCtx.rEngine.PopObjAs(TAdminMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAdminMainForm: TAdminMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BaseSearchPanel(aCtx, l_aAdminMainForm)));
end;//TkwAdminMainFormBaseSearchPanel.DoDoIt

class function TkwAdminMainFormBaseSearchPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAdminMainForm.BaseSearchPanel';
end;//TkwAdminMainFormBaseSearchPanel.GetWordNameForRegister

procedure TkwAdminMainFormBaseSearchPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству BaseSearchPanel', aCtx);
end;//TkwAdminMainFormBaseSearchPanel.SetValuePrim

function TkwAdminMainFormBaseSearchPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAdminMainFormBaseSearchPanel.GetResultTypeInfo

function TkwAdminMainFormBaseSearchPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAdminMainFormBaseSearchPanel.GetAllParamsCount

function TkwAdminMainFormBaseSearchPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAdminMainForm)]);
end;//TkwAdminMainFormBaseSearchPanel.ParamsTypes

type
 TkwAdminMainFormLeftNavigator = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TAdminMainForm.LeftNavigator
[panel]Контрол LeftNavigator формы TAdminMainForm[panel]
*Тип результата:* TnscNavigator
*Пример:*
[code]
OBJECT VAR l_TnscNavigator
 aAdminMainForm .TAdminMainForm.LeftNavigator >>> l_TnscNavigator
[code]  }
 private
 // private methods
   function LeftNavigator(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TnscNavigator;
     {* Реализация слова скрипта .TAdminMainForm.LeftNavigator }
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
 end;//TkwAdminMainFormLeftNavigator

// start class TkwAdminMainFormLeftNavigator

function TkwAdminMainFormLeftNavigator.LeftNavigator(const aCtx: TtfwContext;
  aAdminMainForm: TAdminMainForm): TnscNavigator;
 {-}
begin
 Result := aAdminMainForm.LeftNavigator;
end;//TkwAdminMainFormLeftNavigator.LeftNavigator

procedure TkwAdminMainFormLeftNavigator.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAdminMainForm : TAdminMainForm;
begin
 try
  l_aAdminMainForm := TAdminMainForm(aCtx.rEngine.PopObjAs(TAdminMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAdminMainForm: TAdminMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LeftNavigator(aCtx, l_aAdminMainForm)));
end;//TkwAdminMainFormLeftNavigator.DoDoIt

class function TkwAdminMainFormLeftNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAdminMainForm.LeftNavigator';
end;//TkwAdminMainFormLeftNavigator.GetWordNameForRegister

procedure TkwAdminMainFormLeftNavigator.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству LeftNavigator', aCtx);
end;//TkwAdminMainFormLeftNavigator.SetValuePrim

function TkwAdminMainFormLeftNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwAdminMainFormLeftNavigator.GetResultTypeInfo

function TkwAdminMainFormLeftNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAdminMainFormLeftNavigator.GetAllParamsCount

function TkwAdminMainFormLeftNavigator.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAdminMainForm)]);
end;//TkwAdminMainFormLeftNavigator.ParamsTypes
{$If defined(Admin) AND defined(HasRightNavigator) AND not defined(NoScripts)}

type
 TkwAdminMainFormRightNavigator = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TAdminMainForm.RightNavigator
[panel]Контрол RightNavigator формы TAdminMainForm[panel]
*Тип результата:* TnscNavigator
*Пример:*
[code]
OBJECT VAR l_TnscNavigator
 aAdminMainForm .TAdminMainForm.RightNavigator >>> l_TnscNavigator
[code]  }
 private
 // private methods
   function RightNavigator(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TnscNavigator;
     {* Реализация слова скрипта .TAdminMainForm.RightNavigator }
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
 end;//TkwAdminMainFormRightNavigator
{$IfEnd} //Admin AND HasRightNavigator AND not NoScripts

{$If defined(Admin) AND defined(HasRightNavigator) AND not defined(NoScripts)}

// start class TkwAdminMainFormRightNavigator

function TkwAdminMainFormRightNavigator.RightNavigator(const aCtx: TtfwContext;
  aAdminMainForm: TAdminMainForm): TnscNavigator;
 {-}
begin
 Result := aAdminMainForm.RightNavigator;
end;//TkwAdminMainFormRightNavigator.RightNavigator

procedure TkwAdminMainFormRightNavigator.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAdminMainForm : TAdminMainForm;
begin
 try
  l_aAdminMainForm := TAdminMainForm(aCtx.rEngine.PopObjAs(TAdminMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAdminMainForm: TAdminMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RightNavigator(aCtx, l_aAdminMainForm)));
end;//TkwAdminMainFormRightNavigator.DoDoIt

class function TkwAdminMainFormRightNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAdminMainForm.RightNavigator';
end;//TkwAdminMainFormRightNavigator.GetWordNameForRegister

procedure TkwAdminMainFormRightNavigator.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству RightNavigator', aCtx);
end;//TkwAdminMainFormRightNavigator.SetValuePrim

function TkwAdminMainFormRightNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwAdminMainFormRightNavigator.GetResultTypeInfo

function TkwAdminMainFormRightNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAdminMainFormRightNavigator.GetAllParamsCount

function TkwAdminMainFormRightNavigator.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAdminMainForm)]);
end;//TkwAdminMainFormRightNavigator.ParamsTypes

{$IfEnd} //Admin AND HasRightNavigator AND not NoScripts
{$IfEnd} //Admin AND not NoScripts

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_Form_AdminMain
 Tkw_Form_AdminMain.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminMain_Control_StatusBar
 Tkw_AdminMain_Control_StatusBar.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminMain_Control_StatusBar_Push
 Tkw_AdminMain_Control_StatusBar_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminMain_Control_ClientZone
 Tkw_AdminMain_Control_ClientZone.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminMain_Control_ClientZone_Push
 Tkw_AdminMain_Control_ClientZone_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminMain_Control_MainZone
 Tkw_AdminMain_Control_MainZone.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminMain_Control_MainZone_Push
 Tkw_AdminMain_Control_MainZone_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminMain_Control_ParentZonePanel
 Tkw_AdminMain_Control_ParentZonePanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminMain_Control_ParentZonePanel_Push
 Tkw_AdminMain_Control_ParentZonePanel_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminMain_Control_ChildZonePanel
 Tkw_AdminMain_Control_ChildZonePanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminMain_Control_ChildZonePanel_Push
 Tkw_AdminMain_Control_ChildZonePanel_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminMain_Control_BaseSearchPanel
 Tkw_AdminMain_Control_BaseSearchPanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminMain_Control_BaseSearchPanel_Push
 Tkw_AdminMain_Control_BaseSearchPanel_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminMain_Control_LeftNavigator
 Tkw_AdminMain_Control_LeftNavigator.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminMain_Control_LeftNavigator_Push
 Tkw_AdminMain_Control_LeftNavigator_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND defined(HasRightNavigator) AND not defined(NoScripts)}
// Регистрация Tkw_AdminMain_Control_RightNavigator
 Tkw_AdminMain_Control_RightNavigator.RegisterInEngine;
{$IfEnd} //Admin AND HasRightNavigator AND not NoScripts
{$If defined(Admin) AND defined(HasRightNavigator) AND not defined(NoScripts)}
// Регистрация Tkw_AdminMain_Control_RightNavigator_Push
 Tkw_AdminMain_Control_RightNavigator_Push.RegisterInEngine;
{$IfEnd} //Admin AND HasRightNavigator AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация AdminMainForm_StatusBar
 TkwAdminMainFormStatusBar.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация AdminMainForm_ClientZone
 TkwAdminMainFormClientZone.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация AdminMainForm_MainZone
 TkwAdminMainFormMainZone.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация AdminMainForm_ParentZonePanel
 TkwAdminMainFormParentZonePanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация AdminMainForm_ChildZonePanel
 TkwAdminMainFormChildZonePanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация AdminMainForm_BaseSearchPanel
 TkwAdminMainFormBaseSearchPanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация AdminMainForm_LeftNavigator
 TkwAdminMainFormLeftNavigator.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND defined(HasRightNavigator) AND not defined(NoScripts)}
// Регистрация AdminMainForm_RightNavigator
 TkwAdminMainFormRightNavigator.RegisterInEngine;
{$IfEnd} //Admin AND HasRightNavigator AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа AdminMain
 TtfwTypeRegistrator.RegisterType(TypeInfo(TAdminMainForm));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TnscStatusBar
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscStatusBar));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TvtProportionalPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TvtSizeablePanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TnscNavigator
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscNavigator));
{$IfEnd} //Admin AND not NoScripts

end.