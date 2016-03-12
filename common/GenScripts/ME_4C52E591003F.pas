unit Inpharm_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm_Strange_Controls.pas"
// Стереотип: "VCMControls"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 // MedicListSynchroView

 // MedicFirmList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
