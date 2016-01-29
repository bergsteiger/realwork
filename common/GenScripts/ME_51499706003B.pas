unit kwPopEditorGetWrapLimit;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorGetWrapLimit = class(TkwEditorFromStackWord)
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorGetWrapLimit
 
implementation

uses
 l3ImplUses
 , l3Units
;

type
 TevCEWHack = class(TevCustomEditorWindow)
 end;//TevCEWHack
 
end.
