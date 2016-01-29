unit tfwStringToEnumValue;

interface

uses
 l3IntfUses
 , tfwRegisterableWordPrim
 , TypInfo
 , tfwScriptingInterfaces
;

type
 TtfwStringToEnumValue = class(TtfwRegisterableWordPrim)
  procedure Register(aTypeInfo: PTypeInfo);
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TtfwStringToEnumValue
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
