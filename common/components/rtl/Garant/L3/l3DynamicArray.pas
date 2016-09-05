unit l3DynamicArray;
 {* Базовый класс для динамических массовов. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3DynamicArray.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3DynamicArray" MUID: (479DFD5300C5)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3Memory
 , l3Interfaces
 , l3Types
 , Classes
 , l3Except
;

 {$Define _l3Items_NeedsBeforeFreeItem}

type
 _DataType_ = Tl3Ptr;
 _l3UntypedList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UntypedList.imp.pas}
 Tl3DynamicArray = class(_l3UntypedList_)
  {* Базовый класс для динамических массовов. }
  protected
   function pm_GetItems(anIndex: Integer): Pointer;
  public
   property Items[anIndex: Integer]: Pointer
    read pm_GetItems;
    default;
 end;//Tl3DynamicArray

implementation

uses
 l3ImplUses
 , l3Base
 , RTLConsts
 , SysUtils
 , l3MinMax
 //#UC START# *479DFD5300C5impl_uses*
 //#UC END# *479DFD5300C5impl_uses*
;

type _Instance_R_ = Tl3DynamicArray;

{$Include w:\common\components\rtl\Garant\L3\l3UntypedList.imp.pas}

function Tl3DynamicArray.pm_GetItems(anIndex: Integer): Pointer;
//#UC START# *479DFDBE0123_479DFD5300C5get_var*
//#UC END# *479DFDBE0123_479DFD5300C5get_var*
begin
//#UC START# *479DFDBE0123_479DFD5300C5get_impl*
 Result := ItemSlot(anIndex);
//#UC END# *479DFDBE0123_479DFD5300C5get_impl*
end;//Tl3DynamicArray.pm_GetItems

end.
