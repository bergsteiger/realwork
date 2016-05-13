unit TtfwTypeRegistrator_Proxy;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\TtfwTypeRegistrator_Proxy.pas"
// Стереотип: "ClassProxy"
// Элемент модели: "TtfwTypeRegistrator" MUID: (572C98D2039D)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 //#UC START# *572C98D2039Dintf_uses*
 , TypInfo
 //, tfwTypeRegistrator
 //#UC END# *572C98D2039Dintf_uses*
;

//#UC START# *572C98D2039Dintf_code*
type
 TtfwTypeRegistrator = class
  public
   class function RegisterType(aTypeInfo: PTypeInfo): Boolean;
 end;//TtfwTypeRegistrator

 //TtfwTypeRegistrator = tfwTypeRegistrator.TtfwTypeRegistrator;
//#UC END# *572C98D2039Dintf_code*
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *572C98D2039Dimpl_uses*
 , tfwTypesForRegister
 //#UC END# *572C98D2039Dimpl_uses*
;

//#UC START# *572C98D2039Dimpl_code*
class function TtfwTypeRegistrator.RegisterType(aTypeInfo: PTypeInfo): Boolean;
begin
 TtfwTypesForRegister.RegisterType(aTypeInfo);
end;
//#UC END# *572C98D2039Dimpl_code*
{$IfEnd} // NOT Defined(NoScripts)

end.
