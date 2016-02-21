unit kwParaCoordsToScreen;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwParaCoordsToScreen.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , nevTools
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , l3Units
;

type
 _Para2Point_Parent_ = TkwEditorFromStackWord;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}
 _kwParaCoordsToScreenUses_Parent_ = _Para2Point_;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\kwParaCoordsToScreenUses.imp.pas}
 TkwParaCoordsToScreen = {abstract} class(_kwParaCoordsToScreenUses_)
  protected
   f_Point: InevBasePoint;
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
    {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
 end;//TkwParaCoordsToScreen
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , nevControl
 , Types
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TnevControlFriend = {abstract} class(TnevControl)
  {* Друг для TnevControl }
 end;//TnevControlFriend

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}

{$Include w:\common\components\rtl\Garant\ScriptEngine\kwParaCoordsToScreenUses.imp.pas}

procedure TkwParaCoordsToScreen.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4F955027033B_var*
var
 l_l3Pt: Tl3Point;
 l_EditorCorner: TPoint;
//#UC END# *4F4CB81200CA_4F955027033B_var*
begin
//#UC START# *4F4CB81200CA_4F955027033B_impl*
 l_EditorCorner := anEditor.ClientToScreen(Point(0, 0));

 f_Point := anEditor.Selection.Cursor;
 try
  l_l3Pt := TranslatePara2Point(anEditor);
  with TPoint(TnevControlFriend(anEditor).LP2DP(l_l3Pt)) do
  begin
   aCtx.rEngine.PushInt(l_EditorCorner.X + X);
   aCtx.rEngine.PushInt(l_EditorCorner.Y + Y);
  end;
 finally
  f_Point := nil;
 end;
//#UC END# *4F4CB81200CA_4F955027033B_impl*
end;//TkwParaCoordsToScreen.DoWithEditor

function TkwParaCoordsToScreen.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
//#UC START# *4BF4E6A00093_4F955027033B_var*
//#UC END# *4BF4E6A00093_4F955027033B_var*
begin
//#UC START# *4BF4E6A00093_4F955027033B_impl*
 Result := f_Point.MostInner.Obj^.AsPara;
//#UC END# *4BF4E6A00093_4F955027033B_impl*
end;//TkwParaCoordsToScreen.GetInnerPara

initialization
 TkwParaCoordsToScreen.RegisterClass;
 {* Регистрация TkwParaCoordsToScreen }
{$IfEnd} // NOT Defined(NoScripts)

end.
