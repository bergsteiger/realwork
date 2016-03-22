unit TevSectionBreakInterfaceFactory_Proxy;

// Модуль: "w:\common\components\rtl\Garant\EVD\TevSectionBreakInterfaceFactory_Proxy.pas"
// Стереотип: "InterfaceFactoryProxy"
// Элемент модели: "TevSectionBreakInterfaceFactory" MUID: (56D0747401E4)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 //#UC START# *56D0747401E4intf_uses*
 ,
 evSectionBreak_InterfaceFactory
 //#UC END# *56D0747401E4intf_uses*
;

//#UC START# *56D0747401E4intf_code*
type
 TevSectionBreakInterfaceFactory = evSectionBreak_InterfaceFactory.TevSectionBreakInterfaceFactory;
//#UC END# *56D0747401E4intf_code*
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 //#UC START# *56D0747401E4impl_uses*
 //#UC END# *56D0747401E4impl_uses*
;

//#UC START# *56D0747401E4impl_code*
//#UC END# *56D0747401E4impl_code*
{$IfEnd} // Defined(k2ForEditor)

end.
