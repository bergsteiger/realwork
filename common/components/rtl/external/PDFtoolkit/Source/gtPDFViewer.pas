{ ********************************************************************* }
{                                                                       }
{                       Gnostice PDFtoolkit v3.0                        }
{                       Copyright (c) 2002-2009                         }
{          Gnostice Information Technologies Private Limited            }
{                       http://www.gnostice.com                         }
{                                                                       }
{ ********************************************************************* }
{$I gtDefines.inc}
unit gtPDFViewer;

interface

uses
  SysUtils, Classes, Controls, Forms, ExtCtrls, Messages, Windows,
  gtCstPDFDoc, {$IFDEF gtDelphi6up} Types, {$ENDIF}Graphics, Dialogs,
  gtScrollingPanel, gtViewerWidgets, gtViewerTypes, gtExProPDFDoc, gtPDFConsts,
  gtPDFUtils, gtPDFTypes;

type
  TgtRegion = class;
  TgtRegionClass = class of TgtRegion;
  TgtPDFViewer = class;
  TgtPageSurface = class;
  TgtPageManager = class;
  TgtDisplaySettings = class;

  TgtViewerPageChangeEvent = procedure(Sender: TgtPDFViewer;
    const CurrentPageIndex: TPageIndex) of object;
  TgtViewerZoomChangeEvent = procedure(Sender: TgtPDFViewer;
    const Zoom: Double) of object;
  TgtViewerMouseActivityEvent = procedure(Sender: TObject; Shift: TShiftState;
    MouseActivity: TgtViewerMouseActivity; PageNumber: Integer;
    X, Y, SelectionWidth, SelectionHeight: Integer) of object;
  TgtViewerMarqueeSelectEvent = procedure(Sender: TObject; Shift: TShiftState;
    RegionRect: TRect; LabelFont: TFont; var LabelColor: TColor;
    var LabelText: string) of object;
  TgtViewerRegionMouseActivityEvent = procedure(Sender: TObject;
    Shift: TShiftState; MouseActivity: TgtViewerMouseActivity;
    PageNumber: Integer; X, Y: Integer; RegionObj: TgtRegion;
    AssociatedObj: TObject) of object;

  TgtRegion = class(TObject)
  private
    FRegionHighlighter: TgtHighlightWidget;
    FInteractive: Boolean;
    function GetAssociatedObj: TObject;
    function GetHighlightColor: TColor;
    function GetHint: string;
    function GetPageIndex: TPageIndex;
    function GetRegion: TRect;
  protected
    property PageIndex: TPageIndex read GetPageIndex;
    property Region: TRect read GetRegion;
  public
    destructor Destroy; override;
    property AssociatedObj: TObject read GetAssociatedObj;
    property Hint: string read GetHint;
    property HighlightColor: TColor read GetHighlightColor;
    property Interactive: Boolean read FInteractive;
  end;

  TgtSelectedRegion = class(TgtRegion)
  private
    function GetEndPoint: TPoint;
    function GetHeight: Integer;
    function GetStartPoint: TPoint;
    function GetWidth: Integer;
    function GetRegionType: TgtSelectionType;
    procedure SetRegionType(const Value: TgtSelectionType);
    function GetRegionHighlighter: TgtRegionSelectionWidget;
    property RegionHighlighter: TgtRegionSelectionWidget
      read GetRegionHighlighter;
  public
    property RegionType: TgtSelectionType read GetRegionType
      write SetRegionType;
    property StartPoint: TPoint read GetStartPoint;
    property EndPoint: TPoint read GetEndPoint;
    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight;
    property PageIndex;
  end;

  TgtSelectedRegionList = class(TList)
  private
    function Get(Index: Integer): TgtSelectedRegion;
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    property Items[Index: Integer]: TgtSelectedRegion read Get; default;
  end;

  TgtHighlightedRegion = class(TgtRegion)
  public
    property PageIndex;
    property Region;
  end;

  TgtHighlightedRegionList = class(TList)
  private
    function Get(Index: Integer): TgtHighlightedRegion;
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    property Items[Index: Integer]: TgtHighlightedRegion read Get; default;
  end;

  TgtPageRegionsList = class(TList)
  private
    FPagesIDs: TList;
    FPageHighlightRegions: TList;
  public
    constructor Create;
    destructor Destroy; override;
//    function RegionsOfPage(APageIndex: TPageIndex): TgtHighlightedRegionList;
  end;

  TgtHighlightedKeyword = class(TgtHighlightedRegion)
  private
    FKeyword: string;
    FPageHighlightRegions: TgtPageRegionsList;
  public
    constructor Create;
    destructor Destroy; override;
    property Keyword: string read FKeyword;
  end;

  TgtHighlightedKeywordsList = class(TList)
  private
    function Get(Index: Integer): TgtHighlightedKeyword;
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    property Items[Index: Integer]: TgtHighlightedKeyword read Get; default;
  end;

  TgtPDFViewer = class(TgtScrollingPanel)
  private
    FPageManager: TgtPageManager;
    FDocument: TgtCustomPDFDocument;
    FActive: Boolean;
    FBorderStyle: TBorderStyle;
    FBorderWidth: TBorderWidth;
    FMarqueeDrawOn: Boolean;
    FMouseActivity: TgtViewerMouseActivity;
    FMouseOrigin: TPoint;
    FMouseDest: TPoint;
    FSelectedRegions: TgtSelectedRegionList;
    FHighlightedRegions: TgtHighlightedRegionList;
    FOnChange: TNotifyEvent;
    FOnMouseActivity: TgtViewerMouseActivityEvent;
    FOnPageChange: TgtViewerPageChangeEvent;
    FOnZoomChange: TgtViewerZoomChangeEvent;
    FOnMarqueeSelect: TgtViewerMarqueeSelectEvent;
    FOnRegionMouseActivity: TgtViewerRegionMouseActivityEvent;
    FDisplaySettings: TgtDisplaySettings;
    function GetAbout: string;
    function GetActualPoint(const APoint: TPoint;
      AConnectedPage: TPageIndex): TPoint;
    function GetCurrentPageIndex: TPageIndex;
    function GetHScrollPos: Integer;
    function GetIsFirst: Boolean;
    function GetIsLast: Boolean;
    function GetNextZoom: Double;
    function GetPrevZoom: Double;
    function GetRotationAngle: TgtRotationAngle;
    function GetSearchHighlightColor: TColor;
    function GetSelectedRegionsCount: Integer;
    function GetVersion: string;
    function GetVScrollPos: Integer;
    function GetZoom: Double;
    function GetZoomType: TgtStdZoomType;
    function IsAllReadyToView: Boolean;
    function IsZoomStored: Boolean;
    procedure Activate;
    procedure Deactivate;
    procedure SetAbout(const Value: string);
    procedure SetActive(const Value: Boolean);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetBorderWidth(const Value: TBorderWidth);
    procedure SetCurrentPageIndex(const Value: TPageIndex);
    procedure SetDocument(const Value: TgtCustomPDFDocument);
    procedure SetHScrollPos(const Value: Integer);
    procedure SetRotationAngle(const Value: TgtRotationAngle);
    procedure SetSearchHighlightColor(const Value: TColor);
    procedure SetVersion(const Value: string);
    procedure SetVScrollPos(const Value: Integer);
    procedure SetZoom(const Value: Double);
    procedure SetZoomType(const Value: TgtStdZoomType);
    procedure WMNCHitTest(var Message: TMessage); message WM_NCHITTEST;

    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;

    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;

    procedure Lasso(Sender: TObject; X, Y: Integer; AHide: Boolean = False);
    procedure PageClick(Sender: TObject);
    procedure PageKeyDown(Sender: TObject; var Key: Word; Shift:
      TShiftState);
    procedure PageKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PageKeyPress(Sender: TObject; var Key: Char);

    procedure PageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PageMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure PageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PageMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);

    procedure RegionMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RegionMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure RegionMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
//    procedure PageMouseEnter(Sender: TObject);
//    procedure PageMouseLeave(Sender: TObject);
    procedure OrderPoints(var AP1, AP2: TPoint);
    function CreateRegion(ARegionType: TgtRegionClass;
      AWidgetType: TgtHighlightWidgetClass; ARegion: TRect;
      APageIndex: TPageIndex; AHint: string; AHighlightColor: TColor;
      ARectIsActual: Boolean = True; AInteractive: Boolean = False;
      AAssociatedObj: TObject = nil): TgtRegion;
    procedure ClearAllRegions;
    procedure DisplaySettingsChanged(ADispSettings: TObject);
  protected
    function GetScrollHintText: string; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint): Boolean; override;
    procedure DoOnChange;
    procedure DoOnMouseActivity(Shift: TShiftState; PageNumber: Integer);
    procedure DoOnPageChange;
    procedure DoOnZoomChange;

    procedure DoOnMarqueeSelect(Shift: TShiftState; RegionRect: TRect;
      LabelFont: TFont; var LabelColor: TColor; var LabelText: string);
    procedure DoOnRegionMouseActivity(Shift: TShiftState;
      MouseActivity: TgtViewerMouseActivity; X, Y: Integer; RegionObj: TgtRegion);

    procedure CMPDFDocumentChanged(var Message:
      TCMPDFDocumentChanged); message CM_PDFDocumentChanged;
    procedure CMPDFDocumentDestroying(var Message:
      TCMPDFDocumentDestroying); message CM_PDFDocumentDestroying;
    procedure MouseDown(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
    procedure WMDisplayChange(var Message: TWMDisplayChange);
      message WM_DISPLAYCHANGE;
//    procedure SetParent(AParent: TWinControl); override;
    procedure Click; override;

    property DisplaySettings: TgtDisplaySettings read FDisplaySettings
      write FDisplaySettings;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetStandardZoomValue(AZoomType: TgtStdZoomType): Double;
    function GoToPage(APageIndex: TPageIndex;
      ATop: Integer = 0; ALeft: Integer = 0): TPageIndex;
    function HighlightRegion(ARegion: TRect; APageIndex: TPageIndex;
      AHint: string = ''; AHighlightColor: TColor = clYellow;
      AInteractive: Boolean = False; AAssociatedObj: TObject = nil): Integer;
    function RotateClockwise90: TgtRotationAngle;
    function RotateAntiClockwise90: TgtRotationAngle;
    function ZoomIn: Boolean;
    function ZoomOut: Boolean;
    procedure ClearHighlightRegions;
    procedure ClearInternalHighlightRegions;
    procedure ClearSelectedRegions;
    procedure First;
    procedure Last;
    procedure Next;
    procedure Prior;
    procedure KeyHome;
    procedure KeyEnd;
    procedure KeyPageUp;
    procedure KeyPageDown;
    procedure KeyArrowUp;
    procedure KeyArrowDown;
    procedure KeyArrowLeft;
    procedure KeyArrowRight;
    // This is for internal use by PDFtoolkit components. Do not use this method.
    // Use HighlightRegion instead
    procedure InternalHighlightRegion(ARegion: TRect;
      APageIndex: TPageIndex; AGotoRegion: Boolean = True);
    procedure PrintDoc(const AShowPrintDialog: Boolean = True);
    procedure Reset;
    property HighlightedRegions: TgtHighlightedRegionList
      read FHighlightedRegions;
    property IsFirst: Boolean read GetIsFirst;
    property IsLast: Boolean read GetIsLast;
    // Selected regions always returns startpoint=(left,top),
    // endpoint=(right,bottom) in pixels and coordinates are based on actual size
    // negating rotation and zoom
    property SelectedRegions: TgtSelectedRegionList read FSelectedRegions;
    property SelectedRegionsCount: Integer read GetSelectedRegionsCount;

    // Get and set current positions of horizontal and vertical scroll positions
    // Useful to sync 2 side-by-side arranged viewer components viewing the same
    // document
    property HScrollPos: Integer read GetHScrollPos write SetHScrollPos;
    property VScrollPos: Integer read GetVScrollPos write SetVScrollPos;

  published
    // Inherited properties and events
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelKind;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property Color nodefault;
    property Ctl3D;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DockOrientation;
    property DockManager;
    property DockSite;
{$IFDEF gtDelphi7Up }
    property ParentBackground default False;
{$ENDIF}
    property ParentColor;
    property ParentCtl3D;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property UseDockManager;
    property Visible;
    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    // Use only to get mouse events from areas *outside* the displayed page of
    // the viewer. Use OnMouseActivity instead to get events from displayed page
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
    //Keyboard events exposed
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;

    // Introduced properties and events
    property About: string read GetAbout write SetAbout;
    property Active: Boolean read FActive write SetActive default False;
    property BorderStyle: TBorderStyle read FBorderStyle
      write SetBorderStyle default bsNone;
    property BorderWidth: TBorderWidth read FBorderWidth
      write SetBorderWidth default cDEFAULT_BORDER_WIDTH;
    property PDFDocument: TgtCustomPDFDocument read FDocument write SetDocument;
    property CurrentPageIndex: TPageIndex read GetCurrentPageIndex
      write SetCurrentPageIndex default 1;
    property PageNo: TPageIndex read GetCurrentPageIndex write SetCurrentPageIndex default 1; // can't deprecate
      // PageNo - published property, so it should be mentioned in help not to use this
      // property as it will be removed in future versions.
      // CurrentPageIndex should be used instead.
    property RotationAngle: TgtRotationAngle read GetRotationAngle write SetRotationAngle default ra0;
    property SearchHighlightColor: TColor read GetSearchHighlightColor write SetSearchHighlightColor default clSkyBlue;
    property Version: string read GetVersion write SetVersion;
    property Zoom: Double read GetZoom write SetZoom stored IsZoomStored;
    property ZoomType: TgtStdZoomType read GetZoomType write SetZoomType
      default sztFitWidth;

    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    // Coordinates supplied by OnMouseActivity are actual coordinates in pixels, negating Zoom and rotation
    // Width and Height are always positive values even if mouse was dragged in the negative x and/or y axis
    property OnMouseActivity: TgtViewerMouseActivityEvent read FOnMouseActivity write FOnMouseActivity;
    property OnPageChange: TgtViewerPageChangeEvent read FOnPageChange write FOnPageChange;
    property OnZoomChange: TgtViewerZoomChangeEvent read FOnZoomChange write FOnZoomChange;

    property OnMarqueeSelect: TgtViewerMarqueeSelectEvent read FOnMarqueeSelect
      write FOnMarqueeSelect;
    property OnRegionMouseActivity: TgtViewerRegionMouseActivityEvent
      read FOnRegionMouseActivity write FOnRegionMouseActivity;
    // These scroll events fire when their respective scroll bar positions change
    // The events are of the existing VCL event type StdCtrls.TScrollEvent
    property OnHScroll;
    property OnVScroll;
  end;

  TgtDisplaySettings = class(TPersistent)
  private
    FResDPISource: TgtResDPISource;
    FResDPICustom: TResDPI;
    FOnChange: TNotifyEvent;
    procedure SetResDPISource(const Value: TgtResDPISource);
    procedure SetResDPICustom(const Value: TResDPI);
    procedure Changed;
    function GetResDPIEffective: TResDPI;
  public
    constructor Create; virtual;
    property ResDPIEffective: TResDPI read GetResDPIEffective;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property ResDPISource: TgtResDPISource read FResDPISource
      write SetResDPISource default rsUseCustom;
    property ResDPICustom: TResDPI read FResDPICustom
      write SetResDPICustom default cDEFAULT_RES_DPI;
  end;

  TgtPageProperties = class(TObject)
  private
    FActualWidth: Double;
    FActualHeight: Double;
    FWidth: Double;
    FHeight: Double;
    FTop: Double;
  public
    property Width: Double read FWidth write FWidth;
    property Height: Double read FHeight write FHeight;
    property Top: Double read FTop write FTop;
  end;

  TgtPagePropsList = class(TList)
  private
    function Get(Index: Integer): TgtPageProperties;
  public
    property Items[Index: Integer]: TgtPageProperties read Get; default;
  end;

  TgtPageSurface = class(TCustomPanel)
  private
    FViewer: TgtPDFViewer;
    FConnectedPage: TPageIndex;
    FPageEMF: TStream;
    FRotationAngle: TgtRotationAngle;
    FRedraw: Boolean;

    FBitmap: HBITMAP;
    FSavedDC: HDC;

    procedure SetRotationAngle(const Value: TgtRotationAngle);
    procedure RenderPage(DC: HDC; Rect: TRect);
  protected
    procedure Paint; override;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    property RotationAngle: TgtRotationAngle read FRotationAngle
      write SetRotationAngle;
    property ConnectedPage: TPageIndex read FConnectedPage write FConnectedPage;

  end;

  TgtPageSurfList = class(TList)
  private
    function Get(Index: Integer): TgtPageSurface;
  public
    property Items[Index: Integer]: TgtPageSurface read Get; default;

  end;

  TgtPageManager = class(TObject)
  private
    FViewer: TgtPDFViewer;
    FVisiblePages: TgtPageSurfList;
    FSearchHighlighter: TgtHighlightWidget;
    FShowSearchRegion: Boolean;
    FPageProps: TgtPagePropsList;
    FCurrentPageIndex: TPageIndex;
    FFirstPageIndex: TPageIndex;
    FLastPageIndex: TPageIndex;
    FActualMaxPageHeight: Double;
    FActualMaxPageWidth: Double;
    FMaxPageHeight: Double;
    FMaxPageWidth: Double;
    FRotationAngle: TgtRotationAngle;
    FSizingLocked: Boolean;
    FZoom: Double;
    FZoomType: TgtStdZoomType;
    FZoomTypeLocked: Boolean;
    function CreatePage(AConnectedPage: TPageIndex): TgtPageSurface;
    function GetPageSurfaceOf(APageIndex: TPageIndex): TgtPageSurface;
    function GetPageIndexFromScrollPos(AScrollPos: Integer): TPageIndex;
    function GetScrollPosFromPageIndex(APageIndex: TPageIndex): Integer;
    function GetStandardZoomValue(AZoomType: TgtStdZoomType): Double;
    function GetTransformedPoint(const APoint: TPoint;
      AConnectedPage: TPageIndex): TPoint;
    function GetHScrollRange: Integer;
    function GetVScrollRange: Integer;
    function UpdateViewer(AScrollPos, ACachePageCount: Integer): Boolean;
    function ValidatePageIndex(APageIndex: TPageIndex): TPageIndex;
    procedure Activate;
    procedure Deactivate;
    procedure ClearPageProps;
    procedure DeletePage(AListIndex: Integer);
    procedure DestroyPages;
    procedure ReadPageProps;
    procedure ReCalcPageProps;
    procedure RefreshView;
    procedure ResetWidgetBounds(AWidget: TgtViewerWidget;
      APageSurf: TgtPageSurface; AInteractive: Boolean = False);
//    procedure RenderPage(AConnectedPage: TPageIndex);
    procedure SetCurrentPageIndex(const Value: TPageIndex);
    procedure SetPageBounds(APage: TgtPageSurface);
    procedure SetRotationAngle(const Value: TgtRotationAngle);
    procedure SetHScrollRange(ARange: Integer);
    procedure SetVScrollRange(ARange: Integer);
    procedure SetZoom(const Value: Double);
    procedure SetZoomType(const Value: TgtStdZoomType);
    procedure UpdateVisiblePages;
    procedure UpdateWidgets(APage: TgtPageSurface);
  public
    constructor Create(AOwner: TgtPDFViewer);
    destructor Destroy; override;
    function GoToPage(APageIndex: TPageIndex;
      ATop: Integer = 0; ALeft: Integer = 0): TPageIndex;
    procedure ScrollViewer(AScrollPos: Integer;
      APageCacheCount: Integer = cPAGE_CACHE_COUNT);
    property CurrentPageIndex: TPageIndex read FCurrentPageIndex
      write SetCurrentPageIndex;
    property RotationAngle: TgtRotationAngle read FRotationAngle write SetRotationAngle;
    property Zoom: Double read FZoom write SetZoom;
    property ZoomType: TgtStdZoomType read FZoomType write SetZoomType;
  end;

implementation

uses Math, gtPDFPrinter, gtMouseWheelRectifier;

{ Helper routines }

function PointInWindow(APoint: TPoint; AWindow: TWinControl): Boolean;
begin
  with AWindow.ClientRect do
    Result := (Left <= APoint.X) and (Right >= APoint.X) and
      (Top <= APoint.Y) and (Bottom >= APoint.Y);
end;

function RectsEqual(const ARect1, ARect2: TRect): Boolean;
begin
  Result := PointsEqual(ARect1.TopLeft, ARect2.TopLeft) and
    PointsEqual(ARect1.BottomRight, ARect2.BottomRight);
end;

procedure SwapAB(var A, B: Integer);
var
  C: Integer;
begin
  C := A;
  A := B;
  B := C;
end;

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

{ TgtPDFViewer }

constructor TgtPDFViewer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF gtDelphi6 }
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csSetCaption, csDoubleClicks {csPannable,}];
{$ENDIF}
{$IFDEF gtDelphi7Up }
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csSetCaption, csDoubleClicks, {csPannable,} csNeedsBorderPaint];
{$ENDIF}

  FPageManager := TgtPageManager.Create(Self);
  FSelectedRegions := TgtSelectedRegionList.Create;
  FHighlightedRegions := TgtHighlightedRegionList.Create;
  FActive := False;
  FBorderStyle := bsNone;
  Color := clGray;
  AutoScroll := False;
  Width := 450;
  Height := 300;
  FBorderWidth := cDEFAULT_BORDER_WIDTH;

  // Set general verticle scrollbar properties
  VertScrollBar.Smooth := True;
  VertScrollBar.Tracking := True;
  VertScrollBar.Style := ssHotTrack;
  VertScrollBar.Visible := True;

  // Set general horizontal scrollbar properties
  HorzScrollBar.Smooth := True;
  HorzScrollBar.Tracking := True;
  HorzScrollBar.Style := ssHotTrack;
  HorzScrollBar.Visible := True;

  FDisplaySettings := TgtDisplaySettings.Create;
  FDisplaySettings.OnChange := DisplaySettingsChanged;
end;

destructor TgtPDFViewer.Destroy;
begin
  if FDocument <> nil then
    FDocument.UnRegisterLinkedControl(Self);
  FPageManager.Free;
  // Extended list types. They handle items objects freeing internally
  FSelectedRegions.Free;
  FHighlightedRegions.Free;
  FDisplaySettings.Free;
  inherited Destroy;
end;

procedure TgtPDFViewer.DisplaySettingsChanged(ADispSettings: TObject);
begin
  FPageManager.RefreshView;
end;


function TgtPDFViewer.GetAbout: string;
begin
  Result := SProductName; // About string constant goes here
end;

// Return corrected points negating rotation and zoom

function TgtPDFViewer.GetActualPoint(const APoint: TPoint;
  AConnectedPage: TPageIndex): TPoint;
var
  LPoint: TPoint;
  LWidth, LHeight: Integer;
begin
  LPoint := APoint;
  LWidth := Round(FPageManager.FPageProps[AConnectedPage - 1].Width);
  LHeight := Round(FPageManager.FPageProps[AConnectedPage - 1].Height);

  // Correction for rotation
  case RotationAngle of
    raCW90, raACW270:             // Rotated right -->
    begin
      SwapAB(LPoint.X, LPoint.Y);
      LPoint.Y := LWidth - LPoint.Y;
    end;
    raCW270, raACW90:             // Rotated left <--
    begin
      SwapAB(LPoint.X, LPoint.Y);
      LPoint.X := LHeight - LPoint.X;
    end;
    raCW180, raACW180:            // upside-down
    begin
      LPoint.X := LWidth - LPoint.X;
      LPoint.Y := LHeight - LPoint.Y;
    end;
    ra0: ;                        // Normal postion ^ - so no correction required
  end;

  // Correction for Zoom and DPI
  LPoint.X := Round(LPoint.X / Zoom * 100 / DisplaySettings.ResDPIEffective
    * Screen.PixelsPerInch);
  LPoint.Y := Round(LPoint.Y / Zoom * 100 / DisplaySettings.ResDPIEffective
    * Screen.PixelsPerInch);
  Result := LPoint;
end;

function TgtPDFViewer.GetCurrentPageIndex: TPageIndex;
begin
  Result := FPageManager.CurrentPageIndex;
end;

function TgtPDFViewer.GetHScrollPos: Integer;
begin
  Result := HorzScrollBar.Position;
end;

function TgtPDFViewer.GetIsFirst: Boolean;
begin
  Result := CurrentPageIndex = 1;
end;

function TgtPDFViewer.GetIsLast: Boolean;
begin
  Result := CurrentPageIndex = PDFDocument.PageCount;
end;

function TgtPDFViewer.GetNextZoom: Double;
var
  I: Integer;
begin
  for I := Low(cZOOM_STD_VALUES) to High(cZOOM_STD_VALUES) do
    if cZOOM_STD_VALUES[I] > Zoom then
      Break;
  Result := cZOOM_STD_VALUES[I];
end;

function TgtPDFViewer.GetPrevZoom: Double;
var
  I: Integer;
begin
  for I := High(cZOOM_STD_VALUES) downto Low(cZOOM_STD_VALUES) do
    if cZOOM_STD_VALUES[I] < Zoom then
      Break;
  Result := cZOOM_STD_VALUES[I];
end;

function TgtPDFViewer.GetRotationAngle: TgtRotationAngle;
begin
  Result := FPageManager.RotationAngle;
end;

function TgtPDFViewer.GetSearchHighlightColor: TColor;
begin
  Result := FPageManager.FSearchHighlighter.BrushColor;
end;

function TgtPDFViewer.GetSelectedRegionsCount: Integer;
begin
  Result := FSelectedRegions.Count;
end;

function TgtPDFViewer.GetVersion: string;
begin
  Result := CVersion; // Version constant goes here
end;

function TgtPDFViewer.GetVScrollPos: Integer;
begin
  Result := VertScrollBar.Position;
end;

function TgtPDFViewer.GetZoom: Double;
begin
  Result := FPageManager.Zoom;
end;

function TgtPDFViewer.GetZoomType: TgtStdZoomType;
begin
  Result := FPageManager.ZoomType;
end;

function TgtPDFViewer.IsAllReadyToView: Boolean;
begin
  Result := Active and (PDFDocument <> nil) and PDFDocument.IsLoaded;
end;

// This prevents the property's set method (SetZoom) from being invoked at the time of
// loading/reading the property values from the stream, which would wrongly cause
// setting the ZoomType to sztCustom
// If value is not stored in the form file, then setzoom will not be called and so
// prevent zoomtype from wrongly changing to sztCustom on form load
// SetZoom should only be called if Zoom was specifically set by user at
// design-time, which also would have automatically set ZoomType to sztCustom.
// Function required because non ordinal property types cannot use the default specifier
// If this is not done and a very low zoom value was specified, it would confuse the user
// as the pages would be small dots, also, it would never be possible to start
// with a standard initial zoom of FitWidth/FitPage...
function TgtPDFViewer.IsZoomStored: Boolean;
begin
  Result := ZoomType = sztCustom;
end;

procedure TgtPDFViewer.Activate;
begin
  FPageManager.Activate;
end;

procedure TgtPDFViewer.Deactivate;
begin
  FPageManager.Deactivate;
end;

procedure TgtPDFViewer.SetAbout(const Value: string);
begin
// Do nothing
end;

procedure TgtPDFViewer.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    // Did user try to set Active to True when it was false and is document ready?
    if (Value = True) and (FDocument = nil) or (Assigned(FDocument) and (not FDocument.IsLoaded)) then
    begin
      // if in design-time, show message that document is nil or not loaded
      //  so Active will remain false
      Exit;
    end;
    // else Active can be set to whatever the user intended to set it to
    FActive := Value;
    if FActive then
      Activate
    else
      Deactivate;
  end;
end;

procedure TgtPDFViewer.SetBorderStyle(Value: TBorderStyle);
begin
  if Value <> FBorderStyle then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TgtPDFViewer.SetBorderWidth(const Value: TBorderWidth);
begin
  if FBorderWidth <> Value then
  begin
    FBorderWidth := Value;
    FPageManager.RefreshView;
  end;
end;

procedure TgtPDFViewer.SetCurrentPageIndex(const Value: TPageIndex);
begin
  FPageManager.CurrentPageIndex := Value;
end;

procedure TgtPDFViewer.SetDocument(const Value: TgtCustomPDFDocument);
begin
  if FDocument <> nil then
    FDocument.UnRegisterLinkedControl(Self);
  FDocument := Value;
  ClearAllRegions;
  if FDocument <> nil then
    FDocument.RegisterLinkedControl(Self);
  if FDocument = nil then
    Active := False       // if Document was cleared then viewer needs to be deactivated
  else if Active then
    Activate;
    // setting Active will automatically Activate viewer,
    // but if Active did not change (was True), but Document was changed, then explicitly
    // re-activate
end;

procedure TgtPDFViewer.SetHScrollPos(const Value: Integer);
begin
  HorzScrollBar.Position := Value;
end;

procedure TgtPDFViewer.SetRotationAngle(const Value: TgtRotationAngle);
begin
  FPageManager.RotationAngle := Value;
end;

procedure TgtPDFViewer.SetSearchHighlightColor(const Value: TColor);
begin
  FPageManager.FSearchHighlighter.BrushColor := Value;
end;

procedure TgtPDFViewer.SetVersion(const Value: string);
begin
// Do nothing
end;

procedure TgtPDFViewer.SetVScrollPos(const Value: Integer);
begin
  FPageManager.ScrollViewer(Value);
end;

procedure TgtPDFViewer.SetZoom(const Value: Double);
begin
  FPageManager.Zoom := Value;
end;

procedure TgtPDFViewer.SetZoomType(const Value: TgtStdZoomType);
begin
  FPageManager.ZoomType := Value;
end;

procedure TgtPDFViewer.WMDisplayChange(var Message: TWMDisplayChange);
begin
  FPageManager.RefreshView;
end;

procedure TgtPDFViewer.WMNCHitTest(var Message: TMessage);
begin
  inherited;
//  DefaultHandler(Message);
end;

procedure TgtPDFViewer.WMSize(var Message: TWMSize);
var
  LOldZoom: Double;
begin
  inherited;
  if FPageManager.FSizingLocked then
    Exit;

  LOldZoom := Zoom;
  if not (ZoomType in [sztCustom, sztActualSize]) then
    ZoomType := ZoomType; // force recalc zoom, which will take care of updating viewer
  // if zoom did not change, force update viewer as page position needs to change
  if LOldZoom = Zoom then
    FPageManager.ScrollViewer(VertScrollBar.Position);
end;

procedure TgtPDFViewer.WMVScroll(var Message: TWMVScroll);
var
  LOldPos, LPosDelta: Integer;
begin
  LOldPos := VertScrollBar.Position;
  inherited;
  LPosDelta := VertScrollBar.Position - LOldPos;

  if LPosDelta = 0 then // No change in position so don't do anything
    Exit;

  FPageManager.ScrollViewer(VertScrollBar.Position);
end;

procedure TgtPDFViewer.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (FBorderStyle = bsSingle) then RecreateWnd;
  inherited;
end;

procedure TgtPDFViewer.Lasso(Sender: TObject; X, Y: Integer; AHide: Boolean);
begin
  with TgtPageSurface(Sender).Canvas do
  begin
    Brush.Style := bsClear;
    Pen.Mode := pmNotXor;
    Pen.Style := psDot;
    // Erase old rect by redrawing a rect over old rect (pen style takes care of that)
    Rectangle(FMouseOrigin.X, FMouseOrigin.Y, FMouseDest.X, FMouseDest.Y);
    // Draw new rect
    if not AHide then
      Rectangle(FMouseOrigin.X, FMouseOrigin.Y, X, Y);
  end;
end;

procedure TgtPDFViewer.PageClick(Sender: TObject);
begin
  SetFocus;
end;

procedure TgtPDFViewer.PageKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  KeyDown(Key, Shift);
end;

procedure TgtPDFViewer.PageKeyPress(Sender: TObject; var Key: Char);
begin
  KeyPress(Key);
end;

procedure TgtPDFViewer.PageKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  KeyUp(Key, Shift);
end;

procedure TgtPDFViewer.PageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FMouseActivity := vmaButtonDown;
  FMouseOrigin := Point(X, Y);
  FMouseDest := Point(X, Y);
  // When selection starts search highlighting is cleared
  ClearInternalHighlightRegions;
  case Button of
    mbLeft: Shift := Shift + [ssLeft];
    mbRight: Shift := Shift + [ssRight];
    mbMiddle: Shift := Shift + [ssMiddle];
  end;
  // If Ctrl not pressed, clear previously selected regions
  if not (ssCtrl in Shift) then
    FSelectedRegions.Clear;
  FMarqueeDrawOn := True;
  DoOnMouseActivity(Shift, TgtPageSurface(Sender).ConnectedPage);
end;

procedure TgtPDFViewer.PageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (ssLeft in Shift) or (ssRight in Shift) or (ssMiddle in Shift) then
  begin
    FMouseActivity := vmaSelecting;
    Lasso(Sender, X, Y);
    FMouseDest := Point(X, Y);
  end
  else
  begin
    FMouseActivity := vmaMoving;
    FMouseOrigin := Point(X, Y);
    FMouseDest := Point(X, Y);
  end;
  DoOnMouseActivity(Shift, TgtPageSurface(Sender).ConnectedPage);
end;

procedure TgtPDFViewer.PageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  LSelectedRegion: TgtSelectedRegion;
  LConnectedPage: TPageIndex;
  LRegion: TRect;
  LLabelColor: TColor;
  LLabelText: string;
begin
  if not FMarqueeDrawOn then
    Exit; // mousedown did not take place on page so exit (drawing started outside page)
  FMarqueeDrawOn := False;
  Lasso(Sender, X, Y, True);
  FMouseActivity := vmaButtonUp;
  FMouseDest := Point(X, Y);
  case Button of
    mbLeft: Shift := Shift + [ssLeft];
    mbRight: Shift := Shift + [ssRight];
    mbMiddle: Shift := Shift + [ssMiddle];
  end;
  LConnectedPage := TgtPageSurface(Sender).ConnectedPage;
  DoOnMouseActivity(Shift, LConnectedPage);

  LRegion := Rect(FMouseOrigin.X, FMouseOrigin.Y, FMouseDest.X, FMouseDest.Y);

  LSelectedRegion := TgtSelectedRegion(CreateRegion(TgtSelectedRegion,
    TgtRegionSelectionWidget, LRegion, LConnectedPage, '', clSkyBlue, False));
  LLabelColor := LSelectedRegion.RegionHighlighter.LabelColor;
  LLabelText := sRegionSelectorLabelPrefix + IntToStr(FSelectedRegions.Count + 1);
  DoOnMarqueeSelect(Shift, LRegion, LSelectedRegion.RegionHighlighter.LabelFont,
    LLabelColor, LLabelText);
  LSelectedRegion.RegionHighlighter.LabelColor := LLabelColor;
  LSelectedRegion.RegionHighlighter.LabelText := LLabelText;

  if PointsEqual(FMouseOrigin, FMouseDest) then // Is selection a single point?
    with LSelectedRegion do // Show point
    begin
      RegionType := stPoint;
      // point is 6 pixels wide and 6 pixels tall
      RegionHighlighter.Left := FMouseOrigin.X - 3;
      RegionHighlighter.Top := FMouseOrigin.Y - 3;
    end;
  FSelectedRegions.Add(LSelectedRegion);
end;

procedure TgtPDFViewer.PageMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  DoMouseWheel(Shift, WheelDelta, MousePos);
  Handled := True;
end;

// Makes AP1 = left, top; AP2 = right, bottom
procedure TgtPDFViewer.OrderPoints(var AP1, AP2: TPoint);
begin
  if AP1.X > AP2.X then
    SwapAB(AP1.X, AP2.X);
  if AP1.Y > AP2.Y then
    SwapAB(AP1.Y, AP2.Y);
end;

function TgtPDFViewer.GetScrollHintText: string;
begin
  // Don't call inherited as we want to provide new text for the hint
  Result := sScrollToolTipText +
    IntToStr(FPageManager.GetPageIndexFromScrollPos(VertScrollBar.TrackingPos));
end;

procedure TgtPDFViewer.CreateParams(var Params: TCreateParams);
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
  end;
end;

procedure TgtPDFViewer.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  case Operation of
    opRemove:
      if PDFDocument = AComponent then PDFDocument := nil;
  end;
end;

function TgtPDFViewer.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint): Boolean;
begin
	Result := True;
  if ssCtrl in Shift then
  begin
    if WheelDelta < 0 then
      ZoomOut
    else
      ZoomIn;
  end
  else
  begin
    VertScrollBar.Position := VertScrollBar.Position - WheelDelta;
    FPageManager.ScrollViewer(VertScrollBar.Position);
  end;
end;

procedure TgtPDFViewer.DoOnChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TgtPDFViewer.DoOnRegionMouseActivity(Shift: TShiftState;
  MouseActivity: TgtViewerMouseActivity; X, Y: Integer; RegionObj: TgtRegion);
begin
  if Assigned(FOnRegionMouseActivity) then
    FOnRegionMouseActivity(Self, Shift, MouseActivity, RegionObj.PageIndex,
      X, Y, RegionObj, RegionObj.AssociatedObj);
end;

procedure TgtPDFViewer.DoOnMarqueeSelect(Shift: TShiftState; RegionRect: TRect;
  LabelFont: TFont; var LabelColor: TColor; var LabelText: string);
begin
  if Assigned(FOnMarqueeSelect) then
    FOnMarqueeSelect(Self, Shift, RegionRect, LabelFont, LabelColor, LabelText);
end;

procedure TgtPDFViewer.DoOnMouseActivity(Shift: TShiftState; PageNumber: Integer);
var
  LP1, LP2: TPoint;
begin
  LP1 := GetActualPoint(FMouseOrigin, PageNumber);
  LP2 := GetActualPoint(FMouseDest, PageNumber);
  if Assigned(FOnMouseActivity) then
    FOnMouseActivity(Self, Shift, FMouseActivity, PageNumber,
      LP1.X, LP1.Y, Abs(LP2.X - LP1.X), Abs(LP2.Y - LP1.Y));
end;

procedure TgtPDFViewer.DoOnPageChange;
begin
  if Assigned(FOnPageChange) then
    FOnPageChange(Self, CurrentPageIndex);
  DoOnChange;
end;

procedure TgtPDFViewer.DoOnZoomChange;
begin
  if Assigned(FOnZoomChange) then
    FOnZoomChange(Self, Zoom);
  DoOnChange;
end;

procedure TgtPDFViewer.CMPDFDocumentChanged(var Message: TCMPDFDocumentChanged);
begin
  ClearAllRegions;
  if Active then
    Activate;
end;

procedure TgtPDFViewer.CMPDFDocumentDestroying(
  var Message: TCMPDFDocumentDestroying);
begin
  PDFDocument := nil;
end;

function TgtPDFViewer.GetStandardZoomValue(AZoomType: TgtStdZoomType): Double;
begin
  Result := FPageManager.GetStandardZoomValue(AZoomType);
end;

function TgtPDFViewer.GoToPage(APageIndex: TPageIndex;
  ATop: Integer; ALeft: Integer): TPageIndex;
begin
  // Top and Left are relative to the requested PageIndex, in pixels
  Result := FPageManager.GoToPage(APageIndex, ATop, ALeft);
  // Returns page number it was possible to change to.
  // Useful to update a page change edit control in a viewer application.
end;

function TgtPDFViewer.HighlightRegion(ARegion: TRect; APageIndex: TPageIndex;
  AHint: string; AHighlightColor: TColor; AInteractive: Boolean;
  AAssociatedObj: TObject): Integer;
begin
  Result := FHighlightedRegions.Add(TgtHighlightedRegion(
    CreateRegion(TgtHighlightedRegion, TgtHighlightWidget, ARegion, APageIndex,
      AHint, AHighlightColor, True, AInteractive, AAssociatedObj)));
end;

function TgtPDFViewer.RotateAntiClockwise90: TgtRotationAngle;
begin
  if RotationAngle = raACW270 then
    RotationAngle := ra0
  else if RotationAngle = ra0 then
    RotationAngle := raACW90
  else if RotationAngle < raACW90 then
    RotationAngle := Pred(RotationAngle)
  else
    RotationAngle := Succ(RotationAngle);
  Result := RotationAngle;
end;

function TgtPDFViewer.RotateClockwise90: TgtRotationAngle;
begin
  if RotationAngle in [raCW270, raACW90] then
    RotationAngle := ra0
  else if RotationAngle > raACW90 then
    RotationAngle := Pred(RotationAngle)
  else
    RotationAngle := Succ(RotationAngle);
  Result := RotationAngle;
end;

function TgtPDFViewer.ZoomIn: Boolean;
begin
  Result := True;
  if Zoom < cZOOM_RANGE_MAX then
    Zoom := GetNextZoom
  else
    Result := False;
end;

function TgtPDFViewer.ZoomOut: Boolean;
begin
  Result := True;
  if Zoom > cZOOM_RANGE_MIN then
    Zoom := GetPrevZoom
  else
    Result := False;
end;

procedure TgtPDFViewer.ClearHighlightRegions;
begin
  // The list's notify method is overridden to free objects. No need to free here.
  // List.Clear calls Delete(0..n) which calls Notify
  FHighlightedRegions.Clear;
end;

procedure TgtPDFViewer.ClearInternalHighlightRegions;
begin
  FPageManager.FSearchHighlighter.Parent := nil;
  FPageManager.FShowSearchRegion := False;
end;

procedure TgtPDFViewer.ClearSelectedRegions;
begin
  FSelectedRegions.Clear;
end;

procedure TgtPDFViewer.Click;
begin
  inherited;
  SetFocus;
end;

procedure TgtPDFViewer.First;
begin
  CurrentPageIndex := 1;
end;

procedure TgtPDFViewer.Last;
begin
  CurrentPageIndex := PDFDocument.PageCount;
end;

procedure TgtPDFViewer.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  ClearSelectedRegions;
  ClearInternalHighlightRegions;
end;

procedure TgtPDFViewer.Next;
begin
  if CurrentPageIndex < PDFDocument.PageCount then
    CurrentPageIndex := CurrentPageIndex + 1;
end;

procedure TgtPDFViewer.Prior;
begin
  if CurrentPageIndex > 1 then
    CurrentPageIndex := CurrentPageIndex - 1;
end;

procedure TgtPDFViewer.KeyArrowDown;
begin
//
end;

procedure TgtPDFViewer.KeyArrowLeft;
begin
//
end;

procedure TgtPDFViewer.KeyArrowRight;
begin
//
end;

procedure TgtPDFViewer.KeyArrowUp;
begin
//
end;

procedure TgtPDFViewer.KeyEnd;
begin
//
end;

procedure TgtPDFViewer.KeyHome;
begin
//
end;

procedure TgtPDFViewer.KeyPageDown;
begin
//
end;

procedure TgtPDFViewer.KeyPageUp;
begin
//
end;

procedure TgtPDFViewer.InternalHighlightRegion(ARegion: TRect;
  APageIndex: TPageIndex; AGotoRegion: Boolean);
var
  LP1, LP2: TPoint;
begin
  FPageManager.FShowSearchRegion := True;
  ClearSelectedRegions;
  with FPageManager.FSearchHighlighter do
  begin
    // Transform region based on zoom and rotation
    // and reverse points (directing mouse events to parent trick)
    ActualBoundsRect := ARegion;
    LP1 := FPageManager.GetTransformedPoint(ARegion.TopLeft, APageIndex);
    LP2 := FPageManager.GetTransformedPoint(ARegion.BottomRight, APageIndex);
    OrderPoints(LP2, LP1);
    BoundsRect := Rect(LP1.X, LP1.Y, LP2.X, LP2.Y);
    PageIndex := APageIndex;
    Parent := FPageManager.GetPageSurfaceOf(APageIndex);
    if Parent <> nil then
    begin
      Visible := True;
      BringToFront;
    end;
  end;
  if AGotoRegion then
    GoToPage(APageIndex, ARegion.Top, ARegion.Left);
end;

procedure TgtPDFViewer.PrintDoc(const AShowPrintDialog: Boolean = True);
var
  LDefaultPrinter: TgtPDFPrinter;
begin
  LDefaultPrinter := TgtPDFPrinter.Create(Self);
  LDefaultPrinter.ShowSetupDialog := AShowPrintDialog;
  try
    LDefaultPrinter.PDFDocument := PDFDocument;
    LDefaultPrinter.Scaling := psFitPage;
    LDefaultPrinter.AutoRotate := False;
    LDefaultPrinter.RotationAngle := RotationAngle;
    LDefaultPrinter.PrintDoc;
  finally
    LDefaultPrinter.Free;
  end;
end;
procedure TgtPDFViewer.RegionMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DoOnRegionMouseActivity(Shift, vmaButtonDown, X, Y,
    TgtRegion(TgtViewerWidget(Sender).AssociatedRgn));
end;

procedure TgtPDFViewer.RegionMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  DoOnRegionMouseActivity(Shift, vmaMoving, X, Y,
    TgtRegion(TgtViewerWidget(Sender).AssociatedRgn));
end;

procedure TgtPDFViewer.RegionMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DoOnRegionMouseActivity(Shift, vmaButtonUp, X, Y,
    TgtRegion(TgtViewerWidget(Sender).AssociatedRgn));
end;

// Set viewer.document to nil and deactivate viewer
procedure TgtPDFViewer.Reset;
begin
  PDFDocument := nil;
end;

procedure TgtPDFViewer.ClearAllRegions;
begin
  FSelectedRegions.Clear;
  FHighlightedRegions.Clear;
end;

function TgtPDFViewer.CreateRegion(ARegionType: TgtRegionClass;
  AWidgetType: TgtHighlightWidgetClass; ARegion: TRect; APageIndex: TPageIndex;
  AHint: string; AHighlightColor: TColor; ARectIsActual: Boolean;
  AInteractive: Boolean; AAssociatedObj: TObject): TgtRegion;
var
  LHighlighter: TgtHighlightWidget;
  LRegion: TgtRegion;
  LP1: TPoint;
  LP2: TPoint;
begin
  LHighlighter := AWidgetType.Create(Self);
  with LHighlighter do
  begin
    Cursor := crHandPoint;
    BrushColor := AHighlightColor;
    Hint := AHint;
    ShowHint := Hint <> '';
    LHighlighter.OnMouseDown := Self.RegionMouseDown;
    LHighlighter.OnMouseMove := Self.RegionMouseMove;
    LHighlighter.OnMouseUp := Self.RegionMouseUp;
    LHighlighter.AssociatedObj := AAssociatedObj;
    if ARectIsActual then
    begin
      ActualBoundsRect := ARegion;
      // Transform region based on zoom and rotation
      LP1 := FPageManager.GetTransformedPoint(ARegion.TopLeft, APageIndex);
      LP2 := FPageManager.GetTransformedPoint(ARegion.BottomRight, APageIndex);
    end
    else
    begin
      // Negate rotation and zoom
      LP1 := GetActualPoint(ARegion.TopLeft, APageIndex);
      LP2 := GetActualPoint(ARegion.BottomRight, APageIndex);
      ActualBoundsRect := Rect(LP1.X, LP1.Y, LP2.X, LP2.Y);
      // Restore to supplied (visually correct) rect
      LP1 := ARegion.TopLeft;
      LP2 := ARegion.BottomRight;
    end;
  // Deliberately set mouse origin to the farther point and mouse dest to nearer,
  // so width and height will always be in the negative.
  // It's a trick to get mouse events directly to parent even if activity takes
  // place on marquee selector. Coordinates are corrected later to p1=(left, top),
  // p2=(right, bottom) when SelectedRegion is requested
    // Make negative height and width so region is transparent to mouse activity
    // ('directing mouse events to parent' trick)
    if not AInteractive then
      OrderPoints(LP2, LP1);
    BoundsRect := Rect(LP1.X, LP1.Y, LP2.X, LP2.Y);
    PageIndex := APageIndex;
    Parent := FPageManager.GetPageSurfaceOf(APageIndex);
    if Parent <> nil then
    begin
      Visible := True;
      BringToFront;
    end;
  end;
  LRegion := ARegionType.Create;
  LRegion.FRegionHighlighter := LHighlighter;
  LHighlighter.AssociatedRgn := LRegion;
  LRegion.FInteractive := AInteractive;
  Result := LRegion;
end;

{ TgtPagePropsList }

function TgtPagePropsList.Get(Index: Integer): TgtPageProperties;
begin
  Result := TgtPageProperties(inherited Get(Index));
end;

{ TgtPageSurface }

constructor TgtPageSurface.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BevelInner := bvNone;
  BevelOuter := bvNone;
  BevelKind := bkNone;
  Ctl3D := False;
  BorderStyle := bsNone;
  FRedraw := True;

  FPageEMF := nil;
  FViewer := TgtPDFViewer(AOwner);
{$IFDEF gtDelphi7Up }
  ParentBackground := False;
{$ENDIF}
  Color := clWhite;
  OnClick := FViewer.PageClick;
  OnMouseDown := FViewer.PageMouseDown;
  OnMouseUp := FViewer.PageMouseUp;
  OnMouseMove := FViewer.PageMouseMove;
  OnMouseWheel := FViewer.PageMouseWheel;
  OnKeyDown := FViewer.PageKeyDown;
  OnKeyUp := FViewer.PageKeyUp;
  OnKeyPress := FViewer.PageKeyPress;
  Cursor := crCross;
end;

destructor TgtPageSurface.Destroy;
var
  I: Integer;
begin
  // Search region
  if FViewer.FPageManager.FSearchHighlighter.Parent = Self then
    FViewer.FPageManager.FSearchHighlighter.Parent := nil;

  // Un parent all selected regions so they don't get freed
  for I := 0 to FViewer.FSelectedRegions.Count - 1 do
    if FViewer.FSelectedRegions[I].RegionHighlighter.Parent = Self then
      FViewer.FSelectedRegions[I].RegionHighlighter.Parent := nil;

  // Un parent all highlighted regions so they don't get freed
  for I := 0 to FViewer.FHighlightedRegions.Count - 1 do
    if FViewer.FHighlightedRegions[I].FRegionHighlighter.Parent = Self then
      FViewer.FHighlightedRegions[I].FRegionHighlighter.Parent := nil;

  if Assigned(FPageEMF) then FPageEMF.Free;

  if FBitmap <> 0 then
    DeleteObject(FBitmap);
  if FSavedDC <> 0 then
    DeleteDC(FSavedDC);

  inherited;
end;

procedure TgtPageSurface.Paint;
begin
  inherited;
  RenderPage(Canvas.Handle, GetClientRect);
end;

type
  THackDoc = class(TgtExProPDFDocument)
  end;

procedure TgtPageSurface.RenderPage(DC: HDC; Rect: TRect);
var
  LOldBitmap: HBITMAP;
  LSize: TSize;
  LRotationAngle: Integer;
  LPageSize: TgtPageSize;
begin
  if not Assigned(FPageEMF) then
  begin
    FPageEMF := TMemoryStream.Create;
    try
      LPageSize := THackDoc(FViewer.PDFDocument).GetPageSize(FConnectedPage, muPixels);
      THackDoc(FViewer.PDFDocument).RenderToStream(FPageEMF, FConnectedPage,
        LPageSize.Width, LPageSize.Height, Screen.PixelsPerInch, Screen.PixelsPerInch, 0, True, False);
    except

    end;
  end;

  if RotationAngle in [ra0, raCW90, raCW180, raCW270] then
    LRotationAngle := 90 * Ord(RotationAngle)
  else
    LRotationAngle := -90 * (Ord(RotationAngle) - 3);

  FPageEMF.Position := 0;
  LOldBitmap := 0;

  if FRedraw then
  begin
    if FBitmap <> 0 then
      DeleteObject(FBitmap);
    if FSavedDC <> 0 then
      DeleteDC(FSavedDC);

    FBitmap := 0;
    FSavedDC := 0;

    FRedraw := False;
    FSavedDC := CreateCompatibleDC(DC);
    FBitmap := CreateCompatibleBitmap(DC, Rect.Right - Rect.Left,
      Rect.Bottom - Rect.Top);
    if FBitmap <> 0 then
    begin
      LOldBitmap := SelectObject(FSavedDC, FBitmap);
      SetMapMode(FSavedDC, GetMapMode(DC));

      GetWindowExtEx(DC, LSize);
      SetWindowExtEx(FSavedDC, LSize.cx, LSize.cy, nil);

      GetViewportExtEx(DC, LSize);
      SetViewportExtEx(FSavedDC, LSize.cx, LSize.cy, nil);

      SetWindowOrgEx(FSavedDC, Rect.Left, Rect.Top, nil);

      THackDoc(FViewer.PDFDocument).RenderImageToCanvas(FSavedDC,
        FPageEMF, Width, Height, LRotationAngle);
    end;
  end
  else
  begin
    if FBitmap <> 0 then
      LOldBitmap := SelectObject(FSavedDC, FBitmap);
  end;

  if FBitmap <> 0 then
  begin
    BitBlt(DC, Rect.Left, Rect.Top, Rect.Right - Rect.Left,
      Rect.Bottom - Rect.Top, FSavedDC, Rect.Left, Rect.Top, SRCCOPY);
    FBitmap := SelectObject(FSavedDC, LOldBitmap);
  end
  else
  begin
    THackDoc(FViewer.PDFDocument).RenderImageToCanvas(Canvas.Handle,
      FPageEMF, Width, Height, LRotationAngle);
  end;
end;

procedure TgtPageSurface.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if (ALeft <> Left) or (ATop <> Top) or (AWidth <> Width) or
    (AHeight <> Height) then
    FRedraw := True;
  inherited;
end;

procedure TgtPageSurface.SetRotationAngle(const Value: TgtRotationAngle);
begin
  if FRotationAngle <> Value then
    FRedraw := True;
  FRotationAngle := Value;
end;

procedure TgtPageSurface.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin

end;

{ TgtPageSurfList }

function TgtPageSurfList.Get(Index: Integer): TgtPageSurface;
begin
  Result := TgtPageSurface(inherited Get(Index));
end;

{ TgtPageManager }

constructor TgtPageManager.Create(AOwner: TgtPDFViewer);
begin
  FCurrentPageIndex := 1;
  FViewer := AOwner;
  FVisiblePages := TgtPageSurfList.Create;
  FPageProps := TgtPagePropsList.Create;
  FSearchHighlighter := TgtHighlightWidget.Create(AOwner);
  FSearchHighlighter.Visible := False;
  FShowSearchRegion := False;
  FRotationAngle := ra0;
  FZoom := 100;
  FZoomType := sztFitWidth;
end;

destructor TgtPageManager.Destroy;
begin
  DestroyPages;
  ClearPageProps;
  FVisiblePages.Free;
  FPageProps.Free;
  FSearchHighlighter.Free;
  inherited;
end;

function TgtPageManager.CreatePage(AConnectedPage: TPageIndex): TgtPageSurface;
var
  LPage: TgtPageSurface;
begin
  LPage := TgtPageSurface.Create(FViewer);
  with LPage do
  begin
    ConnectedPage := AConnectedPage;
    SetPageBounds(LPage);
    Parent := FViewer;
  end;
//  UpdateWidgets(LPage);
  Result := LPage;
end;

function TgtPageManager.GetPageIndexFromScrollPos(AScrollPos: Integer): TPageIndex;
var
  LPageNumber: Integer;
  LCurPageVisibleHt, LSpaceforNxtPage: Integer;
begin
  for LPageNumber := 1 to FViewer.PDFDocument.PageCount do
    if ((FPageProps[LPageNumber - 1].Top + FPageProps[LPageNumber - 1].Height) > AScrollPos) then
      Break;
  LPageNumber := Max(1, LPageNumber);
  LPageNumber := Min(LPageNumber, FViewer.PDFDocument.PageCount);

  LCurPageVisibleHt := Round(FPageProps[LPageNumber - 1].Top +
    FPageProps[LPageNumber - 1].Height - AScrollPos);
  LSpaceforNxtPage := FViewer.ClientHeight - LCurPageVisibleHt - FViewer.BorderWidth;

  // If top of *this* page is visible, then *this* is the current page, so check for other cases where top is above viewable area
  if FPageProps[LPageNumber - 1].Top < AScrollPos then
    // Is more of next page visible than current page if current page not last? Then next page is current
    if (LPageNumber < FViewer.PDFDocument.PageCount) then
      if LCurPageVisibleHt < LSpaceforNxtPage then
        Inc(LPageNumber);
  Result := LPageNumber;
end;

function TgtPageManager.GetPageSurfaceOf(
  APageIndex: TPageIndex): TgtPageSurface;
begin
  Result := nil;
  if InRange(APageIndex, FFirstPageIndex, FLastPageIndex) then
    Result := FVisiblePages[APageIndex - FFirstPageIndex];
end;

function TgtPageManager.GetScrollPosFromPageIndex(APageIndex: TPageIndex): Integer;
begin
  Result := Round(FPageProps[APageIndex - 1].Top - FViewer.BorderWidth);
end;

function TgtPageManager.GetStandardZoomValue(AZoomType: TgtStdZoomType): Double;
var
  LViewableWidth: Integer;
  LViewableHeight: Integer;
  LSizeFactor: Double;
begin
  Result := Zoom;
  if FViewer.IsAllReadyToView then
    case AZoomType of
      sztActualSize: Result := 100;
      sztFitPage, sztFitWidth:
        begin
          LSizeFactor := 1 / cDEFAULT_RES_DPI
            * FViewer.DisplaySettings.ResDPIEffective;
          LViewableWidth := FViewer.ClientWidth - FViewer.BorderWidth * 2;
          LViewableHeight := FViewer.ClientHeight - FViewer.BorderWidth * 2;
          if RotationAngle in [raCW90, raCW270, raACW90, raACW270] then
            Result := LViewableWidth / (FActualMaxPageHeight * LSizeFactor) * 100
          else
            Result := LViewableWidth / (FActualMaxPageWidth * LSizeFactor) * 100;
          if AZoomType = sztFitPage then
            if RotationAngle in [raCW90, raCW270, raACW90, raACW270] then
              Result := Min(Result, LViewableHeight / (FActualMaxPageWidth
                * LSizeFactor) * 100)
            else
              Result := Min(Result, LViewableHeight / (FActualMaxPageHeight
                * LSizeFactor) * 100);
        end;
    end;
end;

// Return given points after applying current rotation and zoom
function TgtPageManager.GetTransformedPoint(const APoint: TPoint;
  AConnectedPage: TPageIndex): TPoint;
var
  LPoint: TPoint;
  LWidth, LHeight: Integer;
begin
  LPoint := APoint;
  LWidth := Round(FPageProps[AConnectedPage - 1].FActualWidth);
  LHeight := Round(FPageProps[AConnectedPage - 1].FActualHeight);

  // Account for rotation
  case RotationAngle of
    raCW90, raACW270:             // Rotated right -->
    begin
      SwapAB(LPoint.X, LPoint.Y);
      LPoint.X := LHeight - LPoint.X;
    end;
    raCW270, raACW90:             // Rotated left <--
    begin
      SwapAB(LPoint.X, LPoint.Y);
      LPoint.Y := LWidth - LPoint.Y;
    end;
    raCW180, raACW180:            // upside-down
    begin
      LPoint.X := LWidth - LPoint.X;
      LPoint.Y := LHeight - LPoint.Y;
    end;
    ra0: ;                        // Normal postion ^ - so no correction required
  end;

  // Account for Zoom and DPI
  LPoint.X := Round(LPoint.X / 100 * Zoom / Screen.PixelsPerInch *
    FViewer.DisplaySettings.ResDPIEffective);
  LPoint.Y := Round(LPoint.Y / 100 * Zoom / Screen.PixelsPerInch *
    FViewer.DisplaySettings.ResDPIEffective);
  Result := LPoint;
end;

function TgtPageManager.GetHScrollRange: Integer;
begin
  Result := Round(FMaxPageWidth) + FViewer.BorderWidth * 2
end;

function TgtPageManager.GetVScrollRange: Integer;
begin
  Result := Round(FPageProps[FPageProps.Count - 1].Top +
    FPageProps[FPageProps.Count - 1].Height) + FViewer.BorderWidth;
end;

function TgtPageManager.UpdateViewer(AScrollPos,
  ACachePageCount: Integer): Boolean;

  function CalcLastVisiblePageIndex(ACurPageIndex: TPageIndex): Integer;
  var
    LAvailHeight: Integer;
    LPageIndex: TPageIndex;
    LHeight: Double;
  begin
    LPageIndex := ACurPageIndex;
    LAvailHeight := FViewer.ClientHeight;
    LHeight := AScrollPos;
    if (LPageIndex < FViewer.PDFDocument.PageCount) then
    begin
      if (FPageProps[LPageIndex - 1].Top >= AScrollPos) then
        LHeight := FPageProps[LPageIndex - 1].Top - AScrollPos
      else
      begin
        LHeight := FPageProps[LPageIndex].Top - AScrollPos;
        Inc(LPageIndex);
      end;
    end;
    while (LPageIndex <= FViewer.PDFDocument.PageCount) do
    begin
      LHeight := LHeight + FPageProps[LPageIndex - 1].Height + FViewer.BorderWidth;
      if LHeight > LAvailHeight then
        Break;
      Inc(LPageIndex);
    end;
    Result := Min(FViewer.PDFDocument.PageCount, LPageIndex + ACachePageCount);
  end;

begin
  Result := FViewer.IsAllReadyToView;
  if Result then
  begin
    FFirstPageIndex := Max(1, CurrentPageIndex - 1 - ACachePageCount);
    FLastPageIndex := CalcLastVisiblePageIndex(CurrentPageIndex);
    UpdateVisiblePages;
    if FViewer.VertScrollBar.Position <> AScrollPos then
      FViewer.VertScrollBar.Position := AScrollPos;
  end;
end;

procedure TgtPageManager.Activate;
var
  LOldZoom: Double;
begin
  DestroyPages;
  ReadPageProps;
  FCurrentPageIndex := ValidatePageIndex(FCurrentPageIndex);

  FSizingLocked := True;
  try
    SetVScrollRange(GetVScrollRange);
    SetHScrollRange(GetHScrollRange);
    FViewer.VertScrollBar.Position := GetScrollPosFromPageIndex(CurrentPageIndex);
    LOldZoom := FZoom;
    if not (ZoomType in [sztCustom, sztActualSize]) then
      ZoomType := ZoomType; // force recalc zoom, rest will be taken care when zoom changes
    // if zoom didn't change, show pages and force events so applications can
    // initialize values, update controls
    if LOldZoom = FZoom then
    begin
      UpdateViewer(GetScrollPosFromPageIndex(CurrentPageIndex), 0);
      FViewer.DoOnZoomChange;
    end;
    FViewer.DoOnPageChange;
  finally
    FSizingLocked := False;
  end;
end;

procedure TgtPageManager.Deactivate;
begin
  DestroyPages;
  SetHScrollRange(0);
  SetVScrollRange(0);
end;

procedure TgtPageManager.ClearPageProps;
var
  I: Integer;
begin
  for I := 0 to FPageProps.Count - 1 do
    FPageProps.Items[I].Free;
  FPageProps.Clear;
end;

procedure TgtPageManager.DeletePage(AListIndex: Integer);
begin
  if ((AListIndex >= 0) and (AListIndex < FVisiblePages.Count)) then
  begin
    FVisiblePages[AListIndex].Free;
    FVisiblePages.Delete(AListIndex);
  end;
end;

procedure TgtPageManager.DestroyPages;
var
  I: Integer;
begin
  FShowSearchRegion := False;
  for I := 0 to FVisiblePages.Count - 1 do
    FVisiblePages[I].Free;
  FVisiblePages.Clear;
end;

// Get width, height and starting point of each page and greatest width, height
// Necessary for setting Scroll ranges and instantly knowing a page's position in viewer
procedure TgtPageManager.ReadPageProps;
var
  I: Integer;
  LTop: Integer;
  LPageProp: TgtPageProperties;
  LPageSize: TgtPageSize;
  LSizeFactor: Double;
begin
  ClearPageProps;
  LTop := FViewer.BorderWidth;
  FMaxPageWidth := 0;
  FMaxPageHeight := 0;
  FActualMaxPageWidth := 0;
  FActualMaxPageHeight := 0;
  // Calc factor once for Current DPI and Zoom
  LSizeFactor := 1 / cDEFAULT_RES_DPI *
    FViewer.DisplaySettings.ResDPIEffective / 100 * Zoom;
  // Use separate loop to avoid checking within the loop
  if RotationAngle in [raCW90, raCW270, raACW90, raACW270] then
  begin
    with FViewer.PDFDocument do
    begin
      for I := 1 to PageCount do
      begin
        LPageSize := GetPageSize(I, muInches);

        LPageProp := TgtPageProperties.Create;
        // Store physical size for later recalculations for zooming...
        LPageProp.FActualWidth := LPageSize.Width * cDEFAULT_RES_DPI;
        LPageProp.FActualHeight := LPageSize.Height * cDEFAULT_RES_DPI;

        // Apply zoom to display size
        // Page is rotated so width and height need to be interchanged
        LPageProp.Width := LPageProp.FActualHeight * LSizeFactor;
        LPageProp.Height := LPageProp.FActualWidth * LSizeFactor;
        LPageProp.Top := LTop;

        FMaxPageWidth := Max(LPageProp.Width, FMaxPageWidth);
        FMaxPageHeight := Max(LPageProp.Height, FMaxPageHeight);
        FActualMaxPageWidth := Max(LPageProp.FActualWidth, FActualMaxPageWidth);
        FActualMaxPageHeight := Max(LPageProp.FActualHeight, FActualMaxPageHeight);

        LTop := LTop + Round(LPageProp.Height) + FViewer.BorderWidth;

        FPageProps.Add(LPageProp);
      end;
    end;
  end
  else
  begin
    with FViewer.PDFDocument do
    begin
      for I := 1 to PageCount do
      begin
        LPageSize := GetPageSize(I, muInches);

        LPageProp := TgtPageProperties.Create;
        // Store physical size for later recalculations for zooming...
        LPageProp.FActualWidth := LPageSize.Width * cDEFAULT_RES_DPI;
        LPageProp.FActualHeight := LPageSize.Height * cDEFAULT_RES_DPI;

        // Apply zoom to display size
        LPageProp.Width := LPageProp.FActualWidth * LSizeFactor;
        LPageProp.Height := LPageProp.FActualHeight * LSizeFactor;
        LPageProp.Top := LTop;

        FMaxPageWidth := Max(LPageProp.Width, FMaxPageWidth);
        FMaxPageHeight := Max(LPageProp.Height, FMaxPageHeight);
        FActualMaxPageWidth := Max(LPageProp.FActualWidth, FActualMaxPageWidth);
        FActualMaxPageHeight := Max(LPageProp.FActualHeight, FActualMaxPageHeight);

        LTop := LTop + Round(LPageProp.Height) + FViewer.BorderWidth;

        FPageProps.Add(LPageProp);
      end;
    end;
  end;
end;

procedure TgtPageManager.ReCalcPageProps;
var
  I: Integer;
  LTop: Integer;
  LSizeFactor: Double;
begin
  LTop := FViewer.BorderWidth;
  FMaxPageWidth := 0;
  FMaxPageHeight := 0;
  // Calc factor once for Current DPI and Zoom
  LSizeFactor := 1 / cDEFAULT_RES_DPI *
    FViewer.DisplaySettings.ResDPIEffective / 100 * Zoom;
  // Use separate loop to avoid checking within the loop
  if RotationAngle in [raCW90, raCW270, raACW90, raACW270] then
    for I := 0 to FPageProps.Count - 1 do
      with FPageProps.Items[I] do
      begin
        // Apply zoom to display size
        // Page is rotated so width and height need to be interchanged
        Height := FActualWidth * LSizeFactor;
        Width := FActualHeight * LSizeFactor;
        Top := LTop;

        FMaxPageWidth := Max(Width, FMaxPageWidth);
        FMaxPageHeight := Max(Height, FMaxPageHeight);

        LTop := LTop + Round(Height) + FViewer.BorderWidth;
        Application.ProcessMessages;
      end
  else
    for I := 0 to FPageProps.Count - 1 do
      with FPageProps.Items[I] do
      begin
        // Apply zoom to display size
        Width := FActualWidth * LSizeFactor;
        Height := FActualHeight * LSizeFactor;
        Top := LTop;

        FMaxPageWidth := Max(Width, FMaxPageWidth);
        FMaxPageHeight := Max(Height, FMaxPageHeight);

        LTop := LTop + Round(Height) + FViewer.BorderWidth;
        Application.ProcessMessages;
      end;
end;

function TgtPageManager.GoToPage(APageIndex: TPageIndex;
  ATop: Integer; ALeft: Integer): TPageIndex;
var
  LTemp: TPageIndex;
  LScrollPos: Integer;
  LPoint: TPoint;
begin
  if not FViewer.IsAllReadyToView then
  begin
    FCurrentPageIndex := APageIndex; // page index set before viewer was active. just store it and use later
    Result := FCurrentPageIndex;
    Exit;
  end;
  LTemp := ValidatePageIndex(APageIndex);
  // when zoom is very low or pages are small, we may not exactly be able to
  // position last page at the top of the viewing area. The bottom of the last page
  // should never be above the viewable area (minus borderwidth)
  // (except when zoom is so low and all pages fit within a single view).
  // So even if last page is requested, get to know the last Vscroll point and
  // get page number for that pos
  LScrollPos := GetScrollPosFromPageIndex(LTemp);

  // Is positioning page at specific x/y requested? Then advance scroll pos by that much
  if (ATop <> 0) or (ALeft <> 0) then
  begin
    // Account for Zoom and rotation
    LPoint := GetTransformedPoint(Point(ALeft, ATop),
      APageIndex);
    Inc(LScrollPos, LPoint.Y - FViewer.BorderWidth);
  end;
  FViewer.VertScrollBar.Position := LScrollPos;
  ScrollViewer(FViewer.VertScrollBar.Position);
  FViewer.HorzScrollBar.Position := LPoint.X - FViewer.BorderWidth;
  Result := CurrentPageIndex;
end;

procedure TgtPageManager.ScrollViewer(AScrollPos: Integer; APageCacheCount: Integer);
var
  LTempPage: Integer;
begin
  if not FViewer.IsAllReadyToView then
    Exit;
  LTempPage := GetPageIndexFromScrollPos(AScrollPos);
  if FCurrentPageIndex <> LTempPage then
  begin
    FCurrentPageIndex := LTempPage;
    FViewer.DoOnPageChange;
  end;
  UpdateViewer(AScrollPos, APageCacheCount);
end;

procedure TgtPageManager.UpdateWidgets(APage: TgtPageSurface);
var
  I: Integer;
//  J: Integer;
begin
  if FShowSearchRegion and (FSearchHighlighter.PageIndex = APage.ConnectedPage) then
    ResetWidgetBounds(FSearchHighlighter, APage);

  // Selected Regions
  for I := 0 to FViewer.FSelectedRegions.Count - 1 do
    if FViewer.FSelectedRegions[I].PageIndex = APage.ConnectedPage then
      ResetWidgetBounds(FViewer.FSelectedRegions[I].FRegionHighlighter, APage,
        FViewer.FSelectedRegions[I].Interactive);

  // Highlighted Regions
  for I := 0 to FViewer.FHighlightedRegions.Count - 1 do
    if FViewer.FHighlightedRegions[I].PageIndex = APage.ConnectedPage then
      ResetWidgetBounds(FViewer.FHighlightedRegions[I].FRegionHighlighter, APage,
        FViewer.FHighlightedRegions[I].Interactive);

end;

procedure TgtPageManager.RefreshView;
var
  LOldPos: Integer;
begin
  if not FViewer.IsAllReadyToView then
    Exit;

  if ZoomType in [sztCustom, sztActualSize] then
  begin
    FSizingLocked := True;
    try
      // What is the page position relative to scroll pos?
      LOldPos := GetScrollPosFromPageIndex(FCurrentPageIndex) - FViewer.VertScrollBar.Position;
      ReCalcPageProps;
      SetVScrollRange(GetVScrollRange);
      SetHScrollRange(GetHScrollRange);
      // Maintain pos after rotate
      FViewer.VertScrollBar.Position := GetScrollPosFromPageIndex(FCurrentPageIndex) - LOldPos;
      ScrollViewer(FViewer.VertScrollBar.Position);
    finally
      FSizingLocked := False;
    end;
  end
  else // auto zoom types set, so need to recalc zoom for rotation
    ZoomType := ZoomType; // force recalc zoom, which will take care of updating viewer
end;

procedure TgtPageManager.ResetWidgetBounds(AWidget: TgtViewerWidget;
  APageSurf: TgtPageSurface; AInteractive: Boolean);
var
  LP1, LP2: TPoint;
begin
  with AWidget do
  begin
    Parent := nil;
    // Transform actual bounds based on zoom and rotation
    // and reverse points (directing mouse events to parent trick)
    LP1 := GetTransformedPoint(ActualBoundsRect.TopLeft, PageIndex);
    LP2 := GetTransformedPoint(ActualBoundsRect.BottomRight, PageIndex);
    if not AInteractive then
      FViewer.OrderPoints(LP2, LP1);
    BoundsRect := Rect(LP1.X, LP1.Y, LP2.X, LP2.Y);
    Parent := APageSurf;
    Visible := True;
    BringToFront;
  end;
end;

function TgtPageManager.ValidatePageIndex(APageIndex: TPageIndex): TPageIndex;
begin
  // Can't be < 1 and > pagecount
  Result := Min(APageIndex, FViewer.PDFDocument.PageCount);
  Result := Max(1, Result);
end;

procedure TgtPageManager.SetCurrentPageIndex(const Value: TPageIndex);
begin
  GoToPage(Value);
end;

procedure TgtPageManager.SetPageBounds(APage: TgtPageSurface);
var
  LTop: Integer;
  LHeight: Integer;
  LWidth: Integer;
  LLeft: Integer;
begin
  with APage do
  begin
    LWidth := Round(FPageProps[ConnectedPage - 1].Width);
    LHeight := Round(FPageProps[ConnectedPage - 1].Height);
    // Note: if scroll window has scrolled,
    // top & left are relative to that position so add position
    LTop := Round(FPageProps[ConnectedPage - 1].Top) -
      FViewer.VertScrollBar.Position;
    LLeft := (Max(FViewer.ClientWidth,
      Round(FMaxPageWidth) + FViewer.BorderWidth * 2) - LWidth) div
      2 - FViewer.HorzScrollBar.Position;
    APage.RotationAngle := Self.RotationAngle;
    if not RectsEqual(BoundsRect,
        Rect(LLeft, LTop, LWidth + LLeft, LHeight + LTop)) then
      SetBounds(LLeft, LTop, LWidth, LHeight);
    UpdateWidgets(APage);
  end;
end;

procedure TgtPageManager.SetRotationAngle(const Value: TgtRotationAngle);
begin
  if FRotationAngle <> Value then
  begin
    FRotationAngle := Value;
    RefreshView;
  end;
end;

procedure TgtPageManager.SetHScrollRange(ARange: Integer);
begin
  FViewer.HorzScrollBar.Range := ARange;
end;

procedure TgtPageManager.SetVScrollRange(ARange: Integer);
begin
  FViewer.VertScrollBar.Range := ARange;
end;

procedure TgtPageManager.SetZoom(const Value: Double);

  function GetMaxPossibleZoom(const AOldZoom, ANewZoom: Double): Double;
var
    LTemp: Double;
  begin
    Result := ANewZoom;
    // Check if greater side of largest page will exceed limits based on new zoom
    LTemp := Max(FMaxPageHeight, FMaxPageWidth);
    LTemp := LTemp / AOldZoom * ANewZoom;
    // if so then get max zoom value for largest page, which is within limit
    // by getting original size and calculating how many times it can grow upto the limit
    if LTemp > MAXSHORT then
      Result := MAXSHORT / (LTemp / ANewZoom * 100) * 100;
  end;

var
  LOldVPos, LOldHPos: Integer;
  LOldZoom: Double;
  LP1: TPoint;
begin
  if not FZoomTypeLocked then
    FZoomType := sztCustom;
  if FZoom <> Value then
  begin
    FSizingLocked := True;
    try
      LOldZoom := FZoom;
      FZoom := Max(cZOOM_RANGE_MIN, Value);
      FZoom := Min(cZOOM_RANGE_MAX, FZoom);
      FZoom := SimpleRoundTo(FZoom);
      if not FViewer.IsAllReadyToView then
        Exit;

      // What is the page position relative to vscroll pos and hrange to hscroll pos?
      LOldVPos := GetScrollPosFromPageIndex(FCurrentPageIndex) -
        FViewer.VertScrollBar.Position;
      LOldHPos := Round(FViewer.HorzScrollBar.Position /
        FViewer.HorzScrollBar.Range * 100);

      // Reset zoom to max that system resources will allow (Zoom, page size)
      if FZoom > LOldZoom then
        FZoom := GetMaxPossibleZoom(LOldZoom, FZoom);
      FZoom := SimpleRoundTo(FZoom);

      ReCalcPageProps;
      SetVScrollRange(GetVScrollRange);
      SetHScrollRange(GetHScrollRange);
      { Intelligent page positioning in view after zoom.
        Bring search region or selected region in view, depending on which
        one is shown. If none is shown (default), bring the region of page that was most
        visible before zoom, back in view. Do this by maintaining same
        difference of new page pos to scroll pos.}
      if FShowSearchRegion then
        LP1 := GetTransformedPoint(FSearchHighlighter.ActualBoundsRect.TopLeft,
          FCurrentPageIndex)
//      else if FShowSelectedRegion then
//        LP1 := GetTransformedPoint(FMarqueeSelector.ActualBoundsRect.TopLeft,
//          FCurrentPageIndex)
      else
        LP1 := Point(Round(FViewer.HorzScrollBar.Range / 100 * LOldHPos),
          -LOldVPos);

      FViewer.VertScrollBar.Position :=
        GetScrollPosFromPageIndex(FCurrentPageIndex) + LP1.Y - FViewer.BorderWidth;
      FViewer.HorzScrollBar.Position := LP1.X;
      ScrollViewer(FViewer.VertScrollBar.Position);
      FViewer.DoOnZoomChange;
    finally
      FSizingLocked := False;
    end;
  end;
end;

procedure TgtPageManager.SetZoomType(const Value: TgtStdZoomType);
begin
  FZoomType := Value;
  if not FViewer.IsAllReadyToView then
    Exit;
  FZoomTypeLocked := True;
  try
    Zoom := GetStandardZoomValue(FZoomType);
  finally
    FZoomTypeLocked := False;
  end;
end;

procedure TgtPageManager.UpdateVisiblePages;
var
  LI: Integer;
begin
  with FVisiblePages do
  begin
    // delete un-needed pages at top
    while ((Count > 0) and (Items[0].ConnectedPage < FFirstPageIndex)) do
      DeletePage(0);
    // delete un-needed pages at bottom
    while ((Count > 0) and (Items[Count - 1].ConnectedPage > FLastPageIndex)) do
      DeletePage(Count - 1);

    //no items, add all
    if (Count = 0) then
    begin
      for LI := FFirstPageIndex to FLastPageIndex do
        Add(CreatePage(LI));
    end
    else
    begin
      // add needed pages at top
      LI := Items[0].ConnectedPage;
      while (LI > FFirstPageIndex) do
      begin
        Dec(LI);
        Insert(0, CreatePage(LI));
      end;
      // add needed pages at bottom
      LI := Items[Count - 1].ConnectedPage;
      while (LI < FLastPageIndex) do
      begin
        Inc(LI);
        Add(CreatePage(LI));
      end;
    end;
    // show the pages and update page sizes and centering (in case zoom changed)
    if (Count > 0) then
    begin
      for LI := 0 to Count - 1 do
      begin
        SetPageBounds(Items[LI]);
      end;
    end;
  end;
end;

{ TgtRegion }

destructor TgtRegion.Destroy;
begin
  FRegionHighlighter.Free;
  inherited;
end;

function TgtRegion.GetAssociatedObj: TObject;
begin
  Result := FRegionHighlighter.AssociatedObj;
end;

function TgtRegion.GetHighlightColor: TColor;
begin
  Result := FRegionHighlighter.BrushColor;
end;

function TgtRegion.GetHint: string;
begin
  Result := FRegionHighlighter.Hint;
end;

function TgtRegion.GetPageIndex: TPageIndex;
begin
  Result := FRegionHighlighter.PageIndex;
end;

function TgtRegion.GetRegion: TRect;
begin
  Result := FRegionHighlighter.ActualBoundsRect;
end;

{ TgtSelectedRegionList }

function TgtSelectedRegionList.Get(Index: Integer): TgtSelectedRegion;
begin
  Result := TgtSelectedRegion(inherited Get(Index));
end;

procedure TgtSelectedRegionList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  inherited;
  if Action in [lnExtracted, lnDeleted] then
    TgtSelectedRegion(Ptr).Free;
end;

{ TgtHighlightedRegionList }

function TgtHighlightedRegionList.Get(Index: Integer): TgtHighlightedRegion;
begin
  Result := TgtHighlightedRegion(inherited Get(Index));
end;

procedure TgtHighlightedRegionList.Notify(Ptr: Pointer;
  Action: TListNotification);
begin
  inherited;
  if Action in [lnExtracted, lnDeleted] then
    TgtHighlightedRegion(Ptr).Free;
end;

{ TgtHighlightedKeywordsList }

function TgtHighlightedKeywordsList.Get(Index: Integer): TgtHighlightedKeyword;
begin
  Result := TgtHighlightedKeyword(inherited Get(Index));
end;

procedure TgtHighlightedKeywordsList.Notify(Ptr: Pointer;
  Action: TListNotification);
begin
  inherited;
  if Action in [lnExtracted, lnDeleted] then
    TgtHighlightedKeyword(Ptr).Free;
end;

{ TgtHighlightedKeyword }

constructor TgtHighlightedKeyword.Create;
begin
  FPageHighlightRegions := TgtPageRegionsList.Create;
end;

destructor TgtHighlightedKeyword.Destroy;
begin
  FPageHighlightRegions.Free;
  inherited;
end;

{ TgtSelectedRegion }

function TgtSelectedRegion.GetEndPoint: TPoint;
begin
  Result := FRegionHighlighter.ActualBoundsRect.BottomRight;
end;

function TgtSelectedRegion.GetHeight: Integer;
begin
  Result := FRegionHighlighter.ActualBoundsRect.Top -
    FRegionHighlighter.ActualBoundsRect.Bottom;
end;

function TgtSelectedRegion.GetRegionHighlighter: TgtRegionSelectionWidget;
begin
  Result := TgtRegionSelectionWidget(FRegionHighlighter);
end;

function TgtSelectedRegion.GetRegionType: TgtSelectionType;
begin
  Result := RegionHighlighter.SelectionType;
end;

function TgtSelectedRegion.GetStartPoint: TPoint;
begin
  Result := FRegionHighlighter.ActualBoundsRect.TopLeft;
end;

function TgtSelectedRegion.GetWidth: Integer;
begin
  Result := FRegionHighlighter.ActualBoundsRect.Right -
    FRegionHighlighter.ActualBoundsRect.Left
end;

procedure TgtSelectedRegion.SetRegionType(const Value: TgtSelectionType);
begin
  RegionHighlighter.SelectionType := Value;
end;

{ TgtPageRegionsList }

constructor TgtPageRegionsList.Create;
begin
  FPagesIDs := TList.Create;
  FPageHighlightRegions := TList.Create;
end;

destructor TgtPageRegionsList.Destroy;
begin
  FPagesIDs.Free;
  FPageHighlightRegions.Free;
  inherited;
end;

{ TgtDisplaySettings }

procedure TgtDisplaySettings.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TgtDisplaySettings.Create;
begin
  FResDPISource := rsUseCustom;
  FResDPICustom := cDEFAULT_RES_DPI;
end;

function TgtDisplaySettings.GetResDPIEffective: TResDPI;
begin
  Result := FResDPICustom;
  if FResDPISource = rsUseSystem then
    Result := Screen.PixelsPerInch;
  if Result < Low(TResDPI) then
    Result := Low(TResDPI);
end;

procedure TgtDisplaySettings.SetResDPICustom(const Value: TResDPI);
begin
  if FResDPICustom <> Value then
  begin
    FResDPICustom := Value;
    Changed;
  end;
end;

procedure TgtDisplaySettings.SetResDPISource(const Value: TgtResDPISource);
begin
  if FResDPISource <> Value then
  begin
    FResDPISource := Value;
    Changed;
  end;
end;

end.

