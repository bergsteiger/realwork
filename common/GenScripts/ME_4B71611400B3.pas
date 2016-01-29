unit l3AtomicListPrim.imp;

interface

uses
 l3IntfUses
;

 {$Define l3Items_IsAtomic}
 
type
 _l3AtomicListPrim_ = class(_l3UnrefcountedList_)
  {* Список атомарных элементов }
 end;//_l3AtomicListPrim_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
