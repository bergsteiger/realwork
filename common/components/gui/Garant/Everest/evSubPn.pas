unit evSubPn;

// Модуль: "w:\common\components\gui\Garant\Everest\evSubPn.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evSubPn" MUID: (547DC5BA0275)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evSubPanel
;

type
 TevSubPanel = evSubPanel.TevSubPanel;

 TevCustomSubPanel = evSubPanel.TevCustomSubPanel;

 TevCustomSubDescriptors = evSubPanel.TevCustomSubDescriptors;

 TevSubDescriptor = evSubPanel.TevSubDescriptor;

 TevSubLayerDescriptor = evSubPanel.TevSubLayerDescriptor;

 TevSubDescriptors = evSubPanel.TevSubDescriptors;

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *547DC5BA0275impl_uses*
 //#UC END# *547DC5BA0275impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevSubPanel));
 {* Регистрация типа TevSubPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevCustomSubPanel));
 {* Регистрация типа TevCustomSubPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevCustomSubDescriptors));
 {* Регистрация типа TevCustomSubDescriptors }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevSubDescriptor));
 {* Регистрация типа TevSubDescriptor }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevSubLayerDescriptor));
 {* Регистрация типа TevSubLayerDescriptor }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevSubDescriptors));
 {* Регистрация типа TevSubDescriptors }
{$IfEnd} // NOT Defined(NoScripts)

end.
