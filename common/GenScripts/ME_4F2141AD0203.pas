unit kwBynameControlPush;

interface

uses
 l3IntfUses
 , kwControlWord
 , Controls
 , tfwScriptingInterfaces
 , Classes
 , TypInfo
;

type
 TkwBynameControlPush = class(TkwControlWord)
  procedure DoControl(aControl: TControl;
   const aCtx: TtfwContext);
 end;//TkwBynameControlPush
 
implementation

uses
 l3ImplUses
 , l3Except
;

end.
