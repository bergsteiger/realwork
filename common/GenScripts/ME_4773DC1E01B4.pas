unit l3ClassList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

type
 Tl3ClassList = class(_l3UnrefcountedList_)
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tl3ClassList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
