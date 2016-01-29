{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Canvas.D2D;

{.$DEFINE D2DEBUG}

interface

procedure RegisterCanvasClasses;
procedure UnregisterCanvasClasses;

implementation

uses
  Winapi.Windows, Winapi.Messages, Winapi.MultiMon, Winapi.ActiveX, Winapi.Wincodec, Winapi.UxTheme,
  Winapi.DxgiFormat, Winapi.DxgiType, Winapi.DXGI, Winapi.D2D1, Winapi.D3D10,
  System.Types, System.Classes, System.SysUtils,  System.Math, System.Win.ComObj, System.Generics.Collections,
  System.UITypes, System.UIConsts, FMX.Types, FMX.Platform.Win, FMX.Forms, FMX.Consts, FMX.Types3D,
  FMX.TextLayout, FMX.PixelFormats, FMX.Surfaces, FMX.Context.DX10;

const
  TargetMode: TD2D1RenderTargetType = D2D1_RENDER_TARGET_TYPE_DEFAULT;

var
  Res: HResult;

type

{ TD2DCanvasSaveState }

  TD2DCanvasSaveState = class(TCanvasSaveState)
  private
    FStateBlock: ID2D1DrawingStateBlock;
    FLayer: ID2D1Layer;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure CreateLayer(const RenderTarget: ID2D1RenderTarget); inline;
    property Layer: ID2D1Layer read FLayer;
  end;

{ TBitmapCodecWIC }

  TBitmapCodecWIC = class(TCustomBitmapCodec)
  public
    class function GetImageSize(const AFileName: string): TPointF; override;
    class function IsValid(const AStream: TStream): Boolean; override;
    function LoadFromFile(const AFileName: string; const Bitmap: TBitmapSurface): Boolean; override;
    function SaveToFile(const AFileName: string; const Bitmap: TBitmapSurface;
      const SaveParams: PBitmapCodecSaveParams = nil): Boolean; override;
    function LoadThumbnailFromFile(const AFileName: string;
      const AFitWidth, AFitHeight: Single; const UseEmbedded: Boolean;
      const Bitmap: TBitmapSurface): Boolean; override;
    function LoadFromStream(const AStream: TStream; const Bitmap: TBitmapSurface): Boolean; override;
    function SaveToStream(const AStream: TStream; const Bitmap: TBitmapSurface;
      const Extension: string; const SaveParams: PBitmapCodecSaveParams = nil): Boolean; override;
  end;

{ TCanvasD2D }

  TD2DBitmap = class
  private
    Bitmap: TBitmap;
    Texture: ID3D10Texture2D;
    SharedBitmap: ID2D1Bitmap;
    Access: TMapAccess;
    MapBuffer: ID3D10Texture2D;
  public
    function CreateBitmap(RenderTarget: ID2D1RenderTarget): ID2D1Bitmap;
  end;

  TCanvasD2D = class(TCanvas)
  private class var
    FFactory: ID2D1Factory;
    FDWriteFactory: IDWriteFactory;
    FImagingFactory: IWICImagingFactory;
    FSharedTexture: ID3D10Texture2D;
    FSharedRenderTarget: ID2D1RenderTarget;
    class function SharedRenderTarget: ID2D1RenderTarget; static;
    class function Factory: ID2D1Factory; static;
    class function ImagingFactory: IWICImagingFactory; static;
    class function DWriteFactory: IDWriteFactory; static;
    class procedure CreateSharedResources; static;
    class procedure DestroySharedResources; static;
  private
    FBrush: ID2D1Brush;
    FStrokeBrush: ID2D1Brush;
    FStrokeStyle: ID2D1StrokeStyle;
    FLayer: ID2D1Layer;
    FCurrentSaveState: TD2DCanvasSaveState;
    FTarget: ID2D1RenderTarget;
    FContextHandle: THandle;
    // window
    FSwapChain: IDXGISwapChain;
    FRenderTargetView: ID3D10RenderTargetView;
    FBufferTexture: ID3D10Texture2D;
    // copy
    FCopyBuffer: ID3D10Texture2D;
    procedure CreateResources;
    procedure DisposeResources;
    procedure SetClipRects(const ARects: array of TRectF);
    function CreateD2DBitmapBrush(ABitmap: TBitmap; const AWrapMode: TWrapMode; const ARect: TRectF; const AOpacity: Single): ID2D1Brush;
    function CreateD2DGradientBrush(AGradient: TGradient; const ARect: TRectF; const AOpacity: Single): ID2D1Brush;
    procedure ApplyFill(const ABrush: TBrush; ARect: TRectF; const AOpacity: Single);
    procedure ApplyStroke(const AStroke: TStrokeBrush; ARect: TRectF; const AOpacity: Single);
  protected
    FLocaleName: string;
    procedure FontChanged(Sender: TObject); override;
    function CreateSaveState: TCanvasSaveState; override;
    { begin and }
    function DoBeginScene(const AClipRects: PClipRects = nil; AContextHandle: THandle = 0): Boolean; override;
    procedure DoEndScene; override;
    { creation }
    constructor CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
      const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault); override;
    constructor CreateFromBitmap(const ABitmap: TBitmap; const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault); override;
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
    destructor Destroy; override;
    procedure SetSize(const AWidth, AHeight: Integer); override;
    { buffer }
    procedure Clear(const Color: TAlphaColor); override;
    procedure ClearRect(const ARect: TRectF; const AColor: TAlphaColor = 0); override;
    { matrix }
    procedure SetMatrix(const M: TMatrix); override;
    { cliping }
    procedure IntersectClipRect(const ARect: TRectF); override;
    procedure ExcludeClipRect(const ARect: TRectF); override;
    { drawing }
    procedure MeasureLines(const ALines: TLineMetricInfo; const ARect: TRectF; const AText: string; const WordWrap: Boolean; const Flags: TFillTextFlags;
      const ATextAlign: TTextAlign; const AVTextAlign: TTextAlign = TTextAlign.taCenter); override;
    function PtInPath(const APoint: TPointF; const APath: TPathData): Boolean; override;
  end;

  TTextLayoutD2D = class(TTextLayout)
  private
    FLayout: IDWriteTextLayout;
    FBrush: ID2D1Brush;
    FMetrics: TDWriteTextMetrics;
  protected
    procedure DoRenderLayout; override;
    procedure DoDrawLayout(const ACanvas: TCanvas); override;
    function GetTextHeight: Single; override;
    function GetTextWidth: Single; override;
    function GetTextRect: TRectF; override;
    function DoPositionAtPoint(const APoint: TPointF): Integer; override;
    function DoRegionForRange(const ARange: TTextRange): TRegion; override;
  public
    constructor Create(const ACanvas: TCanvas = nil); override;
    destructor Destroy; override;
    //
    procedure ConvertToPath(const APath: TPathData); override;
  end;

{ TBitmapCodecWIC }

class function TBitmapCodecWIC.GetImageSize(const AFileName: string): TPointF;
var
  dec: IWICBitmapDecoder;
  frame: IWICBitmapFrameDecode;
  W, H: UINT;
  fn: string;
begin
  W := 0;
  H := 0;
  fn := AFileName;
  TCanvasD2D.ImagingFactory.CreateDecoderFromFilename(PChar(fn), GUID_NULL, $FFFFFFFF,
    WICDecodeMetadataCacheOnDemand, dec);
  if Assigned(dec) then
  begin
    dec.GetFrame(0, frame);
    if Assigned(frame) then
    begin
      frame.GetSize(W, H);
    end;
  end;
  Result := PointF(W, H);
end;

class function TBitmapCodecWIC.IsValid(const AStream: TStream): Boolean;
var
  dec: IWICBitmapDecoder;
  frame: IWICBitmapFrameDecode;
  W, H: UINT;
  mem: TMemoryStream;
  stream: IWICStream;
  SavePosition: Int64;
begin
  W := 0;
  H := 0;
  SavePosition := AStream.Position;
  mem := TMemoryStream.Create;
  try
    mem.CopyFrom(AStream, AStream.Size);
    TCanvasD2D.ImagingFactory.CreateStream(stream);
    stream.InitializeFromMemory(mem.Memory, mem.Size);
    TCanvasD2D.ImagingFactory.CreateDecoderFromStream(stream, GUID_NULL, WICDecodeMetadataCacheOnDemand, dec);
    if Assigned(dec) then
    begin
      dec.GetFrame(0, frame);
      if Assigned(frame) then
        frame.GetSize(W, H);
    end;
    Result := W * H <> 0;
  finally
    mem.Free;
    AStream.Position := SavePosition;
  end;
end;

function TBitmapCodecWIC.LoadFromFile(const AFileName: string;
  const Bitmap: TBitmapSurface): Boolean;
var
  dec: IWICBitmapDecoder;
  frame: IWICBitmapFrameDecode;
  conv: IWICFormatConverter;
  W, H: UINT;
  FS: TStream;
  SA: TStreamAdapter;
begin
  Result := False;
  FS := TFileStream.Create(AFileName, fmOpenRead);
  SA := TStreamAdapter.Create(FS);
  try
    TCanvasD2D.ImagingFactory.CreateDecoderFromStream(SA, GUID_NULL, WICDecodeMetadataCacheOnDemand, dec);
    if Assigned(dec) then
    begin
      dec.GetFrame(0, frame);
      if Assigned(frame) then
      begin
        TCanvasD2D.ImagingFactory.CreateFormatConverter(conv);
        Res := conv.Initialize(frame, GUID_WICPixelFormat32bppPBGRA, WICBitmapDitherTypeNone, nil, 0, 0);
        if Res = 0 then
        begin
          conv.GetSize(W, H);
          Bitmap.SetSize(W, H, pfA8B8G8R8);
          Res := conv.CopyPixels(nil, Bitmap.Pitch, H * Cardinal(Bitmap.Pitch), PByte(Bitmap.Bits));
          Result := Res = 0;
        end;
      end;
    end;
  finally
    FS.Free;
  end;
end;

function TBitmapCodecWIC.LoadThumbnailFromFile(const AFileName: string;
  const AFitWidth, AFitHeight: Single; const UseEmbedded: Boolean;
  const Bitmap: TBitmapSurface): Boolean;
var
  bmp: IWICBitmapSource;
  dec: IWICBitmapDecoder;
  scale: Single;
  scaler: IWICBitmapScaler;
  frame: IWICBitmapFrameDecode;
  conv: IWICFormatConverter;
  W, H: UINT;
  R: TRectF;
  fn: string;
begin
  fn := AFileName;
  Result := False;
  TCanvasD2D.ImagingFactory.CreateDecoderFromFilename(PChar(fn), GUID_NULL, $FFFFFFFF, WICDecodeMetadataCacheOnDemand, dec);
  if Assigned(dec) then
  begin
    dec.GetFrame(0, frame);
    if UseEmbedded then
      frame.GetThumbnail(bmp);
    if Assigned(bmp) then
    begin
      TCanvasD2D.ImagingFactory.CreateFormatConverter(conv);
      Res := conv.Initialize(bmp, GUID_WICPixelFormat32bppPBGRA, WICBitmapDitherTypeNone, nil, 0, 0);
      if Res = 0 then
      begin
        conv.GetSize(W, H);

        Bitmap.SetSize(W, H, pfA8B8G8R8);
        Res := conv.CopyPixels(nil, Bitmap.Pitch, H * Cardinal(Bitmap.Pitch), PByte(Bitmap.Bits));
        Result := Res = 0;
      end;
    end
    else
    begin
      if Assigned(frame) then
      begin
        frame.GetSize(W, H);
        R := RectF(0, 0, W, H);
        scale := R.Fit(RectF(0, 0, AFitWidth, AFitHeight));
        if scale = 0 then
          scale := 0.001;
        if scale < 1 then
          scale := 1;

        TCanvasD2D.ImagingFactory.CreateBitmapScaler(scaler);
        Res := scaler.Initialize(frame, round(W / scale), round(H / scale), WICBitmapInterpolationModeLinear);

        TCanvasD2D.ImagingFactory.CreateFormatConverter(conv);
        Res := conv.Initialize(scaler, GUID_WICPixelFormat32bppPBGRA, WICBitmapDitherTypeNone, nil, 0, 0);
        if Res = 0 then
        begin
          conv.GetSize(W, H);

          Bitmap.SetSize(W, H, pfA8B8G8R8);
          Res := conv.CopyPixels(nil, Bitmap.Pitch, H * Cardinal(Bitmap.Pitch), PByte(Bitmap.Bits));
          Result := Res = 0;
        end;
      end;
    end;
  end;
end;

function TBitmapCodecWIC.LoadFromStream(const AStream: TStream;
  const Bitmap: TBitmapSurface): Boolean;
var
  dec: IWICBitmapDecoder;
  mem: TMemoryStream;
  stream: IWICStream;
  frame: IWICBitmapFrameDecode;
  conv: IWICFormatConverter;
  W, H: UINT;
begin
  Result := False;
  mem := TMemoryStream.Create;
  try
    mem.CopyFrom(AStream, AStream.Size);
    TCanvasD2D.ImagingFactory.CreateStream(stream);
    stream.InitializeFromMemory(mem.Memory, mem.Size);
    TCanvasD2D.ImagingFactory.CreateDecoderFromStream(stream, GUID_NULL, WICDecodeMetadataCacheOnDemand, dec);
    if Assigned(dec) then
    begin
      dec.GetFrame(0, frame);
      if Assigned(frame) then
      begin
        TCanvasD2D.ImagingFactory.CreateFormatConverter(conv);
        Res := conv.Initialize(frame, GUID_WICPixelFormat32bppPBGRA, WICBitmapDitherTypeNone, nil, 0, 0);
        if Res = 0 then
        begin
          conv.GetSize(W, H);

          Bitmap.SetSize(W, H, pfA8B8G8R8);
          Res := conv.CopyPixels(nil, Bitmap.Pitch, H * Cardinal(Bitmap.Pitch), PByte(Bitmap.Bits));
          Result := True;
        end;
      end;
    end;
  finally
    mem.Free;
  end;
end;

function TBitmapCodecWIC.SaveToStream(const AStream: TStream;
  const Bitmap: TBitmapSurface; const Extension: string; const SaveParams: PBitmapCodecSaveParams = nil): Boolean;
var
  bmp: IWICBitmap;
  enc: IWICBitmapEncoder;
  encoderType: TGUID;
  stream: IWICStream;
  frame: IWICBitmapFrameEncode;
  conv: IWICFormatConverter;
  props: IPropertyBag2;
  pformat: WICPixelFormatGUID;
begin
  Result := False;
  encoderType := GUID_ContainerFormatPng;
  if SameText(Extension, '.jpeg') then
    encoderType := GUID_ContainerFormatJpeg;
  if SameText(Extension, '.jpg') then
    encoderType := GUID_ContainerFormatJpeg;
  if SameText(Extension, '.png') then
    encoderType := GUID_ContainerFormatPng;
  if SameText(Extension, '.bmp') then
    encoderType := GUID_ContainerFormatBmp;
  if SameText(Extension, '.tif') then
    encoderType := GUID_ContainerFormatTiff;
  if SameText(Extension, '.tiff') then
    encoderType := GUID_ContainerFormatTiff;
  if SameText(Extension, '.gif') then
    encoderType := GUID_ContainerFormatGif;
  if SameText(Extension, '.wmp') then
    encoderType := GUID_ContainerFormatWmp;
  TCanvasD2D.ImagingFactory.CreateEncoder(encoderType, GUID_NULL, enc);
  if Assigned(enc) then
  begin
    TCanvasD2D.ImagingFactory.CreateStream(stream);
    stream.InitializeFromIStream(TStreamAdapter.Create(AStream) as IStream);
    enc.Initialize(stream, WICBitmapEncoderNoCache);
    enc.CreateNewFrame(frame, props);
    if Assigned(frame) then
    begin
      frame.Initialize(props);
      Res := frame.SetSize(Bitmap.Width, Bitmap.Height);
      pformat := GUID_WICPixelFormat32bppPBGRA;
      Res := frame.SetPixelFormat(pformat);
      if IsEqualGuid(pformat, GUID_WICPixelFormat32bppPBGRA) then
      begin
        Res := frame.WritePixels(Bitmap.Height, Bitmap.Pitch, Bitmap.Pitch * Bitmap.Height, PByte(Bitmap.Bits));
        Res := frame.Commit;
        Res := enc.Commit;
      end
      else
      begin
        TCanvasD2D.ImagingFactory.CreateBitmapFromMemory(Bitmap.Width, Bitmap.Height, GUID_WICPixelFormat32bppPBGRA,
          Bitmap.Pitch, Bitmap.Pitch * Bitmap.Height, PByte(Bitmap.Bits), bmp);
        TCanvasD2D.ImagingFactory.CreateFormatConverter(conv);
        Res := conv.Initialize(bmp, pformat, WICBitmapDitherTypeNone, nil, 0, 0);
        Res := frame.WriteSource(bmp, nil);
        Res := frame.Commit;
        Res := enc.Commit;
      end;
    end;
  end;
end;

function TBitmapCodecWIC.SaveToFile(const AFileName: string;
  const Bitmap: TBitmapSurface; const SaveParams: PBitmapCodecSaveParams = nil): Boolean;
var
  bmp: IWICBitmap;
  enc: IWICBitmapEncoder;
  encoderType: TGUID;
  stream: IWICStream;
  frame: IWICBitmapFrameEncode;
  conv: IWICFormatConverter;
  props: IPropertyBag2;
  fn: string;
  pformat: WICPixelFormatGUID;
  pname: TPropBag2;
  pvalue: Variant;
  value: ansistring;
begin
  fn := AFileName;
  Result := False;
  encoderType := GUID_ContainerFormatPng;
  if (LowerCase(ExtractFileExt(AFileName)) = '.jpg') or (LowerCase(ExtractFileExt(AFileName)) = '.jpeg') then
    encoderType := GUID_ContainerFormatJpeg;
  if (LowerCase(ExtractFileExt(AFileName)) = '.bmp') then
    encoderType := GUID_ContainerFormatBmp;
  if (LowerCase(ExtractFileExt(AFileName)) = '.png') then
    encoderType := GUID_ContainerFormatPng;
  if (LowerCase(ExtractFileExt(AFileName)) = '.tif') or (LowerCase(ExtractFileExt(AFileName)) = '.tiff') then
    encoderType := GUID_ContainerFormatTiff;
  if (LowerCase(ExtractFileExt(AFileName)) = '.gif') then
    encoderType := GUID_ContainerFormatGif;
  if (LowerCase(ExtractFileExt(AFileName)) = '.wmp') then
    encoderType := GUID_ContainerFormatWmp;
  TCanvasD2D.ImagingFactory.CreateEncoder(encoderType, GUID_NULL, enc);
  if Assigned(enc) then
  begin
    TCanvasD2D.ImagingFactory.CreateStream(stream);
    stream.InitializeFromFilename(PChar(fn), $FFFFFFFF);
    enc.Initialize(stream, WICBitmapEncoderNoCache);
    enc.CreateNewFrame(frame, props);
    if Assigned(frame) then
    begin
      { set params }
      if SaveParams <> nil then
      begin
        FillChar(pname, SizeOf(pname), 0);
        pname.dwType := 1;//PROPBAG2_TYPE_DATA;
        pname.vt := VT_VARIANT;
        pname.pstrName := PChar(string('ImageQuality'));
        pvalue := SaveParams.Quality;
        Res := props.Write(1, @pname, @value);
      end;
      Res := frame.Initialize(props);
      { }
      Res := frame.SetSize(Bitmap.Width, Bitmap.Height);
      pformat := GUID_WICPixelFormat32bppPBGRA;
      Res := frame.SetPixelFormat(pformat);
      if IsEqualGuid(pformat, GUID_WICPixelFormat32bppPBGRA) then
      begin
        Res := frame.WritePixels(Bitmap.Height, Bitmap.Pitch, Bitmap.Pitch * Bitmap.Height, PByte(Bitmap.Bits));
        Res := frame.Commit;
        Res := enc.Commit;
      end
      else
      begin
        TCanvasD2D.ImagingFactory.CreateBitmapFromMemory(Bitmap.Width, Bitmap.Height, GUID_WICPixelFormat32bppPBGRA,
          Bitmap.Pitch, Bitmap.Pitch * Bitmap.Height, PByte(Bitmap.Bits), bmp);
        TCanvasD2D.ImagingFactory.CreateFormatConverter(conv);
        Res := conv.Initialize(bmp, pformat, WICBitmapDitherTypeNone, nil, 0, 0);
        Res := frame.WriteSource(bmp, nil);
        Res := frame.Commit;
        Res := enc.Commit;
      end;
    end;
  end;
end;

{ Canvas }

const
  D2DERR_RECREATE_TARGET = HResult($8899000C);

var
  IdentM: D2D_MATRIX_3X2_F;

function D2Rect(const R: TRectF): TD2D1RectF; inline;
begin
  Result := TD2D1RectF(R);
end;

function D2Color(const AColor: TAlphaColor; const Opacity: Single): TD2D1ColorF;
var
  D2R: Single;
  D2G: Single;
  D2B: Single;
  D2A: Single;
begin
  D2R := TAlphaColorRec(AColor).R / $FF;
  D2B := TAlphaColorRec(AColor).B / $FF;
  D2G := TAlphaColorRec(AColor).G / $FF;
  D2A := TAlphaColorRec(AColor).A / $FF;
  Result := D2D1ColorF(D2R, D2G, D2B, D2A * Opacity);
end;

function D2Point(X, y: Single): TD2D1Point2F; inline;
begin
  Result.X := X;
  Result.y := y;
end;

function D2Size(W, H: cardinal): TD2DSizeU; inline;
begin
  Result.Width := W;
  Result.Height := H;
end;

function D2Matrix(M: TMatrix): TD2D1Matrix3X2F;
begin
  Result._11 := M.m11;
  Result._12 := M.m12;
  Result._21 := M.m21;
  Result._22 := M.m22;
  Result._31 := M.m31;
  Result._32 := M.m32;
end;

function MatrixToD2(M: TD2D1Matrix3X2F): TMatrix;
begin
  Result.m11 := M._11;
  Result.m12 := M._12;
  Result.m21 := M._21;
  Result.m22 := M._22;
  Result.m31 := M._31;
  Result.m32 := M._32;
end;

function D2Bezier(x1, y1, x2, y2, x3, y3: Single): TD2D1BezierSegment;
begin
  Result.Point1.X := x1;
  Result.Point1.y := y1;
  Result.Point2.X := x2;
  Result.Point2.y := y2;
  Result.Point3.X := x3;
  Result.Point3.y := y3;
end;

function D2Ellipse(R: TRectF): TD2D1Ellipse;
begin
  Result.Point.X := (R.Right + R.Left) / 2;
  Result.Point.y := (R.Bottom + R.Top) / 2;
  Result.RadiusX := (R.Right - R.Left) / 2;
  Result.RadiusY := (R.Bottom - R.Top) / 2;
end;

function D2FontStyle(Style: TFontStyles): TDWriteFontStyle; inline;
begin
  Result := 0;
  if TFontStyle.fsItalic in Style then
    Result := Result + DWRITE_FONT_STYLE_OBLIQUE;
end;

function D2FontWeight(Style: TFontStyles): TDWriteFontWeight; inline;
begin
  Result := DWRITE_FONT_WEIGHT_REGULAR;
  if TFontStyle.fsBold in Style then
    Result := DWRITE_FONT_WEIGHT_BOLD;
end;

function BitmapProp(DXGI: DXGI_Format; AlphaMode: TD2D1AlphaMode): TD2D1BitmapProperties;
begin
  Result.PixelFormat.Format := DXGI;
  Result.PixelFormat.AlphaMode := AlphaMode;
  Result.DpiX := 0;
  Result.DpiY := 0;
end;

{ TD2DBitmap }

function TD2DBitmap.CreateBitmap(RenderTarget: ID2D1RenderTarget): ID2D1Bitmap;
var
  Prop: TD2D1BitmapProperties;
begin
  Prop := BitmapProp(DXGI_FORMAT_UNKNOWN, D2D1_ALPHA_MODE_PREMULTIPLIED);
  if not Assigned(SharedBitmap) then
    Res := TCanvasD2D.SharedRenderTarget.CreateSharedBitmap(IDXGISurface, Pointer(Texture as IDXGISurface), @Prop, SharedBitmap);
  Res := RenderTarget.CreateSharedBitmap(ID2D1Bitmap, Pointer(SharedBitmap), @Prop, Result);
end;

{ TCanvasD2D }

constructor TCanvasD2D.CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
  const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault);
begin
  inherited CreateFromWindow(AParent, AWidth, AHeight, AQuality);
  if WindowHandleToPlatform(Parent).Form.Transparency then
    WindowHandleToPlatform(Parent).CreateBuffer(Width, Height);
end;

constructor TCanvasD2D.CreateFromBitmap(const ABitmap: TBitmap; const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault);
begin
  inherited CreateFromBitmap(ABitmap, AQuality);
  CreateResources;
end;

constructor TCanvasD2D.CreateFromPrinter(const APrinter: TAbstractPrinter);
begin
  // Just a stub implementation - not used.
end;

destructor TCanvasD2D.Destroy;
begin
  DisposeResources;
  inherited Destroy;
end;

procedure TCanvasD2D.CreateResources;
var
  SizeInPixels: D2D1_SIZE_U;
  Prop: TD2D1RenderTargetProperties;
  BackBuffer: ID3D10Texture2D;
  SwapDesc: TDXGISwapChainDesc;
  Desc: TD3D10_Texture2DDesc;
begin
  if not Assigned(FTarget) then
  begin
    SizeInPixels.Width := FWidth;
    SizeInPixels.Height := FHeight;
    if (Bitmap <> nil) then
    begin
      if Bitmap.HandleAllocated then
      begin
        Prop := D2D1RenderTargetProperties(TargetMode, D2D1PixelFormat(DXGI_FORMAT_UNKNOWN, D2D1_ALPHA_MODE_PREMULTIPLIED));
        Res := Factory.CreateDxgiSurfaceRenderTarget(TD2DBitmap(Bitmap.Handle).Texture as IDXGISurface , Prop, FTarget);
      end;
    end
    else
    begin
      if Assigned(Parent) and WindowHandleToPlatform(Parent).Form.Transparency then
      begin
        // Resize platform buffer
        WindowHandleToPlatform(Parent).ResizeBuffer(Width, Height);
        // Create buffer
        FillChar(Desc, SizeOf(D3D10_TEXTURE2D_DESC), 0);
        Desc.Format := DXGI_FORMAT_B8G8R8A8_UNORM;
        Desc.Width := Width;
        Desc.Height := Height;
        Desc.MipLevels := 1;
        Desc.ArraySize := 1;
        Desc.SampleDesc.Count := 1;
        Desc.SampleDesc.Quality := 0;
        Desc.Usage := D3D10_USAGE_DEFAULT;
        Desc.BindFlags := D3D10_BIND_RENDER_TARGET or D3D10_BIND_SHADER_RESOURCE;
        Res := TCustomDX10Context.SharedDevice.CreateTexture2D(Desc, nil, FBufferTexture);
        Prop := D2D1RenderTargetProperties(TargetMode, D2D1PixelFormat(DXGI_FORMAT_UNKNOWN, D2D1_ALPHA_MODE_PREMULTIPLIED));
        Res := Factory.CreateDxgiSurfaceRenderTarget(FBufferTexture as IDXGISurface, Prop, FTarget);
        // Create copy buffer
        FillChar(Desc, SizeOf(D3D10_TEXTURE2D_DESC), 0);
        Desc.Format := DXGI_FORMAT_B8G8R8A8_UNORM;
        Desc.Width := Width;
        Desc.Height := Height;
        Desc.MipLevels := 1;
        Desc.ArraySize := 1;
        Desc.SampleDesc.Count := 1;
        Desc.SampleDesc.Quality := 0;
        Desc.CPUAccessFlags := D3D10_CPU_ACCESS_READ;
        Desc.Usage := D3D10_USAGE_STAGING;
        Desc.BindFlags := 0;
        Res := TCustomDX10Context.SharedDevice.CreateTexture2D(Desc, nil, FCopyBuffer);
      end
      else
      begin
        FillChar(SwapDesc, SizeOf(SwapDesc), 0);
        SwapDesc.BufferCount:= 1;
        SwapDesc.BufferDesc.Width := Width;
        SwapDesc.BufferDesc.Height:= Height;
        SwapDesc.BufferDesc.Format:= DXGI_FORMAT_B8G8R8A8_UNORM;
        SwapDesc.BufferUsage := DXGI_USAGE_RENDER_TARGET_OUTPUT;
        SwapDesc.OutputWindow := WindowHandleToPlatform(Parent).Wnd;
        SwapDesc.SampleDesc.Count  := 1;
        SwapDesc.SampleDesc.Quality:= 0;
        SwapDesc.Windowed := True;
        Res := TCustomDX10Context.DXGIFactory.CreateSwapChain(TCustomDX10Context.SharedDevice, SwapDesc, FSwapChain);
        Res := FSwapChain.GetBuffer(0, ID3D10Texture2D, BackBuffer);
        if Succeeded(Res) then
        begin
          Res := TCustomDX10Context.SharedDevice.CreateRenderTargetView(BackBuffer, nil, @FRenderTargetView);
          Prop := D2D1RenderTargetProperties(TargetMode, D2D1PixelFormat(DXGI_FORMAT_UNKNOWN, D2D1_ALPHA_MODE_PREMULTIPLIED));
          Res := Factory.CreateDxgiSurfaceRenderTarget(BackBuffer as IDXGISurface, Prop, FTarget);
        end;
      end;
    end;
    if FTarget <> nil then
    begin
      FTarget.SetDpi(96, 96);
      case Quality of
        TCanvasQuality.ccHighPerformance: FTarget.SetAntialiasMode(D2D1_ANTIALIAS_MODE_ALIASED);
        TCanvasQuality.ccHighQuality: FTarget.SetAntialiasMode(D2D1_ANTIALIAS_MODE_PER_PRIMITIVE);
      else
        FTarget.SetAntialiasMode(D2D1_ANTIALIAS_MODE_PER_PRIMITIVE);
      end;
      FTarget.SetTextAntialiasMode(D2D1_TEXT_ANTIALIAS_MODE_DEFAULT);
    end;
  end
end;

procedure TCanvasD2D.DisposeResources;
begin
  FBufferTexture := nil;
  FCopyBuffer := nil;
  FRenderTargetView := nil;
  FStrokeBrush := nil;
  FBrush := nil;
  FLayer := nil;
  FTarget := nil;
  FSwapChain := nil;
end;

function TCanvasD2D.CreateSaveState: TCanvasSaveState;
begin
  Result := TD2DCanvasSaveState.Create;
end;

function TCanvasD2D.CreateD2DGradientBrush(AGradient: TGradient; const ARect: TRectF;
  const AOpacity: Single): ID2D1Brush;
var
  Count: Integer;
  grad: array of TD2D1GradientStop;
  gradcol: ID2D1GradientStopCollection;
  gradbrushprop: TD2D1LinearGradientBrushProperties;
  rgradbrushprop: TD2D1RadialGradientBrushProperties;
  I: Integer;
begin
  if AGradient.Points.Count > 1 then
  begin
    Count := 0;
    // + 2 - two boundary points of a gradient
    SetLength(grad, AGradient.Points.Count + 2);
    if AGradient.Points[0].Offset > 0 then
    begin
      grad[Count].Color := D2Color(MakeColor(AGradient.Points[0].IntColor, AOpacity), 1);
      grad[Count].Position := 0;
      Inc(Count);
    end;
    for I := 0 to AGradient.Points.Count - 1 do
    begin
      grad[I + Count].Color := D2Color(MakeColor(AGradient.Points[I].IntColor, AOpacity), 1);
      grad[I + Count].Position := AGradient.Points[I].Offset;
    end;
    if AGradient.Points[AGradient.Points.Count - 1].Offset < 1 then
    begin
      Inc(Count);
      grad[AGradient.Points.Count + Count - 1].Color :=
        D2Color(MakeColor(AGradient.Points[AGradient.Points.Count - 1].IntColor, AOpacity), 1);
      grad[AGradient.Points.Count + Count - 1].Position := 1;
    end;

    if AGradient.Style = TGradientStyle.gsLinear then
    begin
      { Linear }
      FTarget.CreateGradientStopCollection(@grad[0], AGradient.Points.Count + Count, D2D1_GAMMA_2_2,
        D2D1_EXTEND_MODE_CLAMP, gradcol);
      gradbrushprop.StartPoint := D2Point(ARect.Left + AGradient.StartPosition.X * ARect.Width,
        ARect.Top + AGradient.StartPosition.y * ARect.Height);
      gradbrushprop.EndPoint := D2Point(ARect.Left + AGradient.StopPosition.X * ARect.Width,
        ARect.Top + AGradient.StopPosition.y * ARect.Height);
      FTarget.CreateLinearGradientBrush(gradbrushprop, nil, gradcol, ID2D1LinearGradientBrush(Result));
      gradcol := nil;
    end
    else
    begin
      { Radial }
      for I := 0 to AGradient.Points.Count + Count - 1 do
        grad[I].Position := 1 - grad[I].Position;
      FTarget.CreateGradientStopCollection(@grad[0], AGradient.Points.Count + Count, D2D1_GAMMA_2_2,
        D2D1_EXTEND_MODE_CLAMP, gradcol);
      rgradbrushprop.GradientOriginOffset := TD2D1Point2F(Point(0, 0));
      rgradbrushprop.Center := TD2D1Point2F(
        PointF(AGradient.RadialTransform.RotationCenter.X * RectWidth(ARect),
        AGradient.RadialTransform.RotationCenter.y * RectHeight(ARect)) + ARect.TopLeft);
      rgradbrushprop.RadiusX := RectWidth(ARect) / 2;
      rgradbrushprop.RadiusY := RectHeight(ARect) / 2;
      FTarget.CreateRadialGradientBrush(rgradbrushprop, nil, gradcol, ID2D1RadialGradientBrush(Result));
      gradcol := nil;
    end;
  end
  else
    FTarget.CreateSolidColorBrush(D2Color(0, 0), nil, ID2D1SolidColorBrush(Result));
end;

function TCanvasD2D.CreateD2DBitmapBrush(ABitmap: TBitmap; const AWrapMode: TWrapMode; const ARect: TRectF;
  const AOpacity: Single): ID2D1Brush;
var
  bitmapbrushprop: TD2D1BitmapBrushProperties;
  brushprop: TD2D1BrushProperties;
  d2dbmp: ID2D1Bitmap;
  M: TMatrix;
begin
  if (ABitmap <> nil) and (ABitmap.ResourceBitmap <> nil) then
    ABitmap := ABitmap.ResourceBitmap;
  if (ABitmap <> nil) and (ABitmap.Width > 0) and (ABitmap.Height > 0) then
  begin
    bitmapbrushprop.InterpolationMode := D2D1_BITMAP_INTERPOLATION_MODE_LINEAR;
    brushprop.Opacity := AOpacity;
    M := IdentityMatrix;
    case AWrapMode of
      TWrapMode.wmTile:
        begin
          bitmapbrushprop.ExtendModeX := D2D1_EXTEND_MODE_WRAP;
          bitmapbrushprop.ExtendModeY := D2D1_EXTEND_MODE_WRAP;
        end;
      TWrapMode.wmTileOriginal:
        begin
          bitmapbrushprop.ExtendModeX := D2D1_EXTEND_MODE_CLAMP;
          bitmapbrushprop.ExtendModeY := D2D1_EXTEND_MODE_CLAMP;
        end;
      TWrapMode.wmTileStretch:
        begin
          bitmapbrushprop.ExtendModeX := D2D1_EXTEND_MODE_WRAP;
          bitmapbrushprop.ExtendModeY := D2D1_EXTEND_MODE_WRAP;
          if Stroke.Kind = TBrushKind.bkNone then
          begin
            M.m11 := ARect.Width / ABitmap.Width;
            M.m22 := ARect.Height / ABitmap.Height;
          end
          else
          begin
            M.m11 := (ARect.Width + (Stroke.Thickness / 2)) / ABitmap.Width;
            M.m22 := (ARect.Height + (Stroke.Thickness / 2)) / ABitmap.Height;
          end;
          M.m31 := ARect.Left;
          M.m32 := ARect.Top;
        end;
    end;
    brushprop.Transform := D2Matrix(M);
    d2dbmp := TD2DBitmap(ABitmap.Handle).CreateBitmap(FTarget);
    FTarget.CreateBitmapBrush(d2dbmp, @bitmapbrushprop, @brushprop, ID2D1BitmapBrush(Result));
  end
  else
    FTarget.CreateSolidColorBrush(D2Color(0, 0), nil, ID2D1SolidColorBrush(Result));
end;

procedure TCanvasD2D.Clear(const Color: TAlphaColor);
begin
  FTarget.Clear(D2Color(Color, 1));
end;

procedure TCanvasD2D.ClearRect(const ARect: TRectF; const AColor: TAlphaColor);
begin
  FTarget.Clear(D2Color(AColor, 1));
end;

function TCanvasD2D.DoBeginScene(const AClipRects: PClipRects = nil; AContextHandle: THandle = 0): Boolean;
begin
  CreateResources;
  Result := inherited DoBeginScene(AClipRects) and (FTarget <> nil);
  if Result then
  begin
    FCurrentSaveState := nil;
    FContextHandle := AContextHandle;
    if Result then
    begin
      FTarget.BeginDraw;
      if AClipRects <> nil then
        SetClipRects(AClipRects^);
    end;
  end;
end;

procedure TCanvasD2D.DoEndScene;
var
  t1, t2: TD2D1Tag;
  Mapped: D3D10_MAPPED_TEXTURE2D;
  I: Integer;
begin
  if FTarget <> nil then
  begin
    if FLayer <> nil then
    begin
      FTarget.PopLayer;
      FLayer := nil;
    end;
    Res := FTarget.Flush(@t1, @t2);
    if (Res <> 0) or (t1 <> 0) or (t2 <> 0) then ;
    Res := FTarget.EndDraw;
    if Res = D2DERR_RECREATE_TARGET then
      DisposeResources;
    if (BeginSceneCount = 1) and Assigned(FSwapChain) then
      Res := FSwapChain.Present(0, 0);
    if Assigned(FBufferTexture) then
    begin
      // copy to layered buffer
      TCustomDX10Context.SharedDevice.CopyResource(FCopyBuffer, FBufferTexture);
      if Succeeded(FCopyBuffer.Map(0, D3D10_MAP_READ, 0, Mapped)) then
      try
        if Mapped.RowPitch <> Cardinal(Width * 4) then
        begin
          for I := 0 to Height - 1 do
            Move(PAlphaColorArray(Mapped.pData)[Cardinal(I) * (Mapped.RowPitch div 4)],
              PAlphaColorArray(WindowHandleToPlatform(Parent).BufferBits)[I * Width], Width * 4);
        end else
          Move(Mapped.pData^, WindowHandleToPlatform(Parent).BufferBits^, Width * Height * 4);
      finally
        FCopyBuffer.Unmap(0);
      end;
      // in design-time just draw buffer
      if (csDesigning in WindowHandleToPlatform(Parent).Form.ComponentState) then
        Winapi.Windows.BitBlt(FContextHandle, 0, 0, Width, Height, WindowHandleToPlatform(Parent).BufferHandle, 0, 0, SRCCOPY);
    end;
  end;
  inherited;
end;

procedure TCanvasD2D.SetMatrix(const M: TMatrix);
begin
  FMatrix := M;
  if FTarget <> nil then
    FTarget.SetTransform(D2Matrix(FMatrix));
end;

procedure TCanvasD2D.SetSize(const AWidth, AHeight: Integer);
var
  BackBuffer: ID3D10Texture2D;
  Prop: TD2D1RenderTargetProperties;
begin
  if Assigned(Parent) and ((AWidth <> Width) or (AHeight <> Height)) then
  begin
    inherited;
    if Assigned(FTarget) then
    begin
      if Assigned(FSwapChain) then
      begin
        FTarget := nil;
        FRenderTargetView := nil;
        Res := FSwapChain.ResizeBuffers(1, Width, Height, DXGI_FORMAT_UNKNOWN, 0);
        Res := FSwapChain.GetBuffer(0, ID3D10Texture2D, BackBuffer);
        if Succeeded(Res) then
        begin
          Res := TCustomDX10Context.SharedDevice.CreateRenderTargetView(BackBuffer, nil, @FRenderTargetView);
          Prop := D2D1RenderTargetProperties(TargetMode, D2D1PixelFormat(DXGI_FORMAT_UNKNOWN, D2D1_ALPHA_MODE_PREMULTIPLIED));
          Res := FFactory.CreateDxgiSurfaceRenderTarget(BackBuffer as IDXGISurface, Prop, FTarget);
        end;
      end else begin
        FTarget := nil;
        FRenderTargetView := nil;
        FBufferTexture := nil;
        FCopyBuffer := nil;
      end;
    end;
  end;
end;

procedure TCanvasD2D.SetClipRects(const ARects: array of TRectF);
var
  i: Integer;
  Geoms: array of ID2D1Geometry;
  FClipGeom: ID2D1GeometryGroup;
  LayerPar: TD2D1LayerParameters;
  R: TRectF;
begin
  if Length(ARects) > 0 then
  begin
    FTarget.SetTransform(D2Matrix(IdentityMatrix));
    // First clear
    for i := 0 to High(ARects) do
    begin
      R := ARects[i];
      FTarget.PushAxisAlignedClip(D2Rect(R), D2D1_ANTIALIAS_MODE_ALIASED);
      FTarget.Clear(D2Color(0, 0));
      FTarget.PopAxisAlignedClip;
    end;
    FClipGeom := nil;
    // Second create clipregion
    SetLength(Geoms, Length(ARects));
    for i := 0 to High(ARects) do
    begin
      Factory.CreateRectangleGeometry(D2Rect(ARects[i]), ID2D1RectangleGeometry(Geoms[i]));
    end;
    Factory.CreateGeometryGroup(D2D1_FILL_MODE_WINDING, @Geoms[0], Length(Geoms), FClipGeom);
    for i := 0 to High(ARects) do
    begin
      Geoms[i] := nil;
    end;
    // Apply clips
    FTarget.CreateLayer(nil, FLayer);
    LayerPar.ContentBounds := D2Rect(RectF(0, 0, FWidth, FHeight));
    LayerPar.GeometricMask := FClipGeom;
    LayerPar.MaskAntialiasMode := D2D1_ANTIALIAS_MODE_ALIASED;
    LayerPar.MaskTransform := D2Matrix(IdentityMatrix);
    LayerPar.Opacity := 1;
    LayerPar.OpacityBrush := nil;
    LayerPar.LayerOptions := D2D1_LAYER_OPTIONS_NONE;
    FTarget.PushLayer(LayerPar, FLayer);
    FClipGeom := nil;
  end;
end;

procedure TCanvasD2D.IntersectClipRect(const ARect: TRectF);
var
  Geom: ID2D1RectangleGeometry;
  LayerPar: TD2D1LayerParameters;
begin
  FClippingChangeCount := FClippingChangeCount + 1;
  if FCurrentSaveState <> nil then
  begin
    OleCheck(Factory.CreateRectangleGeometry(D2Rect(ARect), Geom));
    if Assigned(Geom) then
    begin
      FCurrentSaveState.CreateLayer(FTarget);
      LayerPar.ContentBounds := D2Rect(RectF(-MaxSingle, -MaxSingle, MaxSingle, MaxSingle));
      LayerPar.GeometricMask := Geom;
      LayerPar.MaskAntialiasMode := D2D1_ANTIALIAS_MODE_ALIASED;
      LayerPar.MaskTransform := D2Matrix(IdentityMatrix);
      LayerPar.Opacity := 1;
      LayerPar.OpacityBrush := nil;
      LayerPar.LayerOptions := D2D1_LAYER_OPTIONS_NONE;
      FTarget.PushLayer(LayerPar, FCurrentSaveState.Layer);
      Geom := nil;
    end;
  end;
end;

procedure TCanvasD2D.ExcludeClipRect(const ARect: TRectF);
var
  i: Integer;
  Geoms: array of ID2D1RectangleGeometry;
  R: TRectF;
  RR: array of TRectF;
  GeomGroup: ID2D1GeometryGroup;
  LayerPar: TD2D1LayerParameters;
begin
  FClippingChangeCount := FClippingChangeCount + 1;
  if FCurrentSaveState <> nil then
  begin
    SetLength(Geoms, 4);
    R := ARect;
    SetLength(RR, 4);
    RR[0] := RectF(-FWidth, -FWidth, R.Left, FHeight);
    RR[1] := RectF(R.Right, -FHeight, FWidth, FHeight);
    RR[2] := RectF(R.Left, -FHeight, R.Right, R.Top);
    RR[3] := RectF(R.Left, R.Bottom, R.Right, FHeight);
    for i := 0 to High(RR) do
      OleCheck(Factory.CreateRectangleGeometry(D2Rect(RR[i]), Geoms[i]));
    OleCheck(Factory.CreateGeometryGroup(D2D1_FILL_MODE_WINDING, @Geoms[0], Length(Geoms), GeomGroup));
    if Assigned(GeomGroup) then
    begin
      FCurrentSaveState.CreateLayer(FTarget);
      LayerPar.ContentBounds := D2Rect(RectF(-FWidth, -FHeight, 400000, 400000));
      LayerPar.GeometricMask := GeomGroup;
      LayerPar.MaskAntialiasMode := D2D1_ANTIALIAS_MODE_ALIASED;
      LayerPar.MaskTransform := D2Matrix(IdentityMatrix);
      LayerPar.Opacity := 1;
      LayerPar.OpacityBrush := nil;
      LayerPar.LayerOptions := D2D1_LAYER_OPTIONS_NONE;
      FTarget.PushLayer(LayerPar, FCurrentSaveState.Layer);
    end;
  end;
end;

procedure TCanvasD2D.ApplyFill(const ABrush: TBrush; ARect: TRectF; const AOpacity: Single);
begin
  FBrush := nil;
  if (ABrush.Kind = TBrushKind.bkResource) and Assigned(ABrush.Resource) and Assigned(ABrush.Resource.Brush) then
    ABrush.Assign(ABrush.Resource.Brush);

  case ABrush.Kind of
    TBrushKind.bkSolid:
        FTarget.CreateSolidColorBrush(D2Color(ABrush.Color, AOpacity), nil, ID2D1SolidColorBrush(FBrush));

    TBrushKind.bkGradient:
        FBrush := CreateD2DGradientBrush(ABrush.Gradient, ARect, AOpacity);

    TBrushKind.bkBitmap:
        FBrush := CreateD2DBitmapBrush(ABrush.Bitmap.Bitmap, ABrush.Bitmap.WrapMode, ARect, AOpacity);
  else
    FTarget.CreateSolidColorBrush(D2Color(0, 0), nil, ID2D1SolidColorBrush(FBrush));
  end;
end;

procedure TCanvasD2D.ApplyStroke(const AStroke: TStrokeBrush; ARect: TRectF; const AOpacity: Single);
var
  StyleProp: TD2D1StrokeStyleProperties;
begin
  FStrokeBrush := nil;
  FStrokeStyle := nil;
  if (AStroke.Kind = TBrushKind.bkResource) and (AStroke.Resource <> nil) and
     (AStroke.Resource.Brush <> nil) then
    AStroke.Assign(AStroke.Resource.Brush);

  case AStroke.Kind of
    TBrushKind.bkSolid:
        FTarget.CreateSolidColorBrush(D2Color(AStroke.Color, AOpacity), nil,
          ID2D1SolidColorBrush(FStrokeBrush));

    TBrushKind.bkBitmap:
        FStrokeBrush := CreateD2DBitmapBrush(AStroke.Bitmap.Bitmap, AStroke.Bitmap.WrapMode, ARect, AOpacity);

    TBrushKind.bkGradient:
        FStrokeBrush := CreateD2DGradientBrush(AStroke.Gradient, ARect, AOpacity);
  else
    FTarget.CreateSolidColorBrush(D2Color(0, 0), nil, ID2D1SolidColorBrush(FStrokeBrush));
  end;

  case AStroke.Cap of
    TStrokeCap.scFlat:
      StyleProp.DashCap := D2D1_CAP_STYLE_SQUARE;
    TStrokeCap.scRound:
      StyleProp.DashCap := D2D1_CAP_STYLE_ROUND;
  end;
  StyleProp.StartCap := StyleProp.DashCap;
  StyleProp.EndCap := StyleProp.DashCap;
  case AStroke.Join of
    TStrokeJoin.sjMiter:
      StyleProp.LineJoin := D2D1_LINE_JOIN_MITER;
    TStrokeJoin.sjRound:
      StyleProp.LineJoin := D2D1_LINE_JOIN_ROUND;
    TStrokeJoin.sjBevel:
      StyleProp.LineJoin := D2D1_LINE_JOIN_BEVEL;
  end;
  StyleProp.MiterLimit := 10;
  StyleProp.DashOffset := AStroke.DashOffset;
  StyleProp.DashStyle := TD2D1DashStyle(AStroke.Dash);

  if AStroke.Dash = TStrokeDash.sdCustom then
    Factory.CreateStrokeStyle(StyleProp, @AStroke.DashArray[0], Length(AStroke.DashArray), FStrokeStyle)
  else
    Factory.CreateStrokeStyle(StyleProp, nil, 0, FStrokeStyle)
end;

procedure TCanvasD2D.FontChanged(Sender: TObject);
begin
end;

procedure TCanvasD2D.DoDrawLine(const APt1, APt2: TPointF; const AOpacity: Single; const ABrush: TStrokeBrush);
begin
  ApplyStroke(ABrush, RectF(APt1.X, APt1.y, APt2.X, APt2.y), AOpacity);
  FTarget.DrawLine(D2Point(APt1.X, APt1.y), D2Point(APt2.X, APt2.y), FStrokeBrush,
    ABrush.Thickness, FStrokeStyle);
end;

procedure TCanvasD2D.DoDrawRect(const ARect: TRectF; const AOpacity: Single; const ABrush: TStrokeBrush);
begin
  if (FTarget <> nil) then
  begin
    ApplyStroke(ABrush, ARect, AOpacity);
    FTarget.DrawRectangle(D2Rect(ARect), FStrokeBrush, ABrush.Thickness, FStrokeStyle);
  end;
end;

procedure TCanvasD2D.DoFillRect(const ARect: TRectF; const AOpacity: Single; const ABrush: TBrush);
begin
  if (FTarget <> nil) then
  begin
    ApplyFill(ABrush, ARect, AOpacity);
    FTarget.FillRectangle(D2Rect(ARect), FBrush);
  end;
end;

procedure TCanvasD2D.DoDrawEllipse(const ARect: TRectF; const AOpacity: Single; const ABrush: TStrokeBrush);
begin
  if (FTarget <> nil) then
  begin
    ApplyStroke(ABrush, ARect, AOpacity);
    FTarget.DrawEllipse(D2Ellipse(ARect), FStrokeBrush, ABrush.Thickness, FStrokeStyle);
  end;
end;

procedure TCanvasD2D.DoFillEllipse(const ARect: TRectF; const AOpacity: Single; const ABrush: TBrush);
begin
  if (FTarget <> nil) then
  begin
    ApplyFill(ABrush, ARect, AOpacity);
    FTarget.FillEllipse(D2Ellipse(ARect), FBrush);
  end;
end;

procedure TCanvasD2D.MeasureLines(const ALines: TLineMetricInfo; const ARect: TRectF; const AText: string; const WordWrap: Boolean; const Flags: TFillTextFlags;
  const ATextAlign: TTextAlign; const AVTextAlign: TTextAlign = TTextAlign.taCenter);
var
  TextRange: TDWriteTextRange;
  TextLayout: IDWriteTextLayout;
  TextFormat: IDWriteTextFormat;
  RWidth, RHeight: Single;
  WS: string;
  P,
  I, LineCount: Cardinal;
  LineMetrics: array of DWRITE_LINE_METRICS;
//  ALineMetric: TLineMetric;
begin
  if Length(AText) = 0 then
    Exit;

  if not WordWrap then
    RWidth := 0
  else
    RWidth := RectWidth(ARect);
  RHeight := RectHeight(ARect);

  WS := FFont.Family;
  DWriteFactory.CreateTextFormat(PChar(WS), nil, D2FontWeight(FFont.Style), D2FontStyle(FFont.Style),
    DWRITE_FONT_STRETCH_NORMAL, FFont.Size, PChar(FLocaleName), TextFormat);
  if TFillTextFlag.ftRightToLeft in Flags then
    TextFormat.SetReadingDirection(DWRITE_READING_DIRECTION_RIGHT_TO_LEFT);

  DWriteFactory.CreateTextLayout(PChar(AText), Length(AText), TextFormat, RWidth, RHeight, TextLayout);

  TextRange.StartPosition := 0;
  TextRange.Length := Length(AText);

  if not WordWrap then
    TextLayout.SetWordWrapping(DWRITE_WORD_WRAPPING_NO_WRAP)
  else
    TextLayout.SetWordWrapping(DWRITE_WORD_WRAPPING_WRAP);

  if TFontStyle.fsStrikeOut in FFont.Style then
    TextLayout.SetStrikethrough(True, TextRange);

  if TFontStyle.fsUnderline in FFont.Style then
    TextLayout.SetUnderline(True, TextRange);

  // formating
  case AVTextAlign of
    TTextAlign.taCenter:
      begin
        TextLayout.SetParagraphAlignment(DWRITE_PARAGRAPH_ALIGNMENT_CENTER);
      end;
    TTextAlign.taLeading:
      begin
        TextLayout.SetParagraphAlignment(DWRITE_PARAGRAPH_ALIGNMENT_NEAR);
      end;
    TTextAlign.taTrailing:
      begin
        TextLayout.SetParagraphAlignment(DWRITE_PARAGRAPH_ALIGNMENT_FAR);
      end;
  end;
  case ATextAlign of
    TTextAlign.taCenter:
      begin
        TextLayout.SetTextAlignment(DWRITE_TEXT_ALIGNMENT_CENTER);
      end;
    TTextAlign.taLeading:
      begin
        TextLayout.SetTextAlignment(DWRITE_TEXT_ALIGNMENT_LEADING);
      end;
    TTextAlign.taTrailing:
      begin
        TextLayout.SetTextAlignment(DWRITE_TEXT_ALIGNMENT_TRAILING);
      end;
  end;

  // measure
  TextLayout.GetLineMetrics(NIL, 0, LineCount);
  if LineCount > 0 then
  begin
    SetLength(LineMetrics, LineCount);
    TextLayout.GetLineMetrics(@(LineMetrics[0]), LineCount, LineCount);

    ALines.Count := LineCount;
    P := 1;
    for I := 0 to LineCount - 1 do
    begin
      ALines.Metrics[I].Index := P;
//      if LineMetrics[I].newlineLength = 0 then
//        ALines.Metrics[I].LineTypes := []
//      else
//        ALines.Metrics[I].LineTypes := [TLineType.ltWrap];
      P := P + LineMetrics[I].length;
    end;
  end;
  TextFormat := nil;
  TextLayout := nil;
end;

{ Shared }

class procedure TCanvasD2D.CreateSharedResources;
var
{$IFDEF D2DEBUG}
  Opts: D2D1_FACTORY_OPTIONS;
{$ENDIF}
  Prop: TD2D1RenderTargetProperties;
  Desc: TD3D10_Texture2DDesc;
begin
  if not Assigned(FFactory) then
  begin
    {$IFDEF D2DEBUG}
    Opts.debugLevel := D2D1_DEBUG_LEVEL_INFORMATION;
    D2D1CreateFactory(D2D1_FACTORY_TYPE_MULTI_THREADED, ID2D1Factory, @Opts, FFactory);
    {$ELSE}
    D2D1CreateFactory(D2D1_FACTORY_TYPE_MULTI_THREADED, ID2D1Factory, nil, FFactory);
    {$ENDIF}
    DWriteCreateFactory(DWRITE_FACTORY_TYPE_SHARED, IDWriteFactory, IUnknown(FDWriteFactory));

    if Assigned(TCustomDX10Context.SharedDevice) then
    begin
      FillChar(Desc, SizeOf(D3D10_TEXTURE2D_DESC), 0);
      Desc.Format := DXGI_FORMAT_B8G8R8A8_UNORM;
      Desc.Width := 1;
      Desc.Height := 1;
      Desc.MipLevels := 1;
      Desc.ArraySize := 1;
      Desc.SampleDesc.Count := 1;
      Desc.SampleDesc.Quality := 0;
      Desc.Usage := D3D10_USAGE_DEFAULT;
      Desc.BindFlags := D3D10_BIND_RENDER_TARGET or D3D10_BIND_SHADER_RESOURCE;
      Res := TCustomDX10Context.SharedDevice.CreateTexture2D(Desc, nil, FSharedTexture);
      Prop := D2D1RenderTargetProperties(TargetMode, D2D1PixelFormat(DXGI_FORMAT_UNKNOWN, D2D1_ALPHA_MODE_PREMULTIPLIED));
      Res := FFactory.CreateDxgiSurfaceRenderTarget(FSharedTexture as IDXGISurface, Prop, FSharedRenderTarget);
    end;
  end;
end;

class function TCanvasD2D.Factory: ID2D1Factory;
begin
  CreateSharedResources;
  Result := FFactory;
end;

class function TCanvasD2D.SharedRenderTarget: ID2D1RenderTarget;
begin
  CreateSharedResources;
  Result := FSharedRenderTarget;
end;

class function TCanvasD2D.ImagingFactory: IWICImagingFactory;
begin
  if not Assigned(FImagingFactory) then
  begin
    CoCreateInstance(CLSID_WICImagingFactory, nil, CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER,
      IUnknown, FImagingFactory);
  end;
  Result := FImagingFactory;
end;

class function TCanvasD2D.DWriteFactory: IDWriteFactory;
begin
  CreateSharedResources;
  Result := FDWriteFactory;
end;

class procedure TCanvasD2D.DestroySharedResources;
begin
  FDWriteFactory := nil;
  FSharedRenderTarget := nil;
  FSharedTexture := nil;
  FFactory := nil;
end;

{ Bitmaps }

class procedure TCanvasD2D.DoInitializeBitmap(const Bitmap: TBitmap);
var
  H: TD2DBitmap;
  Desc: TD3D10_Texture2DDesc;
begin
  CreateSharedResources;
  if Assigned(FSharedRenderTarget) then
  begin
    H := TD2DBitmap.Create;
    H.Bitmap := Bitmap;
    H.Access := TMapAccess.maRead;
    (Bitmap as IBitmapAccess).Handle := THandle(H);
    (Bitmap as IBitmapAccess).PixelFormat := TPixelFormat.pfA8R8G8B8;

    FillChar(Desc, SizeOf(D3D10_TEXTURE2D_DESC), 0);
    Desc.Format := DXGI_FORMAT_B8G8R8A8_UNORM;
    Desc.Width := Bitmap.Width;
    Desc.Height := Bitmap.Height;
    Desc.MipLevels := 1;
    Desc.ArraySize := 1;
    Desc.SampleDesc.Count := 1;
    Desc.SampleDesc.Quality := 0;
    Desc.Usage := D3D10_USAGE_DEFAULT;
    Desc.BindFlags := D3D10_BIND_RENDER_TARGET or D3D10_BIND_SHADER_RESOURCE;
    Res := TCustomDX10Context.SharedDevice.CreateTexture2D(Desc, nil, H.Texture);
  end;
end;

class procedure TCanvasD2D.DoFinalizeBitmap(const Bitmap: TBitmap);
var
  H: TD2DBitmap;
begin
  H := TD2DBitmap(Bitmap.Handle);
  H.SharedBitmap := nil;
  H.MapBuffer := nil;
  H.Texture := nil;
  H.Free;
end;

class function TCanvasD2D.DoMapBitmap(const Bitmap: TBitmap; const Access: TMapAccess; var Data: TBitmapData): Boolean;
var
  H: TD2DBitmap;
  Desc: TD3D10_Texture2DDesc;
  Mapped: D3D10_MAPPED_TEXTURE2D;
  Flags: TD3D10_Map;
begin
  Result := False;
  H := TD2DBitmap(Bitmap.Handle);
  H.Access := Access;
  if not Assigned(H.MapBuffer) then
  begin
    FillChar(Desc, SizeOf(D3D10_TEXTURE2D_DESC), 0);
    Desc.Format := DXGI_FORMAT_B8G8R8A8_UNORM;
    Desc.Width := Bitmap.Width;
    Desc.Height := Bitmap.Height;
    Desc.MipLevels := 1;
    Desc.ArraySize := 1;
    Desc.SampleDesc.Count := 1;
    Desc.SampleDesc.Quality := 0;
    Desc.CPUAccessFlags := D3D10_CPU_ACCESS_READ or D3D10_CPU_ACCESS_WRITE;
    Desc.Usage := D3D10_USAGE_STAGING;
    Desc.BindFlags := 0;
    Res := TCustomDX10Context.SharedDevice.CreateTexture2D(Desc, nil, H.MapBuffer);
  end;
  case Access of
    TMapAccess.maRead:
      begin
        Flags := D3D10_MAP_READ;
        TCustomDX10Context.SharedDevice.CopyResource(H.MapBuffer, H.Texture);
      end;
    TMapAccess.maWrite:
      begin
        Flags := D3D10_MAP_WRITE;
      end;
  else
    Flags := D3D10_MAP_READ_WRITE;
    TCustomDX10Context.SharedDevice.CopyResource(H.MapBuffer, H.Texture);
  end;
  if Succeeded(H.MapBuffer.Map(0, Flags, 0, Mapped)) then
  begin
    Data.Data := Mapped.pData;
    Data.Pitch := Mapped.RowPitch;
    Result := True;
  end;
end;

class procedure TCanvasD2D.DoUnmapBitmap(const Bitmap: TBitmap; var Data: TBitmapData);
var
  H: TD2DBitmap;
begin
  H := TD2DBitmap(Bitmap.Handle);
  H.MapBuffer.Unmap(0);
  case H.Access of
    TMapAccess.maWrite:
      begin
        TCustomDX10Context.SharedDevice.CopyResource(H.Texture, H.MapBuffer);
      end;
    TMapAccess.maReadWrite:
      begin
        TCustomDX10Context.SharedDevice.CopyResource(H.Texture, H.MapBuffer);
      end;
  end;
end;

procedure TCanvasD2D.DoDrawBitmap(const ABitmap: TBitmap; const SrcRect, DstRect: TRectF; const AOpacity: Single;
  const HighSpeed: Boolean = False);
var
  SR, DR: TD2D1RectF;
  IntMode: TD2D1BitmapInterpolationMode;
  B: ID2D1Bitmap;
begin
  if FTarget <> nil then
  begin
    SR := D2Rect(SrcRect);
    DR := D2Rect(DstRect);

    if ABitmap.HandleAllocated then
    begin
      if HighSpeed then
        IntMode := D2D1_BITMAP_INTERPOLATION_MODE_NEAREST_NEIGHBOR
      else
        IntMode := D2D1_BITMAP_INTERPOLATION_MODE_LINEAR;

      B := TD2DBitmap(ABitmap.Handle).CreateBitmap(FTarget);
      FTarget.DrawBitmap(B, @DR, AOpacity, IntMode, @SR);
    end;
  end;
end;

{ Path }

procedure TCanvasD2D.DoDrawPath(const APath: TPathData; const AOpacity: Single; const ABrush: TStrokeBrush);
var
  i: Integer;
  CP1, CP2: TPointF;
  Geometry: ID2D1PathGeometry;
  Path: ID2D1GeometrySink;
  Closed: Boolean;
begin
  if (FTarget <> nil) then
  begin
    ApplyStroke(ABrush, APath.GetBounds, AOpacity);

    Factory.CreatePathGeometry(Geometry);
    Geometry.Open(Path);
    i := 0;
    Closed := False;
    while i < APath.Count do
    begin
      case APath[i].Kind of
        TPathPointKind.ppMoveTo:
          begin
            if (i > 0) and (APath[i - 1].Kind <> TPathPointKind.ppClose) then
              Path.EndFigure(D2D1_FIGURE_END_OPEN);
            Path.BeginFigure(D2Point(APath[i].Point.X,
              APath[i].Point.Y), D2D1_FIGURE_BEGIN_FILLED);
          end;
        TPathPointKind.ppLineTo:
          begin
            Path.AddLine(D2Point(APath[i].Point.X,
              APath[i].Point.Y));
          end;
        TPathPointKind.ppCurveTo:
          begin
            CP1 := PointF(APath[i].Point.X, APath[i].Point.Y);
            Inc(i);
            CP2 := PointF(APath[i].Point.X, APath[i].Point.Y);
            Inc(i);
            Path.AddBezier(D2Bezier(CP1.X, CP1.y, CP2.X, CP2.y, APath[i].Point.X, APath[i].Point.Y));
          end;
        TPathPointKind.ppClose:
          begin
            Path.EndFigure(D2D1_FIGURE_END_CLOSED);
            Closed := True;
          end;
      end;
      Inc(i);
    end;

    if not Closed then
      Path.EndFigure(D2D1_FIGURE_END_OPEN);

    Res := Path.Close;
    FTarget.DrawGeometry(Geometry, FStrokeBrush, ABrush.Thickness, FStrokeStyle);
  end;
end;

procedure TCanvasD2D.DoFillPath(const APath: TPathData; const AOpacity: Single; const ABrush: TBrush);
var
  i: Integer;
  CP1, CP2: TPointF;
  Geometry: ID2D1PathGeometry;
  Path: ID2D1GeometrySink;
  Closed: Boolean;
begin
  Factory.CreatePathGeometry(Geometry);
  Geometry.Open(Path);
  i := 0;
  Closed := False;
  while i < APath.Count do
  begin
    case APath[i].Kind of
      TPathPointKind.ppMoveTo:
        begin
          if (i > 0) and (APath[i - 1].Kind <> TPathPointKind.ppClose) then
            Path.EndFigure(D2D1_FIGURE_END_OPEN);
          Path.BeginFigure(D2Point(APath[i].Point.X,
            APath[i].Point.Y), D2D1_FIGURE_BEGIN_FILLED);
        end;
      TPathPointKind.ppLineTo:
        begin
          Path.AddLine(D2Point(APath[i].Point.X,
            APath[i].Point.Y));
        end;
      TPathPointKind.ppCurveTo:
        begin
          CP1 := PointF(APath[i].Point.X, APath[i].Point.Y);
          Inc(i);
          CP2 := PointF(APath[i].Point.X, APath[i].Point.Y);
          Inc(i);
          Path.AddBezier(D2Bezier(CP1.X, CP1.y, CP2.X, CP2.y, APath[i].Point.X, APath[i].Point.Y));
        end;
      TPathPointKind.ppClose:
        begin
          Path.EndFigure(D2D1_FIGURE_END_CLOSED);
          Closed := True;
        end;
    end;
    Inc(i);
  end;
  if not Closed then
    Path.EndFigure(D2D1_FIGURE_END_OPEN);
  Path.Close;
  ApplyFill(ABrush, APath.GetBounds, AOpacity);
  FTarget.FillGeometry(Geometry, FBrush, nil);
end;

function TCanvasD2D.PtInPath(const APoint: TPointF; const APath: TPathData): Boolean;
var
  i: Integer;
  B: TRectF;
  CP1, CP2: TPointF;
  Geometry: ID2D1PathGeometry;
  Path: ID2D1GeometrySink;
  Cont: LongBool;
  Closed: Boolean;
begin
  Result := False;
  B := APath.GetBounds;
  if not B.Contains(APoint) then
    Result := False
  else
  begin
    if APath.IsEmpty then
      Exit;
    Factory.CreatePathGeometry(Geometry);
    Geometry.Open(Path);
    i := 0;
    Closed := False;
    while i < APath.Count do
    begin
      case APath[i].Kind of
        TPathPointKind.ppMoveTo:
          begin
            Path.BeginFigure(D2Point(APath[i].Point.X,
              APath[i].Point.Y), D2D1_FIGURE_BEGIN_FILLED);
          end;
        TPathPointKind.ppLineTo:
          begin
            Path.AddLine(D2Point(APath[i].Point.X,
              APath[i].Point.Y));
          end;
        TPathPointKind.ppCurveTo:
          begin
            CP1 := PointF(APath[i].Point.X, APath[i].Point.Y);
            Inc(i);
            CP2 := PointF(APath[i].Point.X, APath[i].Point.Y);
            Inc(i);
            Path.AddBezier(D2Bezier(CP1.X, CP1.y, CP2.X, CP2.y, APath[i].Point.X, APath[i].Point.Y));
          end;
        TPathPointKind.ppClose:
          begin
            Path.EndFigure(D2D1_FIGURE_END_CLOSED);
            Closed := True;
          end;
      end;
      Inc(i);
    end;
    if not Closed then
      Path.EndFigure(D2D1_FIGURE_END_OPEN);

    Path.Close;
    Geometry.FillContainsPoint(D2Point(APoint.X, APoint.y), IdentM, 1, Cont);

    Result := Cont;
  end;
end;

{ TTextRendering }

type
  TSink = class(TInterfacedPersistent, ID2D1SimplifiedGeometrySink)
  private
    Path: TPathData;
    procedure SetFillMode(FillMode: TD2D1FillMode); stdcall;
    procedure SetSegmentFlags(VertexFlags: TD2D1PathSegment); stdcall;
    procedure BeginFigure(StartPoint: TD2D1Point2F; FigureBegin: TD2D1FigureBegin); stdcall;
    procedure AddLines(Points: PD2D1Point2F;
      (* __in_ecount(pointsCount) *) PointsCount: LongWord); stdcall;
    procedure AddBeziers(Beziers: PD2D1BezierSegment;
      (* __in_ecount(beziersCount) *) BeziersCount: LongWord); stdcall;
    procedure EndFigure(FigureEnd: D2D1_FIGURE_END); stdcall;
    function Close: HResult; stdcall;
  public
    ShiftX: Single;
    ShiftY: Single;
  end;

{ TSink }

procedure TSink.BeginFigure(StartPoint: TD2D1Point2F; FigureBegin: TD2D1FigureBegin);
begin
  Path.MoveTo(PointF(StartPoint.x + ShiftX, StartPoint.y + ShiftY));
end;

procedure TSink.AddBeziers(Beziers: PD2D1BezierSegment; BeziersCount: LongWord);
var
  i: Integer;
begin
  for i := 0 to BeziersCount - 1 do
  begin
    Path.CurveTo(
      PointF(Beziers.point1.x + ShiftX, Beziers.point1.y + ShiftY),
      PointF(Beziers.point2.x + ShiftX, Beziers.point2.y + ShiftY),
      PointF(Beziers.point3.x + ShiftX, Beziers.point3.y + ShiftY)
    );
    Inc(Beziers);
  end;
end;

procedure TSink.AddLines(Points: PD2D1Point2F; PointsCount: LongWord);
var
  i: Integer;
begin
  for i := 0 to PointsCount - 1 do
  begin
    Path.LineTo(PointF(Points^.x + ShiftX, Points^.y + ShiftY));
    Inc(Points);
  end;
end;

procedure TSink.EndFigure(FigureEnd: D2D1_FIGURE_END);
begin
  Path.ClosePath;
end;

function TSink.Close: HResult;
begin
  Result := S_OK;
end;

procedure TSink.SetFillMode(FillMode: TD2D1FillMode);
begin
end;

procedure TSink.SetSegmentFlags(VertexFlags: TD2D1PathSegment);
begin
end;

type

{ TTextRendering }

  TTextRendering = class(TInterfacedPersistent, IDWriteTextRenderer)
  private
    function IsPixelSnappingDisabled(clientDrawingContext: Pointer; var isDisabled: BOOL): HResult; stdcall;

    function GetCurrentTransform(clientDrawingContext: Pointer; var Transform: TDwriteMatrix): HResult; stdcall;

    function GetPixelsPerDip(clientDrawingContext: Pointer; var pixelsPerDip: Single): HResult; stdcall;
    function DrawGlyphRun(clientDrawingContext: Pointer; baselineOriginX: Single; baselineOriginY: Single;
      measuringMode: TDWriteMeasuringMode; var glyphRun: TDwriteGlyphRun;
      var glyphRunDescription: TDwriteGlyphRunDescription; const clientDrawingEffect: IUnknown): HResult; stdcall;

    function DrawUnderline(clientDrawingContext: Pointer; baselineOriginX: Single; baselineOriginY: Single;
      var underline: TDwriteUnderline; const clientDrawingEffect: IUnknown): HResult; stdcall;

    function DrawStrikethrough(clientDrawingContext: Pointer; baselineOriginX: Single; baselineOriginY: Single;
      var strikethrough: TDwriteStrikethrough; const clientDrawingEffect: IUnknown): HResult; stdcall;

    function DrawInlineObject(clientDrawingContext: Pointer; originX: Single; originY: Single;
      var inlineObject: IDWriteInlineObject; isSideways: BOOL; isRightToLeft: BOOL;
      const clientDrawingEffect: IUnknown): HResult; stdcall;
  end;

function TTextRendering.DrawGlyphRun(clientDrawingContext: Pointer; baselineOriginX: Single; baselineOriginY: Single;
  measuringMode: TDWriteMeasuringMode; var glyphRun: TDwriteGlyphRun;
  var glyphRunDescription: TDwriteGlyphRunDescription; const clientDrawingEffect: IUnknown): HResult;
var
  pPathGeometry: ID2D1PathGeometry;
  pSink: ID2D1GeometrySink;
  pSimSink: TSink;
begin
  // Create the path geometry.
  Res := TCanvasD2D.Factory.CreatePathGeometry(pPathGeometry);
  // Write to the path geometry using the geometry sink.
  if (SUCCEEDED(Res)) then
    Res := pPathGeometry.Open(pSink);
  // Get the glyph run outline geometries back from DirectWrite and place them within the geometry sink.
  if (SUCCEEDED(Res)) then
  begin
    Res := glyphRun.fontFace.GetGlyphRunOutline(glyphRun.fontEmSize, glyphRun.glyphIndices, glyphRun.glyphAdvances,
      glyphRun.glyphOffsets, glyphRun.glyphCount, glyphRun.isSideways, False { glyphRun.bidiLevel } , pSink);
  end;
  // Close the geometry sink
  if (SUCCEEDED(Res)) then
    Res := pSink.Close();
  // Simplify
  pSimSink := TSink.Create;
  //instead pSimSink.Path.Translate(baselineOriginX, baselineOriginY),
  //if we need to add new figure to an existing path
  pSimSink.ShiftX := baselineOriginX;
  pSimSink.ShiftY := baselineOriginY;
  pSimSink.Path := TPathData(clientDrawingContext);
  Res := pPathGeometry.Simplify(D2D1_GEOMETRY_SIMPLIFICATION_OPTION_CUBICS_AND_LINES, IdentM, 0, pSimSink);
  pSimSink.Close;
  pSimSink.Free;
  Result := S_OK;
end;

function TTextRendering.DrawInlineObject(clientDrawingContext: Pointer; originX: Single; originY: Single;
  var inlineObject: IDWriteInlineObject; isSideways: BOOL; isRightToLeft: BOOL;
  const clientDrawingEffect: IUnknown): HResult;
begin
  Result := S_OK;
end;

function TTextRendering.DrawStrikethrough(clientDrawingContext: Pointer; baselineOriginX: Single;
  baselineOriginY: Single; var strikethrough: TDwriteStrikethrough; const clientDrawingEffect: IUnknown): HResult;
begin
  Result := S_OK;
end;

function TTextRendering.DrawUnderline(clientDrawingContext: Pointer; baselineOriginX: Single; baselineOriginY: Single;
  var underline: TDwriteUnderline; const clientDrawingEffect: IUnknown): HResult;
begin
  Result := S_OK;
end;

function TTextRendering.GetCurrentTransform(clientDrawingContext: Pointer; var Transform: TDwriteMatrix): HResult;
begin
  Transform := TDwriteMatrix(D2Matrix(IdentityMatrix));
  Result := S_OK;
end;

function TTextRendering.GetPixelsPerDip(clientDrawingContext: Pointer; var pixelsPerDip: Single): HResult;
begin
  pixelsPerDip := 1;
  Result := S_OK;
end;

function TTextRendering.IsPixelSnappingDisabled(clientDrawingContext: Pointer; var isDisabled: BOOL): HResult;
begin
  isDisabled := True;
  Result := S_OK;
end;

{ TD2DCanvasSaveState }

procedure TD2DCanvasSaveState.Assign(Source: TPersistent);
var
  LSource: TCanvasD2D;
begin
  inherited Assign(Source);
  if Source is TCanvasD2D then
  begin                                                            
    LSource := TCanvasD2D(Source);
    OleCheck(TCanvasD2D.Factory.CreateDrawingStateBlock(nil, nil, FStateBlock));
    LSource.FTarget.SaveDrawingState(FStateBlock);
    LSource.FCurrentSaveState := Self;
  end; 
end;

procedure TD2DCanvasSaveState.AssignTo(Dest: TPersistent);
var
  LDest: TCanvasD2D;
begin
  if Dest is TCanvasD2D then
  begin
    LDest := TCanvasD2D(Dest);
    LDest.FCurrentSaveState := nil;
    LDest.FTarget.RestoreDrawingState(FStateBlock);
    if FLayer <> nil then
    begin
      LDest.FTarget.PopLayer;
      FLayer := nil;
    end;
  end;
  inherited AssignTo(Dest);
end;

procedure TD2DCanvasSaveState.CreateLayer(const RenderTarget: ID2D1RenderTarget);
begin
  OleCheck(RenderTarget.CreateLayer(nil, FLayer));
end;

{ TTextLayoutD2D }

procedure TTextLayoutD2D.ConvertToPath(const APath: TPathData);
var
  PathRendering: TTextRendering;
begin
  if Text.IsEmpty or not Assigned(APath) then
    Exit;

  PathRendering := TTextRendering.Create;
                                                                                     
  FLayout.Draw(APath, PathRendering, 0, 0);

  FreeAndNil(PathRendering);
end;

constructor TTextLayoutD2D.Create(const ACanvas: TCanvas);
begin
  inherited Create(ACanvas);
  FLayout := nil;
  FBrush := nil;
end;

destructor TTextLayoutD2D.Destroy;
begin
  FLayout := nil;
  FBrush := nil;
  inherited;
end;

procedure TTextLayoutD2D.DoDrawLayout(const ACanvas: TCanvas);

  function SameColor: Boolean;
  var
    LColor: TD2D1ColorF;
  begin
    ID2D1SolidColorBrush(FBrush).GetColor(LColor);
    Result := SameValue(LColor.r, TAlphaColorRec(Color).R / $FF) and
              SameValue(LColor.b, TAlphaColorRec(Color).B / $FF) and
              SameValue(LColor.g, TAlphaColorRec(Color).G / $FF) and
              SameValue(LColor.a, TAlphaColorRec(Color).A / $FF * Opacity);
  end;

begin
  if not Assigned(ACanvas) or not (ACanvas is TCanvasD2D) or
     Text.IsEmpty or not Assigned(FLayout) then
    Exit;

  if Assigned(FLayout) and (not Assigned(FBrush) or
    not SameValue(FBrush.GetOpacity, Opacity) or not SameColor) then
    begin
      FBrush := nil;
      // Creating brush
      TCanvasD2D(ACanvas).FTarget.CreateSolidColorBrush(
        D2Color(Color, Opacity), nil, ID2D1SolidColorBrush(FBrush));
    end;

  if Assigned(FLayout) and Assigned(FBrush) then
    TCanvasD2D(ACanvas).FTarget.DrawTextLayout(
      D2Point(TopLeft.X + Padding.Left, TopLeft.Y + Padding.Top),
      FLayout,
      FBrush,
      D2D1_DRAW_TEXT_OPTIONS_CLIP);
end;

procedure TTextLayoutD2D.DoRenderLayout;
var
  TextRange: TDWriteTextRange;
  TextFormat: IDWriteTextFormat;
  i: Integer;
  LocaleName: string;
  Attr: TTextAttributedRange;
  TrimOptions: TDwriteTrimming;
  trimminSign: IDWriteInlineObject;
begin
  FLayout := nil;
  if Succeeded(TCanvasD2D.DWriteFactory.CreateTextFormat(
       PChar(Font.Family),
       nil,
       D2FontWeight(Font.Style),
       D2FontStyle(Font.Style),
       DWRITE_FONT_STRETCH_NORMAL,
       Font.Size,
       PChar(LocaleName),
       TextFormat)) then
  try
    if RightToLeft then
      TextFormat.SetReadingDirection(DWRITE_READING_DIRECTION_RIGHT_TO_LEFT)
    else
      TextFormat.SetReadingDirection(DWRITE_READING_DIRECTION_LEFT_TO_RIGHT);

    //Word wrap
    if WordWrap then
      TextFormat.SetWordWrapping(DWRITE_WORD_WRAPPING_WRAP)
    else
      TextFormat.SetWordWrapping(DWRITE_WORD_WRAPPING_NO_WRAP);
    //Trimming
    ZeroMemory(@TrimOptions, SizeOf(TrimOptions));
    case Trimming of
      TTextTrimming.ttNone:
        TrimOptions.granularity := DWRITE_TRIMMING_GRANULARITY_NONE;
      TTextTrimming.ttCharacter:
        TrimOptions.granularity := DWRITE_TRIMMING_GRANULARITY_CHARACTER;
      TTextTrimming.ttWord:
        TrimOptions.granularity := DWRITE_TRIMMING_GRANULARITY_WORD;
    end;
    trimminSign := nil;
    if Trimming <> TTextTrimming.ttNone then
      TCanvasD2D.DWriteFactory.CreateEllipsisTrimmingSign(TextFormat, trimminSign);
    TextFormat.SetTrimming(TrimOptions, trimminSign);
    trimminSign := nil;

    if Succeeded(TCanvasD2D.DWriteFactory.CreateTextLayout(
         PChar(Text),
         Text.Length,
         TextFormat,
         MaxSize.X - Padding.Left - Padding.Right,
         MaxSize.Y - Padding.Top - Padding.Bottom,
         FLayout)) then
    try
      TextRange.StartPosition := 0;
      TextRange.Length := Text.Length;
      FLayout.SetStrikethrough(TFontStyle.fsStrikeOut in Font.Style, TextRange);
      FLayout.SetUnderline(TFontStyle.fsUnderline in Font.Style, TextRange);

      for i := 0 to AttributesCount - 1 do
      begin
        Attr := Attributes[i];

        if Assigned(Attr.Attribute.Font) then
        begin
          TextRange.startPosition := Attr.Range.Pos;
          TextRange.length := Attr.Range.Length;

          FLayout.SetStrikethrough(TFontStyle.fsStrikeOut in Attr.Attribute.Font.Style, TextRange);
          FLayout.SetUnderline(TFontStyle.fsUnderline in Attr.Attribute.Font.Style, TextRange);
          if Attr.Attribute.Font.Size <> Font.Size then
            FLayout.SetFontSize(Attr.Attribute.Font.Size, TextRange);
          FLayout.SetFontWeight(D2FontWeight(Attr.Attribute.Font.Style), TextRange);
          FLayout.SetFontStyle(D2FontStyle(Attr.Attribute.Font.Style), TextRange);

          if Attr.Attribute.Font.Family <> Font.Family then
            Res := FLayout.SetFontFamilyName(TMarshal.InString(Attr.Attribute.Font.Family), TextRange);
        end;
      end;

      // formating
      case HorizontalAlign of
        TTextAlign.taCenter:
          FLayout.SetTextAlignment(DWRITE_TEXT_ALIGNMENT_CENTER);
        TTextAlign.taLeading:
          FLayout.SetTextAlignment(DWRITE_TEXT_ALIGNMENT_LEADING);
        TTextAlign.taTrailing:
          FLayout.SetTextAlignment(DWRITE_TEXT_ALIGNMENT_TRAILING);
      end;
      case VerticalAlign of
        TTextAlign.taCenter:
          FLayout.SetParagraphAlignment(DWRITE_PARAGRAPH_ALIGNMENT_CENTER);
        TTextAlign.taLeading:
          FLayout.SetParagraphAlignment(DWRITE_PARAGRAPH_ALIGNMENT_NEAR);
        TTextAlign.taTrailing:
          FLayout.SetParagraphAlignment(DWRITE_PARAGRAPH_ALIGNMENT_FAR);
      end;
      //Calculatiog size
      FLayout.GetMetrics(FMetrics);
    except
      FLayout := nil;
    end;
  finally
    TextFormat := nil;
  end;
end;

function TTextLayoutD2D.GetTextHeight: Single;
begin
  if Assigned(FLayout) then
    Result := Min(FMetrics.height, FMetrics.layoutHeight)
  else
    Result := 0;
end;

function TTextLayoutD2D.GetTextRect: TRectF;
begin
  Result := TRectF.Create(FMetrics.left, FMetrics.top,
    FMetrics.left + TextWidth,
    FMetrics.top + TextHeight);
  Result.Offset(TopLeft);
  if FMetrics.top < 0 then
    Result.Offset(0, Abs(FMetrics.top));
end;

function TTextLayoutD2D.GetTextWidth: Single;
begin
  if Assigned(FLayout) then
    Result := FMetrics.widthIncludingTrailingWhitespace
  else
    Result := 0;
end;

function TTextLayoutD2D.DoPositionAtPoint(const APoint: TPointF): Integer;
var
  TrailingHit: BOOL;
  Inside: BOOL;
  HitTestMetrics: TDWriteHitTestMetrics;
  LRect: TRectF;
  Count: Cardinal;
  HitTestMetricsArray: array of TDWriteHitTestMetrics;
begin
  Result := -1;

  if not Assigned(FLayout) then
    Exit;

  LRect := Self.TextRect;
  LRect.Width := Max(LRect.Width, MaxSize.X);
  if (APoint.X >= LRect.Left) and (APoint.X <= LRect.Right) and (APoint.Y >= LRect.Top)
    and (APoint.Y <= LRect.Bottom) then
  begin
    FLayout.HitTestPoint(APoint.X - TopLeft.X - Padding.Left,
      APoint.Y - TopLeft.Y - Padding.Top, TrailingHit, Inside, HitTestMetrics);
    Result := HitTestMetrics.textPosition;
    if TrailingHit or Inside then
    begin
      //Checking if we hit after the middle of charecter, when increasing
      //position. This will handle situation when we need to set position after
      //last charecter in text.
      Count := 1;
      SetLength(HitTestMetricsArray, 1);
      FLayout.HitTestTextRange(Result, 1, 0, 0, HitTestMetricsArray[0], Count, Count);
      if Count > 0 then
      begin
        if (HitTestMetricsArray[0].width > 0) and (APoint.X > (TopLeft.X + HitTestMetricsArray[0].Left + HitTestMetricsArray[0].width * 3 / 5)) then
          Inc(Result);
      end
      else
        if (FMetrics.widthIncludingTrailingWhitespace > 0) and (APoint.X > (TopLeft.X + FMetrics.left + FMetrics.widthIncludingTrailingWhitespace * 3 / 5)) then
          Inc(Result);
    end;
  end;
end;

function TTextLayoutD2D.DoRegionForRange(const ARange: TTextRange): TRegion;
var
  HitTestMetrics: array of TDWriteHitTestMetrics;
  HitTestMetric: TDWriteHitTestMetrics;
  Count: Cardinal;
  i, RemainsLength, RangeLength: Integer;
begin
  if ARange.Pos < 0 then
    Exit;

  RangeLength := Text.Length;
  if ARange.Pos > RangeLength then
    Exit;

  SetLength(Result, 0);
  if (ARange.Length = 0) and Text.IsEmpty then
  begin
    SetLength(Result, 1);
    Result[0] := Self.TextRect;
    Exit;
  end;
  RemainsLength := Min(ARange.Length, RangeLength - ARange.Pos);
  SetLength(HitTestMetrics, 1);
  FLayout.HitTestTextRange(ARange.Pos,
    RemainsLength, 0, 0, HitTestMetrics[0], 0, Count);
  SetLength(HitTestMetrics, Count);
  FLayout.HitTestTextRange(ARange.Pos,
    RemainsLength, 0, 0, HitTestMetrics[0], Count, Count);
  if Count > 0 then
    for i := 0 to High(HitTestMetrics) do
    begin
      SetLength(Result, Length(Result) + 1);
      HitTestMetric := HitTestMetrics[i];
      Result[High(Result)] := TRectF.Create(HitTestMetric.left,
                                HitTestMetric.top,
                                HitTestMetric.left + HitTestMetric.width,
                                HitTestMetric.top + HitTestMetric.height);
      Result[High(Result)].Offset(TopLeft);
      Result[High(Result)].Offset(Padding.Left, Padding.Top);
  end;
end;

procedure RegisterCanvasClasses;
begin
  if (TCustomDX10Context.CheckDevice = D3D10_DRIVER_TYPE_HARDWARE) or
     (TCustomDX10Context.CheckDevice = D3D10_DRIVER_TYPE_WARP) then
  begin
    // check for classic theme mode
    if InitThemeLibrary and UseThemes and GlobalUseDirect2D then
      TCanvasManager.RegisterCanvas(TCanvasD2D, True, False);
  end;
end;

procedure UnregisterCanvasClasses;
begin
  TCanvasD2D.DestroySharedResources;
end;

initialization
  TTextLayoutManager.RegisterTextLayout(TTextLayoutD2D, TCanvasD2D);
  FillChar(IdentM, SizeOf(IdentM), 0);
  IdentM._11 := 1;
  IdentM._22 := 1;
  TBitmapCodecManager.RegisterBitmapCodecClass('.bmp', SVBitmaps, True, TBitmapCodecWIC);
  TBitmapCodecManager.RegisterBitmapCodecClass('.jpg', SVJPGImages, True, TBitmapCodecWIC);
  TBitmapCodecManager.RegisterBitmapCodecClass('.jpeg', SVJPGImages, True, TBitmapCodecWIC);
  TBitmapCodecManager.RegisterBitmapCodecClass('.png', SVPNGImages, True, TBitmapCodecWIC);
  TBitmapCodecManager.RegisterBitmapCodecClass('.gif', SVGIFImages, True, TBitmapCodecWIC);
  TBitmapCodecManager.RegisterBitmapCodecClass('.tif', SVTIFFImages, True, TBitmapCodecWIC);
  TBitmapCodecManager.RegisterBitmapCodecClass('.ico', SVIcons, True, TBitmapCodecWIC);
  TBitmapCodecManager.RegisterBitmapCodecClass('.wmp', SWMPImages, True, TBitmapCodecWIC);
end.
