unit NOT_FINISHED_fstList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\NOT_FINISHED_fstList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TfstList" MUID: (57691A62014A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 TfstList = class
 end;//TfstList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
