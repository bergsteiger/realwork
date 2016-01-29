{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.MagnifierGlass;

interface

uses
  System.Types, System.Classes, System.UITypes,
  FMX.Controls, FMX.Types, FMX.Objects;

{$SCOPEDENUMS ON}

const
  DEFAULT_LOUPE_SCALE = 1.4;

type

{ TMagnifierGlass }

  /// <summary>
  ///   Two options of display of a magnifying glass - a round and rectangular
  ///   lens <see cref="TMagnifierGlass"/>.
  /// </summary>
  TLoupeMode = (lmCircle, lmRectangle);

  TZoomMode = (zmAbsolute, zmRelative);

  TCustomMagnifierGlass = class (TStyledControl)
  strict private
    FLoupeMode: TLoupeMode;
    FLoupeScale: Single;
    FZoomRegionCenter: TPosition;
    FZoomMode: TZoomMode;
    FBackgroundColor: TAlphaColor;
    FParentScreenshotBitmap: TBitmap;
    FScaledBitmap: TBitmap;
    FContent: TShape;
    procedure SetLoupeMode(const Value: TLoupeMode);
    procedure SetLoupeScale(const Value: Single);
    procedure SetZoomMode(const Value: TZoomMode);
    procedure SetBackgroundColor(const Value: TAlphaColor);
    function IsLoupeScaleStored: Boolean;
    function GetScreenScale: Single;
  protected
    procedure SetZoomRegionCenter(const Value: TPosition); virtual;
    function GetZoomRect: TRectF; virtual;
    procedure DoZoomRegionChanged(Sender: TObject);
    { Style }
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    function GetDefaultStyleLookupName: string; override;
    function HasContent: Boolean;
    { Painting }
    procedure Paint; override;
    procedure AfterPaint; override;
    property ScreenScale: Single read GetScreenScale;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    /// <summary>
    ///   Area center round which the image will be increased. Uses only, when ZoomMode = zmAbsolute
    /// </summary>
    property ZoomRegionCenter: TPosition read FZoomRegionCenter write SetZoomRegionCenter;
    property ZoomMode: TZoomMode read FZoomMode write SetZoomMode default TZoomMode.zmRelative;
    property BackgroundColor: TAlphaColor read FBackgroundColor write SetBackgroundColor default TAlphaColorRec.White;
    property LoupeMode: TLoupeMode read FLoupeMode write SetLoupeMode default TLoupeMode.lmCircle;
    property LoupeScale: Single read FLoupeScale write SetLoupeScale stored IsLoupeScaleStored nodefault;
  end;

  /// <summary>
  ///   <para>
  ///     Magnifying glass increasing area parent control. Allows to change
  ///     scaling coefficient <paramref name="LoupeScale"/>. Has two options
  ///     of display - a circular and rectangular lens <paramref name="LoupeMode"/>.
  ///   </para>
  ///   <para>
  ///     For installation of style of a magnifying glass the following names
  ///     of styles are used for <paramref name="LoupeMode"/>:
  ///   </para>
  ///   <list type="bullet">
  ///     <item>
  ///       <term>lmCircle</term>
  ///       <description> - 'magnifierglassstyle'</description>
  ///     </item>
  ///     <item>
  ///       <term>lmRectangle</term>
  ///       <description> - 'magnifierglassrectanglestyle'</description>
  ///     </item>
  ///   </list>
  /// </summary>
  /// <remarks>
  ///   It is recommended to use for increase in components of the small size.
  /// </remarks>
  TMagnifierGlass = class (TCustomMagnifierGlass)
  published
    property BackgroundColor;
    property LoupeMode;
    property LoupeScale;
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default False;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property Visible default True;
    property Width;
    property ZoomMode;
    property ZoomRegionCenter;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Mouse events}
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

  ///  <summary>
  ///    Service displays a magnifying glass for the current form.
  ///    Works with absolute coordinates.
  ///  </summary>
  ///  <remarks>
  ///    Also it is intended for use of one magnifying glass different controls.
  ///    Therefore before each use of a magnifying glass through service,
  ///    it is recommended to initialize all values of service anew.
  ///  </remarks>
  ILoupeService = interface
  ['{EAFDFBA9-F24A-4DF0-920E-F0D2BC6E8B33}']
    procedure SetLoupeMode(const AMode: TLoupeMode);
    procedure SetLoupeScale(const AScale: Single);
    function GetWidth: Single;
    function GetHeight: Single;
    /// <summary>
    ///   See <see cref="TCustomMagnifierGlass.ZoomRegionCenter"/>
    /// </summary>
    procedure SetZoomRegionCenter(const AZoomPoint: TPointF);
    procedure SetPosition(const AAbsolutePosition: TPointF);
    procedure ShowFor(AControl: TControl);
    procedure Hide;
  end;

  TLoupeFactoryService = class (TInterfacedObject, ILoupeService)
  strict private
    [weak] FForControl: TControl;
    FLoupe: TMagnifierGlass;
  public
    constructor Create;
    destructor Destroy; override;
    { ILoupeFactoryService }
    procedure SetLoupeMode(const AMode: TLoupeMode);
    procedure SetLoupeScale(const AScale: Single);
    function GetWidth: Single;
    function GetHeight: Single;
    procedure SetZoomRegionCenter(const AZoomPoint: TPointF);
    procedure SetPosition(const AAbsolutePosition: TPointF);
    procedure ShowFor(AControl: TControl);
    procedure Hide;
  end;

implementation

uses
  System.SysUtils, System.Math,
  FMX.Platform, FMX.Forms; // Temporary. We need to add special interface with control size
                           // like as IControl for common use it for get control and form  size
const
  MAX_BOUNDARY_TOP = 20;
  OFFSET_ZOOM_FOR_TOP_CONTROL = 20;

{ TMagnifierGlass }

procedure TCustomMagnifierGlass.AfterPaint;
begin
  inherited AfterPaint;
  if HasContent then
    IBitmapLink(FContent.Fill.Bitmap.Bitmap).SetResourceBitmap(nil);
end;

procedure TCustomMagnifierGlass.ApplyStyle;
var
  Obj: TFmxObject;
begin
  inherited ApplyStyle;
  Obj := FindStyleResource('content');
  if Assigned(Obj) and (Obj is TShape) then
  begin
    FContent := Obj as TShape;
    FContent.Fill.Kind := TBrushKind.bkBitmap;
    FContent.Fill.Bitmap.WrapMode := TWrapMode.wmTileStretch;
  end;
end;

constructor TCustomMagnifierGlass.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetAcceptsControls(False);
  FLoupeMode := TLoupeMode.lmCircle;
  FLoupeScale := 1;
  FBackgroundColor := TAlphaColorRec.White;
  FParentScreenshotBitmap := TBitmap.Create(0, 0);
  FScaledBitmap := TBitmap.Create(0, 0);
  FZoomMode := TZoomMode.zmRelative;
  FZoomRegionCenter := TPosition.Create(PointF(0, 0));
  FZoomRegionCenter.OnChange := DoZoomRegionChanged;
  HitTest := False;
end;

destructor TCustomMagnifierGlass.Destroy;
begin
  FreeAndNil(FZoomRegionCenter);
  FreeAndNil(FScaledBitmap);
  FreeAndNil(FParentScreenshotBitmap);
  inherited Destroy;
end;

procedure TCustomMagnifierGlass.DoZoomRegionChanged(Sender: TObject);
begin
  Repaint;
end;

procedure TCustomMagnifierGlass.FreeStyle;
begin
  inherited FreeStyle;
  FContent := nil;
end;

function TCustomMagnifierGlass.GetDefaultStyleLookupName: string;
begin
  if LoupeMode = TLoupeMode.lmRectangle then
    Result := 'magnifierglassrectanglestyle'
  else
    Result := 'magnifierglassstyle';
end;

function TCustomMagnifierGlass.GetZoomRect: TRectF;
var
  ZoomPoint: TPointF;
  ZoomRectPos: TPointF;
  ZoomRectWidth: Single;
  ZoomRectHeight: Single;
begin
  if HasContent then
  begin
    case ZoomMode of
      TZoomMode.zmAbsolute:
        ZoomPoint := ZoomRegionCenter.Point.Scale(ScreenScale);
      TZoomMode.zmRelative:
        ZoomPoint := Position.Point.Scale(ScreenScale) + PointF(Width / 2, Height / 2).Scale(ScreenScale) +
                     ZoomRegionCenter.Point.Scale(ScreenScale);
    end;
    ZoomRectPos := PointF(ZoomPoint.X - FContent.Width * ScreenScale / LoupeScale / 2 ,
                          ZoomPoint.Y - FContent.Height * ScreenScale / LoupeScale / 2);
    ZoomRectWidth := FContent.Width / LoupeScale * ScreenScale;
    ZoomRectHeight := FContent.Height / LoupeScale * ScreenScale;
    Result := TRectF.Create(ZoomRectPos, ZoomRectWidth, ZoomRectHeight);
  end
  else
    Result := TRectF.Empty;
end;

function TCustomMagnifierGlass.GetScreenScale: Single;
begin
  if Assigned(Scene) then
    Result := Scene.GetSceneScale
  else
    Result := 1;
end;

function TCustomMagnifierGlass.HasContent: Boolean;
begin
  Result := Assigned(FContent);
end;

function TCustomMagnifierGlass.IsLoupeScaleStored: Boolean;
begin
  Result := not SameValue(LoupeScale, 1);
end;

procedure TCustomMagnifierGlass.Paint;
var
  ParentWidth: Single;
  ParentHeight: Single;

  procedure DefineParentSize;
  begin
    ParentWidth := 0;
    ParentHeight := 0;
    if Parent is TCustomForm then
    begin
      ParentWidth := (Parent as TCustomForm).ClientWidth;
      ParentHeight := (Parent as TCustomForm).ClientHeight;
    end;
    if Parent is TControl then
    begin
      ParentWidth := (Parent as TControl).Width;
      ParentHeight := (Parent as TControl).Height;
    end;
  end;

  function IsBitmapSizeChanged(ABitmap: TBitmap; const ANewWidth, ANewHeight: Single): Boolean;
  begin
    Result := not SameValue(ANewWidth * ABitmap.BitmapScale, ABitmap.Width) or
              not SameValue(ANewHeight * ABitmap.BitmapScale, ABitmap.Height);
  end;

  procedure UpdateBitmapSize(ABitmap: TBitmap; const ANewWidth, ANewHeight: Single);
  begin
    (ABitmap as IBitmapAccess).BitmapScale := ScreenScale;
    ABitmap.SetSize(Round(ANewWidth * ScreenScale), Round(ANewHeight * ScreenScale));
  end;

  procedure MakeParentScreenshot;
  var
    Form: TCommonCustomForm;
    Child: TFmxObject;
    ParentControl: TControl;
  begin
    if FParentScreenshotBitmap.Canvas.BeginScene then
      try
        FDisablePaint := True;
        if Parent is TCommonCustomForm then
        begin
          Form := Parent as TCommonCustomForm;
          for Child in Form.Children do
            if (Child is TControl) and (Child as TControl).Visible then
            begin
              ParentControl := Child as TControl;
              ParentControl.PaintTo(FParentScreenshotBitmap.Canvas, ParentControl.ParentedRect);
            end;
        end
        else
          (Parent as TControl).PaintTo(FParentScreenshotBitmap.Canvas, RectF(0, 0, ParentWidth, ParentHeight));
      finally
        FDisablePaint := False;
        FParentScreenshotBitmap.Canvas.EndScene;
      end;
  end;

  procedure CropImage(ASource: TBitmap; ADest: TBitmap; const CropRect: TRectF);
  var
    DestRect: TRectF;
    CropRectNew: TRectF;
  begin
    if ADest.Canvas.BeginScene then
      try
        DestRect := RectF(0, 0, FContent.Width, FContent.Height);
        CropRectNew := CropRect;
        // Clear old screenshot image
        ADest.Canvas.Clear(FBackgroundColor);
        // We correct the sizes of the picture received on borders of
        // a parental component
        if CropRect.Left < 0 then
        begin
          CropRectNew.Left := 0;
          DestRect.Left := -CropRect.Left * LoupeScale / ScreenScale;
        end;
        if CropRect.Top < 0 then
        begin
          CropRectNew.Top := 0;
          DestRect.Top := -CropRect.Top * LoupeScale / ScreenScale;
        end;
        if CropRect.Right > ParentWidth * ScreenScale then
        begin
          CropRectNew.Right := ParentWidth * ScreenScale;
          DestRect.Right := DestRect.Left + CropRectNew.Width * LoupeScale / ScreenScale;
        end;
        if CropRectNew.Bottom > ParentHeight * ScreenScale then
        begin
          CropRectNew.Bottom := ParentHeight * ScreenScale;
          DestRect.Bottom := DestRect.Top + CropRectNew.Height * LoupeScale / ScreenScale;
        end;
        // Draw screenshot image into ADest
        ADest.Canvas.DrawBitmap(ASource, CropRectNew, DestRect, 1, True);
      finally
        ADest.Canvas.EndScene;
      end;
  end;

begin
  inherited Paint;

  if HasContent and HasParent then
  begin
    // Make screenshot of Parent control
    DefineParentSize;
    if IsBitmapSizeChanged(FParentScreenshotBitmap, ParentWidth, ParentHeight) then
      UpdateBitmapSize(FParentScreenshotBitmap, ParentWidth, ParentHeight);
    MakeParentScreenshot;

    // Crop screenshot
    if IsBitmapSizeChanged(FScaledBitmap, FContent.Width, FContent.Height) then
      UpdateBitmapSize(FScaledBitmap, FContent.Width, FContent.Height);
    CropImage(FParentScreenshotBitmap, FScaledBitmap, GetZoomRect);

    // Set ScaledScreenshot as Bitmap Brush using IBitmapLink.
    // IBitmapLink doesn't use copy of bitmap (instead TBitmap.Assing)
    // and increased performance
    IBitmapLink(FContent.Fill.Bitmap.Bitmap).SetResourceBitmap(FScaledBitmap);
  end;
end;

procedure TCustomMagnifierGlass.SetBackgroundColor(const Value: TAlphaColor);
begin
  if FBackgroundColor <> Value then
  begin
    FBackgroundColor := Value;
    Repaint;
  end;
end;

procedure TCustomMagnifierGlass.SetZoomMode(const Value: TZoomMode);
begin
  if ZoomMode <> Value then
  begin
    FZoomMode := Value;
    Repaint;
  end;
end;

procedure TCustomMagnifierGlass.SetZoomRegionCenter(const Value: TPosition);
begin
  if Assigned(Value) and (ZoomRegionCenter.Point <> Value.Point) then
  begin
    FZoomRegionCenter.Assign(Value);
    Repaint;
  end;
end;

procedure TCustomMagnifierGlass.SetLoupeMode(const Value: TLoupeMode);
begin
  if LoupeMode <> Value then
  begin
    FLoupeMode := Value;
    NeedStyleLookup;
    ApplyStyleLookup;
  end;
end;

procedure TCustomMagnifierGlass.SetLoupeScale(const Value: Single);
begin
  if not SameValue(LoupeScale, Value) then
  begin
    FLoupeScale := Value;
    Repaint;
  end;
end;

{ TLoupeFactoryService }

constructor TLoupeFactoryService.Create;
begin
  FLoupe := TMagnifierGlass.Create(nil);
  FLoupe.ZoomMode := TZoomMode.zmAbsolute;
end;

destructor TLoupeFactoryService.Destroy;
begin
  FreeAndNil(FLoupe);
  inherited Destroy;
end;

function TLoupeFactoryService.GetHeight: Single;
begin
  Result := FLoupe.Height;
end;

function TLoupeFactoryService.GetWidth: Single;
begin
  Result := FLoupe.Width;
end;

procedure TLoupeFactoryService.Hide;
begin
  FLoupe.Parent := nil;
  FLoupe.Visible := False;
end;

procedure TLoupeFactoryService.SetLoupeMode(const AMode: TLoupeMode);
begin
  FLoupe.LoupeMode := AMode;
end;

procedure TLoupeFactoryService.SetLoupeScale(const AScale: Single);
begin
  FLoupe.LoupeScale := AScale;
end;

procedure TLoupeFactoryService.SetPosition(const AAbsolutePosition: TPointF);
begin
  // If loupe was located in top form, we need make offset for usability
  if FLoupe.LoupeMode = TLoupeMode.lmCircle then
  begin
    if AAbsolutePosition.Y <= -FLoupe.Height / 3 then
    begin
      FLoupe.Position.X := AAbsolutePosition.X;
      FLoupe.Position.Y := -FLoupe.Height / 3;
    end
    else
      FLoupe.Position.Point := AAbsolutePosition;
  end
  else
  begin
    if AAbsolutePosition.Y <= 0 then
    begin
      FLoupe.Position.X := AAbsolutePosition.X;
      FLoupe.Position.Y := 0;
    end
    else
      FLoupe.Position.Point := AAbsolutePosition;
  end;
end;

procedure TLoupeFactoryService.SetZoomRegionCenter(const AZoomPoint: TPointF);
begin
  if Assigned(FForControl) and (FForControl.Position.Y <= MAX_BOUNDARY_TOP) then
    FLoupe.ZoomRegionCenter.Point := AZoomPoint - TPointF.Create(0, OFFSET_ZOOM_FOR_TOP_CONTROL)
  else
    FLoupe.ZoomRegionCenter.Point := AZoomPoint;
end;

procedure TLoupeFactoryService.ShowFor(AControl: TControl);
var
  NeedUpdateStyle: Boolean;
begin
  Assert(Assigned(AControl));
  Assert(Assigned(AControl.Root));
  Assert(Assigned(AControl.Root.GetObject));

  FForControl := AControl;
  NeedUpdateStyle := FLoupe.Parent <> AControl.Root.GetObject;
  FLoupe.Parent := AControl.Root.GetObject;
  if NeedUpdateStyle then
    FLoupe.ApplyStyleLookup;
  FLoupe.Visible := True;
end;

initialization
  RegisterFmxClasses([TMagnifierGlass]);
{$IFDEF IOS}
  TPlatformServices.Current.AddPlatformService(ILoupeService, IInterface(TLoupeFactoryService.Create));
{$ENDIF}
end.
