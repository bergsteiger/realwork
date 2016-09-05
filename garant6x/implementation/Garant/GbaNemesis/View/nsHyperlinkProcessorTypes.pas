unit nsHyperlinkProcessorTypes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsHyperlinkProcessorTypes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsHyperlinkProcessorTypes" MUID: (5418021C0216)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , NavigationInterfaces
;

type
 TnsProcessHyperLinkBehaviour = TbsProcessHyperLinkBehaviour;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *5418021C0216impl_uses*
 //#UC END# *5418021C0216impl_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
