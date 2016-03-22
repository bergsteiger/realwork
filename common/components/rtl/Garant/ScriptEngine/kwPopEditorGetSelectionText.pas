unit kwPopEditorGetSelectionText;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetSelectionText.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_editor_GetSelectionText" MUID: (4EAFDEE000EC)
// Имя типа: "TkwPopEditorGetSelectionText"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorGetSelectionText = class(TkwEditorFromStackWord)
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorGetSelectionText
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwPopEditorGetSelectionText.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4EAFDEE000EC_var*
//#UC END# *4F4CB81200CA_4EAFDEE000EC_var*
begin
//#UC START# *4F4CB81200CA_4EAFDEE000EC_impl*
 aCtx.rEngine.PushString(EvAsString(anEditor.View.Control.Selection.GetBlock.Data));
//#UC END# *4F4CB81200CA_4EAFDEE000EC_impl*
end;//TkwPopEditorGetSelectionText.DoWithEditor

class function TkwPopEditorGetSelectionText.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:GetSelectionText';
end;//TkwPopEditorGetSelectionText.GetWordNameForRegister

initialization
 TkwPopEditorGetSelectionText.RegisterInEngine;
 {* Регистрация pop_editor_GetSelectionText }
{$IfEnd} // NOT Defined(NoScripts)

end.
