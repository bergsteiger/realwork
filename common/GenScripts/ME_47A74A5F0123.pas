unit l3TypedListPrim.imp;

interface

uses
 l3IntfUses
 , l3Types
 , l3Interfaces
 , l3Core
;

type
 _l3TypedListPrim_ = class(_l3Items_)
  function Clone: Pointer; overload;
  procedure Assign(anOther: _l3TypedListPrim_); overload;
  function GrowByOne: PItemType;
   {* ����������� ������ ������ �� ������� � ���������� ��������� �� ��������� ������� ��� ����������. ���� ������� ��������������� ������. }
  procedure Insert(anIndex: Integer;
   const anItem: _ItemType_);
   {* ��������� ������� � ������. }
  function IndexOf(const anItem: _ItemType_): Integer;
   {* ���������� ������ �������� ������ ��� -1, ���� �������� � ������ ���. }
  function Remove(const anItem: _ItemType_): Integer;
   {* ������� ������� �� ������ � ���������� ��� ������. }
  function Add(const anItem: _ItemType_): Integer;
   {* ��������� ������� ������. }
  procedure Move(CurIndex: Integer;
   NewIndex: Integer);
   {* ����������� �������� ������. }
  function IterateBackF(aHi: Tl3Index;
   aLo: Tl3Index;
   anAction: Tl3IteratorAction): Integer;
   {* ���������� �������� ������ � �������� ������� � ����������� �������� ��� anAction. }
  function IterateBack(aHi: Tl3Index;
   aLo: Tl3Index;
   anAction: Tl3IteratorAction): Integer;
   {* ���������� �������� ������ � �������� �������. }
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* ���������� �������� ������ }
  procedure Assign(Source: TPersistent); overload;
  function JoinWith(aList: _l3TypedListPrim_): Integer; overload;
   {* ���������� ���� ������ � ������. }
  function Iterate(aLo: Tl3Index;
   aHi: Tl3Index;
   Action: Tl3IteratorAction): Integer;
   {* ���������� ��� �������� ��������� � aLo �� aHi. }
  function IterateAll(Action: Tl3IteratorAction): Integer;
   {* ���������� ��� �������� ���������. }
  procedure Clear;
  function GetItem(Index: Integer): _ItemType_;
  function DoAdd(const aData: _ItemType_): Integer;
   {* ��������� ������� � ������. }
  procedure DoInsert(anIndex: Integer;
   const aData: _ItemType_);
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  procedure DoSetItem(anIndex: Integer;
   const anItem: _ItemType_);
  procedure DeleteLast;
   {* ������� ��������� ������� ������. }
  procedure Create;
  function Clone: Pointer; overload;
   {* ������� ��� ��������� ����� �������. }
  procedure ReAllocList(NewCapacity: Integer;
   aList: _l3Items_);
   {* �������� �������� ������. }
  function GetCapacity(aList: _l3Items_): Integer;
  function GetItemSlot(anIndex: Integer;
   aList: _l3Items_): PItemType;
  function Count: Integer;
   {* ����� ���������. }
 end;//_l3TypedListPrim_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type
 PLong = ^Integer;
  {* ��������� �� �����. }
 
end.
