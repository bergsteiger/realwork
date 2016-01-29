unit l3TypedList.imp;

interface

uses
 l3IntfUses
;

type
 _l3TypedList_ = class(_l3TypedListPrim_)
  {* Список с возможностью переопределения методов манипуляции с элементами }
  procedure MoveItems(Dst: Integer;
   Src: Integer;
   aSize: Cardinal;
   aList: _l3Items_);
   {* Передвигает кусок памяти. }
 end;//_l3TypedList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
