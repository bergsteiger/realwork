unit k2DictionaryIDIndexPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

type
 Tk2DictionaryIDIndexPrim = class(Tl3ProtoDataContainer)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tk2DictionaryIDIndexPrim
 
implementation

uses
 l3ImplUses
 , k2Tags
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

end.
