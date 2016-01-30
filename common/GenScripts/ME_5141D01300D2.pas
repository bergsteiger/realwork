unit kwPopEditorGetLMargin;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetLMargin.pas"
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
 TkwPopEditorGetLMargin = {final} class(TkwEditorFromStackWord)
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorGetLMargin
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwPopEditorGetLMargin.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_5141D01300D2_var*
//#UC END# *4F4CB81200CA_5141D01300D2_var*
begin
//#UC START# *4F4CB81200CA_5141D01300D2_impl*
 aCtx.rEngine.PushInt(anEditor.LMargin);
//#UC END# *4F4CB81200CA_5141D01300D2_impl*
end;//TkwPopEditorGetLMargin.DoWithEditor

class function TkwPopEditorGetLMargin.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:GetLMargin';
end;//TkwPopEditorGetLMargin.GetWordNameForRegister

initialization
 TkwPopEditorGetLMargin.RegisterInEngine;
 {* Регистрация pop_editor_GetLMargin }
{$IfEnd} // NOT Defined(NoScripts)

end.
