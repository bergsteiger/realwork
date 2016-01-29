unit l3StringValueMapManager;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3SimpleDataContainer
 , l3ValueMapManager
;

type
 Tl3StringValueMapFactories = class(_l3InterfaceRefList_)
 end;//Tl3StringValueMapFactories
 
 Tl3StringValueMapManager = class(Tl3ValueMapManager, Il3StringValueMapManager)
  function Make: Il3StringValueMapManager;
  procedure RegisterFactory(const aFactory: Il3StringValueMapFactory;
   aPreferred: Boolean);
   {* aPreferred - Фабрика будет вызываться как можно раньше. }
  procedure UnRegisterFactory(const aFactory: Il3StringValueMapFactory);
  function Map: Il3StringValueMap;
   {* Мапа по ее ID. }
 end;//Tl3StringValueMapManager
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 , l3Types
;

end.
