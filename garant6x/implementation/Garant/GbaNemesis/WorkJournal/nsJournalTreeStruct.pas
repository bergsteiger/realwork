unit nsJournalTreeStruct;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\WorkJournal\nsJournalTreeStruct.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsJournalTreeStruct" MUID: (4A8260EC0099)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsDataResetTreeStruct
 , DynamicTreeUnit
;

type
 TnsJournalTreeStruct = class(TnsDataResetTreeStruct)
  protected
   function ReAqurieUnfilteredRoot: INodeBase; override;
 end;//TnsJournalTreeStruct
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
;

function TnsJournalTreeStruct.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_4A8260EC0099_var*
//#UC END# *48FF64F60078_4A8260EC0099_var*
begin
//#UC START# *48FF64F60078_4A8260EC0099_impl*
 defDataAdapter.NativeAdapter.MakeUserJournal.GetUserJornalTree(Result);
//#UC END# *48FF64F60078_4A8260EC0099_impl*
end;//TnsJournalTreeStruct.ReAqurieUnfilteredRoot
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
