unit l3DataContainerWithoutIUnknown;

interface

uses
 l3IntfUses
 , l3DataContainerWithoutIUnknownPrim
;

type
 Tl3DataContainerWithoutIUnknown = class(Tl3DataContainerWithoutIUnknownPrim)
  {* Контейнер данных без реализации IUnknown, но во всей интерфейсной поддержкой }
 end;//Tl3DataContainerWithoutIUnknown
 
implementation

uses
 l3ImplUses
;

end.
