unit nevFlatSubsList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevContainers
 , nevTools
;

type
 TnevFlatSubsList = class(_l3InterfaceRefList_, InevFlatSubsList)
  {* Плоский контейнер сабов }
  function Count: Integer;
   {* Число элементов. }
 end;//TnevFlatSubsList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
