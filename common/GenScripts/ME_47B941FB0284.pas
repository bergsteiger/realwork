unit l3PtrListPrim.imp;

interface

uses
 l3IntfUses
;

type
 _l3PtrListPrim_ = class(_l3StandardTypedList_)
  {* Примесь для списков указателей. Список НЕ УПРАВЛЯЕТ временем жизни элементов. }
  procedure FreeItem(var aPlace: _ItemType_;
   aList: _l3Items_);
   {* Очищает элемент списка }
 end;//_l3PtrListPrim_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
