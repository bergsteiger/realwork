unit kwPopControlScrollInfoMax;

interface

uses
 l3IntfUses
 , kwScrollInfoWord
 , tfwScriptingInterfaces
;

type
 TkwPopControlScrollInfoMax = class(TkwScrollInfoWord)
  procedure DoScrollInfo(const aCtx: TtfwContext);
 end;//TkwPopControlScrollInfoMax
 
implementation

uses
 l3ImplUses
;

end.
