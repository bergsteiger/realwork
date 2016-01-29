unit l3RecordListPrimPrim.imp;

interface

uses
 l3IntfUses
;

type
 _l3RecordListPrimPrim_ = class(_l3StandardMemTypedList_)
  procedure DoExchange(var A: _ItemType_;
   var B: _ItemType_;
   anItems: _l3Items_);
   {* ������ �������� ������ �������. ��� ������ ��������. }
  procedure FillItem(var aPlace: _ItemType_;
   const anItem: _ItemType_;
   anItems: _l3Items_);
   {* ��������� ������� ������. }
 end;//_l3RecordListPrimPrim_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
