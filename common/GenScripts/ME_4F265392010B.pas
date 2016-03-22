unit kwPopEditorParaEndCoordsToScreen;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaEndCoordsToScreen.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_editor_ParaEndCoordsToScreen" MUID: (4F265392010B)
// Имя типа: "TkwPopEditorParaEndCoordsToScreen"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwParaCoordsToScreen
 , evCustomEditorWindow
 , l3Units
 , nevTools
 , tfwScriptingInterfaces
;

type
 TkwPopEditorParaEndCoordsToScreen = {final} class(TkwParaCoordsToScreen)
  private
   f_Editor: TevCustomEditorWindow;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* Возвращает точку, на которую нужно спозиционироваться. }
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorParaEndCoordsToScreen
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , nevControl
 , evMsgCode
 , evOp
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

procedure TkwPopEditorParaEndCoordsToScreen.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4F265392010B_var*
//#UC END# *479731C50290_4F265392010B_var*
begin
//#UC START# *479731C50290_4F265392010B_impl*
 f_Editor := nil;
 inherited;
//#UC END# *479731C50290_4F265392010B_impl*
end;//TkwPopEditorParaEndCoordsToScreen.Cleanup

function TkwPopEditorParaEndCoordsToScreen.GetPoint(const aMap: InevMap): Tl3Point;
 {* Возвращает точку, на которую нужно спозиционироваться. }
//#UC START# *4C3C927B027E_4F265392010B_var*
var
 l_DeltaX: Integer;
//#UC END# *4C3C927B027E_4F265392010B_var*
begin
//#UC START# *4C3C927B027E_4F265392010B_impl*
 l_DeltaX := f_Point.DeltaX(f_Editor.View, f_Editor.View.RootMap);
 Result := l3Point(l_DeltaX, aMap.Bounds.Bottom);
//#UC END# *4C3C927B027E_4F265392010B_impl*
end;//TkwPopEditorParaEndCoordsToScreen.GetPoint

procedure TkwPopEditorParaEndCoordsToScreen.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4F265392010B_var*
var
 l_l3Pt: Tl3Point;
 l_EditorCorner: TPoint;
 
 l_Map: InevMap;
 l_Para: InevPara;
 l_Op: InevOp;
 
 l_Indent, l_DeltaX: Integer;
//#UC END# *4F4CB81200CA_4F265392010B_var*
begin
//#UC START# *4F4CB81200CA_4F265392010B_impl*
 f_Editor := anEditor;
 
 try
  l_Op := f_Editor.StartOp(ev_msgMove);
  try
   f_Point := f_Editor.Selection.Cursor.ClonePoint(f_Editor.View);
   f_Point.MostInner.Move(f_Editor.View, ev_ocBottomRight, l_Op);
  finally
   l_Op := nil;
  end;

  l_EditorCorner := f_Editor.ClientToScreen(Point(0, 0));

  l_l3Pt := TranslatePara2Point(f_Editor);
  with TPoint(TnevControlFriend(f_Editor).LP2DP(l_l3Pt)) do
  begin
   aCtx.rEngine.PushInt(l_EditorCorner.X + X);
   aCtx.rEngine.PushInt(l_EditorCorner.Y + Y);
  end;
 finally
  f_Point := nil;
 end;
//#UC END# *4F4CB81200CA_4F265392010B_impl*
end;//TkwPopEditorParaEndCoordsToScreen.DoWithEditor

class function TkwPopEditorParaEndCoordsToScreen.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:ParaEndCoordsToScreen';
end;//TkwPopEditorParaEndCoordsToScreen.GetWordNameForRegister

initialization
 TkwPopEditorParaEndCoordsToScreen.RegisterInEngine;
 {* Регистрация pop_editor_ParaEndCoordsToScreen }
{$IfEnd} // NOT Defined(NoScripts)

end.
