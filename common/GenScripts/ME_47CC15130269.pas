unit evMarkersList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
;

type
 TevMarkersList = class(_l3InterfaceRefList_, IevMarkersList)
  function Count: Integer;
   {* Число элементов. }
 end;//TevMarkersList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
