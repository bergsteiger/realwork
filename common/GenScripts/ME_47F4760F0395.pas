unit NOT_FINISHED_ListRes;
 {* ������� ������. }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Business\List\NOT_FINISHED_ListRes.pas"
// ���������: "UtilityPack"
// ������� ������: "ListRes" MUID: (47F4760F0395)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Classes
;

type
 TnsListRes = class(TDataModule)
  {* ������� ������. }
 end;//TnsListRes
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
 TtfwClassRef.Register(TnsListRes);
 {* ����������� TnsListRes }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
