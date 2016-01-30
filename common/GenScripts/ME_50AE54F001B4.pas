unit kwPopEditorGetLeftIndentDelta;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetLeftIndentDelta.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorGetLeftIndentDelta = {final} class(TkwEditorFromStackWord)
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorGetLeftIndentDelta
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwPopEditorGetLeftIndentDelta.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_50AE54F001B4_var*
//#UC END# *4F4CB81200CA_50AE54F001B4_var*
begin
//#UC START# *4F4CB81200CA_50AE54F001B4_impl*
 aCtx.rEngine.PushInt(anEditor.LeftIndentDelta);
//#UC END# *4F4CB81200CA_50AE54F001B4_impl*
end;//TkwPopEditorGetLeftIndentDelta.DoWithEditor

class function TkwPopEditorGetLeftIndentDelta.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:GetLeftIndentDelta';
end;//TkwPopEditorGetLeftIndentDelta.GetWordNameForRegister

initialization
 TkwPopEditorGetLeftIndentDelta.RegisterInEngine;
 {* Регистрация pop_editor_GetLeftIndentDelta }
{$IfEnd} // NOT Defined(NoScripts)

end.
