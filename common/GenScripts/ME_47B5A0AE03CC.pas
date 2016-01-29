unit l3ObjectRefListPrim.imp;

interface

uses
 l3IntfUses
;

type
 _l3ObjectRefListPrim_ = class(_l3RefList_)
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
 end;//_l3ObjectRefListPrim_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
