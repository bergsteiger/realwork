unit moList;
 {* ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moList.pas"
// ���������: "VCMUseCaseRealization"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , List_Module
;

type
 Tmo_List = {final} class(TListModule)
  {* ������ }
 end;//Tmo_List
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
