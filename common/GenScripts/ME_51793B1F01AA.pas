unit kwPopControlScrollInfoPosition;

interface

uses
 l3IntfUses
 , kwScrollInfoWord
 , tfwScriptingInterfaces
;

type
 TkwPopControlScrollInfoPosition = class(TkwScrollInfoWord)
  procedure DoScrollInfo(const aCtx: TtfwContext);
 end;//TkwPopControlScrollInfoPosition
 
implementation

uses
 l3ImplUses
;

end.
