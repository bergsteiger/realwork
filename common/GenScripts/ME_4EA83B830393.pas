unit kwPopEditorParaUp;
 {* Переходит на параграф вверх в редакторе. pop:editor:ParaUp }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaUp.pas"
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
 TkwPopEditorParaUp = class(TkwEditorFromStackCursorWord)
  {* Переходит на параграф вверх в редакторе. pop:editor:ParaUp }
  protected
   procedure DoCursor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow;
    const aPoint: InevBasePoint); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorParaUp
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

procedure TkwPopEditorParaUp.DoCursor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow;
 const aPoint: InevBasePoint);
//#UC START# *50B8BCDF0093_4EA83B830393_var*
//#UC END# *50B8BCDF0093_4EA83B830393_var*
begin
//#UC START# *50B8BCDF0093_4EA83B830393_impl*
 aPoint.MostInner.ParentPoint.Move(anEditor.View, ev_ocParaUp);
//#UC END# *50B8BCDF0093_4EA83B830393_impl*
end;//TkwPopEditorParaUp.DoCursor

class function TkwPopEditorParaUp.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:ParaUp';
end;//TkwPopEditorParaUp.GetWordNameForRegister

initialization
 TkwPopEditorParaUp.RegisterInEngine;
 {* Регистрация pop_editor_ParaUp }
{$IfEnd} // NOT Defined(NoScripts)

end.
