unit k2FontNameListPrim;

interface

uses
 l3IntfUses
 , l3DataContainerWithoutIUnknownPrim
 , k2FontName
;

type
 Tk2FontNameListPrim = class(_l3UncomparabeObjectRefList_)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tk2FontNameListPrim
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
