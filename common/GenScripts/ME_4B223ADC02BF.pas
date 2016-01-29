unit l3RecordListPrim.imp;

interface

uses
 l3IntfUses
;

type
 _l3RecordListPrim_ = class(_l3RecordListPrimPrim_)
  {* Список записей }
  procedure FreeItem(var aPlace: _ItemType_;
   aList: _l3Items_);
   {* Очищает элемент списка }
 end;//_l3RecordListPrim_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
