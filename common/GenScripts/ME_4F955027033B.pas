unit kwParaCoordsToScreen;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , nevTools
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevControl
;

type
 TkwParaCoordsToScreen = class(TkwEditorFromStackWord)
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwParaCoordsToScreen
 
implementation

uses
 l3ImplUses
 , Types
;

type
 TnevControlFriend = class(TnevControl)
  {* Друг для TnevControl }
 end;//TnevControlFriend
 
end.
