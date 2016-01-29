unit kwPopEditorCheckContinueCells;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorCheckContinueCells = class(TkwEditorFromStackWord)
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorCheckContinueCells
 
implementation

uses
 l3ImplUses
 , evTableSearch
 , evTypes
;

end.
