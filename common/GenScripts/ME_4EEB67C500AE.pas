unit kwMouseGetCursorIndex;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwMouseGetCursorIndex = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMouseGetCursorIndex
 
implementation

uses
 l3ImplUses
 , Messages
 , Windows
 , Forms
 , Controls
;

end.
