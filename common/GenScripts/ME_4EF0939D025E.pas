unit kwMouseSetCursorPosition;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwMouseSetCursorPosition = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMouseSetCursorPosition
 
implementation

uses
 l3ImplUses
 , Windows
;

end.
