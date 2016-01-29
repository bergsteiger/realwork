unit l3COMQueryInterface.imp;

interface

uses
 l3IntfUses
 , l3IID
 , l3Interfaces
;

type
 _l3COMQueryInterface_ = class(Ml3Castable)
  function COMQueryInterface(const IID: Tl3GUID;
   out Obj): Tl3HResult;
   {* Реализация запроса интерфейса }
 end;//_l3COMQueryInterface_
 
implementation

uses
 l3ImplUses
 , l3InterfacesMisc
;

end.
