unit kwBlockResize;

interface

uses
 l3IntfUses
 , kwEditorFromStackCursorWord
 , tfwScriptingInterfaces
 , nevTools
 , evCustomEditorWindow
;

type
 TkwBlockResize = class(TkwEditorFromStackCursorWord)
  procedure CorrectBlockPoint(const aCtx: TtfwContext;
   var aMap: InevMap;
   var aCursor: InevBasePoint);
  procedure DoCursor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow;
   const aPoint: InevBasePoint);
 end;//TkwBlockResize
 
implementation

uses
 l3ImplUses
 , l3Units
 , nevGUIInterfaces
 , Classes
 , l3Base
 , Block_Const
;

end.
