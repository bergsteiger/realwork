unit NOT_FINISHED_nsPageSetup;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\NOT_FINISHED_nsPageSetup.pas"
// ���������: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , ConfigInterfaces
;

type
 TnsPageSetup = class
  private
   f_Metrics: TnsMetrics;
 end;//TnsPageSetup
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin)

end.
