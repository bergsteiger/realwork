unit kwStyleTableChanging;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwStyleTableChanging = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStyleTableChanging
 
implementation

uses
 l3ImplUses
 , evStyleTableSpy
;

end.
