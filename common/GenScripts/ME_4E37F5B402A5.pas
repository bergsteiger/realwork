unit kwEditorFromStackTableColumnResize;

interface

uses
 l3IntfUses
 , kwEditorFromStackCursorWord
 , nevTools
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwEditorFromStackTableColumnResize = class(TkwEditorFromStackCursorWord)
  {* Вспомогательное слово для изменение размера колонок таблиц }
  procedure DoCursor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow;
   const aPoint: InevBasePoint);
 end;//TkwEditorFromStackTableColumnResize
 
implementation

uses
 l3ImplUses
 , Table_Const
 , evConst
 , l3Base
;

end.
