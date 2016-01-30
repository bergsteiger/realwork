unit moDocument;
 {* Документ }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moDocument.pas"
// Стереотип: "VCMUseCaseRealization"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Document_Module
;

type
 Tmo_Document = {final} class(TDocumentModule)
  {* Документ }
 end;//Tmo_Document
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
