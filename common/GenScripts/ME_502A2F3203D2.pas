unit kwPopEditorInsertFormula;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwPopEditorInsertFormula.pas"
// Стереотип: "ScriptKeyword"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorInsertFormula = {final} class(TkwEditorFromStackWord)
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorInsertFormula
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evCommonUtils
 , evCustomEditor
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwPopEditorInsertFormula.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_502A2F3203D2_var*
//#UC END# *4F4CB81200CA_502A2F3203D2_var*
begin
//#UC START# *4F4CB81200CA_502A2F3203D2_impl*
 EvInsertFormula(anEditor as TevCustomEditor);
//#UC END# *4F4CB81200CA_502A2F3203D2_impl*
end;//TkwPopEditorInsertFormula.DoWithEditor

class function TkwPopEditorInsertFormula.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:InsertFormula';
end;//TkwPopEditorInsertFormula.GetWordNameForRegister

initialization
 TkwPopEditorInsertFormula.RegisterInEngine;
 {* Регистрация pop_editor_InsertFormula }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
