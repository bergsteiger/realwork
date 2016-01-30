unit moWorkJournal;
 {* Журнал работы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moWorkJournal.pas"
// Стереотип: "VCMUseCaseRealization"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseWorkJournal_Module
;

type
 Tmo_WorkJournal = {final} class(TBaseWorkJournalModule)
  {* Журнал работы }
 end;//Tmo_WorkJournal
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
