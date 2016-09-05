unit kwPopEditorParaHome;
 {* В начало параграфа }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaHome.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_editor_ParaHome" MUID: (4F73173A01D7)
// Имя типа: "TkwPopEditorParaHome"

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
 TkwPopEditorParaHome = {final} class(TkwEditorFromStackCursorWord)
  {* В начало параграфа }
  protected
   procedure DoCursor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow;
    const aPoint: InevBasePoint); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorParaHome
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
 //#UC START# *4F73173A01D7impl_uses*
 //#UC END# *4F73173A01D7impl_uses*
;

procedure TkwPopEditorParaHome.DoCursor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow;
 const aPoint: InevBasePoint);
//#UC START# *50B8BCDF0093_4F73173A01D7_var*
//#UC END# *50B8BCDF0093_4F73173A01D7_var*
begin
//#UC START# *50B8BCDF0093_4F73173A01D7_impl*
 aPoint.MostInner.Move(anEditor.View, ev_ocParaHome);
//#UC END# *50B8BCDF0093_4F73173A01D7_impl*
end;//TkwPopEditorParaHome.DoCursor

class function TkwPopEditorParaHome.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:ParaHome';
end;//TkwPopEditorParaHome.GetWordNameForRegister

initialization
 TkwPopEditorParaHome.RegisterInEngine;
 {* Регистрация pop_editor_ParaHome }
{$IfEnd} // NOT Defined(NoScripts)

end.
