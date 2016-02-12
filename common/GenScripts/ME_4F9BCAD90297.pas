unit Pl3MessageIDListPrim;

// Модуль: "w:\common\components\rtl\Garant\L3\Pl3MessageIDListPrim.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3MessageID
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Pl3MessageID;
 _l3AtomicListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3AtomicListPrim.imp.pas}
 TPl3MessageIDListPrim = class(_l3AtomicListPrim_)
 end;//TPl3MessageIDListPrim

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4F9BCAD90297_var*
//#UC END# *47B99D4503A2_4F9BCAD90297_var*
begin
//#UC START# *47B99D4503A2_4F9BCAD90297_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4F9BCAD90297_impl*
end;//CompareExistingItems

type _Instance_R_ = TPl3MessageIDListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3AtomicListPrim.imp.pas}

end.
