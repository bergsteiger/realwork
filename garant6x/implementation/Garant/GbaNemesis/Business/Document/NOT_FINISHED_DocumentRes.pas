unit NOT_FINISHED_DocumentRes;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\NOT_FINISHED_DocumentRes.pas"
// ���������: "UtilityPack"
// ������� ������: "DocumentRes" MUID: (49256C760276)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Classes
;

type
 TnsDocumentRes = class(TDataModule)
 end;//TnsDocumentRes

procedure nsDocumentRes;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure nsDocumentRes;
//#UC START# *49256C990052_49256C760276_var*
//#UC END# *49256C990052_49256C760276_var*
begin
//#UC START# *49256C990052_49256C760276_impl*
 !!! Needs to be implemented !!!
//#UC END# *49256C990052_49256C760276_impl*
end;//nsDocumentRes

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnsDocumentRes);
 {* ����������� TnsDocumentRes }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
