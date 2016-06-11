{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Colors;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Types, System.Rtti, System.UITypes, FMX.Objects, FMX.Types, FMX.StdCtrls,
  FMX.Edit, FMX.ListBox, FMX.Controls, FMX.Pickers, FMX.Graphics;

const
  ColorPickSize = 10;

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
    property Size;
    property TabOrder;
    property TabStop;
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
    property Size;
    property TabOrder;
    property TabStop;
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
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
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
    property Size;
    property TabOrder;
    property TabStop;
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
    property Size;
    property TabOrder;
    property TabStop;
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
    property Size;
    property TabOrder;
    property TabStop;
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
    procedure CalcSize;
  protected
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure ApplyStyle; override;
    function CanObserve(const ID: Integer): Boolean; override;
    function GetDefaultStyleLookupName: string; override;
    procedure DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure ParentChanged; override;
    procedure DoColorChange(Sender: TObject); virtual;
    procedure DoTextChange(Sender: TObject); virtual;
    /// <summary>Validating input text color</summary>
    procedure DoValidating(Sender: TObject; var Text: string); virtual;
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
    property Size;
    property StyleLookup;
    property TabOrder;
    property TabStop;
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
    property ControlType;
    property Cursor default crDefault;
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
    property Size;
    property StyleLookup;
    property TabOrder;
    property TabStop;
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

  TColorListBox = class(TCustomListBox)
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
    property Color: TAlphaColor read GetColor write SetColor default TAlphaColorRec.Null;
    property Align;
    property AllowDrag;
    property AlternatingRowBackground;
    property Anchors;
    property CanFocus;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DisableFocusEffect default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default True;
    property ItemIndex;
    property ItemHeight;
    property ItemWidth;
    property DefaultItemStyles;
    property GroupingKind;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property StyleLookup;
    property TabOrder;
    property TabStop;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    property OnChange;
    {Drag and Drop events}
    property OnDragChange;
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
    property OnItemClick;

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

{ TCustomColorComboBox }

  TCustomColorComboBox = class(TCustomComboBox)
  private
    procedure SetColor(const Value: TAlphaColor);
    function GetColor: TAlphaColor;
    procedure DoItemApplyStyleLookup(Sender: TObject);
    procedure ReadItemsStrings(Reader: TReader);
  protected
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure RebuildList;
    procedure DefineProperties(Filer: TFiler); override;
    function GetDefaultStyleLookupName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property DropDownKind nodefault;
    property Color: TAlphaColor read GetColor write SetColor;
  end;

  TColorComboBox = class(TCustomColorComboBox)
  public
    property PlacementRectangle;
  published
    property Color;
    { inherited }
    property Align;
    property Anchors;
    property CanFocus;
    property CanParentFocus;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DisableFocusEffect default True;
    property DragMode;
    property DropDownCount;
    property DropDownKind nodefault;
    property EnableDragHighlight;
    property Enabled;
    property Locked;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest;
    property ItemIndex default -1;
    property ItemWidth;
    property ItemHeight;
    property ListBoxResource;
    property Padding;
    property Opacity;
    property Margins;
    property Placement default TPlacement.Bottom;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property StyleLookup;
    property TabOrder;
    property TabStop;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    {events}
    property OnApplyStyleLookup;
    property OnChange;
    property OnClosePopup;
    property OnPopup;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnKeyDown;
    property OnKeyUp;
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

procedure MakeChessBoardBrush(ABrushBitmap: TBrushBitmap; const AChessStep: Single);

implementation

uses
  System.UIConsts, System.Variants, System.SysUtils, System.Math, System.Character, FMX.Platform, FMX.Forms;

type
  TOpenEdit = class (TCustomEdit)
  end;

procedure MakeChessBoardBrush(ABrushBitmap: TBrushBitmap; const AChessStep: Single);
var
  BitmapTmp: TBitmap;
begin
  BitmapTmp := ABrushBitmap.Bitmap;
  BitmapTmp.SetSize(Trunc(2 * AChessStep), Trunc(2 * AChessStep));
  BitmapTmp.Clear(TAlphaColorRec.White);
  BitmapTmp.ClearRect(RectF(0, 0, AChessStep, AChessStep), TAlphaColorRec.Lightgray);
  BitmapTmp.ClearRect(RectF(AChessStep, AChessStep, 2 * AChessStep, 2 * AChessStep), TAlphaColorRec.Lightgray);
  ABrushBitmap.WrapMode := TWrapMode.Tile;
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
  I, J: Integer;
  M: TBitmapData;
begin
  if FBitmap.Map(TMapAccess.Write, M) then
  try
    for J := 0 to FBitmap.Height - 1 do
      for I := 0 to FBitmap.Width - 1 do
        if Orientation = TOrientation.Horizontal then
          M.SetPixel(I, J, (HSLtoRGB(I / FBitmap.Width, 0.9, 0.5)))
        else
          M.SetPixel(I, J, (HSLtoRGB(J / FBitmap.Height, 0.9, 0.5)));
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
  I, J: Integer;
  M: TBitmapData;
begin
  if FBitmap.Map(TMapAccess.Write, M) then
  try
    for J := 0 to FBitmap.Height - 1 do
    begin
      for I := 0 to FBitmap.Width - 1 do
      begin
        if odd(I div 3) and not odd(J div 3) then
          M.SetPixel(I, J, $FFA0A0A0)
        else if not odd(I div 3) and odd(J div 3) then
          M.SetPixel(I, J, $FFA0A0A0)
        else
          M.SetPixel(I, J, $FFFFFFFF)
      end;
    end;
  finally
    FBitmap.Unmap(M);
  end;
  if FBitmap.Canvas.BeginScene then
  try
    FBitmap.Canvas.Fill.Kind := TBrushKind.Gradient;
    FBitmap.Canvas.Fill.Gradient.Points[0].Color := $00FFFFFF;
    FBitmap.Canvas.Fill.Gradient.Points[1].Color := $FFFFFFFF;
    if Orientation = TOrientation.Horizontal then
      FBitmap.Canvas.Fill.Gradient.StopPosition.Point := PointF(1, 0)
    else
      FBitmap.Canvas.Fill.Gradient.StopPosition.Point := PointF(0, 1);
    FBitmap.Canvas.FillRect(RectF(0, 0, FBitmap.Width, FBitmap.Height), 0, 0, [], 1);
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
  I, J: Integer;
  A: Byte;
  M: TBitmapData;
begin
  if FBitmap.Map(TMapAccess.Write, M) then
  try
    for J := 0 to FBitmap.Height - 1 do
    begin
      for I := 0 to FBitmap.Width - 1 do
      begin
        if Orientation = TOrientation.Horizontal then
          A := Round((I / FBitmap.Width) * $FF)
        else
          A := Round((J / FBitmap.Height) * $FF);
        M.SetPixel(I, J, MakeColor(A, A, A))
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
    Canvas.Fill.Kind := TBrushKind.Bitmap;
    Canvas.FillRect(LocalRect, 0, 0, AllCorners, AbsoluteOpacity);

    Canvas.Fill.Kind := TBrushKind.Solid;
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
  FreeAndNil(FColorBitmap);
  inherited;
end;

function TColorQuad.GetAbsoluteRect: TRectF;
begin
  Result := inherited GetAbsoluteRect;
  InflateRect(Result, ColorPickSize + 1, ColorPickSize + 1);
end;

function TColorQuad.GetIsTracking: Boolean;
begin
  Result := Pressed;
end;

function TColorQuad.PointInObjectLocal(X, Y: Single): Boolean;
begin
  Result := False;
  if (X > -ColorPickSize / 2) and (X < Width + ColorPickSize / 2) and
    (Y > -ColorPickSize / 2) and (Y < Height + ColorPickSize / 2) then
  begin
    Result := True;
  end;
end;

procedure TColorQuad.PreviewColor(const ValHue, ValLum, ValSat, ValAlpha: Single);
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
    FreeAndNil(FColorBitmap);
    if FColorBox <> nil then
      FColorBox.Color := HSLtoRGB(FHue, FSat, FLum) and $FFFFFF or (Round(FAlpha * $FF) shl 24);
    Repaint;
  end;
end;

procedure TColorQuad.MouseMove(Shift: TShiftState; X, Y: Single);
var
  LLum, LSat: Single;
begin
  inherited;
  if Pressed then
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
  I, J: Integer;
  R: TRectF;
  H, S, L: Single;
  M: TBitmapData;
begin
  H := Hue;
  S := Sat;
  L := Lum;

  if FColorBitmap = nil then
  begin
    FColorBitmap := TBitmap.Create(Trunc(Width), Trunc(Height));
    if FColorBitmap <> nil then
    begin
      if FColorBitmap.Map(TMapAccess.Write, M) then
      try
        for I := 0 to FColorBitmap.Width - 1 do
          for J := 0 to FColorBitmap.Height - 1 do
            M.SetPixel(I, J, HSLtoRGB(H, I / FColorBitmap.Width, (1 - (J / FColorBitmap.Height))));
      finally
        FColorBitmap.Unmap(M);
      end;
    end;
  end;
  if FColorBitmap <> nil then
    Canvas.DrawBitmap(FColorBitmap, RectF(0, 0, FColorBitmap.Width, FColorBitmap.Height), RectF(0, 0, Width, Height),
      AbsoluteOpacity);
  { current }

  R := RectF(S * (Width), (1 - L) * (Height), S * (Width), (1 - L) * (Height));

  InflateRect(R, ColorPickSize / 2, ColorPickSize / 2);
  Canvas.Stroke.Kind := TBrushKind.Solid;
  Canvas.StrokeThickness := 1;
  Canvas.Stroke.Color := $FF000000;
  Canvas.DrawEllipse(R, AbsoluteOpacity);
  InflateRect(R, -1, -1);
  Canvas.Stroke.Color := $FFFFFFFF;
  Canvas.DrawEllipse(R, AbsoluteOpacity);
  InflateRect(R, -1, -1);
  Canvas.Fill.Kind := TBrushKind.Solid;
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
    if FColorBox <> nil then
      FColorBox.Color := HSLtoRGB(Hue, Sat, Lum) and $FFFFFF or (Round(Alpha * $FF) shl 24);
    if not Pressed and Assigned(FOnChange) then
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
    FreeAndNil(FColorBitmap);
    if FColorBox <> nil then
      FColorBox.Color := HSLtoRGB(Hue, Sat, Lum) and $FFFFFF or (Round(Alpha * $FF) shl 24);
    if not Pressed and Assigned(FOnChange) then
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
    if FColorBox <> nil then
      FColorBox.Color := HSLtoRGB(Hue, Sat, Lum) and $FFFFFF or (Round(Alpha * $FF) shl 24);
    if not Pressed and Assigned(FOnChange) then
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
    if FColorBox <> nil then
      FColorBox.Color := HSLtoRGB(Hue, Sat, Lum) and $FFFFFF or (Round(Alpha * $FF) shl 24);
    if not Pressed and Assigned(FOnChange) then
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

  FreeAndNil(FColorBitmap);
  if FColorBox <> nil then
    FColorBox.Color := HSLtoRGB(Hue, Sat, Lum) and $FFFFFF or (Round(Alpha * $FF) shl 24);
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
    if (FColorBox <> nil) and (not Pressed) then
      FColorBox.Color := HSLtoRGB(Hue, Sat, Lum) and $FFFFFF or (Round(Alpha * $FF) shl 24);
  end;
end;

{ TColorPicker }

constructor TColorPicker.Create(AOwner: TComponent);
begin
  inherited;
  AutoCapture := True;
  SetAcceptsControls(False);
end;

destructor TColorPicker.Destroy;
begin
  if FHueBitmap <> nil then
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
  InflateRect(Result, 0, ColorPickSize / 2);
end;

function TColorPicker.PointInObjectLocal(X, Y: Single): Boolean;
begin
  Result := False;
  if (X > 0) and (X < Width) and (Y > -ColorPickSize / 2) and (Y < Height + ColorPickSize / 2) then
    Result := True;
end;

procedure TColorPicker.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if Pressed then
    if Height <> 0 then
      Hue := ((Y) / (Height));
end;

procedure TColorPicker.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if Pressed then
    MouseMove([ssLeft], X, Y);
  inherited;
end;

procedure TColorPicker.Paint;
var
  I, J: Integer;
  R: TRectF;
  M: TBitmapData;
begin
  if FHueBitmap = nil then
  begin
    FHueBitmap := TBitmap.Create(Trunc(Width), Trunc(Height));
    if FHueBitmap <> nil then
    begin
      if FHueBitmap.Map(TMapAccess.Write, M) then
      try
        for J := 0 to FHueBitmap.Height - 1 do
          for I := 0 to FHueBitmap.Width - 1 do
            M.SetPixel(I, J, HSLtoRGB(J / FHueBitmap.Height, 0.9, 0.5));
      finally
        FHueBitmap.Unmap(M);
      end;
    end;
  end;

  if FHueBitmap <> nil then
    Canvas.DrawBitmap(FHueBitmap, RectF(0, 0, FHueBitmap.Width, FHueBitmap.Height), RectF(0, 0, Width, Height),
      AbsoluteOpacity);

  { hue pos }
  R := RectF(Width / 2, FHue * (Height), Width / 2, FHue * (Height));
  InflateRect(R, ColorPickSize / 2, ColorPickSize / 2);
  // OffsetRect(R, 01, StrokeThickness);
  Canvas.Stroke.Kind := TBrushKind.Solid;
  Canvas.StrokeThickness := 1;
  Canvas.Stroke.Color := $FF000000;
  Canvas.DrawEllipse(R, AbsoluteOpacity);
  InflateRect(R, -1, -1);
  Canvas.Stroke.Color := $FFFFFFFF;
  Canvas.DrawEllipse(R, AbsoluteOpacity);
  InflateRect(R, -1, -1);
  Canvas.Fill.Kind := TBrushKind.Solid;
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
  if FColorQuad <> nil then
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
    if FColorQuad <> nil then
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
  FreeAndNil(FBitmap);
  FreeAndNil(FGradient);
  inherited;
end;

function TGradientEdit.GetPointRect(const Point: Integer): TRectF;
begin
  if (Point >= 0) and (Point < FGradient.Points.Count) then
  begin
    Result := RectF(0 + ColorPickSize + (FGradient.Points[Point].Offset * (Width - ((0 + ColorPickSize) * 2))),
      Height - 0 - ColorPickSize, 0 + ColorPickSize + (FGradient.Points[Point].Offset * (Width - ((0 + ColorPickSize) *
      2))), Height - 0);
    InflateRect(Result, ColorPickSize / 2, 0);
  end
  else
    Result := RectF(0, 0, 0, 0);
end;

procedure TGradientEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  NewOffset: Single;
  NewColor: TAlphaColor;
  I: Integer;
  NewGradientPoint: TGradientPoint;
begin
  inherited;
  FMoving := False;
  if Button = TMouseButton.mbLeft then
  begin
    { select point }
    for I := 0 to FGradient.Points.Count - 1 do
      if GetPointRect(I).Contains(PointF(X, Y)) then
      begin
        CurrentPoint := I;
        if Assigned(OnSelectPoint) then
          OnSelectPoint(Self);
        FMoving := True;
        Repaint;
        Exit;
      end;
    { add new point }
    if (Y > 0) and (Y < Height - 0 - ColorPickSize) then
    begin
      NewOffset := ((X - 0 - ColorPickSize) /
        (Width - ((0 + ColorPickSize) * 2)));
      if NewOffset < 0 then
        NewOffset := 0;
      if NewOffset > 1 then
        NewOffset := 1;
      NewColor := FGradient.InterpolateColor(NewOffset);
      for I := 1 to FGradient.Points.Count - 1 do
        if NewOffset < FGradient.Points[I].Offset then
        begin
          NewGradientPoint := TGradientPoint(FGradient.Points.Add);
          NewGradientPoint.Index := I;
          CurrentPoint := I;
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
      FCurrentPointInvisible := ((Y < -10) or (Y > Height + 10)) and (FGradient.Points.Count > 1) and
        (CurrentPoint <> 0) and (CurrentPoint <> FGradient.Points.Count - 1);
      { move }
      FGradient.Points[CurrentPoint].Offset := ((X - 0 - ColorPickSize) / (Width - ((0 + ColorPickSize) * 2)));
      if FGradient.Points[CurrentPoint].Offset < 0 then
        FGradient.Points[CurrentPoint].Offset := 0;
      if FGradient.Points[CurrentPoint].Offset > 1 then
        FGradient.Points[CurrentPoint].Offset := 1;
      { move right }
      if CurrentPoint < FGradient.Points.Count - 1 then
        if FGradient.Points[CurrentPoint].Offset > FGradient.Points[CurrentPoint + 1].Offset then
        begin
          FGradient.Points[CurrentPoint].Index := FGradient.Points[CurrentPoint].Index + 1;
          CurrentPoint := CurrentPoint + 1;
        end;
      { move left }
      if CurrentPoint > 0 then
        if FGradient.Points[CurrentPoint].Offset < FGradient.Points[CurrentPoint - 1].Offset then
        begin
          FGradient.Points[CurrentPoint].Index := FGradient.Points[CurrentPoint].Index - 1;
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
    GradientRect := RectF(ColorPickSize, 0, Width - ColorPickSize, Height - ColorPickSize);
    MakeChessBoardBrush(Canvas.Fill.Bitmap, 10);
    Canvas.Fill.Kind := TBrushKind.Bitmap;
    Canvas.FillRect(GradientRect, 0, 0, AllCorners, AbsoluteOpacity);
  end;

  procedure DrawGradient;
  var
    GradientRect: TRectF;
  begin
    GradientRect := RectF(ColorPickSize, 0, Width - ColorPickSize, Height - ColorPickSize);

    Canvas.Stroke.Kind := TBrushKind.None;
    Canvas.Fill.Kind := TBrushKind.Gradient;
    Canvas.Fill.Gradient.Assign(FGradient);
    Canvas.Fill.Gradient.Style := TGradientStyle.Linear;
    Canvas.Fill.Gradient.StartPosition.SetPointNoChange(TPointF.Zero);
    Canvas.Fill.Gradient.StopPosition.SetPointNoChange(TPointF.Create(1, 0));

    Canvas.FillRect(GradientRect, 0, 0, AllCorners, AbsoluteOpacity);
  end;

  procedure DrawPoints;
  var
    I: Integer;
    PointRect: TRectF;
  begin
    Canvas.Fill.Kind := TBrushKind.Solid;
    Canvas.Stroke.Kind := TBrushKind.Solid;
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
    if (FColorPicker <> nil) and (CurrentPoint >= 0) then
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
  if (FColorPicker <> nil) and (CurrentPoint >= 0) then
    FColorPicker.Color := Gradient.Points[CurrentPoint].IntColor;
end;

procedure TGradientEdit.UpdateGradient;
begin
  if (FColorPicker <> nil) and (CurrentPoint >= 0) then
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
  FAlphaTrack.Align := TAlignLayout.Bottom;
  FAlphaTrack.Stored := False;
  FAlphaTrack.Name := 'AlphaTrack';
  FAlphaTrack.Locked := True;
  FAlphaTrack.Margins.Rect := RectF(0, 0, 15, 0);
  FAlphaTrack.Height := 15;
  FAlphaTrack.DisableFocusEffect := True;
  FAlphaTrack.OnChange := DoAlphaChange;

  FHueTrack := THueTrackBar.Create(Self);
  FHueTrack.Parent := Self;
  FHueTrack.Align := TAlignLayout.Right;
  FHueTrack.Stored := False;
  FHueTrack.Locked := True;
  FHueTrack.Name := 'HueTrack';
  FHueTrack.Margins.Rect := RectF(0, 0, 0, 0);
  FHueTrack.Orientation := TOrientation.Vertical;
  FHueTrack.Width := 15;
  FHueTrack.DisableFocusEffect := True;
  FHueTrack.OnChange := DoHueChange;

  FColorQuad := TColorQuad.Create(Self);
  FColorQuad.Parent := Self;
  FColorQuad.Align := TAlignLayout.Client;
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
    if FColorBox <> nil then
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
    if FColorBox <> nil then
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
  Result := MakeColor(HSLtoRGB(FColorQuad.Hue, FColorQuad.Sat, FColorQuad.Lum), FColorQuad.Alpha);
end;

function TColorPanel.GetData: TValue;
begin
  Result := TValue.From<TAlphaColor>(Color);
end;

function TColorPanel.GetObservers: TObservers;
begin
  if (Owner <> nil) and FOwnerObserves then
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
    if FColorBox <> nil then
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
  FPopup.Stored := False;
  FPopup.Parent := Self;
  FPopup.Locked := True;
  FPopup.DragWithParent := True;
  FPopup.Width := 240;
  FPopup.Height := 160;
  FPopup.Padding.Rect := RectF(5, 5, 5, 5);
  FColorBox := TColorBox.Create(nil);
  FColorBox.Width := 50;
  FColorBox.Parent := FPopup;
  FColorBox.Stored := False;
  FColorBox.Align := TAlignLayout.HorzCenter;
  FColorBox.Margins.Rect := RectF(15, 60, 15, 40);
  FColorText := TEdit.Create(Self);
  FColorText.Parent := FPopup;
  FColorText.Stored := False;
  FColorText.Locked := True;
  FColorText.BoundsRect := RectF(164, 20, 164 + 70, 20 + 22);
  FColorText.DisableFocusEffect := True;
  FColorText.OnValidating := DoValidating;
  FColorText.OnChange := DoTextChange;
  FColorPanel := TColorPanel.Create(Self);
  FColorPanel.Parent := FPopup;
  FColorPanel.Stored := False;
  FColorPanel.DisableFocusEffect := True;
  FColorPanel.Align := TAlignLayout.Left;
  FColorPanel.Width := 156;
  FColorPanel.OnChange := DoColorChange;
  FColorPanel.OwnerObserves;
  FColorPanel.ColorBox := FColorBox;
  SetAcceptsControls(False);
end;

destructor TComboColorBox.Destroy;
begin
  FreeAndNil(FColorPanel);
  FreeAndNil(FColorText);
  FreeAndNil(FColorBox);
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

procedure TComboColorBox.DoValidating(Sender: TObject; var Text: string);
const
  FilterChars = '#0123456789abcdef';
var
  I: Integer;
  NewColor: Integer;
begin
  if not IdentToAlphaColor(Text, NewColor) and not IdentToAlphaColor('cla' + Text, NewColor) then
  begin
    I := 0;
    while I < Text.Length do
    begin
      if not FilterChars.Contains(Text.Chars[I].ToLower) then
        Text := Text.Replace(Text.Chars[I], '', [rfReplaceAll, rfIgnoreCase])
      else 
        Inc(I);
    end;
  end;
end;

procedure TComboColorBox.CalcSize;
var
  W, DW, LWidth: Single;
begin
  TCanvasManager.MeasureCanvas.Font.Assign(FColorText.ResultingTextSettings.Font);
  DW := FColorText.Width - FColorText.TextContentRect.Width;
  W := Max(FColorText.Width, Ceil(TCanvasManager.MeasureCanvas.TextWidth('#DDDDDDDD') + DW));
  FColorText.Width := W;
  LWidth := Max(FPopup.Width, FColorText.Position.X + W + 8);
  if LWidth > Width then
    FPopup.PopupFormSize := TSizeF.Create(LWidth, 0);
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
    if Pressed or DoubleClick then
      FPopup.PreferedDisplayIndex := Screen.DisplayFromPoint(Screen.MousePos).Index
    else
      FPopup.PreferedDisplayIndex := -1;
    FPopup.Placement := FPlacement;
    FPopup.ApplyStyleLookup;
    FColorText.ApplyStyleLookup;
    CalcSize;
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

procedure TComboColorBox.ParentChanged;
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
  StyledControl: TControl;
begin
  inherited;
  if FindStyleResource<TControl>('Content', StyledControl) then
    StyledControl.OnPaint := DoContentPaint;
end;

procedure TComboColorBox.DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
var
  R: TRectF;
  State: TCanvasSaveState;
  I, J: Integer;
begin
  R := ARect;
  R.Inflate(-0.5 - 2, -0.5 - 2);
  R.Offset(0.5, 0.5);
  { draw back }
  State := Canvas.SaveState;
  try
    Canvas.IntersectClipRect(R);
    Canvas.Stroke.Kind := TBrushKind.None;
    Canvas.Fill.Kind := TBrushKind.Solid;
    Canvas.Fill.Color := $FFFFFFFF;
    Canvas.FillRect(R, 0, 0, AllCorners, AbsoluteOpacity);
    Canvas.Fill.Color := $FFD3D3D3;
    for I := 0 to Trunc(RectWidth(R) / 5) + 1 do
      for J := 0 to Trunc(RectHeight(R) / 5) + 1 do
        if Odd(I + J) then
          Canvas.FillRect(RectF(I * 5, J * 5, (I + 1) * 5, (J + 1) * 5), 0, 0, AllCorners, AbsoluteOpacity);
    { color }
    Canvas.Fill.Kind := TBrushKind.Solid;
    Canvas.Fill.Color := Color;
    Canvas.FillRect(R, 0, 0, AllCorners, AbsoluteOpacity);
    Canvas.Stroke.Color := TAlphaColors.Black;
    Canvas.Stroke.Kind := TBrushKind.Solid;
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
begin
  inherited;
  if FindStyleResource<TShape>('fill', FFill) then
    FFill.Fill.Color := FColor;
end;

procedure TColorButton.FreeStyle;
begin
  inherited;
  FFill := nil;
end;

procedure TColorButton.SetColor(const Value: TAlphaColor);
begin
  FColor := Value;
  if FFill <> nil then
    FFill.Fill.Color := FColor;
  if not (csLoading in ComponentState) and Assigned(FOnChange) then
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

type
  TAlphaColorMapEntry = record
    Value: TAlphaColor;
    Name: string;
  end;

  TRTLColors = class
  strict private
    FColors: array of TAlphaColorMapEntry;
    procedure GetAlphaColorValuesProc(const AColorName: string);
    function GetColor(AIndex : Integer) : TAlphaColorMapEntry;
  public
    constructor Create;
    function Count : Integer;
    property Color[Index : Integer] : TAlphaColorMapEntry read GetColor;
  end;

function TRTLColors.GetColor(AIndex: Integer): TAlphaColorMapEntry;
begin
  Result := FColors[AIndex];
end;

function TRTLColors.Count: Integer;
begin
  Result := Length(FColors);
end;

constructor TRTLColors.Create;
begin
  GetAlphaColorValues(GetAlphaColorValuesProc);
end;

procedure TRTLColors.GetAlphaColorValuesProc(const AColorName: string);
var
  LNewIndex : Integer;
begin
  LNewIndex := Count;
  SetLength(FColors, LNewIndex + 1);
  FColors[LNewIndex].Name := AColorName;
  FColors[LNewIndex].Value := StringToAlphaColor(AColorName);
end;

var
  ColorsMap : TRTLColors;

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
  I, SaveIndex: Integer;
  Item: TListBoxItem;
begin
  if (FUpdating > 0) or (csDestroying in ComponentState) then
    Exit;

  BeginUpdate;
  SaveIndex := ItemIndex;
  Clear;
  for I := 0 to ColorsMap.Count - 1 do
  begin
    Item := TListBoxItem.Create(nil);
    Item.Parent := Self;
    Item.Width := Item.DefaultSize.Width;
    Item.Height := Item.DefaultSize.Height;
    Item.Stored := False;
    Item.Locked := True;
    Item.Text := ColorsMap.Color[I].Name;
    Item.Tag := I;
    Item.StyleLookup := 'colorlistboxitemstyle';
    Item.OnApplyStyleLookup := DoItemApplyStyleLookup;
  end;
  SelectionController.SetCurrent(SaveIndex);
  EndUpdate;
end;

procedure TColorListBox.SetColor(const Value: TAlphaColor);
var
  I: Integer;
begin
  if Value = TAlphaColorRec.Null then
    ItemIndex := -1
  else
    for I := 0 to ColorsMap.Count - 1 do
      if ColorsMap.Color[I].Value = Value then
      begin
        ItemIndex := I;
        Break;
      end;
end;

function TColorListBox.GetColor: TAlphaColor;
begin
  if (ItemIndex >= 0) and (ItemIndex < Count) then
    Result := ColorsMap.Color[ItemIndex].Value
  else
    Result := TAlphaColorRec.Null;
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

procedure TColorListBox.DoItemApplyStyleLookup(Sender: TObject);
var
  ColorObj: TShape;
begin
  if TListBoxItem(Sender).FindStyleResource<TShape>('color', ColorObj) then
    ColorObj.Fill.Color := ColorsMap.Color[TListBoxItem(Sender).Tag].Value;
end;

function TColorListBox.GetData: TValue;
begin
  Result := TValue.From<TAlphaColor>(Color);
end;

function TColorListBox.GetDefaultStyleLookupName: string;
begin
  Result := 'listboxstyle';
end;

{ TCustomColorComboBox }

constructor TCustomColorComboBox.Create(AOwner: TComponent);
var
  DefaultValueService: IFMXDefaultPropertyValueService;
  LDropDownKind: TValue;
begin
  inherited;

  LDropDownKind := TValue.Empty;
  if SupportsPlatformService(IFMXDefaultPropertyValueService, DefaultValueService) then
    LDropDownKind := DefaultValueService.GetDefaultPropertyValue(Self.ClassName, 'dropdownkind');

  if not LDropDownKind.IsEmpty then
    DropDownKind := LDropDownKind.AsType<TDropDownKind>
  else
    DropDownKind := TDropDownKind.Custom;

  RebuildList;
  SetAcceptsControls(False);
end;

procedure TCustomColorComboBox.ReadItemsStrings(Reader: TReader);
begin
  Reader.SkipValue;
end;

procedure TCustomColorComboBox.RebuildList;
var
  I, SaveIndex: Integer;
  Item: TListBoxItem;
begin
  if (FUpdating > 0) or (csDestroying in ComponentState) then
    Exit;

  BeginUpdate;
  try
    SaveIndex := Listbox.ItemIndex;
    Listbox.ItemIndex := -1;
    Clear;
    for I := 0 to ColorsMap.Count - 1 do
    begin
      Item := TListBoxItem.Create(nil);
      Item.Parent := Self;
      Item.Stored := False;
      Item.Locked := True;
      Item.Text := ColorsMap.Color[I].Name;
      Item.Tag := I;
      Item.StyleLookup := 'colorlistboxitemstyle';
      Item.OnApplyStyleLookup := DoItemApplyStyleLookup;
    end;
  finally
    EndUpdate;
  end;
  Listbox.ItemIndex := SaveIndex;
end;

procedure TCustomColorComboBox.SetColor(const Value: TAlphaColor);
var
  I: Integer;
begin
  for I := 0 to ColorsMap.Count - 1 do
    if ColorsMap.Color[I].Value = Value then
    begin
      ItemIndex := I;
      Break;
    end;
end;

procedure TCustomColorComboBox.SetData(const Value: TValue);
begin
  if Value.IsType<TNotifyEvent> then
    OnChange := Value.AsType<TNotifyEvent>()
  else if Value.IsType<TAlphaColor> then
    Color := Value.AsType<TAlphaColor>
  else
    Color := StringToAlphaColor(Value.ToString);
end;

procedure TCustomColorComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Items.Strings', ReadItemsStrings, nil, False);
end;

procedure TCustomColorComboBox.DoItemApplyStyleLookup(Sender: TObject);
var
  ColorObj: TShape;
begin
  if TListBoxItem(Sender).FindStyleResource<TShape>('color', ColorObj) then
    ColorObj.Fill.Color := ColorsMap.Color[TListBoxItem(Sender).Tag].Value;
end;

function TCustomColorComboBox.GetColor: TAlphaColor;
begin
  if (0 <= ItemIndex) and (ItemIndex < Count) then
    Result := ColorsMap.Color[ItemIndex].Value
  else
    Result := TAlphaColors.Null;
end;

function TCustomColorComboBox.GetData: TValue;
begin
  Result := TValue.From<TAlphaColor>(Color);
end;

function TCustomColorComboBox.GetDefaultStyleLookupName: string;
begin
  Result := 'comboboxstyle';
end;

procedure InitColorsMap;
begin
  ColorsMap := TRTLColors.Create;
end;

procedure DestroyColorsMap;
begin
  FreeAndNil(ColorsMap);
end;

initialization
  InitColorsMap;
  RegisterFmxClasses([THueTrackBar, TAlphaTrackBar, TBWTrackBar, TColorQuad, TColorPicker, TGradientEdit, TColorBox,
    TColorPanel, TComboColorBox, TColorButton, TColorComboBox, TColorListBox]);
finalization
  DestroyColorsMap;
end.
