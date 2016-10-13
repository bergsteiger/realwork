unit msmValuesForSelect;

// Модуль: "w:\common\components\gui\Garant\msm\msmValuesForSelect.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmValuesForSelect" MUID: (57FBBEFF00B7)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , msmModelElements
 , msmControllers
 , msmConcreteModels
;

type
 TmsmValueForSelect = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rElement: ImsmModelElement;
   rCaption: ImsmCaptionModel;
   rList: ImsmListLikeModel;
   rCurrentElement: ImsmModelElement;
 end;//TmsmValueForSelect

 _ItemType_ = TmsmValueForSelect;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TmsmValuesForSelect = class(_l3RecordListPrim_)
 end;//TmsmValuesForSelect

function TmsmValueForSelect_C(const anElement: ImsmModelElement): TmsmValueForSelect; overload;
function TmsmValueForSelect_C: TmsmValueForSelect; overload;

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57FBBEFF00B7impl_uses*
 //#UC END# *57FBBEFF00B7impl_uses*
;

function TmsmValueForSelect_C(const anElement: ImsmModelElement): TmsmValueForSelect;
//#UC START# *57FBBFD701E7_57FBBF4D0058_var*
//#UC END# *57FBBFD701E7_57FBBF4D0058_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *57FBBFD701E7_57FBBF4D0058_impl*
 Result.rElement := anElement;
//#UC END# *57FBBFD701E7_57FBBF4D0058_impl*
end;//TmsmValueForSelect_C

function TmsmValueForSelect_C: TmsmValueForSelect;
//#UC START# *57FBC27F0043_57FBBF4D0058_var*
//#UC END# *57FBC27F0043_57FBBF4D0058_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *57FBC27F0043_57FBBF4D0058_impl*
 Result := TmsmValueForSelect_C(nil);
//#UC END# *57FBC27F0043_57FBBF4D0058_impl*
end;//TmsmValueForSelect_C

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_57FBBEFF00B7_var*
//#UC END# *47B07CF403D0_57FBBEFF00B7_var*
begin
//#UC START# *47B07CF403D0_57FBBEFF00B7_impl*
 Result := false;
 Assert(false);
//#UC END# *47B07CF403D0_57FBBEFF00B7_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_57FBBEFF00B7_var*
//#UC END# *47B2C42A0163_57FBBEFF00B7_var*
begin
//#UC START# *47B2C42A0163_57FBBEFF00B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_57FBBEFF00B7_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_57FBBEFF00B7_var*
//#UC END# *47B99D4503A2_57FBBEFF00B7_var*
begin
//#UC START# *47B99D4503A2_57FBBEFF00B7_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_57FBBEFF00B7_impl*
end;//CompareExistingItems

type _Instance_R_ = TmsmValuesForSelect;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

end.
