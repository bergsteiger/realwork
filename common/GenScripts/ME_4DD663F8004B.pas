unit kwPopEditorParaDown;

interface

uses
 l3IntfUses
 , kwEditorFromStackCursorWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
;

type
 TkwPopEditorParaDown = class(TkwEditorFromStackCursorWord)
  {* ��������� �� �������� ���� � ���������. pop:editor:ParaDown }
  procedure DoCursor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow;
   const aPoint: InevBasePoint);
 end;//TkwPopEditorParaDown
 
implementation

uses
 l3ImplUses
 , evMsgCode
 , evOp
;

end.
