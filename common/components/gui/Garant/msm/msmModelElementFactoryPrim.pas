unit msmModelElementFactoryPrim;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElementFactoryPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelElementFactoryPrim" MUID: (57C021910000)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , msmModelElement
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TmsmModelElement;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TmsmModelElementFactoryPrim = class(_l3UncomparabeObjectRefList_)
  protected
   procedure InitFields; override;
 end;//TmsmModelElementFactoryPrim

implementation

uses
 l3ImplUses
 , l3PointerUtils
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57C021910000impl_uses*
 //#UC END# *57C021910000impl_uses*
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_57C021910000_var*
//#UC END# *47B2C42A0163_57C021910000_var*
begin
//#UC START# *47B2C42A0163_57C021910000_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_57C021910000_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_57C021910000_var*
//#UC END# *47B99D4503A2_57C021910000_var*
begin
//#UC START# *47B99D4503A2_57C021910000_impl*
 if (CI.rA^ = CI.rB^) then
  Result := 0
 else
  Result := l3ComparePointers(CI.rA.MainWord.GetRefForCompare, CI.rB.MainWord.GetRefForCompare);
//#UC END# *47B99D4503A2_57C021910000_impl*
end;//CompareExistingItems

type _Instance_R_ = TmsmModelElementFactoryPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

procedure TmsmModelElementFactoryPrim.InitFields;
//#UC START# *47A042E100E2_57C021910000_var*
//#UC END# *47A042E100E2_57C021910000_var*
begin
//#UC START# *47A042E100E2_57C021910000_impl*
 inherited;
 Sorted := true;
 Duplicates := l3_dupError;
//#UC END# *47A042E100E2_57C021910000_impl*
end;//TmsmModelElementFactoryPrim.InitFields

end.
