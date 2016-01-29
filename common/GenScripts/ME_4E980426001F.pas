unit kwPopEditorSelectCellByMouse;

interface

uses
 l3IntfUses
 , kwEditorFromStackCursorWord
 , nevTools
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorSelectCellByMouse = class(TkwEditorFromStackCursorWord)
  {* editorSelectCellByMouse }
  procedure DoCursor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow;
   const aPoint: InevBasePoint);
 end;//TkwPopEditorSelectCellByMouse
 
implementation

uses
 l3ImplUses
 , Table_Const
 , evConst
 , l3Base
;

end.
