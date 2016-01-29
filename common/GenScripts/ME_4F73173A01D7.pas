unit kwPopEditorParaHome;

interface

uses
 l3IntfUses
 , kwEditorFromStackCursorWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
;

type
 TkwPopEditorParaHome = class(TkwEditorFromStackCursorWord)
  {* В начало параграфа }
  procedure DoCursor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow;
   const aPoint: InevBasePoint);
 end;//TkwPopEditorParaHome
 
implementation

uses
 l3ImplUses
;

end.
