unit l3StandardMemTypedList.imp;

interface

uses
 l3IntfUses
 , l3Memory
;

type
 _l3StandardMemTypedList_ = class(_l3TypedList_)
  {* Типизированный список со стандартной функцией распределения памяти }
 end;//_l3StandardMemTypedList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
