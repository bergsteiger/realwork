unit kwPopEditorSetCursorByPoint;
 {* editor:SetCursorByPoint }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSetCursorByPoint.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_editor_SetCursorByPoint" MUID: (4EA922390373)
// Имя типа: "TkwPopEditorSetCursorByPoint"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , nevTools
 , l3Units
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 _Para2Point_Parent_ = TkwEditorFromStackWord;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}
 TkwPopEditorSetCursorByPoint = class(_Para2Point_)
  {* editor:SetCursorByPoint }
  private
   f_Point: InevBasePoint;
   f_DeltaX: Integer;
   f_DeltaY: Integer;
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
    {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* Возвращает точку, на которую нужно спозиционироваться. }
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorSetCursorByPoint
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , nevGUIInterfaces
 , l3Base
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *4EA922390373impl_uses*
 //#UC END# *4EA922390373impl_uses*
;

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}

procedure TkwPopEditorSetCursorByPoint.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4EA922390373_var*
var
 l_Effect        : TevMouseEffect;
 l_Keys          : TevMouseState;
 l_l3Pt          : Tl3Point;
 l_EditorHotSpot : IevHotSpot;
//#UC END# *4F4CB81200CA_4EA922390373_var*
begin
//#UC START# *4F4CB81200CA_4EA922390373_impl*
 if aCtx.rEngine.IsTopInt then
  f_DeltaY := aCtx.rEngine.PopInt
 else
  RunnerError('Не задана дельта к координате Y.', aCtx);
 if aCtx.rEngine.IsTopInt then
  f_DeltaX := aCtx.rEngine.PopInt
 else
  RunnerError('Не задана дельта к координате X.', aCtx);
 f_Point := anEditor.Selection.Cursor;
 l_l3Pt := TranslatePara2Point(anEditor);
 l_EditorHotSpot := anEditor.HotSpotClass.Make(anEditor, nil);
 try
  l3FillChar(l_Effect, SizeOf(l_Effect), 0);
  l_Effect.rNeedAsyncLoop := True;
  l3FillChar(l_Keys, SizeOf(l_Keys), 0);
  l_Keys.rKeys := [];
  l_Keys.rInitialPoint := l_l3Pt;
  l_Keys.rPoint := l_l3Pt;
  l_EditorHotSpot.LButtonDown(anEditor.View, l_Keys, l_Effect);
  l_EditorHotSpot.LButtonUp(anEditor.View, l_Keys);
 finally
  l_EditorHotSpot := nil;
 end;
//#UC END# *4F4CB81200CA_4EA922390373_impl*
end;//TkwPopEditorSetCursorByPoint.DoWithEditor

function TkwPopEditorSetCursorByPoint.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
//#UC START# *4BF4E6A00093_4EA922390373_var*
//#UC END# *4BF4E6A00093_4EA922390373_var*
begin
//#UC START# *4BF4E6A00093_4EA922390373_impl*
 Result := f_Point.MostInner.Obj^.AsPara;
 f_Point := nil;
//#UC END# *4BF4E6A00093_4EA922390373_impl*
end;//TkwPopEditorSetCursorByPoint.GetInnerPara

function TkwPopEditorSetCursorByPoint.GetPoint(const aMap: InevMap): Tl3Point;
 {* Возвращает точку, на которую нужно спозиционироваться. }
//#UC START# *4C3C927B027E_4EA922390373_var*
//#UC END# *4C3C927B027E_4EA922390373_var*
begin
//#UC START# *4C3C927B027E_4EA922390373_impl*
 Result := l3Point(aMap.Bounds.Right - f_DeltaX, aMap.Bounds.Bottom - f_DeltaY);
//#UC END# *4C3C927B027E_4EA922390373_impl*
end;//TkwPopEditorSetCursorByPoint.GetPoint

class function TkwPopEditorSetCursorByPoint.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:SetCursorByPoint';
end;//TkwPopEditorSetCursorByPoint.GetWordNameForRegister

initialization
 TkwPopEditorSetCursorByPoint.RegisterInEngine;
 {* Регистрация pop_editor_SetCursorByPoint }
{$IfEnd} // NOT Defined(NoScripts)

end.
