unit l3RecordWithEQList.imp;

interface

uses
 l3IntfUses
;

type
 _l3RecordWithEQList_ = class(_l3RecordListPrim_)
  {* Список записей с операцией EQ }
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
 end;//_l3RecordWithEQList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
