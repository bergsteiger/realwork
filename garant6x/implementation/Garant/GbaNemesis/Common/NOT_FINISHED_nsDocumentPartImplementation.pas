unit NOT_FINISHED_nsDocumentPartImplementation;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\NOT_FINISHED_nsDocumentPartImplementation.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 TnsDocumentPartImplementation = class
 end;//TnsDocumentPartImplementation
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
