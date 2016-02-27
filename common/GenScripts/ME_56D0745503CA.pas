unit TevLeafParaInterfaceFactory_Proxy;

// Модуль: "w:\common\components\rtl\Garant\EVD\TevLeafParaInterfaceFactory_Proxy.pas"
// Стереотип: "InterfaceFactoryProxy"

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 //#UC START# *56D0745503CAintf_uses*
 ,
 evLeafPara_InterfaceFactory
 //#UC END# *56D0745503CAintf_uses*
;

//#UC START# *56D0745503CAintf_code*
type
 TevLeafParaInterfaceFactory = evLeafPara_InterfaceFactory.TevLeafParaInterfaceFactory; 
//#UC END# *56D0745503CAintf_code*
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 //#UC START# *56D0745503CAimpl_uses*
 //#UC END# *56D0745503CAimpl_uses*
;

//#UC START# *56D0745503CAimpl_code*
//#UC END# *56D0745503CAimpl_code*
{$IfEnd} // Defined(k2ForEditor)

end.
