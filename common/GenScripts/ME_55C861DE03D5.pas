unit tfwRTTIProperty;

interface

uses
 l3IntfUses
 , tfwRegisterableWordPrim
 , TypInfo
 , tfwScriptingInterfaces
 , tfwTypeInfo
;

type
 TtfwRTTIProperty = class(TtfwRegisterableWordPrim)
  procedure Register(aClass: TClass;
   aPropInfo: PPropInfo);
  procedure Create(aClass: TClass;
   aPropInfo: PPropInfo);
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TtfwRTTIProperty
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
;

end.
