unit ddDocumentAtomList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddDocumentAtom
;

type
 TddDocumentAtomList = class(_l3UncomparabeObjectRefList_)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TddDocumentAtomList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
