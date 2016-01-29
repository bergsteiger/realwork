unit kwPopEditorSelectTable;

interface

uses
 l3IntfUses
 , kwEditorFromStackCursorWord
 , nevTools
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorSelectTable = class(TkwEditorFromStackCursorWord)
  procedure DoCursor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow;
   const aPoint: InevBasePoint);
 end;//TkwPopEditorSelectTable
 
implementation

uses
 l3ImplUses
 , Table_Const
 , evOp
 , evCursorTools
;

end.
