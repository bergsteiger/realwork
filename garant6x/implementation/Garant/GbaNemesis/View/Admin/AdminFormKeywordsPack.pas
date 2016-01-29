unit AdminFormKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/AdminFormKeywordsPack.pas"
// Начат: 07.09.2009 18:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Администратор::Admin::View::Admin::Admin::AdminFormKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы AdminForm
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
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  Admin_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
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
  Tkw_Form_AdminForm = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы AdminForm
----
*Пример использования*:
[code]
'aControl' форма::AdminForm TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_AdminForm

// start class Tkw_Form_AdminForm

class function Tkw_Form_AdminForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::AdminForm';
end;//Tkw_Form_AdminForm.GetWordNameForRegister

function Tkw_Form_AdminForm.GetString: AnsiString;
 {-}
begin
 Result := 'cfAdminForm';
end;//Tkw_Form_AdminForm.GetString

type
  Tkw_AdminForm_Control_BackgroundPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AdminForm_Control_BackgroundPanel

// start class Tkw_AdminForm_Control_BackgroundPanel

class function Tkw_AdminForm_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_AdminForm_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_AdminForm_Control_BackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BackgroundPanel';
end;//Tkw_AdminForm_Control_BackgroundPanel.GetString

class procedure Tkw_AdminForm_Control_BackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_AdminForm_Control_BackgroundPanel.RegisterInEngine

type
  Tkw_AdminForm_Control_BackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AdminForm_Control_BackgroundPanel_Push

// start class Tkw_AdminForm_Control_BackgroundPanel_Push

procedure Tkw_AdminForm_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_AdminForm_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_AdminForm_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_AdminForm_Control_BackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_AdminForm_Control_PropertyZone = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола PropertyZone
----
*Пример использования*:
[code]
контрол::PropertyZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AdminForm_Control_PropertyZone

// start class Tkw_AdminForm_Control_PropertyZone

class function Tkw_AdminForm_Control_PropertyZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::PropertyZone';
end;//Tkw_AdminForm_Control_PropertyZone.GetWordNameForRegister

function Tkw_AdminForm_Control_PropertyZone.GetString: AnsiString;
 {-}
begin
 Result := 'PropertyZone';
end;//Tkw_AdminForm_Control_PropertyZone.GetString

class procedure Tkw_AdminForm_Control_PropertyZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_AdminForm_Control_PropertyZone.RegisterInEngine

type
  Tkw_AdminForm_Control_PropertyZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола PropertyZone
----
*Пример использования*:
[code]
контрол::PropertyZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AdminForm_Control_PropertyZone_Push

// start class Tkw_AdminForm_Control_PropertyZone_Push

procedure Tkw_AdminForm_Control_PropertyZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('PropertyZone');
 inherited;
end;//Tkw_AdminForm_Control_PropertyZone_Push.DoDoIt

class function Tkw_AdminForm_Control_PropertyZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::PropertyZone:push';
end;//Tkw_AdminForm_Control_PropertyZone_Push.GetWordNameForRegister

type
  Tkw_AdminForm_Control_TreeZone = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола TreeZone
----
*Пример использования*:
[code]
контрол::TreeZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AdminForm_Control_TreeZone

// start class Tkw_AdminForm_Control_TreeZone

class function Tkw_AdminForm_Control_TreeZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::TreeZone';
end;//Tkw_AdminForm_Control_TreeZone.GetWordNameForRegister

function Tkw_AdminForm_Control_TreeZone.GetString: AnsiString;
 {-}
begin
 Result := 'TreeZone';
end;//Tkw_AdminForm_Control_TreeZone.GetString

class procedure Tkw_AdminForm_Control_TreeZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AdminForm_Control_TreeZone.RegisterInEngine

type
  Tkw_AdminForm_Control_TreeZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола TreeZone
----
*Пример использования*:
[code]
контрол::TreeZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AdminForm_Control_TreeZone_Push

// start class Tkw_AdminForm_Control_TreeZone_Push

procedure Tkw_AdminForm_Control_TreeZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('TreeZone');
 inherited;
end;//Tkw_AdminForm_Control_TreeZone_Push.DoDoIt

class function Tkw_AdminForm_Control_TreeZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::TreeZone:push';
end;//Tkw_AdminForm_Control_TreeZone_Push.GetWordNameForRegister

type
  TkwCfAdminFormBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TcfAdminForm.BackgroundPanel
[panel]Контрол BackgroundPanel формы TcfAdminForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 acfAdminForm .TcfAdminForm.BackgroundPanel >>> l_TvtProportionalPanel
[code]  }
  private
  // private methods
   function BackgroundPanel(const aCtx: TtfwContext;
     acfAdminForm: TcfAdminForm): TvtProportionalPanel;
     {* Реализация слова скрипта .TcfAdminForm.BackgroundPanel }
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
  end;//TkwCfAdminFormBackgroundPanel

// start class TkwCfAdminFormBackgroundPanel

function TkwCfAdminFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
  acfAdminForm: TcfAdminForm): TvtProportionalPanel;
 {-}
begin
 Result := acfAdminForm.BackgroundPanel;
end;//TkwCfAdminFormBackgroundPanel.BackgroundPanel

procedure TkwCfAdminFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfAdminForm : TcfAdminForm;
begin
 try
  l_acfAdminForm := TcfAdminForm(aCtx.rEngine.PopObjAs(TcfAdminForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfAdminForm: TcfAdminForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BackgroundPanel(aCtx, l_acfAdminForm)));
end;//TkwCfAdminFormBackgroundPanel.DoDoIt

class function TkwCfAdminFormBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfAdminForm.BackgroundPanel';
end;//TkwCfAdminFormBackgroundPanel.GetWordNameForRegister

procedure TkwCfAdminFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwCfAdminFormBackgroundPanel.SetValuePrim

function TkwCfAdminFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwCfAdminFormBackgroundPanel.GetResultTypeInfo

function TkwCfAdminFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfAdminFormBackgroundPanel.GetAllParamsCount

function TkwCfAdminFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfAdminForm)]);
end;//TkwCfAdminFormBackgroundPanel.ParamsTypes

type
  TkwCfAdminFormPropertyZone = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TcfAdminForm.PropertyZone
[panel]Контрол PropertyZone формы TcfAdminForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 acfAdminForm .TcfAdminForm.PropertyZone >>> l_TvtSizeablePanel
[code]  }
  private
  // private methods
   function PropertyZone(const aCtx: TtfwContext;
     acfAdminForm: TcfAdminForm): TvtSizeablePanel;
     {* Реализация слова скрипта .TcfAdminForm.PropertyZone }
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
  end;//TkwCfAdminFormPropertyZone

// start class TkwCfAdminFormPropertyZone

function TkwCfAdminFormPropertyZone.PropertyZone(const aCtx: TtfwContext;
  acfAdminForm: TcfAdminForm): TvtSizeablePanel;
 {-}
begin
 Result := acfAdminForm.PropertyZone;
end;//TkwCfAdminFormPropertyZone.PropertyZone

procedure TkwCfAdminFormPropertyZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfAdminForm : TcfAdminForm;
begin
 try
  l_acfAdminForm := TcfAdminForm(aCtx.rEngine.PopObjAs(TcfAdminForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfAdminForm: TcfAdminForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PropertyZone(aCtx, l_acfAdminForm)));
end;//TkwCfAdminFormPropertyZone.DoDoIt

class function TkwCfAdminFormPropertyZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfAdminForm.PropertyZone';
end;//TkwCfAdminFormPropertyZone.GetWordNameForRegister

procedure TkwCfAdminFormPropertyZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству PropertyZone', aCtx);
end;//TkwCfAdminFormPropertyZone.SetValuePrim

function TkwCfAdminFormPropertyZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwCfAdminFormPropertyZone.GetResultTypeInfo

function TkwCfAdminFormPropertyZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfAdminFormPropertyZone.GetAllParamsCount

function TkwCfAdminFormPropertyZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfAdminForm)]);
end;//TkwCfAdminFormPropertyZone.ParamsTypes

type
  TkwCfAdminFormTreeZone = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TcfAdminForm.TreeZone
[panel]Контрол TreeZone формы TcfAdminForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 acfAdminForm .TcfAdminForm.TreeZone >>> l_TvtPanel
[code]  }
  private
  // private methods
   function TreeZone(const aCtx: TtfwContext;
     acfAdminForm: TcfAdminForm): TvtPanel;
     {* Реализация слова скрипта .TcfAdminForm.TreeZone }
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
  end;//TkwCfAdminFormTreeZone

// start class TkwCfAdminFormTreeZone

function TkwCfAdminFormTreeZone.TreeZone(const aCtx: TtfwContext;
  acfAdminForm: TcfAdminForm): TvtPanel;
 {-}
begin
 Result := acfAdminForm.TreeZone;
end;//TkwCfAdminFormTreeZone.TreeZone

procedure TkwCfAdminFormTreeZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfAdminForm : TcfAdminForm;
begin
 try
  l_acfAdminForm := TcfAdminForm(aCtx.rEngine.PopObjAs(TcfAdminForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfAdminForm: TcfAdminForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TreeZone(aCtx, l_acfAdminForm)));
end;//TkwCfAdminFormTreeZone.DoDoIt

class function TkwCfAdminFormTreeZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfAdminForm.TreeZone';
end;//TkwCfAdminFormTreeZone.GetWordNameForRegister

procedure TkwCfAdminFormTreeZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству TreeZone', aCtx);
end;//TkwCfAdminFormTreeZone.SetValuePrim

function TkwCfAdminFormTreeZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfAdminFormTreeZone.GetResultTypeInfo

function TkwCfAdminFormTreeZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfAdminFormTreeZone.GetAllParamsCount

function TkwCfAdminFormTreeZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfAdminForm)]);
end;//TkwCfAdminFormTreeZone.ParamsTypes
{$IfEnd} //Admin AND not NoScripts

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_Form_AdminForm
 Tkw_Form_AdminForm.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminForm_Control_BackgroundPanel
 Tkw_AdminForm_Control_BackgroundPanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminForm_Control_BackgroundPanel_Push
 Tkw_AdminForm_Control_BackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminForm_Control_PropertyZone
 Tkw_AdminForm_Control_PropertyZone.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminForm_Control_PropertyZone_Push
 Tkw_AdminForm_Control_PropertyZone_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminForm_Control_TreeZone
 Tkw_AdminForm_Control_TreeZone.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_AdminForm_Control_TreeZone_Push
 Tkw_AdminForm_Control_TreeZone_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация cfAdminForm_BackgroundPanel
 TkwCfAdminFormBackgroundPanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация cfAdminForm_PropertyZone
 TkwCfAdminFormPropertyZone.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация cfAdminForm_TreeZone
 TkwCfAdminFormTreeZone.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа AdminForm
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfAdminForm));
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
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //Admin AND not NoScripts

end.