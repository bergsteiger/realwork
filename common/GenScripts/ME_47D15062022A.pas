unit l3Bitmap;

interface

uses
 l3IntfUses
 , Graphics
 , l3Canvas
 , l3InternalInterfaces
;

type
 Tl3Bitmap = class(_l3Unknown_)
 end;//Tl3Bitmap
 
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
;

type
 Tl3BitmapCanvas = class(Tl3Canvas)
 end;//Tl3BitmapCanvas
 
end.
