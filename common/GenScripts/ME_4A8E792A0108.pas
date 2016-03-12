unit F1_Without_Usecases_System_Controls;
 {* "Системные" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\F1_Without_Usecases_System_Controls.pas"
// Стереотип: "VCMControls"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 // System

 // Fonts

 // Help

 // System

 // WarnOnControl

 // Reminder

 // Common
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
