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
  {* � ������ ��������� }
  procedure DoCursor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow;
   const aPoint: InevBasePoint);
 end;//TkwPopEditorParaHome
 
implementation

uses
 l3ImplUses
;

end.
