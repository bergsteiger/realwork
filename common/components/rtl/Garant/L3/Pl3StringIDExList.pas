unit Pl3StringIDExList;

// Модуль: "w:\common\components\rtl\Garant\L3\Pl3StringIDExList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TPl3StringIDExList" MUID: (4F9BD2A103C7)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3StringIDEx
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Pl3StringIDEx;
 _l3AtomicListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3AtomicListPrim.imp.pas}
 TPl3StringIDExList = class(_l3AtomicListPrim_)
 end;//TPl3StringIDExList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *4F9BD2A103C7impl_uses*
 //#UC END# *4F9BD2A103C7impl_uses*
;

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4F9BD2A103C7_var*
//#UC END# *47B99D4503A2_4F9BD2A103C7_var*
begin
//#UC START# *47B99D4503A2_4F9BD2A103C7_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4F9BD2A103C7_impl*
end;//CompareExistingItems

type _Instance_R_ = TPl3StringIDExList;

{$Include w:\common\components\rtl\Garant\L3\l3AtomicListPrim.imp.pas}

end.
