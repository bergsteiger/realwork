unit vgGradientPoints;

interface

uses
 l3IntfUses
 , Classes
 , vgGradientPoint
;

 {$Define _UnknownForDesign}
 
 {$Define l3Unknown_NoIUnknown}
 
type
 TvgGradientPoints = class(_l3Unknown_)
 end;//TvgGradientPoints
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
;

end.
