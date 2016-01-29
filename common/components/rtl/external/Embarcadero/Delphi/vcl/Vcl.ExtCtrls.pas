{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.ExtCtrls;

{$S-,W-,R-,H+,X+}

{$HPPEMIT '#ifndef _WIN64'}
{$HPPEMIT '#pragma link "dwmapi.lib"'}
{$HPPEMIT '#endif //_WIN64'}

interface

uses 
{$IF DEFINED(CLR)}
  System.ComponentModel.Design.Serialization,
{$ENDIF}
  Winapi.Messages, Winapi.Windows, System.SysUtils, System.Classes, System.Contnrs, System.Types, System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Menus, Vcl.Graphics, Vcl.StdCtrls, Vcl.GraphUtil, Vcl.ImgList, Vcl.Themes, Winapi.ShellAPI;

type
  TShapeType = (stRectangle, stSquare, stRoundRect, stRoundSquare,
    stEllipse, stCircle);

  TShape = class(TGraphicControl)
  private
    FPen: TPen;
    FBrush: TBrush;
    FShape: TShapeType;
    procedure SetBrush(Value: TBrush);
    procedure SetPen(Value: TPen);
    procedure SetShape(Value: TShapeType);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    procedure StyleChanged(Sender: TObject);
    property Align;
    property Anchors;
    property Brush: TBrush read FBrush write SetBrush;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Constraints;
    property ParentShowHint;
    property Pen: TPen read FPen write SetPen;
    property Shape: TShapeType read FShape write SetShape default stRectangle;
    property ShowHint;
    property Touch;
    property Visible;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnGesture;
    property OnStartDock;
    property OnStartDrag;
  end;

  TPaintBox = class(TGraphicControl)
  private
    FOnPaint: TNotifyEvent;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Canvas;
  published
    property Align;
    property Anchors;
    property Color;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Touch;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnGesture;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
    property OnStartDock;
    property OnStartDrag;
  end;

  TImage = class(TGraphicControl)
  private
    FPicture: TPicture;
    FOnProgress: TProgressEvent;
    FStretch: Boolean;
    FCenter: Boolean;
    FIncrementalDisplay: Boolean;
    FTransparent: Boolean;
    FDrawing: Boolean;
    FProportional: Boolean;    
    function GetCanvas: TCanvas;
    procedure PictureChanged(Sender: TObject);
    procedure SetCenter(Value: Boolean);
    procedure SetPicture(Value: TPicture);
    procedure SetStretch(Value: Boolean);
    procedure SetTransparent(Value: Boolean);
    procedure SetProportional(Value: Boolean);
  protected
    function CanObserve(const ID: Integer): Boolean; override;
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    function DestRect: TRect;
    function DoPaletteChange: Boolean;
    function GetPalette: HPALETTE; override;
    procedure Paint; override;
    procedure Progress(Sender: TObject; Stage: TProgressStage;
      PercentDone: Byte; RedrawNow: Boolean; const R: TRect; const Msg: string); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas: TCanvas read GetCanvas;
  published
    property Align;
    property Anchors;
    property AutoSize;
    property Center: Boolean read FCenter write SetCenter default False;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property IncrementalDisplay: Boolean read FIncrementalDisplay write FIncrementalDisplay default False;
    property ParentShowHint;
    property Picture: TPicture read FPicture write SetPicture;
    property PopupMenu;
    property Proportional: Boolean read FProportional write SetProportional default false;
    property ShowHint;
    property Stretch: Boolean read FStretch write SetStretch default False;
    property Touch;
    property Transparent: Boolean read FTransparent write SetTransparent default False;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnGesture;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
    property OnStartDock;
    property OnStartDrag;
  end;

  TBevelStyle = (bsLowered, bsRaised);
  TBevelShape = (bsBox, bsFrame, bsTopLine, bsBottomLine, bsLeftLine,
    bsRightLine, bsSpacer);

  TBevel = class(TGraphicControl)
  private
    FStyle: TBevelStyle;
    FShape: TBevelShape;
    procedure SetStyle(Value: TBevelStyle);
    procedure SetShape(Value: TBevelShape);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property Anchors;
    property Constraints;
    property ParentShowHint;
    property Shape: TBevelShape read FShape write SetShape default bsBox;
    property ShowHint;
    property Style: TBevelStyle read FStyle write SetStyle default bsLowered;
    property Touch;
    property Visible;
    property OnGesture;
  end;

  [RootDesignerSerializerAttribute('', '', False)]
  TTimer = class(TComponent)
  private
    FInterval: Cardinal;
    FWindowHandle: HWND;
    FOnTimer: TNotifyEvent;
    FEnabled: Boolean;
    procedure UpdateTimer;
    procedure SetEnabled(Value: Boolean);
    procedure SetInterval(Value: Cardinal);
    procedure SetOnTimer(Value: TNotifyEvent);
    procedure WndProc(var Msg: TMessage);
  protected
    procedure Timer; dynamic;
{$IF DEFINED(CLR)}
  strict protected
    procedure Finalize; override;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Interval: Cardinal read FInterval write SetInterval default 1000;
    property OnTimer: TNotifyEvent read FOnTimer write SetOnTimer;
  end;

  TPanelBevel = TBevelCut;

  TCustomPanel = class(TCustomControl)
  private
    FAlignment: TAlignment;
    FAutoSizeDocking: Boolean;
    FBevelInner: TPanelBevel;
    FBevelOuter: TPanelBevel;
    FBevelWidth: TBevelWidth;
    FBorderWidth: TBorderWidth;
    FBorderStyle: TBorderStyle;
    FFullRepaint: Boolean;
    FLocked: Boolean;
    FParentBackgroundSet: Boolean;
    FShowCaption: Boolean;
    FVerticalAlignment: TVerticalAlignment;
    procedure CMBorderChanged(var Message: TMessage); message CM_BORDERCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMIsToolControl(var Message: TMessage); message CM_ISTOOLCONTROL;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure SetAlignment(Value: TAlignment);
    procedure SetBevelInner(Value: TPanelBevel);
    procedure SetBevelOuter(Value: TPanelBevel);
    procedure SetBevelWidth(Value: TBevelWidth);
    procedure SetBorderWidth(Value: TBorderWidth);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetShowCaption(Value: Boolean);
    procedure SetVerticalAlignment(const Value: TVerticalAlignment);
{$IF NOT DEFINED(CLR)}
    procedure CMDockClient(var Message: TCMDockClient); message CM_DOCKCLIENT;
{$ENDIF}
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure AdjustClientRect(var Rect: TRect); override;
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure Paint; override;
    procedure UpdateStyleElements; override;
    property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
    property BevelInner: TPanelBevel read FBevelInner write SetBevelInner default bvNone;
    property BevelOuter: TPanelBevel read FBevelOuter write SetBevelOuter default bvRaised;
    property BevelWidth: TBevelWidth read FBevelWidth write SetBevelWidth default 1;
    property BorderWidth: TBorderWidth read FBorderWidth write SetBorderWidth default 0;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsNone;
    property Color default clBtnFace;
    property FullRepaint: Boolean read FFullRepaint write FFullRepaint default True;
    property Locked: Boolean read FLocked write FLocked default False;
    property ParentColor default False;
    property ShowCaption: Boolean read FShowCaption write SetShowCaption default True;
    property VerticalAlignment: TVerticalAlignment read FVerticalAlignment write SetVerticalAlignment default taVerticalCenter;
    procedure SetParentBackground(Value: Boolean); override;
{$IF DEFINED(CLR)}
    function DockClient(DockSource: TDragDockObject; MousePos: TPoint): Integer; override;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    function GetControlsAlignment: TAlignment; override;
    property ParentBackground stored FParentBackgroundSet default True;
  end;

  TPanel = class(TCustomPanel)
  public
    property DockManager;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
    property Locked;
    property Padding;
    property ParentBiDiMode;
    property ParentBackground;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowCaption;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property VerticalAlignment;
    property Visible;
    property StyleElements;
    property OnAlignInsertBefore;
    property OnAlignPosition;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnGetSiteInfo;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  TFlowStyle = (fsLeftRightTopBottom, fsRightLeftTopBottom, fsLeftRightBottomTop, fsRightLeftBottomTop,
                fsTopBottomLeftRight, fsBottomTopLeftRight, fsTopBottomRightLeft, fsBottomTopRightLeft);

  TCustomFlowPanel = class(TCustomPanel)
  private
    FControlList: TObjectList;
    FAutoWrap: Boolean;
    FFlowStyle: TFlowStyle;
    procedure SetAutoWrap(Value: Boolean);
    procedure SetFlowStyle(Value: TFlowStyle);
{$IF NOT DEFINED(CLR)}
    procedure CMControlListChanging(var Message: TCMControlListChanging); message CM_CONTROLLISTCHANGING;
{$ENDIF}
  protected
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
{$IF DEFINED(CLR)}
    procedure ControlListChanging(Inserting: Boolean; Child: TControl; AParent: TWinControl); override;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function GetControlIndex(AControl: TControl): Integer;
    procedure SetControlIndex(AControl: TControl; Index: Integer);
    property AutoWrap: Boolean read FAutoWrap write SetAutoWrap default True;
    property FlowStyle: TFlowStyle read FFlowStyle write SetFlowStyle default fsLeftRightTopBottom;
  end;

  TFlowPanel = class(TCustomFlowPanel)
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property AutoWrap;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FlowStyle;
    property FullRepaint;
    property Font;
    property Locked;
    property Padding;
    property ParentBiDiMode;
    property ParentBackground;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowCaption;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property VerticalAlignment;
    property Visible;
    property StyleElements;
    property OnAlignInsertBefore;
    property OnAlignPosition;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnGetSiteInfo;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  TSizeStyle = (ssAbsolute, ssPercent, ssAuto);

  TCustomGridPanel = class;
  EGridPanelException = class(Exception);

  TCellItem = class(TCollectionItem)
  private
    FSizeStyle: TSizeStyle;
    FValue: Double;
    FSize: Integer;
    FAutoAdded: Boolean;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure SetSizeStyle(Value: TSizeStyle);
    procedure SetValue(Value: Double);
    property Size: Integer read FSize write FSize;
    property AutoAdded: Boolean read FAutoAdded write FAutoAdded;
  public
    constructor Create(Collection: TCollection); override;
  published
    property SizeStyle: TSizeStyle read FSizeStyle write SetSizeStyle default ssPercent;
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
    function Owner: TCustomGridPanel;
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
    FControl: TControl;
    FColumn, FRow: Integer;
    FColumnSpan, FRowSpan: TCellSpan;
    FPushed: Integer;
    function GetGridPanel: TCustomGridPanel;
    function GetPushed: Boolean;
    procedure SetColumn(Value: Integer);
    procedure SetColumnSpan(Value: TCellSpan);
    procedure SetControl(Value: TControl);
    procedure SetRow(Value: Integer);
    procedure SetRowSpan(Value: TCellSpan);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure InternalSetLocation(AColumn, ARow: Integer; APushed: Boolean; MoveExisting: Boolean);
    property GridPanel: TCustomGridPanel read GetGridPanel;
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
    function Owner: TCustomGridPanel;
    property Controls[AColumn, ARow: Integer]: TControl read GetControl write SetControl;
    property ControlItems[AColumn, ARow: Integer] : TControlItem read GetControlItem;
    property Items[Index: Integer]: TControlItem read GetItem write SetItem; default;
  end;

  TExpandStyle = (emAddRows, emAddColumns, emFixedSize);

  TCustomGridPanel = class(TCustomPanel)
  private
    FRowCollection: TRowCollection;
    FColumnCollection: TColumnCollection;
    FControlCollection: TControlCollection;
    FRecalcCellSizes: Boolean;
    FExpandStyle: TExpandStyle;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    function GetCellCount: Integer;
    function GetCellSizes(AColumn, ARow: Integer): TPoint;
    function GetCellRect(AColumn, ARow: Integer): TRect;
    function GetColumnSpanIndex(AColumn, ARow: Integer): Integer;
    function GetRowSpanIndex(AColumn, ARow: Integer): Integer;
    procedure SetColumnCollection(const Value: TColumnCollection);
    procedure SetControlCollection(const Value: TControlCollection);
    procedure SetRowCollection(const Value: TRowCollection);
    procedure RecalcCellDimensions(const Rect: TRect);
{$IF NOT DEFINED(CLR)}
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
{$ENDIF}
  protected
    function AutoAddColumn: TColumnItem;
    function AutoAddRow: TRowItem;
    function CellToCellIndex(AColumn, ARow: Integer): Integer;
    procedure CellIndexToCell(AIndex: Integer; var AColumn, ARow: Integer);
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure Loaded; override;
    procedure Paint; override;
    procedure RemoveEmptyAutoAddColumns;
    procedure RemoveEmptyAutoAddRows;
    procedure UpdateControlOriginalParentSize(AControl: TControl; var AOriginalParentSize: TPoint); override;
{$IF DEFINED(CLR)}
    procedure ControlChange(Inserting: Boolean; Child: TControl); override;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function IsColumnEmpty(AColumn: Integer): Boolean;
    function IsRowEmpty(ARow: Integer): Boolean;
    procedure UpdateControlsColumn(AColumn: Integer);
    procedure UpdateControlsRow(ARow: Integer);
    property ColumnSpanIndex[AColumn, ARow: Integer]: Integer read GetColumnSpanIndex;
    property CellCount: Integer read GetCellCount;
    property CellSize[AColumn, ARow: Integer]: TPoint read GetCellSizes;
    property CellRect[AColumn, ARow: Integer]: TRect read GetCellRect;
    property ColumnCollection: TColumnCollection read FColumnCollection write SetColumnCollection;
    property ControlCollection: TControlCollection read FControlCollection write SetControlCollection;
    property ExpandStyle: TExpandStyle read FExpandStyle write FExpandStyle default emAddRows;
    property RowCollection: TRowCollection read FRowCollection write SetRowCollection;
    property RowSpanIndex[AColumn, ARow: Integer]: Integer read GetRowSpanIndex;
  end;

  TGridPanel = class(TCustomGridPanel)
  public
    property DockManager;
  published
    property Align;
    property Alignment;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    property Caption;
    property Color;
    property ColumnCollection;
    property Constraints;
    property ControlCollection;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ExpandStyle;
    property FullRepaint;
    property Font;
    property Locked;
    property Padding;
    property ParentBiDiMode;
    property ParentBackground;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RowCollection;
    property ShowCaption;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property VerticalAlignment;
    property Visible;
    property StyleElements;
    property OnAlignInsertBefore;
    property OnAlignPosition;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnGetSiteInfo;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  TPage = class(TCustomControl)
  private
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  protected
    procedure ReadState(Reader: TReader); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Caption;
    property Height stored False;
    property TabOrder stored False;
    property Touch;
    property Visible stored False;
    property Width stored False;
    property OnAlignInsertBefore;
    property OnAlignPosition;
    property OnGesture;
  end;

  TNotebook = class(TCustomControl)
  private
    FPageList: TList;
    FAccess: TStrings;
    FPageIndex: Integer;
    FOnPageChanged: TNotifyEvent;
    procedure SetPages(Value: TStrings);
    procedure SetActivePage(const Value: string);
    function GetActivePage: string;
    procedure SetPageIndex(Value: Integer);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    function GetChildOwner: TComponent; override;
    procedure ReadState(Reader: TReader); override;
    procedure ShowControl(AControl: TControl); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  published
    property ActivePage: string read GetActivePage write SetActivePage stored False;
    property Align;
    property Anchors;
    property Color;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Font;
    property Enabled;
    property Constraints;
    property PageIndex: Integer read FPageIndex write SetPageIndex default 0;
    property Pages: TStrings read FAccess write SetPages stored False;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnPageChanged: TNotifyEvent read FOnPageChanged write FOnPageChanged;
    property OnStartDock;
    property OnStartDrag;
  end;

{ THeader
  Purpose  - Creates sectioned visual header that allows each section to be
             resized with the mouse.
  Features - This is a design-interactive control.  In design mode, the
             sections are named using the string-list editor.  Each section
             can now be manually resized using the right mouse button the grab
             the divider and drag to the new size.  Changing the section list
             at design (or even run-time), will attempt to maintain the
             section widths for sections that have not been changed.
  Properties:
    Align - Standard property.
    AllowResize - If True, the control allows run-time mouse resizing of the
                  sections.
    BorderStyle - Turns the border on and off.
    Font - Standard property.
    Sections - A special string-list that contains the section text.
    ParentFont - Standard property.
    OnSizing - Event called for each mouse move during a section resize
               operation.
    OnSized - Event called once the size operation is complete.

    SectionWidth - Array property allowing run-time getting and setting of
                   each section's width. }

  TSectionEvent = procedure(Sender: TObject;
    ASection, AWidth: Integer) of object;

  THeader = class(TCustomControl)
  private
    FSections: TStrings;
    FHitTest: TPoint;
    FCanResize: Boolean;
    FAllowResize: Boolean;
    FBorderStyle: TBorderStyle;
    FResizeSection: Integer;
    FMouseOffset: Integer;
    FOnSizing: TSectionEvent;
    FOnSized: TSectionEvent;
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure FreeSections;
    procedure SetSections(Strings: TStrings);
    function GetWidth(X: Integer): Integer;
    procedure SetWidth(X: Integer; Value: Integer);
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
  protected
    procedure Paint; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Sizing(ASection, AWidth: Integer); dynamic;
    procedure Sized(ASection, AWidth: Integer); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property SectionWidth[X: Integer]: Integer read GetWidth write SetWidth;
  published
    property Align;
    property AllowResize: Boolean read FAllowResize write FAllowResize default True;
    property Anchors;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Constraints;
    property DoubleBuffered;
    property Enabled;
    property Font;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property Sections: TStrings read FSections write SetSections;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property Visible;
    property OnContextPopup;
    property OnGesture;
    property OnSizing: TSectionEvent read FOnSizing write FOnSizing;
    property OnSized: TSectionEvent read FOnSized write FOnSized;
  end;

  TCustomRadioGroup = class(TCustomGroupBox)
  private
    FButtons: TList;
    FItems: TStrings;
    FItemIndex: Integer;
    FColumns: Integer;
    FReading: Boolean;
    FUpdating: Boolean;
    FWordWrap: Boolean;
    function GetButtons(Index: Integer): TRadioButton;
    procedure ArrangeButtons;
    procedure ButtonClick(Sender: TObject);
    procedure ItemsChange(Sender: TObject);
    procedure SetButtonCount(Value: Integer);
    procedure SetColumns(Value: Integer);
    procedure SetItemIndex(Value: Integer);
    procedure SetItems(Value: TStrings);
    procedure SetWordWrap(Value: Boolean);
    procedure UpdateButtons;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    procedure CreateWnd; override;
    procedure Loaded; override;
    procedure ReadState(Reader: TReader); override;
    function CanModify: Boolean; virtual;
    property Columns: Integer read FColumns write SetColumns default 1;
    property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
    property Items: TStrings read FItems write SetItems;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure FlipChildren(AllLevels: Boolean); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    property Buttons[Index: Integer]: TRadioButton read GetButtons;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
  end;

  TRadioGroup = class(TCustomRadioGroup)
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Color;
    property Columns;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ItemIndex;
    property Items;
    property Constraints;
    property ParentBiDiMode;
    property ParentBackground default True;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property Visible;
    property StyleElements;
    property WordWrap;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnStartDock;
    property OnStartDrag;
  end;

  NaturalNumber = 1..High(Integer);

  TSplitterCanResizeEvent = procedure(Sender: TObject; var NewSize: Integer;
    var Accept: Boolean) of object;
  TCanResizeEvent = TSplitterCanResizeEvent;

  TResizeStyle = (rsNone, rsLine, rsUpdate, rsPattern);

  TSplitter = class(TGraphicControl)
  private
    FActiveControl: TWinControl;
    FAutoSnap: Boolean;
    FBeveled: Boolean;
    FBrush: TBrush;
    FControl: TControl;
    FDownPos: TPoint;
    FLineDC: HDC;
    FLineVisible: Boolean;
    FMinSize: NaturalNumber;
    FMaxSize: Integer;
    FNewSize: Integer;
    FOldKeyDown: TKeyEvent;
    FOldSize: Integer;
    FPrevBrush: HBrush;
    FResizeStyle: TResizeStyle;
    FSplit: Integer;
    FOnCanResize: TCanResizeEvent;
    FOnMoved: TNotifyEvent;
    FOnPaint: TNotifyEvent;
    procedure AllocateLineDC;
    procedure CalcSplitSize(X, Y: Integer; var NewSize, Split: Integer);
    procedure DrawLine;
    function FindControl: TControl;
    procedure FocusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ReleaseLineDC;
    procedure SetBeveled(Value: Boolean);
    procedure UpdateControlSize;
    procedure UpdateSize(X, Y: Integer);
  protected
    function CanResize(var NewSize: Integer): Boolean; reintroduce; virtual;
    function DoCanResize(var NewSize: Integer): Boolean; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint; override;
    procedure RequestAlign; override;
    procedure StopSizing; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas;
  published
    property Align default alLeft;
    property AutoSnap: Boolean read FAutoSnap write FAutoSnap default True;
    property Beveled: Boolean read FBeveled write SetBeveled default False;
    property Color;
    property Cursor default crHSplit;
    property Constraints;
    property MinSize: NaturalNumber read FMinSize write FMinSize default 30;
    property ParentColor;
    property ResizeStyle: TResizeStyle read FResizeStyle write FResizeStyle
      default rsPattern;
    property Visible;
    property Width default 3;
    property OnCanResize: TCanResizeEvent read FOnCanResize write FOnCanResize;
    property OnMoved: TNotifyEvent read FOnMoved write FOnMoved;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
  end;

{ TControlBar }

  TBandPaintOption = (bpoGrabber, bpoFrame, bpoGradient, bpoRoundRect);
  TBandPaintOptions = set of TBandPaintOption;
  TBandDrawingStyle = (dsNormal, dsGradient);

  TBandDragEvent = procedure (Sender: TObject; Control: TControl;
    var Drag: Boolean) of object;
  TBandInfoEvent = procedure (Sender: TObject; Control: TControl;
    var Insets: TRect; var PreferredSize, RowCount: Integer) of object;
  TBandMoveEvent = procedure (Sender: TObject; Control: TControl;
    var ARect: TRect) of object;
  TBeginBandMoveEvent = procedure (Sender: TObject; Control: TControl; var AllowMove: Boolean) of object;
  TEndBandMoveEvent = procedure (Sender: TObject; Control: TControl) of object;
  TBandPaintEvent = procedure (Sender: TObject; Control: TControl;
    Canvas: TCanvas; var ARect: TRect; var Options: TBandPaintOptions) of object;

  TCornerEdge = (ceNone, ceSmall, ceMedium, ceLarge);
  TRowSize = 1..MaxInt;

{$IF DEFINED(CLR)}
  TDockPos = class
  public
    Control: TControl;
    Insets: TRect;
    Visible: Boolean;
    Break: Boolean;
    Pos: TPoint;
    Width: Integer;

    Height: Integer;
    RowCount: Integer;
    TempRow: Integer;
    Parent: TDockPos;
    SubItem: TDockPos;

    TempBreak: Boolean;
    TempPos: TPoint;
    TempWidth: Integer;
  end;
{$ENDIF}

  TCustomControlBar = class(TCustomControl)
  private
    FAligning: Boolean;
    FAutoDrag: Boolean;
    FAutoDock: Boolean;
    FCornerEdge: TCornerEdge;
    FDockingControl: TControl;
    FDragControl: TControl;
    FDragOffset: TPoint;
    FDrawing: Boolean;
    FDrawingStyle: TBandDrawingStyle;
    FFloating: Boolean;
    FGradientDirection: TGradientDirection;
    FGradientEndColor: TColor;
    FGradientStartColor: TColor;
    FItems: TList;
    FPicture: TPicture;
    FRowSize: TRowSize;
    FRowSnap: Boolean;
    FOnBandDrag: TBandDragEvent;
    FOnBandInfo: TBandInfoEvent;
    FOnBandMove: TBandMoveEvent;
    FOnBandPaint: TBandPaintEvent;
    FOnBeginBandMove: TBeginBandMoveEvent;
    FOnEndBandMove: TEndBandMoveEvent;
    FOnPaint: TNotifyEvent;
    function IsGradientEndColorStored: Boolean;
    procedure DoAlignControl(AControl: TControl);
    procedure PictureChanged(Sender: TObject);
    procedure SetPicture(const Value: TPicture);
    procedure SetRowSize(Value: TRowSize);
    procedure SetRowSnap(Value: Boolean);
    procedure UnDockControl(AControl: TControl);
    function UpdateItems(AControl: TControl): Boolean;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure SetCornerEdge(Value: TCornerEdge);
    procedure SetGradientStartColor(Value: TColor);
    procedure SetGradientEndColor(Value: TColor);
    procedure SetGradientDirection(Value: TGradientDirection);
    procedure SetDrawingStyle(const Value: TBandDrawingStyle);
                                               
{$IF DEFINED(CLR)}
    function FindPos(AControl: TControl): TDockPos;
    function HitTest2(X, Y: Integer): TObject;
    procedure DockControl(AControl: TControl; const ARect: TRect;
      var BreakList: TBooleanDynArray; var IndexList, SizeList: TIntegerDynArray;
      Parent: TDockPos; ChangedPriorBreak: Boolean; Insets: TRect;
      PreferredSize, RowCount: Integer; Existing: Boolean);
    procedure CMInvalidate(var Message: TMessage); message CM_INVALIDATE;
{$ELSE}
    function FindPos(AControl: TControl): Pointer;
    function HitTest2(X, Y: Integer): Pointer;
    procedure DockControl(AControl: TControl; const ARect: TRect;
      BreakList, IndexList, SizeList: TList; Parent: Pointer;
      ChangedPriorBreak: Boolean; Insets: TRect; PreferredSize,
      RowCount: Integer; Existing: Boolean);
    procedure CMControlListChange(var Message: TCMControlListChange); message CM_CONTROLLISTCHANGE;
{$ENDIF}
  protected
    procedure AlignControls(AControl: TControl; var ARect: TRect); override;
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoBandMove(Control: TControl; var ARect: TRect); virtual;
    procedure DoBandPaint(Control: TControl; Canvas: TCanvas; var ARect: TRect;
      var Options: TBandPaintOptions); virtual;
    function DoBeginBandMove(Control: TControl): Boolean; dynamic;
    procedure DoEndBandMove(Control: TControl); dynamic;
    procedure DockOver(Source: TDragDockObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    function DoPaletteChange: Boolean;
    function DragControl(AControl: TControl; X, Y: Integer;
      KeepCapture: Boolean = False): Boolean; virtual;
    procedure GetControlInfo(AControl: TControl; var Insets: TRect;
      var PreferredSize, RowCount: Integer); virtual;
    function GetPalette: HPALETTE; override;
    procedure GetSiteInfo(Client: TControl; var InfluenceRect: TRect;
      MousePos: TPoint; var CanDock: Boolean); override;
    function HitTest(X, Y: Integer): TControl;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint; override;
    procedure PaintControlFrame(Canvas: TCanvas; AControl: TControl;
      var ARect: TRect); virtual;
{$IF DEFINED(CLR)}
    procedure ControlListChange(Inserting: Boolean; Child: TControl); override;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure FlipChildren(AllLevels: Boolean); override;
    procedure StickControls; virtual;
    property Picture: TPicture read FPicture write SetPicture;
  protected
    property AutoDock: Boolean read FAutoDock write FAutoDock default True;
    property AutoDrag: Boolean read FAutoDrag write FAutoDrag default True;
    property AutoSize;
    property BevelKind default bkTile;
    property CornerEdge: TCornerEdge read FCornerEdge
      write SetCornerEdge default ceMedium;
    property DockSite default True;
    property DrawingStyle: TBandDrawingStyle read FDrawingStyle
      write SetDrawingStyle default dsNormal;
    property GradientDirection: TGradientDirection read FGradientDirection
      write SetGradientDirection default gdVertical;
    property GradientStartColor: TColor read FGradientStartColor
      write SetGradientStartColor default clWindow;
    property GradientEndColor: TColor read FGradientEndColor
      write SetGradientEndColor stored IsGradientEndColorStored;
    property RowSize: TRowSize read FRowSize write SetRowSize default 26;
    property RowSnap: Boolean read FRowSnap write SetRowSnap default True;
    property OnBandDrag: TBandDragEvent read FOnBandDrag write FOnBandDrag;
    property OnBandInfo: TBandInfoEvent read FOnBandInfo write FOnBandInfo;
    property OnBandMove: TBandMoveEvent read FOnBandMove write FOnBandMove;
    property OnBandPaint: TBandPaintEvent read FOnBandPaint write FOnBandPaint;
    property OnBeginBandMove: TBeginBandMoveEvent read FOnBeginBandMove write FOnBeginBandMove;
    property OnEndBandMove: TEndBandMoveEvent read FOnEndBandMove write FOnEndBandMove;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
  end;

  TControlBar = class(TCustomControlBar)
  public
    property Canvas;
  published
    property Align;
    property Anchors;
    property AutoDock;
    property AutoDrag;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BorderWidth;
    property Color nodefault;
    property Constraints;
    property CornerEdge;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DrawingStyle;
    property Enabled;
    property GradientDirection;
    property GradientEndColor;
    property GradientStartColor;
    property ParentBackground default True;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property Picture;
    property PopupMenu;
    property RowSize;
    property RowSnap;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property Visible;
    property OnAlignInsertBefore;
    property OnAlignPosition;
    property OnBandDrag;
    property OnBandInfo;
    property OnBandMove;
    property OnBandPaint;
    property OnBeginBandMove;
    property OnEndBandMove;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnGetSiteInfo;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnPaint;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  { TBoundLabel }

  TBoundLabel = class(TCustomLabel)
  private
    function GetTop: Integer;
    function GetLeft: Integer;
    function GetWidth: Integer;
    function GetHeight: Integer;
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
  protected
    procedure AdjustBounds; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property BiDiMode;
    property Caption;
    property Color;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Font;
    property Height: Integer read GetHeight write SetHeight;
    property Left: Integer read GetLeft;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Top: Integer read GetTop;
    property Touch;
    property Transparent;
    property Layout;
    property WordWrap;
    property Width: Integer read GetWidth write SetWidth;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnGesture;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  TLabelPosition = (lpAbove, lpBelow, lpLeft, lpRight);

  { TCustomLabeledEdit }

  TCustomLabeledEdit = class(TCustomEdit)
  private
    FEditLabel: TBoundLabel;
    FLabelPosition: TLabelPosition;
    FLabelSpacing: Integer;
    procedure SetLabelPosition(const Value: TLabelPosition);
    procedure SetLabelSpacing(const Value: Integer);
  protected
    procedure SetParent(AParent: TWinControl); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    procedure CMVisiblechanged(var Message: TMessage);
      message CM_VISIBLECHANGED;
    procedure CMEnabledchanged(var Message: TMessage);
      message CM_ENABLEDCHANGED;
    procedure CMBidimodechanged(var Message: TMessage);
      message CM_BIDIMODECHANGED;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
    procedure SetupInternalLabel;
    property EditLabel: TBoundLabel read FEditLabel;
    property LabelPosition: TLabelPosition read FLabelPosition write SetLabelPosition default lpAbove;
    property LabelSpacing: Integer read FLabelSpacing write SetLabelSpacing default 3;
  end;

  { TLabeledEdit }

  TLabeledEdit = class(TCustomLabeledEdit)
  published
    property Alignment;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property EditLabel;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property LabelPosition;
    property LabelSpacing;
    property MaxLength;
    property OEMConvert;
    property NumbersOnly;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property TextHint;
    property Touch;
    property Visible;
    property StyleElements;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  { TEditButton }

  TCustomButtonedEdit = class;

  TEditButton = class(TPersistent)
  strict private
    type
      TButtonState = (bsNormal, bsHot, bsPushed);
      TGlyph = class(TCustomControl)
      private
        FButton: TEditButton;
        FState: TButtonState;
      protected
        procedure Click; override;
        procedure CreateWnd; override;
        procedure Paint; override;
        procedure WndProc(var Message: TMessage); override;
      public
        constructor Create(AButton: TEditButton); reintroduce; virtual;
      end;
  protected
    type
      TButtonPosition = (bpLeft, bpRight);
  strict private
    FDisabledImageIndex: TImageIndex;
    FDropDownMenu: TPopupMenu;
    FEditControl: TCustomButtonedEdit;
    FGlyph: TGlyph;
    FHotImageIndex: TImageIndex;
    FImageIndex: TImageIndex;
    FPosition: TButtonPosition;
    FPressedImageIndex: TImageIndex;
    function GetEnabled: Boolean;
    function GetCustomHint: TCustomHint;
    function GetHint: string;
    function GetImages: TCustomImageList;
    function GetVisible: Boolean;
    procedure SetDisabledImageIndex(const Value: TImageIndex);
    procedure SetEnabled(const Value: Boolean);
    procedure SetCustomHint(const Value: TCustomHint);
    procedure SetHint(const Value: string);
    procedure SetHotImageIndex(const Value: TImageIndex);
    procedure SetImageIndex(const Value: TImageIndex);
    procedure SetPressedImageIndex(const Value: TImageIndex);
    procedure SetVisible(const Value: Boolean);
  protected
    function GetOwner: TPersistent; override;
    procedure UpdateBounds; dynamic;
    property EditControl: TCustomButtonedEdit read FEditControl;
    property Glyph: TGlyph read FGlyph;
    property Images: TCustomImageList read GetImages;
    property Position: TButtonPosition read FPosition;
  public
    constructor Create(EditControl: TCustomButtonedEdit; APosition: TButtonPosition); reintroduce; virtual;
    destructor Destroy; override;
  published
    property CustomHint: TCustomHint read GetCustomHint write SetCustomHint;
    property DisabledImageIndex: TImageIndex read FDisabledImageIndex write SetDisabledImageIndex default -1;
    property DropDownMenu: TPopupMenu read FDropDownMenu write FDropDownMenu;
    property Enabled: Boolean read GetEnabled write SetEnabled default True;
    property Hint: string read GetHint write SetHint;
    property HotImageIndex: TImageIndex read FHotImageIndex write SetHotImageIndex default -1;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex default -1;
    property PressedImageIndex: TImageIndex read FPressedImageIndex write SetPressedImageIndex default -1;
    property Visible: Boolean read GetVisible write SetVisible default False;
  end;

  TEditButtonClass = class of TEditButton;

  { TCustomButtonedEdit }

  TCustomButtonedEdit = class(TCustomEdit)
  private
    FCanvas: TControlCanvas;
    FImages: TCustomImageList;
    FImageChangeLink: TChangeLink;
    FLeftButton: TEditButton;
    FRightButton: TEditButton;
    function AdjustTextHint(Margin: Integer; const Value: string): string;
    procedure ImageListChange(Sender: TObject);
    procedure SetImages(const Value: TCustomImageList);
    function GetOnLeftButtonClick: TNotifyEvent;
    function GetOnRightButtonClick: TNotifyEvent;
    procedure SetLeftButton(const Value: TEditButton);
    procedure SetOnLeftButtonClick(const Value: TNotifyEvent);
    procedure SetOnRightButtonClick(const Value: TNotifyEvent);
    procedure SetRightButton(const Value: TEditButton);
  protected
    procedure DoSetTextHint(const Value: string); override;
    function GetEditButtonClass: TEditButtonClass; dynamic;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure UpdateEditMargins; dynamic;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DefaultHandler(var Message); override;
    property Images: TCustomImageList read FImages write SetImages;
    property LeftButton: TEditButton read FLeftButton write SetLeftButton;
    property RightButton: TEditButton read FRightButton write SetRightButton;
    property OnLeftButtonClick: TNotifyEvent read GetOnLeftButtonClick write SetOnLeftButtonClick;
    property OnRightButtonClick: TNotifyEvent read GetOnRightButtonClick write SetOnRightButtonClick;
  end;

  { TButtonedEdit }

  TButtonedEdit = class(TCustomButtonedEdit)
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property Images;
    property ImeMode;
    property ImeName;
    property LeftButton;
    property MaxLength;
    property OEMConvert;
    property NumbersOnly;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property RightButton;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property TextHint;
    property Touch;
    property Visible;
    property StyleElements;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnGesture;
    property OnLeftButtonClick;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnRightButtonClick;
    property OnStartDock;
    property OnStartDrag;
  end;


const
  NoColorSelected = TColor($FF000000);

type
  TCustomColorBox = class;
  TColorBoxStyles = (cbStandardColors, // first sixteen RGBI colors
                     cbExtendedColors, // four additional reserved colors
                     cbSystemColors,   // system managed/defined colors
                     cbIncludeNone,    // include clNone color, must be used with cbSystemColors
                     cbIncludeDefault, // include clDefault color, must be used with cbSystemColors
                     cbCustomColor,    // first color is customizable
                     cbPrettyNames,
                     cbCustomColors);  // All colors are custom colors
  TColorBoxStyle = set of TColorBoxStyles;
  TGetColorsEvent = procedure(Sender: TCustomColorBox; Items: TStrings) of object;
  TCustomColorBox = class(TCustomComboBox)
  private
    FStyle: TColorBoxStyle;
    FNeedToPopulate: Boolean;
    FNeedToSetSelected: Boolean;
    FListSelected: Boolean;
    FDefaultColorColor: TColor;
    FNoneColorColor: TColor;
    FSelectedColor: TColor;
    FOnGetColors: TGetColorsEvent;
    function GetColor(Index: Integer): TColor;
    function GetColorName(Index: Integer): string;
    function GetSelected: TColor;
    procedure SetSelected(const AColor: TColor);
    procedure ColorCallBack(const AName: string);
    procedure SetDefaultColorColor(const Value: TColor);
    procedure SetNoneColorColor(const Value: TColor);
{$IF DEFINED(CLR)}
    function IndexOfColor(const Value: TColor): Integer;
{$ENDIF}
  protected
    procedure CloseUp; override;
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    function PickCustomColor: Boolean; virtual;
    procedure PopulateList;
    procedure Select; override;
    procedure SetStyle(AStyle: TColorBoxStyle); reintroduce;
  public
    constructor Create(AOwner: TComponent); override;
    property Style: TColorBoxStyle read FStyle write SetStyle
      default [cbStandardColors, cbExtendedColors, cbSystemColors];
    property Colors[Index: Integer]: TColor read GetColor;
    property ColorNames[Index: Integer]: string read GetColorName;
    property Selected: TColor read GetSelected write SetSelected default clBlack;
    property DefaultColorColor: TColor read FDefaultColorColor write SetDefaultColorColor default clBlack;
    property NoneColorColor: TColor read FNoneColorColor write SetNoneColorColor default clBlack;
    property OnGetColors: TGetColorsEvent read FOnGetColors write FOnGetColors;
  end;

  TColorBox = class(TCustomColorBox)
  published
    property Align;
    property AutoComplete;
    property AutoDropDown;
    property DefaultColorColor;
    property NoneColorColor;
    property Selected;
    property Style;

    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DropDownCount;
    property Enabled;
    property Font;
    property ItemHeight;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property Visible;
    property StyleElements;
    property OnChange;
    property OnCloseUp;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnGetColors;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelect;
    property OnStartDock;
    property OnStartDrag;
  end;

{ TColorListBox }

  TCustomColorListBox = class;
  TLBGetColorsEvent = procedure(Sender: TCustomColorListBox; Items: TStrings) of object;

  TCustomColorListBox = class(TCustomListBox)
  private
    FStyle: TColorBoxStyle;
    FNeedToPopulate: Boolean;
    FNeedToSetSelected: Boolean;
    FListSelected: Boolean;
    FDefaultColorColor: TColor;
    FNoneColorColor: TColor;
    FSelectedColor: TColor;
    FOnGetColors: TLBGetColorsEvent;
    function GetColor(Index: Integer): TColor;
    function GetColorName(Index: Integer): string;
    function GetSelected: TColor;
    procedure SetSelected(const AColor: TColor);
    procedure ColorCallBack(const AName: string);
    procedure SetDefaultColorColor(const Value: TColor);
    procedure SetNoneColorColor(const Value: TColor);
  protected
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    function PickCustomColor: Boolean; virtual;
    procedure PopulateList;
    procedure SetStyle(AStyle: TColorBoxStyle); reintroduce;
  public
    constructor Create(AOwner: TComponent); override;
    property Style: TColorBoxStyle read FStyle write SetStyle
      default [cbStandardColors, cbExtendedColors, cbSystemColors];
    property Colors[Index: Integer]: TColor read GetColor;
    property ColorNames[Index: Integer]: string read GetColorName;
    property Selected: TColor read GetSelected write SetSelected default clBlack;
    property DefaultColorColor: TColor read FDefaultColorColor write SetDefaultColorColor default clBlack;
    property NoneColorColor: TColor read FNoneColorColor write SetNoneColorColor default clBlack;
    property OnGetColors: TLBGetColorsEvent read FOnGetColors write FOnGetColors;
  end;

  TColorListBox = class(TCustomColorListBox)
  published
    property Align;
    property AutoComplete;
    property DefaultColorColor;
    property NoneColorColor;
    property Selected;
    property Style;

    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property Enabled;
    property Font;
    property ItemHeight;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property Visible;
    property StyleElements;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnGetColors;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

{ TTrayIcon }

const
  WM_SYSTEM_TRAY_MESSAGE = WM_USER + 1;

type
  TBalloonFlags = (bfNone = NIIF_NONE, bfInfo = NIIF_INFO,
    bfWarning = NIIF_WARNING, bfError = NIIF_ERROR);

  [RootDesignerSerializerAttribute('', '', False)]
  TCustomTrayIcon = class(TComponent)
  private
    class var
      RM_TaskbarCreated: DWORD;
  private
    FAnimate: Boolean;
    FBalloonHint: string;
    FBalloonTitle: string;
    FBalloonFlags: TBalloonFlags;
    FIsClicked: Boolean;
    FCurrentIcon: TIcon;
{$IF DEFINED(CLR)}
    FData: TNotifyIconData;
{$ELSE}
    FData: PNotifyIconData;
{$ENDIF}
    FIcon: TIcon;
    FIconList: TCustomImageList;
    FPopupMenu: TPopupMenu;
    FTimer: TTimer;
    FHint: String;
    FIconIndex: Integer;
    FVisible: Boolean;
    FOnBalloonClick: TNotifyEvent;
    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FOnMouseDown: TMouseEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseEvent;
    FOnAnimate: TNotifyEvent;
    function GetData: TNotifyIconData;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetHint(const Value: string);
    function GetAnimateInterval: Cardinal;
    procedure SetAnimateInterval(Value: Cardinal);
    procedure SetAnimate(Value: Boolean);
    procedure SetBalloonHint(const Value: string);
    function GetBalloonTimeout: Integer;
    procedure SetBalloonTimeout(Value: Integer);
    procedure SetBalloonTitle(const Value: string);
    procedure SetVisible(Value: Boolean); virtual;
    procedure SetIconIndex(Value: Integer); virtual;
    procedure SetIcon(Value: TIcon);
    procedure SetIconList(Value: TCustomImageList);
    procedure WindowProc(var Message: TMessage); virtual;
    procedure DoOnAnimate(Sender: TObject); virtual;
    property Data: TNotifyIconData read GetData;
    function Refresh(Message: Integer): Boolean; overload;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure Refresh; overload;
    procedure SetDefaultIcon;
    procedure ShowBalloonHint; virtual;
    property Animate: Boolean read FAnimate write SetAnimate default False;
    property AnimateInterval: Cardinal read GetAnimateInterval write SetAnimateInterval default 1000;
    property Hint: string read FHint write SetHint;
    property BalloonHint: string read FBalloonHint write SetBalloonHint;
    property BalloonTitle: string read FBalloonTitle write SetBalloonTitle;
    property BalloonTimeout: Integer read GetBalloonTimeout write SetBalloonTimeout default 10000;
    property BalloonFlags: TBalloonFlags read FBalloonFlags write FBalloonFlags default bfNone;
    property Icon: TIcon read FIcon write SetIcon;
    property Icons: TCustomImageList read FIconList write SetIconList;
    property IconIndex: Integer read FIconIndex write SetIconIndex default 0;
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu;
    property Visible: Boolean read FVisible write SetVisible default False;
    property OnBalloonClick: TNotifyEvent read FOnBalloonClick write FOnBalloonClick;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnAnimate: TNotifyEvent read FOnAnimate write FOnAnimate;
  end;

  TTrayIcon = class(TCustomTrayIcon)
  published
    property Animate;
    property AnimateInterval;
    property Hint;
    property BalloonHint;
    property BalloonTitle;
    property BalloonTimeout;
    property BalloonFlags;
    property Icon;
    property Icons;
    property IconIndex;
    property PopupMenu;
    property Visible;
    property OnBalloonClick;
    property OnClick;
    property OnDblClick;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseDown;
    property OnAnimate;
  end;

{ TCategoryPanelGroup }

const
  DefaultCategoryPanelHeight = 200;

type
  TCustomCategoryPanel = class;
  TCustomCategoryPanelGroup = class;

  TCategoryPanelSurface = class(TCustomTransparentControl)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TCategoryPanelSurfaceClass = class of TCategoryPanelSurface;

  TCustomCategoryPanel = class(TCustomPanel)
  strict protected type
    THeaderState = (hsNormal, hsHot, hsPressed);
  private
    FAllowResize: Boolean;
    FCollapsed: Boolean;
    FCollapsedHotImageIndex: TImageIndex;
    FCollapsedImageIndex: TImageIndex;
    FCollapsedPressedImageIndex: TImageIndex;
    FExpandedHeight: Integer;
    FExpandedHotImageIndex: TImageIndex;
    FExpandedImageIndex: TImageIndex;
    FExpandedPressedImageIndex: TImageIndex;
    FGlyphRect: TRect;
    FHeaderState: THeaderState;
    FPanelGroup: TCustomCategoryPanelGroup;
    FMouseInClient: Boolean;
    FTextRect: TRect;
    FOnCollapse: TNotifyEvent;
    FOnExpand: TNotifyEvent;
    function GetHeaderHeight: Integer;
    procedure ReadExpandedHeight(Reader: TReader);
    procedure SetCollapsed(const Value: Boolean);
    procedure SetCollapsedHotImageIndex(const Value: TImageIndex);
    procedure SetCollapsedImageIndex(const Value: TImageIndex);
    procedure SetCollapsedPressedImageIndex(const Value: TImageIndex);
    procedure SetExpandedHotImageIndex(const Value: TImageIndex);
    procedure SetExpandedImageIndex(const Value: TImageIndex);
    procedure SetExpandedPressedImageIndex(const Value: TImageIndex);
    procedure SetPanelGroup(const Value: TCustomCategoryPanelGroup);
    procedure UpdateButtonState;
    function UsingImageList: Boolean;
    procedure WriteExpandedHeight(Writer: TWriter);
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
{$IF NOT DEFINED(CLR)}
    procedure CMControlListChanging(var Message: TCMControlListChanging); message CM_CONTROLLISTCHANGING;
{$ENDIF}
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMNCMouseLeave(var Message: TMessage); message WM_NCMOUSELEAVE;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
  protected
    FPanelSurface: TCategoryPanelSurface;
    procedure CalcRectBounds; virtual;
{$IF DEFINED(CLR)}
    procedure ControlListChanging(Inserting: Boolean; var Item: TControlListItem); override;
{$ENDIF}
    procedure DefineProperties(Filer: TFiler); override;
    procedure DrawCollapsedPanel(ACanvas: TCanvas); virtual;
    procedure DrawHeader; overload; virtual;
    procedure DrawHeader(DC: HDC); overload; virtual;
    procedure DrawHeaderBackground(ACanvas: TCanvas); virtual;
    procedure DrawHeaderCaption(ACanvas: TCanvas); virtual;
    procedure DrawHeaderChevron(ACanvas: TCanvas); virtual;
    function GetCategoryPanelSurfaceClass: TCategoryPanelSurfaceClass; virtual;
    function GetCollapsedHeight: Integer; virtual;
    procedure Loaded; override;
    procedure ReadState(Reader: TReader); override;
    procedure ResizeHeader(OldHeight, NewHeight: Integer);
    procedure SetParent(AParent: TWinControl); override;
    procedure UpdateControlOriginalParentSize(AControl: TControl; var AOriginalParentSize: TPoint); override;
    procedure UpdateHeader;
    procedure WndProc(var Message: TMessage); override;
    property HeaderHeight: Integer read GetHeaderHeight;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Collapse;
    procedure Expand;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure GetTabControlList(List: TList); override;
    procedure GetTabOrderList(List: TList); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property Collapsed: Boolean read FCollapsed write SetCollapsed default False;
    property CollapsedHotImageIndex: TImageIndex read FCollapsedHotImageIndex write SetCollapsedHotImageIndex default -1;
    property CollapsedImageIndex: TImageIndex read FCollapsedImageIndex write SetCollapsedImageIndex default -1;
    property CollapsedPressedImageIndex: TImageIndex read FCollapsedPressedImageIndex write SetCollapsedPressedImageIndex default -1;
    property ExpandedHotImageIndex: TImageIndex read FExpandedHotImageIndex write SetExpandedHotImageIndex default -1;
    property ExpandedImageIndex: TImageIndex read FExpandedImageIndex write SetExpandedImageIndex default -1;
    property ExpandedPressedImageIndex: TImageIndex read FExpandedPressedImageIndex write SetExpandedPressedImageIndex default -1;
    property HeaderState: THeaderState read FHeaderState;
    property PanelGroup: TCustomCategoryPanelGroup read FPanelGroup write SetPanelGroup;
    property OnCollapse: TNotifyEvent read FOnCollapse write FOnCollapse;
    property OnExpand: TNotifyEvent read FOnExpand write FOnExpand;
  end;

  TCategoryPanelClass = class of TCustomCategoryPanel;

  TCategoryPanel = class(TCustomCategoryPanel)
  published
    property BiDiMode;
    property Caption;
    property Color;
    property Collapsed;
    property CollapsedHotImageIndex;
    property CollapsedImageIndex;
    property CollapsedPressedImageIndex;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ExpandedHotImageIndex;
    property ExpandedImageIndex;
    property ExpandedPressedImageIndex;
    property FullRepaint;
    property Font;
    property Height default DefaultCategoryPanelHeight;
    property Left stored False;
    property Locked;
    property Padding;
    property ParentBiDiMode;
    property ParentBackground default False;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property Visible;
    property StyleElements;
    property Width stored False;
    property OnCollapse;
    property OnClick;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnExpand;
    property OnGesture;
    property OnGetSiteInfo;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  TCustomCategoryPanelGroup = class(TScrollingWinControl)
  public type
    THeaderStyle = (hsGradient, hsImage, hsThemed);
  private
    FChevronAlignment: TAlignment;
    FChevronColor: TColor;
    FChevronHotColor: TColor;
    FGradientBaseColor: TColor;
    FGradientColor: TColor;
    FGradientDirection: TGradientDirection;
    FHeaderAlignment: TAlignment;
    FHeaderFont: TFont;
    FHeaderImage: TPicture;
    FHeaderHeight: Integer;
    FHeaderStyle: THeaderStyle;
    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FPanels: TList;
    FReorderPanels: Boolean;
    class constructor Create;
    class destructor Destroy;
    procedure ImageListChange(Sender: TObject);
    procedure InsertPanel(Panel: TCustomCategoryPanel);
    procedure RemovePanel(Panel: TCustomCategoryPanel);
    procedure SetChevronAlignment(const Value: TAlignment);
    procedure SetChevronColor(const Value: TColor);
    procedure SetChevronHotColor(const Value: TColor);
    procedure SetGradientBaseColor(const Value: TColor);
    procedure SetGradientColor(const Value: TColor);
    procedure SetGradientDirection(const Value: TGradientDirection);
    procedure SetHeaderAlignment(const Value: TAlignment);
    procedure SetHeaderFont(const Value: TFont);
    procedure SetHeaderHeight(const Value: Integer);
    procedure SetHeaderImage(const Value: TPicture);
    procedure SetHeaderStyle(const Value: THeaderStyle);
    procedure SetImages(const Value: TCustomImageList);
    procedure UpdatePanelHeaders;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
{$IF NOT DEFINED(CLR)}
    procedure CMControlListChanging(var Message: TCMControlListChanging); message CM_CONTROLLISTCHANGING;
{$ENDIF}
    procedure CMDoubleBufferedChanged(var Mesage: TMessage); message CM_DOUBLEBUFFEREDCHANGED;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  protected
{$IF DEFINED(CLR)}
    procedure ControlListChanging(Inserting: Boolean; var Item: TControlListItem); override;
{$ENDIF}
    procedure CreateWnd; override;
    procedure CreateParams(var Params: TCreateParams); override;
    function GetCategoryPanelClass: TCategoryPanelClass; virtual;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ReorderPanels; dynamic;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CollapseAll;
    function CreatePanel(AOwner: TComponent): TCustomCategoryPanel;
    procedure ExpandAll;
    property ChevronAlignment: TAlignment read FChevronAlignment write SetChevronAlignment default taLeftJustify;
    property ChevronColor: TColor read FChevronColor write SetChevronColor default clBlack;
    property ChevronHotColor: TColor read FChevronHotColor write SetChevronHotColor default clGray;
    property Color default clMedGray;
    property GradientBaseColor: TColor read FGradientBaseColor write SetGradientBaseColor default $F0F0F0;
    property GradientColor: TColor read FGradientColor write SetGradientColor default $C0C0C0;
    property GradientDirection: TGradientDirection read FGradientDirection write SetGradientDirection default gdVertical;
    property HeaderAlignment: TAlignment read FHeaderAlignment write SetHeaderAlignment default taLeftJustify;
    property HeaderFont: TFont read FHeaderFont write SetHeaderFont;
    property HeaderHeight: Integer read FHeaderHeight write SetHeaderHeight default 24;
    property HeaderImage: TPicture read FHeaderImage write SetHeaderImage;
    property HeaderStyle: THeaderStyle read FHeaderStyle write SetHeaderStyle default hsGradient;
    property Images: TCustomImageList read FImages write SetImages;
    property Panels: TList read FPanels;
  end;

  TCategoryPanelGroup = class(TCustomCategoryPanelGroup)
  strict private
    class constructor Create;
    class destructor Destroy;
  published
    property Align default alLeft;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BiDiMode;
    property ChevronAlignment;
    property ChevronColor;
    property ChevronHotColor;
    property Constraints;
    property DockSite;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Color;
    property Ctl3D;
    property Font;
    property GradientBaseColor;
    property GradientColor;
    property GradientDirection;
    property HeaderAlignment;
    property HeaderFont;
    property HeaderHeight;
    property HeaderImage;
    property HeaderStyle;
    property Height default 350;
    property Images;
    property Padding;
    property ParentBiDiMode;
    property ParentBackground default False;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property Visible;
    property StyleElements;
    property Width default 200;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDblClick;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnGetSiteInfo;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  TSysLinkType = (sltURL, sltID);

  TSysLinkEvent = procedure(Sender: TObject; const Link: string; LinkType: TSysLinkType) of object;

  TCustomLinkLabel = class(TWinControl)
  public type
    TLinkAlignment = taLeftJustify..taRightJustify;
  private
    FAlignment: TLinkAlignment;
    FAutoSize: Boolean;
    FUseVisualStyle: Boolean;
    FOnLinkClick: TSysLinkEvent;
    class constructor Create;
    class destructor Destroy;
    procedure AdjustBounds;
    procedure DoOnLinkClick(const Link: string; LinkType: TSysLinkType);
    function ParseLinks: string;
    procedure SetAlignment(const Value: TLinkAlignment);
    procedure SetUseVisualStyle(const Value: Boolean);
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure CNCtlColorStatic(var Message: TWMCtlColorStatic); message CN_CTLCOLORSTATIC;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure SetAutoSize(Value: Boolean); override;
    function UseThemes: Boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    property Alignment: TLinkAlignment read FAlignment write SetAlignment default taLeftJustify;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default True;
    property UseVisualStyle: Boolean read FUseVisualStyle write SetUseVisualStyle default False;
    property OnLinkClick: TSysLinkEvent read FOnLinkClick write FOnLinkClick;
  end;

  TLinkLabel = class(TCustomLinkLabel)
  strict private
    class constructor Create;
    class destructor Destroy;
  published
    property Alignment; // Requires Windows Vista or later
    property Anchors;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property Caption;
    property Color nodefault;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property UseVisualStyle;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnGesture;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnLinkClick;
  end;

  TLinkLabelStyleHook = class(TStyleHook)
  strict protected
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AControl: TWinControl); override;
  end;


procedure Frame3D(Canvas: TCanvas; var Rect: TRect;
  TopColor, BottomColor: TColor; Width: Integer);
procedure NotebookHandlesNeeded(Notebook: TNotebook);

implementation

uses
{$IF DEFINED(CLR)}
  WinUtils, System.Text,
  System.Security.Permissions, System.Runtime.InteropServices,
{$ENDIF}
  Vcl.Consts, Vcl.Dialogs, System.Math, Winapi.UxTheme, Winapi.DwmApi, Winapi.CommCtrl;

{ Utility routines }

procedure Frame3D(Canvas: TCanvas; var Rect: TRect; TopColor, BottomColor: TColor;
  Width: Integer);

  procedure DoRect;
  var
    TopRight, BottomLeft: TPoint;
  begin
    with Canvas, Rect do
    begin
      TopRight.X := Right;
      TopRight.Y := Top;
      BottomLeft.X := Left;
      BottomLeft.Y := Bottom;
      Pen.Color := TopColor;
      PolyLine([BottomLeft, TopLeft, TopRight]);
      Pen.Color := BottomColor;
      Dec(BottomLeft.X);
      PolyLine([TopRight, BottomRight, BottomLeft]);
    end;
  end;

begin
  Canvas.Pen.Width := 1;
  Dec(Rect.Bottom); Dec(Rect.Right);
  while Width > 0 do
  begin
    Dec(Width);
    DoRect;
    InflateRect(Rect, -1, -1);
  end;
  Inc(Rect.Bottom); Inc(Rect.Right);
end;

// Call HandleNeeded for each page in notebook.  Used to allow anchors to work
// on invisible pages.
procedure NotebookHandlesNeeded(Notebook: TNotebook);
var
  I: Integer;
begin
  if Notebook <> nil then
    for I := 0 to Notebook.FPageList.Count - 1 do
      with TPage(Notebook.FPageList[I]) do
      begin
        DisableAlign;
        try
          HandleNeeded;
          ControlState := ControlState - [csAlignmentNeeded];
        finally
          EnableAlign;
        end;
      end;
end;

function AdjustedAlignment(RightToLeftAlignment: Boolean; Alignment: TAlignment): TAlignment;
begin
  Result := Alignment;
  if RightToLeftAlignment then
    case Result of
      taLeftJustify: Result := taRightJustify;
      taRightJustify: Result := taLeftJustify;
    end;
end;


{ TShape }

constructor TShape.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  Width := 65;
  Height := 65;
  FPen := TPen.Create;
  FPen.OnChange := StyleChanged;
  FBrush := TBrush.Create;
  FBrush.OnChange := StyleChanged;
end;

destructor TShape.Destroy;
begin
  FPen.Free;
  FBrush.Free;
  inherited Destroy;
end;

procedure TShape.Paint;
var
  X, Y, W, H, S: Integer;
begin
  with Canvas do
  begin
    Pen := FPen;
    Brush := FBrush;
    X := Pen.Width div 2;
    Y := X;
    W := Width - Pen.Width + 1;
    H := Height - Pen.Width + 1;
    if Pen.Width = 0 then
    begin
      Dec(W);
      Dec(H);
    end;
    if W < H then S := W else S := H;
    if FShape in [stSquare, stRoundSquare, stCircle] then
    begin
      Inc(X, (W - S) div 2);
      Inc(Y, (H - S) div 2);
      W := S;
      H := S;
    end;
    case FShape of
      stRectangle, stSquare:
        Rectangle(X, Y, X + W, Y + H);
      stRoundRect, stRoundSquare:
        RoundRect(X, Y, X + W, Y + H, S div 4, S div 4);
      stCircle, stEllipse:
        Ellipse(X, Y, X + W, Y + H);
    end;
  end;
end;

procedure TShape.StyleChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TShape.SetBrush(Value: TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TShape.SetPen(Value: TPen);
begin
  FPen.Assign(Value);
end;

procedure TShape.SetShape(Value: TShapeType);
begin
  if FShape <> Value then
  begin
    FShape := Value;
    Invalidate;
  end;
end;

{ TPaintBox }

constructor TPaintBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  Width := 105;
  Height := 105;
end;

procedure TPaintBox.Paint;
begin
  Canvas.Font := Font;
  Canvas.Brush.Color := Color;
  if csDesigning in ComponentState then
    with Canvas do
    begin
      Pen.Style := psDash;
      Brush.Style := bsClear;
      Rectangle(0, 0, Width, Height);
    end;
  if Assigned(FOnPaint) then FOnPaint(Self);
end;

{ TImage }

constructor TImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable, csPannable];
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
  FPicture.OnProgress := Progress;
  Height := 105;
  Width := 105;
end;

destructor TImage.Destroy;
begin
  FPicture.Free;
  inherited Destroy;
end;

function TImage.GetPalette: HPALETTE;
begin
  Result := 0;
  if FPicture.Graphic <> nil then
    Result := FPicture.Graphic.Palette;
end;

function TImage.CanObserve(const ID: Integer): Boolean;
begin
  Result := False;
  if ID = TObserverMapping.EditLinkID then
    Result := True;
end;

function TImage.DestRect: TRect;
var
  w, h, cw, ch: Integer;
  xyaspect: Double;
begin
  w := Picture.Width;
  h := Picture.Height;
  cw := ClientWidth;
  ch := ClientHeight;
  if Stretch or (Proportional and ((w > cw) or (h > ch))) then
  begin
    if Proportional and (w > 0) and (h > 0) then
    begin
      xyaspect := w / h;
      if w > h then
      begin
        w := cw;
        h := Trunc(cw / xyaspect);
        if h > ch then  // woops, too big
        begin
          h := ch;
          w := Trunc(ch * xyaspect);
        end;
      end
      else
      begin
        h := ch;
        w := Trunc(ch * xyaspect);
        if w > cw then  // woops, too big
        begin
          w := cw;
          h := Trunc(cw / xyaspect);
        end;
      end;
    end
    else
    begin
      w := cw;
      h := ch;
    end;
  end;

  with Result do
  begin
    Left := 0;
    Top := 0;
    Right := w;
    Bottom := h;
  end;

  if Center then
    OffsetRect(Result, (cw - w) div 2, (ch - h) div 2);
end;

procedure TImage.Paint;

  procedure DoBufferedPaint(Canvas: TCanvas);
  var
    MemDC: HDC;
    Rect: TRect;
    PaintBuffer: HPAINTBUFFER;
  begin
    Rect := DestRect;
    PaintBuffer := BeginBufferedPaint(Canvas.Handle, Rect, BPBF_TOPDOWNDIB, nil, MemDC);
    try
      Canvas.Handle := MemDC;
      Canvas.StretchDraw(DestRect, Picture.Graphic);
      BufferedPaintMakeOpaque(PaintBuffer, Rect);
    finally
      EndBufferedPaint(PaintBuffer, True);
    end;
  end;

var
  Save: Boolean;
begin
  if csDesigning in ComponentState then
    with inherited Canvas do
    begin
      Pen.Style := psDash;
      Brush.Style := bsClear;
      Rectangle(0, 0, Width, Height);
    end;
  Save := FDrawing;
  FDrawing := True;
  try
    if (csGlassPaint in ControlState) and (Picture.Graphic <> nil) and
       not Picture.Graphic.SupportsPartialTransparency then
      DoBufferedPaint(inherited Canvas)
    else
      with inherited Canvas do
        StretchDraw(DestRect, Picture.Graphic);
  finally
    FDrawing := Save;
  end;
end;

function TImage.DoPaletteChange: Boolean;
var
  ParentForm: TCustomForm;
  Tmp: TGraphic;
begin
  Result := False;
  Tmp := Picture.Graphic;
  if Visible and (not (csLoading in ComponentState)) and (Tmp <> nil) and
    (Tmp.PaletteModified) then
  begin
    if (Tmp.Palette = 0) then
      Tmp.PaletteModified := False
    else
    begin
      ParentForm := GetParentForm(Self);
      if Assigned(ParentForm) and ParentForm.Active and Parentform.HandleAllocated then
      begin
        if FDrawing then
          ParentForm.Perform(wm_QueryNewPalette, 0, 0)
        else
          PostMessage(ParentForm.Handle, wm_QueryNewPalette, 0, 0);
        Result := True;
        Tmp.PaletteModified := False;
      end;
    end;
  end;
end;

procedure TImage.Progress(Sender: TObject; Stage: TProgressStage;
  PercentDone: Byte; RedrawNow: Boolean; const R: TRect; const Msg: string);
begin
  if FIncrementalDisplay and RedrawNow then
  begin
    if DoPaletteChange then Update
    else Paint;
  end;
  if Assigned(FOnProgress) then FOnProgress(Sender, Stage, PercentDone, RedrawNow, R, Msg);
end;

function TImage.GetCanvas: TCanvas;
var
  Bitmap: TBitmap;
begin
  if Picture.Graphic = nil then
  begin
    Bitmap := TBitmap.Create;
    try
      Bitmap.Width := Width;
      Bitmap.Height := Height;
      Picture.Graphic := Bitmap;
    finally
      Bitmap.Free;
    end;
  end;
  if Picture.Graphic is TBitmap then
    Result := TBitmap(Picture.Graphic).Canvas
  else
    raise EInvalidOperation.Create(SImageCanvasNeedsBitmap);
end;

procedure TImage.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    PictureChanged(Self);
  end;
end;

procedure TImage.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TImage.SetStretch(Value: Boolean);
begin
  if Value <> FStretch then
  begin
    FStretch := Value;
    PictureChanged(Self);
  end;
end;

procedure TImage.SetTransparent(Value: Boolean);
begin
  if Value <> FTransparent then
  begin
    FTransparent := Value;
    PictureChanged(Self);
  end;
end;

procedure TImage.SetProportional(Value: Boolean);
begin
  if FProportional <> Value then
  begin
    FProportional := Value;
    PictureChanged(Self);
  end;
end;

procedure TImage.PictureChanged(Sender: TObject);
var
  G: TGraphic;
  D : TRect;
begin
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if TLinkObservers.EditLinkEdit(Observers) then
      TLinkObservers.EditLinkModified(Observers);

  if AutoSize and (Picture.Width > 0) and (Picture.Height > 0) then
	SetBounds(Left, Top, Picture.Width, Picture.Height);
  G := Picture.Graphic;
  if G <> nil then
  begin
    if not ((G is TMetaFile) or (G is TIcon)) then
      G.Transparent := FTransparent;
    D := DestRect;
    if (not G.Transparent) and (D.Left <= 0) and (D.Top <= 0) and
       (D.Right >= Width) and (D.Bottom >= Height) then
      ControlStyle := ControlStyle + [csOpaque]
    else  // picture might not cover entire clientrect
      ControlStyle := ControlStyle - [csOpaque];
    if DoPaletteChange and FDrawing then Update;
  end
  else ControlStyle := ControlStyle - [csOpaque];
  if not FDrawing then Invalidate;

  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if TLinkObservers.EditLinkIsEditing(Observers) then
      TLinkObservers.EditLinkUpdate(Observers);
end;

function TImage.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := True;
  if not (csDesigning in ComponentState) or (Picture.Width > 0) and
    (Picture.Height > 0) then
  begin
    if Align in [alNone, alLeft, alRight] then
      NewWidth := Picture.Width;
    if Align in [alNone, alTop, alBottom] then
      NewHeight := Picture.Height;
  end;
end;

{ TBevel }

constructor TBevel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FStyle := bsLowered;
  FShape := bsBox;
  Width := 50;
  Height := 50;
end;

procedure TBevel.SetStyle(Value: TBevelStyle);
begin
  if Value <> FStyle then
  begin
    FStyle := Value;
    Invalidate;
  end;
end;

procedure TBevel.SetShape(Value: TBevelShape);
begin
  if Value <> FShape then
  begin
    FShape := Value;
    Invalidate;
  end;
end;

procedure TBevel.Paint;
const
  XorColor = $00FFD8CE;
var
  Color1, Color2: TColor;
  Temp: TColor;

  procedure BevelRect(const R: TRect);
  begin
    with Canvas do
    begin
      Pen.Color := Color1;
      PolyLine([Point(R.Left, R.Bottom), Point(R.Left, R.Top),
        Point(R.Right, R.Top)]);
      Pen.Color := Color2;
      PolyLine([Point(R.Right, R.Top), Point(R.Right, R.Bottom),
        Point(R.Left, R.Bottom)]);
    end;
  end;

  procedure BevelLine(C: TColor; X1, Y1, X2, Y2: Integer);
  begin
    with Canvas do
    begin
      Pen.Color := C;
      MoveTo(X1, Y1);
      LineTo(X2, Y2);
    end;
  end;

begin
  with Canvas do
  begin
    if (csDesigning in ComponentState) then
    begin
      if (FShape = bsSpacer) then
      begin
        Pen.Style := psDot;
        Pen.Mode := pmXor;
        Pen.Color := XorColor;
        Brush.Style := bsClear;
        Rectangle(0, 0, ClientWidth, ClientHeight);
        Exit;
      end
      else
      begin
        Pen.Style := psSolid;
        Pen.Mode  := pmCopy;
        Pen.Color := clBlack;
        Brush.Style := bsSolid;
      end;
    end;

    Pen.Width := 1;

    if FStyle = bsLowered then
    begin
      Color1 := StyleServices.GetSystemColor(clBtnShadow);
      Color2 := StyleServices.GetSystemColor(clBtnHighlight);
    end
    else
    begin
      Color1 := StyleServices.GetSystemColor(clBtnHighlight);
      Color2 := StyleServices.GetSystemColor(clBtnShadow);
    end;

    case FShape of
      bsBox: BevelRect(Rect(0, 0, Width - 1, Height - 1));
      bsFrame:
        begin
          Temp := Color1;
          Color1 := Color2;
          BevelRect(Rect(1, 1, Width - 1, Height - 1));
          Color2 := Temp;
          Color1 := Temp;
          BevelRect(Rect(0, 0, Width - 2, Height - 2));
        end;
      bsTopLine:
        begin
          BevelLine(Color1, 0, 0, Width, 0);
          BevelLine(Color2, 0, 1, Width, 1);
        end;
      bsBottomLine:
        begin
          BevelLine(Color1, 0, Height - 2, Width, Height - 2);
          BevelLine(Color2, 0, Height - 1, Width, Height - 1);
        end;
      bsLeftLine:
        begin
          BevelLine(Color1, 0, 0, 0, Height);
          BevelLine(Color2, 1, 0, 1, Height);
        end;
      bsRightLine:
        begin
          BevelLine(Color1, Width - 2, 0, Width - 2, Height);
          BevelLine(Color2, Width - 1, 0, Width - 1, Height);
        end;
    end;
  end;
end;

{ TTimer }

constructor TTimer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEnabled := True;
  FInterval := 1000;
  FWindowHandle := AllocateHWnd(WndProc);
end;

destructor TTimer.Destroy;
begin
  FEnabled := False;
  if FWindowHandle <> 0 then
  begin
    UpdateTimer;
    DeallocateHWnd(FWindowHandle);
    FWindowHandle := 0;
  end;
{$IF DEFINED(CLR)}
  System.GC.SuppressFinalize(self);
{$ENDIF}
  inherited Destroy;
end;

{$IF DEFINED(CLR)}
procedure TTimer.Finalize;
begin
  FEnabled := False;
  if FWindowHandle <> 0 then
  begin
    KillTimer(FWindowHandle, 1);
    DeallocateHWnd(FWindowHandle);
    FWindowHandle := 0;
  end;
  inherited;
end;
{$ENDIF}

procedure TTimer.WndProc(var Msg: TMessage);
begin
  with Msg do
    if Msg = WM_TIMER then
      try
        Timer;
      except
        Application.HandleException(Self);
      end
    else
      Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);
end;

procedure TTimer.UpdateTimer;
begin
  KillTimer(FWindowHandle, 1);
  if (FInterval <> 0) and FEnabled and Assigned(FOnTimer) then
    if SetTimer(FWindowHandle, 1, FInterval, nil) = 0 then
      raise EOutOfResources.Create(SNoTimers);
end;

procedure TTimer.SetEnabled(Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    UpdateTimer;
  end;
end;

procedure TTimer.SetInterval(Value: Cardinal);
begin
  if Value <> FInterval then
  begin
    FInterval := Value;
    UpdateTimer;
  end;
end;

procedure TTimer.SetOnTimer(Value: TNotifyEvent);
begin
  FOnTimer := Value;
  UpdateTimer;
end;

procedure TTimer.Timer;
begin
  if Assigned(FOnTimer) then FOnTimer(Self);
end;

{ TCustomPanel }

constructor TCustomPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csSetCaption, csOpaque, csDoubleClicks, csReplicatable, csPannable, csGestures];
  { When themes are on in an application default to making
    TCustomPanel's paint with their ParentBackground }
  if StyleServices.Enabled then
    ControlStyle := ControlStyle + [csParentBackground] - [csOpaque];
  Width := 185;
  Height := 41;
  FAlignment := taCenter;
  FVerticalAlignment := taVerticalCenter;
  BevelOuter := bvRaised;
  BevelWidth := 1;
  FBorderStyle := bsNone;
  Color := clBtnFace;
  FFullRepaint := True;
  UseDockManager := True;
  ParentBackground := True;
  FShowCaption := True;
end;

procedure TCustomPanel.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or BorderStyles[FBorderStyle];
    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

procedure TCustomPanel.CMBorderChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TCustomPanel.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure TCustomPanel.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (FBorderStyle = bsSingle) then RecreateWnd;
  inherited;
end;

procedure TCustomPanel.CMIsToolControl(var Message: TMessage);
begin
  if not FLocked then Message.Result := 1;
end;

procedure TCustomPanel.WMWindowPosChanged(var Message: TWMWindowPosChanged);
var
  BevelPixels: Integer;
  Rect: TRect;
begin
  if FullRepaint or (ShowCaption and (Caption <> '')) then
    Invalidate
  else
  begin
    BevelPixels := BorderWidth;
    if BevelInner <> bvNone then Inc(BevelPixels, BevelWidth);
    if BevelOuter <> bvNone then Inc(BevelPixels, BevelWidth);
    if BevelPixels > 0 then
    begin
      Rect.Right := Width;
      Rect.Bottom := Height;
      if Message.WindowPos.cx <> Rect.Right then
      begin
        Rect.Top := 0;
        Rect.Left := Rect.Right - BevelPixels - 1;
        InvalidateRect(Handle, Rect, True);
      end;
      if Message.WindowPos.cy <> Rect.Bottom then
      begin
        Rect.Left := 0;
        Rect.Top := Rect.Bottom - BevelPixels - 1;
        InvalidateRect(Handle, Rect, True);
      end;
    end;
  end;
  inherited;
end;

procedure TCustomPanel.Paint;
const
  Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
  VerticalAlignments: array[TVerticalAlignment] of Longint = (DT_TOP, DT_BOTTOM, DT_VCENTER);
var
  Rect: TRect;
  LColor: TColor;
  LStyle: TCustomStyleServices;
  LDetails: TThemedElementDetails;
  TopColor, BottomColor: TColor;
  BaseColor, BaseTopColor, BaseBottomColor: TColor;
  //FontHeight: Integer;
  Flags: Longint;

  procedure AdjustColors(Bevel: TPanelBevel);
  begin
    TopColor := BaseTopColor;
    if Bevel = bvLowered then
      TopColor := BaseBottomColor;
    BottomColor := BaseBottomColor;
    if Bevel = bvLowered then
      BottomColor := BaseTopColor;
  end;

begin
  Rect := GetClientRect;

  BaseColor := Color;
  BaseTopColor := clBtnHighlight;
  BaseBottomColor := clBtnShadow;
  LStyle := StyleServices;
  if LStyle.Enabled and (seClient in StyleElements) then
  begin
    LDetails := LStyle.GetElementDetails(tpPanelBackground);
    if LStyle.GetElementColor(LDetails, ecFillColor, LColor) and (LColor <> clNone) then
      BaseColor := LColor;
    LDetails := LStyle.GetElementDetails(tpPanelBevel);
    if LStyle.GetElementColor(LDetails, ecEdgeHighLightColor, LColor) and (LColor <> clNone) then
      BaseTopColor := LColor;
    if LStyle.GetElementColor(LDetails, ecEdgeShadowColor, LColor) and (LColor <> clNone) then
      BaseBottomColor := LColor;
  end;

  if BevelOuter <> bvNone then
  begin
    AdjustColors(BevelOuter);
    Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
  end;
  if not (LStyle.Enabled and (csParentBackground in ControlStyle)) then
    Frame3D(Canvas, Rect, BaseColor, BaseColor, BorderWidth)
  else
    InflateRect(Rect, -Integer(BorderWidth), -Integer(BorderWidth));
  if BevelInner <> bvNone then
  begin
    AdjustColors(BevelInner);
    Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
  end;
  with Canvas do
  begin
    if not LStyle.Enabled or not ParentBackground or not (seClient in StyleElements) then
    begin
      Brush.Color := BaseColor;
      FillRect(Rect);
    end;

    if FShowCaption and (Caption <> '') then
    begin
      Brush.Style := bsClear;
      Font := Self.Font;
      Flags := DT_EXPANDTABS or DT_SINGLELINE or
        VerticalAlignments[FVerticalAlignment] or Alignments[FAlignment];
      Flags := DrawTextBiDiModeFlags(Flags);
      if LStyle.Enabled and (seFont in StyleElements) then
      begin
        LDetails := LStyle.GetElementDetails(tpPanelBackground);
        if not LStyle.GetElementColor(LDetails, ecTextColor, LColor) or (LColor = clNone) then
          LColor := Font.Color;
        LStyle.DrawText(Handle, LDetails, Caption, Rect, TTextFormatFlags(Flags), LColor)
      end
      else
        DrawText(Handle, Caption, -1, Rect, Flags);
    end;
  end;
end;

procedure TCustomPanel.UpdateStyleElements;
begin
  Invalidate;
end;

procedure TCustomPanel.SetAlignment(Value: TAlignment);
begin
  FAlignment := Value;
  Invalidate;
end;

procedure TCustomPanel.SetBevelInner(Value: TPanelBevel);
begin
  FBevelInner := Value;
  Realign;
  Invalidate;
end;

procedure TCustomPanel.SetBevelOuter(Value: TPanelBevel);
begin
  FBevelOuter := Value;
  Realign;
  Invalidate;
end;

procedure TCustomPanel.SetBevelWidth(Value: TBevelWidth);
begin
  FBevelWidth := Value;
  Realign;
  Invalidate;
end;

procedure TCustomPanel.SetBorderWidth(Value: TBorderWidth);
begin
  FBorderWidth := Value;
  Realign;
  Invalidate;
end;

procedure TCustomPanel.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TCustomPanel.SetShowCaption(Value: Boolean);
begin
  if Value <> FShowCaption then
  begin
    FShowCaption := Value;
    Invalidate;
  end;
end;

function TCustomPanel.GetControlsAlignment: TAlignment;
begin
  Result := FAlignment;
end;

procedure TCustomPanel.AdjustClientRect(var Rect: TRect);
var
  BevelSize: Integer;
begin
  inherited AdjustClientRect(Rect);
  InflateRect(Rect, -Integer(BorderWidth), -Integer(BorderWidth));
  BevelSize := 0;
  if BevelOuter <> bvNone then Inc(BevelSize, BevelWidth);
  if BevelInner <> bvNone then Inc(BevelSize, BevelWidth);
  InflateRect(Rect, -BevelSize, -BevelSize);
end;

{$IF DEFINED(CLR)}
function TCustomPanel.DockClient(DockSource: TDragDockObject; MousePos: TPoint): Integer;
{$ELSE}
procedure TCustomPanel.CMDockClient(var Message: TCMDockClient);
{$ENDIF}
var
  R: TRect;
  Dim: Integer;
begin
  if AutoSize then
  begin
    FAutoSizeDocking := True;
    try
{$IF DEFINED(CLR)}
      R := DockSource.DockRect;
{$ELSE}
      R := Message.DockSource.DockRect;
{$ENDIF}
      case Align of
        alLeft: if Width = 0 then Width := R.Right - R.Left;
        alRight: if Width = 0 then
          begin
            Dim := R.Right - R.Left;
            SetBounds(Left - Dim, Top, Dim, Height);
          end;
        alTop: if Height = 0 then Height := R.Bottom - R.Top;
        alBottom: if Height = 0 then
          begin
            Dim := R.Bottom - R.Top;
            SetBounds(Left, Top - Dim, Width, Dim);
          end;
      end;
{$IF DEFINED(CLR)}
      Result := inherited DockClient(DockSource, MousePos);
{$ELSE}
      inherited;
{$ENDIF}
      Exit;
    finally
      FAutoSizeDocking := False;
    end;
  end;
{$IF DEFINED(CLR)}
  Result := inherited DockClient(DockSource, MousePos);
{$ELSE}
  inherited;
{$ENDIF}
end;

function TCustomPanel.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := (not FAutoSizeDocking) and inherited CanAutoSize(NewWidth, NewHeight);
end;

procedure TCustomPanel.SetParentBackground(Value: Boolean);
begin
  { TCustomPanel needs to not have csOpaque when painting
    with the ParentBackground in Themed applications }
  if Value then
    ControlStyle := ControlStyle - [csOpaque]
  else
    ControlStyle := ControlStyle + [csOpaque];
  FParentBackgroundSet := True;
  inherited;
end;

procedure TCustomPanel.SetVerticalAlignment(const Value: TVerticalAlignment);
begin
  FVerticalAlignment := Value;
  Invalidate;
end;

{ TCustomFlowPanel }

procedure TCustomFlowPanel.AlignControls(AControl: TControl; var Rect: TRect);
const
  XIncDir: array[TFlowStyle] of Integer = (1, -1, 1, -1, 1, 1, -1, -1);
  YIncDir: array[TFlowStyle] of Integer = (1, 1, -1, -1, 1, -1, 1, -1);
  YDeltaConst: array[TFlowStyle] of Integer = (0, 0, -1, -1, 0, 0, 0, 0);
  XDeltaConst: array[TFlowStyle] of Integer = (0, 0, 0, 0, 0, 0, -1, -1);
var
  I, Count: Integer;
  MaxHeight, MaxWidth: Integer;
  YDelta, XDelta: Integer;
  Position: TPoint;
  Size: TSize;
  Control: TControl;                                                                        
begin
  if ControlCount > 0 then
  begin
    MaxHeight := 0;
    MaxWidth := 0;
    AdjustClientRect(Rect);
    if AutoSize then
      Rect := TRect.Create(
        Rect.Left,
        Rect.Top,
        Rect.Left + (ExplicitWidth - (Width - (Rect.Right - Rect.Left))),
        Rect.Top + (ExplicitHeight - (Height - (Rect.Bottom - Rect.Top))));
    case FFlowStyle of
      fsLeftRightTopBottom,
      fsTopBottomLeftRight:
        Position := Rect.TopLeft;
      fsRightLeftTopBottom,
      fsTopBottomRightLeft:
        Position := Point(Rect.Right, Rect.Top);
      fsLeftRightBottomTop,
      fsBottomTopLeftRight:
        Position := Point(Rect.Left, Rect.Bottom);
      fsRightLeftBottomTop,
      fsBottomTopRightLeft:
        Position := Rect.BottomRight;
    end;
{$IF DEFINED(CLR)}
    if (AControl <> nil) and (FControlList.IndexOf(AControl) = -1) then
      Count := FControlList.Count
    else
      Count := FControlList.Count - 1;
{$ELSE}
      Count := FControlList.Count - 1;
{$ENDIF}
    for I := 0 to Count do
    begin
{$IF DEFINED(CLR)}
      Control := nil;
      if I < FControlList.Count then
        Control := TControl(FControlList[I])
      else if (AControl <> nil) then
        Control := AControl
      else
        Break;
      if (Control <> nil) and not Control.Visible and not (csDesigning in ComponentState) then
        Continue;
{$ELSE}
      Control := TControl(FControlList[I]);
      if not Control.Visible and not (csDesigning in ComponentState) then
        Continue;
{$ENDIF}
      Size.cx := Control.Margins.ControlWidth;
      Size.cy := Control.Margins.ControlHeight;
      case FFlowStyle of
        fsLeftRightTopBottom,
        fsLeftRightBottomTop:
          if (MaxHeight > 0) and (Position.X + Size.cx >= Rect.Right) and FAutoWrap then
          begin
            Inc(Position.Y, MaxHeight * YIncDir[FFlowStyle]);
            MaxHeight := 0;
            Position.X := Rect.Left;
          end;
        fsRightLeftTopBottom,
        fsRightLeftBottomTop:
          begin
            Dec(Position.X, Size.cx);
            if (MaxHeight > 0) and (Position.X <= 0) and FAutoWrap then
            begin
              Inc(Position.Y, MaxHeight * YIncDir[FFlowStyle]);
              MaxHeight := 0;
              Position.X := Rect.Right - Size.cx;
            end;
          end;
        fsTopBottomLeftRight,
        fsTopBottomRightLeft:
          if (MaxWidth > 0) and (Position.Y + Size.cy >= Rect.Bottom) and FAutoWrap then
          begin
            Inc(Position.X, MaxWidth * XIncDir[FFlowStyle]);
            MaxWidth := 0;
            Position.Y := Rect.Top;
          end;
        fsBottomTopLeftRight,
        fsBottomTopRightLeft:
          begin
            Dec(Position.Y, Size.cy);
            if (MaxWidth > 0) and (Position.Y <= 0) and FAutoWrap then
            begin
              Inc(Position.X, MaxWidth * XIncDir[FFlowStyle]);
              MaxWidth := 0;
              Position.Y := Rect.Bottom - Size.cy;
            end;
          end;
      end;
      YDelta := YDeltaConst[FFlowStyle] * Size.cy;
      XDelta := XDeltaConst[FFlowStyle] * Size.cx;
      if Size.cy > MaxHeight then
        MaxHeight := Size.cy;
      if Size.cx > MaxWidth then
        MaxWidth := Size.cx;
      Control.Margins.SetControlBounds(Position.X + XDelta, Position.Y + YDelta, Size.cx, Size.cy);
      if FFlowStyle in [fsLeftRightTopBottom, fsLeftRightBottomTop] then
        Inc(Position.X, Size.cx * XIncDir[FFlowStyle])
      else if FFlowStyle in [fsTopBottomLeftRight, fsTopBottomRightLeft] then
        Inc(Position.Y, Size.cy + YIncDir[FFlowStyle]);
    end;
    ControlsAligned;
  end;
  if Showing then AdjustSize;
end;

{$IF DEFINED(CLR)}
procedure TCustomFlowPanel.ControlListChanging(Inserting: Boolean; Child: TControl; AParent: TWinControl);
begin
  inherited;
  if Inserting and (AParent = Self) then
  begin
    if FControlList.IndexOf(Child) < 0 then
      FControlList.Add(Child);
  end else
    FControlList.Remove(Child);
end;
{$ENDIF}

{$IF NOT DEFINED(CLR)}
procedure TCustomFlowPanel.CMControlListChanging(var Message: TCMControlListChanging);
begin
  inherited;
  if Message.Inserting and (Message.ControlListItem.Parent = Self) then
  begin
    if FControlList.IndexOf(Message.ControlListItem.Control) < 0 then
      FControlList.Add(Message.ControlListItem.Control);
  end else
    FControlList.Remove(Message.ControlListItem.Control);
end;
{$ENDIF}

constructor TCustomFlowPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutoWrap := True;
  FControlList := TObjectList.Create(False);
end;

destructor TCustomFlowPanel.Destroy;
begin
  inherited;
  FreeAndNil(FControlList);
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TCustomFlowPanel.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  Control: TControl;
begin
  for I := 0 to FControlList.Count - 1 do
  begin
    Control := TControl(FControlList[I]);
    if Control.Owner = Root then Proc(Control);
  end;
end;

function TCustomFlowPanel.GetControlIndex(AControl: TControl): Integer;
begin
  Result := FControlList.IndexOf(AControl);
end;

procedure TCustomFlowPanel.SetAutoWrap(Value: Boolean);
begin
  if FAutoWrap <> Value then
  begin
    FAutoWrap := Value;
    Realign;
  end;
end;

procedure TCustomFlowPanel.SetControlIndex(AControl: TControl; Index: Integer);
var
  CurIndex: Integer;
begin
  CurIndex := GetControlIndex(AControl);
  if (CurIndex > -1) and (CurIndex <> Index) and (Index < FControlList.Count) then
  begin
    FControlList.Move(CurIndex, Index);
    Realign;
  end;
end;

procedure TCustomFlowPanel.SetFlowStyle(Value: TFlowStyle);
begin
  if FFlowStyle <> Value then
  begin
    FFlowStyle := Value;
    Realign;
  end;
end;

{ TCustomGridPanel }

procedure TCustomGridPanel.AlignControls(AControl: TControl; var Rect: TRect);

  procedure ArrangeControlInCell(AControl: TControl; CellRect: TRect; const AlignInfo: TAlignInfo);
  var
    NewBounds: TRect;
    AnchorSubset: TAnchors;
  begin
    if AControl.Align <> alNone then
        ArrangeControl(AControl, Point(CellRect.Right - CellRect.Left, CellRect.Bottom - CellRect.Top),
          AControl.Align, AlignInfo, CellRect, True)
    else
    begin
      AnchorSubset := AControl.Anchors * [akLeft, akRight];
      if AnchorSubset = [akLeft] then
        NewBounds.Left := CellRect.Left
      else if AnchorSubset = [akRight] then
        NewBounds.Left := Max(CellRect.Left, CellRect.Right - AControl.Margins.ExplicitWidth)
      else
        NewBounds.Left := Max(CellRect.Left, CellRect.Left + ((CellRect.Right - CellRect.Left) - AControl.Margins.ControlWidth) div 2);
      NewBounds.Right := NewBounds.Left + Min(CellRect.Right - CellRect.Left, AControl.Margins.ExplicitWidth);
      AnchorSubset := AControl.Anchors * [akTop, akBottom];
      if AnchorSubset = [akTop] then
        NewBounds.Top := CellRect.Top
      else if AnchorSubset = [akBottom] then
        NewBounds.Top := Max(CellRect.Top, CellRect.Bottom - AControl.Margins.ExplicitHeight)
      else
        NewBounds.Top := Max(CellRect.Top, CellRect.Top + ((CellRect.Bottom - CellRect.Top) - AControl.Margins.ControlHeight) div 2);
      NewBounds.Bottom := NewBounds.Top + Min(CellRect.Bottom - CellRect.Top, AControl.Margins.ExplicitHeight);
      AControl.Margins.SetControlBounds(NewBounds, True);
    end;
  end;

  procedure AdjustCellRect(var Rect: TRect);
  begin
    Inc(Rect.Left, Padding.Left);
    Inc(Rect.Top, Padding.Top);
    Dec(Rect.Right, Padding.Right);
    Dec(Rect.Bottom, Padding.Bottom);
  end;

  procedure ArrangeControls;
  var
    I, J, K: Integer;
    CellRect: TRect;
    SpanRect: TRect;
    ControlItem: TControlItem;
    AlignInfo: TAlignInfo;
  begin
    AlignInfo.ControlIndex := 0;
    AlignInfo.AlignList := TList.Create;
    try
      CellRect.Top := Rect.Top;
      for J := 0 to FRowCollection.Count - 1 do
      begin
        CellRect.Left := Rect.Left;
        CellRect.Bottom := CellRect.Top + FRowCollection[J].Size;
        for I := 0 to FColumnCollection.Count - 1 do
        begin
          ControlItem := FControlCollection.ControlItems[I, J];
          CellRect.Right := CellRect.Left + FColumnCollection[I].Size;
          if (ControlItem <> nil) and (ControlItem.Control <> nil) and
             (ControlItem.Column = I) and (ControlItem.Row = J) then
          begin
            AlignInfo.AlignList.Clear;
            AlignInfo.AlignList.Add(ControlItem.Control);
            AlignInfo.Align := ControlItem.Control.Align;
            SpanRect := CellRect;
            if ControlItem.ColumnSpan > 1 then
              for K := I + 1 to Min(I + ControlItem.ColumnSpan - 1, FColumnCollection.Count - 1) do
                Inc(SpanRect.Right, FColumnCollection[K].Size);
            if ControlItem.RowSpan > 1 then
              for K := J + 1 to Min(J + ControlItem.RowSpan - 1, FRowCollection.Count - 1 ) do
                Inc(SpanRect.Bottom, FRowCollection[K].Size);
            AdjustCellRect(SpanRect);
            ArrangeControlInCell(ControlItem.Control, SpanRect, AlignInfo);
          end;
          CellRect.Left := CellRect.Right;
        end;
        CellRect.Top := CellRect.Bottom;
      end;
    finally
      AlignInfo.AlignList.Free;
    end;
  end;

begin
  AdjustClientRect(Rect);
  if FRecalcCellSizes then
    RecalcCellDimensions(Rect);
  if ControlCount > 0 then
    ArrangeControls;
end;

function TCustomGridPanel.AutoAddColumn: TColumnItem;
begin
  Result := FColumnCollection.Add;
  Result.SizeStyle := ssAuto;
  Result.AutoAdded := True;
end;

function TCustomGridPanel.AutoAddRow: TRowItem;
begin
  Result := FRowCollection.Add;
  Result.SizeStyle := ssAuto;
  Result.AutoAdded := True;
end;

procedure TCustomGridPanel.CellIndexToCell(AIndex: Integer; var AColumn, ARow: Integer);
begin
  if FExpandStyle in [emAddColumns, emFixedSize] then
  begin
    AColumn := AIndex div FRowCollection.Count;
    ARow := AIndex mod FRowCollection.Count;
  end else
  begin
    ARow := AIndex div FColumnCollection.Count;
    AColumn := AIndex mod FColumnCollection.Count;
  end;
end;

function TCustomGridPanel.CellToCellIndex(AColumn, ARow: Integer): Integer;
begin
  if FExpandStyle in [emAddColumns, emFixedSize] then
    Result := ColumnSpanIndex[AColumn, ARow]
  else
    Result := RowSpanIndex[AColumn, ARow];
end;

constructor TCustomGridPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRowCollection := TRowCollection.Create(Self);
  FColumnCollection := TColumnCollection.Create(Self);
  FControlCollection := TControlCollection.Create(Self);
  FRecalcCellSizes := True;
  FRowCollection.Add;
  FRowCollection.Add;
  FColumnCollection.Add;
  FColumnCollection.Add;
end;

{$IF DEFINED(CLR)}
procedure TCustomGridPanel.ControlChange(Inserting: Boolean; Child: TControl);
begin
  inherited ControlChange(Inserting, Child);
  if not (csLoading in ComponentState) then
    if Inserting and (Child.Parent = Self) then
    begin
      DisableAlign;
      try
        Child.Anchors := [];
        FControlCollection.AddControl(Child);
      finally
        EnableAlign;
      end;
    end else
      FControlCollection.RemoveControl(Child);
end;
{$ENDIF}

{$IF NOT DEFINED(CLR)}
procedure TCustomGridPanel.CMControlChange(var Message: TCMControlChange);
begin
  inherited;
  if not (csLoading in ComponentState) then
    if Message.Inserting and (Message.Control.Parent = Self) then
    begin
      DisableAlign;
      try
        Message.Control.Anchors := [];
        FControlCollection.AddControl(Message.Control);
      finally
        EnableAlign;
      end;
    end else
      FControlCollection.RemoveControl(Message.Control);
end;
{$ENDIF}

destructor TCustomGridPanel.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FRowCollection);
  FreeAndNil(FColumnCollection);
  FreeAndNil(FControlCollection);
end;

function TCustomGridPanel.GetCellCount: Integer;
begin
  Result := FRowCollection.Count * FColumnCollection.Count;
end;

function TCustomGridPanel.GetCellRect(AColumn, ARow: Integer): TRect;
var
  I: Integer;
begin
  Result.Left := 0;
  Result.Top := 0;
  for I := 0 to AColumn - 1 do
    Inc(Result.Left, FColumnCollection[I].Size);
  for I := 0 to ARow - 1 do
    Inc(Result.Top, FRowCollection[I].Size);
  Result.BottomRight := CellSize[AColumn, ARow];
  Inc(Result.Bottom, Result.Top);
  Inc(Result.Right, Result.Left);
end;

function TCustomGridPanel.GetCellSizes(AColumn, ARow: Integer): TPoint;
begin
  Result := Point(FColumnCollection[AColumn].Size, FRowCollection[ARow].Size);
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TCustomGridPanel.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  ControlItem: TControlItem;
begin
  for I := 0 to FControlCollection.Count - 1 do
  begin
    ControlItem := TControlItem(FControlCollection.Items[I]);
    if (ControlItem.Control <> nil) and (ControlItem.Control.Owner = Root) then
      Proc(ControlItem.Control);
  end;
end;

function TCustomGridPanel.GetColumnSpanIndex(AColumn, ARow: Integer): Integer;
begin
  Result := AColumn + (ARow * FColumnCollection.Count);
end;

function TCustomGridPanel.GetRowSpanIndex(AColumn, ARow: Integer): Integer;
begin
  Result := ARow + (AColumn * FRowCollection.Count);
end;

function TCustomGridPanel.IsColumnEmpty(AColumn: Integer): Boolean;
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
    raise EGridPanelException.CreateFmt(sInvalidColumnIndex, [AColumn]);
end;

function TCustomGridPanel.IsRowEmpty(ARow: Integer): Boolean;
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
    raise EGridPanelException.CreateFmt(sInvalidRowIndex, [ARow]);
end;

procedure TCustomGridPanel.Loaded;
var
  LItem: TCollectionItem;
begin
  inherited;
  for LItem in ControlCollection do
    with TControlItem(LItem) do
      TControlItem(LItem).InternalSetLocation(Column, Row, False, True);
end;

procedure TCustomGridPanel.Paint;
var
  I: Integer;
  LinePos, Size: Integer;
  ClientRect: TRect;
begin
  inherited;
  if csDesigning in ComponentState then
  begin
    LinePos := 0;
    Canvas.Pen.Style := psDot;
    Canvas.Pen.Color := clBlack;
    ClientRect := GetClientRect;
    for I := 0 to FColumnCollection.Count - 2 do
    begin
      Size := FColumnCollection[I].Size;
      Canvas.MoveTo(LinePos + Size, ClientRect.Top);
      Canvas.LineTo(LinePos + Size, ClientRect.Bottom);
      Inc(LinePos, Size);
    end;
    LinePos := 0;
    for I := 0 to FRowCollection.Count - 2 do
    begin
      Size := FRowCollection[I].Size;
      Canvas.MoveTo(ClientRect.Left, LinePos + Size);
      Canvas.LineTo(ClientRect.Right, LinePos + Size);
      Inc(LinePos, Size);
    end;
  end;
end;

procedure TCustomGridPanel.RecalcCellDimensions(const Rect: TRect);
var
  I, J: Integer;
  LSize, XSize, YSize, RemainingX, RemainingY: Integer;
  MaxSize, PercentXCount, PercentYCount: Integer;
  PercentX, PercentY: Double;
  ControlItem: TControlItem;
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
    with FColumnCollection[I] do
      if SizeStyle = ssAbsolute then
        Dec(XSize, Trunc(Value))
      else if SizeStyle = ssPercent then
      begin
        PercentX := PercentX + Value;
        Inc(PercentXCount);
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
            LSize := ControlItem.Control.Margins.ControlWidth + Self.Padding.Left + Self.Padding.Right;
            if LSize > MaxSize then
              MaxSize := LSize;
          end;
        end;
        Dec(XSize, MaxSize);
        Size := MaxSize;
      end;
  PercentYCount := 0;
  for I := 0 to FRowCollection.Count - 1 do
    with FRowCollection[I] do
      if SizeStyle = ssAbsolute then
        Dec(YSize, Trunc(Value))
      else if SizeStyle = ssPercent then
      begin
        PercentY := PercentY + Value;
        Inc(PercentYCount);
      end else
      begin
        MaxSize := 0;
        for J := 0 to FColumnCollection.Count - 1 do
        begin
          ControlItem := FControlCollection.ControlItems[J, I];
          if (ControlItem <> nil) and (ControlItem.Control <> nil) and
             (ControlItem.Column = J) and (ControlItem.Row = I) then
          begin
            LSize := ControlItem.Control.Margins.ControlHeight + Self.Padding.Top + Self.Padding.Bottom;
            if LSize > MaxSize then
              MaxSize := LSize;
          end;
        end;
        Dec(YSize, MaxSize);
        Size := MaxSize;
      end;
  // Finally Calculate the size of the percentage-based columns and rows based on the remaining
  // X and Y sizes
  RemainingX := XSize;
  RemainingY := YSize;
  for I := 0 to FColumnCollection.Count - 1 do
    with FColumnCollection[I] do
      if SizeStyle = ssPercent then
      begin
        if IsZero(PercentX) then
          Value := 100.0 / PercentXCount
        else
          Value := (Value / PercentX) * 100.0;
        Size := Trunc(XSize * (Value / 100.0));
        Dec(RemainingX, Size);
        if (RemainingX > 0) and (I = FColumnCollection.Count - 1) then
          Size := Size + RemainingX;
      end;
  for I := 0 to FRowCollection.Count - 1 do
    with FRowCollection[I] do
      if SizeStyle = ssPercent then
      begin
        if IsZero(PercentY) then
          Value := 100.0 / PercentYCount
        else
          Value := (Value / PercentY) * 100.0;
        Size := Trunc(YSize * (Value / 100.0));
        Dec(RemainingY, Size);
        if (RemainingY > 0) and (I = FRowCollection.Count - 1) then
          Size := Size + RemainingY;
      end;
  FRecalcCellSizes := False;
end;

procedure TCustomGridPanel.RemoveEmptyAutoAddColumns;
var
  I: Integer;
begin
  for I := FColumnCollection.Count - 1 downto 0 do
    if FColumnCollection[I].AutoAdded and IsColumnEmpty(I) then
      FColumnCollection.Delete(I)
    else
      Exit;
end;

procedure TCustomGridPanel.RemoveEmptyAutoAddRows;
var
  I: Integer;
begin
  for I := FRowCollection.Count - 1 downto 0 do
    if FRowCollection[I].AutoAdded and IsRowEmpty(I) then
      FRowCollection.Delete(I)
    else
      Exit;
end;

procedure TCustomGridPanel.SetControlCollection(const Value: TControlCollection);
begin
  FControlCollection.Assign(Value);
end;

procedure TCustomGridPanel.SetRowCollection(const Value: TRowCollection);
begin
  FRowCollection.Assign(Value);
end;

procedure TCustomGridPanel.SetColumnCollection(const Value: TColumnCollection);
begin
  FColumnCollection.Assign(Value);
end;

procedure TCustomGridPanel.UpdateControlsColumn(AColumn: Integer);
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

procedure TCustomGridPanel.UpdateControlsRow(ARow: Integer);
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

procedure TCustomGridPanel.UpdateControlOriginalParentSize(AControl: TControl; var AOriginalParentSize: TPoint);
var
  Rect: TRect;
  Index: Integer;
  ControlItem: TControlItem;
begin
  if FRecalcCellSizes and HandleAllocated then
  begin
    Rect := GetClientRect;
    AdjustClientRect(Rect);
    RecalcCellDimensions(Rect);
  end;
  Index := FControlCollection.IndexOf(AControl);
  if Index > -1 then
  begin
    ControlItem := FControlCollection[Index];
    AOriginalParentSize := CellSize[ControlItem.Column, ControlItem.Row]
  end else
    inherited UpdateControlOriginalParentSize(AControl, AOriginalParentSize);
end;

procedure TCustomGridPanel.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  FRecalcCellSizes := True;
end;

{ TCellItem }

procedure TCellItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TCellItem then
    with TCellItem(Dest) do
    begin
      FSizeStyle := Self.FSizeStyle;
      FValue := Self.FValue;
      FSize := Self.FSize;
    end;
end;

constructor TCellItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FSizeStyle := ssPercent;
end;

procedure TCellItem.SetSizeStyle(Value: TSizeStyle);
begin
  if Value <> FSizeStyle then
  begin
    FSizeStyle := Value;
    Changed(False);
  end;
end;

procedure TCellItem.SetValue(Value: Double);
begin
  if Value <> FValue then
  begin
    if FSizeStyle = ssAbsolute then
    begin
      FSize := Trunc(Value);
      FValue := FSize;
    end else
      FValue := Value;
    Changed(False);
  end;
end;

{ TCellCollection }

function TCellCollection.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := sCellMember;
    1: Result := sCellSizeType;
    2: Result := sCellValue;
  else
    Result := '';
  end;
end;

function TCellCollection.GetAttrCount: Integer;
begin
  Result := 3;
end;

function TCellCollection.GetItem(Index: Integer): TCellItem;
begin
  Result := TCellItem(inherited GetItem(Index));
end;

function TCellCollection.GetItemAttr(Index, ItemIndex: Integer): string;

  function GetSizeStyleString(Index: Integer): string;
  begin
    with Items[Index] do
      case SizeStyle of
        ssAbsolute: Result := sCellAbsoluteSize;
        ssPercent: Result := sCellPercentSize;
        ssAuto: Result := sCellAutoSize;
      else
        Result := '';
      end;
  end;

  function GetValueString(Index: Integer): string;
  begin
    with Items[Index] do
      if SizeStyle = ssAbsolute then
        Result := IntToStr(Trunc(Value))
      else if SizeStyle = ssPercent then
        Result := Format('%3.2f%%', [Value]) // do not localize
      else Result := sCellAutoSize;
  end;

begin
  case Index of
    1: Result := GetSizeStyleString(ItemIndex);
    2: Result := GetValueString(ItemIndex);
  else
    Result := '';
  end;
end;

function TCellCollection.Owner: TCustomGridPanel;
begin
  Result := GetOwner as TCustomGridPanel;
end;

procedure TCellCollection.SetItem(Index: Integer; Value: TCellItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TCellCollection.Update(Item: TCollectionItem);
begin
  inherited;
  if Owner <> nil then
    with Owner do
    begin
      FRecalcCellSizes := True;
      Invalidate;
      Realign;
    end;
end;

{ TRowCollection }

constructor TRowCollection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TRowItem);
end;

function TRowCollection.Add: TRowItem;
begin
  Result := TRowItem(inherited Add);
end;

function TRowCollection.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  if Index = 0 then
    Result := Format(sCellRow, [ItemIndex])
  else
    Result := inherited GetItemAttr(Index, ItemIndex);
end;

procedure TRowCollection.Notify(Item: TCollectionItem;
  Action: System.Classes.TCollectionNotification);
begin
  inherited;
  if (Action = System.Classes.TCollectionNotification.cnExtracting) and not (csDestroying in Owner.ComponentState) and
     not (csUpdating in Owner.ComponentState) then
    if not Owner.IsRowEmpty(Item.Index) then
      raise EGridPanelException.Create(sCannotDeleteRow)
    else Owner.UpdateControlsRow(Item.Index);
end;

{ TColumnCollection }

constructor TColumnCollection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TColumnItem);
end;

function TColumnCollection.Add: TColumnItem;
begin
  Result := TColumnItem(inherited Add);
end;

function TColumnCollection.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  if Index = 0 then
    Result := Format(sCellColumn, [ItemIndex])
  else
    Result := inherited GetItemAttr(Index, ItemIndex);
end;

procedure TColumnCollection.Notify(Item: TCollectionItem;
  Action: System.Classes.TCollectionNotification);
begin
  inherited;
  if (Action = System.Classes.TCollectionNotification.cnExtracting) and not (csDestroying in Owner.ComponentState) and
     not (csUpdating in Owner.ComponentState) then
    if not Owner.IsColumnEmpty(Item.Index) then
      raise EGridPanelException.Create(sCannotDeleteColumn)
    else
      Owner.UpdateControlsColumn(Item.Index);
end;

{ TControlCollection }

function TControlCollection.Add: TControlItem;
begin
  Result := TControlItem(inherited Add);
end;

procedure TControlCollection.AddControl(AControl: TControl; AColumn, ARow: Integer);

  procedure PlaceInCell(ControlItem: TControlItem);
  var
    I, J: Integer;
  begin
    with ControlItem do
    try
      Control := AControl;
      FRow := -1;
      FColumn := -1;
      if (ARow = -1) and (AColumn > -1) then
      begin
        for I := 0 to Owner.RowCollection.Count - 1 do
          if Controls[AColumn, I] = nil then
          begin
            Row := I;
            Column := AColumn;
            Exit;
          end;
        AColumn := -1;
      end;
      if (AColumn = -1) and (ARow > -1) then
      begin
        for I := 0 to Owner.ColumnCollection.Count - 1 do
          if Controls[I, ARow] = nil then
          begin
            Column := I;
            Row := ARow;
            Exit;
          end;
        ARow := -1;
      end;
      if (AColumn > -1) and (ARow > -1) then
      begin
        if Controls[AColumn, ARow] = nil then
        begin
          Column := AColumn;
          Row := ARow;
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
              Row := J;
              Column := I;
              Exit;
            end;
      end;
      if (Row = -1) or (Column = -1) then
        if (Owner <> nil) and (Owner.ExpandStyle <> emFixedSize) then
        begin
          if Owner.ExpandStyle = emAddRows then
            Owner.AutoAddRow
          else
            Owner.AutoAddColumn;
          PlaceInCell(ControlItem);
        end else
          raise EGridPanelException.Create(sCannotAddFixedSize);
    except
      Control := nil;
      Free;
      raise;
    end;
  end;

begin
  if IndexOf(AControl) < 0 then
    PlaceInCell(Add);
end;

constructor TControlCollection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TControlItem);
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
function TControlCollection.GetControl(AColumn, ARow: Integer): TControl;
var
  ControlItem: TControlItem;
begin
  ControlItem := GetControlItem(AColumn, ARow);
  if ControlItem <> nil then
    Result := ControlItem.Control
  else
    Result := nil;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
function TControlCollection.GetControlItem(AColumn, ARow: Integer): TControlItem;
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

function TControlCollection.GetItem(Index: Integer): TControlItem;
begin
  Result := TControlItem(inherited GetItem(Index));
end;

function TControlCollection.IndexOf(AControl: TControl): Integer;
begin
  for Result := 0 to Count - 1 do
    if TControlItem(Items[Result]).Control = AControl then
      Exit;
  Result := -1;
end;

function TControlCollection.Owner: TCustomGridPanel;
begin
  Result := TCustomGridPanel(GetOwner);
end;

procedure TControlCollection.RemoveControl(AControl: TControl);
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

procedure TControlCollection.SetControl(AColumn, ARow: Integer; Value: TControl);
var
  Index: Integer;
  ControlItem: TControlItem;
begin
  if Owner <> nil then
  begin
    if (AColumn < 0) or (AColumn >= Owner.ColumnCollection.Count) then
      raise EGridPanelException.CreateFmt(sInvalidColumnIndex, [AColumn]);
    if (ARow < 0) or (ARow >= Owner.RowCollection.Count) then
      raise EGridPanelException.CreateFmt(sInvalidRowIndex, [ARow]);
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

procedure TControlCollection.SetItem(Index: Integer; Value: TControlItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TControlCollection.Update(Item: TCollectionItem);
begin
  inherited;
  if Owner <> nil then
  begin
    Owner.FRecalcCellSizes := True;
    Owner.Invalidate;
    Owner.Realign;
  end;
end;

{ TControlItem }

procedure TControlItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TControlItem then
    with TControlItem(Dest) do
    begin
      FControl := Self.Control;
      FRow := Self.Row;
      FColumn := Self.Column;
      Changed(False);
    end;
end;

constructor TControlItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FRowSpan := 1;
  FColumnSpan := 1;
end;

destructor TControlItem.Destroy;
var
  LControl: TControl;
begin
  if Assigned(FControl) and not (csLoading in GridPanel.ComponentState) and
     not (csUpdating in GridPanel.ComponentState) and
     not (csDestroying in GridPanel.ComponentState) then
  begin
    LControl := FControl;
    FControl := nil;
    GridPanel.RemoveControl(LControl);
    LControl.Free;
  end;
  inherited;
end;

function TControlItem.GetGridPanel: TCustomGridPanel;
var
  Owner: TControlCollection;
begin
  Owner := TControlCollection(GetOwner);
  if Owner <> nil then
    Result := Owner.Owner
  else
    Result := nil;
end;

procedure TControlItem.SetControl(Value: TControl);
begin
  if FControl <> Value then
  begin
{$IF DEFINED(CLR)}
    if Assigned(Value) and Value.Equals(GridPanel) then
{$ELSE}
    if Value = GridPanel then
{$ENDIF}
      raise EGridPanelException.Create(sInvalidControlItem);
    FControl := Value;
    Changed(False);
  end;
end;

procedure TControlItem.SetColumn(Value: Integer);
begin
  if FColumn <> Value then
  begin
    if not (csLoading in GridPanel.ComponentState) then
    begin
      if (Value < 0)or (Value > GridPanel.ColumnCollection.Count - 1) then
        raise EGridPanelException.CreateFmt(sInvalidColumnIndex, [Value]);
      InternalSetLocation(Value, FRow, False, True);
    end
    else
      FColumn := Value;
  end;
end;

procedure TControlItem.SetRow(Value: Integer);
begin
  if FRow <> Value then
  begin
    if not (csLoading in GridPanel.ComponentState) then
    begin
      if (Value < 0) or (Value > GridPanel.RowCollection.Count - 1) then
        raise EGridPanelException.CreateFmt(sInvalidRowIndex, [Value]);
      InternalSetLocation(FColumn, Value, False, True);
    end
    else
      FRow := Value;
  end;
end;

type
  TNewLocationRec = record
    ControlItem: TControlItem;
    NewColumn, NewRow: Integer;
    Pushed: Boolean;
  end;
  TNewLocationRecs = array of TNewLocationRec;

  TNewLocations = class
  private
    FNewLocations: TNewLocationRecs;
    FCount: Integer;
  public
    function AddNewLocation(AControlItem: TControlItem; ANewColumn, ANewRow: Integer; APushed: Boolean = False): Integer;
    procedure ApplyNewLocations;
    property Count: Integer read FCount;
    property NewLocations: TNewLocationRecs read FNewLocations;
  end;

function TNewLocations.AddNewLocation(AControlItem: TControlItem; ANewColumn, ANewRow: Integer; APushed: Boolean): Integer;
begin
  if FCount = Length(FNewLocations) then
    SetLength(FNewLocations, Length(FNewLocations) + 10);
  Result := FCount;
  Inc(FCount);
  with FNewLocations[Result] do
  begin
    ControlItem := AControlItem;
    NewColumn := ANewColumn;
    NewRow := ANewRow;
    Pushed := APushed;
  end;
end;

procedure TNewLocations.ApplyNewLocations;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    with FNewLocations[I] do
      if ControlItem <> nil then
        ControlItem.InternalSetLocation(NewColumn, NewRow, Pushed, False);
end;

procedure TControlItem.SetRowSpan(Value: TCellSpan);
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
      raise EGridPanelException.CreateFmt(sInvalidSpan, [Value]);
    Collection := TControlCollection(GetOwner);
    if Collection = nil then Exit;
    GridPanel.DisableAlign;
    try
      NewLocations := TNewLocations.Create;
      try
        if FRowSpan > Value then
        begin
          Delta := FRowSpan - Value;
          FRowSpan := Value;
          if GridPanel.ExpandStyle in [emAddRows, emFixedSize] then
          begin
            NumRows := GridPanel.RowCollection.Count;
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
            GridPanel.RemoveEmptyAutoAddRows;
          end else
          begin
            // Scan forward in row primary order, removing Delta from position of each
            // control item, unwrapping where nessesary, until the last control is reached
            // or a non "pushed" control is found.
            for I := GridPanel.RowSpanIndex[FColumn, FRow] to GridPanel.CellCount - 1 do
            begin
              GridPanel.CellIndexToCell(I, LColumn, LRow);
              ControlItem := Collection.ControlItems[LColumn, LRow];
              if ControlItem <> nil then
              begin
                if ControlItem.Pushed then
                begin
                  if (ControlItem.Column = LColumn) and (ControlItem.Row = LRow) then
                  begin
                    GridPanel.CellIndexToCell(I - Delta, LColumn, LRow);
                    if (LRow > 0) and (LRow + ControlItem.RowSpan > GridPanel.RowCollection.Count) then
                    begin
                      Inc(Delta, (LRow + ControlItem.RowSpan) - GridPanel.RowCollection.Count);
                      GridPanel.CellIndexToCell(I - Delta, LColumn, LRow);
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
            GridPanel.RemoveEmptyAutoAddRows;
          end;
        end else
        begin
          NumRows := GridPanel.RowCollection.Count;
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
          if GridPanel.ExpandStyle in [emAddRows, emFixedSize] then
          begin
            if (GridPanel.ExpandStyle = emFixedSize) and (NumToAdd > 0) then
              raise EGridPanelException.Create(sCannotAddFixedSize);
            while NumToAdd > 0 do
            begin
              GridPanel.AutoAddRow;
              Dec(NumToAdd);
            end;
            NumRows := GridPanel.RowCollection.Count;
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
            for I := GridPanel.RowSpanIndex[FColumn, FRow] to GridPanel.CellCount - 1 do
            begin
              GridPanel.CellIndexToCell(I, LColumn, LRow);
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
                  GridPanel.CellIndexToCell(I + IndexDelta, LColumn, LRow);
                end;
                if LRow + Span > GridPanel.RowCollection.Count then
                begin
                  if LRow > 0 then
                  begin
                    Inc(IndexDelta, GridPanel.RowCollection.Count - LRow);
                    GridPanel.CellIndexToCell(I + IndexDelta - NumToAdd, LColumn, LRow);
                  end else if ControlItem <> Self then
                  begin
                    Inc(IndexDelta, Min(Span, GridPanel.RowCollection.Count));
                    GridPanel.CellIndexToCell(I + IndexDelta, LColumn, LRow);
                  end else if (ControlItem = Self) and (LRow = 0) then
                    Exit;
                end;
                NumToAdd := 0;
                NewLocations.AddNewLocation(ControlItem, LColumn, LRow, True);
              end;
            end;
            for I := 0 to NewLocations.Count - 1 do
              if NewLocations.NewLocations[I].NewColumn > GridPanel.ColumnCollection.Count - 1 then
                GridPanel.AutoAddColumn;
            NewLocations.ApplyNewLocations;
          end;
          FRowSpan := Value;
        end;
        Changed(False);
      finally
        NewLocations.Free;
      end;
    finally
      GridPanel.EnableAlign;
    end;
  end;
end;

procedure TControlItem.SetColumnSpan(Value: TCellSpan);
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
      raise EGridPanelException.CreateFmt(sInvalidSpan, [Value]);
    Collection := TControlCollection(GetOwner);
    if Collection = nil then Exit;
    GridPanel.DisableAlign;
    try
      NewLocations := TNewLocations.Create;
      try
        if FColumnSpan > Value then
        begin
          Delta := FColumnSpan - Value;
          FColumnSpan := Value;
          if GridPanel.ExpandStyle in [emAddColumns, emFixedSize] then
          begin
            NumColumns := GridPanel.ColumnCollection.Count;
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
            GridPanel.RemoveEmptyAutoAddColumns;
          end else
          begin
            // Scan forward in column primary order, removing Delta from position of each
            // control item, unwrapping where nessesary, until the last control is reached
            // or a non "pushed" control is found.
            for I := GridPanel.ColumnSpanIndex[FColumn, FRow] to GridPanel.CellCount - 1 do
            begin
              GridPanel.CellIndexToCell(I, LColumn, LRow);
              ControlItem := Collection.ControlItems[LColumn, LRow];
              if ControlItem <> nil then
              begin
                if ControlItem.Pushed then
                begin
                  if (ControlItem.Column = LColumn) and (ControlItem.Row = LRow) then
                  begin
                    GridPanel.CellIndexToCell(I - Delta, LColumn, LRow);
                    if (LColumn > 0) and (LColumn + ControlItem.ColumnSpan > GridPanel.ColumnCollection.Count) then
                    begin
                      Inc(Delta, (LColumn + ControlItem.ColumnSpan) - GridPanel.ColumnCollection.Count);
                      GridPanel.CellIndexToCell(I - Delta, LColumn, LRow);
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
            GridPanel.RemoveEmptyAutoAddRows;
          end;
        end else
        begin
          NumColumns := GridPanel.ColumnCollection.Count;
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
          if GridPanel.ExpandStyle in [emAddColumns, emFixedSize] then
          begin
            if (GridPanel.ExpandStyle = emFixedSize) and (NumToAdd > 0) then
              raise EGridPanelException.Create(sCannotAddFixedSize);
            while NumToAdd > 0 do
            begin
              GridPanel.AutoAddColumn;
              Dec(NumToAdd);
            end;
            NumColumns := GridPanel.ColumnCollection.Count;
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
            for I := GridPanel.ColumnSpanIndex[FColumn, FRow] to GridPanel.CellCount - 1 do
            begin
              GridPanel.CellIndexToCell(I, LColumn, LRow);
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
                  GridPanel.CellIndexToCell(I + IndexDelta, LColumn, LRow);
                end;
                if LColumn + Span > GridPanel.ColumnCollection.Count then
                begin
                  if LColumn > 0 then
                  begin
                    Inc(IndexDelta, GridPanel.ColumnCollection.Count - LColumn);
                    GridPanel.CellIndexToCell(I + IndexDelta - NumToAdd, LColumn, LRow);
                  end else if ControlItem <> Self then
                  begin
                    Inc(IndexDelta, Min(Span, GridPanel.ColumnCollection.Count));
                    GridPanel.CellIndexToCell(I + IndexDelta, LColumn, LRow);
                  end else if (ControlItem = Self) and (LColumn = 0) then
                    Exit;
                end;
                NumToAdd := 0;
                NewLocations.AddNewLocation(ControlItem, LColumn, LRow, True);
              end;
            end;
            for I := 0 to NewLocations.Count - 1 do
              if NewLocations.NewLocations[I].NewRow > GridPanel.RowCollection.Count - 1 then
                GridPanel.AutoAddRow;
            NewLocations.ApplyNewLocations;
          end;
          FColumnSpan := Value;
        end;
        Changed(False);
      finally
        NewLocations.Free;
      end;
    finally
      GridPanel.EnableAlign;
    end;
  end;
end;

procedure TControlItem.InternalSetLocation(AColumn, ARow: Integer; APushed, MoveExisting: Boolean);
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

procedure TControlItem.SetLocation(AColumn, ARow: Integer; APushed: Boolean);
begin
  InternalSetLocation(AColumn, ARow, APushed, True);
end;

function TControlItem.GetPushed: Boolean;
begin
  Result := FPushed > 0;
end;

{ TPageAccess }

type
  TPageAccess = class(TStrings)
  private
    PageList: TList;
    Notebook: TNotebook;
  protected
    function GetCount: Integer; override;
    function Get(Index: Integer): string; override;
    procedure Put(Index: Integer; const S: string); override;
    function GetObject(Index: Integer): TObject; override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    constructor Create(APageList: TList; ANotebook: TNotebook);
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure Move(CurIndex, NewIndex: Integer); override;
  end;

constructor TPageAccess.Create(APageList: TList; ANotebook: TNotebook);
begin
  inherited Create;
  PageList := APageList;
  Notebook := ANotebook;
end;

function TPageAccess.GetCount: Integer;
begin
  Result := PageList.Count;
end;

function TPageAccess.Get(Index: Integer): string;
begin
  Result := TPage(PageList[Index]).Caption;
end;

procedure TPageAccess.Put(Index: Integer; const S: string);
begin
  TPage(PageList[Index]).Caption := S;
end;

function TPageAccess.GetObject(Index: Integer): TObject;
begin
  Result := PageList[Index];
end;

procedure TPageAccess.SetUpdateState(Updating: Boolean);
begin
  { do nothing }
end;

procedure TPageAccess.Clear;
var
  I: Integer;
begin
  for I := 0 to PageList.Count - 1 do
    TPage(PageList[I]).Free;
  PageList.Clear;
end;

procedure TPageAccess.Delete(Index: Integer);
var
  Form: TCustomForm;
begin
  TPage(PageList[Index]).Free;
  PageList.Delete(Index);
  NoteBook.PageIndex := 0;

  if csDesigning in NoteBook.ComponentState then
  begin
    Form := GetParentForm(NoteBook);
    if (Form <> nil) and (Form.Designer <> nil) then
      Form.Designer.Modified;
  end;
end;

procedure TPageAccess.Insert(Index: Integer; const S: string);
var
  Page: TPage;
  Form: TCustomForm;
begin
  Page := TPage.Create(Notebook);
  with Page do
  begin
    Parent := Notebook;
    Caption := S;
  end;
  PageList.Insert(Index, Page);

  NoteBook.PageIndex := Index;

  if csDesigning in NoteBook.ComponentState then
  begin
    Form := GetParentForm(NoteBook);
    if (Form <> nil) and (Form.Designer <> nil) then
      Form.Designer.Modified;
  end;
end;

procedure TPageAccess.Move(CurIndex, NewIndex: Integer);
var
  AObject: TObject;
begin
  if CurIndex <> NewIndex then
  begin
    AObject := PageList[CurIndex];
    PageList[CurIndex] := PageList[NewIndex];
    PageList[NewIndex] := AObject;
  end;
end;

{ TPage }

constructor TPage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Visible := False;
  ControlStyle := ControlStyle + [csAcceptsControls, csNoDesignVisible,
    csParentBackground];
  Align := alClient;
end;

procedure TPage.Paint;
begin
  inherited Paint;
  if csDesigning in ComponentState then
    with Canvas do
    begin
      Pen.Style := psDash;
      Brush.Style := bsClear;
      Rectangle(0, 0, Width, Height);
    end;
end;

procedure TPage.ReadState(Reader: TReader);
begin
  if Reader.Parent is TNotebook then
    TNotebook(Reader.Parent).FPageList.Add(Self);
  inherited ReadState(Reader);
end;

procedure TPage.WMNCHitTest(var Message: TWMNCHitTest);
begin
  if not (csDesigning in ComponentState) then
    Message.Result := HTTRANSPARENT
  else
    inherited;
end;

{ TNotebook }

var
  Registered: Boolean = False;

constructor TNotebook.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 150;
  Height := 150;
  FPageList := TList.Create;
  FAccess := TPageAccess.Create(FPageList, Self);
  FPageIndex := -1;
  FAccess.Add(SDefault);
  PageIndex := 0;
  FComponentStyle := ComponentStyle - [csInheritable];
  ControlStyle := ControlStyle + [csParentBackground];
  if not Registered then
  begin
    System.Classes.RegisterClasses([TPage]);
    Registered := True;
  end;
end;

destructor TNotebook.Destroy;
begin
  FreeAndNil(FAccess);
  FreeAndNil(FPageList);
  inherited Destroy;
end;

procedure TNotebook.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_CLIPCHILDREN;
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

function TNotebook.GetChildOwner: TComponent;
begin
  Result := Self;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TNotebook.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to FPageList.Count - 1 do Proc(TControl(FPageList[I]));
end;

procedure TNotebook.ReadState(Reader: TReader);
begin
  Pages.Clear;
  inherited ReadState(Reader);
  if (FPageIndex <> -1) and (FPageIndex >= 0) and (FPageIndex < FPageList.Count) then
    with TPage(FPageList[FPageIndex]) do
    begin
      BringToFront;
      Visible := True;
      Align := alClient;
    end
  else FPageIndex := -1;
end;

procedure TNotebook.ShowControl(AControl: TControl);
var
  I: Integer;
begin
  for I := 0 to FPageList.Count - 1 do
    if FPageList[I] = AControl then
    begin
      SetPageIndex(I);
      Exit;
    end;
  inherited ShowControl(AControl);
end;

procedure TNotebook.SetPages(Value: TStrings);
begin
  FAccess.Assign(Value);
end;

procedure TNotebook.SetPageIndex(Value: Integer);
var
  ParentForm: TCustomForm;
begin
  if csLoading in ComponentState then
  begin
    FPageIndex := Value;
    Exit;
  end;
  if (Value <> FPageIndex) and (Value >= 0) and (Value < FPageList.Count) then
  begin
    ParentForm := GetParentForm(Self);
    if ParentForm <> nil then
      if ContainsControl(ParentForm.ActiveControl) then
        ParentForm.ActiveControl := Self;
    with TPage(FPageList[Value]) do
    begin
      BringToFront;
      Visible := True;
      Align := alClient;
    end;
    if (FPageIndex >= 0) and (FPageIndex < FPageList.Count) then
      TPage(FPageList[FPageIndex]).Visible := False;
    FPageIndex := Value;
    if ParentForm <> nil then
      if ParentForm.ActiveControl = Self then SelectFirst;
    if Assigned(FOnPageChanged) then
      FOnPageChanged(Self);
  end;
end;

procedure TNotebook.SetActivePage(const Value: string);
begin
  SetPageIndex(FAccess.IndexOf(Value));
end;

function TNotebook.GetActivePage: string;
begin
  Result := FAccess[FPageIndex];
end;

{ THeaderStrings }

const
  DefaultSectionWidth = 75;

type
{$IF DEFINED(CLR)}
  THeaderSection = class
  public
    FObject: TObject;
    Width: Integer;
    Title: string;
  end;

  THeaderSectionType = THeaderSection;
{$ELSE}
  PHeaderSection = ^THeaderSection;
  THeaderSection = record
    FObject: TObject;
    Width: Integer;
    Title: string;
  end;

  THeaderSectionType = PHeaderSection;
{$ENDIF}

type
  THeaderStrings = class(TStrings)
  private
    FHeader: THeader;
    FList: TList;
    procedure ReadData(Reader: TReader);
    procedure WriteData(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function Get(Index: Integer): string; override;
    function GetCount: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure Put(Index: Integer; const S: string); override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure Clear; override;
  end;

procedure FreeSection(Section: THeaderSectionType);
begin
  if Section <> nil then
{$IF DEFINED(CLR)}
    Section.Free;
{$ELSE}
    Dispose(Section);
{$ENDIF}
end;

function NewSection(const ATitle: string; AWidth: Integer; AObject: TObject): THeaderSectionType;
begin
{$IF DEFINED(CLR)}
  Result := THeaderSection.Create;
{$ELSE}
  New(Result);
{$ENDIF}
  with Result{$IFNDEF CLR}^{$ENDIF} do
  begin
    Title := ATitle;
    Width := AWidth;
    FObject := AObject;
  end;
end;

constructor THeaderStrings.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor THeaderStrings.Destroy;
begin
  if FList <> nil then
  begin
    Clear;
    FreeAndNil(FList);
  end;
  inherited Destroy;
end;

procedure THeaderStrings.Assign(Source: TPersistent);
var
  I, J: Integer;
  Strings: TStrings;
  NewList: TList;
  Section: THeaderSectionType;
  TempStr: string;
  Found: Boolean;
begin
  if Source is TStrings then
  begin
    Strings := TStrings(Source);
    BeginUpdate;
    try
      NewList := TList.Create;
      try
        { Delete any sections not in the new list }
        I := FList.Count - 1;
        Found := False;
        while I >= 0 do
        begin
          TempStr := Get(I);
          for J := 0 to Strings.Count - 1 do
          begin
            Found := AnsiCompareStr(Strings[J], TempStr) = 0;
            if Found then Break;
          end;
          if not Found then Delete(I);
          Dec(I);
        end;

        { Now iterate over the lists and maintain section widths of sections in
          the new list }
        I := 0;
        for J := 0 to Strings.Count - 1 do
        begin
          if (I < FList.Count) and (AnsiCompareStr(Strings[J], Get(I)) = 0) then
          begin
            Section := NewSection(Get(I), 
              THeaderSectionType(FList[I]).Width, GetObject(I));
            Inc(I);
          end else
            Section := NewSection(Strings[J],
              FHeader.Canvas.TextWidth(Strings[J]) + 8, Strings.Objects[J]);
          NewList.Add(Section);
        end;
        Clear;
        FList.Free;
        FList := NewList;
        FHeader.Invalidate;
      except
        for I := 0 to NewList.Count - 1 do
          FreeSection(THeaderSectionType(NewList[I]));
        NewList.Free;
        raise;
      end;
    finally
      EndUpdate;
    end;
    Exit;
  end;
  inherited Assign(Source);
end;

procedure THeaderStrings.DefineProperties(Filer: TFiler);
begin
  { This will allow the old file image read in }
  if Filer is TReader then inherited DefineProperties(Filer);
  Filer.DefineProperty('Sections', ReadData, WriteData, Count > 0);
end;

procedure THeaderStrings.Clear;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
    FreeSection(THeaderSectionType(FList[I]));
  FList.Clear;
end;

procedure THeaderStrings.Delete(Index: Integer);
begin
  FreeSection(THeaderSectionType(FList[Index]));
  FList.Delete(Index);
  if FHeader <> nil then FHeader.Invalidate;
end;

function THeaderStrings.Get(Index: Integer): string;
begin
  Result := THeaderSectionType(FList[Index]).Title;
end;

function THeaderStrings.GetCount: Integer;
begin
  Result := FList.Count;
end;

function THeaderStrings.GetObject(Index: Integer): TObject;
begin
  Result := THeaderSectionType(FList[Index]).FObject;
end;

procedure THeaderStrings.Insert(Index: Integer; const S: string);
var
  Width: Integer;
begin
  if FHeader <> nil then
    Width := FHeader.Canvas.TextWidth(S) + 8
  else Width := DefaultSectionWidth;
  FList.Expand.Insert(Index, NewSection(S, Width, nil));
  if FHeader <> nil then FHeader.Invalidate;
end;

procedure THeaderStrings.Put(Index: Integer; const S: string);
var
  LSection: THeaderSectionType;
  Width: Integer;
begin
  LSection := THeaderSectionType(FList[Index]);
  if FHeader <> nil then
    Width := FHeader.Canvas.TextWidth(S) + 8
  else Width := DefaultSectionWidth;
  FList[Index] := NewSection(S, Width, LSection.FObject);
  FreeSection(LSection);
  if FHeader <> nil then FHeader.Invalidate;
end;

procedure THeaderStrings.PutObject(Index: Integer; AObject: TObject);
begin
  THeaderSectionType(FList[Index]).FObject := AObject;
  if FHeader <> nil then FHeader.Invalidate;
end;

procedure THeaderStrings.ReadData(Reader: TReader);
var
  Width, I: Integer;
  Str: string;
begin
  Reader.ReadListBegin;
  Clear;
  while not Reader.EndOfList do
  begin
    Str := Reader.ReadString;
    Width := DefaultSectionWidth;
    I := 1;
    if Str[1] = #0 then
    begin
      repeat
        Inc(I);
      until (I > Length(Str)) or (Str[I] = #0);
      Width := StrToIntDef(Copy(Str, 2, I - 2), DefaultSectionWidth);
{$IF DEFINED(CLR)}
      Borland.Delphi.System.Delete(Str, 1, I);
{$ELSE}
      System.Delete(Str, 1, I);
{$ENDIF}
    end;
    FList.Expand.Insert(FList.Count, NewSection(Str, Width, nil));
  end;
  Reader.ReadListEnd;
end;

procedure THeaderStrings.SetUpdateState(Updating: Boolean);
begin
  if FHeader <> nil then
  begin
    SendMessage(FHeader.Handle, WM_SETREDRAW, Ord(not Updating), 0);
    if not Updating then FHeader.Refresh;
  end;
end;

procedure THeaderStrings.WriteData(Writer: TWriter);
var
  I: Integer;
  HeaderSection: THeaderSectionType;
begin
  Writer.WriteListBegin;
  for I := 0 to Count - 1 do
  begin
    HeaderSection := THeaderSectionType(FList[I]);
    with HeaderSection{$IFNDEF CLR}^{$ENDIF} do
      Writer.WriteString(Format(#0'%d'#0'%s', [Width, Title]));
  end;
  Writer.WriteListEnd;
end;

{ THeader }

constructor THeader.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csDesignInteractive, csOpaque];
  Width := 250;
  Height := 25;
  FSections := THeaderStrings.Create;
  THeaderStrings(FSections).FHeader := Self;
  FAllowResize := True;
  FBorderStyle := bsSingle;
end;

destructor THeader.Destroy;
begin
  FreeSections;
  FSections.Free;
  inherited Destroy;
end;

procedure THeader.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or BorderStyles[FBorderStyle];
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

procedure THeader.Paint;
var
  I, Y, W: Integer;
  S: string;
  R: TRect;
begin
  with Canvas do
  begin
    Font := Self.Font;
    Brush.Color := clBtnFace;
    I := 0;
    Y := (ClientHeight - Canvas.TextHeight('T')) div 2;
    R := Rect(0, 0, 0, ClientHeight);
    W := 0;
    S := '';
    repeat
      if I < FSections.Count then
      begin
        with THeaderSectiontype(THeaderStrings(FSections).FList[I]){$IFNDEF CLR}^{$ENDIF} do
        begin
          W := Width;
          S := Title;
        end;
        Inc(I);
      end;
      R.Left := R.Right;
      Inc(R.Right, W);
      if (ClientWidth - R.Right < 2) or (I = FSections.Count) then
        R.Right := ClientWidth;
      TextRect(Rect(R.Left + 1, R.Top + 1, R.Right - 1,
        R.Bottom - 1), R.Left + 3, Y, S);
      DrawEdge(Canvas.Handle, R, BDR_RAISEDINNER, BF_TOPLEFT);
      DrawEdge(Canvas.Handle, R, BDR_RAISEDINNER, BF_BOTTOMRight);
    until R.Right = ClientWidth;
  end;
end;

procedure THeader.FreeSections;
begin
  if FSections <> nil then
    FSections.Clear;
end;

procedure THeader.SetBorderStyle(Value: TBorderStyle);
begin
  if Value <> FBorderStyle then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure THeader.SetSections(Strings: TStrings);
begin
  FSections.Assign(Strings);
end;

function THeader.GetWidth(X: Integer): Integer;
var
  I, W: Integer;
begin
  if X = FSections.Count - 1 then
  begin
    W := 0;
    for I := 0 to X - 1 do
      Inc(W, THeaderSectionType(THeaderStrings(FSections).FList[I]).Width);
    Result := ClientWidth - W;
  end
  else if (X >= 0) and (X < FSections.Count) then
    Result := THeaderSectionType(THeaderStrings(FSections).FList[X]).Width
  else
    Result := 0;
end;

procedure THeader.SetWidth(X: Integer; Value: Integer);
begin
  if X < 0 then Exit;
  THeaderSectionType(THeaderStrings(FSections).FList[X]).Width := Value;
  Invalidate;
end;

procedure THeader.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;
  FHitTest := SmallPointToPoint(Msg.Pos);
end;

procedure THeader.WMSetCursor(var Msg: TWMSetCursor);
var
  Cur: HCURSOR;
  I: Integer;
  X: Integer;
begin
  Cur := 0;
  FResizeSection := 0;
  FHitTest := ScreenToClient(FHitTest);
  X := 2;
  with Msg do
    if HitTest = HTCLIENT then
      for I := 0 to FSections.Count - 2 do  { don't count last section }
      begin
        Inc(X, THeaderSectionType(THeaderStrings(FSections).FList[I]).Width);
        FMouseOffset := X - (FHitTest.X + 2);
        if Abs(FMouseOffset) < 4 then
        begin
          Cur := LoadCursor(0, IDC_SIZEWE);
          FResizeSection := I;
          Break;
        end;
      end;
  FCanResize := (FAllowResize or (csDesigning in ComponentState)) and (Cur <> 0);
  if FCanResize then SetCursor(Cur)
  else inherited;
end;

procedure THeader.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if ((csDesigning in ComponentState) and (Button = mbRight)) or (Button = mbLeft) then
    if FCanResize then SetCapture(Handle);
end;

procedure THeader.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
  AbsPos: Integer;
  MinPos: Integer;
  MaxPos: Integer;
begin
  inherited MouseMove(Shift, X, Y);
  if (GetCapture = Handle) and FCanResize then
  begin
    { absolute position of this item }
    AbsPos := 2;
    for I := 0 to FResizeSection do
      Inc(AbsPos, THeaderSectionType(THeaderStrings(FSections).FList[I]).Width);

    if FResizeSection > 0 then MinPos := AbsPos -
      THeaderSectionType(THeaderStrings(FSections).FList[FResizeSection]).Width + 2
    else MinPos := 2;
    MaxPos := ClientWidth - 2;
    if X < MinPos then X := MinPos;
    if X > MaxPos then X := MaxPos;

    Dec(THeaderSectionType(THeaderStrings(FSections).FList[FResizeSection]).Width,
      (AbsPos - X - 2) - FMouseOffset);
    Sizing(FResizeSection,
      THeaderSectionType(THeaderStrings(FSections).FList[FResizeSection]).Width);
    Refresh;
  end;
end;

procedure THeader.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if FCanResize then
  begin
    ReleaseCapture;
    Sized(FResizeSection,
      THeaderSectionType(THeaderStrings(FSections).FList[FResizeSection]).Width);
    FCanResize := False;
  end;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure THeader.Sizing(ASection, AWidth: Integer);
begin
  if Assigned(FOnSizing) then FOnSizing(Self, ASection, AWidth);
end;

procedure THeader.Sized(ASection, AWidth: Integer);
var
  Form: TCustomForm;
begin
  if Assigned(FOnSized) then FOnSized(Self, ASection, AWidth);
  if csDesigning in ComponentState then
  begin
    Form := GetParentForm(Self);
    if Form <> nil then
      Form.Designer.Modified;
  end;
end;

procedure THeader.WMSize(var Msg: TWMSize);
begin
  inherited;
  Invalidate;
end;

{ TGroupButton }

type
  TGroupButton = class(TRadioButton)
  private
    FInClick: Boolean;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor InternalCreate(RadioGroup: TCustomRadioGroup);
    destructor Destroy; override;
  end;

constructor TGroupButton.InternalCreate(RadioGroup: TCustomRadioGroup);
begin
  inherited Create(RadioGroup);
  RadioGroup.FButtons.Add(Self);
  Visible := False;
  Enabled := RadioGroup.Enabled;
  ParentShowHint := False;
  OnClick := RadioGroup.ButtonClick;
  Parent := RadioGroup;
end;

destructor TGroupButton.Destroy;
begin
  TCustomRadioGroup(Owner).FButtons.Remove(Self);
  inherited Destroy;
end;

procedure TGroupButton.CNCommand(var Message: TWMCommand);
begin
  if not FInClick then
  begin
    FInClick := True;
    try
      if ((Message.NotifyCode = BN_CLICKED) or
        (Message.NotifyCode = BN_DOUBLECLICKED)) and
        TCustomRadioGroup(Parent).CanModify then
        inherited;
    except
      Application.HandleException(Self);
    end;
    FInClick := False;
  end;
end;

procedure TGroupButton.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  TCustomRadioGroup(Parent).KeyPress(Key);
  if (Key = #8) or (Key = ' ') then
  begin
    if not TCustomRadioGroup(Parent).CanModify then Key := #0;
  end;
end;

procedure TGroupButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  TCustomRadioGroup(Parent).KeyDown(Key, Shift);
end;

procedure TGroupButton.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params.WindowClass do
    style := style and not (CS_HREDRAW or CS_VREDRAW);
end;

{ TCustomRadioGroup }

constructor TCustomRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csSetCaption, csDoubleClicks, csParentBackground];
  FButtons := TList.Create;
  FItems := TStringList.Create;
  TStringList(FItems).OnChange := ItemsChange;
  FItemIndex := -1;
  FColumns := 1;
end;

destructor TCustomRadioGroup.Destroy;
begin
  SetButtonCount(0);
  TStringList(FItems).OnChange := nil;
  FItems.Free;
  FButtons.Free;
  inherited Destroy;
end;

procedure TCustomRadioGroup.FlipChildren(AllLevels: Boolean); 
begin
  { The radio buttons are flipped using BiDiMode }
end;

procedure TCustomRadioGroup.ArrangeButtons;
var
  ButtonsPerCol, ButtonWidth, ButtonHeight, TopMargin, I: Integer;
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
  DeferHandle: THandle;
  ALeft: Integer;
begin
  if (FButtons.Count <> 0) and not FReading then
  begin
    DC := GetDC(0);
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
    ReleaseDC(0, DC);
    ButtonsPerCol := (FButtons.Count + FColumns - 1) div FColumns;
    ButtonWidth := (Width - 10) div FColumns;
    I := Height - Metrics.tmHeight - 5;
    ButtonHeight := I div ButtonsPerCol;
    TopMargin := Metrics.tmHeight + 1 + (I mod ButtonsPerCol) div 2;
    DeferHandle := BeginDeferWindowPos(FButtons.Count);
    try
      for I := 0 to FButtons.Count - 1 do
        with TGroupButton(FButtons[I]) do
        begin
          BiDiMode := Self.BiDiMode;
          ALeft := (I div ButtonsPerCol) * ButtonWidth + 8;
          if UseRightToLeftAlignment then
            ALeft := Self.ClientWidth - ALeft - ButtonWidth;
          DeferHandle := DeferWindowPos(DeferHandle, Handle, 0,
            ALeft,
            (I mod ButtonsPerCol) * ButtonHeight + TopMargin,
            ButtonWidth, ButtonHeight,
            SWP_NOZORDER or SWP_NOACTIVATE);
          Visible := True;
        end;
    finally
      EndDeferWindowPos(DeferHandle);
    end;
  end;
end;

procedure TCustomRadioGroup.ButtonClick(Sender: TObject);
begin
  if not FUpdating then
  begin
    FItemIndex := FButtons.IndexOf(Sender);
    Changed;
    Click;
  end;
end;

procedure TCustomRadioGroup.ItemsChange(Sender: TObject);
begin
  if not FReading then
  begin
    if FItemIndex >= FItems.Count then
      FItemIndex := FItems.Count - 1;
    UpdateButtons;
  end;
end;

procedure TCustomRadioGroup.Loaded;
begin
  inherited Loaded;
  ArrangeButtons;
end;

procedure TCustomRadioGroup.ReadState(Reader: TReader);
begin
  FReading := True;
  inherited ReadState(Reader);
  FReading := False;
  if HandleAllocated then
    UpdateButtons;
end;

procedure TCustomRadioGroup.CreateWnd;
begin
  inherited CreateWnd;
  UpdateButtons;
end;

procedure TCustomRadioGroup.SetButtonCount(Value: Integer);
begin
  while FButtons.Count < Value do
    TGroupButton.InternalCreate(Self);
  while FButtons.Count > Value do
    TGroupButton(FButtons.Last).Free;
end;

procedure TCustomRadioGroup.SetColumns(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 16 then Value := 16;
  if FColumns <> Value then
  begin
    FColumns := Value;
    ArrangeButtons;
    Invalidate;
  end;
end;

procedure TCustomRadioGroup.SetItemIndex(Value: Integer);
begin
  if FReading then FItemIndex := Value else
  begin
    HandleNeeded;
    if Value < -1 then Value := -1;
    if Value >= FButtons.Count then Value := FButtons.Count - 1;
    if FItemIndex <> Value then
    begin
      if FItemIndex >= 0 then
        TGroupButton(FButtons[FItemIndex]).Checked := False;
      FItemIndex := Value;
      if FItemIndex >= 0 then
        TGroupButton(FButtons[FItemIndex]).Checked := True;
    end;
  end;
end;

procedure TCustomRadioGroup.SetItems(Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TCustomRadioGroup.SetWordWrap(Value: Boolean);
begin
  if Value <> FWordWrap then
  begin
    FWordWrap := Value;
    UpdateButtons;
  end;
end;

procedure TCustomRadioGroup.UpdateButtons;
var
  I: Integer;
begin
  SetButtonCount(FItems.Count);
  for I := 0 to FButtons.Count - 1 do
  begin
    TGroupButton(FButtons[I]).Caption := FItems[I];
    TGroupButton(FButtons[I]).WordWrap := FWordWrap;
  end;
  if FItemIndex >= 0 then
  begin
    FUpdating := True;
    TGroupButton(FButtons[FItemIndex]).Checked := True;
    FUpdating := False;
  end;
  ArrangeButtons;
  Invalidate;
end;

procedure TCustomRadioGroup.CMEnabledChanged(var Message: TMessage);
var
  I: Integer;
begin
  inherited;
  for I := 0 to FButtons.Count - 1 do
    TGroupButton(FButtons[I]).Enabled := Enabled;
end;

procedure TCustomRadioGroup.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ArrangeButtons;
end;

procedure TCustomRadioGroup.WMSize(var Message: TWMSize);
begin
  inherited;
  ArrangeButtons;
end;

function TCustomRadioGroup.CanModify: Boolean;
begin
  Result := True;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TCustomRadioGroup.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
end;

function TCustomRadioGroup.GetButtons(Index: Integer): TRadioButton;
begin
  Result := TRadioButton(FButtons[Index]);
end;

{ TSplitter }

{$IF NOT DEFINED(CLR)}
type
  TWinControlAccess = class(TWinControl);
{$ENDIF}

constructor TSplitter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csGestures];
  FAutoSnap := True;
  Height := 100;
  Align := alLeft;
  Width := 3;
  Cursor := crHSplit;
  FMinSize := 30;
  FResizeStyle := rsPattern;
  FOldSize := -1;
end;

destructor TSplitter.Destroy;
begin
  FBrush.Free;
  inherited Destroy;
end;

procedure TSplitter.AllocateLineDC;
begin
  FLineDC := GetDCEx(Parent.Handle, 0, DCX_CACHE or DCX_CLIPSIBLINGS
    or DCX_LOCKWINDOWUPDATE);
  if ResizeStyle = rsPattern then
  begin
    if FBrush = nil then
    begin
      FBrush := TBrush.Create;
      if TStyleManager.IsCustomStyleActive then
        with StyleServices do
          FBrush.Bitmap := AllocPatternBitmap(clBlack, GetStyleColor(scSplitter))
      else
        FBrush.Bitmap := AllocPatternBitmap(clBlack, clWhite);
    end;
    FPrevBrush := SelectObject(FLineDC, FBrush.Handle);
  end;
end;

procedure TSplitter.DrawLine;
var
  P: TPoint;
begin
  FLineVisible := not FLineVisible;
  P := Point(Left, Top);
  if Align in [alLeft, alRight] then
    P.X := Left + FSplit else
    P.Y := Top + FSplit;
  with P do PatBlt(FLineDC, X, Y, Width, Height, PATINVERT);
end;

procedure TSplitter.ReleaseLineDC;
begin
  if FPrevBrush <> 0 then
    SelectObject(FLineDC, FPrevBrush);
  ReleaseDC(Parent.Handle, FLineDC);
  if FBrush <> nil then
  begin
    FBrush.Free;
    FBrush := nil;
  end;
end;

function TSplitter.FindControl: TControl;
var
  P: TPoint;
  I: Integer;
  R: TRect;
begin
  Result := nil;
  P := Point(Left, Top);
  case Align of
    alLeft:
      if not AlignWithMargins then
        Dec(P.X)
      else
        Dec(P.X, Margins.Left + 1);
    alRight:
      if not AlignWithMargins then
        Inc(P.X, Width)
      else
        Inc(P.X, Width + Margins.Right + 1);
    alTop:
      if not AlignWithMargins then
        Dec(P.Y)
      else
        Dec(P.Y, Margins.Top + 1);
    alBottom:
      if not AlignWithMargins then
        Inc(P.Y, Height)
      else
        Inc(P.Y, Height + Margins.Bottom + 1);
  else
    Exit;
  end;
  for I := 0 to Parent.ControlCount - 1 do
  begin
    Result := Parent.Controls[I];
    if Result.Visible and Result.Enabled and
      (Result.Align in [alLeft, alRight, alTop, alBottom]) and
     ((Result.Align in [alLeft, alRight]) = (Align in [alLeft, alRight])) then
    begin
      R := Result.BoundsRect;
      if Result.AlignWithMargins then
      begin
        Inc(R.Right, Result.Margins.Right);
        Dec(R.Left, Result.Margins.Left);
        Inc(R.Bottom, Result.Margins.Bottom);
        Dec(R.Top, Result.Margins.Top);
      end;
      if (R.Right - R.Left) = 0 then
        if Align in [alTop, alLeft] then
          Dec(R.Left)
        else
          Inc(R.Right);
      if (R.Bottom - R.Top) = 0 then
        if Align in [alTop, alLeft] then
          Dec(R.Top)
        else
          Inc(R.Bottom);
      if R.Contains(P) then Exit;
    end;
  end;
  Result := nil;
end;

procedure TSplitter.RequestAlign;
begin
  inherited RequestAlign;
  if (Cursor <> crVSplit) and (Cursor <> crHSplit) then Exit;
  if Align in [alBottom, alTop] then
    Cursor := crVSplit
  else
    Cursor := crHSplit;
end;

procedure TSplitter.Paint;
const
  XorColor = $00FFD8CE;
var
  FrameBrush: HBRUSH;
  R: TRect;
begin
  R := ClientRect;
  if TStyleManager.IsCustomStyleActive then
    Canvas.Brush.Color := StyleServices.GetSystemColor(clBtnFace)
  else
    Canvas.Brush.Color := Color;
  Canvas.FillRect(ClientRect);
  if Beveled then
  begin
    if Align in [alLeft, alRight] then
      InflateRect(R, -1, 2) else
      InflateRect(R, 2, -1);
    OffsetRect(R, 1, 1);
    FrameBrush := CreateSolidBrush(ColorToRGB(StyleServices.GetSystemColor(clBtnHighlight)));
    FrameRect(Canvas.Handle, R, FrameBrush);
    DeleteObject(FrameBrush);
    OffsetRect(R, -2, -2);
    FrameBrush := CreateSolidBrush(ColorToRGB(StyleServices.GetSystemColor(clBtnShadow)));
    FrameRect(Canvas.Handle, R, FrameBrush);
    DeleteObject(FrameBrush);
  end;
  if csDesigning in ComponentState then
    { Draw outline }
    with Canvas do
    begin
      Pen.Style := psDot;
      Pen.Mode := pmXor;
      Pen.Color := XorColor;
      Brush.Style := bsClear;
      Rectangle(0, 0, ClientWidth, ClientHeight);
    end;
  if Assigned(FOnPaint) then FOnPaint(Self);
end;

function TSplitter.DoCanResize(var NewSize: Integer): Boolean;
begin
  Result := CanResize(NewSize);
  if Result and (NewSize <= MinSize) and FAutoSnap then
    NewSize := 0;
end;

function TSplitter.CanResize(var NewSize: Integer): Boolean;
begin
  Result := True;
  if Assigned(FOnCanResize) then FOnCanResize(Self, NewSize, Result);
end;

procedure TSplitter.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  I: Integer;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if Button = mbLeft then
  begin
    FControl := FindControl;
    FDownPos := Point(X, Y);
    if Assigned(FControl) then
    begin
      if Align in [alLeft, alRight] then
      begin
        FMaxSize := Parent.ClientWidth - FMinSize;
        for I := 0 to Parent.ControlCount - 1 do
          with Parent.Controls[I] do
            if Visible and (Align in [alLeft, alRight]) then
              Dec(FMaxSize, Width);
        Inc(FMaxSize, FControl.Width);
      end
      else
      begin
        FMaxSize := Parent.ClientHeight - FMinSize;
        for I := 0 to Parent.ControlCount - 1 do
          with Parent.Controls[I] do
            if Visible and (Align in [alTop, alBottom]) then
              Dec(FMaxSize, Height);
        Inc(FMaxSize, FControl.Height);
      end;
      UpdateSize(X, Y);
      AllocateLineDC;
      with ValidParentForm(Self) do
        if ActiveControl <> nil then
        begin
          FActiveControl := ActiveControl;
{$IF DEFINED(CLR)}
          FOldKeyDown := @FocusKeyDown;
          (FActiveControl as IControl).HookDelegate('OnKeyDown', @FOldKeyDown);
{$ELSE}
          FOldKeyDown := TWinControlAccess(FActiveControl).OnKeyDown;
          TWinControlAccess(FActiveControl).OnKeyDown := FocusKeyDown;
{$ENDIF}
        end;
      if ResizeStyle in [rsLine, rsPattern] then DrawLine;
    end;
  end;
end;

procedure TSplitter.UpdateControlSize;
var
  OldPosition: Integer;
begin
  if FNewSize <> FOldSize then
  begin
    case Align of
      alLeft:
        begin
          OldPosition := FControl.Left;
          FControl.Width := FNewSize;
          FControl.Left := OldPosition;
        end;
      alTop:
        begin
          OldPosition := FControl.Top;
          FControl.Height := FNewSize;
          FControl.Top := OldPosition;
        end;
      alRight:
        begin
          Parent.DisableAlign;
          try
            FControl.Left := FControl.Left + (FControl.Width - FNewSize);
            FControl.Width := FNewSize;
          finally
            Parent.EnableAlign;
          end;
        end;
      alBottom:
        begin
          Parent.DisableAlign;
          try
            FControl.Top := FControl.Top + (FControl.Height - FNewSize);
            FControl.Height := FNewSize;
          finally
            Parent.EnableAlign;
          end;
        end;
    end;
    Update;
    if Assigned(FOnMoved) then FOnMoved(Self);
    FOldSize := FNewSize;
  end;
end;

procedure TSplitter.CalcSplitSize(X, Y: Integer; var NewSize, Split: Integer);
var
  S: Integer;
begin
  if Align in [alLeft, alRight] then
    Split := X - FDownPos.X
  else
    Split := Y - FDownPos.Y;
  S := 0;
  case Align of
    alLeft: S := FControl.Width + Split;
    alRight: S := FControl.Width - Split;
    alTop: S := FControl.Height + Split;
    alBottom: S := FControl.Height - Split;
  end;
  NewSize := S;
  if S < FMinSize then
    NewSize := FMinSize
  else if S > FMaxSize then
    NewSize := FMaxSize;
  if S <> NewSize then
  begin
    if Align in [alRight, alBottom] then
      S := S - NewSize else
      S := NewSize - S;
    Inc(Split, S);
  end;
end;

procedure TSplitter.UpdateSize(X, Y: Integer);
begin
  CalcSplitSize(X, Y, FNewSize, FSplit);
end;

procedure TSplitter.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewSize, Split: Integer;
begin
  inherited;
  if (ssLeft in Shift) and Assigned(FControl) then
  begin
    CalcSplitSize(X, Y, NewSize, Split);
    if DoCanResize(NewSize) then
    begin
      if ResizeStyle in [rsLine, rsPattern] then DrawLine;
      FNewSize := NewSize;
      FSplit := Split;
      if ResizeStyle = rsUpdate then UpdateControlSize;
      if ResizeStyle in [rsLine, rsPattern] then DrawLine;
    end;
  end;
end;

procedure TSplitter.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if Assigned(FControl) then
  begin
    if ResizeStyle in [rsLine, rsPattern] then DrawLine;
    UpdateControlSize;
    StopSizing;
  end;
end;

procedure TSplitter.FocusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    StopSizing
{$IF NOT DEFINED(CLR)}
  else if Assigned(FOldKeyDown) then
    FOldKeyDown(Sender, Key, Shift);
{$ENDIF}
end;

procedure TSplitter.SetBeveled(Value: Boolean);
begin
  FBeveled := Value;
  Repaint;
end;

procedure TSplitter.StopSizing;
begin
  if Assigned(FControl) then
  begin
    if FLineVisible then DrawLine;
    FControl := nil;
    ReleaseLineDC;
{$IF DEFINED(CLR)}
    if Assigned(FActiveControl) and Assigned(FOldKeyDown) then
    begin
      (FActiveControl as IControl).UnhookDelegate('OnKeyDown', @FOldKeyDown);
      FActiveControl := nil;
      FOldKeyDown := nil;
    end;
{$ELSE}
    if Assigned(FActiveControl) then
    begin
      TWinControlAccess(FActiveControl).OnKeyDown := FOldKeyDown;
      FActiveControl := nil;
    end;
{$ENDIF}
  end;
  if Assigned(FOnMoved) then
    FOnMoved(Self);
end;

{ TCustomControlBar }

                                     

type
{$IF NOT DEFINED(CLR)}
  PDockPos = ^TDockPos;
  TDockPos = record
    Control: TControl;
    Insets: TRect;
    Visible: Boolean;
    Break: Boolean;
    Pos: TPoint;
    Width: Integer;

    Height: Integer;
    RowCount: Integer;
    TempRow: Integer;
    Parent: PDockPos;
    SubItem: PDockPos;

    TempBreak: Boolean;
    TempPos: TPoint;
    TempWidth: Integer;
  end;

  TDockPosType = PDockPos;
{$ELSE}
  TDockPosType = TDockPos;
{$ENDIF}

function CreateDockPos(AControl: TControl; Break: Boolean; Visible: Boolean;
  const APos: TPoint; AWidth, AHeight: Integer; Parent: TDockPosType;
  const Insets: TRect; RowCount: Integer): TDockPosType;
begin
{$IF DEFINED(CLR)}
  Result := TDockPos.Create;
{$ELSE}
  GetMem(Result, SizeOf(TDockPos));
{$ENDIF}
  Result.Control := AControl;
  Result.Insets := Insets;
  Result.Visible := Visible;
  Result.Break := Break;
  Result.Pos := APos;
  Result.Width := AWidth;
  Result.Height := AHeight;
  Result.RowCount := RowCount;
  Result.TempRow := 1;
  Result.TempBreak := Break;
  Result.TempPos := APos;
  Result.TempWidth := AWidth;
  Result.Parent := Parent;
  Result.SubItem := nil;
end;

procedure FreeDockPos(Items: TList; DockPos: TDockPosType);
var
  Tmp: TDockPosType;
begin
  { Remove all subitems }
  while DockPos <> nil do
  begin
    Tmp := DockPos;
    Items.Remove(DockPos);
    DockPos := DockPos.SubItem;
{$IF DEFINED(CLR)}
    Tmp.Free;
{$ELSE}
    FreeMem(Tmp, SizeOf(TDockPos));
{$ENDIF}
  end;
end;

procedure AdjustControlRect(var ARect: TRect; const Insets: TRect);
begin
  with Insets do
  begin
    Dec(ARect.Left, Left);
    Dec(ARect.Top, Top);
    Inc(ARect.Right, Right);
    Inc(ARect.Bottom, Bottom);
  end;
end;

constructor TCustomControlBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csDoubleClicks, csOpaque, csParentBackground, csGestures];
  Width := 100;
  Height := 50;
  FAutoDrag := True;
  FAutoDock := True;
  FDrawingStyle := dsNormal;
  FItems := TList.Create;
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
  FRowSize := 26;
  FRowSnap := True;
  BevelKind := bkTile;
  DoubleBuffered := True;
  DockSite := True;
  GradientStartColor := clWindow;
  GradientEndColor := GetShadowColor(clBtnFace, -25);
  GradientDirection := gdVertical;
  CornerEdge := ceMedium;
end;

destructor TCustomControlBar.Destroy;
var
  I: Integer;
begin
  for I := 0 to FItems.Count - 1 do
    if FItems[I] <> nil then
{$IF DEFINED(CLR)}
      TDockPos(FItems[I]).Free;
{$ELSE}
      FreeMem(PDockPos(FItems[I]), SizeOf(TDockPos));
{$ENDIF}
  FItems.Free;
  FPicture.Free;
  inherited Destroy;
end;

procedure TCustomControlBar.SetCornerEdge(Value: TCornerEdge);
begin
  if Value <> FCornerEdge then
  begin
    FCornerEdge := Value;
    Repaint;
  end;
end;

procedure TCustomControlBar.SetGradientStartColor(Value: TColor);
begin
  if Value <> FGradientStartColor then
  begin
    FGradientStartColor := Value;
    if HandleAllocated then
      Repaint;
  end;
end;

procedure TCustomControlBar.SetGradientEndColor(Value: TColor);
begin
  if Value <> FGradientEndColor then
  begin
    FGradientEndColor := Value;
    if HandleAllocated then
      Repaint;
  end;
end;

procedure TCustomControlBar.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params.WindowClass do
    style := style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TCustomControlBar.AlignControls(AControl: TControl; var ARect: TRect);
var
  I, J, X: Integer;
  DockPos: TDockPosType;
  TotalSize, RowSize, RowSpace, Shift: Integer;
  RowHeight, PrevRowHeight: Integer;
  MoveBy: Integer;
  Pos: TPoint;
  CX: Integer;
  Control: TControl;
  UseTemp: Boolean;

  Row: Integer;
  RowCount: Integer;
  FirstIndex, LastIndex: Integer;
  InsertingControl: Boolean;
  Dirty: Boolean;
  R: TRect;

  TempRowSize, TempRowSpace: Integer;
  AdjustX: Integer;
  DockRect: TRect;
  PreferredSize: Integer;

  TmpDockPos: TDockPosType;
  Redo: TDockPosType;
  RedoCount: Integer;
  SkipRedo: Boolean;

  function ShouldRedo(DockPos: TDockPosType; const Pos: TPoint; Width: Integer): Boolean;
  begin
     { Determine whether this subitem has changed and will affect its
      parent(s). }
    if (DockPos.Parent <> nil) and ((Pos.X <> DockPos.Parent.TempPos.X) or
      (Width <> DockPos.Parent.TempWidth)) then
    begin
      DockPos := DockPos.Parent;
      { Update parents and re-perform align logic }
      repeat
        DockPos.TempPos.X := Pos.X;
        DockPos.TempWidth := Width;
        Redo := DockPos;
        DockPos := DockPos.Parent;
      until DockPos = nil;
      Result := True;
    end
    else
      Result := False;
  end;

begin
  if FAligning then Exit;
  if (AlignControlList <> nil) and (AControl <> nil) then Exit;
  FAligning := True;
  try
    { Update items }
    InsertingControl := UpdateItems(AControl);
    if FItems.Count = 0 then Exit;
    RowCount := 0;
    FirstIndex := 0;
    LastIndex := FItems.Count - 1;

    { Find number of rows }
    for I := FirstIndex to LastIndex do
    begin
      DockPos := TDockPosType(FItems[I]);
      { First item can't have Break set! }
      DockPos.TempBreak := DockPos.Break;
      if DockPos.Break then
        Inc(RowCount);
    end;

    Redo := nil;
    SkipRedo := False;
    RedoCount := 2;
    repeat

      if Redo <> nil then
      begin
        SkipRedo := True;
        Dec(RedoCount);
      end;
      if RedoCount = 0 then Exit;

      RowHeight := 0;
      PrevRowHeight := 0;
      Row := 1;

      while Row <= RowCount do
      begin

        if Row = 1 then
          RowHeight := 0;

        { Find first and last index for current row }
        if Row = 1 then
          FirstIndex := 0
        else
          FirstIndex := LastIndex + 1;
        LastIndex := FItems.Count - 1;
        for I := FirstIndex to LastIndex - 1 do
        begin
          DockPos := TDockPosType(FItems[I + 1]);
          { First item can't have Break set }
          if DockPos.Break or DockPos.TempBreak then
          begin
            LastIndex := I;
            Break;
          end;
        end;

        { Set temp values for all controls }
        TotalSize := ARect.Right - ARect.Left;
        RowSize := 0;
        RowSpace := 0;

        for I := FirstIndex to LastIndex do
        begin
          DockPos := TDockPosType(FItems[I]);

          if DockPos.Break or DockPos.TempBreak then
          begin
            RowSize := 0;
            RowSpace := 0;
            UseTemp := False;
            if UseTemp then
              DockPos.TempPos.Y := RowHeight else
              DockPos.Pos.Y := RowHeight;
            PrevRowHeight := RowHeight;
          end
          else UseTemp := False;

          Control := DockPos.Control;
          if (csDesigning in ComponentState) or Control.Visible then
          begin
            { If control was moved/resized, update our info }
            if DockPos.Parent = nil then
            begin
              PreferredSize := DockPos.Width;
              Dec(PreferredSize, DockPos.Insets.Left + DockPos.Insets.Right);
              GetControlInfo(Control, DockPos.Insets, PreferredSize,
                DockPos.RowCount);
              DockPos.Width := PreferredSize + DockPos.Insets.Left +
                DockPos.Insets.Right;
              if not InsertingControl and (DockPos.Parent = nil) and
                (AControl = DockPos.Control) then
              begin
                if UseTemp then
                begin
                  DockPos.TempPos := Point(AControl.Left - ARect.Left -
                    DockPos.Insets.Left, AControl.Top - ARect.Top - DockPos.Insets.Top);
                  DockPos.TempWidth := AControl.Width + DockPos.Insets.Left +
                    DockPos.Insets.Right;
                  DockRect := Bounds(DockPos.TempPos.X, DockPos.TempPos.Y,
                    DockPos.TempWidth, DockPos.Height);
                end
                else
                  DockRect := Bounds(DockPos.Pos.X, DockPos.Pos.Y,
                    DockPos.Width, DockPos.Height);
              end;

              { Let user adjust sizes }
              if DockPos = Redo then
                DockRect := Bounds(DockPos.TempPos.X, DockPos.TempPos.Y,
                  DockPos.TempWidth, DockPos.Height)
              else
                DockRect := Bounds(DockPos.Pos.X, DockPos.Pos.Y,
                  DockPos.Width, DockPos.Height);
              DoBandMove(Control, DockRect);
              DockPos.TempWidth := DockRect.Right - DockRect.Left;
            end
            else
            begin
              { Use parent's position }
              with DockPos{$IFNDEF CLR}^{$ENDIF}.Parent{$IFNDEF CLR}^{$ENDIF} do
              begin
                DockPos.Pos := Pos;
                DockPos.TempPos := TempPos;
                Inc(DockPos.Pos.Y, Height);
                Inc(DockPos.TempPos.Y, Height);
                DockPos.Width := Width;
                DockPos.TempWidth := TempWidth;
                DockRect := Bounds(DockPos.TempPos.X, DockPos.TempPos.Y,
                  DockPos.TempWidth, DockPos.Height);
              end;
            end;

            if DockPos = Redo then
            begin
              with DockPos{$IFNDEF CLR}^{$ENDIF} do
              begin
                TempPos.X := DockRect.Left;
                TempPos.Y := DockRect.Top;
                TempWidth := DockRect.Right - DockRect.Left;
                Redo := nil;
                SkipRedo := False;
              end;
            end
            else
            begin
              with DockPos{$IFNDEF CLR}^{$ENDIF} do
              begin
                Pos.X := DockRect.Left;
                Pos.Y := DockRect.Top;
              end;
            end;

            if UseTemp then
            begin
              Pos := DockPos.TempPos;
              CX := DockPos.TempWidth;
            end
            else
            begin
              Pos := DockRect.TopLeft;
              CX := DockRect.Right - DockRect.Left;
            end;

            { Make sure Pos is within bounds }
            if Pos.X < RowSize then
            begin
              { If a control is being resized/moved then adjust any controls to
                its left }
              if (RowSpace > 0) then
              begin
                TempRowSize := Pos.X;
                AdjustX := Pos.X;
                TempRowSpace := RowSpace;
                for J := I - 1 downto FirstIndex do
                begin
                  with TDockPosType(FItems[J]){$IFNDEF CLR}^{$ENDIF} do
                  begin
                    if (csDesigning in ComponentState) or Control.Visible then
                    begin
                      if TempPos.X + TempWidth > TempRowSize then
                      begin
                        X := TempPos.X + TempWidth - TempRowSize;
                        { Calculate adjusted rowspace }
                        if J < I - 1 then
                          Dec(TempRowSpace, AdjustX - (TempPos.X + TempWidth));
                        if X > TempRowSpace then
                          X := TempRowSpace;
                        AdjustX := TempPos.X;
                        Dec(TempPos.X, X);
                        Dec(TempRowSize, TempWidth);

                        TmpDockPos := TDockPosType(FItems[J]);
                        if ShouldRedo(TmpDockPos, TmpDockPos.TempPos,
                          TmpDockPos.TempWidth) then
{$IF DEFINED(CLR)}
                          Borland.Delphi.System.Break;
{$ELSE}
                          System.Break;
{$ENDIF}

                        TmpDockPos := SubItem;
                        while TmpDockPos <> nil do
                          with TmpDockPos{$IFNDEF CLR}^{$ENDIF} do
                          begin
                            Pos := TDockPosType(FItems[J]).Pos;
                            TempPos := TDockPosType(FItems[J]).TempPos;
                            Inc(Pos.Y, Parent.Height);
                            Inc(TempPos.Y, Parent.Height);
                            Width := TDockPosType(FItems[J]).Width;
                            TempWidth := TDockPosType(FItems[J]).TempWidth;
                            TmpDockPos := SubItem;
                          end;

                      end
{$IF DEFINED(CLR)}
                      else Borland.Delphi.System.Break;
{$ELSE}
                      else System.Break;
{$ENDIF}
                    end;
                  end;
                end;
                AdjustX := RowSize - Pos.X;
                if AdjustX > RowSpace then
                  AdjustX := RowSpace;
                Dec(RowSpace, AdjustX);
                Dec(RowSize, AdjustX);
              end;
              Pos.X := RowSize;
            end;

            if (Redo <> nil) and not SkipRedo then Break;

            if Pos.Y <> PrevRowHeight then
              Pos.Y := PrevRowHeight;

            if Pos.Y + DockPos.Height > RowHeight then
              RowHeight := Pos.Y + DockPos.Height;

            Inc(RowSpace, Pos.X - RowSize);
            Inc(RowSize, Pos.X - RowSize + CX);

            if DockPos.Parent = nil then
            begin
              DockPos.TempPos := Pos;
              DockPos.TempWidth := CX;
            end
            else
            begin
              if ShouldRedo(DockPos, Pos, CX) then
{$IF DEFINED(CLR)}
                Borland.Delphi.System.Break
{$ELSE}
                System.Break
{$ENDIF}
              else if not DockPos.Break and (DockPos.TempPos.X < Pos.X) then
              begin
                DockPos.TempPos := Pos;
                DockPos.TempWidth := CX;
              end;
            end;

            TmpDockPos := DockPos.SubItem;
            while TmpDockPos <> nil do
              with TmpDockPos{$IFNDEF CLR}^{$ENDIF} do
              begin
                Pos := DockPos.Pos;
                TempPos := DockPos.TempPos;
                Inc(Pos.Y, Parent.Height);
                Inc(TempPos.Y, Parent.Height);
                Width := DockPos.Width;
                TempWidth := DockPos.TempWidth;
                TmpDockPos := SubItem;
              end;
          end;
        end;

        if (Redo <> nil) and not SkipRedo then Break;

        { Determine whether controls on this row can fit }
        Shift := TotalSize - RowSize;
        if Shift < 0 then
        begin
          TotalSize := ARect.Right - ARect.Left;
          { Try to move all controls to fill space }
          AdjustX := RowSize;
          TempRowSpace := RowSpace;
          for I := LastIndex downto FirstIndex do
          begin
            DockPos := TDockPosType(FItems[I]);
            Control := DockPos.Control;
            if (csDesigning in ComponentState) or Control.Visible then
            begin
              if (DockPos.TempPos.X + DockPos.TempWidth) > TotalSize then
              begin
                MoveBy := (DockPos.TempPos.X + DockPos.TempWidth) - TotalSize;
                if I < LastIndex then
                  Dec(TempRowSpace, AdjustX - (DockPos.TempPos.X +
                    DockPos.TempWidth));
                if MoveBy <= TempRowSpace then
                  Shift := MoveBy else
                  Shift := TempRowSpace;
                if Shift <= TempRowSpace then
                begin
                  AdjustX := DockPos.TempPos.X;
                  Dec(DockPos.TempPos.X, Shift);
                  Dec(TotalSize, DockPos.TempWidth);

                  if ShouldRedo(DockPos, DockPos.TempPos, DockPos.TempWidth) then
                    Break;

                  TmpDockPos := DockPos.SubItem;
                  while TmpDockPos <> nil do
                    with TmpDockPos{$IFNDEF CLR}^{$ENDIF} do
                    begin
                      TempPos := DockPos.TempPos;
                      Inc(TempPos.Y, Parent.Height);
                      TmpDockPos := SubItem;
                    end;
                end
                else
                  Break;
              end;
            end;
          end;

          if (Redo <> nil) and not SkipRedo then Break;

          { Try to minimize all controls to fill space }
          if TotalSize < 0 then
          begin
            TotalSize := ARect.Right - ARect.Left;
            for I := LastIndex downto FirstIndex do
            begin
              DockPos := TDockPosType(FItems[I]);
              Control := DockPos.Control;
              if (csDesigning in ComponentState) or Control.Visible then
              begin
                if DockPos.TempPos.X + DockPos.TempWidth > TotalSize then
                begin
                  { Try to minimize control, move if it can't be resized }
                  DockPos.TempWidth := DockPos.TempWidth -
                    ((DockPos.TempPos.X + DockPos.TempWidth) - TotalSize);
                  if DockPos.TempWidth < Control.Constraints.MinWidth +
                    DockPos.Insets.Left + DockPos.Insets.Right then
                    DockPos.TempWidth := Control.Constraints.MinWidth +
                      DockPos.Insets.Left + DockPos.Insets.Right;
                  { Move control }
                  if DockPos.TempPos.X + DockPos.TempWidth > TotalSize then
                  begin
                    Dec(DockPos.TempPos.X, (DockPos.TempPos.X +
                      DockPos.TempWidth) - TotalSize);
                    if DockPos.TempPos.X < ARect.Left then
                      DockPos.TempPos.X := ARect.Left;
                  end;

                  if ShouldRedo(DockPos, DockPos.TempPos, DockPos.TempWidth) then
                    Break;

                  TmpDockPos := DockPos.SubItem;
                  while TmpDockPos <> nil do
                    with TmpDockPos{$IFNDEF CLR}^{$ENDIF} do
                    begin
                      Pos := DockPos.Pos;
                      TempPos := DockPos.TempPos;
                      Inc(TempPos.Y, Parent.Height);
                      TempWidth := DockPos.TempWidth;
                      TmpDockPos := SubItem;
                    end;
                end;
                Dec(TotalSize, DockPos.TempWidth);
              end;
            end;
          end;

          if (Redo <> nil) and not SkipRedo then Break;

                                                                          
                                                                             
                       
          if (TotalSize < 0) and (FirstIndex <> LastIndex) then
          begin
            DockPos := TDockPosType(FItems[LastIndex]);
            DockPos.TempPos.X := 0;
            DockPos.TempWidth := DockPos.Width;
            DockPos.TempBreak := True;
            Inc(RowCount);

            if ShouldRedo(DockPos, DockPos.TempPos, DockPos.TempWidth) then
              Break;

            TmpDockPos := DockPos.SubItem;
            while TmpDockPos <> nil do
              with TmpDockPos{$IFNDEF CLR}^{$ENDIF} do
              begin
                TempPos := DockPos.TempPos;
                Inc(TempPos.Y, Parent.Height);
                TempWidth := DockPos.TempWidth;
                TmpDockPos := SubItem;
              end;
          end
          else
            Inc(Row);
        end
        else
          Inc(Row);

      end;

    until Redo = nil;

    Dirty := False; // avoid W1036: Variable '%s' might not have been initialized
    { Now position controls }
    for I := 0 to FItems.Count - 1 do
    begin
      DockPos := TDockPosType(FItems[I]);
      with DockPos{$IFNDEF CLR}^{$ENDIF} do
        if (Parent = nil) and ((csDesigning in ComponentState) or
          Control.Visible) then
        begin
          with Insets do
            R := Rect(Left + TempPos.X, Top + TempPos.Y,
              TempPos.X + TempWidth - Right,
              TempPos.Y + DockPos.Height - Bottom);
          TmpDockPos := SubItem;
          while TmpDockPos <> nil do
          begin
            Inc(R.Bottom, TmpDockPos.Height);
            TmpDockPos := TmpDockPos.SubItem;
          end;
          if (R.Left <> Control.Left) or (R.Top <> Control.Top) or
            (R.Right - R.Left <> Control.Width) or
            (R.Bottom - R.Top <> Control.Height) then
          begin
            Dirty := True;
            Control.BoundsRect := R;
          end;
        end;
    end;
    if Dirty or (AControl <> nil) then
      Invalidate;
    { Apply any constraints }
    AdjustSize;
  finally
    FAligning := False;
  end;
end;

const
  DefaultInsets: TRect = (Left: 11; Top: 2; Right: 2; Bottom: 2);

function TCustomControlBar.UpdateItems(AControl: TControl): Boolean;
var
  I, J, Tmp, RepositionIndex: Integer;
  PrevBreak: Boolean;
  Control: TControl;
  Exists: Boolean;
  AddControls: TList;
  DockRect, R: TRect;
  Dirty: Boolean;
  IsVisible: Boolean;
  DockPos, TmpDockPos1, TmpDockPos2: TDockPosType;
  ChangedPriorBreak: Boolean;
                                        
{$IF DEFINED(CLR)}
  BreakList: TBooleanDynArray;
  IndexList: TIntegerDynArray;
  SizeList: TIntegerDynArray;
{$ELSE}
  BreakList: TList;
  IndexList: TList;
  SizeList: TList;
{$ENDIF}

  procedure AddControl(List: TList; Control: TControl);
  var
     I: Integer;
  begin
    for I := 0 to List.Count - 1 do
      with TControl(List[I]) do
        if (Control.Top < Top) or (Control.Top = Top) and
          (Control.Left < Left) then
        begin
          List.Insert(I, Control);
          Exit;
        end;
    List.Add(Control);
  end;

{$IF DEFINED(CLR)}
  procedure AddInteger(var List: TIntegerDynArray; Value: Integer);
  var
     L: Integer;
  begin
    L := Length(List);
    SetLength(List, L + 1);
    List[L] := Value;
  end;

  procedure AddFlag(var List: TBooleanDynArray; Value: Boolean);
  var
     L: Integer;
  begin
    L := Length(List);
    SetLength(List, L + 1);
    List[L] := Value;
  end;
{$ENDIF}

begin
  Result := False;
  ChangedPriorBreak := False;
  AddControls := TList.Create;
{$IF NOT DEFINED(CLR)}
  BreakList := TList.Create;
  IndexList := TList.Create;
  SizeList := TList.Create;
{$ENDIF}
  try
    AddControls.Capacity := ControlCount;
    RepositionIndex := -1;
    Dirty := False;
    for I := 0 to ControlCount - 1 do
    begin
      Control := Controls[I];
      IsVisible := (csDesigning in ComponentState) or Control.Visible;
      Exists := False;
      for J := 0 to FItems.Count - 1 do
        if (TDockPosType(FItems[J]).Parent = nil) and
          (TDockPosType(FItems[J]).Control = Control) then
        begin
          Dirty := Dirty or TDockPosType(FItems[J]).Visible <> IsVisible;
          TDockPosType(FItems[J]).Visible := IsVisible;
          Exists := True;
          Break;
        end;
      if (csDesigning in ComponentState) and Exists and (AControl = nil) then
      begin
        { Always redock the control to fix inherited streaming issues and
          insure we have the correct size when re-aligning. }
        Exists := False;
        FreeDockPos(FItems, TDockPosType(FItems[J]));
      end;

      if Exists and (Control = AControl) then
      begin
        RepositionIndex := J;
        DockPos := TDockPosType(FItems[J]);
        with DockPos{$IFNDEF CLR}^{$ENDIF} do
        begin
{$IF DEFINED(CLR)}
          AddInteger(SizeList, Insets.Top + Insets.Bottom);
{$ELSE}
          SizeList.Add(TObject(Insets.Top + Insets.Bottom));
{$ENDIF}
          if FDragControl <> nil then
            DockRect := Rect(Pos.X + Insets.Left,
              Pos.Y + Insets.Top, Pos.X + Width - Insets.Right,
              Pos.Y + Insets.Top + Control.Height)
          else
            DockRect := Control.BoundsRect;
          PrevBreak := Break;
        end;
        { If we were starting a row, then update any items to the right to
          begin starting the row. }
        if PrevBreak and (J + 1 < FItems.Count) then
        begin
          TmpDockPos1 := TDockPosType(FItems[J + 1]);
          if not TmpDockPos1.Break then
          begin
            TmpDockPos1.Break := True;
            TmpDockPos1.TempBreak := True;
            ChangedPriorBreak := True;
          end;
        end;

        { Remember the state of this item and its subitems }
{$IF DEFINED(CLR)}
        AddFlag(BreakList, PrevBreak);
        AddInteger(IndexList, J);
{$ELSE}
        BreakList.Add(TObject(Ord(PrevBreak)));
        IndexList.Add(TObject(J));
{$ENDIF}
        TmpDockPos1 := DockPos.SubItem;
        while TmpDockPos1 <> nil do
        begin
          Tmp := FItems.IndexOf(TmpDockPos1);
{$IF DEFINED(CLR)}
          AddFlag(BreakList, TmpDockPos1.Break);
          AddInteger(IndexList, Tmp);
{$ELSE}
          BreakList.Add(TObject(Ord(TmpDockPos1.Break)));
          IndexList.Add(TObject(Tmp));
{$ENDIF}
          with TmpDockPos1{$IFNDEF CLR}^{$ENDIF} do
{$IF DEFINED(CLR)}
            AddInteger(SizeList, Insets.Top + Insets.Bottom);
{$ELSE}
            SizeList.Add(TObject(Insets.Top + Insets.Bottom));
{$ENDIF}
          { If we were starting a row, then update any items to the right to
            begin starting the row. }
          if TmpDockPos1.Break then
          begin
            if Tmp + 1 < FItems.Count then
            begin
              TmpDockPos2 := TDockPosType(FItems[Tmp + 1]);
              if not TmpDockPos2.Break then
                TmpDockPos2.Break := True;
            end;
          end;
          TmpDockPos1 := TmpDockPos1.SubItem;
        end;

        { Remove this item from consideration in DockControl. It's as if we are
          adding a new control. }
        FreeDockPos(FItems, DockPos);
      end
      else if not Exists then
      begin
        if Control = AControl then Result := True;
        AddControl(AddControls, Control);
      end;
    end;
    for I := 0 to AddControls.Count - 1 do
    begin
      R := TControl(AddControls[I]).BoundsRect;
      DockControl(TControl(AddControls[I]), R, BreakList, IndexList, SizeList,
        nil, ChangedPriorBreak, DefaultInsets, -1, -1, False);
    end;
    if RepositionIndex >= 0 then
      DockControl(AControl, DockRect, BreakList, IndexList, SizeList, nil,
        ChangedPriorBreak, DefaultInsets, -1, -1, True);
    if Dirty then
      Invalidate;
  finally
    AddControls.Free;
{$IF NOT DEFINED(CLR)}
    BreakList.Free;
    IndexList.Free;
    SizeList.Free;
{$ENDIF}
  end;
end;

procedure TCustomControlBar.SetRowSize(Value: TRowSize);
begin
  if Value <> RowSize then
  begin
    FRowSize := Value;
  end;
end;

procedure TCustomControlBar.SetRowSnap(Value: Boolean);
begin
  if Value <> RowSnap then
  begin
    FRowSnap := Value;
  end;
end;

procedure TCustomControlBar.FlipChildren(AllLevels: Boolean);
begin
  { Do not flip controls }
end;

procedure TCustomControlBar.StickControls;
var
  I: Integer;
begin
  for I := 0 to FItems.Count - 1 do
    if FItems[I] <> nil then
      with TDockPosType(FItems[I]){$IFNDEF CLR}^{$ENDIF} do
      begin
        if Parent <> nil then
          Pos := Point(Parent.Pos.X, Parent.Pos.Y + Parent.Height)
        else
        begin
          Pos := Control.BoundsRect.TopLeft;
          Dec(Pos.X, Insets.Left);
          Dec(Pos.Y, Insets.Top);
        end;
        Width := Control.Width + Insets.Left + Insets.Right;
        Break := TempBreak;
      end;
end;

function TCustomControlBar.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
var
  I: Integer;
  DockPos: TDockPosType;
begin
  Result := True;
  if HandleAllocated and (not (csDesigning in ComponentState) or
    (ControlCount > 0)) then
  begin
    if Align in [alLeft, alRight] then
    begin
      NewWidth := 0;
      for I := 0 to FItems.Count - 1 do
      begin
        DockPos := TDockPosType(FItems[I]);
        with DockPos{$IFNDEF CLR}^{$ENDIF} do
        begin
          if (Parent = nil) and ((csDesigning in ComponentState) or Control.Visible) then
          begin
            if TempPos.X + Control.Width + Insets.Left + Insets.Right > NewWidth then
              NewWidth := TempPos.X + Control.Width + Insets.Left + Insets.Right;
          end;
        end;
      end;
      Inc(NewWidth, Width - ClientWidth);
    end
    else
    begin
      NewHeight := 0;
      for I := 0 to FItems.Count - 1 do
      begin
        DockPos := TDockPosType(FItems[I]);
        with DockPos{$IFNDEF CLR}^{$ENDIF} do
        begin
          if (Parent = nil) and ((csDesigning in ComponentState) or Control.Visible) then
          begin
            if TempPos.Y + Control.Height + Insets.Top + Insets.Bottom > NewHeight then
              NewHeight := TempPos.Y + Control.Height + Insets.Top + Insets.Bottom;
          end;
        end;
      end;
      Inc(NewHeight, Height - ClientHeight);
    end;
  end;
end;

{$IF DEFINED(CLR)}
procedure TCustomControlBar.DockControl(AControl: TControl; const ARect: TRect;
  var BreakList: TBooleanDynArray; var IndexList, SizeList: TIntegerDynArray;
  Parent: TDockPos; ChangedPriorBreak: Boolean; Insets: TRect;
  PreferredSize, RowCount: Integer; Existing: Boolean);
{$ELSE}
procedure TCustomControlBar.DockControl(AControl: TControl;
  const ARect: TRect; BreakList, IndexList, SizeList: TList; Parent: Pointer;
  ChangedPriorBreak: Boolean; Insets: TRect; PreferredSize, RowCount: Integer;
  Existing: Boolean);
{$ENDIF}
var
  I, InsPos, Size, TotalSize: Integer;
  DockPos: TDockPosType;
  MidPoint: TPoint;
  NewControlRect, ControlRect: TRect;
  IsVisible, DockBreak: Boolean;
  PrevBreak: Boolean;
  PrevIndex: Integer;
  NewHeight, PrevInsetHeight: Integer;
  NewLine: Boolean;

  procedure AddItem;
  var
    DockPos: TDockPosType;
    H: Integer;
  begin
    if InsPos = 0 then DockBreak := True;
    if (PrevIndex <> InsPos) or ChangedPriorBreak then
    begin
      if DockBreak and (InsPos < FItems.Count) then
      begin
        DockPos := TDockPosType(FItems[InsPos]);
        if not NewLine and DockPos.Break then
        begin
          DockPos.Break := False;
          DockPos.TempBreak := False;
        end;
      end;
    end;
    if RowSnap then
      H := RowSize else
      H := NewControlRect.Bottom - NewControlRect.Top;
    DockPos := CreateDockPos(AControl, DockBreak, IsVisible,
      NewControlRect.TopLeft, NewControlRect.Right - NewControlRect.Left,
      H, Parent, Insets, RowCount);
    if Parent <> nil then
      TDockPosType(Parent).SubItem := DockPos;
    FItems.Insert(InsPos, DockPos);
    { If we're adding an item that spans more than one row, we need to add
      pseudo items which are linked to this item. }
    if RowCount > 1 then
    begin
      Dec(RowCount);
      Inc(NewControlRect.Top, RowSize);
      DockControl(AControl, NewControlRect, BreakList, IndexList, SizeList,
        DockPos, False, Insets, PreferredSize, RowCount, False);
    end;
  end;

begin
{$IF DEFINED(CLR)}
  FDockingControl := AControl;
  if Length(BreakList) > 0 then
  begin
    PrevBreak := BreakList[0];
    BreakList := Copy(BreakList, 1, Length(BreakList) - 1);
  end
  else
    PrevBreak := False;
  if Length(IndexList) > 0 then
  begin
    PrevIndex := IndexList[0];
    IndexList := Copy(IndexList, 1, Length(IndexList) - 1);
  end
  else
    PrevIndex := -1;
  if Length(SizeList) > 0 then
  begin
    PrevInsetHeight := SizeList[0];
    SizeList := Copy(SizeList, 1, Length(SizeList) - 1);
  end
  else
    PrevInsetHeight := -1;
{$ELSE}
  FDockingControl := AControl;
  if BreakList.Count > 0 then
  begin
    PrevBreak := Boolean(BreakList[0]);
    BreakList.Delete(0);
  end
  else
    PrevBreak := False;
  if IndexList.Count > 0 then
  begin
                                                                           
    PrevIndex := Integer(IndexList[0]);
    IndexList.Delete(0);
  end
  else
    PrevIndex := -1;
  if SizeList.Count > 0 then
  begin
                                                                          
    PrevInsetHeight := Integer(SizeList[0]);
    SizeList.Delete(0);
  end
  else
    PrevInsetHeight := -1;
{$ENDIF}

  InsPos := 0;
  Size := -MaxInt;
  TotalSize := -MaxInt;

  NewControlRect := ARect;
  if RowCount < 0 then
    with AControl do
    begin
      PreferredSize := ARect.Right - ARect.Left;
      Insets := DefaultInsets;
      if PrevInsetHeight < 0 then
        PrevInsetHeight := Insets.Top + Insets.Bottom;
      { Try to fit control into row size }
      NewHeight := PrevInsetHeight + NewControlRect.Bottom - NewControlRect.Top;
      if RowSnap then
      begin
        RowCount := NewHeight div RowSize;
        if RowCount = 0 then
          Inc(RowCount);
        if Existing and (NewHeight > RowSize * RowCount) then
          Inc(RowCount);
      end
      else
        RowCount := 1;
      GetControlInfo(AControl, Insets, PreferredSize, RowCount);
      if RowCount = 0 then RowCount := 1;
      if RowSnap and Existing and (NewHeight > RowSize * RowCount) then
        RowCount := NewHeight div RowSize + 1;
      NewControlRect.Right := NewControlRect.Left + PreferredSize;
      AdjustControlRect(NewControlRect, Insets);
      if RowSnap then
        NewControlRect.Bottom := NewControlRect.Top + RowSize * RowCount;
    end;

  IsVisible := (csDesigning in Self.ComponentState) or AControl.Visible;
  MidPoint.Y := NewControlRect.Top + RowSize div 2;
  DockBreak := False;
  NewLine := False;

  for I := 0 to FItems.Count - 1 do
  begin
    DockPos := TDockPosType(FItems[I]);
    with DockPos{$IFNDEF CLR}^{$ENDIF} do
      ControlRect := Rect(Pos.X, Pos.Y, Pos.X + Width, Pos.Y + Height);
    //with ControlRect do
    //begin
    if ControlRect.Bottom - ControlRect.Top > Size then
      Size := ControlRect.Bottom - ControlRect.Top;
    if ControlRect.Bottom > TotalSize then
      TotalSize := ControlRect.Bottom;

    if (NewControlRect.Left > ControlRect.Left) and (MidPoint.Y > ControlRect.Top) then
    begin
      DockBreak := False;
      InsPos := I + 1;
    end;
    //end;

    if (I = FItems.Count - 1) or ((I + 1 = PrevIndex) and (PrevBreak)) or
      TDockPosType(FItems[I + 1]).Break then
    begin
      if MidPoint.Y < TotalSize then
      begin
        NewLine := (InsPos = 0) and (MidPoint.Y < ControlRect.Top);
        AddItem;
        Exit;
      end
      else
      begin
        DockBreak := (ControlRect.Left > NewControlRect.Left) or
          ((DockPos.SubItem = nil));
        InsPos := I + 1;
      end;
      if RowSnap then
        Size := RowSize else
        Size := 0;
    end;
  end;
  AddItem;
end;

procedure TCustomControlBar.UnDockControl(AControl: TControl);
var
  I: Integer;
  DockPos: TDockPosType;
begin
  FDockingControl := AControl;
  for I := 0 to FItems.Count - 1 do
  begin
    DockPos := TDockPosType(FItems[I]);
    if DockPos.Control = AControl then
    begin
      if DockPos.Break and (I < FItems.Count - 1) then
        TDockPosType(FItems[I + 1]).Break := True;
      FreeDockPos(FItems, DockPos);
      Break;
    end;
  end;
end;

procedure TCustomControlBar.GetControlInfo(AControl: TControl; var Insets: TRect;
  var PreferredSize, RowCount: Integer);
begin
  if RowCount = 0 then RowCount := 1;
  if Assigned(FOnBandInfo) then FOnBandInfo(Self, AControl, Insets,
    PreferredSize, RowCount);
end;

procedure TCustomControlBar.PaintControlFrame(Canvas: TCanvas; AControl: TControl;
  var ARect: TRect);
const
  Offset = 3;
var
  LRect: TRect;
  ElemDetails: TThemedElementDetails;
  Options: TBandPaintOptions;

  procedure DrawGrabber;
  begin
    with Canvas do
    begin
      Pen.Color := StyleServices.GetSystemColor(clBtnHighlight);
      MoveTo(LRect.Left + 1, LRect.Top);
      LineTo(LRect.Left, LRect.Top);
      LineTo(LRect.Left, LRect.Bottom - 1);
      Pen.Color := StyleServices.GetSystemColor(clBtnShadow);
      MoveTo(LRect.Right, LRect.Top);
      LineTo(LRect.Right, LRect.Bottom);
      LineTo(LRect.Left, LRect.Bottom);
    end;
  end;

  procedure DrawGradient;
  var
    LStartColor, LEndColor, LColor: TColor;
    LDetails: TThemedElementDetails;
    LStyle: TCustomStyleServices;
  begin
    LStyle := StyleServices;
    LStartColor := GradientStartColor;
    LEndColor := GradientEndColor;

    // overriding gradient colors if defined by the theme
    if LStyle.Enabled then
    begin
      LDetails := LStyle.GetElementDetails(tcbGradientItemFrame);
      if LStyle.GetElementColor(LDetails, ecGradientColor1, LColor) and (LColor <> clNone) then
        LStartColor := LColor;
      if LStyle.GetElementColor(LDetails, ecGradientColor2, LColor) and (LColor <> clNone) then
        LEndColor := LColor;
    end;

    { This gradient is actually the border gradient }
    if not TStyleManager.IsCustomStyleActive then
      GradientFillCanvas(Canvas, GetHighlightColor(LStartColor),
        GetShadowColor(LEndColor), ARect, GradientDirection);

    LRect := ARect;
    InflateRect(LRect, -Canvas.Pen.Width, -Canvas.Pen.Width);

    { The gradient of the band }
    GradientFillCanvas(Canvas, LStartColor, LEndColor,
      LRect, GradientDirection);
  end;

begin
  if FDrawingStyle = dsGradient then
    Options := [bpoGrabber, bpoGradient, bpoRoundRect]
  else
    Options := [bpoGrabber, bpoFrame];

  DoBandPaint(AControl, Canvas, ARect, Options);
  with Canvas do
  begin
    if bpoFrame in Options then
    begin
      if TStyleManager.IsCustomStyleActive then
        DrawStyleEdge(Canvas, ARect, [eeRaisedInner], [efRect])
      else
        DrawEdge(Handle, ARect, BDR_RAISEDINNER, BF_RECT);
    end;

    if bpoRoundRect in Options then
    begin
      BeginPath(Handle);
        Polyline([Point(ARect.Left + Integer(CornerEdge), ARect.Top),
          Point(ARect.Right - Integer(CornerEdge), ARect.Top), { Top line }
          Point(ARect.Right, ARect.Top + Integer(CornerEdge)), { Top right curve }
          Point(ARect.Right, ARect.Bottom - Integer(CornerEdge)), { Right side line }
          Point(ARect.Right - Integer(CornerEdge), ARect.Bottom), { Bottom right curve }
          Point(ARect.Left + Integer(CornerEdge), ARect.Bottom), { Bottom line }
          Point(ARect.Left, ARect.Bottom - Integer(CornerEdge)), { Bottom left curve }
          Point(ARect.Left, ARect.Top + Integer(CornerEdge)), { Left side line }
          Point(ARect.Left + Integer(CornerEdge), ARect.Top)]); { Top left curve }
      EndPath(Handle);

      { Clips the canvas to our roundrect drawn above using polyline }
      SelectClipPath(Handle, RGN_COPY);
    end;

    if bpoGradient in Options then
      DrawGradient;

    if bpoGrabber in Options then
    begin
      if StyleServices.Enabled then
      begin
        ElemDetails := StyleServices.GetElementDetails(trGripper);
        LRect := Rect(ARect.Left + 2, ARect.Top + 2, ARect.Left + 5 + 2, ARect.Bottom - 3);
        StyleServices.DrawElement(Canvas.Handle, ElemDetails, LRect);
      end
      else
      begin
        LRect := Rect(ARect.Left + Offset, ARect.Top + 2,
          ARect.Left + Offset + 2, ARect.Bottom - 3);
        DrawGrabber;
      end;
    end;
  end;
end;

procedure TCustomControlBar.Paint;
var
  I: Integer;
  DockPos: TDockPosType;
  Control: TControl;
  R: TRect;
begin
  with Canvas do
  begin
    if Assigned(FOnPaint) then FOnPaint(Self);
    { Draw grabbers and frames for each control }
    for I := 0 to FItems.Count - 1 do
    begin
      DockPos := TDockPosType(FItems[I]);
      Control := DockPos.Control;
      if (DockPos.Parent = nil) and ((csDesigning in ComponentState) or
        Control.Visible) then
      begin
        R := Control.BoundsRect;
        with DockPos.Insets do
        begin
          Dec(R.Left, Left);
          Dec(R.Top, Top);
          Inc(R.Right, Right);
          Inc(R.Bottom, Bottom);
        end;
        PaintControlFrame(Canvas, Control, R);
      end;
    end;
  end;
end;

function TCustomControlBar.HitTest(X, Y: Integer): TControl;
var
  DockPos: TDockPosType;
begin
  DockPos := TDockPosType(HitTest2(X, Y));
  if DockPos <> nil then
    Result := DockPos.Control else
    Result := nil;
end;

{$IF DEFINED(CLR)}
function TCustomControlBar.HitTest2(X, Y: Integer): TObject;
{$ELSE}
function TCustomControlBar.HitTest2(X, Y: Integer): Pointer;
{$ENDIF}
var
  I: Integer;
  R: TRect;
begin
  for I := 0 to FItems.Count - 1 do
  begin
    Result := TDockPosType(FItems[I]);
    with TDockPosType(Result){$IFNDEF CLR}^{$ENDIF} do
      if (Parent = nil) and ((csDesigning in ComponentState) or
        Control.Visible) then
      begin
        R := Control.BoundsRect;
        with Insets do
        begin
          Dec(R.Left, Left);
          Dec(R.Top, Top);
          Inc(R.Right, Right);
          Inc(R.Bottom, Bottom);
        end;
        if R.Contains(Point(X, Y)) then Exit;
      end;
  end;
  Result := nil;
end;

function TCustomControlBar.IsGradientEndColorStored: Boolean;
begin
  Result := FGradientEndColor <> GetShadowColor(clBtnFace, -25);
end;

procedure TCustomControlBar.DoAlignControl(AControl: TControl);
var
  Rect: TRect;
begin
  if not HandleAllocated or (csDestroying in ComponentState) then Exit;
  DisableAlign;
  try
    Rect := GetClientRect;
    AlignControls(AControl, Rect);
  finally
    ControlState := ControlState - [csAlignmentNeeded];
    EnableAlign;
  end;
end;

procedure TCustomControlBar.CNKeyDown(var Message: TWMKeyDown);
var
  DockPos: TDockPosType;
  P: TPoint;
begin
  inherited;
  if (Message.CharCode = VK_CONTROL) and not (csDesigning in ComponentState) and
    AutoDrag and (FDragControl <> nil) then
  begin
    DockPos := FindPos(FDragControl);
    if (DockPos <> nil) and (DockPos.Control <> nil) then
      with DockPos{$IFNDEF CLR}^{$ENDIF} do
      begin
        GetCursorPos(P);
        MapWindowPoints(0, Handle, P, 1);
        DragControl(Control, P.X, P.Y, True);
        Exit;
      end;
  end;
end;

procedure TCustomControlBar.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  DockPos: TDockPosType;

  procedure ResetDockItems;
  var
    I: Integer;
  begin
    for I := FItems.Count - 1 downto 0 do
{$IF DEFINED(CLR)}
      TDockPos(FItems[I]).Free;
{$ELSE}
      FreeMem(PDockPos(FItems[I]), SizeOf(TDockPos));
{$ENDIF}
    FItems.Clear;
    FDragControl := nil;
    FDockingControl := nil;
    DoAlignControl(nil);
  end;

begin
  inherited MouseDown(Button, Shift, X, Y);
  if MouseCapture then
  begin
    ResetDockItems;
    if FDragControl <> nil then
      DockPos := FindPos(FDragControl) else
      DockPos := TDockPosType(HitTest2(X, Y));
    if (DockPos <> nil) and (not (ssDouble in Shift) or not (AutoDrag or
      (ssDouble in Shift)) or (csDesigning in ComponentState) or
      not DragControl(DockPos.Control, X, Y, False)) and
      DoBeginBandMove(DockPos.Control) then
    begin
      FDragControl := DockPos.Control;
      if FDockingControl = FDragControl then
        FDockingControl := nil
      else
        StickControls;
      FDragOffset := Point(DockPos.TempPos.X - X, DockPos.TempPos.Y - Y);
    end;
  end;
end;

procedure TCustomControlBar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  DockPos: TDockPosType;
  Delta: Integer;
begin
  inherited MouseMove(Shift, X, Y);
  if MouseCapture then
  begin
    if FDragControl <> nil then
    begin
      DockPos := FindPos(FDragControl);
      if DockPos <> nil then
        with DockPos{$IFNDEF CLR}^{$ENDIF} do
        begin
          Pos.X := X + FDragOffset.X;
          Pos.Y := Y + FDragOffset.Y;
          TempPos := Pos;
          TempWidth := Control.Width + Insets.Left + Insets.Right;
          { Detect a float operation }
          if not (csDesigning in ComponentState) and AutoDrag then
          begin
            Delta := Control.Height;
            if (Pos.X < -Delta) or (Pos.Y < -Delta) or
              (Pos.X > ClientWidth + Delta) or (Pos.Y > ClientHeight + Delta) then
            begin
              if DragControl(Control, X, Y, True) then Exit;
            end;
          end;
          DoAlignControl(Control);
        end;
    end;
  end;
end;

procedure TCustomControlBar.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  Control: TControl;
begin
  if FDragControl <> nil then
  begin
    Control := FDragControl;
    FDragControl := nil;
    if FDockingControl = Control then
      FDockingControl := nil
    else
      StickControls;
    DoEndBandMove(Control);
  end;
  inherited MouseUp(Button, Shift, X, Y);
end;

{$IF DEFINED(CLR)}
function TCustomControlBar.FindPos(AControl: TControl): TDockPos;
{$ELSE}
function TCustomControlBar.FindPos(AControl: TControl): Pointer;
{$ENDIF}
var
  I: Integer;
begin
  for I := 0 to FItems.Count - 1 do
    with TDockPosType(FItems[I]){$IFNDEF CLR}^{$ENDIF} do
    begin
      if (Parent = nil) and (Control = AControl) then
      begin
        Result := TDockPosType(FItems[I]);
        Exit;
      end;
    end;
  Result := nil;
end;

function TCustomControlBar.DragControl(AControl: TControl; X, Y: Integer;
  KeepCapture: Boolean): Boolean;
begin
  Result := True;
  if (AControl <> nil) and Assigned(FOnBandDrag) then
    FOnBandDrag(Self, AControl, Result);
  if Result then
    AControl.BeginDrag(True);
end;

procedure TCustomControlBar.DockOver(Source: TDragDockObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  inherited DockOver(Source, X, Y, State, Accept);
  if AutoDrag and Accept and ((State = dsDragEnter) and AutoDock)
  and Source.Control.Floating then
  begin
    FDragControl := Source.Control;
    FDragControl.EndDrag(True);
    PostMessage(Handle, WM_LBUTTONDOWN, MK_LBUTTON, MakeLong(FDragControl.Left,
      FDragControl.Top));
  end;
end;

procedure TCustomControlBar.GetSiteInfo(Client: TControl; var InfluenceRect: TRect;
  MousePos: TPoint; var CanDock: Boolean);
begin
  inherited GetSiteInfo(Client, InfluenceRect, MousePos, CanDock);
  CanDock := CanDock and not FFloating;
end;

procedure TCustomControlBar.DoBandMove(Control: TControl; var ARect: TRect);
begin
  if Assigned(FOnBandMove) then FOnBandMove(Self, Control, ARect);
end;

procedure TCustomControlBar.DoBandPaint(Control: TControl; Canvas: TCanvas;
  var ARect: TRect; var Options: TBandPaintOptions);
begin
  if Assigned(FOnBandPaint) then
    FOnBandPaint(Self, Control, Canvas, ARect, Options);
end;

function TCustomControlBar.DoBeginBandMove(Control: TControl): Boolean;
begin
  Result := True;
  if Assigned(FOnBeginBandMove) then
    FOnBeginBandMove(Self, Control, Result);
end;

procedure TCustomControlBar.DoEndBandMove(Control: TControl);
begin
  if Assigned(FOnEndBandMove) then
    FOnEndBandMove(Self, Control);
end;

function TCustomControlBar.GetPalette: HPALETTE;
begin
  Result := 0;
  if FPicture.Graphic <> nil then
    Result := FPicture.Graphic.Palette;
end;

procedure TCustomControlBar.SetPicture(const Value: TPicture);
begin
  FPicture.Assign(Value);
end;

function TCustomControlBar.DoPaletteChange: Boolean;
var
  ParentForm: TCustomForm;
  Tmp: TGraphic;
begin
  Result := False;
  Tmp := Picture.Graphic;
  if Visible and (not (csLoading in ComponentState)) and (Tmp <> nil) and
    (Tmp.PaletteModified) then
  begin
    if (Tmp.Palette = 0) then
      Tmp.PaletteModified := False
    else
    begin
      ParentForm := GetParentForm(Self);
      if Assigned(ParentForm) and ParentForm.Active and Parentform.HandleAllocated then
      begin
        if FDrawing then
          ParentForm.Perform(WM_QUERYNEWPALETTE, 0, 0)
        else
          PostMessage(ParentForm.Handle, WM_QUERYNEWPALETTE, 0, 0);
        Result := True;
        Tmp.PaletteModified := False;
      end;
    end;
  end;
end;

procedure TCustomControlBar.PictureChanged(Sender: TObject);
begin
  if Picture.Graphic <> nil then
    if DoPaletteChange and FDrawing then Update;
  if not FDrawing then Invalidate;
end;

{$IF DEFINED(CLR)}
procedure TCustomControlBar.ControlListChange(Inserting: Boolean; Child: TControl);
begin
  inherited;
  if not Inserting then
  begin
    if Child = FDragControl then
      FDragControl := nil;
    UnDockControl(Child);
    if AutoSize then AdjustSize;
    Invalidate;
  end;
end;
{$ENDIF}

{$IF NOT DEFINED(CLR)}
procedure TCustomControlBar.CMControlListChange(var Message: TCMControlListChange);
begin
  inherited;
  if not Message.Inserting then
  begin
    if Message.Control = FDragControl then
      FDragControl := nil;
    UnDockControl(Message.Control);
    if AutoSize then AdjustSize;
    Invalidate;
  end;
end;
{$ENDIF}

procedure TCustomControlBar.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  Message.Result := Ord((FDragControl <> nil) or
    (HitTest(Message.XPos, Message.YPos) <> nil));
end;

procedure TCustomControlBar.WMEraseBkgnd(var Message: TWmEraseBkgnd);
var
  R: TRect;
  I, J: Integer;
  Save: Boolean;
begin
  if Message.DC <> 0 then
    Canvas.Handle := Message.DC;
  if Picture.Graphic <> nil then
  begin
    try
      R := ClientRect;
      Save := FDrawing;
      FDrawing := True;
      try
        { Tile image across client area }
        for I := 0 to (R.Right - R.Left) div Picture.Width do
          for J := 0 to (R.Bottom - R.Top) div Picture.Height do
            Canvas.Draw(I * Picture.Width, J * Picture.Height, Picture.Graphic);
      finally
        FDrawing := Save;
      end
    finally
      if Message.DC <> 0 then
        Canvas.Handle := 0;
      Message.Result := 1;
    end;
  end
  else
  begin
    if TStyleManager.IsCustomStyleActive then
      Canvas.Brush.Color := StyleServices.GetStyleColor(scWindow)
    else
      Canvas.Brush.Color := Color;
    Canvas.Brush.Style := bsSolid;
    Canvas.FillRect(ClientRect);
    inherited;
  end;
end;

procedure TCustomControlBar.SetGradientDirection(Value: TGradientDirection);
begin
  if Value <> FGradientDirection then
  begin
    FGradientDirection := Value;
    if HandleAllocated then
      Repaint;
  end;
end;

{$IF DEFINED(CLR)}
procedure TCustomControlBar.CMInvalidate(var Message: TMessage);
var
  I: Integer;
begin
  if Message.WParam = 0 then
    for I := 0 to ControlCount - 1 do
      Controls[I].Invalidate;
  inherited;
end;
{$ENDIF}

procedure TCustomControlBar.SetDrawingStyle(const Value: TBandDrawingStyle);
begin
  if Value <> FDrawingStyle then
  begin
    FDrawingStyle := Value;
    if HandleAllocated then
      Repaint;
  end;
end;

{ TBoundLabel }

constructor TBoundLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Name := 'SubLabel';  { do not localize }
  SetSubComponent(True);
  if Assigned(AOwner) then
    Caption := AOwner.Name;
end;

procedure TBoundLabel.AdjustBounds;
begin
  inherited AdjustBounds;
  if Owner is TCustomLabeledEdit then
    with Owner as TCustomLabeledEdit do
      SetLabelPosition(LabelPosition);
end;

function TBoundLabel.GetHeight: Integer;
begin
  Result := inherited Height;
end;

function TBoundLabel.GetLeft: Integer;
begin
  Result := inherited Left;
end;

function TBoundLabel.GetTop: Integer;
begin
  Result := inherited Top;
end;

function TBoundLabel.GetWidth: Integer;
begin
  Result := inherited Width;
end;

procedure TBoundLabel.SetHeight(const Value: Integer);
begin
  SetBounds(Left, Top, Width, Value);
end;

procedure TBoundLabel.SetWidth(const Value: Integer);
begin
  SetBounds(Left, Top, Value, Height);
end;

{ TCustomLabeledEdit }

constructor TCustomLabeledEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLabelPosition := lpAbove;
  FLabelSpacing := 3;
  SetupInternalLabel;
end;

procedure TCustomLabeledEdit.CMBidimodechanged(var Message: TMessage);
begin
  inherited;
  if FEditLabel <> nil then
    FEditLabel.BiDiMode := BiDiMode;
end;

procedure TCustomLabeledEdit.CMEnabledchanged(var Message: TMessage);
begin
  inherited;
  if FEditLabel <> nil then
    FEditLabel.Enabled := Enabled;
end;

procedure TCustomLabeledEdit.CMVisiblechanged(var Message: TMessage);
begin
  inherited;
  if FEditLabel <> nil then
    FEditLabel.Visible := Visible;
end;

procedure TCustomLabeledEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FEditLabel) and (Operation = opRemove) then
    FEditLabel := nil;
end;

procedure TCustomLabeledEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
end;

procedure TCustomLabeledEdit.SetLabelPosition(const Value: TLabelPosition);
var
  P: TPoint;
begin
  if FEditLabel = nil then Exit;
  FLabelPosition := Value;
  case Value of
    lpAbove:
      case AdjustedAlignment(UseRightToLeftAlignment, Alignment) of
        taLeftJustify: P := Point(Left, Top - FEditLabel.Height - FLabelSpacing);
        taRightJustify: P := Point(Left + Width - FEditLabel.Width,
          Top - FEditLabel.Height - FLabelSpacing);
        taCenter: P := Point(Left + (Width - FEditLabel.Width) div 2,
          Top - FEditLabel.Height - FLabelSpacing);
      end;
    lpBelow:
      case AdjustedAlignment(UseRightToLeftAlignment, Alignment) of
        taLeftJustify: P := Point(Left, Top + Height + FLabelSpacing);
        taRightJustify: P := Point(Left + Width - FEditLabel.Width,
          Top + Height + FLabelSpacing);
        taCenter: P := Point(Left + (Width - FEditLabel.Width) div 2,
          Top + Height + FLabelSpacing);
      end;
    lpLeft : P := Point(Left - FEditLabel.Width - FLabelSpacing,
                    Top + ((Height - FEditLabel.Height) div 2));
    lpRight: P := Point(Left + Width + FLabelSpacing,
                    Top + ((Height - FEditLabel.Height) div 2));
  end;
  FEditLabel.SetBounds(P.x, P.y, FEditLabel.Width, FEditLabel.Height);
end;

procedure TCustomLabeledEdit.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

procedure TCustomLabeledEdit.SetName(const Value: TComponentName);
var
  LClearText: Boolean;
begin
  if (csDesigning in ComponentState) and (FEditLabel <> nil) and
     ((FEditlabel.GetTextLen = 0) or
     (CompareText(FEditLabel.Caption, Name) = 0)) then
    FEditLabel.Caption := Value;
  LClearText := (csDesigning in ComponentState) and (Text = '');
  inherited SetName(Value);
  if LClearText then
    Text := '';
end;

procedure TCustomLabeledEdit.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if FEditLabel = nil then exit;
  FEditLabel.Parent := AParent;
  FEditLabel.Visible := True;
end;

procedure TCustomLabeledEdit.SetupInternalLabel;
begin
  if Assigned(FEditLabel) then exit;
  FEditLabel := TBoundLabel.Create(Self);
  FEditLabel.FreeNotification(Self);
  FEditLabel.FocusControl := Self;
end;

{ TEditButton.TGlyph }

constructor TEditButton.TGlyph.Create(AButton: TEditButton);
begin
  inherited Create(AButton.FEditControl);
  FButton := AButton;
  FState := bsNormal;
  Parent := FButton.FEditControl;
  Visible := False;
end;

procedure TEditButton.TGlyph.Click;
begin
  // Replicate from TControl to set Sender to owning TButtonedEdit control
  if Assigned(OnClick) and (Action <> nil) and not DelegatesEqual(@OnClick, @Action.OnExecute) then
    OnClick(FButton.EditControl)
  else if not (csDesigning in ComponentState) and (ActionLink <> nil) then
    ActionLink.Execute(FButton.EditControl)
  else if Assigned(OnClick) then
    OnClick(FButton.EditControl);
end;

procedure TEditButton.TGlyph.CreateWnd;
begin
  inherited;
  if Visible then
    FButton.FEditControl.UpdateEditMargins;
end;

procedure TEditButton.TGlyph.Paint;
var
  LIndex: Integer;
begin
  inherited;
  if (FButton.Images <> nil) and Visible then
  begin
    LIndex := FButton.ImageIndex;
    if Enabled then
    begin
      case FState of
        bsHot:
          if FButton.HotImageIndex <> -1 then
            LIndex := FButton.HotImageIndex;
        bsPushed:
          if FButton.PressedImageIndex <> -1 then
            LIndex := FButton.PressedImageIndex;
      end;
    end
    else
      if FButton.DisabledImageIndex <> -1 then
        LIndex := FButton.DisabledImageIndex;
    if LIndex <> -1 then
      FButton.Images.Draw(Canvas, 0, 0, LIndex);
  end;
end;

procedure TEditButton.TGlyph.WndProc(var Message: TMessage);
var
  LPoint: TPoint;
begin
  if (Message.Msg = WM_CONTEXTMENU) and (FButton.EditControl.PopupMenu = nil) then
    Exit;

  inherited;
  case Message.Msg of
    CM_MOUSEENTER: FState := bsHot;
    CM_MOUSELEAVE: FState := bsNormal;
    WM_LBUTTONDOWN:
      if FButton.FDropDownMenu <> nil then
      begin
        if not (csDesigning in Parent.ComponentState) then
        begin
          LPoint := ClientToScreen(Point(0, FButton.EditControl.Height));
          FButton.FDropDownMenu.Popup(LPoint.X, LPoint.Y);
        end;
      end
      else
        FState := bsPushed;
    WM_LBUTTONUP: FState := bsHot;
    CM_VISIBLECHANGED: FButton.UpdateBounds;
  else
    Exit;
  end;
  Invalidate;
end;

{ TEditButton }

constructor TEditButton.Create(EditControl: TCustomButtonedEdit; APosition: TButtonPosition);
begin
  inherited Create;
  FEditControl := EditControl;
  FGlyph := TGlyph.Create(Self);
  FHotImageIndex := -1;
  FImageIndex := -1;
  FPosition := APosition;
  FPressedImageIndex := -1;
  FDisabledImageIndex := -1;
end;

destructor TEditButton.Destroy;
begin
  FGlyph.Parent.RemoveControl(FGlyph);
  FGlyph.Free;
  inherited;
end;

function TEditButton.GetEnabled: Boolean;
begin
  Result := FGlyph.Enabled;
end;

function TEditButton.GetCustomHint: TCustomHint;
begin
  Result := FGlyph.CustomHint;
end;

function TEditButton.GetHint: string;
begin
  Result := FGlyph.Hint;
end;

function TEditButton.GetImages: TCustomImageList;
begin
  Result := FEditControl.Images;
end;

function TEditButton.GetOwner: TPersistent;
begin
  Result := FEditControl;
end;

function TEditButton.GetVisible: Boolean;
begin
  Result := FGlyph.Visible;
end;

procedure TEditButton.SetDisabledImageIndex(const Value: TImageIndex);
begin
  if Value <> FDisabledImageIndex then
  begin
    FDisabledImageIndex := Value;
    if not Enabled then
      FGlyph.Invalidate;
  end;
end;

procedure TEditButton.SetEnabled(const Value: Boolean);
begin
  if Value <> FGlyph.Enabled then
  begin
    FGlyph.Enabled := Value;
    FGlyph.Invalidate;
  end;
end;

procedure TEditButton.SetCustomHint(const Value: TCustomHint);
begin
  if Value <> FGlyph.CustomHint then
    FGlyph.CustomHint := Value;
end;

procedure TEditButton.SetHint(const Value: string);
begin
  if Value <> FGlyph.Hint then
    FGlyph.Hint := Value;
end;

procedure TEditButton.SetHotImageIndex(const Value: TImageIndex);
begin
  if Value <> FHotImageIndex then
  begin
    FHotImageIndex := Value;
    if FGlyph.FState = bsHot then
      FGlyph.Invalidate;
  end;
end;

procedure TEditButton.SetImageIndex(const Value: TImageIndex);
begin
  if Value <> FImageIndex then
  begin
    FImageIndex := Value;
    if FGlyph.FState = bsNormal then
      FGlyph.Invalidate;
  end;
end;

procedure TEditButton.SetPressedImageIndex(const Value: TImageIndex);
begin
  if Value <> FPressedImageIndex then
  begin
    FPressedImageIndex := Value;
    if FGlyph.FState = bsPushed then
      FGlyph.Invalidate;
  end;
end;

procedure TEditButton.SetVisible(const Value: Boolean);
begin
  if Value <> FGlyph.Visible then
  begin
    FGlyph.Visible := Value;
    FEditControl.UpdateEditMargins;
  end;
end;

procedure TEditButton.UpdateBounds;
var
  EdgeSize, NewLeft: Integer;
begin
  if FGlyph <> nil then
  begin
    if Images <> nil then
    begin
      FGlyph.Width := Images.Width;
      FGlyph.Height := Images.Height;
    end
    else
    begin
      FGlyph.Width := 0;
      FGlyph.Height := 0;
    end;
    FGlyph.Top := 0;
    NewLeft := FGlyph.Left;

    if not StyleServices.Enabled then
      FGlyph.Top := 1;

    case FPosition of
      bpLeft:
        begin
          if StyleServices.Enabled then
            NewLeft := 0
          else
            NewLeft := 1;
        end;
      bpRight:
        begin
          NewLeft := FEditControl.Width - FGlyph.Width;
          if FEditControl.BorderStyle <> bsNone then
            Dec(NewLeft, 4);
          if FEditControl.BevelKind <> bkNone then
          begin
            EdgeSize := 0;
            if FEditControl.BevelInner <> bvNone then
              Inc(EdgeSize, FEditControl.BevelWidth);
            if FEditControl.BevelOuter <> bvNone then
              Inc(EdgeSize, FEditControl.BevelWidth);
            if beRight in FEditControl.BevelEdges then
              Dec(NewLeft, EdgeSize);
            if beLeft in FEditControl.BevelEdges then
              Dec(NewLeft, EdgeSize);
          end;
          if not StyleServices.Enabled then
            Dec(NewLeft);
        end;
    end;

    if (not FEditControl.Ctl3D) and (FEditControl.BorderStyle <> bsNone) then
    begin
      FGlyph.Top := 2;
      Inc(NewLeft, 2);
    end;

    FGlyph.Left := NewLeft;

    if (csDesigning in FEditControl.ComponentState) and not Visible then
      FGlyph.Width := 0;
  end;
end;

{ TCustomButtonedEdit }

constructor TCustomButtonedEdit.Create(AOwner: TComponent);
begin
  inherited;
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FLeftButton := GetEditButtonClass.Create(Self, bpLeft);
  FRightButton := GetEditButtonClass.Create(Self, bpRight);
end;

destructor TCustomButtonedEdit.Destroy;
begin
  FreeAndNil(FCanvas);
  FreeAndNil(FImageChangeLink);
  FreeAndNil(FLeftButton);
  FreeAndNil(FRightButton);
  inherited;
end;

function TCustomButtonedEdit.AdjustTextHint(Margin: Integer; const Value: string): string;
var
  LWidth, Count: Integer;
begin
  if (Margin = 0) or (Win32MajorVersion >= 6) then
    inherited DoSetTextHint(Value)
  else
  begin
    // This is a hack!! Due to a presumed bug in Windows XP any text hint
    // set with EM_SETCUEBANNER does not respect left margins set with
    // EM_SETMARGINS. The following works around the issue.
    FCanvas.Font := Font;
    LWidth := FCanvas.TextWidth(' '); // do not localize
    Count := Margin div LWidth;
    if (Margin mod LWidth) > 0 then
      Inc(Count);
    inherited DoSetTextHint(StringOfChar(' ', Count) + Value);
  end;
end;

procedure TCustomButtonedEdit.DoSetTextHint(const Value: string);
begin
  AdjustTextHint(0, Value);
end;

function TCustomButtonedEdit.GetEditButtonClass: TEditButtonClass;
begin
  Result := TEditButton;
end;

function TCustomButtonedEdit.GetOnLeftButtonClick: TNotifyEvent;
begin
  Result := LeftButton.Glyph.OnClick;
end;

function TCustomButtonedEdit.GetOnRightButtonClick: TNotifyEvent;
begin
  Result := RightButton.Glyph.OnClick;
end;

procedure TCustomButtonedEdit.ImageListChange(Sender: TObject);
begin
  if HandleAllocated then
  begin
    FLeftButton.UpdateBounds;
    FRightButton.UpdateBounds;
    UpdateEditMargins;
  end;
end;

procedure TCustomButtonedEdit.DefaultHandler(var Message);
{$IF DEFINED(CLR)}
var
  LMessage: TMessage;
{$ENDIF}
begin
  inherited;
{$IF DEFINED(CLR)}
  LMessage := UnwrapMessage(TObject(Message));
  case LMessage.Msg of
{$ELSE}
  case TMessage(Message).Msg of
{$ENDIF}
    CN_CTLCOLOREDIT:
      begin
        FLeftButton.Glyph.Invalidate;
        FRightButton.Glyph.Invalidate;
      end;
    WM_SIZE: FRightButton.UpdateBounds;
  end;
end;

procedure TCustomButtonedEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FImages then
    begin
      FImages := nil;
      FLeftButton.UpdateBounds;
      FRightButton.UpdateBounds;
      UpdateEditMargins;
    end
    else if (LeftButton <> nil) and (AComponent = LeftButton.DropDownMenu) then
      LeftButton.DropDownMenu := nil
    else if (RightButton <> nil) and (AComponent = RightButton.DropDownMenu) then
      RightButton.DropDownMenu := nil;
  end;
end;

procedure TCustomButtonedEdit.SetImages(const Value: TCustomImageList);
begin
  if Value <> FImages then
  begin
    if FImages <> nil then
      FImages.UnRegisterChanges(FImageChangeLink);
    FImages := Value;
    if FImages <> nil then
    begin
      FImages.RegisterChanges(FImageChangeLink);
      FImages.FreeNotification(Self);
    end;
    FLeftButton.UpdateBounds;
    FRightButton.UpdateBounds;
    UpdateEditMargins;
  end;
end;

procedure TCustomButtonedEdit.SetLeftButton(const Value: TEditButton);
begin
  FLeftButton.Assign(Value);
end;

procedure TCustomButtonedEdit.SetOnLeftButtonClick(const Value: TNotifyEvent);
begin
  LeftButton.Glyph.OnClick := Value;
end;

procedure TCustomButtonedEdit.SetOnRightButtonClick(const Value: TNotifyEvent);
begin
  RightButton.Glyph.OnClick := Value;
end;

procedure TCustomButtonedEdit.SetRightButton(const Value: TEditButton);
begin
  FRightButton.Assign(Value);
end;

procedure TCustomButtonedEdit.UpdateEditMargins;
var
  LMargin, RMargin: Integer;
begin
  if HandleAllocated then
  begin
    LMargin := 0;
    RMargin := 0;
    if (Images <> nil) then
    begin
      if LeftButton.Visible then
        LMargin := Images.Width + 2;
      if RightButton.Visible then
        RMargin := Images.Width + 2;
    end;
    SendMessage(Handle, EM_SETMARGINS, EC_LEFTMARGIN or EC_RIGHTMARGIN, MakeLong(LMargin, RMargin));
    AdjustTextHint(LMargin, TextHint);
    Invalidate;
  end;
end;

procedure TCustomButtonedEdit.WndProc(var Message: TMessage);
var
  LLeft, LTop: Integer;
begin
  case Message.Msg of
    CN_CTLCOLORSTATIC,
    CN_CTLCOLOREDIT:
      if FImages <> nil then
      begin
        if LeftButton.Visible then
        begin
          LLeft := LeftButton.Glyph.Left;
          LTop := LeftButton.Glyph.Top;
          if StyleServices.Enabled and Ctl3D then
          begin
            Inc(LLeft);
            Inc(LTop);
          end;
          ExcludeClipRect(Message.WParam, LLeft + 1, LTop + 1,
            LeftButton.Glyph.Width + LeftButton.Glyph.Left, LeftButton.Glyph.Height);
        end;

        if RightButton.Visible then
        begin
          LTop := RightButton.Glyph.Top;
          if StyleServices.Enabled and Ctl3D then
            Inc(LTop);
          ExcludeClipRect(Message.WParam, RightButton.Glyph.Left, LTop + 1,
            RightButton.Glyph.Width + RightButton.Glyph.Left, RightButton.Glyph.Height);
        end;
      end;
  end;

  inherited;

  case Message.Msg of
    CM_BORDERCHANGED,
    CM_CTL3DCHANGED:
      begin
        if not (csLoading in ComponentState) then
        begin
          LeftButton.UpdateBounds;
          RightButton.UpdateBounds;
        end;
      end;
    CM_FONTCHANGED:
      if not (csLoading in ComponentState) then
        UpdateEditMargins;
  end;
end;

{ TCustomColorBox }

procedure TCustomColorBox.CloseUp;
begin
  inherited CloseUp;
  FListSelected := True;
end;

function ColorToPrettyName(Color: TColor; var Name: string): Boolean;
begin
  Result := True;
  case Color of
    clBlack: Name := SNameBlack;
    clMaroon: Name := SNameMaroon;
    clGreen: Name := SNameGreen;
    clOlive: Name := SNameOlive;
    clNavy: Name := SNameNavy;
    clPurple: Name := SNamePurple;
    clTeal: Name := SNameTeal;
    clGray: Name := SNameGray;
    clSilver: Name := SNameSilver;
    clRed: Name := SNameRed;
    clLime: Name := SNameLime;
    clYellow: Name := SNameYellow;
    clBlue: Name := SNameBlue;
    clFuchsia: Name := SNameFuchsia;
    clAqua: Name := SNameAqua;
    clWhite: Name := SNameWhite;
    clMoneyGreen: Name := SNameMoneyGreen;
    clSkyBlue: Name := SNameSkyBlue;
    clCream: Name := SNameCream;
    clMedGray: Name := SNameMedGray;

    clActiveBorder: Name := SNameActiveBorder;
    clActiveCaption: Name := SNameActiveCaption;
    clAppWorkSpace: Name := SNameAppWorkSpace;
    clBackground: Name := SNameBackground;
    clBtnFace: Name := SNameBtnFace;
    clBtnHighlight: Name := SNameBtnHighlight;
    clBtnShadow: Name := SNameBtnShadow;
    clBtnText: Name := SNameBtnText;
    clCaptionText: Name := SNameCaptionText;
    clDefault: Name := SNameDefault;
    clGrayText: Name := SNameGrayText;
    clGradientActiveCaption: Name := SNameGradientActiveCaption;
    clGradientInactiveCaption: Name := SNameGradientInactiveCaption;
    clHighlight: Name := SNameHighlight;
    clHighlightText: Name := SNameHighlightText;
    clHotLight: Name := SNameHotLight;
    clInactiveBorder: Name := SNameInactiveBorder;
    clInactiveCaption: Name := SNameInactiveCaption;
    clInactiveCaptionText: Name := SNameInactiveCaptionText;
    clInfoBk: Name := SNameInfoBk;
    clInfoText: Name := SNameInfoText;
    clMenu: Name := SNameMenu;
    clMenuBar: Name := SNameMenuBar;
    clMenuHighlight: Name := SNameMenuHighlight;
    clMenuText: Name := SNameMenuText;
    clNone: Name := SNameNone;
    clScrollBar: Name := SNameScrollBar;
    cl3DDkShadow: Name := SName3DDkShadow;
    cl3DLight: Name := SName3DLight;
    clWindow: Name := SNameWindow;
    clWindowFrame: Name := SNameWindowFrame;
    clWindowText: Name := SNameWindowText;
  else
    Result := False;
  end;
end;

function ColorToBorderColor(AColor: TColor; State: TOwnerDrawState): TColor;
begin
  if (Byte(AColor) > 192) or          {Red}
     (Byte(AColor shr 8) > 192) or    {Green}
     (Byte(AColor shr 16) > 192) then  {Blue}
    Result := clBlack
  else if odSelected in State then
    Result := clWhite
  else
    Result := AColor;
end;

procedure TCustomColorBox.ColorCallBack(const AName: String);
var
  I, LStart: Integer;
  LColor: TColor;
  LName: string;
begin
  LColor := StringToColor(AName);
  if cbPrettyNames in Style then
  begin
    if not ColorToPrettyName(LColor, LName) then
    begin
      if Copy(AName, 1, 2) = 'cl' then
        LStart := 3
      else
        LStart := 1;
      LName := '';
      for I := LStart to Length(AName) do
      begin
        case AName[I] of
          'A'..'Z':
            if LName <> '' then
              LName := LName + ' ';
        end;
        LName := LName + AName[I];
      end;
    end;
  end
  else
    LName := AName;
  Items.AddObject(LName, TObject(LColor));
end;

constructor TCustomColorBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited Style := csOwnerDrawFixed;
  FStyle := [cbStandardColors, cbExtendedColors, cbSystemColors];
  FSelectedColor := clBlack;
  FDefaultColorColor := clBlack;
  FNoneColorColor := clBlack;
  PopulateList;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TCustomColorBox.CreateWnd;
begin
  inherited CreateWnd;
  if FNeedToPopulate then
    PopulateList;
  if FNeedToSetSelected then
    SetSelected(FSelectedColor);
end;

procedure TCustomColorBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  LRect: TRect;
  LBackground: TColor;
begin
  with Canvas do
  begin
    FillRect(Rect);
    LBackground := Brush.Color;

    LRect := Rect;
    LRect.Right := LRect.Bottom - LRect.Top + LRect.Left;
    InflateRect(LRect, -1, -1);
    Brush.Color := Colors[Index];
    if Brush.Color = clDefault then
      Brush.Color := DefaultColorColor
    else if Brush.Color = clNone then
      Brush.Color := NoneColorColor;
    FillRect(LRect);
    Brush.Color := ColorToBorderColor(ColorToRGB(Brush.Color), State);
    FrameRect(LRect);

    Brush.Color := LBackground;
    Rect.Left := LRect.Right + 5;

    TextRect(Rect, Rect.Left,
      Rect.Top + (Rect.Bottom - Rect.Top - TextHeight(Items[Index])) div 2,
      Items[Index]);
  end;
end;

function TCustomColorBox.GetColor(Index: Integer): TColor;
begin
  Result := TColor(Items.Objects[Index]);
end;

function TCustomColorBox.GetColorName(Index: Integer): string;
begin
  Result := Items[Index];
end;

function TCustomColorBox.GetSelected: TColor;
begin
  if HandleAllocated then
    if ItemIndex <> -1 then
      Result := Colors[ItemIndex]
    else
      Result := NoColorSelected
  else
    Result := FSelectedColor;
end;

procedure TCustomColorBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  FListSelected := False;
  inherited KeyDown(Key, Shift);
end;

procedure TCustomColorBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (cbCustomColor in Style) and (Key = #13) and (ItemIndex = 0) then
  begin
    { If the user picked a custom color, force a select event to happen
      so the user can handle it }
    if PickCustomColor and Assigned(OnSelect)then
      OnSelect(Self);
    Key := #0;
  end;
end;

procedure TCustomColorBox.Loaded;
begin
  inherited;
  Selected := FSelectedColor;
  if FNeedToPopulate then
    PopulateList;
end;

function TCustomColorBox.PickCustomColor: Boolean;
var
  LColor: TColor;
begin
  with TColorDialog.Create(nil) do
    try
      LColor := ColorToRGB(TColor(Items.Objects[0]));
      Color := LColor;
{$IF DEFINED(CLR)}
      CustomColors.Text := Format('ColorA=%.8x', [Convert.ToInt32(LColor)]);
{$ELSE}
      CustomColors.Text := Format('ColorA=%.8x', [LColor]);
{$ENDIF}
      Result := Execute;
      if Result then
      begin
        Items.Objects[0] := TObject(Color);
        Self.Invalidate;
      end;
    finally
      Free;
    end;
end;

{$IF DEFINED(CLR)}
function TCustomColorBox.IndexOfColor(const Value: TColor): Integer;
var
  I: Integer;
begin
{ in CLR, we can't use Items.IndexOfObject because the boxed color
  identity is not the same as value identity }
  Result := -1;
  for I := 0 to Items.Count - 1 do
    if Value = TColor(Items.Objects[I]) then
    begin
      Result := I;
      Exit;
    end;
end;
{$ENDIF}

procedure TCustomColorBox.PopulateList;

  procedure DeleteRange(const AMin, AMax: Integer);
  var
    I: Integer;
  begin
    for I := AMax downto AMin do
      Items.Delete(I);
  end;

  procedure DeleteColor(const AColor: TColor);
  var
    I: Integer;
  begin
{$IF DEFINED(CLR)}
    I := IndexOfColor(AColor);
{$ELSE}
    I := Items.IndexOfObject(TObject(AColor));
{$ENDIF}
    if I <> -1 then
      Items.Delete(I);
  end;

var
  LSelectedColor, LCustomColor: TColor;
begin
  if HandleAllocated and not (csLoading in ComponentState) then
  begin
    Items.BeginUpdate;
    try
      LCustomColor := clBlack;
      if (cbCustomColor in Style) and (Items.Count > 0) then
        LCustomColor := TColor(Items.Objects[0]);
      LSelectedColor := FSelectedColor;
      Items.Clear;
      if Style <> [cbCustomColors] then
      begin
        GetColorValues(ColorCallBack);
        if not (cbIncludeNone in Style) then
          DeleteColor(clNone);
        if not (cbIncludeDefault in Style) then
          DeleteColor(clDefault);
        if not (cbSystemColors in Style) then
          DeleteRange(StandardColorsCount + ExtendedColorsCount, Items.Count - 1);
        if not (cbExtendedColors in Style) then
          DeleteRange(StandardColorsCount, StandardColorsCount + ExtendedColorsCount - 1);
        if not (cbStandardColors in Style) then
          DeleteRange(0, StandardColorsCount - 1);
        if cbCustomColor in Style then
          Items.InsertObject(0, SColorBoxCustomCaption, TObject(LCustomColor));
      end;
      if (cbCustomColors in Style) and Assigned(OnGetColors) then
        OnGetColors(Self, Items);
      Selected := LSelectedColor;
    finally
      Items.EndUpdate;
      FNeedToPopulate := False;
    end;
  end
  else
    FNeedToPopulate := True;
end;

procedure TCustomColorBox.Select;
begin
  if FListSelected then
  begin
    FListSelected := False;
    if (cbCustomColor in Style) and
       (ItemIndex = 0) and
       not PickCustomColor then
      Exit;
  end;
  inherited Select;
end;

procedure TCustomColorBox.SetDefaultColorColor(const Value: TColor);
begin
  if Value <> FDefaultColorColor then
  begin
    FDefaultColorColor := Value;
    Invalidate;
  end;
end;

procedure TCustomColorBox.SetNoneColorColor(const Value: TColor);
begin
  if Value <> FNoneColorColor then
  begin
    FNoneColorColor := Value;
    Invalidate;
  end;
end;

procedure TCustomColorBox.SetSelected(const AColor: TColor);
var
  I, Index: Integer;
begin
  if HandleAllocated then
  begin
{$IF DEFINED(CLR)}
    I := IndexOfColor(AColor);
{$ELSE}
    I := Items.IndexOfObject(TObject(AColor));
{$ENDIF}
    if (I = -1) and (cbCustomColor in Style) and (AColor <> NoColorSelected) then
    begin
      Items.Objects[0] := TObject(AColor);
      I := 0;
    end
    else if (cbCustomColor in Style) and (I = 0) then
    begin
      { Look for the color anywhere else but the first color before
        defaulting to selecting the "custom color". }
      for Index := 1 to Items.Count - 1 do
      begin
        if Items.Objects[Index] = TObject(AColor) then
        begin
          I := Index;
          Break;
        end;
      end;
    end;
    if (ItemIndex = 0) and (I = 0) then
      Invalidate { Refresh the color shown }
    else
      ItemIndex := I;
    FNeedToSetSelected := False;
  end
  else
    FNeedToSetSelected := True;
  FSelectedColor := AColor;
end;

procedure TCustomColorBox.SetStyle(AStyle: TColorBoxStyle);
begin
  if AStyle <> Style then
  begin
    FStyle := AStyle;
    Enabled := ([cbStandardColors, cbExtendedColors, cbSystemColors,
      cbCustomColor, cbCustomColors] * FStyle) <> [];
    PopulateList;
    if (Items.Count > 0) and (ItemIndex = -1) then
      ItemIndex := 0;
  end;
end;

{ TCustomColorListBox }

procedure TCustomColorListBox.ColorCallBack(const AName: String);
var
  I, LStart: Integer;
  LColor: TColor;
  LName: string;
{$IF DEFINED(CLR)}
  SB: StringBuilder;
{$ENDIF}
begin
  LColor := StringToColor(AName);
  if cbPrettyNames in Style then
  begin
    if not ColorToPrettyName(LColor, LName) then
    begin
      if Copy(AName, 1, 2) = 'cl' then
        LStart := 3
      else
        LStart := 1;
{$IF DEFINED(CLR)}
      SB := StringBuilder.Create(Length(AName));
      for I := LStart to Length(AName) do
      begin
        case AName[I] of
          'A'..'Z':
            if SB.Length > 0 then
              SB.Append(' ');
        end;
        SB.Append(AName[I]);
      end;
      LName := SB.ToString;
{$ELSE}
      LName := '';
      for I := LStart to Length(AName) do
      begin
        case AName[I] of
          'A'..'Z':
            if LName <> '' then
              LName := LName + ' ';
        end;
        LName := LName + AName[I];
      end;
{$ENDIF}
    end;
  end
  else
    LName := AName;
  Items.AddObject(LName, TObject(LColor));
end;

constructor TCustomColorListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited Style := lbOwnerDrawFixed;
  FStyle := [cbStandardColors, cbExtendedColors, cbSystemColors];
  FSelectedColor := clBlack;
  FDefaultColorColor := clBlack;
  FNoneColorColor := clBlack;
  PopulateList;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TCustomColorListBox.CreateWnd;
begin
  inherited CreateWnd;
  if FNeedToPopulate then
    PopulateList;
  if FNeedToSetSelected then
    SetSelected(FSelectedColor);
end;

procedure TCustomColorListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  LRect: TRect;
  LBackground: TColor;
begin
  with Canvas do
  begin
    FillRect(Rect);
    LBackground := Brush.Color;

    LRect := Rect;
    LRect.Right := LRect.Bottom - LRect.Top + LRect.Left + 5;
    InflateRect(LRect, -1, -1);
    Brush.Color := Colors[Index];
    if Brush.Color = clDefault then
      Brush.Color := DefaultColorColor
    else if Brush.Color = clNone then
      Brush.Color := NoneColorColor;
    FillRect(LRect);
    Brush.Color := ColorToBorderColor(ColorToRGB(Brush.Color), State);
    FrameRect(LRect);

    Brush.Color := LBackground;
    Rect.Left := LRect.Right + 5;

    TextRect(Rect, Rect.Left,
      Rect.Top + (Rect.Bottom - Rect.Top - TextHeight(Items[Index])) div 2,
      Items[Index]);
  end;
end;

function TCustomColorListBox.GetColor(Index: Integer): TColor;
begin
  Result := TColor(Items.Objects[Index]);
end;

function TCustomColorListBox.GetColorName(Index: Integer): string;
begin
  Result := Items[Index];
end;

function TCustomColorListBox.GetSelected: TColor;
begin
  if HandleAllocated then
    if ItemIndex <> -1 then
      Result := Colors[ItemIndex]
    else
      Result := NoColorSelected
  else
    Result := FSelectedColor;
end;

procedure TCustomColorListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  FListSelected := False;
  inherited KeyDown(Key, Shift);
end;

procedure TCustomColorListBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (cbCustomColor in Style) and (Key = #13) and (ItemIndex = 0) then
  begin
    { If the user picked a custom color, force a click event to happen
      so the user can handle it }
    if PickCustomColor then
      OnClick(Self);
    Key := #0;
  end;
end;

procedure TCustomColorListBox.Loaded;
begin
  inherited;
  Selected := FSelectedColor;
  if FNeedToPopulate then
    PopulateList;
end;

function TCustomColorListBox.PickCustomColor: Boolean;
var
  LColor: TColor;
begin
  with TColorDialog.Create(nil) do
    try
      LColor := ColorToRGB(TColor(Items.Objects[0]));
      Color := LColor;
      CustomColors.Text := Format('ColorA=%.8x', [LColor]);
      Result := Execute;
      if Result then
      begin
        Items.Objects[0] := TObject(Color);
        Self.Invalidate;
      end;
    finally
      Free;
    end;
end;

procedure TCustomColorListBox.PopulateList;

  procedure DeleteRange(const AMin, AMax: Integer);
  var
    I: Integer;
  begin
    for I := AMax downto AMin do
      Items.Delete(I);
  end;

  procedure DeleteColor(const AColor: TColor);
  var
    I: Integer;
  begin
    I := Items.IndexOfObject(TObject(AColor));
    if I <> -1 then
      Items.Delete(I);
  end;

var
  LSelectedColor, LCustomColor: TColor;
begin
  if HandleAllocated and not (csLoading in ComponentState) then
  begin
    Items.BeginUpdate;
    try
      LCustomColor := clBlack;
      if (cbCustomColor in Style) and (Items.Count > 0) then
        LCustomColor := TColor(Items.Objects[0]);
      LSelectedColor := FSelectedColor;
      Items.Clear;
      if Style <> [cbCustomColors] then
      begin
        GetColorValues(ColorCallBack);
        if not (cbIncludeNone in Style) then
          DeleteColor(clNone);
        if not (cbIncludeDefault in Style) then
          DeleteColor(clDefault);
        if not (cbSystemColors in Style) then
          DeleteRange(StandardColorsCount + ExtendedColorsCount, Items.Count - 1);
        if not (cbExtendedColors in Style) then
          DeleteRange(StandardColorsCount, StandardColorsCount + ExtendedColorsCount - 1);
        if not (cbStandardColors in Style) then
          DeleteRange(0, StandardColorsCount - 1);
        if cbCustomColor in Style then
          Items.InsertObject(0, SColorBoxCustomCaption, TObject(LCustomColor));
      end;
      if (cbCustomColors in Style) and Assigned(OnGetColors) then
        OnGetColors(Self, Items);
      Selected := LSelectedColor;
    finally
      Items.EndUpdate;
      FNeedToPopulate := False;
    end;
  end
  else
    FNeedToPopulate := True;
end;

procedure TCustomColorListBox.SetDefaultColorColor(const Value: TColor);
begin
  if Value <> FDefaultColorColor then
  begin
    FDefaultColorColor := Value;
    Invalidate;
  end;
end;

procedure TCustomColorListBox.SetNoneColorColor(const Value: TColor);
begin
  if Value <> FNoneColorColor then
  begin
    FNoneColorColor := Value;
    Invalidate;
  end;
end;

procedure TCustomColorListBox.SetSelected(const AColor: TColor);
var
  I, Index: Integer;
begin
  if HandleAllocated then
  begin
    I := Items.IndexOfObject(TObject(AColor));
    if (I = -1) and (cbCustomColor in Style) and (AColor <> NoColorSelected) then
    begin
      Items.Objects[0] := TObject(AColor);
      I := 0;
    end
    else if (cbCustomColor in Style) and (I = 0) then
    begin
      { Look for the color anywhere else but the first color before
        defaulting to selecting the "custom color". }
      for Index := 1 to Items.Count - 1 do
      begin
        if Items.Objects[Index] = TObject(AColor) then
        begin
          I := Index;
          Break;
        end;
      end;
    end;
    if (ItemIndex = 0) and (I = 0) then
      Invalidate { Refresh the color shown }
    else
      ItemIndex := I;
    FNeedToSetSelected := False;
  end
  else
    FNeedToSetSelected := True;
  FSelectedColor := AColor;
end;

procedure TCustomColorListBox.SetStyle(AStyle: TColorBoxStyle);
begin
  if AStyle <> Style then
  begin
    FStyle := AStyle;
    Enabled := ([cbStandardColors, cbExtendedColors, cbSystemColors,
      cbCustomColor, cbCustomColors] * FStyle) <> [];
    PopulateList;
    if (Items.Count > 0) and (ItemIndex = -1) then
      ItemIndex := 0;
  end;
end;

{ TTrayIcon}

constructor TCustomTrayIcon.Create(Owner: TComponent);
begin
  inherited;
{$IF NOT DEFINED(CLR)}
  New(FData);
{$ENDIF}
  FAnimate := False;
  FBalloonFlags := bfNone;
  BalloonTimeout := 10000;
  FIcon := TIcon.Create;
  FCurrentIcon := TIcon.Create;
  FTimer := TTimer.Create(nil);
  FIconIndex := 0;
  FVisible := False;
  FIsClicked := False;
  FTimer.Enabled := False;
  FTimer.OnTimer := DoOnAnimate;
  FTimer.Interval := 1000;

  if not (csDesigning in ComponentState) then
  begin
{$IF DEFINED(CLR)}
    FData.cbSize := Marshal.SizeOf(FData);
    FData.Wnd := AllocateHwnd(WindowProc);
    FData.szTip := Application.Title;
{$ELSE}
    FillChar(FData^, SizeOf(FData^), 0);
    FData^.cbSize := FData^.SizeOf; // Use SizeOf method to get platform specific size
    FData^.Wnd := AllocateHwnd(WindowProc);
    StrPLCopy(FData^.szTip, Application.Title, Length(FData^.szTip) - 1);
{$ENDIF}
    FData.uID := FData.Wnd;
    FData.uTimeout := 10000;
    FData.hIcon := FCurrentIcon.Handle;
    FData.uFlags := NIF_ICON or NIF_MESSAGE;
    FData.uCallbackMessage := WM_SYSTEM_TRAY_MESSAGE;
    if Length(Application.Title) > 0 then
       FData.uFlags := FData.uFlags or NIF_TIP;
    Refresh;
  end;
end;

destructor TCustomTrayIcon.Destroy;
begin
  if not (csDesigning in ComponentState) then
  begin
    Refresh(NIM_DELETE);
    DeallocateHWnd(FData.Wnd);
  end;
  FCurrentIcon.Free;
  FIcon.Free;
  FTimer.Free;
{$IF NOT DEFINED(CLR)}
  Dispose(FData);
{$ENDIF}
  inherited;
end;

procedure TCustomTrayIcon.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    if (not FAnimate) or (FAnimate and FCurrentIcon.Empty) then
      SetDefaultIcon;

    if not (csDesigning in ComponentState) then
    begin
      if FVisible then
        Refresh(NIM_ADD)
      else if not (csLoading in ComponentState) then
      begin
        if not Refresh(NIM_DELETE) then
          raise EOutOfResources.Create(STrayIconRemoveError);
      end;
      if FAnimate then
        FTimer.Enabled := Value;
    end;
  end;
end;

procedure TCustomTrayIcon.SetIconList(Value: TCustomImageList);
begin
  if FIconList <> Value then
  begin
    FIconList := Value;
    if not (csDesigning in ComponentState) then
    begin
      if Assigned(FIconList) then
        FIconList.GetIcon(FIconIndex, FCurrentIcon)
      else
        SetDefaultIcon;
      Refresh;
    end;
  end;
end;

procedure TCustomTrayIcon.SetHint(const Value: string);
begin
  if CompareStr(FHint, Value) <> 0 then
  begin
    FHint := Value;
{$IF DEFINED(CLR)}
    FData.szTip := Hint;
{$ELSE}
    StrPLCopy(FData.szTip, FHint, Length(FData.szTip) - 1);
{$ENDIF}
    if Length(Hint) > 0 then
      FData.uFlags := FData.uFlags or NIF_TIP
    else
      FData.uFlags := FData.uFlags and not NIF_TIP;
    Refresh;
  end;
end;

function TCustomTrayIcon.GetAnimateInterval: Cardinal;
begin
  Result := FTimer.Interval;
end;

procedure TCustomTrayIcon.SetAnimateInterval(Value: Cardinal);
begin
  FTimer.Interval := Value;
end;

procedure TCustomTrayIcon.SetAnimate(Value: Boolean);
begin
  if FAnimate <> Value then
  begin
    FAnimate := Value;
    if not (csDesigning in ComponentState) then
    begin
      if (FIconList <> nil) and (FIconList.Count > 0) and Visible then
        FTimer.Enabled := Value;
      if (not FAnimate) and (not FCurrentIcon.Empty) then
        FIcon.Assign(FCurrentIcon);
    end;
  end;
end;

{ Message handler for the hidden shell notification window. Most messages
  use WM_SYSTEM_TRAY_MESSAGE as the Message ID, with WParam as the ID of the
  shell notify icon data. LParam is a message ID for the actual message, e.g.,
  WM_MOUSEMOVE. Another important message is WM_ENDSESSION, telling the shell
  notify icon to delete itself, so Windows can shut down.

  Send the usual events for the mouse messages. Also interpolate the OnClick
  event when the user clicks the left button, and popup the menu, if there is
  one, for right click events. }

[SecurityPermission(SecurityAction.InheritanceDemand, UnmanagedCode=True)]
procedure TCustomTrayIcon.WindowProc(var Message: TMessage);

  { Return the state of the shift keys. }
  function ShiftState: TShiftState;
  begin
    Result := [];
    if GetKeyState(VK_SHIFT) < 0 then
      Include(Result, ssShift);
    if GetKeyState(VK_CONTROL) < 0 then
      Include(Result, ssCtrl);
    if GetKeyState(VK_MENU) < 0 then
      Include(Result, ssAlt);
  end;

var
  Point: TPoint;
  Shift: TShiftState;
begin
  case Message.Msg of
    WM_QUERYENDSESSION: Message.Result := 1;
    WM_ENDSESSION:
      if TWmEndSession(Message).EndSession then
        Refresh(NIM_DELETE);
    WM_SYSTEM_TRAY_MESSAGE:
      begin
        case Int64(Message.lParam) of
          WM_MOUSEMOVE:
            if Assigned(FOnMouseMove) then
            begin
              Shift := ShiftState;
              GetCursorPos(Point);
              FOnMouseMove(Self, Shift, Point.X, Point.Y);
            end;
          WM_LBUTTONDOWN:
            begin
              if Assigned(FOnMouseDown) then
              begin
                Shift := ShiftState + [ssLeft];
                GetCursorPos(Point);
                FOnMouseDown(Self, mbLeft, Shift, Point.X, Point.Y);
              end;
              FIsClicked := True;
            end;
          WM_LBUTTONUP:
            begin
              Shift := ShiftState + [ssLeft];
              GetCursorPos(Point);
              if FIsClicked and Assigned(FOnClick) then
              begin
                FOnClick(Self);
                FIsClicked := False;
              end;
              if Assigned(FOnMouseUp) then
                FOnMouseUp(Self, mbLeft, Shift, Point.X, Point.Y);
            end;
          WM_RBUTTONDOWN:
            if Assigned(FOnMouseDown) then
            begin
              Shift := ShiftState + [ssRight];
              GetCursorPos(Point);
              FOnMouseDown(Self, mbRight, Shift, Point.X, Point.Y);
            end;
          WM_RBUTTONUP:
            begin
              Shift := ShiftState + [ssRight];
              GetCursorPos(Point);
              if Assigned(FOnMouseUp) then
                FOnMouseUp(Self, mbRight, Shift, Point.X, Point.Y);
              if Assigned(FPopupMenu) then
              begin
                SetForegroundWindow(Application.Handle);
                Application.ProcessMessages;
                FPopupMenu.AutoPopup := False;
                FPopupMenu.PopupComponent := Owner;
                FPopupMenu.Popup(Point.x, Point.y);
              end;
            end;
          WM_LBUTTONDBLCLK, WM_MBUTTONDBLCLK, WM_RBUTTONDBLCLK:
            if Assigned(FOnDblClick) then
              FOnDblClick(Self);
          WM_MBUTTONDOWN:
            if Assigned(FOnMouseDown) then
            begin
              Shift := ShiftState + [ssMiddle];
              GetCursorPos(Point);
              FOnMouseDown(Self, mbMiddle, Shift, Point.X, Point.Y);
            end;
          WM_MBUTTONUP:
            if Assigned(FOnMouseUp) then
            begin
              Shift := ShiftState + [ssMiddle];
              GetCursorPos(Point);
              FOnMouseUp(Self, mbMiddle, Shift, Point.X, Point.Y);
            end;
          NIN_BALLOONHIDE, NIN_BALLOONTIMEOUT:
            FData.uFlags := FData.uFlags and not NIF_INFO;
          NIN_BALLOONUSERCLICK:
            if Assigned(FOnBalloonClick) then
              FOnBalloonClick(Self);
        end;
      end;
  else
    if (Cardinal(Message.Msg) = RM_TaskBarCreated) and Visible then
      Refresh(NIM_ADD);
  end;
end;

procedure TCustomTrayIcon.Refresh;
begin
  if not (csDesigning in ComponentState) then
  begin
    FData.hIcon := FCurrentIcon.Handle;
    if Visible then
      Refresh(NIM_MODIFY);
  end;
end;

function TCustomTrayIcon.Refresh(Message: Integer): Boolean;
//var
//  SavedTimeout: Integer;
begin
  Result := Shell_NotifyIcon(Message, FData);
{  if Result then
  begin
    SavedTimeout := FData.uTimeout;
    FData.uTimeout := 4;
    Result := Shell_NotifyIcon(NIM_SETVERSION, FData);
    FData.uTimeout := SavedTimeout;
  end;}
end;

procedure TCustomTrayIcon.SetIconIndex(Value: Integer);
begin
  if FIconIndex <> Value then
  begin
    FIconIndex := Value;
    if not (csDesigning in ComponentState) then
    begin
      if Assigned(FIconList) then
        FIconList.GetIcon(FIconIndex, FCurrentIcon);
      Refresh;
    end;
  end;
end;

procedure TCustomTrayIcon.DoOnAnimate(Sender: TObject);
begin
  if Assigned(FOnAnimate) then
    FOnAnimate(Self);
  if Assigned(FIconList) and (FIconIndex < FIconList.Count - 1) then
    IconIndex := FIconIndex + 1
  else
    IconIndex := 0;
  Refresh;
end;

procedure TCustomTrayIcon.SetIcon(Value: TIcon);
begin
  FIcon.Assign(Value);
  FCurrentIcon.Assign(Value);
  Refresh;
end;

procedure TCustomTrayIcon.SetBalloonHint(const Value: string);
begin
  if CompareStr(FBalloonHint, Value) <> 0 then
  begin
    FBalloonHint := Value;
{$IF DEFINED(CLR)}
    FData.szInfo := FBalloonHint;
{$ELSE}
    StrPLCopy(FData.szInfo, FBalloonHint, Length(FData.szInfo) - 1);
{$ENDIF}
    Refresh(NIM_MODIFY);
  end;
end;

procedure TCustomTrayIcon.SetDefaultIcon;
begin
  if not FIcon.Empty then
    FCurrentIcon.Assign(FIcon)
  else
    FCurrentIcon.Assign(Application.Icon);
  Refresh;
end;

procedure TCustomTrayIcon.SetBalloonTimeout(Value: Integer);
begin
  FData.uTimeout := Value;
end;

function TCustomTrayIcon.GetBalloonTimeout: Integer;
begin
  Result := FData.uTimeout;
end;

function TCustomTrayIcon.GetData: TNotifyIconData;
begin
  Result := FData{$IFNDEF CLR}^{$ENDIF};
end;

procedure TCustomTrayIcon.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FPopupMenu) and (Operation = opRemove) then
    FPopupMenu := nil;
  if (AComponent = FIconList) and (Operation = opRemove) then
    FIconList := nil;
end;

procedure TCustomTrayIcon.ShowBalloonHint;
begin
  FData.uFlags := FData.uFlags or NIF_INFO;
  FData.dwInfoFlags := Cardinal(FBalloonFlags);
  Refresh(NIM_MODIFY);
end;

procedure TCustomTrayIcon.SetBalloonTitle(const Value: string);
begin
  if CompareStr(FBalloonTitle, Value) <> 0 then
  begin
    FBalloonTitle := Value;
{$IF DEFINED(CLR)}
    FData.szInfoTitle := FBalloonTitle;
{$ELSE}
    StrPLCopy(FData.szInfoTitle, FBalloonTitle, Length(FData.szInfoTitle) - 1);
{$ENDIF}
    Refresh(NIM_MODIFY);
  end;
end;

{ TCategoryPanelSurface }

constructor TCategoryPanelSurface.Create(AOwner: TComponent);
begin
  inherited;
  Align := alClient;
  ControlStyle := ControlStyle + [csParentBackground, csOverrideStylePaint];
  InterceptMouse := False;
end;

procedure TCategoryPanelSurface.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if TStyleManager.IsCustomStyleActive then
    Message.Result := 1
  else
    inherited;
end;

procedure TCategoryPanelSurface.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if not TStyleManager.IsCustomStyleActive then
    Params.ExStyle := Params.ExStyle and not WS_EX_TRANSPARENT;
end;

{ TCategoryPanel }

constructor TCustomCategoryPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BevelOuter := bvLowered;
  FCollapsed := False;
  FAllowResize := False;
  FCollapsedHotImageIndex := -1;
  FCollapsedImageIndex := -1;
  FCollapsedPressedImageIndex := -1;
  FExpandedHeight := DefaultCategoryPanelHeight;
  FExpandedHotImageIndex := -1;
  FExpandedImageIndex := -1;
  FExpandedPressedImageIndex := -1;
  FHeaderState := hsNormal;
  FMouseInClient := False;
  FPanelSurface := GetCategoryPanelSurfaceClass.Create(Self);
  FPanelSurface.Parent := Self;
  Height := DefaultCategoryPanelHeight;
  ParentBackground := False;
  ShowCaption := False;
  ControlStyle := ControlStyle + [csOverrideStylePaint];
end;

destructor TCustomCategoryPanel.Destroy;
begin
  if FPanelGroup <> nil then
    FPanelGroup.RemovePanel(Self);
  FreeAndNil(FPanelSurface);
  inherited;
end;

procedure TCustomCategoryPanel.CalcRectBounds;
const
  Offset = 4;
  ChevronState: array[THeaderState] of array[Boolean] of TThemedCategoryPanelGroup =
    ((tcpChevronOpenedNormal, tcpChevronClosedNormal),
     (tcpChevronOpenedHot, tcpChevronClosedHot),
     (tcpChevronOpenedPressed, tcpChevronClosedPressed));
  ThemedChevronState: array[THeaderState] of array[Boolean] of TThemedCategoryPanelGroup =
    ((tcpThemedChevronOpenedNormal, tcpThemedChevronClosedNormal),
     (tcpThemedChevronOpenedHot, tcpThemedChevronClosedHot),
     (tcpThemedChevronOpenedPressed, tcpThemedChevronClosedPressed));
  ChevronPart: array[Boolean] of TThemedExplorerBar = (
    tebNormalGroupCollapseNormal, tebNormalGroupExpandNormal);
var
  LSize: TSize;
  LStyle: TCustomStyleServices;
  LeftOffset, TopOffset: Integer;
  LWidth, LHeight, LRight: Integer;
begin
  // Calculate chevron rect
  LStyle := StyleServices;
  if (FPanelGroup.HeaderStyle = hsThemed) and LStyle.Enabled then
  begin
    LStyle.GetElementSize(Canvas.Handle,
      LStyle.GetElementDetails(ThemedChevronState[FHeaderState, FCollapsed]), esActual, LSize);
    LHeight := LSize.cy;
    LWidth := LSize.cx;
  end
  else
  begin
    if UsingImageList then
    begin
      LHeight := FPanelGroup.Images.Height;
      LWidth := FPanelGroup.Images.Width;
    end
    else
    begin
      if LStyle.Enabled then
      begin
        LStyle.GetElementSize(Canvas.Handle,
          LStyle.GetElementDetails(ChevronState[FHeaderState, FCollapsed]), esActual, LSize);
        LHeight := LSize.cy;
        LWidth := LSize.cx;
      end
      else
      begin
        LHeight := 16; // default height
        LWidth := 16;  // default width
      end;
    end;
  end;

  LRight := ClientRect.Right;
  LeftOffset := 0;
  TopOffset := ((HeaderHeight - LHeight) div 2) - 1;
  case AdjustedAlignment(UseRightToLeftAlignment, FPanelGroup.ChevronAlignment) of
    taLeftJustify: LeftOffset := Offset;
    taRightJustify: LeftOffset := LRight - LWidth - Offset;
    taCenter: LeftOffset := (LRight - LWidth) div 2;
  end;
  FGlyphRect := Rect(LeftOffset, TopOffset, LWidth + LeftOffset, LHeight + TopOffset);
  if (FPanelGroup.HeaderStyle = hsThemed) and FCollapsed and LStyle.Enabled and LStyle.IsSystemStyle then
    Inc(FGlyphRect.Top); // UxTheme themed chevron needs to be pushed down by 1

  // Calculate text rect
  FTextRect := Rect(Offset + (FGlyphRect.Right - FGlyphRect.Left) + Offset, 0,
    LRight - (FGlyphRect.Right - FGlyphRect.Left) - Offset - Offset, HeaderHeight - 1);
end;

{$IF NOT DEFINED(CLR)}
procedure TCustomCategoryPanel.CMControlListChanging(var Message: TCMControlListChanging);
begin
  if Message.Inserting and (Message.ControlListItem^.Parent = Self) and
     (Message.ControlListItem^.Control <> FPanelSurface) then
  begin
    // Deflect inserted controls to the internal 'surface'
    FPanelSurface.InsertControl(Message.ControlListItem^.Control);
    Message.ControlListItem^.Parent := FPanelSurface;
  end
  else
    inherited;
end;
{$ELSE}
procedure TCustomCategoryPanel.ControlListChanging(Inserting: Boolean; var Item: TControlListItem);
begin
  if Inserting and (Item.Parent = Self) and (Item.Control <> FPanelSurface) then
  begin
    // Deflect inserted controls to the internal 'surface'
    FPanelSurface.InsertControl(Item.Control);
    Item.Parent := FPanelSurface;
  end
  else
    inherited ControlListChanging(Inserting, Item);
end;
{$ENDIF}

procedure TCustomCategoryPanel.CNKeyDown(var Message: TWMKeyDown);
begin
  case Message.CharCode of
    VK_SPACE, VK_RETURN:
      begin
        if FCollapsed then
          Expand
        else
          Collapse;
      end;
    VK_LEFT:
      if not FCollapsed then
        Collapse;
    VK_RIGHT:
      if FCollapsed then
        Expand;
    else
      inherited;
  end;
end;

procedure TCustomCategoryPanel.Collapse;
begin
  if not FCollapsed then
  begin
    FAllowResize := True;
    try
      ShowWindow(FPanelSurface.Handle, SW_HIDE);
      FPanelSurface.Align := alNone;
      FCollapsed := True;
      FExpandedHeight := Height;
      Height := GetCollapsedHeight;
      FPanelGroup.ReAlign;
    finally
      FAllowResize := False;
    end;
    if Assigned(FOnCollapse) then
      FOnCollapse(Self);
  end;
end;

procedure TCustomCategoryPanel.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('ExpandedHeight', ReadExpandedHeight, // Do not localize
    WriteExpandedHeight, FCollapsed and (FExpandedHeight <> DefaultCategoryPanelHeight));
end;

procedure TCustomCategoryPanel.DrawCollapsedPanel(ACanvas: TCanvas);
var
  LRect: TRect;
  LColor, LFillColor: TColor;
  LStyle: TCustomStyleServices;
begin
  LRect := ClientRect;
  LRect.Top := HeaderHeight;
  LRect.Bottom := GetCollapsedHeight;

  LStyle := StyleServices;
  if LStyle.Enabled and
     LStyle.GetElementColor(LStyle.GetElementDetails(tpPanelBackground), ecFillColor, LFillColor) and
     (LFillColor <> clNone) then
    LColor := LFillColor
  else
    LColor := Color;

  ACanvas.Brush.Color := LColor;
  ACanvas.FillRect(LRect);

  Inc(LRect.Top, 2);
  Inc(LRect.Left, 5);
  Dec(LRect.Right, 5);

  if LStyle.Enabled and
     LStyle.GetElementColor(LStyle.GetElementDetails(tpPanelBevel), ecEdgeHighLightColor, LFillColor) and
     (LFillColor <> clNone) then
    LColor := LFillColor
  else
    LColor := clBtnHighlight;

  ACanvas.Pen.Color := LColor;
  ACanvas.MoveTo(LRect.Left, LRect.Top);
  ACanvas.LineTo(LRect.Right, LRect.Top);

  Inc(LRect.Top);
  if LStyle.Enabled and
     LStyle.GetElementColor(LStyle.GetElementDetails(tpPanelBevel), ecEdgeShadowColor, LFillColor) and
     (LFillColor <> clNone) then
    LColor := LFillColor
  else
    LColor := clBtnShadow;
  ACanvas.Pen.Color := LColor;
  ACanvas.MoveTo(LRect.Left, LRect.Top);
  ACanvas.LineTo(LRect.Right, LRect.Top);
end;

procedure TCustomCategoryPanel.DrawHeader;
var
  DC: HDC;
begin
  DC := GetWindowDC(Handle);
  try
    DrawHeader(DC);
  finally
    ReleaseDC(Handle, DC);
  end;
end;

procedure TCustomCategoryPanel.DrawHeader(DC: HDC);
var
  LCanvas: TCanvas;
begin
  if FPanelGroup <> nil then
  begin
    LCanvas := TCanvas.Create;
    try
      LCanvas.Handle := DC;
      CalcRectBounds;
      DrawHeaderBackground(LCanvas);
      DrawHeaderChevron(LCanvas);
      DrawHeaderCaption(LCanvas);
      if FCollapsed then
        DrawCollapsedPanel(LCanvas);
    finally
      LCanvas.Handle := 0;
      LCanvas.Free;
    end;
  end;
end;

procedure TCustomCategoryPanel.DrawHeaderBackground(ACanvas: TCanvas);
var
  LRect: TRect;
  LColor: TColor;
  LDetails: TThemedElementDetails;
  LStyle: TCustomStyleServices;

  procedure DrawGradientHeader;
  var
    LBaseColor, LGradientColor: TColor;
  begin
    LBaseColor := FPanelGroup.GradientBaseColor;
    LGradientColor := FPanelGroup.GradientColor;
    if LStyle.Enabled then
    begin
      LDetails := LStyle.GetElementDetails(tcpGradientHeader);
      if LStyle.GetElementColor(LDetails, ecGradientColor1, LColor) and (LColor <> clNone) then
        LBaseColor := LColor;
      if LStyle.GetElementColor(LDetails, ecGradientColor2, LColor) and (LColor <> clNone) then
        LGradientColor := LColor;
    end;
    GradientFillCanvas(ACanvas, LBaseColor, LGradientColor, LRect,
      FPanelGroup.GradientDirection);
  end;

begin
  LRect := ClientRect;
  LRect.Bottom := HeaderHeight;
  LStyle := StyleServices;

  case FPanelGroup.HeaderStyle of
    hsGradient:
      DrawGradientHeader;
    hsThemed:
      if LStyle.Enabled then
      begin
        LDetails := LStyle.GetElementDetails(tcpBackground);
        if LStyle.GetElementColor(LDetails, ecFillColor, LColor) and (LColor <> clNone) then
          ACanvas.Brush.Color := LColor
        else
          ACanvas.Brush.Color := Color;
        ACanvas.FillRect(LRect);
        if not LStyle.DrawElement(ACanvas.Handle,
               LStyle.GetElementDetails(tcpThemedHeader), LRect) then
          DrawGradientHeader;
      end
      else
        DrawGradientHeader;
    hsImage:
      if FPanelGroup.HeaderImage.Graphic <> nil then
        ACanvas.StretchDraw(LRect, FPanelGroup.HeaderImage.Graphic)
      else
        DrawGradientHeader;
  end;
end;

procedure TCustomCategoryPanel.DrawHeaderCaption(ACanvas: TCanvas);
const
  Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
  Parts: array[Boolean] of TThemedCategoryPanelGroup = (tcpGradientHeader, tcpThemedHeader);
var
  LRect: TRect;
  Flags: Cardinal;
  LStyle: TCustomStyleServices;
begin
  ACanvas.Font := FPanelGroup.HeaderFont;
  ACanvas.Brush.Style := bsClear;
  Flags := DT_EXPANDTABS or DT_SINGLELINE or DT_VCENTER or Alignments[Alignment] or DT_END_ELLIPSIS;
  Flags := DrawTextBiDiModeFlags(Flags);

  LStyle := StyleServices;
  if LStyle.Enabled then
    LStyle.DrawText(ACanvas.Handle,
      LStyle.GetElementDetails(Parts[FPanelGroup.HeaderStyle = hsThemed]),
      Caption, FTextRect, TTextFormatFlags(Flags))
  else
    Winapi.Windows.DrawText(ACanvas.Handle, Caption, -1, FTextRect, Flags);

  if Focused then
  begin
    LRect := Rect(2, 2, Width - 4, HeaderHeight - 3);
    ACanvas.Brush.Style := bsSolid;
    ACanvas.DrawFocusRect(LRect);
  end;
end;

procedure TCustomCategoryPanel.DrawHeaderChevron(ACanvas: TCanvas);
const
  ChevronDirection: array[TAlignment, Boolean] of TScrollDirection =
    ((sdDown, sdRight), (sdDown, sdLeft), (sdDown, sdRight));
  Chevron: array[TAlignment, Boolean, THeaderState] of TThemedCategoryPanelGroup =
    (((tcpChevronOpenedNormal, tcpChevronOpenedHot, tcpChevronOpenedPressed),
      (tcpChevronClosedNormal, tcpChevronClosedHot, tcpChevronClosedPressed)),
     ((tcpChevronOpenedNormal, tcpChevronOpenedHot, tcpChevronOpenedPressed),
      (tcpChevronClosedLeftNormal, tcpChevronClosedLeftHot, tcpChevronClosedLeftPressed)),
     ((tcpChevronOpenedNormal, tcpChevronOpenedHot, tcpChevronOpenedPressed),
      (tcpChevronClosedNormal, tcpChevronClosedHot, tcpChevronClosedPressed)));
  ThemedChevron: array[THeaderState] of array[Boolean] of TThemedCategoryPanelGroup =
    ((tcpThemedChevronOpenedNormal, tcpThemedChevronClosedNormal),
     (tcpThemedChevronOpenedHot, tcpThemedChevronClosedHot),
     (tcpThemedChevronOpenedPressed, tcpThemedChevronClosedPressed));
var
  LPoint: TPoint;
  LIndex: Integer;
  LColor: TColor;
  LStyle: TCustomStyleServices;
  LChevronPart: TThemedCategoryPanelGroup;
begin
  LStyle := StyleServices;
  if (FPanelGroup.HeaderStyle = hsThemed) and LStyle.Enabled then
    LStyle.DrawElement(ACanvas.Handle,
      LStyle.GetElementDetails(ThemedChevron[FHeaderState, FCollapsed]), FGlyphRect)
  else
  begin
    if UsingImageList then
    begin
      // draw image from imagelist
      if FCollapsed then
      begin
        LIndex := FCollapsedImageIndex;
        case FHeaderState of
          hsHot:
            if FCollapsedHotImageIndex <> -1 then
              LIndex := FCollapsedHotImageIndex;
          hsPressed:
            if FCollapsedPressedImageIndex <> -1 then
              LIndex := FCollapsedPressedImageIndex;
        end;
      end
      else
      begin
        LIndex := FExpandedImageIndex;
        case FHeaderState of
          hsHot:
            if FExpandedHotImageIndex <> -1 then
              LIndex := FExpandedHotImageIndex;
          hsPressed:
            if FExpandedPressedImageIndex <> -1 then
              LIndex := FExpandedPressedImageIndex;
        end;
      end;
      if LIndex <> -1 then
        FPanelGroup.Images.Draw(ACanvas, FGlyphRect.Left, FGlyphRect.Top, LIndex);
    end
    else
    begin
      // draw chevron
      LPoint.X := FGlyphRect.Left + ((FGlyphRect.Right - FGlyphRect.Left  - 6) div 2) - 1;
      LPoint.Y := (HeaderHeight - 6) div 2;
      if FCollapsed then
        Inc(LPoint.X, 2)
      else
        Inc(LPoint.Y, 2);

      LChevronPart := Chevron[AdjustedAlignment(UseRightToLeftAlignment,
        FPanelGroup.ChevronAlignment), FCollapsed, FHeaderState];
      if not LStyle.Enabled or
         not LStyle.DrawElement(ACanvas.Handle, LStyle.GetElementDetails(LChevronPart), TRect.Create(LPoint, 3, 0)) then
      begin
        case FHeaderState of
          hsNormal:
            if LStyle.Enabled and
               LStyle.GetElementColor(LStyle.GetElementDetails(LChevronPart), ecFillColor, LColor) and
               (LColor <> clNone) then
              ACanvas.Pen.Color := LColor
            else
              ACanvas.Pen.Color := FPanelGroup.ChevronColor;
          hsHot, hsPressed:
            if LStyle.Enabled and
               LStyle.GetElementColor(LStyle.GetElementDetails(LChevronPart), ecFillColor, LColor) and
               (LColor <> clNone) then
              ACanvas.Pen.Color := LColor
            else
              ACanvas.Pen.Color := FPanelGroup.ChevronHotColor;
        end;
        DrawChevron(ACanvas, ChevronDirection[AdjustedAlignment(UseRightToLeftAlignment,
          FPanelGroup.ChevronAlignment), FCollapsed], LPoint, 3);
      end;
    end;
  end;
end;

procedure TCustomCategoryPanel.Expand;
begin
  if FCollapsed then
  begin
    FAllowResize := True;
    try
      FPanelSurface.Align := alClient;
      ShowWindow(FPanelSurface.Handle, SW_SHOW);
      FCollapsed := False;
      Height := FExpandedHeight;
      if FPanelGroup.VertScrollBar.IsScrollBarVisible then
      begin
        FPanelGroup.ScrollInView(Self);
        FPanelGroup.ReAlign;
      end;
    finally
      FAllowResize := False;
    end;
    if Assigned(FOnExpand) then
      FOnExpand(Self);
  end;
end;

function TCustomCategoryPanel.GetCategoryPanelSurfaceClass: TCategoryPanelSurfaceClass;
begin
  Result := TCategoryPanelSurface;
end;

[UIPermission(SecurityAction.InheritanceDemand, Window=UIPermissionWindow.AllWindows),
UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TCustomCategoryPanel.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  Control: TControl;
begin
  for I := 0 to FPanelSurface.ControlCount - 1 do
  begin
    Control := FPanelSurface.Controls[I];
      Proc(Control);
  end;
end;

function TCustomCategoryPanel.GetCollapsedHeight: Integer;
begin
  Result := HeaderHeight + 6;
end;

function TCustomCategoryPanel.GetHeaderHeight: Integer;
begin
  if FPanelGroup <> nil then
    Result := FPanelGroup.HeaderHeight
  else
    Result := 0;
end;

procedure TCustomCategoryPanel.GetTabControlList(List: TList);
begin
  GetTabOrderList(List);
end;

procedure TCustomCategoryPanel.GetTabOrderList(List: TList);
begin
  if (not FCollapsed) and (FPanelSurface <> nil) then
    FPanelSurface.GetTabOrderList(List);
end;

procedure TCustomCategoryPanel.Loaded;
begin
  inherited;
  if FPanelGroup <> nil then
    CalcRectBounds;
  FPanelSurface.FixupTabList;
end;

procedure TCustomCategoryPanel.ReadExpandedHeight(Reader: TReader);
begin
  FExpandedHeight := Reader.ReadInteger;
end;

procedure TCustomCategoryPanel.ReadState(Reader: TReader);
begin
  if Reader.Parent is TCategoryPanelGroup then
    PanelGroup := TCategoryPanelGroup(Reader.Parent);
  inherited ReadState(Reader);
end;

procedure TCustomCategoryPanel.ResizeHeader(OldHeight, NewHeight: Integer);
begin
  FAllowResize := True;
  try
    Height := Height - (OldHeight - NewHeight);
    Invalidate;
  finally
    FAllowResize := False;
  end;
end;

procedure TCustomCategoryPanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  ReorderPanels: Boolean;
begin
  ReorderPanels := (ATop <> Top) and (FPanelGroup <> nil) and
    not (csAligning in ControlState) and not (csLoading in ComponentState);

  if not (FAllowResize) and (AHeight <> Height) then
  begin
    if not FCollapsed or (csLoading in ComponentState) then
      if AHeight >= HeaderHeight then
        inherited;
  end
  else
    inherited;

  if ReorderPanels then
    FPanelGroup.ReorderPanels;
end;

procedure TCustomCategoryPanel.SetCollapsed(const Value: Boolean);
begin
  if Value <> FCollapsed then
  begin
    if not (csLoading in ComponentState) then
    begin
      if not FCollapsed then
        Collapse
      else
        Expand;
    end;
    FCollapsed := Value;
  end;
end;

procedure TCustomCategoryPanel.SetCollapsedHotImageIndex(const Value: TImageIndex);
begin
  if Value <> FCollapsedHotImageIndex then
  begin
    FCollapsedHotImageIndex := Value;
    if not (csLoading in ComponentState) and (PanelGroup.HeaderStyle = hsImage) and
       Collapsed and (FHeaderState = hsHot) then
      if Value <> -1 then
        UpdateButtonState
      else
        UpdateHeader;
  end;
end;

procedure TCustomCategoryPanel.SetCollapsedImageIndex(const Value: TImageIndex);
begin
  if Value <> FCollapsedImageIndex then
  begin
    FCollapsedImageIndex := Value;
    if not (csLoading in ComponentState) and (PanelGroup.HeaderStyle = hsImage) and
       Collapsed and (FHeaderState = hsNormal) then
      if Value <> -1 then
        UpdateButtonState
      else
        UpdateHeader;
  end;
end;

procedure TCustomCategoryPanel.SetCollapsedPressedImageIndex(const Value: TImageIndex);
begin
  if Value <> FCollapsedPressedImageIndex then
  begin
    FCollapsedPressedImageIndex := Value;
    if not (csLoading in ComponentState) and (PanelGroup.HeaderStyle = hsImage) and
       Collapsed and (FHeaderState = hsPressed) then
      if Value <> -1 then
        UpdateButtonState
      else
        UpdateHeader;
  end;
end;

procedure TCustomCategoryPanel.SetExpandedHotImageIndex(const Value: TImageIndex);
begin
  if Value <> FExpandedHotImageIndex then
  begin
    FExpandedHotImageIndex := Value;
    if not (csLoading in ComponentState) and (PanelGroup.HeaderStyle = hsImage) and
       not Collapsed and (FHeaderState = hsHot) then
      if Value <> -1 then
        UpdateButtonState
      else
        UpdateHeader;
  end;
end;

procedure TCustomCategoryPanel.SetExpandedImageIndex(const Value: TImageIndex);
begin
  if Value <> FExpandedImageIndex then
  begin
    FExpandedImageIndex := Value;
    if not (csLoading in ComponentState) and (PanelGroup.HeaderStyle = hsImage) and
       not Collapsed and (FHeaderState = hsNormal) then
      if Value <> -1 then
        UpdateButtonState
      else
        UpdateHeader;
  end;
end;

procedure TCustomCategoryPanel.SetExpandedPressedImageIndex(const Value: TImageIndex);
begin
  if Value <> FExpandedPressedImageIndex then
  begin
    FExpandedPressedImageIndex := Value;
    if not (csLoading in ComponentState) and (PanelGroup.HeaderStyle = hsImage) and
       not Collapsed and (FHeaderState = hsPressed) then
      if Value <> -1 then
        UpdateButtonState
      else
        UpdateHeader;
  end;
end;

procedure TCustomCategoryPanel.SetPanelGroup(const Value: TCustomCategoryPanelGroup);
var
  LRecreating: Boolean;
begin
  if FPanelGroup <> Value then
  begin
    LRecreating := False;
    if not (csLoading in ComponentState) then
    begin
      LRecreating := csRecreating in ControlState;
      if not LRecreating then
        UpdateRecreatingFlag(True);
    end;

    try
      if FPanelGroup <> nil then
        FPanelGroup.RemovePanel(Self);
      Parent := Value;
      if Value <> nil then
      begin
        Value.InsertPanel(Self);
        if not (csLoading in ComponentState) and not LRecreating then
          RecreateWnd;
      end;
    finally
      if not (csLoading in ComponentState) and not LRecreating then
        UpdateRecreatingFlag(False);
    end;
  end;
end;

procedure TCustomCategoryPanel.SetParent(AParent: TWinControl);
begin
  if AParent is TCustomCategoryPanelGroup then
    inherited SetParent(AParent)
  else
    if not (csDestroying in ComponentState) then
      raise EInvalidOperation.Create(SInvalidCategoryPanelParent);
end;

procedure TCustomCategoryPanel.UpdateButtonState;
var
  DC: HDC;
  LCanvas: TCanvas;
begin
  case FPanelGroup.HeaderStyle of
    hsGradient, hsImage:
      begin
        DC := GetWindowDC(Handle);
        try
          LCanvas := TCanvas.Create;
          try
            LCanvas.Handle := DC;
            CalcRectBounds;
            IntersectClipRect(LCanvas.Handle, FGlyphRect.Left,
              FGlyphRect.Top, FGlyphRect.Right, FGlyphRect.Bottom);
            DrawHeaderBackground(LCanvas);
            DrawHeaderChevron(LCanvas);
          finally
            LCanvas.Handle := 0;
            LCanvas.Free;
          end;
        finally
          ReleaseDC(Handle, DC);
        end;
      end;
    hsThemed:
      DrawHeader;
  end;
end;

procedure TCustomCategoryPanel.UpdateControlOriginalParentSize(
  AControl: TControl; var AOriginalParentSize: TPoint);
begin
  inherited UpdateControlOriginalParentSize(AControl, AOriginalParentSize);
  if AOriginalParentSize.Y = Height then
    AOriginalParentSize.Y := Height - HeaderHeight;
end;

procedure TCustomCategoryPanel.UpdateHeader;
begin
  Alignment := FPanelGroup.HeaderAlignment;
  DrawHeader;
end;

function TCustomCategoryPanel.UsingImageList: Boolean;
begin
  Result := (FPanelGroup.Images <> nil) and
    ((not FCollapsed and (FExpandedImageIndex <> -1)) or
    (FCollapsed and (FCollapsedImageIndex <> -1)));
end;

procedure TCustomCategoryPanel.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  DrawHeader;
end;

procedure TCustomCategoryPanel.WMNCCalcSize(var Message: TWMNCCalcSize);
var
  LHeight: Integer;
{$IF DEFINED(CLR)}
  Params: TNCCalcSizeParams;
{$ELSE}
  Params: PNCCalcSizeParams;
{$ENDIF}
begin
  inherited;
  if FCollapsed then
    LHeight := GetCollapsedHeight
  else
    LHeight := HeaderHeight;
  Params := Message.CalcSize_Params;
  Inc(Params.rgrc0.Top, LHeight);
{$IF DEFINED(CLR)}
  Message.CalcSize_Params := Params;
{$ENDIF}
end;

procedure TCustomCategoryPanel.WMNCMouseLeave(var Message: TMessage);
begin
  inherited;
  FMouseInClient := False;
  if FHeaderState <> hsNormal then
  begin
    FHeaderState := hsNormal;
    UpdateButtonState;
  end;
end;

procedure TCustomCategoryPanel.WMNCPaint(var Message: TWMNCPaint);
begin
  inherited;
  DrawHeader;
end;

procedure TCustomCategoryPanel.WMPaint(var Message: TWMPaint);
var
  LPoint: TPoint;
begin
  if (Message.DC = 0) or TStyleManager.IsCustomStyleActive then
    // WM_PAINT sent for normal painting
    inherited
  else
  begin
    // WM_PAINT sent from PaintTo()
    DrawHeader(Message.DC);
    GetWindowOrgEx(Message.DC, LPoint);
    if FCollapsed then
      SetWindowOrgEx(Message.DC, LPoint.X, LPoint.Y - GetCollapsedHeight, nil)
    else
      SetWindowOrgEx(Message.DC, LPoint.X, LPoint.Y - HeaderHeight, nil);
    inherited;
  end;
end;

procedure TCustomCategoryPanel.WMSetCursor(var Message: TWMSetCursor);
var
  LMouseEvent: TTrackMouseEvent;
begin
  if Message.HitTest = HTNOWHERE then
    case Message.MouseMsg of
      WM_LBUTTONUP:
        begin
          FHeaderState := hsHot;
          if FCollapsed then
            Expand
          else
            Collapse;
          Exit;
        end;
      WM_LBUTTONDOWN:
        begin
          FHeaderState := hsPressed;
          UpdateButtonState;
          if TabStop then
            SetFocus;
          Exit;
        end;
      WM_MOUSEMOVE:
        begin
          if not FMouseInClient then
          begin
            FMouseInClient := True;
            // Register for a WM_MOUSELEAVE message which ensures CM_MOUSELEAVE
            // is called when the mouse leaves the TWinControl
            LMouseEvent.dwFlags := TME_LEAVE or TME_NONCLIENT;
            LMouseEvent.hwndTrack := Handle;
            LMouseEvent.dwHoverTime := HOVER_DEFAULT;
  {$IF DEFINED(CLR)}
            LMouseEvent.cbSize := Marshal.SizeOf(TypeOf(LMouseEvent));
            TrackMouseEvent(LMouseEvent);
  {$ELSE}
            LMouseEvent.cbSize := SizeOf(LMouseEvent);
            _TrackMouseEvent(@LMouseEvent);
  {$ENDIF}
          end;
          if FHeaderState = hsNormal then
          begin
            FHeaderState := hsHot;
            UpdateButtonState;
          end;
        end;
    end;
  inherited;
end;

procedure TCustomCategoryPanel.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if FPanelGroup.VertScrollBar.IsScrollBarVisible then
  begin
    FPanelGroup.ScrollInView(Self);
    if Top < 0 then
      // Account for non-client area
      FPanelGroup.VertScrollBar.Position := FPanelGroup.VertScrollBar.Position + Top;
  end;
  DrawHeader;
end;

procedure TCustomCategoryPanel.WndProc(var Message: TMessage);
var
  FCanvas: TCanvas;
  LColor: TColor;
begin
  case Message.Msg of
    WM_ERASEBKGND:
      if TStyleManager.IsCustomStyleActive and StyleServices.Enabled then
      begin
        if DoubleBuffered and (Message.WParam <> 0) then
        begin
          FCanvas := TCanvas.Create;
          FCanvas.Handle := Message.WParam;
          try
            with FCanvas do
            begin
              if not (seClient in StyleElements) then
                Brush.Color := Color
              else
              if StyleServices.GetElementColor(StyleServices.GetElementDetails(tpPanelBackground),
                 ecFillColor, LColor) and (LColor <> clNone) then
                 Brush.Color := LColor
              else
                Brush.Color := StyleServices.GetSystemColor(clBtnFace);
              FillRect(Rect(0, 0, ClientWidth, ClientHeight));
            end;
          finally
            FCanvas.Handle := 0;
            FCanvas.Free;
          end;
        end;
        Message.Result := 1;
        Exit;
      end;
  end;
  inherited;
  case Message.Msg of
    CM_TEXTCHANGED:
      if (not (csLoading in ComponentState)) and HandleAllocated then
        UpdateHeader;
    CM_COLORCHANGED:
      if (not (csLoading in ComponentState)) and HandleAllocated then
        RecreateWnd;
  end;
end;

procedure TCustomCategoryPanel.WriteExpandedHeight(Writer: TWriter);
begin
  Writer.WriteInteger(FExpandedHeight);
end;

{ TCustomCategoryPanelGroup }

class constructor TCustomCategoryPanelGroup.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TCustomCategoryPanelGroup, TScrollingStyleHook);
end;

constructor TCustomCategoryPanelGroup.Create(AOwner: TComponent);
begin
  inherited;
  Align := alLeft;
  BorderWidth := 0;
  Color := clMedGray;
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csSetCaption, csDoubleClicks, csPannable, csGestures];
  FChevronAlignment := taLeftJustify;
  FChevronColor := clBlack;
  FChevronHotColor := clGray;
  FGradientBaseColor := $F0F0F0;
  FGradientColor := $C0C0C0;
  FGradientDirection := gdVertical;
  FHeaderAlignment := taLeftJustify;
  FHeaderFont := TFont.Create;
  FHeaderHeight := 24;
  FHeaderImage := TPicture.Create;
  FHeaderStyle := hsGradient;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FPanels := TList.Create;
  Height := 350;
  Width := 200;
  VertScrollBar.Tracking := True;
end;

class destructor TCustomCategoryPanelGroup.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TCustomCategoryPanelGroup, TScrollingStyleHook);
end;

destructor TCustomCategoryPanelGroup.Destroy;
var
  I: Integer;
begin
  for I := 0 to FPanels.Count - 1 do
    TCustomCategoryPanel(FPanels[I]).FPanelGroup := nil;
  FreeAndNil(FHeaderFont);
  FreeAndNil(FHeaderImage);
  FreeAndNil(FImageChangeLink);
  FreeAndNil(FPanels);
  inherited;
end;

procedure TCustomCategoryPanelGroup.CMColorChanged(var Message: TMessage);
var
  I: Integer;
begin
  inherited;
  if HandleAllocated then
    for I := 0 to FPanels.Count - 1 do
      TCustomCategoryPanel(FPanels[I]).Invalidate;
end;

{$IF NOT DEFINED(CLR)}
procedure TCustomCategoryPanelGroup.CMControlListChanging(var Message: TCMControlListChanging);
begin
  if Message.Inserting and (Message.ControlListItem^.Parent = Self) and
     not (Message.ControlListItem^.Control is TCustomCategoryPanel) then
      raise Exception.CreateRes(@SInvalidCategoryPanelGroupChild);
end;
{$ELSE}
procedure TCustomCategoryPanelGroup.ControlListChanging(Inserting: Boolean; var Item: TControlListItem);
begin
  if Inserting and (Item.Parent = Self) and
     not (Item.Control is TCustomCategoryPanel) then
    raise Exception.CreateRes(SInvalidCategoryPanelGroupChild);
end;
{$ENDIF}

procedure TCustomCategoryPanelGroup.CMDoubleBufferedChanged(var Mesage: TMessage);
begin
  inherited;
  if Showing then
    RecreateWnd;
end;

function TCustomCategoryPanelGroup.CreatePanel(AOwner: TComponent): TCustomCategoryPanel;
begin
  Result := GetCategoryPanelClass.Create(AOwner);
  Result.Parent := Self;
  Result.PanelGroup := Self;
end;

procedure TCustomCategoryPanelGroup.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    if sfHandleMessages in StyleServices.Flags then
      ExStyle := ExStyle + WS_EX_CLIENTEDGE
    else
      Style := Style or WS_BORDER;
end;

procedure TCustomCategoryPanelGroup.CollapseAll;
var
  I: Integer;
begin
  for I := 0 to FPanels.Count - 1 do
    TCustomCategoryPanel(FPanels[I]).Collapse;
end;

procedure TCustomCategoryPanelGroup.CreateWnd;
begin
  inherited;
  if not (csLoading in ComponentState) then
    AutoScroll := True;
end;

procedure TCustomCategoryPanelGroup.ExpandAll;
var
  I: Integer;
begin
  for I := 0 to FPanels.Count - 1 do
    TCustomCategoryPanel(FPanels[I]).Expand;
  VertScrollBar.Position := 0;
end;

function TCustomCategoryPanelGroup.GetCategoryPanelClass: TCategoryPanelClass;
begin
  Result := TCategoryPanel;
end;

procedure TCustomCategoryPanelGroup.ImageListChange(Sender: TObject);
begin
  if HandleAllocated then
    UpdatePanelHeaders;
end;

procedure TCustomCategoryPanelGroup.InsertPanel(Panel: TCustomCategoryPanel);
begin
  FPanels.Add(Panel);
  Panel.FPanelGroup := Self;
  if FPanels.Count = 1 then
    Panel.Top := 0
  else
    Panel.Top := VertScrollBar.Range;
  Panel.Left := 0;
  Panel.Align := alTop;
  Panel.Alignment := FHeaderAlignment;
  if not (csLoading in ComponentState) then
    AutoScrollInView(Panel);
end;

procedure TCustomCategoryPanelGroup.Loaded;
begin
  inherited;
  AutoScroll := True;
end;

procedure TCustomCategoryPanelGroup.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FImages) and (Operation = opRemove) then
  begin
    FImages := nil;
    UpdatePanelHeaders;
  end;
end;

{$IF DEFINED(CLR)}
function ComparePanels(Item1, Item2: TObject): Integer;
{$ELSE}
function ComparePanels(Item1, Item2: Pointer): Integer;
{$ENDIF}
begin
  Result := TCustomCategoryPanel(Item1).Top - TCustomCategoryPanel(Item2).Top;
  if Result > 0 then
    TCustomCategoryPanel(Item2).PanelGroup.FReorderPanels := True;
end;

procedure TCustomCategoryPanelGroup.ReorderPanels;
var
  I: Integer;
  LControl: TControl;
  LRecreating: Boolean;
begin
  FReorderPanels := False;
  FPanels.Sort(ComparePanels);
  if FReorderPanels then
  begin
    DisableAlign;
    try
      for I := FPanels.Count - 1 downto 0 do
      begin
        // Ensure controls knows they are being recreated
        LRecreating := csRecreating in ControlState;
        if not LRecreating then
          UpdateRecreatingFlag(True);
        try
          LControl := TControl(FPanels.Items[I]);
          RemoveControl(LControl);
          InsertControl(LControl);
        finally
          if not LRecreating then
            UpdateRecreatingFlag(False);
        end;
      end;
    finally
      EnableAlign;
    end;
  end;
end;

procedure TCustomCategoryPanelGroup.RemovePanel(Panel: TCustomCategoryPanel);
begin
  Panel.FPanelGroup := nil;
  FPanels.Remove(Panel);
  RemoveControl(Panel);
end;

procedure TCustomCategoryPanelGroup.SetChevronAlignment(const Value: TAlignment);
begin
  if Value <> FChevronAlignment then
  begin
    FChevronAlignment := Value;
    if not (csLoading in ComponentState) then
      UpdatePanelHeaders;
  end;
end;

procedure TCustomCategoryPanelGroup.SetChevronColor(const Value: TColor);
begin
  if Value <> FChevronColor then
  begin
    FChevronColor := Value;
    if not (csLoading in ComponentState) then
      UpdatePanelHeaders;
  end;
end;

procedure TCustomCategoryPanelGroup.SetChevronHotColor(const Value: TColor);
begin
  if Value <> FChevronHotColor then
  begin
    FChevronHotColor := Value;
    if not (csLoading in ComponentState) then
      UpdatePanelHeaders;
  end;
end;

procedure TCustomCategoryPanelGroup.SetGradientBaseColor(const Value: TColor);
begin
  if Value <> FGradientBaseColor then
  begin
    FGradientBaseColor := Value;
    if not (csLoading in ComponentState) then
      UpdatePanelHeaders;
  end;
end;

procedure TCustomCategoryPanelGroup.SetGradientColor(const Value: TColor);
begin
  if Value <> FGradientColor then
  begin
    FGradientColor := Value;
    if not (csLoading in ComponentState) then
      UpdatePanelHeaders;
  end;
end;

procedure TCustomCategoryPanelGroup.SetGradientDirection(const Value: TGradientDirection);
begin
  if Value <> FGradientDirection then
  begin
    FGradientDirection := Value;
    if not (csLoading in ComponentState) then
      UpdatePanelHeaders;
  end;
end;

procedure TCustomCategoryPanelGroup.SetHeaderAlignment(const Value: TAlignment);
begin
  if Value <> FHeaderAlignment then
  begin
    FHeaderAlignment := Value;
    UpdatePanelHeaders;
  end;
end;

procedure TCustomCategoryPanelGroup.SetHeaderFont(const Value: TFont);
begin
  FHeaderFont.Assign(Value);
  if not (csLoading in ComponentState) then
    UpdatePanelHeaders;
end;

procedure TCustomCategoryPanelGroup.SetHeaderHeight(const Value: Integer);
var
  I, OldHeight: Integer;
begin
  if Value <> FHeaderHeight then
  begin
    OldHeight := FHeaderHeight;
    FHeaderHeight := Value;
    if HandleAllocated then
      for I := FPanels.Count - 1 downto 0 do
        TCustomCategoryPanel(FPanels[I]).ResizeHeader(OldHeight, FHeaderHeight);
  end;
end;

procedure TCustomCategoryPanelGroup.SetHeaderImage(const Value: TPicture);
begin
  if Value <> FHeaderImage then
  begin
    FHeaderImage.Assign(Value);
    if not (csLoading in ComponentState) then
      UpdatePanelHeaders;
  end;
end;

procedure TCustomCategoryPanelGroup.SetHeaderStyle(const Value: THeaderStyle);
begin
  if Value <> FHeaderStyle then
  begin
    FHeaderStyle := Value;
    if not (csLoading in ComponentState) then
      UpdatePanelHeaders;
  end;
end;

procedure TCustomCategoryPanelGroup.SetImages(const Value: TCustomImageList);
var
  I: Integer;
begin
  if Value <> FImages then
  begin
    if FImages <> nil then
      FImages.UnRegisterChanges(FImageChangeLink);
    FImages := Value;
    if FImages <> nil then
    begin
      FImages.RegisterChanges(FImageChangeLink);
      FImages.FreeNotification(Self);
    end;
    for I := 0 to FPanels.Count - 1 do
      TCustomCategoryPanel(FPanels[I]).UpdateHeader;
  end;
end;

procedure TCustomCategoryPanelGroup.UpdatePanelHeaders;
var
  I: Integer;
begin
  for I := 0 to FPanels.Count - 1 do
    TCustomCategoryPanel(FPanels[I]).UpdateHeader;
end;

procedure TCustomCategoryPanelGroup.WMEraseBkgnd(var Message: TWmEraseBkgnd);
var
  LBrush: HBRUSH;
  LColor: TColor;
begin
  if StyleServices.Enabled and not (TStyleManager.IsCustomStyleActive and not (seClient in StyleElements)) and
     StyleServices.GetElementColor(StyleServices.GetElementDetails(tcpBackground),
       ecFillColor, LColor) and (LColor <> clNone) then
  begin
    LBrush := CreateSolidBrush(LColor);
    try
      FillRect(Message.DC, ClientRect, LBrush);
    finally
      DeleteObject(LBrush);
    end;
    Message.Result := 1;
  end
  else
    inherited;
end;

procedure TCustomCategoryPanelGroup.WMNCHitTest(var Message: TWMNCHitTest);
begin
  DefaultHandler(Message);
end;

procedure TCustomCategoryPanelGroup.WMPaint(var Message: TWMPaint);
var
  LRect: TRect;
  LPoint: TPoint;
  LCanvas: TCanvas;
begin
  if Message.DC = 0 then
    // WM_PAINT sent for normal painting
    inherited
  else
  begin
    // WM_PAINT sent from PaintTo()
    LCanvas := TCanvas.Create;
    try
      LCanvas.Handle := Message.DC;
      LRect := ClientRect;
      InflateRect(LRect, 1, 1);
      LCanvas.Brush.Color := Color;
      LCanvas.FillRect(LRect);
      GetWindowOrgEx(Message.DC, LPoint);
      SetWindowOrgEx(Message.DC, LPoint.X - 1, LPoint.Y - 1, nil);
      inherited;
    finally
      LCanvas.Free;
    end;
  end;
end;

procedure TCustomCategoryPanelGroup.WndProc(var Message: TMessage);
begin
  inherited;
end;

{ TCategoryPanelGroup }

class constructor TCategoryPanelGroup.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TCategoryPanelGroup, TScrollingStyleHook);
end;

class destructor TCategoryPanelGroup.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TCategoryPanelGroup, TScrollingStyleHook);
end;

{ TCustomLinkLabel }

class constructor TCustomLinkLabel.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TCustomLinkLabel, TLinkLabelStyleHook);
end;

constructor TCustomLinkLabel.Create(AOwner: TComponent);
begin
  inherited;
  FAlignment := taLeftJustify;
  FAutoSize := True;
  FUseVisualStyle := False;
  ParentDoubleBuffered := False;
  Width := 53;
  Height := 17;
end;

class destructor TCustomLinkLabel.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TCustomLinkLabel, TLinkLabelStyleHook);
end;

procedure TCustomLinkLabel.CNCtlColorStatic;
begin
  if StyleServices.Enabled then
  begin
    SetBkMode(Message.ChildDC, WinAPI.Windows.TRANSPARENT);
    StyleServices.DrawParentBackground(Handle, Message.ChildDC, nil, False);
    Message.Result := GetStockObject(NULL_BRUSH);
  end
  else
    inherited;
end;

procedure TCustomLinkLabel.AdjustBounds;
var
  DC: HDC;
  SaveFont: HFont;
  TextSize: TSize;
  Parsed: string;
begin
  if not (csLoading in ComponentState) and FAutoSize then
  begin
    if CheckWin32Version(6) and UseThemes then
    begin
      if HandleAllocated then
      begin
        SendGetStructMessage(Handle, LM_GETIDEALSIZE, MaxInt, TextSize);
        SetBounds(Left, Top, TextSize.cx + (GetSystemMetrics(SM_CXBORDER) * 4),
          TextSize.cy + (GetSystemMetrics(SM_CYBORDER) * 4));
      end;
    end
    else
    begin
      DC := GetDC(0);
      try
        SaveFont := SelectObject(DC, Font.Handle);
        try
          if CheckWin32Version(5, 1) and UseThemes then
          begin
            Parsed := ParseLinks;
            GetTextExtentPoint32(DC, Parsed, Length(Parsed), TextSize);
          end
          else
            GetTextExtentPoint32(DC, Caption, Length(Caption), TextSize);
        finally
          SelectObject(DC, SaveFont);
        end;
      finally
        ReleaseDC(0, DC);
      end;
      SetBounds(Left, Top, TextSize.cx + (GetSystemMetrics(SM_CXBORDER) * 4),
        TextSize.cy + (GetSystemMetrics(SM_CYBORDER) * 4));
    end;
  end;
end;

procedure TCustomLinkLabel.CreateParams(var Params: TCreateParams);
const
  LinkAlignments: array[Boolean, TLinkAlignment] of DWORD =
    ((0, LWS_RIGHT), (LWS_RIGHT, 0));
  TextAlignments: array[Boolean, TLinkAlignment] of DWORD =
    ((SS_LEFT, SS_RIGHT), (SS_RIGHT, SS_LEFT));
  VisualStyles: array[Boolean] of DWORD = (0, LWS_USEVISUALSTYLE);
var
  LStyle: DWORD;
begin
  inherited CreateParams(Params);
  if (((CheckWin32Version(5, 1) and UseThemes))) then
  begin
    CreateSubClass(Params, WC_LINK);
    LStyle := LinkAlignments[UseRightToLeftAlignment, FAlignment] or
      VisualStyles[FUseVisualStyle];
  end
  else
  begin
    CreateSubClass(Params, 'STATIC');
    LStyle := TextAlignments[UseRightToLeftAlignment, FAlignment];
  end;
  with Params do
  begin
    Style := Style or LStyle;
    WindowClass.style := WindowClass.style and not CS_VREDRAW;
  end;
end;

procedure TCustomLinkLabel.CreateWnd;
begin
  inherited;
  AdjustBounds;
end;

procedure TCustomLinkLabel.CMFontChanged(var Message: TMessage);
begin
  inherited;
  AdjustBounds;
end;

procedure TCustomLinkLabel.CMTextChanged(var Message: TMessage);
begin
  inherited;
  AdjustBounds;
  Invalidate;
end;

procedure TCustomLinkLabel.CMNotify(var Message: TWMNotify);
var
  Item: TLItem;
begin
  case Message.NMHdr.code of
    NM_CLICK, NM_RETURN:
    begin
{$IFNDEF CLR}
      Item := PNMLink(Message.NMHdr).item;
{$ELSE}
      Item := TWMNotifySL.Create(Message.OriginalMessage).LItem;
{$ENDIF}

      if Item.szID = '' then
        DoOnLinkClick(Item.szUrl, sltURL)
      else
        DoOnLinkClick(Item.szID, sltID);
    end;
  end;
end;

procedure TCustomLinkLabel.DoOnLinkClick(const Link: string; LinkType: TSysLinkType);
begin
  if Assigned(FOnLinkClick) then
    FOnLinkClick(Self, Link, LinkType);
end;

type
  TParseSearchMode = (psmLinkStart, psmLinkEnd);

function TCustomLinkLabel.ParseLinks: string;
var
  Pos, LookAhead, Last, I: Integer;
  SearchMode: TParseSearchMode;
  Len: Integer;
begin
  if Length(Caption) = 0 then
  begin
    Result := '';
    Exit;
  end;

  SetLength(Result, Length(Caption));
  Pos := 1;
  SearchMode := psmLinkStart;
  Len := 0;
  Last := Length(Caption);

  while Pos <= Last do
  begin
    case Caption[Pos] of
      '<': //do not localize
      begin
        LookAhead := Pos;

        if Pos = Last then
        begin
          Inc(Len);
          Result[Len] := Caption[Pos];
          Break;
        end;

        Inc(LookAhead);
        if SearchMode = psmLinkStart then
        begin
          if CharInSet(Caption[LookAhead], ['a', 'A']) then //do not localize
          begin
            while (Caption[LookAhead] <> '>') and (LookAhead <= Last) do //do not localize
              Inc(LookAhead);

            if LookAhead > Last then
            begin
              for I := 0 to LookAhead - Pos - 1 do
                Result[Len + 1 + I] := Caption[Pos + I];
              Inc(Len, LookAhead - Pos);
              Break;
            end
            else //LookAhead > Last
            begin
              Pos := LookAhead + 1;
              SearchMode := psmLinkEnd;
            end;
          end
          else //CharInSet(LookAhead^, ['a', 'A'])
          begin
            Inc(Len);
            Result[Len] := Caption[Pos];
            Inc(Pos);
          end;
        end
        else //SearchMode = psmLinkStart
        begin
          //A bit of an ugly way to do this, but its fast
          if (Caption[LookAhead] = '/') and //do not localize
             (CharInSet(Caption[LookAhead + 1], ['a', 'A'])) and //do not localize
             (Caption[LookAhead + 2] = '>') then //do not localize
          begin
            Inc(Pos, 4);
            SearchMode := psmLinkStart;
          end
          else
          begin
            Inc(Len);
            Result[Len] := Caption[Pos];
            Inc(Pos);
          end;
        end;
      end
      else
      begin
        Inc(Len);
        Result[Len] := Caption[Pos];
        Inc(Pos);
      end;
    end;
  end;

  SetLength(Result, Len);
end;

procedure TCustomLinkLabel.SetAlignment(const Value: TLinkAlignment);
begin
  if Value <> FAlignment then
  begin
    FAlignment := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TCustomLinkLabel.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    if Value then AdjustBounds;
  end;
end;

procedure TCustomLinkLabel.SetUseVisualStyle(const Value: Boolean);
begin
  if Value <> FUseVisualStyle then
  begin
    FUseVisualStyle := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

var
  ManifestResourcePresent: Boolean;
  ManifestResourceTested: Boolean = False;

function IsLinkLabelSupported: Boolean;
begin
  if not ManifestResourceTested then
  begin
    ManifestResourcePresent := FindResource(MainInstance,
      CREATEPROCESS_MANIFEST_RESOURCE_ID, RT_MANIFEST) <> 0;
    ManifestResourceTested := True;
  end;
  Result := ManifestResourcePresent and StyleServices.Available;
end;

function TCustomLinkLabel.UseThemes: Boolean;
begin
  Result := IsLinkLabelSupported;
end;

{ TLinkLabelStyleHook }

constructor TLinkLabelStyleHook.Create(AControl: TWinControl);
begin
  inherited;
  OverrideEraseBkgnd := True;
  Brush.Color := StyleServices.GetStyleColor(scWindow);
end;

procedure TLinkLabelStyleHook.WndProc(var Message: TMessage);
begin
  // Reserved for potential updates
  inherited;
end;

{ TLinkLabel }

class constructor TLinkLabel.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TLinkLabel, TLinkLabelStyleHook);
end;

class destructor TLinkLabel.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TLinkLabel, TLinkLabelStyleHook);
end;

initialization
{$IF NOT DEFINED(CLR)}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TTimer, Vcl.Controls.TControl);
  GroupDescendentsWith(TCustomTrayIcon, Vcl.Controls.TControl);
{$ENDIF}
  TCustomTrayIcon.RM_TaskBarCreated := RegisterWindowMessage('TaskbarCreated');
end.
