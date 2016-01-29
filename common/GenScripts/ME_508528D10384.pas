unit tfwClassRef;

interface

uses
 l3IntfUses
 , tfwRegisterableWordPrim
 , tfwScriptingInterfaces
 , TypInfo
;

type
 TtfwClassRef = class(TtfwRegisterableWordPrim)
  procedure Create(aClass: TClass);
  function Register(aClass: TClass): Boolean; overload;
  procedure Register(const aClasses: array of TClass); overload;
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TtfwClassRef
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Except
 , l3Base
 , StrUtils
 , tfwTypeModifier
 , tfwScriptingTypes
 , tfwRTTIProperty
 , tfwEnumRegistrator
 , tfwTypeRegistrator
;

end.
