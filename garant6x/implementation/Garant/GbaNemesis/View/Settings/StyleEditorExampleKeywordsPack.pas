unit StyleEditorExampleKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/StyleEditorExampleKeywordsPack.pas"
// Начат: 09.09.2009 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Основные прецеденты::Settings::View::Settings::Settings::StyleEditorExampleKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы StyleEditorExample
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
  Classes
  {$If defined(Nemesis)}
  ,
  nscTextSource
  {$IfEnd} //Nemesis
  ,
  vtPanel,
  StyleEditorExample_Form,
  eeEditorWithoutOperations,
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
  Tkw_Form_StyleEditorExample = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы StyleEditorExample
----
*Пример использования*:
[code]
'aControl' форма::StyleEditorExample TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_StyleEditorExample

// start class Tkw_Form_StyleEditorExample

class function Tkw_Form_StyleEditorExample.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::StyleEditorExample';
end;//Tkw_Form_StyleEditorExample.GetWordNameForRegister

function Tkw_Form_StyleEditorExample.GetString: AnsiString;
 {-}
begin
 Result := 'StyleEditorExampleForm';
end;//Tkw_Form_StyleEditorExample.GetString

type
  Tkw_StyleEditorExample_Component_TextSource = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола TextSource
----
*Пример использования*:
[code]
компонент::TextSource TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorExample_Component_TextSource

// start class Tkw_StyleEditorExample_Component_TextSource

class function Tkw_StyleEditorExample_Component_TextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'компонент::TextSource';
end;//Tkw_StyleEditorExample_Component_TextSource.GetWordNameForRegister

function Tkw_StyleEditorExample_Component_TextSource.GetString: AnsiString;
 {-}
begin
 Result := 'TextSource';
end;//Tkw_StyleEditorExample_Component_TextSource.GetString

class procedure Tkw_StyleEditorExample_Component_TextSource.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTextSource);
end;//Tkw_StyleEditorExample_Component_TextSource.RegisterInEngine

type
  Tkw_StyleEditorExample_Control_EditorPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола EditorPanel
----
*Пример использования*:
[code]
контрол::EditorPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorExample_Control_EditorPanel

// start class Tkw_StyleEditorExample_Control_EditorPanel

class function Tkw_StyleEditorExample_Control_EditorPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::EditorPanel';
end;//Tkw_StyleEditorExample_Control_EditorPanel.GetWordNameForRegister

function Tkw_StyleEditorExample_Control_EditorPanel.GetString: AnsiString;
 {-}
begin
 Result := 'EditorPanel';
end;//Tkw_StyleEditorExample_Control_EditorPanel.GetString

class procedure Tkw_StyleEditorExample_Control_EditorPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_StyleEditorExample_Control_EditorPanel.RegisterInEngine

type
  Tkw_StyleEditorExample_Control_EditorPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола EditorPanel
----
*Пример использования*:
[code]
контрол::EditorPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorExample_Control_EditorPanel_Push

// start class Tkw_StyleEditorExample_Control_EditorPanel_Push

procedure Tkw_StyleEditorExample_Control_EditorPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('EditorPanel');
 inherited;
end;//Tkw_StyleEditorExample_Control_EditorPanel_Push.DoDoIt

class function Tkw_StyleEditorExample_Control_EditorPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::EditorPanel:push';
end;//Tkw_StyleEditorExample_Control_EditorPanel_Push.GetWordNameForRegister

type
  Tkw_StyleEditorExample_Control_Editor = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола Editor
----
*Пример использования*:
[code]
контрол::Editor TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorExample_Control_Editor

// start class Tkw_StyleEditorExample_Control_Editor

class function Tkw_StyleEditorExample_Control_Editor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Editor';
end;//Tkw_StyleEditorExample_Control_Editor.GetWordNameForRegister

function Tkw_StyleEditorExample_Control_Editor.GetString: AnsiString;
 {-}
begin
 Result := 'Editor';
end;//Tkw_StyleEditorExample_Control_Editor.GetString

class procedure Tkw_StyleEditorExample_Control_Editor.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeEditorWithoutOperations);
end;//Tkw_StyleEditorExample_Control_Editor.RegisterInEngine

type
  Tkw_StyleEditorExample_Control_Editor_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола Editor
----
*Пример использования*:
[code]
контрол::Editor:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorExample_Control_Editor_Push

// start class Tkw_StyleEditorExample_Control_Editor_Push

procedure Tkw_StyleEditorExample_Control_Editor_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Editor');
 inherited;
end;//Tkw_StyleEditorExample_Control_Editor_Push.DoDoIt

class function Tkw_StyleEditorExample_Control_Editor_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Editor:push';
end;//Tkw_StyleEditorExample_Control_Editor_Push.GetWordNameForRegister

type
  TkwStyleEditorExampleFormTextSource = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorExampleForm.TextSource
[panel]Контрол TextSource формы TStyleEditorExampleForm[panel]
*Тип результата:* TnscTextSource
*Пример:*
[code]
OBJECT VAR l_TnscTextSource
 aStyleEditorExampleForm .TStyleEditorExampleForm.TextSource >>> l_TnscTextSource
[code]  }
  private
  // private methods
   function TextSource(const aCtx: TtfwContext;
     aStyleEditorExampleForm: TStyleEditorExampleForm): TnscTextSource;
     {* Реализация слова скрипта .TStyleEditorExampleForm.TextSource }
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
  end;//TkwStyleEditorExampleFormTextSource

// start class TkwStyleEditorExampleFormTextSource

function TkwStyleEditorExampleFormTextSource.TextSource(const aCtx: TtfwContext;
  aStyleEditorExampleForm: TStyleEditorExampleForm): TnscTextSource;
 {-}
begin
 Result := aStyleEditorExampleForm.TextSource;
end;//TkwStyleEditorExampleFormTextSource.TextSource

procedure TkwStyleEditorExampleFormTextSource.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorExampleForm : TStyleEditorExampleForm;
begin
 try
  l_aStyleEditorExampleForm := TStyleEditorExampleForm(aCtx.rEngine.PopObjAs(TStyleEditorExampleForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorExampleForm: TStyleEditorExampleForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TextSource(aCtx, l_aStyleEditorExampleForm)));
end;//TkwStyleEditorExampleFormTextSource.DoDoIt

class function TkwStyleEditorExampleFormTextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorExampleForm.TextSource';
end;//TkwStyleEditorExampleFormTextSource.GetWordNameForRegister

procedure TkwStyleEditorExampleFormTextSource.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству TextSource', aCtx);
end;//TkwStyleEditorExampleFormTextSource.SetValuePrim

function TkwStyleEditorExampleFormTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTextSource);
end;//TkwStyleEditorExampleFormTextSource.GetResultTypeInfo

function TkwStyleEditorExampleFormTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorExampleFormTextSource.GetAllParamsCount

function TkwStyleEditorExampleFormTextSource.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorExampleForm)]);
end;//TkwStyleEditorExampleFormTextSource.ParamsTypes

type
  TkwStyleEditorExampleFormEditorPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorExampleForm.EditorPanel
[panel]Контрол EditorPanel формы TStyleEditorExampleForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aStyleEditorExampleForm .TStyleEditorExampleForm.EditorPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function EditorPanel(const aCtx: TtfwContext;
     aStyleEditorExampleForm: TStyleEditorExampleForm): TvtPanel;
     {* Реализация слова скрипта .TStyleEditorExampleForm.EditorPanel }
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
  end;//TkwStyleEditorExampleFormEditorPanel

// start class TkwStyleEditorExampleFormEditorPanel

function TkwStyleEditorExampleFormEditorPanel.EditorPanel(const aCtx: TtfwContext;
  aStyleEditorExampleForm: TStyleEditorExampleForm): TvtPanel;
 {-}
begin
 Result := aStyleEditorExampleForm.EditorPanel;
end;//TkwStyleEditorExampleFormEditorPanel.EditorPanel

procedure TkwStyleEditorExampleFormEditorPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorExampleForm : TStyleEditorExampleForm;
begin
 try
  l_aStyleEditorExampleForm := TStyleEditorExampleForm(aCtx.rEngine.PopObjAs(TStyleEditorExampleForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorExampleForm: TStyleEditorExampleForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EditorPanel(aCtx, l_aStyleEditorExampleForm)));
end;//TkwStyleEditorExampleFormEditorPanel.DoDoIt

class function TkwStyleEditorExampleFormEditorPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorExampleForm.EditorPanel';
end;//TkwStyleEditorExampleFormEditorPanel.GetWordNameForRegister

procedure TkwStyleEditorExampleFormEditorPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству EditorPanel', aCtx);
end;//TkwStyleEditorExampleFormEditorPanel.SetValuePrim

function TkwStyleEditorExampleFormEditorPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwStyleEditorExampleFormEditorPanel.GetResultTypeInfo

function TkwStyleEditorExampleFormEditorPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorExampleFormEditorPanel.GetAllParamsCount

function TkwStyleEditorExampleFormEditorPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorExampleForm)]);
end;//TkwStyleEditorExampleFormEditorPanel.ParamsTypes

type
  TkwStyleEditorExampleFormEditor = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorExampleForm.Editor
[panel]Контрол Editor формы TStyleEditorExampleForm[panel]
*Тип результата:* TeeEditorWithoutOperations
*Пример:*
[code]
OBJECT VAR l_TeeEditorWithoutOperations
 aStyleEditorExampleForm .TStyleEditorExampleForm.Editor >>> l_TeeEditorWithoutOperations
[code]  }
  private
  // private methods
   function Editor(const aCtx: TtfwContext;
     aStyleEditorExampleForm: TStyleEditorExampleForm): TeeEditorWithoutOperations;
     {* Реализация слова скрипта .TStyleEditorExampleForm.Editor }
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
  end;//TkwStyleEditorExampleFormEditor

// start class TkwStyleEditorExampleFormEditor

function TkwStyleEditorExampleFormEditor.Editor(const aCtx: TtfwContext;
  aStyleEditorExampleForm: TStyleEditorExampleForm): TeeEditorWithoutOperations;
 {-}
begin
 Result := aStyleEditorExampleForm.Editor;
end;//TkwStyleEditorExampleFormEditor.Editor

procedure TkwStyleEditorExampleFormEditor.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorExampleForm : TStyleEditorExampleForm;
begin
 try
  l_aStyleEditorExampleForm := TStyleEditorExampleForm(aCtx.rEngine.PopObjAs(TStyleEditorExampleForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorExampleForm: TStyleEditorExampleForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Editor(aCtx, l_aStyleEditorExampleForm)));
end;//TkwStyleEditorExampleFormEditor.DoDoIt

class function TkwStyleEditorExampleFormEditor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorExampleForm.Editor';
end;//TkwStyleEditorExampleFormEditor.GetWordNameForRegister

procedure TkwStyleEditorExampleFormEditor.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Editor', aCtx);
end;//TkwStyleEditorExampleFormEditor.SetValuePrim

function TkwStyleEditorExampleFormEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeEditorWithoutOperations);
end;//TkwStyleEditorExampleFormEditor.GetResultTypeInfo

function TkwStyleEditorExampleFormEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorExampleFormEditor.GetAllParamsCount

function TkwStyleEditorExampleFormEditor.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorExampleForm)]);
end;//TkwStyleEditorExampleFormEditor.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_StyleEditorExample
 Tkw_Form_StyleEditorExample.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorExample_Component_TextSource
 Tkw_StyleEditorExample_Component_TextSource.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorExample_Control_EditorPanel
 Tkw_StyleEditorExample_Control_EditorPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorExample_Control_EditorPanel_Push
 Tkw_StyleEditorExample_Control_EditorPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorExample_Control_Editor
 Tkw_StyleEditorExample_Control_Editor.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorExample_Control_Editor_Push
 Tkw_StyleEditorExample_Control_Editor_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorExampleForm_TextSource
 TkwStyleEditorExampleFormTextSource.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorExampleForm_EditorPanel
 TkwStyleEditorExampleFormEditorPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorExampleForm_Editor
 TkwStyleEditorExampleFormEditor.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа StyleEditorExample
 TtfwTypeRegistrator.RegisterType(TypeInfo(TStyleEditorExampleForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscTextSource
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTextSource));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TeeEditorWithoutOperations
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeEditorWithoutOperations));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.