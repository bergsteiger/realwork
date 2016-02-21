unit kwPopEditorGetWrapLimit;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetWrapLimit.pas"
// Стереотип: "ScriptKeyword"

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
 TkwPopEditorGetWrapLimit = {final} class(TkwEditorFromStackWord)
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorGetWrapLimit
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Units
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TevCEWHack = class(TevCustomEditorWindow)
 end;//TevCEWHack

procedure TkwPopEditorGetWrapLimit.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_51499706003B_var*
//#UC END# *4F4CB81200CA_51499706003B_var*
begin
//#UC START# *4F4CB81200CA_51499706003B_impl*
 with TevCEWHack(anEditor) do
  aCtx.rEngine.PushInt(LP2DP(l3PointX(WrapLimit)).X);
//#UC END# *4F4CB81200CA_51499706003B_impl*
end;//TkwPopEditorGetWrapLimit.DoWithEditor

class function TkwPopEditorGetWrapLimit.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:GetWrapLimit';
end;//TkwPopEditorGetWrapLimit.GetWordNameForRegister

initialization
 TkwPopEditorGetWrapLimit.RegisterInEngine;
 {* Регистрация pop_editor_GetWrapLimit }
{$IfEnd} // NOT Defined(NoScripts)

end.
