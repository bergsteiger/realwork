unit kwPopEditorUpdateCursorFromHotSpot;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorUpdateCursorFromHotSpot = class(TkwEditorFromStackWord)
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorUpdateCursorFromHotSpot
 
implementation

uses
 l3ImplUses
;

type
 TevCustomEditorWindowHack = class(TevCustomEditorWindow)
 end;//TevCustomEditorWindowHack
 
end.
