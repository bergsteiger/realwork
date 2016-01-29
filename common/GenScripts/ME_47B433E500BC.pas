unit l3UntypedList.imp;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Types
;

type
 VOID = record
  {* ����������� ���, ���������� void � C++. }
 end;//VOID
 
 {$Define l3Items_FillItem_NeedsList}
 
 {$Define l3Items_CompareItemsRec_NeedsRList}
 
 _l3UntypedList_ = class(_l3Items_)
  procedure Clear;
   {* ������� ������. }
  function DoCompare(A;
   B;
   DataSize: Cardinal): Integer;
   {* ���������� ��������. }
  function Iterate(aLo: Tl3Index;
   aHi: Tl3Index;
   Action: Tl3IteratorAction): Integer;
   {* ���������� ��� �������� ��������� � aLo �� aHi. }
  function IterateAll(Action: Tl3IteratorAction): Integer;
   {* ���������� ��� �������� ���������. }
  procedure DoInsert(anIndex: Integer;
   aData);
  function DoAdd(aData): Integer;
  function Add(aData): Integer;
  function Find(aData;
   out theIndex: Integer): Boolean;
   {* ������� ������, ��� ������ �������� �������� ���������. }
  procedure Insert(anIndex: Integer;
   aData);
  procedure MoveItems(Dst: Integer;
   Src: Integer;
   aSize: Cardinal;
   aList: _l3Items_);
   {* ����������� ����� ������. }
  procedure ReAllocList(NewCapacity: Integer;
   aList: _l3Items_);
   {* �������� �������� ������. }
  function GetCapacity(aList: _l3Items_): Integer;
  procedure DoExchange(var A: _ItemType_;
   var B: _ItemType_;
   anItems: _l3Items_);
   {* ������ �������� ������ �������. ��� ������ ��������. }
  procedure FillItem(var aPlace: _ItemType_;
   const anItem: _ItemType_;
   anItems: _l3Items_);
   {* ��������� ������� ������. }
  procedure FreeItem(var aPlace: _ItemType_;
   aList: _l3Items_);
   {* ������� ������� ������ }
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
  function GetItemSlot(anIndex: Integer;
   aList: _l3Items_): PItemType;
  function Count: Integer;
   {* ����� ���������. }
 end;//_l3UntypedList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , RTLConsts
 , SysUtils
 , l3MinMax
;

end.
