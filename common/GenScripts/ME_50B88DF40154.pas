unit kwEditorFromStackCursorWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackCursorWord.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
;

type
 _kwEditorFromStackCursorWordUses_Parent_ = TkwEditorFromStackWord;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackCursorWordUses.imp.pas}
 TkwEditorFromStackCursorWord = {abstract} class(_kwEditorFromStackCursorWordUses_)
  protected
   procedure DoCursor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow;
    const aPoint: InevBasePoint); virtual; abstract;
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
 end;//TkwEditorFromStackCursorWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TextPara_Const
 , CommentPara_Const
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , evOp
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackCursorWordUses.imp.pas}

procedure TkwEditorFromStackCursorWord.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_50B88DF40154_var*
//#UC END# *4F4CB81200CA_50B88DF40154_var*
begin
//#UC START# *4F4CB81200CA_50B88DF40154_impl*
 RunnerAssert(anEditor.Selection <> nil, '', aCtx);
 RunnerAssert(anEditor.Selection.Cursor <> nil, '', aCtx);
 DoCursor(aCtx, anEditor, anEditor.Selection.Cursor);
//#UC END# *4F4CB81200CA_50B88DF40154_impl*
end;//TkwEditorFromStackCursorWord.DoWithEditor

initialization
 TkwEditorFromStackCursorWord.RegisterClass;
 {* Регистрация TkwEditorFromStackCursorWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
