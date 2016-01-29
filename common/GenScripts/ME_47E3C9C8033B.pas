unit k2OpRefList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , k2Op
;

type
 Tk2OpRefList = class(_l3UncomparabeObjectRefList_)
  {* ������ ��������. }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//Tk2OpRefList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
