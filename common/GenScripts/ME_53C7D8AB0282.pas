unit k2TypeTableCreatedListeners;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , Classes
;

 {$Define l3Items_NoSort}
 
type
 Tk2TypeTableCreatedListeners = class(_l3StandardTypedList_)
  procedure AddListener(aListener: TNotifyEvent);
  procedure NotifyListeners(aSender: TObject);
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* ���������� �������� ������ }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  procedure FillItem(var aPlace: _ItemType_;
   const anItem: _ItemType_;
   anItems: _l3Items_);
   {* ��������� ������� ������. }
  procedure FreeItem(var aPlace: _ItemType_;
   aList: _l3Items_);
   {* ������� ������� ������ }
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//Tk2TypeTableCreatedListeners
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
