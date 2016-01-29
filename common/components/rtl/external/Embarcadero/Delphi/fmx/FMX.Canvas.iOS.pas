{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Canvas.iOS;

interface

procedure RegisterCanvasClasses;
procedure UnregisterCanvasClasses;

implementation {===============================================================}

uses
  System.Classes, System.SysUtils, System.Math, System.Types, System.UITypes, FMX.Types,
  Macapi.ObjectiveC, Macapi.CoreFoundation,
  iOSapi.CocoaTypes, iOSapi.CoreGraphics, iOSapi.Foundation, iOSapi.CoreText, System.UIConsts, iOSapi.UIKit,
  FMX.Platform, FMX.Consts, FMX.Forms, FMX.TextLayout, FMX.PixelFormats, FMX.Surfaces,
  FMX.Platform.iOS;

type
  { TBitmapCodecQuartz }

  TBitmapCodecQuartz = class(TCustomBitmapCodec)
  public
    class function GetImageSize(const AFileName: string): TPointF; override;
    class function IsValid(const AStream: TStream): Boolean; override;
    function LoadFromFile(const AFileName: string; const Bitmap: TBitmapSurface): Boolean; override;
    function LoadThumbnailFromFile(const AFileName: string; const AFitWidth, AFitHeight: single; const UseEmbedded: Boolean;
      const Bitmap: TBitmapSurface): Boolean; override;
    function SaveToFile(const AFileName: string; const Bitmap: TBitmapSurface;
       const SaveParams: PBitmapCodecSaveParams = nil): Boolean; override;
    function LoadFromStream(const AStream: TStream; const Bitmap: TBitmapSurface): Boolean; override;
    function SaveToStream(const AStream: TStream; const Bitmap: TBitmapSurface; const Extension: string;
       const SaveParams: PBitmapCodecSaveParams = nil): Boolean; override;
  end;

  { TCocoaCanvasSaveState }

  TCocoaCanvasSaveState = class(TCanvasSaveState)
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    procedure Assign(Source: TPersistent); override;
  end;

  TQuartzBitmap = class
  private
    FData: Pointer;
    FContext: CGContextRef;
    FImage: CGImageRef;
    function GetImage: CGImageRef;
  end;

  { TCanvasQuartz }

  TCanvasQuartz = class(TCanvas)
  private
    FFunc: CGFunctionRef;
    FBitmapRef: CGImageRef;
    FCallback: CGFunctionCallbacks;
    FShading: CGShadingRef;
    FContext: CGContextRef;
    function Context: CGContextRef; inline;
    function CreateSaveState: TCanvasSaveState; override;
    procedure SetClipRects(const ARects: array of TRectF);
    procedure ApplyFill(const ABrush: TBrush; ARect: TRectF; const AOpacity: single);
    procedure DeApplyFill(const ABrush: TBrush; ARect: TRectF; const AOpacity: single);
    procedure ApplyStroke(const AStroke: TStrokeBrush; ARect: TRectF; const AOpacity: single);
  protected
    { scene }
    function DoBeginScene(const AClipRects: PClipRects = nil; AContextHandle: THandle = 0): Boolean; override;
    procedure DoEndScene; override;
    function GetCanvasScale: Single; override;
    { creation }
    constructor CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
      const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault); override;
    constructor CreateFromBitmap(const ABitmap: TBitmap;
      const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault); override;
    constructor CreateFromPrinter(const APrinter: TAbstractPrinter); override;
    { Bitmaps }
    class procedure DoInitializeBitmap(const Bitmap: TBitmap); override;
    class procedure DoFinalizeBitmap(const Bitmap: TBitmap); override;
    class function DoMapBitmap(const Bitmap: TBitmap; const Access: TMapAccess; var Data: TBitmapData): Boolean; override;
    class procedure DoUnmapBitmap(const Bitmap: TBitmap; var Data: TBitmapData); override;
    { drawing }
    procedure DoFillRect(const ARect: TRectF; const AOpacity: Single; const ABrush: TBrush); override;
    procedure DoFillPath(const APath: TPathData; const AOpacity: Single; const ABrush: TBrush); override;
    procedure DoFillEllipse(const ARect: TRectF; const AOpacity: Single; const ABrush: TBrush); override;
    procedure DoDrawBitmap(const ABitmap: TBitmap; const SrcRect, DstRect: TRectF; const AOpacity: Single;
      const HighSpeed: Boolean = False); override;
    procedure DoDrawLine(const APt1, APt2: TPointF; const AOpacity: Single; const ABrush: TStrokeBrush); override;
    procedure DoDrawRect(const ARect: TRectF; const AOpacity: Single; const ABrush: TStrokeBrush); override;
    procedure DoDrawPath(const APath: TPathData; const AOpacity: Single; const ABrush: TStrokeBrush); override;
    procedure DoDrawEllipse(const ARect: TRectF; const AOpacity: Single; const ABrush: TStrokeBrush); override;
  public
    { buffer }
    procedure Clear(const Color: TAlphaColor); override;
    procedure ClearRect(const ARect: TRectF; const AColor: TAlphaColor = 0); override;
    { matrix }
    procedure SetMatrix(const M: TMatrix); override;
    { cliping }
    procedure IntersectClipRect(const ARect: TRectF); override;
    procedure ExcludeClipRect(const ARect: TRectF); override;
    { mesuring }
    function PtInPath(const APoint: TPointF; const APath: TPathData): Boolean; override;
  published
  end;

  TTextLayoutCT = class(TTextLayout)
  private
    FCTFrame: CTFrameRef;
    FCTAttr: CFMutableAttributedStringRef;
    FCTPath: CGMutablePathRef;
    FTextWidth: Single;
    FTextHeight: Single;
    FLastColor: TAlphaColor;
    FLastOpacity: Single;
    procedure CreateCT;
    procedure MeasureCT;
    procedure CreateCTFrame;
    function GetCTFontRef(const AFont: TFont): CTFontRef;
  protected
    procedure DoRenderLayout; override;
    procedure DoDrawLayout(const ACanvas: TCanvas); override;
    function GetTextHeight: Single; override;
    function GetTextWidth: Single; override;
    function GetTextRect: TRectF; override;
    function DoPositionAtPoint(const APoint: TPointF): Integer; override;
    function DoRegionForRange(const ARange: TTextRange): TRegion; override;
  public
    destructor Destroy; override;
    //
    procedure ConvertToPath(const APath: TPathData); override;
  end;
  
var
  MyColorSpace: CGColorSpaceRef;

function ColorSpace: CGColorSpaceRef; inline;
begin
  if MyColorSpace = nil then
    MyColorSpace := CGColorSpaceCreateDeviceRGB;
  Result := MyColorSpace;
end;

const
  //Rotating matrix to simulate Italic font attribute
  ItalicMatrix: CGAffineTransform = (
    a: 1;
    b: 0;
    c: 0.176326981; //~tan(10 degrees)
    d: 1;
    tx: 0;
    ty: 0
  );
{ TBitmapCodecQuartz }

class function TBitmapCodecQuartz.GetImageSize(const AFileName: string): TPointF;
var
  Img: UIImage;
begin
  Result := PointF(0, 0);
  Img := TUIImage.Wrap(TUIImage.alloc.initWithContentsOfFile(NSSTR(AFileName)));
  if Img <> nil then
  begin
    Result := PointF(Img.Size.width, Img.Size.height);
  end;
end;

class function TBitmapCodecQuartz.IsValid(const AStream: TStream): Boolean;
var
  Img: UIImage;
  memStream: TMemoryStream;
  data: NSData;
  ImgRef: CGImageRef;
  SavePosition: Integer;
begin
  Result := False;
  SavePosition := AStream.Position;
  try
    memStream := TMemoryStream.Create;
    memStream.CopyFrom(AStream, AStream.Size);
    memStream.Position := 0;
    data := TNSData.Wrap(TNSData.alloc.initWithBytesNoCopy(memStream.Memory, memStream.Size, False));
    try
      if data.length > 0 then
      begin
        Img := TUIImage.Wrap(TUIImage.alloc.initWithData(data));
        try
          if Img <> nil then
          begin
            ImgRef := Img.cGImage;
            Result := Assigned(ImgRef);
          end;
        finally
          if Assigned(Img) then
            Img.release;
        end;
      end;
    finally
      data.release;
    end;
    memStream.Free;
  finally
    AStream.Position := SavePosition;
  end;
end;

function TBitmapCodecQuartz.LoadFromStream(const AStream: TStream; const Bitmap: TBitmapSurface): Boolean;
var
  Img: UIImage;
  memStream: TMemoryStream;
  data: NSData;
  ImgRef: CGImageRef;
  CtxRef: CGContextRef;
begin
  Result := False;
  memStream := TMemoryStream.Create;
  memStream.CopyFrom(AStream, AStream.Size);
  memStream.Position := 0;
  data := TNSData.Wrap(TNSData.alloc.initWithBytesNoCopy(memStream.Memory, memStream.Size, False));
  try
    if data.length > 0 then
    begin
      Img := TUIImage.Wrap(TUIImage.alloc.initWithData(data));
      try
        if Img <> nil then
        begin
          ImgRef := Img.cGImage;
          if ImgRef <> nil then
          begin
            Bitmap.SetSize(CGImageGetWidth(ImgRef), CGImageGetHeight(ImgRef));
            CtxRef := CGBitmapContextCreate(Bitmap.Bits, Bitmap.Width, Bitmap.Height, 8,
               Bitmap.Pitch, ColorSpace, kCGImageAlphaPremultipliedLast);
            CGContextDrawImage(CtxRef, CGRectMake(0, 0, Bitmap.Width, Bitmap.Height), imgRef);
            CGContextRelease(CtxRef);
            Result := True;
          end;
        end;
      finally
        if Assigned(Img) then
          Img.release;
      end;
    end;
  finally
    data.release;
  end;
  memStream.Free;
end;

function TBitmapCodecQuartz.SaveToStream(const AStream: TStream; const Bitmap: TBitmapSurface; const Extension: string;
  const SaveParams: PBitmapCodecSaveParams = nil): Boolean;
var
  data: NSData;
  img: UIImage;
  imgRef: CGImageRef;
  CtxRef: CGContextRef;
begin
  Result := False;
  CtxRef := CGBitmapContextCreate(Bitmap.Bits, Bitmap.Width, Bitmap.Height, 8,
     Bitmap.Pitch, ColorSpace, kCGImageAlphaPremultipliedLast);
  imgRef := CGBitmapContextCreateImage(CtxRef);
  if imgRef <> nil then
  begin
    img := TUIImage.Wrap(TUIImage.alloc.initWithCGImage(imgRef));
    if img <> nil then
    begin
      data := TNSData.Wrap(UIImagePNGRepresentation((img as ILocalObject).GetObjectID));
      AStream.Write(data.bytes^, data.length);
      Result := True;
    end;
    CGImageRelease(imgRef);
  end;
  CGContextRelease(CtxRef);
end;

function TBitmapCodecQuartz.LoadFromFile(const AFileName: string;
  const Bitmap: TBitmapSurface): Boolean;
var
  Img: UIImage;
  ImgRef: CGImageRef;
  CtxRef: CGContextRef;
begin
  Result := False;
  Img := TUIImage.Wrap(TUIImage.alloc.initWithContentsOfFile(NSSTR(AFileName)));
  if Img <> nil then
  begin
    ImgRef := Img.cGImage;
    if ImgRef <> nil then
    begin
      Bitmap.SetSize(CGImageGetWidth(ImgRef), CGImageGetHeight(ImgRef));
      CtxRef := CGBitmapContextCreate(Bitmap.Bits, Bitmap.Width, Bitmap.Height, 8,
         Bitmap.Pitch, ColorSpace, kCGImageAlphaPremultipliedLast);
      CGContextDrawImage(CtxRef, CGRectMake(0, 0, Bitmap.Width, Bitmap.Height), imgRef);
      CGContextRelease(CtxRef);
      Result := True;
    end;
  end;
end;

function TBitmapCodecQuartz.LoadThumbnailFromFile(const AFileName: string;
  const AFitWidth, AFitHeight: single; const UseEmbedded: Boolean; const Bitmap: TBitmapSurface): Boolean;
var
  Img: UIImage;
  ImgRef: CGImageRef;
  CtxRef: CGContextRef;
  R: TRectF;
begin
  Result := False;
  Img := TUIImage.Wrap(TUIImage.alloc.initWithContentsOfFile(NSSTR(AFileName)));
  if Img <> nil then
  begin
    ImgRef := Img.cGImage;
    if ImgRef <> nil then
    begin
      R := TRectF.Create(0, 0, CGImageGetWidth(ImgRef), CGImageGetHeight(ImgRef));
      R.Fit(TRectF.Create(0, 0, AFitWidth, AFitHeight));
      Bitmap.SetSize(round(RectWidth(R)), round(RectHeight(R)));
      CtxRef := CGBitmapContextCreate(Bitmap.Bits, Bitmap.Width, Bitmap.Height, 8,
         Bitmap.Pitch, ColorSpace, kCGImageAlphaPremultipliedLast);
      CGContextDrawImage(CtxRef, CGRectMake(0, 0, Bitmap.Width, Bitmap.Height), imgRef);
      CGContextRelease(CtxRef);
      Result := True;
    end;
  end;
end;

function TBitmapCodecQuartz.SaveToFile(const AFileName: string;
  const Bitmap: TBitmapSurface; const SaveParams: PBitmapCodecSaveParams = nil): Boolean;
var
  data: NSData;
  img: UIImage;
  imgRef: CGImageRef;
  CtxRef: CGContextRef;
  AStream: TStream;
begin
  Result := False;
  if (ExtractFileExt(LowerCase(AFileName)) = '.jpg') or (ExtractFileExt(LowerCase(AFileName)) = '.jpeg') then
  begin
    CtxRef := CGBitmapContextCreate(Bitmap.Bits, Bitmap.Width, Bitmap.Height, 8,
       Bitmap.Pitch, ColorSpace, kCGImageAlphaPremultipliedLast);
    imgRef := CGBitmapContextCreateImage(CtxRef);
    if imgRef <> nil then
    begin
      img := TUIImage.Wrap(TUIImage.alloc.initWithCGImage(imgRef));
      if img <> nil then
      begin
        if SaveParams <> nil then
          data := TNSData.Wrap(UIImageJPEGRepresentation((img as ILocalObject).GetObjectID, SaveParams.Quality / 100))
        else
          data := TNSData.Wrap(UIImageJPEGRepresentation((img as ILocalObject).GetObjectID, 1));
        AStream := TFileStream.Create(AFileName, fmCreate);
        AStream.Write(data.bytes^, data.length);
        AStream.Free;
        Result := True;
      end;
      CGImageRelease(imgRef);
    end;
    CGContextRelease(CtxRef);
  end;
  if (ExtractFileExt(LowerCase(AFileName)) = '.png') then
  begin
    CtxRef := CGBitmapContextCreate(Bitmap.Bits, Bitmap.Width, Bitmap.Height, 8,
       Bitmap.Pitch, ColorSpace, kCGImageAlphaPremultipliedLast);
    imgRef := CGBitmapContextCreateImage(CtxRef);
    if imgRef <> nil then
    begin
      img := TUIImage.Wrap(TUIImage.alloc.initWithCGImage(imgRef));
      if img <> nil then
      begin
        data := TNSData.Wrap(UIImagePNGRepresentation((img as ILocalObject).GetObjectID));
        AStream := TFileStream.Create(AFileName, fmCreate);
        AStream.Write(data.bytes^, data.length);
        AStream.Free;
        Result := True;
      end;
      CGImageRelease(imgRef);
    end;
    CGContextRelease(CtxRef);
  end;
end;

{ TCocoaCanvasSaveState }

procedure TCocoaCanvasSaveState.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TCanvasQuartz then
    CGContextSaveGState(TCanvasQuartz(Source).Context);
end;

procedure TCocoaCanvasSaveState.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);
  if Dest is TCanvasQuartz then
    CGContextRestoreGState(TCanvasQuartz(Dest).Context);
end;

{ TCanvasQuartz }

const
  inputRange: array [1..2] of single = (0, 1);

type

  TRGBFloat = packed record
    r, g, b, a: single;
  end;

function CGColor(const C: TAlphaColor; Opacity: single = 1): TRGBFloat;
var
  cc: TAlphaColor;
begin
  cc := MakeColor(C, Opacity);
  Result.a := TAlphaColorRec(cc).a / $FF;
  Result.r := TAlphaColorRec(cc).r / $FF;
  Result.g := TAlphaColorRec(cc).g / $FF;
  Result.b := TAlphaColorRec(cc).b / $FF;
end;

function CGRectFromRect(const R: TRectF): CGRect;
begin
  Result.origin.x := R.Left;
  Result.origin.Y := R.Top;
  Result.size.Width := R.Right - R.Left;
  Result.size.Height := R.Bottom - R.Top;
end;

procedure DrawTiledImage(const CtxRef: CGContextRef; ARect: TRectF; const Img: CGImageRef; const Bitmap: TBitmap);
var
  x, y: Integer;
  CR: CGRect;
begin
  if Bitmap.Width * Bitmap.Height = 0 then Exit;
  for x := 0 to Trunc(RectWidth(ARect) / Bitmap.Width)  do
    for y := 0 to Trunc(RectHeight(ARect) / Bitmap.Height) do
    begin
      CR := CGRectFromRect(RectF(ARect.Left + (Bitmap.Width * x), ARect.Top + (Bitmap.Height * y),
        ARect.Left + (Bitmap.Width * (x + 1)), ARect.Top + (Bitmap.Height * (y + 1))));
      CR.origin.y := -ARect.Top - (Bitmap.Height * (y + 1));
      CGContextDrawImage(CtxRef, CR, Img);
    end;
end;

const
  SavedCount = 2000;

constructor TCanvasQuartz.CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
  const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault);
begin
  inherited ;
end;

constructor TCanvasQuartz.CreateFromBitmap(const ABitmap: TBitmap; const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault);
begin
  inherited CreateFromBitmap(ABitmap);
end;

constructor TCanvasQuartz.CreateFromPrinter(const APrinter: TAbstractPrinter);
begin
  inherited;
end;

function TCanvasQuartz.GetCanvasScale: Single;
var
  WindowSvc: IFMXWindowService;
begin
  if Assigned(Parent) and TPlatformServices.Current.SupportsPlatformService(IFMXWindowService, IInterface(WindowSvc)) then
    Result := WindowSvc.GetWindowScale(WindowHandleToPlatform(Parent).Form)
  else if Assigned(Bitmap) then
    Result := Bitmap.BitmapScale
  else
    Result := inherited GetCanvasScale;
end;

function TCanvasQuartz.CreateSaveState: TCanvasSaveState;
begin
  Result := TCocoaCanvasSaveState.Create;
end;

procedure TCanvasQuartz.Clear(const Color: TAlphaColor);
var
  LColor: TRGBFloat;
begin
  if Context = nil then Exit;
  CGContextClearRect(Context, CGRectFromRect(RectF(0, 0, FWidth, FHeight)));
  LColor := CGColor(Color, 1);
  CGContextSetRGBFillColor(Context, LColor.r, LColor.g, LColor.b, LColor.a);
  CGContextFillRect(Context, CGRectFromRect(RectF(0, 0, FWidth, FHeight)));
end;

procedure TCanvasQuartz.ClearRect(const ARect: TRectF; const AColor: TAlphaColor);
var
  LColor: TRGBFloat;
begin
  if Context = nil then Exit;
  CGContextClearRect(Context, CGRectFromRect(ARect));
  LColor := CGColor(AColor, 1);
  CGContextSetRGBFillColor(Context, LColor.r, LColor.g, LColor.b, LColor.a);
  CGContextFillRect(Context, CGRectFromRect(ARect));
end;

function TCanvasQuartz.DoBeginScene(const AClipRects: PClipRects = nil; AContextHandle: THandle = 0): Boolean;
begin
  if FContext = nil then
  begin
    if (AContextHandle <> 0) then
      FContext := CGContextRef(AContextHandle)
    else if Assigned(Bitmap) then
    begin
      if TQuartzBitmap(Bitmap.Handle).FImage <> nil then
      begin
        CGImageRelease(TQuartzBitmap(Bitmap.Handle).FImage);
        TQuartzBitmap(Bitmap.Handle).FImage := nil;
      end;
      FContext := CGBitmapContextCreate(TQuartzBitmap(Bitmap.Handle).FData, Bitmap.Width, Bitmap.Height, 8,
        Bitmap.Width * 4, ColorSpace, kCGImageAlphaPremultipliedLast)
    end;
  end;

  Result := inherited DoBeginScene(AClipRects) and (FContext <> nil);
  if Result and (AClipRects <> nil) then
    SetClipRects(AClipRects^);
end;

procedure TCanvasQuartz.DoEndScene;
begin
  inherited DoEndScene;
  if Bitmap <> nil then
    CGContextRelease(FContext);
  if Assigned(Parent) or (Bitmap <> nil) then
    FContext := nil;
end;

procedure TCanvasQuartz.SetMatrix(const M: TMatrix);
var
  IM: TMatrix;
  CurM: CGAffineTransform;
begin
  FMatrix := M;
  if Context = nil then Exit;
  { restore CTM }
  CurM := CGContextGetCTM(Context);
  IM := IdentityMatrix;
  IM.m11 := CurM.a;
  IM.m12 := CurM.b;
  IM.m21 := CurM.c;
  IM.m22 := CurM.d;
  IM.m31 := CurM.tx;
  IM.m32 := CurM.ty;
  InvertMatrix(IM);
  CGContextConcatCTM(Context, CGAffineTransformMake(IM.m11, IM.m12, IM.m21, IM.m22, IM.m31, IM.m32));
  { Quartz inverse }
  if Assigned(Bitmap) then
    CGContextTranslateCTM(Context, 0, FHeight)
  else
    CGContextTranslateCTM(Context, 0, FHeight * Scale);
  CGContextScaleCTM(Context, Scale, -Scale);
  { Set new }
  CGContextConcatCTM(Context, CGAffineTransformMake(FMatrix.m11, FMatrix.m12, FMatrix.m21, FMatrix.m22, FMatrix.m31, FMatrix.m32));
end;

procedure TCanvasQuartz.SetClipRects(const ARects: array of TRectF);
var
  i: Integer;
  Rcts: array of CGRect;
begin
  if Context = nil then Exit;

  SetLength(Rcts, Length(ARects));
  for i := 0 to High(ARects) do
  begin
    Rcts[i] := CGRectFromRect(ARects[i]);
  end;
  CGContextClipToRects(Context, @Rcts[0], Length(Rcts));
end;

procedure TCanvasQuartz.IntersectClipRect(const ARect: TRectF);
begin
  if Context = nil then Exit;
  CGContextClipToRect(Context, CGRectFromRect(ARect));
end;

procedure TCanvasQuartz.ExcludeClipRect(const ARect: TRectF);
var
  R: TRectF;
  RR: array of CGRect;
begin
  if Context = nil then Exit;
  R := ARect;
  SetLength(RR, 4);
  RR[0] := CGRectFromRect(RectF(-FWidth, -FWidth, R.Left, FHeight));
  RR[1] := CGRectFromRect(RectF(R.Right, -FHeight, FWidth, FHeight));
  RR[2] := CGRectFromRect(RectF(R.left, -FHeight, R.Right, R.top));
  RR[3] := CGRectFromRect(RectF(R.left, R.bottom, R.Right, FHeight));
  CGContextClipToRects(Context, @RR[0], 4);
end;

var
  ShadeOpacity: single;

procedure myLinearShadingValues(info: Pointer; inp: {const} PSingle {Float32Ptr}; val: PSingle {Float32Ptr}); cdecl;
var
  c: TAlphaColor;
begin
  if info <> nil then
  begin
    c := MakeColor(TGradient(info).InterpolateColor(inp^), ShadeOpacity);
    val^ := TAlphaColorRec(c).R / $FF;
    Inc(val);
    val^ := TAlphaColorRec(c).G / $FF;
    Inc(val);
    val^ := TAlphaColorRec(c).B / $FF;
    Inc(val);
    val^ := TAlphaColorRec(c).A / $FF;
  end;
end;

function TCanvasQuartz.Context: CGContextRef;
begin
  Result := FContext;
end;

procedure TCanvasQuartz.ApplyFill(const ABrush: TBrush; ARect: TRectF; const AOpacity: single);
var
  LColor: TRGBFloat;
  RCenter: TPointF;
  B: TBitmap;
begin
  if Context = nil then Exit;

  if (ABrush.Kind = TBrushKind.bkResource) and (ABrush.Resource <> nil) and (ABrush.Resource.Brush <> nil) then
    ABrush.Assign(ABrush.Resource.Brush);

  case ABrush.Kind of
    TBrushKind.bkSolid:
      begin
        LColor := CGColor(ABrush.Color, AOpacity);
        CGContextSetRGBFillColor(Context, LColor.r, LColor.g, LColor.b, LColor.a);
      end;
    TBrushKind.bkGradient:
      begin
        FCallback.version := 0;
        FCallback.evaluate := @myLinearShadingValues;
        FCallback.releaseInfo:= nil;
        ShadeOpacity := AOpacity;
        FFunc := CGFunctionCreate(ABrush.Gradient, 1, @inputRange, 4, nil, @FCallback);
        if (ABrush.Gradient.Style = TGradientStyle.gsLinear) then
        begin
          FShading := CGShadingCreateAxial(ColorSpace,
            CGPoint(PointF(ARect.Left + ABrush.Gradient.StartPosition.X * ARect.Width,
            ARect.Top + ABrush.Gradient.StartPosition.Y * ARect.Height)),
            CGPoint(PointF(ARect.Left + ABrush.Gradient.StopPosition.X * ARect.Width,
            ARect.Top + ABrush.Gradient.StopPosition.Y * ARect.Height)), FFunc, 1, 1);
        end
        else
        begin
          RCenter := PointF(ABrush.Gradient.RadialTransform.RotationCenter.X * RectWidth(ARect),
            ABrush.Gradient.RadialTransform.RotationCenter.Y * RectHeight(ARect)) + ARect.TopLeft;
          FShading := CGShadingCreateRadial(ColorSpace, CGPoint(RCenter), RectWidth(ARect) / 2.0, CGPoint(RCenter), 0.0,
            FFunc, 1, 1);
        end;
      end;
    TBrushKind.bkResource:
      begin
      end;
    TBrushKind.bkBitmap:
      begin
        B := ABrush.Bitmap.Bitmap;
        if Assigned(B.ResourceBitmap) then
          B := B.ResourceBitmap;
        if not B.IsEmpty and B.HandleAllocated then
        begin
          CGContextSetAlpha(Context, AOpacity);
          FBitmapRef := TQuartzBitmap(B.Handle).GetImage;
        end;
      end;
  else
    CGContextSetRGBFillColor(Context, 0, 0, 0, 0);
  end;
end;

procedure TCanvasQuartz.DeApplyFill(const ABrush: TBrush; ARect: TRectF; const AOpacity: single);
begin
  if Context = nil then Exit;

  case ABrush.Kind of
    TBrushKind.bkSolid:
      begin
      end;
    TBrushKind.bkGradient:
      begin
        CGShadingRelease(FShading);
        CGFunctionRelease(FFunc);
      end;
    TBrushKind.bkResource:
      begin
      end;
    TBrushKind.bkBitmap:
      begin
        CGContextSetAlpha(Context, 1);
      end;
  end;
  FShading := nil;
  FBitmapRef := nil;
end;

procedure TCanvasQuartz.ApplyStroke(const AStroke: TStrokeBrush; ARect: TRectF; const AOpacity: single);
var
  Dash: TDashArray;
  i: Integer;
  LColor: TRGBFloat;
begin
  if Context = nil then Exit;

  if (AStroke.Kind = TBrushKind.bkResource) and (AStroke.Resource <> nil) and (AStroke.Resource.Brush <> nil) then
    AStroke.Assign(AStroke.Resource.Brush);

  case AStroke.Kind of
    TBrushKind.bkSolid:
      begin
        LColor := CGColor(AStroke.Color, AOpacity);
        CGContextSetRGBStrokeColor(Context, LColor.r, LColor.g, LColor.b, LColor.a);
      end;
    TBrushKind.bkGradient:
      begin
      end;
    TBrushKind.bkBitmap:
      begin
      end;
  else
    CGContextSetRGBStrokeColor(Context, 0, 0, 0, 0);
  end;
  case AStroke.Cap of
    TStrokeCap.scFlat: CGContextSetLineCap(Context, kCGLineCapButt);
    TStrokeCap.scRound: CGContextSetLineCap(Context, kCGLineCapRound);
  end;
  if Length(AStroke.DashArray) > 0 then
  begin
    // select the proper dash array for the printer
    if Assigned(FPrinter) then
      if AStroke.Dash <> TStrokeDash.sdCustom then
        Dash := TStrokeBrush.StdDash[TStrokeBrush.TDashDevice.ddPrinter, AStroke.Dash].DashArray
      else
        Dash := AStroke.DashArray
    else // adjust the line dashes for the screen
    begin
      SetLength(Dash, Length(AStroke.DashArray));
      for i := 0 to High(AStroke.DashArray) do
      begin
        Dash[i] := AStroke.DashArray[i] * AStroke.Thickness;
        if (AStroke.Cap = TStrokeCap.scRound) then
        begin
          if odd(i) then
            Dash[i] := (AStroke.DashArray[i] + 1) * AStroke.Thickness
          else
            Dash[i] := (AStroke.DashArray[i] - 1) * AStroke.Thickness;
        end;
      end;
    end;

    CGContextSetLineDash(Context, AStroke.DashOffset, @Dash[0], Length(AStroke.DashArray));
  end
  else
    CGContextSetLineDash(Context, 0, nil, 0);
  case AStroke.Join of
    TStrokeJoin.sjMiter: CGContextSetLineJoin(Context, kCGLineJoinMiter);
    TStrokeJoin.sjRound: CGContextSetLineJoin(Context, kCGLineJoinRound);
    TStrokeJoin.sjBevel: CGContextSetLineJoin(Context, kCGLineJoinBevel);
  end;
  CGContextSetLineWidth(Context, AStroke.Thickness);
end;

procedure TCanvasQuartz.DoDrawLine(const APt1, APt2: TPointF; const AOpacity: single; const ABrush: TStrokeBrush);
begin
  if Context = nil then Exit;
  ApplyStroke(ABrush, RectF(APt1.X, APt1.Y, APt2.X, APt2.Y), AOpacity);
  CGContextBeginPath(Context);
  CGContextMoveToPoint(Context, APt1.X, APt1.Y);
  CGContextAddLineToPoint(Context, APt2.X, APt2.Y);
  CGContextStrokePath(Context);
end;

procedure TCanvasQuartz.DoDrawRect(const ARect: TRectF; const AOpacity: single; const ABrush: TStrokeBrush);
begin
  if Context = nil then Exit;
  ApplyStroke(ABrush, ARect, AOpacity);
  CGContextStrokeRect(Context, CGRectFromRect(ARect));
end;

procedure TCanvasQuartz.DoFillRect(const ARect: TRectF; const AOpacity: single; const ABrush: TBrush);
var
  B: TBitmap;
begin
  if Context = nil then Exit;
  CGContextSaveGState(Context);
  ApplyFill(ABrush, ARect, AOpacity);
  CGContextBeginPath(Context);
  CGContextAddRect(Context, CGRectFromRect(ARect));
  CGContextClosePath(Context);
  if Assigned(FBitmapRef) then
  begin
    B := ABrush.Bitmap.Bitmap;
    if Assigned(B.ResourceBitmap) then
      B := B.ResourceBitmap;
    CGContextClip(Context);
    case ABrush.Bitmap.WrapMode of
      TWrapMode.wmTile:
        begin
          CGContextScaleCTM(Context, 1, -1);
          DrawTiledImage(Context, ARect, FBitmapRef, B);
        end;
      TWrapMode.wmTileOriginal:
        begin
          CGContextScaleCTM(Context, 1, -1);
          CGContextDrawImage(Context, CGRectFromRect(RectF(ARect.Left, ARect.Top, ARect.Left + B.Width, -ARect.Top - B.Height)), FBitmapRef);
        end;
      TWrapMode.wmTileStretch:
        begin
          CGContextScaleCTM(Context, 1, -1);
          CGContextDrawImage(Context, CGRectFromRect(RectF(ARect.Left, ARect.Top, ARect.Right, -ARect.Bottom)), FBitmapRef);
        end;
    end;
  end
  else
  if FShading <> nil then
  begin
    CGContextClip(Context);
    CGContextDrawShading(Context, FShading)
  end
  else
    CGContextFillPath(Context);
  DeApplyFill(ABrush, ARect, AOpacity);
  CGContextRestoreGState(Context);
end;

procedure TCanvasQuartz.DoDrawEllipse(const ARect: TRectF; const AOpacity: single; const ABrush: TStrokeBrush);
begin
  if Context = nil then Exit;
  ApplyStroke(ABrush, ARect, AOpacity);
  CGContextStrokeEllipseInRect(Context, CGRectFromRect(ARect));
end;

procedure TCanvasQuartz.DoFillEllipse(const ARect: TRectF; const AOpacity: single; const ABrush: TBrush);
var
  B: TBitmap;
begin
  if Context = nil then Exit;
  CGContextSaveGState(Context);
  ApplyFill(ABrush, ARect, AOpacity);
  CGContextBeginPath(Context);
  CGContextAddEllipseInRect(Context, CGRectFromRect(ARect));
  CGContextClosePath(Context);
  if Assigned(FBitmapRef) then
  begin
    B := ABrush.Bitmap.Bitmap;
    if Assigned(B.ResourceBitmap) then
      B := B.ResourceBitmap;
    CGContextClip(Context);
    case ABrush.Bitmap.WrapMode of
      TWrapMode.wmTile:
        begin
          CGContextScaleCTM(Context, 1, -1);
          DrawTiledImage(Context, ARect, FBitmapRef, B);
        end;
      TWrapMode.wmTileOriginal:
        begin
          CGContextScaleCTM(Context, 1, -1);
          CGContextDrawImage(Context, CGRectFromRect(RectF(ARect.Left, ARect.Top, ARect.Left + B.Width, -ARect.Top - B.Height)), FBitmapRef);
        end;
      TWrapMode.wmTileStretch:
        begin
          CGContextScaleCTM(Context, 1, -1);
          CGContextDrawImage(Context, CGRectFromRect(RectF(ARect.Left, ARect.Top, ARect.Right, -ARect.Bottom)), FBitmapRef);
        end;
    end;
  end
  else
  if FShading <> nil then
  begin
    CGContextClip(Context);
    CGContextDrawShading(Context, FShading)
  end
  else
    CGContextFillPath(Context);
  DeApplyFill(ABrush, ARect, AOpacity);
  CGContextRestoreGState(Context);
end;

{ Path }

procedure TCanvasQuartz.DoDrawPath(const APath: TPathData; const AOpacity: single; const ABrush: TStrokeBrush);
var
  i: Integer;
  CP1, CP2: TPointF;
begin
  if Context = nil then Exit;
  ApplyStroke(ABrush, APath.GetBounds, AOpacity);
  { draw }
  CGContextSaveGState(Context);
  CGContextBeginPath(Context);
  i := 0;
  while i < APath.Count do
  begin
    case APath[i].Kind of
      TPathPointKind.ppMoveTo:
        begin
          CGContextMoveToPoint(Context, APath[i].Point.X, APath[i].Point.Y);
        end;
      TPathPointKind.ppLineTo:
        begin
          CGContextAddLineToPoint(Context, APath[i].Point.X, APath[i].Point.Y);
        end;
      TPathPointKind.ppCurveTo:
        begin
          CP1 := PointF(APath[i].Point.X, APath[i].Point.Y);
          Inc(i);
          CP2 := PointF(APath[i].Point.X, APath[i].Point.Y);
          Inc(i);
          CGContextAddCurveToPoint(Context, CP1.X,
            CP1.Y,
            CP2.X,
            CP2.Y,
            APath[i].Point.X,
            APath[i].Point.Y);
        end;
      TPathPointKind.ppClose:
        begin
          CGContextClosePath(Context);
        end;
    end;
    inc(i);
  end;
  CGContextStrokePath(Context);
  CGContextRestoreGState(Context);
end;

procedure TCanvasQuartz.DoFillPath(const APath: TPathData; const AOpacity: single; const ABrush: TBrush);
var
  i: Integer;
  B: TRectF;
  CP1, CP2: TPointF;
  BB: TBitmap;
begin
  if Context = nil then Exit;
  B := APath.GetBounds;
  ApplyFill(ABrush, B, AOpacity);
  CGContextSaveGState(Context);
  CGContextBeginPath(Context);
  i := 0;
  while i < APath.Count do
  begin
    case APath[i].Kind of
      TPathPointKind.ppMoveTo:
        begin
          CGContextMoveToPoint(Context, APath[i].Point.X,
            APath[i].Point.Y);
        end;
      TPathPointKind.ppLineTo:
        begin
          CGContextAddLineToPoint(Context, APath[i].Point.X,
            APath[i].Point.Y);
        end;
      TPathPointKind.ppCurveTo:
        begin
          CP1 := PointF(APath[i].Point.X, APath[i].Point.Y);
          Inc(i);
          CP2 := PointF(APath[i].Point.X, APath[i].Point.Y);
          Inc(i);
          CGContextAddCurveToPoint(Context, CP1.X,
            CP1.Y,
            CP2.X,
            CP2.Y,
            APath[i].Point.X,
            APath[i].Point.Y);
        end;
      TPathPointKind.ppClose:
        begin
          CGContextClosePath(Context);
        end;
    end;
    inc(i);
  end;

  if Assigned(FBitmapRef) then
  begin
    BB := ABrush.Bitmap.Bitmap;
    if Assigned(BB.ResourceBitmap) then
      BB := BB.ResourceBitmap;
    CGContextClip(Context);
    case ABrush.Bitmap.WrapMode of
      TWrapMode.wmTile:
        begin
          CGContextScaleCTM(Context, 1, -1);
          DrawTiledImage(Context, B, FBitmapRef, BB);
        end;
      TWrapMode.wmTileOriginal:
        begin
          CGContextScaleCTM(Context, 1, -1);
          CGContextDrawImage(Context, CGRectFromRect(RectF(B.Left, B.Top, B.Left + BB.Width, -B.Top - BB.Height)), FBitmapRef);
        end;
      TWrapMode.wmTileStretch:
        begin
          CGContextScaleCTM(Context, 1, -1);
          CGContextDrawImage(Context, CGRectFromRect(RectF(B.Left, B.Top, B.Right, -B.Bottom)), FBitmapRef);
        end;
    end;
  end
  else
  if FShading <> nil then
  begin
    CGContextClip(Context);
    CGContextDrawShading(Context, FShading)
  end
  else
    CGContextEOFillPath(Context);
  DeApplyFill(ABrush, B, AOpacity);
  CGContextRestoreGState(Context);
end;

function TCanvasQuartz.PtInPath(const APoint: TPointF; const APath: TPathData): Boolean;
var
  i: Integer;
  B: TRectF;
  CP1, CP2: TPointF;
begin
  Result := False;
  if Context = nil then Exit;
  if APath.IsEmpty then Exit;
  { draw }
  B := APath.GetBounds;
  CGContextSaveGState(Context);
  CGContextTranslateCTM(Context, B.Left, B.Top);
  CGContextBeginPath(Context);
  i := 0;
  while i < APath.Count do
  begin
    case APath[i].Kind of
      TPathPointKind.ppMoveTo:
        begin
          CGContextMoveToPoint(Context, APath[i].Point.X,
            APath[i].Point.Y);
        end;
      TPathPointKind.ppLineTo:
        begin
          CGContextAddLineToPoint(Context, APath[i].Point.X,
            APath[i].Point.Y);
        end;
      TPathPointKind.ppCurveTo:
        begin
          CP1 := PointF(APath[i].Point.X,
            APath[i].Point.Y);
          Inc(i);
          CP2 := PointF(APath[i].Point.X,
            APath[i].Point.Y);
          Inc(i);
          CGContextAddCurveToPoint(Context, CP1.X,
            CP1.Y,
            CP2.X,
            CP2.Y,
            APath[i].Point.X,
            APath[i].Point.Y);
        end;
      TPathPointKind.ppClose:
        begin
          CGContextClosePath(Context);
        end;
    end;
    inc(i);
  end;
  CGContextRestoreGState(Context);
  Result := CGContextPathContainsPoint(Context, CGPoint(APoint), kCGPathFillStroke) > 0;
end;

procedure PathApplierFunction(info: Pointer; const element: PCGPathElement); cdecl;
var
  P, P1, P2: PPointF;
begin
  P := PPointF(element^.points);
  case element.type_ of
    kCGPathElementMoveToPoint:
      TPathData(info).MoveTo(P^);
    kCGPathElementAddLineToPoint:
      TPathData(info).LineTo(P^);
    kCGPathElementAddQuadCurveToPoint:
      begin
        P1 := P;
        Inc(P1);
        TPathData(info).QuadCurveTo(P^, P1^);
      end;
    kCGPathElementAddCurveToPoint:
      begin
        P1 := P;
        Inc(P1);
        P2 := P1;
        Inc(P2);
        TPathData(info).CurveTo(P^, P1^, P2^);
      end;
    kCGPathElementCloseSubpath:
      TPathData(info).ClosePath;
  end;
end;

{ Bitmaps }

class procedure TCanvasQuartz.DoInitializeBitmap(const Bitmap: TBitmap);
var
  H: TQuartzBitmap;
begin
  H := TQuartzBitmap.Create;
{$IFDEF AUTOREFCOUNT}
  H.__ObjAddRef;
{$ENDIF}
  GetMem(H.FData, Bitmap.Width * Bitmap.Height * 4);
  H.FContext := CGBitmapContextCreate(H.FData, Bitmap.Width, Bitmap.Height, 8, Bitmap.Width * 4, ColorSpace,
    kCGImageAlphaPremultipliedLast);
  (Bitmap as IBitmapAccess).Handle := THandle(H);
  (Bitmap as IBitmapAccess).PixelFormat := pfA8B8G8R8;
end;

class procedure TCanvasQuartz.DoFinalizeBitmap(const Bitmap: TBitmap);
var
  H: TQuartzBitmap;
begin
  H := TQuartzBitmap(Bitmap.Handle);
{$IFDEF AUTOREFCOUNT}
  H.__ObjRelease;
{$ENDIF}
  if H.FImage <> nil then
    CGImageRelease(H.FImage);
  H.FImage := nil;
  if H.FContext <> nil then
    CGContextRelease(H.FContext);
  FreeMem(H.FData);
  H.FData := nil;
  H.Free;
end;

class function TCanvasQuartz.DoMapBitmap(const Bitmap: TBitmap; const Access: TMapAccess; var Data: TBitmapData): Boolean;
var
  H: TQuartzBitmap;
begin
  H := TQuartzBitmap(Bitmap.Handle);
  if (Access <> TMapAccess.maRead) and Assigned(H.FImage) then
  begin
    CGImageRelease(H.FImage);
    H.FImage := nil;
  end;
  Data.Data := H.FData;
  Data.Pitch := Bitmap.Width * 4;
  Result := Data.Data <> nil;
end;

class procedure TCanvasQuartz.DoUnmapBitmap(const Bitmap: TBitmap; var Data: TBitmapData);
begin
end;

procedure TCanvasQuartz.DoDrawBitmap(const ABitmap: TBitmap; const SrcRect, DstRect: TRectF; const AOpacity: Single;
      const HighSpeed: Boolean = False);
var
  R, SubR: CGRect;
  ImgRef, SubImgRef: CGImageRef;
begin
  if Context = nil then Exit;
  if ABitmap = nil then Exit;

  if (ABitmap.HandleAllocated) then
  begin
    R := CGRectFromRect(DstRect);
    if (SrcRect.Left = 0) and (SrcRect.Top = 0) and (SrcRect.Right = ABitmap.Width) and (SrcRect.Bottom = ABitmap.Height) then
    begin
      ImgRef := TQuartzBitmap(ABitmap.Handle).GetImage;
      CGContextSaveGState(Context);
      CGContextSetAlpha(Context, AOpacity);

      if HighSpeed then
        CGContextSetInterpolationQuality(Context, kCGInterpolationNone)
      else
        CGContextSetInterpolationQuality(Context, kCGInterpolationLow);

      // flip
      R.origin.y := -DstRect.Bottom;
      CGContextScaleCTM(Context, 1, -1);
      //

      CGContextDrawImage(Context, R, ImgRef);

      CGContextRestoreGState(Context);
    end
    else
    begin
      SubR := CGRectFromRect(SrcRect);

      ImgRef := TQuartzBitmap(ABitmap.Handle).GetImage;
      SubImgRef := CGImageCreateWithImageInRect(ImgRef, SubR);
      if SubImgRef <> nil then
      begin
        CGContextSaveGState(Context);
        CGContextSetAlpha(Context, AOpacity);
        if HighSpeed then
          CGContextSetInterpolationQuality(Context, kCGInterpolationNone)
        else
          CGContextSetInterpolationQuality(Context, kCGInterpolationLow);

        // flip
        R.origin.y := -DstRect.Bottom;
        CGContextScaleCTM(Context, 1, -1);
        //
        CGContextDrawImage(Context, R, SubImgRef);
        CGImageRelease(SubImgRef);
        CGContextRestoreGState(Context);
      end;
    end;
  end;
end;

{ TTextLayoutCT }

procedure TTextLayoutCT.ConvertToPath(const APath: TPathData);
  var
  i, j, k: Integer;
  LFontRef: CTFontRef;
  Line: CTLineRef;
  Lines: CFArrayRef;
  NumLines: CFIndex;
  glyphPath: CGPathRef;
  Runs: CFArrayRef;
  Run: CTRunRef;
  RunGlyphCount: CFIndex;
  glyph: CGGlyph;
  position:  CGPoint;
  glyphMatrix: CGAffineTransform;
  M: TMatrix;
  TextR: TRectF;
  LinePath: TPathData;
  LinesHeight, LineHeight: Single;
  Ascent, Descent, Leading: CGFloat;
  FrameRect: CGRect;
begin
  if not Assigned(FCTAttr) or not Assigned(APath) then
    Exit;

  CreateCTFrame;
  //Creating font for paragraph
  LFontRef := GetCTFontRef(Font);
  Lines := CTFrameGetLines(FCTFrame);
  NumLines := CFArrayGetCount(Lines);
  FrameRect := CGPathGetBoundingBox(FCTPath);
  LinesHeight := 0;
  for i := 0 to NumLines - 1 do
  begin
    LinePath := TPathData.Create;
    Line := CTLineRef(CFArrayGetValueAtIndex(Lines, i));
    //Getting line dimentions to calculate each line vertical shift
    CTLineGetTypographicBounds(Line, @Ascent,  @Descent, @Leading);
    if i > 0 then
    begin
      CTFrameGetLineOrigins(FCTFrame, CFRangeMake(i, 1), @position);
      LineHeight := CGRectGetMaxY(FrameRect) - position.y + descent - LinesHeight;
      LinesHeight := CGRectGetMaxY(FrameRect) - position.y + descent;
      APath.Translate(0, LineHeight);
    end
    else
    begin
      CTFrameGetLineOrigins(FCTFrame, CFRangeMake(i, 1), @position);
      LinesHeight := CGRectGetMaxY(frameRect) - position.y + descent;
    end;
    Runs := CTLineGetGlyphRuns(Line);
    for j := 0 to CFArrayGetCount(Runs) - 1 do
    begin
      Run := CFArrayGetValueAtIndex(Runs, j);
      RunGlyphCount := CTRunGetGlyphCount(Run);
      for k := 0 to RunGlyphCount - 1 do
      begin
        CTRunGetGlyphs(Run, CFRangeMake(k, 1), @glyph);
        CTRunGetPositions(run, CFRangeMake(k, 1), @position);
                                                                                      
        glyphMatrix := CGAffineTransformTranslate(CGAffineTransformIdentity,
          position.x, position.y);
        glyphPath := CTFontCreatePathForGlyph(LFontRef, glyph, @glyphMatrix);
         CGPathApply(glyphPath, LinePath, @PathApplierFunction);
      end;
    end;
    //Adding line path to all path
    TextR := LinePath.GetBounds;
    case HorizontalAlign of
      TTextAlign.taCenter:
        begin
          OffsetRect(TextR, -TextR.Left, 0);
          OffsetRect(TextR, (MaxSize.X - Padding.Left - Padding.Right - TextR.Width) / 2, 0);
          OffsetRect(TextR, TopLeft.X, 0);
        end;
      TTextAlign.taLeading:
        begin
          OffsetRect(TextR, -TextR.Left, 0);
          OffsetRect(TextR, TopLeft.X, 0);
        end;
      TTextAlign.taTrailing:
        begin
          OffsetRect(TextR, -TextR.Left, 0);
          OffsetRect(TextR, (MaxSize.X - Padding.Left - Padding.Right - TextR.Width), 0);
          OffsetRect(TextR, TopLeft.X, 0);
        end;
    end;
    //Only horizontal alignment
    LinePath.Translate(TextR.Left, 0);
    APath.Data := APath.Data + LinePath.Data;
    FreeAndNil(LinePath);
  end;
  CFRelease(LFontRef);
  //
  TextR := APath.GetBounds;

  M := IdentityMatrix;
  M.m22 := -1;
  M.m32 := TextR.Height;
  APath.ApplyMatrix(M);

  TextR := APath.GetBounds;

  case VerticalAlign of
    TTextAlign.taCenter:
      begin
        OffsetRect(TextR, 0, -TextR.Top);
        OffsetRect(TextR, 0, (MaxSize.Y - Padding.Top - Padding.Bottom - TextR.Height) / 2);
        OffsetRect(TextR, 0, TopLeft.Y);
      end;
    TTextAlign.taLeading:
      begin
        OffsetRect(TextR, 0, -TextR.Top);
        OffsetRect(TextR, 0, TopLeft.Y);
      end;
    TTextAlign.taTrailing:
      begin
        OffsetRect(TextR, 0, -TextR.Top);
        OffsetRect(TextR, 0, (MaxSize.Y - Padding.Top - Padding.Bottom - TextR.Height));
        OffsetRect(TextR, 0, TopLeft.Y);
      end;
  end;
  APath.Translate(0, TextR.Top);
end;

procedure AddColorAttribute(AAttribute: CFMutableAttributedStringRef;
  AColor: TAlphaColor; AOpacity: Single; const AStart, ALength: Integer);
var
  AlphaRec: TAlphaColorRec;
  rgba: array [0..3] of Single;
  TextColor: CGColorRef;
begin
  AlphaRec := TAlphaColorRec(MakeColor(AColor, AOpacity));
  rgba[0] := AlphaRec.R / $FF;
  rgba[1] := AlphaRec.G / $FF;
  rgba[2] := AlphaRec.B / $FF;
  rgba[3] := AlphaRec.A / $FF;

  TextColor := CGColorCreate(ColorSpace, @rgba[0]);
  CFAttributedStringSetAttribute(AAttribute, CFRangeMake(AStart, ALength),
    kCTForegroundColorAttributeName, TextColor);
  CFRelease(TextColor);
end;

procedure TTextLayoutCT.CreateCT;

  procedure AddFontAttribute(AAttribute: CFMutableAttributedStringRef;
    AFont: TFont; const AStart, ALength: Integer);
  var
    LFontRef: CTFontRef;
    Underline: CFNumberRef;
    LValue: Cardinal;
  begin
    //Font
    LFontRef := GetCTFontRef(AFont);
    if Assigned(LFontRef) then
    try
      CFAttributedStringSetAttribute(AAttribute, CFRangeMake(AStart, ALength),
        kCTFontAttributeName, LFontRef);
    finally
      CFRelease(LFontRef);
    end;
    //Underline
    if TFontStyle.fsUnderline in AFont.Style then
    begin
      LValue := kCTUnderlineStyleSingle;
      Underline := CFNumberCreate(nil, kCFNumberSInt32Type, @LValue);
      CFAttributedStringSetAttribute(AAttribute, CFRangeMake(AStart, ALength),
        kCTUnderlineStyleAttributeName, Underline);
    end;
  end;

var
  LStringRef: CFStringRef;
  LValue: Cardinal;
  Ligature: CFNumberRef;
  Alignment: Byte;
  Direction: Byte;
  Wrapping: Byte;
  Settings: array of CTParagraphStyleSetting;
  ParagraphStyle: CTParagraphStyleRef;
  Bounds: CGRect;
  i: Integer;
  LText: string;
begin
  if Assigned(FCTFrame) then
    CFRelease(FCTFrame);
  FCTFrame := nil;
  if Assigned(FCTAttr) then
    CFRelease(FCTAttr);
  FCTAttr := nil;
  if Assigned(FCTPath) then
    CFRelease(FCTPath);
  FCTPath := nil;

  FCTPath := CGPathCreateMutable();
  Bounds := CGRectMake(0, 0,
    MaxSize.X - Padding.Left - Padding.Right, $FFFF);
//  if not WordWrap then
//    Bounds.size.width := $FFFF;
  CGPathAddRect(FCTPath, nil, Bounds);

  if Text.Length = 0 then
    LText := ' '
  else
    LText := Text;
  LStringRef := CFStringCreateWithCharacters(kCFAllocatorDefault, PChar(LText),
    LText.Length);
  try
    FCTAttr := CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    CFAttributedStringReplaceString(FCTAttr, CFRangeMake(0, 0), LStringRef);

    CFAttributedStringBeginEditing(FCTAttr);
    try
      //Ligature
      LValue := 0;
      Ligature := CFNumberCreate(nil, kCFNumberSInt32Type, @LValue);
      CFAttributedStringSetAttribute(FCTAttr, CFRangeMake(0, LText.Length),
        kCTLigatureAttributeName, Ligature);
      
      //Font
      AddFontAttribute(FCTAttr, Font, 0, LText.Length);

      //Align
      SetLength(Settings, Length(Settings) + 1);
      case HorizontalAlign of
        TTextAlign.taCenter:
          Alignment := kCTCenterTextAlignment;
        TTextAlign.taLeading:
          Alignment := kCTLeftTextAlignment;
        TTextAlign.taTrailing:
          Alignment := kCTRightTextAlignment;
      end;
      Settings[High(Settings)].spec := kCTParagraphStyleSpecifierAlignment;
      Settings[High(Settings)].valueSize := sizeof(Alignment);
      Settings[High(Settings)].value := @Alignment;

      //Word wrap and trimming
      SetLength(Settings, Length(Settings) + 1);
      if WordWrap then
        Wrapping := kCTLineBreakByWordWrapping
      else
        case Trimming of
          TTextTrimming.ttNone:
            //No trim - just clipping text
            Wrapping := kCTLineBreakByClipping;
          TTextTrimming.ttCharacter, TTextTrimming.ttWord:
            Wrapping := kCTLineBreakByTruncatingTail;
        end;
      Settings[High(Settings)].spec := kCTParagraphStyleSpecifierLineBreakMode;
      Settings[High(Settings)].valueSize := SizeOf(Wrapping);
      Settings[High(Settings)].value := @Wrapping;

      //Right to left text
      SetLength(Settings, Length(Settings) + 1);
      if RightToLeft then
        Direction := kCTWritingDirectionRightToLeft
      else
        Direction := kCTWritingDirectionLeftToRight;
      Settings[High(Settings)].spec := kCTParagraphStyleSpecifierBaseWritingDirection;
      Settings[High(Settings)].valueSize := SizeOf(Direction);
      Settings[High(Settings)].value := @Direction;

      ParagraphStyle := CTParagraphStyleCreate(@Settings[0], Length(Settings));

      CFAttributedStringSetAttribute(FCTAttr, CFRangeMake(0, CFStringGetLength(LStringRef)), kCTParagraphStyleAttributeName, ParagraphStyle);

      CFRelease(ParagraphStyle);

      //Applying attributes
      for i := 0 to AttributesCount - 1 do
        if Assigned(Attributes[i].Attribute.Font) then
          //Checking for changes or we will get an SIGSERV error
          if (Attributes[i].Attribute.Font.Family <> Font.Family) or
             (Attributes[i].Attribute.Font.Size <> Font.Size) or
             (Attributes[i].Attribute.Font.Style <> Font.Style) then
            AddFontAttribute(FCTAttr, Attributes[i].Attribute.Font,
              Attributes[i].Range.Pos, Attributes[i].Range.Length);
    finally
      CFAttributedStringEndEditing(FCTAttr);
    end;
  finally
    CFRelease(LStringRef);
  end;
end;

procedure TTextLayoutCT.CreateCTFrame;
var
  FrameSetter: CTFramesetterRef;
  i: Integer;
  LAttr: CFMutableAttributedStringRef;
begin
  if not Assigned(FCTFrame) then
  begin
    LAttr := CFAttributedStringCreateMutableCopy(kCFAllocatorDefault, 0, CFAttributedStringRef(FCTAttr));
    FLastColor := Color;
    FLastOpacity := Opacity;
    //Applying color attributes
    CFAttributedStringBeginEditing(LAttr);
    try
      AddColorAttribute(LAttr, Color, Opacity, 0, Text.Length);
      for i := 0 to AttributesCount - 1 do
        if (Color <> Attributes[i].Attribute.Color) then
          AddColorAttribute(LAttr, Attributes[i].Attribute.Color, Opacity,
            Attributes[i].Range.Pos, Attributes[i].Range.Length);
    finally
      CFAttributedStringEndEditing(LAttr);
    end;
    FrameSetter := CTFramesetterCreateWithAttributedString(CFAttributedStringRef(LAttr));
    CFRelease(LAttr);
    FCTFrame := CTFramesetterCreateFrame(FrameSetter, CFRangeMake(0, 0), FCTPath, nil);
    CFRelease(FrameSetter);
  end;
end;

destructor TTextLayoutCT.Destroy;
begin
  if Assigned(FCTFrame) then
    CFRelease(FCTFrame);
  if Assigned(FCTAttr) then
    CFRelease(FCTAttr);
  if Assigned(FCTPath) then
    CFRelease(FCTPath);
  inherited;
end;

procedure TTextLayoutCT.DoDrawLayout(const ACanvas: TCanvas);
var
  { strikeout }
  leftLines: CFArrayRef;
  origins: array of CGPoint;
  lineIndex: NSInteger;
  i, j: Integer;
  runs: CFArrayRef;
  lineBounds: CGRect;
  oneLine: CTLineRef;
  offset: CGFloat;
  oneRun: CTRunRef;
  ascent: CGFloat;
  descent: CGFloat;
  rwidth: CGFloat;
  bounds: CGRect;
  y: CGFloat;
  LColor: TRGBFloat;
begin
  if not Assigned(FCTAttr) or (TCanvasQuartz(ACanvas).Context = nil)
     or Text.IsEmpty then
    Exit;

  CGContextSaveGState(TCanvasQuartz(ACanvas).Context);
  try
    CGContextClipToRect(TCanvasQuartz(ACanvas).Context,
      CGRectMake(TopLeft.X, TopLeft.Y, MaxSize.X, MaxSize.Y));

    CGContextSetTextMatrix(TCanvasQuartz(ACanvas).Context,
      CGAffineTransformMakeScale(1.0, 1.0));

    CGContextTranslateCTM(TCanvasQuartz(ACanvas).Context,
      TopLeft.X, TopLeft.Y + MaxSize.Y);
    CGContextScaleCTM(TCanvasQuartz(ACanvas).Context, 1, -1);

    CGContextTranslateCTM(TCanvasQuartz(ACanvas).Context,
      0, -($FFFF - MaxSize.Y));

    //Applying vertical align
    case VerticalAlign of
      TTextAlign.taCenter:
        CGContextTranslateCTM(TCanvasQuartz(ACanvas).Context,
          0, -(MaxSize.Y - FTextHeight + Padding.Top - Padding.Bottom) / 2);
      TTextAlign.taLeading:
        CGContextTranslateCTM(TCanvasQuartz(ACanvas).Context, 0, -Padding.Top);
      TTextAlign.taTrailing:
        CGContextTranslateCTM(TCanvasQuartz(ACanvas).Context,
          0, -(MaxSize.Y - FTextHeight - Padding.Bottom));
    end;
    //Horizontal alignment
//    if not WordWrap then
//      case HorizontalAlign of
//        TTextAlign.taCenter:
//          CGContextTranslateCTM(TCanvasQuartz(ACanvas).Context,
//            -($FFFF / 2) + (MaxSize.X + Padding.Left - Padding.Right) / 2, 0);
//        TTextAlign.taLeading:
//          CGContextTranslateCTM(TCanvasQuartz(ACanvas).Context, Padding.Left, 0);
//        TTextAlign.taTrailing:
//          CGContextTranslateCTM(TCanvasQuartz(ACanvas).Context,
//            -$FFFF + (MaxSize.X - Padding.Right), 0);
//    end;
    if Assigned(FCTFrame) and ((Color <> FLastColor) or (Opacity <> FLastOpacity)) then
    begin
      CFRelease(FCTFrame);
      FCTFrame := nil;
    end;
      CreateCTFrame;
    //
    CTFrameDraw(FCTFrame, TCanvasQuartz(ACanvas).Context);
    { strikeout }
    if TFontStyle.fsStrikeOut in Font.Style then
    begin
      CGContextSetTextPosition(TCanvasQuartz(ACanvas).Context, 0, 0);
      leftLines := CTFrameGetLines(FCTFrame);
      SetLength(origins, CFArrayGetCount(leftLines));
      CTFrameGetLineOrigins(FCTFrame, CFRangeMake(0, 0), @origins[0]);
      lineIndex := 0;
      for i := 0 to High(origins) do
      begin
        oneLine := CFArrayGetValueAtIndex(leftLines, i);
        runs := CTLineGetGlyphRuns(oneLine);
        lineBounds := CTLineGetImageBounds(oneLine, TCanvasQuartz(ACanvas).Context);
        lineBounds.origin.x := lineBounds.origin.x + origins[lineIndex].x;
        lineBounds.origin.y := lineBounds.origin.y + origins[lineIndex].y;
        lineIndex := lineIndex + 1;
        offset := 0;
        for j := 0 to CFArrayGetCount(runs) - 1 do
        begin
          oneRun := CFArrayGetValueAtIndex(runs, j);
          ascent := 0;
          descent := 0;
          rwidth := CTRunGetTypographicBounds(oneRun, CFRangeMake(0, 0), @ascent, @descent, nil);
          bounds := CGRectFromRect(RectF(lineBounds.origin.x + offset, lineBounds.origin.y, lineBounds.origin.x + offset + rwidth,
            lineBounds.origin.y + Font.Size - descent));
          if (bounds.origin.x + bounds.size.width > CGRectGetMaxX(lineBounds)) then
            bounds.size.width := CGRectGetMaxX(lineBounds) - bounds.origin.x;
          LColor := CGColor(Color, Opacity);
          CGContextSetRGBStrokeColor(TCanvasQuartz(ACanvas).Context, LColor.r, LColor.g, LColor.b, LColor.a);
          y := round(bounds.origin.y + bounds.size.height / 2.0);
          CGContextMoveToPoint(TCanvasQuartz(ACanvas).Context, bounds.origin.x, y);
          CGContextAddLineToPoint(TCanvasQuartz(ACanvas).Context, bounds.origin.x + bounds.size.width, y);
          CGContextStrokePath(TCanvasQuartz(ACanvas).Context);
          offset := offset + width;
        end;
      end;
    end;
  finally
    CGContextRestoreGState(TCanvasQuartz(ACanvas).Context);
  end;
end;

procedure TTextLayoutCT.DoRenderLayout;
begin
  CreateCT;
  MeasureCT;
end;

function TTextLayoutCT.GetCTFontRef(const AFont: TFont): CTFontRef;
var
  LFontRef, NewFontRef: CTFontRef;
  Matrix: PCGAffineTransform;
begin
  Result := nil;
  Matrix := nil;
  LFontRef := CTFontCreateWithName(CFSTR(AFont.Family), AFont.Size, nil);
  try
    if TFontStyle.fsItalic in AFont.Style then
    begin
      NewFontRef := CTFontCreateCopyWithSymbolicTraits(LFontRef, 0, nil,
        kCTFontItalicTrait, kCTFontItalicTrait);
      if Assigned(NewFontRef) then
      begin
        CFRelease(LFontRef);
        LFontRef := NewFontRef;
      end
      else
      begin
        Matrix := @ItalicMatrix;
        //Font has no Italic version, applying transform matrix
        NewFontRef := CTFontCreateWithName(CFSTR(AFont.Family), AFont.Size, @ItalicMatrix);
        if Assigned(NewFontRef) then
        begin
          CFRelease(LFontRef);
          LFontRef := NewFontRef;
        end;
      end;
    end;
    if TFontStyle.fsBold in AFont.Style then
    begin
      NewFontRef := CTFontCreateCopyWithSymbolicTraits(LFontRef, 0, Matrix,
        kCTFontBoldTrait, kCTFontBoldTrait);
      if Assigned(NewFontRef) then
      begin
        CFRelease(LFontRef);
        LFontRef := NewFontRef;
      end;
    end;
    Result := LFontRef;
  except
    CFRelease(LFontRef);
  end;
end;

function TTextLayoutCT.GetTextHeight: Single;
begin
  Result := FTextHeight;
end;

function TTextLayoutCT.GetTextRect: TRectF;
begin
  Result := TRectF.Create(0, 0, FTextWidth, FTextHeight);
  Result.Offset(TopLeft);
  case VerticalAlign of
    TTextAlign.taCenter:
      Result.Offset(0, (MaxSize.Y - FTextHeight + Padding.Top - Padding.Bottom) / 2);
    TTextAlign.taLeading:
      Result.Offset(0, Padding.Top);
    TTextAlign.taTrailing:
      Result.Offset(0, (MaxSize.Y - FTextHeight - Padding.Bottom));
  end;
end;

function TTextLayoutCT.GetTextWidth: Single;
begin
  Result := FTextWidth;
end;

procedure TTextLayoutCT.MeasureCT;
var
  LFrameRect: CGRect;
  Lines: CFArrayRef;
  NumLines: CFIndex;
  MaxWidth: CGFloat;
  TextHeight: CGFloat;
  LastLineIndex: CFIndex;
  Index: CFIndex;
  LAscent, LDescent, LLeading, LWidth: CGFloat;
  Line: CTLineRef;
  LastLineOrigin: CGPoint;
begin
  FTextHeight := 0;
  FTextWidth := 0;
  if Assigned(FCTAttr) then
  begin
    CreateCTFrame;
    LFrameRect := CGPathGetBoundingBox(FCTPath);
    Lines := CTFrameGetLines(FCTFrame);
    NumLines := CFArrayGetCount(Lines);
    MaxWidth := 0;
    TextHeight := 0;
    LastLineIndex := NumLines - 1;

    for Index := 0 to NumLines - 1 do
    begin
      Line := CTLineRef(CFArrayGetValueAtIndex(Lines, Index));
      LWidth := CTLineGetTypographicBounds(Line, @LAscent,  @LDescent, @LLeading);
      MaxWidth := Max(LWidth, MaxWidth);
      if Index = LastLineIndex then
      begin
        CTFrameGetLineOrigins(FCTFrame, CFRangeMake(LastLineIndex, 1), @LastLineOrigin);
        TextHeight := CGRectGetMaxY(LFrameRect) - LastLineOrigin.y + LDescent;
      end;
    end;
    //
    FTextWidth := MaxWidth;
    FTextHeight := TextHeight;
  end;
end;

function TTextLayoutCT.DoPositionAtPoint(const APoint: TPointF): Integer;
var
  Line: CTLineRef;
  Lines: CFArrayRef;
  NumLines: CFIndex;
  i: Integer;
  Index: CFIndex;
  LineOrigin: CGPoint;
  Ascent, Descent, Leading, Width: CGFloat;
  LRect: TRectF;
  FrameMaxY, LineHeight, LinesBeforeHeight: CGFloat;
begin
  Result := -1;

  if not Assigned(FCTAttr) then
    Exit;

  LRect := Self.TextRect;
  if not ((APoint.X >= LRect.Left) and (APoint.X <= LRect.Right) and
     (APoint.Y >= LRect.Top) and (APoint.Y <= LRect.Bottom)) then
    begin
      if ((APoint.X >= LRect.Left) and (APoint.X <= (LRect.Left + MaxSize.X)) and
         (APoint.Y >= LRect.Top) and (APoint.Y <= LRect.Bottom)) then
        Result := Text.Length;
      Exit;
    end;
  if Text.IsEmpty then
    Exit(0);

  CreateCTFrame;
  Lines := CTFrameGetLines(FCTFrame);
  NumLines := CFArrayGetCount(Lines);
  FrameMaxY := CGRectGetMaxY(CGPathGetBoundingBox(FCTPath));
  LinesBeforeHeight := 0;
  for i := 0 to NumLines - 1 do
  begin
    Line := CTLineRef(CFArrayGetValueAtIndex(Lines, i));
    Width := CTLineGetTypographicBounds(Line, @Ascent,  @Descent, @Leading);
    if Width = 0 then
      Continue;
    CTFrameGetLineOrigins(FCTFrame, CFRangeMake(i, 1), @LineOrigin);
    LineHeight := FrameMaxY - LineOrigin.y + Descent - LinesBeforeHeight;
    if (APoint.Y >= (TopLeft.Y + Padding.Top + LinesBeforeHeight)) and
      (APoint.Y < (TopLeft.Y + Padding.Top + LinesBeforeHeight + LineHeight)) then
    begin
      Index := CTLineGetStringIndexForPosition(Line,
        NSPoint(TPointF.Create(APoint.X - Padding.Left - LineOrigin.x - TopLeft.X,
          $FFFF - APoint.Y - Padding.Top - TopLeft.Y)));
      if Index >= 0 then
      begin
        Result := Index;
        if Result > 0 then
        begin
          Ascent := CTLineGetOffsetForStringIndex(Line, Result, nil);
          Descent := CTLineGetOffsetForStringIndex(Line, Result - 1, nil);
          Width := Ascent - Descent;
          if (Width > 0) and (APoint.X < (TopLeft.X + Padding.Left + Descent + Width * 3 / 5)) then
            Dec(Result);
        end;
        Break;
      end;
    end;
    LinesBeforeHeight := LinesBeforeHeight + LineHeight;
  end;
end;

function TTextLayoutCT.DoRegionForRange(const ARange: TTextRange): TRegion;
var
  Line: CTLineRef;
  Lines: CFArrayRef;
  NumLines: CFIndex;
  Range: CFRange;
  Runs: CFArrayRef;
  Run: CTRunRef;
  i, j, k: Integer;
  LineOrigin: CGPoint;
  RunGlyphCount: CFIndex;
  Positions: array of CGPoint;
  Advances: array of CGSize;
  Ascent, Descent, Leading, Width: CGFloat;
  Cur: Integer;
  CurLine: TRegion;
  RangeLength, RemainsLength: Integer;
  LRange: TTextRange;
begin
  if not Assigned(FCTAttr) or (ARange.Pos < 0) then
    Exit;

  if Text.Length = 0 then
  begin
    //Getting rect at the end of the text
    SetLength(Result, 1);
    Result[0] := Self.TextRect;
    Result[0].Width := 0;
    Exit;
  end;

  RangeLength := Text.Length;
  if ARange.Pos > RangeLength then
    Exit;

  CreateCTFrame;
  SetLength(Result, 0);
  LRange := ARange;
  if (ARange.Pos = Text.Length) and (ARange.Length = 0) then
  begin
    LRange.Length := 1;
    LRange.Pos := Text.Length - 1;
  end;

  RemainsLength := Min(LRange.Length, RangeLength - LRange.Pos);

  Lines := CTFrameGetLines(FCTFrame);
  NumLines := CFArrayGetCount(Lines);
  for i := 0 to NumLines - 1 do
  begin
    Line := CTLineRef(CFArrayGetValueAtIndex(Lines, i));
    Range := CTLineGetStringRange(Line);
    if (Range.location + RemainsLength) < 0 then
      Continue;
    if Range.location > (LRange.Pos + RemainsLength) then
      Break;
    Width := CTLineGetTypographicBounds(Line, @Ascent,  @Descent, @Leading);
    if Width = 0 then
      Continue;
    CTFrameGetLineOrigins(FCTFrame, CFRangeMake(i, 1), @LineOrigin);
    Runs := CTLineGetGlyphRuns(Line);
    Cur := 0;
    SetLength(CurLine, 0);
    for j := 0 to CFArrayGetCount(Runs) - 1 do
    begin
      Run := CFArrayGetValueAtIndex(Runs, j);
      RunGlyphCount := CTRunGetGlyphCount(Run);
      if RunGlyphCount > 0 then
      begin
        SetLength(Positions, RunGlyphCount);
        SetLength(Advances, RunGlyphCount);
        CTRunGetPositions(Run, CFRangeMake(0, 0), @Positions[0]);
        CTRunGetAdvances(Run, CFRangeMake(0, 0), @Advances[0]);
        for k := 0 to RunGlyphCount - 1 do
        begin
          if (((Range.location + Cur) >= LRange.Pos) and ((Range.location + Cur) < (LRange.Pos + RemainsLength))) or
             ((RemainsLength = 0) and ((Range.location + Cur) = 0))  then
          begin
            SetLength(CurLine, Length(CurLine) + 1);
            CurLine[High(CurLine)] := TRectF.Create(LineOrigin.x + Positions[k].x,
              $FFFF - (LineOrigin.y + Ascent + Descent),
              LineOrigin.x + Positions[k].x + Advances[k].width,
              $FFFF - (LineOrigin.y - Descent));
            if VerticalAlign <> TTextAlign.taLeading then
              CurLine[High(CurLine)].Offset(0, Leading);
            //Reseting width if selection length is 0 (i.e. only position
            //need to be calculated, not a region)
            if RangeLength = 0 then
              CurLine[High(CurLine)].Width := 0;
          end;
          Cur := Cur + 1;
        end;
      end;
    end;
    if Length(CurLine) > 0 then
    begin
      SetLength(Result, Length(Result) + 1);
      Result[High(Result)] := CurLine[0];
      for j := 0 to High(CurLine) do
        Result[High(Result)].Union(CurLine[j]);
      Result[High(Result)].Offset(TopLeft);
      Result[High(Result)].Offset(Padding.Left, Padding.Top);
      if (ARange.Pos = Text.Length) and (ARange.Length = 0) then
        Result[0].Left := Result[0].Right;
    end;
  end;
end;

procedure RegisterCanvasClasses;
begin
  TCanvasManager.RegisterCanvas(TCanvasQuartz, True, True);
end;

procedure UnregisterCanvasClasses;
begin
end;

{ TQuartzBitmap }

function TQuartzBitmap.GetImage: CGImageRef;
begin
  if FImage = nil then
    FImage := CGBitmapContextCreateImage(FContext);
  Result := FImage;
end;


initialization
  TTextLayoutManager.RegisterTextLayout(TTextLayoutCT, TCanvasQuartz);
  TBitmapCodecManager.RegisterBitmapCodecClass('.jpg', SVJPGImages, True, TBitmapCodecQuartz);
  TBitmapCodecManager.RegisterBitmapCodecClass('.jpeg', SVJPGImages, True, TBitmapCodecQuartz);
  TBitmapCodecManager.RegisterBitmapCodecClass('.png', SVPNGImages, True, TBitmapCodecQuartz);
finalization
  if MyColorSpace <> nil then
    CGColorSpaceRelease(MyColorSpace);
end.
