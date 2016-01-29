unit evBitmapParaPictureGetter;

interface

uses
 l3IntfUses
 , l3Variant
 , k2Base
;

type
 TevBitmapParaPictureGetter = class
  function GetPicture(aTag: Tl3Variant;
   aProp: Tk2Prop;
   out Data: Tl3Variant): Boolean;
 end;//TevBitmapParaPictureGetter
 
implementation

uses
 l3ImplUses
;

end.
