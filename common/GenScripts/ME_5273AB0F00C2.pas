unit k2TypesByHandleList;

// Модуль: "w:\common\components\rtl\Garant\K2\k2TypesByHandleList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , k2Base
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

 {$Define l3Items_NoSort}

type
 _ItemType_ = Tk2Type;
 _l3UnrefcountedList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UnrefcountedList.imp.pas}
 _l3OpenArray_Parent_ = _l3UnrefcountedList_;
 {$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}
 Tk2TypesByHandleList = class(_l3OpenArray_)
 end;//Tk2TypesByHandleList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_5273AB0F00C2_var*
//#UC END# *47B99D4503A2_5273AB0F00C2_var*
begin
//#UC START# *47B99D4503A2_5273AB0F00C2_impl*
 Assert(false);
 Result := -1;
//#UC END# *47B99D4503A2_5273AB0F00C2_impl*
end;//CompareExistingItems

type _Instance_R_ = Tk2TypesByHandleList;

{$Include w:\common\components\rtl\Garant\L3\l3UnrefcountedList.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}

end.
