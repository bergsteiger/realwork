{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Objects;

{$H+}

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.UITypes, System.Classes, System.Rtti, System.Messaging, FMX.Types, FMX.Controls, FMX.TextLayout,
  FMX.Platform, FMX.Graphics, FMX.MultiResBitmap;

type

{ TShape }

  TShape = class(TControl)
  private
    FFill: TBrush;
    FStroke: TStrokeBrush;
    procedure SetFill(const Value: TBrush);
    procedure SetStroke(const Value: TStrokeBrush);
  protected
    procedure Painting; override;
    procedure FillChanged(Sender: TObject); virtual;
    procedure StrokeChanged(Sender: TObject); virtual;
    function GetShapeRect: TRectF;
    function DoGetUpdateRect: TRectF; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Fill: TBrush read FFill write SetFill;
    property Stroke: TStrokeBrush read FStroke write SetStroke;
    property ShapeRect: TRectF read GetShapeRect;
  end;

{ TLine }

  TLineType = (Diagonal, Top, Left, Bottom, Right);

  /// <summary>Specifies the way a line is drawn.</summary>
  TLineLocation = (Boundary, Inner, InnerWithin);

  TLineTypeHelper = record helper for TLineType
  const
    ltDiagonal = TLineType.Diagonal deprecated 'Use TLineType.Diagonal';
    ltTop = TLineType.Top deprecated 'Use TLineType.Top';
    ltLeft = TLineType.Left deprecated 'Use TLineType.Left';
  end;

  TLine = class(TShape)
  private
    FLineType: TLineType;
    FShortenLine: Boolean;
    FLineLocation: TLineLocation;
    procedure SetLineType(const Value: TLineType);
    procedure SetShortenLine(const AValue: Boolean);
    procedure SetLineLocation(const AValue: TLineLocation);
  protected
    function DoGetUpdateRect: TRectF; override;
    function IsControlRectEmpty: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
  published
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default True;
    /// <summary>Location of th drawing line, see TLineLocation for more information.</summary>
    property LineLocation: TLineLocation read FLineLocation write SetLineLocation default TLineLocation.Boundary;
    property LineType: TLineType read FLineType write SetLineType;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    /// <summary>If True, the line will be shortened its thickness divided by two.</summary>
    property ShortenLine: Boolean read FShortenLine write SetShortenLine default False;
    property Size;
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
      default TCornerType.Round;
    property Cursor default crDefault;
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
    property Size;
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
    function GetDefaultSize: TSizeF; override;
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
    property Size;
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
  end;

{ TCalloutRectangle }

  TCalloutPosition = (Top, Left, Bottom, Right);

  TCalloutPositionHelper = record helper for TCalloutPosition
  const
    cpTop = TCalloutPosition.Top deprecated 'Use TCalloutPosition.Top';
    cpLeft = TCalloutPosition.Left deprecated 'Use TCalloutPosition.Left';
    cpBottom = TCalloutPosition.Bottom deprecated 'Use TCalloutPosition.Bottom';
    cpRight = TCalloutPosition.Right deprecated 'Use TCalloutPosition.Right';
  end;

  TCalloutRectangle = class(TRectangle)
  private
    FPath: TPathData;
    FFillPath: TPathData;
    FCalloutWidth: Single;
    FCalloutLength: Single;
    FCalloutPosition: TCalloutPosition;
    FCalloutOffset: Single;
    procedure SetCalloutWidth(const Value: Single);
    procedure SetCalloutLength(const Value: Single);
    procedure SetCalloutPosition(const Value: TCalloutPosition);
    procedure SetCalloutOffset(const Value: Single);
  protected
    procedure RebuildPaths;
    { inherited }
    procedure SetXRadius(const Value: Single); override;
    procedure SetYRadius(const Value: Single); override;
    procedure SetCorners(const Value: TCorners); override;
    procedure SetCornerType(const Value: TCornerType); override;
    procedure SetSides(const Value: TSides); override;
    procedure Resize; override;
    procedure Loaded; override;
    { Building Path }
    function GetCalloutRectangleRect: TRectF;
    procedure AddCalloutToPath(APath: TPathData; const ARect: TRectF; const ACornerRadiuses: TSizeF);
    procedure AddRoundCornerToPath(APath: TPathData; const ARect: TRectF; const ACornerSize: TSizeF; const ACorner: TCorner);
    procedure AddRectCornerToPath(APath: TPathData; const ARect: TRectF; const ACornerSize: TSizeF; const ACorner: TCorner;
      const ASkipEmptySide: Boolean = True);
    procedure CreatePath;
    procedure CreateFillPath;
    { Painting }
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Fill;
    property CalloutWidth: Single read FCalloutWidth write SetCalloutWidth;
    property CalloutLength: Single read FCalloutLength write SetCalloutLength;
    property CalloutPosition: TCalloutPosition read FCalloutPosition  write SetCalloutPosition
      default TCalloutPosition.Top;
    property CalloutOffset: Single read FCalloutOffset write SetCalloutOffset;
    property Stroke;
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
    property Size;
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

  TPathWrapMode = (Original, Fit, Stretch, Tile);

  TPathWrapModeHelper = record helper for TPathWrapMode
  const
    pwOriginal = TPathWrapMode.Original deprecated 'Use TPathWrapMode.Original';
    pwFit = TPathWrapMode.Fit deprecated 'Use TPathWrapMode.Fit';
    pwStretch = TPathWrapMode.Stretch deprecated 'Use TPathWrapMode.Stretch';
    pwTile = TPathWrapMode.Tile deprecated 'Use TPathWrapMode.Tile';
  end;

{ TCustomPath }

  TCustomPath = class(TShape, IPathObject)
  private
    FData: TPathData;
    FCurrent: TPathData;
    FWrapMode: TPathWrapMode;
    FNeedUpdate: Boolean;
    procedure SetWrapMode(const Value: TPathWrapMode);
    procedure SetPathData(const Value: TPathData);
    { IPathObject }
    function GetPath: TPathData;
  protected
    procedure StrokeChanged(Sender: TObject); override;
    procedure DoChanged(Sender: TObject);
    procedure Paint; override;
    procedure Resize; override;
    procedure Loaded; override;
    procedure UpdateCurrent;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function PointInObject(X, Y: Single): Boolean; override;
    property Data: TPathData read FData write SetPathData;
    property WrapMode: TPathWrapMode read FWrapMode write SetWrapMode default TPathWrapMode.Stretch;
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
    property Size;
    property Stroke;
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

  TText = class(TControl, ITextSettings, IObjectState)
  protected type
    /// <summary>Accelerator key drawing information.</summary>
    TAcceleratorInfo = class
    private
      FBrush: TStrokeBrush;
      function GetBrush: TStrokeBrush;
    strict private
      FKeyIndex: Integer;
      FIsUnderlineValid: Boolean;
      FUnderlineBeginPoint: TPointF;
      FUnderlineEndPoint: TPointF;
      procedure SetKeyIndex(const Value: Integer);
      function ValidateUnderlinePoints(const AnOwnerControl: TControl; const ACanvas: TCanvas;
        const ALayout: TTextLayout): Boolean;
    public
      destructor Destroy; override;
      /// <summary>Method to indicate that the underline needs to be redrawn.</summary>
      procedure InvalidateUnderline;
      /// <summary>Draws the underline unside the character that holds the accelerator.</summary>
      function DrawUnderline(const AnOwnerControl: TControl; const ACanvas: TCanvas; const ALayout: TTextLayout;
        const AColor: TAlphaColor; const AnOpacity: Single): Boolean;
      /// <summary>Index of the accelerator key.</summary>
      property KeyIndex: Integer read FKeyIndex write SetKeyIndex;
      /// <summary>True if the underline is already generated.</summary>
      property IsUnderlineValid: Boolean read FIsUnderlineValid;
      /// <summary>This brush is used to draw the underline down the accelerator key character.</summary>
      property Brush: TStrokeBrush read GetBrush;
    end;

  private
    FTextSettings: TTextSettings;
    FDefaultTextSettings: TTextSettings;
    FStyledSettings: TStyledSettings;
    FSavedTextSettings: TTextSettings;
    FLayout: TTextLayout;
    FAutoSize: Boolean;
    FStretch: Boolean;
    FIsChanging: Boolean;
    FAcceleratorKeyInfo: TAcceleratorInfo;
    procedure SetText(const Value: string);
    procedure SetFont(const Value: TFont);
    procedure SetHorzTextAlign(const Value: TTextAlign);
    procedure SetVertTextAlign(const Value: TTextAlign);
    procedure SetWordWrap(const Value: Boolean);
    procedure SetAutoSize(const Value: Boolean);
    procedure SetStretch(const Value: Boolean);
    procedure SetColor(const Value: TAlphaColor);
    procedure SetTrimming(const Value: TTextTrimming);
    procedure OnFontChanged(Sender: TObject);
    { ITextSettings }
    function GetDefaultTextSettings: TTextSettings;
    function GetTextSettings: TTextSettings;
    function ITextSettings.GetResultingTextSettings = GetTextSettings;
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
    procedure FontChanged; virtual;
    function ConvertText(const Value: string): string; virtual;
    function SupportsPaintStage(const Stage: TPaintStage): Boolean; override;
    function GetTextSettingsClass: TTextSettingsClass; virtual;
    procedure Paint; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure DoRealign; override;
    procedure AdjustSize;
    procedure Resize; override;
    procedure Loaded; override;
    property Layout: TTextLayout read FLayout;
    procedure UpdateDefaultTextSettings; virtual;
    { IObjectState }
    function SaveState: Boolean; virtual;
    function RestoreState: Boolean; virtual;
    /// <summary>Remove the accelerator key information in the control.</summary>
    procedure RemoveAcceleratorKeyInfo;
    /// <summary>Accelerator key underline drawing information.</summary>
    property AcceleratorKeyInfo: TAcceleratorInfo read FAcceleratorKeyInfo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure SetBounds(X, Y, AWidth, AHeight: Single); override;
    property Font: TFont read GetFont write SetFont;
    property Color: TAlphaColor read GetColor write SetColor;
    property HorzTextAlign: TTextAlign read GetHorzTextAlign write SetHorzTextAlign;
    property Trimming: TTextTrimming read GetTrimming write SetTrimming;
    property VertTextAlign: TTextAlign read GetVertTextAlign write SetVertTextAlign;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap;
  published
    property Align;
    property Anchors;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default False;
    property ClipChildren default False;
    property ClipParent default False;
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
    property Stretch: Boolean read FStretch write SetStretch default False;
    property Text: string read GetText write SetText;
    property TextSettings: TTextSettings read GetTextSettings write SetTextSettings;
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
  end;

{ TImage }

  TImage = class;

  TImageMultiResBitmap = class (TFixedMultiResBitmap)
  private
    [Weak] FImage: TImage;
  protected
    procedure Update(Item: TCollectionItem); override;
    function GetDefaultSize: TSize; override;
  end;

  /// <summary> Specifies whether and how to resize, replicate, and position the image for rendering the control surface.</summary>
  TImageWrapMode = (
    /// <summary> Display the image with its original dimensions. </summary>
    Original,
    /// <summary> Stretches image into the LocalRect, preserving aspect ratio. When LocalRect
    /// is bigger than image, the last one will be stretched to fill LocalRect </summary>
    Fit,
    /// <summary> Stretch the image to fill the entire control's rectangle.</summary>
    Stretch,
    /// <summary> Tile (multiply) the image to cover the entire control's rectangle. </summary>
    Tile,
    /// <summary> Center the image to the control's rectangle. </summary>
    Center,
    /// <summary> Places the image inside the LocalRect. If the image is greater
    /// than the LocalRect then the source rectangle is scaled with aspect ratio.
    /// </summary>
    Place
  );

  TImageWrapModeHelper = record helper for TImageWrapMode
  const
    iwOriginal = TImageWrapMode.Original deprecated 'Use TImageWrapMode.Original';
    iwFit = TImageWrapMode.Fit deprecated 'Use TImageWrapMode.Fit';
    iwStretch = TImageWrapMode.Stretch deprecated 'Use TImageWrapMode.Stretch';
    iwTile = TImageWrapMode.Tile deprecated 'Use TImageWrapMode.Tile';
    iwCenter = TImageWrapMode.Center deprecated 'Use TImageWrapMode.Center';
  end;

  TImage = class(TControl, IBitmapObject, IMultiResBitmapObject)
  private
    FData: TValue;
    FBitmapMargins: TBounds;
    FWrapMode: TImageWrapMode;
    FDisableInterpolation: Boolean;
    FMarginWrapMode: TImageWrapMode;
    FScaleChangedId: Integer;
    FMultiResBitmap: TFixedMultiResBitmap;
    FScreenScale: Single;
    FCurrentScale: Single;
    [weak] FCurrentBitmap: TBitmap;
    FCurrentBitmapUpdating: Boolean;
    procedure SetBitmap(const Value: TBitmap);
    procedure SetWrapMode(const Value: TImageWrapMode);
    procedure SetBitmapMargins(const Value: TBounds);
    procedure SetMarginWrapMode(const Value: TImageWrapMode);
    procedure ScaleChangedHandler(const Sender: TObject; const Msg: TMessage);
    { IBitmapObject }
    function GetBitmap: TBitmap;
    procedure ReadBitmap(Stream: TStream);
    procedure ReadHiBitmap(Stream: TStream);
    procedure SetMultiResBitmap(const Value: TFixedMultiResBitmap);
    procedure UpdateCurrentBitmap;
    { IMultiResBitmapObject }
    function GetMultiResBitmap: TCustomMultiResBitmap;
  protected
    procedure DoChanged; virtual;
    procedure Paint; override;
    procedure DrawWithMargins(const Canvas: TCanvas; const ARect: TRectF; const ABitmap: TBitmap;
      const AOpacity: Single = 1.0);
    /// <summary> This function tries to find the item in <b>MultiResBitmap</b>, which have the most suitable scale
    /// (see Scene.GetSceneScale).
    /// If <b>IncludeEmpty</b> is true then then returned item can be empty otherwise the empty items are ignored
    /// </summary>
    /// <returns> If successful, the item from the property <b>MultiResBitmap</b> otherwise <c>nil</c> </returns>
    function ItemForCurrentScale(const IncludeEmpty: Boolean): TCustomBitmapItem;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    function CreateMultiResBitmap: TFixedMultiResBitmap; virtual;
    procedure DefineProperties(Filer: TFiler); override;
    function MultiResBitmapStored: Boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DrawBitmap(const Canvas: TCanvas; const ARect: TRectF; const ABitmap: TBitmap; const AOpacity: Single = 1.0);
    property Bitmap: TBitmap read GetBitmap write SetBitmap;
  published
    property MultiResBitmap: TFixedMultiResBitmap read FMultiResBitmap write SetMultiResBitmap stored MultiResBitmapStored;
    property Align;
    property Anchors;
    property BitmapMargins: TBounds read FBitmapMargins write SetBitmapMargins;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DisableInterpolation: Boolean read FDisableInterpolation write FDisableInterpolation default False;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property Hint;
    property HitTest default True;
    property Padding;
    property MarginWrapMode: TImageWrapMode read FMarginWrapMode write SetMarginWrapMode default TImageWrapMode.Stretch;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property Visible default True;
    property Width;
    property WrapMode: TImageWrapMode read FWrapMode write SetWrapMode default TImageWrapMode.Fit;
    property ParentShowHint;
    property ShowHint;
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
  public const
    DefaultColor = $FF1072C5;
  public type
    TGrabHandle = (None, LeftTop, RightTop, LeftBottom, RightBottom);
  private
    FParentBounds: Boolean;
    FOnChange: TNotifyEvent;
    FHideSelection: Boolean;
    FMinSize: Integer;
    FOnTrack: TNotifyEvent;
    FProportional: Boolean;
    FGripSize: Single;
    FRatio: Single;
    FActiveHandle: TGrabHandle;
    FHotHandle: TGrabHandle;
    FDownPos: TPointF;
    FShowHandles: Boolean;
    FColor: TAlphaColor;
    procedure SetHideSelection(const Value: Boolean);
    procedure SetMinSize(const Value: Integer);
    procedure SetGripSize(const Value: Single);
    procedure ResetInSpace(const ARotationPoint: TPointF; ASize: TPointF);
    function GetProportionalSize(const ASize: TPointF): TPointF;
    function GetHandleForPoint(const P: TPointF): TGrabHandle;
    procedure GetTransformLeftTop(AX, AY: Single; var NewSize: TPointF; var Pivot: TPointF);
    procedure GetTransformLeftBottom(AX, AY: Single; var NewSize: TPointF; var Pivot: TPointF);
    procedure GetTransformRightTop(AX, AY: Single; var NewSize: TPointF; var Pivot: TPointF);
    procedure GetTransformRightBottom(AX, AY: Single; var NewSize: TPointF; var Pivot: TPointF);
    procedure MoveHandle(AX, AY: Single);
    procedure SetShowHandles(const Value: Boolean);
    procedure SetColor(const Value: TAlphaColor);
  protected
    function DoGetUpdateRect: TRectF; override;
    procedure Paint; override;
    ///<summary>Draw grip handle</summary>
    procedure DrawHandle(const Canvas: TCanvas; const Handle: TGrabHandle; const Rect: TRectF); virtual;
    ///<summary>Draw frame rectangle</summary>
    procedure DrawFrame(const Canvas: TCanvas; const Rect: TRectF); virtual;
  public
    function PointInObjectLocal(X, Y: Single): Boolean; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure DoMouseLeave; override;
    ///<summary>Grip handle where mouse is hovered</summary>
    property HotHandle: TGrabHandle read FHotHandle;
  published
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    ///<summary>Selection frame and handle's border color</summary>
    property Color: TAlphaColor read FColor write SetColor default DefaultColor;
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
    property Size;
    ///<summary>Indicates visibility of handles</summary>
    property ShowHandles: Boolean read FShowHandles write SetShowHandles;
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
    FGripCenter: TPosition;
    FPressed: Boolean;
    FStylized: Boolean;
    FOnChange: TNotifyEvent;
    FOnChangeTrack: TOnChangeTracking;
    procedure SetGripSize(const Value: Single);
    procedure SetGripCenter(const Value: TPosition);
  protected
    procedure Paint; override;
    procedure SetHeight(const Value: Single); override;
    procedure SetWidth(const Value: Single); override;
    function DoGetUpdateRect: TRectF; override;
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
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property GripSize: Single read FGripSize write SetGripSize;
    property GripCenter: TPosition read FGripCenter write SetGripCenter;
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
    property Size;
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

uses
  System.Math.Vectors, System.UIConsts, System.RTLConsts, System.SysUtils, System.Math, System.TypInfo, FMX.Consts,
  FMX.Forms, FMX.FontGlyphs, FMX.AcceleratorKey;

type
  TOpenObject = class(TFmxObject);

{ TShape }

constructor TShape.Create(AOwner: TComponent);
begin
  inherited;
  Size.SetPlatformDefaultWithoutNotification(False);
  FFill := TBrush.Create(TBrushKind.Solid, $FFE0E0E0);
  FFill.OnChanged := FillChanged;
  FStroke := TStrokeBrush.Create(TBrushKind.Solid, $FF000000);
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
  if FStroke.Kind <> TBrushKind.None then
    InflateRect(Result, -(FStroke.Thickness / 2), -(FStroke.Thickness / 2));
end;

function TShape.DoGetUpdateRect: TRectF;
var
  LOffset: Single;
begin
  Result := inherited DoGetUpdateRect;

  LOffset := 0;
  if FStroke <> nil then
  begin
    if (FStroke.Dash <> TStrokeDash.Solid) and (FStroke.Cap = TStrokeCap.Flat) then
      LOffset := (Sqrt(2) - 1) * 0.5 * FStroke.Thickness;
                                           
  end;

  { inflate rect - remove antialiasing artefacts }
  if not Result.IsEmpty then
    LOffset := LOffset + 1;
  if LOffset > 0 then
    Result.Inflate(LOffset, LOffset);
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

function GetDrawingShapeRectAndSetThickness(const AShape: TShape; const Fit: Boolean; var FillShape, DrawShape: Boolean;
  var StrokeThicknessRestoreValue: Single): TRectF;
const
  MinRectAreaSize = 0.01;
begin
  FillShape := (AShape.FFill <> nil) and (AShape.FFill.Kind <> TBrushKind.None);
  DrawShape := (AShape.FStroke <> nil) and (AShape.FStroke.Kind <> TBrushKind.None);

  if Fit then
    Result := TRectF.Create(0, 0, 1, 1).FitInto(AShape.LocalRect)
  else
    Result := AShape.LocalRect;

  if DrawShape then
  begin
    if Result.Width < AShape.FStroke.Thickness then
    begin
      StrokeThicknessRestoreValue := AShape.FStroke.Thickness;
      FillShape := False;
      AShape.FStroke.Thickness := Min(Result.Width, Result.Height);
      Result.Left := (Result.Right + Result.Left) * 0.5;
      Result.Right := Result.Left + MinRectAreaSize;
    end
    else
      Result.Inflate(-AShape.FStroke.Thickness * 0.5, 0);

    if Result.Height < AShape.FStroke.Thickness then
    begin
      if StrokeThicknessRestoreValue < 0.0 then
        StrokeThicknessRestoreValue := AShape.FStroke.Thickness;
      FillShape := False;
      AShape.FStroke.Thickness := Min(Result.Width, Result.Height);
      Result.Top := (Result.Bottom + Result.Top) * 0.5;
      Result.Bottom := Result.Top + MinRectAreaSize;
    end
    else
      Result.Inflate(0, -AShape.FStroke.Thickness * 0.5);
  end;
end;

{ TLine }

constructor TLine.Create(AOwner: TComponent);
begin
  inherited;
  FLineLocation := TLineLocation.Boundary;
end;

function TLine.DoGetUpdateRect: TRectF;
var
  LOffset: Single;
  LFactor: Single;
begin
  Result := inherited;
  if not Result.IsEmpty then
  begin
    if LineLocation = TLineLocation.Inner then
      LFactor := 1
    else
      LFactor := 0.5;

    if (FStroke.Dash <> TStrokeDash.Solid) or (FStroke.Cap = TStrokeCap.Round) then
      LOffset := LFactor * FStroke.Thickness
    else
      LOffset := Sqrt(2) * LFactor * FStroke.Thickness;
    Result.Inflate(LOffset, LOffset);
  end;
end;

function TLine.IsControlRectEmpty: Boolean;
begin
  Result := (Width < 1) and (Height < 1);
end;

procedure TLine.Paint;
const
  PixelSize = 1;
  HalfPixelSize = 0.5;
  LineMinLength = 0.01;
  RectOffsetCorrection = 0.01;

  function CorrectShapeClientRect(const ARect: TRectF; const ACanvas: TCanvas): TRectF;
  begin
    Result := ARect;
    Result.Inflate(-HalfPixelSize * ACanvas.Scale, -HalfPixelSize * ACanvas.Scale);
  end;

  function ValidateRect(const ALocalRect, ARect: TRectF): TRectF;
  begin
    Result := ARect;
    if LineType = TLineType.Diagonal then
      if Result.Right < Result.Left + RectOffsetCorrection then
      begin
        Result.Right := (ALocalRect.Left + ALocalRect.Right) * 0.5;
        Result.Left := Result.Right - RectOffsetCorrection;
        Result.Right := Result.Right + RectOffsetCorrection;
      end;
      if Result.Bottom < Result.Top + RectOffsetCorrection then
      begin
        Result.Bottom := (ALocalRect.Top + ALocalRect.Bottom) * 0.5;
        Result.Top := Result.Bottom - RectOffsetCorrection;
        Result.Bottom := Result.Bottom + RectOffsetCorrection;
      end;
  end;

  procedure GetStartingPointAndDirection(out AStartingPoint, ADirection: TPointF);
  var
    LLocalRect: TRectF;
    LShapeRect: TRectF;
    LDeinflateShapeRect: TRectF;
  begin

    LLocalRect := LocalRect;
    LShapeRect := ValidateRect(LLocalRect, CorrectShapeClientRect(LLocalRect, Canvas));
    LDeinflateShapeRect := ValidateRect(LLocalRect, GetShapeRect);

    case FLineType of
      TLineType.Top:
        begin
          if FLineLocation <> TLineLocation.Boundary then
            AStartingPoint := TPointF.Create(LShapeRect.Left, LDeinflateShapeRect.Top)
          else
            AStartingPoint := TPointF.Create(LShapeRect.Left, LShapeRect.Top);
          ADirection.X := LShapeRect.Right - LShapeRect.Left;
          ADirection.Y := 0;
        end;
      TLineType.Bottom:
        begin
          if FLineLocation <> TLineLocation.Boundary then
            AStartingPoint := TPointF.Create(LShapeRect.Left, LDeinflateShapeRect.Bottom)
          else
            AStartingPoint := TPointF.Create(LShapeRect.Left, LShapeRect.Bottom);
          ADirection.X := LShapeRect.Right - LShapeRect.Left;
          ADirection.Y := 0;
        end;
      TLineType.Left:
        begin
          if FLineLocation <> TLineLocation.Boundary then
            AStartingPoint := TPointF.Create(LDeinflateShapeRect.Left, LShapeRect.Top)
          else
            AStartingPoint := TPointF.Create(LShapeRect.Left, LShapeRect.Top);
          ADirection.X := 0;
          ADirection.Y := LShapeRect.Bottom - LShapeRect.Top;
        end;
      TLineType.Right:
        begin
          if FLineLocation <> TLineLocation.Boundary then
            AStartingPoint := TPointF.Create(LDeinflateShapeRect.Right, LShapeRect.Top)
          else
            AStartingPoint := TPointF.Create(LShapeRect.Right, LShapeRect.Top);
          ADirection.X := 0;
          ADirection.Y := LShapeRect.Bottom - LShapeRect.Top;
        end;
    else
      AStartingPoint := TPointF.Create(LShapeRect.Left, LShapeRect.Top);
      ADirection := LShapeRect.BottomRight - LShapeRect.TopLeft;
    end;
  end;

var
  StrokeThicknessRestoreValue: Single;
  StartingPoint, Direction, UnitDirection: TPointF;
  VectorLength, SizeFactor, Offset: Single;
  LineBegin, LineEnd: TPointF;
begin
  StrokeThicknessRestoreValue := FStroke.Thickness;
  try
    if (FLineLocation = TLineLocation.InnerWithin) and (FStroke.Thickness > Min(Width, Height)) then
      FStroke.Thickness := Min(Width, Height);

    GetStartingPointAndDirection(StartingPoint, Direction);

    if FShortenLine then
      SizeFactor := 2
    else
      SizeFactor := 1;

    VectorLength := Direction.Length;
    UnitDirection := Direction.Normalize;

    if VectorLength < FStroke.Thickness * SizeFactor then
    begin
      FStroke.Thickness := VectorLength / SizeFactor;
      if FLineLocation <> TLineLocation.Boundary then
      begin
        GetStartingPointAndDirection(StartingPoint, Direction);
        UnitDirection := Direction.Normalize;
      end;
    end;

    Offset := FStroke.Thickness * 0.5 * SizeFactor;

    if Offset * 2 < VectorLength - LineMinLength then
    begin
      LineBegin := StartingPoint + (UnitDirection * Offset);
      LineEnd := StartingPoint + Direction - (UnitDirection * Offset);
    end
    else
    begin
      LineBegin := StartingPoint + (UnitDirection * Offset);
      LineEnd := LineBegin + UnitDirection * LineMinLength;
    end;

    Canvas.DrawLine(LineBegin, LineEnd, AbsoluteOpacity, FStroke);
  finally
    if StrokeThicknessRestoreValue <> FStroke.Thickness then
      FStroke.Thickness := StrokeThicknessRestoreValue;
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

procedure TLine.SetShortenLine(const AValue: Boolean);
begin
  if FShortenLine <> AValue then
  begin
    FShortenLine := AValue;
    Repaint;
  end;
end;

procedure TLine.SetLineLocation(const AValue: TLineLocation);
begin
  if FLineLocation <> AValue then
  begin
    FLineLocation := AValue;
    Repaint;
  end;
end;


{ TEllipse }

procedure TEllipse.Paint;
var
  StrokeThicknessRestoreValue: Single;
  FillShape, DrawShape: Boolean;
  LShapeRect: TRectF;
begin
  StrokeThicknessRestoreValue := FStroke.Thickness;
  try
    LShapeRect := GetDrawingShapeRectAndSetThickness(Self, False, FillShape, DrawShape, StrokeThicknessRestoreValue);
    if FillShape then
      Canvas.FillEllipse(LShapeRect, AbsoluteOpacity, FFill);
    if DrawShape then
      Canvas.DrawEllipse(LShapeRect, AbsoluteOpacity, FStroke);
  finally
    if StrokeThicknessRestoreValue <> FStroke.Thickness then
      FStroke.Thickness := StrokeThicknessRestoreValue;
  end;
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
  StrokeThicknessRestoreValue: Single;
  FillShape, DrawShape: Boolean;
  LShapeRect: TRectF;
begin
  StrokeThicknessRestoreValue := FStroke.Thickness;
  try
    LShapeRect := GetDrawingShapeRectAndSetThickness(Self, True, FillShape, DrawShape, StrokeThicknessRestoreValue);
    if FillShape then
      Canvas.FillEllipse(LShapeRect, AbsoluteOpacity, FFill);
    if DrawShape then
      Canvas.DrawEllipse(LShapeRect, AbsoluteOpacity, FStroke);
  finally
    if StrokeThicknessRestoreValue <> FStroke.Thickness then
      FStroke.Thickness := StrokeThicknessRestoreValue;
  end;
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
  LShapePath: TPathData;
  LShapeRect: TRectF;
  MidPoint: TPointF;
  StrokeThicknessRestoreValue: Single;
  FillShape, DrawShape: Boolean;
begin
  StrokeThicknessRestoreValue := FStroke.Thickness;
  LShapePath := TPathData.Create;
  try
    LShapeRect := GetDrawingShapeRectAndSetThickness(Self, False, FillShape, DrawShape, StrokeThicknessRestoreValue);
    MidPoint := LShapeRect.CenterPoint;

    LShapePath.MoveTo(MidPoint);
    LShapePath.AddArc(MidPoint, TPointF.Create(LShapeRect.Width * 0.5, LShapeRect.Height * 0.5), FStartAngle, FEndAngle - FStartAngle);
    LShapePath.LineTo(MidPoint);
    LShapePath.ClosePath;
    if FillShape then
      Canvas.FillPath(LShapePath, AbsoluteOpacity, FFill);
    if DrawShape then
      Canvas.DrawPath(LShapePath, AbsoluteOpacity, FStroke);
  finally
    if LShapePath <> nil then
      LShapePath.Free;
    if StrokeThicknessRestoreValue <> FStroke.Thickness then
      FStroke.Thickness := StrokeThicknessRestoreValue;
  end;

end;

function TPie.PointInObject(X, Y: Single): Boolean;
var
  LShapePath: TPathData;
begin
  if Canvas <> nil then
  begin
    LShapePath := TPathData.Create;
    try
      LShapePath.MoveTo(TPointF.Create(Width / 2, Height / 2));
      LShapePath.AddArc(TPointF.Create(Width / 2, Height / 2), TPointF.Create((Width - Stroke.Thickness) / 2,
        (Height - Stroke.Thickness) / 2), FStartAngle, FEndAngle - FStartAngle);
      LShapePath.LineTo(TPointF.Create(Width / 2, Height / 2));
      LShapePath.ClosePath;
      Result := Canvas.PtInPath(AbsoluteToLocal(PointF(X, Y)), LShapePath);
    finally
      LShapePath.Free;
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
  Fill.Kind := TBrushKind.None;
  Fill.DefaultKind := TBrushKind.None;
  FStartAngle := 0;
  FEndAngle := -90;
end;

procedure TArc.Paint;
var
  LShapeRect: TRectF;
  MidPoint: TPointF;
  StrokeThicknessRestoreValue: Single;
  FillShape, DrawShape: Boolean;
begin
  StrokeThicknessRestoreValue := FStroke.Thickness;
  try
    LShapeRect := GetDrawingShapeRectAndSetThickness(Self, False, FillShape, DrawShape, StrokeThicknessRestoreValue);
    MidPoint := LShapeRect.CenterPoint;

    if FillShape then
      Canvas.FillArc(MidPoint, TPointF.Create(LShapeRect.Width * 0.5, LShapeRect.Height * 0.5), FStartAngle, FEndAngle,
        AbsoluteOpacity, FFill);
    if DrawShape then
      Canvas.DrawArc(MidPoint, TPointF.Create(LShapeRect.Width * 0.5, LShapeRect.Height * 0.5), FStartAngle, FEndAngle,
        AbsoluteOpacity, FStroke);
  finally
    if StrokeThicknessRestoreValue <> FStroke.Thickness then
      FStroke.Thickness := StrokeThicknessRestoreValue;
  end;
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
  LShapeRect: TRectF;
  Off: Single;
  StrokeThicknessRestoreValue: Single;
  FillShape, DrawShape: Boolean;
begin
  StrokeThicknessRestoreValue := FStroke.Thickness;
  try
    LShapeRect := GetDrawingShapeRectAndSetThickness(Self, False, FillShape, DrawShape, StrokeThicknessRestoreValue);

    if Sides <> AllSides then
    begin
      Off := LShapeRect.Left;
      if not(TSide.Top in FSides) then
        LShapeRect.Top := LShapeRect.Top - Off;
      if not(TSide.Left in FSides) then
        LShapeRect.Left := LShapeRect.Left - Off;
      if not(TSide.Bottom in FSides) then
        LShapeRect.Bottom := LShapeRect.Bottom + Off;
      if not(TSide.Right in FSides) then
        LShapeRect.Right := LShapeRect.Right + Off;
      if FillShape then
        Canvas.FillRect(LShapeRect, XRadius, YRadius, FCorners, AbsoluteOpacity, FFill, CornerType);
      if DrawShape then
        Canvas.DrawRectSides(GetShapeRect, XRadius, YRadius, FCorners,  AbsoluteOpacity, Sides, FStroke, CornerType);
    end
    else
    begin
      if FillShape then
        Canvas.FillRect(LShapeRect, XRadius, YRadius, FCorners, AbsoluteOpacity, FFill, CornerType);
      if DrawShape then
        Canvas.DrawRect(LShapeRect, XRadius, YRadius, FCorners, AbsoluteOpacity, FStroke, CornerType);
    end;
  finally
    if StrokeThicknessRestoreValue <> FStroke.Thickness then
      FStroke.Thickness := StrokeThicknessRestoreValue;
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
var
  NewValue: Single;
begin
  if csDesigning in ComponentState then
    NewValue := Min(Value, Min(Width / 2, Height / 2))
  else
    NewValue := Value;
  if not SameValue(FXRadius, NewValue, TEpsilon.Vector) then
  begin
    FXRadius := NewValue;
    Repaint;
  end;
end;

procedure TRectangle.SetYRadius(const Value: Single);
var
  NewValue: Single;
begin
  if csDesigning in ComponentState then
    NewValue := Min(Value, Min(Width / 2, Height / 2))
  else
    NewValue := Value;
  if not SameValue(FYRadius, NewValue, TEpsilon.Vector) then
  begin
    FYRadius := NewValue;
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
  Stroke.Kind := TBrushKind.None;
  FFlashTimer := TTimer.Create(Self);
  FFlashTimer.Enabled := False;
  FFlashTimer.OnTimer := FlashTimerProc;
  FFlashTimer.Stored := False;
  TPlatformServices.Current.SupportsPlatformService(IFMXSystemInformationService, FSystemInformation);
  HitTest := False;
end;

function TCaretRectangle.DefaultColor: TAlphaColor;
begin
  if FCaret <> nil then
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
  if FSystemInformation <> nil then
    Result := FSystemInformation.GetCaretWidth
  else
    Result := 1;
end;

function TCaretRectangle.UseFontColor: Boolean;
begin
  if (FSystemInformation <> nil) and (FCaret <> nil) and (FCaret.DefaultColor <> TAlphaColorRec.Null) then
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
    if (FCaret <> nil) and (FCaret.Owner <> nil) then
      FCaret.Owner.RemoveFreeNotification(self);
    try
      FCaret := Value;
      if (FCaret <> nil) and (FCaret.Owner <> nil) then
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
  if (Operation = opRemove) and (FCaret <> nil) and (AComponent = FCaret.Owner) then
  begin
    Parent := nil;
    FCaret := nil;
  end;
end;

function TCaretRectangle.GetColor: TAlphaColor;
begin
  Result := FColor;
end;

function TCaretRectangle.GetDefaultSize: TSizeF;
begin
  Result := FSize;
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
  LVisible := (Caret <> nil) and
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
      if (Caret.Owner <> nil) and
        (TOpenObject(Caret.Owner).QueryInterface(ITextSettings, IInterface(TextSettings)) = S_OK) and
        (TextSettings.TextSettings <> nil) then
      begin
        if TStyledSetting.FontColor in TextSettings.StyledSettings then
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
    if (Caret.Owner <> nil) and ([csLoading, csDestroying] * Caret.Owner.ComponentState = []) then
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
  R: TRectF;
  StrokeThicknessRestoreValue: Single;
  FillShape, DrawShape: Boolean;
begin
  StrokeThicknessRestoreValue := FStroke.Thickness;
  try
    R := GetDrawingShapeRectAndSetThickness(Self, False, FillShape, DrawShape, StrokeThicknessRestoreValue);

    if Height < Width then
      Radius := R.Height / 2
    else
      Radius := R.Width / 2;

    if FillShape then
      Canvas.FillRect(R, Radius, Radius, FCorners, AbsoluteOpacity, FFill);
    if DrawShape then
      Canvas.DrawRect(R, Radius, Radius, FCorners, AbsoluteOpacity, FStroke);
  finally
    if StrokeThicknessRestoreValue <> FStroke.Thickness then
      FStroke.Thickness := StrokeThicknessRestoreValue;
  end;
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

procedure TCalloutRectangle.AddCalloutToPath(APath: TPathData; const ARect: TRectF; const ACornerRadiuses: TSizeF);
begin
  case CalloutPosition of
    TCalloutPosition.Top:
    begin
      if CalloutOffset = 0 then
      begin
        APath.LineTo(PointF(ARect.Width / 2 - CalloutWidth / 2, ARect.Top));
        APath.LineTo(PointF(ARect.Width / 2, ARect.Top - FCalloutLength));
        APath.LineTo(PointF(ARect.Width / 2 + CalloutWidth / 2, ARect.Top));
        APath.LineTo(PointF(ARect.Right - ACornerRadiuses.cx, ARect.Top));
      end
      else if CalloutOffset > 0 then
      begin
        APath.LineTo(PointF(ARect.Left + FCalloutOffset, ARect.Top));
        APath.LineTo(PointF(ARect.Left + FCalloutOffset + (CalloutWidth / 2), ARect.Top - FCalloutLength));
        APath.LineTo(PointF(ARect.Left + FCalloutOffset + CalloutWidth, ARect.Top));
        APath.LineTo(PointF(ARect.Right - ACornerRadiuses.cx, ARect.Top));
      end else
      begin
        APath.LineTo(PointF(ARect.Right - Abs(FCalloutOffset) - CalloutWidth, ARect.Top));
        APath.LineTo(PointF(ARect.Right - Abs(FCalloutOffset) - CalloutWidth / 2, ARect.Top - FCalloutLength));
        APath.LineTo(PointF(ARect.Right - Abs(FCalloutOffset), ARect.Top));
        APath.LineTo(PointF(ARect.Right - ACornerRadiuses.cx, ARect.Top));
      end;
    end;
    TCalloutPosition.Left:
    begin
      if CalloutOffset = 0 then
      begin
        APath.LineTo(PointF(ARect.Left, ARect.Height / 2 + CalloutWidth / 2));
        APath.LineTo(PointF(ARect.Left - FCalloutLength, (ARect.Bottom - ARect.Top) / 2));
        APath.LineTo(PointF(ARect.Left, ARect.Height / 2 - CalloutWidth / 2));
        APath.LineTo(PointF(ARect.Left, ARect.Top + ACornerRadiuses.cy));
      end
      else if CalloutOffset > 0 then
      begin
        APath.LineTo(PointF(ARect.Left, ARect.Top + CalloutOffset + CalloutWidth));
        APath.LineTo(PointF(ARect.Left - FCalloutLength, ARect.Top + CalloutOffset + CalloutWidth / 2));
        APath.LineTo(PointF(ARect.Left, ARect.Top + CalloutOffset));
        APath.LineTo(PointF(ARect.Left, ARect.Top + ACornerRadiuses.cy));
      end else
      begin
        APath.LineTo(PointF(ARect.Left, ARect.Bottom + CalloutOffset + CalloutWidth));
        APath.LineTo(PointF(ARect.Left - FCalloutLength, ARect.Bottom + CalloutOffset + CalloutWidth / 2));
        APath.LineTo(PointF(ARect.Left, ARect.Bottom + CalloutOffset));
        APath.LineTo(PointF(ARect.Left, ARect.Top + ACornerRadiuses.cy));
      end;
    end;
    TCalloutPosition.Bottom:
    begin
      if CalloutOffset = 0 then
      begin
        APath.LineTo(PointF(ARect.Width / 2 + CalloutWidth / 2, ARect.Bottom));
        APath.LineTo(PointF(ARect.Width / 2, ARect.Bottom + FCalloutLength));
        APath.LineTo(PointF(ARect.Width / 2 - CalloutWidth / 2, ARect.Bottom));
        APath.LineTo(PointF(ARect.Left + ACornerRadiuses.cx, ARect.Bottom));
      end
      else if CalloutOffset > 0 then
      begin
        APath.LineTo(PointF(ARect.Left + FCalloutOffset + CalloutWidth, ARect.Bottom));
        APath.LineTo(PointF(ARect.Left + FCalloutOffset + CalloutWidth / 2, ARect.Bottom + FCalloutLength));
        APath.LineTo(PointF(ARect.Left + FCalloutOffset, ARect.Bottom));
        APath.LineTo(PointF(ARect.Left + ACornerRadiuses.cx, ARect.Bottom));
      end else
      begin
        APath.LineTo(PointF(ARect.Right - Abs(FCalloutOffset), ARect.Bottom));
        APath.LineTo(PointF(ARect.Right - Abs(FCalloutOffset) - CalloutWidth / 2, ARect.Bottom + FCalloutLength));
        APath.LineTo(PointF(ARect.Right - Abs(FCalloutOffset) - CalloutWidth, ARect.Bottom));
        APath.LineTo(PointF(ARect.Left + ACornerRadiuses.cx, ARect.Bottom));
      end;
    end;
    TCalloutPosition.Right:
    begin
      if CalloutOffset = 0 then
      begin
        APath.LineTo(PointF(ARect.Right, ARect.Height / 2 - CalloutWidth / 2));
        APath.LineTo(PointF(ARect.Right + FCalloutLength, ARect.Height / 2));
        APath.LineTo(PointF(ARect.Right, ARect.Height / 2 + CalloutWidth / 2));
        APath.LineTo(PointF(ARect.Right, ARect.Bottom - ACornerRadiuses.cy));
      end
      else if CalloutOffset > 0 then
      begin
        APath.LineTo(PointF(ARect.Right, ARect.Top + CalloutOffset));
        APath.LineTo(PointF(ARect.Right + FCalloutLength, ARect.Top + CalloutOffset + CalloutWidth / 2));
        APath.LineTo(PointF(ARect.Right, ARect.Top + CalloutOffset + CalloutWidth));
        APath.LineTo(PointF(ARect.Right, ARect.Bottom - ACornerRadiuses.cy));
      end
      else
      begin
        APath.LineTo(PointF(ARect.Right, ARect.Bottom + CalloutOffset));
        APath.LineTo(PointF(ARect.Right + FCalloutLength, ARect.Bottom + CalloutOffset + CalloutWidth / 2));
        APath.LineTo(PointF(ARect.Right, ARect.Bottom + CalloutOffset + CalloutWidth));
        APath.LineTo(PointF(ARect.Right, ARect.Bottom - ACornerRadiuses.cy));
      end;
    end;
  end;
end;

procedure TCalloutRectangle.AddRectCornerToPath(APath: TPathData; const ARect: TRectF; const ACornerSize: TSizeF;
  const ACorner: TCorner; const ASkipEmptySide: Boolean = True);
begin
  case ACorner of
    TCorner.TopLeft:
    begin
      if (TSide.Left in FSides) or not ASkipEmptySide then
        APath.LineTo(ARect.TopLeft)
      else
        APath.MoveTo(ARect.TopLeft);
      if (TSide.Top in FSides) or not ASkipEmptySide then
        APath.LineTo(PointF(ARect.Left + ACornerSize.cx, ARect.Top))
      else
        APath.MoveTo(PointF(ARect.Left + ACornerSize.cx, ARect.Top));
    end;
    TCorner.TopRight:
    begin
      if (TSide.Top in FSides) or not ASkipEmptySide then
        APath.LineTo(PointF(ARect.Right, ARect.Top))
      else
        APath.MoveTo(PointF(ARect.Right, ARect.Top));
      if (TSide.Right in FSides) or not ASkipEmptySide then
        APath.LineTo(PointF(ARect.Right, ARect.Top + ACornerSize.cy))
      else
        APath.MoveTo(PointF(ARect.Right, ARect.Top + ACornerSize.cy));
    end;
    TCorner.BottomLeft:
    begin
      if (TSide.Bottom in FSides) or not ASkipEmptySide then
        APath.LineTo(PointF(ARect.Left, ARect.Bottom))
      else
        APath.MoveTo(PointF(ARect.Left, ARect.Bottom));
      if (TSide.Left in FSides) or not ASkipEmptySide then
        APath.LineTo(PointF(ARect.Left, ARect.Bottom - ACornerSize.cy))
      else
        APath.MoveTo(PointF(ARect.Left, ARect.Bottom - ACornerSize.cy));
    end;
    TCorner.BottomRight:
    begin
      if (TSide.Right in FSides) or not ASkipEmptySide then
        APath.LineTo(PointF(ARect.Right, ARect.Bottom))
      else
        APath.MoveTo(PointF(ARect.Right, ARect.Bottom));
      if (TSide.Bottom in FSides) or not ASkipEmptySide then
        APath.LineTo(PointF(ARect.Right - ACornerSize.cx, ARect.Bottom))
      else
        APath.MoveTo(PointF(ARect.Right - ACornerSize.cx, ARect.Bottom));
    end;
  end;
end;

procedure TCalloutRectangle.AddRoundCornerToPath(APath: TPathData; const ARect: TRectF; const ACornerSize: TSizeF;
  const ACorner: TCorner);
var
  x2: Single;
  y2: Single;
begin
  x2 := ACornerSize.cx / 2;
  y2 := ACornerSize.cy / 2;
  case ACorner of
    TCorner.TopLeft:
    begin
      case FCornerType of
      // TCornerType.Round - default
      TCornerType.Bevel:
        APath.LineTo(PointF(ARect.Left + ACornerSize.cx, ARect.Top));
      TCornerType.InnerRound:
        APath.CurveTo(PointF(ARect.Left + x2, ARect.Top + ACornerSize.cy),
          PointF(ARect.Left + ACornerSize.cx, ARect.Top + y2), PointF(ARect.Left + ACornerSize.cx, ARect.Top));
      TCornerType.InnerLine:
        begin
          APath.LineTo(PointF(ARect.Left + x2, ARect.Top + ACornerSize.cy));
          APath.LineTo(PointF(ARect.Left + ACornerSize.cx, ARect.Top + y2));
          APath.LineTo(PointF(ARect.Left + ACornerSize.cx, ARect.Top));
        end;
      else
        APath.CurveTo(PointF(ARect.Left, ARect.Top + y2), PointF(ARect.Left + x2, ARect.Top),
          PointF(ARect.Left + ACornerSize.cx, ARect.Top))
      end;
    end;
    TCorner.TopRight:
    begin
      case FCornerType of
        // TCornerType.Round - default
        TCornerType.Bevel:
          APath.LineTo(PointF(ARect.Right, ARect.Top + ACornerSize.cy));
        TCornerType.InnerRound:
          APath.CurveTo(PointF(ARect.Right - ACornerSize.cx, ARect.Top + y2),
            PointF(ARect.Right - x2, ARect.Top + ACornerSize.cy), PointF(ARect.Right, ARect.Top + ACornerSize.cy));
        TCornerType.InnerLine:
          begin
            APath.LineTo(PointF(ARect.Right - ACornerSize.cx, ARect.Top + y2));
            APath.LineTo(PointF(ARect.Right - x2, ARect.Top + ACornerSize.cy));
            APath.LineTo(PointF(ARect.Right, ARect.Top + ACornerSize.cy));
          end;
      else
        APath.CurveTo(PointF(ARect.Right - x2, ARect.Top), PointF(ARect.Right, ARect.Top + y2),
          PointF(ARect.Right, ARect.Top + ACornerSize.cy))
      end;
    end;
    TCorner.BottomLeft:
    begin
      case FCornerType of
        // TCornerType.Round - default
        TCornerType.Bevel:
          APath.LineTo(PointF(ARect.Left, ARect.Bottom - ACornerSize.cy));
        TCornerType.InnerRound:
          APath.CurveTo(PointF(ARect.Left + ACornerSize.cx, ARect.Bottom - y2),
            PointF(ARect.Left + x2, ARect.Bottom -  ACornerSize.cy), PointF(ARect.Left, ARect.Bottom - ACornerSize.cy));
        TCornerType.InnerLine:
          begin
            APath.LineTo(PointF(ARect.Left +  ACornerSize.cx, ARect.Bottom - y2));
            APath.LineTo(PointF(ARect.Left + x2, ARect.Bottom - ACornerSize.cy));
            APath.LineTo(PointF(ARect.Left, ARect.Bottom - ACornerSize.cy));
          end;
      else
        APath.CurveTo(PointF(ARect.Left + x2, ARect.Bottom), PointF(ARect.Left, ARect.Bottom - y2),
          PointF(ARect.Left, ARect.Bottom - ACornerSize.cy))
      end;
    end;
    TCorner.BottomRight:
    begin
      case FCornerType of
        // TCornerType.Round - default
        TCornerType.Bevel:
          APath.LineTo(PointF(ARect.Right - ACornerSize.cx, ARect.Bottom));
        TCornerType.InnerRound:
          APath.CurveTo(PointF(ARect.Right - x2, ARect.Bottom - ACornerSize.cy),
            PointF(ARect.Right - ACornerSize.cx, ARect.Bottom - y2), PointF(ARect.Right - ACornerSize.cx, ARect.Bottom));
        TCornerType.InnerLine:
          begin
            APath.LineTo(PointF(ARect.Right - x2, ARect.Bottom - ACornerSize.cy));
            APath.LineTo(PointF(ARect.Right - ACornerSize.cx, ARect.Bottom - y2));
            APath.LineTo(PointF(ARect.Right - ACornerSize.cx, ARect.Bottom));
          end;
      else
        APath.CurveTo(PointF(ARect.Right, ARect.Bottom - y2),
          PointF(ARect.Right - x2, ARect.Bottom), PointF(ARect.Right - ACornerSize.cx, ARect.Bottom))
      end;
    end;
  end;
end;

constructor TCalloutRectangle.Create(AOwner: TComponent);
begin
  inherited;
  FCalloutWidth := 23;
  FCalloutLength := 11;
  FPath := TPathData.Create;
  FFillPath := TPathData.Create;
  RebuildPaths;
end;

destructor TCalloutRectangle.Destroy;
begin
  FreeAndNil(FPath);
  FreeAndNil(FFillPath);
  inherited;
end;

function TCalloutRectangle.GetCalloutRectangleRect: TRectF;
var
  R: TRectF;
begin
  R := GetShapeRect;
  case CalloutPosition of
    TCalloutPosition.Top:
      R.Top := R.Top + FCalloutLength;
    TCalloutPosition.Left:
      R.Left := R.Left + FCalloutLength;
    TCalloutPosition.Bottom:
      R.Bottom := R.Bottom - FCalloutLength;
    TCalloutPosition.Right:
      R.Right := R.Right - FCalloutLength;
  end;
  Result := R;
end;

procedure TCalloutRectangle.Loaded;
begin
  inherited Loaded;
  RebuildPaths;
end;

procedure TCalloutRectangle.CreateFillPath;
var
  CornerSize: TSizeF;
  R: TRectF;
begin
  R := GetCalloutRectangleRect;
  CornerSize := TSizeF.Create(XRadius, YRadius);
  if (R.Width - CornerSize.cx * 2 < 0) and (CornerSize.cx > 0) then
    CornerSize.cx := XRadius * R.Width / (CornerSize.cx * 2);
  if (R.Height - CornerSize.cy * 2 < 0) and (CornerSize.cy > 0) then
    CornerSize.cy := YRadius * R.Height / (CornerSize.cy * 2);

  FFillPath.Clear;
  FFillPath.MoveTo(PointF(R.Left, R.Top + CornerSize.cy));

  // Top Left Corner
  if TCorner.TopLeft in FCorners then
    AddRoundCornerToPath(FFillPath, R, CornerSize, TCorner.TopLeft)
  else
    AddRectCornerToPath(FFillPath, R, CornerSize, TCorner.TopLeft, False);

  // Top Side
  if CalloutPosition = TCalloutPosition.Top then
    AddCalloutToPath(FFillPath, R, CornerSize)
  else
    FFillPath.LineTo(PointF(R.Right - CornerSize.cx, R.Top));

  // Top Right Corner
  if TCorner.TopRight in FCorners then
    AddRoundCornerToPath(FFillPath, R, CornerSize, TCorner.TopRight)
  else
    AddRectCornerToPath(FFillPath, R, CornerSize, TCorner.TopRight, False);

  // Right Side
  if (FCalloutPosition = TCalloutPosition.Right) then
    AddCalloutToPath(FFillPath, R, CornerSize)
  else
    FFillPath.LineTo(PointF(R.Right, R.Bottom - CornerSize.cy));

  // Bottom Right Corner
  if TCorner.BottomRight in FCorners then
    AddRoundCornerToPath(FFillPath, R, CornerSize, TCorner.BottomRight)
  else
    AddRectCornerToPath(FFillPath, R, CornerSize, TCorner.BottomRight, False);

  // Bottom Side
  if FCalloutPosition = TCalloutPosition.Bottom then
    AddCalloutToPath(FFillPath, R, CornerSize)
  else
    FFillPath.LineTo(PointF(R.Left + CornerSize.cx, R.Bottom));

  // Bottom Left Corner
  if TCorner.BottomLeft in FCorners then
    AddRoundCornerToPath(FFillPath, R, CornerSize, TCorner.BottomLeft)
  else
    AddRectCornerToPath(FFillPath, R, CornerSize, TCorner.BottomLeft, False);

  // Left Side
  if FCalloutPosition = TCalloutPosition.Left then
    AddCalloutToPath(FFillPath, R, CornerSize)
  else
    FFillPath.LineTo(PointF(R.Left, R.Top + CornerSize.cy));
end;

procedure TCalloutRectangle.CreatePath;
var
  CornerSize: TSizeF;
  R: TRectF;
begin
  R := GetCalloutRectangleRect;
  CornerSize := TSizeF.Create(XRadius, YRadius);
  if (R.Width - CornerSize.cx * 2 < 0) and (CornerSize.cx > 0) then
    CornerSize.cx := XRadius * R.Width / (CornerSize.cx * 2);
  if (R.Height - CornerSize.cy * 2 < 0) and (CornerSize.cy > 0) then
    CornerSize.cy := YRadius * R.Height / (CornerSize.cy * 2);

  FPath.Clear;
  FPath.MoveTo(PointF(R.Left, R.Top + CornerSize.cy));

  // Top Left Corner
  if TCorner.TopLeft in FCorners then
    AddRoundCornerToPath(FPath, R, CornerSize, TCorner.TopLeft)
  else
    AddRectCornerToPath(FPath, R, CornerSize, TCorner.TopLeft);

  // Top Side
  if not (TSide.Top in FSides) then
    FPath.MoveTo(PointF(R.Right - CornerSize.cx, R.Top))
  else
  begin
    if CalloutPosition = TCalloutPosition.Top then
      AddCalloutToPath(FPath, R, CornerSize)
    else
      FPath.LineTo(PointF(R.Right - CornerSize.cx, R.Top));
  end;

  // Top Right Corner
  if TCorner.TopRight in FCorners then
    AddRoundCornerToPath(FPath, R, CornerSize, TCorner.TopRight)
  else
    AddRectCornerToPath(FPath, R, CornerSize, TCorner.TopRight);

  // Right Side
  if not (TSide.Right in FSides) then
    FPath.MoveTo(PointF(R.Right, R.Bottom - CornerSize.cy))
  else
  begin
    if (FCalloutPosition = TCalloutPosition.Right) then
      AddCalloutToPath(FPath, R, CornerSize)
    else
      FPath.LineTo(PointF(R.Right, R.Bottom - CornerSize.cy));
  end;

  // Bottom Right Corner
  if TCorner.BottomRight in FCorners then
    AddRoundCornerToPath(FPath, R, CornerSize, TCorner.BottomRight)
  else
    AddRectCornerToPath(FPath, R, CornerSize, TCorner.BottomRight);

  // Bottom Side
  if not (TSide.Bottom in FSides) then
    FPath.MoveTo(PointF(R.Left + CornerSize.cx, R.Bottom))
  else
  begin
    if FCalloutPosition = TCalloutPosition.Bottom then
      AddCalloutToPath(FPath, R, CornerSize)
    else
      FPath.LineTo(PointF(R.Left + CornerSize.cx, R.Bottom));
  end;

  // Bottom Left Corner
  if TCorner.BottomLeft in FCorners then
    AddRoundCornerToPath(FPath, R, CornerSize, TCorner.BottomLeft)
  else
    AddRectCornerToPath(FPath, R, CornerSize, TCorner.BottomLeft);

  // Left Side
  if not (TSide.Left in FSides) then
    FPath.MoveTo(PointF(R.Left, R.Top + CornerSize.cy))
  else
  begin
    if FCalloutPosition = TCalloutPosition.Left then
      AddCalloutToPath(FPath, R, CornerSize)
    else
      FPath.LineTo(PointF(R.Left, R.Top + CornerSize.cy));
  end;
end;

procedure TCalloutRectangle.Paint;
begin
  Canvas.FillPath(FFillPath, AbsoluteOpacity, FFill);
  Canvas.DrawPath(FPath, AbsoluteOpacity, FStroke);
end;

procedure TCalloutRectangle.RebuildPaths;
begin
  if not (csReading in ComponentState) and not (csLoading in ComponentState) then
  begin
    CreatePath;
    CreateFillPath;
  end;
end;

procedure TCalloutRectangle.Resize;
begin
  inherited Resize;
  RebuildPaths;
end;

procedure TCalloutRectangle.SetCalloutWidth(const Value: Single);
begin
  if FCalloutWidth <> Value then
  begin
    FCalloutWidth := Value;
    RebuildPaths;
    Repaint;
  end;
end;

procedure TCalloutRectangle.SetCorners(const Value: TCorners);
begin
  if Value <> Corners then
  begin
    inherited SetCorners(Value);
    RebuildPaths;
  end;
end;

procedure TCalloutRectangle.SetCornerType(const Value: TCornerType);
begin
  if Value <> CornerType then
  begin
    inherited SetCornerType(Value);
    RebuildPaths;
    Repaint;
  end;
end;

procedure TCalloutRectangle.SetSides(const Value: TSides);
begin
  if Value <> Sides then
  begin
    inherited SetSides(Value);
    RebuildPaths;
    Repaint;
  end;
end;

procedure TCalloutRectangle.SetXRadius(const Value: Single);
begin
  if Value <> XRadius then
  begin
    inherited SetXRadius(Value);
    RebuildPaths;
    Repaint;
  end;
end;

procedure TCalloutRectangle.SetYRadius(const Value: Single);
begin
  if Value <> YRadius then
  begin
    inherited SetYRadius(Value);
    RebuildPaths;
    Repaint;
  end;
end;

procedure TCalloutRectangle.SetCalloutLength(const Value: Single);
begin
  if FCalloutLength <> Value then
  begin
    FCalloutLength := Value;
    RebuildPaths;
    Repaint;
  end;
end;

procedure TCalloutRectangle.SetCalloutPosition(const Value: TCalloutPosition);
begin
  if FCalloutPosition <> Value then
  begin
    FCalloutPosition := Value;
    RebuildPaths;
    Repaint;
  end;
end;

procedure TCalloutRectangle.SetCalloutOffset(const Value: Single);
begin
  if FCalloutOffset <> Value then
  begin
    FCalloutOffset := Value;
    RebuildPaths;
    Repaint;
  end;
end;

{ TTextTextSettings }

type
  TTextTextSettings = class(TTextSettings)
  public
    constructor Create(const AOwner: TPersistent); override;
  published
    property Font;
    property FontColor;
    property Trimming default TTextTrimming.None;
    property WordWrap default True;
    property HorzAlign default TTextAlign.Center;
    property VertAlign default TTextAlign.Center;
  end;

constructor TTextTextSettings.Create(const AOwner: TPersistent);
begin
  inherited;
  Trimming := TTextTrimming.None;
  WordWrap := True;
  HorzAlign := TTextAlign.Center;
  VertAlign := TTextAlign.Center;
end;


{ TText }

constructor TText.Create(AOwner: TComponent);
var
  LClass: TTextSettingsClass;
begin
  inherited;
  LClass := GetTextSettingsClass;
  if LClass = nil then
    LClass := TTextTextSettings;
  FLayout := TTextLayoutManager.DefaultTextLayout.Create;
  FDefaultTextSettings := LClass.Create(Self);
  FDefaultTextSettings.OnChanged := OnFontChanged;
  FTextSettings := LClass.Create(Self);
  FTextSettings.OnChanged := OnFontChanged;
  FTextSettings.BeginUpdate;
  try
    FTextSettings.IsAdjustChanged := True;
  finally
    FTextSettings.EndUpdate;
  end;
end;

destructor TText.Destroy;
begin
  FTextSettings.Free;
  FDefaultTextSettings.Free;
  FLayout.Free;
  FSavedTextSettings.Free;
  FAcceleratorKeyInfo.Free;
  inherited;
end;

procedure TText.AfterConstruction;
begin
  inherited;
  UpdateDefaultTextSettings;
end;

procedure TText.Loaded;
begin
  inherited;
  UpdateDefaultTextSettings;
end;

procedure TText.OnFontChanged(Sender: TObject);
begin
  FontChanged;
end;

procedure TText.UpdateDefaultTextSettings;
begin
  FDefaultTextSettings.Assign(FTextSettings);
end;

type
  TTextPropLoaderEx = class (TTextSettingsInfo.TTextPropLoader)
  public
    procedure ReadProperties; override;
  end;

{ TTextPropLoaderEx }

procedure TTextPropLoaderEx.ReadProperties;
begin
  TextSettings.BeginUpdate;
  try
    inherited;
    Filer.DefineProperty('Color', ReadFontFillColor, nil, False);
  finally
    TextSettings.EndUpdate;
  end;
end;

procedure TText.DefineProperties(Filer: TFiler);
var
  LTextPropLoader: TTextPropLoaderEx;
begin
  inherited;
  // Only for backward compatibility with old versions
  LTextPropLoader := TTextPropLoaderEx.Create(Self, Filer);
  try
    LTextPropLoader.ReadProperties;
  finally
    LTextPropLoader.Free;
  end;
end;

function TText.GetData: TValue;
begin
  Result := Text;
end;

procedure TText.SetData(const Value: TValue);
begin
  Text := Value.ToString;
end;

procedure TText.FontChanged;
begin
  FLayout.BeginUpdate;
  try
    FLayout.WordWrap := WordWrap;
    FLayout.HorizontalAlign := HorzTextAlign;
    FLayout.VerticalAlign := VertTextAlign;
    FLayout.Color := Color;
    FLayout.Font := Font;
    FLayout.Opacity := AbsoluteOpacity;
    FLayout.Trimming := Trimming;
  finally
    FLayout.EndUpdate;
  end;
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
  Result := FDefaultTextSettings;
end;

function TText.GetTextSettings: TTextSettings;
begin
  Result := FTextSettings;
end;

function TText.GetTextSettingsClass: TTextSettingsClass;
begin
  Result := nil;
end;

procedure TText.SetTextSettings(const Value: TTextSettings);
begin
  FTextSettings.Assign(Value);
end;

function TText.GetStyledSettings: TStyledSettings;
begin
  Result := FStyledSettings;
end;

procedure TText.SetStyledSettings(const Value: TStyledSettings);
begin
  FStyledSettings := Value;
end;

function TText.SupportsPaintStage(const Stage: TPaintStage): Boolean;
begin
  Result := Stage in [TPaintStage.All, TPaintStage.Text];
end;

procedure TText.Paint;
var
  R, TextRect: TRectF;
  M, OldM: TMatrix;
  LIsChanging: Boolean;
  ScaleX, ScaleY: Single;
begin
  LIsChanging := FIsChanging;
  try
    FIsChanging := True;
    if FStretch then
    begin
      Canvas.Font.Assign(FLayout.Font);
      Canvas.Fill.Kind := TBrushkind.Solid;
      Canvas.Fill.Color := Color;
      R := TRectF.Create(0, 0, 1000, 1000);
      Canvas.MeasureText(R, Text, False, [], TTextAlign.Leading, TTextAlign.Leading);
      TextRect := LocalRect;
      if not R.IsEmpty and (TextRect.Width > TEpsilon.FontSize) and (TextRect.Height > TEpsilon.FontSize) then
      begin
        OldM := Canvas.Matrix;
        try
          ScaleX := TextRect.Width / R.Width;
          ScaleY := TextRect.Height / R.Height;
          M := TMatrix.Identity;
          M.m11 := ScaleX;
          M.m22 := ScaleY;
          Canvas.MultiplyMatrix(M);
          TextRect.Left := TextRect.Left / ScaleX;
          TextRect.Top := TextRect.Top / ScaleY;
          TextRect.Right := TextRect.Right / ScaleX;
          TextRect.Bottom := TextRect.Bottom / ScaleY;
          Canvas.FillText(TextRect, Text, False, AbsoluteOpacity, FillTextFlags, TTextAlign.Leading,
            TTextAlign.Leading);
        finally
          Canvas.SetMatrix(OldM);
        end;
      end;
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

    if FAcceleratorKeyInfo <> nil then
      if not FAcceleratorKeyInfo.DrawUnderline(Self, Canvas, FLayout, TextSettings.FontColor, Opacity) then
        RemoveAcceleratorKeyInfo;

  finally
    FIsChanging := LIsChanging;
  end;
  if (csDesigning in ComponentState) and not Locked then
    DrawDesignBorder;
end;

function TText.ConvertText(const Value: string): string;
begin
  Result := Value;
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

function TText.SaveState: Boolean;
begin
  Result := False;
  if FTextSettings <> nil then
  begin
    if FSavedTextSettings = nil then
      FSavedTextSettings := TTextSettingsClass(FTextSettings.ClassType).Create(nil);
    FSavedTextSettings.Assign(FTextSettings);
    Result := True;
  end;
end;

function TText.RestoreState: Boolean;
begin
  Result := False;
  if (FSavedTextSettings <> nil) and (FTextSettings <> nil) then
  begin
    TextSettings := FSavedTextSettings;
    FreeAndNil(FSavedTextSettings);
    Result := True;
  end;
end;

procedure TText.SetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    AdjustSize;
  end;
end;

procedure TText.SetBounds(X, Y, AWidth, AHeight: Single);
begin
  inherited;
  if FAcceleratorKeyInfo <> nil then
    FAcceleratorKeyInfo.InvalidateUnderline;
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

procedure TText.RemoveAcceleratorKeyInfo;
begin
  FAcceleratorKeyInfo.Free;
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
  if not FDisableAlign and not (csLoading in ComponentState) then
  begin
    FDisableAlign := True;
    try
      if FAutoSize and (Text <> '') then
      begin
        LHorzAlign := FLayout.HorizontalAlign;
        LVertAlign := FLayout.VerticalAlign;
        LOpacity := FLayout.Opacity;
        try
          if WordWrap then
            R := TRectF.Create(0, 0, Width, MaxSingle)
          else
            R := TRectF.Create(0, 0, MaxSingle, MaxSingle);
          FLayout.BeginUpdate;
          try
            FLayout.TopLeft := R.TopLeft;
            FLayout.MaxSize := PointF(R.Width, R.Height);
            FLayout.Opacity := AbsoluteOpacity;
            FLayout.HorizontalAlign := TTextAlign.Leading;
            FLayout.VerticalAlign := TTextAlign.Leading;
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

        SetBounds(Position.X, Position.Y, R.Width + R.Left * 2 + FTextSettings.Font.Size / 3, R.Height + R.Top * 2);
        if Supports(Parent, IAlignRoot, AlignRoot) then
          AlignRoot.Realign;
      end;
    finally
      FDisableAlign := False;
    end;
  end;
end;

function TText.GetText: string;
begin
  Result := FLayout.Text;
end;

procedure TText.SetText(const Value: string);
var
  NewText: string;
  LKey: Char;
  LKeyIndex: Integer;
  AccelKeyService: IFMXAcceleratorKeyRegistryService;
begin
  if Text <> Value then
  begin
    NewText := ConvertText(DelAmp(Value));

    if TPlatformServices.Current.SupportsPlatformService(IFMXAcceleratorKeyRegistryService, AccelKeyService) then
    begin
      AccelKeyService.ExtractAcceleratorKey(Value, LKey, LKeyIndex);
      if LKeyIndex >= 0 then
      begin
        if FAcceleratorKeyInfo = nil then
          FAcceleratorKeyInfo := TAcceleratorInfo.Create;

        FAcceleratorKeyInfo.KeyIndex := LKeyIndex;
      end;
    end;
    if Text <> NewText then
    begin
      FLayout.LayoutCanvas := Canvas;
      FLayout.Text := NewText;
      AdjustSize;
      Repaint;
    end;
  end;
end;

type
  TBitmapMargins = class (TBounds)
  private
    FImage: TImage;
  protected
    function GetOwner: TPersistent; override;
    procedure DoChange; override;
  public
    constructor Create(AImage: TImage); reintroduce;
    property Image: TImage read FImage;
  end;

{ TBitmapMargins }

constructor TBitmapMargins.Create(AImage: TImage);
begin
  if AImage = nil then
    raise EArgumentException.CreateFMT(SParamIsNil, ['AImage']);
  inherited Create(RectF(0, 0, 0, 0));
  FImage := AImage;
end;

procedure TBitmapMargins.DoChange;
begin
  inherited;
  Image.DoChanged;
end;

function TBitmapMargins.GetOwner: TPersistent;
begin
  result := FImage;
end;

{ TImageMultiResBitmap }

function TImageMultiResBitmap.GetDefaultSize: TSize;
begin
  if FImage = nil then
  begin
    if Owner is TImage then
      FImage := TImage(Owner);
  end;
  if FImage <> nil then
  begin
    Result.cx := Round(FImage.Width - FImage.BitmapMargins.Left - FImage.BitmapMargins.Right);
    Result.cy := Round(FImage.Height - FImage.BitmapMargins.Top - FImage.BitmapMargins.Bottom);
  end
  else
    Result := inherited GetDefaultSize;
end;

procedure TImageMultiResBitmap.Update(Item: TCollectionItem);
begin
  inherited;
  if FImage = nil then
  begin
    if Owner is TImage then
      FImage := TImage(Owner);
  end;
  if (FImage <> nil) and ([csLoading, csDestroying] * FImage.ComponentState = []) then
  begin
    if Item = nil then
      FImage.DoChanged
    else
    begin
      if (TCustomBitmapItem(Item).Scale = FImage.FCurrentScale) then
        FImage.DoChanged
      else
      begin
        FImage.UpdateCurrentBitmap;
        if (TCustomBitmapItem(Item).Scale = FImage.FCurrentScale) then
          FImage.DoChanged
      end;
    end;
  end;
end;

{ TImage }

constructor TImage.Create(AOwner: TComponent);
begin
  inherited;
  FMultiResBitmap := CreateMultiResBitmap;
  FBitmapMargins := TBitmapMargins.Create(self);
  FWrapMode := TImageWrapMode.Fit;
  FMarginWrapMode := TImageWrapMode.Stretch;
  SetAcceptsControls(False);
  FScaleChangedId := TMessageManager.DefaultManager.SubscribeToMessage(TScaleChangedMessage, ScaleChangedHandler);
end;

function TImage.CreateMultiResBitmap: TFixedMultiResBitmap;
begin
  Result := TImageMultiResBitmap.Create(Self, TFixedBitmapItem);
end;

procedure TImage.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('Bitmap.PNG', ReadBitmap, nil, False);
  Filer.DefineBinaryProperty('BitmapHiRes.PNG', ReadHiBitmap, nil, False);
end;

type
  TOpenReader = class(TReader)

  end;

function TImage.MultiResBitmapStored: Boolean;
var
  I: Integer;
begin
  Result := (FMultiResBitmap.TransparentColor <> TColors.SysNone) or
            (FMultiResBitmap.SizeKind <> TSizeKind.Custom) or
            (FMultiResBitmap.Width <> FMultiResBitmap.DefaultSize.cx) or
            (FMultiResBitmap.Height <> FMultiResBitmap.DefaultSize.cy);
  if not Result then
    for I := 0 to FMultiResBitmap.Count - 1 do
      if (FMultiResBitmap[I].FileName <> '') or
         (not FMultiResBitmap[I].IsEmpty) then
      begin
        Result := True;
        Exit;
      end;
end;

procedure TImage.ReadBitmap(Stream: TStream);
begin
  FMultiResBitmap.LoadItemFromStream(Stream, 1);
end;

procedure TImage.ReadHiBitmap(Stream: TStream);
begin
  FMultiResBitmap.LoadItemFromStream(Stream, 2);
end;

destructor TImage.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TScaleChangedMessage, FScaleChangedId);
  FreeAndNil(FBitmapMargins);
  FreeAndNil(FMultiResBitmap);
  inherited;
end;

function TImage.ItemForCurrentScale(const IncludeEmpty: Boolean): TCustomBitmapItem;
begin
  if Scene <> nil then
    FScreenScale := Scene.GetSceneScale
  else
    FScreenScale := 1.0;

  if (FScreenScale > 0) and (FMultiResBitmap <> nil) then
    Result := FMultiResBitmap.ItemByScale(FScreenScale, False, IncludeEmpty)
  else
    raise EInvalidOperation.CreateFMT(SNotInstance, [ClassName]);
end;

function TImage.GetBitmap: TBitmap;
var
  Item: TCustomBitmapItem;
begin
  Result := nil;
  // Return the most appropriate non-empty picture
  Item := ItemForCurrentScale(False);
  if Item <> nil then
    Result := Item.Bitmap;
  if Result = nil then
  begin
    // If there isn't non-empty pictures, then return an empty picture for the screen scale (exact match)
    Item := FMultiResBitmap.ItemByScale(FScreenScale, True, True);
    if Item <> nil then
      Result := Item.Bitmap;
  end;
  if Result = nil then
  begin
    // If there isn't item at the given scale, then create a new item with specified screen scale
    Item := FMultiResBitmap.Add;
    Item.Scale := FScreenScale;
    Result := Item.Bitmap;
  end;
end;

function TImage.GetData: TValue;
begin
  if not FData.IsEmpty then
    Result := FData
  else
    Result := GetBitmap;
end;

function TImage.GetMultiResBitmap: TCustomMultiResBitmap;
begin
  Result := MultiResBitmap;
end;

procedure TImage.SetData(const Value: TValue);
var
  LBitmap: TBitmap;
begin
  LBitmap := GetBitmap;
  FData := Value;
  if LBitmap <> nil then
  begin
    if Value.IsObject then
    begin
      if Value.AsObject is TPersistent then
        LBitmap.Assign(TPersistent(Value.AsObject));
    end
    else
      LBitmap.LoadFromFile(Value.ToString)
  end;
end;

procedure TImage.DoChanged;
begin
  Repaint;
  UpdateEffects;
end;

procedure TImage.UpdateCurrentBitmap;
  function CurrentBitmapFound(var Item: TCustomBitmapItem; const IncludeEmpty: Boolean): Boolean;
  var
    Scale: Single;
  begin
    Scale := 0;
    Item := ItemForCurrentScale(IncludeEmpty);
    if Item <> nil then
      Scale := Item.Scale;

    Result := (Item <> nil) and not Item.IsEmpty;
    if Result then
      FCurrentScale := Scale;
  end;

var
  Item: TCustomBitmapItem;
begin
  if not FCurrentBitmapUpdating then
  begin
    FCurrentBitmapUpdating := True;
    try
      FCurrentScale := 0;
      FCurrentBitmap := nil;
      Item := nil;
      if CurrentBitmapFound(Item, True) or CurrentBitmapFound(Item, False) then
        FCurrentBitmap := Item.Bitmap;
    finally
      FCurrentBitmapUpdating := False;
    end;
  end;
end;

procedure TImage.DrawWithMargins(const Canvas: TCanvas; const ARect: TRectF; const ABitmap: TBitmap;
  const AOpacity: Single = 1.0);
var
  R, IntersectionRect: TRectF;
  I, J: Integer;
begin
  { rightbottom }
  R := TRectF.Create(ARect.Right - FBitmapMargins.Right, ARect.Bottom - FBitmapMargins.Bottom,
    ARect.Right, ARect.Bottom);
  Canvas.DrawBitmap(ABitmap, TRectF.Create(ABitmap.Width - FBitmapMargins.Right,
    ABitmap.Height - FBitmapMargins.Bottom, ABitmap.Width, ABitmap.Height), R,
    AbsoluteOpacity, True);
  { lefttop }
  R := TRectF.Create(ARect.Left, ARect.Top, ARect.Left + FBitmapMargins.Left, ARect.Top + FBitmapMargins.Top);
  Canvas.DrawBitmap(ABitmap, TRectF.Create(0, 0, FBitmapMargins.Left, FBitmapMargins.Top), R,
    AbsoluteOpacity, True);
  { righttop }
  R := TRectF.Create(ARect.Right - FBitmapMargins.Right, ARect.Top, ARect.Right, ARect.Top + FBitmapMargins.Top);
  Canvas.DrawBitmap(ABitmap, TRectF.Create(ABitmap.Width - FBitmapMargins.Right, 0, ABitmap.Width,
    FBitmapMargins.Top), R, AbsoluteOpacity, True);
  { leftbottom }
  R := TRectF.Create(ARect.Left, ARect.Bottom - FBitmapMargins.Bottom, ARect.Left + FBitmapMargins.Left, ARect.Bottom);
  Canvas.DrawBitmap(ABitmap, TRectF.Create(0, ABitmap.Height - FBitmapMargins.Bottom,
    FBitmapMargins.Left, ABitmap.Height), R, AbsoluteOpacity, True);
  { top }
  if FMarginWrapMode = TImageWrapMode.Tile then
  begin
    for I := 0 to Trunc((ARect.Width - FBitmapMargins.Left - FBitmapMargins.Right) /
      (ABitmap.Width - FBitmapMargins.Left - FBitmapMargins.Right)) + 1 do
    begin
      R := TRectF.Create(FBitmapMargins.Left, 0, ABitmap.Width - FBitmapMargins.Bottom, FBitmapMargins.Top);
      R.Offset(ARect.Left + I * R.Width, ARect.Top);
      IntersectionRect := TRectF.Intersect(TRectF.Create(ARect.Left + FBitmapMargins.Left, ARect.Top, ARect.Right - FBitmapMargins.Right,
        ARect.Top + FBitmapMargins.Top), R);
      Canvas.DrawBitmap(ABitmap, TRectF.Create(0 + FBitmapMargins.Left, 0,
        ABitmap.Width - FBitmapMargins.Right, FBitmapMargins.Top),
        IntersectionRect, AbsoluteOpacity, True)
    end;
  end
  else
  begin
    R := TRectF.Create(ARect.Left + FBitmapMargins.Left, ARect.Top, ARect.Right - FBitmapMargins.Right,
      ARect.Top + FBitmapMargins.Top);
    Canvas.DrawBitmap(ABitmap, TRectF.Create(FBitmapMargins.Left, 0,
      ABitmap.Width - FBitmapMargins.Right, FBitmapMargins.Top), R,
      AbsoluteOpacity, True);
  end;
  { left }
  if FMarginWrapMode = TImageWrapMode.Tile then
  begin
    for J := 0 to Trunc((ARect.Height - FBitmapMargins.Bottom - FBitmapMargins.Top) / (ABitmap.Height -
      FBitmapMargins.Bottom - FBitmapMargins.Top)) + 1 do
    begin
      R := TRectF.Create(0, FBitmapMargins.Top, FBitmapMargins.Left, ABitmap.Height - FBitmapMargins.Bottom);
      R.Offset(ARect.Left, ARect.Top + J * R.Height);
      IntersectionRect := TRectF.Intersect(TRectF.Create(ARect.Left, ARect.Top + FBitmapMargins.Top, ARect.Left + FBitmapMargins.Left,
        ARect.Bottom - FBitmapMargins.Bottom), R);
      Canvas.DrawBitmap(ABitmap, TRectF.Create(0, FBitmapMargins.Top,
        FBitmapMargins.Left, FBitmapMargins.Top + IntersectionRect.Height),
        IntersectionRect, AbsoluteOpacity, True)
    end;
  end
  else
  begin
    R := TRectF.Create(ARect.Left, ARect.Top + FBitmapMargins.Top, ARect.Left + FBitmapMargins.Left,
      ARect.Bottom - FBitmapMargins.Bottom);
    Canvas.DrawBitmap(ABitmap, TRectF.Create(0, FBitmapMargins.Top, FBitmapMargins.Left,
      ABitmap.Height - FBitmapMargins.Bottom), R, AbsoluteOpacity, True);
  end;
  { right }
  if FMarginWrapMode = TImageWrapMode.Tile then
  begin
    for J := 0 to Trunc((ARect.Height - FBitmapMargins.Bottom - FBitmapMargins.Top) / (ABitmap.Height - FBitmapMargins.Bottom - FBitmapMargins.Top)) + 1 do
    begin
      R := TRectF.Create(ARect.Right - FBitmapMargins.Right, FBitmapMargins.Top, ARect.Right, ABitmap.Height - FBitmapMargins.Bottom);
      R.Offset(0, ARect.Top + J * R.Height);
      IntersectionRect := TRectF.Intersect(TRectF.Create(ARect.Right - FBitmapMargins.Right, ARect.Top + FBitmapMargins.Top, ARect.Right,
        ARect.Bottom - FBitmapMargins.Bottom), R);
      Canvas.DrawBitmap(ABitmap, TRectF.Create(ABitmap.Width - FBitmapMargins.Right, FBitmapMargins.Top,
        ABitmap.Width, FBitmapMargins.Top + IntersectionRect.Height),
        IntersectionRect, AbsoluteOpacity, True)
    end;
  end
  else
  begin
    R := TRectF.Create(ARect.Right - FBitmapMargins.Right, ARect.Top + FBitmapMargins.Top, ARect.Right,
      ARect.Bottom - FBitmapMargins.Bottom);
    Canvas.DrawBitmap(ABitmap, TRectF.Create(ABitmap.Width - FBitmapMargins.Right,
      FBitmapMargins.Top, ABitmap.Width, ABitmap.Height - FBitmapMargins.Bottom), R,
      AbsoluteOpacity, True);
  end;
  { bottom }
  if FMarginWrapMode = TImageWrapMode.Tile then
  begin
    for I := 0 to Trunc((ARect.Width - FBitmapMargins.Left - FBitmapMargins.Right) / (ABitmap.Width - FBitmapMargins.Left - FBitmapMargins.Right)) + 1 do
    begin
      R := TRectF.Create(FBitmapMargins.Left, ARect.Bottom - FBitmapMargins.Bottom, ABitmap.Width - FBitmapMargins.Right, ARect.Bottom);
      R.Offset(ARect.Left + I * R.Width, 0);
      IntersectionRect := TRectF.Intersect(TRectF.Create(ARect.Left + FBitmapMargins.Left, ARect.Bottom - FBitmapMargins.Bottom, ARect.Right - FBitmapMargins.Right,
        ARect.Bottom), R);
      Canvas.DrawBitmap(ABitmap, TRectF.Create(FBitmapMargins.Left, ABitmap.Height - FBitmapMargins.Bottom,
        ABitmap.Width - FBitmapMargins.Right, ABitmap.Height),
        IntersectionRect, AbsoluteOpacity, True)
    end;
  end
  else
  begin
    R := TRectF.Create(ARect.Left + FBitmapMargins.Left, ARect.Bottom - FBitmapMargins.Bottom,
      ARect.Right - FBitmapMargins.Right, ARect.Bottom);
    Canvas.DrawBitmap(ABitmap, TRectF.Create(FBitmapMargins.Left,
      ABitmap.Height - FBitmapMargins.Bottom, ABitmap.Width - FBitmapMargins.Right,
      ABitmap.Height), R, AbsoluteOpacity, True);
  end;
  { center }
  if FWrapMode = TImageWrapMode.Tile then
  begin
    for I := 0 to Trunc((ARect.Width - FBitmapMargins.Left - FBitmapMargins.Right) / (ABitmap.Width - FBitmapMargins.Left - FBitmapMargins.Right)) + 1 do
      for J := 0 to Trunc((ARect.Height - FBitmapMargins.Bottom - FBitmapMargins.Top) / (ABitmap.Height - FBitmapMargins.Bottom - FBitmapMargins.Top)) + 1 do
      begin
        R := FBitmapMargins.PaddingRect(RectF(0, 0, ABitmap.Width, ABitmap.Height));
        R.Offset(ARect.Left + I * R.Width, ARect.Top + J * R.Height);
        IntersectionRect := TRectF.Intersect(FBitmapMargins.PaddingRect(ARect), R);
        Canvas.DrawBitmap(ABitmap, TRectF.Create(FBitmapMargins.Left, FBitmapMargins.Top, FBitmapMargins.Left + IntersectionRect.Width, FBitmapMargins.Top + IntersectionRect.Height),
          TRectF.Create(R.Left, R.Top, R.Left + IntersectionRect.Width, R.Top + IntersectionRect.Height), AbsoluteOpacity, True)
      end;
  end
  else
  begin
    R := FBitmapMargins.PaddingRect(ARect);
    Canvas.DrawBitmap(ABitmap, TRectF.Create(FBitmapMargins.Left, FBitmapMargins.Top,
      ABitmap.Width - FBitmapMargins.Right, ABitmap.Height - FBitmapMargins.Bottom), R,
      AbsoluteOpacity, True);
  end;
end;

procedure TImage.DrawBitmap(const Canvas: TCanvas; const ARect: TRectF; const ABitmap: TBitmap;
  const AOpacity: Single = 1.0);
var
  LR, R, IntersectionRect: TRectF;
  I, J: Integer;
begin
  LR := TRectF.Create(ARect.Left * FScreenScale, ARect.Top * FScreenScale, ARect.Right * FScreenScale,
    ARect.Bottom * FScreenScale);

  if not FBitmapMargins.MarginEmpty then
    DrawWithMargins(Canvas, ARect, ABitmap, AOpacity)
  else
  begin
    case FWrapMode of
      TImageWrapMode.Original:
        begin
          R := TRectF.Create(ARect.Left, ARect.Top, ARect.Left + ABitmap.Width, ARect.Top + ABitmap.Height);
          IntersectRect(IntersectionRect, LR, R);
          Canvas.DrawBitmap(ABitmap, TRectF.Create(0, 0, IntersectionRect.Width, IntersectionRect.Height),
            TRectF.Create(R.Left, R.Top, R.Left + IntersectionRect.Width / FScreenScale, R.Top + IntersectionRect.Height / FScreenScale),
              AOpacity, DisableInterpolation)
        end;
      TImageWrapMode.Fit:
        begin
          R := TRectF.Create(0, 0, ABitmap.Width / ABitmap.BitmapScale, ABitmap.Height / ABitmap.BitmapScale);
          R := R.FitInto(ARect).SnapToPixel(Canvas.Scale, False);
          Canvas.DrawBitmap(ABitmap, TRectF.Create(0, 0, ABitmap.Width, ABitmap.Height), R, AOpacity, DisableInterpolation);
        end;
      TImageWrapMode.Stretch:
        begin
          Canvas.DrawBitmap(ABitmap, TRectF.Create(0, 0, ABitmap.Width, ABitmap.Height), ARect, AOpacity, DisableInterpolation)
        end;
      TImageWrapMode.Tile:
        begin
          for I := 0 to Trunc(LR.Width / ABitmap.Width) + 1 do
            for J := 0 to Trunc(LR.Height / ABitmap.Height) + 1 do
            begin
              R := TRectF.Create(0, 0, ABitmap.Width, ABitmap.Height);
              OffsetRect(R, I * ABitmap.Width, J * ABitmap.Height);
              IntersectRect(IntersectionRect, LR, R);
              Canvas.DrawBitmap(ABitmap, TRectF.Create(0, 0, IntersectionRect.Width, IntersectionRect.Height),
                TRectF.Create(R.Left / FScreenScale, R.Top / FScreenScale, (R.Left + IntersectionRect.Width) / FScreenScale,
                  (R.Top + IntersectionRect.Height) / FScreenScale), AOpacity, True)
            end;
        end;
      TImageWrapMode.Center:
        begin
          R := TRectF.Create(0, 0, ABitmap.Width / ABitmap.BitmapScale, ABitmap.Height / ABitmap.BitmapScale);
          R := R.CenterAt(ARect).SnapToPixel(Canvas.Scale, False);
          Canvas.DrawBitmap(ABitmap, TRectF.Create(0, 0, ABitmap.Width, ABitmap.Height), R, AOpacity, DisableInterpolation);
        end;
      TImageWrapMode.Place:
        begin
          R := TRectF.Create(0, 0, ABitmap.Width / ABitmap.BitmapScale, ABitmap.Height / ABitmap.BitmapScale);
          R := R.PlaceInto(ARect).SnapToPixel(Canvas.Scale, False);
          Canvas.DrawBitmap(ABitmap, TRectF.Create(0, 0, ABitmap.Width, ABitmap.Height), R, AOpacity, DisableInterpolation);
        end;
    end;
  end;
end;

procedure TImage.Paint;
var
  R: TRectF;
begin
  if (csDesigning in ComponentState) and not Locked and not FInPaintTo then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.DrawDashRect(R, 0, 0, AllCorners, AbsoluteOpacity, $A0909090);
  end;

  UpdateCurrentBitmap;
  if FCurrentBitmap <> nil then
    DrawBitmap(Canvas, LocalRect, FCurrentBitmap, AbsoluteOpacity);
end;

procedure TImage.ScaleChangedHandler(const Sender: TObject; const Msg: TMessage);
begin
  Repaint;
end;

procedure TImage.SetBitmap(const Value: TBitmap);
var
  LBitmap: TBitmap;
begin
  LBitmap := GetBitmap;
  if LBitmap <> nil then
    LBitmap.Assign(Value);
end;

procedure TImage.SetBitmapMargins(const Value: TBounds);
begin
  FBitmapMargins.Assign(Value);
end;

procedure TImage.SetMultiResBitmap(const Value: TFixedMultiResBitmap);
begin
  FMultiResBitmap.Assign(Value);
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

{ TPath }

constructor TCustomPath.Create(AOwner: TComponent);
begin
  inherited;
  FWrapMode := TPathWrapMode.Stretch;
  FData := TPathData.Create;
  FData.OnChanged := DoChanged;
  FCurrent := TPathData.Create;
end;

destructor TCustomPath.Destroy;
begin
  FCurrent.Free;
  FData.Free;
  inherited;
end;

procedure TCustomPath.UpdateCurrent;
var
  B: TRectF;
  P: TPathData;
begin
  if FNeedUpdate then
  begin
    FNeedUpdate := False;

    P := FData;
    if FData.ResourcePath <> nil then
      P := FData.ResourcePath;

    if not P.IsEmpty then
    begin
      case FWrapMode of
        TPathWrapMode.Original:
          FCurrent.Assign(P);
        TPathWrapMode.Fit:
          begin
            FCurrent.Assign(P);
            FCurrent.FitToRect(ShapeRect);
          end;
        TPathWrapMode.Stretch:
          begin
            B := P.GetBounds;
            if (B.Width > 0) and (B.Height > 0) then
            begin
              FCurrent.Assign(P);
              FCurrent.Translate(-B.Left, -B.Top);
              FCurrent.Scale(ShapeRect.Width / B.Width, ShapeRect.Height / B.Height);
            end;
          end;
        TPathWrapMode.Tile:
          begin
            B := P.GetBounds;
            FCurrent.Assign(P);
            FCurrent.Translate(-B.Left, -B.Top);
          end;
      end;
      if Stroke.Kind <> TBrushKind.None then
        FCurrent.Translate(Stroke.Thickness / 2, Stroke.Thickness / 2);
    end
    else
      FCurrent.Clear;
  end;
end;

procedure TCustomPath.StrokeChanged(Sender: TObject);
begin
  inherited;
  FNeedUpdate := True;
end;

procedure TCustomPath.DoChanged(Sender: TObject);
begin
  FNeedUpdate := True;
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
    FNeedUpdate := True;
end;

function TCustomPath.PointInObject(X, Y: Single): Boolean;
begin
  if (csDesigning in ComponentState) and not FLocked and not FInPaintTo then
    Result := inherited PointInObject(X, Y)
  else
  begin
    UpdateCurrent;
    if (Canvas <> nil) and not (FCurrent.IsEmpty) and (FWrapMode <> TPathWrapMode.Tile) then
      Result := Canvas.PtInPath(AbsoluteToLocal(TPointF.Create(X, Y)), FCurrent)
    else
      Result := inherited PointInObject(X, Y);
  end;
end;

procedure TCustomPath.Resize;
begin
  inherited;
  FNeedUpdate := True;
end;

procedure TCustomPath.Paint;

  procedure PaintInternal;
  var
    R: TRectF;
    I, J: Integer;
    TempPath: TPathData;
    PrevDelta, Delta: TPointF;
  begin
    case FWrapMode of
      TPathWrapMode.Original,
      TPathWrapMode.Fit,
      TPathWrapMode.Stretch:
        begin
          Canvas.FillPath(FCurrent, AbsoluteOpacity, FFill);
          Canvas.DrawPath(FCurrent, AbsoluteOpacity, FStroke);
        end;
      TPathWrapMode.Tile:
        begin
          R := FCurrent.GetBounds;
          TempPath := TPathData.Create;
          try
            TempPath.Assign(FCurrent);
            PrevDelta := TPointF.Zero;
            for J := 0 to Round(Height / R.Height) do
              for I := 0 to Round(Width / R.Width) do
              begin
                Delta := TPointF.Create(ShapeRect.Left + I * (R.Width + ShapeRect.Left * 2), ShapeRect.Top + J *
                  (R.Height + ShapeRect.Top * 2));
                TempPath.Translate(Delta - PrevDelta);
                PrevDelta := Delta;
                Canvas.FillPath(TempPath, AbsoluteOpacity, FFill);
                Canvas.DrawPath(TempPath, AbsoluteOpacity, FStroke);
              end;
          finally
            TempPath.Free;
          end;
        end;
    end;
  end;

var
  R: TRectF;
  State: TCanvasSaveState;
begin
  UpdateCurrent;
  if not FCurrent.IsEmpty then
  begin
    if (FWrapMode in [TPathWrapMode.Original, TPathWrapMode.Tile]) or ((Stroke.Kind <> TBrushKind.None) and
      (Stroke.Thickness > 1) and (Stroke.Join = TStrokeJoin.Miter) and
      SameValue(RotationAngle, 0, TEpsilon.Vector)) then
    begin
      State := Canvas.SaveState;
      try
        Canvas.IntersectClipRect(LocalRect);
        PaintInternal;
      finally
        Canvas.RestoreState(State);
      end;
    end
    else
      PaintInternal;
  end;
  if (csDesigning in ComponentState) and not FLocked and not FInPaintTo then
  begin
    R := LocalRect;
    R.Inflate(-0.5, -0.5);
    Canvas.DrawDashRect(R, 0, 0, AllCorners, AbsoluteOpacity, $A0909090);
  end;
end;

procedure TCustomPath.SetWrapMode(const Value: TPathWrapMode);
begin
  if FWrapMode <> Value then
  begin
    FWrapMode := Value;
    FNeedUpdate := True;
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
  FColor := DefaultColor;
  FShowHandles := True;
  FMinSize := 15;
  FGripSize := 3;
  SetAcceptsControls(False);
end;

destructor TSelection.Destroy;
begin
  inherited;
end;

function TSelection.GetProportionalSize(const ASize: TPointF): TPointF;
begin
  Result := ASize;
  if FRatio * Result.Y  > Result.X  then
  begin
    if Result.X < FMinSize then
      Result.X := FMinSize;
    Result.Y := Result.X / FRatio;
    if Result.Y < FMinSize then
    begin
      Result.Y := FMinSize;
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
      Result.X := FMinSize;
      Result.Y := FMinSize / FRatio;
    end;
  end;
end;

function TSelection.GetHandleForPoint(const P: TPointF): TGrabHandle;
var
  Local, R: TRectF;
begin
  Local := LocalRect;
  R := TRectF.Create(Local.Left - GripSize, Local.Top - GripSize, Local.Left + GripSize, Local.Top + GripSize);
  if R.Contains(P) then
    Exit(TGrabHandle.LeftTop);
  R := TRectF.Create(Local.Right - GripSize, Local.Top - GripSize, Local.Right + GripSize, Local.Top + GripSize);
  if R.Contains(P) then
    Exit(TGrabHandle.RightTop);
  R := TRectF.Create(Local.Right - GripSize, Local.Bottom - GripSize, Local.Right + GripSize, Local.Bottom + GripSize);
  if R.Contains(P) then
    Exit(TGrabHandle.RightBottom);
  R := TRectF.Create(Local.Left - GripSize, Local.Bottom - GripSize, Local.Left + GripSize, Local.Bottom + GripSize);
  if R.Contains(P) then
    Exit(TGrabHandle.LeftBottom);
  Result := TGrabHandle.None;
end;


procedure TSelection.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  // this line may be necessary because TSelection is not a styled control;
  // must further investigate for a better fix
  if not Enabled then
    Exit;

  inherited;

  FDownPos := TPointF.Create(X, Y);
  if Button = TMouseButton.mbLeft then
  begin
    FRatio := Width / Height;
    FActiveHandle := GetHandleForPoint(FDownPos);
  end;
end;

procedure TSelection.MouseMove(Shift: TShiftState; X, Y: Single);
var
  P, OldPos: TPointF;
  MoveVector: TVector;
  MovePos: TPointF;
  GrabHandle: TGrabHandle;
begin
  // this line may be necessary because TSelection is not a styled control;
  // must further investigate for a better fix
  if not Enabled then
    Exit;

  inherited;

  MovePos := TPointF.Create(X, Y);
  if not Pressed then
  begin
    // handle painting for hotspot mouse hovering
    GrabHandle := GetHandleForPoint(MovePos);
    if GrabHandle <> FHotHandle then
      Repaint;
    FHotHandle := GrabHandle;
  end
  else if ssLeft in Shift then
  begin
    if FActiveHandle = TGrabHandle.None then
    begin
      MoveVector := LocalToAbsoluteVector(TVector.Create(X - FDownPos.X, Y - FDownPos.Y));
      if ParentControl <> nil then
        MoveVector := ParentControl.AbsoluteToLocalVector(MoveVector);
      Position.Point := Position.Point + TPointF(MoveVector);
      if ParentBounds then
      begin
        if Position.X < 0 then
          Position.X := 0;
        if Position.Y < 0 then
          Position.Y := 0;
        if ParentControl <> nil then
        begin
          if Position.X + Width > ParentControl.Width then
            Position.X := ParentControl.Width - Width;
          if Position.Y + Height > ParentControl.Height then
            Position.Y := ParentControl.Height - Height;
        end
        else
          if Canvas <> nil then
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
    P := LocalToAbsolute(MovePos);
    if ParentControl <> nil then
      P := ParentControl.AbsoluteToLocal(P);
    if ParentBounds then
    begin
      if P.Y < 0 then
        P.Y := 0;
      if P.X < 0 then
        P.X := 0;
      if ParentControl <> nil then
      begin
        if P.X > ParentControl.Width then
          P.X := ParentControl.Width;
        if P.Y > ParentControl.Height then
          P.Y := ParentControl.Height;
      end
      else
        if Canvas <> nil then
        begin
          if P.X > Canvas.Width then
            P.X := Canvas.Width;
          if P.Y > Canvas.Height then
            P.Y := Canvas.Height;
        end;
    end;
    MoveHandle(X, Y);
  end;
end;

function TSelection.PointInObjectLocal(X, Y: Single): Boolean;
begin
  Result := inherited or (GetHandleForPoint(TPointF.Create(X, Y)) <> TGrabHandle.None);
end;

procedure TSelection.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  // this line may be necessary because TSelection is not a styled control;
  // must further investigate for a better fix
  if not Enabled then
    Exit;

  inherited;

  if Assigned(FOnChange) then
    FOnChange(Self);
  FActiveHandle := TGrabHandle.None;
end;

procedure TSelection.DrawFrame(const Canvas: TCanvas; const Rect: TRectF);
begin
  Canvas.DrawDashRect(Rect, 0, 0, AllCorners, AbsoluteOpacity, FColor);
end;

procedure TSelection.DrawHandle(const Canvas: TCanvas; const Handle: TGrabHandle; const Rect: TRectF);
var
  Fill: TBrush;
  Stroke: TStrokeBrush;
begin
  Fill := TBrush.Create(TBrushKind.Solid, claWhite);
  Stroke := TStrokeBrush.Create(TBrushKind.Solid, FColor);
  try
    if Enabled then
      if FHotHandle = Handle then
        Canvas.Fill.Color := claRed
      else
        Canvas.Fill.Color := claWhite
    else
      Canvas.Fill.Color := claGrey;

    Canvas.FillEllipse(Rect, AbsoluteOpacity, Fill);
    Canvas.DrawEllipse(Rect, AbsoluteOpacity, Stroke);
  finally
    Fill.Free;
    Stroke.Free;
  end;
end;

procedure TSelection.Paint;
var
  R: TRectF;
begin
  if FHideSelection then
    Exit;

  R := LocalRect;
  R.Inflate(-0.5, -0.5);
  DrawFrame(Canvas, R);

  if ShowHandles then
  begin
    R := LocalRect;
    DrawHandle(Canvas, TGrabHandle.LeftTop, TRectF.Create(R.Left - GripSize, R.Top - GripSize, R.Left + GripSize,
      R.Top + GripSize));
    DrawHandle(Canvas, TGrabHandle.RightTop, TRectF.Create(R.Right - GripSize, R.Top - GripSize, R.Right + GripSize,
      R.Top + GripSize));
    DrawHandle(Canvas, TGrabHandle.LeftBottom, TRectF.Create(R.Left - GripSize, R.Bottom - GripSize, R.Left + GripSize,
      R.Bottom + GripSize));
    DrawHandle(Canvas, TGrabHandle.RightBottom, TRectF.Create(R.Right - GripSize, R.Bottom - GripSize,
      R.Right + GripSize, R.Bottom + GripSize));
  end;
end;

function TSelection.DoGetUpdateRect: TRectF;
begin
  Result := inherited;
  Result.Inflate((FGripSize + 1) * Scale.X, (FGripSize + 1) * Scale.Y);
end;


procedure TSelection.ResetInSpace(const ARotationPoint: TPointF; ASize: TPointF);
var
  LLocalPos: TPointF;
  LAbsPos: TPointF;
begin
  LAbsPos := LocalToAbsolute(ARotationPoint);
  if ParentControl <> nil then
  begin
    LLocalPos := ParentControl.AbsoluteToLocal(LAbsPos);
    LLocalPos.X := LLocalPos.X - ASize.X * RotationCenter.X * Scale.X;
    LLocalPos.Y := LLocalPos.Y - ASize.Y * RotationCenter.Y * Scale.Y;
    if ParentBounds then
    begin
      if LLocalPos.X < 0 then
      begin
        ASize.X := ASize.X + LLocalPos.X;
        LLocalPos.X := 0;
      end;
      if LLocalPos.Y < 0 then
      begin
        ASize.Y := ASize.Y + LLocalPos.Y;
        LLocalPos.Y := 0;
      end;
      if LLocalPos.X + ASize.X > ParentControl.Width then
        ASize.X := ParentControl.Width - LLocalPos.X;
      if LLocalPos.Y + ASize.Y > ParentControl.Height then
        ASize.Y := ParentControl.Height - LLocalPos.Y;
    end;
  end
  else
  begin
    LLocalPos.X := LAbsPos.X - ASize.X * RotationCenter.X * Scale.X;
    LLocalPos.Y := LAbsPos.Y - ASize.Y * RotationCenter.Y * Scale.Y;
  end;
  SetBounds(LLocalPos.X, LLocalPos.Y, ASize.X, ASize.Y);
end;

procedure TSelection.GetTransformLeftTop(AX, AY: Single; var NewSize: TPointF; var Pivot: TPointF);
var
  LCorrect: TPointF;
begin
  NewSize := Size.Size - TSizeF.Create(AX, AY);
  if NewSize.Y < FMinSize then
  begin
    AY := Height - FMinSize;
    NewSize.Y := FMinSize;
  end;
  if NewSize.X < FMinSize then
  begin
    AX := Width - FMinSize;
    NewSize.X := FMinSize;
  end;
  if FProportional then
  begin
    LCorrect := NewSize;
    NewSize := GetProportionalSize(NewSize);
    LCorrect := LCorrect - NewSize;
    AX := AX + LCorrect.X;
    AY := AY + LCorrect.Y;
  end;
  Pivot := TPointF.Create(Width * RotationCenter.X + AX * (1 - RotationCenter.X),
    Height * RotationCenter.Y + AY * (1 - RotationCenter.Y));
end;

procedure TSelection.GetTransformLeftBottom(AX, AY: Single; var NewSize: TPointF; var Pivot: TPointF);
var
  LCorrect: TPointF;
begin
  NewSize := TPointF.Create(Width - AX, AY);
  if NewSize.Y < FMinSize then
  begin
    AY := FMinSize;
    NewSize.Y := FMinSize;
  end;
  if NewSize.X < FMinSize then
  begin
    AX := Width - FMinSize;
    NewSize.X := FMinSize;
  end;
  if FProportional then
  begin
    LCorrect := NewSize;
    NewSize := GetProportionalSize(NewSize);
    LCorrect := LCorrect - NewSize;
    AX := AX + LCorrect.X;
    AY := AY + LCorrect.Y;
  end;
  Pivot := TPointF.Create(Width * RotationCenter.X + AX * (1 - RotationCenter.X),
    Height * RotationCenter.Y + (AY - Height) * RotationCenter.Y);
end;

procedure TSelection.GetTransformRightTop(AX, AY: Single; var NewSize: TPointF; var Pivot: TPointF);
var
  LCorrect: TPointF;
begin
  NewSize := TPointF.Create(AX, Height - AY);
  if NewSize.Y < FMinSize then
  begin
    AY := Height - FMinSize;
    NewSize.Y := FMinSize;
  end;
  if AX < FMinSize then
  begin
    AX := FMinSize;
    NewSize.X := FMinSize;
  end;
  if FProportional then
  begin
    LCorrect := NewSize;
    NewSize := GetProportionalSize(NewSize);
    LCorrect := LCorrect - NewSize;
    AX := AX - LCorrect.X;
    AY := AY + LCorrect.Y;
  end;
  Pivot := TPointF.Create(Width * RotationCenter.X + (AX - Width) * RotationCenter.X,
    Height * RotationCenter.Y + AY * (1 - RotationCenter.Y));
end;

procedure TSelection.GetTransformRightBottom(AX, AY: Single; var NewSize: TPointF; var Pivot: TPointF);
var
  LCorrect: TPointF;
begin
  NewSize := TPointF.Create(AX, AY);
  if NewSize.Y < FMinSize then
  begin
    AY := FMinSize;
    NewSize.Y := FMinSize;
  end;
  if NewSize.X < FMinSize then
  begin
    AX := FMinSize;
    NewSize.X := FMinSize;
  end;
  if FProportional then
  begin
    LCorrect := NewSize;
    NewSize := GetProportionalSize(NewSize);
    LCorrect := LCorrect - NewSize;
    AX := AX - LCorrect.X;
    AY := AY - LCorrect.Y;
  end;
  Pivot := TPointF.Create(Width * RotationCenter.X + (AX - Width) * RotationCenter.X,
    Height * RotationCenter.Y + (AY - Height) * RotationCenter.Y);
end;

procedure TSelection.MoveHandle(AX, AY: Single);
var
  NewSize, Pivot: TPointF;
begin
  case FActiveHandle of
    TSelection.TGrabHandle.LeftTop: GetTransformLeftTop(AX, AY, NewSize, Pivot);
    TSelection.TGrabHandle.LeftBottom: GetTransformLeftBottom(AX, AY, NewSize, Pivot);
    TSelection.TGrabHandle.RightTop: GetTransformRightTop(AX, AY, NewSize, Pivot);
    TSelection.TGrabHandle.RightBottom: GetTransformRightBottom(AX, AY, NewSize, Pivot);
  end;
  ResetInSpace(Pivot, NewSize);
  if Assigned(FOnTrack) then
    FOnTrack(Self);
end;

procedure TSelection.DoMouseLeave;
begin
  inherited;
  FHotHandle := TGrabHandle.None;
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

procedure TSelection.SetShowHandles(const Value: Boolean);
begin
  if FShowHandles <> Value then
  begin
    FShowHandles := Value;
    Repaint;
  end;
end;

procedure TSelection.SetColor(const Value: TAlphaColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Repaint;
  end;
end;

procedure TSelection.SetGripSize(const Value: Single);
begin
  if FGripSize <> Value then
  begin
    if Value < FGripSize then
      Repaint;
    FGripSize := Value;
    if FGripSize > 20 then
      FGripSize := 20;
    if FGripSize < 1 then
      FGripSize := 1;
    HandleSizeChanged;
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
  FGripCenter := TPosition.Create(TPointF.Zero);
end;

destructor TSelectionPoint.Destroy;
begin
  FreeAndNil(FGripCenter);
  inherited;
end;

function TSelectionPoint.PointInObjectLocal(X, Y: Single): Boolean;
var
  GripSizeTmp: Single;
begin
  Result := inherited PointInObjectLocal(X, Y);

  if FStylized and (ResourceControl <> nil) then
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
    Canvas.Stroke.Kind := TBrushKind.Solid;
    Canvas.Stroke.Color := $FF1072C5;
    Canvas.Fill.Kind := TBrushKind.Solid;

    if IsMouseOver then
      FillColor := claRed
    else
      FillColor := claWhite;
    Stroke := TStrokeBrush.Create(TBrushKind.Solid, $FF1072C5);
    try
      Fill := TBrush.Create(TBrushKind.Solid, FillColor);
      try
        Canvas.FillEllipse(TRectF.Create(-GripSize, -GripSize, GripSize, GripSize), AbsoluteOpacity, Fill);
        Canvas.DrawEllipse(TRectF.Create(-GripSize, -GripSize, GripSize, GripSize), AbsoluteOpacity, Stroke);
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
  if FPressed and (ParentControl <> nil) then
  begin
    P := LocalToAbsolute(PointF(X, Y));
    P := ParentControl.AbsoluteToLocal(P);
    P.Offset(FGripCenter.Point);
    if ParentBounds then
    begin
      if P.X < 0 then
        P.X := 0;
      if P.Y < 0 then
        P.Y := 0;
      if ParentControl <> nil then
      begin
        if P.X > ParentControl.Width then
          P.X := ParentControl.Width;
        if P.Y > ParentControl.Height then
          P.Y := ParentControl.Height;
      end
      else
        if Canvas <> nil then
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

function TSelectionPoint.DoGetUpdateRect: TRectF;
begin
  Result := inherited DoGetUpdateRect;
  if FStylized and (ResourceControl <> nil) then
    Result.Inflate(AbsoluteScale.X * (ResourceControl.Width / 2),
                        AbsoluteScale.Y * (ResourceControl.Height / 2))
  else
    Result.Inflate(AbsoluteScale.X * (GripSize + 1), AbsoluteScale.Y * (GripSize + 1));
end;

procedure TSelectionPoint.SetGripCenter(const Value: TPosition);
begin
  FGripCenter.Assign(Value);
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

procedure RegisterAliases;
begin
  AddEnumElementAliases(TypeInfo(TLineType), ['ltDiagonal', 'ltTop', 'ltLeft']);
  AddEnumElementAliases(TypeInfo(TCalloutPosition), ['cpTop', 'cpLeft', 'cpBottom', 'cpRight']);
  AddEnumElementAliases(TypeInfo(TPathWrapMode), ['pwOriginal', 'pwFit', 'pwStretch', 'pwTile']);
  AddEnumElementAliases(TypeInfo(TImageWrapMode), ['iwOriginal', 'iwFit', 'iwStretch', 'iwTile', 'iwCenter']);
end;

procedure UnregisterAliases;
begin
  RemoveEnumElementAliases(TypeInfo(TLineType));
  RemoveEnumElementAliases(TypeInfo(TCalloutPosition));
  RemoveEnumElementAliases(TypeInfo(TPathWrapMode));
  RemoveEnumElementAliases(TypeInfo(TImageWrapMode));
end;

{ TText.TAcceleratorInfo }

destructor TText.TAcceleratorInfo.Destroy;
begin
  FBrush.Free;
  inherited;
end;

function TText.TAcceleratorInfo.DrawUnderline(const AnOwnerControl: TControl; const ACanvas: TCanvas;
  const ALayout: TTextLayout; const AColor: TAlphaColor; const AnOpacity: Single): Boolean;
begin
  if not IsUnderlineValid then
    if not ValidateUnderlinePoints(AnOwnerControl, ACanvas, ALayout) then
      Exit(False);
  Brush.Thickness := 1;
  Brush.Color := AColor;
  ACanvas.DrawLine(FUnderlineBeginPoint, FUnderlineEndPoint, AnOpacity, Brush);
  Result := True;
end;

function TText.TAcceleratorInfo.GetBrush: TStrokeBrush;
begin
  if FBrush = nil then
    FBrush := TStrokeBrush.Create(TBrushKind.Solid, TAlphaColorRec.Black);
  Result := FBrush;
end;

procedure TText.TAcceleratorInfo.InvalidateUnderline;
begin
  FIsUnderlineValid := False;
end;

procedure TText.TAcceleratorInfo.SetKeyIndex(const Value: Integer);
begin
  FKeyIndex := Value;
  FIsUnderlineValid := False;
end;

function TText.TAcceleratorInfo.ValidateUnderlinePoints(const AnOwnerControl: TControl; const ACanvas: TCanvas;
  const ALayout: TTextLayout): Boolean;
var
  LRange: TTextRange;
  LBounds: TRegion;
  LBaseLine: Single;
  LRect: TRectF;
begin
  if not (csDesigning in AnOwnerControl.ComponentState) or
    TPlatformServices.Current.SupportsPlatformService(IFMXAcceleratorKeyRegistryService) then
  begin
    LBaseline := TFontGlyphManager.Current.GetBaseline(ALayout.Font, ACanvas.Scale);
    LRange.Pos := FKeyIndex;
    LRange.Length := 1;
    LBounds := ALayout.RegionForRange(LRange);
    LRect := LBounds[0];
    FUnderlineBeginPoint := TPointF.Create(LRect.Left, LRect.Top + LBaseLine);
    FUnderlineEndPoint := TPointF.Create(LRect.Right, LRect.Top + LBaseLine);
    FIsUnderlineValid := True;

    // Perform some corrections depending on the canvas type
    FUnderlineBeginPoint.Y := Ceil(FUnderlineBeginPoint.Y) + 1.5;
    FUnderlineEndPoint.Y := Ceil(FUnderlineEndPoint.Y) + 1.5;

    if GlobalUseGPUCanvas then
    begin
      FUnderlineBeginPoint.X := FUnderlineBeginPoint.X + 0.5;
      FUnderlineEndPoint.X := FUnderlineEndPoint.X - 0.5;
    end
    else
      if GlobalUseDirect2D then
      begin
        FUnderlineBeginPoint.X := FUnderlineBeginPoint.X + 1;
        FUnderlineEndPoint.X := FUnderlineEndPoint.X - 1;
      end
      else
      begin
        FUnderlineBeginPoint.X := FUnderlineBeginPoint.X + 1;
        FUnderlineEndPoint.X := FUnderlineEndPoint.X - 2;
      end;

    if FUnderlineBeginPoint.X <= FUnderlineEndPoint.X then
      FUnderlineEndPoint.X := FUnderlineEndPoint.X + 1;
    Result := True;
  end
  else
    Result := False;
end;

initialization
  RegisterAliases;
  RegisterFmxClasses([TLine, TRectangle, TRoundRect, TEllipse, TCircle, TArc,
    TPie, TText, TPath, TImage, TPaintBox, TCalloutRectangle,
    TSelection, TSelectionPoint]);
  RegisterFlasherClass(TCaretRectangle, TCaret);
finalization
  UnregisterAliases;
end.
