unit moWorkJournal;
 {* ������ ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moWorkJournal.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "WorkJournal" MUID: (4A811E460199)
// ��� ����: "Tmo_WorkJournal"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseWorkJournal_Module
;

type
 Tmo_WorkJournal = {final} class(TBaseWorkJournalModule)
  {* ������ ������ }
 end;//Tmo_WorkJournal
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
