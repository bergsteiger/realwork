unit TevPageBreakInterfaceFactory_Proxy;

// Модуль: "w:\common\components\rtl\Garant\EVD\TevPageBreakInterfaceFactory_Proxy.pas"
// Стереотип: "InterfaceFactoryProxy"
// Элемент модели: "TevPageBreakInterfaceFactory" MUID: (56D0746502DC)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 //#UC START# *56D0746502DCintf_uses*
 ,
 evPageBreak_InterfaceFactory
 //#UC END# *56D0746502DCintf_uses*
;

//#UC START# *56D0746502DCintf_code*
type
 TevPageBreakInterfaceFactory = evPageBreak_InterfaceFactory.TevPageBreakInterfaceFactory; 
//#UC END# *56D0746502DCintf_code*
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 //#UC START# *56D0746502DCimpl_uses*
 //#UC END# *56D0746502DCimpl_uses*
;

//#UC START# *56D0746502DCimpl_code*
//#UC END# *56D0746502DCimpl_code*
{$IfEnd} // Defined(k2ForEditor)

end.
