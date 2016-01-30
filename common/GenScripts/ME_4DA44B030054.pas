unit moDocumentListFromFile;
 {* Список документов из файла }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moDocumentListFromFile.pas"
// Стереотип: "VCMUseCaseRealization"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDocumentListFromFile_Module
;

type
 Tmo_DocumentListFromFile = {final} class(TPrimDocumentListFromFileModule)
  {* Список документов из файла }
 end;//Tmo_DocumentListFromFile
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
