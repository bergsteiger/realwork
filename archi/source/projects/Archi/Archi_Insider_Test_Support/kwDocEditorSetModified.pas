unit kwDocEditorSetModified;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwDocEditorSetModified.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "TkwDocEditorSetModified" MUID: (4E01E88B029B)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , arEditorControl
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwDocEditorSetModified = class(TarEditorControl)
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    const anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDocEditorSetModified
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *4E01E88B029Bimpl_uses*
 //#UC END# *4E01E88B029Bimpl_uses*
;

procedure TkwDocEditorSetModified.DoWithEditor(const aCtx: TtfwContext;
 const anEditor: TevCustomEditorWindow);
//#UC START# *4DE7421F03DF_4E01E88B029B_var*
//#UC END# *4DE7421F03DF_4E01E88B029B_var*
begin
//#UC START# *4DE7421F03DF_4E01E88B029B_impl*
 if aCtx.rEngine.IsTopBool then
  anEditor.Modified := aCtx.rEngine.PopBool
 else
  Assert(False, 'Не задано значения флага.');
//#UC END# *4DE7421F03DF_4E01E88B029B_impl*
end;//TkwDocEditorSetModified.DoWithEditor

class function TkwDocEditorSetModified.GetWordNameForRegister: AnsiString;
begin
 Result := 'окно_редактора:редактор:SetModified';
end;//TkwDocEditorSetModified.GetWordNameForRegister

initialization
 TkwDocEditorSetModified.RegisterInEngine;
 {* Регистрация TkwDocEditorSetModified }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
