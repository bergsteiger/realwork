unit kwMedianBacket;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwMedianBacket = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMedianBacket
 
implementation

uses
 l3ImplUses
;

end.
