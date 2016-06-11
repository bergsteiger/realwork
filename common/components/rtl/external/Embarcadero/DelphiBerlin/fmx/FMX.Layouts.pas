{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Layouts;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Types, System.UITypes, System.SysUtils, System.Math.Vectors, FMX.Types, FMX.StdCtrls,
  FMX.Platform, FMX.Controls, FMX.InertialMovement;

type

{ TLayout }

  TLayout = class(TControl)
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property Anchors;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DragMode;
    property EnableDragHighlight;
    property Enabled;
    property Locked;
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
    property Size;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    property TabOrder;
    property TabStop;
    { Events }
    property OnPainting;
    property OnPaint;
    property OnResize;
    { Drag and Drop events }
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    { Mouse events }
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

{ TScaledLayout }

  TScaledLayout = class(TControl)
  private
    FOriginalWidth: Single;
    FOriginalHeight: Single;
    procedure SetOriginalWidth(const Value: Single);
    procedure SetOriginalHeight(const Value: Single);
  protected
    procedure DoRealign; override;
    function GetChildrenMatrix(var Matrix: TMatrix; var Simple: Boolean): Boolean; override;
    procedure SetHeight(const Value: Single); override;
    procedure SetWidth(const Value: Single); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Anchors;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DragMode;
    property EnableDragHighlight;
    property Enabled;
    property Locked;
    property Height;
    property HitTest default False;
    property Padding;
    property Opacity;
    property OriginalWidth: Single read FOriginalWidth write SetOriginalWidth;
    property OriginalHeight: Single read FOriginalHeight write SetOriginalHeight;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    { Events }
    property OnPainting;
    property OnPaint;
    property OnResize;
    { Drag and Drop events }
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    { Mouse events }
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

  TCustomScrollBox = class;

{ TScrollContent }

  TScrollContent = class(TContent)
  private
    [weak] FScrollBox: TCustomScrollBox;
    FIsContentChanged: Boolean;
  protected
    function GetClipRect: TRectF; override;
    function GetChildrenRect: TRectF; override;
    function ObjectAtPoint(P: TPointF): IControl; override;
    function DoGetUpdateRect: TRectF; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    procedure DoRealign; override;
    procedure ContentChanged; override;
    /// <summary> This flag is set in the method ContentChanged. Used to optimize ScrollBox </summary>
    property IsContentChanged: Boolean read FIsContentChanged write FIsContentChanged;
  public
    constructor Create(AOwner: TComponent); override;
    property ScrollBox: TCustomScrollBox read FScrollBox;
    function PointInObjectLocal(X, Y: Single): Boolean; override;
  end;

  TScrollCalculations = class (TAniCalculations)
  private
    [Weak] FScrollBox: TCustomScrollBox;
  protected
    procedure DoChanged; override;
    procedure DoStart; override;
    procedure DoStop; override;
  public
    constructor Create(AOwner: TPersistent); override;
    property ScrollBox: TCustomScrollBox read FScrollBox;
  end;

{ TCustomScrollBox }

  TPositionChangeEvent = procedure (Sender: TObject;
                              const OldViewportPosition, NewViewportPosition: TPointF;
                              const ContentSizeChanged: Boolean) of object;

  TOnCalcContentBoundsEvent = procedure (Sender: TObject;
                                     var ContentBounds: TRectF) of object;

  TCustomScrollBox = class(TStyledControl)
  private
  const
    SmallChangeFraction = 5;
    DesignBorderColor: TAlphaColor = $80A070A0;
  type
    TScrollInfo = record
      [Weak] Scroll: TScrollBar;
      Align: TAlignLayout;
      Margins: TRectF;
    end;
  var
    FSystemInfoSrv: IFMXSystemInformationService;
    FDisableMouseWheel: Boolean;

    FAniCalculations: TScrollCalculations;
    FLastViewportPosition: TPointF;
    FInInternalAlign: Boolean;

    FBackground: TControl;
    FContent: TScrollContent;
    FContentLayout: TControl;
    FContentBounds: TRectF;
    FCachedContentSize: TSizeF;
    FCachedAutoShowing: Boolean;
    FOriginalContentLayoutSize: TSizeF;

    FShowScrollBars: Boolean;
    FAutoHide: Boolean;
    FHScrollInfo: array of TScrollInfo;
    FVScrollInfo: array of TScrollInfo;
    FContentMargins: TRectF;
    FVDisablePaint: Boolean;
    FHDisablePaint: Boolean;
    FGDisablePaint: Boolean;

    FSizeGripContent: TControl;
    FSizeGripParent: TControl;
    FSizeGrip: TControl;
    FShowSizeGrip: Boolean;
    FOnViewportPositionChange: TPositionChangeEvent;
    FOnHScrollChange: TNotifyEvent;
    FOnVScrollChange: TNotifyEvent;
    FOnCalcContentBounds: TOnCalcContentBoundsEvent;
    FMouseEvents: Boolean;
    FContentCalculated: Boolean;
    function HScrollIndex: Integer;
    function VScrollIndex: Integer;
    function GetHScrollAlign: TAlignLayout;
    function GetVScrollAlign: TAlignLayout;
    function GetHScrollMargins: TRectF;
    function GetVScrollMargins: TRectF;
    function GetSceneScale: Single;
    procedure SetShowScrollBars(const Value: Boolean);
    procedure SetShowSizeGrip(const Value: Boolean);
    function GetVScrollBar: TScrollBar;
    function GetHScrollBar: TScrollBar;
    procedure UpdateSizeGrip;
    procedure UpdateVScrollBar(const Value: Single; const ViewportSize: Single);
    procedure UpdateHScrollBar(const Value: Single; const ViewportSize: Single);
    procedure InternalAlign;
    procedure HScrollChangeProc(Sender: TObject);
    procedure VScrollChangeProc(Sender: TObject);
    procedure MousePosToAni(var X, Y: Single);
    procedure SetAutoHide(const Value: Boolean);
    procedure SaveDisablePaint;
    procedure RestoreDisablePaint;
    procedure SetDisablePaint;
    function GetViewportPosition: TPointF;
    procedure SetViewportPosition(const Value: TPointF);
    procedure StartScrolling;
    procedure StopScrolling;
    procedure UpdateOriginalContentLayoutSize(const Force: Boolean);
    procedure ReadPartSize(Reader: TReader; var Size: Single);
    procedure ReadContentLayoutHeight(Reader: TReader);
    procedure ReadContentLayoutWidth(Reader: TReader);
    procedure WriteContentLayoutHeight(Writer: TWriter);
    procedure WriteContentLayoutWidth(Writer: TWriter);
  protected
    //Animation mouse events
    procedure AniMouseDown(const Touch: Boolean; const X, Y: Single); virtual;
    procedure AniMouseMove(const Touch: Boolean; const X, Y: Single); virtual;
    procedure AniMouseUp(const Touch: Boolean; const X, Y: Single); virtual;

    function GetScrollingBehaviours: TScrollingBehaviours;
    procedure Loaded; override;
    procedure PaddingChanged; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoRealign; override;
    function IsAddToContent(const AObject: TFmxObject): Boolean; virtual;
    procedure ContentAddObject(const AObject: TFmxObject); virtual;
    procedure ContentInsertObject(Index: Integer; const AObject: TFmxObject); virtual;
    procedure ContentBeforeRemoveObject(AObject: TFmxObject); virtual;
    procedure ContentRemoveObject(const AObject: TFmxObject); virtual;
    procedure HScrollChange; virtual;
    procedure VScrollChange; virtual;
    procedure ViewportPositionChange(const OldViewportPosition, NewViewportPosition: TPointF;
                                     const ContentSizeChanged: boolean); virtual;
    procedure CMGesture(var EventInfo: TGestureEventInfo); override;
    procedure Painting; override;
    procedure AfterPaint; override;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    function IsOpaque: Boolean; virtual;
    function ContentRect: TRectF;
    function VScrollBarValue: Single;
    function HScrollBarValue: Single;
    function CreateScrollContent: TScrollContent; virtual;
    function CreateAniCalculations: TScrollCalculations; virtual;
    procedure DoUpdateAniCalculations(const AAniCalculations: TScrollCalculations); virtual;
    procedure UpdateAniCalculations;
    function DoCalcContentBounds: TRectF; virtual;
    procedure DoRealignContent(R: TRectF); virtual;
    function GetContentBounds: TRectF;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure DoMouseLeave; override;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); override;
    property ContentLayout: TControl read FContentLayout;
    property Content: TScrollContent read FContent;
    property HScrollAlign: TAlignLayout read GetHScrollAlign;
    property VScrollAlign: TAlignLayout read GetVScrollAlign;
    property HScrollMargins: TRectF read GetHScrollMargins;
    property VScrollMargins: TRectF read GetVScrollMargins;
    property InInternalAlign: Boolean read FInInternalAlign;
    property HScrollBar: TScrollBar read GetHScrollBar;
    property VScrollBar: TScrollBar read GetVScrollBar;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property AniCalculations: TScrollCalculations read FAniCalculations;
    property ViewportPosition: TPointF read GetViewportPosition write SetViewportPosition;
    procedure Sort(Compare: TFmxObjectSortCompare); override;
    procedure Center;
    procedure ScrollTo(const Dx, Dy: Single); deprecated 'use ScrollBy(const Dx, Dy: Single)';
    procedure ScrollBy(const Dx, Dy: Single);
    procedure InViewRect(const Rect: TRectF);
    function ClientWidth: Single;
    function ClientHeight: Single;
    function GetTabList: ITabList; override;
    property ContentBounds: TRectF read GetContentBounds;
    procedure InvalidateContentSize;
    procedure RealignContent;

    property AutoHide: Boolean read FAutoHide write SetAutoHide default True;
    property DisableMouseWheel: Boolean read FDisableMouseWheel write FDisableMouseWheel default False;
    property ShowScrollBars: Boolean read FShowScrollBars write SetShowScrollBars default True;
    property ShowSizeGrip: Boolean read FShowSizeGrip write SetShowSizeGrip default False;
    property OnViewportPositionChange: TPositionChangeEvent read FOnViewportPositionChange write FOnViewportPositionChange;
    property OnHScrollChange: TNotifyEvent read FOnHScrollChange write FOnHScrollChange;
    property OnVScrollChange: TNotifyEvent read FOnVScrollChange write FOnVScrollChange;
    property OnCalcContentBounds: TOnCalcContentBoundsEvent read FOnCalcContentBounds write FOnCalcContentBounds;
  published
    property Align;
    property Anchors;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DragMode;
    property EnableDragHighlight;
    property Enabled;
    property Locked;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest;
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
    property Visible;
    property Width;
    { Events }
    property OnApplyStyleLookup;
    property OnPainting;
    property OnPaint;
    property OnResize;
    { Drag and Drop events }
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    { Mouse events }
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

{ TScrollBox }

  TScrollBox = class(TCustomScrollBox)
  protected
    procedure Paint; override;
  public
    property Content;
  published
    property Align;
    property Anchors;
    property AutoHide;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DisableMouseWheel;
    property DragMode;
    property Enabled;
    property EnableDragHighlight;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest;
    property Locked;
    property Margins;
    property Opacity;
    property Padding;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property ShowScrollBars;
    property ShowSizeGrip;
    property Size;
    property StyleLookup;
    property TabOrder;
    property TabStop;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    { Events }
    property OnApplyStyleLookup;
    property OnPainting;
    property OnPaint;
    property OnResize;
    { Drag and Drop events }
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    { Mouse events }
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    { ScrollBox events }
    property OnViewportPositionChange;
    property OnHScrollChange;
    property OnVScrollChange;
    property OnCalcContentBounds;
  end;

{ TVertScrollBox }

  TVertScrollBox = class(TCustomScrollBox)
  protected
    function GetDefaultStyleLookupName: string; override;
    function DoCalcContentBounds: TRectF; override;
    procedure Paint; override;
    procedure DoUpdateAniCalculations(const AAniCalculations: TScrollCalculations); override;
  public
    property Content;
  published
    property Align;
    property Anchors;
    property AutoHide;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DisableMouseWheel;
    property DragMode;
    property Enabled;
    property EnableDragHighlight;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest;
    property Locked;
    property Margins;
    property Opacity;
    property Padding;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property ShowScrollBars;
    property ShowSizeGrip;
    property Size;
    property StyleLookup;
    property TabOrder;
    property TabStop;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    { Events }
    property OnApplyStyleLookup;
    property OnPainting;
    property OnPaint;
    property OnResize;
    { Drag and Drop events }
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    { Mouse events }
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    { ScrollBox events }
    property OnViewportPositionChange;
    property OnVScrollChange;
    property OnCalcContentBounds;
  end;

{ THorzScrollBox }

  THorzScrollBox = class(TCustomScrollBox)
  protected
    function GetDefaultStyleLookupName: string; override;
    function DoCalcContentBounds: TRectF; override;
    procedure Paint; override;
    procedure DoUpdateAniCalculations(const AAniCalculations: TScrollCalculations); override;
  public
    property Content;
  published
    property Align;
    property Anchors;
    property AutoHide;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DisableMouseWheel;
    property DragMode;
    property Enabled;
    property EnableDragHighlight;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest;
    property Locked;
    property Margins;
    property Opacity;
    property Padding;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property ShowScrollBars;
    property ShowSizeGrip;
    property Size;
    property StyleLookup;
    property TabOrder;
    property TabStop;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    { Events }
    property OnApplyStyleLookup;
    property OnPainting;
    property OnPaint;
    property OnResize;
    { Drag and Drop events }
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    { Mouse events }
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    { ScrollBox events }
    property OnViewportPositionChange;
    property OnHScrollChange;
    property OnCalcContentBounds;
  end;

{ TFramedScrollBox }

  TFramedScrollBox = class(TCustomScrollBox)
  protected
    function IsOpaque: Boolean; override;
  public
    property Content;
  published
    property Align;
    property Anchors;
    property AutoHide;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DisableMouseWheel;
    property DragMode;
    property Enabled;
    property EnableDragHighlight;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest;
    property Locked;
    property Margins;
    property Opacity;
    property Padding;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property ShowScrollBars;
    property ShowSizeGrip;
    property Size;
    property StyleLookup;
    property TabOrder;
    property TabStop;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    { Events }
    property OnApplyStyleLookup;
    property OnPainting;
    property OnPaint;
    property OnResize;
    { Drag and Drop events }
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    { Mouse events }
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    { ScrollBox events }
    property OnViewportPositionChange;
    property OnHScrollChange;
    property OnVScrollChange;
    property OnCalcContentBounds;
  end;

{ TFramedVertScrollBox }

  TFramedVertScrollBox = class(TVertScrollBox)
  protected
    function IsOpaque: Boolean; override;
    function GetDefaultStyleLookupName: string; override;
  end;

{ TGridLayout }

  TGridLayout = class(TControl)
  private
    FItemWidth: Single;
    FItemHeight: Single;
    FOrientation: TOrientation;
    procedure SetItemHeight(const Value: Single);
    procedure SetItemWidth(const Value: Single);
    procedure SetOrientation(const Value: TOrientation);
  protected
    procedure DoRealign; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property Anchors;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DragMode;
    property EnableDragHighlight;
    property Enabled;
    property Locked;
    property Height;
    property HitTest;
    property ItemHeight: Single read FItemHeight write SetItemHeight;
    property ItemWidth: Single read FItemWidth write SetItemWidth;
    property Padding;
    property Opacity;
    property Orientation: TOrientation read FOrientation write SetOrientation;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    property TabOrder;
    property TabStop;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnCanFocus;
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

{ TGridPanelLayout }

  TGridPanelLayout = class(TControl)
  public type
    TSizeStyle = (Absolute, Percent, Auto);

    TSizeStyleHelper = record helper for TSizeStyle
    const
      ssAbsolute = TSizeStyle.Absolute deprecated 'Use TSizeStyle.Absolute';
      ssPercent = TSizeStyle.Percent deprecated 'Use TSizeStyle.Percent';
      ssAuto = TSizeStyle.Auto deprecated 'Use TSizeStyle.Auto';
    end;

    EGridLayoutException = class(Exception);

    TCellItem = class(TCollectionItem)
    private
      FSizeStyle: TSizeStyle;
      FValue: Double;
      FSize: Single;
      FAutoAdded: Boolean;
    protected
      procedure AssignTo(Dest: TPersistent); override;
      procedure SetSizeStyle(Value: TSizeStyle);
      procedure SetValue(Value: Double);
      property Size: Single read FSize write FSize;
      property AutoAdded: Boolean read FAutoAdded write FAutoAdded;
    public
      constructor Create(Collection: TCollection); override;
    published
      property SizeStyle: TSizeStyle read FSizeStyle write SetSizeStyle default TSizeStyle.Percent;
      property Value: Double read FValue write SetValue;
    end;

    TRowItem = class(TCellItem);

    TColumnItem = class(TCellItem);

    TCellCollection = class(TOwnedCollection)
    protected
      function GetAttrCount: Integer; override;
      function GetAttr(Index: Integer): string; override;
      function GetItemAttr(Index, ItemIndex: Integer): string; override;
      function GetItem(Index: Integer): TCellItem;
      procedure SetItem(Index: Integer; Value: TCellItem);
      procedure Update(Item: TCollectionItem); override;
    public
      function Owner: TGridPanelLayout;
      property Items[Index: Integer]: TCellItem read GetItem write SetItem; default;
    end;

    TCellSpan = 1..MaxInt;

    TRowCollection = class(TCellCollection)
    protected
      function GetItemAttr(Index, ItemIndex: Integer): string; override;
      procedure Notify(Item: TCollectionItem; Action: System.Classes.TCollectionNotification); override;
    public
      constructor Create(AOwner: TPersistent);
      function Add: TRowItem;
    end;

    TColumnCollection = class(TCellCollection)
    protected
      function GetItemAttr(Index, ItemIndex: Integer): string; override;
      procedure Notify(Item: TCollectionItem; Action: System.Classes.TCollectionNotification); override;
    public
      constructor Create(AOwner: TPersistent);
      function Add: TColumnItem;
    end;

    TControlItem = class(TCollectionItem)
    private
      [Weak] FControl: TControl;
      FColumn, FRow: Integer;
      FColumnSpan, FRowSpan: TCellSpan;
      FPushed: Integer;
      function GetGridPanelLayout: TGridPanelLayout;
      function GetPushed: Boolean;
      procedure SetColumn(Value: Integer);
      procedure SetColumnSpan(Value: TCellSpan);
      procedure SetControl(Value: TControl);
      procedure SetRow(Value: Integer);
      procedure SetRowSpan(Value: TCellSpan);
    protected
      procedure AssignTo(Dest: TPersistent); override;
      procedure InternalSetLocation(AColumn, ARow: Integer; APushed: Boolean; MoveExisting: Boolean);
      property GridPanelLayout: TGridPanelLayout read GetGridPanelLayout;
      property Pushed: Boolean read GetPushed;
    public
      constructor Create(Collection: TCollection); override;
      destructor Destroy; override;
      procedure SetLocation(AColumn, ARow: Integer; APushed: Boolean = False);
    published
      property Column: Integer read FColumn write SetColumn;
      property ColumnSpan: TCellSpan read FColumnSpan write SetColumnSpan default 1;
      property Control: TControl read FControl write SetControl;
      property Row: Integer read FRow write SetRow;
      property RowSpan: TCellSpan read FRowSpan write SetRowSpan default 1;
    end;

    TControlCollection = class(TOwnedCollection)
    protected
      function GetControl(AColumn, ARow: Integer): TControl;
      function GetControlItem(AColumn, ARow: Integer): TControlItem;
      function GetItem(Index: Integer): TControlItem;
      procedure SetControl(AColumn, ARow: Integer; Value: TControl);
      procedure SetItem(Index: Integer; Value: TControlItem);
      procedure Update(Item: TCollectionItem); override;
    public
      constructor Create(AOwner: TPersistent);
      function Add: TControlItem;
      procedure AddControl(AControl: TControl; AColumn: Integer = -1; ARow: Integer = -1);
      procedure RemoveControl(AControl: TControl);
      function IndexOf(AControl: TControl): Integer;
      function Owner: TGridPanelLayout;
      property Controls[AColumn, ARow: Integer]: TControl read GetControl write SetControl;
      property ControlItems[AColumn, ARow: Integer] : TControlItem read GetControlItem;
      property Items[Index: Integer]: TControlItem read GetItem write SetItem; default;
    end;

    TExpandStyle = (AddRows, AddColumns, FixedSize);

    TExpandStyleHelper = record helper for TExpandStyle
    const
      emAddRows = TExpandStyle.AddRows deprecated 'Use TExpandStyle.AddRows';
      emAddColumns = TExpandStyle.AddColumns deprecated 'Use TExpandStyle.AddColumns';
      emFixedSize = TExpandStyle.FixedSize deprecated 'Use TExpandStyle.FixedSize';
    end;

  private
    FRecalcCellSizes: Boolean;
    FExpandStyle: TExpandStyle;

    FRowCollection: TRowCollection;
    FColumnCollection: TColumnCollection;
    FControlCollection: TControlCollection;

    procedure SetColumnCollection(const Value: TColumnCollection);
    procedure SetControlCollection(const Value: TControlCollection);
    procedure SetRowCollection(const Value: TRowCollection);

    function GetCellCount: Integer;
    function GetCellSizes(AColumn, ARow: Integer): TPointF;
    function GetCellRect(AColumn, ARow: Integer): TRectF;
    function GetColumnSpanIndex(AColumn, ARow: Integer): Integer;
    function GetRowSpanIndex(AColumn, ARow: Integer): Integer;
    procedure RecalcCellDimensions(const Rect: TRectF);

  protected
    procedure DoRealign; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    function AutoAddColumn: TColumnItem;
    function AutoAddRow: TRowItem;
    procedure RemoveEmptyAutoAddColumns;
    procedure RemoveEmptyAutoAddRows;
    function CellToCellIndex(AColumn, ARow: Integer): Integer;
    procedure CellIndexToCell(AIndex: Integer; var AColumn, ARow: Integer);
    procedure DoPaint; override;
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function IsColumnEmpty(AColumn: Integer): Boolean;
    function IsRowEmpty(ARow: Integer): Boolean;
    procedure UpdateControlsColumn(AColumn: Integer);
    procedure UpdateControlsRow(ARow: Integer);
    property ColumnSpanIndex[AColumn, ARow: Integer]: Integer read GetColumnSpanIndex;
    property CellCount: Integer read GetCellCount;
    property CellSize[AColumn, ARow: Integer]: TPointF read GetCellSizes;
    property CellRect[AColumn, ARow: Integer]: TRectF read GetCellRect;
    property RowSpanIndex[AColumn, ARow: Integer]: Integer read GetRowSpanIndex;
  published
    property Align;
    property Anchors;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DragMode;
    property EnableDragHighlight;
    property Enabled;
    property Locked;
    property Height;
    property HitTest;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    property TabOrder;
    property TabStop;
    { Columns and rows }
    property ColumnCollection: TColumnCollection read FColumnCollection write SetColumnCollection;
    property ControlCollection: TControlCollection read FControlCollection write SetControlCollection;
    property ExpandStyle: TExpandStyle read FExpandStyle write FExpandStyle default TExpandStyle.AddRows;
    property RowCollection: TRowCollection read FRowCollection write SetRowCollection;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnCanFocus;
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

  TFlowJustify = (Left, Right, Center, Justify);

  TFlowJustifyHelper = record helper for TFlowJustify
  const
    fjLeft = TFlowJustify.Left deprecated 'Use TFlowJustify.Left';
    fjRight = TFlowJustify.Right deprecated 'Use TFlowJustify.Right';
    fjCenter = TFlowJustify.Center deprecated 'Use TFlowJustify.Center';
    fjJustify = TFlowJustify.Justify deprecated 'Use TFlowJustify.Justify';
  end;
  TFlowDirection = (LeftToRight, RightToLeft);

  TFlowDirectionHelper = record helper for TFlowDirection
  const
    fdLeftToRight = TFlowDirection.LeftToRight deprecated 'Use TFlowDirection.LeftToRight';
    fdRightToLeft = TFlowDirection.RightToLeft deprecated 'Use TFlowDirection.RightToLeft';
  end;

  TFlowLayoutRules = record
    Justify : TFlowJustify;
    JustifyLast : TFlowJustify;
    Direction : TFlowDirection;
    HorizontalGap : Single;
    VerticalGap : Single;
  end;

  TFlowLayoutBreak = class(TControl)
  private
    FRules : TFlowLayoutRules;
    FChangesRules : Boolean;
  protected
    procedure SetChangesRules(AChangesRules : Boolean);
    procedure Paint; override;
    function VisibleStored: Boolean; override;
  public
    constructor Create(AOwner : TComponent); override;
  published
    property ChangesRules : Boolean read FChangesRules write SetChangesRules;

    property Justify : TFlowJustify read FRules.Justify write FRules.Justify;
    property JustifyLastLine : TFlowJustify read FRules.JustifyLast write FRules.JustifyLast;
    property FlowDirection : TFlowDirection read FRules.Direction write FRules.Direction;
    property HorizontalGap : Single read FRules.HorizontalGap write FRules.HorizontalGap;
    property VerticalGap : Single read FRules.VerticalGap write FRules.VerticalGap;

    property Visible;
  end;

  TFlowLayout = class(TControl)
  private
    FRules : TFlowLayoutRules;
  protected
    procedure DoRealign; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    procedure Paint; override;

    procedure SetJustify(AJustify : TFlowJustify);
    procedure SetJustifyLast(AJustify : TFlowJustify);
    procedure SetFlowDirection(ADirection : TFlowDirection);
    procedure SetHGap(AHGap : Single);
    procedure SetVGap(AVGap : Single);

  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property Anchors;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DragMode;
    property EnableDragHighlight;
    property Enabled;
    property Locked;
    property Height;
    property HitTest;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    property TabOrder;
    property TabStop;
    property Justify : TFlowJustify read FRules.Justify write SetJustify;
    property JustifyLastLine : TFlowJustify read FRules.JustifyLast write SetJustifyLast;
    property FlowDirection : TFlowDirection read FRules.Direction write SetFlowDirection;
    property HorizontalGap : Single read FRules.HorizontalGap write SetHGap;
    property VerticalGap : Single read FRules.VerticalGap write SetVGap;
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

implementation

uses
  System.Generics.Collections, System.Math, System.RTLConsts, System.TypInfo, FMX.Styles, FMX.Consts, FMX.Effects,
  FMX.Ani, FMX.Graphics;

type
  TOpenFxmObject = class (TFMXObject)
end;

{ TLayout }

constructor TLayout.Create(AOwner: TComponent);
begin
  inherited;
  CanParentFocus := True;
  HitTest := False;
end;

procedure TLayout.Paint;
begin
  inherited;
  if (csDesigning in ComponentState) and not Locked then
    DrawDesignBorder;
end;

{ TScrollContent }

constructor TScrollContent.Create(AOwner: TComponent);
begin
  inherited;
  if AOwner is TCustomScrollBox then
    FScrollBox := TCustomScrollBox(AOwner);
  ClipChildren := True;
  FIsContentChanged := True;
  SetAcceptsControls(False);
end;

function TScrollContent.GetClipRect: TRectF;
begin
  if FScrollBox <> nil then
    if FScrollBox.ContentLayout <> nil then
    begin
      Result := FScrollBox.ContentLayout.AbsoluteRect;
      Result.TopLeft := AbsoluteToLocal(Result.TopLeft);
      Result.BottomRight := AbsoluteToLocal(Result.BottomRight);
    end
    else
    begin
      Result := TRectF.Create(0, 0, FScrollBox.Width, FScrollBox.Height);
      Result.Offset(FScrollBox.ViewportPosition);
    end
  else
    Result := inherited GetClipRect;
end;

function TScrollContent.ObjectAtPoint(P: TPointF): IControl;
begin
  Result := inherited ObjectAtPoint(P);
  if Result <> nil then
  begin
    if FScene <> nil then
      P := FScene.ScreenToLocal(P);
    P := AbsoluteToLocal(P);
    if not ClipRect.Contains(P) then
      Result := nil;
  end;
end;

function TScrollContent.PointInObjectLocal(X, Y: Single): Boolean;
var
  ClipRect: TRectF;
begin
  ClipRect := GetClipRect;
  Result := (X >= (ClipRect.TopLeft.X - TouchTargetExpansion.Left)) and
    (X <= (ClipRect.TopLeft.X + ClipRect.Width + TouchTargetExpansion.Right)) and
    (Y >= (ClipRect.TopLeft.Y + TouchTargetExpansion.Top)) and
    (Y <= (ClipRect.TopLeft.Y + ClipRect.Height + TouchTargetExpansion.Bottom));
end;

procedure TScrollContent.DoAddObject(const AObject: TFmxObject);
begin
  inherited;
  if FScrollBox <> nil then
    FScrollBox.ContentAddObject(AObject);
end;

procedure TScrollContent.DoInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  inherited;
  if FScrollBox <> nil then
    FScrollBox.ContentInsertObject(Index, AObject);
end;

procedure TScrollContent.DoRealign;
begin
  if (ScrollBox <> nil) and ScrollBox.FContentCalculated then
    inherited;
  FLastWidth := Width;
  FLastHeight := Height;
end;

procedure TScrollContent.DoRemoveObject(const AObject: TFmxObject);
begin
  if FScrollBox <> nil then
    FScrollBox.ContentBeforeRemoveObject(AObject);
  inherited;
  if FScrollBox <> nil then
    FScrollBox.ContentRemoveObject(AObject);
end;

function TScrollContent.DoGetUpdateRect: TRectF;
begin
  if ParentControl is TCustomScrollBox then
  begin
    if TCustomScrollBox(ParentControl).ContentLayout <> nil then
      Result := TCustomScrollBox(ParentControl).ContentLayout.UpdateRect
    else
      Result := TCustomScrollBox(ParentControl).UpdateRect;
  end
  else
    Result := inherited DoGetUpdateRect;
end;

function TScrollContent.GetChildrenRect: TRectF;
begin
  Result := GetUpdateRect;
end;

procedure TScrollContent.ContentChanged;
begin
  inherited;
  if (FScrollBox <> nil) and not FScrollBox.Released and ([csLoading, csDestroying] * FScrollBox.ComponentState = [])
    and not ScrollBox.InInternalAlign then
  begin
    FIsContentChanged := True;
    FScrollBox.InvalidateContentSize;
    if not IsUpdating then
      FScrollBox.Realign;
  end;
end;

{ TScrollCalculations }

constructor TScrollCalculations.Create(AOwner: TPersistent);
begin
  if not (AOwner is TCustomScrollBox) then
    raise EArgumentException.Create(sArgumentInvalid);
  inherited Create(AOwner);
  FScrollBox := TCustomScrollBox(AOwner);
end;

procedure TScrollCalculations.DoChanged;
begin
  if (FScrollBox <> nil) and not (csDestroying in FScrollBox.ComponentState) then
    FScrollBox.InternalAlign;
  inherited;
end;

procedure TScrollCalculations.DoStart;
begin
  inherited;
  if (FScrollBox <> nil) and not (csDestroying in FScrollBox.ComponentState) then
    FScrollBox.StartScrolling;
end;

procedure TScrollCalculations.DoStop;
begin
  inherited;
  if (FScrollBox <> nil) and not (csDestroying in FScrollBox.ComponentState) then
    FScrollBox.StopScrolling;
end;

{ TCustomScrollBox }

type
  TOpenScrollBar = class(TScrollBar);
  TOpenControl = class (TControl);

constructor TCustomScrollBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DisableDisappear := True;
  FOriginalContentLayoutSize := TSizeF.Create(-1, -1);
  SetAcceptsControls(True);
  SetLength(FHScrollInfo, 2);
  SetLength(FVScrollInfo, 2);
  SupportsPlatformService(IFMXSystemInformationService, FSystemInfoSrv);
  AutoCapture := True;
  FAutoHide := True;
  FShowScrollBars := True;
  FContent := CreateScrollContent;
  FContent.Parent := Self;
  FContent.Stored := False;
  FContent.Locked := True;
  FContent.HitTest := False;
  UpdateAniCalculations;
  Touch.DefaultInteractiveGestures := Touch.DefaultInteractiveGestures + [TInteractiveGesture.Pan];
  Touch.InteractiveGestures := Touch.InteractiveGestures + [TInteractiveGesture.Pan];
end;

destructor TCustomScrollBox.Destroy;
begin
  FContent := nil;
  FreeAndNil(FAniCalculations);
  inherited;
end;

function TCustomScrollBox.CreateAniCalculations: TScrollCalculations;
begin
  Result := TScrollCalculations.Create(self);
end;

procedure TCustomScrollBox.DoUpdateAniCalculations(const AAniCalculations: TScrollCalculations);
begin
  AAniCalculations.Animation := TScrollingBehaviour.Animation in GetScrollingBehaviours;
  if TScrollingBehaviour.TouchTracking in GetScrollingBehaviours then
    AAniCalculations.TouchTracking := [ttVertical, ttHorizontal]
  else
    AAniCalculations.TouchTracking := [];
  AAniCalculations.BoundsAnimation := TScrollingBehaviour.BoundsAnimation in GetScrollingBehaviours;
  AAniCalculations.AutoShowing := TScrollingBehaviour.AutoShowing in GetScrollingBehaviours;
end;

procedure TCustomScrollBox.UpdateAniCalculations;
begin
  if not (csDestroying in ComponentState) then
  begin
    if FAniCalculations = nil then
      FAniCalculations := CreateAniCalculations;
    FAniCalculations.BeginUpdate;
    try
      DoUpdateAniCalculations(FAniCalculations);
    finally
      FAniCalculations.EndUpdate;
    end;
  end;
end;

function TCustomScrollBox.GetSceneScale: Single;
begin
  Result := 0;
  if Scene <> nil then
    Result := Scene.GetSceneScale;
  if Result <= 0 then
    Result := 1;
end;

procedure TCustomScrollBox.UpdateSizeGrip;
var
  R, GripRect: TRectF;
  GripLeft, GripTop, SizeGripVisible, Both: Boolean;
begin
  SizeGripVisible := ShowSizeGrip and (FSizeGrip <> nil) and (FSizeGripParent <> nil) and (FSizeGripContent <> nil);
  Both := ((VScrollBar <> nil) and VScrollBar.Visible) and ((HScrollBar <> nil) and HScrollBar.Visible);
  if Both or (SizeGripVisible and (((VScrollBar <> nil) and VScrollBar.Visible) or
    ((HScrollBar <> nil) and HScrollBar.Visible))) then
  begin
    {$REGION 'size'}
    GripRect := TRectF.Empty;
    if HScrollBar <> nil then
      GripRect.Height := HScrollBar.Height
    else
      GripRect.Height := VScrollBar.Width;
    if VScrollBar <> nil then
      GripRect.Width := VScrollBar.Width
    else
      GripRect.Width := HScrollBar.Height;
    {$ENDREGION}
    {$REGION 'vert align'}
    GripTop := (HScrollBar <> nil) and (not (HScrollAlign in [TAlignLayout.Bottom, TAlignLayout.MostBottom]));
    if FSizeGrip <> nil then
    begin
      if GripTop then
        FSizeGrip.Align := TAlignLayout.Top
      else
        FSizeGrip.Align := TAlignLayout.Bottom;
      FSizeGrip.BoundsRect := GripRect;
    end;
    {$ENDREGION}
    {$REGION 'horz align'}
    GripLeft := (VScrollBar <> nil) and (not (VScrollAlign in [TAlignLayout.Right, TAlignLayout.MostRight]));
    if FSizeGripContent <> nil then
      FSizeGripContent.Align := TAlignLayout.Contents;
    if FSizeGripParent <> nil then
    begin
      if GripLeft then
        FSizeGripParent.Align := TAlignLayout.Left
      else
        FSizeGripParent.Align := TAlignLayout.Right;
      FSizeGripParent.Width := GripRect.Width;
    end;
    {$ENDREGION}
    if (HScrollBar <> nil) and HScrollBar.Visible then
    begin
      R := HScrollMargins;
      if GripLeft then
        R.Left := R.Left + GripRect.Width
      else
        R.Right := R.Right + GripRect.Width;
      HScrollBar.Margins.Rect := R;
      if VScrollBar <> nil then
        VScrollBar.Margins.Rect := VScrollMargins;
    end
    else if (VScrollBar <> nil) and VScrollBar.Visible then
    begin
      R := VScrollMargins;
      if GripTop then
        R.Top := R.Top + GripRect.Height
      else
        R.Bottom := R.Bottom + GripRect.Height;
      VScrollBar.Margins.Rect := R;
    end;
    if FSizeGripParent <> nil then
      FSizeGripParent.Visible := True;
    if FSizeGripContent <> nil then
      FSizeGripContent.Visible := True;
    if FSizeGrip <> nil then
    begin
      FSizeGrip.Opacity := AniCalculations.Opacity;
      FSizeGrip.Visible := SizeGripVisible;
      FSizeGrip.Enabled := (Align in [TAlignLayout.Client, TAlignLayout.Contents]) and (not GripTop) and (not GripLeft);
    end;
  end
  else
  begin
    if FSizeGrip <> nil then
      FSizeGrip.Visible := False;
    if FSizeGripContent <> nil then
      FSizeGrip.Visible := False;
    if (VScrollBar <> nil) and (VScrollBar.Margins <> nil) then
      VScrollBar.Margins.Rect := VScrollMargins;
    if (HScrollBar <> nil) and (HScrollBar.Margins <> nil) then
      HScrollBar.Margins.Rect := HScrollMargins;
  end;
end;

procedure TCustomScrollBox.UpdateVScrollBar(const Value: Single; const ViewportSize: Single);
begin
  if VScrollBar <> nil then
  begin
    VScrollBar.ValueRange.BeginUpdate;
    try
      VScrollBar.ValueRange.Min := Min(Value, FContentBounds.Top);
      VScrollBar.ValueRange.Max := Max(Value + ViewportSize, FContentBounds.Bottom);
      VScrollBar.ValueRange.ViewportSize := ViewportSize;
      VScrollBar.Value := Value;
    finally
      VScrollBar.ValueRange.EndUpdate;
    end;
    VScrollBar.SmallChange := VScrollBar.ViewportSize / SmallChangeFraction;
  end;
end;

procedure TCustomScrollBox.UpdateHScrollBar(const Value: Single; const ViewportSize: Single);
begin
  if HScrollBar <> nil then
  begin
    HScrollBar.ValueRange.BeginUpdate;
    try
      HScrollBar.ValueRange.Min := Min(Value, FContentBounds.Left);
      HScrollBar.ValueRange.Max := Max(Value + ViewportSize, FContentBounds.Right);
      HScrollBar.ValueRange.ViewportSize := ViewportSize;
      HScrollBar.Value := Value;
    finally
      HScrollBar.ValueRange.EndUpdate;
    end;
    HScrollBar.SmallChange := HScrollBar.ViewportSize / SmallChangeFraction;
  end;
end;

procedure TCustomScrollBox.InternalAlign;
const
  MaxAlignIterations = 5;

  procedure UpdateScrollbarVisibility(const ScrollBar: TScrollBar; const OverBounds, Reset: Boolean);
  begin
    ScrollBar.Opacity := AniCalculations.Opacity;
    ScrollBar.Enabled := OverBounds or AniCalculations.AutoShowing;
    ScrollBar.Visible := FShowScrollBars and (((not Reset or AniCalculations.AutoShowing) and OverBounds) or
      not FAutoHide) and (AniCalculations.Opacity > TEpsilon.Position);
  end;

  procedure UpdateScrollbarsVisibility(const AContentRect: TRectF; const Reset: Boolean);
  begin
    if FVScrollInfo[Integer(not AniCalculations.AutoShowing)].Scroll <> nil then
      FVScrollInfo[Integer(not AniCalculations.AutoShowing)].Scroll.Visible := False;
    if FHScrollInfo[Integer(not AniCalculations.AutoShowing)].Scroll <> nil then
      FHScrollInfo[Integer(not AniCalculations.AutoShowing)].Scroll.Visible := False;
    if VScrollBar <> nil then
      UpdateScrollbarVisibility(VScrollBar, FContentBounds.Height > AContentRect.Height, Reset);
    if HScrollBar <> nil then
      UpdateScrollbarVisibility(HScrollBar, FContentBounds.Width > AContentRect.Width, Reset);
  end;

  procedure UpdateContentLayoutMargins;
  begin
    ContentLayout.Margins.Rect := FContentMargins;
    if (ContentLayout.Align = TAlignLayout.Contents) and (FBackground <> nil) then
      ContentLayout.Margins.Rect.Inflate(-FBackground.Padding.Left, -FBackground.Padding.Top,
        FBackground.Padding.Right, FBackground.Padding.Bottom);
  end;

  function CalcContentLayoutRect(const Reset: Boolean): TRectF;
  begin
    Result := TRectF.Create(ContentLayout.Position.Point, ContentLayout.Width, ContentLayout.Height);
    UpdateScrollbarsVisibility(Result, Reset);
    Result.TopLeft := Result.TopLeft - ViewportPosition;
    if FDisableAlign and (FBackground <> nil) then
      TOpenControl(FBackground).Realign;
    Result.Width := ContentLayout.Width;
    Result.Height := ContentLayout.Height;
  end;

  procedure UpdateAnimationTargets(const ContentLayoutRect: TRectF);
  var
    I, J: Integer;
    LTargets: array of TAniCalculations.TTarget;
    NewTargets: array of TAniCalculations.TTarget;
  begin
    SetLength(LTargets, AniCalculations.TargetCount);
    AniCalculations.GetTargets(LTargets);
    SetLength(NewTargets, 2);
    NewTargets[0].TargetType := TAniCalculations.TTargetType.Min;
    NewTargets[0].Point := FContentBounds.TopLeft;
    NewTargets[1].TargetType := TAniCalculations.TTargetType.Max;
    NewTargets[1].Point := TPointD.Create(Max(FContentBounds.Left, FContentBounds.Right - ContentLayoutRect.Width),
      Max(FContentBounds.Top, FContentBounds.Bottom - ContentLayoutRect.Height));
    for I := 0 to Length(LTargets) - 1 do
      if not (LTargets[I].TargetType in [TAniCalculations.TTargetType.Min, TAniCalculations.TTargetType.Max]) then
      begin
        J := Length(NewTargets);
        SetLength(NewTargets, J + 1);
        NewTargets[J].TargetType := LTargets[I].TargetType;
        NewTargets[J].Point := LTargets[I].Point;
      end;
    AniCalculations.SetTargets(NewTargets);
  end;

  procedure AssignContentBounds(NewContentBounds: TRectF);
  begin
    if Assigned(OnCalcContentBounds) then
      OnCalcContentBounds(Self, NewContentBounds);
    FContentBounds := NewContentBounds;
  end;

  function TakeControl(I: Integer; var AControl: TControl): Boolean;
  begin
    AControl := FContent.Controls[I];
    Result := (AControl.Align = TAlignLayout.None) and
      ([TAnchorKind.akRight, TAnchorKind.akBottom] * AControl.Anchors <> []);
  end;

  procedure SaveControlRects(const ControlList: TDictionary<TControl, TRectF>);
  var
    I: Integer;
    Ctrl: TControl;
  begin
    if (FOriginalContentLayoutSize.cx >= 0) and (FOriginalContentLayoutSize.cy >= 0) then
      for I := 0 to FContent.ControlsCount - 1 do
        if TakeControl(I, Ctrl) then
          ControlList.Add(Ctrl, Ctrl.BoundsRect);
    if ControlList.Count = 0 then
      FContentCalculated := True;
  end;

  procedure RestoreControlRects(const ControlList: TDictionary<TControl, TRectF>);
  var
    I: Integer;
    R: TRectF;
    Ctrl: TControl;
    LParentSize: TSizeF;
    Dx, Dy: Single;
  begin
    if (ControlList <> nil) and (ControlList.Count > 0) then
    begin
      LParentSize := ContentLayout.BoundsRect.Size;
      Dx := LParentSize.cx - FOriginalContentLayoutSize.cx;
      Dy := LParentSize.cy - FOriginalContentLayoutSize.cy;
      for I := 0 to FContent.ControlsCount - 1 do
        if TakeControl(I, Ctrl) and ControlList.TryGetValue(Ctrl, R) then
        begin
          if TAnchorKind.akRight in Ctrl.Anchors then
            if TAnchorKind.akLeft in Ctrl.Anchors then
              R.Right := R.Right + Dx
            else
              R.Offset(Dx, 0);

          if TAnchorKind.akBottom in Ctrl.Anchors then
            if TAnchorKind.akTop in Ctrl.Anchors then
              R.Bottom := R.Bottom + Dy
            else
              R.Offset(0, Dy);

          Ctrl.BoundsRect := R;
          if FContentCalculated then
            TOpenControl(Ctrl).UpdateAnchorRules(True);
        end;
      if not FContentCalculated then
      begin
        FContentCalculated := True;
        FContent.Realign;
      end;
    end;
  end;

  function FindEqual(const Sizes: array of TSizeF; const Index: Integer): Boolean;
  var
    I: Integer;
  begin
    for I := Index - 1 downto 0 do
      if TPointF(Sizes[Index]).EqualsTo(TPointF(Sizes[I]), TEpsilon.Position) then
        Exit(True);
    Result := False;
  end;

  function InternalContentRealigned(const ContentLayoutRect: TRectF; var ContentSizeChanged: Boolean): Boolean;
  begin
    Result := (FContent <> nil) and (FContent.IsContentChanged or
      not TPointF(FContent.BoundsRect.Size).EqualsTo(TPointF(ContentLayoutRect.Size), TEpsilon.Position));
    if Result then
    begin
      ContentSizeChanged := True;
      DoRealignContent(ContentLayoutRect);
      FContent.IsContentChanged := False;
    end
  end;

  function Adjust(var ContentLayoutRect: TRectF; var SizeAdjusted, ContentPosChanged,
    ContentSizeChanged: Boolean): Boolean;
  type
    TCalculationPhase = (OldAnchoredControls, NewAnchoredControls, Finish);
  var
    Sizes: array of TSizeF;
    AnchoredControlList: TDictionary<TControl, TRectF>;
    AlignCount: Integer;
    LEpsilon: Single;
    Step: TCalculationPhase;
    InvalidCachedContentSize: Boolean;
  begin
    Result := False;
    Step := Low(Step);
    SizeAdjusted := False;
    ContentLayoutRect := TRectF.Empty;
    ContentPosChanged := False;
    ContentSizeChanged := False;
    AnchoredControlList := nil;
    LEpsilon := 1 / Max(2, GetSceneScale * Max(GetAbsoluteScale.X, GetAbsoluteScale.Y));
    SetLength(Sizes, MaxAlignIterations + 1);
    try
      if not FContentCalculated then
      begin
        AnchoredControlList := TDictionary<TControl, TRectF>.Create;
        SaveControlRects(AnchoredControlList);
      end;
      while Step < TCalculationPhase.Finish do
      begin
        if (AnchoredControlList = nil) or (AnchoredControlList.Count = 0) then
          Step := Succ(Step);
        Sizes[0] := FCachedContentSize;
        InvalidCachedContentSize := FCachedContentSize.IsZero;
        for AlignCount := 0 to MaxAlignIterations - 1 do
        begin
          UpdateContentLayoutMargins;
          ContentLayoutRect := CalcContentLayoutRect(InvalidCachedContentSize and (AlignCount = 0));
          if AlignCount = 0 then
            InternalContentRealigned(ContentLayoutRect, ContentSizeChanged);
          Sizes[AlignCount + 1] := ContentLayoutRect.Size;
          if not FindEqual(Sizes, AlignCount + 1) then
            AssignContentBounds(DoCalcContentBounds)
          else
            Break;
        end;
        SizeAdjusted := not TPointF(FCachedContentSize).EqualsTo(TPointF(ContentLayoutRect.Size), TEpsilon.Position);
        if SizeAdjusted then
        begin
          FCachedContentSize := ContentLayoutRect.Size;
          UpdateAnimationTargets(ContentLayoutRect);
        end;
        if InternalContentRealigned(ContentLayoutRect, ContentSizeChanged) then
          Result := True
        else if SizeAdjusted or not FContent.Position.Point.EqualsTo(ContentLayoutRect.TopLeft, LEpsilon) then
        begin
          FContent.Position.Point := ContentLayoutRect.TopLeft;
          ContentPosChanged := True;
          Result := True;
        end
        else
          Break;
        RestoreControlRects(AnchoredControlList);
        Step := Succ(Step);
      end;
    finally
      FContentCalculated := True;
      AnchoredControlList.Free;
    end;
  end;

var
  LViewportPosition: TPointF;
  ContentLayoutRect: TRectF;
  SizeAdjusted, ContentPosChanged, ContentSizeChanged: Boolean;
  LScale: Single;
begin
  if (not FInInternalAlign) and (ContentLayout <> nil) and (Content <> nil) and (AniCalculations <> nil) then
  begin
    LScale := GetSceneScale;
    FInInternalAlign := True;
    try
      if (AniCalculations <> nil) and not Released then
      begin
        if (FCachedAutoShowing <> AniCalculations.AutoShowing) and not AniCalculations.AutoShowing then
          InvalidateContentSize;
        FCachedAutoShowing := AniCalculations.AutoShowing;
      end;
      if (not AniCalculations.Down) and AniCalculations.LowVelocity then
        AniCalculations.Shown := False;
      if not Adjust(ContentLayoutRect, SizeAdjusted, ContentPosChanged, ContentSizeChanged) then
        Exit;
      LViewportPosition := ViewportPosition;
      UpdateVScrollBar(LViewportPosition.Y, ContentLayoutRect.Height);
      UpdateHScrollBar(LViewportPosition.X, ContentLayoutRect.Width);
      UpdateSizeGrip;
      LViewportPosition := TPointF.Create((LViewportPosition * LScale).Round) / LScale;
      if ContentSizeChanged or ContentPosChanged or not FLastViewportPosition.EqualsTo(LViewportPosition,
        TEpsilon.Position) then
        try
          ViewportPositionChange(FLastViewportPosition, LViewportPosition, ContentSizeChanged or ContentPosChanged);
        finally
          FLastViewportPosition := LViewportPosition;
        end;
      if SizeAdjusted then
      begin
        if not (csDesigning in ComponentState) and not AniCalculations.Animation then
          AniCalculations.UpdatePosImmediately(True);
        Repaint;
      end;
    finally
      FInInternalAlign := False;
    end;
  end;
end;

procedure TCustomScrollBox.ApplyStyle;

  function CheckParent(Control: TControl): boolean;
  begin
    Result := (Control <> nil) and
              (Control.Parent <> FBackground) and
              (Control.Parent <> self) and
              (Control.Parent is TControl)
  end;

  procedure UpdateScroll(AStyleLookup: string;
                         var Info: array of TScrollInfo;
                         Small: Boolean;
                         Proc: TNotifyEvent);
  var
    ScrollBar: TScrollBar;
  begin
    if FindStyleResource<TScrollBar>(AStyleLookup, ScrollBar) then
    begin
      Info[Integer(Small)].Scroll := ScrollBar;
      Info[Integer(Small)].Scroll.OnChange := Proc;
      Info[Integer(Small)].Scroll.Visible := False;
      Info[Integer(Small)].Scroll.Locked := True;
      Info[Integer(Small)].Align := ScrollBar.Align;
      Info[Integer(Small)].Margins := ScrollBar.Margins.Rect;
    end
    else
    begin
      Info[Integer(Small)].Scroll := nil;
      Info[Integer(Small)].Align := TAlignLayout.None;
      Info[Integer(Small)].Margins := TRectF.Create(0, 0, 0, 0);
    end;
  end;
begin
  inherited;
  FindStyleResource<TControl>('background', FBackground);

  UpdateScroll('vscrollbar', FVScrollInfo, False, VScrollChangeProc);
  UpdateScroll('hscrollbar', FHScrollInfo, False, HScrollChangeProc);
  UpdateScroll('vsmallscrollbar', FVScrollInfo, True, VScrollChangeProc);
  UpdateScroll('hsmallscrollbar', FHScrollInfo, True, HScrollChangeProc);

  if FindStyleResource<TControl>('sizegrip', FSizeGrip) then
  begin
    FSizeGrip.Visible := False;
    FSizeGrip.Align := TAlignLayout.Bottom;

    if CheckParent(FSizeGrip) then
      FSizeGripParent := TControl(FSizeGrip.Parent);
    if CheckParent(FSizeGripParent) then
      FSizeGripContent := TControl(FSizeGripParent.Parent);

    if FSizeGripParent <> nil then
      FSizeGripParent.Align := TAlignLayout.Right;
    if FSizeGripContent <> nil then
    begin
      FSizeGripContent.Visible := False;
      FSizeGripParent.Align := TAlignLayout.Contents;
    end;
  end;

  if FindStyleResource<TControl>('content', FContentLayout) then
  begin
    FContentMargins := FContentLayout.Margins.Rect;
    FContentLayout.DisableDisappear := True;
  end;
  if ResourceControl <> nil then
    ResourceControl.DisableDisappear := True;
  RealignContent;
end;

procedure TCustomScrollBox.FreeStyle;
var
  I: Integer;
begin
  inherited;
  for I := Low(FHScrollInfo) to High(FHScrollInfo) do
  begin
    FHScrollInfo[I].Scroll := nil;
    FHScrollInfo[I].Margins := TRectF.Create(0, 0, 0, 0);
  end;
  for I := Low(FVScrollInfo) to High(FVScrollInfo) do
  begin
    FVScrollInfo[I].Scroll := nil;
    FVScrollInfo[I].Margins := TRectF.Create(0, 0, 0, 0);
  end;
  UpdateOriginalContentLayoutSize(True);
  FContentCalculated := False;
  FSizeGripParent := nil;
  FSizeGripContent := nil;
  FContentLayout := nil;
  FBackground := nil;
  FSizeGrip := nil;
end;

function TCustomScrollBox.DoCalcContentBounds: TRectF;
const
  RightSide = [TAlignLayout.Top, TAlignLayout.MostTop, TAlignLayout.Bottom, TAlignLayout.MostBottom];
  BottomSide = [TAlignLayout.Left, TAlignLayout.MostLeft, TAlignLayout.Right, TAlignLayout.MostRight];
  NeedAddBottom = [TAlignLayout.Top, TAlignLayout.MostTop];
  NeedAddRight = [TAlignLayout.Left, TAlignLayout.MostLeft];
var
  I: Integer;
  R, LocalR: TRectF;
begin
  Result := TRectF.Create(0, 0, 0, 0);
  if (FContent <> nil) and (ContentLayout <> nil) then
  begin
    R := ContentLayout.LocalRect;
    for I := 0 to FContent.ControlsCount - 1 do
      if FContent.Controls[I].Visible then
      begin
        {$IFDEF MSWINDOWS}
        if (csDesigning in ComponentState) and Supports(FContent.Controls[I], IDesignerControl) then
          Continue;
        {$ENDIF}
        LocalR := FContent.Controls[I].BoundsRect;
        if (FContent.Controls[I].Align in RightSide) or (TAnchorKind.akRight in FContent.Controls[I].Anchors) then
        begin
          LocalR.Left := R.Left;
          LocalR.Right := R.Right;
        end;
        if (FContent.Controls[I].Align in BottomSide) or (TAnchorKind.akBottom in FContent.Controls[I].Anchors) then
        begin
          LocalR.Top := R.Top;
          LocalR.Bottom := R.Bottom;
        end;
        if FContent.Controls[I].Align in NeedAddBottom then
          LocalR.Bottom := LocalR.Bottom + Padding.Bottom;
        if FContent.Controls[I].Align in NeedAddRight then
          LocalR.Right := LocalR.Right + Padding.Right;
        Result.Union(LocalR);
      end;
  end;
end;

function TCustomScrollBox.GetContentBounds: TRectF;
begin
  Result := FContentBounds;
end;

function TCustomScrollBox.HScrollIndex: Integer;
var
  B: Boolean;
begin
  B := AniCalculations.AutoShowing;
  if FHScrollInfo[Integer(B)].Scroll <> nil then
    Result := Integer(B)
  else
  begin
    B := not B;
    if FHScrollInfo[Integer(B)].Scroll <> nil then
      Result := Integer(B)
    else
      Result := -1;
  end;
end;

function TCustomScrollBox.VScrollIndex: Integer;
var
  B: Boolean;
begin
  B := AniCalculations.AutoShowing;
  if FVScrollInfo[Integer(B)].Scroll <> nil then
    Result := Integer(B)
  else
  begin
    B := not B;
    if FVScrollInfo[Integer(B)].Scroll <> nil then
      Result := Integer(B)
    else
      Result := -1;
  end;
end;

function TCustomScrollBox.GetHScrollAlign: TAlignLayout;
var
  I: Integer;
begin
  I := HScrollIndex;
  if I >= 0 then
    Result := FHScrollInfo[I].Align
  else
    Result := TAlignLayout.None;
end;

function TCustomScrollBox.GetHScrollBar: TScrollBar;
var
  I: Integer;
begin
  I := HScrollIndex;
  if I >= 0 then
    Result := FHScrollInfo[I].Scroll
  else
    Result := nil;
end;

function TCustomScrollBox.GetHScrollMargins: TRectF;
var
  I: Integer;
begin
  I := HScrollIndex;
  if I >= 0 then
    Result := FHScrollInfo[I].Margins
  else
    Result := TRectF.Create(0, 0, 0, 0);
end;

function TCustomScrollBox.GetVScrollAlign: TAlignLayout;
var
  I: Integer;
begin
  I := VScrollIndex;
  if I >= 0 then
    Result := FVScrollInfo[I].Align
  else
    Result := TAlignLayout.None;
end;

function TCustomScrollBox.GetVScrollBar: TScrollBar;
var
  I: Integer;
begin
  I := VScrollIndex;
  if I >= 0 then
    Result := FVScrollInfo[I].Scroll
  else
    Result := nil;
end;

function TCustomScrollBox.GetVScrollMargins: TRectF;
var
  I: Integer;
begin
  I := VScrollIndex;
  if I >= 0 then
    Result := FVScrollInfo[I].Margins
  else
    Result := TRectF.Create(0, 0, 0, 0);
end;

function TCustomScrollBox.GetTabList: ITabList;
begin
  if FContent <> nil then
    Result := FContent.GetTabList
  else
    Result := inherited GetTabList;
end;

procedure TCustomScrollBox.DoRealignContent(R: TRectF);
begin
  if FContent <> nil then
  begin
    FContent.SetBounds(R.Left, R.Top, R.Width, R.Height);
    FContent.FRecalcUpdateRect := True;
    FContent.Realign;
  end;
end;

procedure TCustomScrollBox.DoRealign;
var
  LDisablePaint, LDisableInternalAlign: Boolean;
begin
  LDisableInternalAlign := (csDestroying in ComponentState) or FDisableAlign or (FUpdating > 0) or
    (csLoading in ComponentState) or (ContentLayout = nil) or (Content = nil);
  LDisablePaint := FDisablePaint;
  try
    FDisablePaint := True;
    inherited;
    if not LDisableInternalAlign then
    begin
      InternalAlign;
    end;
  finally
    FDisablePaint := LDisablePaint;
  end;
end;

function TCustomScrollBox.ContentRect: TRectF;
begin
  if ContentLayout <> nil then
    Result := ContentLayout.BoundsRect
  else
    Result := LocalRect;
end;

procedure TCustomScrollBox.ViewportPositionChange(const OldViewportPosition, NewViewportPosition: TPointF;
                                            const ContentSizeChanged: boolean);
begin
  if Assigned(FOnViewportPositionChange) then
    FOnViewportPositionChange(self,
                              OldViewportPosition,
                              NewViewportPosition,
                              ContentSizeChanged);
end;

function TCustomScrollBox.VScrollBarValue: Single;
begin
  if FAniCalculations <> nil then
    Result := ViewportPosition.Y
  else
    Result := 0;
end;

function TCustomScrollBox.HScrollBarValue: Single;
begin
  if FAniCalculations <> nil then
    Result := ViewportPosition.X
  else
    Result := 0;
end;

procedure TCustomScrollBox.HScrollChangeProc(Sender: TObject);
begin
  if (not FInInternalAlign) and (AniCalculations <> nil) then
    HScrollChange;
end;

procedure TCustomScrollBox.VScrollChangeProc(Sender: TObject);
begin
  if (not FInInternalAlign) and (AniCalculations <> nil) then
    VScrollChange;
end;

procedure TCustomScrollBox.HScrollChange;
begin
  ViewportPosition := PointF(HScrollBar.Value, ViewportPosition.Y);
  if not IsOpaque then
    UpdateEffects;
  if Assigned(FOnHScrollChange) then
    FOnHScrollChange(self);
  AniCalculations.Shown := True;
end;

procedure TCustomScrollBox.VScrollChange;
begin
  ViewportPosition := TPointF.Create(ViewportPosition.X, VScrollBar.Value);
  if not IsOpaque then
    UpdateEffects;
  if Assigned(FOnVScrollChange) then
    FOnVScrollChange(self);
  AniCalculations.Shown := True;
end;

function TCustomScrollBox.CreateScrollContent: TScrollContent;
begin
  Result := TScrollContent.Create(Self);
end;

function TCustomScrollBox.GetScrollingBehaviours: TScrollingBehaviours;
var
  StyleDescriptor: TStyleDescription;
begin
  if Scene <> nil then
    StyleDescriptor := TStyleManager.GetStyleDescriptionForControl(Self)
  else
    StyleDescriptor := nil;
  if (StyleDescriptor <> nil) and StyleDescriptor.PlatformTarget.Contains('[METROPOLISUI]') then
    Result := [TScrollingBehaviour.AutoShowing]
  else
  begin
    if FSystemInfoSrv <> nil then
      Result := FSystemInfoSrv.GetScrollingBehaviour
    else
      Result := [];
  end;
end;

procedure TCustomScrollBox.MousePosToAni(var X, Y: Single);
var
  LPoint: TPointF;
begin
  LPoint := TPointF.Create(X, Y);
  if ContentLayout <> nil then
  begin
    LPoint := ContentLayout.AbsoluteToLocal(LocalToAbsolute(LPoint));
    X := LPoint.X;
    Y := LPoint.Y;
  end;
end;

procedure TCustomScrollBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Single);
begin
  FMouseEvents := True;
  inherited;
  if (Button = TMouseButton.mbLeft) then
  begin
    MousePosToAni(X, Y);
    AniMouseDown(ssTouch in Shift, X, Y);
  end;
end;

procedure TCustomScrollBox.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  FMouseEvents := True;
  inherited;
  if AniCalculations.Down then
  begin
    MousePosToAni(X, Y);
    AniMouseMove(ssTouch in Shift, X, Y);
  end;
end;

procedure TCustomScrollBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Single);
begin
  FMouseEvents := True;
  inherited;
  if (Button = TMouseButton.mbLeft) then
  begin
    MousePosToAni(X, Y);
    AniMouseUp(ssTouch in Shift, X, Y);
  end;
end;

procedure TCustomScrollBox.DoMouseLeave;
begin
  inherited;
  if FMouseEvents and AniCalculations.Down then
  begin
    AniCalculations.MouseLeave;
    if (AniCalculations.LowVelocity) or
       (not AniCalculations.Animation) then
      AniCalculations.Shown := False;
  end;
end;

procedure TCustomScrollBox.MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
var
  Offset: Single;
begin
  inherited;
  if (not (Handled or FDisableMouseWheel)) and (ContentLayout <> nil) then
  begin
  if ssHorizontal in Shift then
    begin
      if FContentBounds.Width > ContentLayout.Width then
      begin
        AniCalculations.Shown := True;
        if HScrollBar <> nil then
          Offset := HScrollBar.SmallChange
        else
          Offset := ContentLayout.Width / 5;
        Offset := Offset * -1 * (WheelDelta / 120);
        AniCalculations.MouseWheel(Offset, 0);
        Handled := True;
      end;
    end
    else if FContentBounds.Height > ContentLayout.Height then
    begin
      AniCalculations.Shown := True;
      if VScrollBar <> nil then
        Offset := VScrollBar.SmallChange
      else
        Offset := ContentLayout.Height / 5;
      Offset := Offset * -1 * (WheelDelta / 120);
      AniCalculations.MouseWheel(0, Offset);
      Handled := True;
    end
    else if FContentBounds.Width > ContentLayout.Width then
    begin
      AniCalculations.Shown := True;
      if HScrollBar <> nil then
        Offset := HScrollBar.SmallChange
      else
        Offset := ContentLayout.Width / 5;
      Offset := Offset * -1 * (WheelDelta / 120);
      AniCalculations.MouseWheel(Offset, 0);
      Handled := True;
    end;
  end;
end;

procedure TCustomScrollBox.SaveDisablePaint;
begin
  FVDisablePaint := False;
  FHDisablePaint := False;
  FGDisablePaint := False;
  if VScrollBar <> nil then
  begin
    FVDisablePaint := TOpenControl(VScrollBar).FDisablePaint;
    TOpenControl(VScrollBar).FDisablePaint := True;
  end;
  if HScrollBar <> nil then
  begin
    FHDisablePaint := TOpenControl(HScrollBar).FDisablePaint;
    TOpenControl(HScrollBar).FDisablePaint := True;
  end;
  if FSizeGrip <> nil then
  begin
    FGDisablePaint := TOpenControl(FSizeGrip).FDisablePaint;
    TOpenControl(FSizeGrip).FDisablePaint := True;
  end;
end;

procedure TCustomScrollBox.SetDisablePaint;
begin
  if VScrollBar <> nil then
    TOpenControl(VScrollBar).FDisablePaint := True;
  if HScrollBar <> nil then
    TOpenControl(HScrollBar).FDisablePaint := True;
  if FSizeGrip <> nil then
    TOpenControl(FSizeGrip).FDisablePaint := True;
end;

procedure TCustomScrollBox.InvalidateContentSize;
begin
  FCachedContentSize := TSizeF.Create(0, 0);
  FContentBounds := TRectF.Empty;
end;

procedure TCustomScrollBox.RealignContent;
begin
  InvalidateContentSize;
  Realign;
end;

procedure TCustomScrollBox.RestoreDisablePaint;
begin
  if VScrollBar <> nil then
    TOpenControl(VScrollBar).FDisablePaint := FVDisablePaint;
  if HScrollBar <> nil then
    TOpenControl(HScrollBar).FDisablePaint := FHDisablePaint;
  if FSizeGrip <> nil then
    TOpenControl(FSizeGrip).FDisablePaint := FGDisablePaint;
end;

procedure TCustomScrollBox.Painting;
begin
  inherited;
  SaveDisablePaint;
  try
    SetDisablePaint;
  except
    RestoreDisablePaint;
    raise;
  end;
end;

procedure TCustomScrollBox.AfterPaint;
begin
  try
    RestoreDisablePaint;
    if (VScrollBar <> nil) and VScrollBar.Visible and (VScrollBar.Opacity > 0) then
      TOpenControl(VScrollBar).PaintInternal;
    if (HScrollBar <> nil) and HScrollBar.Visible and (HScrollBar.Opacity > 0) then
      TOpenControl(HScrollBar).PaintInternal;
    if (FSizeGrip <> nil) and FSizeGrip.Visible and (FSizeGrip.Opacity > 0) then
      TOpenControl(FSizeGrip).PaintInternal;
  finally
    inherited;
  end;
end;

procedure TCustomScrollBox.AniMouseDown(const Touch: Boolean; const X, Y: Single);
begin
  AniCalculations.Averaging := Touch;
  AniCalculations.MouseDown(X, Y);
end;

procedure TCustomScrollBox.AniMouseMove(const Touch: Boolean; const X, Y: Single);
begin
  AniCalculations.MouseMove(X, Y);
  if AniCalculations.Moved then
    AniCalculations.Shown := True;
end;

procedure TCustomScrollBox.AniMouseUp(const Touch: Boolean; const X, Y: Single);
begin
  AniCalculations.MouseUp(X, Y);
  if (AniCalculations.LowVelocity) or
     (not AniCalculations.Animation) then
    AniCalculations.Shown := False;
end;

procedure TCustomScrollBox.DoAddObject(const AObject: TFmxObject);
begin
  if IsAddToContent(AObject) then
    FContent.AddObject(AObject)
  else
    inherited;
end;

procedure TCustomScrollBox.UpdateOriginalContentLayoutSize(const Force: Boolean);
begin
  if Force or (FOriginalContentLayoutSize.cx < 0) then
    if ContentLayout <> nil then
      FOriginalContentLayoutSize.cx := ContentLayout.LocalRect.Width
    else
      FOriginalContentLayoutSize.cx := LocalRect.Width;
  if Force or (FOriginalContentLayoutSize.cy < 0) then
    if ContentLayout <> nil then
      FOriginalContentLayoutSize.cy := ContentLayout.LocalRect.Height
    else
      FOriginalContentLayoutSize.cy := LocalRect.Height;
end;

procedure TCustomScrollBox.Loaded;
begin
  inherited;
  FContent.Loaded; // ensure that FixupTabList is called for FContent
  UpdateOriginalContentLayoutSize(False);
end;

procedure TCustomScrollBox.PaddingChanged;
begin
  Content.Padding.Assign(Padding);
end;

procedure TCustomScrollBox.Center;
begin
  if ContentLayout <> nil then
    ViewportPosition := TPointF.Create((ContentBounds.Width - ContentLayout.Width) / 2,
      (ContentBounds.Height - ContentLayout.Height) / 2);
end;

procedure TCustomScrollBox.ScrollBy(const Dx, Dy: Single);
begin
  if VScrollBar <> nil then
    VScrollBar.Value := VScrollBar.Value - Dy;
  if HScrollBar <> nil then
    HScrollBar.Value := HScrollBar.Value - Dx;
end;

procedure TCustomScrollBox.ScrollTo(const Dx, Dy: Single);
begin
  ScrollBy(Dx, Dy);
end;

procedure TCustomScrollBox.InViewRect(const Rect: TRectF);
begin
end;

procedure TCustomScrollBox.SetAutoHide(const Value: Boolean);
begin
  if FAutoHide <> Value then
  begin
    FAutoHide := Value;
    Realign;
  end;
end;

procedure TCustomScrollBox.SetShowScrollBars(const Value: Boolean);
begin
  if FShowScrollBars <> Value then
  begin
    FShowScrollBars := Value;
    if FShowScrollBars and FAutoHide then
      InvalidateContentSize;
    Realign;
  end;
end;

procedure TCustomScrollBox.SetShowSizeGrip(const Value: Boolean);
begin
  if FShowSizeGrip <> Value then
  begin
    FShowSizeGrip := Value;
    UpdateSizeGrip;
  end;
end;

function TCustomScrollBox.GetViewportPosition: TPointF;
var
  LScale, X, Y: Double;
begin
  LScale := GetSceneScale;
  X := Round(AniCalculations.ViewportPosition.X * LScale) / LScale;
  Y := Round(AniCalculations.ViewportPosition.Y * LScale) / LScale;
  Result := TPointF.Create(X, Y);
end;

procedure TCustomScrollBox.SetViewportPosition(const Value: TPointF);
var
  LScale, X, Y: Double;
begin
  LScale := GetSceneScale;
  X := Value.X;
  Y := Value.Y;
  AniCalculations.ViewportPosition := TPointD.Create(Round(X * LScale) / LScale, Round(Y * LScale) / LScale);
end;

procedure TCustomScrollBox.DefineProperties(Filer: TFiler);
const
  VP = 'Viewport';
begin
  inherited;
  Filer.DefineProperty('UseSmallScrollBars', IgnoreBooleanValue, nil, False);
  Filer.DefineProperty('MouseTracking', IgnoreBooleanValue, nil, False);
  Filer.DefineProperty(VP + '.Width', ReadContentLayoutWidth, WriteContentLayoutWidth, True);
  Filer.DefineProperty(VP + '.Height', ReadContentLayoutHeight, WriteContentLayoutHeight, True);
end;

procedure TCustomScrollBox.ReadPartSize(Reader: TReader; var Size: Single);
var
  LValue: Double;
begin
  case Reader.NextValue of
    vaExtended: LValue := Reader.ReadFloat;
    vaDouble: LValue := Reader.ReadDouble;
    vaSingle: LValue := Reader.ReadSingle;
    vaInt32: LValue := Reader.ReadInteger;
  else
    Reader.SkipValue;
    Exit;
  end;
  Size := RoundTo(LValue, -1);
end;

procedure TCustomScrollBox.ReadContentLayoutHeight(Reader: TReader);
begin
  ReadPartSize(Reader, FOriginalContentLayoutSize.cy);
end;

procedure TCustomScrollBox.ReadContentLayoutWidth(Reader: TReader);
begin
  ReadPartSize(Reader, FOriginalContentLayoutSize.cx);
end;

procedure TCustomScrollBox.WriteContentLayoutHeight(Writer: TWriter);
begin
  if ContentLayout <> nil then
    FOriginalContentLayoutSize.cy := ContentLayout.LocalRect.Height;
  Writer.WriteFloat(RoundTo(FOriginalContentLayoutSize.cy, -1));
end;

procedure TCustomScrollBox.WriteContentLayoutWidth(Writer: TWriter);
begin
  if ContentLayout <> nil then
    FOriginalContentLayoutSize.cx := ContentLayout.LocalRect.Width;
  Writer.WriteFloat(RoundTo(FOriginalContentLayoutSize.cx, -1));
end;

procedure TCustomScrollBox.Sort(Compare: TFmxObjectSortCompare);
begin
  FContent.Sort(Compare);
end;

procedure TCustomScrollBox.StartScrolling;
begin
  if Scene <> nil then
    Scene.ChangeScrollingState(Self, True);
end;

procedure TCustomScrollBox.StopScrolling;
begin
  if Scene <> nil then
    Scene.ChangeScrollingState(nil, False);
end;

function TCustomScrollBox.ClientHeight: Single;
begin
  if ContentLayout <> nil then
    Result := ContentLayout.Height
  else
    Result := Height;
end;

function TCustomScrollBox.ClientWidth: Single;
begin
  if ContentLayout <> nil then
    Result := ContentLayout.Width
  else
    Result := Width;
end;

procedure TCustomScrollBox.CMGesture(var EventInfo: TGestureEventInfo);
var
  LP: TPointF;
begin
  //This is used when scrolling with the finger on top of a control (like a TButton on a TListItem).
  if (ContentLayout <> nil) and (EventInfo.GestureID = igiPan) then
  begin
    FMouseEvents := False;
    LP := ContentLayout.AbsoluteToLocal(EventInfo.Location);
    if TInteractiveGestureFlag.gfBegin in EventInfo.Flags then
      AniMouseDown(True, LP.X, LP.Y)
    else
      if EventInfo.Flags = [] then
        AniMouseMove(True, LP.X, LP.Y)
      else
      if AniCalculations.Down then
        AniMouseUp(True, LP.X, LP.Y);
  end
  else
    inherited;
end;

function TCustomScrollBox.IsAddToContent(const AObject: TFmxObject): Boolean;
begin
  Result := (FContent <> nil)
    and (AObject <> FContent)
    and (AObject <> ResourceLink)
    and not (AObject is TEffect)
    and not (AObject is TAnimation)
    and not ((AObject = FVScrollInfo[0].Scroll) or
             (AObject = FVScrollInfo[1].Scroll) or
             (AObject = FHScrollInfo[0].Scroll) or
             (AObject = FHScrollInfo[1].Scroll) or
             (AObject = FSizeGrip));
end;

function TCustomScrollBox.IsOpaque: Boolean;
begin
  Result := False;
end;

procedure TCustomScrollBox.ContentAddObject(const AObject: TFmxObject);
begin
  RealignContent;
end;

procedure TCustomScrollBox.ContentInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  RealignContent;
end;

procedure TCustomScrollBox.ContentRemoveObject(const AObject: TFmxObject);
begin
  RealignContent;
end;

procedure TCustomScrollBox.ContentBeforeRemoveObject(AObject: TFmxObject);
begin
end;

{ TGridLayout }

procedure TGridLayout.DoAddObject(const AObject: TFmxObject);
begin
  inherited;
  Realign;
end;

procedure TGridLayout.DoRemoveObject(const AObject: TFmxObject);
begin
  inherited;
  Realign;
end;

procedure TGridLayout.Paint;
begin
  inherited;
  if (csDesigning in ComponentState) and not Locked then
    DrawDesignBorder;
end;

constructor TGridLayout.Create(AOwner: TComponent);
begin
  inherited;
  FItemHeight := 64;
  FItemWidth := 64;
end;

procedure TGridLayout.DoRealign;
var
  I: Integer;
  CurPos: TPointF;
  LControl: TControl;
  LItemWidth, LItemHeight: Single;
begin
  if FDisableAlign then
    Exit;
  FDisableAlign := True;
  { content }
  CurPos := PointF(Padding.Left, Padding.Top);

  LItemWidth := FItemWidth;
  LItemHeight := FItemHeight;
  if (Orientation = TOrientation.Horizontal)
    and (LItemWidth < 0) and (ControlsCount > 0) then
  begin
    LItemWidth := (Width - Padding.Left - Padding.Right) / ControlsCount;
    LItemHeight := Height - Padding.Top - Padding.Bottom;
  end
  else if (Orientation = TOrientation.Vertical)
    and (LItemHeight < 0) and (ControlsCount > 0) then
  begin
    LItemWidth := Width - Padding.Left - Padding.Right;
    LItemHeight := (Height - Padding.Top - Padding.Bottom) / ControlsCount;
  end;

  for I := 0 to ControlsCount - 1 do
  begin
    LControl := Controls[I];
    // Avoid realigning designer "things" like grab handles
    {$IFDEF MSWINDOWS}
    if (csDesigning in ComponentState)
      and Supports(LControl, IDesignerControl) then Continue;
    {$ENDIF}

    LControl.SetBounds(CurPos.X + LControl.Margins.Left, CurPos.Y + LControl.Margins.Top,
      LItemWidth - LControl.Margins.Left - LControl.Margins.Right, LItemHeight - LControl.Margins.Top -
      LControl.Margins.Bottom);
    if Orientation = TOrientation.Horizontal then
    begin
      CurPos.X := CurPos.X + LItemWidth;
      if CurPos.X + LItemWidth > Self.Width - Self.Padding.Left -
        Self.Padding.Right then
      begin
        CurPos.X := Self.Padding.Left;
        CurPos.Y := CurPos.Y + LItemHeight;
      end;
    end
    else
    begin
      CurPos.Y := CurPos.Y + LItemHeight;
      if CurPos.Y + LItemHeight > Self.Height - Self.Padding.Top -
        Self.Padding.Bottom then
      begin
        CurPos.Y := Self.Padding.Top;
        CurPos.X := CurPos.X + LItemWidth;
      end;
    end;
  end;
  FDisableAlign := False;
end;

procedure TGridLayout.SetItemHeight(const Value: Single);
begin
  if FItemHeight <> Value then
  begin
    FItemHeight := Value;
    Realign;
  end;
end;

procedure TGridLayout.SetItemWidth(const Value: Single);
begin
  if FItemWidth <> Value then
  begin
    FItemWidth := Value;
    Realign;
  end;
end;

procedure TGridLayout.SetOrientation(const Value: TOrientation);
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    Realign;
  end;
end;

{ TScaledLayout }

constructor TScaledLayout.Create(AOwner: TComponent);
begin
  inherited;
  HitTest := False;
  FOriginalWidth := Width;
  FOriginalHeight := Height;
end;

destructor TScaledLayout.Destroy;
begin
  inherited;
end;

procedure TScaledLayout.DoRealign;
begin
  if (Parent <> nil) and (Parent is TCustomScrollBox) and (TCustomScrollBox(Parent).FUpdating > 0) then
    Exit;

  if csDesigning in ComponentState then
    inherited DoRealign
  else
  begin
    if FNeedAlign then
      AlignObjects(Self, Padding, FOriginalWidth, FOriginalHeight, FLastWidth, FLastHeight, FDisableAlign);

    RecalcAbsolute;
    FRecalcUpdateRect := True;
  end;
end;

function TScaledLayout.GetChildrenMatrix(var Matrix: TMatrix; var Simple: Boolean): Boolean;
begin
  Result := True;
  if csDesigning in ComponentState then
  begin
    OriginalHeight := Height;
    OriginalWidth := Width;
  end;
  Matrix := TMatrix.Identity;
  Matrix.m11 := Width / FOriginalWidth;
  Matrix.m22 := Height / FOriginalHeight;
  Simple := SameValue(Matrix.m11, 1, TEpsilon.Matrix) and SameValue(Matrix.m22, 1, TEpsilon.Matrix);
end;

procedure TScaledLayout.Paint;
begin
  inherited;
  if (csDesigning in ComponentState) and not Locked then
    DrawDesignBorder;
end;

procedure TScaledLayout.SetOriginalHeight(const Value: Single);
begin
  if FOriginalHeight <> Value then
  begin
    FOriginalHeight := Value;
    if FOriginalHeight < 1 then
      FOriginalHeight := 1;
    RecalcAbsolute;
  end;
end;

procedure TScaledLayout.SetOriginalWidth(const Value: Single);
begin
  if FOriginalWidth <> Value then
  begin
    FOriginalWidth := Value;
    if FOriginalWidth < 1 then
      FOriginalWidth := 1;
    RecalcAbsolute;
  end;
end;

procedure TScaledLayout.SetHeight(const Value: Single);
begin
  inherited;
  if csDesigning in ComponentState then
    OriginalHeight := Height
  else
    RecalcAbsolute;
end;

procedure TScaledLayout.SetWidth(const Value: Single);
begin
  inherited;
  if csDesigning in ComponentState then
    OriginalWidth := Width
  else
    RecalcAbsolute;
end;

{ TScrollBox }

procedure TScrollBox.Paint;
begin
  inherited;
  if (csDesigning in ComponentState) and not Locked then
    DrawDesignBorder(DesignBorderColor, DesignBorderColor);
end;

{ TVertScrollBox }

function TVertScrollBox.DoCalcContentBounds: TRectF;
begin
  if (FContent <> nil) and (ContentLayout <> nil) then
    FContent.Width := ContentLayout.Width; // Only for compatibility with old code
  Result := inherited DoCalcContentBounds;
  if ContentLayout <> nil then
    Result.Width := ContentLayout.Width;
end;

procedure TVertScrollBox.DoUpdateAniCalculations(const AAniCalculations: TScrollCalculations);
begin
  inherited DoUpdateAniCalculations(AAniCalculations);
  AAniCalculations.TouchTracking := AAniCalculations.TouchTracking - [ttHorizontal];
end;

procedure TVertScrollBox.Paint;
begin
  inherited;
  if (csDesigning in ComponentState) and not Locked then
    DrawDesignBorder(DesignBorderColor or TAlphaColorRec.Alpha, DesignBorderColor);
end;

function TVertScrollBox.GetDefaultStyleLookupName: string;
begin
  Result := 'scrollboxstyle';
end;

{ THorzScrollBox }

function THorzScrollBox.DoCalcContentBounds: TRectF;
begin
  if (FContent <> nil) and (ContentLayout <> nil) then
    FContent.Height := ContentLayout.Height; // Only for compatibility with old code
  Result := inherited DoCalcContentBounds;
  if ContentLayout <> nil then
    Result.Height := ContentLayout.Height;
end;

procedure THorzScrollBox.DoUpdateAniCalculations(const AAniCalculations: TScrollCalculations);
begin
  inherited DoUpdateAniCalculations(AAniCalculations);
  AAniCalculations.TouchTracking := AAniCalculations.TouchTracking - [ttVertical];
end;


function THorzScrollBox.GetDefaultStyleLookupName: string;
begin
  Result := 'scrollboxstyle';
end;

procedure THorzScrollBox.Paint;
begin
  inherited;
  if (csDesigning in ComponentState) and not Locked then
    DrawDesignBorder(DesignBorderColor, DesignBorderColor or TAlphaColorRec.Alpha);
end;

{ TFramedVertScrollBox }

function TFramedVertScrollBox.GetDefaultStyleLookupName: string;
begin
  Result := 'framedscrollboxstyle';
end;

function TFramedVertScrollBox.IsOpaque: Boolean;
begin
  Result := True;
end;

{ TFlowLayout }

procedure TFlowLayout.DoAddObject(const AObject: TFmxObject);
begin
  inherited;
  Realign;
end;

procedure TFlowLayout.DoRemoveObject(const AObject: TFmxObject);
begin
  inherited;
  Realign;
end;

procedure TFlowLayout.Paint;
begin
  inherited;
  if (csDesigning in ComponentState) and not Locked then
    DrawDesignBorder;
end;

constructor TFlowLayout.Create(AOwner: TComponent);
begin
  inherited;
  FRules.Justify := TFlowJustify.Left;
  FRules.JustifyLast := TFlowJustify.Left;
  FRules.Direction := TFlowDirection.LeftToRight;
  FRules.HorizontalGap := 0;
  FRules.VerticalGap := 0;
end;

procedure TFlowLayout.DoRealign;
  function ControlWidth(Control : TControl) : Single;
  begin
    if Control.Visible then
      Result := Control.Width + Control.Margins.Left + Control.Margins.Right
    else
      Result := 0;
  end;

  function ControlHeight(Control : TControl; const Rules: TFlowLayoutRules) : Single;
  begin
    if Control.Visible then
      Result := Control.Height
              + Control.Margins.Top + Control.Margins.Bottom
              + Rules.VerticalGap
    else
      Result := 0;
  end;

  function GetJustify(LastLine : Boolean; const Rules : TFlowLayoutRules) : TFlowJustify;
  begin
    if LastLine then
      Result := Rules.JustifyLast
    else
      Result := Rules.Justify;
  end;

  function Gap(First : Boolean) : Single;
  begin
    if First then
      Result := 0
    else
      Result := FRules.HorizontalGap;
  end;

type
  TState = (NewLine, Measure, PreLayout, Layout, &End);

const
  InitialState: array [False..True] of TState = (TState.&End, TState.NewLine);

var
  I: Integer;
  State: TState;
  CurPos: TPointF;
  Control: TControl;
  ControlBounds: TRectF;
  LineStartIdx, LineEndIdx: Integer;
  WidthAccu: Single;
  LineHeight: Single;
  ClientWidth: Single;
  Add: Single;
  NextWidth: Single;
  NextRules: TFlowLayoutRules;
  CurrentRules: TFlowLayoutRules;
begin
  if FDisableAlign or (Controls = nil) then
    Exit;

  FDisableAlign := true;

  CurPos := PointF(Padding.Left, Padding.Top);
  ClientWidth := Self.Width - Self.Padding.Left - Self.Padding.Right;
  LineHeight := 0;

  CurrentRules := Self.FRules;
  NextRules := Self.FRules;

  I := 0;
  LineStartIdx := I;
  LineEndIdx := I;
  WidthAccu := 0;
  Add := 0;
  State := InitialState[Controls.Count <> 0];
  while State <> TState.End do
  begin
    Control := TControl(Controls[i]);

    case State of
      TState.NewLine:
        begin
          CurrentRules := NextRules;
          LineStartIdx := I;
          LineEndIdx := I;
          WidthAccu := 0;
          CurPos.Y := CurPos.Y + LineHeight;
          LineHeight := ControlHeight(Control, CurrentRules);
          State := TState.Measure;
        end;

      TState.Measure:
        begin
          NextWidth := WidthAccu + Gap(i = LineStartIdx) + ControlWidth(Control);
          if Control is TFlowLayoutBreak then
          begin
            if TFlowLayoutBreak(Control).ChangesRules then
              NextRules := TFlowLayoutBreak(Control).FRules;
            I := LineStartIdx;
            State := TState.PreLayout;
          end
          else if (NextWidth > ClientWidth) then
          begin
            // width overflow, layout the line

            // update WidthAccu if the line has only 1 control
            if I = LineStartIdx then
              WidthAccu := NextWidth;

            I := LineStartIdx;
            State := TState.PreLayout;
          end
          else if I = Controls.Count - 1 then
          begin
            // no more controls, layout the line and done
            WidthAccu := NextWidth;
            LineHeight := Max(LineHeight, ControlHeight(Control, CurrentRules));
            LineEndIdx := I;
            I := LineStartIdx;
            State := TState.PreLayout;
          end
          else begin
            // keep counting width
            WidthAccu := NextWidth;
            LineEndIdx := I;
            LineHeight := Max(LineHeight, ControlHeight(Control, CurrentRules));
            Inc(I);
          end;
        end;

    TState.PreLayout:
      begin
        // Prepare to layout the line
        Add := 0;

        case GetJustify(LineEndIdx = (Controls.Count - 1), CurrentRules) of
          TFlowJustify.Left:
            CurPos.X := Padding.Left;
          TFlowJustify.Right:
            CurPos.X := Self.Width - Padding.Right - WidthAccu;
          TFlowJustify.Center:
            CurPos.X := Padding.Left + ClientWidth/2 - WidthAccu/2;
          TFlowJustify.Justify:
            begin
              CurPos.X := Padding.Left;
              if LineEndIdx - LineStartIdx > 0 then
                Add := (ClientWidth - WidthAccu) / (LineEndIdx - LineStartIdx);
            end;
        end;

        case CurrentRules.Direction of
          TFlowDirection.LeftToRight: I := LineStartIdx;
          TFlowDirection.RightToLeft: I := LineEndIdx;
        end;

        State := TState.Layout;
      end;

    TState.Layout:
      begin
        ControlBounds := Control.BoundsRect;
        ControlBounds.SetLocation(CurPos.X + Control.Margins.Left, CurPos.Y + Control.Margins.Top);

        if not ((csDesigning in ComponentState) and Supports(TControl(Self.Children[I]), IDesignerControl)) then
        begin
          Control.BoundsRect := ControlBounds;
          CurPos.X := CurPos.X + ControlWidth(Control) + Add + CurrentRules.HorizontalGap;
        end;

        // advance to the next control in line
        case CurrentRules.Direction of
          TFlowDirection.LeftToRight:
            begin
              if I = Controls.Count - 1 then
                State := TState.End
              else if I = LineEndIdx then
                State := TState.NewLine;

              Inc(I);
            end;
          TFlowDirection.RightToLeft:
            begin
              if I = LineStartIdx then
              begin
                I := LineEndIdx + 1;

                if LineEndIdx = Controls.Count - 1 then
                  State := TState.End
                else
                  State := TState.NewLine;
              end
              else
                Dec(I);
            end;
        end;
      end;
    end;
  end;
  FDisableAlign := false;
end;

procedure TFlowLayout.SetFlowDirection(ADirection: TFlowDirection);
begin
  FRules.Direction := ADirection;
  Realign;
end;

procedure TFlowLayout.SetJustify(AJustify: TFlowJustify);
begin
  FRules.Justify := AJustify;
  Realign;
end;

procedure TFlowLayout.SetJustifyLast(AJustify: TFlowJustify);
begin
  FRules.JustifyLast := AJustify;
  Realign;
end;

procedure TFlowLayout.SetHGap(AHGap: Single);
begin
  FRules.HorizontalGap := AHGap;
  Realign;
end;

procedure TFlowLayout.SetVGap(AVGap: Single);
begin
  FRules.VerticalGap := AVGap;
  Realign;
end;

{ TFlowLayoutBreak }

constructor TFlowLayoutBreak.Create(AOwner: TComponent);
begin
  inherited;
  Width := 4;
  Height := 15;
  Visible := False;
end;

procedure TFlowLayoutBreak.Paint;
begin
  Canvas.FillRect(LocalRect, 0, 0, [], AbsoluteOpacity, TCornerType.InnerLine);
  Canvas.DrawRect(LocalRect, 0, 0, [], AbsoluteOpacity, TCornerType.InnerLine);
end;

procedure TFlowLayoutBreak.SetChangesRules(AChangesRules: Boolean);
begin
  FChangesRules := AChangesRules;
end;

function TFlowLayoutBreak.VisibleStored: Boolean;
begin
  if ActionClient then
    Result := True
  else
    Result := Visible;
end;

{ TFramedScrollBox }

function TFramedScrollBox.IsOpaque: Boolean;
begin
  Result := True;
end;

{ TGridPanelLayout }

{ TGridPanelLayout.TCellItem }

procedure TGridPanelLayout.TCellItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TCellItem then
  begin
    TCellItem(Dest).FSizeStyle := Self.FSizeStyle;
    TCellItem(Dest).FValue := Self.FValue;
    TCellItem(Dest).FSize := Self.FSize;
  end;
end;

constructor TGridPanelLayout.TCellItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FSizeStyle := TSizeStyle.Percent;
end;

procedure TGridPanelLayout.TCellItem.SetSizeStyle(Value: TSizeStyle);
begin
  if Value <> FSizeStyle then
  begin
    FSizeStyle := Value;
    Changed(False);
  end;
end;

procedure TGridPanelLayout.TCellItem.SetValue(Value: Double);
begin
  if Value <> FValue then
  begin
    if FSizeStyle = TSizeStyle.Absolute then
    begin
      FSize := Trunc(Value);
      FValue := FSize;
    end else
      FValue := Value;
    Changed(False);
  end;
end;

{ TGridPanelLayout.TCellCollection }

function TGridPanelLayout.TCellCollection.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := SCellMember;
    1: Result := SCellSizeType;
    2: Result := SCellValue;
  else
    Result := '';
  end;
end;

function TGridPanelLayout.TCellCollection.GetAttrCount: Integer;
begin
  Result := 3;
end;

function TGridPanelLayout.TCellCollection.GetItem(Index: Integer): TCellItem;
begin
  Result := TCellItem(inherited GetItem(Index));
end;

function TGridPanelLayout.TCellCollection.GetItemAttr(Index, ItemIndex: Integer): string;

  function GetSizeStyleString(Index: Integer): string;
  begin
    case Items[Index].SizeStyle of
      TSizeStyle.Absolute: Result := SCellAbsoluteSize;
      TSizeStyle.Percent: Result := SCellPercentSize;
      TSizeStyle.Auto: Result := SCellAutoSize;
    else
      Result := string.Empty;
    end;
  end;

  function GetValueString(Index: Integer): string;
  var
    Item: TCellItem;
  begin
    Item := Items[Index];
    if Item.SizeStyle = TSizeStyle.Absolute then
      Result := IntToStr(Trunc(Item.Value))
    else if Item.SizeStyle = TSizeStyle.Percent then
      Result := Format('%3.2f%%', [Item.Value]) // do not localize
    else Result := SCellAutoSize;
  end;

begin
  case Index of
    1: Result := GetSizeStyleString(ItemIndex);
    2: Result := GetValueString(ItemIndex);
  else
    Result := string.Empty;
  end;
end;

function TGridPanelLayout.TCellCollection.Owner: TGridPanelLayout;
begin
  Result := TGridPanelLayout(GetOwner);
end;

procedure TGridPanelLayout.TCellCollection.SetItem(Index: Integer; Value: TCellItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TGridPanelLayout.TCellCollection.Update(Item: TCollectionItem);
begin
  inherited;
  if Owner <> nil then
  begin
    Owner.FRecalcCellSizes := True;
    Owner.FNeedAlign := True;
    Owner.Realign;
    if csDesigning in Owner.ComponentState then
      Owner.Repaint;
  end;
end;

{ TGridPanelLayout.TRowCollection }

constructor TGridPanelLayout.TRowCollection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TRowItem);
end;

function TGridPanelLayout.TRowCollection.Add: TRowItem;
begin
  Result := TRowItem(inherited Add);
end;

function TGridPanelLayout.TRowCollection.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  if Index = 0 then
    Result := Format(SCellRow, [ItemIndex])
  else
    Result := inherited GetItemAttr(Index, ItemIndex);
end;

procedure TGridPanelLayout.TRowCollection.Notify(Item: TCollectionItem;
  Action: System.Classes.TCollectionNotification);
begin
  inherited;
  if (Action = System.Classes.TCollectionNotification.cnExtracting) and not (csDestroying in Owner.ComponentState) and
     not (csUpdating in Owner.ComponentState) then
    if not (csAncestor in Owner.ComponentState) and not Owner.IsRowEmpty(Item.Index) then
      raise EGridLayoutException.Create(SCannotDeleteRow)
    else Owner.UpdateControlsRow(Item.Index);
end;

{ TGridPanelLayout.TColumnCollection }

function TGridPanelLayout.TColumnCollection.Add: TColumnItem;
begin
  Result := TColumnItem(inherited Add);
end;

constructor TGridPanelLayout.TColumnCollection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TColumnItem);
end;

function TGridPanelLayout.TColumnCollection.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  if Index = 0 then
    Result := Format(SCellColumn, [ItemIndex])
  else
    Result := inherited GetItemAttr(Index, ItemIndex);
end;

procedure TGridPanelLayout.TColumnCollection.Notify(Item: TCollectionItem; Action: System.Classes.TCollectionNotification);
begin
  inherited;
  if (Action = System.Classes.TCollectionNotification.cnExtracting) and not (csDestroying in Owner.ComponentState) and
     not (csUpdating in Owner.ComponentState) then
    if not Owner.IsColumnEmpty(Item.Index) then
      raise EGridLayoutException.Create(SCannotDeleteColumn)
    else
      Owner.UpdateControlsColumn(Item.Index);
end;

{ TGridPanelLayout.TControlCollection }

function TGridPanelLayout.TControlCollection.Add: TControlItem;
begin
  Result := TControlItem(inherited Add);
end;

procedure TGridPanelLayout.TControlCollection.AddControl(AControl: TControl; AColumn, ARow: Integer);
  procedure PlaceInCell(ControlItem: TControlItem);
  var
    I, J: Integer;
  begin
    try
      ControlItem.Control := AControl;
      ControlItem.FRow := -1;
      ControlItem.FColumn := -1;
      if (ARow = -1) and (AColumn > -1) then
      begin
        for I := 0 to Owner.RowCollection.Count - 1 do
          if Controls[AColumn, I] = nil then
          begin
            ControlItem.Row := I;
            ControlItem.Column := AColumn;
            Exit;
          end;
        AColumn := -1;
      end;
      if (AColumn = -1) and (ARow > -1) then
      begin
        for I := 0 to Owner.ColumnCollection.Count - 1 do
          if Controls[I, ARow] = nil then
          begin
            ControlItem.Column := I;
            ControlItem.Row := ARow;
            Exit;
          end;
        ARow := -1;
      end;
      if (AColumn > -1) and (ARow > -1) then
      begin
        if Controls[AColumn, ARow] = nil then
        begin
          ControlItem.Column := AColumn;
          ControlItem.Row := ARow;
          Exit;
        end;
        AColumn := -1;
        ARow := -1;
      end;
      if (ARow = -1) and (AColumn = -1) then
      begin
        for J := 0 to Owner.RowCollection.Count - 1 do
          for I := 0 to Owner.ColumnCollection.Count - 1 do
            if Controls[I, J] = nil then
            begin
              ControlItem.Row := J;
              ControlItem.Column := I;
              Exit;
            end;
      end;
      if (ControlItem.Row = -1) or (ControlItem.Column = -1) then
        if (Owner <> nil) and (Owner.ExpandStyle <> TExpandStyle.FixedSize) then
        begin
          if Owner.ExpandStyle = TExpandStyle.AddRows then
            Owner.AutoAddRow
          else
            Owner.AutoAddColumn;
          PlaceInCell(ControlItem);
        end else if not (csDesigning in ControlItem.Control.ComponentState) then
          raise EGridLayoutException.Create(SCannotAddFixedSize);
    except
      ControlItem.Control := nil;
      raise;
    end;
  end;

begin
  if IndexOf(AControl) < 0 then
    PlaceInCell(Add);
end;

constructor TGridPanelLayout.TControlCollection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TControlItem);
end;

function TGridPanelLayout.TControlCollection.GetControl(AColumn, ARow: Integer): TControl;
var
  ControlItem: TControlItem;
begin
  ControlItem := GetControlItem(AColumn, ARow);
  if ControlItem <> nil then
    Result := ControlItem.Control
  else
    Result := nil;
end;

function TGridPanelLayout.TControlCollection.GetControlItem(AColumn, ARow: Integer): TControlItem;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := TControlItem(Items[I]);
    if (ARow >= Result.Row) and (ARow <= Result.Row + Result.RowSpan - 1) and
      (AColumn >= Result.Column) and (AColumn <= Result.Column + Result.ColumnSpan - 1) then
      Exit;
  end;
  Result := nil;
end;

function TGridPanelLayout.TControlCollection.GetItem(Index: Integer): TControlItem;
begin
  Result := TControlItem(inherited GetItem(Index));
end;

function TGridPanelLayout.TControlCollection.IndexOf(AControl: TControl): Integer;
begin
  for Result := 0 to Count - 1 do
    if TControlItem(Items[Result]).Control = AControl then
      Exit;
  Result := -1;
end;

function TGridPanelLayout.TControlCollection.Owner: TGridPanelLayout;
begin
  Result := TGridPanelLayout(GetOwner);
end;

procedure TGridPanelLayout.TControlCollection.RemoveControl(AControl: TControl);
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    if Items[I].Control = AControl then
    begin
      Items[I].Control := nil;
      Delete(I);
      Exit;
    end;
end;

procedure TGridPanelLayout.TControlCollection.SetControl(AColumn, ARow: Integer; Value: TControl);
var
  Index: Integer;
  ControlItem: TControlItem;
begin
  if Owner <> nil then
  begin
    if (AColumn < 0) or (AColumn >= Owner.ColumnCollection.Count) then
      raise EGridLayoutException.CreateFmt(SInvalidColumnIndex, [AColumn]);
    if (ARow < 0) or (ARow >= Owner.RowCollection.Count) then
      raise EGridLayoutException.CreateFmt(SInvalidRowIndex, [ARow]);
    Index := IndexOf(Value);
    if Index > -1 then
    begin
      ControlItem := Items[Index];
      ControlItem.FColumn := AColumn;
      ControlItem.FRow := ARow;
    end else
      AddControl(Value, AColumn, ARow);
  end;
end;

procedure TGridPanelLayout.TControlCollection.SetItem(Index: Integer; Value: TControlItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TGridPanelLayout.TControlCollection.Update(Item: TCollectionItem);
begin
  inherited;
  if Owner <> nil then
  begin
    Owner.FRecalcCellSizes := True;
    Owner.Realign;
  end;
end;

{ TGridPanelLayout.TControlItem }

procedure TGridPanelLayout.TControlItem.AssignTo(Dest: TPersistent);
var
  DestControlItem: TControlItem;
begin
  if Dest is TControlItem then
  begin
    DestControlItem := TControlItem(Dest);
    DestControlItem.FControl := Self.Control;
    DestControlItem.FRow := Self.Row;
    DestControlItem.FColumn := Self.Column;
    DestControlItem.Changed(False);
  end;
end;

constructor TGridPanelLayout.TControlItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FRowSpan := 1;
  FColumnSpan := 1;
end;

destructor TGridPanelLayout.TControlItem.Destroy;
var
  LControl: TControl;
begin
  if (FControl <> nil) and not (csLoading in GridPanelLayout.ComponentState) and
     not (csUpdating in GridPanelLayout.ComponentState) and
     not (csDestroying in GridPanelLayout.ComponentState) then
  begin
    LControl := FControl;
    FControl := nil;
    LControl.Parent := nil;
    LControl.Free;
  end;
  inherited;
end;

function TGridPanelLayout.TControlItem.GetGridPanelLayout: TGridPanelLayout;
var
  Owner: TControlCollection;
begin
  Owner := TControlCollection(GetOwner);
  if Owner <> nil then
    Result := Owner.Owner
  else
    Result := nil;
end;

procedure TGridPanelLayout.TControlItem.SetControl(Value: TControl);
begin
  if FControl <> Value then
  begin
    if Value = GridPanelLayout then
      raise EGridLayoutException.Create(SInvalidControlItem);
    FControl := Value;
    Changed(False);
  end;
end;

procedure TGridPanelLayout.TControlItem.SetColumn(Value: Integer);
begin
  if FColumn <> Value then
  begin
    if not (csLoading in GridPanelLayout.ComponentState) then
    begin
      if (Value < 0)or (Value > GridPanelLayout.ColumnCollection.Count - 1) then
        raise EGridLayoutException.CreateFmt(SInvalidColumnIndex, [Value]);
      InternalSetLocation(Value, FRow, False, True);
    end
    else
      FColumn := Value;
  end;
end;

procedure TGridPanelLayout.TControlItem.SetRow(Value: Integer);
begin
  if FRow <> Value then
  begin
    if not (csLoading in GridPanelLayout.ComponentState) then
    begin
      if (Value < 0) or (Value > GridPanelLayout.RowCollection.Count - 1) then
        raise EGridLayoutException.CreateFmt(SInvalidRowIndex, [Value]);
      InternalSetLocation(FColumn, Value, False, True);
    end
    else
      FRow := Value;
  end;
end;

type
  TNewLocationRec = record
    ControlItem: TGridPanelLayout.TControlItem;
    NewColumn, NewRow: Integer;
    Pushed: Boolean;
  end;
  TNewLocationRecs = array of TNewLocationRec;

  TNewLocations = class
  private
    FNewLocations: TNewLocationRecs;
    FCount: Integer;
  public
    function AddNewLocation(AControlItem: TGridPanelLayout.TControlItem; ANewColumn, ANewRow: Integer; APushed: Boolean = False): Integer;
    procedure ApplyNewLocations;
    property Count: Integer read FCount;
    property NewLocations: TNewLocationRecs read FNewLocations;
  end;

function TNewLocations.AddNewLocation(AControlItem: TGridPanelLayout.TControlItem; ANewColumn, ANewRow: Integer; APushed: Boolean): Integer;
var
  NLRec: TNewLocationRec;
begin
  if FCount = Length(FNewLocations) then
    SetLength(FNewLocations, Length(FNewLocations) + 10);
  Result := FCount;
  Inc(FCount);
  NLRec := FNewLocations[Result];
  NLRec.ControlItem := AControlItem;
  NLRec.NewColumn := ANewColumn;
  NLRec.NewRow := ANewRow;
  NLRec.Pushed := APushed;
end;

procedure TNewLocations.ApplyNewLocations;
var
  I: Integer;
  NLRec: TNewLocationRec;
begin
  for I := 0 to FCount - 1 do
  begin
    NLRec := FNewLocations[I];
    if NLRec.ControlItem <> nil then
      NLRec.ControlItem.InternalSetLocation(NLRec.NewColumn, NLRec.NewRow, NLRec.Pushed, False);
  end;
end;

procedure TGridPanelLayout.TControlItem.SetRowSpan(Value: TCellSpan);
var
  I, Delta: Integer;
  Collection: TControlCollection;
  ControlItem: TControlItem;
  NumToAdd, NumRows, MoveBy, LColumn, LRow, IndexDelta: Integer;
  Span: TCellSpan;
  NewLocations: TNewLocations;
begin
  if FRowSpan <> Value then
  begin
    if Value < 1 then
      raise EGridLayoutException.CreateFmt(SInvalidSpan, [Value]);
    Collection := TControlCollection(GetOwner);
    if Collection = nil then Exit;
    GridPanelLayout.BeginUpdate;
    try
      NewLocations := TNewLocations.Create;
      try
        if FRowSpan > Value then
        begin
          Delta := FRowSpan - Value;
          FRowSpan := Value;
          if GridPanelLayout.ExpandStyle in [TExpandStyle.AddRows, TExpandStyle.FixedSize] then
          begin
            NumRows := GridPanelLayout.RowCollection.Count;
            // Move the controls below up to fill in the space.
            for I := FRow + FRowSpan + Delta to NumRows - 1 do
            begin
              ControlItem := Collection.ControlItems[FColumn, I];
              if ControlItem <> nil then
                if ControlItem.Pushed then
                  NewLocations.AddNewLocation(ControlItem, FColumn, I - Delta, False)
                else
                  Break;
            end;
            NewLocations.ApplyNewLocations;
            GridPanelLayout.RemoveEmptyAutoAddRows;
          end else
          begin
            // Scan forward in row primary order, removing Delta from position of each
            // control item, unwrapping where nessesary, until the last control is reached
            // or a non "pushed" control is found.
            for I := GridPanelLayout.RowSpanIndex[FColumn, FRow] to GridPanelLayout.CellCount - 1 do
            begin
              GridPanelLayout.CellIndexToCell(I, LColumn, LRow);
              ControlItem := Collection.ControlItems[LColumn, LRow];
              if ControlItem <> nil then
              begin
                if ControlItem.Pushed then
                begin
                  if (ControlItem.Column = LColumn) and (ControlItem.Row = LRow) then
                  begin
                    GridPanelLayout.CellIndexToCell(I - Delta, LColumn, LRow);
                    if (LRow > 0) and (LRow + ControlItem.RowSpan > GridPanelLayout.RowCollection.Count) then
                    begin
                      Inc(Delta, (LRow + ControlItem.RowSpan) - GridPanelLayout.RowCollection.Count);
                      GridPanelLayout.CellIndexToCell(I - Delta, LColumn, LRow);
                    end;
                    NewLocations.AddNewLocation(ControlItem, LColumn, LRow, False);
                  end;
                end else if ControlItem <> Self then
                  Break
                else
                  NewLocations.AddNewLocation(ControlItem, LColumn, LRow, False);
              end;
            end;
            NewLocations.ApplyNewLocations;
            GridPanelLayout.RemoveEmptyAutoAddRows;
          end;
        end else
        begin
          NumRows := GridPanelLayout.RowCollection.Count;
          Delta := Value - FRowSpan;
          // first check if there is room down to expand and if so remove those
          // rows from the Delta
          for I := Min(FRow + FRowSpan, NumRows) to Min(FRow + Value - 1, NumRows - 1) do
            if Collection.Controls[FColumn, I] = nil then
              Dec(Delta)
            else
              Break;
          MoveBy := Delta;
          // Now find out how many rows to add, if any
          for I := NumRows - 1 downto NumRows - MoveBy do
            if Collection.Controls[FColumn, I] = nil then
              Dec(Delta)
            else
              Break;
          NumToAdd := Delta;
          // Add the rows
          if GridPanelLayout.ExpandStyle in [TExpandStyle.AddRows, TExpandStyle.FixedSize] then
          begin
            if (GridPanelLayout.ExpandStyle = TExpandStyle.FixedSize) and (NumToAdd > 0) then
              raise EGridLayoutException.Create(SCannotAddFixedSize);
            while NumToAdd > 0 do
            begin
              GridPanelLayout.AutoAddRow;
              Dec(NumToAdd);
            end;
            NumRows := GridPanelLayout.RowCollection.Count;
            for I := NumRows - 1 downto NumRows - Delta do
            begin
              ControlItem := Collection.ControlItems[FColumn, I - MoveBy];
              if (ControlItem <> nil) and (ControlItem <> Self) then
                NewLocations.AddNewLocation(ControlItem, FColumn, I, True);
            end;
            NewLocations.ApplyNewLocations;
          end else if (NumToAdd + MoveBy) > 0 then
          begin
            IndexDelta := Max(NumToAdd, Min(MoveBy, NumRows));
            for I := GridPanelLayout.RowSpanIndex[FColumn, FRow] to GridPanelLayout.CellCount - 1 do
            begin
              GridPanelLayout.CellIndexToCell(I, LColumn, LRow);
              ControlItem := Collection.ControlItems[LColumn, LRow];
              if (ControlItem <> nil) and (ControlItem.Column = LColumn) and (ControlItem.Row = LRow) then
              begin
                if ControlItem = Self then
                begin
                  Span := Value;
                  LColumn := FColumn;
                  LRow := FRow;
                end else
                begin
                  Span := ControlItem.RowSpan;
                  GridPanelLayout.CellIndexToCell(I + IndexDelta, LColumn, LRow);
                end;
                if LRow + Span > GridPanelLayout.RowCollection.Count then
                begin
                  if LRow > 0 then
                  begin
                    Inc(IndexDelta, GridPanelLayout.RowCollection.Count - LRow);
                    GridPanelLayout.CellIndexToCell(I + IndexDelta - NumToAdd, LColumn, LRow);
                  end else if ControlItem <> Self then
                  begin
                    Inc(IndexDelta, Min(Span, GridPanelLayout.RowCollection.Count));
                    GridPanelLayout.CellIndexToCell(I + IndexDelta, LColumn, LRow);
                  end else if (ControlItem = Self) and (LRow = 0) then
                    Exit;
                end;
                NumToAdd := 0;
                NewLocations.AddNewLocation(ControlItem, LColumn, LRow, True);
              end;
            end;
            for I := 0 to NewLocations.Count - 1 do
              if NewLocations.NewLocations[I].NewColumn > GridPanelLayout.ColumnCollection.Count - 1 then
                GridPanelLayout.AutoAddColumn;
            NewLocations.ApplyNewLocations;
          end;
          FRowSpan := Value;
        end;
        Changed(False);
      finally
        NewLocations.Free;
      end;
    finally
      GridPanelLayout.EndUpdate;
    end;
  end;
end;

procedure TGridPanelLayout.TControlItem.SetColumnSpan(Value: TCellSpan);
var
  I, Delta: Integer;
  Collection: TControlCollection;
  ControlItem: TControlItem;
  NumToAdd, NumColumns, MoveBy, LColumn, LRow, IndexDelta: Integer;
  Span: TCellSpan;
  NewLocations: TNewLocations;
begin
  if FColumnSpan <> Value then
  begin
    if Value < 1 then
      raise EGridLayoutException.CreateFmt(SInvalidSpan, [Value]);
    Collection := TControlCollection(GetOwner);
    if Collection = nil then Exit;
    GridPanelLayout.BeginUpdate;
    try
      NewLocations := TNewLocations.Create;
      try
        if FColumnSpan > Value then
        begin
          Delta := FColumnSpan - Value;
          FColumnSpan := Value;
          if GridPanelLayout.ExpandStyle in [TExpandStyle.AddColumns, TExpandStyle.FixedSize] then
          begin
            NumColumns := GridPanelLayout.ColumnCollection.Count;
            // Move the controls to the right back to fill in the space.
            for I := FColumn + FColumnSpan + Delta to NumColumns - 1 do
            begin
              ControlItem := Collection.ControlItems[I, FRow];
              if ControlItem <> nil then
                if ControlItem.Pushed then
                  NewLocations.AddNewLocation(ControlItem, I - Delta, FRow, False)
                else
                  Break;
            end;
            NewLocations.ApplyNewLocations;
            GridPanelLayout.RemoveEmptyAutoAddColumns;
          end else
          begin
            // Scan forward in column primary order, removing Delta from position of each
            // control item, unwrapping where nessesary, until the last control is reached
            // or a non "pushed" control is found.
            for I := GridPanelLayout.ColumnSpanIndex[FColumn, FRow] to GridPanelLayout.CellCount - 1 do
            begin
              GridPanelLayout.CellIndexToCell(I, LColumn, LRow);
              ControlItem := Collection.ControlItems[LColumn, LRow];
              if ControlItem <> nil then
              begin
                if ControlItem.Pushed then
                begin
                  if (ControlItem.Column = LColumn) and (ControlItem.Row = LRow) then
                  begin
                    GridPanelLayout.CellIndexToCell(I - Delta, LColumn, LRow);
                    if (LColumn > 0) and (LColumn + ControlItem.ColumnSpan > GridPanelLayout.ColumnCollection.Count) then
                    begin
                      Inc(Delta, (LColumn + ControlItem.ColumnSpan) - GridPanelLayout.ColumnCollection.Count);
                      GridPanelLayout.CellIndexToCell(I - Delta, LColumn, LRow);
                    end;
                    NewLocations.AddNewLocation(ControlItem, LColumn, LRow, False);
                  end;
                end else if ControlItem <> Self then
                  Break
                else
                  NewLocations.AddNewLocation(ControlItem, LColumn, LRow, False);
              end;
            end;
            NewLocations.ApplyNewLocations;
            GridPanelLayout.RemoveEmptyAutoAddRows;
          end;
        end else
        begin
          NumColumns := GridPanelLayout.ColumnCollection.Count;
          Delta := Value - FColumnSpan;
          // first check if there is room to the right to expand and if so remove those
          // columns from the Delta
          for I := Min(FColumn + FColumnSpan, NumColumns) to Min(FColumn + Value - 1, NumColumns - 1) do
            if Collection.Controls[I, FRow] = nil then
              Dec(Delta)
            else
              Break;
          MoveBy := Delta;
          // Now find out how many columns to add, if any
          for I := NumColumns - 1 downto NumColumns - MoveBy do
            if Collection.Controls[I, FRow] = nil then
              Dec(Delta)
            else
              Break;
          NumToAdd := Delta;
          // Add the columns
          if GridPanelLayout.ExpandStyle in [TExpandStyle.AddColumns, TExpandStyle.FixedSize] then
          begin
            if (GridPanelLayout.ExpandStyle = TExpandStyle.FixedSize) and (NumToAdd > 0) then
              raise EGridLayoutException.Create(sCannotAddFixedSize);
            while NumToAdd > 0 do
            begin
              GridPanelLayout.AutoAddColumn;
              Dec(NumToAdd);
            end;
            NumColumns := GridPanelLayout.ColumnCollection.Count;
            for I := NumColumns - 1 downto NumColumns - Delta do
            begin
              ControlItem := Collection.ControlItems[I - MoveBy, FRow];
              if (ControlItem <> nil) and (ControlItem <> Self) then
                NewLocations.AddNewLocation(ControlItem, I, FRow, True);
            end;
            NewLocations.ApplyNewLocations;
          end else if (NumToAdd + MoveBy) > 0 then
          begin
            IndexDelta := Max(NumToAdd, Min(MoveBy, NumColumns));
            for I := GridPanelLayout.ColumnSpanIndex[FColumn, FRow] to GridPanelLayout.CellCount - 1 do
            begin
              GridPanelLayout.CellIndexToCell(I, LColumn, LRow);
              ControlItem := Collection.ControlItems[LColumn, LRow];
              if (ControlItem <> nil) and (ControlItem.Column = LColumn) and (ControlItem.Row = LRow) then
              begin
                if ControlItem = Self then
                begin
                  Span := Value;
                  LColumn := FColumn;
                  LRow := FRow;
                end else
                begin
                  Span := ControlItem.ColumnSpan;
                  GridPanelLayout.CellIndexToCell(I + IndexDelta, LColumn, LRow);
                end;
                if LColumn + Span > GridPanelLayout.ColumnCollection.Count then
                begin
                  if LColumn > 0 then
                  begin
                    Inc(IndexDelta, GridPanelLayout.ColumnCollection.Count - LColumn);
                    GridPanelLayout.CellIndexToCell(I + IndexDelta - NumToAdd, LColumn, LRow);
                  end else if ControlItem <> Self then
                  begin
                    Inc(IndexDelta, Min(Span, GridPanelLayout.ColumnCollection.Count));
                    GridPanelLayout.CellIndexToCell(I + IndexDelta, LColumn, LRow);
                  end else if (ControlItem = Self) and (LColumn = 0) then
                    Exit;
                end;
                NumToAdd := 0;
                NewLocations.AddNewLocation(ControlItem, LColumn, LRow, True);
              end;
            end;
            for I := 0 to NewLocations.Count - 1 do
              if NewLocations.NewLocations[I].NewRow > GridPanelLayout.RowCollection.Count - 1 then
                GridPanelLayout.AutoAddRow;
            NewLocations.ApplyNewLocations;
          end;
          FColumnSpan := Value;
        end;
        Changed(False);
      finally
        NewLocations.Free;
      end;
    finally
      GridPanelLayout.EndUpdate;
    end;
  end;
end;

procedure TGridPanelLayout.TControlItem.InternalSetLocation(AColumn, ARow: Integer; APushed, MoveExisting: Boolean);
var
  Collection: TControlCollection;
  CurrentItem: TControlItem;
begin
  if (AColumn <> FColumn) or (ARow <> FRow) then
  begin
    if MoveExisting then
    begin
      Collection := TControlCollection(GetOwner);
      if Collection <> nil then
        CurrentItem := Collection.ControlItems[AColumn, ARow]
      else
        CurrentItem := nil;
      if CurrentItem <> nil then
        CurrentItem.InternalSetLocation(FColumn, FRow, False, False);
    end;
    FColumn := AColumn;
    FRow := ARow;
    if APushed then
      Inc(FPushed)
    else if FPushed > 0 then
      Dec(FPushed);
    Changed(False);
  end;
end;

procedure TGridPanelLayout.TControlItem.SetLocation(AColumn, ARow: Integer; APushed: Boolean);
begin
  InternalSetLocation(AColumn, ARow, APushed, True);
end;

function TGridPanelLayout.TControlItem.GetPushed: Boolean;
begin
  Result := FPushed > 0;
end;

procedure TGridPanelLayout.DoAddObject(const AObject: TFmxObject);
begin
  inherited;
  if AObject is TControl
    and (not (csLoading in ComponentState))
      {$IFDEF MSWINDOWS}
      and not ((csDesigning in ComponentState)
        and Supports(AObject, IDesignerControl))
      {$ENDIF}
    then
    begin
      TControl(AObject).Anchors := [];
      FControlCollection.AddControl(TControl(AObject));
    end;
  Realign;
end;

procedure TGridPanelLayout.DoPaint;
var
  I: Integer;
  Size: Single;
  LinePos, RealLinePos: Single;
begin
  inherited;
  if csDesigning in ComponentState then
  begin
    if not Locked then
      DrawDesignBorder;
    Canvas.Fill.Kind := TBrushKind.None;
    Canvas.Stroke.Kind := TBrushKind.Solid;
    Canvas.StrokeDash := TStrokeDash.Dash;
    Canvas.Stroke.Color := DesignBorderColor;
    LinePos := 0;
    for I := 0 to FColumnCollection.Count - 2 do
    begin
      Size := FColumnCollection[I].Size;
      LinePos := LinePos + Size;
      if Size > 0 then
      begin
        RealLinePos := Floor(LinePos) + 0.5;
        Canvas.DrawLine(TPointF.Create(RealLinePos, LocalRect.Top),
          TPointF.Create(RealLinePos, LocalRect.Bottom), AbsoluteOpacity * DefaultDisabledOpacity);
      end;
    end;
    LinePos := 0;
    for I := 0 to FRowCollection.Count - 2 do
    begin
      Size := FRowCollection[I].Size;
      LinePos := LinePos + Size;
      if Size > 0 then
      begin
        RealLinePos := Floor(LinePos) + 0.5;
        Canvas.DrawLine(TPointF.Create(LocalRect.Left, RealLinePos),
          TPointF.Create(LocalRect.Right, RealLinePos), AbsoluteOpacity * DefaultDisabledOpacity);
      end;
    end;
  end;
end;

procedure TGridPanelLayout.DoRemoveObject(const AObject: TFmxObject);
begin
  if AObject is TControl then
    FControlCollection.RemoveControl(TControl(AObject));
  inherited;
  Realign;
end;

function TGridPanelLayout.GetCellCount: Integer;
begin
  Result := FRowCollection.Count * FColumnCollection.Count;
end;

function TGridPanelLayout.GetCellRect(AColumn, ARow: Integer): TRectF;
var
  I: Integer;
begin
  Result.Left := 0;
  Result.Top := 0;
  for I := 0 to AColumn - 1 do
    Result.Left := Result.Left + FColumnCollection[I].Size;
  for I := 0 to ARow - 1 do
    Result.Top := Result.Top + FRowCollection[I].Size;
  Result.BottomRight := CellSize[AColumn, ARow];

  Result.Bottom := Result.Bottom + Result.Top;
  Result.Right := Result.Right + Result.Left;
end;

function TGridPanelLayout.GetCellSizes(AColumn, ARow: Integer): TPointF;
begin
  Result := TPointF.Create(FColumnCollection[AColumn].Size, FRowCollection[ARow].Size);
end;

function TGridPanelLayout.GetColumnSpanIndex(AColumn, ARow: Integer): Integer;
begin
  Result := AColumn + (ARow * FColumnCollection.Count);
end;

function TGridPanelLayout.GetRowSpanIndex(AColumn, ARow: Integer): Integer;
begin
  Result := ARow + (AColumn * FRowCollection.Count);
end;

function TGridPanelLayout.IsColumnEmpty(AColumn: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if (AColumn > -1) and (AColumn < FColumnCollection.Count) then
  begin
    for I := 0 to FRowCollection.Count -1 do
      if ControlCollection.Controls[AColumn, I] <> nil then
        Exit;
    Result := True;
  end else
    raise EGridLayoutException.CreateFmt(SInvalidColumnIndex, [AColumn]);
end;

function TGridPanelLayout.IsRowEmpty(ARow: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if (ARow > -1) and (ARow < FRowCollection.Count) then
  begin
    for I := 0 to FColumnCollection.Count -1 do
      if ControlCollection.Controls[I, ARow] <> nil then
        Exit;
    Result := True;
  end else
    raise EGridLayoutException.CreateFmt(SInvalidRowIndex, [ARow]);
end;

procedure TGridPanelLayout.RemoveEmptyAutoAddColumns;
var
  I: Integer;
begin
  for I := FColumnCollection.Count - 1 downto 0 do
    if FColumnCollection[I].AutoAdded and IsColumnEmpty(I) then
      FColumnCollection.Delete(I)
    else
      Exit;
end;

procedure TGridPanelLayout.RemoveEmptyAutoAddRows;
var
  I: Integer;
begin
  for I := FRowCollection.Count - 1 downto 0 do
    if FRowCollection[I].AutoAdded and IsRowEmpty(I) then
      FRowCollection.Delete(I)
    else
      Exit;
end;

procedure TGridPanelLayout.Resize;
begin
  FRecalcCellSizes := True;
  if (csDesigning in ComponentState) and (ControlsCount = 0) then
  begin
    FNeedAlign := True;
    Realign;
  end;
  inherited;
end;

function TGridPanelLayout.AutoAddColumn: TColumnItem;
begin
  Result := FColumnCollection.Add;
  Result.SizeStyle := TSizeStyle.Auto;
  Result.AutoAdded := True;
end;

function TGridPanelLayout.AutoAddRow: TRowItem;
begin
  Result := FRowCollection.Add;
  Result.SizeStyle := TSizeStyle.Auto;
  Result.AutoAdded := True;
end;

procedure TGridPanelLayout.CellIndexToCell(AIndex: Integer; var AColumn,
  ARow: Integer);
begin
  if FExpandStyle in [TExpandStyle.AddColumns, TExpandStyle.FixedSize] then
  begin
    AColumn := AIndex div FRowCollection.Count;
    ARow := AIndex mod FRowCollection.Count;
  end else
  begin
    ARow := AIndex div FColumnCollection.Count;
    AColumn := AIndex mod FColumnCollection.Count;
  end;
end;

function TGridPanelLayout.CellToCellIndex(AColumn, ARow: Integer): Integer;
begin
  if FExpandStyle in [TExpandStyle.AddColumns, TExpandStyle.FixedSize] then
    Result := ColumnSpanIndex[AColumn, ARow]
  else
    Result := RowSpanIndex[AColumn, ARow];
end;

constructor TGridPanelLayout.Create(AOwner: TComponent);
begin
  inherited;
  FRowCollection := TRowCollection.Create(Self);
  FColumnCollection := TColumnCollection.Create(Self);
  FControlCollection := TControlCollection.Create(Self);
  FRowCollection.BeginUpdate;
  try
    FRowCollection.Add;
    FRowCollection.Add;
  finally
    FRowCollection.EndUpdate;
  end;
  FColumnCollection.BeginUpdate;
  try
    FColumnCollection.Add;
    FColumnCollection.Add;
  finally
    FColumnCollection.EndUpdate;
  end;
end;

destructor TGridPanelLayout.Destroy;
begin
  FRowCollection.Free;
  FColumnCollection.Free;
  FControlCollection.Free;
  inherited;
end;

procedure TGridPanelLayout.RecalcCellDimensions(const Rect: TRectF);
var
  I, J: Integer;
  LSize, XSize, YSize, RemainingX, RemainingY: Single;
  MaxSize, PercentXCount, PercentYCount: Single;
  PercentX, PercentY: Double;
  ControlItem: TControlItem;
  Control: TControl;
begin
  // Subtract the size of absolute size columns and rows and also calculate the total size of
  // the percentage rows and columns
  // Also subtract the width of the widest control in each autosize column
  // or the tallest control in each autosize row and set the column or row size to that value
  XSize := Rect.Right - Rect.Left;
  YSize := Rect.Bottom - Rect.Top;
  PercentX := 0.0;
  PercentY := 0.0;

  PercentXCount := 0;
  for I := 0 to FColumnCollection.Count - 1 do
    if FColumnCollection[I].SizeStyle = TSizeStyle.Absolute then
      XSize := XSize - FColumnCollection[I].Value
    else if FColumnCollection[I].SizeStyle = TSizeStyle.Percent then
    begin
      PercentX := PercentX + FColumnCollection[I].Value;
      PercentXCount := PercentXCount + 1;
    end
    else
    begin
      MaxSize := 0;
      for J := 0 to FRowCollection.Count - 1 do
      begin
        ControlItem := FControlCollection.ControlItems[I, J];
        if (ControlItem <> nil) and (ControlItem.Control <> nil) and
           (ControlItem.Column = I) and (ControlItem.Row = J) then
        begin
          Control := ControlItem.Control;
          LSize := Control.Width + Control.Margins.Left + Control.Margins.Right + Self.Padding.Left + Self.Padding.Right;
          if LSize > MaxSize then
            MaxSize := LSize;
        end;
      end;
      XSize := XSize - MaxSize;
      FColumnCollection[I].Size := MaxSize;
    end;

  PercentYCount := 0;
  for I := 0 to FRowCollection.Count - 1 do
    if FRowCollection[I].SizeStyle = TSizeStyle.Absolute then
      YSize := YSize - FRowCollection[I].Value
    else if FRowCollection[I].SizeStyle = TSizeStyle.Percent then
    begin
      PercentY := PercentY + FRowCollection[I].Value;
      PercentYCount := PercentYCount + 1;
    end else
    begin
      MaxSize := 0;
      for J := 0 to FColumnCollection.Count - 1 do
      begin
        ControlItem := FControlCollection.ControlItems[J, I];
        if (ControlItem <> nil) and (ControlItem.Control <> nil) and
           (ControlItem.Column = J) and (ControlItem.Row = I) then
        begin
          Control := ControlItem.Control;
          LSize := Control.Height + Control.Margins.Left + Control.Margins.Right + Self.Padding.Top + Self.Padding.Bottom;
          if LSize > MaxSize then
            MaxSize := LSize;
        end;
      end;
      YSize := YSize - MaxSize;
      FRowCollection[I].Size := MaxSize;
    end;

  // Finally Calculate the size of the percentage-based columns and rows based on the remaining
  // X and Y sizes
  RemainingX := XSize;
  RemainingY := YSize;
  for I := 0 to FColumnCollection.Count - 1 do
    if FColumnCollection[I].SizeStyle = TSizeStyle.Percent then
    begin
      if IsZero(PercentX) then
        FColumnCollection[I].Value := 100.0 / PercentXCount
      else
        FColumnCollection[I].Value := (FColumnCollection[I].Value / PercentX) * 100.0;
      FColumnCollection[I].Size := XSize * (FColumnCollection[I].Value / 100.0);
      RemainingX := RemainingX - FColumnCollection[I].Size;
      if (RemainingX > 0) and (I = FColumnCollection.Count - 1) then
        FColumnCollection[I].Size := FColumnCollection[I].Size + RemainingX;
    end;

  for I := 0 to FRowCollection.Count - 1 do
    if FRowCollection[I].SizeStyle = TSizeStyle.Percent then
    begin
      if IsZero(PercentY) then
        FRowCollection[I].Value := 100.0 / PercentYCount
      else
        FRowCollection[I].Value := (FRowCollection[I].Value / PercentY) * 100.0;
      FRowCollection[I].Size := YSize * (FRowCollection[I].Value / 100.0);
      RemainingY := RemainingY - FRowCollection[I].Size;
      if (RemainingY > 0) and (I = FRowCollection.Count - 1) then
        FRowCollection[I].Size := FRowCollection[I].Size + RemainingY;
    end;
  FRecalcCellSizes := False;
end;


procedure TGridPanelLayout.DoRealign;

  procedure ArrangeControlInCell(AControl: TControl; CellRect: TRectF);
  var
    NewBounds: TRectF;
    AnchorSubset: TAnchors;
  begin
    if AControl.Align <> TAlignLayout.None then
      ArrangeControl(AControl, AControl.Align,
        CellRect.Width, CellRect.Height,
        CellRect.Width, CellRect.Height,
        CellRect)
    else
    begin
      AnchorSubset := AControl.Anchors * [TAnchorKind.akLeft, TAnchorKind.akRight];
      if AnchorSubset = [TAnchorKind.akLeft] then
        NewBounds.Left := CellRect.Left
      else if AnchorSubset = [TAnchorKind.akRight] then
        NewBounds.Left := Max(CellRect.Left, CellRect.Right - AControl.Width) (* was: Margins.ExplicitWidth *)
      else
        NewBounds.Left := Max(CellRect.Left, CellRect.Left + ((CellRect.Right - CellRect.Left) - AControl.Width (* was: Margins.ControlWidth *)) / 2);
      NewBounds.Right := NewBounds.Left + Min(CellRect.Right - CellRect.Left, AControl.Width); (* was: Margins.ExplicitWidth *)
      AnchorSubset := AControl.Anchors * [TAnchorKind.akTop, TAnchorKind.akBottom];
      if AnchorSubset = [TAnchorKind.akTop] then
        NewBounds.Top := CellRect.Top
      else if AnchorSubset = [TAnchorKind.akBottom] then
        NewBounds.Top := Max(CellRect.Top, CellRect.Bottom - AControl.Height) (* was: Margins.ExplicitHeight *)
      else
        NewBounds.Top := Max(CellRect.Top, CellRect.Top + ((CellRect.Bottom - CellRect.Top) - AControl.Height) / 2); (* was: Margins.ControlHeight *)
      NewBounds.Bottom := NewBounds.Top + Min(CellRect.Bottom - CellRect.Top, AControl.Height); (* was: Margins.ExplicitHeight *)
      AControl.BoundsRect := NewBounds;
    end;
  end;

  procedure AdjustCellRect(var Rect: TRectF);
  begin
    Rect.Left := Rect.Left + Padding.Left;
    Rect.Top := Rect.Top + Padding.Top;
    Rect.Right := Rect.Right - Padding.Right;
    Rect.Bottom := Rect.Bottom - Padding.Bottom;
  end;

  procedure ArrangeControls;
  var
    I, J, K: Integer;
    CellRect: TRectF;
    SpanRect: TRectF;
    ControlItem: TControlItem;
  begin
    CellRect.Top := LocalRect.Top;
    for J := 0 to FRowCollection.Count - 1 do
    begin
      CellRect.Left := LocalRect.Left;
      CellRect.Bottom := CellRect.Top + FRowCollection[J].Size;
      for I := 0 to FColumnCollection.Count - 1 do
      begin
        ControlItem := FControlCollection.ControlItems[I, J];
        CellRect.Right := CellRect.Left + FColumnCollection[I].Size;
        if (ControlItem <> nil) and (ControlItem.Control <> nil) and
           (ControlItem.Column = I) and (ControlItem.Row = J) then
        begin
          SpanRect := CellRect;
          if ControlItem.ColumnSpan > 1 then
            for K := I + 1 to Min(I + ControlItem.ColumnSpan - 1, FColumnCollection.Count - 1) do
              SpanRect.Right := SpanRect.Right + FColumnCollection[K].Size;
          if ControlItem.RowSpan > 1 then
            for K := J + 1 to Min(J + ControlItem.RowSpan - 1, FRowCollection.Count - 1 ) do
              SpanRect.Bottom := SpanRect.Bottom + FRowCollection[K].Size;
          AdjustCellRect(SpanRect);
          ArrangeControlInCell(ControlItem.Control, SpanRect);
        end;
        CellRect.Left := CellRect.Right;
      end;
      CellRect.Top := CellRect.Bottom;
    end;
  end;

begin
  if not FNeedAlign then
    Exit;

  FDisableAlign := True;
  if FRecalcCellSizes then
    RecalcCellDimensions(LocalRect);
  if ControlsCount > 0 then
    ArrangeControls
  else if csDesigning in ComponentState then
    Repaint;
  FDisableAlign := False;
end;


procedure TGridPanelLayout.SetColumnCollection(const Value: TColumnCollection);
begin
  FColumnCollection.Assign(Value);
end;

procedure TGridPanelLayout.SetControlCollection(const Value: TControlCollection);
begin
  FControlCollection.Assign(Value);
end;

procedure TGridPanelLayout.SetRowCollection(const Value: TRowCollection);
begin
  FRowCollection.Assign(Value);
end;

procedure TGridPanelLayout.UpdateControlsColumn(AColumn: Integer);
var
  I, J: Integer;
  AControlItem: TControlItem;
begin
  for I := AColumn + 1 to FColumnCollection.Count - 1 do
    for J := 0 to FRowCollection.Count - 1 do
    begin
      AControlItem := FControlCollection.ControlItems[I, J];
      if (AControlItem <> nil) and (AControlItem.Column = I) and
         (AControlItem.Row = J) then
        AControlItem.SetColumn(AControlItem.Column - 1);
    end;
end;

procedure TGridPanelLayout.UpdateControlsRow(ARow: Integer);
var
  I, J: Integer;
  AControlItem: TControlItem;
begin
  for I := 0 to FColumnCollection.Count - 1 do
    for J := ARow + 1 to FRowCollection.Count - 1 do
    begin
      AControlItem := FControlCollection.ControlItems[I, J];
      if (AControlItem <> nil) and (AControlItem.Column = I) and
         (AControlItem.Row = J) then
        AControlItem.SetRow(AControlItem.Row - 1);
    end;
end;

procedure RegisterAliases;
begin
  AddEnumElementAliases(TypeInfo(TGridPanelLayout.TSizeStyle), ['ssAbsolute', 'ssPercent', 'ssAuto']);
  AddEnumElementAliases(TypeInfo(TGridPanelLayout.TExpandStyle), ['emAddRows', 'emAddColumns', 'emFixedSize']);
  AddEnumElementAliases(TypeInfo(TFlowJustify), ['fjLeft', 'fjRight', 'fjCenter', 'fjJustify']);
  AddEnumElementAliases(TypeInfo(TFlowDirection), ['fdLeftToRight', 'fdRightToLeft']);
end;

procedure UnregisterAliases;
begin
  RemoveEnumElementAliases(TypeInfo(TGridPanelLayout.TSizeStyle));
  RemoveEnumElementAliases(TypeInfo(TGridPanelLayout.TExpandStyle));
  RemoveEnumElementAliases(TypeInfo(TFlowJustify));
  RemoveEnumElementAliases(TypeInfo(TFlowDirection));
end;

initialization
  RegisterAliases;
  RegisterFmxClasses([TLayout, TScaledLayout, TGridLayout, TGridPanelLayout,
    TFlowLayout, TFlowLayoutBreak, TScrollBox, TVertScrollBox, THorzScrollBox,
    TFramedScrollBox, TFramedVertScrollBox]);
finalization
  UnregisterAliases;
end.
