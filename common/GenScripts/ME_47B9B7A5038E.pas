unit k2PropSorter;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , k2Base
;

type
 Tk2PropSorter = class(_l3UncomparabeObjectRefList_)
  {* ����������� �������. }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//Tk2PropSorter
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
