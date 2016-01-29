unit kwCheckEtalon;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwCheckEtalon = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCheckEtalon
 
implementation

uses
 l3ImplUses
;

end.
