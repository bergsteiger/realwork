unit kwBlockResize;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwBlockResize.pas"
// ���������: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackCursorWord
 , tfwScriptingInterfaces
 , nevTools
 , evCustomEditorWindow
;

type
 TkwBlockResize = {abstract} class(TkwEditorFromStackCursorWord)
  protected
   procedure CorrectBlockPoint(const aCtx: TtfwContext;
    var aMap: InevMap;
    var aCursor: InevBasePoint); virtual; abstract;
   procedure DoCursor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow;
    const aPoint: InevBasePoint); override;
 end;//TkwBlockResize
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Units
 , nevGUIInterfaces
 , Classes
 , l3Base
 , Block_Const
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

procedure TkwBlockResize.DoCursor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow;
 const aPoint: InevBasePoint);
//#UC START# *50B8BCDF0093_514BFB250118_var*
var
 l_Map           : InevMap;
 l_Cursor        : InevBasePoint;
 l_HotSpot       : IevHotSpot;
 l_Effect        : TevMouseEffect;
 l_Keys          : TevMouseState;
 l_l3Pt          : Tl3Point;
 l_Delta         : Integer;
 l_State         : TevCursorState;
 l_HotSpotTester : InevHotSpotTester2;
//#UC END# *50B8BCDF0093_514BFB250118_var*
begin
//#UC START# *50B8BCDF0093_514BFB250118_impl*
 l_Cursor := aPoint.MostInner;
 anEditor.Invalidate;
 l_Map := anEditor.View.MapByPoint(l_Cursor);
 while not l_Cursor.AsObject.IsKindOf(k2_typBlock) do
 begin
  l_Map := l_Map.Outer as InevMap;
  l_Cursor := l_Cursor.ParentPoint;
 end; // while not l_Cursor.IsKindOf(k2_typBlock) do
 CorrectBlockPoint(aCtx, l_Map, l_Cursor);
 if aCtx.rEngine.IsTopBool then
  if aCtx.rEngine.PopBool then
   l_l3Pt := l3Point(l_Map.Bounds.Left + 500,  l_Map.Bounds.Top + 10)
  else
   l_l3Pt := l3Point(l_Map.Bounds.Left + 500,  l_Map.Bounds.Bottom - 10)
 else
  Assert(False, '�� ������ ����� ������� ��������!');
 l_Map := anEditor.View.RootMap;
 l_State.rInitialPoint := l_l3Pt;
 l_State.rPoint := l_l3Pt;
 l_State.rKeys := [];
 if anEditor.Document.AsObject.QT(InevHotSpotTester2, l_HotSpotTester, anEditor.TextSource.Processor) then
  l_HotSpotTester.GetAdvancedHotSpot(anEditor.View, l_State, aPoint, l_Map, l_HotSpot);
 if l_HotSpot <> nil then
 begin
  l3FillChar(l_Keys, SizeOf(l_Keys), 0);
  l_Effect.rNeedAsyncLoop := True;
  l_Keys.rKeys := [ssShift];
  l_Keys.rInitialPoint := l_l3Pt;
  l_Keys.rPoint := l_l3Pt;
  l_HotSpot.LButtonDown(anEditor.View, l_Keys, l_Effect);
  l_Keys.rInMove := true;
  if aCtx.rEngine.IsTopInt then
   l_Delta := aCtx.rEngine.PopInt
  else
   Assert(False, '�� ������ ������!');
  l_Keys.rPoint := l3Point(l_l3Pt.X, l_l3Pt.Y - l_Delta);
  l_HotSpot.MouseMove(anEditor.View, l_Keys);
  l_HotSpot.LButtonUp(anEditor.View, l_Keys);
 end;// if l_HotSpotTester.GetAdvancedHotSpot(anEditor.View,
//#UC END# *50B8BCDF0093_514BFB250118_impl*
end;//TkwBlockResize.DoCursor

initialization
 TkwBlockResize.RegisterClass;
 {* ����������� TkwBlockResize }
{$IfEnd} // NOT Defined(NoScripts)

end.
