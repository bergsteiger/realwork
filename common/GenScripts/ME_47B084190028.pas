unit l3TypedList.imp;

interface

uses
 l3IntfUses
;

type
 _l3TypedList_ = class(_l3TypedListPrim_)
  {* ������ � ������������ ��������������� ������� ����������� � ���������� }
  procedure MoveItems(Dst: Integer;
   Src: Integer;
   aSize: Cardinal;
   aList: _l3Items_);
   {* ����������� ����� ������. }
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
