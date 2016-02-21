unit kwPopEditorCopyAndPaste2DocumentBottom;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCopyAndPaste2DocumentBottom.pas"
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
 _ClipboardOperations_Parent_ = TkwEditorFromStackWord;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas}
 TkwPopEditorCopyAndPaste2DocumentBottom = class(_ClipboardOperations_)
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorCopyAndPaste2DocumentBottom
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
 , evOp
 , l3InternalInterfaces
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas}

procedure TkwPopEditorCopyAndPaste2DocumentBottom.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4E2835DE00FD_var*
//#UC END# *4F4CB81200CA_4E2835DE00FD_var*
begin
//#UC START# *4F4CB81200CA_4E2835DE00FD_impl*
 CopyAndPaste2DocumentBottom(anEditor);
//#UC END# *4F4CB81200CA_4E2835DE00FD_impl*
end;//TkwPopEditorCopyAndPaste2DocumentBottom.DoWithEditor

class function TkwPopEditorCopyAndPaste2DocumentBottom.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:CopyAndPaste2DocumentBottom';
end;//TkwPopEditorCopyAndPaste2DocumentBottom.GetWordNameForRegister

initialization
 TkwPopEditorCopyAndPaste2DocumentBottom.RegisterInEngine;
 {* Регистрация pop_editor_CopyAndPaste2DocumentBottom }
{$IfEnd} // NOT Defined(NoScripts)

end.
