unit ncsPriorityMessageList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ncsMessage
;

type
 TncsPriorityMessageList = class(Tl3ProtoDataContainer)
  {* ������ ������������ �� ���������� � ���� ��������� }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//TncsPriorityMessageList
 
implementation

uses
 l3ImplUses
 , Math
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
