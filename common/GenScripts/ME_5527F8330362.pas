unit tfwTypeRegistrator;

interface

uses
 l3IntfUses
 , TypInfo
;

type
 TtfwTypeRegistrator = class
  function RegisterType(aTypeInfo: PTypeInfo): Boolean;
  procedure RegisterColorValue(const aValue: AnsiString);
  procedure RegisterCharsetValue(const aValue: AnsiString);
 end;//TtfwTypeRegistrator
 
implementation

uses
 l3ImplUses
 , tfwEnumRegistrator
 , tfwClassRef
 , tfwInterfaceRegistrator
 , tfwTypeModifier
 , tfwEnumConstantRegistrator
 , Graphics
;

end.
