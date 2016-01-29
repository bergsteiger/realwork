unit nscTasksPanelGroupDescList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3StringIDEx
 , Controls
;

type
 TnscTasksPanelGroupDesc = object
 end;//TnscTasksPanelGroupDesc
 
 TnscTasksPanelGroupDescList = class(Tl3ProtoDataContainer)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TnscTasksPanelGroupDescList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 , l3String
;

end.
