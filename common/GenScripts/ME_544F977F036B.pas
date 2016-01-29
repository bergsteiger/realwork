unit ncsPriorityMessageList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ncsMessage
;

type
 TncsPriorityMessageList = class(Tl3ProtoDataContainer)
  {* Список сортированый по приоритету и дате сообщения }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
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
