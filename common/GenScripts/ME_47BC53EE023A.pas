unit dtDictItemsPrim;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , dtCustomDictItem
;

type
 TdtDictItemsPrim = class(_l3UncomparabeObjectRefList_)
  {* Базовый список элементов словаря. }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TdtDictItemsPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
