unit moFilters;
 {* Фильтры }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moFilters.pas"
// Стереотип: "VCMUseCaseRealization"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Filters_Module
;

type
 Tmo_Filters = {final} class(TFiltersModule)
  {* Фильтры }
 end;//Tmo_Filters
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
