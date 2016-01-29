unit kwInteger;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , TypInfo
 , l3Interfaces
;

type
 TkwInteger = class(TtfwWord)
  {* Зарезервированное слово Interger }
  procedure Create(aValue: Integer);
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwInteger
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
