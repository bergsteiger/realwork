unit kwPopEditorCheckContinueCells;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCheckContinueCells.pas"
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
 TkwPopEditorCheckContinueCells = {final} class(TkwEditorFromStackWord)
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorCheckContinueCells
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evTableSearch
 , evTypes
;

procedure TkwPopEditorCheckContinueCells.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_507510BF02AB_var*
//#UC END# *4F4CB81200CA_507510BF02AB_var*
begin
//#UC START# *4F4CB81200CA_507510BF02AB_impl*
 aCtx.rEngine.PushBool(anEditor.Find(TevTextInContinueCellSearcher.Make, nil, [ev_soGlobal, ev_soUseInternalCursor]));
//#UC END# *4F4CB81200CA_507510BF02AB_impl*
end;//TkwPopEditorCheckContinueCells.DoWithEditor

class function TkwPopEditorCheckContinueCells.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:CheckContinueCells';
end;//TkwPopEditorCheckContinueCells.GetWordNameForRegister

initialization
 TkwPopEditorCheckContinueCells.RegisterInEngine;
 {* Регистрация pop_editor_CheckContinueCells }
{$IfEnd} // NOT Defined(NoScripts)

end.
