unit TevParaInterfaceFactory_Proxy;

// Модуль: "w:\common\components\rtl\Garant\EVD\TevParaInterfaceFactory_Proxy.pas"
// Стереотип: "InterfaceFactoryProxy"
// Элемент модели: "TevParaInterfaceFactory" MUID: (56D074460007)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 //#UC START# *56D074460007intf_uses*
 ,
 evPara_InterfaceFactory
 //#UC END# *56D074460007intf_uses*
;

//#UC START# *56D074460007intf_code*
type
 TevParaInterfaceFactory = evPara_InterfaceFactory.TevParaInterfaceFactory;
//#UC END# *56D074460007intf_code*
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 //#UC START# *56D074460007impl_uses*
 //#UC END# *56D074460007impl_uses*
;

//#UC START# *56D074460007impl_code*
//#UC END# *56D074460007impl_code*
{$IfEnd} // Defined(k2ForEditor)

end.
