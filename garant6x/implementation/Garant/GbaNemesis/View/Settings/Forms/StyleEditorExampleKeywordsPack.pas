unit StyleEditorExampleKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы StyleEditorExample }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorExampleKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "StyleEditorExampleKeywordsPack" MUID: (4ABA14A4011C_Pack)

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
 , StyleEditorExample_Form
 , tfwPropertyLike
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , vtPanel
 , eeEditorWithoutOperations
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4ABA14A4011C_Packimpl_uses*
 //#UC END# *4ABA14A4011C_Packimpl_uses*
;

type
 TkwStyleEditorExampleFormTextSource = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorExampleForm.TextSource }
  private
   function TextSource(const aCtx: TtfwContext;
    aStyleEditorExampleForm: TStyleEditorExampleForm): TnscTextSource;
    {* Реализация слова скрипта .TStyleEditorExampleForm.TextSource }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorExampleFormTextSource

 TkwStyleEditorExampleFormEditorPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorExampleForm.EditorPanel }
  private
   function EditorPanel(const aCtx: TtfwContext;
    aStyleEditorExampleForm: TStyleEditorExampleForm): TvtPanel;
    {* Реализация слова скрипта .TStyleEditorExampleForm.EditorPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorExampleFormEditorPanel

 TkwStyleEditorExampleFormEditor = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorExampleForm.Editor }
  private
   function Editor(const aCtx: TtfwContext;
    aStyleEditorExampleForm: TStyleEditorExampleForm): TeeEditorWithoutOperations;
    {* Реализация слова скрипта .TStyleEditorExampleForm.Editor }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorExampleFormEditor

 Tkw_Form_StyleEditorExample = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы StyleEditorExample
----
*Пример использования*:
[code]форма::StyleEditorExample TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_StyleEditorExample

 Tkw_StyleEditorExample_Component_TextSource = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TextSource
----
*Пример использования*:
[code]компонент::TextSource TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorExample_Component_TextSource

 Tkw_StyleEditorExample_Control_EditorPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола EditorPanel
----
*Пример использования*:
[code]контрол::EditorPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorExample_Control_EditorPanel

 Tkw_StyleEditorExample_Control_EditorPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола EditorPanel
----
*Пример использования*:
[code]контрол::EditorPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorExample_Control_EditorPanel_Push

 Tkw_StyleEditorExample_Control_Editor = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Editor
----
*Пример использования*:
[code]контрол::Editor TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorExample_Control_Editor

 Tkw_StyleEditorExample_Control_Editor_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Editor
----
*Пример использования*:
[code]контрол::Editor:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorExample_Control_Editor_Push

function TkwStyleEditorExampleFormTextSource.TextSource(const aCtx: TtfwContext;
 aStyleEditorExampleForm: TStyleEditorExampleForm): TnscTextSource;
 {* Реализация слова скрипта .TStyleEditorExampleForm.TextSource }
begin
 Result := aStyleEditorExampleForm.TextSource;
end;//TkwStyleEditorExampleFormTextSource.TextSource

class function TkwStyleEditorExampleFormTextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorExampleForm.TextSource';
end;//TkwStyleEditorExampleFormTextSource.GetWordNameForRegister

function TkwStyleEditorExampleFormTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTextSource);
end;//TkwStyleEditorExampleFormTextSource.GetResultTypeInfo

function TkwStyleEditorExampleFormTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorExampleFormTextSource.GetAllParamsCount

function TkwStyleEditorExampleFormTextSource.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorExampleForm)]);
end;//TkwStyleEditorExampleFormTextSource.ParamsTypes

procedure TkwStyleEditorExampleFormTextSource.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству TextSource', aCtx);
end;//TkwStyleEditorExampleFormTextSource.SetValuePrim

procedure TkwStyleEditorExampleFormTextSource.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorExampleForm: TStyleEditorExampleForm;
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
 aCtx.rEngine.PushObj(TextSource(aCtx, l_aStyleEditorExampleForm));
end;//TkwStyleEditorExampleFormTextSource.DoDoIt

function TkwStyleEditorExampleFormEditorPanel.EditorPanel(const aCtx: TtfwContext;
 aStyleEditorExampleForm: TStyleEditorExampleForm): TvtPanel;
 {* Реализация слова скрипта .TStyleEditorExampleForm.EditorPanel }
begin
 Result := aStyleEditorExampleForm.EditorPanel;
end;//TkwStyleEditorExampleFormEditorPanel.EditorPanel

class function TkwStyleEditorExampleFormEditorPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorExampleForm.EditorPanel';
end;//TkwStyleEditorExampleFormEditorPanel.GetWordNameForRegister

function TkwStyleEditorExampleFormEditorPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwStyleEditorExampleFormEditorPanel.GetResultTypeInfo

function TkwStyleEditorExampleFormEditorPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorExampleFormEditorPanel.GetAllParamsCount

function TkwStyleEditorExampleFormEditorPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorExampleForm)]);
end;//TkwStyleEditorExampleFormEditorPanel.ParamsTypes

procedure TkwStyleEditorExampleFormEditorPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству EditorPanel', aCtx);
end;//TkwStyleEditorExampleFormEditorPanel.SetValuePrim

procedure TkwStyleEditorExampleFormEditorPanel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorExampleForm: TStyleEditorExampleForm;
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
 aCtx.rEngine.PushObj(EditorPanel(aCtx, l_aStyleEditorExampleForm));
end;//TkwStyleEditorExampleFormEditorPanel.DoDoIt

function TkwStyleEditorExampleFormEditor.Editor(const aCtx: TtfwContext;
 aStyleEditorExampleForm: TStyleEditorExampleForm): TeeEditorWithoutOperations;
 {* Реализация слова скрипта .TStyleEditorExampleForm.Editor }
begin
 Result := aStyleEditorExampleForm.Editor;
end;//TkwStyleEditorExampleFormEditor.Editor

class function TkwStyleEditorExampleFormEditor.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorExampleForm.Editor';
end;//TkwStyleEditorExampleFormEditor.GetWordNameForRegister

function TkwStyleEditorExampleFormEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeEditorWithoutOperations);
end;//TkwStyleEditorExampleFormEditor.GetResultTypeInfo

function TkwStyleEditorExampleFormEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorExampleFormEditor.GetAllParamsCount

function TkwStyleEditorExampleFormEditor.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorExampleForm)]);
end;//TkwStyleEditorExampleFormEditor.ParamsTypes

procedure TkwStyleEditorExampleFormEditor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Editor', aCtx);
end;//TkwStyleEditorExampleFormEditor.SetValuePrim

procedure TkwStyleEditorExampleFormEditor.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorExampleForm: TStyleEditorExampleForm;
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
 aCtx.rEngine.PushObj(Editor(aCtx, l_aStyleEditorExampleForm));
end;//TkwStyleEditorExampleFormEditor.DoDoIt

function Tkw_Form_StyleEditorExample.GetString: AnsiString;
begin
 Result := 'StyleEditorExampleForm';
end;//Tkw_Form_StyleEditorExample.GetString

class procedure Tkw_Form_StyleEditorExample.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TStyleEditorExampleForm);
end;//Tkw_Form_StyleEditorExample.RegisterInEngine

class function Tkw_Form_StyleEditorExample.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::StyleEditorExample';
end;//Tkw_Form_StyleEditorExample.GetWordNameForRegister

function Tkw_StyleEditorExample_Component_TextSource.GetString: AnsiString;
begin
 Result := 'TextSource';
end;//Tkw_StyleEditorExample_Component_TextSource.GetString

class procedure Tkw_StyleEditorExample_Component_TextSource.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTextSource);
end;//Tkw_StyleEditorExample_Component_TextSource.RegisterInEngine

class function Tkw_StyleEditorExample_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::TextSource';
end;//Tkw_StyleEditorExample_Component_TextSource.GetWordNameForRegister

function Tkw_StyleEditorExample_Control_EditorPanel.GetString: AnsiString;
begin
 Result := 'EditorPanel';
end;//Tkw_StyleEditorExample_Control_EditorPanel.GetString

class procedure Tkw_StyleEditorExample_Control_EditorPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_StyleEditorExample_Control_EditorPanel.RegisterInEngine

class function Tkw_StyleEditorExample_Control_EditorPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EditorPanel';
end;//Tkw_StyleEditorExample_Control_EditorPanel.GetWordNameForRegister

procedure Tkw_StyleEditorExample_Control_EditorPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('EditorPanel');
 inherited;
end;//Tkw_StyleEditorExample_Control_EditorPanel_Push.DoDoIt

class function Tkw_StyleEditorExample_Control_EditorPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EditorPanel:push';
end;//Tkw_StyleEditorExample_Control_EditorPanel_Push.GetWordNameForRegister

function Tkw_StyleEditorExample_Control_Editor.GetString: AnsiString;
begin
 Result := 'Editor';
end;//Tkw_StyleEditorExample_Control_Editor.GetString

class procedure Tkw_StyleEditorExample_Control_Editor.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeEditorWithoutOperations);
end;//Tkw_StyleEditorExample_Control_Editor.RegisterInEngine

class function Tkw_StyleEditorExample_Control_Editor.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Editor';
end;//Tkw_StyleEditorExample_Control_Editor.GetWordNameForRegister

procedure Tkw_StyleEditorExample_Control_Editor_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Editor');
 inherited;
end;//Tkw_StyleEditorExample_Control_Editor_Push.DoDoIt

class function Tkw_StyleEditorExample_Control_Editor_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Editor:push';
end;//Tkw_StyleEditorExample_Control_Editor_Push.GetWordNameForRegister

initialization
 TkwStyleEditorExampleFormTextSource.RegisterInEngine;
 {* Регистрация StyleEditorExampleForm_TextSource }
 TkwStyleEditorExampleFormEditorPanel.RegisterInEngine;
 {* Регистрация StyleEditorExampleForm_EditorPanel }
 TkwStyleEditorExampleFormEditor.RegisterInEngine;
 {* Регистрация StyleEditorExampleForm_Editor }
 Tkw_Form_StyleEditorExample.RegisterInEngine;
 {* Регистрация Tkw_Form_StyleEditorExample }
 Tkw_StyleEditorExample_Component_TextSource.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorExample_Component_TextSource }
 Tkw_StyleEditorExample_Control_EditorPanel.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorExample_Control_EditorPanel }
 Tkw_StyleEditorExample_Control_EditorPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorExample_Control_EditorPanel_Push }
 Tkw_StyleEditorExample_Control_Editor.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorExample_Control_Editor }
 Tkw_StyleEditorExample_Control_Editor_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorExample_Control_Editor_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TStyleEditorExampleForm));
 {* Регистрация типа TStyleEditorExampleForm }
{$If Defined(Nemesis)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTextSource));
 {* Регистрация типа TnscTextSource }
{$IfEnd} // Defined(Nemesis)
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeEditorWithoutOperations));
 {* Регистрация типа TeeEditorWithoutOperations }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
