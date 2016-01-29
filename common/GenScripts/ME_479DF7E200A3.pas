unit l3BaseRecList;

interface

uses
 l3IntfUses
 , l3ProtoPtrRecList
;

type
 Tl3BaseRecList = class(Tl3ProtoPtrRecList)
  function CompareItem(A: Integer;
   B;
   aDataSize: Cardinal): Integer;
   {* aDataSize - размер сравниваемой части записи, если 0, то вся запись }
  function DoCompare(A;
   B;
   DataSize: Cardinal): Integer;
   {* Сравнивает элементы. }
 end;//Tl3BaseRecList
 
implementation

uses
 l3ImplUses
 , m2MemLib
;

end.
