unit vgCustomGradientPoint;

interface

uses
 l3IntfUses
 , Classes
 , vgTypes
;

 {$Define _UnknownForDesign}
 
 {$Define l3Unknown_NoIUnknown}
 
type
 TvgCustomGradientPoint = class(_l3Unknown_)
 end;//TvgCustomGradientPoint
 
implementation

uses
 l3ImplUses
 , vg_scene
 , TtfwClassRef_Proxy
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
;

end.
