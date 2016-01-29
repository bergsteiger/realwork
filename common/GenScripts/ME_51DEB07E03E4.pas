unit List.imp;

interface

uses
 l3IntfUses
 , l3PtrLoc
;

type
 PItemType = ^_ItemType_;
 
 IndexType = Integer;
 
 _List_ = class(MRefCounted)
  {* ����������� ������ �������� }
  procedure ReAllocList(aNewCapacity: IndexType);
  procedure CheckIndex(anIndex: IndexType);
   {* ��������� ���������� ������� � ��������� ����������, ���� �� ������������ }
  function ItemSlot(anIndex: IndexType): PItemType;
  function ExpandSize(aTargetSize: IndexType): Cardinal;
  procedure CheckSetItem(anIndex: IndexType);
   {* ��������� ���������� ������� ��� ������� }
  procedure Delete(anIndex: IndexType);
   {* ������� ������� � �������� anIndex }
  procedure DirectInsert(anIndex: IndexType;
   const anItem: _ItemType_);
   {* ���������������� ������� ��������. ��� �������� ���������� ������� }
  procedure Insert(anIndex: IndexType;
   const anItem: _ItemType_);
   {* ������� �������� }
  procedure MoveItems(aDst: IndexType;
   aSrc: IndexType;
   aSize: Cardinal);
  procedure Add(const anItem: _ItemType_);
   {* ��������� ������� ������ }
  function IndexOf(const anItem: _ItemType_): IndexType;
   {* ���������� ������ �������� ������ ��� -1, ���� �������� � ������ ��� }
  procedure Remove(const anIndex: _ItemType_);
   {* ������� ������� �� ������ }
  procedure Clear;
   {* ������� ������ }
  procedure FreeItem(var thePlace: _ItemType_);
  procedure FillItem(var thePlace: _ItemType_;
   const aFrom: _ItemType_);
  function IsSame(const A: _ItemType_;
   const B: _ItemType_): Boolean;
 end;//_List_
 
implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
;

end.
