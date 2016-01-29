unit kwPopEditorSelectCellByMouse;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Everest"
// ������: "kwPopEditorSelectCellByMouse.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi::ScriptEngine$Everest::EditorFromStackKeyWords::pop_editor_SelectCellByMouse
//
// editorSelectCellByMouse
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  nevTools,
  kwEditorFromStackCursorWord,
  evCustomEditorWindow,
  l3Units,
  nevGUIInterfaces,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 _CellSelectionByMouse_Parent_ = TkwEditorFromStackCursorWord;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CellSelectionByMouse.imp.pas}
 TkwPopEditorSelectCellByMouse = {scriptword} class(_CellSelectionByMouse_)
  {* editorSelectCellByMouse }
 private
 // private fields
   f_Row : Integer;
    {* ����� ������}
   f_Col : Integer;
    {* ����� �������.}
   f_Table : InevParaList;
 protected
 // realized methods
   procedure DoCursor(const aCtx: TtfwContext;
     anEditor: TevCustomEditorWindow;
     const aPoint: InevBasePoint); override;
 protected
 // overridden protected methods
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
     {* ���������� ��������, ������������ �������� ����� �������������� ����� ��� ��������� }
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorSelectCellByMouse
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Table_Const,
  evConst,
  l3Base,
  evOp,
  CommentPara_Const,
  TextPara_Const
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CellSelectionByMouse.imp.pas}

// start class TkwPopEditorSelectCellByMouse

procedure TkwPopEditorSelectCellByMouse.DoCursor(const aCtx: TtfwContext;
  anEditor: TevCustomEditorWindow;
  const aPoint: InevBasePoint);
//#UC START# *50B8BCDF0093_4E980426001F_var*
var
 l_Point: InevBasePoint;
//#UC END# *50B8BCDF0093_4E980426001F_var*
begin
//#UC START# *50B8BCDF0093_4E980426001F_impl*
 l_Point := aPoint; 
 while not l_Point.AsObject.IsKindOf(k2_typTable) do
 begin
  l_Point := l_Point.Inner;
  RunnerAssert(l_Point <> nil, '������ �� � �������.', aCtx);
 end; // while not f_Cursor.IsKindOf(k2_typTable) do
 f_Table := l_Point.Obj^.AsPara.AsList;
 if aCtx.rEngine.IsTopInt then
  f_Row := aCtx.rEngine.PopInt
 else
  RunnerError('�� ����� ����� ������!', aCtx);
 if aCtx.rEngine.IsTopInt then
  f_Col := aCtx.rEngine.PopInt
 else
  RunnerError('�� ����� ����� ������!', aCtx);
 SelectCell(anEditor);
 f_Table := nil;
//#UC END# *50B8BCDF0093_4E980426001F_impl*
end;//TkwPopEditorSelectCellByMouse.DoCursor

function TkwPopEditorSelectCellByMouse.GetInnerPara(const aView: InevInputView;
  const aDocument: InevPara): InevPara;
//#UC START# *4BF4E6A00093_4E980426001F_var*
//#UC END# *4BF4E6A00093_4E980426001F_var*
begin
//#UC START# *4BF4E6A00093_4E980426001F_impl*
 Result := f_Table.Para[f_Row].AsList.Para[f_Col];
//#UC END# *4BF4E6A00093_4E980426001F_impl*
end;//TkwPopEditorSelectCellByMouse.GetInnerPara

class function TkwPopEditorSelectCellByMouse.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:editor:SelectCellByMouse';
end;//TkwPopEditorSelectCellByMouse.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_editor_SelectCellByMouse
 TkwPopEditorSelectCellByMouse.RegisterInEngine;
{$IfEnd} //not NoScripts

end.