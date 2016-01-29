unit l3DataContainerWithoutIUnknownPrim;

interface

uses
 l3IntfUses
 , l3CastablePersistent
;

 {$Define l3Unknown_NoIUnknown}
 
 {$Undef l3Unknown_NoMultiThread}
 
type
 Tl3DataContainerWithoutIUnknownPrim = class(_l3Unknown_)
 end;//Tl3DataContainerWithoutIUnknownPrim
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
 , l3IID
 , l3InterfacesMisc
;

end.
