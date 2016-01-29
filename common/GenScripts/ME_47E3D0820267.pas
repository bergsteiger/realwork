unit k2OperationContainerRefList;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , k2OperationContainer
;

type
 Tk2OperationContainerRefList = class(_l3UncomparabeObjectRefList_)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tk2OperationContainerRefList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
