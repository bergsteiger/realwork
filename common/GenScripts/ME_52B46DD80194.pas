unit kwValue;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , l3Interfaces
;

type
 TkwValue = class(TtfwWord)
  procedure Create(const aValue: TtfwStackValue);
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwValue
 
implementation

uses
 l3ImplUses
;

end.
