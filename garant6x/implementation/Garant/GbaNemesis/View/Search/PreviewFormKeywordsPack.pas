unit PreviewFormKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/PreviewFormKeywordsPack.pas"
// Начат: 10.09.2009 21:03
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::CommonSearch::PreviewFormKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы PreviewForm
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(NoScripts)}
uses
  Preview_Form
  {$If defined(Nemesis)}
  ,
  nscPreviewPanel
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

{$IfEnd} //not Admin AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_PreviewForm = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы PreviewForm
----
*Пример использования*:
[code]
'aControl' форма::PreviewForm TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_PreviewForm

// start class Tkw_Form_PreviewForm

class function Tkw_Form_PreviewForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::PreviewForm';
end;//Tkw_Form_PreviewForm.GetWordNameForRegister

function Tkw_Form_PreviewForm.GetString: AnsiString;
 {-}
begin
 Result := 'efPreviewForm';
end;//Tkw_Form_PreviewForm.GetString

type
  Tkw_PreviewForm_Control_PreviewPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола PreviewPanel
----
*Пример использования*:
[code]
контрол::PreviewPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_PreviewForm_Control_PreviewPanel

// start class Tkw_PreviewForm_Control_PreviewPanel

class function Tkw_PreviewForm_Control_PreviewPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::PreviewPanel';
end;//Tkw_PreviewForm_Control_PreviewPanel.GetWordNameForRegister

function Tkw_PreviewForm_Control_PreviewPanel.GetString: AnsiString;
 {-}
begin
 Result := 'PreviewPanel';
end;//Tkw_PreviewForm_Control_PreviewPanel.GetString

class procedure Tkw_PreviewForm_Control_PreviewPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscPreviewPanel);
end;//Tkw_PreviewForm_Control_PreviewPanel.RegisterInEngine

type
  Tkw_PreviewForm_Control_PreviewPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола PreviewPanel
----
*Пример использования*:
[code]
контрол::PreviewPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_PreviewForm_Control_PreviewPanel_Push

// start class Tkw_PreviewForm_Control_PreviewPanel_Push

procedure Tkw_PreviewForm_Control_PreviewPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('PreviewPanel');
 inherited;
end;//Tkw_PreviewForm_Control_PreviewPanel_Push.DoDoIt

class function Tkw_PreviewForm_Control_PreviewPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::PreviewPanel:push';
end;//Tkw_PreviewForm_Control_PreviewPanel_Push.GetWordNameForRegister

type
  TkwEfPreviewFormPreviewPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefPreviewForm.PreviewPanel
[panel]Контрол PreviewPanel формы TefPreviewForm[panel]
*Тип результата:* TnscPreviewPanel
*Пример:*
[code]
OBJECT VAR l_TnscPreviewPanel
 aefPreviewForm .TefPreviewForm.PreviewPanel >>> l_TnscPreviewPanel
[code]  }
  private
  // private methods
   function PreviewPanel(const aCtx: TtfwContext;
     aefPreviewForm: TefPreviewForm): TnscPreviewPanel;
     {* Реализация слова скрипта .TefPreviewForm.PreviewPanel }
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
  end;//TkwEfPreviewFormPreviewPanel

// start class TkwEfPreviewFormPreviewPanel

function TkwEfPreviewFormPreviewPanel.PreviewPanel(const aCtx: TtfwContext;
  aefPreviewForm: TefPreviewForm): TnscPreviewPanel;
 {-}
begin
 Result := aefPreviewForm.PreviewPanel;
end;//TkwEfPreviewFormPreviewPanel.PreviewPanel

procedure TkwEfPreviewFormPreviewPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefPreviewForm : TefPreviewForm;
begin
 try
  l_aefPreviewForm := TefPreviewForm(aCtx.rEngine.PopObjAs(TefPreviewForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefPreviewForm: TefPreviewForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PreviewPanel(aCtx, l_aefPreviewForm)));
end;//TkwEfPreviewFormPreviewPanel.DoDoIt

class function TkwEfPreviewFormPreviewPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefPreviewForm.PreviewPanel';
end;//TkwEfPreviewFormPreviewPanel.GetWordNameForRegister

procedure TkwEfPreviewFormPreviewPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству PreviewPanel', aCtx);
end;//TkwEfPreviewFormPreviewPanel.SetValuePrim

function TkwEfPreviewFormPreviewPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscPreviewPanel);
end;//TkwEfPreviewFormPreviewPanel.GetResultTypeInfo

function TkwEfPreviewFormPreviewPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfPreviewFormPreviewPanel.GetAllParamsCount

function TkwEfPreviewFormPreviewPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefPreviewForm)]);
end;//TkwEfPreviewFormPreviewPanel.ParamsTypes
{$IfEnd} //not Admin AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_Form_PreviewForm
 Tkw_Form_PreviewForm.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PreviewForm_Control_PreviewPanel
 Tkw_PreviewForm_Control_PreviewPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PreviewForm_Control_PreviewPanel_Push
 Tkw_PreviewForm_Control_PreviewPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация efPreviewForm_PreviewPanel
 TkwEfPreviewFormPreviewPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа PreviewForm
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefPreviewForm));
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TnscPreviewPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscPreviewPanel));
{$IfEnd} //not Admin AND not NoScripts

end.