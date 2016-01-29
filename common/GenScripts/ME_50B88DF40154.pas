unit kwEditorFromStackCursorWord;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
;

type
 TkwEditorFromStackCursorWord = class(TkwEditorFromStackWord)
  procedure DoCursor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow;
   const aPoint: InevBasePoint);
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwEditorFromStackCursorWord
 
implementation

uses
 l3ImplUses
 , TextPara_Const
 , CommentPara_Const
 , Windows
 , Controls
 , evParaTools
 , evOp
;

end.
