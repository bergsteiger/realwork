unit moDocumentListFromFile;
 {* ������ ���������� �� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moDocumentListFromFile.pas"
// ���������: "VCMUseCaseRealization"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDocumentListFromFile_Module
;

type
 Tmo_DocumentListFromFile = {final} class(TPrimDocumentListFromFileModule)
  {* ������ ���������� �� ����� }
 end;//Tmo_DocumentListFromFile
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
