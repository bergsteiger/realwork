unit tfwInterfaceRegistrator;

interface

uses
 l3IntfUses
 , TypInfo
;

type
 TtfwInterfaceRegistrator = class
  function RegisterInterface(aTypeInfo: PTypeInfo): Boolean;
 end;//TtfwInterfaceRegistrator
 
implementation

uses
 l3ImplUses
 , tfwStringConstantRegistrator
 , l3String
 , tfwScriptingInterfaces
 , SysUtils
 , tfwTypeModifier
;

end.
