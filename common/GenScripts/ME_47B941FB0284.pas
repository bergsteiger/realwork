unit l3PtrListPrim.imp;

interface

uses
 l3IntfUses
;

type
 _l3PtrListPrim_ = class(_l3StandardTypedList_)
  {* ������� ��� ������� ����������. ������ �� ��������� �������� ����� ���������. }
  procedure FreeItem(var aPlace: _ItemType_;
   aList: _l3Items_);
   {* ������� ������� ������ }
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
