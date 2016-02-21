unit tfwInterfaceRegistrator;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwInterfaceRegistrator.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TypInfo
;

type
 TtfwInterfaceRegistrator = class
  public
   class function RegisterInterface(aTypeInfo: PTypeInfo): Boolean;
 end;//TtfwInterfaceRegistrator
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwStringConstantRegistrator
 , l3String
 , tfwScriptingInterfaces
 , SysUtils
 , tfwTypeModifier
;

class function TtfwInterfaceRegistrator.RegisterInterface(aTypeInfo: PTypeInfo): Boolean;
//#UC START# *55311CD00337_55311C9F022C_var*
var
 l_TD : PTypeData;
//#UC END# *55311CD00337_55311C9F022C_var*
begin
//#UC START# *55311CD00337_55311C9F022C_impl*
 Result := false;
 Assert(aTypeInfo <> nil);
 Assert(aTypeInfo.Kind = tkInterface);
 l_TD := GetTypeData(aTypeInfo);
 Assert(l_TD <> nil);
 if (ifHasGuid in l_TD.IntfFlags) then
 begin
  Result := TtfwStringConstantRegistrator.Register('guid::' + aTypeInfo.Name, TtfwCStringFactory.C(GUIDtoString(l_TD.GUID)));
  TtfwTypeModifier.RegisterTypeModifier(aTypeInfo);
 end;//ifHasGuid in l_TD.IntfFlags
 if (l_TD.IntfParent <> nil) then
  RegisterInterface(l_TD.IntfParent^);
//#UC END# *55311CD00337_55311C9F022C_impl*
end;//TtfwInterfaceRegistrator.RegisterInterface
{$IfEnd} // NOT Defined(NoScripts)

end.
