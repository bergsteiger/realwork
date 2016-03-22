unit kwEditorFromStackTextParaWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackTextParaWord.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwEditorFromStackTextParaWord" MUID: (50BA0B820089)

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
 TkwEditorFromStackTextParaWord = {abstract} class(TkwEditorFromStackCursorWord)
  protected
   procedure DoPara(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow;
    const aPara: InevPara); virtual; abstract;
   procedure DoCursor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow;
    const aPoint: InevBasePoint); override;
 end;//TkwEditorFromStackTextParaWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , LeafPara_Const
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

procedure TkwEditorFromStackTextParaWord.DoCursor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow;
 const aPoint: InevBasePoint);
//#UC START# *50B8BCDF0093_50BA0B820089_var*
var
 l_P : InevBasePoint;
 l_O : InevPara;
//#UC END# *50B8BCDF0093_50BA0B820089_var*
begin
//#UC START# *50B8BCDF0093_50BA0B820089_impl*
 l_P := aPoint.MostInner;
 if not l_P.Obj.AsObject.QT(InevPara, l_O) then
  RunnerError('', aCtx);
 RunnerAssert(l_O.AsObject.IsKindOf(k2_typLeafPara), '', aCtx);
 DoPara(aCtx, anEditor, l_O);
//#UC END# *50B8BCDF0093_50BA0B820089_impl*
end;//TkwEditorFromStackTextParaWord.DoCursor

initialization
 TkwEditorFromStackTextParaWord.RegisterClass;
 {* Регистрация TkwEditorFromStackTextParaWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
