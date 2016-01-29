unit l3CustomSortIntegerList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

 {$Define l3Items_CompareItemsRec_NeedsRList}
 
type
 Tl3CustomSortIntegerList = class(Tl3ProtoDataContainer)
  {* http://mdp.garant.ru/pages/viewpage.action?pageId=269058147 }
  function CompareItems(A: Integer;
   B: Integer): Integer;
   {* Функция сравнения элементов }
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tl3CustomSortIntegerList
 
implementation

uses
 l3ImplUses
 , l3Types
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
