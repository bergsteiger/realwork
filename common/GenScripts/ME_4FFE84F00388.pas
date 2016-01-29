unit vcmFormSetFactoryPrim;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
;

type
 TvcmFormSetFactoryPrim = class(Tl3ProtoObject)
  function GetInstance: TvcmFormSetFactoryPrim;
 end;//TvcmFormSetFactoryPrim
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
