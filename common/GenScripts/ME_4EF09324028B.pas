unit kwMouseGetCursorNameByIndex;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwMouseGetCursorNameByIndex = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMouseGetCursorNameByIndex
 
implementation

uses
 l3ImplUses
 , Controls
;

end.
