unit ncsReplyDecsriptionList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ncsReplyDescription
;

type
 TncsReplyDecsriptionList = class(Tl3ProtoDataContainer)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TncsReplyDecsriptionList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
