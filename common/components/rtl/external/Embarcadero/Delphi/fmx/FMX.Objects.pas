{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Objects;

{$H+}

interface

uses
  System.Classes, System.Types, System.Rtti, System.UITypes, System.UIConsts,
  FMX.Types, FMX.Controls, FMX.TextLayout, FMX.Text, FMX.Messages, FMX.Platform;

{$SCOPEDENUMS ON}

type

{ TShape }

  TShape = class(TControl)
  private
    FFill: TBrush;
    FStroke: TStrokeBrush;
    procedure SetFill(const Value: TBrush);
    procedure SetStroke(const Value: TStrokeBrush);
    procedure SetStrokeCap(const Value: TStrokeCap);
    procedure SetStrokeDash(const Value: TStrokeDash);
    procedure SetStrokeJoin(const Value: TStrokeJoin);
    procedure SetStrokeThickness(const Value: Single);
  protected
    procedure Painting; override;
    procedure FillChanged(Sender: TObject); virtual;
    procedure StrokeChanged(Sender: TObject); virtual;
    function GetShapeRect: TRectF;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Fill: TBrush read FFill write SetFill;
    property Stroke: TStrokeBrush read FStroke write SetStroke;
    property ShapeRect: TRectF read GetShapeRect;
    { deprecated - moved to Stroke }
    property StrokeThickness: Single write SetStrokeThickness;
    property StrokeCap: TStrokeCap write SetStrokeCap;
    property StrokeDash: TStrokeDash write SetStrokeDash;
    property StrokeJoin: TStrokeJoin write SetStrokeJoin;
  end;

{ TLine }

  TLineType = (ltDiagonal, ltTop, ltLeft);

  TLine = class(TShape)
  private
    FLineType: TLineType;
    procedure SetLineType(const Value: TLineType);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
  published
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
    property HitTest default True;
    property LineType: TLineType read FLineType write SetLineType;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Stroke;
    property Visible default True;
    property Width;
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
    { deprecated - moved to Stroke }
    property StrokeThickness stored false;
    property StrokeCap stored false;
    property StrokeDash stored false;
    property StrokeJoin stored false;
  end;

{ TRectangle }

  TRectangle = class(TShape)
  private
    FYRadius: Single;
    FXRadius: Single;
    FCorners: TCorners;
    FCornerType: TCornerType;
    FSides: TSides;
    function IsCornersStored: Boolean;
    function IsSidesStored: Boolean;
  protected
    procedure SetXRadius(const Value: Single); virtual;
    procedure SetYRadius(const Value: Single); virtual;
    procedure SetCorners(const Value: TCorners); virtual;
    procedure SetCornerType(const Value: TCornerType); virtual;
    procedure SetSides(const Value: TSides); virtual;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Corners: TCorners read FCorners write SetCorners
      stored IsCornersStored;
    property CornerType: TCornerType read FCornerType write SetCornerType
      default TCornerType.ctRound;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Fill;
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
    property Sides: TSides read FSides write SetSides stored IsSidesStored;
    { deprecated - moved to Stroke }
    property StrokeThickness stored false;
    property StrokeCap stored false;
    property StrokeDash stored false;
    property StrokeJoin stored false;
    property Stroke;
    property Visible default True;
    property XRadius: Single read FXRadius write SetXRadius;
    property YRadius: Single read FYRadius write SetYRadius;
    property Width;
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

  TCaretRectangle = class (TRectangle, IFlasher)
  private
    FFlashTimer: TTimer;
    [weak]FCaret: TCustomCaret;
    FColor: TAlphaColor;
    FPos: TPointF;
    FSize: TSizeF;
    FInterval: TFlasherInterval;
    FSystemInformation: IFMXSystemInformationService;
    procedure FlashTimerProc(Sender: TObject);
    function GetColor: TAlphaColor;
    function GetPos: TPointF;
    function GetSize: TSizeF;
    function GetVisible: Boolean;
    function GetInterval: TFlasherInterval;
    function GetCaret: TCustomCaret;
    function GetOpacity: Single;
    procedure SetCaret(const Value: TCustomCaret);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function DefaultWidth: Integer; virtual;
    function DefaultColor: TAlphaColor; virtual;
    function UseFontColor: Boolean; virtual;
    function DefaultInterval: TFlasherInterval; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateState;
    property Caret: TCustomCaret read GetCaret write SetCaret;
  end;

{ TRoundRect }

  TRoundRect = class(TShape)
  private
    FCorners: TCorners;
    function IsCornersStored: Boolean;
  protected
    procedure SetCorners(const Value: TCorners); virtual;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Corners: TCorners read FCorners write SetCorners stored IsCornersStored;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Fill;
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
    property Stroke;
    property Visible default True;
    property Width;
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
    { deprecated - moved to Stroke }
    property StrokeThickness stored false;
    property StrokeCap stored false;
    property StrokeDash stored false;
    property StrokeJoin stored false;
  end;

{ TCalloutRectangle }

  TCalloutPosition = (cpTop, cpLeft, cpBottom, cpRight);

  TCalloutRectangle = class(TRectangle)
  private
    FPath: TPathData;
    FCalloutWidth: Single;
    FCalloutLength: Single;
    FCalloutPosition: TCalloutPosition;
    FCalloutOffset: Single;
    procedure SetCalloutWidth(const Value: Single);
    procedure SetCalloutLength(const Value: Single);
    procedure SetCalloutPosition(const Value: TCalloutPosition);
    procedure SetCalloutOffset(const Value: Single);
  protected
    procedure CreatePath;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Fill;
    property CalloutWidth: Single read FCalloutWidth write SetCalloutWidth;
    property CalloutLength: Single read FCalloutLength write SetCalloutLength;
    property CalloutPosition: TCalloutPosition read FCalloutPosition  write SetCalloutPosition
      default TCalloutPosition.cpTop;
    property CalloutOffset: Single read FCalloutOffset write SetCalloutOffset;
    property Stroke;
    { deprecated - moved to Stroke }
    property StrokeThickness stored false;
    property StrokeCap stored false;
    property StrokeDash stored false;
    property StrokeJoin stored false;
  end;

{ TEllipse }

  TEllipse = class(TShape)
  protected
    procedure Paint; override;
  published
    function PointInObjectLocal(X, Y: Single): Boolean; override;
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Fill;
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
    property Stroke;
    property Visible default True;
    property Width;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
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

{ TCircle }

  TCircle = class(TEllipse)
  protected
    procedure Paint; override;
  end;

{ TPie }

  TPie = class(TEllipse)
  private
    FStartAngle: Single;
    FEndAngle: Single;
    procedure SetEndAngle(const Value: Single);
    procedure SetStartAngle(const Value: Single);
  protected
    procedure Paint; override;
  public
    function PointInObject(X, Y: Single): Boolean; override;
    constructor Create(AOwner: TComponent); override;
  published
    property StartAngle: Single read FStartAngle write SetStartAngle;
    property EndAngle: Single read FEndAngle write SetEndAngle;
  end;

{ TArc }

  TArc = class(TEllipse)
  private
    FStartAngle: Single;
    FEndAngle: Single;
    procedure SetEndAngle(const Value: Single);
    procedure SetStartAngle(const Value: Single);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property StartAngle: Single read FStartAngle write SetStartAngle;
    property EndAngle: Single read FEndAngle write SetEndAngle;
  end;

  TPathWrapMode = (pwOriginal, pwFit, pwStretch, pwTile);

{ TCustomPath }

  TCustomPath = class(TShape, IPathObject)
  private
    FData, FCurrent: TPathData;
    FWrapMode: TPathWrapMode;
    procedure SetWrapMode(const Value: TPathWrapMode);
    procedure SetPathData(const Value: TPathData);
    { IPathObject }
    function GetPath: TPathData;
  protected
    procedure DoChanged(Sender: TObject);
    procedure Paint; override;
    procedure Resize; override;
    procedure Loaded; override;
    procedure UpdatePath;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function PointInObject(X, Y: Single): Boolean; override;
    property Data: TPathData read FData write SetPathData;
    property WrapMode: TPathWrapMode read FWrapMode write SetWrapMode default TPathWrapMode.pwStretch;
  end;

{ TPath }

  TPath = class(TCustomPath)
  published
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property Data;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Fill;
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
    property Stroke;
    property StrokeThickness stored false;
    property StrokeCap stored false;
    property StrokeDash stored false;
    property StrokeJoin stored false;
    property Visible default True;
    property Width;
    property WrapMode;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
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

{ TText }

  TText = class(TControl, ITextSettings)
  private
    FTextSettings: TTextSettings;
    FTextSettingsEnabled: TStyledSettings;
    FLayout: TTextLayout;
    FAutoSize: Boolean;
    FStretch: Boolean;
    FIsChanging: Boolean;
    procedure SetText(const Value: string);
    procedure SetFont(const Value: TFont);
    procedure SetHorzTextAlign(const Value: TTextAlign);
    procedure SetVertTextAlign(const Value: TTextAlign);
    procedure SetWordWrap(const Value: Boolean);
    procedure SetAutoSize(const Value: Boolean);
    procedure SetStretch(const Value: Boolean);
    procedure SetColor(const Value: TAlphaColor);
    procedure ReadFillColor(Reader: TReader);
    procedure SetTrimming(const Value: TTextTrimming);
    { ITextSettings }
    function GetDefaultTextSettings: TTextSettings;
    function GetTextSettings: TTextSettings;
    procedure SetTextSettings(const Value: TTextSettings);
    procedure SetStyledSettings(const Value: TStyledSettings);
    function GetStyledSettings: TStyledSettings;
    function GetColor: TAlphaColor;
    function GetFont: TFont;
    function GetHorzTextAlign: TTextAlign;
    function GetTrimming: TTextTrimming;
    function GetVertTextAlign: TTextAlign;
    function GetWordWrap: Boolean;
    function GetText: string;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure FontChanged(Sender: TObject); virtual;
    function SupportsPaintStage(const Stage: TPaintStage): Boolean; override;
    procedure Paint; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure DoRealign; override;
    procedure AdjustSize;
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Anchors;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default False;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property Color: TAlphaColor read GetColor write SetColor;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Font: TFont read GetFont write SetFont;
    property Locked default False;
    property Height;
    property HitTest default True;
    property HorzTextAlign: TTextAlign read GetHorzTextAlign write SetHorzTextAlign
      default TTextAlign.taCenter;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Stretch: Boolean read FStretch write SetStretch default False;
    property Text: string read GetText write SetText;
    property Trimming: TTextTrimming read GetTrimming write SetTrimming default TTextTrimming.ttNone;
    property VertTextAlign: TTextAlign read GetVertTextAlign write SetVertTextAlign
      default TTextAlign.taCenter;
    property Visible default True;
    property Width;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap default True;
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

{ TImageData }

  TImageData = class(TPersistent)
  private
    FBitmap: TBitmap;
    FBitmapHiRes: TBitmap;
    FOnChange: TNotifyEvent;
    procedure SetBitmap(const Value: TBitmap);
    procedure SetBitmapHiRes(const Value: TBitmap);
    procedure DoBitmapChanged(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property BitmapHiRes: TBitmap read FBitmapHiRes write SetBitmapHiRes;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

{ TImage }

  TImageWrapMode = (iwOriginal, iwFit, iwStretch, iwTile, iwCenter);

  TImage = class(TControl, IBitmapObject)
  private
    FData: TValue;
    FBitmap: TBitmap;
    FBitmapHiRes: TBitmap;
    FBitmapMargins: TBounds;
    FWrapMode: TImageWrapMode;
    FDisableInterpolation: Boolean;
    FMarginWrapMode: TImageWrapMode;
    FScaleChangedId: Integer;
    procedure SetBitmap(const Value: TBitmap);
    procedure SetBitmapHiRes(const Value: TBitmap);
    procedure SetWrapMode(const Value: TImageWrapMode);
    procedure SetBitmapMargins(const Value: TBounds);
    procedure SetMarginWrapMode(const Value: TImageWrapMode);
    procedure ScaleChangedHandler(const Sender: TObject; const Msg: TMessage);
    { IBitmapObject }
    function GetBitmap: TBitmap;
  protected
    procedure DoBitmapChanged(Sender: TObject); virtual;
    procedure Paint; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Anchors;
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property BitmapHiRes: TBitmap read FBitmapHiRes write SetBitmapHiRes;
    property BitmapMargins: TBounds read FBitmapMargins write SetBitmapMargins;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DisableInterpolation: Boolean read FDisableInterpolation write FDisableInterpolation default False;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default True;
    property Padding;
    property MarginWrapMode: TImageWrapMode read FMarginWrapMode write SetMarginWrapMode default TImageWrapMode.iwStretch;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Visible default True;
    property Width;
    property WrapMode: TImageWrapMode read FWrapMode write SetWrapMode default TImageWrapMode.iwFit;
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

{ TSubImage }

  TSubImage = class(TControl)
  private
    FSource: TImage;
    FBuffer: TBitmap;
    FBitmapMargins: TBounds;
    FWrapMode: TImageWrapMode;
    FDisableInterpolation: Boolean;
    FSourceRect: TBounds;
    FMarginWrapMode: TImageWrapMode;
    FSourceLookup: string;
    FBitmapScale: single;
    FOpaque: Boolean;
    procedure SetBitmapMargins(const Value: TBounds);
    procedure SetSource(const Value: TImage);
    procedure SetWrapMode(const Value: TImageWrapMode);
    procedure SetSourceRect(const Value: TBounds);
    procedure SetMarginWrapMode(const Value: TImageWrapMode);
    procedure SetSourceLookup(const Value: string);
    procedure ReadBitmapScale(Reader: TReader);
    procedure WriteBitmapScale(Writer: TWriter);
    procedure ReadOpaque(Reader: TReader);
    procedure WriteOpaque(Writer: TWriter);
    procedure SetOpaque(const Value: Boolean);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Paint; override;
    procedure RectChanged(Sender: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure FreeNotification(AObject: TObject); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DrawToCanvas(const Canvas: TCanvas; const ARect: TRectF; const AOpacity: Single = 1.0);
    property BitmapScale: Single write FBitmapScale;
    property Opaque: Boolean read FOpaque write SetOpaque;
  published
    property Align;
    property Anchors;
    property BitmapMargins: TBounds read FBitmapMargins write SetBitmapMargins;
    property DisableInterpolation: Boolean read FDisableInterpolation write FDisableInterpolation default False;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default True;
    property Padding;
    property MarginWrapMode: TImageWrapMode read FMarginWrapMode write SetMarginWrapMode default TImageWrapMode.iwStretch;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Source: TImage read FSource write SetSource;
    property SourceLookup: string read FSourceLookup write SetSourceLookup;
    property SourceRect: TBounds read FSourceRect write SetSourceRect;
    property Scale;
    property Visible default True;
    property Width;
    property WrapMode: TImageWrapMode read FWrapMode write SetWrapMode default TImageWrapMode.iwStretch;
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

{ TPaintBox }

  TPaintEvent = procedure(Sender: TObject; Canvas: TCanvas) of object;

  TPaintBox = class(TControl)
  private
    FOnPaint: TPaintEvent;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
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
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Visible default True;
    property Width;
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
    property OnPaint: TPaintEvent read FOnPaint write FOnPaint;
    property OnResize;
  end;

{ TSelection }

  TSelection = class(TControl)
  private
    FParentBounds: Boolean;
    FOnChange: TNotifyEvent;
    FHideSelection: Boolean;
    FMinSize: Integer;
    FOnTrack: TNotifyEvent;
    FProportional: Boolean;
    FGripSize: Single;
    FRatio: Single;
    FMove, FLeftTop, FLeftBottom, FRightTop, FRightBottom: Boolean;
    FLeftTopHot, FLeftBottomHot, FRightTopHot, FRightBottomHot: Boolean;
    FDownPos, FMovePos: TPointF;
    procedure SetHideSelection(const Value: Boolean);
    procedure SetMinSize(const Value: Integer);
    procedure SetGripSize(const Value: Single);
    procedure DoLeftTopMove( AX, AY: Single) ;
    procedure DoLeftBottomMove( AX, AY: Single) ;
    procedure DoRightTopMove( AX, AY: Single) ;
    procedure DoRightBottomMove( AX, AY: Single) ;
    procedure ReSetInSpace(ARotationPoint, ASize: TPointF) ;
    function  GetProportionalSize(ASize : TPointF) : TPointF ;
  protected
    function GetAbsoluteRect: TRectF; override;
    procedure Paint; override;
  public
    function PointInObjectLocal(X, Y: Single): Boolean; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure DoMouseLeave; override;
  published
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property GripSize: Single read FGripSize write SetGripSize;
    property Locked default False;
    property Height;
    property HideSelection: Boolean read FHideSelection write SetHideSelection;
    property HitTest default True;
    property Padding;
    property MinSize: Integer read FMinSize write SetMinSize default 15;
    property Opacity;
    property Margins;
    property ParentBounds: Boolean read FParentBounds write FParentBounds default True;
    property Proportional: Boolean read FProportional write FProportional;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Visible default True;
    property Width;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
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
    property OnTrack: TNotifyEvent read FOnTrack write FOnTrack;
  end;

{ TSelectionPoint }

  TOnChangeTracking = procedure (Sender: TObject; var X, Y: Single) of object;

  TSelectionPoint = class(TStyledControl)
  private
    FParentBounds: Boolean;
    FGripSize: Single;
    FPressed: Boolean;
    FStylized: Boolean;
    FOnChange: TNotifyEvent;
    FOnChangeTrack: TOnChangeTracking;
    procedure SetGripSize(const Value: Single);
  protected
    procedure Paint; override;
    procedure SetHeight(const Value: Single); override;
    procedure SetWidth(const Value: Single); override;
    function GetUpdateRect: TRectF; override;
    procedure DoMouseEnter; override;
    procedure DoMouseLeave; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure DoChangeTracking(var X, Y: Single);
    procedure DoChange;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function PointInObjectLocal(X, Y: Single): Boolean; override;
  published
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property GripSize: Single read FGripSize write SetGripSize;
    property Locked default False;
    property Height;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property ParentBounds: Boolean read FParentBounds write FParentBounds default True;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
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
    property OnTrack: TOnChangeTracking read FOnChangeTrack write FOnChangeTrack;
  end;

implementation

uses System.SysUtils, System.Math, FMX.Effects, FMX.Forms;

type
  TOpenObject = class (TFmxObject)

  end;

 { TShape }

constructor TShape.Create(AOwner: TComponent);
begin
  inherited;
  FFill := TBrush.Create(TBrushKind.bkSolid, $FFE0E0E0);
  FFill.OnChanged := FillChanged;
  FStroke := TStrokeBrush.Create(TBrushKind.bkSolid, $FF000000);
  FStroke.OnChanged := StrokeChanged;
  SetAcceptsControls(False);
end;

destructor TShape.Destroy;
begin
  FStroke.Free;
  FFill.Free;
  inherited;
end;

function TShape.GetShapeRect: TRectF;
begin
  Result := LocalRect;
  if FStroke.Kind <> TBrushKind.bkNone then
    InflateRect(Result, -(FStroke.Thickness / 2), -(FStroke.Thickness / 2));
end;

procedure TShape.Painting;
begin
  inherited;
  Canvas.Stroke.Assign(FStroke);
end;

procedure TShape.FillChanged(Sender: TObject);
begin
  if FUpdating = 0 then
    Repaint;
end;

procedure TShape.StrokeChanged(Sender: TObject);
begin
  if FUpdating = 0 then
    Repaint;
end;

procedure TShape.SetFill(const Value: TBrush);
begin
  FFill.Assign(Value);
end;

procedure TShape.SetStroke(const Value: TStrokeBrush);
begin
  FStroke.Assign(Value);
end;

{ Deprecated }

procedure TShape.SetStrokeCap(const Value: TStrokeCap);
begin
  FStroke.Cap := Value;
end;

procedure TShape.SetStrokeDash(const Value: TStrokeDash);
begin
  FStroke.Dash := Value;
end;

procedure TShape.SetStrokeJoin(const Value: TStrokeJoin);
begin
  FStroke.Join := Value;
end;

procedure TShape.SetStrokeThickness(const Value: Single);
begin
  FStroke.Thickness := Value;
end;

{ TLine }

constructor TLine.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TLine.Paint;
begin
  case FLineType of
    TLineType.ltTop:
      Canvas.DrawLine(GetShapeRect.TopLeft, PointF(GetShapeRect.Right, GetShapeRect.Top), AbsoluteOpacity, FStroke);
    TLineType.ltLeft:
      Canvas.DrawLine(GetShapeRect.TopLeft, PointF(GetShapeRect.Left, GetShapeRect.Bottom), AbsoluteOpacity, FStroke);
  else
    Canvas.DrawLine(GetShapeRect.TopLeft, GetShapeRect.BottomRight, AbsoluteOpacity, FStroke);
  end;
end;

procedure TLine.SetLineType(const Value: TLineType);
begin
  if FLineType <> Value then
  begin
    FLineType := Value;
    Repaint;
  end;
end;

{ TEllipse }

procedure TEllipse.Paint;
begin
  Canvas.FillEllipse(GetShapeRect, AbsoluteOpacity, FFill);
  Canvas.DrawEllipse(GetShapeRect, AbsoluteOpacity, FStroke);
end;

function TEllipse.PointInObjectLocal(X, Y: Single): Boolean;
begin
  Result := False;
  if Width * Height = 0 then
    Exit;
  if (Sqr((X * 2 - Width) / Width) + Sqr((Y * 2 - Height) / Height) <= 1)
  then
  begin
    Result := True;
  end;
end;

{ TCircle }

procedure TCircle.Paint;
var
  R: TRectF;
begin
  R := RectF(0, 0, Max(Width, Height), Max(Width, Height));
  R.Fit(GetShapeRect);
  Canvas.FillEllipse(R, AbsoluteOpacity, FFill);
  Canvas.DrawEllipse(R, AbsoluteOpacity, FStroke);
end;

{ TPie }

constructor TPie.Create(AOwner: TComponent);
begin
  inherited;
  FStartAngle := 0;
  FEndAngle := -90;
end;

procedure TPie.Paint;
var
  P: TPathData;
begin
  P := TPathData.Create;
  try
    P.MoveTo(PointF(Width / 2, Height / 2));
    P.AddArc(PointF(Width / 2, Height / 2), PointF((Width - Stroke.Thickness) / 2,
      (Height - Stroke.Thickness) / 2), FStartAngle, FEndAngle - FStartAngle);
    P.LineTo(PointF(Width / 2, Height / 2));
    P.ClosePath;
    Canvas.FillPath(P, AbsoluteOpacity, FFill);
    Canvas.DrawPath(P, AbsoluteOpacity, FStroke);
  finally
    if Assigned(P) then
      P.Free;
  end;
end;

function TPie.PointInObject(X, Y: Single): Boolean;
var
  P: TPathData;
begin
  if Assigned(Canvas) then
  begin
    P := TPathData.Create;
    try
      P.MoveTo(PointF(Width / 2, Height / 2));
      P.AddArc(PointF(Width / 2, Height / 2), PointF((Width - Stroke.Thickness) / 2,
        (Height - Stroke.Thickness) / 2), FStartAngle, FEndAngle - FStartAngle);
      P.LineTo(PointF(Width / 2, Height / 2));
      P.ClosePath;
      Result := Canvas.PtInPath(AbsoluteToLocal(PointF(X, Y)), P);
    finally
      P.Free;
    end;
  end
  else
    Result := inherited PointInObject(X, Y);
end;

procedure TPie.SetEndAngle(const Value: Single);
begin
  if FEndAngle <> Value then
  begin
    FEndAngle := Value;
    Repaint;
  end;
end;

procedure TPie.SetStartAngle(const Value: Single);
begin
  if FStartAngle <> Value then
  begin
    FStartAngle := Value;
    Repaint;
  end;
end;

{ TArc }

constructor TArc.Create(AOwner: TComponent);
begin
  inherited;
  Fill.Kind := TBrushKind.bkNone;
  Fill.DefaultKind := TBrushKind.bkNone;
  FStartAngle := 0;
  FEndAngle := -90;
end;

procedure TArc.Paint;
begin
  Canvas.FillArc(PointF(Width / 2, Height / 2),
    PointF((Width - Stroke.Thickness) / 2, ((Height - Stroke.Thickness) / 2)),
    FStartAngle, FEndAngle, AbsoluteOpacity, FFill);
  Canvas.DrawArc(PointF(Width / 2, Height / 2),
    PointF((Width - Stroke.Thickness) / 2, ((Height - Stroke.Thickness) / 2)),
    FStartAngle, FEndAngle, AbsoluteOpacity, FStroke);
end;

procedure TArc.SetEndAngle(const Value: Single);
begin
  if FEndAngle <> Value then
  begin
    FEndAngle := Value;
    Repaint;
  end;
end;

procedure TArc.SetStartAngle(const Value: Single);
begin
  if FStartAngle <> Value then
  begin
    FStartAngle := Value;
    Repaint;
  end;
end;

{ TRectangle }

constructor TRectangle.Create(AOwner: TComponent);
begin
  inherited;
  FCorners := AllCorners;
  FXRadius := 0;
  FYRadius := 0;
  FSides := AllSides;
end;

function TRectangle.IsCornersStored: Boolean;
begin
  Result := FCorners <> AllCorners;
end;

function TRectangle.IsSidesStored: Boolean;
begin
  Result := FSides * AllSides <> AllSides
end;

procedure TRectangle.Paint;
var
  R: TRectF;
  Off: Single;
begin
  R := GetShapeRect;

  if Sides <> AllSides then
  begin
    Off := R.Left;
    if not(TSide.sdTop in FSides) then
      R.Top := R.Top - Off;
    if not(TSide.sdLeft in FSides) then
      R.Left := R.Left - Off;
    if not(TSide.sdBottom in FSides) then
      R.Bottom := R.Bottom + Off;
    if not(TSide.sdRight in FSides) then
      R.Right := R.Right + Off;
    Canvas.FillRect(R, XRadius, YRadius, FCorners, AbsoluteOpacity, FFill, CornerType);
    Canvas.DrawRectSides(GetShapeRect, XRadius, YRadius, FCorners,  AbsoluteOpacity, Sides, FStroke, CornerType);
  end
  else
  begin
    Canvas.FillRect(R, XRadius, YRadius, FCorners, AbsoluteOpacity, FFill, CornerType);
    Canvas.DrawRect(R, XRadius, YRadius, FCorners, AbsoluteOpacity, FStroke, CornerType);
  end;
end;

procedure TRectangle.SetCorners(const Value: TCorners);
begin
  if FCorners <> Value then
  begin
    FCorners := Value;
    Repaint;
  end;
end;

procedure TRectangle.SetCornerType(const Value: TCornerType);
begin
  if FCornerType <> Value then
  begin
    FCornerType := Value;
    Repaint;
  end;
end;

procedure TRectangle.SetXRadius(const Value: Single);
begin
  if FXRadius <> Value then
  begin
    FXRadius := Min(Value, Min(Width / 2, Height / 2));
    Repaint;
  end;
end;

procedure TRectangle.SetYRadius(const Value: Single);
begin
  if FYRadius <> Value then
  begin
    FYRadius := Min(Value, Min(Width / 2, Height / 2));
    Repaint;
  end;
end;

procedure TRectangle.SetSides(const Value: TSides);
begin
  if FSides <> Value then
  begin
    FSides := Value;
    Repaint;
  end;
end;


{ TCaretRectangle }
const
  AnimationCaretStyle = 'caret';

constructor TCaretRectangle.Create(AOwner: TComponent);
begin
  inherited;
  Stroke.Kind := TBrushKind.bkNone;
  FFlashTimer := TTimer.Create(Self);
  FFlashTimer.Enabled := False;
  FFlashTimer.OnTimer := FlashTimerProc;
  FFlashTimer.Stored := False;
  TPlatformServices.Current.SupportsPlatformService(IFMXSystemInformationService, IInterface(FSystemInformation));
  HitTest := False;
end;

function TCaretRectangle.DefaultColor: TAlphaColor;
begin
  if Assigned(FCaret) then
    Result := FCaret.DefaultColor
  else
    Result := TAlphaColorRec.Black;
end;

function TCaretRectangle.DefaultInterval: TFlasherInterval;
begin
  Result := 500;
end;

function TCaretRectangle.DefaultWidth: integer;
begin
  if Assigned(FSystemInformation) then
    Result := FSystemInformation.GetCaretWidth
  else
    Result := 1;
end;

function TCaretRectangle.UseFontColor: Boolean;
begin
  if Assigned(FSystemInformation) and Assigned(FCaret) and (FCaret.DefaultColor <> TAlphaColorRec.Null) then
    Result := False
  else
    Result := True;
end;

destructor TCaretRectangle.Destroy;
begin
  FSystemInformation := nil;
  FreeAndNil(FFlashTimer);
  inherited;
end;

procedure TCaretRectangle.FlashTimerProc(Sender: TObject);
begin
  if Opacity = 1 then
    Opacity := 0
  else
    Opacity := 1;
end;

function TCaretRectangle.GetCaret: TCustomCaret;
begin
  Result := FCaret;
end;

procedure TCaretRectangle.SetCaret(const Value: TCustomCaret);
begin
  if FCaret <> Value then
  begin
    Parent := nil;
    if Assigned(FCaret) and (Assigned(FCaret.Owner)) then
      FCaret.Owner.RemoveFreeNotification(self);
    try
      FCaret := Value;
      if Assigned(FCaret) and (Assigned(FCaret.Owner)) then
        FCaret.Owner.FreeNotification(self);
    except
      FCaret := nil;
      raise;
    end;
  end;
end;

procedure TCaretRectangle.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (Assigned(FCaret)) and (AComponent = FCaret.Owner) then
  begin
    Parent := nil;
    FCaret := nil;
  end;
end;

function TCaretRectangle.GetColor: TAlphaColor;
begin
  Result := FColor;
end;

function TCaretRectangle.GetInterval: TFlasherInterval;
begin
  Result := FInterval;
end;

function TCaretRectangle.GetOpacity: Single;
begin
  Result := inherited Opacity;
end;

function TCaretRectangle.GetPos: TPointF;
begin
  Result := FPos;
end;

function TCaretRectangle.GetSize: TSizeF;
begin
  Result := FSize;
end;

function TCaretRectangle.GetVisible: Boolean;
begin
  Result := inherited Visible;
end;

procedure TCaretRectangle.UpdateState;
var
  LVisible: Boolean;
  LPos: TPointF;
  LSize: TSizeF;
  LColor: TAlphaColor;
  TextSettings: ITextSettings;
begin
  LVisible := Assigned(Caret) and
             (Caret.Visible) and
             (Caret.Displayed) and
             (not Caret.TemporarilyHidden);
  if LVisible then
  begin
    LPos := FCaret.Pos;
    LPos.X := Round(LPos.X);

    FInterval := FCaret.Interval;
    if FInterval = 0 then
      FInterval := DefaultInterval;
    if FInterval <= 0 then
      FInterval := -1;

    LSize := FCaret.Size;
    if LSize.cx < 1 then
      LSize.cx := DefaultWidth;

    LColor := FCaret.Color;
    if (LColor = TAlphaColorRec.Null) and UseFontColor then
    begin
      if Assigned(Caret.Owner) and
        (TOpenObject(Caret.Owner).QueryInterface(ITextSettings, IInterface(TextSettings)) = S_OK) and
        (Assigned(TextSettings.TextSettings)) then
      begin
        if TStyledSetting.ssFontColor in TextSettings.StyledSettings then
          LColor := TextSettings.DefaultTextSettings.FontColor
        else
          LColor := TextSettings.TextSettings.FontColor;
      end;
    end;
    if (LColor = TAlphaColorRec.Null) then
      LColor := DefaultColor;

    if not ((FPos = LPos) and (FSize = LSize)) then
    begin
      FFlashTimer.Enabled := False;
      Visible := False;
      FPos := LPos;
      FSize := LSize;
      Width := FSize.cx;
      Height := FSize.cy;
      Position.Point := FPos;
    end;
    if FColor <> LColor then
    begin
      FColor := LColor;
      Fill.Color := FColor;
    end;
    if Assigned(Caret.Owner) and ([csLoading, csDestroying] * Caret.Owner.ComponentState = []) then
      Parent := Caret.Owner
    else
    begin
      Parent := nil;
      FFlashTimer.Enabled := False;
      inherited Visible := False;
      Exit;
    end;
    if not inherited Visible then
    begin
      Opacity := 1;
      inherited Visible := True;
      BringToFront;
    end;
    FFlashTimer.Enabled := (FInterval > 0) and (inherited Visible);
    if FFlashTimer.Enabled then
      FFlashTimer.Interval := FInterval;
  end
  else
  begin
    FFlashTimer.Enabled := False;
    inherited Visible := False;
  end;
end;

{ TRoundRect }

constructor TRoundRect.Create(AOwner: TComponent);
begin
  inherited;
  FCorners := AllCorners;
end;

function TRoundRect.IsCornersStored: Boolean;
begin
  Result := FCorners <> AllCorners;
end;

procedure TRoundRect.Paint;
var
  Radius: Single;
begin
  if Height < Width then
    Radius := RectHeight(GetShapeRect) / 2
  else
    Radius := RectWidth(GetShapeRect) / 2;
  Canvas.FillRect(GetShapeRect, Radius, Radius, FCorners, AbsoluteOpacity, FFill);
  Canvas.DrawRect(GetShapeRect, Radius, Radius, FCorners, AbsoluteOpacity, FStroke);
end;

procedure TRoundRect.SetCorners(const Value: TCorners);
begin
  if FCorners <> Value then
  begin
    FCorners := Value;
    Repaint;
  end;
end;

{ TCalloutRectangle }

constructor TCalloutRectangle.Create(AOwner: TComponent);
begin
  inherited;
  FCalloutWidth := 23;
  FCalloutLength := 11;
  FPath := TPathData.Create;
end;

destructor TCalloutRectangle.Destroy;
begin
  FreeAndNil(FPath);
  inherited;
end;

procedure TCalloutRectangle.CreatePath;
var
  x1, x2, y1, y2: Single;
  R: TRectF;
  Off: Single;
begin
  R := GetShapeRect;
  case CalloutPosition of
    TCalloutPosition.cpTop:
      R.Top := R.Top + FCalloutLength;
    TCalloutPosition.cpLeft:
      R.Left := R.Left + FCalloutLength;
    TCalloutPosition.cpBottom:
      R.Bottom := R.Bottom - FCalloutLength;
    TCalloutPosition.cpRight:
      R.Right := R.Right - FCalloutLength;
  end;
  if Sides <> AllSides then
  begin
    Off := R.Left;
    if not(TSide.sdTop in FSides) then
      R.Top := R.Top - Off;
    if not(TSide.sdLeft in FSides) then
      R.Left := R.Left - Off;
    if not(TSide.sdBottom in FSides) then
      R.Bottom := R.Bottom + Off;
    if not(TSide.sdRight in FSides) then
      R.Right := R.Right + Off;
  end;
  x1 := XRadius;
  if (RectWidth(R) - (x1 * 2) < 0) and (x1 > 0) then
    x1 := (XRadius * (RectWidth(R) / (x1 * 2)));
  x2 := x1 / 2;
  y1 := YRadius;
  if (RectHeight(R) - (y1 * 2) < 0) and (y1 > 0) then
    y1 := (YRadius * (RectHeight(R) / (y1 * 2)));
  y2 := y1 / 2;
  FPath.Clear;
  FPath.MoveTo(PointF(R.Left, R.Top + y1));
  if TCorner.crTopLeft in FCorners then
  begin
    case FCornerType of
      // ctRound - default
      TCornerType.ctBevel:
        FPath.LineTo(PointF(R.Left + x1, R.Top));
      TCornerType.ctInnerRound:
        FPath.CurveTo(PointF(R.Left + x2, R.Top + y1),
          PointF(R.Left + x1, R.Top + y2), PointF(R.Left + x1, R.Top));
      TCornerType.ctInnerLine:
        begin
          FPath.LineTo(PointF(R.Left + x2, R.Top + y1));
          FPath.LineTo(PointF(R.Left + x1, R.Top + y2));
          FPath.LineTo(PointF(R.Left + x1, R.Top));
        end;
    else
      FPath.CurveTo(PointF(R.Left, R.Top + (y2)), PointF(R.Left + x2, R.Top),
        PointF(R.Left + x1, R.Top))
    end;
  end
  else
  begin
    if TSide.sdLeft in FSides then
      FPath.LineTo(R.TopLeft)
    else
      FPath.MoveTo(R.TopLeft);
    if TSide.sdTop in FSides then
      FPath.LineTo(PointF(R.Left + x1, R.Top))
    else
      FPath.MoveTo(PointF(R.Left + x1, R.Top));
  end;
  if not(TSide.sdTop in FSides) then
    FPath.MoveTo(PointF(R.Right - x1, R.Top))
  else
  begin
    if (FCalloutPosition = TCalloutPosition.cpTop) then
    begin
      if CalloutOffset = 0 then
      begin
        FPath.LineTo(PointF((R.Right - R.Left) / 2 - (CalloutWidth / 2), R.Top));
        FPath.LineTo(PointF((R.Right - R.Left) / 2, R.Top - FCalloutLength));
        FPath.LineTo(PointF((R.Right - R.Left) / 2 + (CalloutWidth / 2), R.Top));
        FPath.LineTo(PointF(R.Right - x1, R.Top));
      end
      else if CalloutOffset > 0 then
      begin
        FPath.LineTo(PointF(R.Left + FCalloutOffset, R.Top));
        FPath.LineTo(PointF(R.Left + FCalloutOffset + (CalloutWidth / 2), R.Top - FCalloutLength));
        FPath.LineTo(PointF(R.Left + FCalloutOffset + CalloutWidth, R.Top));
        FPath.LineTo(PointF(R.Right - x1, R.Top));
      end else
      begin
        FPath.LineTo(PointF(R.Right - Abs(FCalloutOffset) - CalloutWidth, R.Top));
        FPath.LineTo(PointF(R.Right - Abs(FCalloutOffset) - (CalloutWidth / 2), R.Top - FCalloutLength));
        FPath.LineTo(PointF(R.Right - Abs(FCalloutOffset), R.Top));
        FPath.LineTo(PointF(R.Right - x1, R.Top));
      end;
    end else
      FPath.LineTo(PointF(R.Right - x1, R.Top));
  end;
  if TCorner.crTopRight in FCorners then
  begin
    case FCornerType of
      // ctRound - default
      TCornerType.ctBevel:
        FPath.LineTo(PointF(R.Right, R.Top + y1));
      TCornerType.ctInnerRound:
        FPath.CurveTo(PointF(R.Right - x1, R.Top + y2),
          PointF(R.Right - x2, R.Top + y1), PointF(R.Right, R.Top + y1));
      TCornerType.ctInnerLine:
        begin
          FPath.LineTo(PointF(R.Right - x1, R.Top + y2));
          FPath.LineTo(PointF(R.Right - x2, R.Top + y1));
          FPath.LineTo(PointF(R.Right, R.Top + y1));
        end;
    else
      FPath.CurveTo(PointF(R.Right - x2, R.Top), PointF(R.Right, R.Top + (y2)),
        PointF(R.Right, R.Top + y1))
    end;
  end
  else
  begin
    if TSide.sdTop in FSides then
      FPath.LineTo(PointF(R.Right, R.Top))
    else
      FPath.MoveTo(PointF(R.Right, R.Top));
    if TSide.sdRight in FSides then
      FPath.LineTo(PointF(R.Right, R.Top + y1))
    else
      FPath.MoveTo(PointF(R.Right, R.Top + y1));
  end;
  if not(TSide.sdRight in FSides) then
    FPath.MoveTo(PointF(R.Right, R.Bottom - y1))
  else
  begin
    if (FCalloutPosition = TCalloutPosition.cpRight) then
    begin
      if CalloutOffset = 0 then
      begin
        FPath.LineTo(PointF(R.Right, (R.Bottom - R.Top) / 2 -
          (CalloutWidth / 2)));
        FPath.LineTo(PointF(R.Right + FCalloutLength, (R.Bottom - R.Top) / 2));
        FPath.LineTo(PointF(R.Right, (R.Bottom - R.Top) / 2 +
          (CalloutWidth / 2)));
        FPath.LineTo(PointF(R.Right, R.Bottom - y1));
      end
      else if CalloutOffset > 0 then
      begin
        FPath.LineTo(PointF(R.Right, R.Top + CalloutOffset));
        FPath.LineTo(PointF(R.Right + FCalloutLength, R.Top + CalloutOffset + (CalloutWidth / 2)));
        FPath.LineTo(PointF(R.Right, R.Top + CalloutOffset + CalloutWidth));
        FPath.LineTo(PointF(R.Right, R.Bottom - y1));
      end
      else
      begin
        FPath.LineTo(PointF(R.Right, R.Bottom + CalloutOffset));
        FPath.LineTo(PointF(R.Right + FCalloutLength, R.Bottom + CalloutOffset + (CalloutWidth / 2)));
        FPath.LineTo(PointF(R.Right, R.Bottom + CalloutOffset + CalloutWidth));
        FPath.LineTo(PointF(R.Right, R.Bottom - y1));
      end;
    end else
      FPath.LineTo(PointF(R.Right, R.Bottom - y1));
  end;
  if TCorner.crBottomRight in FCorners then
  begin
    case FCornerType of
      // ctRound - default
      TCornerType.ctBevel:
        FPath.LineTo(PointF(R.Right - x1, R.Bottom));
      TCornerType.ctInnerRound:
        FPath.CurveTo(PointF(R.Right - x2, R.Bottom - y1),
          PointF(R.Right - x1, R.Bottom - y2), PointF(R.Right - x1, R.Bottom));
      TCornerType.ctInnerLine:
        begin
          FPath.LineTo(PointF(R.Right - x2, R.Bottom - y1));
          FPath.LineTo(PointF(R.Right - x1, R.Bottom - y2));
          FPath.LineTo(PointF(R.Right - x1, R.Bottom));
        end;
    else
      FPath.CurveTo(PointF(R.Right, R.Bottom - (y2)),
        PointF(R.Right - x2, R.Bottom), PointF(R.Right - x1, R.Bottom))
    end;
  end
  else
  begin
    if TSide.sdRight in FSides then
      FPath.LineTo(PointF(R.Right, R.Bottom))
    else
      FPath.MoveTo(PointF(R.Right, R.Bottom));
    if TSide.sdBottom in FSides then
      FPath.LineTo(PointF(R.Right - x1, R.Bottom))
    else
      FPath.MoveTo(PointF(R.Right - x1, R.Bottom));
  end;
  if not(TSide.sdBottom in FSides) then
    FPath.MoveTo(PointF(R.Left + x1, R.Bottom))
  else
  begin
    if (FCalloutPosition = TCalloutPosition.cpBottom) then
    begin
      if CalloutOffset = 0 then
      begin
        FPath.LineTo(PointF((R.Right - R.Left) / 2 + (CalloutWidth / 2), R.Bottom));
        FPath.LineTo(PointF((R.Right - R.Left) / 2, R.Bottom + FCalloutLength));
        FPath.LineTo(PointF((R.Right - R.Left) / 2 - (CalloutWidth / 2), R.Bottom));
        FPath.LineTo(PointF(R.Left + x1, R.Bottom));
      end
      else if CalloutOffset > 0 then
      begin
        FPath.LineTo(PointF(R.Left + FCalloutOffset + CalloutWidth, R.Bottom));
        FPath.LineTo(PointF(R.Left + FCalloutOffset + (CalloutWidth / 2), R.Bottom + FCalloutLength));
        FPath.LineTo(PointF(R.Left + FCalloutOffset, R.Bottom));
        FPath.LineTo(PointF(R.Left + x1, R.Bottom));
      end else
      begin
        FPath.LineTo(PointF(R.Right - Abs(FCalloutOffset), R.Bottom));
        FPath.LineTo(PointF(R.Right - Abs(FCalloutOffset) - (CalloutWidth / 2), R.Bottom + FCalloutLength));
        FPath.LineTo(PointF(R.Right - Abs(FCalloutOffset) - CalloutWidth, R.Bottom));
        FPath.LineTo(PointF(R.Left + x1, R.Bottom));
      end;
    end else
      FPath.LineTo(PointF(R.Left + x1, R.Bottom));
  end;
  if TCorner.crBottomLeft in FCorners then
  begin
    case FCornerType of
      // ctRound - default
      TCornerType.ctBevel:
        FPath.LineTo(PointF(R.Left, R.Bottom - y1));
      TCornerType.ctInnerRound:
        FPath.CurveTo(PointF(R.Left + x1, R.Bottom - y2),
          PointF(R.Left + x2, R.Bottom - y1), PointF(R.Left, R.Bottom - y1));
      TCornerType.ctInnerLine:
        begin
          FPath.LineTo(PointF(R.Left + x1, R.Bottom - y2));
          FPath.LineTo(PointF(R.Left + x2, R.Bottom - y1));
          FPath.LineTo(PointF(R.Left, R.Bottom - y1));
        end;
    else
      FPath.CurveTo(PointF(R.Left + x2, R.Bottom), PointF(R.Left, R.Bottom - (y2)
        ), PointF(R.Left, R.Bottom - y1))
    end;
  end else
  begin
    if TSide.sdBottom in FSides then
      FPath.LineTo(PointF(R.Left, R.Bottom))
    else
      FPath.MoveTo(PointF(R.Left, R.Bottom));
    if TSide.sdLeft in FSides then
      FPath.LineTo(PointF(R.Left, R.Bottom - y1))
    else
      FPath.MoveTo(PointF(R.Left, R.Bottom - y1));
  end;
  if (TSide.sdLeft in FSides) then
  begin
    if (FCalloutPosition = TCalloutPosition.cpLeft) then
    begin
      if CalloutOffset = 0 then
      begin
        FPath.LineTo(PointF(R.Left, (R.Bottom - R.Top) / 2 + (CalloutWidth / 2)));
        FPath.LineTo(PointF(R.Left - FCalloutLength, (R.Bottom - R.Top) / 2));
        FPath.LineTo(PointF(R.Left, (R.Bottom - R.Top) / 2 - (CalloutWidth / 2)));
        FPath.LineTo(PointF(R.Left, R.Top + y1));
      end
      else if CalloutOffset > 0 then
      begin
        FPath.LineTo(PointF(R.Left, R.Top + CalloutOffset + CalloutWidth));
        FPath.LineTo(PointF(R.Left - FCalloutLength, R.Top + CalloutOffset + (CalloutWidth / 2)));
        FPath.LineTo(PointF(R.Left, R.Top + CalloutOffset));
        FPath.LineTo(PointF(R.Left, R.Top + y1));
      end else
      begin
        FPath.LineTo(PointF(R.Left, R.Bottom + CalloutOffset + CalloutWidth));
        FPath.LineTo(PointF(R.Left - FCalloutLength, R.Bottom + CalloutOffset + (CalloutWidth / 2)));
        FPath.LineTo(PointF(R.Left, R.Bottom + CalloutOffset));
        FPath.LineTo(PointF(R.Left, R.Top + y1));
      end;
    end else
      FPath.LineTo(PointF(R.Left, R.Top + y1));
  end;
end;

procedure TCalloutRectangle.Paint;
begin
  CreatePath;
  Canvas.FillPath(FPath, AbsoluteOpacity, FFill);
  Canvas.DrawPath(FPath, AbsoluteOpacity, FStroke);
end;

procedure TCalloutRectangle.SetCalloutWidth(const Value: Single);
begin
  if FCalloutWidth <> Value then
  begin
    FCalloutWidth := Value;
    CreatePath;
    Repaint;
  end;
end;

procedure TCalloutRectangle.SetCalloutLength(const Value: Single);
begin
  if FCalloutLength <> Value then
  begin
    FCalloutLength := Value;
    CreatePath;
    Repaint;
  end;
end;

procedure TCalloutRectangle.SetCalloutPosition(const Value: TCalloutPosition);
begin
  if FCalloutPosition <> Value then
  begin
    FCalloutPosition := Value;
    CreatePath;
    Repaint;
  end;
end;

procedure TCalloutRectangle.SetCalloutOffset(const Value: Single);
begin
  if FCalloutOffset <> Value then
  begin
    FCalloutOffset := Value;
    CreatePath;
    Repaint;
  end;
end;

{ TTextTextSettings }

type
  TTextTextSettings = class(TTextSettings)
  private
    FText: TText;
  protected
    procedure DoChanged; override;
  end;

procedure TTextTextSettings.DoChanged;
begin
  FText.FLayout.BeginUpdate;
  FText.FLayout.WordWrap := FText.WordWrap;
  FText.FLayout.HorizontalAlign := FText.HorzTextAlign;
  FText.FLayout.VerticalAlign := FText.VertTextAlign;
  FText.FLayout.Color := FText.Color;
  FText.FLayout.Font := FText.Font;
  FText.FLayout.Opacity := FText.AbsoluteOpacity;
  FText.FLayout.Trimming := FText.Trimming;
  FText.FLayout.EndUpdate;
  inherited;
end;

{ TText }

constructor TText.Create(AOwner: TComponent);
begin
  inherited;
  FLayout := TTextLayoutManager.DefaultTextLayout.Create;

  FTextSettings := TTextTextSettings.Create(nil);
  TTextTextSettings(FTextSettings).FText := Self;
  FTextSettings.BeginUpdate;
  FTextSettings.WordWrap := True;
  FTextSettings.HorzAlign := TTextAlign.taCenter;
  FTextSettings.VertAlign := TTextAlign.taCenter;
  FTextSettings.OnChanged := FontChanged;
  FTextSettings.IsAdjustChanged := True;
  FTextSettings.EndUpdate;
end;

destructor TText.Destroy;
begin
  FreeAndNil(FTextSettings);
  FreeAndNil(FLayout);
  inherited;
end;

procedure TText.DefineProperties(Filer: TFiler);
begin
  inherited;
  // Only for backward compatibility with XE2
  Filer.DefineProperty('Fill.Color', ReadFillColor, nil, False);
end;

function TText.GetData: TValue;
begin
  Result := Text;
end;

procedure TText.SetData(const Value: TValue);
begin
  Text := Value.ToString;
end;

procedure TText.FontChanged(Sender: TObject);
begin
  if not FIsChanging then
  begin
    FIsChanging := True;
    try
      if FTextSettings.IsAdjustChanged then
        AdjustSize;
      Repaint;
    finally
      FIsChanging := False;
    end;
  end;
end;

procedure TText.DoRealign;
begin
  inherited;
  AdjustSize;
end;

function TText.GetDefaultTextSettings: TTextSettings;
begin
  Result := FTextSettings;
end;

function TText.GetTextSettings: TTextSettings;
begin
  Result := FTextSettings;
end;

procedure TText.SetTextSettings(const Value: TTextSettings);
begin
  FTextSettings.Assign(Value);
end;

function TText.GetStyledSettings: TStyledSettings;
begin
  Result := FTextSettingsEnabled;
end;

procedure TText.SetStyledSettings(const Value: TStyledSettings);
begin
  FTextSettingsEnabled := Value;
end;

function TText.SupportsPaintStage(const Stage: TPaintStage): Boolean;
begin
  Result := Stage in [TPaintStage.psAll, TPaintStage.psText];
end;

procedure TText.Paint;
var
  R: TRectF;
  M: TMatrix;
  LIsChanging: boolean;
begin
  LIsChanging := FIsChanging;
  try
    FIsChanging := True;
    if FStretch then
    begin
      Canvas.Font.Assign(FLayout.Font);
      Canvas.Fill.Kind := TBrushkind.bkSolid;
      Canvas.Fill.Color := Color;
      R := RectF(0, 0, 1000, 1000);
      Canvas.MeasureText(R, Text, False, [], HorzTextAlign, VertTextAlign);
      OffsetRect(R, -R.Left, -R.Top);
      M := IdentityMatrix;
      Canvas.SetMatrix(M);
      if not IsRectEmpty(R) then
      begin
        M.m11 := RectWidth(LocalRect) / RectWidth(R);
        M.m22 := RectHeight(LocalRect) / RectHeight(R);
      end;
      Canvas.MultiplyMatrix(M);
      M := IdentityMatrix;
      M.m31 := Position.X;
      M.m32 := Position.Y;
      Canvas.MultiplyMatrix(M);
      InflateRect(R, Font.Size / 3, Font.Size / 3);
      Canvas.FillText(BoundsRect, Text, False, AbsoluteOpacity,  FillTextFlags, TTextAlign.taLeading, TTextAlign.taLeading);
    end
    else
    begin
      FLayout.BeginUpdate;
      try
        FLayout.LayoutCanvas := Self.Canvas;
        FLayout.TopLeft := LocalRect.TopLeft;
        FLayout.Opacity := AbsoluteOpacity;
        FLayout.MaxSize := PointF(LocalRect.Width, LocalRect.Height);
      finally
        FLayout.EndUpdate;
      end;
      FLayout.RenderLayout(Canvas);
    end;
  finally
    FIsChanging := LIsChanging;
  end;
  if (csDesigning in ComponentState) and not Locked and not FInPaintTo then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.DrawDashRect(R, 0, 0, AllCorners, AbsoluteOpacity, $A0909090);
  end;
end;

procedure TText.ReadFillColor(Reader: TReader);
var
  LColor: TAlphaColor;
begin
  LColor := 0;
  IdentToAlphaColor(Reader.ReadIdent, Integer(LColor));
  Color := LColor;
end;

function TText.GetColor: TAlphaColor;
begin
  Result := FTextSettings.FontColor;
end;

procedure TText.SetColor(const Value: TAlphaColor);
begin
  FTextSettings.FontColor := Value;
end;

function TText.GetWordWrap: Boolean;
begin
  Result := FTextSettings.WordWrap;
end;

procedure TText.SetWordWrap(const Value: Boolean);
begin
  FTextSettings.WordWrap := Value;
end;

function TText.GetFont: TFont;
begin
  Result := FTextSettings.Font;
end;

procedure TText.SetFont(const Value: TFont);
begin
  FTextSettings.Font := Value;
end;

function TText.GetHorzTextAlign: TTextAlign;
begin
  Result := FTextSettings.HorzAlign;
end;

procedure TText.SetHorzTextAlign(const Value: TTextAlign);
begin
  FTextSettings.HorzAlign := Value;
end;

function TText.GetVertTextAlign: TTextAlign;
begin
  Result := FTextSettings.VertAlign;
end;

procedure TText.SetVertTextAlign(const Value: TTextAlign);
begin
  FTextSettings.VertAlign := Value;
end;

function TText.GetTrimming: TTextTrimming;
begin
  Result := FTextSettings.Trimming;
end;

procedure TText.SetTrimming(const Value: TTextTrimming);
begin
  FTextSettings.Trimming := Value;
end;

procedure TText.SetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    AdjustSize;
  end;
end;

procedure TText.SetStretch(const Value: Boolean);
begin
  if FStretch <> Value then
  begin
    FStretch := Value;
    if Stretch then
      AutoSize := False;
    Repaint;
  end;
end;

procedure TText.Resize;
begin
  inherited;
  AdjustSize;
end;

procedure TText.AdjustSize;
var
  R: TRectF;
  AlignRoot: IAlignRoot;
  LHorzAlign: TTextAlign;
  LVertAlign: TTextAlign;
  LOpacity: Single;
begin
  if FDisableAlign then
    Exit;
  FDisableAlign := True;
  try
    if FAutoSize and (Text <> '') then
    begin
      LHorzAlign := FLayout.HorizontalAlign;
      LVertAlign := FLayout.VerticalAlign;
      LOpacity := FLayout.Opacity;
      try
        if WordWrap then
          R := RectF(0, 0, Width, MaxSingle)
        else
          R := RectF(0, 0, MaxSingle, MaxSingle);
        FLayout.BeginUpdate;
        try
          FLayout.TopLeft := R.TopLeft;
          FLayout.MaxSize := PointF(R.Width, R.Height);
          FLayout.Opacity := AbsoluteOpacity;
          FLayout.HorizontalAlign := TTextAlign.taLeading;
          FLayout.VerticalAlign := TTextAlign.taLeading;
        finally
          FLayout.EndUpdate;
        end;
        R := FLayout.TextRect;
      finally
        FLayout.BeginUpdate;
        try
          FLayout.Opacity := LOpacity;
          FLayout.HorizontalAlign := LHorzAlign;
          FLayout.VerticalAlign := LVertAlign;
        finally
          FLayout.EndUpdate;
        end;
      end;
      SetBounds(Position.X, Position.Y, Round(R.Width) + 4, Round(R.Height) + 4);
      if Supports(Parent, IAlignRoot, AlignRoot) then
        AlignRoot.Realign;
    end;
  finally
    FDisableAlign := False;
  end;
end;

function TText.GetText: string;
begin
  Result := FLayout.Text;
end;

procedure TText.SetText(const Value: string);
begin
  if Text <> Value then
  begin
    FLayout.LayoutCanvas := Canvas;
    FLayout.Text := Value;
    AdjustSize;
    Repaint;
  end;
end;

{ TImageData }

constructor TImageData.Create;
begin
  inherited ;
  FBitmap := TBitmap.Create(0, 0);
  FBitmap.OnChange := DoBitmapChanged;
  FBitmapHiRes := TBitmap.Create(0, 0);
  FBitmapHiRes.OnChange := DoBitmapChanged;
end;

destructor TImageData.Destroy;
begin
  FreeAndNil(FBitmapHiRes);
  FreeAndNil(FBitmap);
  inherited;
end;

procedure TImageData.DoBitmapChanged(Sender: TObject);
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TImageData.SetBitmap(const Value: TBitmap);
begin
  FBitmap.Assign(Value);
end;

procedure TImageData.SetBitmapHiRes(const Value: TBitmap);
begin
  FBitmapHiRes.Assign(Value);
end;

{ TImage }

constructor TImage.Create(AOwner: TComponent);
begin
  inherited;
  FBitmap := TBitmap.Create(0, 0);
  FBitmap.OnChange := DoBitmapChanged;
  FBitmapHiRes := TBitmap.Create(0, 0);
  FBitmapHiRes.OnChange := DoBitmapChanged;
  IBitmapAccess(FBitmapHiRes).BitmapScale := 2.0;
  FBitmapMargins := TBounds.Create(RectF(0, 0, 0, 0));
  FWrapMode := TImageWrapMode.iwFit;
  FMarginWrapMode := TImageWrapMode.iwStretch;
  SetAcceptsControls(False);
  FScaleChangedId := TMessageManager.DefaultManager.SubscribeToMessage(TScaleChangedMessage, ScaleChangedHandler);
end;

destructor TImage.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TScaleChangedMessage, FScaleChangedId);
  FreeAndNil(FBitmapMargins);
  FreeAndNil(FBitmapHiRes);
  FreeAndNil(FBitmap);
  inherited;
end;

function TImage.GetBitmap: TBitmap;
begin
  Result := FBitmap;
end;

function TImage.GetData: TValue;
begin
  if not FData.IsEmpty then
    Result := FData
  else
    Result := FBitmap;
end;

procedure TImage.SetData(const Value: TValue);
begin
  FData := Value;
  if Value.IsObject then
  begin
    if Value.AsObject is TPersistent then
      FBitmap.Assign(TPersistent(Value.AsObject));
  end
  else
    FBitmap.LoadFromFile(Value.ToString)
end;

procedure TImage.DoBitmapChanged(Sender: TObject);
begin
  Repaint;
  UpdateEffects;
end;

procedure TImage.Paint;
var
  LR, R, IntersectionRect: TRectF;
  i, j: Integer;
  B: TBitmap;
  ScreenScale: Single;
begin
  if (csDesigning in ComponentState) and not Locked and not FInPaintTo then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.DrawDashRect(R, 0, 0, AllCorners, AbsoluteOpacity, $A0909090);
  end;

  B := FBitmap;
  if Assigned(Scene) then
    ScreenScale := Scene.GetSceneScale
  else
    ScreenScale := 1.0;
  if (ScreenScale > 1.0) and not FBitmapHiRes.IsEmpty then
    B := FBitmapHiRes;

  if Assigned(B.ResourceBitmap) then
    B := B.ResourceBitmap;
  if B.IsEmpty then
    Exit;

  LR := RectF(0, 0, Trunc(Width * ScreenScale), Trunc(Height * ScreenScale));

  if not FBitmapMargins.MarginEmpty then
  begin
    { rightbottom }
    R := RectF(Width - FBitmapMargins.Right, Height - FBitmapMargins.Bottom,
      Width, Height);
    Canvas.DrawBitmap(B, RectF(B.Width - FBitmapMargins.Right,
      B.Height - FBitmapMargins.Bottom, B.Width, B.Height), R,
      AbsoluteOpacity, True);
    { lefttop }
    R := RectF(0, 0, FBitmapMargins.Left, FBitmapMargins.Top);
    Canvas.DrawBitmap(B, RectF(0, 0, FBitmapMargins.Left, FBitmapMargins.Top), R,
      AbsoluteOpacity, True);
    { righttop }
    R := RectF(Width - FBitmapMargins.Right, 0, Width, FBitmapMargins.Top);
    Canvas.DrawBitmap(B, RectF(B.Width - FBitmapMargins.Right, 0, B.Width,
      FBitmapMargins.Top), R, AbsoluteOpacity, True);
    { leftbottom }
    R := RectF(0, Height - FBitmapMargins.Bottom, FBitmapMargins.Left, Height);
    Canvas.DrawBitmap(B, RectF(0, B.Height - FBitmapMargins.Bottom,
      FBitmapMargins.Left, B.Height), R, AbsoluteOpacity, True);
    { top }
    if FMarginWrapMode = TImageWrapMode.iwTile then
    begin
      for i := 0 to Trunc((Width - FBitmapMargins.Left - FBitmapMargins.Right) / (B.Width - FBitmapMargins.Left - FBitmapMargins.Right)) + 1 do
      begin
        R := RectF(FBitmapMargins.Left, 0, B.Width - FBitmapMargins.Bottom, FBitmapMargins.Top);
        OffsetRect(R, i * R.Width, 0);
        IntersectRect(IntersectionRect, RectF(FBitmapMargins.Left, 0, Width - FBitmapMargins.Right,
          FBitmapMargins.Top), R);
        Canvas.DrawBitmap(B, RectF(0 + FBitmapMargins.Left, 0,
          B.Width - FBitmapMargins.Right, FBitmapMargins.Top),
          IntersectionRect, AbsoluteOpacity, True)
      end;
    end
    else
    begin
      R := RectF(FBitmapMargins.Left, 0, Width - FBitmapMargins.Right,
        FBitmapMargins.Top);
      Canvas.DrawBitmap(B, RectF(FBitmapMargins.Left, 0,
        B.Width - FBitmapMargins.Right, FBitmapMargins.Top), R,
        AbsoluteOpacity, True);
    end;
    { left }
    if FMarginWrapMode = TImageWrapMode.iwTile then
    begin
      for j := 0 to Trunc((Height - FBitmapMargins.Bottom - FBitmapMargins.Top) / (B.Height - FBitmapMargins.Bottom - FBitmapMargins.Top)) + 1 do
      begin
        R := RectF(0, FBitmapMargins.Top, FBitmapMargins.Left, B.Height - FBitmapMargins.Bottom);
        OffsetRect(R, 0, j * R.Height);
        IntersectRect(IntersectionRect, RectF(0, FBitmapMargins.Top, FBitmapMargins.Left, Height - FBitmapMargins.Bottom), R);
        Canvas.DrawBitmap(B, RectF(0, FBitmapMargins.Top,
          FBitmapMargins.Left, FBitmapMargins.Top + IntersectionRect.Height),
          IntersectionRect, AbsoluteOpacity, True)
      end;
    end
    else
    begin
      R := RectF(0, FBitmapMargins.Top, FBitmapMargins.Left,
        Height - FBitmapMargins.Bottom);
      Canvas.DrawBitmap(B, RectF(0, FBitmapMargins.Top, FBitmapMargins.Left,
        B.Height - FBitmapMargins.Bottom), R, AbsoluteOpacity, True);
    end;
    { right }
    if FMarginWrapMode = TImageWrapMode.iwTile then
    begin
      for j := 0 to Trunc((Height - FBitmapMargins.Bottom - FBitmapMargins.Top) / (B.Height - FBitmapMargins.Bottom - FBitmapMargins.Top)) + 1 do
      begin
        R := RectF(Width - FBitmapMargins.Right, FBitmapMargins.Top, Width, B.Height - FBitmapMargins.Bottom);
        OffsetRect(R, 0, j * R.Height);
        IntersectRect(IntersectionRect, RectF(Width - FBitmapMargins.Right, FBitmapMargins.Top, Width, Height - FBitmapMargins.Bottom), R);
        Canvas.DrawBitmap(B, RectF(B.Width - FBitmapMargins.Right, FBitmapMargins.Top,
          B.Width, FBitmapMargins.Top + IntersectionRect.Height),
          IntersectionRect, AbsoluteOpacity, True)
      end;
    end
    else
    begin
      R := RectF(Width - FBitmapMargins.Right, FBitmapMargins.Top, Width,
        Height - FBitmapMargins.Bottom);
      Canvas.DrawBitmap(B, RectF(B.Width - FBitmapMargins.Right,
        FBitmapMargins.Top, B.Width, B.Height - FBitmapMargins.Bottom), R,
        AbsoluteOpacity, True);
    end;
    { bottom }
    if FMarginWrapMode = TImageWrapMode.iwTile then
    begin
      for i := 0 to Trunc((Width - FBitmapMargins.Left - FBitmapMargins.Right) / (B.Width - FBitmapMargins.Left - FBitmapMargins.Right)) + 1 do
      begin
        R := RectF(FBitmapMargins.Left, Height - FBitmapMargins.Bottom, B.Width - FBitmapMargins.Right, Height);
        OffsetRect(R, i * R.Width, 0);
        IntersectRect(IntersectionRect, RectF(FBitmapMargins.Left, Height - FBitmapMargins.Bottom, Width - FBitmapMargins.Right,
          Height), R);
        Canvas.DrawBitmap(B, RectF(FBitmapMargins.Left, B.Height - FBitmapMargins.Bottom,
          B.Width - FBitmapMargins.Right, B.Height),
          IntersectionRect, AbsoluteOpacity, True)
      end;
    end
    else
    begin
      R := RectF(FBitmapMargins.Left, Height - FBitmapMargins.Bottom,
        Width - FBitmapMargins.Right, Height);
      Canvas.DrawBitmap(B, RectF(FBitmapMargins.Left,
        B.Height - FBitmapMargins.Bottom, B.Width - FBitmapMargins.Right,
        B.Height), R, AbsoluteOpacity, True);
    end;
    { center }
    if FWrapMode = TImageWrapMode.iwTile then
    begin
      for i := 0 to Trunc((Width - FBitmapMargins.Left - FBitmapMargins.Right) / (B.Width - FBitmapMargins.Left - FBitmapMargins.Right)) + 1 do
        for j := 0 to Trunc((Height - FBitmapMargins.Bottom - FBitmapMargins.Top) / (B.Height - FBitmapMargins.Bottom - FBitmapMargins.Top)) + 1 do
        begin
          R := FBitmapMargins.PaddingRect(RectF(0, 0, B.Width, B.Height));
          OffsetRect(R, i * R.Width, j * R.Height);
          IntersectRect(IntersectionRect, FBitmapMargins.PaddingRect(LocalRect), R);
          Canvas.DrawBitmap(B, RectF(FBitmapMargins.Left, FBitmapMargins.Top, FBitmapMargins.Left + IntersectionRect.Width, FBitmapMargins.Top + IntersectionRect.Height),
            RectF(R.Left, R.Top, R.Left + IntersectionRect.Width, R.Top + IntersectionRect.Height), AbsoluteOpacity, True)
        end;
    end
    else
    begin
      R := RectF(FBitmapMargins.Left, FBitmapMargins.Top,
        Width - FBitmapMargins.Right, Height - FBitmapMargins.Bottom);
      Canvas.DrawBitmap(B, RectF(FBitmapMargins.Left, FBitmapMargins.Top,
        B.Width - FBitmapMargins.Right, B.Height - FBitmapMargins.Bottom), R,
        AbsoluteOpacity, True);
    end;
  end
  else
  begin
    case FWrapMode of
      TImageWrapMode.iwOriginal:
        begin
          R := RectF(0, 0, B.Width, B.Height);
          IntersectRect(IntersectionRect, LR, R);
          Canvas.DrawBitmap(B, RectF(0, 0, IntersectionRect.Width, IntersectionRect.Height),
            RectF(R.Left, R.Top, R.Left + IntersectionRect.Width / ScreenScale, R.Top + IntersectionRect.Height / ScreenScale), AbsoluteOpacity, DisableInterpolation)
        end;
      TImageWrapMode.iwFit:
        begin
          LR := RectF(0, 0, Width, Height);
          R := RectF(0, 0, B.Width / B.BitmapScale, B.Height / B.BitmapScale);
          R.Fit(LR);
          R.Left := Round(R.Left);
          R.Top := Round(R.Top);
          R.Right := Round(R.Right);
          R.Bottom := Round(R.Bottom);
          Canvas.DrawBitmap(B, RectF(0, 0, B.Width, B.Height), R, AbsoluteOpacity, DisableInterpolation);
        end;
      TImageWrapMode.iwStretch:
        begin
          Canvas.DrawBitmap(B, RectF(0, 0, B.Width, B.Height), RectF(0, 0, Width, Height), AbsoluteOpacity, DisableInterpolation)
        end;
      TImageWrapMode.iwTile:
        begin
          for i := 0 to Trunc(LR.Width / B.Width) + 1 do
            for j := 0 to Trunc(LR.Height / B.Height) + 1 do
            begin
              R := RectF(0, 0, B.Width, B.Height);
              OffsetRect(R, i * B.Width, j * B.Height);
              IntersectRect(IntersectionRect, LR, R);
              Canvas.DrawBitmap(B, RectF(0, 0, IntersectionRect.Width, IntersectionRect.Height),
                RectF(R.Left / ScreenScale, R.Top / ScreenScale, (R.Left + IntersectionRect.Width) / ScreenScale,
                  (R.Top + IntersectionRect.Height) / ScreenScale), AbsoluteOpacity, True)
            end;
        end;
      TImageWrapMode.iwCenter:
        begin
          R := RectF(0, 0, B.Width / B.BitmapScale, B.Height / B.BitmapScale);
          RectCenter(R, RectF(0, 0, Width, Height));
          Canvas.DrawBitmap(B, RectF(0, 0, B.Width, B.Height), R, AbsoluteOpacity, DisableInterpolation);
        end;
    end;
  end;
end;

procedure TImage.ScaleChangedHandler(const Sender: TObject; const Msg: TMessage);
begin
  Repaint;
end;

procedure TImage.SetBitmap(const Value: TBitmap);
begin
  FBitmap.Assign(Value);
end;

procedure TImage.SetBitmapHiRes(const Value: TBitmap);
begin
  FBitmapHiRes.Assign(Value);
end;

procedure TImage.SetBitmapMargins(const Value: TBounds);
begin
  FBitmapMargins.Assign(Value);
end;

procedure TImage.SetMarginWrapMode(const Value: TImageWrapMode);
begin
  if FMarginWrapMode <> Value then
  begin
    FMarginWrapMode := Value;
    Repaint;
  end;
end;

procedure TImage.SetWrapMode(const Value: TImageWrapMode);
begin
  if FWrapMode <> Value then
  begin
    FWrapMode := Value;
    Repaint;
  end;
end;

{ TSubImage }

constructor TSubImage.Create(AOwner: TComponent);
begin
  inherited;
  FBitmapMargins := TBounds.Create(RectF(0, 0, 0, 0));
  FBitmapMargins.StoreAsInt := True;
  FBitmapMargins.OnChange := RectChanged;
  FBitmapScale := 1.0;
  FSourceRect := TBounds.Create(RectF(0, 0, 0, 0));
  FSourceRect.StoreAsInt := True;
  FSourceRect.OnChange := RectChanged;
  FWrapMode := TImageWrapMode.iwStretch;
  FMarginWrapMode := TImageWrapMode.iwStretch;
  SetAcceptsControls(False);
end;

destructor TSubImage.Destroy;
begin
  if Assigned(FSource) then
    FSource.RemoveFreeNotify(Self);
  FSourceRect.Free;
  FBitmapMargins.Free;
  FreeAndNil(FBuffer);
  inherited;
end;

procedure TSubImage.FreeNotification(AObject: TObject);
begin
  inherited;
  if AObject = Source then
    Source := nil;
end;

procedure TSubImage.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FSource) then
    Source := nil;
end;

procedure TSubImage.DrawToCanvas(const Canvas: TCanvas; const ARect: TRectF; const AOpacity: Single = 1.0);
var
  LR, LRUnscaled, R, IntersectionRect, ScaledMargins: TRectF;
  i, j: Integer;
  B: TBitmap;
  SR, SRScaled: TRectF;
  ScreenScale: Single;
  HorzMarginsOnly, VertMarginsOnly: Boolean;
  SaveState: TCanvasSaveState;
  HighSpeed: Boolean;
  M: TMatrix;
begin
  if FSourceRect.Empty or not Assigned(FSource) then
    Exit;

  if Assigned(Scene) then
    ScreenScale := Scene.GetSceneScale
  else
    ScreenScale := Canvas.Scale;

  HighSpeed := DisableInterpolation and SameValue(Frac(ScreenScale), 0.0, Epsilon);

  B := FSource.Bitmap;
  if Assigned(FSource.FBitmap.ResourceBitmap) then
    B := FSource.FBitmap.ResourceBitmap;
  if B.IsEmpty then
    Exit;

  if FOpaque and SameValue(AOpacity, 1.0, Epsilon) then
    Canvas.Blending := False
  else
    Canvas.Blending := True;

  SR := FSourceRect.Rect;
  SRScaled := TRectF.Create(SR.Left / ScreenScale, SR.Top / ScreenScale, SR.Right / ScreenScale, SR.Bottom / ScreenScale);
  LR := TRectF.Create(Round(ARect.Left * ScreenScale), Round(ARect.Top * ScreenScale), Round(ARect.Right * ScreenScale), Round(ARect.Bottom * ScreenScale));
  LRUnscaled := ARect;

  ScaledMargins := TRectF.Create(FBitmapMargins.Left / ScreenScale, FBitmapMargins.Top / ScreenScale,
    FBitmapMargins.Right / ScreenScale, FBitmapMargins.Bottom / ScreenScale);

  if (FBitmapMargins.Left + FBitmapMargins.Right > LR.Width) then
  begin
    LR.Width := FBitmapMargins.Left + FBitmapMargins.Right;
    LRUnscaled.Width := LR.Width / ScreenScale;
    HorzMarginsOnly := True;
  end
  else
    HorzMarginsOnly := False;
  if (FBitmapMargins.Top + FBitmapMargins.Bottom > LR.Height) then
  begin
    LR.Height := FBitmapMargins.Top + FBitmapMargins.Bottom;
    LRUnscaled.Height := LR.Height / ScreenScale;
    VertMarginsOnly := True;
  end
  else
    VertMarginsOnly := False;

  if not FBitmapMargins.MarginEmpty then
  begin
    // fixed scale
    if HorzMarginsOnly or VertMarginsOnly then
    begin
      SaveState := Canvas.SaveState;
      Canvas.IntersectClipRect(ARect);
      // Offset for bottom oriented
      if VertMarginsOnly and Assigned(ParentControl) and (Position.Y + Height > ParentControl.Height / 2) then
      begin
        M := IdentityMatrix;
        M.m32 := Height - LRUnscaled.Height;
        M := MatrixMultiply(AbsoluteMatrix, M);
        Canvas.SetMatrix(M);
      end;
    end
    else
      SaveState := nil;
    { lefttop }
    R := TRectF.Create(LRUnscaled.Left, LRUnscaled.Top, LRUnscaled.Left + ScaledMargins.Left, LRUnscaled.Top + ScaledMargins.Top);
    Canvas.DrawBitmap(B, TRectF.Create(SR.Left, SR.Top, SR.Left + FBitmapMargins.Left, SR.Top + FBitmapMargins.Top), R,
      AOpacity, True);
    { righttop }
    R := TRectF.Create(LRUnscaled.Right - ScaledMargins.Right, LRUnscaled.Top, LRUnscaled.Right, LRUnscaled.Top + ScaledMargins.Top);
    Canvas.DrawBitmap(B, TRectF.Create(SR.Right - FBitmapMargins.Right, SR.Top, SR.Right,
      SR.Top + FBitmapMargins.Top), R, AOpacity, True);
    { leftbottom }
    R := TRectF.Create(LRUnscaled.Left, LRUnscaled.Bottom - ScaledMargins.Bottom, LRUnscaled.Left + ScaledMargins.Left, LRUnscaled.Bottom);
    Canvas.DrawBitmap(B, TRectF.Create(SR.Left, SR.Bottom - FBitmapMargins.Bottom,
      SR.Left + FBitmapMargins.Left, SR.Bottom), R, AOpacity, True);
    { rightbottom }
    R := TRectF.Create(LRUnscaled.Right - ScaledMargins.Right, LRUnscaled.Bottom - ScaledMargins.Bottom, LRUnscaled.Right, LRUnscaled.Bottom);
    Canvas.DrawBitmap(B, TRectF.Create(SR.Right - FBitmapMargins.Right,
      SR.Bottom - FBitmapMargins.Bottom, SR.Right, SR.Bottom), R,
      AOpacity, True);
    if not HorzMarginsOnly then
    begin
      { top }
      if FMarginWrapMode = TImageWrapMode.iwTile then
      begin
        for i := 0 to Ceil((LR.Width - FBitmapMargins.Left - FBitmapMargins.Right) / (SR.Width - FBitmapMargins.Left - FBitmapMargins.Right)) do
        begin
          R := TRectF.Create(LRUnscaled.Left + ScaledMargins.Left, LRUnscaled.Top, LRUnscaled.Left + SRScaled.Width - ScaledMargins.Right, LRUnscaled.Top + ScaledMargins.Top);
          OffsetRect(R, i * R.Width, 0);
          IntersectRect(IntersectionRect, TRectF.Create(LRUnscaled.Left + ScaledMargins.Left, LRUnscaled.Top, LRUnscaled.Right - ScaledMargins.Right, LRUnscaled.Top + ScaledMargins.Top), R);
          Canvas.DrawBitmap(B, TRectF.Create(SR.Left + FBitmapMargins.Left, SR.Top, SR.Right - FBitmapMargins.Right, SR.Top + FBitmapMargins.Top),
            IntersectionRect, AOpacity, True)
        end;
      end
      else
        Canvas.DrawBitmap(B, TRectF.Create(SR.Left + FBitmapMargins.Left, SR.Top, SR.Right - FBitmapMargins.Right, SR.Top + FBitmapMargins.Top),
          TRectF.Create(LRUnscaled.Left + ScaledMargins.Left, LRUnscaled.Top, LRUnscaled.Right - ScaledMargins.Right, LRUnscaled.Top + ScaledMargins.Top),
          AOpacity, True);
      { bottom }
      if FMarginWrapMode = TImageWrapMode.iwTile then
      begin
        for i := 0 to Ceil((LR.Width - FBitmapMargins.Left - FBitmapMargins.Right) / (SR.Width - FBitmapMargins.Left - FBitmapMargins.Right)) do
        begin
          R := TRectF.Create(LRUnscaled.Left + ScaledMargins.Left, LRUnscaled.Bottom - ScaledMargins.Bottom, LRUnscaled.Left + SRScaled.Width - ScaledMargins.Right, LRUnscaled.Bottom);
          OffsetRect(R, i * R.Width, 0);
          IntersectRect(IntersectionRect, TRectF.Create(LRUnscaled.Left + ScaledMargins.Left, LRUnscaled.Bottom - ScaledMargins.Bottom, LRUnscaled.Right - ScaledMargins.Right,
            LRUnscaled.Bottom), R);
          Canvas.DrawBitmap(B, TRectF.Create(SR.Left + FBitmapMargins.Left, SR.Bottom - FBitmapMargins.Bottom, SR.Right - FBitmapMargins.Right, SR.Bottom),
            IntersectionRect, AOpacity, True)
        end;
      end
      else
        Canvas.DrawBitmap(B, TRectF.Create(SR.Left + FBitmapMargins.Left, SR.Bottom - FBitmapMargins.Bottom, SR.Right - FBitmapMargins.Right, SR.Bottom),
          TRectF.Create(LRUnscaled.Left + ScaledMargins.Left, LRUnscaled.Bottom - ScaledMargins.Bottom, LRUnscaled.Right - ScaledMargins.Right, LRUnscaled.Bottom),
          AOpacity, True);
    end;
    if not VertMarginsOnly then
    begin
      { left }
      if FMarginWrapMode = TImageWrapMode.iwTile then
      begin
        for j := 0 to Ceil((LR.Height - FBitmapMargins.Bottom - FBitmapMargins.Top) / (SR.Height - FBitmapMargins.Bottom - FBitmapMargins.Top))  do
        begin
          R := TRectF.Create(LRUnscaled.Left, LRUnscaled.Top + ScaledMargins.Top, LRUnscaled.Left + ScaledMargins.Left, LRUnscaled.Top + SRScaled.Height - ScaledMargins.Bottom);
          OffsetRect(R, 0, j * R.Height);
          IntersectRect(IntersectionRect, TRectF.Create(LRUnscaled.Left, LRUnscaled.Top + ScaledMargins.Top,
            LRUnscaled.Left + ScaledMargins.Left, LRUnscaled.Bottom - ScaledMargins.Bottom), R);
          Canvas.DrawBitmap(B, TRectF.Create(SR.Left, SR.Top + FBitmapMargins.Top, SR.Left + FBitmapMargins.Left, SR.Top + FBitmapMargins.Top + IntersectionRect.Height),
            IntersectionRect, AOpacity, True)
        end;
      end
      else
        Canvas.DrawBitmap(B, TRectF.Create(SR.Left, SR.Top + FBitmapMargins.Top, SR.Left + FBitmapMargins.Left, SR.Bottom - FBitmapMargins.Bottom),
          TRectF.Create(LRUnscaled.Left, LRUnscaled.Top + ScaledMargins.Top, LRUnscaled.Left + ScaledMargins.Left, LRUnscaled.Bottom - ScaledMargins.Bottom), AOpacity, True);
      { right }
      if FMarginWrapMode = TImageWrapMode.iwTile then
      begin
        for j := 0 to Ceil((LR.Height - FBitmapMargins.Bottom - FBitmapMargins.Top) / (SR.Height - FBitmapMargins.Bottom - FBitmapMargins.Top)) do
        begin
          R := TRectF.Create(LRUnscaled.Right - ScaledMargins.Right, LRUnscaled.Top + ScaledMargins.Top, LRUnscaled.Right, LRUnscaled.Top + SRScaled.Height - ScaledMargins.Bottom);
          OffsetRect(R, 0, j * R.Height);
          IntersectRect(IntersectionRect, TRectF.Create(LRUnscaled.Width - ScaledMargins.Right, LRUnscaled.Top + ScaledMargins.Top, LRUnscaled.Right,
            LRUnscaled.Bottom - ScaledMargins.Bottom), R);
          Canvas.DrawBitmap(B, TRectF.Create(SR.Right - FBitmapMargins.Right, SR.Top + FBitmapMargins.Top, SR.Right, SR.Top + FBitmapMargins.Top + IntersectionRect.Height),
            IntersectionRect, AOpacity, True)
        end;
      end
      else
        Canvas.DrawBitmap(B, TRectF.Create(SR.Right - FBitmapMargins.Right, SR.Top + FBitmapMargins.Top, SR.Right, SR.Bottom - FBitmapMargins.Bottom),
          TRectF.Create(LRUnscaled.Right - ScaledMargins.Right, LRUnscaled.Top + ScaledMargins.Top, LRUnscaled.Right, LRUnscaled.Bottom - ScaledMargins.Bottom),
          AOpacity, True);
    end;
    { center }
    if not VertMarginsOnly and not HorzMarginsOnly then
    begin
      if FWrapMode = TImageWrapMode.iwTile then
      begin
        for i := 0 to Ceil((LR.Width - FBitmapMargins.Left - FBitmapMargins.Right) / (SR.Width - FBitmapMargins.Left - FBitmapMargins.Right)) do
          for j := 0 to Ceil((LR.Height - FBitmapMargins.Bottom - FBitmapMargins.Top) / (SR.Height - FBitmapMargins.Bottom - FBitmapMargins.Top)) do
          begin
            R := TRectF.Create(LRUnscaled.Left + ScaledMargins.Left, LRUnscaled.Top + ScaledMargins.Top,
              LRUnscaled.Left + SRScaled.Width - ScaledMargins.Right, LRUnscaled.Top + SRScaled.Height - ScaledMargins.Bottom);
            OffsetRect(R, i * R.Width, j * R.Height);
            IntersectRect(IntersectionRect, TRectF.Create(LRUnscaled.Left + ScaledMargins.Left, LRUnscaled.Top + ScaledMargins.Top,
              LRUnscaled.Right - ScaledMargins.Right, LRUnscaled.Bottom - ScaledMargins.Bottom), R);
            Canvas.DrawBitmap(B, TRectF.Create(SR.Left + FBitmapMargins.Left, SR.Top + FBitmapMargins.Top, SR.Left + FBitmapMargins.Left + IntersectionRect.Width, SR.Top + FBitmapMargins.Top + IntersectionRect.Height),
              IntersectionRect, AOpacity, True);
          end;
      end
      else
      begin
        R := TRectF.Create(LRUnscaled.Left + ScaledMargins.Left, LRUnscaled.Top + ScaledMargins.Top, LRUnscaled.Right - ScaledMargins.Right, LRUnscaled.Bottom - ScaledMargins.Bottom);
        Canvas.DrawBitmap(B, TRectF.Create(SR.Left + FBitmapMargins.Left, SR.Top + FBitmapMargins.Top, SR.Right - FBitmapMargins.Right, SR.Bottom - FBitmapMargins.Bottom), R,
          AOpacity, True);
      end;
    end;
    if HorzMarginsOnly or VertMarginsOnly then
      Canvas.RestoreState(SaveState);
  end
  else
  begin
    case FWrapMode of
      TImageWrapMode.iwOriginal:
        begin
          R := TRectF.Create(LRUnscaled.Left, LRUnscaled.Top, LRUnscaled.Left + SRScaled.Width, LRUnscaled.Top + SRScaled.Height);
          IntersectRect(IntersectionRect, LRUnscaled, R);
          Canvas.DrawBitmap(B, TRectF.Create(SR.Left, SR.Top, SR.Left + IntersectionRect.Width * ScreenScale, SR.Top + IntersectionRect.Height * ScreenScale),
            IntersectionRect, AOpacity, HighSpeed)
        end;
      TImageWrapMode.iwFit:
        begin
          LR := TRectF.Create(0, 0, Width, Height);
          R := FSourceRect.Rect;
          R.Fit(LR);
          R.Left := Round(R.Left);
          R.Top := Round(R.Top);
          R.Right := Round(R.Right);
          R.Bottom := Round(R.Bottom);
          Canvas.DrawBitmap(B, SR, R, AOpacity, HighSpeed);
        end;
      TImageWrapMode.iwStretch:
        begin
          Canvas.DrawBitmap(B, SR, LRUnscaled, AOpacity, DisableInterpolation)
        end;
      TImageWrapMode.iwTile:
        begin
          for i := 0 to Ceil(LR.Width / SR.Width) do
            for j := 0 to Ceil(LR.Height / SR.Height) do
            begin
              R := TRectF.Create(LRUnscaled.Left, LRUnscaled.Top, LRUnscaled.Left + SRScaled.Width, LRUnscaled.Top + SRScaled.Height);
              OffsetRect(R, i * R.Width, j * R.Height);
              IntersectRect(IntersectionRect, LRUnscaled, R);
              Canvas.DrawBitmap(B, TRectF.Create(SR.Left, SR.Top, SR.Left + IntersectionRect.Width * ScreenScale, SR.Top + IntersectionRect.Height * ScreenScale),
                IntersectionRect, AOpacity, True)
            end;
        end;
      TImageWrapMode.iwCenter:
        begin
          R := RectF(0, 0, SR.Width / FBitmapScale, SR.Height / FBitmapScale);
          RectCenter(R, LRUnscaled);
          Canvas.DrawBitmap(B, SR, R, AOpacity, HighSpeed);
        end;
    end;
  end;
  Canvas.Blending := True;
end;

procedure TSubImage.Paint;
var
  R: TRectF;
begin
  DrawToCanvas(Canvas, LocalRect, AbsoluteOpacity);
  if (csDesigning in ComponentState) and not Locked and not FInPaintTo then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.DrawDashRect(R, 0, 0, AllCorners, AbsoluteOpacity, $A0909090);
  end;
end;

procedure TSubImage.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('BitmapScale', ReadBitmapScale, WriteBitmapScale, not SameValue(FBitmapScale, 1.0, Epsilon));
  Filer.DefineProperty('Opaque', ReadOpaque, WriteOpaque, Opaque);
end;

procedure TSubImage.ReadBitmapScale(Reader: TReader);
begin
  FBitmapScale := Reader.ReadFloat;
end;

procedure TSubImage.ReadOpaque(Reader: TReader);
begin
  FOpaque := Reader.ReadBoolean;
end;

procedure TSubImage.WriteBitmapScale(Writer: TWriter);
begin
  Writer.WriteFloat(FBitmapScale);
end;

procedure TSubImage.WriteOpaque(Writer: TWriter);
begin
  Writer.WriteBoolean(FOpaque);
end;

procedure TSubImage.RectChanged(Sender: TObject);
begin
  Repaint;
end;

procedure TSubImage.SetBitmapMargins(const Value: TBounds);
begin
  FBitmapMargins.Assign(Value);
end;

procedure TSubImage.SetMarginWrapMode(const Value: TImageWrapMode);
begin
  if FMarginWrapMode <> Value then
  begin
    FMarginWrapMode := Value;
    Repaint;
  end;
end;

procedure TSubImage.SetOpaque(const Value: Boolean);
begin
  if FOpaque <> Value then
  begin
    FOpaque := Value;
    Repaint;
  end;
end;

procedure TSubImage.SetSource(const Value: TImage);
begin
  if FSource <> Value then
  begin
    if Assigned(FSource) then
      FSource.RemoveFreeNotify(Self);
    FSource := Value;
    if Assigned(FSource) then
      FSource.AddFreeNotify(Self);
    Repaint;
  end;
end;

procedure TSubImage.SetSourceLookup(const Value: string);
var
  O: TFmxObject;
begin
  if FSourceLookup <> Value then
  begin
    FSourceLookup := Value;
    if FSourceLookup <> '' then
    begin
      O := FMX.Types.FindStyleResource(FSourceLookup);
      if O is TImage then
        Source := TImage(O);
    end;
  end;
end;

procedure TSubImage.SetSourceRect(const Value: TBounds);
begin
  FSourceRect.Assign(Value);
end;

procedure TSubImage.SetWrapMode(const Value: TImageWrapMode);
begin
  if FWrapMode <> Value then
  begin
    FWrapMode := Value;
    Repaint;
  end;
end;

{ TPath }

constructor TCustomPath.Create(AOwner: TComponent);
begin
  inherited;
  FWrapMode := TPathWrapMode.pwStretch;
  FData := TPathData.Create;
  FData.OnChanged := DoChanged;
  FCurrent := TPathData.Create;
end;

destructor TCustomPath.Destroy;
begin
  FreeAndNil(FCurrent);
  FreeAndNil(FData);
  inherited;
end;

procedure TCustomPath.UpdatePath;
var
  B: TRectF;
  P: TPathData;
begin
  { Update path }
  P := FData;
  if Assigned(FData.ResourcePath) then
    P := FData.ResourcePath;

  if not P.IsEmpty then
  begin
    case FWrapMode of
      TPathWrapMode.pwOriginal:
        begin
          FCurrent.Assign(P);
        end;
      TPathWrapMode.pwFit:
        begin
          B := P.GetBounds;
          B.Fit(ShapeRect);
          FCurrent.Assign(P);
          FCurrent.FitToRect(B);
        end;
      TPathWrapMode.pwStretch:
        begin
          B := P.GetBounds;
          FCurrent.Assign(P);
          FCurrent.Translate(-B.Left, -B.Top);
          FCurrent.Scale(RectWidth(ShapeRect) / RectWidth(B), RectHeight(ShapeRect) / RectHeight(B));
        end;
      TPathWrapMode.pwTile:
        begin
          B := P.GetBounds;
          FCurrent.Assign(P);
          FCurrent.Translate(-B.Left, -B.Top);
        end;
    end;
    if Stroke.Kind <> TBrushKind.bkNone then
      FCurrent.Translate(Stroke.Thickness / 2, Stroke.Thickness / 2);
  end
  else
    FCurrent.Clear;
end;

procedure TCustomPath.DoChanged(Sender: TObject);
begin
  UpdatePath;
  Repaint;
end;

function TCustomPath.GetPath: TPathData;
begin
  Result := FData;
end;

procedure TCustomPath.Loaded;
begin
  inherited;
  if not (csDestroying in ComponentState) then
    UpdatePath;
end;

function TCustomPath.PointInObject(X, Y: Single): Boolean;
begin
  if (csDesigning in ComponentState) and not FLocked and not FInPaintTo then
  begin
    Result := inherited PointInObject(X, Y);
  end
  else
  if Assigned(Canvas) and not (FCurrent.IsEmpty)
  and (FWrapMode <> TPathWrapMode.pwTile) then
  begin
    Result := Canvas.PtInPath(AbsoluteToLocal(PointF(X, Y)), FCurrent)
  end
  else
    Result := inherited PointInObject(X, Y);
end;

procedure TCustomPath.Resize;
begin
  inherited;
  UpdatePath;
end;

procedure TCustomPath.Paint;
var
  B, R: TRectF;
  i, j: Integer;
  State: TCanvasSaveState;
  P1: TPathData;
begin
  if not FCurrent.IsEmpty then
  begin
    case FWrapMode of
      TPathWrapMode.pwOriginal:
        begin
          State := Canvas.SaveState;
          try
            Canvas.IntersectClipRect(LocalRect);
            Canvas.FillPath(FCurrent, AbsoluteOpacity, FFill);
            Canvas.DrawPath(FCurrent, AbsoluteOpacity, FStroke);
          finally
            Canvas.RestoreState(State);
          end;
        end;
      TPathWrapMode.pwFit:
        begin
          Canvas.FillPath(FCurrent, AbsoluteOpacity, FFill);
          Canvas.DrawPath(FCurrent, AbsoluteOpacity, FStroke);
        end;
      TPathWrapMode.pwStretch:
        begin
          Canvas.FillPath(FCurrent, AbsoluteOpacity, FFill);
          Canvas.DrawPath(FCurrent, AbsoluteOpacity, FStroke);
        end;
      TPathWrapMode.pwTile:
        begin
          State := Canvas.SaveState;
          try
            Canvas.IntersectClipRect(LocalRect);

            B := FCurrent.GetBounds;
            R := B;
            P1 := TPathData.Create;
            try
              for i := 0 to Round(Width / RectWidth(R)) do
                for j := 0 to Round(Height / RectHeight(R)) do
                begin
                  P1.Assign(FCurrent);
                  P1.Translate(ShapeRect.Left + i * (RectWidth(R) + ShapeRect.Left * 2),
                    ShapeRect.Top + j * (RectHeight(R) + ShapeRect.Top * 2));
                  Canvas.FillPath(P1, AbsoluteOpacity, FFill);
                  Canvas.DrawPath(P1, AbsoluteOpacity, FStroke);
                end;
            finally
              if Assigned(P1) then
                P1.Free;
            end;
          finally
            Canvas.RestoreState(State);
          end;
        end;
    end;
  end;
  if (csDesigning in ComponentState) and not FLocked and not FInPaintTo then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.DrawDashRect(R, 0, 0, AllCorners, AbsoluteOpacity, $A0909090);
  end;
end;

procedure TCustomPath.SetWrapMode(const Value: TPathWrapMode);
begin
  if FWrapMode <> Value then
  begin
    FWrapMode := Value;
    UpdatePath;
    Repaint;
  end;
end;

procedure TCustomPath.SetPathData(const Value: TPathData);
begin
  FData.Assign(Value);
end;

{ TPaintBox }

constructor TPaintBox.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TPaintBox.Destroy;
begin
  inherited;
end;

procedure TPaintBox.Paint;
var
  R: TRectF;
begin
  if (csDesigning in ComponentState) and not FLocked and not FInPaintTo then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.DrawDashRect(R, 0, 0, AllCorners, AbsoluteOpacity, $A0909090);
  end;
  if Assigned(FOnPaint) then
    FOnPaint(Self, Canvas);
end;

{ TSelection }

constructor TSelection.Create(AOwner: TComponent);
begin
  inherited;
  AutoCapture := True;
  ParentBounds := True;
  FMinSize := 15;
  FGripSize := 3;
  SetAcceptsControls(False);
end;

destructor TSelection.Destroy;
begin
  inherited;
end;

function TSelection.GetAbsoluteRect: TRectF;
begin
  Result := inherited GetAbsoluteRect;
  InflateRect(Result, (FGripSize + 4) * Scale.X, (FGripSize + 4) * Scale.Y);
end;

function TSelection.GetProportionalSize(ASize: TPointF): TPointF;
begin
  Result := ASize ;
  if (FRatio * Result.Y)  > Result.X  then
  begin
    if Result.X < FMinSize then
      Result.X := FMinSize;
    Result.Y := Result.X / FRatio;
    if Result.Y < FMinSize then
    begin
      Result.Y := FMinSize ;
      Result.X := FMinSize * FRatio;
    end;
  end
  else
  begin
    if Result.Y < FMinSize then
      Result.Y := FMinSize;
    Result.X := Result.Y * FRatio;
    if Result.X < FMinSize then
    begin
      Result.X := FMinSize ;
      Result.Y := FMinSize / FRatio;
    end;
  end;
end;

procedure TSelection.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  R: TRectF;
begin
  // this line may be necessary because TSelection is not a styled control;
  // must further investigate for a better fix
  if not Enabled then
    Exit;

  inherited;

  FDownPos := PointF(X, Y);
  if Button = TMouseButton.mbLeft then
  begin
    FRatio := Width / Height;
    R := LocalRect;
    R := RectF(R.Left - (GripSize), R.Top - (GripSize), R.Left + (GripSize),
      R.Top + (GripSize));
    if R.Contains(FDownPos) then
    begin
      FLeftTop := True;
      Exit;
    end;
    R := LocalRect;
    R := RectF(R.Right - (GripSize), R.Top - (GripSize), R.Right + (GripSize),
      R.Top + (GripSize));
    if R.Contains(FDownPos) then
    begin
      FRightTop := True;
      Exit;
    end;
    R := LocalRect;
    R := RectF(R.Right - (GripSize), R.Bottom - (GripSize), R.Right + (GripSize),
      R.Bottom + (GripSize));
    if R.Contains(FDownPos) then
    begin
      FRightBottom := True;
      Exit;
    end;
    R := LocalRect;
    R := RectF(R.Left - (GripSize), R.Bottom - (GripSize), R.Left + (GripSize),
      R.Bottom + (GripSize));
    if R.Contains(FDownPos) then
    begin
      FLeftBottom := True;
      Exit;
    end;
    FMove := True;
  end;
end;

procedure TSelection.MouseMove(Shift: TShiftState; X, Y: Single);
var
  P, OldPos: TPointF;
  R: TRectF;
  LMoveVector : TVector ;
begin
  // this line may be necessary because TSelection is not a styled control;
  // must further investigate for a better fix
  if not Enabled then
    Exit;

  inherited;

  if Shift = [] then
  begin
    // handle painting for hotspot mouse hovering
    FMovePos := PointF(X, Y);
    P := LocalToAbsolute(FMovePos);
    if Assigned(ParentControl) then
      P := ParentControl.AbsoluteToLocal(P);

    R := LocalRect;
    R := RectF(R.Left - (GripSize), R.Top - (GripSize), R.Left + (GripSize),
      R.Top + (GripSize));
    if R.Contains(FMovePos) xor FLeftTopHot then
    begin
      FLeftTopHot := not FLeftTopHot;
      Repaint;
    end;

    R := LocalRect;
    R := RectF(R.Right - (GripSize), R.Top - (GripSize), R.Right + (GripSize),
      R.Top + (GripSize));
    if R.Contains(FMovePos) xor FRightTopHot then
    begin
      FRightTopHot := not FRightTopHot;
      Repaint;
    end;

    R := LocalRect;
    R := RectF(R.Right - (GripSize), R.Bottom - (GripSize), R.Right + (GripSize),
      R.Bottom + (GripSize));
    if R.Contains(FMovePos) xor FRightBottomHot then
    begin
      FRightBottomHot := not FRightBottomHot;
      Repaint;
    end;

    R := LocalRect;
    R := RectF(R.Left - (GripSize), R.Bottom - (GripSize), R.Left + (GripSize),
      R.Bottom + (GripSize));
    if R.Contains(FMovePos) xor FLeftBottomHot then
    begin
      FLeftBottomHot := not FLeftBottomHot;
      Repaint;
    end;
  end;
  if ssLeft in Shift then
  begin
    FMovePos := PointF(X, Y);
    if FMove then
    begin
      LMoveVector := Vector(X - FDownPos.X, Y - FDownPos.Y) ;
      LMoveVector := LocalToAbsoluteVector(LMoveVector);
      if Assigned(ParentControl) then
        LMoveVector := ParentControl.AbsoluteToLocalVector(LMoveVector);
      Position.Point := PointF(Position.X + LMoveVector.X, Position.Y + LMoveVector.Y);
      if ParentBounds then
      begin
        if Position.X < 0 then
          Position.X := 0;
        if Position.Y < 0 then
          Position.Y := 0;
        if Assigned(ParentControl) then
        begin
          if Position.X + Width > ParentControl.Width then
            Position.X := ParentControl.Width - Width;
          if Position.Y + Height > ParentControl.Height then
            Position.Y := ParentControl.Height - Height;
        end
        else
          if Assigned(Canvas) then
          begin
            if Position.X + Width > Canvas.Width then
              Position.X := Canvas.Width - Width;
            if Position.Y + Height > Canvas.Height then
              Position.Y := Canvas.Height - Height;
          end;
      end;
      if Assigned(FOnTrack) then
        FOnTrack(Self);
      Exit;
    end;

    OldPos := Position.Point;
    P := LocalToAbsolute(FMovePos);
    if Assigned(ParentControl) then
      P := ParentControl.AbsoluteToLocal(P);
    if ParentBounds then
    begin
      if P.Y < 0 then
        P.Y := 0;
      if P.X < 0 then
        P.X := 0;
      if Assigned(ParentControl) then
      begin
        if P.X > ParentControl.Width then
          P.X := ParentControl.Width;
        if P.Y > ParentControl.Height then
          P.Y := ParentControl.Height;
      end
      else
        if Assigned(Canvas) then
        begin
          if P.X > Canvas.Width then
            P.X := Canvas.Width;
          if P.Y > Canvas.Height then
            P.Y := Canvas.Height;
        end;
    end;
    if FLeftTop then
      DoLeftTopMove(X,Y);
    if FLeftBottom then
      DoLeftBottomMove(X,Y);
    if FRightTop then
      DoRightTopMove(X,Y);
    if FRightBottom then
      DoRightBottomMove(X,Y);
  end;
end;

function TSelection.PointInObjectLocal(X, Y: Single): Boolean;
var
  R: TRectF;
  P: TPointF;
begin
  Result := inherited PointInObjectLocal(X, Y);
  if not Result then
  begin
    P := PointF(X,Y);
    R := LocalRect;
    R := RectF(R.Left - (GripSize), R.Top - (GripSize), R.Left + (GripSize),
      R.Top + (GripSize));
    if R.Contains(P) then
    begin
      Result := True;
      Exit;
    end;
    R := LocalRect;
    R := RectF(R.Right - (GripSize), R.Top - (GripSize), R.Right + (GripSize),
      R.Top + (GripSize));
    if R.Contains(P) then
    begin
      Result := True;
      Exit;
    end;
    R := LocalRect;
    R := RectF(R.Right - (GripSize), R.Bottom - (GripSize), R.Right + (GripSize),
      R.Bottom + (GripSize));
    if R.Contains(P) then
    begin
      Result := True;
      Exit;
    end;
    R := LocalRect;
    R := RectF(R.Left - (GripSize), R.Bottom - (GripSize), R.Left + (GripSize),
      R.Bottom + (GripSize));
    if R.Contains(P) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

procedure TSelection.ReSetInSpace(ARotationPoint, ASize: TPointF);
var
  LLocalPos: TPointF;
begin
  if Assigned(ParentControl) then
  begin
    LLocalPos := ParentControl.AbsoluteToLocal(ARotationPoint);
    LLocalPos.X := LLocalPos.X - ASize.X * RotationCenter.X;
    LLocalPos.Y := LLocalPos.Y - ASize.Y * RotationCenter.Y;
    if ParentBounds then
    begin
      if (LLocalPos.X < 0) then
      begin
        ASize.X := ASize.X + LLocalPos.X;
        LLocalPos.X := 0;
      end;
      if (LLocalPos.Y < 0) then
      begin
        ASize.Y := ASize.Y + LLocalPos.Y;
        LLocalPos.Y := 0;
      end;
      if (LLocalPos.X + ASize.X > ParentControl.Width) then
        ASize.X := ParentControl.Width - LLocalPos.X;
      if (LLocalPos.Y + ASize.Y > ParentControl.Height) then
        ASize.Y := ParentControl.Height - LLocalPos.Y;
    end;
  end
  else
  begin
    LLocalPos.X := ARotationPoint.X - ASize.X * RotationCenter.X;
    LLocalPos.Y := ARotationPoint.Y - ASize.Y * RotationCenter.Y;
  end;
  Width := ASize.X;
  Height := ASize.Y;
  Position.Point := LLocalPos;
end;

procedure TSelection.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  // this line may be necessary because TSelection is not a styled control;
  // must further investigate for a better fix
  if not Enabled then
    Exit;

  inherited;

  if FMove or FLeftTop or FLeftBottom or FRightTop or FRightBottom then
  begin
    if Assigned(FOnChange) then
      FOnChange(Self);

    FMove := False;
    FLeftTop := False;
    FLeftBottom := False;
    FRightTop := False;
    FRightBottom := False;
  end;
end;

procedure TSelection.Paint;
var
  R: TRectF;
  Fill: TBrush;

  // sets the canvas color depending if the control is enabled and if
  // we need to draw a zone being hot or not
  procedure SelectZoneColor(HotZone: Boolean);
  begin
    if Enabled then
      if HotZone then
        Fill.Color := claRed
      else
        Fill.Color := $FFFFFFFF
    else
      Fill.Color := claGrey;
  end;

var
  Stroke: TStrokeBrush;
begin
  if FHideSelection then
    Exit;
  R := LocalRect;
  InflateRect(R, -0.5, -0.5);
  Canvas.DrawDashRect(R, 0, 0, AllCorners, AbsoluteOpacity, $FF1072C5);

  { angles }
  Fill := TBrush.Create(TBrushKind.bkSolid, claWhite);
  Stroke := TStrokeBrush.Create(TBrushKind.bkSolid, $FF1072C5);
  try
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    SelectZoneColor(FLeftTopHot);
    Canvas.FillEllipse(RectF(R.Left - (GripSize), R.Top - (GripSize),
      R.Left + (GripSize), R.Top + (GripSize)), AbsoluteOpacity, Fill);
    Canvas.DrawEllipse(RectF(R.Left - (GripSize), R.Top - (GripSize),
      R.Left + (GripSize), R.Top + (GripSize)), AbsoluteOpacity, Stroke);

    R := LocalRect;
    SelectZoneColor(FRightTopHot);
    Canvas.FillEllipse(RectF(R.Right - (GripSize), R.Top - (GripSize),
      R.Right + (GripSize), R.Top + (GripSize)), AbsoluteOpacity, Fill);
    Canvas.DrawEllipse(RectF(R.Right - (GripSize), R.Top - (GripSize),
      R.Right + (GripSize), R.Top + (GripSize)), AbsoluteOpacity, Stroke);

    R := LocalRect;
    SelectZoneColor(FLeftBottomHot);
    Canvas.FillEllipse(RectF(R.Left - (GripSize), R.Bottom - (GripSize),
      R.Left + (GripSize), R.Bottom + (GripSize)), AbsoluteOpacity, Fill);
    Canvas.DrawEllipse(RectF(R.Left - (GripSize), R.Bottom - (GripSize),
      R.Left + (GripSize), R.Bottom + (GripSize)), AbsoluteOpacity, Stroke);

    R := LocalRect;
    SelectZoneColor(FRightBottomHot);
    Canvas.FillEllipse(RectF(R.Right - (GripSize), R.Bottom - (GripSize),
      R.Right + (GripSize), R.Bottom + (GripSize)), AbsoluteOpacity, Fill);
    Canvas.DrawEllipse(RectF(R.Right - (GripSize), R.Bottom - (GripSize),
      R.Right + (GripSize), R.Bottom + (GripSize)), AbsoluteOpacity, Stroke);
  finally
    Fill.Free;
    Stroke.Free;
  end;
end;

procedure TSelection.DoLeftBottomMove(AX, AY: Single);
var
  LRotationPoint : TPointF ;
  LSize, LOldSize, LCorrect : TPointF ;
begin
  Repaint;
  LOldSize.Y := Height ;
  LOldSize.X := Width ;
  if AY < FMinSize then
  begin
    LSize.Y := FMinSize ;
    AY := LSize.Y ;
  end
  else
    LSize.Y := AY;
  if LOldSize.X - AX < FMinSize then
  begin
    LSize.X  := FMinSize ;
    AX := LOldSize.X - LSize.X ;
  end
  else
    LSize.X  := LOldSize.X - AX ;
  if FProportional then
  begin
    if FRatio = 0 then
      FRatio := LOldSize.X/LOldSize.Y ;
    LCorrect := LSize ;
    LSize := GetProportionalSize(LSize) ;
    LCorrect.X := LCorrect.X - LSize.X ;
    LCorrect.Y := LCorrect.Y - LSize.Y ;
    AX := AX + LCorrect.X ;
    AY := AY + LCorrect.Y ;
  end;
  LRotationPoint.X := LOldSize.X * RotationCenter.X
    + (AX) * (1 - RotationCenter.X) ;
  LRotationPoint.Y := LOldSize.Y * RotationCenter.Y
    + (AY - LOldSize.Y) * (RotationCenter.Y) ;
  LRotationPoint := LocalToAbsolute(LRotationPoint) ;
  ReSetInSpace(LRotationPoint, LSize);
  if Assigned(FOnTrack) then
    FOnTrack(Self);
  Repaint;
end;

procedure TSelection.DoLeftTopMove(AX, AY: Single);
var
  LRotationPoint : TPointF ;
  LSize, LOldSize, LCorrect : TPointF ;
begin
  Repaint;
  LOldSize.Y := Height ;
  LOldSize.X := Width ;
  if (LOldSize.Y - AY) < FMinSize then
  begin
    LSize.Y := FMinSize ;
    AY := LOldSize.Y - LSize.Y ;
  end
  else
    LSize.Y := LOldSize.Y - AY;
  if (LOldSize.X - AX) < FMinSize then
  begin
    LSize.X  := FMinSize ;
    AX := LOldSize.X - LSize.X ;
  end
  else
    LSize.X  := LOldSize.X - AX ;
  if FProportional then
  begin
    if FRatio = 0 then
      FRatio := LOldSize.X/LOldSize.Y ;
    LCorrect := LSize ;
    LSize := GetProportionalSize(LSize) ;
    LCorrect.X := LCorrect.X - LSize.X ;
    LCorrect.Y := LCorrect.Y - LSize.Y ;
    AX := AX + LCorrect.X ;
    AY := AY + LCorrect.Y ;
  end;
  LRotationPoint.X := LOldSize.X * RotationCenter.X
    + (AX) * (1 - RotationCenter.X) ;
  LRotationPoint.Y := LOldSize.Y * RotationCenter.Y
    + (AY) * (1 - RotationCenter.Y) ;
  LRotationPoint := LocalToAbsolute(LRotationPoint) ;
  ReSetInSpace(LRotationPoint, LSize);
  if Assigned(FOnTrack) then
    FOnTrack(Self);
  Repaint;
end;

procedure TSelection.DoMouseLeave;
begin
  inherited;

  FLeftTopHot := False;
  FLeftBottomHot := False;
  FRightTopHot := False;
  FRightBottomHot := False;

  Repaint;
end;

procedure TSelection.DoRightBottomMove(AX, AY: Single);
var
  LRotationPoint : TPointF ;
  LSize, LOldSize, LCorrect : TPointF ;
begin
  Repaint;
  LOldSize.Y := Height ;
  LOldSize.X := Width ;
  if AY < FMinSize then
  begin
    LSize.Y := FMinSize ;
    AY := LSize.Y ;
  end
  else
    LSize.Y := AY;
  if AX < FMinSize then
  begin
    LSize.X  := FMinSize ;
    AX := LSize.X ;
  end
  else
    LSize.X  := AX ;
  if FProportional then
  begin
    if FRatio = 0 then
      FRatio := LOldSize.X/LOldSize.Y ;
    LCorrect := LSize ;
    LSize := GetProportionalSize(LSize) ;
    LCorrect.X := LCorrect.X - LSize.X ;
    LCorrect.Y := LCorrect.Y - LSize.Y ;
    AX := AX - LCorrect.X ;
    AY := AY - LCorrect.Y ;
  end;
  LRotationPoint.X := LOldSize.X * RotationCenter.X
    + (AX - LOldSize.X) * (RotationCenter.X) ;
  LRotationPoint.Y := LOldSize.Y * RotationCenter.Y
    + (AY - LOldSize.Y) * (RotationCenter.Y) ;
  LRotationPoint := LocalToAbsolute(LRotationPoint) ;
  ReSetInSpace(LRotationPoint, LSize);
  if Assigned(FOnTrack) then
    FOnTrack(Self);
  Repaint;
end;

procedure TSelection.DoRightTopMove(AX, AY: Single);
var
  LRotationPoint : TPointF ;
  LSize, LOldSize, LCorrect : TPointF ;
begin
  Repaint;
  LOldSize.Y := Height ;
  LOldSize.X := Width ;
  if (LOldSize.Y - AY) < FMinSize then
  begin
    LSize.Y := FMinSize ;
    AY := LOldSize.Y - LSize.Y ;
  end
  else
    LSize.Y := LOldSize.Y - AY;
  if AX  < FMinSize then
  begin
    LSize.X  := FMinSize ;
    AX := LSize.X ;
  end
  else
    LSize.X  := AX ;
  if FProportional then
  begin
    if FRatio = 0 then
      FRatio := LOldSize.X/LOldSize.Y ;
    LCorrect := LSize ;
    LSize := GetProportionalSize(LSize) ;
    LCorrect.X := LCorrect.X - LSize.X ;
    LCorrect.Y := LCorrect.Y - LSize.Y ;
    AX := AX - LCorrect.X ;
    AY := AY + LCorrect.Y ;
  end;
  LRotationPoint.X := LOldSize.X * RotationCenter.X
    + (AX - LOldSize.X) * (RotationCenter.X) ;
  LRotationPoint.Y := LOldSize.Y * RotationCenter.Y
    + (AY) * (1 - RotationCenter.Y) ;
  LRotationPoint := LocalToAbsolute(LRotationPoint) ;
  ReSetInSpace(LRotationPoint, LSize);
  if Assigned(FOnTrack) then
    FOnTrack(Self);
  Repaint;
end;

procedure TSelection.SetHideSelection(const Value: Boolean);
begin
  if FHideSelection <> Value then
  begin
    FHideSelection := Value;
    Repaint;
  end;
end;

procedure TSelection.SetMinSize(const Value: Integer);
begin
  if FMinSize <> Value then
  begin
    FMinSize := Value;
    if FMinSize < 1 then
      FMinSize := 1;
  end;
end;

procedure TSelection.SetGripSize(const Value: Single);
begin
  if FGripSize <> Value then
  begin
    FGripSize := Value;
    if FGripSize > 20 then
      FGripSize := 20;
    if FGripSize < 1 then
      FGripSize := 1;
    Repaint;
  end;
end;

{ TSelectionPoint }

procedure TSelectionPoint.ApplyStyle;
begin
  inherited ApplyStyle;
  FStylized := True;
end;

constructor TSelectionPoint.Create(AOwner: TComponent);
begin
  inherited;
  AutoCapture := True;
  ParentBounds := True;
  FGripSize := 3;
  FStylized := False;
  Width := FGripSize * 2;
  Height := FGripSize * 2;
  SetAcceptsControls(False);
end;

destructor TSelectionPoint.Destroy;
begin
  inherited;
end;

function TSelectionPoint.PointInObjectLocal(X, Y: Single): Boolean;
var
  GripSizeTmp: Single;
begin
  Result := False;
  if FStylized and Assigned(ResourceControl) then
    GripSizeTmp := ResourceControl.Width / 2
  else
    GripSizeTmp := GripSize;

  if (Abs(X) <= GripSizeTmp) and (Abs(Y) <= GripSizeTmp) then
    Result := True;
end;

procedure TSelectionPoint.Paint;
var
  Fill: TBrush;
  Stroke: TStrokeBrush;
  FillColor: TAlphaColor;
begin
  inherited Paint;
  if not FStylized then
  begin
    Canvas.Stroke.Thickness := 1;
    Canvas.Stroke.Kind := TBrushKind.bkSolid;
    Canvas.Stroke.Color := $FF1072C5;
    Canvas.Fill.Kind := TBrushKind.bkSolid;

    if IsMouseOver then
      FillColor := claRed
    else
      FillColor := claWhite;
    Stroke := TStrokeBrush.Create(TBrushKind.bkSolid, $FF1072C5);
    try
      Fill := TBrush.Create(TBrushKind.bkSolid, FillColor);
      try
        Canvas.FillEllipse(RectF(-(GripSize), -(GripSize), (GripSize), (GripSize)),
          AbsoluteOpacity, Fill);
        Canvas.DrawEllipse(RectF(-(GripSize), -(GripSize), (GripSize), (GripSize)),
          AbsoluteOpacity, Stroke);
      finally
        Fill.Free;
      end;
    finally
      Stroke.Free;
    end;
  end;
end;

procedure TSelectionPoint.SetHeight(const Value: Single);
begin
  if FStylized then
    inherited SetHeight(Value)
  else
    inherited SetHeight(FGripSize * 2);
end;

procedure TSelectionPoint.SetWidth(const Value: Single);
begin
  if FStylized then
    inherited SetWidth(Value)
  else
    inherited SetWidth(FGripSize * 2);
end;

procedure TSelectionPoint.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if Button = TMouseButton.mbLeft then
    FPressed := True;
end;

procedure TSelectionPoint.MouseMove(Shift: TShiftState; X, Y: Single);
var
  P: TPointF;
begin
  inherited;
  if FPressed and Assigned(ParentControl) then
  begin
    P := LocalToAbsolute(PointF(X, Y));
    P := ParentControl.AbsoluteToLocal(P);
    if ParentBounds then
    begin
      if P.X < 0 then
        P.X := 0;
      if P.Y < 0 then
        P.Y := 0;
      if Assigned(ParentControl) then
      begin
        if P.X > ParentControl.Width then
          P.X := ParentControl.Width;
        if P.Y > ParentControl.Height then
          P.Y := ParentControl.Height;
      end
      else
        if Assigned(Canvas) then
        begin
          if P.X > Canvas.Width then
            P.X := Canvas.Width;
          if P.Y > Canvas.Height then
            P.Y := Canvas.Height;
        end;
    end;
    DoChangeTracking(P.X, P.Y);
    Position.X := P.X;
    Position.Y := P.Y;
  end;
end;

procedure TSelectionPoint.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if FPressed then
    DoChange;
  FPressed := False;
end;

procedure TSelectionPoint.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TSelectionPoint.DoChangeTracking(var X, Y: Single);
begin
  if Assigned(FOnChangeTrack) then
    FOnChangeTrack(Self, X, Y);
end;

procedure TSelectionPoint.DoMouseEnter;
begin
  inherited;
  Repaint;
end;

procedure TSelectionPoint.DoMouseLeave;
begin
  inherited;
  Repaint;
end;

procedure TSelectionPoint.FreeStyle;
begin
  inherited FreeStyle;
  FStylized := False;
end;

function TSelectionPoint.GetUpdateRect: TRectF;
var
  RecalcNeeded: Boolean;
begin
  RecalcNeeded := FRecalcUpdateRect;
  inherited GetUpdateRect;
  if RecalcNeeded then
    if FStylized and Assigned(ResourceControl) then
      InflateRect(FUpdateRect, AbsoluteScale.X * (ResourceControl.Width / 2),
                          AbsoluteScale.Y * (ResourceControl.Height / 2))
    else
      InflateRect(FUpdateRect, AbsoluteScale.X * (GripSize + 1), AbsoluteScale.Y * (GripSize + 1));
  Result := FUpdateRect;
end;

procedure TSelectionPoint.SetGripSize(const Value: Single);
begin
  if FGripSize <> Value then
  begin
    FGripSize := Value;
    if FGripSize > 20 then
      FGripSize := 20;
    if FGripSize < 1 then
      FGripSize := 1;
    Repaint;
  end;
end;


initialization
  RegisterFmxClasses([TLine, TRectangle, TRoundRect, TEllipse, TCircle, TArc,
    TPie, TText, TPath, TImage, TSubImage, TPaintBox, TCalloutRectangle,
    TSelection, TSelectionPoint]);
  RegisterFlasherClass(TCaretRectangle, TCaret);
end.


