unit evOneCharLongIntList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

type
 TevOneCharLongIntList = class(Tl3ProtoDataContainer)
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//TevOneCharLongIntList
 
implementation

uses
 l3ImplUses
 , l3UnitsTools
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
