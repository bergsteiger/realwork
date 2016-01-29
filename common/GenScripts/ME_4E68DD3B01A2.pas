unit kwPopEditorUpdateCursorFromHotSpotEx;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorUpdateCursorFromHotSpotEx = class(TkwEditorFromStackWord)
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorUpdateCursorFromHotSpotEx
 
implementation

uses
 l3ImplUses
;

type
 TevCustomEditorWindowHack = class(TevCustomEditorWindow)
 end;//TevCustomEditorWindowHack
 
end.
