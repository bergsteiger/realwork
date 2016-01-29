unit tfwIntegerConstantRegistrator;

interface

uses
 l3IntfUses
 , tfwInteger
;

type
 TtfwIntegerConstantRegistrator = class(TtfwInteger)
  procedure Register(const aName: AnsiString;
   aValue: Integer);
  procedure Create(aValue: Integer);
 end;//TtfwIntegerConstantRegistrator
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
