unit WorkWithList_ListOperations_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkWithList_ListOperations_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "ListOperations" MUID: (4C371629008F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 // List

 // CRList

 // WarnListFiltered

 // Reminder

 // List

 // DocumentInList

 // SelectedDocuments
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
