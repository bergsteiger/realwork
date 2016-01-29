unit myReferenceCountGuard;

interface

uses
 l3IntfUses
 , myInterfacedObject
;

type
 ImyReferenceCountGuard = interface
  {* Интерфейс исключительно для примеров }
  function GetRefCount: Integer;
 end;//ImyReferenceCountGuard
 
 TmyReferenceCountGuard = class(TmyInterfacedObject, ImyReferenceCountGuard)
  {* Класс исключительно для примеров }
  function Make: ImyReferenceCountGuard;
  function GetRefCount: Integer;
 end;//TmyReferenceCountGuard
 
implementation

uses
 l3ImplUses
;

end.
