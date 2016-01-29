unit kwMouseGetCursorPosition;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwMouseGetCursorPosition = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMouseGetCursorPosition
 
implementation

uses
 l3ImplUses
 , Windows
;

end.
