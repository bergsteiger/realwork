unit l3InterfacedIntegerList;

interface

uses
 l3IntfUses
 , l3ProtoIntegerList
 , l3Interfaces
;

type
 Tl3InterfacedIntegerList = class(Tl3ProtoIntegerList, Il3IntegerList)
  function Count: Integer;
   {* Число элементов. }
 end;//Tl3InterfacedIntegerList
 
implementation

uses
 l3ImplUses
;

end.
