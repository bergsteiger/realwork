unit nsHyperlinkProcessorTypes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsHyperlinkProcessorTypes.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

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
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
