unit ddTaskItemList;

// Модуль: "w:\common\components\rtl\Garant\cs\ddTaskItemList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddServerTask
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

 {$Undef l3Items_NoSort}

type
 _ItemType_ = TddTaskItem;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TddTaskItemList = class(_l3UncomparabeObjectRefList_)
  protected
   procedure InitFields; override;
 end;//TddTaskItemList
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , StrUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_52FB5AEF0267_var*
//#UC END# *47B2C42A0163_52FB5AEF0267_var*
begin
//#UC START# *47B2C42A0163_52FB5AEF0267_impl*
 Assert(false);
//#UC END# *47B2C42A0163_52FB5AEF0267_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_52FB5AEF0267_var*
//#UC END# *47B99D4503A2_52FB5AEF0267_var*
begin
//#UC START# *47B99D4503A2_52FB5AEF0267_impl*
 Result := CompareText(CI.rA.TaskID, CI.rB.TaskID);
//#UC END# *47B99D4503A2_52FB5AEF0267_impl*
end;//CompareExistingItems

type _Instance_R_ = TddTaskItemList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

procedure TddTaskItemList.InitFields;
//#UC START# *47A042E100E2_52FB5AEF0267_var*
//#UC END# *47A042E100E2_52FB5AEF0267_var*
begin
//#UC START# *47A042E100E2_52FB5AEF0267_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_52FB5AEF0267_impl*
end;//TddTaskItemList.InitFields
{$IfEnd} // NOT Defined(Nemesis)

end.
