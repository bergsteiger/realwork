unit kwPopEditorSetCursorByPoint;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , nevTools
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , l3Units
;

type
 TkwPopEditorSetCursorByPoint = class(TkwEditorFromStackWord)
  {* editor:SetCursorByPoint }
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorSetCursorByPoint
 
implementation

uses
 l3ImplUses
 , nevGUIInterfaces
 , l3Base
;

end.
