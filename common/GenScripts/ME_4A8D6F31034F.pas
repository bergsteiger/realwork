unit vcmCommandIDsListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

type
 TvcmCommandInfo = object
  {* Информация о команде }
 end;//TvcmCommandInfo
 
 TvcmCommandIDsListPrim = class(Tl3ProtoDataContainer)
  {* Список информации о командах }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TvcmCommandIDsListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
