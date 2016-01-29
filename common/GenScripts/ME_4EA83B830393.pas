unit kwPopEditorParaUp;

interface

uses
 l3IntfUses
 , kwEditorFromStackCursorWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
;

type
 TkwPopEditorParaUp = class(TkwEditorFromStackCursorWord)
  {* Переходит на параграф вверх в редакторе. pop:editor:ParaUp }
  procedure DoCursor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow;
   const aPoint: InevBasePoint);
 end;//TkwPopEditorParaUp
 
implementation

uses
 l3ImplUses
 , evMsgCode
 , evOp
;

end.
