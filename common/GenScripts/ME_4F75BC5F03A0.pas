unit kwPopEditorJumpToHyperlink;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorJumpToHyperlink.pas"
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
 TkwPopEditorJumpToHyperlink = {final} class(TkwEditorFromStackWord)
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorJumpToHyperlink
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , nevNavigation
 , afwNavigation
 , SysUtils
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwPopEditorJumpToHyperlink.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4F75BC5F03A0_var*
var
 l_Hyperlink : IevHyperlink;
//#UC END# *4F4CB81200CA_4F75BC5F03A0_var*
begin
//#UC START# *4F4CB81200CA_4F75BC5F03A0_impl*
 if Supports(anEditor.Selection, IevHyperlink, l_Hyperlink) then
  if IevMonikerSink(anEditor).JumpTo([], l_Hyperlink As IevMoniker) then
   Exit;
 RunnerError('Не удалось перейти по гиперссылке', aCtx);
//#UC END# *4F4CB81200CA_4F75BC5F03A0_impl*
end;//TkwPopEditorJumpToHyperlink.DoWithEditor

class function TkwPopEditorJumpToHyperlink.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:JumpToHyperlink';
end;//TkwPopEditorJumpToHyperlink.GetWordNameForRegister

initialization
 TkwPopEditorJumpToHyperlink.RegisterInEngine;
 {* Регистрация pop_editor_JumpToHyperlink }
{$IfEnd} // NOT Defined(NoScripts)

end.
