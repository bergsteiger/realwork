unit moSearch;
 {* Поиск }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moSearch.pas"
// Стереотип: "VCMUseCaseRealization"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Search_Module
;

type
 Tmo_Search = {final} class(TSearchModule)
  {* Поиск }
 end;//Tmo_Search
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
