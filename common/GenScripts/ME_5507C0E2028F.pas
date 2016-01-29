unit ChromeLikeTabSetControlPrim;

interface

uses
 l3IntfUses
 , Controls
 , l3Bitmap
 , ImgList
 , Messages
 , ChromeLikeTabSetTypes
 , Windows
 , Types
 , Graphics
 , Classes
;

type
 TChromeLikeTabHintParams = record
 end;//TChromeLikeTabHintParams
 
 TChromeLikeTabSetControlPrim = class(TWinControl)
  function GetDrawingContext: IChromeLkeTabSetDrawingContext;
  procedure ResizeBuffer(aNewWidth: Integer;
   aNewHeight: Integer);
  procedure PaintBuffer;
  procedure FlushBuffer(aDC: hDC;
   const aRect: TRect);
  function IsTransparentPoint(const aPoint: TPoint): Boolean;
  procedure Paint(const aContext: IChromeLkeTabSetDrawingContext);
  procedure PaintBackground(aCanvas: TCanvas);
  procedure DoOnMouseLeave;
  procedure DoOnMouseEnter;
  procedure DoOnResize;
  function GetHintParams(const aPoint: TPoint): TChromeLikeTabHintParams;
  procedure WMNCHitTest(var aMessage: TWMNCHitTest);
  procedure WMMouseActivate(var aMessage: TWMMouseActivate);
  procedure WMEraseBkgnd(var aMessage: TWMEraseBkGnd);
  procedure WMPaint(var aMessage: TWMPaint);
  procedure WMSize(var aMessage: TWMSize);
  procedure CMMouseLeave(var aMessage: TMessage);
  procedure CMHintShow(var aMessage: TMessage);
  procedure CMMouseEnter(var aMessage: TMessage);
 end;//TChromeLikeTabSetControlPrim
 
implementation

uses
 l3ImplUses
 , Forms
 , ChromeLikeDrawingContext
 , SysUtils
 , ChromeLikeTabSetUtils
 , TtfwClassRef_Proxy
;

end.
