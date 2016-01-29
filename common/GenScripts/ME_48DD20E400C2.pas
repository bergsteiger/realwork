unit l3GraphicContainer;

interface

uses
 l3IntfUses
 , l3_Base
 , l3InternalInterfaces
 , l3Units
 , l3Core
 , l3Interfaces
 , Classes
;

type
 Tl3PrimGraphicContainer = class(Tl3_Base, Il3Bitmap)
  procedure StretchDraw(const R: Tl3Rect;
   const aCanvas: Il3Canvas);
  procedure SaveToClipboardFormat(var AFormat: Word;
   var AData: THandle;
   var APalette: HPALETTE);
  procedure AssignTo(P: TObject);
  procedure Assign(P: TPersistent);
  function IsMF: Boolean;
  function Width: Integer;
  function Height: Integer;
  function InchWidth: Integer;
  function InchHeight: Integer;
 end;//Tl3PrimGraphicContainer
 
 Tl3SizeableGraphicContainerPrim = class(Tl3PrimGraphicContainer)
 end;//Tl3SizeableGraphicContainerPrim
 
 Tl3SizeableGraphicContainer = class(Tl3SizeableGraphicContainerPrim)
 end;//Tl3SizeableGraphicContainer
 
 Tl3GraphicContainer = class(Tl3SizeableGraphicContainerPrim)
 end;//Tl3GraphicContainer
 
implementation

uses
 l3ImplUses
 , l3GraphicContainerStack
;

end.
