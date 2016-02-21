unit kwPopEditorParaEnd;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaEnd.pas"
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
 TkwPopEditorParaEnd = {final} class(TkwEditorFromStackCursorWord)
  protected
   procedure DoCursor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow;
    const aPoint: InevBasePoint); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorParaEnd
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
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

procedure TkwPopEditorParaEnd.DoCursor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow;
 const aPoint: InevBasePoint);
//#UC START# *50B8BCDF0093_4F732C5C00BD_var*
//#UC END# *50B8BCDF0093_4F732C5C00BD_var*
begin
//#UC START# *50B8BCDF0093_4F732C5C00BD_impl*
 aPoint.MostInner.Move(anEditor.View, ev_ocParaEnd);
//#UC END# *50B8BCDF0093_4F732C5C00BD_impl*
end;//TkwPopEditorParaEnd.DoCursor

class function TkwPopEditorParaEnd.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:ParaEnd';
end;//TkwPopEditorParaEnd.GetWordNameForRegister

initialization
 TkwPopEditorParaEnd.RegisterInEngine;
 {* Регистрация pop_editor_ParaEnd }
{$IfEnd} // NOT Defined(NoScripts)

end.
