unit moFilters;
 {* ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moFilters.pas"
// ���������: "VCMUseCaseRealization"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Filters_Module
;

type
 Tmo_Filters = {final} class(TFiltersModule)
  {* ������� }
 end;//Tmo_Filters
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
