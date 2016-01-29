unit l3IntegerValueMapManager;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3SimpleDataContainer
 , l3ValueMapManager
;

type
 Tl3IntegerValueMapFactories = class(_l3InterfaceRefList_)
 end;//Tl3IntegerValueMapFactories
 
 Tl3IntegerValueMapManager = class(Tl3ValueMapManager, Il3IntegerValueMapManager)
  function Make: Il3IntegerValueMapManager;
  procedure RegisterFactory(const aFactory: Il3IntegerValueMapFactory;
   aPreferred: Boolean);
   {* aPreferred - Фабрика будет вызываться как можно раньше. }
  procedure UnRegisterFactory(const aFactory: Il3IntegerValueMapFactory);
  function Map: Il3IntegerValueMap;
   {* Мапа по ID. }
 end;//Tl3IntegerValueMapManager
 
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
