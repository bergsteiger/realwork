unit tfwIntegerToEnumName;

interface

uses
 l3IntfUses
 , tfwRegisterableWordPrim
 , TypInfo
 , tfwScriptingInterfaces
;

type
 TtfwIntegerToEnumName = class(TtfwRegisterableWordPrim)
  procedure Register(aTypeInfo: PTypeInfo);
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TtfwIntegerToEnumName
 
implementation

uses
 l3ImplUses
 , SysUtils
 , tfwStringToEnumValue
;

end.
