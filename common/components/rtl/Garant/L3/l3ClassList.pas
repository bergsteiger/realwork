unit l3ClassList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ClassList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3ClassList" MUID: (4773DC1E01B4)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

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
;

type
 _ItemType_ = TClass;
 _l3UnrefcountedList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UnrefcountedList.imp.pas}
 Tl3ClassList = class(_l3UnrefcountedList_)
 end;//Tl3ClassList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *4773DC1E01B4impl_uses*
 //#UC END# *4773DC1E01B4impl_uses*
;

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4773DC1E01B4_var*
//#UC END# *47B99D4503A2_4773DC1E01B4_var*
begin
//#UC START# *47B99D4503A2_4773DC1E01B4_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := Integer(CI.rA^) - Integer(CI.rB^);
//#UC END# *47B99D4503A2_4773DC1E01B4_impl*
end;//CompareExistingItems

type _Instance_R_ = Tl3ClassList;

{$Include w:\common\components\rtl\Garant\L3\l3UnrefcountedList.imp.pas}

end.
