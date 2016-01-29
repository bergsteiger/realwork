unit l3Searcher.imp;

interface

uses
 l3IntfUses
 , l3Types
;

type
 _l3Searcher_ = class
  {* ����� ������ �������� �� ��������� ��������. }
  function CompareItemWithData(const anItem: _ItemType_;
   const aData: _FindDataType_;
   aSortIndex: Tl3SortIndex;
   aList: _l3Searcher_): Integer;
   {* ���������� ������������ ������� � �������. }
  function FindData(const aFindData: _FindDataType_;
   out theIndex: Integer;
   aSortIndex: Tl3SortIndex): Boolean; overload;
   {* ���� � ������ ��������� ������. ���������� true ���� ������ �������, � � theIndex - ������ ��������� ��������, ���� ������ �� �������, �� theIndex ��������� �� �������������� ����� �������. }
 end;//_l3Searcher_
 
implementation

uses
 l3ImplUses
;

end.
