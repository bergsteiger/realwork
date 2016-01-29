unit vgInterfacedPersistent;

interface

uses
 l3IntfUses
 , Classes
;

 {$Define l3Unknown_NoIUnknown}
 
 {$Define _UnknownForDesign}
 
type
 TvgInterfacedPersistent = class(_l3Unknown_)
  procedure Free(var Dummy: Integer);
   {* Для ловли Free }
 end;//TvgInterfacedPersistent
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
;

end.
