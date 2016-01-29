unit ChromeLikeDrawingContext;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ChromeLikeTabSetTypes
 , GDIPOBJ
 , Graphics
;

type
 TChromeLikeDrawingContext = class(Tl3ProtoObject, IChromeLkeTabSetDrawingContext)
  procedure Create(aCanvas: TCanvas);
  function Make(aCanvas: TCanvas): IChromeLkeTabSetDrawingContext;
  function Canvas: TCanvas;
  function Graphics: TGPGraphics;
 end;//TChromeLikeDrawingContext
 
implementation

uses
 l3ImplUses
 , ChromeLikeTabSetUtils
 , SysUtils
;

end.
