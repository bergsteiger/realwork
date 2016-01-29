unit l3ProtoObjectRefList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3ProtoObject
;

 {$Define l3Items_NoSort}
 
type
 Tl3ProtoObjectRefList = class(_l3UncomparabeObjectRefList_)
  {* Список ССЫЛОК на Tl3ProtoObject }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tl3ProtoObjectRefList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
