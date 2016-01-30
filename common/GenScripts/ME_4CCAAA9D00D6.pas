unit Filters_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters_Strange_Controls.pas"
// Стереотип: "VCMControls"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 // Activate

 // Edit

 // PersistentFilter

 // RenameFilter

 // Filter

 // New

 // Refresh

 // Filters

 // CreateFilter

 // Filter
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
