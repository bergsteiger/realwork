unit kwStyleTableChanged;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwStyleTableChanged = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStyleTableChanged
 
implementation

uses
 l3ImplUses
 , evStyleTableSpy
;

end.
