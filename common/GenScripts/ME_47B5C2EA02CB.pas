unit l3FourByteItemList.imp;

interface

uses
 l3IntfUses
;

type
 _l3FourByteItemList_ = class(_l3TypedList_)
  {* Список элементов размером в 4 байта. }
  procedure DoExchange(var A: _ItemType_;
   var B: _ItemType_;
   anItems: _l3Items_);
   {* Меняет элементы списка местами. Без всяких проверок. }
 end;//_l3FourByteItemList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
