unit kwPopEditorJumpToHyperlink;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorJumpToHyperlink = class(TkwEditorFromStackWord)
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorJumpToHyperlink
 
implementation

uses
 l3ImplUses
 , nevNavigation
 , afwNavigation
 , SysUtils
;

end.
