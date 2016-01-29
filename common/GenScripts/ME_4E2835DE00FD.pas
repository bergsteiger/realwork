unit kwPopEditorCopyAndPaste2DocumentBottom;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorCopyAndPaste2DocumentBottom = class(TkwEditorFromStackWord)
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorCopyAndPaste2DocumentBottom
 
implementation

uses
 l3ImplUses
 , l3Base
 , evOp
 , l3InternalInterfaces
;

end.
