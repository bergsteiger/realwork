unit l3AtomicList.imp;

interface

uses
 l3IntfUses
;

type
 _l3AtomicList_ = class(_l3AtomicListPrim_)
  {* ������ ��������� ���������, ��� ������� �������� ������ � ���������� �������� ����� }
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//_l3AtomicList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
