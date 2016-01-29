unit vgCustomControl;

interface

uses
 l3IntfUses
 , Controls
;

 {$Define _UnknownIsComponent}
 
 {$Define l3Unknown_NoIUnknown}
 
type
 TvgCustomControl = class(_l3Unknown_)
  procedure Free(var Dummy: Integer);
   {* Для ловли Free }
 end;//TvgCustomControl
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

end.
