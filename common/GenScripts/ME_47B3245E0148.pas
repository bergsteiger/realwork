unit l3Sortable.imp;

interface

uses
 l3IntfUses
 , l3Types
;

type
 PItemType = ^_ItemType_;
 
 _l3Sortable_ = class
  procedure Sort;
   {* ��������� ���������. }
  procedure SortInterval(aLo: Integer;
   aHi: Integer);
   {* ��������� �������� ���������. ������� ��������������� ��������� - �� �������. }
  function DoCompareItems(const A: _ItemType_;
   const B: _ItemType_;
   aSortIndex: Tl3SortIndex;
   aList: _l3Sortable_): Integer;
  procedure Swap(var I1: _ItemType_;
   var I2: _ItemType_);
   {* ������ �������� ��������� �������. �� ��������� ���������� ��������. }
  function DoGetSortIndex: Tl3SortIndex;
  procedure DoSetSortIndex(Value: Tl3SortIndex);
  function DoFindInsertionPlace(const aFindData: _ItemType_;
   out theIndex: Integer): Boolean;
   {* ���� ��������� ��������� �������� � ������. ���� �� ������� - ���������� ����� �������������� �������. }
  procedure Cleanup;
 end;//_l3Sortable_
 
implementation

uses
 l3ImplUses
;

end.
