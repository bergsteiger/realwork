unit kwPopEditorParaDown;
 {* Переходит на параграф вниз в редакторе. pop:editor:ParaDown }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaDown.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackCursorWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
;

type
 TkwPopEditorParaDown = class(TkwEditorFromStackCursorWord)
  {* Переходит на параграф вниз в редакторе. pop:editor:ParaDown }
  protected
   procedure DoCursor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow;
    const aPoint: InevBasePoint); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorParaDown
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evMsgCode
 , evOp
 , CommentPara_Const
 , TextPara_Const
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwPopEditorParaDown.DoCursor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow;
 const aPoint: InevBasePoint);
//#UC START# *50B8BCDF0093_4DD663F8004B_var*
//#UC END# *50B8BCDF0093_4DD663F8004B_var*
begin
//#UC START# *50B8BCDF0093_4DD663F8004B_impl*
 aPoint.MostInner.ParentPoint.Move(anEditor.View, ev_ocParaDown);
//#UC END# *50B8BCDF0093_4DD663F8004B_impl*
end;//TkwPopEditorParaDown.DoCursor

class function TkwPopEditorParaDown.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:ParaDown';
end;//TkwPopEditorParaDown.GetWordNameForRegister

initialization
 TkwPopEditorParaDown.RegisterInEngine;
 {* Регистрация pop_editor_ParaDown }
{$IfEnd} // NOT Defined(NoScripts)

end.
