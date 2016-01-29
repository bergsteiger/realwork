unit kwPopControlScrollInfo;

interface

uses
 l3IntfUses
 , kwScrollInfoWord
 , tfwScriptingInterfaces
;

type
 TkwPopControlScrollInfo = class(TkwScrollInfoWord)
  procedure DoScrollInfo(const aCtx: TtfwContext);
 end;//TkwPopControlScrollInfo
 
implementation

uses
 l3ImplUses
;

end.
