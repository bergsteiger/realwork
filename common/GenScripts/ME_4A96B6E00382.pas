unit moFolders;
 {* ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moFolders.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "Folders" MUID: (4A96B6E00382)
// ��� ����: "Tmo_Folders"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFolders_Module
;

type
 Tmo_Folders = {final} class(TPrimFoldersModule)
  {* ����� }
 end;//Tmo_Folders
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
 TtfwClassRef.Register(Tmo_Folders);
 {* ����������� Folders$UC }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
