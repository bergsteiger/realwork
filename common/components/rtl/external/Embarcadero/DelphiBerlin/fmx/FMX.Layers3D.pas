{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Layers3D;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Types, System.UITypes, System.Messaging, System.Math.Vectors, FMX.Types, FMX.Types3D,
  FMX.Objects, FMX.Controls, FMX.Controls3D, FMX.Graphics;

type

{ TAbstractLayer3D }

  TAbstractLayer3D = class(TControl3D, IAlignableObject, IAlignRoot)
  private
    FOnLayerMouseMove: TMouseMoveEvent;
    FOnLayerMouseDown: TMouseEvent;
    FOnLayerMouseUp: TMouseEvent;
    FDisableLayerEvent: Boolean;
    FAlign: TAlignLayout;
    FAnchors: TAnchors;
    FMargins: TBounds;
    FPadding: TBounds;            
    FModulationColor: TAlphaColor;
    FResolution: Integer;
    FLayerWidth, FLayerHeight: Integer;
    FLastWidth, FLastHeight: Single;
    FNeedAlign: Boolean;
    FDisableAlign: Boolean;
    FScaleChangedId: Integer;
    { added for aligment using a relation between align and anchors }
    FAnchorMove: Boolean;
    FAnchorRules: TPointF;
    FAnchorOrigin: TPointF;
    FOriginalParentSize: TPointF;
    FExplicitLeft: Single;
    FExplicitTop: Single;
    FExplicitWidth: Single;
    FExplicitHeight: Single;
    procedure PaddingChanged(Sender: TObject); virtual;
    procedure MarginsChanged(Sender: TObject); virtual;
    procedure SetResolution(const Value: Integer);
    procedure SetModulationColor(const Value: TAlphaColor);
    function IsAnchorsStored: Boolean;
    procedure UpdateExplicitBounds;
    procedure UpdateAnchorRules;
    procedure ScaleChangedHandler(const Sender: TObject; const Msg : TMessage);
    procedure SetPadding(const Value: TBounds);
    procedure SetMargins(const Value: TBounds);
  protected
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure MatrixChanged(Sender: TObject); override;
    procedure MouseMove3D(Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D); override;
    procedure MouseDown3D(Button: TMouseButton; Shift: TShiftState; X, Y: Single;
      RayPos, RayDir: TVector3D); override;
    procedure MouseUp3D(Button: TMouseButton; Shift: TShiftState; X, Y: Single;
      RayPos, RayDir: TVector3D); override;
    procedure Resize3D; override;
    procedure SetDepth(const Value: Single); override;
    procedure SetProjection(const Value: TProjection); override;
    function ObjectAtPoint(P: TPointF): IControl; override;
    function DoRayCastIntersect(const RayPos, RayDir: TPoint3D; var Intersection: TPoint3D): Boolean; override;
    { Rendering }
    procedure ApplyEffect; override;
    { Layer }
    procedure LayerMouseMove(Shift: TShiftState; X, Y: Single); virtual;
    procedure LayerMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); virtual;
    procedure LayerMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); virtual;
    procedure LayerResized; virtual;
    { Events }
    procedure DoScaleChanged; virtual;
    { IAlignRoot }
    procedure Realign; virtual;
    procedure ChildrenAlignChanged;
    { IAlignableObject }
    function GetAlign: TAlignLayout;
    procedure SetAlign(const Value: TAlignLayout); virtual;
    function GetAnchors: TAnchors;
    procedure SetAnchors(const Value: TAnchors); virtual;
    function GetMargins: TBounds;
    function GetPadding: TBounds;
    procedure SetBounds(X, Y, AWidth, AHeight: Single);
    function GetAllowAlign: Boolean;
    function GetAnchorRules : TPointF;
    function GetAnchorOrigin : TPointF;
    function GetOriginalParentSize : TPointF;
    function GetAnchorMove : Boolean;
    procedure SetAnchorMove(Value : Boolean);

    function IAlignableObject.GetWidth = GetAlignableWidth;
    function IAlignableObject.GetHeight = GetAlignableHeight;
    function IAlignableObject.GetLeft = GetAlignableLeft;
    function IAlignableObject.GetTop = GetAlignableTop;
    function GetAlignableWidth: single;
    function GetAlignableHeight: single;
    function GetAlignableLeft: single;
    function GetAlignableTop: single;
    function GetAdjustSizeValue: TSizeF; virtual;
    function GetAdjustType: TAdjustType; virtual;
    { }
    procedure Loaded; override;
    { Layer }
    property LayerWidth: Integer read FLayerWidth;
    property LayerHeight: Integer read FLayerHeight;
    property Resolution: Integer read FResolution write SetResolution;
    procedure SetParent(const Value : TFmxObject); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Align: TAlignLayout read FAlign write SetAlign default TAlignLayout.None;
    property Anchors: TAnchors read FAnchors write SetAnchors stored IsAnchorsStored default [TAnchorKind.akLeft, TAnchorKind.akTop];
    property Padding: TBounds read GetPadding write SetPadding;
    property ModulationColor: TAlphaColor read FModulationColor write SetModulationColor default TAlphaColors.White;
    property Margins: TBounds read GetMargins write SetMargins;
    {events}
    property OnLayerMouseMove: TMouseMoveEvent read FOnLayerMouseMove write FOnLayerMouseMove;
    property OnLayerMouseDown: TMouseEvent read FOnLayerMouseDown write FOnLayerMouseDown;
    property OnLayerMouseUp: TMouseEvent read FOnLayerMouseUp write FOnLayerMouseUp;
  end;

{ TLayout3D }

  TLayout3D = class(TAbstractLayer3D)
  protected
    procedure Render; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Anchors;
    property Cursor default crDefault;
    property DragMode default TDragMode.dmManual;
    property Height;
    property HitTest default True;
    property Locked default False;
    property Padding;
    property Opacity nodefault;
    property Margins;
    property Position;
    property Projection;
    property RotationAngle;
    property Scale;
    property VisibleContextMenu default True;
    property TwoSide default True;
    property Visible default True;
    property Width;
    property ZWrite default True;
    {events}
    property OnDragEnd;
    property OnDragEnter;
    property OnDragDrop;
    property OnDragLeave;
    property OnDragOver;
    property OnLayerMouseDown;
    property OnLayerMouseMove;
    property OnLayerMouseUp;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnKeyDown;
    property OnKeyUp;
    property OnRender;
  end;

{ TSplitter3D }

  TSplitter3D = class(TAbstractLayer3D)
  private
    FPressed: Boolean;
    FControl: TAbstractLayer3D;
    FDownPos: TPointF;
    FMinSize: Single;
    FMaxSize: Single;
    FNewSize, FOldSize: Single;
    FSplit: Single;
  protected
    procedure Render; override;
    procedure SetAlign(const Value: TAlignLayout); override;
    function FindObject: TAbstractLayer3D;
    procedure CalcSplitSize(X, Y: Single; var NewSize, Split: Single);
    procedure UpdateSize(X, Y: Single);
    function DoCanResize(var NewSize: Single): Boolean;
    procedure UpdateControlSize;
    procedure LayerMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure LayerMouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure LayerMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Anchors;
    property Cursor default crDefault;
    property DragMode default TDragMode.dmManual;
    property Height;
    property HitTest default True;
    property Locked default False;
    property Padding;
    property Opacity nodefault;
    property Margins;
    property Position;
    property Projection;
    property RotationAngle;
    property Scale;
    property VisibleContextMenu default True;
    property TwoSide default True;
    property Visible default True;
    property Width;
    property ZWrite default True;
    { events }
    property OnDragEnd;
    property OnDragEnter;
    property OnDragDrop;
    property OnDragLeave;
    property OnDragOver;
    property OnLayerMouseDown;
    property OnLayerMouseMove;
    property OnLayerMouseUp;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnRender;
  end;

{ TSolidLayer3D }

  TSolidLayer3D = class(TAbstractLayer3D)
  private
  protected
    procedure Render; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Anchors;
    property Cursor default crDefault;
    property DragMode default TDragMode.dmManual;
    property Height;
    property HitTest default True;
    property Locked default False;
    property Padding;
    property ModulationColor;
    property Opacity nodefault;
    property Margins;
    property Position;
    property Projection;
    property RotationAngle;
    property Scale;
    property VisibleContextMenu default True;
    property TwoSide default True;
    property Visible default True;
    property Width;
    property ZWrite default True;
    { events }
    property OnDragEnd;
    property OnDragEnter;
    property OnDragDrop;
    property OnDragLeave;
    property OnDragOver;
    property OnLayerMouseDown;
    property OnLayerMouseMove;
    property OnLayerMouseUp;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnRender;
  end;

{ TImage3D }

  TImage3D = class(TAbstractLayer3D, IBitmapObject)
  private
    FBitmap: TBitmap;
    FWrapMode: TImageWrapMode;
    procedure SetBitmap(const Value: TBitmap);
    procedure SetWrapMode(const Value: TImageWrapMode);
    { IBitmapObject }
    function GetBitmap: TBitmap;
  protected
    procedure DoBitmapChanged(Sender: TObject);
    procedure Render; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Anchors;
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property Cursor default crDefault;
    property DragMode default TDragMode.dmManual;
    property Height;
    property HitTest default True;
    property Locked default False;
    property Padding;
    property Opacity nodefault;
    property Margins;
    property Position;
    property Projection;
    property RotationAngle;
    property Scale;
    property VisibleContextMenu default True;
    property TwoSide default True;
    property Visible default True;
    property Width;
    property WrapMode: TImageWrapMode read FWrapMode write SetWrapMode default TImageWrapMode.Stretch;
    property ZWrite default True;
    { events }
    property OnDragEnd;
    property OnDragEnter;
    property OnDragDrop;
    property OnDragLeave;
    property OnDragOver;
    property OnLayerMouseDown;
    property OnLayerMouseMove;
    property OnLayerMouseUp;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnRender;
  end;

{ TCustomBufferLayer3D }

  TCustomBufferLayer3D = class(TAbstractLayer3D)
  private
    FOnUpdateBuffer: TNotifyEvent;
  protected
    FBuffer: TBitmap;
    procedure BeforeRender; override;
    procedure Render; override;
    function GetBitmap: TBitmap; virtual;
    { Layer }
    procedure LayerResized; override;
    { Events }
    procedure DoScaleChanged; override;
    { BufferLayer }
    procedure DoUpdateBuffer; virtual;
    property OnUpdateBuffer: TNotifyEvent read FOnUpdateBuffer write FOnUpdateBuffer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Buffer: TBitmap read FBuffer;
  end;

{ TBufferLayer3D }

  TBufferLayer3D = class(TCustomBufferLayer3D)
  published
    property Align;
    property Anchors;
    property Cursor default crDefault;
    property DragMode default TDragMode.dmManual;
    property Height;
    property HitTest default True;
    property Locked default False;
    property Padding;
    property Opacity nodefault;
    property Margins;
    property Position;
    property Projection;
    property Resolution;
    property RotationAngle;
    property Scale;
    property VisibleContextMenu default True;
    property TwoSide default True;
    property Visible default True;
    property Width;
    property ZWrite default True;
    {events}
    property OnDragEnd;
    property OnDragEnter;
    property OnDragDrop;
    property OnDragLeave;
    property OnDragOver;
    property OnLayerMouseDown;
    property OnLayerMouseMove;
    property OnLayerMouseUp;
    property OnUpdateBuffer;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnKeyDown;
    property OnKeyUp;
    property OnRender;
  end;

{ TCustomLayer3D }

  TCustomLayer3D = class(TCustomBufferLayer3D, IStyleBookOwner, IScene, IContainerObject)
  private const
    InitialControlsCapacity = 10;
  private
    FFill: TBrush;
    FTransparency: Boolean;
    FDrawing: Boolean;
    FStyleBook: TStyleBook;
    FActiveControl: TStyledControl;
    FAnimatedCaret: Boolean;
    FStyleLookup: string;
    FNeedStyleLookup: Boolean;
    FResourceLink: TControl;
    FOnPaint: TOnPaintEvent;
    FStyleChangedId: Integer;
    FControls: TControlList;
    FDisableUpdating: Integer;
    procedure SetActiveControl(AControl: TStyledControl);
    procedure SetFill(const Value: TBrush);
    procedure FillChanged(Sender: TObject);
    procedure StyleChangedHandler(const Sender: TObject; const Msg : TMessage);
    { IScene }
    function GetCanvas: TCanvas;
    function GetUpdateRectsCount: Integer;
    function GetUpdateRect(const Index: Integer): TRectF;
    function GetStyleBook: TStyleBook;
    function LocalToScreen(P: TPointF): TPointF;
    function ScreenToLocal(P: TPointF): TPointF;
    procedure SetStyleBook(const Value: TStyleBook);
    function GetSceneScale: Single;
    procedure ChangeScrollingState(const AControl: TControl; const Active: Boolean);
    procedure DisableUpdating;
    procedure EnableUpdating;
    { IContainerObject }
    function GetContainerWidth: Single;
    function GetContainerHeight: Single;
    procedure SetStyleLookup(const Value: string);
  protected
    FUpdateRects: array of TRectF;
    procedure DoUpdateBuffer; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function FindTarget(P: TPointF; const Data: TDragObject): IControl; override;
    procedure SetVisible(const Value: Boolean); override;
    { Events }
    procedure DoScaleChanged; override;
    procedure DoStyleChanged; virtual;
    { children }
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    procedure DoDeleteChildren; override;
    procedure ChangeChildren; override;
    { resources }
    procedure ApplyStyleLookup; virtual;
    function GetStyleObject: TControl;
    procedure DoPaint(const Canvas: TCanvas; const ARect: TRectF); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Invalidate;
    procedure AddUpdateRect(R: TRectF);
    property Canvas: TCanvas read GetCanvas;
    property ActiveControl: TStyledControl read FActiveControl write SetActiveControl;
    property AnimatedCaret: Boolean read FAnimatedCaret write FAnimatedCaret default True;
    property Fill: TBrush read FFill write SetFill;
    property StyleBook: TStyleBook read FStyleBook write SetStyleBook;
    property StyleLookup: string read FStyleLookup write SetStyleLookup;
    property Transparency: Boolean read FTransparency write FTransparency;
    property OnPaint: TOnPaintEvent read FOnPaint write FOnPaint;
  end;

{ TLayer3D }

  TLayer3D = class(TCustomLayer3D)
  published
    property ActiveControl;
    property Align;
    property Anchors;
    property AnimatedCaret;
    property Cursor default crDefault;
    property DragMode default TDragMode.dmManual;
    property Fill;
    property Height;
    property HitTest default True;
    property Locked default False;
    property Padding;
    property Opacity nodefault;
    property Margins;
    property Position;
    property Projection;
    property Resolution;
    property RotationAngle;
    property Scale;
    property VisibleContextMenu default True;
    property StyleBook;
    property StyleLookup;
    property Transparency default False;
    property TwoSide default True;
    property Visible default True;
    property Width;
    property ZWrite default True;
    property OnDragEnd;
    property OnDragEnter;
    property OnDragDrop;
    property OnDragLeave;
    property OnDragOver;
    property OnLayerMouseMove;
    property OnLayerMouseDown;
    property OnLayerMouseUp;
    property OnPaint;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnKeyDown;
    property OnKeyUp;
    property OnRender;
  end;

{ TTextLayer3D }

  TTextLayer3D = class(TCustomLayer3D)
  private
    FText: TText;
    function GetText: string;
    procedure SetText(const Value: string);
    function GetFont: TFont;
    procedure SetFont(const Value: TFont);
    function GetColor: TAlphaColor;
    procedure SetColor(const Value: TAlphaColor);
  protected
    procedure ApplyStyleLookup; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property Anchors;
    property Cursor default crDefault;
    property DragMode default TDragMode.dmManual;
    property Color: TAlphaColor read GetColor write SetColor;
    property Font: TFont read GetFont write SetFont;
    property Height;
    property HitTest default True;
    property Locked default False;
    property Padding;
    property Opacity nodefault;
    property Margins;
    property Position;
    property Projection;
    property Resolution;
    property RotationAngle;
    property Scale;
    property VisibleContextMenu default True;
    property Text: string read GetText write SetText;
    property TwoSide default True;
    property Visible default True;
    property Width;
    property ZWrite default True;
    {events}
    property OnDragEnd;
    property OnDragEnter;
    property OnDragDrop;
    property OnDragLeave;
    property OnDragOver;
    property OnLayerMouseMove;
    property OnLayerMouseDown;
    property OnLayerMouseUp;
    property OnPaint;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnKeyDown;
    property OnKeyUp;
    property OnRender;
  end;

implementation

uses
  System.Math, System.SysUtils, System.RTLConsts, FMX.Consts, FMX.Forms, FMX.Effects, FMX.Styles, FMX.Materials;

{ TAbstractLayer3D }

constructor TAbstractLayer3D.Create(AOwner: TComponent);
begin
  inherited;
  FResolution := 50;
  FModulationColor := $FFFFFFFF;
  FPadding := TBounds.Create(RectF(0, 0, 0, 0));
  FPadding.OnChange := PaddingChanged;
  FMargins := TBounds.Create(RectF(0, 0, 0, 0));
  FMargins.OnChange := MarginsChanged;
  FScaleChangedId := TMessageManager.DefaultManager.SubscribeToMessage(TScaleChangedMessage, ScaleChangedHandler);
  SetSize(5, 4, 0);
  TwoSide := True;
  FAnchors := [TAnchorKind.akLeft, TAnchorKind.akTop];
end;

destructor TAbstractLayer3D.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TScaleChangedMessage, FScaleChangedId);
  FreeAndNil(FPadding);
  FreeAndNil(FMargins);
  inherited;
end;

procedure TAbstractLayer3D.DoAddObject(const AObject: TFmxObject);
var
  AlignObject: IAlignableObject;
begin
  if AObject is TAbstractLayer3D then
    TAbstractLayer3D(AObject).Projection := Projection;
  inherited;
  if Supports(AObject, IAlignableObject, AlignObject) and 
     ((AlignObject.Align <> TAlignLayout.None) or (AlignObject.Anchors <> [TAnchorKind.akLeft, TAnchorKind.akTop])) then
    FNeedAlign := True;
end;

procedure TAbstractLayer3D.ApplyEffect;
begin
  inherited ;
end;

procedure TAbstractLayer3D.ChildrenAlignChanged;
var
  I: Integer;
  AlignObject: IAlignableObject;
begin
  FNeedAlign := False;
  UpdateAnchorRules;
  if Children <> nil then
    for I := 0 to Children.Count - 1 do
      if Supports(Children[I], IAlignableObject, AlignObject) and
         ((AlignObject.Align <> TAlignLayout.None) or (AlignObject.Anchors <> [TAnchorKind.akLeft, TAnchorKind.akTop])) then
      begin
        FNeedAlign := True;
        Break;
      end;
end;

function TAbstractLayer3D.DoRayCastIntersect(const RayPos, RayDir: TPoint3D; var Intersection: TPoint3D): Boolean;
var
  IPoint: TPoint3D;
begin
  if RayCastPlaneIntersect(RayPos, RayDir, TPoint3D.Zero, TPoint3D.Create(0, 0, -1), IPoint) then
  begin
    Result := (IPoint.X >= 0) and (IPoint.X <= Width) and (IPoint.Y >= 0) and (IPoint.Y <= Height);
    if (Root <> nil) and (Root.Captured <> nil) and (Root.Captured.GetObject = Self) then
      Result := True;
    Intersection := TPoint3D(LocalToAbsoluteVector(IPoint));
  end
  else
    Result := False;
end;

procedure TAbstractLayer3D.DoScaleChanged;
begin

end;

function TAbstractLayer3D.ObjectAtPoint(P: TPointF): IControl;
var
  I: Integer;
  Obj: TFmxObject;
  NewObj: IControl;
  Intersect: TPoint3D;
  RayPos, RayDir: TVector3D;
  VP: TPointF;
  LayersOffset: Integer;
begin
  Result := nil;
  for I := ChildrenCount - 1 downto 0 do
  begin
    Obj := Children[I];

    if IInterface(Obj).QueryInterface(IControl, NewObj) <> 0 then
      Continue;
    if not(csDesigning in ComponentState) and not NewObj.GetVisible then
      Continue;

    NewObj := NewObj.ObjectAtPoint(P);
    if NewObj <> nil then
    begin
      Result := NewObj;
      Break;
    end;
  end;
  if (Result = nil) and (Context <> nil) and Visible and (GlobalProjection = Projection) and CheckHitTest(HitTest) then
  begin
    VP := P;

    if FViewport <> nil then
      VP := FViewport.ScreenToLocal(VP);

    Context.Pick(VP.X, VP.Y, FProjection, RayPos, RayDir);

    if CheckHitTest(HitTest) and RayCastIntersect(TPoint3D(AbsoluteToLocalVector(RayPos)),
      TPoint3D(AbsoluteToLocalVector(RayDir)).Normalize, Intersect) then
    begin
      if Projection = TProjection.Screen then
      begin
        LayersOffset := 0;

        Obj := Parent;
        while Obj <> nil do
        begin
          if Obj is TAbstractLayer3D then
            LayersOffset := LayersOffset + 1;

          Obj := Obj.Parent;
        end;

        if ((Intersect - TPoint3D(RayPos)).Length - LayersOffset < GlobalDistance) then
        begin
          GlobalDistance := (Intersect - TPoint3D(RayPos)).Length - LayersOffset;
          Result := Self;
        end;
      end;
      if (Projection = TProjection.Camera) and (FViewport.CurrentCamera <> nil) and
        ((Intersect - TPoint3D(FViewport.CurrentCamera.AbsolutePosition)).Length < GlobalDistance) then
      begin
        GlobalDistance := (Intersect - TPoint3D(FViewport.CurrentCamera.AbsolutePosition)).Length;
        Result := Self;
      end;
    end;
  end;
end;

procedure TAbstractLayer3D.Realign;
begin
  if csDestroying in ComponentState then
    Exit;
  if (Abs(FLayerWidth) < 1) or (Abs(FLayerHeight) < 1) then
    Exit;
  if Children = nil then
    Exit;
  if Children.Count = 0 then
    Exit;
  if FUpdating > 0 then
    Exit;
  if not FNeedAlign then
    Exit;
  AlignObjects(Self, FPadding, FLayerWidth, FLayerHeight, FLastWidth, FLastHeight, FDisableAlign);
end;

function TAbstractLayer3D.IsAnchorsStored: Boolean;
begin
  Result := Anchors <> AnchorAlign[Align];
end;

procedure TAbstractLayer3D.MouseMove3D(Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
var
  P3: TPoint3D;
begin
  FDisableLayerEvent := True;
  try
    inherited;
  finally
    FDisableLayerEvent := False;
  end;

  if RayCastIntersect(TPoint3D(RayPos), TPoint3D(RayDir), P3) then
  begin
    P3 := TPoint3D(AbsoluteToLocalVector(P3));
    X := ((P3.X / Width) * FLayerWidth);
    Y := ((P3.Y / Height) * FLayerHeight);
  end
  else
    Exit;

  LayerMouseMove(Shift, X, Y);
end;

procedure TAbstractLayer3D.MouseDown3D(Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos,
  RayDir: TVector3D);
var
  P3: TPoint3D;
begin
  FDisableLayerEvent := True;
  try
    inherited;
  finally
    FDisableLayerEvent := False;
  end;

  if RayCastIntersect(TPoint3D(RayPos), TPoint3D(RayDir), P3) then
  begin
    P3 := TPoint3D(AbsoluteToLocalVector(P3));
    X := ((P3.X / Width) * FLayerWidth);
    Y := ((P3.Y / Height) * FLayerHeight);
  end
  else
    Exit;

  LayerMouseDown(Button, Shift, X, Y);
end;

procedure TAbstractLayer3D.MouseUp3D(Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos,
  RayDir: TVector3D);
var
  P3: TPoint3D;
begin
  FDisableLayerEvent := True;
  try
    inherited;
  finally
    FDisableLayerEvent := False;
  end;

  if RayCastIntersect(TPoint3D(RayPos), TPoint3D(RayDir), P3) then
  begin
    P3 := TPoint3D(AbsoluteToLocalVector(P3));
    X := ((P3.X / Width) * FLayerWidth);
    Y := ((P3.Y / Height) * FLayerHeight);
  end
  else
    Exit;

  LayerMouseUp(Button, Shift, X, Y);
end;

procedure TAbstractLayer3D.LayerMouseMove(Shift: TShiftState; X, Y: Single);
begin
  if Assigned(FOnLayerMouseMove) then
    FOnLayerMouseMove(Self, Shift, trunc(X), trunc(Y));
end;

procedure TAbstractLayer3D.LayerMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if Assigned(FOnLayerMouseDown) then
    FOnLayerMouseDown(Self, Button, Shift, trunc(X), trunc(Y));
end;

procedure TAbstractLayer3D.LayerMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if Assigned(FOnLayerMouseUp) then
    FOnLayerMouseUp(Self, Button, Shift, trunc(X), trunc(Y));
end;

procedure TAbstractLayer3D.ScaleChangedHandler(const Sender: TObject; const Msg: TMessage);
begin
  DoScaleChanged;
end;

procedure TAbstractLayer3D.SetAlign(const Value: TAlignLayout);
var
  AlignRoot: IAlignRoot;
begin
  if FAlign <> Value then
  begin
    FAlign := Value;
    if not (csLoading in ComponentState) and (Projection <> TProjection.Screen) then
      FAlign := TAlignLayout.None;
    if (Align <> TAlignLayout.None) and Supports(Parent, IAlignRoot, AlignRoot) then
    begin
      AlignRoot.ChildrenAlignChanged;
      if not (csLoading in ComponentState) then
        AlignRoot.Realign;
    end;
  end;
end;

procedure TAbstractLayer3D.SetAnchors(const Value: TAnchors);
var
  OldAnchors: TAnchors;
  AlignRoot: IAlignRoot;
begin
  if FAnchors <> Value then
  begin
    OldAnchors:= FAnchors;
    FAnchors := Value;
    if not (csLoading in ComponentState) then
      if (OldAnchors <> [TAnchorKind.akLeft, TAnchorKind.akTop]) and (FAnchors = [TAnchorKind.akLeft, TAnchorKind.akTop]) and
        ((FExplicitLeft <> GetAlignableLeft) or (FExplicitTop <> GetAlignableTop) or
          (FExplicitWidth <> GetAlignableWidth) or (FExplicitHeight <> GetAlignableHeight)) then
        SetBounds(FExplicitLeft, FExplicitTop, FExplicitWidth, FExplicitHeight)
      else
        UpdateAnchorRules;
    if (Anchors <> [TAnchorKind.akLeft, TAnchorKind.akTop]) and Supports(Parent, IAlignRoot, AlignRoot) then
    begin
      AlignRoot.ChildrenAlignChanged;
      if not (csLoading in ComponentState) then
        AlignRoot.Realign;
    end;
  end;
end;

procedure TAbstractLayer3D.SetDepth(const Value: Single);
begin
  inherited SetDepth(0);
end;

function TAbstractLayer3D.GetAdjustSizeValue: TSizeF;
begin
  Result := TSizeF.Create(0, 0);
end;

function TAbstractLayer3D.GetAdjustType: TAdjustType;
begin
  Result := TAdjustType.None;
end;

function TAbstractLayer3D.GetAlign: TAlignLayout;
begin
  Result := FAlign;
end;

function TAbstractLayer3D.GetAlignableHeight: single;
begin
  Result := FHeight;
end;

function TAbstractLayer3D.GetAlignableWidth: single;
begin
  Result := FWidth;
end;

function TAbstractLayer3D.GetAlignableLeft: single;
begin
  Result := Position.X - Trunc(Width / 2);
end;

function TAbstractLayer3D.GetAlignableTop: single;
begin
  Result := Position.Y - Trunc(Height / 2);
end;

function TAbstractLayer3D.GetAllowAlign: Boolean;
begin
  Result := (Projection = TProjection.Screen) and Visible;
end;

function TAbstractLayer3D.GetAnchors: TAnchors;
begin
  Result := FAnchors;
end;

function TAbstractLayer3D.GetAnchorRules : TPointF;
begin
  Result := FAnchorRules;
end;

function TAbstractLayer3D.GetAnchorMove: Boolean;
begin
  Result := FAnchorMove;
end;

procedure TAbstractLayer3D.SetAnchorMove(Value: Boolean);
begin
  FAnchorMove := Value;
end;

function TAbstractLayer3D.GetAnchorOrigin : TPointF;
begin
  Result := FAnchorOrigin;
end;

function TAbstractLayer3D.GetOriginalParentSize : TPointF;
begin
  Result := FOriginalParentSize;
end;

function TAbstractLayer3D.GetMargins: TBounds;
begin
  Result := FMargins;
end;

procedure TAbstractLayer3D.SetMargins(const Value: TBounds);
begin
  FMargins.Assign(Value);
end;

function TAbstractLayer3D.GetPadding: TBounds;
begin
  Result := FPadding;
end;

procedure TAbstractLayer3D.SetPadding(const Value: TBounds);
begin
  FPadding.Assign(Value);
end;

procedure TAbstractLayer3D.SetBounds(X, Y, AWidth, AHeight: Single);
begin
  FWidth := AWidth;
  FHeight := AHeight;
  Position.Point := TPoint3D.Create(X + Trunc(AWidth / 2), Y + Trunc(AHeight / 2), Position.Z);
  Resize3D;
end;

procedure TAbstractLayer3D.LayerResized;
begin
  UpdateAnchorRules;
  UpdateExplicitBounds;
  Realign;
end;

procedure TAbstractLayer3D.Loaded;
begin
  inherited;
  FLastWidth := FWidth;
  FLastHeight := FHeight;
  Resize3D;
end;

procedure TAbstractLayer3D.Resize3D;
begin
  inherited;
  if (csLoading in ComponentState) then Exit;
  if Projection = TProjection.Camera then
  begin
    FLayerWidth := Round(Width * FResolution);
    FLayerHeight := Round(Height * FResolution);
  end
  else
  begin
    FLayerHeight := Round(Height);
    FLayerWidth := Round(Width);
  end;
  if (FLayerWidth > 0) and (FLayerHeight > 0) then
    LayerResized;
  MatrixChanged(Self);
end;

procedure TAbstractLayer3D.MarginsChanged(Sender: TObject);
var
  AlignRoot: IAlignRoot;
begin
  if not (csLoading in ComponentState) and (Projection = TProjection.Screen) and  Supports(Parent, IAlignRoot, AlignRoot) then
    AlignRoot.Realign;
end;

procedure TAbstractLayer3D.PaddingChanged(Sender: TObject);
begin
  Realign;
end;

procedure TAbstractLayer3D.MatrixChanged(Sender: TObject);
var
  AlignRoot: IAlignRoot;
  LeftVector, DirectionVector, UpVector: TPoint3D;
  TransMatrix, RotMatrix: TMatrix3D;
begin
  UpVector := TPoint3D.Create(0, 1, 0);
  DirectionVector := TPoint3D.Create(0, 0, 1);

  if (not SameValue(FRotationAngle.X, 0, TEpsilon.Vector)) or (not SameValue(FRotationAngle.Y, 0, TEpsilon.Vector)) or
    (not SameValue(FRotationAngle.Z, 0, TEpsilon.Vector)) then
  begin
    RotMatrix := FQuaternion;
    UpVector := UpVector * RotMatrix;
    DirectionVector := DirectionVector * RotMatrix;
  end
  else
  begin
    FRotationAngle.SetVectorNoChange(TVector3D.Create(0, 0, 0));
    FQuaternion := TQuaternion3D.Identity;
  end;

  LeftVector := UpVector.CrossProduct(DirectionVector);

  FLocalMatrix.M[0] := LeftVector * FScale.X;
  FLocalMatrix.m14 := 0;
  FLocalMatrix.M[1] := UpVector * FScale.Y;
  FLocalMatrix.m24 := 0;
  FLocalMatrix.M[2] := DirectionVector * FScale.Z;
  FLocalMatrix.m34 := 0;

  if Projection = TProjection.Screen then
  begin
    FPosition.SetPoint3DNoChange(TPoint3D.Create(Round(FPosition.X), Round(FPosition.Y), Round(FPosition.Z)));

    FWidth := Round(FWidth);
    FHeight := Round(FHeight);

    FLocalMatrix.m41 := FPosition.X;
    FLocalMatrix.m42 := FPosition.Y;
    FLocalMatrix.m43 := FPosition.Z;

    if not (Parent is TAbstractLayer3D) and (Context <> nil) then
    begin
      FLocalMatrix.m41 := FLocalMatrix.m41 + Context.PixelToPixelPolygonOffset.X;
      FLocalMatrix.m42 := FLocalMatrix.m42 + Context.PixelToPixelPolygonOffset.Y;
    end;

    TransMatrix := TMatrix3D.Identity;
    TransMatrix.m41 := -Trunc(FWidth / 2);
    TransMatrix.m42 := -Trunc(FHeight / 2);
  end
  else
  begin
    FLocalMatrix.m41 := FPosition.X;
    FLocalMatrix.m42 := FPosition.Y;
    FLocalMatrix.m43 := FPosition.Z;

    TransMatrix := TMatrix3D.Identity;
    TransMatrix.m41 := -FWidth / 2;
    TransMatrix.m42 := -FHeight / 2;
  end;

  FLocalMatrix := TransMatrix * FLocalMatrix;

  RecalcAbsolute;
  Repaint;
  if not (csLoading in ComponentState) and (Projection = TProjection.Screen) and Supports(Parent, IAlignRoot,
    AlignRoot) then
    AlignRoot.Realign
end;

procedure TAbstractLayer3D.SetResolution(const Value: Integer);
begin
  if FResolution <> Value then
  begin
    FResolution := Value;
    if FResolution < 1 then
      FResolution := 1;
    if FResolution > 256 then
      FResolution := 256;
    Resize3D;
  end;
end;

procedure TAbstractLayer3D.SetModulationColor(const Value: TAlphaColor);
begin
  if FModulationColor <> Value then
  begin
    FModulationColor := Value;
    Repaint;
  end;
end;

procedure TAbstractLayer3D.SetParent(const Value: TFmxObject);
begin
  inherited;
  UpdateAnchorRules;
end;

procedure TAbstractLayer3D.UpdateExplicitBounds;
begin
  if not (csReading in ComponentState) then
  begin
    FExplicitLeft := GetAlignableLeft;
    FExplicitTop := GetAlignableTop;
    FExplicitWidth := GetAlignableWidth;
    FExplicitHeight := GetAlignableHeight;
  end;
end;

procedure TAbstractLayer3D.UpdateAnchorRules;
begin
  if not FAnchorMove and not (csLoading in ComponentState) and (Projection = TProjection.Screen) then
  begin
    RecalcAnchorRules(Parent, FAnchors, TRectF.Create(GetAlignableLeft, GetAlignableTop,
      GetAlignableLeft + GetAlignableWidth, GetAlignableTop + GetAlignableHeight),
      FOriginalParentSize, FAnchorOrigin, FAnchorRules);
    RecalcControlOriginalParentSize(Parent, ComponentState, False, FOriginalParentSize);
  end;
end;

procedure TAbstractLayer3D.SetProjection(const Value: TProjection);
var
  i: Integer;
begin
  if Value <> Projection then
  begin
    FProjection := Value;
    if Children <> nil then
      for i := 0 to Children.Count - 1 do
        if (Children[i] is TControl3D) then
          TControl3D(Children[i]).Projection := Value;
    if not (csLoading in ComponentState) and (csDesigning in ComponentState) then
    begin
      if FProjection = TProjection.Screen then
      begin
        SetSize(FLayerWidth, FLayerHeight, Depth);
        if (FViewport <> nil) and (FViewport.Context <> nil) then
          Position.Point := TPoint3D.Create(FViewport.Context.Width / 2, FViewport.Context.Height / 2, 0);
      end
      else
      begin
        if FResolution > 0 then
          SetSize(FLayerWidth / FResolution, FLayerHeight / FResolution, Depth);
        Position.Point := TPoint3D.Zero;
      end;
      Repaint;
    end;
  end;
end;

{ TLayout3D }

constructor TLayout3D.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TLayout3D.Destroy;
begin
  inherited;
end;

procedure TLayout3D.Render;
begin
  if (csDesigning in ComponentState) then
    Context.DrawRect(TPoint3D.Zero, TPoint3D.Create(Width, Height, 0), AbsoluteOpacity, $A0909090);
end;

{ TSplitter3D }

constructor TSplitter3D.Create(AOwner: TComponent);
begin
  inherited;
  FMinSize := 20;
  Projection := TProjection.Screen;
  AutoCapture := True;
  Width := 5;
  Align := TAlignLayout.Left;
  Cursor := crHSplit;
  SetAcceptsControls(False);
end;

destructor TSplitter3D.Destroy;
begin
  inherited;
end;

procedure TSplitter3D.Render;
begin
  if (csDesigning in ComponentState) then
  begin
    Context.DrawCube(TPoint3D.Zero, TPoint3D.Create(Width, Height, Depth), AbsoluteOpacity, $A0909090);
  end;
end;

procedure TSplitter3D.SetAlign(const Value: TAlignLayout);
begin
  inherited;
  if Align in [TAlignLayout.Top, TAlignLayout.Bottom] then
    Cursor := crVSplit
  else
    Cursor := crHSplit;
end;

function TSplitter3D.FindObject: TAbstractLayer3D;
var
  P: TPointF;
  i: Integer;
  R: TRectF;
begin
  Result := nil;
  P := TPointF.Create(Position.X - Width / 2, Position.Y - Height / 2);
  case Align of
    TAlignLayout.Left, TAlignLayout.MostLeft:
      P.X := P.X - 1;
    TAlignLayout.Right, TAlignLayout.MostRight:
      P.X := P.X + Width + 1;
    TAlignLayout.Top:
      P.Y := P.Y - 1;
    TAlignLayout.Bottom:
      P.Y := P.Y + Height + 1;
  else
    Exit;
  end;
  if Parent <> nil then
    for i := 0 to Parent.ChildrenCount - 1 do
    begin
      if not (Parent.Children[i] is TAbstractLayer3D) then
        Continue;
      if TAbstractLayer3D(Parent.Children[i]).Locked then
        Continue;
      if (Align in [TAlignLayout.Left, TAlignLayout.MostLeft, TAlignLayout.Right, TAlignLayout.MostRight]) and
        not((TAbstractLayer3D(Parent.Children[i]).Align in [TAlignLayout.Left, TAlignLayout.MostLeft, TAlignLayout.Right, TAlignLayout.MostRight])) then
        Continue;
      if (Align in [TAlignLayout.Top, TAlignLayout.Bottom, TAlignLayout.MostTop, TAlignLayout.MostBottom]) and
        not((TAbstractLayer3D(Parent.Children[i]).Align in [TAlignLayout.Top, TAlignLayout.Bottom, TAlignLayout.MostTop, TAlignLayout.MostBottom])) then
        Continue;

      Result := TAbstractLayer3D(Parent.Children[i]);
      if Result.Visible then
      begin
        R := TRectF.Create(Result.Position.X - Result.Width / 2, Result.Position.Y - Result.Height / 2,
          Result.Position.X + Result.Width / 2, Result.Position.Y + Result.Height / 2);
        if (R.right - R.left) = 0 then
          if Align in [TAlignLayout.Top, TAlignLayout.Left, TAlignLayout.MostLeft] then
            R.left := R.left - 1
          else
            R.right := R.right + 1;
        if (R.bottom - R.top) = 0 then
          if Align in [TAlignLayout.Top, TAlignLayout.Left, TAlignLayout.MostLeft] then
            R.top := R.top - 1
          else
            R.bottom := R.bottom + 1;
        if R.Contains(P) then
          Exit;
      end;
    end;
  Result := nil;
end;

procedure TSplitter3D.UpdateSize(X, Y: Single);
begin
  CalcSplitSize(X, Y, FNewSize, FSplit);
end;

procedure TSplitter3D.CalcSplitSize(X, Y: Single; var NewSize, Split: Single);
var
  S: Single;
begin
  if Align in [TAlignLayout.Left, TAlignLayout.Right, TAlignLayout.MostLeft, TAlignLayout.MostRight] then
    Split := X - FDownPos.X
  else
    Split := Y - FDownPos.Y;
  S := 0;
  case Align of
    TAlignLayout.Left, TAlignLayout.MostLeft:
      S := FControl.Width + Split;
    TAlignLayout.Right, TAlignLayout.MostRight:
      S := FControl.Width - Split;
    TAlignLayout.Top:
      S := FControl.Height + Split;
    TAlignLayout.Bottom:
      S := FControl.Height - Split;
  end;
  NewSize := S;
  if S < FMinSize then
    NewSize := FMinSize
  else if S > FMaxSize then
    NewSize := FMaxSize;
  if S <> NewSize then
  begin
    if Align in [TAlignLayout.Right, TAlignLayout.MostRight, TAlignLayout.Bottom] then
      S := S - NewSize
    else
      S := NewSize - S;
    Split := Split + S;
  end;
end;

function TSplitter3D.DoCanResize(var NewSize: Single): Boolean;
begin
  Result := True;
  if (NewSize <= FMinSize) { and FAutoSnap } then
    NewSize := FMinSize;
end;

procedure TSplitter3D.LayerMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  i: Integer;
  C: IContainerObject;
  LLayer: TAbstractLayer3D;
begin
  inherited;
  if (Button = TMouseButton.mbLeft) and Supports(Parent, IContainerObject, C) then
  begin
    FPressed := True;
    FDownPos := TPointF.Create(X, Y);
    FControl := FindObject;
    if FControl <> nil then
    begin
      if Align in [TAlignLayout.Left, TAlignLayout.MostLeft, TAlignLayout.Right, TAlignLayout.MostRight] then
      begin
        FMaxSize := C.ContainerWidth - FMinSize;
        if Parent is TAbstractLayer3D then
          FMaxSize := FMaxSize - TAbstractLayer3D(Parent).Padding.left - TControl(Parent).Padding.right;
        for i := 0 to Parent.ChildrenCount - 1 do
        begin
          if not(Parent.Children[i] is TAbstractLayer3D) then
            Continue;
          LLayer := TAbstractLayer3D(Parent.Children[i]);
          if LLayer.Align in [TAlignLayout.Left, TAlignLayout.Right, TAlignLayout.MostLeft, TAlignLayout.MostRight] then
            FMaxSize := FMaxSize - LLayer.Width - LLayer.Margins.Left - LLayer.Margins.Right;
        end;
        FMaxSize := FMaxSize + FControl.Width;
      end
      else
      begin
        FMaxSize := C.ContainerHeight - FMinSize;
        if Parent is TAbstractLayer3D then
          FMaxSize := FMaxSize - TAbstractLayer3D(Parent).Padding.top - TAbstractLayer3D(Parent).Padding.bottom;
        for i := 0 to Parent.ChildrenCount - 1 do
        begin
          if not(Parent.Children[i] is TAbstractLayer3D) then
            Continue;
          LLayer := TAbstractLayer3D(Parent.Children[i]);
          if LLayer.Align in [TAlignLayout.Top, TAlignLayout.Bottom] then
            FMaxSize := FMaxSize - LLayer.Height - LLayer.Margins.Top - LLayer.Margins.Bottom;
        end;
        FMaxSize := FMaxSize + FControl.Height;
      end;
      UpdateSize(X, Y);
    end;
  end;
end;

procedure TSplitter3D.LayerMouseMove(Shift: TShiftState; X, Y: Single);
var
  NewSize, Split: Single;
begin
  inherited;
  if FPressed and (FControl <> nil) then
  begin
    CalcSplitSize(X, Y, NewSize, Split);
    if DoCanResize(NewSize) then
    begin
      FNewSize := NewSize;
      FSplit := Split;
      UpdateControlSize;
    end;
  end;
end;

procedure TSplitter3D.LayerMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  FPressed := False;
  FControl := nil;
end;

procedure TSplitter3D.UpdateControlSize;
begin
  if FNewSize <> FOldSize then
  begin
    case Align of
      TAlignLayout.Left, TAlignLayout.MostLeft:
        FControl.Width := FNewSize;
      TAlignLayout.Top:
        FControl.Height := FNewSize;
      TAlignLayout.Right, TAlignLayout.MostRight:
        begin
          FControl.Position.X := FControl.Position.X + (FControl.Width - FNewSize);
          FControl.Width := FNewSize;
        end;
      TAlignLayout.Bottom:
        begin
          FControl.Position.Y := FControl.Position.Y + (FControl.Height - FNewSize);
          FControl.Height := FNewSize;
        end;
    end;
    // if Assigned(FOnMoved) then FOnMoved(Self);
    FOldSize := FNewSize;
  end;
end;

{ TSolidLayer3D }

constructor TSolidLayer3D.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TSolidLayer3D.Destroy;
begin
  inherited;
end;

procedure TSolidLayer3D.Render;
var
  Ver: TVertexBuffer;
  Idx: TIndexBuffer;
  Mat: TColorMaterial;
begin
  Mat := TColorMaterial.Create;
  Mat.Color := ModulationColor;
  Ver := TVertexBuffer.Create([TVertexFormat.Vertex, TVertexFormat.TexCoord0], 4);
  Ver.Vertices[0] := TPoint3D.Zero;
  Ver.TexCoord0[0] := TPointF.Zero;
  Ver.Vertices[1] := TPoint3D.Create(Width, 0, 0);
  Ver.TexCoord0[1] := TPointF.Create(1, 0);
  Ver.Vertices[2] := TPoint3D.Create(Width, Height, 0);
  Ver.TexCoord0[2] := TPointF.Create(1, 1);
  Ver.Vertices[3] := TPoint3D.Create(0, Height, 0);
  Ver.TexCoord0[3] := TPointF.Create(0, 1);
  Idx := TIndexBuffer.Create(6);
  Idx[0] := 0;
  Idx[1] := 1;
  Idx[2] := 3;
  Idx[3] := 3;
  Idx[4] := 1;
  Idx[5] := 2;
  Context.DrawTriangles(Ver, Idx, Mat, AbsoluteOpacity);
  Ver.Free;
  Idx.Free;
  Mat.Free;
end;

{ TImage3D }

constructor TImage3D.Create(AOwner: TComponent);
begin
  inherited;
  FBitmap := TTextureBitmap.Create;
  FBitmap.OnChange := DoBitmapChanged;
  FWrapMode := TImageWrapMode.Stretch;
end;

destructor TImage3D.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure TImage3D.DoBitmapChanged(Sender: TObject);
begin
  Repaint;
end;

function TImage3D.GetBitmap: TBitmap;
begin
  Result := FBitmap;
end;

procedure TImage3D.SetBitmap(const Value: TBitmap);
begin
  FBitmap.Assign(Value);
end;

procedure TImage3D.Render;
var
  Mat: TTextureMaterial;

 function ImageXToReal(X: Single): Single;
 begin
   if Projection = TProjection.Camera then
     Result := (X / 10)
   else
     Result := X;
 end;
 function ImageYToReal(Y: Single): Single;
 begin
   if Projection = TProjection.Camera then
     Result := (Y / 10)
   else
     Result := Y;
 end;

var
  Ver: TVertexBuffer;
  Idx: TIndexBuffer;
  LocalRect, IntersectionRect, R: TRectF;
begin
  if not FBitmap.IsEmpty then
  begin
    Mat := TTextureMaterial.Create;
    Mat.Texture := TTextureBitmap(FBitmap).Texture;
    if Projection = TProjection.Camera then
      LocalRect := TRectF.Create(0, 0, Width * 10, Height * 10)
    else
    begin
      LocalRect := TRectF.Create(0, 0, Width, Height);
    end;
    case FWrapMode of
      TImageWrapMode.Original:
        begin
          R := TRectF.Create(0, 0, FBitmap.Width, FBitmap.Height);
          IntersectRect(IntersectionRect, LocalRect, R);
          Ver := TVertexBuffer.Create([TVertexFormat.Vertex, TVertexFormat.TexCoord0], 4);
          Ver.Vertices[0] := TPoint3D.Create(ImageXToReal(LocalRect.Left), ImageYToReal(LocalRect.Top), 0);
          Ver.TexCoord0[0] := TPointF.Zero;
          Ver.Vertices[1] := TPoint3D.Create(ImageXToReal(IntersectionRect.Width), ImageYToReal(LocalRect.Top), 0);
          Ver.TexCoord0[1] := TPointF.Create(IntersectionRect.Width / FBitmap.Width, 0);
          Ver.Vertices[2] := TPoint3D.Create(ImageXToReal(IntersectionRect.Width), ImageYToReal(IntersectionRect.Height), 0);
          Ver.TexCoord0[2] := TPointF.Create(IntersectionRect.Width / FBitmap.Width, IntersectionRect.Height / FBitmap.Height);
          Ver.Vertices[3] := TPoint3D.Create(ImageXToReal(LocalRect.Left), ImageYToReal(IntersectionRect.Height), 0);
          Ver.TexCoord0[3] := TPointF.Create(0, IntersectionRect.Height / FBitmap.Height);
          Idx := TIndexBuffer.Create(6);
          Idx[0] := 0;
          Idx[1] := 1;
          Idx[2] := 3;
          Idx[3] := 3;
          Idx[4] := 1;
          Idx[5] := 2;
          Context.DrawTriangles(Ver, Idx, Mat, AbsoluteOpacity);
          Idx.Free;
          Ver.Free;
        end;
      TImageWrapMode.Fit:
        begin
          R := TRectF.Create(0, 0, FBitmap.Width, FBitmap.Height);
          R := R.FitInto(LocalRect);
          Ver := TVertexBuffer.Create([TVertexFormat.Vertex, TVertexFormat.TexCoord0], 4);
          Ver.Vertices[0] := TPoint3D.Create(ImageXToReal(R.Left), ImageYToReal(R.Top), 0);
          Ver.TexCoord0[0] := TPointF.Zero;
          Ver.Vertices[1] := TPoint3D.Create(ImageXToReal(R.Right), ImageYToReal(R.Top), 0);
          Ver.TexCoord0[1] := TPointF.Create(1, 0);
          Ver.Vertices[2] := TPoint3D.Create(ImageXToReal(R.Right), ImageYToReal(R.Bottom), 0);
          Ver.TexCoord0[2] := TPointF.Create(1, 1);
          Ver.Vertices[3] := TPoint3D.Create(ImageXToReal(R.Left), ImageYToReal(R.Bottom), 0);
          Ver.TexCoord0[3] := TPointF.Create(0, 1);
          Idx := TIndexBuffer.Create(6);
          Idx[0] := 0;
          Idx[1] := 1;
          Idx[2] := 3;
          Idx[3] := 3;
          Idx[4] := 1;
          Idx[5] := 2;
          Context.DrawTriangles(Ver, Idx, Mat, AbsoluteOpacity);
          Idx.Free;
          Ver.Free;
        end;
      TImageWrapMode.Stretch:
        begin
          Ver := TVertexBuffer.Create([TVertexFormat.Vertex, TVertexFormat.TexCoord0], 4);
          Ver.Vertices[0] := TPoint3D.Create(ImageXToReal(LocalRect.Left), ImageYToReal(LocalRect.Top), 0);
          Ver.TexCoord0[0] := TPointF.Zero;
          Ver.Vertices[1] := TPoint3D.Create(ImageXToReal(LocalRect.Right), ImageYToReal(LocalRect.Top), 0);
          Ver.TexCoord0[1] := TPointF.Create(1, 0);
          Ver.Vertices[2] := TPoint3D.Create(ImageXToReal(LocalRect.Right), ImageYToReal(LocalRect.Bottom), 0);
          Ver.TexCoord0[2] := TPointF.Create(1, 1);
          Ver.Vertices[3] := TPoint3D.Create(ImageXToReal(LocalRect.Left), ImageYToReal(LocalRect.Bottom), 0);
          Ver.TexCoord0[3] := TPointF.Create(0, 1);
          Idx := TIndexBuffer.Create(6);
          Idx[0] := 0;
          Idx[1] := 1;
          Idx[2] := 3;
          Idx[3] := 3;
          Idx[4] := 1;
          Idx[5] := 2;
          Context.DrawTriangles(Ver, Idx, Mat, AbsoluteOpacity);
          Idx.Free;
          Ver.Free;
        end;
      TImageWrapMode.Tile:
        begin
          R := TRectF.Create(0, 0, FBitmap.Width, FBitmap.Height);
          Ver := TVertexBuffer.Create([TVertexFormat.Vertex, TVertexFormat.TexCoord0], 4);
          Ver.Vertices[0] := TPoint3D.Create(ImageXToReal(0), ImageYToReal(0), 0);
          Ver.TexCoord0[0] := TPointF.Zero;
          Ver.Vertices[1] := TPoint3D.Create(ImageXToReal(LocalRect.Width), ImageYToReal(0), 0);
          Ver.TexCoord0[1] := TPointF.Create(LocalRect.Width / FBitmap.Width, 0);
          Ver.Vertices[2] := TPoint3D.Create(ImageXToReal(LocalRect.Width), ImageYToReal(LocalRect.Height), 0);
          Ver.TexCoord0[2] := TPointF.Create(LocalRect.Width / FBitmap.Width, LocalRect.Height / FBitmap.Height);
          Ver.Vertices[3] := TPoint3D.Create(ImageXToReal(0), ImageYToReal(LocalRect.Height), 0);
          Ver.TexCoord0[3] := TPointF.Create(0, LocalRect.Height / FBitmap.Height);
          Idx := TIndexBuffer.Create(6);
          Idx[0] := 0;
          Idx[1] := 1;
          Idx[2] := 3;
          Idx[3] := 3;
          Idx[4] := 1;
          Idx[5] := 2;
          Context.DrawTriangles(Ver, Idx, Mat, AbsoluteOpacity);
          Idx.Free;
          Ver.Free;
        end;
    end;
    Mat.Free;
  end;
  if csDesigning in ComponentState then
    Context.DrawRect(TPoint3D.Zero, TPoint3D.Create(Width, Height, 0), AbsoluteOpacity, $A0909090);
end;

procedure TImage3D.SetWrapMode(const Value: TImageWrapMode);
begin
  if FWrapMode <> Value then
  begin
    FWrapMode := Value;
    Repaint;
  end;
end;

{ TCustomBufferLayer3D }

constructor TCustomBufferLayer3D.Create(AOwner: TComponent);
begin
  inherited;
  FBuffer := TTextureBitmap.Create(FLayerWidth, FLayerHeight);
end;

destructor TCustomBufferLayer3D.Destroy;
begin
  FreeAndNil(FBuffer);
  inherited;
end;

procedure TCustomBufferLayer3D.DoScaleChanged;
begin
  inherited;
  LayerResized;
end;

procedure TCustomBufferLayer3D.DoUpdateBuffer;
begin
  if (FBuffer <> nil) and Assigned(FOnUpdateBuffer) then
    FOnUpdateBuffer(Self);
end;

procedure TCustomBufferLayer3D.BeforeRender;
begin
  inherited;
  DoUpdateBuffer;
end;

procedure TCustomBufferLayer3D.Render;
var
  Ver: TVertexBuffer;
  Idx: TIndexBuffer;
  Mat: TTextureMaterial;
begin
  if not FBuffer.IsEmpty then
  begin
    Ver := TVertexBuffer.Create([TVertexFormat.Vertex, TVertexFormat.TexCoord0], 4);
    Ver.Vertices[0] := TPoint3D.Zero;
    Ver.Vertices[1] := TPoint3D.Create(Width, 0, 0);
    Ver.Vertices[2] := TPoint3D.Create(Width, Height, 0);
    Ver.Vertices[3] := TPoint3D.Create(0, Height, 0);
    Ver.TexCoord0[0] := TPointF.Zero;
    Ver.TexCoord0[1] := TPointF.Create(1, 0);
    Ver.TexCoord0[2] := TPointF.Create(1, 1);
    Ver.TexCoord0[3] := TPointF.Create(0, 1);
    Idx := TIndexBuffer.Create(6);
    Idx[0] := 0;
    Idx[1] := 1;
    Idx[2] := 3;
    Idx[3] := 3;
    Idx[4] := 1;
    Idx[5] := 2;
    Mat := TTextureMaterial.Create;
    Mat.Texture := TTextureBitmap(FBuffer).Texture;
    Context.DrawTriangles(Ver, Idx, Mat, AbsoluteOpacity);
    Mat.Free;
    Ver.Free;
    Idx.Free;
  end;
end;

function TCustomBufferLayer3D.GetBitmap: TBitmap;
begin
  Result := FBuffer;
end;

procedure TCustomBufferLayer3D.LayerResized;
begin
  if FBuffer <> nil then
  begin
    if FViewport <> nil then
    begin
      FBuffer.BitmapScale := FViewport.GetViewportScale;
      FBuffer.SetSize(Round(FLayerWidth * FViewport.GetViewportScale), Round(FLayerHeight * FViewport.GetViewportScale))
    end
    else
      FBuffer.SetSize(FLayerWidth, FLayerHeight);
  end;
  inherited ;
end;

{ TCustomLayer3D }

type
  TOpenControl = class(TControl);

constructor TCustomLayer3D.Create(AOwner: TComponent);
begin
  inherited;
  FStyleLookup := 'backgroundstyle';
  FNeedStyleLookup := True;
  FAnimatedCaret := True;
  ShowHint := True;
  DisableDragHighlight := True;
  Width := 8;
  Depth := 8;
  AutoCapture := True;
  FDesignInteract := True;
  FFill := TBrush.Create(TBrushKind.None, TAlphaColors.White);
  FFill.OnChanged := FillChanged;
  FStyleChangedId := TMessageManager.DefaultManager.SubscribeToMessage(TStyleChangedMessage, StyleChangedHandler);
end;

destructor TCustomLayer3D.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TStyleChangedMessage, FStyleChangedId);
  FreeAndNil(FControls);
  DeleteChildren;
  FreeAndNil(FFill);
  inherited;
end;

procedure TCustomLayer3D.ChangeScrollingState(const AControl: TControl; const Active: Boolean);
begin
end;

procedure TCustomLayer3D.AddUpdateRect(R: TRectF);
begin
  if (FDisableUpdating = 0) and not (csDestroying in ComponentState) then
  begin
    R := TRectF.Create(R.TopLeft.Truncate, R.BottomRight.Ceiling);
    if IntersectRect(R, TRectF.Create(0, 0, FLayerWidth, FLayerHeight))  then
    begin
      SetLength(FUpdateRects, Length(FUpdateRects) + 1);
      FUpdateRects[High(FUpdateRects)] := R;
      Repaint;
    end;
  end;
end;

procedure TCustomLayer3D.DoPaint(const Canvas: TCanvas; const ARect: TRectF);
begin
  if Assigned(FOnPaint) then
    FOnPaint(Self, Canvas, ARect);
end;

procedure TCustomLayer3D.DoUpdateBuffer;
var
  i, j: Integer;
  R: TRectF;
  CallOnPaint, AllowPaint: Boolean;
  Control: TOpenControl;
begin
  inherited ;
  if FDrawing then Exit;
  if Length(FUpdateRects) > 0 then
  begin
    FDrawing := True;
    try
      ApplyStyleLookup;
      if TCanvasStyle.SupportClipRects in TCanvasManager.DefaultCanvas.GetCanvasStyle then
      begin
        { Split rects if rects too more }
        if (Length(FUpdateRects) > 20) then
        begin
          for i := 1 to High(FUpdateRects) do
            FUpdateRects[0] := UnionRect(FUpdateRects[0], FUpdateRects[i]);
          SetLength(FUpdateRects, 1);
        end;
      end
      else
      begin
        SetLength(FUpdateRects, 1);
        FUpdateRects[0] := RectF(0, 0, LayerWidth, LayerHeight);
      end;
      if Canvas.BeginScene(@FUpdateRects) then
      try
        if (FFill.Kind = TBrushKind.None) or
           ((FFill.Color and $FF000000 = 0) and (FFill.Kind = TBrushKind.Solid)) then
        begin
          if not (TCanvasStyle.SupportClipRects in TCanvasManager.DefaultCanvas.GetCanvasStyle) then
          begin
            if Transparency then
              Canvas.Clear(0)
            else
              Canvas.Clear(FFill.Color and $FFFFFF);
          end else
            for i := 0 to High(FUpdateRects) do
            begin
              if Transparency then
                Canvas.ClearRect(FUpdateRects[i], 0)
              else
                Canvas.ClearRect(FUpdateRects[i], FFill.Color and $FFFFFF);
            end;
        end
        else
        begin
          Canvas.Fill.Assign(FFill);
          Canvas.FillRect(RectF(0, 0, LayerWidth, LayerHeight), 0, 0, AllCorners, 1);
        end;
        { Children }
        CallOnPaint := False;
        if FControls <> nil then
          for i := 0 to FControls.Count - 1 do
            if ((FControls[i].Visible) or (not FControls[i].Visible and (csDesigning in ComponentState) and not FControls[i].Locked)) then
              begin
                Control := TOpenControl(FControls[i]);
                if (Control.UpdateRect.IsEmpty) then
                  Continue;
                if (Control = FResourceLink) then
                begin
                  if Self.Transparency then Continue;
                  if (Self.Fill.Kind <> TBrushKind.None) then Continue;
                  if (Self.Fill.Kind = TBrushKind.Solid) and (Self.Fill.Color <> Fill.DefaultColor) then Continue;
                end;

                AllowPaint := False;
                if (csDesigning in Control.ComponentState) or Control.InPaintTo then
                  AllowPaint := True;
                if not AllowPaint then
                begin
                  R := UnionRect(Control.ChildrenRect, Control.UpdateRect);
                  for j := 0 to High(FUpdateRects) do
                    if IntersectRect(FUpdateRects[j], R) then
                    begin
                      AllowPaint := True;
                      Break;
                    end;
                end;
                if AllowPaint then
                  TOpenControl(Control).PaintInternal;
                { Call OnPaint after style painted }
                if (Control = FResourceLink) then
                begin
                  Self.Canvas.SetMatrix(TMatrix.Identity);
                  Self.DoPaint(Self.Canvas, RectF(0, 0, LayerWidth, LayerHeight));
                  CallOnPaint := True;
                end;
              end;
        { Call OnPaint if style not loaded }
        if not CallOnPaint then
        begin
          Canvas.SetMatrix(TMatrix.Identity);
          DoPaint(Canvas, RectF(0, 0, LayerWidth, LayerHeight));
        end;
      finally
        Canvas.EndScene;
      end;
    finally
      SetLength(FUpdateRects, 0);
      FDrawing := False;
    end;
  end;
end;

procedure TCustomLayer3D.DoAddObject(const AObject: TFmxObject);
begin
  inherited;

  if AObject is TControl then
  begin
    TControl(AObject).SetNewScene(Self);

    TOpenControl(AObject).RecalcOpacity;
    TOpenControl(AObject).RecalcAbsolute;
    TOpenControl(AObject).RecalcUpdateRect;
    TOpenControl(AObject).RecalcHasClipParent;
    TOpenControl(AObject).RecalcEnabled;

    if TControl(AObject).Align <> TAlignLayout.None then
      Realign;

    if FControls = nil then
    begin
      FControls := TControlList.Create;
      FControls.Capacity := InitialControlsCapacity;
    end;
    FControls.Add(TControl(AObject));

    Invalidate;
  end;
end;

procedure TCustomLayer3D.DoDeleteChildren;
begin
  inherited;
  FreeAndNil(FControls);
end;

procedure TCustomLayer3D.DoRemoveObject(const AObject: TFmxObject);
begin
  inherited;
  if AObject is TControl then
  begin
    if FControls <> nil then
      FControls.Remove(TControl(AObject));

    if not (csDestroying in ComponentState) then
    begin
      if (Canvas <> nil) and (TCanvasStyle.SupportClipRects in Canvas.GetCanvasStyle) then
        AddUpdateRect(TControl(AObject).UpdateRect)
      else
        Invalidate;
    end;
    TControl(AObject).SetNewScene(nil);
  end;
end;

procedure TCustomLayer3D.ChangeChildren;
var
  I, C: Integer;
  Changes: Integer;
begin
  inherited;
  Changes := 0;
  if not (csLoading in ComponentState) and (FControls <> nil) then
  begin
    C := 0;
    for I := 0 to ChildrenCount - 1 do
      if Children[I] is TControl then
      begin
        if C = FControls.Count then
          FControls.Add(TControl(Children[I]))
        else if FControls[C] <> TControl(Children[I]) then
        begin
          Inc(Changes);
          FControls[C] := TControl(Children[I]);
        end;
        Inc(C);
      end;
    while C < FControls.Count do
    begin
      Inc(Changes);
      FControls.Delete(FControls.Count - 1);
    end;
    if Changes > 0 then
      Realign;
  end;
end;

procedure TCustomLayer3D.DoScaleChanged;
begin
  inherited;
  DoStyleChanged;
end;

procedure TCustomLayer3D.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FStyleBook) then
    StyleBook := nil;
end;

procedure TCustomLayer3D.SetFill(const Value: TBrush);
begin
  FFill.Assign(Value);
end;

procedure TCustomLayer3D.FillChanged(Sender: TObject);
begin
  Invalidate;
end;

function TCustomLayer3D.GetCanvas: TCanvas;
begin
  Result := FBuffer.Canvas;
end;

function TCustomLayer3D.GetContainerHeight: Single;
begin
  Result := LayerHeight;
end;

function TCustomLayer3D.GetContainerWidth: Single;
begin
  Result := LayerWidth;
end;

function TCustomLayer3D.GetUpdateRectsCount: Integer;
begin
  Result := Length(FUpdateRects);
end;

procedure TCustomLayer3D.Invalidate;
begin
  SetLength(FUpdateRects, 0);
  AddUpdateRect(TRectF.Create(0, 0, FLayerWidth, FLayerHeight));
end;

function TCustomLayer3D.GetUpdateRect(const Index: Integer): TRectF;
begin
  Result := FUpdateRects[Index];
end;

function TCustomLayer3D.GetStyleObject: TControl;
var
  StyleObject: TFmxObject;
  DefaultStyleLookup: string;
  ParentClassStyleLookup: string;
begin
  DefaultStyleLookup := (ClassName + TStyledControl.StyleSuffix).Remove(0, 1);
  ParentClassStyleLookup := (ClassParent.ClassName + TStyledControl.StyleSuffix).Remove(0, 1);

  StyleObject := TStyledControl.LookupStyleObject(Self, Self, Self, StyleLookup, DefaultStyleLookup, ParentClassStyleLookup,
    True);

  if StyleObject is TFmxObject then
    Result := TControl(StyleObject)
  else
  begin
    StyleObject.Free;
    Result := nil;
  end;
end;

procedure TCustomLayer3D.ApplyStyleLookup;
var
  ResourceObject: TControl;
begin
  if FNeedStyleLookup then
  begin
    FNeedStyleLookup := False;
    ResourceObject := GetStyleObject;
    if ResourceObject <> nil then
    begin
      if FResourceLink <> nil then
      begin
        FResourceLink.Free;
        FResourceLink := nil;
      end;
      ResourceObject.Visible := True;
      ResourceObject.Align := TAlignLayout.Contents;
      FResourceLink := ResourceObject;
      AddObject(ResourceObject);
      { bring to front }
      RemoveObject(ResourceObject);
      InsertObject(0, ResourceObject);
      Realign;
      { }
      ResourceObject.Stored := False;
      ResourceObject.Lock;
    end;
  end;
end;

function TCustomLayer3D.GetSceneScale: Single;
begin
  if FViewport <> nil then
    Result := FViewport.GetViewportScale
  else
    Result := 1.0;
end;

function TCustomLayer3D.GetStyleBook: TStyleBook;
var
  StyleBookOwner: IStyleBookOwner;
begin
  Result := FStyleBook;
  if (Result = nil) and (Root <> nil) and Supports(Root, IStyleBookOwner, StyleBookOwner) then
    Result := StyleBookOwner.StyleBook;
end;

function TCustomLayer3D.ScreenToLocal(P: TPointF): TPointF;
var
  P3: TPoint3D;
  RayPos, RayDir: TVector3D;
begin
  if Context = nil then
    Exit(P);

  if FViewport <> nil then
    Result := FViewport.ScreenToLocal(P)
  else
    Result := P;

  Context.Pick(Result.X, Result.Y, Projection, RayPos, RayDir);

  RayPos := TPoint3D(AbsoluteToLocalVector(RayPos));
  RayDir := TPoint3D(AbsoluteToLocalVector(RayDir)).Normalize;

  if RayCastIntersect(TPoint3D(RayPos), TPoint3D(RayDir), P3) then
  begin
    P3 := TPoint3D(AbsoluteToLocalVector(P3));
    Result.X := (P3.X / Width) * FLayerWidth;
    Result.Y := (P3.Y / Height) * FLayerHeight;
  end
  else
    Result := TPointF.Create(-$FFFF, -$FFFF);
end;

function TCustomLayer3D.LocalToScreen(P: TPointF): TPointF;
var
  P3: TPoint3D;
begin
  if Context = nil then
  begin
    Result := P;
    Exit;
  end;

  P3 := TPoint3D.Create((P.X / FLayerWidth) * Width, (P.Y / FLayerHeight) * Height, 0);
  P3 := Context.WorldToScreen(Projection, LocalToAbsolute3D(P3));

  Result := TPointF.Create(P3.X, P3.Y);

  if FViewport <> nil then
    Result := FViewport.LocalToScreen(Result);
end;

procedure TCustomLayer3D.DoStyleChanged;
begin
  FNeedStyleLookup := True;
  if not (csLoading in ComponentState) and not (csDestroying in ComponentState) then
    ApplyStyleLookup;
end;

procedure TCustomLayer3D.SetStyleBook(const Value: TStyleBook);
begin
  if FStyleBook <> Value then
  begin
    FStyleBook := Value;
    if not (csLoading in ComponentState) and not (csDestroying in ComponentState) then
      TMessageManager.DefaultManager.SendMessage(nil, TStyleChangedMessage.Create(FStyleBook, Self), True);
  end;
end;

function TCustomLayer3D.FindTarget(P: TPointF; const Data: TDragObject): IControl;
var
  i: Integer;
  Obj: TFmxObject;
  NewObj: IControl;
begin
  Result := nil;
  for i := ChildrenCount - 1 downto 0 do
  begin
    Obj := Children[i];
    if IInterface(Obj).QueryInterface(IControl, NewObj) <> 0 then
      Continue;
    if not NewObj.Visible then Continue;
    if not NewObj.HitTest then Continue;
    NewObj := NewObj.FindTarget(P, Data);
    if NewObj <> nil then
    begin
      Result := NewObj;
      Exit;
    end;
  end;
end;

procedure TCustomLayer3D.SetVisible(const Value: Boolean);
begin
  inherited SetVisible(Value);
  if Visible then
    AddUpdateRect(RectF(0, 0, FLayerWidth, FLayerHeight));
end;

procedure TCustomLayer3D.StyleChangedHandler(const Sender: TObject; const Msg: TMessage);
begin
  DoStyleChanged;
end;

procedure TCustomLayer3D.SetActiveControl(AControl: TStyledControl);
begin
  if AControl <> FActiveControl then
  begin
    FActiveControl := AControl;
    if (FActiveControl <> nil) and not(csLoading in ComponentState) then
      FActiveControl.SetFocus;
  end;
end;

procedure TCustomLayer3D.DisableUpdating;
begin
  Inc(FDisableUpdating);
end;

procedure TCustomLayer3D.EnableUpdating;
begin
  Dec(FDisableUpdating);
  if FDisableUpdating < 0 then
    raise EInvalidSceneUpdatingPairCall.Create(SInvalidSceneUpdatingPairCall);
end;

procedure TCustomLayer3D.SetStyleLookup(const Value: string);
begin
  FStyleLookup := Value;
  FNeedStyleLookup := True;
  if not (csLoading in ComponentState) then
  begin
    ApplyStyleLookup;
  end;
end;

{ TTextLayer3D }

constructor TTextLayer3D.Create(AOwner: TComponent);
begin
  inherited;
  FTransparency := True;
  FText := TText.Create(Self);
  FText.Locked := True;
  FText.Stored := False;
  FText.Align := TAlignLayout.Contents;
  FText.Parent := Self;
end;

procedure TTextLayer3D.ApplyStyleLookup;
begin
end;

function TTextLayer3D.GetColor: TAlphaColor;
begin
  Result := FText.Color;
end;

function TTextLayer3D.GetFont: TFont;
begin
  Result := FText.Font;
end;

function TTextLayer3D.GetText: string;
begin
  Result := FText.Text;
end;

procedure TTextLayer3D.SetColor(const Value: TAlphaColor);
begin
  FText.Color := Value;
end;

procedure TTextLayer3D.SetFont(const Value: TFont);
begin
  FText.Font.Assign(Value);
end;

procedure TTextLayer3D.SetText(const Value: string);
begin
  FText.Text := Value;
end;

initialization
  RegisterFmxClasses([TLayout3D, TSplitter3D, TImage3D, TSolidLayer3D, TLayer3D, TTextLayer3D]);
end.


