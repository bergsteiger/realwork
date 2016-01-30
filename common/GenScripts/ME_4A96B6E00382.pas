unit moFolders;
 {* Папки }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moFolders.pas"
// Стереотип: "VCMUseCaseRealization"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFolders_Module
;

type
 Tmo_Folders = {final} class(TPrimFoldersModule)
  {* Папки }
 end;//Tmo_Folders
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
