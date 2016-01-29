unit l3ValueMapManager;

interface

uses
 l3IntfUses
 , l3ValueMapManagerPrim
 , l3Interfaces
 , l3Types
;

type
 Tl3ValueMapManager = class(Tl3ValueMapManagerPrim)
  {* базовая реализация менеджера мап "строка"-что-то. }
  function MakeDefaultMap(const aID: Tl3ValueMapID): Il3ValueMap;
 end;//Tl3ValueMapManager
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

end.
