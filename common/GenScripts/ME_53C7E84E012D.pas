unit tfwEnumRegistrator;

interface

uses
 l3IntfUses
 , TypInfo
;

type
 TtfwEnumRegistrator = class
  function RegisterEnum(aTypeInfo: PTypeInfo): Boolean;
 end;//TtfwEnumRegistrator
 
implementation

uses
 l3ImplUses
 , tfwEnumConstantRegistrator
 , tfwRegisteredEnums
 , tfwIntegerToEnumName
 , tfwTypeModifier
;

end.
