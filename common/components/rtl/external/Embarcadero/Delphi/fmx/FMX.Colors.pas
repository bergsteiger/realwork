{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Colors;

interface

uses
  System.Classes, System.Types, System.Rtti, System.UITypes, FMX.Objects, FMX.Types, FMX.StdCtrls,
  FMX.Edit, FMX.ListBox, FMX.PixelFormats, FMX.Controls, FMX.Pickers;

const
  colorPickSize = 10;

type

{ THueTrackBar }

  THueTrackBar = class(TBitmapTrackBar)
  private
    function IsValueStored: Boolean;
  protected
    procedure FillBitmap; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Value stored IsValueStored;
  end;

{ TAlphaTrackBar }

  TAlphaTrackBar = class(TBitmapTrackBar)
  private
    function IsValueStored: Boolean;
  protected
    procedure FillBitmap; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Value stored IsValueStored;
  end;

{ TBWTrackBar }

  TBWTrackBar = class(TBitmapTrackBar)
  private
    function IsValueStored: Boolean;
  protected
    procedure FillBitmap; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Value stored IsValueStored;
  end;

{ TColorBox }

  TColorBox = class(TControl)
  private
    FColor: TAlphaColor;
    procedure SetColor(const Value: TAlphaColor);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Color: TAlphaColor read FColor write SetColor;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property TabOrder;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
    property OnCanFocus;
    property OnClick;
    property OnDblClick;

    property OnEnter;
    property OnExit;
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

{ TColorQuad }

  TColorQuad = class(TControl)
  private
    FColorBox: TColorBox;
    FColorBitmap: TBitmap;
    FHue: Single;
    FSat: Single;
    FLum: Single;
    FOnChange: TNotifyEvent;
    FAlpha: Single;
    FPendingChanges: Boolean;
    procedure SetHue(const Value: Single);
    procedure SetLum(const Value: Single);
    procedure SetSat(const Value: Single);
    procedure SetAlpha(const Value: Single);
    procedure SetColorBox(const Value: TColorBox);
    procedure PreviewColor(const ValHue, ValLum, ValSat, ValAlpha: Single);
    procedure SetColor(const ValHue, ValLum, ValSat, ValAlpha: Single);
    function GetIsTracking: Boolean;
  protected
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    function GetAbsoluteRect: TRectF; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
  public
    function PointInObjectLocal(X, Y: Single): Boolean; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Alpha: Single read FAlpha write SetAlpha;
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property ColorBox: TColorBox read FColorBox write SetColorBox;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default True;
    property Hue: Single read FHue write SetHue;
    property Lum: Single read FLum write SetLum;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Sat: Single read FSat write SetSat;
    property Scale;
    property TabOrder;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
    property OnCanFocus;
    property OnClick;
    property OnDblClick;

    property OnEnter;
    property OnExit;
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

{ TColorPicker }

  TColorPicker = class(TControl)
  private
    FHueBitmap: TBitmap;
    FHue: Single;
    FColorQuad: TColorQuad;
    procedure SetHue(const Value: Single);
    function GetColor: TAlphaColor;
    procedure SetColor(const Value: TAlphaColor);
  protected
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Single); override;
    function GetAbsoluteRect: TRectF; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
  public
    function PointInObjectLocal(X, Y: Single): Boolean; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Color: TAlphaColor read GetColor write SetColor;
  published
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property ColorQuad: TColorQuad read FColorQuad write FColorQuad;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default True;
    property Hue: Single read FHue write SetHue;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property TabOrder;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
    property OnCanFocus;
    property OnClick;
    property OnDblClick;

    property OnEnter;
    property OnExit;
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

{ TGradientEdit }

  TGradientEdit = class(TControl)
  private
    FBitmap: TBitmap;
    FGradient: TGradient;
    FCurrentPoint: Integer;
    FCurrentPointInvisible: Boolean;
    FMoving: Boolean;
    FOnChange: TNotifyEvent;
    FOnSelectPoint: TNotifyEvent;
    FColorPicker: TColorPicker;
    procedure SetGradient(const Value: TGradient);
    function GetPointRect(const Point: Integer): TRectF;
    procedure DoChanged(Sender: TObject);
    procedure SetCurrentPoint(const Value: Integer);
    procedure SetColorPicker(const Value: TColorPicker);
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateGradient;
    property Gradient: TGradient read FGradient write SetGradient;
    property CurrentPoint: Integer read FCurrentPoint write SetCurrentPoint;
  published
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property ColorPicker: TColorPicker read FColorPicker write SetColorPicker;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property TabOrder;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    {events}
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
    property OnCanFocus;
    property OnClick;
    property OnDblClick;

    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;

    property OnPainting;
    property OnPaint;
    property OnResize;
    property OnSelectPoint: TNotifyEvent read FOnSelectPoint write FOnSelectPoint;
  end;

{ TColorPanel }

  TColorPanel = class(TControl)
  private
    FOnChange: TNotifyEvent;
    FColorQuad: TColorQuad;
    FAlphaTrack: TAlphaTrackBar;
    FHueTrack: THueTrackBar;
    FColorBox: TColorBox;
    FUseAlpha: Boolean;
    FOwnerObserves: Boolean;
    function GetColor: TAlphaColor;
    procedure SetColor(const Value: TAlphaColor);
    procedure SetColorBox(const Value: TColorBox);
    procedure SetUseAlpha(const Value: Boolean);
  protected
    function GetObservers: TObservers; override;
    function CanObserve(const ID: Integer): Boolean; override;
    function GetData: TValue; override;
    procedure DoAlphaChange(Sender: TObject);
    procedure DoHueChange(Sender: TObject);
    procedure DoQuadChange(Sender: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure OwnerObserves;
  published
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Color: TAlphaColor read GetColor write SetColor;
    property ColorBox: TColorBox read FColorBox write SetColorBox;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property TabOrder;
    property TouchTargetExpansion;
    property UseAlpha: Boolean read FUseAlpha write SetUseAlpha default True;
    property Visible default True;
    property Width;
    {events}
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
    property OnCanFocus;
    property OnClick;
    property OnDblClick;

    property OnEnter;
    property OnExit;
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

{ TComboColorBox }

  TComboColorBox = class(TStyledControl)
  private
    FPopup: TPopup;
    FColorPanel: TColorPanel;
    FColorBox: TColorBox;
    FColorText: TEdit;
    FPlacement: TPlacement;
    FOnChange: TNotifyEvent;
    function GetValue: TAlphaColor;
    procedure SetValue(const Value: TAlphaColor);
    function GetUseAlpha: Boolean;
    procedure SetUseAlpha(const Value: Boolean);
  protected
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure ApplyStyle; override;
    function CanObserve(const ID: Integer): Boolean; override;
    function GetDefaultStyleLookupName: string; override;
    procedure DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure ChangeParent; override;
    procedure DoColorChange(Sender: TObject); virtual;
    procedure DoTextChange(Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DropDown;
  published
    property Align;
    property Anchors;
    property CanFocus default True;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Color: TAlphaColor read GetValue write SetValue;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DisableFocusEffect;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TabOrder;
    property TouchTargetExpansion;
    property UseAlpha: Boolean read GetUseAlpha write SetUseAlpha default True;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
    property OnCanFocus;
    property OnClick;
    property OnDblClick;

    property OnEnter;
    property OnExit;
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

{ TColorButton }

  TColorButton = class(TCustomButton)
  private
    FFill: TShape;
    FColor: TAlphaColor;
    FOnChange: TNotifyEvent;
    procedure SetColor(const Value: TAlphaColor);
  protected
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property AutoTranslate default False;
    property CanFocus default True;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Color: TAlphaColor read FColor write SetColor;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property DisableFocusEffect;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    {trigger}
    property StaysPressed default False;
    property IsPressed;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TabOrder;
    property Text;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
    property OnCanFocus;
    property OnClick;
    property OnDblClick;

    property OnEnter;
    property OnExit;
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

{ TColorListBox }

  TColorListBox = class(TListBox)
  private
    FItems: TStrings;
    procedure SetColor(const Value: TAlphaColor);
    function GetColor: TAlphaColor;
    procedure SetItems(const Value: TStrings);
    procedure DoItemApplyStyleLookup(Sender: TObject);
  protected
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure RebuildList;
    function GetDefaultStyleLookupName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Color: TAlphaColor read GetColor write SetColor;
    property Items: TStrings read FItems write SetItems stored false;
  end;

{ TColorComboBox }

  TColorComboBox = class(TComboBox)
  private
    procedure SetColor(const Value: TAlphaColor);
    function GetColor: TAlphaColor;
    procedure DoItemApplyStyleLookup(Sender: TObject);
  protected
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure RebuildList;
    function GetDefaultStyleLookupName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DropDownKind nodefault;
    property Color: TAlphaColor read GetColor write SetColor;
  end;

procedure MakeChessBoardBrush(ABrushBitmap: TBrushBitmap; const AChessStep: Single);

implementation

uses System.UIConsts, System.Variants, System.SysUtils, System.Math, FMX.Platform;

procedure MakeChessBoardBrush(ABrushBitmap: TBrushBitmap; const AChessStep: Single);
var
  BitmapTmp: TBitmap;
begin
  BitmapTmp := ABrushBitmap.Bitmap;
  BitmapTmp.SetSize(Trunc(2 * AChessStep), Trunc(2 * AChessStep));
  BitmapTmp.Clear(TAlphaColorRec.White);
  BitmapTmp.ClearRect(RectF(0, 0, AChessStep, AChessStep), TAlphaColorRec.Lightgray);
  BitmapTmp.ClearRect(RectF(AChessStep, AChessStep, 2 * AChessStep, 2 * AChessStep), TAlphaColorRec.Lightgray);
  ABrushBitmap.WrapMode := TWrapMode.wmTile;
end;

{ THueTrackBar }

constructor THueTrackBar.Create(AOwner: TComponent);
begin
  inherited;
  Max := 1;
  Value := 0.5;
end;

procedure THueTrackBar.FillBitmap;
var
  i, j: Integer;
  M: TBitmapData;
begin
  if FBitmap.Map(TMapAccess.maWrite, M) then
  try
    for j := 0 to FBitmap.Height - 1 do
    begin
      for i := 0 to FBitmap.Width - 1 do
      begin
        if Orientation = TOrientation.orHorizontal then
          M.SetPixel(i, j, (HSLtoRGB(i / FBitmap.Width, 0.9, 0.5)))
        else
          M.SetPixel(i, j, (HSLtoRGB(j / FBitmap.Height, 0.9, 0.5)));
      end;
    end;
  finally
    FBitmap.Unmap(M);
  end;
end;

function THueTrackBar.IsValueStored: Boolean;
begin
  Result := Value <> 0.5;
end;

{ TAlphaTrackBar }

constructor TAlphaTrackBar.Create(AOwner: TComponent);
begin
  inherited;
  Max := 1;
  Value := 1;
end;

procedure TAlphaTrackBar.FillBitmap;
var
  i, j: Integer;
  M: TBitmapData;
begin
  if FBitmap.Map(TMapAccess.maWrite, M) then
  try
    for j := 0 to FBitmap.Height - 1 do
    begin
      for i := 0 to FBitmap.Width - 1 do
      begin
        if odd(i div 3) and not odd(j div 3) then
          M.SetPixel(i, j, $FFA0A0A0)
        else if not odd(i div 3) and odd(j div 3) then
          M.SetPixel(i, j, $FFA0A0A0)
        else
          M.SetPixel(i, j, $FFFFFFFF)
      end;
    end;
  finally
    FBitmap.Unmap(M);
  end;
  if FBitmap.Canvas.BeginScene then
  try
    FBitmap.Canvas.Fill.Kind := TBrushKind.bkGradient;
    FBitmap.Canvas.Fill.Gradient.Points[0].Color := $00FFFFFF;
    FBitmap.Canvas.Fill.Gradient.Points[1].Color := $FFFFFFFF;
    if Orientation = TOrientation.orHorizontal then
      FBitmap.Canvas.Fill.Gradient.StopPosition.Point := PointF(1, 0)
    else
      FBitmap.Canvas.Fill.Gradient.StopPosition.Point := PointF(0, 1);
    FBitmap.Canvas.FillRect(RectF(0, 0, FBitmap.Width, FBitmap.Height), 0,
      0, [], 1);
  finally
    FBitmap.Canvas.EndScene;
  end;
end;

function TAlphaTrackBar.IsValueStored: Boolean;
begin
  Result := Value <> 1;
end;

{ TBWTrackBar }

constructor TBWTrackBar.Create(AOwner: TComponent);
begin
  inherited;
  Max := 1;
  Value := 0.5;
end;

procedure TBWTrackBar.FillBitmap;
var
  i, j: Integer;
  a: byte;
  M: TBitmapData;
begin
  if FBitmap.Map(TMapAccess.maWrite, M) then
  try
    for j := 0 to FBitmap.Height - 1 do
    begin
      for i := 0 to FBitmap.Width - 1 do
      begin
        if Orientation = TOrientation.orHorizontal then
          a := round((i / FBitmap.Width) * $FF)
        else
          a := round((j / FBitmap.Height) * $FF);
        M.SetPixel(i, j, MakeColor(a, a, a))
      end;
    end;
  finally
    FBitmap.Unmap(M);
  end;
end;

function TBWTrackBar.IsValueStored: Boolean;
begin
  Result := Value <> 0.5;
end;

{ TColorBox }

constructor TColorBox.Create(AOwner: TComponent);
begin
  inherited;
  SetAcceptsControls(False);
end;

procedure TColorBox.Paint;
var
  State: TCanvasSaveState;
begin
  State := Canvas.SaveState;
  try
    MakeChessBoardBrush(Canvas.Fill.Bitmap, 5);
    Canvas.Fill.Kind := TBrushKind.bkBitmap;
    Canvas.FillRect(LocalRect, 0, 0, AllCorners, AbsoluteOpacity);

    Canvas.Fill.Kind := TBrushKind.bkSolid;
    Canvas.Fill.Color := FColor;
    Canvas.FillRect(LocalRect, 0, 0, AllCorners, AbsoluteOpacity);
  finally
    Canvas.RestoreState(State);
  end;
end;

procedure TColorBox.SetColor(const Value: TAlphaColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Repaint;
  end;
end;

{ TColorQuad }

constructor TColorQuad.Create(AOwner: TComponent);
begin
  inherited;
  FAlpha := 1;
  AutoCapture := True;
  SetAcceptsControls(False);
  FPendingChanges := false;
end;

destructor TColorQuad.Destroy;
begin
  if Assigned(FColorBitmap) then
    FreeAndNil(FColorBitmap);
  inherited;
end;

function TColorQuad.GetAbsoluteRect: TRectF;
begin
  Result := inherited GetAbsoluteRect;
  InflateRect(Result, colorPickSize + 1, colorPickSize + 1);
end;

function TColorQuad.GetIsTracking: Boolean;
begin
  Result := FPressed;
end;

function TColorQuad.PointInObjectLocal(X, Y: Single): Boolean;
begin
  Result := False;
  if (X > -colorPickSize / 2) and (X < Width + colorPickSize / 2) and
    (Y > -colorPickSize / 2) and (Y < Height + colorPickSize / 2) then
  begin
    Result := True;
  end;
end;

procedure TColorQuad.PreviewColor(const ValHue, ValLum, ValSat,
  ValAlpha: Single);
var
  LChanged : Boolean;
begin
  LChanged := false;

  if FHue <> ValHue then
  begin
    FHue := ValHue;
    if FHue < 0 then
      FHue := 0;
    if FHue > 1 then
      FHue := 1;

    LChanged := true;
  end;

  if FLum <> ValLum then
  begin
    FLum := ValLum;
    if FLum < 0 then
      FLum := 0;
    if FLum > 1 then
      FLum := 1;

    LChanged := true;
  end;

  if FSat <> ValSat then
  begin
    FSat := ValSat;
    if FSat < 0 then
      FSat := 0;
    if FSat > 1 then
      FSat := 1;

    LChanged := true;
  end;

  if FAlpha <> ValAlpha then
  begin
    FAlpha := ValAlpha;
    if FAlpha < 0 then
      FAlpha := 0;
    if FAlpha > 1 then
      FAlpha := 1;

    LChanged := true;
  end;

  if LChanged then
  begin
    if Assigned(FColorBitmap) then
      FreeAndNil(FColorBitmap);
    if Assigned(FColorBox) then
      FColorBox.Color := HSLtoRGB(FHue, FSat, FLum) and $FFFFFF or
        (round(FAlpha * $FF) shl 24);
    Repaint;
  end;
end;

procedure TColorQuad.MouseMove(Shift: TShiftState; X, Y: Single);
var
  LLum, LSat: Single;
begin
  inherited;
  if FPressed then
  begin
    LLum := Lum;
    LSat := Sat;
    if Height <> 0 then
      LLum := 1 - ((Y) / (Height));
    if Width <> 0 then
      LSat := ((X) / (Width));

    if GetIsTracking then
      SetColor(Hue, LLum, LSat, Alpha)
    else
      // will not fire OnChange event. MouseUp though will change the value when gets fired
      PreviewColor(Hue, LLum, LSat, Alpha);
  end;
end;

procedure TColorQuad.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  LLum, LSat: Single;
begin
  inherited;

  LLum := Lum;
  LSat := Sat;
  if Height <> 0 then
    LLum := 1 - ((Y) / (Height));
  if Width <> 0 then
    LSat := ((X) / (Width));

  SetColor(Hue, LLum, LSat, Alpha);
end;

procedure TColorQuad.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FColorBox) then
    ColorBox := nil;
end;

procedure TColorQuad.Paint;
var
  i, j: Integer;
  R: TRectF;
  H, S, L: Single;
  M: TBitmapData;
begin
  H := Hue;
  S := Sat;
  L := Lum;

  if not Assigned(FColorBitmap) then
  begin
    FColorBitmap := TBitmap.Create(Trunc(Width), Trunc(Height));
    if Assigned(FColorBitmap) then
    begin
      if FColorBitmap.Map(TMapAccess.maWrite, M) then
      try
        for i := 0 to FColorBitmap.Width - 1 do
        begin
          for j := 0 to FColorBitmap.Height - 1 do
            M.SetPixel(i, j, HSLtoRGB(H, i / FColorBitmap.Width, (1 - (j / FColorBitmap.Height))));
        end;
      finally
        FColorBitmap.Unmap(M);
      end;
    end;
  end;
  if Assigned(FColorBitmap) then
    Canvas.DrawBitmap(FColorBitmap, RectF(0, 0, FColorBitmap.Width, FColorBitmap.Height),
      RectF(0, 0, Width, Height), AbsoluteOpacity);
  { current }

  R := RectF(S * (Width), (1 - L) * (Height), S * (Width),
    (1 - L) * (Height));

  InflateRect(R, colorPickSize / 2, colorPickSize / 2);
  Canvas.Stroke.Kind := TBrushKind.bkSolid;
  Canvas.StrokeThickness := 1;
  Canvas.Stroke.Color := $FF000000;
  Canvas.DrawEllipse(R, AbsoluteOpacity);
  InflateRect(R, -1, -1);
  Canvas.Stroke.Color := $FFFFFFFF;
  Canvas.DrawEllipse(R, AbsoluteOpacity);
  InflateRect(R, -1, -1);
  Canvas.Fill.Kind := TBrushKind.bkSolid;
  Canvas.Fill.Color := HSLtoRGB(H, S, L);
  Canvas.FillEllipse(R, AbsoluteOpacity);
end;

procedure TColorQuad.SetAlpha(const Value: Single);
begin
  if FAlpha <> Value then
  begin
    FAlpha := Value;
    if FAlpha < 0 then
      FAlpha := 0;
    if FAlpha > 1 then
      FAlpha := 1;
    if Assigned(FColorBox) then
      FColorBox.Color := HSLtoRGB(Hue, Sat, Lum) and $FFFFFF or
        (round(Alpha * $FF) shl 24);
    if (not FPressed) and Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TColorQuad.SetHue(const Value: Single);
begin
  if FHue <> Value then
  begin
    FHue := Value;
    if FHue < 0 then
      FHue := 0;
    if FHue > 1 then
      FHue := 1;
    if Assigned(FColorBitmap) then
      FreeAndNil(FColorBitmap);
    if Assigned(FColorBox) then
      FColorBox.Color := HSLtoRGB(Hue, Sat, Lum) and $FFFFFF or
        (round(Alpha * $FF) shl 24);
    if (not FPressed) and Assigned(FOnChange) then
      FOnChange(Self);
    Repaint;
  end;
end;

procedure TColorQuad.SetLum(const Value: Single);
begin
  if FLum <> Value then
  begin
    FLum := Value;
    if FLum < 0 then
      FLum := 0;
    if FLum > 1 then
      FLum := 1;
    if Assigned(FColorBox) then
      FColorBox.Color := HSLtoRGB(Hue, Sat, Lum) and $FFFFFF or
        (round(Alpha * $FF) shl 24);
    if (not FPressed) and Assigned(FOnChange) then
      FOnChange(Self);
    Repaint;
  end;
end;

procedure TColorQuad.SetSat(const Value: Single);
begin
  if FSat <> Value then
  begin
    FSat := Value;
    if FSat < 0 then
      FSat := 0;
    if FSat > 1 then
      FSat := 1;
    if Assigned(FColorBox) then
      FColorBox.Color := HSLtoRGB(Hue, Sat, Lum) and $FFFFFF or
        (round(Alpha * $FF) shl 24);
    if (not FPressed) and Assigned(FOnChange) then
      FOnChange(Self);
    Repaint;
  end;
end;

procedure TColorQuad.SetColor(const ValHue, ValLum, ValSat, ValAlpha: Single);
begin
  if FPendingChanges then
    Exit;
  FPendingChanges := true;

  FHue := ValHue;
  if FHue < 0 then
    FHue := 0;
  if FHue > 1 then
    FHue := 1;

  FLum := ValLum;
  if FLum < 0 then
    FLum := 0;
  if FLum > 1 then
    FLum := 1;

  FSat := ValSat;
  if FSat < 0 then
    FSat := 0;
  if FSat > 1 then
    FSat := 1;

  FAlpha := ValAlpha;
  if FAlpha < 0 then
    FAlpha := 0;
  if FAlpha > 1 then
    FAlpha := 1;

  if Assigned(FColorBitmap) then
    FreeAndNil(FColorBitmap);
  if Assigned(FColorBox) then
    FColorBox.Color := HSLtoRGB(Hue, Sat, Lum) and $FFFFFF or
      (round(Alpha * $FF) shl 24);
  if Assigned(FOnChange) then
      FOnChange(Self);
    Repaint;

  FPendingChanges := false;
end;

procedure TColorQuad.SetColorBox(const Value: TColorBox);
begin
  if FColorBox <> Value then
  begin
    FColorBox := Value;
    if Assigned(FColorBox) and (not FPressed) then
      FColorBox.Color := HSLtoRGB(Hue, Sat, Lum) and $FFFFFF or
        (round(Alpha * $FF) shl 24);
  end;
end;

{ TColorPicker }

constructor TColorPicker.Create(AOwner: TComponent);
begin
  inherited;
  AutoCapture := True;
end;

destructor TColorPicker.Destroy;
begin
  if Assigned(FHueBitmap) then
    FreeAndNil(FHueBitmap);
  inherited;
end;

procedure TColorPicker.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FColorQuad) then
    ColorQuad := nil;
end;

function TColorPicker.GetAbsoluteRect: TRectF;
begin
  Result := inherited GetAbsoluteRect;
  InflateRect(Result, 0, colorPickSize / 2);
end;

function TColorPicker.PointInObjectLocal(X, Y: Single): Boolean;
begin
  Result := False;
  if (X > 0) and (X < Width) and (Y > -colorPickSize / 2) and
    (Y < Height + colorPickSize / 2) then
    Result := True;
end;

procedure TColorPicker.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if FPressed then
  begin
    if Height <> 0 then
      Hue := ((Y) / (Height));
  end;
end;

procedure TColorPicker.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if FPressed then
    MouseMove([ssLeft], X, Y);
  inherited;
end;

procedure TColorPicker.Paint;
var
  i, j: Integer;
  R: TRectF;
  M: TBitmapData;
begin
  if not Assigned(FHueBitmap) then
  begin
    FHueBitmap := TBitmap.Create(Trunc(Width), Trunc(Height));
    if Assigned(FHueBitmap) then
    begin
      if FHueBitmap.Map(TMapAccess.maWrite, M) then
      try
        for j := 0 to FHueBitmap.Height - 1 do
        begin
          for i := 0 to FHueBitmap.Width - 1 do
            M.SetPixel(i, j, HSLtoRGB(j / FHueBitmap.Height, 0.9, 0.5));
        end;
      finally
        FHueBitmap.Unmap(M);
      end;
    end;
  end;

  if Assigned(FHueBitmap) then
    Canvas.DrawBitmap(FHueBitmap, RectF(0, 0, FHueBitmap.Width, FHueBitmap.Height),
      RectF(0, 0, Width, Height), AbsoluteOpacity);

  { hue pos }
  R := RectF(Width / 2, FHue * (Height), Width / 2, FHue * (Height));
  InflateRect(R, colorPickSize / 2, colorPickSize / 2);
  // OffsetRect(R, 01, StrokeThickness);
  Canvas.Stroke.Kind := TBrushKind.bkSolid;
  Canvas.StrokeThickness := 1;
  Canvas.Stroke.Color := $FF000000;
  Canvas.DrawEllipse(R, AbsoluteOpacity);
  InflateRect(R, -1, -1);
  Canvas.Stroke.Color := $FFFFFFFF;
  Canvas.DrawEllipse(R, AbsoluteOpacity);
  InflateRect(R, -1, -1);
  Canvas.Fill.Kind := TBrushKind.bkSolid;
  Canvas.Fill.Color := HSLtoRGB(Hue, 0.9, 0.5);
  Canvas.FillEllipse(R, AbsoluteOpacity);
end;

function TColorPicker.GetColor: TAlphaColor;
begin
  Result := HSLtoRGB(Hue, 1, 0.5)
end;

procedure TColorPicker.SetColor(const Value: TAlphaColor);
var
  H, S, L: Single;
begin
  RGBtoHSL(Value, H, S, L);
  Hue := H;
  if Assigned(FColorQuad) then
  begin
    FColorQuad.Alpha := TAlphaColorRec(Value).a / $FF;
    FColorQuad.Hue := H;
    FColorQuad.Sat := S;
    FColorQuad.Lum := L;
  end;
end;

procedure TColorPicker.SetHue(const Value: Single);
begin
  if FHue <> Value then
  begin
    FHue := Value;
    if FHue < 0 then
      FHue := 0;
    if FHue > 1 then
      FHue := 1;
    if Assigned(FColorQuad) then
      FColorQuad.Hue := FHue;
    Repaint;
  end;
end;

{ TGradientEdit }

constructor TGradientEdit.Create(AOwner: TComponent);
begin
  inherited;
  FGradient := TGradient.Create;
  FGradient.OnChanged := DoChanged;
  Width := 200;
  Height := 20;
  AutoCapture := True;
  SetAcceptsControls(False);
end;

destructor TGradientEdit.Destroy;
begin
  if Assigned(FBitmap) then
    FreeAndNil(FBitmap);
  if Assigned(FGradient) then
    FreeAndNil(FGradient);
  inherited;
end;

function TGradientEdit.GetPointRect(const Point: Integer): TRectF;
begin
  if (Point >= 0) and (Point < FGradient.Points.Count) then
  begin
      Result := RectF(0 + colorPickSize + (FGradient.Points[Point].Offset *
        (Width - ((0 + colorPickSize) * 2))), Height - 0 - colorPickSize,
        0 + colorPickSize + (FGradient.Points[Point].Offset *
        (Width - ((0 + colorPickSize) * 2))), Height - 0);
      InflateRect(Result, colorPickSize / 2, 0);
  end
  else
    Result := RectF(0, 0, 0, 0);
end;

procedure TGradientEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  NewOffset: Single;
  NewColor: TAlphaColor;
  i: Integer;
  NewGradientPoint: TGradientPoint;
begin
  inherited;
  FMoving := False;
  if Button = TMouseButton.mbLeft then
  begin
    { select point }
    for i := 0 to FGradient.Points.Count - 1 do
      if GetPointRect(i).Contains(PointF(X, Y)) then
      begin
        CurrentPoint := i;
        if Assigned(OnSelectPoint) then
          OnSelectPoint(Self);
        FMoving := True;
        Repaint;
        Exit;
      end;
    { add new point }
    if (Y > 0) and (Y < Height - 0 - colorPickSize) then
    begin
      NewOffset := ((X - 0 - colorPickSize) /
        (Width - ((0 + colorPickSize) * 2)));
      if NewOffset < 0 then
        NewOffset := 0;
      if NewOffset > 1 then
        NewOffset := 1;
      NewColor := FGradient.InterpolateColor(NewOffset);
      for i := 1 to FGradient.Points.Count - 1 do
        if NewOffset < FGradient.Points[i].Offset then
        begin
          NewGradientPoint := TGradientPoint(FGradient.Points.Add);
          NewGradientPoint.Index := i;
          CurrentPoint := i;
          NewGradientPoint.IntColor := NewColor;
          NewGradientPoint.Offset := NewOffset;
          Repaint;
          DoChanged(Self);
          Break;
        end;
    end;
  end;
end;

procedure TGradientEdit.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if ssLeft in Shift then
  begin
    if FMoving then
    begin
      FCurrentPointInvisible := ((Y < -10) or (Y > Height + 10)) and
        (FGradient.Points.Count > 1) and (CurrentPoint <> 0) and
        (CurrentPoint <> FGradient.Points.Count - 1);
      { move }
      FGradient.Points[CurrentPoint].Offset :=
        ((X - 0 - colorPickSize) / (Width - ((0 + colorPickSize) * 2)));
      if FGradient.Points[CurrentPoint].Offset < 0 then
        FGradient.Points[CurrentPoint].Offset := 0;
      if FGradient.Points[CurrentPoint].Offset > 1 then
        FGradient.Points[CurrentPoint].Offset := 1;
      { move right }
      if CurrentPoint < FGradient.Points.Count - 1 then
        if FGradient.Points[CurrentPoint].Offset > FGradient.Points
          [CurrentPoint + 1].Offset then
        begin
          FGradient.Points[CurrentPoint].Index := FGradient.Points[CurrentPoint]
            .Index + 1;
          CurrentPoint := CurrentPoint + 1;
        end;
      { move left }
      if CurrentPoint > 0 then
        if FGradient.Points[CurrentPoint].Offset < FGradient.Points
          [CurrentPoint - 1].Offset then
        begin
          FGradient.Points[CurrentPoint].Index := FGradient.Points[CurrentPoint]
            .Index - 1;
          CurrentPoint := CurrentPoint - 1;
        end;
      Repaint;
      DoChanged(Self);
    end;
  end;
end;

procedure TGradientEdit.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  FCurrentPointInvisible := False;
  if FMoving then
  begin
    { delete }
    if (Y > Height + 10) and (FGradient.Points.Count > 2) then
    begin
      FGradient.Points.Delete(CurrentPoint);
      CurrentPoint := CurrentPoint - 1;
      if CurrentPoint < 0 then
        CurrentPoint := 0;
      Repaint;
      DoChanged(Self);
      FMoving := False;
      Exit;
    end;
  end;
  FMoving := False;
end;

procedure TGradientEdit.Paint;

  procedure DrawBackground;
  var
    GradientRect: TRectF;
  begin
    GradientRect := RectF(colorPickSize, 0, Width - colorPickSize, Height - colorPickSize);
    MakeChessBoardBrush(Canvas.Fill.Bitmap, 10);
    Canvas.Fill.Kind := TBrushKind.bkBitmap;
    Canvas.FillRect(GradientRect, 0, 0, AllCorners, AbsoluteOpacity);
  end;

  procedure DrawGradient;
  var
    GradientRect: TRectF;
  begin
    GradientRect := RectF(colorPickSize, 0, Width - colorPickSize, Height - colorPickSize);

    Canvas.Stroke.Kind := TBrushKind.bkNone;
    Canvas.Fill.Kind := TBrushKind.bkGradient;
    Canvas.Fill.Gradient.Assign(FGradient);
    Canvas.Fill.Gradient.Style := TGradientStyle.gsLinear;
    Canvas.Fill.Gradient.StartPosition.SetPointNoChange(TPointF.Create(0, 0));
    Canvas.Fill.Gradient.StopPosition.SetPointNoChange(TPointF.Create(1, 0));

    Canvas.FillRect(GradientRect, 0, 0, AllCorners, AbsoluteOpacity);
  end;

  procedure DrawPoints;
  var
    I: Integer;
    PointRect: TRectF;
  begin
    Canvas.Fill.Kind := TBrushKind.bkSolid;
    Canvas.Stroke.Kind := TBrushKind.bkSolid;
    Canvas.StrokeThickness := 1;
    for I := 0 to FGradient.Points.Count - 1 do
    begin
      if FCurrentPointInvisible and (I = CurrentPoint) then
        Continue;
      PointRect := GetPointRect(I);
      InflateRect(PointRect, -1, -1);
      Canvas.Stroke.Color := $FF757575;
      Canvas.Fill.Color := FGradient.Points[I].IntColor;
      Canvas.FillEllipse(PointRect, AbsoluteOpacity);
      Canvas.DrawEllipse(PointRect, AbsoluteOpacity);
      if CurrentPoint = I then
      begin
        InflateRect(PointRect, 1, 1);
        Canvas.Stroke.Color := TAlphaColorRec.White;
        Canvas.DrawEllipse(PointRect, AbsoluteOpacity);
      end;
    end;
  end;

begin
  DrawBackground;
  DrawGradient;
  DrawPoints;
end;

procedure TGradientEdit.SetGradient(const Value: TGradient);
begin
  FGradient.Assign(Value);
end;

procedure TGradientEdit.DoChanged(Sender: TObject);
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
  UpdateGradient;
end;

procedure TGradientEdit.SetCurrentPoint(const Value: Integer);
begin
  if FCurrentPoint <> Value then
  begin
    FCurrentPoint := Value;
    if Assigned(OnSelectPoint) then
      OnSelectPoint(Self);
    if Assigned(FColorPicker) and (CurrentPoint >= 0) then
      FColorPicker.Color := Gradient.Points[CurrentPoint].IntColor;
  end;
end;

procedure TGradientEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FColorPicker) then
    ColorPicker := nil;
end;

procedure TGradientEdit.SetColorPicker(const Value: TColorPicker);
begin
  FColorPicker := Value;
  if Assigned(FColorPicker) and (CurrentPoint >= 0) then
    FColorPicker.Color := Gradient.Points[CurrentPoint].IntColor;
end;

procedure TGradientEdit.UpdateGradient;
begin
  if Assigned(FColorPicker) and (CurrentPoint >= 0) then
    FColorPicker.Color := Gradient.Points[CurrentPoint].IntColor;
end;

{ TColorPanel }

constructor TColorPanel.Create(AOwner: TComponent);
begin
  inherited;
  FUseAlpha := True;
  Width := 150;
  Height := 150;
  FAlphaTrack := TAlphaTrackBar.Create(Self);
  FAlphaTrack.Parent := Self;
  FAlphaTrack.Align := TAlignLayout.alBottom;
  FAlphaTrack.Stored := False;
  FAlphaTrack.Name := 'AlphaTrack';
  FAlphaTrack.Locked := True;
  FAlphaTrack.Margins.Rect := RectF(0, 0, 15, 0);
  FAlphaTrack.Height := 15;
  FAlphaTrack.DisableFocusEffect := True;
  FAlphaTrack.OnChange := DoAlphaChange;

  FHueTrack := THueTrackBar.Create(Self);
  FHueTrack.Parent := Self;
  FHueTrack.Align := TAlignLayout.alRight;
  FHueTrack.Stored := False;
  FHueTrack.Locked := True;
  FHueTrack.Name := 'HueTrack';
  FHueTrack.Margins.Rect := RectF(0, 0, 0, 0);
  FHueTrack.Orientation := TOrientation.orVertical;
  FHueTrack.Width := 15;
  FHueTrack.DisableFocusEffect := True;
  FHueTrack.OnChange := DoHueChange;

  FColorQuad := TColorQuad.Create(Self);
  FColorQuad.Parent := Self;
  FColorQuad.Align := TAlignLayout.alClient;
  FColorQuad.Name := 'ColorQuad';
  FColorQuad.Stored := False;
  FColorQuad.Locked := True;
  FColorQuad.Margins.Rect := RectF(5, 5, 3, 3);
  FColorQuad.OnChange := DoQuadChange;

  Color := TAlphaColors.White;
  SetAcceptsControls(False);
end;

destructor TColorPanel.Destroy;
begin
  inherited;
end;

function TColorPanel.CanObserve(const ID: Integer): Boolean;
begin
  Result := False;
  if ID = TObserverMapping.EditLinkID then
    Result := True;
  if ID = TObserverMapping.ControlValueID then
    Result := True;
end;

procedure TColorPanel.DoAlphaChange(Sender: TObject);
begin
  FColorQuad.Alpha := FAlphaTrack.Value;
end;

procedure TColorPanel.DoHueChange(Sender: TObject);
begin
  FColorQuad.Hue := FHueTrack.Value;
end;

procedure TColorPanel.DoQuadChange(Sender: TObject);
begin
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
  begin
    if TLinkObservers.EditLinkIsReadOnly(Observers) then
      Exit;
    if Assigned(FColorBox) then
      FColorBox.Color := Color;
    if Assigned(OnChange) then
      OnChange(Self);
    if TLinkObservers.EditLinkEdit(Observers) then
      TLinkObservers.EditLinkModified(Observers)
    else
    begin
      TLinkObservers.EditLinkReset(Observers);
      Exit;
    end;
    TLinkObservers.EditLinkUpdate(Observers);
  end
  else
  begin
    if Assigned(FColorBox) then
      FColorBox.Color := Color;
    if Assigned(OnChange) then
      OnChange(Self);
  end;
  if Observers.IsObserving(TObserverMapping.ControlValueID) then
  begin
    TLinkObservers.ControlValueModified(Observers);
    TLinkObservers.ControlValueUpdate(Observers);
  end;
end;

function TColorPanel.GetColor: TAlphaColor;
begin
  Result := MakeColor(HSLtoRGB(FColorQuad.Hue, FColorQuad.Sat, FColorQuad.Lum),
    FColorQuad.Alpha);
end;

function TColorPanel.GetData: TValue;
begin
  Result := TValue.From<TAlphaColor>(Color);
end;

function TColorPanel.GetObservers: TObservers;
begin
  if Assigned(Owner) and FOwnerObserves then
    Result := Owner.Observers
  else
    Result := inherited;
end;

procedure TColorPanel.Loaded;
begin
  inherited;
  Color := Color;
end;

procedure TColorPanel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FColorBox) then
    ColorBox := nil;
end;

procedure TColorPanel.OwnerObserves;
begin
  FOwnerObserves := True;
end;

procedure TColorPanel.SetColor(const Value: TAlphaColor);
var
  SavedOnQuadChange : TNotifyEvent;
  SavedOnHueChange : TNotifyEvent;
  SavedOnAlphaChange : TNotifyEvent;
  SaveOnChange: TNotifyEvent;

  procedure StoreChangeEvents;
  begin
    SaveOnChange := FOnChange;
    SavedOnQuadChange := FColorQuad.OnChange;
    SavedOnHueChange := FHueTrack.OnChange;
    SavedOnAlphaChange := FAlphaTrack.OnChange;
  end;

  procedure ResetChangeEvents;
  begin
    FOnChange := nil;
    FColorQuad.OnChange := nil;
    FHueTrack.OnChange := nil;
    FAlphaTrack.OnChange := nil;
  end;

  procedure RestoreChangeEvents;
  begin
    FOnChange := SaveOnChange;
    FColorQuad.OnChange := SavedOnQuadChange;
    FHueTrack.OnChange := SavedOnHueChange;
    FAlphaTrack.OnChange := SavedOnAlphaChange;
  end;

  procedure FillControls(AColor: TAlphaColor);
  var
    H, S, L: Single;
  begin
    RGBtoHSL(AColor, H, S, L);
    FColorQuad.Lum := L;
    FColorQuad.Sat := S;
    FColorQuad.Hue := H;
    FColorQuad.Alpha := TAlphaColorRec(AColor).A / $FF;
    FHueTrack.Value := H;
    FAlphaTrack.Value := TAlphaColorRec(AColor).A / $FF;
  end;

begin
  if Value <> Color then
  begin
    StoreChangeEvents;
    try
      ResetChangeEvents;
      FillControls(Value);

      if not (csLoading in ComponentState) then
        DoQuadChange(Self);
    finally
      RestoreChangeEvents;
    end;
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TColorPanel.SetColorBox(const Value: TColorBox);
begin
  if FColorBox <> Value then
  begin
    FColorBox := Value;
    if Assigned(FColorBox) then
      FColorBox.Color := Color;
  end;
end;

procedure TColorPanel.SetUseAlpha(const Value: Boolean);
begin
  if FUseAlpha <> Value then
  begin
    FUseAlpha := Value;
    FAlphaTrack.Visible := FUseAlpha;
  end;
end;

{ TComboColorBox }

constructor TComboColorBox.Create(AOwner: TComponent);
begin
  inherited;
  Width := 60;
  Height := 22;
  CanFocus := True;
  AutoCapture := True;
  FPopup := TPopup.Create(Self);
  FPopup.StyleLookup := 'combopopupstyle';
  FPopup.PlacementTarget := Self;
  FPopup.StaysOpen := False;
  FPopup.Stored := False;
  FPopup.Parent := Self;
  FPopup.Locked := True;
  FPopup.DragWithParent := True;
//  FPopup.DesignVisible := True;  RAID 283593
  FPopup.DesignVisible:= False;
  FPopup.Width := 240;
  FPopup.Height := 160;
  FPopup.Padding.Rect := RectF(5, 5, 5, 5);
  FColorBox := TColorBox.Create(nil);
  FColorBox.Width := 50;
  FColorBox.Parent := FPopup;
  FColorBox.Stored := False;
  FColorBox.Align := TAlignLayout.alRight;
  FColorBox.Margins.Rect := RectF(15, 70, 15, 30);
  FColorText := TEdit.Create(Self);
  FColorText.Parent := FPopup;
  FColorText.Stored := False;
  FColorText.Locked := True;
  FColorText.FilterChar := '#0123456789abcdefABCDEF';
  FColorText.BoundsRect := RectF(160, 20, 160 + 70, 20 + 22);
//  FColorText.Anchors := [TAnchorKind.akTop, TAnchorKind.akRight];
  FColorText.DisableFocusEffect := True;
  FColorText.OnChange := DoTextChange;
  FColorPanel := TColorPanel.Create(Self);
  FColorPanel.Parent := FPopup;
  FColorPanel.Stored := False;
  FColorPanel.DisableFocusEffect := True;
  FColorPanel.Align := TAlignLayout.alClient;
  FColorPanel.OnChange := DoColorChange;
  FColorPanel.OwnerObserves;
  FColorPanel.ColorBox := FColorBox;
  SetAcceptsControls(False);
end;

destructor TComboColorBox.Destroy;
begin
  if Assigned(FColorPanel) then
    FreeAndNil(FColorPanel);
  if Assigned(FColorText) then
    FreeAndNil(FColorText);
  if Assigned(FColorBox) then
    FreeAndNil(FColorBox);
  if Assigned(FPopup) then
    FreeAndNil(FPopup);
  inherited;
end;

function TComboColorBox.GetData: TValue;
begin
  Result := TValue.From<TAlphaColor>(Color);
end;

procedure TComboColorBox.SetData(const Value: TValue);
begin
  if Value.IsType<TNotifyEvent> then
    OnChange := Value.AsType<TNotifyEvent>()
  else if Value.IsType<TAlphaColor> then
    Color := Value.AsType<TAlphaColor>
  else
    Color := StringToAlphaColor(Value.ToString);
end;

procedure TComboColorBox.DoTextChange(Sender: TObject);
var
  C: TAlphaColor;
begin
  C := TAlphaColorRec.White;
  try
    C := Color;
    Color := StringToAlphaColor(FColorText.Text);
  except
    Color := C;
  end;
end;

procedure TComboColorBox.DoColorChange(Sender: TObject);
begin
  FColorText.Text := AlphaColorToString(Color);
  Repaint;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TComboColorBox.DropDown;
begin
  if not FPopup.IsOpen then
  begin
    FPopup.Placement := FPlacement;
    FPopup.IsOpen := True;
  end
  else
    FPopup.IsOpen := False;
end;

procedure TComboColorBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if (Button = TMouseButton.mbLeft) then
    DropDown;
end;

function TComboColorBox.CanObserve(const ID: Integer): Boolean;
begin
  Result := False;
  if ID = TObserverMapping.EditLinkID then
    Result := True;
  if ID = TObserverMapping.ControlValueID then
    Result := True;
end;

procedure TComboColorBox.ChangeParent;
begin
  inherited;
end;

function TComboColorBox.GetValue: TAlphaColor;
begin
  Result := FColorPanel.Color
end;

procedure TComboColorBox.SetValue(const Value: TAlphaColor);
begin
  FColorPanel.Color := Value;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TComboColorBox.ApplyStyle;
var
  T: TFmxObject;
begin
  inherited;
  T := FindStyleResource('Content');
  if Assigned(T) and (T is TControl) then
    TControl(T).OnPaint := DoContentPaint;
end;

procedure TComboColorBox.DoContentPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  R: TRectF;
  State: TCanvasSaveState;
  i, j: Integer;
begin
  R := ARect;
  R.Inflate(-0.5 - 2, -0.5 - 2);
  R.Offset(0.5, 0.5);
  { draw back }
  State := Canvas.SaveState;
  try
    Canvas.IntersectClipRect(R);
    Canvas.Stroke.Kind := TBrushKind.bkNone;
    Canvas.Fill.Kind := TBrushKind.bkSolid;
    Canvas.Fill.Color := $FFFFFFFF;
    Canvas.FillRect(R, 0, 0, AllCorners, AbsoluteOpacity);
    Canvas.Fill.Color := $FFD3D3D3;
    for i := 0 to Trunc(RectWidth(R) / 5) + 1 do
      for j := 0 to Trunc(RectHeight(R) / 5) + 1 do
      begin
        if odd(i + j) then
        begin
          Canvas.FillRect(RectF(i * 5, j * 5, (i + 1) * 5, (j + 1) * 5), 0, 0,
            AllCorners, AbsoluteOpacity);
        end;
      end;
    { color }
    Canvas.Fill.Kind := TBrushKind.bkSolid;
    Canvas.Fill.Color := Color;
    Canvas.FillRect(R, 0, 0, AllCorners, AbsoluteOpacity);
    Canvas.Stroke.Color := TAlphaColors.Black;
    Canvas.Stroke.Kind := TBrushKind.bkSolid;
    Canvas.DrawRect(R, 0, 0, AllCorners, AbsoluteOpacity);
  finally
    Canvas.RestoreState(State);
  end;
end;

function TComboColorBox.GetUseAlpha: Boolean;
begin
  Result := FColorPanel.UseAlpha;
end;

procedure TComboColorBox.SetUseAlpha(const Value: Boolean);
begin
  FColorPanel.UseAlpha := Value;
end;

function TComboColorBox.GetDefaultStyleLookupName: string;
begin
  Result := 'comboboxstyle';
end;

{ TColorButton }

constructor TColorButton.Create(AOwner: TComponent);
begin
  inherited;
  AutoTranslate := False;
  FColor := $FF000000;
end;

destructor TColorButton.Destroy;
begin
  inherited;
end;

procedure TColorButton.ApplyStyle;
var
  O: TFmxObject;
begin
  inherited;
  O := FindStyleResource('fill');
  if Assigned(O) and (O is TShape) then
  begin
    FFill := TShape(O);
    FFill.Fill.Color := FColor;
  end;
end;

procedure TColorButton.FreeStyle;
begin
  inherited;
  FFill := nil;
end;

procedure TColorButton.SetColor(const Value: TAlphaColor);
begin
  FColor := Value;
  if Assigned(FFill) then
    FFill.Fill.Color := FColor;
  if not(csLoading in ComponentState) then
    if Assigned(FOnChange) then
      FOnChange(Self);
end;

function SwapColor(const C: TAlphaColor): TAlphaColor;
begin
  Result := C;
  TAlphaColorRec(Result).R := TAlphaColorRec(C).B;
  TAlphaColorRec(Result).B := TAlphaColorRec(C).R;
end;


type
  THackListBox = class(TListBox);

const

  Colors: array [0 .. 147] of TIdentMapEntry = ((Value: Integer($FFF0F8FF); Name: 'Aliceblue'), (Value: Integer($FFFAEBD7);
    Name: 'Antiquewhite'), (Value: Integer($FF00FFFF); Name: 'Aqua'), (Value: Integer($FF7FFFD4); Name: 'Aquamarine'),
    (Value: Integer($FFF0FFFF); Name: 'Azure'), (Value: Integer($FFF5F5DC); Name: 'Beige'), (Value: Integer($FFFFE4C4); Name: 'Bisque'),
    (Value: Integer($FF000000); Name: 'Black';), (Value: Integer($FFFFEBCD); Name: 'Blanchedalmond'), (Value: Integer($FF0000FF);
    Name: 'Blue'), (Value: Integer($FF8A2BE2); Name: 'Blueviolet'), (Value: Integer($FFA52A2A); Name: 'Brown'), (Value: Integer($FFDEB887);
    Name: 'Burlywood'), (Value: Integer($FF5F9EA0); Name: 'Cadetblue'), (Value: Integer($FF7FFF00); Name: 'Chartreuse'),
    (Value: Integer($FFD2691E); Name: 'Chocolate'), (Value: Integer($FFFF7F50); Name: 'Coral'), (Value: Integer($FF6495ED);
    Name: 'Cornflowerblue'), (Value: Integer($FFFFF8DC); Name: 'Cornsilk'), (Value: Integer($FFDC143C); Name: 'Crimson'),
    (Value: Integer($FF00FFFF); Name: 'Cyan'), (Value: Integer($FF00008B); Name: 'Darkblue'), (Value: Integer($FF008B8B); Name: 'Darkcyan'),
    (Value: Integer($FFB8860B); Name: 'Darkgoldenrod'), (Value: Integer($FFA9A9A9); Name: 'Darkgray'), (Value: Integer($FF006400);
    Name: 'Darkgreen'), (Value: Integer($FFA9A9A9); Name: 'Darkgrey'), (Value: Integer($FFBDB76B); Name: 'Darkkhaki'),
    (Value: Integer($FF8B008B); Name: 'Darkmagenta'), (Value: Integer($FF556B2F); Name: 'Darkolivegreen'), (Value: Integer($FFFF8C00);
    Name: 'Darkorange'), (Value: Integer($FF9932CC); Name: 'Darkorchid'), (Value: Integer($FF8B0000); Name: 'Darkred'),
    (Value: Integer($FFE9967A); Name: 'Darksalmon'), (Value: Integer($FF8FBC8F); Name: 'Darkseagreen'), (Value: Integer($FF483D8B);
    Name: 'Darkslateblue'), (Value: Integer($FF2F4F4F); Name: 'Darkslategray'), (Value: Integer($FF2F4F4F); Name: 'Darkslategrey'),
    (Value: Integer($FF00CED1); Name: 'Darkturquoise'), (Value: Integer($FF9400D3); Name: 'Darkviolet'), (Value: Integer($FFFF1493);
    Name: 'Deeppink'), (Value: Integer($FF00BFFF); Name: 'Deepskyblue'), (Value: Integer($FF696969); Name: 'Dimgray'),
    (Value: Integer($FF696969); Name: 'Dimgrey'), (Value: Integer($FF1E90FF); Name: 'Dodgerblue'), (Value: Integer($FFB22222);
    Name: 'Firebrick'), (Value: Integer($FFFFFAF0); Name: 'Floralwhite'), (Value: Integer($FF228B22); Name: 'Forestgreen'),
    (Value: Integer($FFFF00FF); Name: 'Fuchsia'), (Value: Integer($FFDCDCDC); Name: 'Gainsboro'), (Value: Integer($FFF8F8FF);
    Name: 'Ghostwhite'), (Value: Integer($FFFFD700); Name: 'Gold'), (Value: Integer($FFDAA520); Name: 'Goldenrod'),
    (Value: Integer($FF808080); Name: 'Gray'), (Value: Integer($FF008000); Name: 'Green'), (Value: Integer($FFADFF2F); Name: 'Greenyellow'),
    (Value: Integer($FF808080); Name: 'Grey'), (Value: Integer($FFF0FFF0); Name: 'Honeydew'), (Value: Integer($FFFF69B4); Name: 'Hotpink'),
    (Value: Integer($FFCD5C5C); Name: 'Indianred'), (Value: Integer($FF4B0082); Name: 'Indigo'), (Value: Integer($FFFFFFF0); Name: 'Ivory'),
    (Value: Integer($FFF0E68C); Name: 'Khaki'), (Value: Integer($FFE6E6FA); Name: 'Lavender'), (Value: Integer($FFFFF0F5);
    Name: 'Lavenderblush'), (Value: Integer($FF7CFC00); Name: 'Lawngreen'), (Value: Integer($FFFFFACD); Name: 'Lemonchiffon'),
    (Value: Integer($FFADD8E6); Name: 'Lightblue'), (Value: Integer($FFF08080); Name: 'Lightcoral'), (Value: Integer($FFE0FFFF);
    Name: 'Lightcyan'), (Value: Integer($FFFAFAD2); Name: 'Lightgoldenrodyellow'), (Value: Integer($FFD3D3D3); Name: 'Lightgray'),
    (Value: Integer($FF90EE90); Name: 'Lightgreen'), (Value: Integer($FFD3D3D3); Name: 'Lightgrey'), (Value: Integer($FFFFB6C1);
    Name: 'Lightpink'), (Value: Integer($FFFFA07A); Name: 'Lightsalmon'), (Value: Integer($FF20B2AA); Name: 'Lightseagreen'),
    (Value: Integer($FF87CEFA); Name: 'Lightskyblue'), (Value: Integer($FF778899); Name: 'Lightslategray'), (Value: Integer($FF778899);
    Name: 'Lightslategrey'), (Value: Integer($FFB0C4DE); Name: 'Lightsteelblue'), (Value: Integer($FFFFFFE0); Name: 'Lightyellow'),
    (Value: Integer($FF00FF00); Name: 'Lime'), (Value: Integer($FF32CD32); Name: 'Limegreen'), (Value: Integer($FFFAF0E6); Name: 'Linen'),
    (Value: Integer($FFFF00FF); Name: 'Magenta'), (Value: Integer($FF800000); Name: 'Maroon'), (Value: Integer($FF66CDAA);
    Name: 'Mediumaquamarine'), (Value: Integer($FF0000CD); Name: 'Mediumblue'), (Value: Integer($FFBA55D3); Name: 'Mediumorchid'),
    (Value: Integer($FF9370DB); Name: 'Mediumpurple'), (Value: Integer($FF3CB371); Name: 'Mediumseagreen'), (Value: Integer($FF7B68EE);
    Name: 'Mediumslateblue'), (Value: Integer($FF00FA9A); Name: 'Mediumspringgreen'), (Value: Integer($FF48D1CC);
    Name: 'Mediumturquoise'), (Value: Integer($FFC71585); Name: 'Mediumvioletred'), (Value: Integer($FF191970);
    Name: 'Midnightblue'), (Value: Integer($FFF5FFFA); Name: 'Mintcream'), (Value: Integer($FFFFE4E1); Name: 'Mistyrose'),
    (Value: Integer($FFFFE4B5); Name: 'Moccasin'), (Value: Integer($FFFFDEAD); Name: 'Navajowhite'), (Value: Integer($FF000080);
    Name: 'Navy'), (Value: Integer($FFFDF5E6); Name: 'Oldlace'), (Value: Integer($FF808000); Name: 'Olive'), (Value: Integer($FF6B8E23);
    Name: 'Olivedrab'), (Value: Integer($FFFFA500); Name: 'Orange'), (Value: Integer($FFFF4500); Name: 'Orangered'),
    (Value: Integer($FFDA70D6); Name: 'Orchid'), (Value: Integer($FFEEE8AA); Name: 'Palegoldenrod'), (Value: Integer($FF98FB98);
    Name: 'Palegreen'), (Value: Integer($FFAFEEEE); Name: 'Paleturquoise'), (Value: Integer($FFDB7093); Name: 'Palevioletred'),
    (Value: Integer($FFFFEFD5); Name: 'Papayawhip'), (Value: Integer($FFFFDAB9); Name: 'Peachpuff'), (Value: Integer($FFCD853F);
    Name: 'Peru'), (Value: Integer($FFFFC0CB); Name: 'Pink'), (Value: Integer($FFDDA0DD); Name: 'Plum'), (Value: Integer($FFB0E0E6);
    Name: 'Powderblue'), (Value: Integer($FF800080); Name: 'Purple'), (Value: Integer($FFFF0000); Name: 'Red'), (Value: Integer($FFBC8F8F);
    Name: 'Rosybrown'), (Value: Integer($FF4169E1); Name: 'Royalblue'), (Value: Integer($FF8B4513); Name: 'Saddlebrown'),
    (Value: Integer($FFFA8072); Name: 'Salmon'), (Value: Integer($FFF4A460); Name: 'Sandybrown'), (Value: Integer($FF2E8B57);
    Name: 'Seagreen'), (Value: Integer($FFFFF5EE); Name: 'Seashell'), (Value: Integer($FFA0522D); Name: 'Sienna'),
    (Value: Integer($FFC0C0C0); Name: 'Silver'), (Value: Integer($FF87CEEB); Name: 'Skyblue'), (Value: Integer($FF6A5ACD);
    Name: 'Slateblue'), (Value: Integer($FF708090); Name: 'Slategray'), (Value: Integer($FF708090); Name: 'Slategrey'),
    (Value: Integer($FFFFFAFA); Name: 'Snow'), (Value: Integer($FF00FF7F); Name: 'Springgreen'), (Value: Integer($FF4682B4);
    Name: 'Steelblue'), (Value: Integer($FFD2B48C); Name: 'Tan'), (Value: Integer($FF008080); Name: 'Teal'), (Value: Integer($FFD8BFD8);
    Name: 'Thistle'), (Value: Integer($FFFF6347); Name: 'Tomato'), (Value: Integer($FF40E0D0); Name: 'Turquoise'),
    (Value: Integer($FFEE82EE); Name: 'Violet'), (Value: Integer($FFF5DEB3); Name: 'Wheat'), (Value: Integer($FFFFFFFF); Name: 'White'),
    (Value: Integer($FFF5F5F5); Name: 'Whitesmoke'), (Value: Integer($FFFFFF00); Name: 'Yellow'),
    (Value: Integer($FF9ACD32); Name: 'Yellowgreen'),
    (Value: Integer($0); Name: 'Null'));

{ TColorListBox }

constructor TColorListBox.Create(AOwner: TComponent);
begin
  inherited;
  RebuildList;
  SetAcceptsControls(False);
end;

destructor TColorListBox.Destroy;
begin
  inherited;
end;

procedure TColorListBox.RebuildList;
var
  i, SaveIndex: Integer;
  Item: TListBoxItem;
begin
  if FUpdating > 0 then Exit;
  if csDestroying in ComponentState then Exit;

  BeginUpdate;
  SaveIndex := ItemIndex;
  FItemIndex := -1;
  Clear;
  for i := 0 to High(Colors) do
  begin
    Item := TListBoxItem.Create(nil);
    Item.Parent := Self;
    Item.Stored := False;
    Item.Locked := True;
    Item.Text := Colors[i].Name;
    Item.Tag := i;
    Item.StyleLookup := 'colorlistboxitemstyle';
    Item.OnApplyStyleLookup := DoItemApplyStyleLookup;
  end;
  EndUpdate;
  FItemIndex := SaveIndex;
end;

procedure TColorListBox.SetColor(const Value: TAlphaColor);
var
  i: Integer;
begin
  for i := 0 to High(Colors) do
    if TAlphaColor(Colors[i].Value) = Value then
    begin
      ItemIndex := i;
      Break;
    end;
end;

procedure TColorListBox.SetData(const Value: TValue);
begin
  if Value.IsType<TNotifyEvent> then
    OnChange := Value.AsType<TNotifyEvent>()
  else if Value.IsType<TAlphaColor> then
    Color := Value.AsType<TAlphaColor>
  else
    Color := StringToAlphaColor(Value.ToString);
end;

procedure TColorListBox.SetItems(const Value: TStrings);
begin
  RebuildList;
end;

procedure TColorListBox.DoItemApplyStyleLookup(Sender: TObject);
var
  ColorObj: TFmxObject;
begin
  ColorObj := TListBoxItem(Sender).FindStyleResource('color');
  if ColorObj is TShape then
    TShape(ColorObj).Fill.Color := TAlphaColor(Colors[TListBoxItem(Sender).Tag].Value);
end;

function TColorListBox.GetColor: TAlphaColor;
begin
  if (0 <= ItemIndex) and (ItemIndex < Count) then
    Result := TAlphaColor(Colors[ItemIndex].Value)
  else
    Result := TAlphaColorRec.Null;
end;

function TColorListBox.GetData: TValue;
begin
  Result := TValue.From<TAlphaColor>(Color);
end;

function TColorListBox.GetDefaultStyleLookupName: string;
begin
  Result := 'listboxstyle';
end;

{ TColorComboBox }

constructor TColorComboBox.Create(AOwner: TComponent);
var
  DefaultValueService: IFMXDefaultPropertyValueService;
  LDropDownKind: TValue;
begin
  inherited;

  LDropDownKind := TValue.Empty;
  if SupportsPlatformService(IFMXDefaultPropertyValueService, IInterface(DefaultValueService)) then
    LDropDownKind := DefaultValueService.GetDefaultPropertyValue(Self.ClassName,
      'dropdownkind');

  if not LDropDownKind.IsEmpty then
    DropDownKind := LDropDownKind.AsType<TDropDownKind>
  else
    DropDownKind := TDropDownKind.ddkCustom;

  RebuildList;
  SetAcceptsControls(False);
end;

destructor TColorComboBox.Destroy;
begin
  inherited;
end;

procedure TColorComboBox.RebuildList;
var
  i, SaveIndex: Integer;
  Item: TListBoxItem;
begin
  if FUpdating > 0 then Exit;
  if csDestroying in ComponentState then Exit;

  BeginUpdate;
  SaveIndex := FListbox.ItemIndex;
  THackListBox(FListbox).FItemIndex := -1;
  Clear;
  for i := 0 to High(Colors) do
  begin
    Item := TListBoxItem.Create(nil);
    Item.Parent := Self;
    Item.Stored := False;
    Item.Locked := True;
    Item.Text := Colors[i].Name;
    Item.Tag := i;
    Item.StyleLookup := 'colorlistboxitemstyle';
    Item.OnApplyStyleLookup := DoItemApplyStyleLookup;
  end;
  EndUpdate;
  THackListBox(FListbox).FItemIndex := SaveIndex;
end;

procedure TColorComboBox.SetColor(const Value: TAlphaColor);
var
  i: Integer;
begin
  for i := 0 to High(Colors) do
    if TAlphaColor(Colors[i].Value) = Value then
    begin
      ItemIndex := i;
      Break;
    end;
end;

procedure TColorComboBox.SetData(const Value: TValue);
begin
  if Value.IsType<TNotifyEvent> then
    OnChange := Value.AsType<TNotifyEvent>()
  else if Value.IsType<TAlphaColor> then
    Color := Value.AsType<TAlphaColor>
  else
    Color := StringToAlphaColor(Value.ToString);
end;

procedure TColorComboBox.DoItemApplyStyleLookup(Sender: TObject);
var
  ColorObj: TFmxObject;
begin
  ColorObj := TListBoxItem(Sender).FindStyleResource('color');
  if ColorObj is TShape then
  begin
    TShape(ColorObj).Fill.Color := TAlphaColor(Colors[TListBoxItem(Sender).Tag].Value);
  end;
end;

function TColorComboBox.GetColor: TAlphaColor;
begin
  if (0 <= ItemIndex) and (ItemIndex < Count) then
    Result := TAlphaColor(Colors[ItemIndex].Value)
  else
    Result := TAlphaColors.Null;
end;

function TColorComboBox.GetData: TValue;
begin
  Result := TValue.From<TAlphaColor>(Color);
end;

function TColorComboBox.GetDefaultStyleLookupName: string;
begin
  Result := 'comboboxstyle';
end;

initialization
  RegisterFmxClasses([THueTrackBar, TAlphaTrackBar, TBWTrackBar,
    TColorQuad, TColorPicker, TGradientEdit, TColorBox, TColorPanel,
    TComboColorBox, TColorButton, TColorComboBox, TColorListBox]);
end.
