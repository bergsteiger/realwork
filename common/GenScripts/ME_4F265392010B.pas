unit kwPopEditorParaEndCoordsToScreen;

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
 TkwPopEditorParaEndCoordsToScreen = class(TkwParaCoordsToScreen)
 end;//TkwPopEditorParaEndCoordsToScreen
 
implementation

uses
 l3ImplUses
 , evMsgCode
 , evOp
;

type
 TnevControlFriend = class(TnevControl)
  {* Друг для TnevControl }
 end;//TnevControlFriend
 
end.
