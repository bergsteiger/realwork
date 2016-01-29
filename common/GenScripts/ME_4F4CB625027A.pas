unit kwEditorFromStackWord;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , Controls
;

type
 TkwEditorFromStackWord = class(_kwControlFromStackWord_)
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
  procedure DoControl(aControl: TControl;
   const aCtx: TtfwContext);
 end;//TkwEditorFromStackWord
 
implementation

uses
 l3ImplUses
;

end.
