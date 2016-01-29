unit l3FrameLineList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3FrameLine
;

type
 Tl3FrameLineList = class(_l3UncomparabeObjectRefList_)
  {* ������ ������������� �����. }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//Tl3FrameLineList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
