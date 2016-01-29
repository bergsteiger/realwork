unit kwPopEditorGetSelectionText;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorGetSelectionText = class(TkwEditorFromStackWord)
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorGetSelectionText
 
implementation

uses
 l3ImplUses
 , evParaTools
;

end.
