unit moBaseSearch;
 {* ������� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moBaseSearch.pas"
// ���������: "VCMUseCaseRealization"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseSearch_Module
;

type
 Tmo_BaseSearch = {final} class(TBaseSearchModule)
  {* ������� ����� }
 end;//Tmo_BaseSearch
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
