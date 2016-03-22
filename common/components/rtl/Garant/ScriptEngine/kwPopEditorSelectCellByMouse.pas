unit kwPopEditorSelectCellByMouse;
 {* editorSelectCellByMouse }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCellByMouse.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_editor_SelectCellByMouse" MUID: (4E980426001F)
// Имя типа: "TkwPopEditorSelectCellByMouse"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackCursorWord
 , nevTools
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , l3Units
 , nevGUIInterfaces
;

type
 _CellSelectionByMouse_Parent_ = TkwEditorFromStackCursorWord;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CellSelectionByMouse.imp.pas}
 TkwPopEditorSelectCellByMouse = class(_CellSelectionByMouse_)
  {* editorSelectCellByMouse }
  private
   f_Row: Integer;
    {* Номер строки }
   f_Col: Integer;
    {* Номер колонки. }
   f_Table: InevParaList;
  protected
   procedure DoCursor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow;
    const aPoint: InevBasePoint); override;
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
    {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorSelectCellByMouse
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Table_Const
 , evConst
 , l3Base
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

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CellSelectionByMouse.imp.pas}

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
  RunnerAssert(l_Point <> nil, 'Курсор не в таблице.', aCtx);
 end; // while not f_Cursor.IsKindOf(k2_typTable) do
 f_Table := l_Point.Obj^.AsPara.AsList;
 if aCtx.rEngine.IsTopInt then
  f_Row := aCtx.rEngine.PopInt
 else
  RunnerError('Не задан номер строки!', aCtx);
 if aCtx.rEngine.IsTopInt then
  f_Col := aCtx.rEngine.PopInt
 else
  RunnerError('Не задан номер ячейки!', aCtx);
 SelectCell(anEditor);
 f_Table := nil;
//#UC END# *50B8BCDF0093_4E980426001F_impl*
end;//TkwPopEditorSelectCellByMouse.DoCursor

function TkwPopEditorSelectCellByMouse.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
//#UC START# *4BF4E6A00093_4E980426001F_var*
//#UC END# *4BF4E6A00093_4E980426001F_var*
begin
//#UC START# *4BF4E6A00093_4E980426001F_impl*
 Result := f_Table.Para[f_Row].AsList.Para[f_Col];
//#UC END# *4BF4E6A00093_4E980426001F_impl*
end;//TkwPopEditorSelectCellByMouse.GetInnerPara

class function TkwPopEditorSelectCellByMouse.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:SelectCellByMouse';
end;//TkwPopEditorSelectCellByMouse.GetWordNameForRegister

initialization
 TkwPopEditorSelectCellByMouse.RegisterInEngine;
 {* Регистрация pop_editor_SelectCellByMouse }
{$IfEnd} // NOT Defined(NoScripts)

end.
