unit k2ToolPrimList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , k2ToolPrim
;

type
 Tk2ToolPrimList = class(_l3UncomparabeObjectRefList_)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tk2ToolPrimList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
