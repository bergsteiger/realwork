unit l3Items.imp;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Types
;

type
 PFindItemType = ^_ItemType_;
 
 CompareItemsRec = record
  {* ������ ��� ��������� ��������� ������. }
 end;//CompareItemsRec
 
 {$Define l3Items_NoChanging}
 
 {$Define l3Items_NoOwner}
 
 _l3Items_ = class(_l3Sortable_)
  {* ������ }
  procedure Delete(Index: Integer);
   {* ������� ������� � �������� Index. }
  procedure DoDelete(Index: Integer);
   {* ������� ������� � �������� Index. �� ��������� ���������� �������. }
  procedure MoveItems(Dst: Integer;
   Src: Integer;
   aSize: Cardinal;
   aList: _l3Items_);
   {* ����������� ����� ������. }
  procedure FillSlot(var aPlace: _ItemType_;
   const anItem: _ItemType_);
   {* ��������� ����� �������� ��� ���������. }
  procedure DirectInsert(anIndex: Integer;
   const aData: _ItemType_);
   {* ���������������� �������� ��������. ��� �������� ���������� �������. }
  procedure CheckSetItem(anIndex: Integer);
   {* ��������� ���������� ������� ��� �������. }
  procedure ReAllocList(NewCapacity: Integer;
   aList: _l3Items_);
   {* �������� �������� ������. }
  function GetCapacity(aList: _l3Items_): Integer;
  procedure BeforeAddToCache;
  procedure Release;
  procedure CheckIndex(Index: Integer);
   {* ��������� ���������� ������� � ��������� ����������, ���� �� ������������. }
  function ItemSlot(anIndex: Integer): PItemType;
  procedure DoExchange(var A: _ItemType_;
   var B: _ItemType_;
   anItems: _l3Items_);
   {* ������ �������� ������ �������. ��� ������ ��������. }
  procedure FillItem(var aPlace: _ItemType_;
   const anItem: _ItemType_;
   anItems: _l3Items_);
   {* ��������� ������� ������. }
  procedure FreeSlot(var aPlace: _ItemType_);
  procedure FreeItem(var aPlace: _ItemType_;
   aList: _l3Items_);
   {* ������� ������� ������ }
  function ExpandSize(aTargetSize: Integer): Integer;
  function GetEmpty: Boolean;
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
  procedure Exchange(I1: Integer;
   I2: Integer);
   {* ������ �������� ������ �������. ��������� ���������� �������. }
  function GetItemSlot(anIndex: Integer;
   aList: _l3Items_): PItemType;
  function IterateF(I1: Tl3Index;
   I2: Tl3Index;
   Action: Tl3IteratorAction): Integer;
  function IterateAllF(Action: Tl3IteratorAction): Integer;
  procedure BeforeFreeItem(var aPlace: _ItemType_);
   {* ����������� �������� �� ������������ �������� ������ }
  function DoCompareItems(const A: _ItemType_;
   const B: _ItemType_;
   aSortIndex: Tl3SortIndex;
   aList: _l3Sortable_): Integer;
  procedure Swap(var I1: _ItemType_;
   var I2: _ItemType_);
   {* ������ �������� ��������� �������. �� ��������� ���������� ��������. }
  function CompareItemWithData(const anItem: _ItemType_;
   const aData: _FindDataType_;
   aSortIndex: Tl3SortIndex;
   aList: _l3Searcher_): Integer;
   {* ���������� ������������ ������� � �������. }
 end;//_l3Items_
 
implementation

uses
 l3ImplUses
 , RTLConsts
;

end.
