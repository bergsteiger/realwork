unit l3FourByteItemList.imp;

interface

uses
 l3IntfUses
;

type
 _l3FourByteItemList_ = class(_l3TypedList_)
  {* ������ ��������� �������� � 4 �����. }
  procedure DoExchange(var A: _ItemType_;
   var B: _ItemType_;
   anItems: _l3Items_);
   {* ������ �������� ������ �������. ��� ������ ��������. }
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
