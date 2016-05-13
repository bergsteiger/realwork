unit moBaseSearch;
 {* ������� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moBaseSearch.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "BaseSearch" MUID: (4CC97A9F0310)
// ��� ����: "Tmo_BaseSearch"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Tmo_BaseSearch);
 {* ����������� BaseSearch$UC }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
