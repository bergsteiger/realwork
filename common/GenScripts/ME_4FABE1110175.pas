unit kwPopEditorCursorCoordsToScreen;

interface

uses
 l3IntfUses
 , kwParaCoordsToScreen
 , evCustomEditorWindow
 , l3Units
 , nevTools
 , tfwScriptingInterfaces
 , nevControl
;

type
 TkwPopEditorCursorCoordsToScreen = class(TkwParaCoordsToScreen)
 end;//TkwPopEditorCursorCoordsToScreen
 
implementation

uses
 l3ImplUses
;

type
 TnevControlFriend = class(TnevControl)
  {* ���� ��� TnevControl }
 end;//TnevControlFriend
 
end.
