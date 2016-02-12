unit ncsPriorityMessageList;
 {* Список сортированый по приоритету и дате сообщения }

// Модуль: "w:\common\components\rtl\Garant\cs\ncsPriorityMessageList.pas"
// Стереотип: "SimpleClass"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , ncsMessage
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TncsMessage;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TncsPriorityMessageList = class(_l3UncomparabeObjectRefList_)
  {* Список сортированый по приоритету и дате сообщения }
 end;//TncsPriorityMessageList
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , Math
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_544F977F036B_var*
//#UC END# *47B2C42A0163_544F977F036B_var*
begin
//#UC START# *47B2C42A0163_544F977F036B_impl*
 Assert(False);
//#UC END# *47B2C42A0163_544F977F036B_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_544F977F036B_var*
//#UC END# *47B99D4503A2_544F977F036B_var*
begin
//#UC START# *47B99D4503A2_544F977F036B_impl*
 Assert(False);


{ if CI.rA.Priority > CI.rB.Priority then
  Result := 1
 else
  if CI.rA.Priority < CI.rB.Priority then
   Result := -1
  else}
   Result := Sign(CI.rA.TimeStamp - CI.rB.TimeStamp);
 if Result = 0 then
   Result := Sign(Ord(CI.rB.Kind) - Ord(CI.rA.Kind));
 if Result = 0 then
  Result := AnsiCompareText(CI.rA.MessageID, CI.rB.MessageID);
//#UC END# *47B99D4503A2_544F977F036B_impl*
end;//CompareExistingItems

type _Instance_R_ = TncsPriorityMessageList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(Nemesis)

end.
