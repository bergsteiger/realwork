unit moDocument;
 {* �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moDocument.pas"
// ���������: "VCMUseCaseRealization"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Document_Module
;

type
 Tmo_Document = {final} class(TDocumentModule)
  {* �������� }
 end;//Tmo_Document
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
