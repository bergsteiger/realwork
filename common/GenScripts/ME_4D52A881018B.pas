unit vgComponent;

interface

uses
 l3IntfUses
 , Classes
;

 {$Define _UnknownIsComponent}
 
 {$Define l3Unknown_NoIUnknown}
 
type
 TvgComponent = class(_l3Unknown_)
  procedure Free(var Dummy: Integer);
   {* Для ловли просто Free }
 end;//TvgComponent
 
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
