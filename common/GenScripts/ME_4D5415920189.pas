unit vgBitmap;

interface

uses
 l3IntfUses
 , vgCustomBitmap
 , vgObject
;

type
 TvgBitmapObject = class(TvgObject)
 end;//TvgBitmapObject
 
 TvgBitmap = class(TvgCustomBitmap)
 end;//TvgBitmap
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
