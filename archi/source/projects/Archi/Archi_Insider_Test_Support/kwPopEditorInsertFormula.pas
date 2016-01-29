unit kwPopEditorInsertFormula;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwPopEditorInsertFormula.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::EditorKeyWords::pop_editor_InsertFormula
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  kwEditorFromStackWord,
  evCustomEditorWindow,
  tfwScriptingInterfaces
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwPopEditorInsertFormula = {final scriptword} class(TkwEditorFromStackWord)
 protected
 // realized methods
   procedure DoWithEditor(const aCtx: TtfwContext;
     anEditor: TevCustomEditorWindow); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorInsertFormula
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  evCommonUtils,
  evCustomEditor
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwPopEditorInsertFormula

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
 {-}
begin
 Result := 'pop:editor:InsertFormula';
end;//TkwPopEditorInsertFormula.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация pop_editor_InsertFormula
 TkwPopEditorInsertFormula.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.