unit kwPopControlScrollInfoMin;

interface

uses
 l3IntfUses
 , kwScrollInfoWord
 , tfwScriptingInterfaces
;

type
 TkwPopControlScrollInfoMin = class(TkwScrollInfoWord)
  procedure DoScrollInfo(const aCtx: TtfwContext);
 end;//TkwPopControlScrollInfoMin
 
implementation

uses
 l3ImplUses
;

end.
