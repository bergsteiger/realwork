unit ddCellsPropertyList;

// Модуль: "w:\common\components\rtl\Garant\dd\ddCellsPropertyList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddCellsPropertyList" MUID: (5189EB3F0246)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddCellProperty
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TddCellProperty;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TddCellsPropertyList = class(_l3UncomparabeObjectRefList_)
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//TddCellsPropertyList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *5189EB3F0246impl_uses*
 //#UC END# *5189EB3F0246impl_uses*
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5189EB3F0246_var*
//#UC END# *47B2C42A0163_5189EB3F0246_var*
begin
//#UC START# *47B2C42A0163_5189EB3F0246_impl*
 Assert(False);
//#UC END# *47B2C42A0163_5189EB3F0246_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_5189EB3F0246_var*
//#UC END# *47B99D4503A2_5189EB3F0246_var*
begin
//#UC START# *47B99D4503A2_5189EB3F0246_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_5189EB3F0246_impl*
end;//CompareExistingItems

type _Instance_R_ = TddCellsPropertyList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

{$If NOT Defined(DesignTimeLibrary)}
class function TddCellsPropertyList.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_5189EB3F0246_var*
//#UC END# *47A6FEE600FC_5189EB3F0246_var*
begin
//#UC START# *47A6FEE600FC_5189EB3F0246_impl*
 Result := True;
//#UC END# *47A6FEE600FC_5189EB3F0246_impl*
end;//TddCellsPropertyList.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
