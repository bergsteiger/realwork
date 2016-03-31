unit PrimWorkJournalInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\PrimWorkJournalInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "PrimWorkJournalInterfaces" MUID: (4D7A05A000C1)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
;

type
 InsWorkJournalListener = interface
  ['{730A7894-DD4B-4BB7-95EE-77F4E7C2EE79}']
  procedure JournalShrinked;
 end;//InsWorkJournalListener
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin)

end.
