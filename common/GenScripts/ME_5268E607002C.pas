unit ddSubsList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddSub
;

type
 TddSubsList = class(_l3UncomparabeObjectRefList_)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//TddSubsList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
