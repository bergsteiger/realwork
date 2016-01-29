{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit WBComp;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Controls, Vcl.Graphics, Vcl.OleCtrls,
  Winapi.ActiveX, SHDocVw, MSHTML, mshtmcid, idoc, System.Contnrs, System.Variants,
  System.Win.ComObj, WebBrowserEx, System.Win.ComObjWrapper, System.WideStrings;

type

{ TCustomHTMLEditDesigner }

  // IHTMLEditDesigner Interface
  // http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/mshtml/reference/ifaces/editdesigner/ihtmleditdesigner.asp

  TCustomHTMLEditDesigner = class;

  TEditDesignerEvent = procedure(Sender: TCustomHTMLEditDesigner; EventDispID: TDispID; const Event: IHTMLEventObj; var Result: HRESULT) of object;

  THTMLEditDesignerImpl = class(TInterfacedObject, IHTMLEditDesigner)
  private
    FComponentIntf: IHTMLEditDesigner;
    FComponent: TCustomHTMLEditDesigner;
    { IHTMLEditDesigner }
    function PostEditorEventNotify(inEvtDispId: Integer;
      const pIEventObj: IHTMLEventObj): HRESULT; stdcall;
    function PostHandleEvent(inEvtDispId: Integer;
      const pIEventObj: IHTMLEventObj): HRESULT; stdcall;
    function PreHandleEvent(inEvtDispId: Integer;
      const pIEventObj: IHTMLEventObj): HRESULT; stdcall;
    function TranslateAccelerator(inEvtDispId: Integer;
      const pIEventObj: IHTMLEventObj): HRESULT; stdcall;
    procedure DisconnectComponent;
  public
    constructor Create(AComponent: TCustomHTMLEditDesigner);
    destructor Destroy; override;
  end;

  TCustomHTMLEditDesigner = class(TCustomWebBrowserComponent, IHTMLEditDesigner)
  private
    FOnPostEditor: TEditDesignerEvent;
    FOnPostHandle: TEditDesignerEvent;
    FOnPreHandle: TEditDesignerEvent;
    FOnTranslateAccel: TEditDesignerEvent;
    FActive: Boolean;
    FDesignerImpl: THTMLEditDesignerImpl;
  protected
    function IsPrimaryDocumentEvent(EventObj: IHTMLEventObj): Boolean;
    function IsPrimaryDocumentElement(AElement: IHTMLElement): Boolean;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetWebBrowser(const Value: TWebBrowserEx); override;
    { IHTMLEditDesigner }
    function PostEditorEventNotify(inEvtDispId: Integer;
      const pIEventObj: IHTMLEventObj): HRESULT; stdcall;
    function PostHandleEvent(inEvtDispId: Integer;
      const pIEventObj: IHTMLEventObj): HRESULT; stdcall;
    function PreHandleEvent(inEvtDispId: Integer;
      const pIEventObj: IHTMLEventObj): HRESULT; stdcall;
    function TranslateAccelerator(inEvtDispId: Integer;
      const pIEventObj: IHTMLEventObj): HRESULT; stdcall;

    procedure SetActive(const Value: Boolean); virtual;
  public
    property Active: Boolean read FActive write SetActive;
    property OnPostEditor: TEditDesignerEvent read FOnPostEditor write FOnPostEditor;
    property OnPostHandle: TEditDesignerEvent read FOnPostHandle write FOnPostHandle;
    property OnPreHandle: TEditDesignerEvent read FOnPreHandle write FOnPreHandle;
    property OnTranslateAccel: TEditDesignerEvent read FOnTranslateAccel
      write FOnTranslateAccel;
    destructor Destroy; override;
  end;

{ THTMLEditDesigner }

  THTMLEditDesigner = class(TCustomHTMLEditDesigner)
  published
    // Stream the WebBrowser property first so Active can be streamed set to True
    property WebBrowser;
    property Active;
    property OnPostEditor;
    property OnPostHandle;
    property OnPreHandle;
    property OnTranslateAccel;
    property OnBrowserChanged;
  end;

{ TCustomSelectionDesigner }

  TCustomSelectionDesigner = class(TCustomHTMLEditDesigner, IHTMLEditDesigner)
  private
    FCanvas: TCanvas;
    FDrawPrevious: Boolean;
    FInitialPt: TPoint;
    FSelectionRect: TRect;
    FSelectionStarted: Boolean;
    FSrcElement: IHTMLElement;
    FSrcBody: IHTMLElement2;
    FSrcElementXY: TPoint;
    FOverrideCursorState: Boolean;
  protected
    procedure AdjustSelectionRect;
    procedure CancelSelection;
    function CalcMousePt(EventObj: IHTMLEventObj): TPoint;
    procedure ClearSelectionRect;
    procedure SelectControls;
    procedure SetActive(const Value: Boolean); override;
    { IHTMLEditDesigner }
    function PreHandleEvent(inEvtDispId: Integer;
      const pIEventObj: IHTMLEventObj): HRESULT; stdcall;
    function TranslateAccelerator(inEvtDispId: Integer;
      const pIEventObj: IHTMLEventObj): HRESULT; stdcall;
    function DoMouseMove(EventObj: IHTMLEventObj): HRESULT;
    function DoMouseDown(EventObj: IHTMLEventObj): HRESULT;
    function DoMouseUp(EventObj: IHTMLEventObj): HRESULT;
  public
    destructor Destroy; override;
  end;

{ TSelectionDesigner }

  TSelectionDesigner = class(TCustomSelectionDesigner)
  published
    // Stream the WebBrowser property first so Active can be streamed set to True
    property WebBrowser;
    property Active;
    property OnPostEditor;
    property OnPostHandle;
    property OnPreHandle;
    property OnTranslateAccel;
    property OnBrowserChanged;
  end;

{ TCustomHTMLDocumentFragment }

  TCustomElementBehavior = class;

  TCustomHTMLDocumentFragment = class(TComponent)
  private
    FBehavior: TCustomElementBehavior;
    FSpanElement: IHTMLElement;
    FBodyElement: IHTMLElement;
    FFragment: IHTMLDocument2;
    FHTML: TWideStringList;
    function GetHTMLDocument: IHTMLDocument2;
    procedure SetHTML(const Value: TWideStringList);
    procedure HTMLChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Document2: IHTMLDocument2 read GetHTMLDocument;
    property Behavior: TCustomElementBehavior read FBehavior write FBehavior;
    property BodyElement: IHTMLElement read FBodyElement;
    property SpanElement: IHTMLElement read FSpanElement;
  published
    property HTML: TWideStringList read FHTML write SetHTML;
  end;

{ TBehaviorElementEvents }

  TBehaviorElementEvents = class(THTMLElementEventDispatch)
  private
    FBehavior: TCustomElementBehavior;
  protected
    function DoInvoke(DispID: Integer; const IID: TGUID;
      LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
      VarResult, ExcepInfo, ArgErr: Pointer): HRESULT; override;
  public
    constructor Create(Behavior: TCustomElementBehavior; Element: IHTMLElement);
    property Behavior: TCustomElementBehavior read FBehavior;
  end;

{ TCustomElementBehavior }

  // IElementBehavior Interface
  // http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/behaviors/reference/ifaces/elementbehavior/elementbehavior.asp
  TCustomBehaviorWrapper = class;
  TBehaviorElementEventsClass = class of TBehaviorElementEvents;

  TCustomElementBehaviorFactory = class;

  TElementEvent = procedure(Sender: TCustomElementBehavior; var Result: HRESULT) of object;
  TElementInitEvent = procedure(Sender: TCustomElementBehavior;
    const pBehaviorSite: IElementBehaviorSite; var Result: HRESULT) of object;
  TElementNotifyEvent = procedure(Sender: TCustomElementBehavior; lEvent: Integer;
    var pVar: OleVariant; var Result: HRESULT) of object;

  TCustomElementBehavior = class(TWrappedComObject, IElementBehavior,
    IElementBehaviorLayout, IElementBehaviorLayout2, IElementBehaviorFocus,
    IObjectSafety)
  private
    FIsAttached: Boolean;
    FElement2: IHTMLElement2;
    FElement3: IHTMLElement3;
    FElement4: IHTMLElement4;
    FBehavior: string;
    FBehaviorSite: IElementBehaviorSite;
    FCookie: Integer;
    FObjectSafetyFlags: DWORD;
    FOnDetach: TElementEvent;
    FOnInit: TElementInitEvent;
    FOnNotify: TElementNotifyEvent;
    FOnContentSave: TElementEvent;
    FOnContentReady: TElementEvent;
    FOnDocumentReady: TElementEvent;
    FOnDocumentContextChange: TElementEvent;
    FOnMove: TElementEvent;
    FViewLink: TCustomHTMLDocumentFragment;
    FInternalViewLink: TCustomHTMLDocumentFragment;
    FViewLinkHTML: string;
    FElementEventsHolder: IInterface;
    FElementEvents: TBehaviorElementEvents;
    FOnControlSelect: TElementEvent;
    FHandleEvents: Boolean;
    FComComponentReference: TObject;
    function GetElement: IHTMLElement;
    function GetElement2: IHTMLElement2;
    function GetElement3: IHTMLElement3;
    function GetElement4: IHTMLElement4;
    function GetDefaults: IHTMLElementDefaults;
    procedure SetBehavior(const Value: string);
    procedure SetViewLink(const Value: TCustomHTMLDocumentFragment);
    procedure SetViewLinkHTML(const Value: string);
    procedure SetHandleEvents(const Value: Boolean);
    function GetViewLink: TCustomHTMLDocumentFragment;
  protected
    function GetIsReadOnly: Boolean; virtual;
    function DoContentReady: HRESULT; virtual;
    function DoContentSave: HRESULT; virtual;
    function DoDetach: HRESULT; virtual;
    function DoDocumentReady: HRESULT; virtual;
    function DoDocumentContextChange: HRESULT; virtual;
    function DoControlSelect: HRESULT; virtual;
    function DoMove: HRESULT; virtual;
    function DoNotify(lEvent: Integer; var pVar: OleVariant): HRESULT; virtual;
    function DoInit(const pBehaviorSite: IElementBehaviorSite): HRESULT; virtual;
    function GetElementEventsClass: TBehaviorElementEventsClass; virtual;
    function GetBehaviorWrapper: TCustomBehaviorWrapper;
    procedure SetBehaviorSite(const Value: IElementBehaviorSite); virtual;
    { IElementBehavior }
    function Detach: HRESULT; virtual; stdcall;
    function Init(const pBehaviorSite: IElementBehaviorSite): HRESULT; virtual; stdcall;
    function Notify(lEvent: Integer; var pVar: OleVariant): HRESULT; virtual; stdcall;
    { IElementBehaviorLayout }
    function GetLayoutInfo(out plLayoutInfo: Integer): HRESULT; virtual; stdcall;
    function GetPosition(lFlags: Integer;
      var pptTopLeft: MSHTML.tagPOINT): HRESULT; virtual; stdcall;
    function GetSize(dwFlags: Integer; sizeContent: MSHTML.tagSIZE;
      var pptTranslateBy: MSHTML.tagPOINT; var pptTopLeft: MSHTML.tagPOINT;
      var psizeProposed: MSHTML.tagSIZE): HRESULT; virtual; stdcall;
    function MapSize(psizeIn: MSHTML.PtagSIZE; out prcOut: MSHTML.tagRECT): HRESULT; virtual; stdcall;
    property BehaviorSite: IElementBehaviorSite read FBehaviorSite write SetBehaviorSite;
    { IElementBehaviorLayout2 }
    function GetTextDescent(out plDescent: Integer): HRESULT; virtual; stdcall;
    { IElementBehaviorFocus }
    function GetFocusRect(var pRect: MSHTML.tagRECT): HRESULT; virtual; stdcall;
    { IObjectSafety }
    function GetInterfaceSafetyOptions(const IID: TGUID;
      pdwSupportedOptions: PDWORD; pdwEnabledOptions: PDWORD): HRESULT; stdcall;
    function SetInterfaceSafetyOptions(const IID: TGUID;
      dwOptionSetMask: Cardinal; dwEnabledOptions: Cardinal): HRESULT; stdcall;
  public
    procedure Initialize; override;
    destructor Destroy; override;
    property HandleEvents: Boolean read FHandleEvents write SetHandleEvents;
    property IsReadOnly: Boolean read GetIsReadOnly;
    property Cookie: Integer read FCookie;
    property Element: IHTMLElement read GetElement;
    property Element2: IHTMLElement2 read GetElement2;
    property Element3: IHTMLElement3 read GetElement3;
    property Element4: IHTMLElement4 read GetElement4;
    property Defaults: IHTMLElementDefaults read GetDefaults;
    property Behavior: string read FBehavior write SetBehavior;
    property IsAttached: Boolean read FIsAttached;
    property ViewLink: TCustomHTMLDocumentFragment read GetViewLink write SetViewLink;
    property ViewLinkHTML: string read FViewLinkHTML write SetViewLinkHTML;
    property OnNotify: TElementNotifyEvent read FOnNotify write FOnNotify;
    property OnDetach: TElementEvent read FOnDetach write FOnDetach;
    property OnInit: TElementInitEvent read FOnInit write FOnInit;
    property OnContentReady: TElementEvent read FOnContentReady write FOnContentReady;
    property OnContentSave: TElementEvent read FOnContentSave write FOnContentSave;
    property OnDocumentReady: TElementEvent read FOnDocumentReady write FOnDocumentReady;
    property OnDocumentContextChange: TElementEvent read FOnDocumentContextChange write FOnDocumentContextChange;
    property OnControlSelect: TElementEvent read FOnControlSelect write FOnControlSelect;
    property OnMove: TElementEvent read FOnMove write FOnMove;
  end;

{ TCustomPaintedBehavior - stores the IHTMLPaintSite and calls invalidateRect
    when the element is detached (which may not always be desired)

    NOTE: In order for a painted behavior to render the HTML element must have
          "layout" otherwise it will not render. }

  TCustomPaintedBehavior = class;

  TPainterFlag = (pfOpaque, pfTransparent, pfAlpha, pfComplex, pfOverlay,
    pfHitTest, pfSurface, pf3DSurface, pfNoBand, pfNoDC, pfNoPhysicalClip,
    pfNoSaveDC, pfSupportsXFORM, pfExpand, pfNoScrollBits);
  TPainterFlags = set of TPainterFlag;
  TPaintZOrder = (pzNone, pzReplaceAll, pzReplaceContent, pzReplaceBackground,
    pzBelowContent, pzBelowFlow, pzAboveFlow, pzAboveContent, pzWindowTop);

  TPainterDrawFlags = (dfUpdateRegion = 1, dfUseXForm);
  TPainterDrawEvent = procedure(Behavior: TCustomPaintedBehavior;
    BoundsRect, UpdateRect: tagRECT; DrawFlags: TPainterDrawFlags;
    DrawObject: Pointer; var Result: HRESULT) of object;
  TPainterGetPainterInfoEvent = procedure(Behavior: TCustomPaintedBehavior;
    var PainterInfo: _HTML_PAINTER_INFO; var Result: HRESULT) of object;
  TPainterHitTestPointEvent = procedure(Behavior: TCustomPaintedBehavior;
    pt: MSHTML.tagPOINT; out pbHit: Integer; out plPartID: Integer;
    var Result: HRESULT) of object;
  TPainterResizeEvent = procedure(Behavior: TCustomPaintedBehavior; size: tagSIZE;
    var Result: HRESULT) of object;
  TPainterGetEventTarget = procedure(Behavior: TCustomPaintedBehavior;
    var ppElement: IHTMLElement; Result: HRESULT) of object;
  TPainterSetCursor = procedure(Behavior: TCustomPaintedBehavior;
    lPartID: Integer; Result: HRESULT) of object;

  TCustomPaintedBehavior = class(TCustomElementBehavior, IHTMLPainter,
    IHTMLPainterEventInfo)
  private
    FCanvas: TCanvas;
    FPaintSite: IHTMLPaintSite;
    FOnDraw: TPainterDrawEvent;
    FOnGetPainterInfo: TPainterGetPainterInfoEvent;
    FOnHitTestPoint: TPainterHitTestPointEvent;
    FOnResize: TPainterResizeEvent;
    FDrawInfo: _HTML_PAINT_DRAW_INFO;
    FOnGetEventTarget: TPainterGetEventTarget;
    FOnSetCursor: TPainterSetCursor;
    FDrawObject: TGUID;
    FPainterFlags: TPainterFlags;
    FPaintZOrder: TPaintZOrder;
    FExpandRect: TRect;
  protected
    procedure DoCanvasCreated; virtual;
    function DoDraw(const BoundsRect, UpdateRect: tagRECT;
      const DrawFlags: TPainterDrawFlags; DrawObject: Pointer): HRESULT; virtual;
    function DoGetEventTarget(var ppElement: IHTMLElement): HRESULT; virtual;
    function DoSetCursor(lPartID: Integer): HRESULT; virtual;
    { IElementBehavior }
    function Init(const pBehaviorSite: IElementBehaviorSite): HRESULT; override;
    function Detach: HRESULT; override;
    { IHTMLPainter }
    function Draw(rcBounds: MSHTML.tagRECT; rcUpdate: MSHTML.tagRECT; lDrawFlags: Integer;
      hdc: HDC; pvDrawObject: Pointer): HRESULT; virtual; stdcall;
    function GetPainterInfo(out pInfo: _HTML_PAINTER_INFO): HRESULT; virtual; stdcall;
    function HitTestPoint(pt: MSHTML.tagPOINT; out pbHit: Integer;
      out plPartID: Integer): HRESULT; virtual; stdcall;
    function IHTMLPainter.onresize = onresizeevent;
    function onresizeevent(size: tagSIZE): HRESULT; virtual; stdcall;
    { IHTMLPainterEventInfo }
    function GetEventInfoFlags(out plEventInfoFlags: Integer): HRESULT; virtual; stdcall;
    function GetEventTarget(var ppElement: IHTMLElement): HRESULT; stdcall;
    function SetCursor(lPartID: Integer): HRESULT; stdcall;
    function StringFromPartID(lPartID: Integer; out pbstrPart: WideString): HRESULT; stdcall;
  public
    procedure Initialize; override;
    destructor Destroy; override;
    procedure InvalidatePainterInfo;
    property Canvas: TCanvas read FCanvas;
    property DrawInfo: _HTML_PAINT_DRAW_INFO read FDrawInfo;
    property DrawObject: TGUID read FDrawObject write FDrawObject;
    property PaintSite: IHTMLPaintSite read FPaintSite;
    property PainterFlags: TPainterFlags read FPainterFlags write FPainterFlags;
    property PaintZOrder: TPaintZOrder read FPaintZOrder write FPaintZOrder;
    property ExpandRect: TRect read FExpandRect write FExpandRect;
    property OnDraw: TPainterDrawEvent read FOnDraw write FOnDraw;
    property OnGetPainterInfo: TPainterGetPainterInfoEvent read FOnGetPainterInfo
      write FOnGetPainterInfo;
    property OnHitTestPoint: TPainterHitTestPointEvent read FOnHitTestPoint write FOnHitTestPoint;
    property OnResize: TPainterResizeEvent read FOnResize write FOnResize;
    property OnGetEventTarget: TPainterGetEventTarget read FOnGetEventTarget write FOnGetEventTarget;
    property OnSetCursor: TPainterSetCursor read FOnSetCursor write FOnSetCursor;
  end;

{ TCustomBinaryElementBehavior

    This class is just a skeleton implementation of a BinaryElementBehavior
    that declares all of the necessary interface to create a binary Element
    Behavior.  Descendants of this class must override at least
    CreateWithImplementation and FindBehavior in order to implement an
    actual behavior. }

  TCustomBinaryElementBehavior = class(TCustomPaintedBehavior, IElementNamespaceFactory2,
    IElementBehaviorFactory)
  protected
    { IElementNamespaceFactory2 }
    function IElementNamespaceFactory2.create = _create;
    function _create(const pNamespace: IElementNamespace): HResult; stdcall;
    function CreateWithImplementation(const pNamespace: IElementNamespace;
      const bstrImplementation: WideString): HRESULT; virtual; stdcall;
    { IElementBehaviorFactory }
    function FindBehavior(const bstrBehavior: WideString;
      const bstrBehaviorUrl: WideString; const pSite: IElementBehaviorSite;
      out ppBehavior: IElementBehavior): HRESULT; virtual; stdcall;
  end;

{ TCustomBGColorBehavior }

// http://msdn.microsoft.com/downloads/samples/internet/default.asp?url=/downloads/samples/internet/browser/EditHost/default.asp
  TCustomHTMLEditHost = class;
  TCustomBGColorBehavior = class;
  TGridInfo = class;
  TGetMessageInfoEvent = procedure(Sender: TCustomBGColorBehavior; var MsgText: string;
    var TextColor: TColor; var FontStyle: TFontStyles; var DoDefault: Boolean) of object;
  TGetIsCustomContainerEvent = procedure(Sender: TGridInfo; Element: IHTMLElement;
    var IsGridContainer: Boolean) of object;

  // Information that may be shared by multiple grid behaviors.
  TGridInfo = class
  strict private
    FGridsizeX: Integer;
    FGridsizeY: Integer;
    FShowGrid: Boolean;
    FOnInvalidateGrid: TNotifyEvent;
    FOnGetIsCustomContainer: TGetIsCustomContainerEvent;
    procedure SetShowGrid(const Value: Boolean);
    procedure SetGridSizeX(const Value: Integer);
    procedure SetGridSizeY(const Value: Integer);
  private
    procedure InvalidateGrid;
  public
    constructor Create;
    function IsCustomContainer(Element: IHTMLElement): Boolean;
    property ShowGrid: Boolean read FShowGrid write SetShowGrid;
    property GridSizeX: Integer read FGridsizeX write SetGridSizeX;
    property GridSizeY: Integer read FGridsizeY write SetGridSizeY;
    property OnInvalidateGrid: TNotifyEvent read FOnInvalidateGrid
      write FOnInvalidateGrid;
    property OnGetIsCustomContainer: TGetIsCustomContainerEvent read FOnGetIsCustomContainer
      write FOnGetIsCustomContainer;
  end;

  TExcludeRects = array of IHTMLElement;
  TExcludeElementRectEvent = function(Sender: TCustomBGColorBehavior;
    const E: IHTMLElement; var DoDefault: Boolean): Boolean;

  TCustomBGColorBehavior = class(TCustomPaintedBehavior)
  strict private
    FShowMessage: Boolean;
    FExcludeRects: TExcludeRects;
    FDocVersion: LongInt;
    FOnGetMessageInfo: TGetMessageInfoEvent;
    FOnExcludeElementRect: TExcludeElementRectEvent;
    procedure SetShowMessage(const Value: Boolean);
  private
    FHTMLEditHost: TCustomHTMLEditHost;
    FCanChangeLayoutMode: Boolean;
  protected
    procedure DrawMessage(BoundsRect: TRect; Document: IHTMLDocument2);
    function DoDraw(const BoundsRect, UpdateRect: tagRECT;
      const DrawFlags: TPainterDrawFlags; DrawObject: Pointer): HRESULT; override;
    procedure DrawBackground(const BoundsRect, UpdateRect: tagRECT;
      const DrawFlags: TPainterDrawFlags; DrawObject: Pointer; const Document: IHTMLDocument2); virtual; abstract;
    function ExcludeElementRect(const EUnk: IUnknown; const E: IHTMLElement; var DoDefault: Boolean): Boolean; virtual;
    { IHTMLPainter }
    function GetPainterInfo(out pInfo: _HTML_PAINTER_INFO): HRESULT; override;
    function onresizeevent(size: tagSIZE): HRESULT; override;
    function DoDetach: HRESULT; override;
  public
    procedure Initialize; override;
    destructor Destroy; override;
    procedure Refresh; virtual;
    property ExcludeRects: TExcludeRects read FExcludeRects write FExcludeRects;
    property CanChangeLayoutMode: Boolean read FCanChangeLayoutMode write FCanChangeLayoutMode;
    property ShowMessage: Boolean read FShowMessage write SetShowMessage;
    property OnGetMessageInfo: TGetMessageInfoEvent read FOnGetMessageInfo
      write FOnGetMessageInfo;
    property OnExcludeElementRect: TExcludeElementRectEvent read FOnExcludeElementRect
      write FOnExcludeElementRect;
  end;

{ TCustomGridBehavior }

  TCustomGridBehavior = class(TCustomBGColorBehavior)
  private
    FOwnsInfo: Boolean;
    FGridInfo: TGridInfo;
    FIsContentPage: Boolean;
    function GetGridsizeX: Integer;
    function GetGridsizeY: Integer;
    function GetShowGrid: Boolean;
    procedure SetGridSizeX(const Value: Integer);
    procedure SetGridSizeY(const Value: Integer);
    procedure SetShowGrid(const Value: Boolean);
    procedure SetInfo(AGridInfo: TGridInfo);
    function GetInfo: TGridInfo;
    function GetOnGetIsCustomContainer: TGetIsCustomContainerEvent;
    procedure SetOnGetIsCustomContainer(
      const Value: TGetIsCustomContainerEvent);
    procedure InvalidateGrid(Sender: TObject);
  protected
    function DisplayGrid: Boolean;
    procedure DrawAlphaBlend (rt: TRect; hdcwnd : HDC);
    procedure DrawBackground(const BoundsRect, UpdateRect: TRect;
      const DrawFlags: TPainterDrawFlags; DrawObject: Pointer;
      const Document: IHTMLDocument2); override;
    function ExcludeElementRect(const EUnk: IUnknown; const E: IHTMLElement; var DoDefault: Boolean): Boolean; override;
  public
    destructor Destroy; override;
    procedure Refresh; override;
    // The following properties are managed by GridInfo
    property GridInfo: TGridInfo read GetInfo write SetInfo;
    property GridSizeX: Integer read GetGridsizeX write SetGridSizeX;
    property GridSizeY: Integer read GetGridsizeY write SetGridSizeY;
    property ShowGrid: Boolean read GetShowGrid write SetShowGrid;
    property IsContentPage: Boolean read FIsContentPage write FIsContentPage;
    property OnGetIsCustomContainer: TGetIsCustomContainerEvent read GetOnGetIsCustomContainer
      write SetOnGetIsCustomContainer;
  end;

  TCustomBodyGridBehavior = class(TCustomGridBehavior)
  private
    FBehaviors: TList;
    FGridWrapper: TCustomBehaviorWrapper;
    FBehaviorsDocVersion: LongInt;
    procedure GetComClass(Sender: TComComponent; var ComClass: TComClass);
    function AddGridBehavior(MSPositioning: OleVariant;
      Element: IHTMLElement): Boolean;
  protected
    //function AddGridBehavior(MSPositioning: OleVariant; Element: IHTMLElement): Boolean; override;
    procedure BehaviorCreated(Sender: TCustomBehaviorWrapper; const Behavior: TCustomElementBehavior);
    procedure BehaviorDestroyed(Sender: TCustomBehaviorWrapper; const Behavior: TCustomElementBehavior);
    function Detach: HRESULT; override; stdcall;
  public
    procedure AddGridBehaviors;
    procedure Initialize; override;
    destructor Destroy; override;
  end;

  TGridBehavior = class(TCustomGridBehavior);

{ TCustomBehaviorWrapper }

  TCustomElementBehaviorClass = class of TCustomElementBehavior;

  TGetComClassEvent = procedure(Sender: TCustomBehaviorWrapper;
    var BehaviorComClass: TCustomElementBehaviorClass) of object;

  TBehaviorWrapperHResultEvent = procedure(Sender: TCustomBehaviorWrapper;
    Behavior: TCustomElementBehavior; var Result: HRESULT) of object;
  TBehaviorWrapperInitEvent = procedure(Sender: TCustomBehaviorWrapper;
    Behavior: TCustomElementBehavior; const pBehaviorSite: IElementBehaviorSite;
    var Result: HRESULT) of object;
  TBehaviorWrapperNotifyEvent = procedure(Sender: TCustomBehaviorWrapper;
    Behavior: TCustomElementBehavior; lEvent: Integer; var pVar: OleVariant;
    var Result: HRESULT) of object;
  TBehaviorWrapperEvent = procedure(Sender: TCustomBehaviorWrapper;
    const Behavior: TCustomElementBehavior) of object;
  TBehaviorWrapperCreateEvent = procedure(Sender: TCustomBehaviorWrapper;
    var Behavior: TCustomElementBehavior) of object;
  TBehaviorWrapperSupportsNamespaceEvent = procedure(Sender: TCustomBehaviorWrapper;
    ANamespace, AURL, ALongURL: string; var Supports: Boolean) of object;

  TCustomBehaviorWrapper = class(TComComponent)
  private
    FAttachedBehavior: Boolean;
    FBehavior: TCustomElementBehavior;
    FTags: TStringList;
    FOnBehaviorCreated: TBehaviorWrapperEvent;
    FOnBehaviorDestroy: TBehaviorWrapperEvent;
    FOnDetach: TBehaviorWrapperHResultEvent;
    FOnInit: TBehaviorWrapperInitEvent;
    FOnNotify: TBehaviorWrapperNotifyEvent;
    FOnContentSave: TBehaviorWrapperHResultEvent;
    FOnContentReady: TBehaviorWrapperHResultEvent;
    FOnDocumentReady: TBehaviorWrapperHResultEvent;
    FOnDocumentContextChange: TBehaviorWrapperHResultEvent;
    FOnControlSelect: TBehaviorWrapperHResultEvent;
    FFactory: TCustomElementBehaviorFactory;
    FNamespace: string;
    FURL: string;
    FOnCreateBehavior: TBehaviorWrapperCreateEvent;
    FOnSupportsNamespace: TBehaviorWrapperSupportsNamespaceEvent;
    procedure SetFactory(const Value: TCustomElementBehaviorFactory);
    procedure SetTags(const Value: TStringList);
  protected
    procedure DoCreated(const ComObj: TWrappedComObject); override;
    function DoContentReady(Behavior: TCustomElementBehavior): HRESULT; virtual;
    function DoContentSave(Behavior: TCustomElementBehavior): HRESULT; virtual;
    procedure DoDestroy(const ComObj: TWrappedComObject); override;
    function DoDetach(Behavior: TCustomElementBehavior): HRESULT; virtual;
    function DoDocumentReady(Behavior: TCustomElementBehavior): HRESULT; virtual;
    function DoDocumentContextChange(Behavior: TCustomElementBehavior): HRESULT; virtual;
    function DoControlSelect(Behavior: TCustomElementBehavior): HRESULT; virtual;
    function DoNotify(Behavior: TCustomElementBehavior; lEvent: Integer; var pVar: OleVariant): HRESULT; virtual;
    function DoInit(Behavior: TCustomElementBehavior; const pBehaviorSite: IElementBehaviorSite): HRESULT; virtual;
    function GetComClass: TComClass; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddBehavior(URL: string; Element: IHTMLElement); overload;
    procedure AddBehavior(URL: string; Element: IHTMLElement2); overload;
    procedure AddBehavior(Element: IHTMLElement); overload;
    procedure AddBehavior(Element: IHTMLElement2); overload;
    function CreateBehavior: IElementBehavior;
    function RemoveBehavior(Behavior: TCustomElementBehavior): Boolean;
    function SupportsNamespace(const ANamespace, AURL, ALongURL: string): Boolean;
    property Factory: TCustomElementBehaviorFactory read FFactory write SetFactory;
    property Namespace: string read FNamespace write FNamespace;
    property Tags: TStringList read FTags write SetTags;
    property URL: string read FURL write FURL;
    property OnBehaviorCreated: TBehaviorWrapperEvent read FOnBehaviorCreated
      write FOnBehaviorCreated;
    property OnBehaviorDestroy: TBehaviorWrapperEvent read FOnBehaviorDestroy
      write FOnBehaviorDestroy;
    property OnNotify: TBehaviorWrapperNotifyEvent read FOnNotify write FOnNotify;
    property OnDetach: TBehaviorWrapperHResultEvent read FOnDetach write FOnDetach;
    property OnInit: TBehaviorWrapperInitEvent read FOnInit write FOnInit;
    property OnContentReady: TBehaviorWrapperHResultEvent read FOnContentReady write FOnContentReady;
    property OnContentSave: TBehaviorWrapperHResultEvent read FOnContentSave write FOnContentSave;
    property OnDocumentReady: TBehaviorWrapperHResultEvent read FOnDocumentReady write FOnDocumentReady;
    property OnDocumentContextChange: TBehaviorWrapperHResultEvent read FOnDocumentContextChange write FOnDocumentContextChange;
    property OnControlSelect: TBehaviorWrapperHResultEvent read FOnControlSelect write FOnControlSelect;
    property OnCreateBehavior: TBehaviorWrapperCreateEvent read FOnCreateBehavior write FOnCreateBehavior;
    property OnSupportsNamespace: TBehaviorWrapperSupportsNamespaceEvent read FOnSupportsNamespace write FOnSupportsNamespace;
  end;

{ TBehaviorWrapper }

  TBehaviorWrapper = class(TCustomBehaviorWrapper)
  published
    property Factory;
    property Description;
    property GUID;
    property Namespace;
    property Tags;
    property URL;
    property OnBehaviorCreated;
    property OnBehaviorDestroy;
    property OnCreateBehavior;
    property OnGetComClass;
    property OnNotify;
    property OnDetach;
    property OnInit;
    property OnContentReady;
    property OnContentSave;
    property OnDocumentReady;
    property OnDocumentContextChange;
    property OnControlSelect;
    property OnSupportsNamespace;
  end;

{ TCustomElementBehaviorFactory }

  // IElementBehaviorFactory Interface
  // http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/behaviors/reference/ifaces/elementbehaviorfactory/elementbehaviorfactory.asp

  TFindBehaviorEvent = procedure(Sender: TCustomElementBehaviorFactory;
    const Behavior: string; const BehaviorUrl: string;
    const pSite: IElementBehaviorSite; out ppBehavior: IElementBehavior;
    var Result: HRESULT) of object;
  TResolveEvent = procedure(Sender: TCustomElementBehaviorFactory;
    const Namespace, TagName: string; Attrs: widestring;
    const pNamespace: IElementNamespace; Result: HRESULT) of object;
  TBehaviorArray = array of TCustomElementBehavior;

  TCustomElementBehaviorFactory = class(TWebBrowserServiceProvider, IElementBehaviorFactory,
    IElementNamespaceFactory2, IElementNamespaceFactoryCallback)
  private
    FBehaviors: TList;
    FOnFindBehavior: TFindBehaviorEvent;
    FOnResolve: TResolveEvent;
  protected
    function DoResolve(const bstrNamespace, bstrTagName, bstrAttrs: WideString;
      const pNamespace: IElementNamespace): HRESULT;
    { IElementBehaviorFactory }
    function FindBehavior(const bstrBehavior: WideString;
      const bstrBehaviorUrl: WideString; const pSite: IElementBehaviorSite;
      out ppBehavior: IElementBehavior): HRESULT; stdcall;
    { IElementNamespaceFactory }
    function IElementNamespaceFactory2.create = _create;
    function _create(const pNamespace: IElementNamespace): HResult; virtual; stdcall;
    function CreateWithImplementation(const pNamespace: IElementNamespace;
      const bstrImplementation: WideString): HRESULT; stdcall;
    { IElementNamespaceFactoryCallback }
    function Resolve(const bstrNamespace, bstrTagName, bstrAttrs: WideString;
      const pNamespace: IElementNamespace): HResult; stdcall;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddBehavior(Element: IHTMLElement2; Behavior: TCustomElementBehavior);
    procedure Delete(Behavior: TCustomElementBehavior; AllowUndo: Boolean = true); overload;
    procedure Delete(BehaviorsArray: TBehaviorArray; AllowUndo: Boolean = true); overload;
    procedure RegisterBehavior(Behavior: TCustomBehaviorWrapper);
    procedure Select(Behavior: TCustomElementBehavior); overload;
    procedure Select(BehaviorsArray: TBehaviorArray); overload;
    procedure UnRegisterBehavior(Behavior: TCustomBehaviorWrapper);
    property Behaviors: TList read FBehaviors;
    property OnFindBehavior: TFindBehaviorEvent read FOnFindBehavior write FOnFindBehavior;
    property OnResolve: TResolveEvent read FOnResolve write FOnResolve;
  end;

{ TElementBehaviorFactory }

  TElementBehaviorFactory = class(TCustomElementBehaviorFactory)
  published
    property WebBrowser;
    property OnFindBehavior;
    property OnResolve;
  end;

{ TElementNamespaceFactory }

  TElementNamespaceFactory = class(TWebBrowserServiceProvider, IElementNamespaceFactory2)
  public
    function IElementNamespaceFactory2.create = _create;
    function _create(const pNamespace: IElementNamespace): HRESULT;
      virtual; stdcall;
    function CreateWithImplementation(const pNamespace: IElementNamespace;
      const bstrImplementation: WideString): HRESULT; virtual; stdcall;
  end;

{ TGlyphTable }

  // Using Editing Glyphs:
  // http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/editing/usingeditingglyphs.asp

  TTagType = (ttOpen, ttClose, ttBoth);
  TTagAlignment = (taLeft, taCenter, taRight, taUndefined);
  TTagPositioning = (tpStatic, tpAbsolute, tpRelative, tpAll);
  TTagDirection = (tdLeftToRight, tdRightToLeft, tdTopToBottom, tdBottomToTop, tdAll);

  TGlyphTable = class
  private
    FGlyphTable: string;
  public
    procedure AddGlyph(TagID, GlyphLocation: string; TagType: TTagType;
      Alignment: TTagAlignment; Positioning: TTagPositioning; Direction: TTagDirection;
      Width: Integer; Height: Integer);
    procedure ClearTable;
    property GlyphTable: string read FGlyphTable;
  end;

{ TCustomHTMLEditHost }

  TCustomHTMLEditHost = class(TWebBrowserServiceProvider, IHTMLEditHost, IHTMLEditHost2)
  private
    FSnap: Boolean;
    FGridBehavior: TCustomGridBehavior;
    FGridSizeX: Integer;
    FGridSizeY: Integer;
    procedure SetGridBehavior(const Value: TCustomGridBehavior);
    function GetGridSizeX: Integer;
    function GetGridSizeY: Integer;
    procedure SetGridSizeX(const Value: Integer);
    procedure SetGridSizeY(const Value: Integer);
  protected
    { IHTMLEditHost }
    function SnapRect(const pIElement: IHTMLElement; var prcNew: MSHTML.tagRECT;
      eHandle: _ELEMENT_CORNER): HRESULT; virtual; stdcall;
    { IHTMLEditHost2 }
    function PreDrag: HRESULT; virtual; stdcall;
  public
    constructor Create(AOwner: TComponent); override;
    function SnapBottom(Bottom: Integer): Integer;
    function SnapLeft(Left: Integer): Integer;
    function SnapRight(Right: Integer): Integer;
    function SnapTop(Top: Integer): Integer;
    property Grid: TCustomGridBehavior read FGridBehavior write SetGridBehavior;
    property GridSizeX: Integer read GetGridSizeX write SetGridSizeX default 10;
    property GridSizeY: Integer read GetGridSizeY write SetGridSizeY default 10;
//    property Increment: Integer read GetIncrement write SetIncrement default 10;
    property Snap: Boolean read FSnap write FSnap default True;
  end;

{ THTMLEditHost }

  THTMLEditHost = class(TCustomHTMLEditHost)
  published
    property GridSizeX default 10;
    property GridSizeY default 10;
    property Snap;
    property WebBrowser;
  end;

{ TCustomHostBehaviorInit }

  TCustomHostBehaviorInit = class;
  TPopulateNamespaceTableEvent = procedure(Sender: TCustomHostBehaviorInit) of object;

                                                                              

  TCustomHostBehaviorInit = class(TWebBrowserServiceProvider, IHostBehaviorInit)
  private
    FNamespaces: TWideStringList;
    FElementNamespaceTable: IElementNamespaceTable;
    FOnPopulateNamespaceTable: TPopulateNamespaceTableEvent;
    FFactory: TCustomElementBehaviorFactory;
    procedure SetNamespaces(const Value: TWideStringList);
    procedure SetFactory(const Value: TCustomElementBehaviorFactory);
  protected
    function PopulateNamespaceTable: HRESULT; stdcall;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Factory: TCustomElementBehaviorFactory read FFactory write SetFactory;
    property Namespaces: TWideStringList read FNamespaces write SetNamespaces;
    property OnPopulateNamespaceTable: TPopulateNamespaceTableEvent read FOnPopulateNamespaceTable
      write FOnPopulateNamespaceTable;
    property ElementNamespaceTable: IElementNamespaceTable read FElementNamespaceTable;
  end;

{ THostBehaviorInit }

  THostBehaviorInit = class(TCustomHostBehaviorInit)
  published
    property Factory;
    property Namespaces;
    property WebBrowser;
    property OnPopulateNamespaceTable;
    property OnBrowserChanged;
  end;

{ TCustomHTMLValidator }

  TCustomHTMLValidator = class(TCustomWebBrowserComponent)
  private
    FInvalidTags: TList;
  public
    procedure ValidateDocument;
    property InvalidTags: TList read FInvalidTags;
  end;

{ TCustomWebBrowserServices }

  TCustomWebBrowserServices = class(TCustomWebBrowserComponent)
  protected
    procedure ClearReferences; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetWebBrowser(const Value: TWebBrowserEx); override;
  public
    destructor Destroy; override;
  end;

{ TCustomMarkupServices }

  TElementArray = array of IHTMLElement;

  TMarkupContentFlag = (mctAbsoluteLayout, mctFlowLayout, mctText);
  TMarkupContentFlags = set of TMarkupContentFlag;
  TCustomMarkupServices = class(TCustomWebBrowserServices)
  private
    FLeftPos: IMarkupPointer2;
    FRightPos: IMarkupPointer2;
    FStartPos: IMarkupPointer2;
    FInsertPos: IMarkupPointer2;
    FFinishPos: IMarkupPointer2;
    FEndMatch: IMarkupPointer2;
    FContainer: IMarkupContainer2;
    FSearchText: WideString;
    FDocument: IHTMLDocument;
    FMarkupServices: IMarkupServices;
    FMarkupServices2: IMarkupServices2;
    FMarkupContainer: IMarkupContainer;
    function GetLeftPos: IMarkupPointer2;
    function GetRightPos: IMarkupPointer2;
    function GetStartPos: IMarkupPointer2;
    function GetFinishPos: IMarkupPointer2;
    function GetInsertPos: IMarkupPointer2;
    function GetContainer: IMarkupContainer2;
    function GetDocument2: IHTMLDocument2;
    function GetMarkupServices: IMarkupServices;
    function GetMarkupServices2: IMarkupServices2;
    procedure SetDocument(const Value: IHTMLDocument);
    function GetParsedElement: IHTMLElement;
  protected
    procedure ClearReferences; override;
    function GetDocument: IHTMLDocument;
  public
    procedure CreateContainer;
    function CreatePointer: IMarkupPointer;
    procedure Copy;
    function Find(TheText: string; FromBeginning: Boolean = True): Boolean;
    function FindNext: Boolean;
    function ParseGlobalOnly(const HTML: HGLOBAL; var ResultContainer: IMarkupContainer): Boolean;
    function CalcMarkupContentFlags: TMarkupContentFlags;
    function ParseStringOnly(const HTML: WideString; var ResultContainer: IMarkupContainer): Boolean;
    procedure ParseStringMove(const HTML: WideString);
    procedure ParseStringMovePosition(const HTML: WideString; Left, Top, ZIndex: Integer);
    procedure InsertText(TheText: string);
    procedure InsertElement(Element: IHTMLElement);
    procedure Move;
    procedure MovePosition(Left, Top, ZIndex: Integer);
    function SelectLeftElement(CollapseText: Boolean = False): Boolean;
    procedure SelectLeftToRightElements;
    procedure RemoveElement(Element: IHTMLElement);
    procedure Remove;
    procedure ReplaceContent(NewContent: string);
    procedure Select(Element: IHTMLElement); overload;
    procedure Select(Elements: TElementArray); overload;
    property Document: IHTMLDocument read GetDocument write SetDocument;
    property Document2: IHTMLDocument2 read GetDocument2;
    property Container: IMarkupContainer2 read GetContainer;
    property LeftPos: IMarkupPointer2 read GetLeftPos;
    property MarkupServices: IMarkupServices read GetMarkupServices;
    property MarkupServices2: IMarkupServices2 read GetMarkupServices2;
    property RightPos: IMarkupPointer2 read GetRightPos;
    property StartPos: IMarkupPointer2 read GetStartPos;
    property FinishPos: IMarkupPointer2 read GetFinishPos;
    property InsertPos: IMarkupPointer2 read GetInsertPos;
    property EndMatch: IMarkupPointer2 read FEndMatch;
    property ResultContainer: IMarkupContainer read FMarkupContainer;
    property ParsedElement: IHTMLElement read GetParsedElement;
  end;

{ TMarkupServices }

  TMarkupServices = class(TCustomMarkupServices)
  published
    property WebBrowser;
  end;

{ TCustomDisplayServices }

  TCustomDisplayServices = class(TCustomWebBrowserServices)
  private
    FStartPtr: IDisplayPointer;
    FEndPtr: IDisplayPointer;
    FDisplayServices: IDisplayServices;
    function GetStartPtr: IDisplayPointer;
    function GetEndPtr: IDisplayPointer;
    function GetDisplayServices: IDisplayServices;
    function GetCaret: IHTMLCaret;
    function GetLinInfo: ILineInfo;
    //function GetHTMLElement: IHTMLElement;
  protected
    procedure ClearReferences; override;
  public
    function CreateDisplayPointer: IDisplayPointer;
    property Caret: IHTMLCaret read GetCaret;
    property LineInfo: ILineInfo read GetLinInfo;
    property DisplayServices: IDisplayServices read GetDisplayServices;
    property StartPtr: IDisplayPointer read GetStartPtr;
    property EndPtr: IDisplayPointer read GetEndPtr;
    //property HTMLElement: IHTMLElement read GetHTMLElement;
  end;

{ TDisplayServices }

  TDisplayServices = class(TCustomDisplayServices)
  published
    property WebBrowser;
  end;

{ TCustomHighlightRenderingServices }

  TCustomHighlightRenderingServices = class(TCustomWebBrowserServices)
  private
    FHTMLRenderStyle: IHTMLRenderStyle;
    FHighlightRenderingServices: IHighlightRenderingServices;
    function GetHTMLRenderStyle: IHTMLRenderStyle;
    function GetHighlightRenderingServices: IHighlightRenderingServices;
  protected
    procedure ClearReferences; override;
  public
    function CreateRenderStyle: IHTMLRenderStyle;
    property HighlightRenderingServices: IHighlightRenderingServices
      read GetHighlightRenderingServices;
    property RenderStyle: IHTMLRenderStyle read GetHTMLRenderStyle;
  end;

{ THighlightRenderingServices }

  THighlightRenderingServices = class(TCustomHighlightRenderingServices)
  published
    property WebBrowser;  
  end;

{ TParserEventDispatch }

  TCustomMSHTMLParser = class;

  TParserEventDispatch = class(TEventDispatchEx)
  private
    FParser: TCustomMSHTMLParser;
  protected
    function GetEventInterface: IInterface; override;
    function DoInvoke(DispID: Integer; const IID: TGUID;
      LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
      VarResult, ExcepInfo, ArgErr: Pointer): HRESULT; override;
  public
    procedure AfterConstruction; override;
  end;

{ TCustomMSHTMLParser }

  TCustomMSHTMLParser = class(TComponent, IUnknown, IDispatch, IPropertyNotifySink, IOleClientSite)
  private
    FDocEvents: TParserEventDispatch;
    FDocument2: IHTMLDocument2;
    FAfterUpdate: TNotifyEvent;
    FOnReadyStateChange: TNotifyEvent;
    FBeforeUpdate: TNotifyEvent;
    function GetDocument2: IHTMLDocument2;
    function GetDocument3: IHTMLDocument3;
  protected
    procedure DoAfterUpdate;
    procedure DoBeforeUpdate;
    procedure DoReadyStateChange;

    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
    function OnChanged(dispid: Integer): HRESULT; stdcall;
    function OnRequestEdit(dispid: Integer): HRESULT; stdcall;
    function GetContainer(out container: IOleContainer): HRESULT; stdcall;
    function GetMoniker(dwAssign: Integer; dwWhichMoniker: Integer;
      out mk: IMoniker): HRESULT; stdcall;
    function OnShowWindow(fShow: LongBool): HRESULT; stdcall;
    function RequestNewObjectLayout: HRESULT; stdcall;
    function SaveObject: HRESULT; stdcall;
    function ShowObject: HRESULT; stdcall;
  public
    destructor Destroy; override;
    procedure LoadFromStream(S: TStream);
    procedure LoadFromFile(const FileName: string); virtual;
    procedure SaveToStream(S: TStream);
    procedure SaveToFile(const FileName: string); virtual;
    property Document2: IHTMLDocument2 read GetDocument2;
    property Document3: IHTMLDocument3 read GetDocument3;    
    property AfterUpdate: TNotifyEvent read FAfterUpdate write FAfterUpdate;
    property BeforeUpdate: TNotifyEvent read FBeforeUpdate write FBeforeUpdate;
    property OnReadyStateChange: TNotifyEvent read FOnReadyStateChange
      write FOnReadyStateChange;
  end;

{ TMSHTMLParser }

  TMSHTMLParser = class(TCustomMSHTMLParser)
  published
    property AfterUpdate;
    property BeforeUpdate;
    property OnReadyStateChange;
  end;

{ TSelectionServicesListenter }

  TSelectionServicesListenter = class(TComponent, ISelectionServicesListener)
  public
    function BeginSelectionUndo: HRESULT; stdcall;
    function EndSelectionUndo: HRESULT; stdcall;
    function GetTypeDetail(out pTypeDetail: WideString): HRESULT; stdcall;
    function OnChangeType(eType: TOleEnum;
      const pIListener: ISelectionServicesListener): HRESULT; stdcall;
    function OnSelectedElementExit(const pIElementStart: IMarkupPointer;
      const pIElementEnd: IMarkupPointer;
      const pIElementContentStart: IMarkupPointer;
      const pIElementContentEnd: IMarkupPointer): HRESULT; stdcall;
  end;

{ TCustomWebBrowserChangeManager }

  TCustomWebBrowserChangeManager = class(TCustomWebBrowserComponent, IHTMLChangeSink)
  private
    FOnNotify: TNotifyEvent;
    FChangeLog: IHTMLChangeLog;
    FActive: Boolean;
    procedure SetActive(const Value: Boolean);
  protected
    procedure CreateChangeLog;
    procedure ExecChange(Forward: Boolean);
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { IHTMLChangeSink }
    function Notify: HRESULT; stdcall;
  public
    procedure Redo;
    procedure Undo;
    property Active: Boolean read FActive write SetActive;
    property OnNotify: TNotifyEvent read FOnNotify write FOnNotify;
  end;

{ TWebBrowserChangeManager }

  TWebBrowserChangeManager = class(TCustomWebBrowserChangeManager)
  published
    property Active;
    property WebBrowser;
    property OnNotify;
    property OnBrowserChanged;
  end;

{  TMarkupContainer = class(TComponent)
  private
    FMarkupContainer: IMarkupContainer;
    FOnNotify: TNotifyEvent;
  published
    property RegisterForDirtyRange: boolean read FRegisterForDirtyRange write SetRegisterForDirtyRange;
    property OnNotify: TNotifyEvent read FOnNotify write FOnNotify;
  end;}

  TCustomHTMLTableDesigner = class;
  TTableDragKind = (tdkNone, tdkRow, tdkColumn, tdkRowSelect, tdkColSelect);
  TTableDesignerNotifyEvent = procedure(Sender: TCustomHTMLTableDesigner) of object;

  TCustomHTMLTableDesigner = class(TCustomHTMLEditDesigner, IHTMLEditDesigner,
    ISelectionServicesListener)
  private
    FDragCell: IHTMLTableCell;
    FDragTable: IHTMLTable;
    FDragRow2: IHTMLTableRow2;
    FDragCol: IHTMLElement;
    FDraggingRow: Boolean;
    FOffsetPos: TPoint;
    FOverridingCursor: Boolean;
    FOnChange: TTableDesignerNotifyEvent;
    FColumnResizeColor: string;
    FRowResizeColor: string;
    procedure SetColumnHeight(const AWidth: Integer);
    procedure SetColumnWidth(const AWidth: Integer);
    function CanDesignElement(AElement: IHTMLElement): Boolean;
  protected
    procedure Clear;
    function DoMouseDown(EventObj: IHTMLEventObj): HRESULT;
    function DoMouseMove(EventObj: IHTMLEventObj): HRESULT;
    procedure SetColumnHighlight(const Color: string);
    procedure SetRowHighlight(const Color: string);
    function OnTable(ADragTable: IHTMLTable; const X, Y: Integer; var ARow: IHTMLTableRow2): TTableDragKind;
    function OnCell(ADragCell: IHTMLTableCell; const X, Y: Integer; var ATableRow2: IHTMLTableRow2): TTableDragKind;
    { IHTMLEditDesigner }
    function PreHandleEvent(inEvtDispId: Integer;
      const pIEventObj: IHTMLEventObj): HRESULT; stdcall;
    { ISelectionServicesListener }
    function BeginSelectionUndo: HRESULT; stdcall;
    function EndSelectionUndo: HRESULT; stdcall;
    function GetTypeDetail(out pTypeDetail: WideString): HRESULT; stdcall;
    function OnChangeType(eType: TOleEnum;
      const pIListener: ISelectionServicesListener): HRESULT; stdcall;
    function OnSelectedElementExit(const pIElementStart: IMarkupPointer;
      const pIElementEnd: IMarkupPointer;
      const pIElementContentStart: IMarkupPointer;
      const pIElementContentEnd: IMarkupPointer): HRESULT; stdcall;
  public
    constructor Create(AOwner: TComponent); override;
    property ColumnResizeColor: string read FColumnResizeColor write FColumnResizeColor;
    property RowResizeColor: string read FRowResizeColor write FRowResizeColor;
    property OnChange: TTableDesignerNotifyEvent read FOnChange write FOnChange;
  end;

  THTMLTableDesigner = class(TCustomHTMLTableDesigner)
  published
    property Active;
    property ColumnResizeColor;
    property RowResizeColor;
    property WebBrowser;
    property OnBrowserChanged;
  end;

  THTMLDragDropEffectEvent = procedure(Sender: TObject; EventObj: IHTMLEventObj; var dwEffect: Integer) of object;
  THTMLDragDropEvent = procedure(Sender: TObject; EventObj: IHTMLEventObj) of object;
  THTMLDragDropSetCursorEvent = procedure(Sender: TObject; var CursorSet: Boolean) of object;

  TCustomHTMLDragDropDesigner = class(TCustomHTMLEditDesigner, IHTMLEditDesigner)
  private
    FDragOver: Boolean;
    FDragEnter: Boolean;
    FOverridingCursor: Boolean;
    FOnDragEnter: THTMLDragDropEffectEvent;
    FOnDragLeave: THTMLDragDropEvent;
    FOnDragOver: THTMLDragDropEffectEvent;
    FOnDragDrop: THTMLDragDropEffectEvent;
    FOnSetDragCursor: THTMLDragDropSetCursorEvent;
    procedure DoDragDrop(EventObj: IHTMLEventObj);
    procedure DoDragLeave(EventObj: IHTMLEventObj);
    procedure DoDragOver(EventObj: IHTMLEventObj);
    procedure DoDragEnter(EventObj: IHTMLEventObj);
    procedure RestoreCursor;
    procedure DoSetCursor;
  protected
    procedure Clear;
    function DoCancel(EventObj: IHTMLEventObj): HRESULT;
    function DoMouseDown(EventObj: IHTMLEventObj): HRESULT;
    function DoMouseMove(EventObj: IHTMLEventObj): HRESULT;
    function DoMouseUp(EventObj: IHTMLEventObj): HRESULT;
    function DoMouseOut(EventObj: IHTMLEventObj): HRESULT;
    { IHTMLEditDesigner }
    function PreHandleEvent(inEvtDispId: Integer;
      const pIEventObj: IHTMLEventObj): HRESULT; stdcall;
  public
    constructor Create(AOwner: TComponent); override;
    property OnDragEnter: THTMLDragDropEffectEvent read FOnDragEnter write FOnDragEnter;
    property OnDragLeave: THTMLDragDropEvent read FOnDragLeave write FOnDragLeave;
    property OnDragOver: THTMLDragDropEffectEvent read FOnDragOver write FOnDragOver;
    property OnDragDrop: THTMLDragDropEffectEvent read FOnDragDrop write FOnDragDrop;
    property OnSetDragCursor: THTMLDragDropSetCursorEvent read FOnSetDragCursor write FOnSetDragCursor;
  end;

  THTMLDragDropDesigner = class(TCustomHTMLDragDropDesigner)
  published
    property Active;
    property WebBrowser;
    property OnBrowserChanged;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
  end;

  // Handle events necessary to support ASP control regions
  THTMLRegionDesignerClickRegionEvent = procedure(Sender: TObject; EventObj: IHTMLEventObj; Region: Integer) of object;
  THTMLRegionDesignerClickEvent = procedure(Sender: TObject; EventObj: IHTMLEventObj; out AHandled: Boolean) of object;
  THTMLRegionDesignerCanClickRegionEvent = procedure(Sender: TObject; EventObj: IHTMLEventObj; Region: Integer; out CanClick: Boolean) of object;
  TCustomHTMLRegionDesigner = class(TCustomHTMLEditDesigner, IHTMLEditDesigner)
  private
    FOverridingCursor: Boolean;
    FOnClickRegion: THTMLRegionDesignerClickRegionEvent;
    FOnClickNonEditable: THTMLRegionDesignerClickEvent;
    FOnCanClickRegion: THTMLRegionDesignerCanClickRegionEvent;
    FMouseDownCancelled: Boolean;
    function InClickableRegion(EventObj: IHTMLEventObj): Boolean; overload;
    function InClickableRegion(EventObj: IHTMLEventObj; out Region: Integer): Boolean; overload;
    function InNonEditableRegion(EventObj: IHTMLEventObj): Boolean;
    class function RegionIndexOfElement(HTMLElement: IHTMLElement): Integer;
    function DoMouseDown(EventObj: IHTMLEventObj): HRESULT;
    function DoPostEditEventMouseDown(EventObj: IHTMLEventObj): HRESULT;
    function DoMouseUp(EventObj: IHTMLEventObj): HRESULT;
    function DoKeyUp(EventObj: IHTMLEventObj): HRESULT;
    function DoKeyPress(EventObj: IHTMLEventObj): HRESULT;
    function DoKeyDown(EventObj: IHTMLEventObj): HRESULT;
    function CanEnterText(AEventObj: IHTMLEventObj): Boolean;
    function DoBeforeDeactivate(EventObj: IHTMLEventObj): HRESULT;
    function DoMouseMove(EventObj: IHTMLEventObj): HRESULT;
    { IHTMLEditDesigner }
    function PostEditorEventNotify(inEvtDispId: Integer; const pIEventObj: IHTMLEventObj): HResult; stdcall;
    function PostHandleEvent(inEvtDispId: Integer; const pIEventObj: IHTMLEventObj): HResult; stdcall;
    function PreHandleEvent(inEvtDispId: Integer;
      const pIEventObj: IHTMLEventObj): HRESULT; stdcall;
    function TranslateAccelerator(inEvtDispId: Integer;
      const pIEventObj: IHTMLEventObj): HRESULT; stdcall;
    procedure SetClickableRegionCursor(EventObj: IHTMLEventObj);
    procedure SetNonEditableRegionCursor(EventObj: IHTMLEventObj);
    function OverSelectableControlInRegion(EventObj: IHTMLEventObj;
      out AControlElement: IHTMLElement): Boolean; overload;
    function OverSelectableControlInRegion(EventObj: IHTMLEventObj): Boolean; overload;
    procedure SetOverSelectableControlInRegionCursor(EventObj: IHTMLEventObj);
    procedure SelectControlInRegion(AHTMLElement: IHTMLElement);
    procedure SetFocusControlInRegion(AHTMLElement: IHTMLElement);
    function CanSelectTextInSrcElement(EventObj: IHTMLEventObj): Boolean;
    procedure RestoreCursor;
    procedure CalcClientRect(var Rect: TRect);
    function OverClient(EventObj: IHTMLEventObj): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    class function RegionIndexOfElementOrParent(HTMLElement: IHTMLElement; out RegionElement: IHTMLElement): Integer;
    property OnClickRegion: THTMLRegionDesignerClickRegionEvent read FOnClickRegion write FOnClickRegion;
    property OnClickNonEditable: THTMLRegionDesignerClickEvent read FOnClickNonEditable write FOnClickNonEditable;
    property OnCanClickRegion: THTMLRegionDesignerCanClickRegionEvent read FOnCanClickRegion write FOnCanClickRegion;
  end;


  THTMLRegionDesigner = class(TCustomHTMLRegionDesigner)
  published
    property Active;
    property WebBrowser;
    property OnBrowserChanged;
    property OnClickRegion;
  end;

  TDefaultPositioning = (dpGrid, dpFlow);

function IsGridPositioning(MSPositioning: OleVariant): Boolean;
function IsFlowPositioning(MSPositioning: OleVariant): Boolean;
procedure SetDefaultPositioning(ADefaultPositioning: TDefaultPositioning);
function GetPixelHeightPropertyValue(HTMLElement: IHTMLElement): Integer;
function GetPixelWidthPropertyValue(HTMLElement: IHTMLElement): Integer;
function SameDocument(ADocument1: IHTMLDocument; ADocument2: IHTMLDocument): Boolean;
// Calculate the real location of E by add parentElement offsets
function CalcElementXY(E: IHTMLElement): TPoint;
procedure RestoreBrowserCursor(WebBrowser: TWebBrowserEx);


implementation

uses Mshtmdid, Vcl.Forms, Vcl.Dialogs, System.Types, System.StrUtils, Vcl.GraphUtil, Winapi.Messages,
  IEConst;

const
  sMSPositioning = 'ms_positioning';
  sHasGrid = 'hasgrid';

var
  FDefaultPositioning: TDefaultPositioning = dpGrid;

procedure SetDefaultPositioning(ADefaultPositioning: TDefaultPositioning);
begin
  FDefaultPositioning := ADefaultPositioning;
end;

function IsGridPositioning(MSPositioning: OleVariant): Boolean;
const
  sGridLayout = 'gridlayout';
begin
  if FDefaultPositioning = dpGrid then
    Result := VarIsNull(MSPositioning) or (WideCompareText(MSPositioning, sGridLayout) = 0) // Do not localize
  else
    Result := (not VarIsNull(MSPositioning)) and (WideCompareText(MSPositioning, sGridLayout) = 0) // Do not localize
end;

function IsFlowPositioning(MSPositioning: OleVariant): Boolean;
begin
  Result := not IsGridPositioning(MSPositioning);
end;

function CalcElementXY(E: IHTMLElement): TPoint;
begin
  Result := Point(0,0);
  if E = nil then exit;
  Result := Point(E.offsetLeft, E.offsetTop);
  while E.parentElement <> nil do
  begin
    Inc(Result.X, E.parentElement.offsetLeft);
    Inc(Result.Y, E.parentElement.offsetTop);
    E := E.parentElement;
  end;
end;

function VariantPropertyToPixels(V: OleVariant): Integer;
const
  sPx = 'px';
var
  S: string;
  I: Integer;
begin
  Result := 0;
  if not VarIsNull(V) then
    try
      S := V;
      if S <> '' then
      begin
        I := Pos(sPx, S);
        if I > 0 then
          S := Copy(S, 1, I-1);
        Result := StrToInt(S);
      end;
    except
    end;
end;

procedure CalcElementRect(HTMLElement: IHTMLElement; var Rect: TRect);
var
  HTMLRect: IHTMLRect;
begin
  HTMLRect := (HTMLElement as IHTMLElement2).getBoundingClientRect;
  Rect.Top := HTMLRect.top;
  Rect.Left := HTMLRect.left;
  Rect.Right := HTMLRect.right;
  Rect.Bottom := HTMLRect.bottom;
end;

function GetPixelHeightPropertyValue(HTMLElement: IHTMLElement): Integer;
var
  pixelHeight: Integer;
  HTMLRect: IHTMLRect;
begin
  // Get height
  pixelHeight := HTMLElement.style.pixelHeight;
  if pixelHeight = 0 then
  begin
    pixelHeight := VariantPropertyToPixels(HTMLElement.getAttribute('height', 0));  // do not localize
    if pixelHeight = 0 then
    begin
      HTMLRect := (HTMLElement as IHTMLElement2).getBoundingClientRect;
      pixelHeight := HTMLRect.Bottom - HTMLRect.Top;
    end;
  end;
  Result := pixelHeight;
end;

function GetPixelWidthPropertyValue(HTMLElement: IHTMLElement): Integer;
var
  HTMLTable: IHTMLTable;
  pixelWidth: Integer;
  HTMLRect: IHTMLRect;
begin
  // Get width
  if Supports(HTMLElement, IHTMLTable, HTMLTable) then
  begin
    pixelWidth := 0;
    try
      pixelWidth := HTMLTable.Width;
    except
    end;
    if pixelWidth = 0 then
      pixelWidth := HTMLElement.style.pixelWidth;
    if pixelWidth = 0 then
    begin
      HTMLRect := (HTMLElement as IHTMLElement2).getBoundingClientRect;
      pixelWidth := HTMLRect.Right - HTMLRect.Left;
    end;
  end
  else
  begin
    pixelWidth := HTMLElement.style.pixelWidth;
    if pixelWidth = 0 then
    begin
      pixelWidth := VariantPropertyToPixels(HTMLElement.getAttribute('width', 0));  // do not localize
      if pixelWidth = 0 then
      begin
        HTMLRect := (HTMLElement as IHTMLElement2).getBoundingClientRect;
        pixelWidth := HTMLRect.Right - HTMLRect.Left;
      end;
    end;
  end;
  Result := pixelWidth;
end;

function SameDocument(ADocument1: IHTMLDocument; ADocument2: IHTMLDocument): Boolean;
var
  Doc3_1, Doc3_2: IHTMLDocument3;
//  Unk1, Unk2: IUnknown;
begin
  Supports(ADocument1, IHTMLDocument3, Doc3_1);
  Supports(ADocument2, IHTMLDocument3, Doc3_2);
  Assert(Doc3_1 <> nil);
  Assert(Doc3_2 <> nil);
//  Supports(Doc3_1, IUnknown, Unk1);
//  Supports(Doc3_2, IUnknown, Unk2);
//  Result := Unk1 = Unk2;
  if (Doc3_1 <> nil) and (Doc3_2 <> nil) then
    Result := (Doc3_1.DocumentElement as IUnknown) = (Doc3_2.DocumentElement as IUnknown)
  else
    Result := False;
end;

procedure RestoreBrowserCursor(WebBrowser: TWebBrowserEx);
var
  LWnd: HWND;
  LSetCursor: TWMSetCursor;
begin
  LWnd := WebBrowser.InetExplorerServerHandle;
  LSetCursor.Hittest := HTCLIENT;
  LSetCursor.CursorWnd := LWnd;
  LSetCursor.Msg := WM_MOUSEMOVE;
  LSetCursor.Result := 0;
  SendMessage(LWnd, WM_SETCURSOR, TMessage(LSetCursor).wParam, TMessage(LSetCursor).lParam);
end;

{ TCustomHTMLEditDesigner }

destructor TCustomHTMLEditDesigner.Destroy;
begin
  if FDesignerImpl <> nil then
    FDesignerImpl.DisconnectComponent;
  inherited;
end;

function TCustomHTMLEditDesigner.IsPrimaryDocumentEvent(
  EventObj: IHTMLEventObj): Boolean;
begin
  Result := True;
  if Assigned(EventObj) and Assigned(EventObj.srcElement) then
  begin
    Result := IsPrimaryDocumentElement(EventObj.srcElement);
  end;
end;

function TCustomHTMLEditDesigner.IsPrimaryDocumentElement(AElement: IHTMLElement): Boolean;
begin
  Result := SameDocument(WebBrowser.Document as IHTMLDocument,
      AElement.document as IHTMLDocument);
end;

procedure TCustomHTMLEditDesigner.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = WebBrowser) then
    SetActive(False);
  inherited;
end;

function TCustomHTMLEditDesigner.PostEditorEventNotify(inEvtDispId: Integer;
  const pIEventObj: IHTMLEventObj): HRESULT;
begin
  Result := S_FALSE;
  if Assigned(FOnPostEditor) then FOnPostEditor(Self, inEvtDispId, pIEventObj, Result);
end;

function TCustomHTMLEditDesigner.PostHandleEvent(inEvtDispId: Integer;
  const pIEventObj: IHTMLEventObj): HRESULT;
begin
  Result := S_FALSE;
  if Assigned(FOnPostHandle) then FOnPostHandle(Self, inEvtDispId, pIEventObj, Result);
end;

function TCustomHTMLEditDesigner.PreHandleEvent(inEvtDispId: Integer;
  const pIEventObj: IHTMLEventObj): HRESULT;
begin
  Result := S_FALSE;
  if Assigned(FOnPreHandle) then FOnPreHandle(Self, inEvtDispId, pIEventObj, Result);
end;

procedure TCustomHTMLEditDesigner.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    CheckWebBrowserAssigned;
    if csDestroying in WebBrowser.ComponentState then
    begin
      FActive := False;
      if FDesignerImpl <> nil then
        FDesignerImpl.DisconnectComponent;
      Assert(FDesignerImpl = nil);
      exit;
    end;
    if Assigned(WebBrowser.HTMLEditServices) then
      if Value then
        OleCheck(WebBrowser.HTMLEditServices.AddDesigner(THTMLEditDesignerImpl.Create(Self) as IHTMLEditDesigner))
      else
      begin
        // check: if FActive == true then FDesignerImpl <> nil
        Assert(FDesignerImpl <> nil);
        if FDesignerImpl <> nil then
        begin
          WebBrowser.HTMLEditServices.RemoveDesigner(FDesignerImpl as IHTMLEditDesigner);
          if FDesignerImpl <> nil then
            // Should have been disconnected by now but do this just in case
            FDesignerImpl.DisconnectComponent;
        end;
      end
    else
    begin
      FActive := Value;
      if FActive then
        raise Exception.CreateFmt(sEditDesignerNoPageLoaded, [Name]);
    end;
    FActive := Value;
  end;
end;

procedure TCustomHTMLEditDesigner.SetWebBrowser(const Value: TWebBrowserEx);
begin
  if (WebBrowser <> nil) and (WebBrowser <> Value) then
    SetActive(False);
  inherited SetWebBrowser(Value);
end;

function TCustomHTMLEditDesigner.TranslateAccelerator(inEvtDispId: Integer;
  const pIEventObj: IHTMLEventObj): HRESULT;
begin
  Result := S_FALSE;
  if Assigned(FOnTranslateAccel) then FOnTranslateAccel(Self, inEvtDispId, pIEventObj, Result);
end;

{ TCustomElementBehavior }

function TCustomElementBehavior.Detach: HRESULT;
begin
  HandleEvents := False; // Release FElementEvents
  if FViewLink <> nil then
    FViewLink.FFragment := nil;
  // Call DoDetach before releasing IHTMLElement so that Detach event handlers
  // can access the element.
  Result := DoDetach;
  FElement2 := nil;
  FElement3 := nil;
  FElement4 := nil;
  FBehaviorSite := nil;
end;

function TCustomElementBehavior.DoContentReady: HRESULT;
var
  BehaviorWrapper: TCustomBehaviorWrapper;
begin
  if Assigned(FOnContentReady) then FOnContentReady(Self, Result);
  BehaviorWrapper := GetBehaviorWrapper;
  if Assigned(BehaviorWrapper) then
    Result := BehaviorWrapper.DoContentReady(Self);
  if Assigned(ViewLink) and (Length(ViewLink.HTML.Text) > 0) then
    Defaults.ViewLink := ViewLink.Document2;
end;

function TCustomElementBehavior.DoContentSave: HRESULT;
var
  BehaviorWrapper: TCustomBehaviorWrapper;
begin
  Result := S_OK;
  if Assigned(FOnContentSave) then FOnContentSave(Self, Result);
  BehaviorWrapper := GetBehaviorWrapper;
  if Assigned(BehaviorWrapper) then
     Result := BehaviorWrapper.DoContentSave(Self);
end;

function TCustomElementBehavior.DoDetach: HRESULT;
var
  BehaviorWrapper: TCustomBehaviorWrapper;
begin
  Result := S_OK;
  if Assigned(FOnDetach) then FOnDetach(Self, Result);
  BehaviorWrapper := GetBehaviorWrapper;
  if Assigned(BehaviorWrapper) then
     Result := BehaviorWrapper.DoDetach(Self);
end;

function TCustomElementBehavior.DoDocumentContextChange: HRESULT;
var
  BehaviorWrapper: TCustomBehaviorWrapper;
begin
  Result := S_OK;
  if Assigned(FOnDocumentContextChange) then FOnDocumentContextChange(Self, Result);
  BehaviorWrapper := GetBehaviorWrapper;
  if Assigned(BehaviorWrapper) then
                                            
     Result := BehaviorWrapper.DoDocumentContextChange(Self);
end;

function TCustomElementBehavior.DoDocumentReady: HRESULT;
var
  BehaviorWrapper: TCustomBehaviorWrapper;
begin
  Result := S_OK;
  if Assigned(FOnDocumentReady) then FOnDocumentReady(Self, Result);
  BehaviorWrapper := GetBehaviorWrapper;
  if Assigned(BehaviorWrapper) then
     Result := BehaviorWrapper.DoDocumentReady(Self);
end;

function TCustomElementBehavior.GetDefaults: IHTMLElementDefaults;
var
  Site: IElementBehaviorSiteOM;
  Site2: IElementBehaviorSiteOM2;
begin
  Result  := nil;
  try
  if Supports(FBehaviorSite, IID_IElementBehaviorSiteOM, Site) then
    if Supports(Site, IID_IElementBehaviorSiteOM2, Site2) then
      OleCheck(Site2.GetDefaults(Result));
  except
    // Ignore exception when element doens't have defaults

  end;
end;

function TCustomElementBehavior.GetElement: IHTMLElement;
begin
  Result := nil;
  if Assigned(FBehaviorSite) then
    FBehaviorSite.GetElement(Result);
end;

function TCustomElementBehavior.GetElement2: IHTMLElement2;
begin
  if FElement2 = nil then
    FElement2 := GetElement as IHTMLElement2;
  Result := FElement2;
end;

function TCustomElementBehavior.GetElement3: IHTMLElement3;
begin
  if FElement3 = nil then
    FElement3 := GetElement as IHTMLElement3;
  Result := FElement3;
end;

function TCustomElementBehavior.GetElement4: IHTMLElement4;
begin
  if FElement4 = nil then
    FElement4 := GetElement as IHTMLElement4;
  Result := FElement4;
end;

function TCustomElementBehavior.GetFocusRect(var pRect: tagRECT): HRESULT;
begin
  Result := S_OK;
end;

function TCustomElementBehavior.GetLayoutInfo(
  out plLayoutInfo: Integer): HRESULT;
begin
  Result := S_OK;
end;

function TCustomElementBehavior.GetPosition(lFlags: Integer;
  var pptTopLeft: MSHTML.tagPOINT): HRESULT;
begin
  Result := S_OK;
  pptTopLeft.x := 20;
  pptTopLeft.y := 30;
end;

function TCustomElementBehavior.GetSize(dwFlags: Integer; sizeContent: MSHTML.tagSIZE;
  var pptTranslateBy, pptTopLeft: MSHTML.tagPOINT;
  var psizeProposed: MSHTML.tagSIZE): HRESULT;
begin
  Result := S_OK;
end;

function TCustomElementBehavior.Init(
  const pBehaviorSite: IElementBehaviorSite): HRESULT;
var
  EventsClass: TBehaviorElementEventsClass;
begin
  FBehaviorSite := pBehaviorSite;
  if HandleEvents then
  begin
    EventsClass := GetElementEventsClass;
    if Assigned(EventsClass) then
    begin
      FElementEvents := EventsClass.Create(Self, GetElement);
      FElementEventsHolder := FElementEvents;
      FElementEvents.Active := True;
    end;
  end;
  Result := DoInit(pBehaviorSite);
end;

type
  // nil a component reference when component is destroyed.
  // Use this class to prevent the a TWrappedComObject instance
  // from referencing a TComComponent after the TComComponent has
  // been freed.  For behaviors, we have no control over when the
  // behavior interface will be released by the IE control.  Some times
  // this happened after the form containing TComComponents was destroyed.
  TComComponentReference = class(TComponent)
  private
    FComponent: TComponent;
  protected
    procedure Notification(AComponent: TComponent;
      AOperation: TOperation); override;
    procedure SetComponent(Value: TComponent);
  public
    destructor Destroy; override;
    property Component: TComponent read FComponent write SetComponent;
  end;

destructor TComComponentReference.Destroy;
begin
  if Assigned(FComponent) then
    FComponent.RemoveFreeNotification(Self);
  inherited;
end;

procedure TComComponentReference.SetComponent(Value: TComponent);
begin
  if FComponent <> nil then
    FComponent.RemoveFreeNotification(Self);
  FComponent := Value;
  if FComponent <> nil then
    FComponent.FreeNotification(Self);
end;

procedure TComComponentReference.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited;
  if (AOperation = opRemove) and (AComponent = FComponent) then
    FComponent := nil;
end;

procedure TCustomElementBehavior.Initialize;
var
  LComComponentReference: TComComponentReference;
begin
  inherited;
  LComComponentReference := TComComponentReference.Create(nil);
  LComComponentReference.Component := ComComponent;
  FComComponentReference := LComComponentReference;
  (* jmt.!!! Don't create viewlink until later
  if IsReadOnly then
  begin
    FViewLink := TCustomHTMLDocumentFragment.Create(nil);
    FViewLink.SetSubComponent(True);
    FViewLink.Name := 'InternalHTMLDocumentFragment';  { do not localize }
    FViewLink.Behavior := Self;
  end;
  *)
  FHandleEvents := True;
end;

function TCustomElementBehavior.MapSize(psizeIn: MSHTML.PtagSIZE;
  out prcOut: MSHTML.tagRECT): HRESULT;
begin
  Result := S_OK;
end;

function TCustomElementBehavior.Notify(lEvent: Integer;
  var pVar: OleVariant): HRESULT;
begin
  Result := DoNotify(lEvent, pVar);
  if Result <> S_OK then exit;
  case lEvent of
    BEHAVIOREVENT_CONTENTREADY: Result := DoContentReady;
    BEHAVIOREVENT_CONTENTSAVE: Result := DoContentSave;
    BEHAVIOREVENT_DOCUMENTREADY: Result := DoDocumentReady;
    BEHAVIOREVENT_DOCUMENTCONTEXTCHANGE: Result := DoDocumentContextChange;
  end;
end;

procedure TCustomElementBehavior.SetBehavior(const Value: string);
begin
                                                       
  // According to MSDN attached behaviors have to use all lower case behavior names
  // Element behaviors have to use all upper case behavior names!!
  // Refer to the MSDN documentation for IElementBehaviorFactory.FindBehavior
  if FIsAttached then
    FBehavior := LowerCase(Value)
  else
    FBehavior := UpperCase(Value);
end;

procedure TCustomElementBehavior.SetViewLink(const Value: TCustomHTMLDocumentFragment);
begin
  if FViewLink <> Value then
  begin
    if Assigned(FInternalViewLink) and (FViewLink = FInternalViewLink) then
      FreeAndNil(FInternalViewLink);
    FViewLink := Value;
    if Assigned(FViewLink) then
      Defaults.viewLink := FViewLink.Document2;
  end;
end;

procedure TCustomElementBehavior.SetViewLinkHTML(const Value: string);
begin
  FViewLinkHTML := Value;
end;

procedure TCustomElementBehavior.SetBehaviorSite(
  const Value: IElementBehaviorSite);
begin
  FBehaviorSite := Value;
end;

function TCustomElementBehavior.DoControlSelect: HRESULT;
var
  BehaviorWrapper: TCustomBehaviorWrapper;
begin
  Result := S_OK;
  if Assigned(FOnControlSelect) then FOnControlSelect(Self, Result);
  BehaviorWrapper := GetBehaviorWrapper;
  if Assigned(BehaviorWrapper) then
    Result := BehaviorWrapper.DoControlSelect(Self);
end;

function TCustomElementBehavior.DoMove: HRESULT;
begin
  Result := S_OK;
  if Assigned(FOnMove) then FOnMove(Self, Result);
end;

function TCustomElementBehavior.DoNotify(lEvent: Integer;
  var pVar: OleVariant): HRESULT;
begin
  Result := S_OK;
  if Assigned(FOnNotify) then FOnNotify(Self, lEvent, pVar, Result);
end;

function TCustomElementBehavior.DoInit(const pBehaviorSite: IElementBehaviorSite): HRESULT;
var
  BehaviorWrapper: TCustomBehaviorWrapper;
begin
  Result := S_OK;
  if Assigned(FOnInit) then FOnInit(Self, pBehaviorSite, Result);
  if (Result = S_OK) then
  begin
    BehaviorWrapper := GetBehaviorWrapper;
    if Assigned(BehaviorWrapper) then
      BehaviorWrapper.DoInit(Self, pBehaviorSite);
  end;
end;

function TCustomElementBehavior.GetBehaviorWrapper: TCustomBehaviorWrapper;
begin
  //Result := TCustomBehaviorWrapper(ComComponent);
  // TComComponentReference provides a nil value if the component gets freed
  Result := TCustomBehaviorWrapper(TComComponentReference(FComComponentReference).Component);
end;

procedure TCustomElementBehavior.SetHandleEvents(const Value: Boolean);
var
  Element: IHTMLElement;
begin
  if FHandleEvents <> Value then
  begin
    if not Value then
    begin
      // Release the reference to FElementEvents.
      FElementEvents.Active := False;
      FElementEvents := nil;
      FElementEventsHolder := nil;
    end;
    FHandleEvents := Value;
    if FHandleEvents then
    begin
      OleCheck(FBehaviorSite.GetElement(Element));
      FElementEvents := TBehaviorElementEvents.Create(Self, Element);
      FElementEventsHolder := FElementEvents;
    end;
  end;
end;

function TCustomElementBehavior.GetElementEventsClass: TBehaviorElementEventsClass;
begin
  Result := TBehaviorElementEvents;
end;

destructor TCustomElementBehavior.Destroy;
begin
  FreeAndNil(FComComponentReference);
  FreeAndNil(FViewLink);
  FElementEvents := nil;
  FElementEventsHolder := nil;
  FBehaviorSite := nil;
  inherited;
end;

function TCustomElementBehavior.GetViewLink: TCustomHTMLDocumentFragment;
begin
  if not Assigned(FViewLink) and not Assigned(FInternalViewLink) then
  begin
    if IsReadOnly then
    begin
      FViewLink := TCustomHTMLDocumentFragment.Create(nil);
      FViewLink.SetSubComponent(True);
      FViewLink.Name := 'InternalHTMLDocumentFragment';  { do not localize }
      FViewLink.Behavior := Self;
      FInternalViewLink := FViewLink;
    end;
  end;
  Result := FViewLink;
end;

function TCustomElementBehavior.GetInterfaceSafetyOptions(const IID: TGUID;
  pdwSupportedOptions, pdwEnabledOptions: PDWORD): HRESULT;
var
 Unk: IUnknown;  
begin
  if (pdwSupportedOptions = nil) or (pdwEnabledOptions = nil) then
  begin
    Result := E_POINTER;
    Exit;
  end;
  Result := QueryInterface(IID, Unk);
  if Result = S_OK then
  begin
    pdwSupportedOptions^ := INTERFACESAFE_FOR_UNTRUSTED_CALLER or
      INTERFACESAFE_FOR_UNTRUSTED_DATA;
    pdwEnabledOptions^ := FObjectSafetyFlags and (INTERFACESAFE_FOR_UNTRUSTED_CALLER or
      INTERFACESAFE_FOR_UNTRUSTED_DATA);
  end
  else
  begin
    pdwSupportedOptions^ := 0;
    pdwEnabledOptions^ := 0;
  end;
end;

function TCustomElementBehavior.SetInterfaceSafetyOptions(const IID: TGUID;
  dwOptionSetMask, dwEnabledOptions: Cardinal): HRESULT;
var
 Unk: IUnknown;
begin
  Result := QueryInterface(IID, Unk);
  if Result <> S_OK then exit;
  FObjectSafetyFlags := dwEnabledOptions and dwOptionSetMask;
end;

function TCustomElementBehavior.GetTextDescent(
  out plDescent: Integer): HRESULT;
begin
  Result := S_OK;
end;

function TCustomElementBehavior.GetIsReadOnly: Boolean;
begin
  Result := True; // Has a viewlink by default
end;

{ TCustomPaintedBehavior }

procedure TCustomPaintedBehavior.DoCanvasCreated;
begin
end;

destructor TCustomPaintedBehavior.Destroy;
begin
  FreeAndNil(FCanvas);
  inherited;
end;

function TCustomPaintedBehavior.Detach: HRESULT;
begin
  Result := inherited Detach;
  if (Result = S_OK) and Assigned(FPaintSite) then
                                                                                                        
    Result := FPaintSite.InvalidateRect(nil);
  FPaintSite := nil;
  FreeAndNil(FCanvas);
end;

function TCustomPaintedBehavior.DoDraw(const BoundsRect, UpdateRect: tagRECT;
  const DrawFlags: TPainterDrawFlags; DrawObject: Pointer): HRESULT;
begin
  { From: Using Rendering Behaviors
    URL : http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/editing/imprendbehav.asp
    Note  A rendering behavior does not render itself all at once. It renders
          itself in multiple horizontal bands or sections, using multiple calls
          to IHTMLPainter::Draw. The top left corner of each band is the origin
          of the device context, which means that the top value of rcBounds is
          frequently negative.

         It might not be necessary to redraw the entire rcBounds area when
         MSHTML calls IHTMLPainter::Draw. The rcUpdate parameter is the actual
         area that needs to be updated in any call to IHTMLPainter::Draw. Its
         coordinates are given with respect to the device context, just like the
         rcBounds rectangle. You can gain efficiency by limiting your drawing to
         this update area. }
  Result := S_OK;
  if Assigned(FOnDraw) then
    FOnDraw(Self, BoundsRect, UpdateRect, DrawFlags, DrawObject, Result);
end;

function TCustomPaintedBehavior.DoGetEventTarget(
  var ppElement: IHTMLElement): HRESULT;
begin
  Result := S_OK;
  if Assigned(FOnGetEventTarget) then
    FOnGetEventTarget(Self, ppElement, Result);
end;

function TCustomPaintedBehavior.DoSetCursor(lPartID: Integer): HRESULT;
begin
  Result := S_OK;
  if Assigned(FOnResize) then
    FOnSetCursor(Self, lPartID, Result);
end;

function TCustomPaintedBehavior.Draw(rcBounds, rcUpdate: tagRECT;
  lDrawFlags: Integer; hdc: HDC; pvDrawObject: Pointer): HRESULT;
begin
  if not Assigned(FCanvas) then
  begin
    FCanvas := TCanvas.Create;
    DoCanvasCreated;
  end;
  FCanvas.Handle := hdc;
  try
(*   FillChar(FDrawInfo, SizeOf(FDrawInfo), 0);
    OleCheck(PaintSite.GetDrawInfo(HTMLPAINT_DRAWINFO_VIEWPORT or
      HTMLPAINT_DRAWINFO_UPDATEREGION {or HTMLPAINT_DRAWINFO_XFORM}, FDrawInfo));*)
    Result := DoDraw(rcBounds, rcUpdate, TPainterDrawFlags(lDrawFlags), pvDrawObject);
  finally
    FCanvas.Handle := 0;
  end;
end;

function TCustomPaintedBehavior.GetEventInfoFlags(
  out plEventInfoFlags: Integer): HRESULT;
begin
  plEventInfoFlags := 0;
  if Assigned(FOnGetEventTarget) then
    plEventInfoFlags := HTMLPAINT_EVENT_TARGET;
  if Assigned(FOnSetCursor) then
    plEventInfoFlags := plEventInfoFlags or HTMLPAINT_EVENT_SETCURSOR;
  Result := S_OK;
end;

function TCustomPaintedBehavior.GetEventTarget(
  var ppElement: IHTMLElement): HRESULT;
begin
  Result := S_OK;
end;

function TCustomPaintedBehavior.GetPainterInfo(
  out pInfo: _HTML_PAINTER_INFO): HRESULT;
const
  PaintFlags: array[TPainterFlag] of Integer = (HTMLPAINTER_OPAQUE,
    HTMLPAINTER_TRANSPARENT, HTMLPAINTER_ALPHA, HTMLPAINTER_COMPLEX,
    HTMLPAINTER_OVERLAY, HTMLPAINTER_HITTEST, HTMLPAINTER_SURFACE,
    HTMLPAINTER_3DSURFACE, HTMLPAINTER_NOBAND, HTMLPAINTER_NODC,
    HTMLPAINTER_NOPHYSICALCLIP, HTMLPAINTER_NOSAVEDC, HTMLPAINTER_SUPPORTS_XFORM,
    HTMLPAINTER_EXPAND, HTMLPAINTER_NOSCROLLBITS);
  ZOrder: array[TPaintZOrder] of Integer = (HTMLPAINT_ZORDER_NONE,
    HTMLPAINT_ZORDER_REPLACE_ALL, HTMLPAINT_ZORDER_REPLACE_CONTENT,
    HTMLPAINT_ZORDER_REPLACE_BACKGROUND, HTMLPAINT_ZORDER_BELOW_CONTENT,
    HTMLPAINT_ZORDER_BELOW_FLOW, HTMLPAINT_ZORDER_ABOVE_FLOW,
    HTMLPAINT_ZORDER_ABOVE_CONTENT, HTMLPAINT_ZORDER_WINDOW_TOP);
var
  I: TPainterFlag;
begin
  Result := S_OK;
  for I := Low(TPainterFlag) to High(TPainterFlag) do
    if I in PainterFlags then
      pInfo.lFlags := pInfo.lFlags or PaintFlags[I];
  pInfo.lZOrder := ZOrder[FPaintZOrder];
  pInfo.iidDrawObject := FDrawObject;
  pInfo.rcExpand := FExpandRect;
  if Assigned(FOnGetPainterInfo) then
    FOnGetPainterInfo(Self, pInfo, Result);
end;

function TCustomPaintedBehavior.HitTestPoint(pt: MSHTML.tagPOINT; out pbHit,
  plPartID: Integer): HRESULT;
begin
  // MSHTML calls this method when calls are made to such methods as
  // IHTMLDocument2::elementFromPoint or IHTMLElement2::componentFromPoint
  // that need to determine how a point relates to the elements in a document's
  // object tree.
  if (pbHit = 0) or (plPartID = 0) then
    Result := E_POINTER
  else
    Result := E_NOTIMPL;
  if Assigned(FOnHitTestPoint) then
    FOnHitTestPoint(Self, pt, pbHit, PlPartID, Result);
end;

function TCustomPaintedBehavior.Init(
  const pBehaviorSite: IElementBehaviorSite): HRESULT;
begin
  Result := inherited Init(pBehaviorSite);
  // Store off the IPaintSite which can be used to invalidate when the
  // behavior is detached
  if Result = S_OK then
    Supports(pBehaviorSite, IHTMLPaintSite, FPaintSite);
end;

procedure TCustomPaintedBehavior.Initialize;
begin
  inherited;
  FPainterFlags := [pfOpaque, pfNoPhysicalClip];
  FPaintZOrder := pzWindowTop;
  FExpandRect := Rect(0,0,0,0);
  FDrawObject := GUID_NULL;
end;

procedure TCustomPaintedBehavior.InvalidatePainterInfo;
begin
  // Used to cause GetPainterInfo to be called again by MSHTML
  if Assigned(PaintSite) then
    PaintSite.InvalidatePainterInfo;
end;

function TCustomPaintedBehavior.onresizeevent(size: MSHTML.tagSIZE): HRESULT;
begin
                                                                                         
  Result := S_OK;
  if Assigned(FOnResize) then
    FOnResize(Self, size, Result);
end;

function TCustomPaintedBehavior.SetCursor(lPartID: Integer): HRESULT;
begin
  Result := DoSetCursor(lPartID);
end;

function TCustomPaintedBehavior.StringFromPartID(lPartID: Integer;
  out pbstrPart: WideString): HRESULT;
begin
                                                                                  
  Result := S_OK;
end;

{ TCustomBinaryElementBehavior }

function TCustomBinaryElementBehavior._create(
  const pNamespace: IElementNamespace): HResult;
begin
  Result := S_OK;
end;

function TCustomBinaryElementBehavior.CreateWithImplementation(
  const pNamespace: IElementNamespace;
  const bstrImplementation: WideString): HRESULT;
begin
  Result := S_OK;
end;

function TCustomBinaryElementBehavior.FindBehavior(const bstrBehavior,
  bstrBehaviorUrl: WideString; const pSite: IElementBehaviorSite;
  out ppBehavior: IElementBehavior): HRESULT;
begin
  Result := S_OK;
end;

{ TGridInfo }

procedure TGridInfo.SetGridSizeX(const Value: Integer);
begin
  if FGridsizeX <> Value then
  begin
    FGridsizeX := Value;
    InvalidateGrid;
  end;
end;

procedure TGridInfo.InvalidateGrid;
begin
  if Assigned(FOnInvalidateGrid) then
    FOnInvalidateGrid(Self);
end;

procedure TGridInfo.SetGridSizeY(const Value: Integer);
begin
  if FGridsizeY <> Value then
  begin
    FGridsizeY := Value;
    InvalidateGrid;
  end;
end;

procedure TGridInfo.SetShowGrid(const Value: Boolean);
begin
  if FShowGrid <> Value then
  begin
    FShowGrid := Value;
    InvalidateGrid;
  end;
end;

function TGridInfo.IsCustomContainer(
  Element: IHTMLElement): Boolean;
begin
  Result := False;
  if Assigned(FOnGetIsCustomContainer) then
    FOnGetIsCustomContainer(Self, Element, Result)
end;

constructor TGridInfo.Create;
begin
  FGridsizeX := 9;
  FGridsizeY := 9;
  FShowGrid := True;
end;

{ TCustomBGColorBehavior }

destructor TCustomBGColorBehavior.Destroy;
begin
  if Assigned(FHTMLEditHost) then
    FHTMLEditHost.FGridBehavior := nil;
  inherited;
end;

function TCustomBGColorBehavior.DoDetach: HRESULT;
begin
  Result := inherited DoDetach;
  SetLength(FExcludeRects, 0);
end;

// {$DEFINE DEBUGDODRAW}
function TCustomBGColorBehavior.DoDraw(const BoundsRect, UpdateRect: tagRECT;
  const DrawFlags: TPainterDrawFlags; DrawObject: Pointer): HRESULT;
const
  XorColor = $00FFD8CE;
var
  Document: IHTMLDocument2;
  R: TRect;
  I: Integer;
  E: IHTMLElement;
  EUnk: IUnknown;
  Len: Integer;
  Col: IHTMLElementCollection;
  MC: IMarkupContainer2;
  RectCount: Integer;
  Default: Boolean;
  HTMLElementRect: IHTMLRect;
  ScrollTop, ScrollLeft: Integer;
begin
  Result := inherited DoDraw(BoundsRect, UpdateRect, DrawFlags, DrawObject);
  if (Result <> S_OK) then exit;

{$IFDEF DEBUGDODRAW}
OutputDebugString('BEGIN DoDraw');
OutputDebugString(PAnsiChar(Format('  Element tag: %s SourceIndex: %d', [
  Element.tagName, Element.SourceIndex])));
OutputDebugString(PAnsiChar(Format('  BoundsRect top:%d left: %d right: %d bottom: %d',
  [BoundsRect.top, BoundsRect.left, BoundsRect.right, BoundsRect.bottom])));
OutputDebugString(PAnsiChar(Format('  UpdateRect top:%d left: %d right: %d bottom: %d',
  [UpdateRect.top, UpdateRect.left, UpdateRect.right, UpdateRect.bottom])));
with (Element as IHTMLElement2).getBoundingClientRect do
  OutputDebugString(PAnsiChar(Format('  ClientRect top: top:%d left: %d right: %d bottom: %d',
    [top, left, right, bottom])));
{$ENDIF}
  Document := Element.document as IHTMLDocument2;
  MC := Document as IMarkupContainer2;
  if FDocVersion <> MC.GetVersionNumber then
  begin
    FDocVersion := MC.GetVersionNumber;
    Col := Element.all as IHTMLElementCollection;
    Len := Col.length;
    SetLength(FExcludeRects, Len);
    RectCount := 0;
    EUnk := Element as IUnknown;
    Default := True;
    for I := 0 to Len - 1 do
    begin
      E := Col.item(I, I) as IHTMLElement;
      if ExcludeElementRect(EUnk, E, Default) then
      begin
        FExcludeRects[RectCount] := E;
        Inc(RectCount);
      end;
    end;
    SetLength(FExcludeRects, RectCount);
  end;

  for I := 0 to Length(FExcludeRects) - 1 do
  begin
    HTMLElementRect := (FExcludeRects[I] as IHTMLElement2).getBoundingClientRect;
    with HTMLElementRect do
      R := Rect(left, top, right, bottom);
                                               
    OffsetRect(R, -2, -2);  // Difference between html element client and actual client
    ScrollTop := (Document.Body as IHTMLelement2).scrollTop;
    ScrollLeft := (Document.Body as IHTMLelement2).scrollLeft;
    OffsetRect(R, ScrollLeft, ScrollTop);
    OffsetRect(R, BoundsRect.Left, BoundsRect.Top);
    // +2 Account for margin on content elements
    ExcludeClipRect(Canvas.Handle, R.Left+2, R.Top+2, R.Right, R.Bottom);
  end;

  DrawBackground(BoundsRect, UpdateRect, DrawFlags, DrawObject, Document);

  if ShowMessage then
    DrawMessage(BoundsRect, Document);
  SelectClipRgn(Canvas.Handle, 0);
  Result := S_OK;
{$IFDEF DEBUGDODRAW}
OutputDebugString('END DoDraw');
{$ENDIF}
end;

procedure TCustomBGColorBehavior.DrawMessage(BoundsRect: TRect; Document: IHTMLDocument2);
var
  E2: IHTMLElement2;
  Msg: String;
  TextRect: TRect;
  DoDefault: Boolean;
  MSPositioning: OleVariant;
  MsgTextColor: TColor;
  MsgFontStyle: TFontStyles;
  ElementCollection: IHTMLElementCollection;
begin
  DoDefault := True;
  Msg := '';
  MsgTextColor := clGrayText;
  MsgFontStyle := [];
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := clWhite;
  if Assigned(FOnGetMessageInfo) then
    FOnGetMessageInfo(Self, Msg, MsgTextColor, MsgFontStyle, DoDefault);
  if DoDefault then
  begin
    Supports(Document.body.all, IHTMLElementCollection, ElementCollection);
    if (ElementCollection <> nil) and (((Document.body.all as IHTMLElementCollection).length > 0) or
       ((Document.body as IHTMLElement).innerText <> '')) and
       not ((ElementCollection.length = 1) and Supports(ElementCollection.item(0, 0), IHTMLFormElement) and
       ((ElementCollection.item(0, 0) as IHTMLElement).innerText = '')) then exit;
    with Document.Body as IHTMLElement do
      MSPositioning := Element.getAttribute(sMSPositioning, 0);
    if (Msg = '') then
      if IsGridPositioning(MSPositioning) then
        Msg := sGridLayout
      else
      begin
        if CanChangeLayoutMode then
          Msg := sFlowLayout
        else
          Msg := sFlowLayoutFixed;
        Canvas.Brush.Style := bsClear;
      end;
  end;
  if Length(Msg) > 0 then
  begin
    Canvas.Font.Color := MsgTextColor;
    Canvas.Font.Style := MsgFontStyle;
    E2 := Element2;
    TextRect := Rect(25, 0, BoundsRect.Right - E2.scrollLeft - 25, BoundsRect.Bottom);
    DrawText(Canvas.Handle, PChar(Msg), Length(Msg), TextRect, DT_CALCRECT or DT_CENTER or DT_WORDBREAK);
    OffsetRect(TextRect, E2.clientWidth div 2 - TextRect.Right div 2,
      (E2.scrollTop + E2.ClientHeight div 2 + BoundsRect.Top) - (TextRect.Bottom - TextRect.Top) div 2);
    DrawText(Canvas.Handle, PChar(Msg), Length(Msg), TextRect, DT_CENTER or DT_WORDBREAK);
  end;
end;

function TCustomBGColorBehavior.GetPainterInfo(out pInfo: _HTML_PAINTER_INFO): HRESULT;
begin
  pInfo.lFlags := HTMLPAINTER_TRANSPARENT;//HTMLPAINTER_OPAQUE or HTMLPAINTER_HITTEST;//HTMLPAINTER_TRANSPARENT;
//  pInfo.lZOrder :=  HTMLPAINT_ZORDER_REPLACE_BACKGROUND;//HTMLPAINT_ZORDER_WINDOW_TOP;//TMLPAINT_ZORDER_ABOVE_CONTENT;//HTMLPAINT_ZORDER_REPLACE_BACKGROUND;//HTMLPAINT_ZORDER_BELOW_CONTENT;
  pInfo.lZOrder := HTMLPAINT_ZORDER_ABOVE_FLOW;//HTMLPAINT_ZORDER_BELOW_CONTENT;
  pInfo.iidDrawObject := GUID_NULL;

  pInfo.rcExpand.left := 0;
  pInfo.rcExpand.right := 0;
  pInfo.rcExpand.top := 0;
  pInfo.rcExpand.bottom := 0;

  Result := S_OK;
end;

procedure TCustomBGColorBehavior.Initialize;
begin
  inherited;
  FShowMessage := True;
end;

function TCustomBGColorBehavior.onresizeevent(size: MSHTML.tagSIZE): HRESULT;
begin
  Result := S_OK;
end;

{procedure TCustomBGColorBehavior.SetActive(const Value: Boolean);
var
  BehaviorFactory: OleVariant;
begin
  inherited;
  if Active then
  begin
    BehaviorFactory := Factory as IElementBehaviorFactory;
    if Assigned(FBehavior.Element.parentElement.document.Document2.body) then
    begin
      Factory.AddBehavior(Factory.WebBrowser.Document2.body as IHTMLElement2, Self);
      if Assigned(PaintSite) then
        PaintSite.InvalidateRect(nil);
    end;
  end;
end;}

procedure TCustomBGColorBehavior.SetShowMessage(const Value: Boolean);
begin
  if FShowMessage <> Value then
  begin
    FShowMessage := Value;
    Refresh;
  end;
end;

function TCustomBGColorBehavior.ExcludeElementRect(const EUnk: IUnknown;
  const E: IHTMLElement; var DoDefault: Boolean): Boolean;
begin
  if Assigned(FOnExcludeElementRect) then
    Result := FOnExcludeElementRect(Self, E, DoDefault)
  else
    Result := False;
end;

procedure TCustomBGColorBehavior.Refresh;
begin
//noop
end;

{ TCustomGridBehavior }

destructor TCustomGridBehavior.Destroy;
begin
  inherited;
  if FOwnsInfo then
    FGridInfo.Free;
end;

function TCustomGridBehavior.DisplayGrid: Boolean;
var
  MSPositioning: OleVariant;
  HasGrid: OleVariant;
begin
//  Result := True;
//  if Supports(Element, IHTMLBodyElement) then
  begin
    MSPositioning := Element.getAttribute(sMSPositioning, 0);
    with Element as IHTMLElement2 do
      HasGrid := runtimestyle.getAttribute(sHasGrid, 0);
    Result := ShowGrid and IsGridPositioning(MSPositioning) and
      (Supports(Element, IHTMLBodyElement) or (not VarIsNull(HasGrid)));
  end;
end;

function TCustomGridBehavior.GetInfo: TGridInfo;
begin
  if FGridInfo = nil then
  begin
    FOwnsInfo := True;
    FGridInfo := TGridInfo.Create;
  end;
  Result := FGridInfo;
end;

procedure TCustomGridBehavior.SetInfo(
  AGridInfo: TGridInfo);
begin
  if FGridInfo <> AGridInfo then
  begin
    if FGridInfo <> nil then
      if FOwnsInfo then
        FGridInfo.Free;
    FGridInfo := AGridInfo;
    FOwnsInfo := False;
  end;
end;

procedure TCustomGridBehavior.DrawAlphaBlend(rt: TRect; hdcwnd: HDC);
var
  BlendFn: BLENDFUNCTION;
  BmpInfo: BITMAPINFO;
  DC: HDC;
  OldHBmp, HBmp: HBITMAP;
  pvBits : pointer;
begin
  DC := CreateCompatibleDC(hdcwnd);
  HBmp := 0;
  OldHBmp := 0;
  try
    ZeroMemory(@BmpInfo, sizeof(BITMAPINFO));

    BmpInfo.bmiHeader.biSize := sizeof(BITMAPINFOHEADER);
    BmpInfo.bmiHeader.biWidth := rt.Right - rt.Left;
    BmpInfo.bmiHeader.biHeight := rt.Bottom - rt.Top;
    BmpInfo.bmiHeader.biPlanes := 1;
    BmpInfo.bmiHeader.biBitCount := 32;
    BmpInfo.bmiHeader.biCompression := BI_RGB;
    BmpInfo.bmiHeader.biSizeImage := BmpInfo.bmiHeader.biWidth * BmpInfo.bmiHeader.biHeight;

    HBmp := CreateDIBSection(DC, BmpInfo, DIB_RGB_COLORS, pvBits, 0, 0);
    OldHBmp := SelectObject(DC, HBmp);

    BlendFn.BlendOp := AC_SRC_OVER;
    BlendFn.BlendFlags := 0;
    BlendFn.AlphaFormat := 0;
    BlendFn.SourceConstantAlpha := $30;

    AlphaBlend(hdcwnd, rt.Left, rt.Top, BmpInfo.bmiHeader.biWidth, BmpInfo.bmiHeader.biHeight,
      DC, 0, 0, BmpInfo.bmiHeader.biWidth, BmpInfo.bmiHeader.biHeight, BlendFn);
  finally
    if OldHBmp <> 0 then
      SelectObject(DC, OldHBmp);
    if HBmp <> 0 then
      DeleteObject(HBmp);
    DeleteDC(DC);
  end;
end;

procedure TCustomGridBehavior.DrawBackground(const BoundsRect,
  UpdateRect: TRect; const DrawFlags: TPainterDrawFlags; DrawObject: Pointer;
  const Document: IHTMLDocument2);
var
  X, Y: Integer;
  Offset: Integer;
  E: IHTMLElement;
  E2: IHTMLElement2;
  SLeft: Integer;
  EScrollLeft: Integer;
begin
  inherited;
  // DoDraw is called multiple times and paints in bands therefore we need to be sure
  // to offset the current "band" by whatever amount was left over from the
  // previous call
                                                   
  if DisplayGrid then
  begin
    if BoundsRect.Top < 0 then
    begin
      Y := UpdateRect.Top + GridInfo.GridSizeY - Abs(BoundsRect.Top) mod GridInfo.GridSizeY;
      if Y = GridInfo.GridSizeY then Y := 0;
    end
    else
      Y := UpdateRect.Top + GridInfo.GridSizeY;
    Offset := 0;
    E := Element;
    while Assigned(E) do
    begin
      Inc(Offset, E.offsetLeft);
      E := E.offsetParent;
    end;
    SLeft := 0;
    if Supports(Document.body, IHTMLElement2, E2) then
      SLeft := E2.scrollLeft - E2.clientLeft;
    EScrollLeft := (Element as IHTMLElement2).scrollLeft;
    while Y < UpdateRect.bottom do
    begin
      if EScrollLeft <> 0 then
      begin
        X := UpdateRect.Left + GridInfo.GridSizeX - Abs(Offset - UpdateRect.Left) -
             (SLeft mod GridInfo.GridSizeX);
        if (X = GridInfo.GridSizeX) then
          X := 0;
      end
      else
        X := Offset - SLeft + GridInfo.GridSizeX;
      while X < UpdateRect.right do
      begin
        Canvas.Pixels[X, Y] := clBlack;//XorColor;
        Inc(X, GridInfo.GridSizeX);
      end;
      Inc(Y, GridInfo.GridSizeY);
    end;
  end;
  if IsContentPage then
    DrawAlphaBlend(UpdateRect, Canvas.Handle);
end;

function TCustomGridBehavior.ExcludeElementRect(const EUnk: IUnknown;
  const E: IHTMLElement; var DoDefault: Boolean): Boolean;
const
  sContentTag = 'content';
  sContentScope = 'asp';
begin
  if IsContentPage then
begin
                                                         
    // Excluding the entire content control is not correct because it does not allow an
    // properly paint an HTML grid panel in a content area.
    Result := False;
    if SameText(E.TagName, sContentTag) then
      if SameText((E as IHTMLElement2).scopeName, sContentScope) then
        Result := True;
    Exit;
  end;
  Result := inherited ExcludeElementRect(EUnk, E, DoDefault);
  if Result or not DoDefault then exit;
  if (Supports(E, IHTMLTable) or Supports(E, IHTMLDivElement) or
      Supports(E, IHTMLImgElement) or GridInfo.IsCustomContainer(E)) and
     ((E.offsetParent as IUnknown) = EUnk) then
    Result := True;
end;

function TCustomGridBehavior.GetGridsizeX: Integer;
begin
  Result := GridInfo.GridSizeX;
end;

function TCustomGridBehavior.GetGridsizeY: Integer;
begin
  Result := GridInfo.GridSizeY;
end;

function TCustomGridBehavior.GetShowGrid: Boolean;
begin
  Result := GridInfo.ShowGrid;
end;

procedure TCustomGridBehavior.SetGridSizeX(const Value: Integer);
begin
  GridInfo.GridSizeX := Value;
end;

procedure TCustomGridBehavior.SetGridSizeY(const Value: Integer);
begin
  GridInfo.GridSizeY := Value;
end;

procedure TCustomGridBehavior.SetShowGrid(const Value: Boolean);
begin
  GridInfo.ShowGrid := Value;
end;

function TCustomGridBehavior.GetOnGetIsCustomContainer: TGetIsCustomContainerEvent;
begin
  Result := GridInfo.OnGetIsCustomContainer;
end;

procedure TCustomGridBehavior.SetOnGetIsCustomContainer(
  const Value: TGetIsCustomContainerEvent);
begin
  GridInfo.OnGetIsCustomContainer := Value;
end;

procedure TCustomGridBehavior.InvalidateGrid(Sender: TObject);
begin
  if Assigned(PaintSite) then
    PaintSite.InvalidateRect(nil);
end;

procedure TCustomGridBehavior.Refresh;
begin
  inherited;
  InvalidateGrid(nil);
end;

{ TCustomBehaviorWrapper }

constructor TCustomBehaviorWrapper.Create(AOwner: TComponent);
begin
  inherited;
  FTags := TStringList.Create;
end;

destructor TCustomBehaviorWrapper.Destroy;
begin
  if Assigned(FFactory) then
    FFactory.UnRegisterBehavior(Self);
  FreeAndNil(FTags);
  inherited;
end;

function TCustomBehaviorWrapper.CreateBehavior: IElementBehavior;
var
  Behavior: TCustomElementBehavior;
begin
  Result := nil;
  if Assigned(FOnCreateBehavior) then
  begin
    FOnCreateBehavior(Self, Behavior);
    Supports(Behavior, IElementBehavior, Result);
  end;
  if not Assigned(Result) then
  try
    Result := CreateObject as IElementBehavior;
  except
   on E:EOleSysError do
      raise Exception.CreateFmt(sErrorCreatingBehavior, [Classname, E.Message]);
  end;
end;

procedure TCustomBehaviorWrapper.DoCreated(const ComObj: TWrappedComObject);
begin
  inherited DoCreated(ComObj);
  if FAttachedBehavior then
    FBehavior := ComObj as TCustomElementBehavior;
  if Assigned(FOnBehaviorCreated) then
    FOnBehaviorCreated(Self, ComObj as TCustomElementBehavior);
end;

function TCustomBehaviorWrapper.DoContentReady(Behavior: TCustomElementBehavior): HRESULT;
begin
  Result := S_OK;
  if Assigned(FOnContentReady) then
    FOnContentReady(Self, Behavior, Result);
end;

function TCustomBehaviorWrapper.DoContentSave(Behavior: TCustomElementBehavior): HRESULT;
begin
  Result := S_OK;
  if Assigned(FOnContentSave) then
    FOnContentSave(Self, Behavior, Result);
end;

function TCustomBehaviorWrapper.DoControlSelect(Behavior: TCustomElementBehavior): HRESULT;
begin
  Result := S_OK;
  if Assigned(FOnControlSelect) then
    FOnControlSelect(Self, Behavior, Result);
end;

procedure TCustomBehaviorWrapper.DoDestroy(const ComObj: TWrappedComObject);
begin
  inherited;
  if Assigned(FOnBehaviorDestroy) then
    FOnBehaviorDestroy(Self, ComObj as TCustomElementBehavior);
end;

function TCustomBehaviorWrapper.DoDetach(Behavior: TCustomElementBehavior): HRESULT;
begin
  Result := S_OK;
  if Assigned(FOnDetach) then
    FOnDetach(Self, Behavior, Result);
end;

function TCustomBehaviorWrapper.DoDocumentContextChange(Behavior: TCustomElementBehavior): HRESULT;
begin
  Result := S_OK;
  if Assigned(FOnDocumentContextChange) then
    FOnDocumentContextChange(Self, Behavior, Result);
end;

function TCustomBehaviorWrapper.DoDocumentReady(Behavior: TCustomElementBehavior): HRESULT;
begin
  Result := S_OK;
  if Assigned(FOnDocumentReady) then
    FOnDocumentReady(Self, Behavior, Result);
end;

function TCustomBehaviorWrapper.DoInit(Behavior: TCustomElementBehavior; const pBehaviorSite: IElementBehaviorSite): HRESULT;
begin
  Result := S_OK;
  if Assigned(FOnInit) then
    FOnInit(Self, Behavior, pBehaviorSite, Result);
end;

function TCustomBehaviorWrapper.DoNotify(Behavior: TCustomElementBehavior; lEvent: Integer; var pVar: OleVariant): HRESULT;
begin
  Result := S_OK;
  if Assigned(FOnNotify) then
    FOnNotify(Self, Behavior, lEvent, pVar, Result);
end;

function TCustomBehaviorWrapper.GetComClass: TComClass;
begin
  Result := TCustomElementBehavior;
  if Assigned(OnGetComClass) then
    OnGetComClass(Self, Result);
end;

procedure TCustomBehaviorWrapper.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FFactory) then
    FFactory := nil;
end;

procedure TCustomBehaviorWrapper.SetFactory(
  const Value: TCustomElementBehaviorFactory);
begin
  if FFactory <> Value then
  begin
    if Assigned(FFactory) then
    begin
      FFactory.RemoveFreeNotification(Self);
      FFactory.UnRegisterBehavior(Self);
    end;
    FFactory := Value;
    if Assigned(FFactory) then
    begin
      FFactory.FreeNotification(Self);
      FFactory.RegisterBehavior(Self);
    end;
  end;
end;

procedure TCustomBehaviorWrapper.SetTags(const Value: TStringList);
begin
  if FTags <> Value then
    FTags.Assign(Value);
end;

procedure TCustomBehaviorWrapper.AddBehavior(URL: string; Element: IHTMLElement);
var
  E: IHTMLElement2;
begin
  if Supports(Element, IHTMLElement2, E) then
    AddBehavior(URL, E);
end;

procedure TCustomBehaviorWrapper.AddBehavior(URL: string; Element: IHTMLElement2);
var
  AFactory: OleVariant;
  Cookie: Integer;
begin
  if Assigned(Element) then
    if Assigned(Factory) then
    begin
      FAttachedBehavior := True;
      try
        AFactory := Factory as IElementBehaviorFactory;
        Cookie := Element.addBehavior(URL, AFactory);
        if Assigned(FBehavior) then
        begin
          FBehavior.FIsAttached := True;
          FBehavior.FCookie := Cookie;
          FBehavior := nil;
        end;
      finally
        FAttachedBehavior := False;
      end;
    end;
end;

function TCustomBehaviorWrapper.RemoveBehavior(
  Behavior: TCustomElementBehavior): Boolean;
begin
  Result := False;
  if Assigned(Behavior) and Assigned(Behavior.Element2) then
  begin
    Behavior.FIsAttached := False;
    Result := Behavior.Element2.removeBehavior(Behavior.Cookie);
  end;
end;

procedure TCustomBehaviorWrapper.AddBehavior(Element: IHTMLElement);
begin
  AddBehavior('#factory#' + URL, Element);
end;

procedure TCustomBehaviorWrapper.AddBehavior(Element: IHTMLElement2);
begin
  AddBehavior('#factory#' + URL, Element);
end;

function TCustomBehaviorWrapper.SupportsNamespace(
  const ANamespace, AURL, ALongURL: string): Boolean;
begin
                                         
                                                    
  Result := ((Length(Namespace) = 0) or
            (CompareText(Namespace, ANamespace) = 0)) and
            ((Length(URL) > 0) and (CompareText(URL, AURL) = 0) or
             (Length(URL) = 0)  {(Tags.IndexOf(bstrBehavior) <> -1)});
  if Assigned(FOnSupportsNamespace) then
    FOnSupportsNamespace(Self, ANamespace, AURL, ALongURL, Result);
end;

{ TCustomElementBehaviorFactory }

constructor TCustomElementBehaviorFactory.Create(AOwner: TComponent);
begin
  inherited;
  FBehaviors := TList.Create;
  FServiceGUID := IID_IElementBehaviorFactory;
end;

destructor TCustomElementBehaviorFactory.Destroy;
begin
  FreeAndNil(FBehaviors);
  inherited;
end;

procedure TCustomElementBehaviorFactory.AddBehavior(Element: IHTMLElement2;
  Behavior: TCustomElementBehavior);
var
  Factory: OleVariant;
  I: OleVariant;
begin
  if Element = nil then
    raise Exception.Create(sAttachToNilElement);
  I := 0;
  Factory := Self as IElementBehaviorFactory;
  Behavior.FCookie := Element.addBehavior('#factory#' + Behavior.Behavior, Factory); { do not localize }
end;

procedure TCustomElementBehaviorFactory.Delete(Behavior: TCustomElementBehavior;
  AllowUndo: Boolean);
var
  Behaviors: TBehaviorArray;
begin
  SetLength(Behaviors, 1);
  Behaviors[0] := Behavior;
  Delete(Behaviors, AllowUndo);
end;

procedure TCustomElementBehaviorFactory.Delete(BehaviorsArray: TBehaviorArray;
  AllowUndo: Boolean);
var
  I: Integer;
  ControlRange: IHTMLControlRange2;
begin
  CheckDocumentAssigned;
  for I := 0 to Length(BehaviorsArray) - 1 do
    if AllowUndo then
    begin
      with WebBrowser.Document2.body as IHTMLElement2 do
        ControlRange := createControlRange as IHTMLControlRange2;
      ControlRange.addElement(BehaviorsArray[I].Element as IHTMLElement);
    end
    else
    begin
      BehaviorsArray[I].Element.innerText := '';    { do not localize }
      WebBrowser.MarkupServices.RemoveElement(BehaviorsArray[I].Element);
    end;

  if AllowUndo and Assigned(ControlRange) then
    with ControlRange as IHTMLControlRange do
    begin
      select;
      execCommand('Cut', False, EmptyParam)   { do not localize }
    end;
end;

                                                                                

{ From MSDN: "Specify the case of the bstrBehavior parameter to be all
  caps when using this method with element behaviors; for attached behaviors
  specify the bstrBehavior parameter in lower case. Because the bstrBehavior
  parameter has a specific case, based on the type of behavior, it is necessary
  to take precautions when this parameter is used in a string comparison:
  either the case of the string should be forced or a case–insensitive
  comparison should be used." }
function TCustomElementBehaviorFactory.FindBehavior(const bstrBehavior,
  bstrBehaviorUrl: WideString; const pSite: IElementBehaviorSite;
  out ppBehavior: IElementBehavior): HRESULT;
var
  I: Integer;
  E: IHTMLElement;
  Namespace: string;
  ActualBehavior, BW: TCustomBehaviorWrapper;
begin
  Result := E_NOTIMPL;
  // pSite parameter is nil for #default behaviors which is not documented
  // in the MSDN therefore the best we can do at this point is simply exit.
  if pSite = nil then exit;
  ppBehavior := nil;
  if Assigned(FBehaviors) then
  begin
    OleCheck(pSite.GetElement(E));
    Namespace := (E as IHTMLElement2).scopeName;
    ActualBehavior := nil;
    for I := 0 to FBehaviors.Count - 1 do
    begin
      BW := TCustomBehaviorWrapper(FBehaviors[I]);
      // jmt.!!! Allows a behavior to support multiple namespaces
      // if CompareText(Namespace, BW.Namespace) = 0 then
      if BW.SupportsNamespace(Namespace, bstrBehavior, bstrBehaviorUrl) then
      begin
        if Result = S_OK then
          raise Exception.CreateFmt(SFindBehaviorFoundTwoBehaviors, [ActualBehavior.Name,
            BW.Name, bstrBehavior]);
        ActualBehavior := BW;
        ppBehavior := BW.CreateBehavior;
        Result := S_OK;
      end;
    end;
  end;
                                                                                             
  if (Result <> S_OK) and Assigned(FOnFindBehavior) then
    FOnFindBehavior(Self, bstrBehavior, bstrBehaviorUrl, pSite, ppBehavior, Result);
end;

procedure TCustomElementBehaviorFactory.RegisterBehavior(
  Behavior: TCustomBehaviorWrapper);
begin
  if Behavior = nil then exit;
  if FBehaviors = nil then
    FBehaviors := TList.Create;
  FBehaviors.Add(Behavior);
end;

procedure TCustomElementBehaviorFactory.UnRegisterBehavior(
  Behavior: TCustomBehaviorWrapper);
var
  I: Integer;
begin
  if FBehaviors = nil then exit;
  I := FBehaviors.IndexOf(Behavior);
  if I = -1 then exit;
  FBehaviors.Delete(I);
end;

function TCustomElementBehaviorFactory._create(
  const pNamespace: IElementNamespace): HResult;
begin
  // Since this class implements IElementNamespaceFactory2 this method will
  // never be called in favor of CreateWithImplementation
  Result := S_OK;
end;

function TCustomElementBehaviorFactory.CreateWithImplementation(
  const pNamespace: IElementNamespace;
  const bstrImplementation: WideString): HRESULT;
begin
  Result := S_OK;
end;

function TCustomElementBehaviorFactory.Resolve(const bstrNamespace,
  bstrTagName, bstrAttrs: WideString;
  const pNamespace: IElementNamespace): HResult;
var
  I: Integer;
  BW: TCustomBehaviorWrapper;
begin
  // Dynamically add the tags to the namespace such that MSHTML will call
  // IElementBehaviorFactory.FindBehavior for each of the tags
  Result := S_OK;
  if Assigned(FOnResolve) then
    Result := DoResolve(bstrNamespace, bstrTagName, bstrAttrs, pNamespace)
  else
  begin
    for I := 0 to FBehaviors.Count - 1 do
    begin
      BW := TCustomBehaviorWrapper(FBehaviors[I]);
      if (CompareText(BW.Namespace, bstrNamespace) = 0) and
         (BW.Tags.IndexOf(bstrTagName) <> -1) then
        OleCheck(pNamespace.AddTag(bstrTagName, 0));
    end;
  end;
end;

function TCustomElementBehaviorFactory.DoResolve(const bstrNamespace,
  bstrTagName, bstrAttrs: WideString;
  const pNamespace: IElementNamespace): HRESULT;
begin
  Result := S_OK;
  if Assigned(FOnResolve) then
    FOnResolve(Self, bstrNamespace, bstrTagName, bstrAttrs, pNamespace, Result);
end;

procedure TCustomElementBehaviorFactory.Select(
  Behavior: TCustomElementBehavior);
var
  Behaviors: TBehaviorArray;
begin
  SetLength(Behaviors, 1);
  Behaviors[0] := Behavior;
  Select(Behaviors);
end;

procedure TCustomElementBehaviorFactory.Select(
  BehaviorsArray: TBehaviorArray);
var
  I: Integer;
  ControlRange: IHTMLControlRange2;
  Element2: IHTMLElement2;
  CmdState: TCommandStates;
begin
  CheckDocumentAssigned;
  if Length(BehaviorsArray) > 1 then
  begin
    CmdState := WebBrowser.CommandState(IDM_MULTIPLESELECTION);
    if not (csChecked in CmdState) then
      raise Exception.Create(sMultiSelectNotEnabled);
  end;
  for I := 0 to Length(BehaviorsArray) - 1 do
  begin
    if Element2 = nil then
    begin
      // ControlRange must belong to document of element.  When using ViewLinks there are multiple documents.
      Supports((BehaviorsArray[I].Element.document as IHTMLDocument2).body, IHTMLElement2, Element2);
      Assert(Element2 <> nil);
      ControlRange := Element2.createControlRange as IHTMLControlRange2;
    end;
    ControlRange.addElement(BehaviorsArray[I].Element as IHTMLElement);
  end;
  if Assigned(ControlRange) then
    (ControlRange as IHTMLControlRange).select;
end;

{ TGlyphTable }

procedure TGlyphTable.AddGlyph(TagID, GlyphLocation: string;
  TagType: TTagType; Alignment: TTagAlignment;
  Positioning: TTagPositioning; Direction: TTagDirection; Width,
  Height: Integer);
begin
  FGlyphTable := Format('%s%%%%%s^^%%%%%s^^%%%%%d^^%%%%%d^^%%%%%d^^%%%%%d^^%%%%%d^^%%%%%d^^%%%%%d^^%%%%%d^^**', { do not localize }
    [FGlyphTable, TagID, GlyphLocation, Ord(TagType), Ord(Alignment), Ord(Positioning),
     Ord(Direction), Width, Height, Width, Height]);
end;

procedure TGlyphTable.ClearTable;
begin
  SetLength(FGlyphTable, 0);
end;

{ TCustomHTMLEditHost }

constructor TCustomHTMLEditHost.Create(AOwner: TComponent);
begin
  inherited;
  FSnap := True;
  FServiceGUID := IID_IHTMLEditHost;
end;

function TCustomHTMLEditHost.GetGridSizeX: Integer;
begin
  if Assigned(FGridBehavior) then
    if ssCtrl in KeyboardStateToShiftState then
      Result := 1
    else
      Result := Grid.GridInfo.GridsizeX
  else
    Result := FGridSizeX;
end;

function TCustomHTMLEditHost.GetGridSizeY: Integer;
begin
  if Assigned(FGridBehavior) then
    if ssCtrl in KeyboardStateToShiftState then
      Result := 1
    else
      Result := Grid.GridInfo.GridsizeY
  else
    Result := FGridSizeY;
end;

function TCustomHTMLEditHost.PreDrag: HRESULT;
begin
  Result := S_OK;
end;

procedure TCustomHTMLEditHost.SetGridBehavior(const Value: TCustomGridBehavior);
begin
  if FGridBehavior <> Value then
  begin
    if Assigned(FGridBehavior) then
      FGridBehavior.FHTMLEditHost := nil;
    FGridBehavior := Value;
    if Assigned(FGridBehavior) then
    begin
      FGridBehavior.FHTMLEditHost := Self;
      FGridBehavior.GridInfo.GridSizeX := FGridSizeX;
      FGridBehavior.GridInfo.GridSizeY := FGridSizeY;
    end;
  end;
end;

procedure TCustomHTMLEditHost.SetGridSizeX(const Value: Integer);
begin
  FGridSizeX := Value;
  if Assigned(FGridBehavior) then
    FGridBehavior.GridInfo.GridSizeX := Value;
end;

procedure TCustomHTMLEditHost.SetGridSizeY(const Value: Integer);
begin
  FGridSizeY := Value;
  if Assigned(FGridBehavior) then
    FGridBehavior.GridInfo.GridSizeY := Value;
end;

function TCustomHTMLEditHost.SnapTop(Top: Integer): Integer;
begin
  Result := ((Top + (GridSizeY div 2)) div GridSizeY) * GridSizeY - 2;
end;

function TCustomHTMLEditHost.SnapBottom(Bottom: Integer): Integer;
begin
  Result := ((Bottom + (GridSizeY div 2)) div GridSizeY) * GridSizeY + 1;
end;

function TCustomHTMLEditHost.SnapLeft(Left: Integer): Integer;
begin
  Result := ((Left + (GridSizeX div 2)) div GridSizeX) * GridSizeX - 2;
end;

function TCustomHTMLEditHost.SnapRight(Right: Integer): Integer;
begin
  Result := ((Right + (GridSizeX div 2)) div GridSizeX) * GridSizeX + 1;
end;

function TCustomHTMLEditHost.SnapRect(const pIElement: IHTMLElement;
  var prcNew: tagRECT; eHandle: _ELEMENT_CORNER): HRESULT;
var
  Width, Height: LongInt;
  IncrX, IncrY: Integer;
begin
  Result := S_OK;
  if not Snap then exit;

  IncrX := GridSizeX;
  IncrY := GridSizeY;

  Width := prcNew.right - prcNew.left;
  Height := prcNew.bottom - prcNew.top;

  case eHandle of
    ELEMENT_CORNER_NONE:
      begin
        prcNew.top := ((prcNew.top + (IncrY div 2)) div IncrY) * IncrY - 2;
        prcNew.left := ((prcNew.left + (IncrX div 2)) div IncrX) * IncrX - 2;
        prcNew.bottom := prcNew.top + Height;
        prcNew.right := prcNew.left + Width;
      end;
    ELEMENT_CORNER_TOP:
      prcNew.top := ((prcNew.top + (IncrY div 2)) div IncrY) * IncrY - 2;
    ELEMENT_CORNER_LEFT:
      prcNew.left := ((prcNew.left + (IncrX div 2)) div IncrX) * IncrX - 2;
    ELEMENT_CORNER_BOTTOM:
      prcNew.bottom := ((prcNew.bottom + (IncrY div 2)) div IncrY) * IncrY+ 1;
    ELEMENT_CORNER_RIGHT:
      prcNew.right := ((prcNew.right + (IncrX div 2)) div IncrX) * IncrX+ 1;
    ELEMENT_CORNER_TOPLEFT:
      begin
        prcNew.top := ((prcNew.top + (IncrY div 2)) div IncrY) * IncrY- 2;
        prcNew.left := ((prcNew.left + (IncrX div 2)) div IncrX) * IncrX- 2;
      end;
    ELEMENT_CORNER_TOPRIGHT:
      begin
        prcNew.top := ((prcNew.top + (IncrY div 2)) div IncrY) * IncrY - 2;
        prcNew.right := ((prcNew.right + (IncrX div 2)) div IncrX) * IncrX + 1;
      end;
    ELEMENT_CORNER_BOTTOMLEFT:
      begin
        prcNew.bottom := ((prcNew.bottom + (IncrY div 2)) div IncrY) * IncrY + 1;
        prcNew.left := ((prcNew.left + (IncrX div 2)) div IncrX) * IncrX - 2;
      end;
    ELEMENT_CORNER_BOTTOMRIGHT:
      begin
        prcNew.bottom := ((prcNew.bottom + (IncrY div 2)) div IncrY) * IncrY + 1;
        prcNew.right := ((prcNew.right + (IncrX div 2)) div IncrX) * IncrX + 1;
      end;
  end;
end;

{ TCustomHostBehaviorInit }

constructor TCustomHostBehaviorInit.Create(AOwner: TComponent);
begin
  inherited;
  FServiceGUID := IID_IHostBehaviorInit;
  FNamespaces := TWideStringList.Create;
end;

destructor TCustomHostBehaviorInit.Destroy;
begin
  FreeAndNil(FNamespaces);
  inherited;
end;

procedure TCustomHostBehaviorInit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FFactory) then
    FFactory := nil;
end;

function TCustomHostBehaviorInit.PopulateNamespaceTable: HRESULT;
var
  ServProv: IServiceProvider;
  OleObject: IOleObject;
  V: OleVariant;
  I: Integer;
begin
  Result := E_NOTIMPL;
  if FFactory = nil then
  begin
    MessageDlg(Format(sFactoryPropertyNotAssigned, [Name]), mtError, [mbOk], 0);
    exit;
  end;
  if WebBrowser = nil then
  begin
    MessageDlg(Format(sWebBrowserNotAssigned, [Name]), mtError, [mbOk], 0);
    exit;
  end;
  // The following steps used to retrieve IElementNamespaceTable are not
  // documented _anywhere_.  This information was eventually gleened from email
  // discussions directly with Microsoft.
  if Supports(WebBrowser.Document2, IOleObject, OleObject) then
    if Supports(OleObject, IServiceProvider, ServProv) then
      if ServProv.QueryService(IID_IElementNamespaceTable,
        IID_IElementNamespaceTable, FElementNamespaceTable) = S_OK then
      begin
        V := Factory as IUnknown;
        for I := 0 to FNamespaces.Count - 1 do
          OleCheck(FElementNamespaceTable.AddNamespace(FNamespaces[I], '',  { do not localize }
            ELEMENTNAMESPACEFLAGS_QUERYFORUNKNOWNTAGS, V));
        Result := S_OK;
      end;
end;

procedure TCustomHostBehaviorInit.SetFactory(
  const Value: TCustomElementBehaviorFactory);
begin
  if FFactory <> Value then
  begin
    if Assigned(FFactory) then
      FFactory.RemoveFreeNotification(Self);
    FFactory := Value;
    if Assigned(FFactory) then
      FFactory.FreeNotification(Self);
  end;
end;

procedure TCustomHostBehaviorInit.SetNamespaces(const Value: TWideStringList);
begin
  FNamespaces.Assign(Value);
end;

{ TElementNamespaceFactory }

function TElementNamespaceFactory._create(
  const pNamespace: IElementNamespace): HRESULT;
begin
  Result := S_OK;
end;

function TElementNamespaceFactory.CreateWithImplementation(const pNamespace: IElementNamespace;
  const bstrImplementation: WideString): HRESULT;
begin
  Result := E_NOTIMPL;
end;

{ TCustomHTMLValidator }

procedure TCustomHTMLValidator.ValidateDocument;
var
  TargetPtr, BeginPtr, EndPtr, StatusPtr: IMarkupPointer;
  Elements: IHTMLElementCollection;
  E: IHTMLElement;
  Bottom, Top: IHTMLElement;
//  Result: HRESULT;
  MarkupServices: IMarkupServices2;
  Doc2: IHTMLDocument2;
begin
  Bottom := nil;
  Top := nil;
  StatusPtr := nil;
  if not Supports(WebBrowser.Document, IMarkupServices2, MarkupServices) then exit;
  if not Supports(WebBrowser.Document, IHTMLDocument2, Doc2) then exit;
  Elements := WebBrowser.Document2.all;
  if not Supports(Elements.item(0,0), IHTMLElement, E) then exit;
  MarkupServices.CreateMarkupPointer(BeginPtr);
  MarkupServices.CreateMarkupPointer(EndPtr);
  BeginPtr.MoveAdjacentToElement(Doc2.body, ELEM_ADJ_AfterBegin);
  with Elements.item(Elements.length - 1, Elements.length - 1) as IHTMLElement do
    EndPtr.MoveAdjacentToElement(E, ELEM_ADJ_BeforeEnd);
  MarkupServices.ValidateElements(BeginPtr, EndPtr, TargetPtr, StatusPtr, Bottom, Top);
{//  OleCheck(WebBrowser.MarkupServices.CreateMarkupPointer(StatusPtr));
  OleCheck(WebBrowser.MarkupServices.CreateMarkupPointer(BeginPtr));
  OleCheck(WebBrowser.MarkupServices.CreateMarkupPointer(EndPtr));
  TargetPtr := nil;
//  OleCheck(WebBrowser.MarkupServices.CreateMarkupPointer(TargetPtr));
  Elements := WebBrowser.Document2.all as IHTMLElementCollection;
  E := Elements.item(1,1) as IHTMLElement;
  OleCheck(BeginPtr.MoveAdjacentToElement(WebBrowser.Document2.body, ELEM_ADJ_AfterBegin));
//  OleCheck(TargetPtr.MoveToPointer(BeginPtr));
//  OleCheck(StatusPtr.MoveToPointer(BeginPtr));
  E := Elements.item(Elements.length - 1, Elements.length - 1) as IHTMLElement;
  OleCheck(EndPtr.MoveAdjacentToElement(E, ELEM_ADJ_BeforeEnd));
//  Result := (BeginPtr as IMarkupPointer2).MoveToContent(E, 1);
//  E := Elements.item(0, Elements.length - 3) as IHTMLElement;
//  Result := (EndPtr as IMarkupPointer2).MoveToContent(E, 1);
  OleCheck(WebBrowser.MarkupServices.ValidateElements(BeginPtr, EndPtr,
    TargetPtr, StatusPtr, Bottom, Top));}
  if Assigned(Bottom) or Assigned(Top) then
    beep;
end;

{ TCustomHTMLDocumentFragment }

constructor TCustomHTMLDocumentFragment.Create(AOwner: TComponent);
begin
  inherited;
  FHTML := TWideStringList.Create;
  FHTML.OnChange := HTMLChange;
end;

destructor TCustomHTMLDocumentFragment.Destroy;
begin
  FreeAndNil(FHTML);
  inherited;
end;

function TCustomHTMLDocumentFragment.GetHTMLDocument: IHTMLDocument2;
var
  //Node, Node2, Node3, Node4: IHTMLDOMNode;
  HTMLElement, HEADElement, BODYElement, SPANElement: IHTMLElement;
  HTMLDocument: IHTMLDocument2;
  HTMLDomNode: IHTMLDomNode;
begin
  if FFragment = nil then
  begin
  //FFragment := nil;
  // The following steps used to create an HTML document fragement
  // for assignment to a viewlink is not documented in MSDN.
  // This information was eventually gleened from email discussions
  // directly with Microsoft.
  (*
  FFragment := (FBehavior.Element.document as IHTMLDocument3).createDocumentFragment;
  HeadElement := FFragment.createElement('head');
  FBodyElement := FFragment.createElement('body');   { do not localize }
  FBodyElement.innerHTML := HTML.Text;
  OleCheck(FFragment.QueryInterface(IID_IHTMLDOMNode, Node));
  OleCheck(HeadElement.QueryInterface(IID_IHTMLDOMNode, Node4));
  OleCheck(FBodyelement.QueryInterface(IID_IHTMLDOMNode, Node2));
  Node3 := Node.insertBefore(Node2, NULL);
  Result := FFragment;
  *)

    HTMLDocument := FBehavior.Element.document as IHTMLDocument2;
    HTMLElement := HTMLDocument.CreateElement('HTML'); { do not localize }
    HEADElement := HTMLDocument.CreateElement('HEAD'); { do not localize }
    BODYElement := HTMLDocument.CreateElement('BODY');  { do not localize }
                // ContentEditable attribute in viewlink doesn't seem to affect designer
                // (e.g.; can still edit a label, for example
                //BODYElement.setAttribute('contenteditable', 'false', 0);
    (HTMLElement as IHTMLElement2).InsertAdjacentElement('afterBegin', HEADElement); { do not localize }
    (HEADElement as IHTMLElement2).InsertAdjacentElement('afterEnd', BODYElement);   { do not localize }
		SPANElement := HTMLDocument.CreateElement('SPAN');
                // ContentEditable attribute in viewlink doesn't seem to affect designer
                // (e.g.; can still edit a label, for example
                //SPANElement.setAttribute('contenteditable', 'false', 0);
    SPANElement.innerHTML := HTML.Text;
    HTMLDomNode := BODYElement as IHTMLDomNode;
    HTMLDomNode.AppendChild(SPANElement as IHTMLDomNode);
    FFragment := HTMLElement.Document as IHTMLDocument2;
    FBodyElement := BODYElement;
    FSpanElement := SPANElement;
  end;
  Result := FFragment;
end;

procedure TCustomHTMLDocumentFragment.HTMLChange(Sender: TObject);
begin
  if Assigned(FSpanElement) then
    FSpanElement.innerHTML := (Sender as TWideStringList).Text;
end;

procedure TCustomHTMLDocumentFragment.SetHTML(const Value: TWideStringList);
begin
  FHTML.Assign(Value);
end;

{ TBehaviorElementEvents }

constructor TBehaviorElementEvents.Create(Behavior: TCustomElementBehavior;
  Element: IHTMLElement);
begin
  FBehavior := Behavior;
  HTMLElement := Element;
end;

function TBehaviorElementEvents.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HRESULT;
begin
  Result := inherited DoInvoke(DispID, IID, LocaleID, Flags, dps, pDispIds,
    VarResult, ExcepInfo, ArgErr);
  case DispID of
{    DISPID_HTMLELEMENTEVENTS2_ONHELP:;
    DISPID_HTMLELEMENTEVENTS2_ONCLICK:;
    DISPID_HTMLELEMENTEVENTS2_ONDBLCLICK:;
    DISPID_HTMLELEMENTEVENTS2_ONKEYPRESS:;
    DISPID_HTMLELEMENTEVENTS2_ONKEYDOWN:;
    DISPID_HTMLELEMENTEVENTS2_ONKEYUP:;
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEOUT:;
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEOVER:;
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEMOVE:;
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEDOWN:;
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEUP:;
    DISPID_HTMLELEMENTEVENTS2_ONSELECTSTART:;
    DISPID_HTMLELEMENTEVENTS2_ONFILTERCHANGE:;
    DISPID_HTMLELEMENTEVENTS2_ONDRAGSTART:;
    DISPID_HTMLELEMENTEVENTS2_ONBEFOREUPDATE:;
    DISPID_HTMLELEMENTEVENTS2_ONAFTERUPDATE:;
    DISPID_HTMLELEMENTEVENTS2_ONERRORUPDATE:;
    DISPID_HTMLELEMENTEVENTS2_ONROWEXIT:;
    DISPID_HTMLELEMENTEVENTS2_ONROWENTER:;
    DISPID_HTMLELEMENTEVENTS2_ONDATASETCHANGED:;
    DISPID_HTMLELEMENTEVENTS2_ONDATAAVAILABLE:;
    DISPID_HTMLELEMENTEVENTS2_ONDATASETCOMPLETE:;
    DISPID_HTMLELEMENTEVENTS2_ONLOSECAPTURE:;
    DISPID_HTMLELEMENTEVENTS2_ONPROPERTYCHANGE:;
    DISPID_HTMLELEMENTEVENTS2_ONSCROLL:;
    DISPID_HTMLELEMENTEVENTS2_ONFOCUS:;
    DISPID_HTMLELEMENTEVENTS2_ONBLUR:;
    DISPID_HTMLELEMENTEVENTS2_ONRESIZE:;
    DISPID_HTMLELEMENTEVENTS2_ONDRAG:;
    DISPID_HTMLELEMENTEVENTS2_ONDRAGEND:;
    DISPID_HTMLELEMENTEVENTS2_ONDRAGENTER:;
    DISPID_HTMLELEMENTEVENTS2_ONDRAGOVER:;
    DISPID_HTMLELEMENTEVENTS2_ONDRAGLEAVE:;
    DISPID_HTMLELEMENTEVENTS2_ONDROP:;
    DISPID_HTMLELEMENTEVENTS2_ONBEFORECUT:;
    DISPID_HTMLELEMENTEVENTS2_ONCUT:;
    DISPID_HTMLELEMENTEVENTS2_ONBEFORECOPY:;
    DISPID_HTMLELEMENTEVENTS2_ONCOPY:;
    DISPID_HTMLELEMENTEVENTS2_ONBEFOREPASTE:;
    DISPID_HTMLELEMENTEVENTS2_ONPASTE:;
    DISPID_HTMLELEMENTEVENTS2_ONCONTEXTMENU:;
    DISPID_HTMLELEMENTEVENTS2_ONROWSDELETE:;
    DISPID_HTMLELEMENTEVENTS2_ONROWSINSERTED:;
    DISPID_HTMLELEMENTEVENTS2_ONCELLCHANGE:;
    DISPID_HTMLELEMENTEVENTS2_ONREADYSTATECHANGE:;
    DISPID_HTMLELEMENTEVENTS2_ONLAYOUTCOMPLETE:;
    DISPID_HTMLELEMENTEVENTS2_ONPAGE:;
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEENTER:;
    DISPID_HTMLELEMENTEVENTS2_ONMOUSELEAVE:;
    DISPID_HTMLELEMENTEVENTS2_ONACTIVATE:;
    DISPID_HTMLELEMENTEVENTS2_ONDEACTIVATE:;
    DISPID_HTMLELEMENTEVENTS2_ONBEFOREDEACTIVATE:;
    DISPID_HTMLELEMENTEVENTS2_ONBEFOREACTIVATE:;
    DISPID_HTMLELEMENTEVENTS2_ONFOCUSIN:;
    DISPID_HTMLELEMENTEVENTS2_ONFOCUSOUT:;    }
    DISPID_HTMLELEMENTEVENTS2_ONMOVE:
      if Assigned(FBehavior) then
        Result := FBehavior.DoMove;
    DISPID_HTMLELEMENTEVENTS2_ONCONTROLSELECT:
      if Assigned(FBehavior) then
        Result := FBehavior.DoControlSelect;
    DISPID_HTMLELEMENTEVENTS2_ONMOVESTART:
      if Assigned(FBehavior) then
        Result := FBehavior.DoMove;
    DISPID_HTMLELEMENTEVENTS2_ONMOVEEND:
      if Assigned(FBehavior) then
        Result := FBehavior.DoMove;
{    DISPID_HTMLELEMENTEVENTS2_ONRESIZESTART:;
    DISPID_HTMLELEMENTEVENTS2_ONRESIZEEND:;
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEWHEEL:;}
  end;
end;

{ TCustomWebBrowserServices }

procedure TCustomWebBrowserServices.ClearReferences;
begin
end;

destructor TCustomWebBrowserServices.Destroy;
begin
  ClearReferences;
  inherited;
end;

procedure TCustomWebBrowserServices.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = WebBrowser) then
    ClearReferences;
  inherited;
end;

procedure TCustomWebBrowserServices.SetWebBrowser(
  const Value: TWebBrowserEx);
begin
  ClearReferences;
  inherited;
end;

{ TCustomMarkupServices }

procedure TCustomMarkupServices.ClearReferences;
begin
  inherited;
  FLeftPos := nil;
  FRightPos := nil;
  FStartPos := nil;
  FInsertPos := nil;
  FFinishPos := nil;
  FContainer := nil;
  FEndMatch := nil;
  FDocument := nil;
  FMarkupServices := nil;
  FMarkupServices2 := nil;
end;

procedure TCustomMarkupServices.Copy;
begin
  if Assigned(FStartPos) and Assigned(FFinishPos) and Assigned(FInsertPos) then
    OleCheck(WebBrowser.MarkupServices.Copy(StartPos, FinishPos, FInsertPos))
  else
    raise Exception.Create(sPointersNotSetError);
end;

procedure TCustomMarkupServices.CreateContainer;
var
  AContainer: IMarkupContainer;
  MarkupServices: IMarkupServices;
begin
  AContainer := nil;
  MarkupServices := GetMarkupServices;
  if Assigned(MarkupServices) then
    MarkupServices.CreateMarkupContainer(AContainer);
  FContainer := AContainer as IMarkupContainer2;
end;

function TCustomMarkupServices.CreatePointer: IMarkupPointer;
var
  MarkupServices: IMarkupServices;
begin
  Result := nil;
  MarkupServices := GetMarkupServices;
  if Assigned(MarkupServices) then
    MarkupServices.CreateMarkupPointer(Result);
end;

function TCustomMarkupServices.Find(TheText: string;
  FromBeginning: Boolean): Boolean;
begin
  FSearchText := TheText;
  if TheText = '' then
    raise Exception.Create(sNoSearchStringSpecified);
  CheckWebBrowserAssigned;
  if not Assigned(FFinishPos) then
    raise Exception.CreateFmt(sFinishPosNotSet, [Name]);
  if FromBeginning or (FStartPos = nil) then
    OleCheck(StartPos.MoveAdjacentToElement(WebBrowser.Document2.body, ELEM_ADJ_AfterBegin));
  if FEndMatch = nil then
    FEndMatch := CreatePointer as IMarkupPointer2;
  Result := StartPos.findText(@FSearchText[1], 0, FEndMatch, FFinishPos) = S_OK;
end;

function TCustomMarkupServices.FindNext: Boolean;
begin
  if not Assigned(FFinishPos) then
    raise Exception.CreateFmt(sFinishPosNotSet, [Name]);
  if Assigned(FEndMatch) then
    Result := FEndMatch.findText(@FSearchText[1], 0, FEndMatch, FFinishPos) = S_OK
  else
    raise Exception.Create(sCallingFindNextBeforeFind);
end;

function TCustomMarkupServices.GetContainer: IMarkupContainer2;
begin
  Result := nil;
  if FContainer = nil then
    if Assigned(FDocument) then
      Result := FDocument as IMarkupContainer2
    else
    begin
      CheckWebBrowserAssigned;
      Result := WebBrowser.PrimaryMarkupContainer;
    end;
end;

function TCustomMarkupServices.GetDocument: IHTMLDocument;
begin
  Result := nil;
  if Assigned(FDocument) then
    Result := FDocument
  else
  begin
    CheckWebBrowserAssigned;
    Result := WebBrowser.Document as IHTMLDocument;
  end;
end;

function TCustomMarkupServices.GetDocument2: IHTMLDocument2;
begin
  Result := nil;
  if Assigned(FDocument) then
    Result := FDocument as IHTMLDocument2
  else
  begin
    CheckWebBrowserAssigned;
    Result := WebBrowser.Document2;
  end;
end;

function TCustomMarkupServices.GetFinishPos: IMarkupPointer2;
var
  MarkupServices: IMarkupServices;
  P: IMarkupPointer;
begin
  MarkupServices := GetMarkupServices;
  if Assigned(MarkupServices) and (FFinishPos = nil) then
  begin
    OleCheck(MarkupServices.CreateMarkupPointer(P));
    FFinishPos := P as IMarkupPointer2;
  end;
  Result := FFinishPos;
end;

function TCustomMarkupServices.GetInsertPos: IMarkupPointer2;
var
  MarkupServices: IMarkupServices;
  P: IMarkupPointer;
begin
  MarkupServices := GetMarkupServices;
  if Assigned(MarkupServices) and (FInsertPos = nil) then
  begin
    OleCheck(MarkupServices.CreateMarkupPointer(P));
    FInsertPos := P as IMarkupPointer2;
  end;
  Result := FInsertPos;
end;

function TCustomMarkupServices.GetLeftPos: IMarkupPointer2;
var
  MarkupServices: IMarkupServices;
  P: IMarkupPointer;
begin
  MarkupServices := GetMarkupServices;
  if Assigned(MarkupServices) and (FLeftPos = nil) then
  begin
    OleCheck(MarkupServices.CreateMarkupPointer(P));
    FLeftPos := P as IMarkupPointer2;
  end;
  Result := FLeftPos;
end;

function TCustomMarkupServices.GetMarkupServices: IMarkupServices;
begin
  Result := FMarkupServices;
  if Assigned(Result) then exit;
  if Assigned(FDocument) then
    FMarkupServices := FDocument as IMarkupServices
  else
  begin
    CheckWebBrowserAssigned;
    FMarkupServices := WebBrowser.Document as IMarkupServices;
  end;
  if FMarkupServices = nil then
    raise Exception.Create(sMarkupServicesNotAvailable);
  Result := FMarkupServices;
end;

function TCustomMarkupServices.GetMarkupServices2: IMarkupServices2;
begin
  Result := FMarkupServices2;
  if Assigned(Result) then exit;
  if Assigned(FDocument) then
    FMarkupServices2 := FDocument as IMarkupServices2
  else
  begin
    CheckWebBrowserAssigned;
    FMarkupServices2 := WebBrowser.Document as IMarkupServices2;
  end;
  if FMarkupServices2 = nil then
    raise Exception.Create(sMarkupServices2NotAvailable);
  Result := FMarkupServices2;
end;

function TCustomMarkupServices.GetRightPos: IMarkupPointer2;
var
  MarkupServices: IMarkupServices;
  P: IMarkupPointer;
begin
  MarkupServices := GetMarkupServices;
  if Assigned(MarkupServices) and (FRightPos = nil) then
  begin
    OleCheck(MarkupServices.CreateMarkupPointer(P));
    FRightPos := P as IMarkupPointer2;
  end;
  Result := FRightPos;
end;

function TCustomMarkupServices.GetStartPos: IMarkupPointer2;
var
  MarkupServices: IMarkupServices;
  P: IMarkupPointer;
begin
  MarkupServices := GetMarkupServices;
  if Assigned(MarkupServices) and (FStartPos = nil) then
  begin
    OleCheck(MarkupServices.CreateMarkupPointer(P));
    FStartPos := P as IMarkupPointer2;
  end;
  Result := FStartPos;
end;

procedure TCustomMarkupServices.InsertElement(Element: IHTMLElement);
var
  MarkupServices: IMarkupServices2;
begin
  MarkupServices := GetMarkupServices2;
  if not Assigned(MarkupServices) then
    raise Exception.Create(sMarkupServicesUnavailable);
  if Assigned(FStartPos) and Assigned(FFinishPos) then
    OleCheck(MarkupServices.InsertElement(Element, StartPos, FinishPos))
  else
    raise Exception.Create(sSetPointerError);
end;

procedure TCustomMarkupServices.InsertText(TheText: string);
var
  S: Widestring;
begin
  S := TheText;
  if Assigned(FStartPos) then
    OleCheck(GetMarkupServices.InsertText(@S[1], Length(S), StartPos))
  else
    raise Exception.Create(sStartPosNotSet);
end;

procedure TCustomMarkupServices.Move;
var
  MarkupServices: IMarkupServices2;
begin
  if Assigned(FStartPos) and Assigned(FFinishPos) and Assigned(FInsertPos) then
  begin
    // Position LeftPos and RightPos so they will end up being on either
    // end of the moved content
    OleCheck(LeftPos.MoveToPointer(FInsertPos));
    OleCheck(LeftPos.SetGravity(POINTER_GRAVITY_Left));
    OleCheck(RightPos.MoveToPointer(FInsertPos));
    OleCheck(RightPos.SetGravity(POINTER_GRAVITY_Right));
    MarkupServices := GetMarkupServices2;
    if Assigned(MarkupServices) then
      OleCheck(MarkupServices.move(StartPos, FinishPos, InsertPos))
  end
  else
    raise Exception.Create(sMarkupServicesPointerError);
end;

function TCustomMarkupServices.ParseStringOnly(const HTML: WideString; var ResultContainer: IMarkupContainer): Boolean;
begin
  Result := Length(HTML) > 0;
  if not Result then Exit;
  // Calling ParseString with a valid namespace tag (like <asp:label></asp:label>)
  // will construct an element behavior if necessary.  IMarkupContainer.OwningDoc
  // should not be used for further manipulation of the markup within the
  // container, instead use IMarkupPointer (this is not clear from the MSDN).
  // Additionally, calling IMarkupPointer.MoveToContainer(AMarkupContainer, 1)
  // does not leave the pointer in a valid position to insert HTML into another
  // container.
  OleCheck(WebBrowser.MarkupServices.ParseString(@HTML[1], 0, ResultContainer,
    StartPos, FinishPos));
end;

function TCustomMarkupServices.ParseGlobalOnly(const HTML: HGLOBAL; var ResultContainer: IMarkupContainer): Boolean;
begin
  Result := True;
  OleCheck(WebBrowser.MarkupServices.ParseGlobal(HTML, 0, ResultContainer,
    StartPos, FinishPos));
end;

function TCustomMarkupServices.CalcMarkupContentFlags: TMarkupContentFlags;
var
  Scope: IHTMLElement;
  ContextType: _MARKUP_CONTEXT_TYPE;
  cText: Integer;
  pText: Word;
  CurrentStyle: IHTMLCurrentStyle;
  HasLayout: Boolean;
  MarkupPointer: IMarkupPointer;
  InScope: IHTMLElement;

  function IsRightOfOrEqualTo: Boolean;
  var
    I: Integer;
  begin
    MarkupPointer.IsRightOfOrEqualTo(FinishPos, I);
    Result := I <> 0;
  end;

  function EqualElements(HTMLElement1, HTMLElement2: IHTMLElement): Boolean;
  begin
    if (HTMLElement1 = nil) or (HTMLElement2 = nil) then
      Result := HTMLElement1 = HTMLElement2
    else
      Result := (HTMLElement1 as IInterface) = (HTMLElement2 as IInterface);
  end;

const
  cAbsolute = 'absolute';
begin
  Result := [];
  WebBrowser.MarkupServices.CreateMarkupPointer(MarkupPointer);
  MarkupPointer.MoveToPointer(StartPos);
  try
    // Move sets up RightPos and LeftPos try to select elements between RightPos and LeftPos
  while(not IsRightOfOrEqualTo) do
  begin
    cText := -1; // Get all text
    //OleCheck(MarkupPointer.Right(-1, ContextType, Scope, cText, Buffer[1]));
    OleCheck(MarkupPointer.Right(-1, ContextType, Scope, cText, pText));
    case ContextType of
      CONTEXT_TYPE_None:
        break;
      CONTEXT_TYPE_Text:
        if InScope = nil then
          Include(Result, mctText);
      CONTEXT_TYPE_NoScope,
      CONTEXT_TYPE_EnterScope:
        begin
          Assert(Scope <> nil);
          CurrentStyle := (Scope as IHTMLElement2).currentStyle;
          HasLayout := (CurrentStyle as IHTMLCurrentStyle2).hasLayout;
          if HasLayout then
          begin
            if WideCompareText(Scope.style.position, cAbsolute) = 0 then
              Include(Result, mctAbsoluteLayout)
            else
              Include(Result, mctFlowLayout)
          end
          else
            Include(Result, mctText);
          if ContextType = CONTEXT_TYPE_EnterScope then
            InScope := Scope;
        end;
      CONTEXT_TYPE_ExitScope:
        if EqualElements(InScope, Scope) then
          InScope := nil;
    end;
  end;
  except
    // Silent exception
  end;
end;

procedure TCustomMarkupServices.ParseStringMove(const HTML: WideString);
var
  ResultContainer: IMarkupContainer;
begin
  if ParseStringOnly(HTML, ResultContainer)then
    Move;
end;

// Set left and top before moving element into document.
procedure TCustomMarkupServices.ParseStringMovePosition(const HTML: WideString; Left, Top, ZIndex: Integer);
var
  ResultContainer: IMarkupContainer;
begin
  if ParseStringOnly(HTML, ResultContainer) then
    MovePosition(Left, Top, ZIndex);
end;

function TCustomMarkupServices.GetParsedElement: IHTMLElement;
var
  ContextType: _MARKUP_CONTEXT_TYPE;
  cText: Integer;
  pText: Word;
begin
  cText := 0;
                                      
  OleCheck(StartPos.Right(0, ContextType, Result, cText, pText));
end;

// Set left and top before moving element into document.
procedure TCustomMarkupServices.MovePosition(Left, Top, ZIndex: Integer);
var
  CurrentStyle: IHTMLStyle;
  Element: IHTMLElement;
begin
                                      
  Element := ParsedElement;
  if Element <> nil then
  begin
    CurrentStyle := Element.style;
    CurrentStyle.setAttribute('Position', 'absolute', 0);
    CurrentStyle.posLeft := Left;
    CurrentStyle.posTop := Top;
    CurrentStyle.zIndex := ZIndex;
  end;
  Move;
end;

procedure TCustomMarkupServices.SelectLeftToRightElements;
var
  Scope: IHTMLElement;
  ContextType: _MARKUP_CONTEXT_TYPE;
  cText: Integer;
  pText: Word;
  CurrentStyle: IHTMLCurrentStyle;
  HasLayout: Boolean;
  MarkupPointer: IMarkupPointer;
  InScope: IHTMLElement;
  Element2: IHTMLElement2;
  ControlRange: IHTMLControlRange2;
  TextRange: IHTMLTxtRange;

  function IsRightOfOrEqualTo: Boolean;
  var
    I: Integer;
  begin
    MarkupPointer.IsRightOfOrEqualTo(RightPos, I);
    Result := I <> 0;
  end;

  function EqualElements(HTMLElement1, HTMLElement2: IHTMLElement): Boolean;
  begin
    if (HTMLElement1 = nil) or (HTMLElement2 = nil) then
      Result := HTMLElement1 = HTMLElement2
    else
      Result := (HTMLElement1 as IInterface) = (HTMLElement2 as IInterface);
  end;

const
  cAbsolute = 'absolute';
begin
  WebBrowser.MarkupServices.CreateMarkupPointer(MarkupPointer);
  MarkupPointer.MoveToPointer(LeftPos);
  try
    // Move sets up RightPos and LeftPos try to select elements between RightPos and LeftPos
  //Supports(WebBrowser.Document2.body, IID_IHTMLElement2, Element2);
  while(not IsRightOfOrEqualTo) do
  begin
    cText := -1; // Get all text
    //OleCheck(MarkupPointer.Right(-1, ContextType, Scope, cText, Buffer[1]));
    OleCheck(MarkupPointer.Right(-1, ContextType, Scope, cText, pText));
    if (Scope <> nil) and (Element2 = nil) then
    begin
      // Use document associated with element
      Supports((Scope.document as IHTMLDocument2).body, IHTMLElement2, Element2);
      Assert(Element2 <> nil);
    end;

    case ContextType of
      CONTEXT_TYPE_None:
        break;
      CONTEXT_TYPE_Text:
        if InScope = nil then
          //Include(Result, mctText);
          ;
      CONTEXT_TYPE_NoScope,
      CONTEXT_TYPE_EnterScope:
        begin
          Assert(Scope <> nil);
          if InScope = nil then
          begin
            CurrentStyle := (Scope as IHTMLElement2).currentStyle;
            HasLayout := (CurrentStyle as IHTMLCurrentStyle2).hasLayout;
            if HasLayout then
            begin
              if ControlRange = nil then
                ControlRange := Element2.createControlRange as IHTMLControlRange2;
              if ControlRange <> nil then
              try
                ControlRange.addElement(Scope);
                if ContextType = CONTEXT_TYPE_EnterScope then
                  InScope := Scope;
              except
                TextRange := (Element2 as IHTMLBodyElement).createTextRange as IHTMLTxtRange;
                if TextRange <> nil then
                  TextRange.MoveToElementText(Scope);
              end;
            end;
          end
          else
          begin
            TextRange := (Element2 as IHTMLBodyElement).createTextRange as IHTMLTxtRange;
            if TextRange <> nil then
              TextRange.MoveToElementText(Scope);
          end;
        end;
      CONTEXT_TYPE_ExitScope:
        if EqualElements(InScope, Scope) then
          InScope := nil;
    end;
  end;
  if Assigned(ControlRange) then
    (ControlRange as IHTMLControlRange).select
  else if Assigned(TextRange) then
    TextRange.select
  except
    // Silent exception
  end;
end;


function TCustomMarkupServices.SelectLeftElement(CollapseText: Boolean): Boolean;
var
  Scope: IHTMLElement;
  Element2: IHTMLElement2;
  ControlRange: IHTMLControlRange2;
  ContextType: _MARKUP_CONTEXT_TYPE;
  cText: Integer;
  pText: Word;
  TextRange: IHTMLTxtRange;
  CurrentStyle: IHTMLCurrentStyle;
  HasLayout: Boolean;
  (*
  CONTEXT_TYPE_None = $00000000;
  CONTEXT_TYPE_Text = $00000001;
  CONTEXT_TYPE_EnterScope = $00000002;
  CONTEXT_TYPE_ExitScope = $00000003;
  CONTEXT_TYPE_NoScope = $00000004;
  *)
begin
  Result := False;
  try
    // Move sets up RightPos and LeftPos try to select elements between RightPos and LeftPos
    cText := 0;
    OleCheck(LeftPos.Right(-1, ContextType, Scope, cText, pText));
    if (Scope <> nil) (* and Supports(WebBrowser.Document2.body, IID_IHTMLElement2, Element2) *) then
    begin
      Result := True;
      CurrentStyle := (Scope as IHTMLElement2).currentStyle;
      HasLayout := (CurrentStyle as IHTMLCurrentStyle2).hasLayout;
      Supports((scope.document as IHTMLDocument2).body, IID_IHTMLElement2, Element2);
      Assert(Element2 <> nil);
      if HasLayout then
      begin
        ControlRange := Element2.createControlRange as IHTMLControlRange2;
        if ControlRange <> nil then
        try
          ControlRange.addElement(Scope);
        except
          TextRange := (Element2 as IHTMLBodyElement).createTextRange as IHTMLTxtRange;
          if TextRange <> nil then
            TextRange.MoveToElementText(Scope);
        end;
      end
      else
      begin
        TextRange := (Element2 as IHTMLBodyElement).createTextRange as IHTMLTxtRange;
        if TextRange <> nil then
          TextRange.MoveToElementText(Scope);
      end;
    end;
    if Assigned(TextRange) then
    begin
      if CollapseText then
        TextRange.Collapse(True); // Collapse to beginning
      TextRange.select;
    end
    else if Assigned(ControlRange) then
      (ControlRange as IHTMLControlRange).select
  except
    // Silent exception
  end;
end;

procedure TCustomMarkupServices.Remove;
var
  MarkupServices: IMarkupServices;
begin
  MarkupServices := GetMarkupServices;
  if Assigned(MarkupServices) and Assigned(FStartPos) and Assigned(FFinishPos) then
    OleCheck(MarkupServices.remove(StartPos, FinishPos))
  else
    raise Exception.Create(sSetPointerError);
end;

procedure TCustomMarkupServices.RemoveElement(Element: IHTMLElement);
var
  MarkupServices: IMarkupServices;
begin
  MarkupServices := GetMarkupServices;
  if Assigned(MarkupServices) and Assigned(Element) then
    OleCheck(MarkupServices.RemoveElement(Element));
end;

procedure TCustomMarkupServices.ReplaceContent(NewContent: string);
begin
                                                                     
end;

procedure TCustomMarkupServices.Select(Element: IHTMLElement);
var
  Elements: TElementArray;
begin
  SetLength(Elements, 1);
  Elements[0] := Element;
  Select(Elements);
end;

procedure TCustomMarkupServices.Select(Elements: TElementArray);
var
  I: Integer;
  ControlRange: IHTMLControlRange2;
begin
  if Document2 = nil then exit;
  for I := 0 to Length(Elements) - 1 do
  begin
    with Document2.body as IHTMLElement2 do
      ControlRange := createControlRange as IHTMLControlRange2;
    ControlRange.addElement(Elements[I]);
  end;
  if Assigned(ControlRange) then
    with ControlRange as IHTMLControlRange do
      select;
end;

procedure TCustomMarkupServices.SetDocument(const Value: IHTMLDocument);
begin
  ClearReferences;
  FDocument := Value;
end;

{ TCustomDisplayServices }

procedure TCustomDisplayServices.ClearReferences;
begin
  inherited;
  FEndPtr := nil;
  FStartPtr := nil;
  FDisplayServices := nil;
end;

function TCustomDisplayServices.CreateDisplayPointer: IDisplayPointer;
begin
  Result := nil;
  if Assigned(DisplayServices) then
    OleCheck(DisplayServices.CreateDisplayPointer(Result));
end;

function TCustomDisplayServices.GetCaret: IHTMLCaret;
begin
  Result := nil;
  if Assigned(DisplayServices) then
    OleCheck(DisplayServices.GetCaret(Result));
end;

function TCustomDisplayServices.GetDisplayServices: IDisplayServices;
begin
  if Assigned(WebBrowser) and Assigned(WebBrowser.Document) then
    FDisplayServices := WebBrowser.Document as IDisplayServices;
  Result := FDisplayServices;
end;

function TCustomDisplayServices.GetEndPtr: IDisplayPointer;
begin
  if FEndPtr = nil then
    FEndPtr := CreateDisplayPointer;
  Result := FEndPtr;
end;

// Very slow
// Use WebBrowserEx.GetCurrentElement instead
//function TCustomDisplayServices.GetHTMLElement: IHTMLElement;
//var
//  Pointer: IMarkupPointer;
//  DispPtr: IDisplayPointer;
//begin
//  Result := nil;
//  DispPtr := CreateDisplayPointer;
//  if Assigned(DispPtr) then
//  begin
//    // This is very slow.  TWebBrowserEx.CurrentElement has a cached value.
//    // May not be correct if selection is changing but the caret hasn't moved yet.
//    OleCheck(WebBrowser.MarkupServices.CreateMarkupPointer(Pointer));
//    OleCheck(Caret.MoveDisplayPointerToCaret(DispPtr));
//    OleCheck(DispPtr.PositionMarkupPointer(Pointer));
//    OleCheck(Pointer.CurrentScope(Result));
//  end;
//end;

function TCustomDisplayServices.GetLinInfo: ILineInfo;
var
  Ptr: IDisplayPointer;
begin
  Result := nil;
  Ptr := CreateDisplayPointer;
  if Assigned(Ptr) then
  begin
    OleCheck(Caret.MoveDisplayPointerToCaret(Ptr));
    OleCheck(Ptr.GetLineInfo(Result));
  end;
end;

function TCustomDisplayServices.GetStartPtr: IDisplayPointer;
begin
  if FStartPtr = nil then
    FStartPtr := CreateDisplayPointer;
  Result := FStartPtr;
end;

{ TCustomHighlightRenderingServices }

procedure TCustomHighlightRenderingServices.ClearReferences;
begin
  inherited;
  FHighlightRenderingServices := nil;
end;

function TCustomHighlightRenderingServices.CreateRenderStyle: IHTMLRenderStyle;
begin
  CheckDocumentAssigned;
  Result := WebBrowser.Document4.createRenderStyle('')
end;

function TCustomHighlightRenderingServices.GetHighlightRenderingServices: IHighlightRenderingServices;
begin
  CheckDocumentAssigned;
  if FHighlightRenderingServices = nil then
    FHighlightRenderingServices := WebBrowser.Document as IHighlightRenderingServices;
  Result := FHighlightRenderingServices;
end;

function TCustomHighlightRenderingServices.GetHTMLRenderStyle: IHTMLRenderStyle;
begin
  if not Assigned(FHTMLRenderStyle) then
    FHTMLRenderStyle := CreateRenderStyle;
  Result := FHTMLRenderStyle;
end;

{ TCustomMSHTMLParser }

procedure TCustomMSHTMLParser.DoAfterUpdate;
begin
  if Assigned(FAfterUpdate) then
    FAfterUpdate(Self);
end;

procedure TCustomMSHTMLParser.DoBeforeUpdate;
begin
  if Assigned(FBeforeUpdate) then
    FBeforeUpdate(Self);
end;

destructor TCustomMSHTMLParser.Destroy;
begin
  FDocument2 := nil;
  inherited;
end;

procedure TCustomMSHTMLParser.DoReadyStateChange;
begin
  if Assigned(FOnReadyStateChange) then
    FOnReadyStateChange(Self);
end;

function TCustomMSHTMLParser.GetContainer(
  out container: IOleContainer): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TCustomMSHTMLParser.GetDocument2: IHTMLDocument2;
var
  ConnectionPoint: IConnectionPoint;
  C: Integer;
begin
  if FDocument2 = nil then
  begin
    OleCheck(CoCreateInstance(CLASS_HTMLDocument, nil, CLSCTX_INPROC_SERVER,
      IID_IHTMLDocument2, FDocument2));
    OleCheck((Document2 as IOleObject).SetClientSite(self as IOleClientsite));
    OleCheck((Document2 as IOleControl).OnAmbientPropertyChange(DISPID_AMBIENT_DLCONTROL));
    OleCheck((Document2 as IConnectionPointContainer).FindConnectionPoint(IpropertyNotifySink, ConnectionPoint));
    ConnectionPoint.Advise(Self as IPropertyNotifySink, C);
    FDocEvents := TParserEventDispatch.Create;
    FDocEvents.FParser := Self;
    FDocEvents.Active := True;
  end;
  Result := FDocument2;
end;

function TCustomMSHTMLParser.GetDocument3: IHTMLDocument3;
begin
  Result := Document2 as IHTMLDocument3;
end;

function TCustomMSHTMLParser.GetMoniker(dwAssign, dwWhichMoniker: Integer;
  out mk: IMoniker): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TCustomMSHTMLParser.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
var
  I: Integer;
begin
  if DispId = DISPID_AMBIENT_DLCONTROL then begin
    I := DLCTL_DOWNLOADONLY + DLCTL_NO_SCRIPTS +
      DLCTL_NO_JAVA + DLCTL_NO_DLACTIVEXCTLS +
      DLCTL_NO_RUNACTIVEXCTLS;
    PVariant(VarResult)^ := I;
    Result := S_OK;
  end else
    Result := DISP_E_MEMBERNOTFOUND;
end;

procedure TCustomMSHTMLParser.LoadFromFile(const FileName: string);
var
  F: TFileStream;
begin
  F := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(F);
  finally
    F.Free;
  end;
end;

procedure TCustomMSHTMLParser.LoadFromStream(S: TStream);
var
  DocStream: IPersistStreamInit;
begin
  if Supports(Document2, IPersistStreamInit, DocStream) then
    OleCheck(DocStream.Load(TStreamAdapter.Create(S)));
end;

function TCustomMSHTMLParser.OnChanged(dispid: Integer): HRESULT;
var
  dp: TDispParams;
  vResult: OleVariant;
begin
  Result := S_FALSE;
  if (DISPID_READYSTATE = Dispid) then
    if Succeeded(Document2.Invoke(DISPID_READYSTATE, GUID_null,
      LOCALE_SYSTEM_DEFAULT, DISPATCH_PROPERTYGET, dp, @vresult, nil, nil)) then
      Result := S_OK;
end;

function TCustomMSHTMLParser.OnRequestEdit(dispid: Integer): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TCustomMSHTMLParser.OnShowWindow(fShow: LongBool): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TCustomMSHTMLParser.RequestNewObjectLayout: HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TCustomMSHTMLParser.SaveObject: HRESULT;
begin
  Result := E_NOTIMPL;
end;

procedure TCustomMSHTMLParser.SaveToFile(const FileName: string);
var
  F: TFileStream;
begin
  F := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(F);
  finally
    F.Free;
  end;
end;

procedure TCustomMSHTMLParser.SaveToStream(S: TStream);
begin
  if not Assigned(Document2) then
    raise Exception.Create(sNoPageLoaded);
  OleCheck((Document2 as IPersistStreamInit).Save(TStreamAdapter.Create(S), false));
end;

function TCustomMSHTMLParser.ShowObject: HRESULT;
begin
  Result := E_NOTIMPL;
end;

{ TParserEventDispatch }

procedure TParserEventDispatch.AfterConstruction;
begin
  inherited;
  FIID := DIID_HTMLDocumentEvents2;
end;

function TParserEventDispatch.GetEventInterface: IInterface;
begin
  Result := nil;
  if Assigned(FParser) then
    Result := FParser.Document2;
end;

function TParserEventDispatch.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HRESULT;
begin
  Result := inherited DoInvoke(DispID, IID, LocaleID, Flags, dps, pDispIds,
    VarResult, ExcepInfo, ArgErr);
  case DispID of
    DISPID_HTMLDOCUMENTEVENTS_ONREADYSTATECHANGE:
      begin
        if Assigned(FParser) then FParser.DoReadyStateChange;
        Result := S_OK;
      end;
    DISPID_HTMLDOCUMENTEVENTS_ONBEFOREUPDATE:
      begin
        if Assigned(FParser) then FParser.DoBeforeUpdate;
        Result := S_OK;
      end;
    DISPID_HTMLDOCUMENTEVENTS_ONAFTERUPDATE:
      begin
        if Assigned(FParser) then FParser.DoAfterUpdate;
        Result := S_OK;
      end;
//    DISPID_HTMLDOCUMENTEVENTS_ONERRORUPDATE: ErrorUpdate;
  end;
end;

{ TSelectionServicesListenter }

function TSelectionServicesListenter.BeginSelectionUndo: HRESULT;
begin
  Result := S_OK;
end;

function TSelectionServicesListenter.EndSelectionUndo: HRESULT;
begin
  Result := S_OK;
end;

function TSelectionServicesListenter.GetTypeDetail(
  out pTypeDetail: WideString): HRESULT;
begin
                                                       
  Result := S_OK;
end;

function TSelectionServicesListenter.OnChangeType(eType: TOleEnum;
  const pIListener: ISelectionServicesListener): HRESULT;
begin
  Result := S_OK;
end;

function TSelectionServicesListenter.OnSelectedElementExit(
  const pIElementStart, pIElementEnd, pIElementContentStart,
  pIElementContentEnd: IMarkupPointer): HRESULT;
begin
  Result := S_OK;
end;

{ TCustomWebBrowserChangeManager }

procedure TCustomWebBrowserChangeManager.CreateChangeLog;
begin
  if not (csLoading in ComponentState) and FActive and Assigned(WebBrowser) and
     Assigned(WebBrowser.Document) then
    OleCheck(WebBrowser.PrimaryMarkupContainer.CreateChangeLog(Self as IHTMLChangeSink,
      FChangeLog, 1, 1));
end;

procedure TCustomWebBrowserChangeManager.ExecChange(Forward: Boolean);
var
  Playback: IHTMLChangePlayback;
  Buffer: array of Byte;
  Len: Integer;
begin
  if Assigned(FChangeLog) and Assigned(WebBrowser) and
     Assigned(WebBrowser.Document) then
    if Supports(WebBrowser.PrimaryMarkupContainer, IID_IHTMLChangePlayback, Playback) then
    begin
      OleCheck(FChangeLog.GetNextChange(nil, 0, Len));
      if Len = 0 then exit;
      SetLength(Buffer, Len);
      OleCheck(FChangeLog.GetNextChange(@Buffer[0], Length(Buffer), Len));
      OleCheck(Playback.ExecChange(@Buffer[0], Integer(Forward)))
    end;
end;

procedure TCustomWebBrowserChangeManager.Loaded;
begin
  inherited;
  CreateChangeLog;
end;

procedure TCustomWebBrowserChangeManager.Notification(
  AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = WebBrowser) then
    FChangeLog := nil;
  inherited;
end;

function TCustomWebBrowserChangeManager.Notify: HRESULT;
begin
  Result := S_OK;
  if Assigned(FOnNotify) then FOnNotify(Self);
end;

procedure TCustomWebBrowserChangeManager.Redo;
begin
  ExecChange(True);
end;

procedure TCustomWebBrowserChangeManager.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    if FActive then
      CreateChangeLog
    else
      FChangeLog := nil;
  end;
end;

procedure TCustomWebBrowserChangeManager.Undo;
begin
  ExecChange(False);
end;

{ TCustomHTMLTableDesigner }

function TCustomHTMLTableDesigner.BeginSelectionUndo: HRESULT;
begin
  Result := S_OK;
end;

procedure TCustomHTMLTableDesigner.Clear;
begin
  // Clear row/col highlighting
  SetColumnHighlight('');
  SetRowHighlight('');
  WebBrowser.MarkupServices.EndUndoUnit;
  FDragCell := nil;
  FDragRow2 := nil;
  FDragCol := nil;
  FDraggingRow := False;
  FDragTable := nil;
  FOffsetPos := Point(0,0);
  if FOverridingCursor then
  begin
    WebBrowser.OverrideCursor := False;
    RestoreBrowserCursor(WebBrowser);
  end;
end;

function TCustomHTMLTableDesigner.CanDesignElement(AElement: IHTMLElement): Boolean;
begin
  Result := IsPrimaryDocumentElement(AElement) or WebBrowser.GetIsEditableElement(AElement,
    [efOuterRequired]);
end;

constructor TCustomHTMLTableDesigner.Create(AOwner: TComponent);
begin
  inherited;
  FColumnResizeColor := '';
  FRowResizeColor := '';
end;

function TCustomHTMLTableDesigner.DoMouseDown(
  EventObj: IHTMLEventObj): HRESULT;
var
  I: Integer;
//  Row: IHTMLTableRow;
//  ColIdx: Integer;
//  Start, Finish: IMarkupPointer;
//  DPStart, DPFinish: IDisplayPointer;
//  RS: IHTMLRenderStyle;
  DragKind: TTableDragKind;
  E: IHTMLElement;
  LDragCell: IHTMLTableCell;
  LDragTable: IHTMLTable;
  LDragRow: IHTMLTableRow;
  LDragRow2: IHTMLTableRow2;
  LDragCol: IHTMLElement;
begin
  Result := S_FALSE;
  if (EventObj.button = 1) and
    ((Supports(EventObj.srcElement, IHTMLTable, LDragTable) or
      Supports(EventObj.srcElement, IHTMLTableCell, LDragCell)) and
      CanDesignElement(EventObj.srcElement)) then
  begin
    if Assigned(LDragTable) then
    begin
      DragKind := OnTable(LDragTable, EventObj.offsetX, EventObj.offsetY,  LDragRow2);
      LDragCell := nil;
    end
    else
      DragKind := OnCell(LDragCell, EventObj.offsetX, EventObj.offsetY,
        LDragRow2);
    case DragKind of
      tdkRow:
        begin
          WebBrowser.MarkupServices.BeginUndoUnit(Name);
          Assert(Supports(LDragRow2, IHTMLTableRow));
          begin
            FDragTable := LDragTable;
            FDraggingRow := True;
            FDragRow2 := LDragRow2;
            if Supports(LDragRow2, IHTMLElement, E) then
            begin
              FOffsetPos := Mouse.CursorPos;
              FOffsetPos.X := E.offsetHeight;  // Save the orignal height
            end;
            SetRowHighlight(FRowResizeColor);
            Result := S_OK;
          end;
        end;
      tdkColumn:
        begin
          WebBrowser.MarkupServices.BeginUndoUnit(Name);
          I := 1;
          if Assigned(LDragCell) then
          begin
            if Supports(EventObj.srcElement.parentElement, IHTMLTableRow) then
              if Supports(EventObj.srcElement.parentElement.parentElement, IHTMLTableSection) then
              begin
                Supports(EventObj.srcElement.parentElement.parentElement.parentElement, IHTMLTable, LDragTable);
                Supports(LDragCell, IHTMLElement, LDragCol);
              end;
          end
          else
          begin
            if Supports(LDragRow2, IHTMLTableRow, LDragRow) then
              if Supports(LDragRow.cells.item(0, 0), IHTMLElement, LDragCol) then
                while (I < LDragRow.cells.length) do
                  if Supports(LDragRow.cells.item(I, I), IHTMLElement, E) then
                    if EventObj.offsetX > E.offsetLeft then
                    begin
                      LDragCol := LDragRow.cells.item(I, I) as IHTMLElement;
                      Inc(I);
                    end
                    else
                      break
                  else
                   break;
                while (I < LDragRow.cells.length) and
                   (EventObj.offsetX > (LDragRow.cells.item(I, I) as IHTMLElement).offsetLeft) do
                begin
                  LDragCol := LDragRow.cells.item(I, I) as IHTMLElement;
                  Inc(I);
                end;
          end;
          if Assigned(LDragCol) then
          begin
            FDragCol := LDragCol;
            FDragCell := LDragCell;
            FDragRow2 := LDragRow2;
            FDragTable := LDragTable;
            FOffsetPos := Mouse.CursorPos;
            FOffsetPos.Y := LDragCol.offsetWidth;  // Save the orignal width
            SetColumnHighlight(FColumnResizeColor);
            Result := S_OK;
          end;
        end;
//      tdkColSelect:
//        if Supports(LDragTable.rows.item(0,0), IHTMLTableRow, Row) then
//        begin
//            if Assigned(FDragCell) then
//              ColIdx := FDragCell.cellIndex
//            else
//            begin
//              ColIdx := 0;
//              while (ColIdx < Row.cells.length) and
//                 (EventObj.offsetX > (Row.cells.item(ColIdx, ColIdx) as IHTMLElement).offsetLeft +
//                 (Row.cells.item(ColIdx, ColIdx) as IHTMLElement).offsetWidth) do
//                Inc(ColIdx);
//            end;
//          OleCheck(WebBrowser.SelectionServices.SetSelectionType(SELECTION_TYPE_Text,
//            Self as ISelectionServicesListener));
//          OleCheck(WebBrowser.MarkupServices.CreateMarkupPointer(Start));
//          OleCheck(WebBrowser.MarkupServices.CreateMarkupPointer(Finish));
//          WebBrowser.DisplayServices.CreateDisplayPointer(DPStart);
//          WebBrowser.DisplayServices.CreateDisplayPointer(DPFinish);
//          RS := WebBrowser.Document4.createRenderStyle('');
//          OleCheck(Start.MoveAdjacentToElement(Row.cells.item(ColIdx, ColIdx) as IHTMLElement, ELEM_ADJ_AfterBegin));
//          DPStart.MoveToMarkupPointer(Start, nil);
//          for I := 0 to LDragTable.rows.length - 1 do
//            if Supports(LDragTable.rows.item(I,I), IHTMLTableRow, Row) then
//              with Row do
//              begin
//                if Supports(cells.item(ColIdx, ColIdx), IHTMLElement, E) then
//                begin
//                  OleCheck(Finish.MoveAdjacentToElement(E, ELEM_ADJ_BeforeEnd));
//                  OleCheck(WebBrowser.SelectionServices.AddSegment(Start, Finish, FSegment));
//                end;
//              end;
//          DPFinish.MoveToMarkupPointer(Finish, nil);
////          WebBrowser.HighlightRenderingServices.AddSegment(DPStart, DPFinish, RS, FHighLight);
//          Result := S_OK;
//        end;
//      tdkRowSelect:;
    end;
  end;
end;

                                                         
function TCustomHTMLTableDesigner.DoMouseMove(EventObj: IHTMLEventObj): HRESULT;
  procedure UpdateOverrideCursor(ADragKind: TTableDragKind);
  begin
     if FOverridingCursor <> (ADragKind <> tdkNone) then
     begin
       FOverridingCursor := ADragKind <> tdkNone;
       WebBrowser.OverrideCursor := ADragKind <> tdkNone;
       if not FOverridingCursor then
         RestoreBrowserCursor(WebBrowser);
     end
  end;
var
  TmpRow: IHTMLTableRow2;
  DragKind: TTableDragKind;
  E: IHTMLElement;
  LDragCell: IHTMLTableCell;
  LDragTable: IHTMLTable;
  LDragRow2: IHTMLTableRow2;
begin
  Result := S_FALSE;
    case EventObj.button of
      0: begin  // No button pressed
           if Supports(EventObj.srcElement, IHTMLTable, LDragTable) and
             CanDesignElement(EventObj.srcElement) then
           begin
             DragKind := OnTable(LDragTable, EventObj.offsetX, EventObj.offsetY, TmpRow);
             case DragKind of
               tdkRow   : SetCursor(LoadCursor(GetModuleHandle('MSHTML.DLL'), '#9804'));  { do not localize }
               tdkColumn: SetCursor(LoadCursor(GetModuleHandle('MSHTML.DLL'), '#9805'));  { do not localize }
               // tdkRowSelect: SetCursor(LoadCursor(0, IDC_WAIT));  { do not localize }
               // tdkColSelect: SetCursor(LoadCursor(0, IDC_CROSS));
             end;
             UpdateOverrideCursor(DragKind);
           end
           else
           if Supports(EventObj.srcElement, IHTMLTableCell, LDragCell) and
             CanDesignElement(EventObj.srcElement) then
           begin
             E := EventObj.srcElement.parentElement;
             while Assigned(E) and not Supports(E, IHTMLTable, LDragTable) do
               E := E.parentElement;
             if not Assigned(E) then
             begin
               UpdateOverrideCursor(tdkNone);
               Exit;
             end;
             DragKind := OnCell(LDragCell, EventObj.offsetX, EventObj.offsetY,
                LDragRow2);
             case DragKind of
               tdkRow   : SetCursor(LoadCursor(GetModuleHandle('MSHTML.DLL'), '#9804'));  { do not localize }
               tdkColumn: SetCursor(LoadCursor(GetModuleHandle('MSHTML.DLL'), '#9805'));  { do not localize }
               // tdkRowSelect: SetCursor(LoadCursor(0, IDC_WAIT));  { do not localize }
               // tdkColSelect: SetCursor(LoadCursor(0, IDC_CROSS));
             end;
             UpdateOverrideCursor(DragKind);
           end
           else
             UpdateOverrideCursor(tdkNone);
         end;
      1: if Assigned(FDragRow2) then  // left button down and dragging
         begin
           Result := S_OK;
           if FDraggingRow then
             SetColumnHeight(FOffsetPos.X + (Mouse.CursorPos.Y - FOffsetPos.Y))
           else
             SetColumnWidth(FOffsetPos.Y + (Mouse.CursorPos.X - FOffsetPos.X));
         end
    end;
end;

function TCustomHTMLTableDesigner.EndSelectionUndo: HRESULT;
begin
  Result := S_OK;
end;

function TCustomHTMLTableDesigner.GetTypeDetail(
  out pTypeDetail: WideString): HRESULT;
begin
  Result := S_OK;
end;

procedure TCustomHTMLTableDesigner.SetColumnHighlight(const Color: string);
var
  Cell: IHTMLTableCell;
  Row: IHTMLTableRow;
  I: Integer;
  E2: IHTMLElement2;
begin
  if (FDragCol = nil) or (FDragTable = nil) then exit;
  if Supports(FDragCol, IHTMLTableCell, Cell) then
  for I := 0 to FDragTable.rows.length - 1 do
    if Supports(FDragTable.rows.item(I, I), IHTMLTableRow, Row) then
      if Cell.cellIndex < Row.cells.length then
        if Supports(Row.cells.item(Cell.cellIndex, Cell.cellIndex), IHTMLElement2, E2) then
          with E2 do
            runtimeStyle.backgroundColor := Color;
end;

//{$DEFINE DRAWRECT}
{$IFDEF DRAWRECT}
procedure DrawRect(WebBrowserEx1: TWebBrowserEx; AClientRect: TRect; AColor: TColor);
var
  LCanvas: TCanvas;
  LDC: HDC;
  LWnd: HWND;
begin
  LWnd := WebBrowserEx1.InetExplorerServerHandle;
  LDC := GetDC(LWnd);
  LCanvas := TCanvas.Create;
  try
    LCanvas.Pen.Color := AColor;
    LCanvas.Handle := GetDC(LWnd);
    //LCanvas.Brush.Color := clNone;
    //LCanvas.Rectangle(AClientRect);
    with AClientRect, LCanvas do
    begin
      MoveTo(Left, Top);
      LineTo(Right-1, Top);
      LineTo(Right-1, Bottom-1);
      LineTo(Left, Bottom-1);
      LineTo(Left, Top);
    end;
    LCanvas.Handle := 0;
  finally
    LCanvas.Free;
    ReleaseDC(LDC, LWnd);
  end;
end;

procedure InvalidateBrowserRect(WebBrowserEx1: TWebBrowserEx; AClientRect: TRect);
var
  LWnd: HWND;
begin
  LWnd := WebBrowserEx1.InetExplorerServerHandle;
  InvalidateRect(LWnd, @AClientRect, True);
  UpdateWindow(LWnd);
end;

procedure DrawTableRect(AWebBrowser: TWebBrowserEx; ATable: IHTMLElement; ATableRect: TRect; AColor: TColor);
var
  LRect: TRect;
begin
  CalcElementRect(ATable as IHTMLElement, LRect);
  OffsetRect(ATableRect, LRect.Left, LRect.Top);
  DrawRect(AWebBrowser, ATableRect, AColor);
end;

procedure EraseTableRect(AWebBrowser: TWebBrowserEx; ATable: IHTMLElement; ATableRect: TRect);
var
  LRect: TRect;
begin
  CalcElementRect(ATable as IHTMLElement, LRect);
  OffsetRect(ATableRect, LRect.Left, LRect.Top);
  //DrawRect(AWebBrowser, ATableRect, AColor);
  InvalidateBrowserRect(AWebBrowser, ATableRect)
end;

procedure EraseTableOfElement(AWebBrowser: TWebBrowserEx; ATableElement: IHTMLElement);
  function ParentTable: IHTMLElement;
  begin
    Result := ATableElement;
    while Result <> nil do
    begin
      if Supports(Result, IHTMLTable) then
        Exit;
      Result := Result.parentElement;
    end;
    Assert(False);
  end;
var
  LRect: TRect;
begin
  CalcElementRect(ParentTable, LRect);
  //DrawRect(AWebBrowser, ATableRect, AColor);
  InvalidateBrowserRect(AWebBrowser, LRect)
end;
{$ENDIF}

function TCustomHTMLTableDesigner.OnCell(ADragCell: IHTMLTableCell; const X, Y: Integer; var ATableRow2: IHTMLTableRow2): TTableDragKind;
var
  Row: IHTMLTableRow;
  LHTMLElement: IHTMLElement;
  LLeft, LRight: Integer;
  LTop, LBottom: Integer;
begin
  Result := tdkNone;
  Assert(ADragCell <> nil);
  Supports(ADragCell, IHTMLElement, LHTMLElement);
  Assert(LHTMLElement <> nil);
  LLeft := LHTMLElement.OffsetWidth - 5;
  LRight := LHTMLElement.OffsetWidth;
  if (X >= LLeft) and (X < LRight) then
  begin
    if Supports(LHTMLElement.parentElement, IHTMLTableRow, Row) then
      if (ADragCell.cellIndex < Row.cells.length - 1) then
      begin
        Result := tdkColumn;
{$IFDEF DRAWRECT}
        DrawTableRect(WebBrowser, LHTMLElement,
          Rect(LLeft, 0, LRight, GetPixelHeightPropertyValue(ADragCell as IHTMLElement)), clGreen);
{$ENDIF}
      end;
  end;
  LTop := LHTMLElement.OffsetHeight - 4;
  LBottom := LHTMLElement.OffsetHeight;
                                                                                         
  if (Y >= LTop) and
     (Y < LBottom) then
  begin
    Result := tdkRow;
{$IFDEF DRAWRECT}
    DrawTableRect(WebBrowser, LHTMLElement,
      Rect(0, LTop, GetPixelWidthPropertyValue(LHTMLElement), LBottom), clAqua);
{$ENDIF}
  end;
{$IFDEF DRAWRECT}
  if Result = tdkNone then
    EraseTableOfElement(WebBrowser, LHTMLElement);
{$ENDIF}
  if Result <> tdkNone then
    Supports(LHTMLElement.parentElement, IHTMLTableRow2, ATableRow2);
end;

function TCustomHTMLTableDesigner.OnChangeType(eType: TOleEnum;
  const pIListener: ISelectionServicesListener): HRESULT;
begin
  WebBrowser.Document2.selection.empty;
  Result := S_OK;
end;

function TCustomHTMLTableDesigner.OnSelectedElementExit(
  const pIElementStart, pIElementEnd, pIElementContentStart,
  pIElementContentEnd: IMarkupPointer): HRESULT;
begin
  Result := S_OK;
end;

// Based on the position of the mouse on the TABLE tag figure out if
// the cursor is actually on a row or column boundary.
function TCustomHTMLTableDesigner.OnTable(ADragTable: IHTMLTable; const X, Y: Integer;
  var ARow: IHTMLTableRow2): TTableDragKind;
var
  I: Integer;
  E1: IHTMLElement;
  E2: IHTMLElement;
  CellSpacing: Integer;
  LRect: TRect;
  LTop, LBottom: Integer;
begin
  Result := tdkNone;
  if not Assigned(ADragTable) then exit;
  CellSpacing := 0;
  if ADragTable.cellSpacing <> '' then
    CellSpacing := ADragTable.cellSpacing;
  for I := 0 to ADragTable.rows.length - 1 do
  begin
    E1 := ADragTable.rows.item(I, I) as IHTMLElement;
    if (I < ADragTable.rows.length - 1) and
       Supports(ADragTable.rows.item(I + 1, I + 1), IHTMLElement, E2) then
    begin
      LTop := E1.offsetTop;
      LBottom :=  E1.offsetTop + 4;
      if (Y >= LTop) and (Y < LBottom) then
      begin
        Result := tdkRow;
        {$IFDEF DRAWRECT}
        DrawTableRect(WebBrowser, ADragTable as IHTMLElement,
          Rect(0, LTop, GetPixelWidthPropertyValue(ADragTable as IHTMLElement), LBottom), clRed);
        {$ENDIF}
      end;
    end;
    if (Result = tdkNone) then
    begin
      LRect := Rect(CellSpacing + 2, E1.offsetTop + 2, E1.offsetWidth - 2,
        E1.offsetTop + E1.offsetHeight - 2 + 1 );
      if LRect.Contains(Point(X, Y)) then
      begin
        Result := tdkColumn;
        {$IFDEF DRAWRECT}
        DrawTableRect(WebBrowser, ADragTable  as IHTMLElement, LRect, clBlue);
        {$ENDIF}
      end;
    end;
{    if (X >= -1) and (Y <= 1) then
      Result := tdkColSelect;
    if (Y > 3) and (X >= -1) and (X <= 1) then
      Result := tdkRowSelect;}
{$IFDEF DRAWRECT}
    if Result = tdkNone then
      EraseTableOfElement(WebBrowser, ADragTable as IHTMLElement);
{$ENDIF}

    if Result <> tdkNone then
    begin
      Supports(E1, IHTMLTableRow2, ARow);
      break;
    end;
  end;
end;


function TCustomHTMLTableDesigner.PreHandleEvent(inEvtDispId: Integer;
  const pIEventObj: IHTMLEventObj): HRESULT;
begin
  Result := inherited PreHandleEvent(inEvtDispId, pIEventObj);
  case inEvtDispId of
    DISPID_HTMLELEMENTEVENTS_ONKEYDOWN:
      if (Assigned(FDragRow2) or Assigned(FDragCell)) and (pIEventObj.keyCode = VK_ESCAPE) then
      begin
        if FDraggingRow then
          FDragRow2.height := FOffsetPos.X
        else
          SetColumnWidth(FOffsetPos.Y);
        Clear;
      end;
    DISPID_HTMLELEMENTEVENTS_ONMOUSEDOWN:
      Result := DoMouseDown(piEventObj);
    DISPID_HTMLELEMENTEVENTS_ONMOUSEUP:
      if Assigned(FDragRow2) or Assigned(FDragCell) then
        Clear;
    DISPID_HTMLELEMENTEVENTS_ONMOUSEMOVE:
      Result := DoMouseMove(piEventObj);
  end;
end;

procedure TCustomHTMLTableDesigner.SetColumnHeight(const AWidth: Integer);
var
  I: Integer;
  E: IHTMLElement;
  LDragRow: IHTMLTableRow;
begin
  Assert(FDragRow2 <> nil);
  Supports(FDragRow2, IHTMLTableRow, LDragRow);
  Assert(LDragRow <> nil);
                                                                                                  
  SetCursor(LoadCursor(GetModuleHandle('MSHTML.DLL'), '#9804'));  { do not localize }
  if FOffsetPos.X + (Mouse.CursorPos.Y - FOffsetPos.Y) > 0 then
    for I := 0 to LDragRow.cells.length - 1 do
      if Supports(LDragRow.cells.item(I, I), IHTMLElement, E) then
        E.style.height := IntToStr(FOffsetPos.X + (Mouse.CursorPos.Y - FOffsetPos.Y)) + 'px';
end;

procedure TCustomHTMLTableDesigner.SetColumnWidth(const AWidth: Integer);
var
  CellIndex: Integer;
  I: Integer;
  Row: IHTMLTableRow;
  E: IHTMLElement;
begin
  Assert(FDragTable <> nil);
  if (AWidth < 1) or not Assigned(FDragCol) or not Assigned(FDragRow2) or
     not Assigned(FDragTable) then exit;
  SetCursor(LoadCursor(GetModuleHandle('MSHTML.DLL'), '#9805'));  { do not localize }
  CellIndex := (FDragCol as IHTMLTableCell).cellIndex;
  for I := 0 to FDragTable.rows.length - 1 do
    if Supports(FDragTable.rows.item(I, I), IHTMLTableRow, Row) then
      if CellIndex < Row.cells.length then
        if Supports(Row.cells.item(CellIndex, CellIndex), IHTMLElement, E) then
          E.style.width := IntToStr(AWidth) + 'px';                 { do not localize }
end;

procedure TCustomHTMLTableDesigner.SetRowHighlight(const Color: string);
var
  E2: IHTMLElement2;
begin
  if Assigned(FDragRow2) and Supports(FDragRow2, IHTMLElement2, E2) then
    E2.runtimeStyle.backgroundColor := Color;
end;

{ TCustomHTMLDragDropDesigner }


procedure TCustomHTMLDragDropDesigner.Clear;
begin
  FDragOver := False;
  FDragEnter := False;
  RestoreCursor;
end;

procedure TCustomHTMLDragDropDesigner.RestoreCursor;
begin
  if FOverridingCursor then
  begin
    WebBrowser.OverrideCursor := False;
    RestoreBrowserCursor(WebBrowser);
  end;
end;

constructor TCustomHTMLDragDropDesigner.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TCustomHTMLDragDropDesigner.DoDragDrop(
  EventObj: IHTMLEventObj);
var
  dwEffect: Integer;
begin
  if Assigned(FOnDragDrop) then
  begin
    dwEffect := DROPEFFECT_NONE;
    FOnDragDrop(Self, EventObj, dwEffect);
    Clear;
  end;
end;

procedure TCustomHTMLDragDropDesigner.DoDragLeave(
  EventObj: IHTMLEventObj);
begin
  if Assigned(FOnDragLeave) then
    FOnDragLeave(Self, EventObj);
end;

procedure TCustomHTMLDragDropDesigner.DoDragEnter(
  EventObj: IHTMLEventObj);
var
  dwEffect: Integer;
begin
  if Assigned(FOnDragEnter) then
  begin
    dwEffect := DROPEFFECT_NONE;
    FOnDragEnter(Self, EventObj, dwEffect);
    if dwEffect <> DROPEFFECT_NONE then
      FDragEnter := True;
  end;
end;

procedure TCustomHTMLDragDropDesigner.DoDragOver(
  EventObj: IHTMLEventObj);
var
  dwEffect: Integer;
begin
  if Assigned(FOnDragOver) then
  begin
    dwEffect := DROPEFFECT_NONE;
    FOnDragOver(Self, EventObj, dwEffect);
    if dwEffect <> DROPEFFECT_NONE then
      FDragOver := True
    else
      FDragOver := False;
  end
  else
    FDragOver := True;
end;

function TCustomHTMLDragDropDesigner.DoMouseDown(
  EventObj: IHTMLEventObj): HRESULT;
begin
  Result := S_FALSE;
  if FDragEnter then
  begin
    if (EventObj.button = 1) then
    begin
      if FDragOver then
      begin
        Result := S_OK;
        DoDragDrop(EventObj);
        Clear;
      end
      else
        Clear;
    end;
  end;
end;

procedure TCustomHTMLDragDropDesigner.DoSetCursor;
var
  CursorSet: Boolean;
begin
  CursorSet := False;
  if Assigned(FOnSetDragCursor) then
    FOnSetDragCursor(Self, CursorSet);
  if not CursorSet then
    SetCursor(LoadCursor(0, IDC_CROSS))
end;

function TCustomHTMLDragDropDesigner.DoMouseMove(EventObj: IHTMLEventObj): HRESULT;
var
  SaveDragEnter: Boolean;
begin
  Result := S_FALSE;
  SaveDragEnter := FDragEnter;
  case EventObj.button of
    0: begin  // No button pressed
         if not FDragEnter then
           DoDragEnter(EventObj)
         else
           DoDragOver(EventObj);
         //Result := S_OK;
       end;
    1: begin   // left button down and dragging
         // Draw selection rectangle here
         if FDragEnter then
           Result := S_OK;
       end
  end;
  if FDragEnter then
  begin
    FOverridingCursor := True;
    WebBrowser.OverrideCursor := True;
    if FDragOver then
      DoSetCursor
    else
      SetCursor(LoadCursor(0, IDC_NO))
  end
  else if SaveDragEnter then
  begin
    RestoreCursor;
  end;

end;


function TCustomHTMLDragDropDesigner.DoMouseUp(EventObj: IHTMLEventObj): HRESULT;
begin
  Result := S_FALSE;
end;

function TCustomHTMLDragDropDesigner.DoMouseOut(EventObj: IHTMLEventObj): HRESULT;
begin
  Result := S_FALSE;
  case EventObj.button of
    0: begin  // No button pressed
         if FDragEnter then
         begin
           DoDragLeave(EventObj);
           Clear;
         end
       end;
    1: begin   // left button down and dragging
         // Draw selection rectangle here
       end
  end;
end;

function TCustomHTMLDragDropDesigner.PreHandleEvent(inEvtDispId: Integer;
  const pIEventObj: IHTMLEventObj): HRESULT;
begin
  Result := inherited PreHandleEvent(inEvtDispId, pIEventObj);
  case inEvtDispId of
    DISPID_HTMLELEMENTEVENTS_ONKEYDOWN:
      if pIEventObj.keyCode = VK_ESCAPE then
        Result := DoCancel(piEventObj);
    DISPID_HTMLELEMENTEVENTS_ONMOUSEDOWN:
      Result := DoMouseDown(piEventObj);
    DISPID_HTMLELEMENTEVENTS_ONMOUSEUP:
      Result := DoMouseUp(piEventObj);
    DISPID_HTMLELEMENTEVENTS_ONMOUSEMOVE:
      Result := DoMouseMove(piEventObj);
    DISPID_HTMLELEMENTEVENTS_ONMOUSEOUT:
      if Supports(piEventObj.srcElement, IHTMLBodyElement) then
        Result := DoMouseOut(piEventObj);
    DISPID_HTMLELEMENTEVENTS_ONMOUSEENTER:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS_ONMOUSELEAVE:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS_ONMOVESTART:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS_ONMOVEEND:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS_ONMOVE:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS_ONRESIZESTART:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS_ONRESIZEEND:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS_ONRESIZE:
      Result := S_FALSE;
  end;
end;


function TCustomHTMLDragDropDesigner.DoCancel(
  EventObj: IHTMLEventObj): HRESULT;
begin
                                                
  Result := S_FALSE;
end;

{ TCustomHTMLRegionDesigner }

constructor TCustomHTMLRegionDesigner.Create(AOwner: TComponent);
begin
  inherited;
end;

function TCustomHTMLRegionDesigner.InClickableRegion(EventObj: IHTMLEventObj): Boolean;
var
  Region: Integer;
begin
  Result := InClickableRegion(EventObj, Region);
end;

function TCustomHTMLRegionDesigner.InNonEditableRegion(EventObj: IHTMLEventObj): Boolean;
begin
   Result := OverClient(EventObj) and (not WebBrowser.GetIsEditableElement(EventObj.srcElement, [efInnerOrOuterRequired]));
end;

function TCustomHTMLRegionDesigner.OverSelectableControlInRegion(EventObj: IHTMLEventObj): Boolean;
var
  LHTMLElement: IHTMLElement;
begin
  Result := OverSelectableControlInRegion(EventObj, LHTMLElement);
end;

function TCustomHTMLRegionDesigner.CanSelectTextInSrcElement(EventObj: IHTMLEventObj): Boolean;
begin
  Result := Supports(EventObj.srcElement, IHTMLDivElement) or
    Supports(EventObj.srcElement, IHTMLSpanElement) or
    Supports(EventObj.srcElement, IHTMLTableCell);
  if Result then
    if not IsPrimaryDocumentEvent(EventObj) then
      if not WebBrowser.GetIsEditableElement(EventObj.srcElement, [efInnerRequired]) then
        Result := False;
end;

function TCustomHTMLRegionDesigner.OverSelectableControlInRegion(EventObj: IHTMLEventObj; out AControlElement: IHTMLElement): Boolean;
var
  LRegionElement: IHTMLElement;
  LRegionControlElement: IHTMLElement;
  LRegion: Integer;
begin
  AControlElement := nil;
  Result := False;
  if (not IsPrimaryDocumentEvent(EventObj)) and OverClient(EventObj) then
  begin
    if WebBrowser.CurrentElement <> nil then
    begin
       // Over an element that is in the same document as the selection.  No need to select
       if SameDocument(WebBrowser.CurrentElement.document as IHTMLDocument,
          EventObj.srcElement.document as IHTMLDocument) then
       begin
         Result := False;
         Exit;
       end;
    end;
    LRegion := RegionIndexOfElementOrParent(EventObj.srcElement, LRegionElement);
    if LRegion >= 0 then
      if WebBrowser.GetIsEditableElement(EventObj.srcElement, [efSelectableControlRequired]) then
      begin
        // Selectable control within a region (asp:button, button, div with layout, table)
        AControlElement := EventObj.srcElement;
        Result := True;
      end;
    if not Result then
    begin
      if LRegionElement <> nil then
      begin
        LRegionControlElement := WebBrowser.GetElementOfViewLinkDocument(LRegionElement.document as IHTMLDocument);
        if (LRegionControlElement <> nil) and not IsPrimaryDocumentElement(LRegionControlElement.parentElement) then
        begin
          // Region within a region (e.g.; Panel within a Panel)
          if (WebBrowser.CurrentElement <> nil) and
            SameDocument(WebBrowser.CurrentElement.document as IHTMLDocument,
            LRegionControlElement.document as IHTMLDocument) then
          begin
            // over element in region when region is already selected
            Result := False;
            Exit;
          end;
          AControlElement := LRegionControlElement;
          Result := True;
        end;
      end;
    end;
  end
end;

function TCustomHTMLRegionDesigner.InClickableRegion(EventObj: IHTMLEventObj; out Region: Integer): Boolean;
var
  RegionElement: IHTMLElement;
begin
  Result := False;
  Region := -1;
  if (not IsPrimaryDocumentEvent(EventObj)) and OverClient(EventObj) then
  begin
    Region := RegionIndexOfElementOrParent(EventObj.srcElement, RegionElement);
    if Region >= 0 then
      if Assigned(FOnCanClickRegion) then
        FOnCanClickRegion(Self, EventObj, Region, Result)
      else
        Result := True;
  end
end;

const
  sRegionIndexAttributeName = '__BorlControlRegionIndex';
class function TCustomHTMLRegionDesigner.RegionIndexOfElement(HTMLElement: IHTMLElement): Integer;
var
  Index: OleVariant;
begin
  Result := -1;
  Index := HTMLElement.getAttribute(sRegionIndexAttributeName, 0);
  if  not VarIsNull(Index) then
    try
      Result := Index;
    except
      // Ignore.  Return -1;
    end;
end;

class function TCustomHTMLRegionDesigner.RegionIndexOfElementOrParent(HTMLElement: IHTMLElement; out RegionElement: IHTMLElement): Integer;
var
  Current: IHTMLElement;
begin
  RegionElement := nil;
  Current := HTMLElement;
  while Current <> nil do
  begin
    Result := RegionIndexOfElement(Current);
    if Result >= 0 then
    begin
       RegionElement := Current;
       Exit;
    end;
    Current := Current.parentElement;
  end;
  Result := -1;
end;

procedure TCustomHTMLRegionDesigner.SetClickableRegionCursor(EventObj: IHTMLEventObj);
begin
  SetCursor(LoadCursor(0, IDC_ARROW));
  FOverridingCursor := True;
  WebBrowser.OverrideCursor := True;
end;

procedure TCustomHTMLRegionDesigner.SetNonEditableRegionCursor(EventObj: IHTMLEventObj);
begin
  SetCursor(LoadCursor(0, IDC_SIZEALL));
  FOverridingCursor := True;
  WebBrowser.OverrideCursor := True;
end;

//{$DEFINE SHOWOVERSELECTABLECONTROLCURSOR}
procedure TCustomHTMLRegionDesigner.SetOverSelectableControlInRegionCursor(EventObj: IHTMLEventObj);
begin
  RestoreCursor;
{$IFDEF SHOWOVERSELECTABLECONTROLCURSOR}
  SetCursor(LoadCursor(0, IDC_HAND)); // testing
{$ENDIF}
end;

procedure TCustomHTMLRegionDesigner.SelectControlInRegion(AHTMLElement: IHTMLElement);
var
  LControlRange: IHTMLControlRange2;
  LHTMLElement2: IHTMLElement2;
begin
                                                                        
  LHTMLElement2 := (AHTMLElement.document as IHTMLDocument2).body as IHTMLElement2;
  LControlRange := LHTMLElement2.createControlRange as IHTMLControlRange2;
  try
    LControlRange.addElement(AHTMLElement);
    (LControlRange as IHTMLControlRange).select;
  except
    // Ignore exception in case this element is not selectable
    try
      Assert(False);
    finally
      Application.HandleException(self);
    end;
  end;
end;

procedure TCustomHTMLRegionDesigner.SetFocusControlInRegion(AHTMLElement: IHTMLElement);
var
  LDocument4: IHTMLDocument4;
begin
                                                                        
  LDocument4 := (AHTMLElement.document as IHTMLDocument4);
  try
    LDocument4.focus;
  except
    // Ignore exception
  end;
end;

procedure TCustomHTMLRegionDesigner.RestoreCursor;
begin
  if FOverridingCursor then
  begin
    FOverridingCursor := False;
    WebBrowser.OverrideCursor := False;
    RestoreBrowserCursor(WebBrowser);
  end;
end;

function TCustomHTMLRegionDesigner.DoMouseMove(EventObj: IHTMLEventObj): HRESULT;
begin
  Result := S_FALSE;
  case EventObj.button of
    0: begin  // No button pressed
         //if SameText(EventObj.srcElement.tagName, 'span') then
         if InClickableRegion(EventObj) then
         begin
           SetClickableRegionCursor(EventObj);
         end
         else if InNonEditableRegion(EventObj) then
         begin
           SetNonEditableRegionCursor(EventObj);
         end
         else if OverSelectableControlInRegion(EventObj) then
         begin
           SetOverSelectableControlInRegionCursor(EventObj);
         end
         else
           RestoreCursor;
//           if FOverridingCursor then
//           begin
//             FOverridingCursor := False;
//             WebBrowser.OverrideCursor := False;
//             RestoreBrowserCursor(WebBrowser);
//           end;
       end;
    1: begin // button pressed
       end;
  end;
end;

var
  FMouseDownCancelClickableRegion: Boolean = False;
  FMouseDownCanceNonEditableRegion: Boolean = False;
  FMouseUpCancelClickableRegion: Boolean = False;
  FMouseUpCanceNonEditableRegion: Boolean = False;
  FClickNonEditableRegionOnDown: Boolean = False;
  FClickRegionOnDown: Boolean = False;
  FCancelClickableOnDown: Boolean = True;
  FCancelClickableOnUp: Boolean = False;
  FCancelSelectableOnDown: Boolean = False;
  FSetFocusClickableOnDown: Boolean = False;
  FSelectClickableOnDown: Boolean = True;
  FSelectClickableOnPostDown: Boolean = True;
  FCancelCtrlKeyOnSelect: Boolean = True;

function IsClickableElement(HTMLElement: IHTMLElement): Boolean;
var
  LTagName: string;
begin
  Result := False;
  if HTMLElement <> nil then
  begin
    LTagName := HTMLElement.tagName;
    Result := SameText(LTagName, 'a') or
      SameText(LTagName, 'input');
  end;
end;

function TCustomHTMLRegionDesigner.DoPostEditEventMouseDown(EventObj: IHTMLEventObj): HRESULT;
var
  LSelectableControl: IHTMLElement;
begin
  Result := S_FALSE;
  FMouseDownCancelled := False;
  case EventObj.button of
    1: begin  // Left button pressed
         if OverSelectableControlInRegion(EventObj, LSelectableControl) and
           CanSelectTextInSrcElement(EventObj) then
         begin
           if FSelectClickableOnPostDown then
             begin
             SelectControlInRegion(LSelectableControl);
           end;
         end;
       end;
  end;
end;

var
  FFilterKeyDown: Boolean = false;
  FFilterKeyUp: Boolean = false;
  FFilterKeyPress: Boolean = true;

function TCustomHTMLRegionDesigner.CanEnterText(AEventObj: IHTMLEventObj): Boolean;
begin
  Result := True;
  if WebBrowser.GetIsContentPage then  // Optimization to improve performance while typing
    case WebBrowser.CurrentElementType of
      cetAtCursor, cetTextRange:
        Result := WebBrowser.GetIsEditableElement(WebBrowser.CurrentElement, [efInnerRequired]);
    end;
end;

function TCustomHTMLRegionDesigner.DoKeyDown(EventObj: IHTMLEventObj): HRESULT;
begin
  Result := S_FALSE;
  if FFilterKeyDown then
  if not CanEnterText(EventObj) then
    Result := S_OK;
end;

function TCustomHTMLRegionDesigner.DoKeyUp(EventObj: IHTMLEventObj): HRESULT;
begin
  Result := S_FALSE;
  if FFilterKeyUp then
  if not CanEnterText(EventObj) then
    Result := S_OK;
end;

function TCustomHTMLRegionDesigner.DoKeyPress(EventObj: IHTMLEventObj): HRESULT;
begin
  Result := S_FALSE;
  if FFilterKeyPress then
  if not CanEnterText(EventObj) then
    Result := S_OK;
end;

procedure TCustomHTMLRegionDesigner.CalcClientRect(var Rect: TRect);
var
  Wnd: HWND;
  body: IHTMLElement2;
  LScrollTop, LScrollLeft: Integer;
begin
  (WebBrowser.Document as IOleWindow).GetWindow(Wnd);
  Winapi.Windows.GetClientRect(Wnd, Rect);
  Rect.Right := Rect.right - GetSystemMetrics(SM_CXVSCROLL);
  body := WebBrowser.Document2.body as IHTMLElement2;
  if body.scrollHeight > body.clientHeight then
    Rect.Bottom := Rect.Bottom - GetSystemMetrics(SM_CYHSCROLL);
  // Adjust rect to work with EventObj.ClientX, ClientY
  LScrollTop := body.scrollTop;
  LScrollLeft := body.scrollLeft;
  OffsetRect(Rect, LScrollLeft, LScrollTop);
end;

function TCustomHTMLRegionDesigner.OverClient(EventObj: IHTMLEventObj): Boolean;
var
  Rect: TRect;
begin
  CalcClientRect(Rect);
  Result := Rect.Contains(Point(EventObj.clientX, EventObj.clientY));
end;

function TCustomHTMLRegionDesigner.DoMouseDown(EventObj: IHTMLEventObj): HRESULT;
var
  LHandled: Boolean;
  Region: Integer;
  LSelectableControl: IHTMLElement;
begin
  Result := S_FALSE;
  FMouseDownCancelled := False;
  case EventObj.button of
    1: begin  // Left button pressed
         if InClickableRegion(EventObj, Region) then
         begin
           SetClickableRegionCursor(EventObj);
           if FClickRegionOnDown then
             if Assigned(FOnClickRegion) then
               FOnClickRegion(Self, EventObj, Region);
           if FMouseDownCancelClickableRegion then
             Result := S_OK;
           if FCancelClickableOnDown then
             if IsClickableElement(EventObj.srcElement) then
             begin
               FMouseDownCancelled := True;
               Result := S_OK;
             end;
         end
         else if InNonEditableRegion(EventObj) then
         begin
           SetNonEditableRegionCursor(EventObj);
           if FClickNonEditableRegionOnDown then
             if Assigned(FOnClickNonEditable) then
               FOnClickNonEditable(Self, EventObj, LHandled);
           if FMouseDownCanceNonEditableRegion then
             Result := S_OK;
           if FCancelClickableOnDown then
             if IsClickableElement(EventObj.srcElement) then
               Result := S_OK;
         end
         else if OverSelectableControlInRegion(EventObj, LSelectableControl) and
           not CanSelectTextInSrcElement(EventObj) then
         begin
           if FSetFocusClickableOnDown then
           begin
             SetFocusControlInRegion(LSelectableControl);
           end;
           if FSelectClickableOnDown then
             begin
             SelectControlInRegion(LSelectableControl);
             if FCancelCtrlKeyOnSelect then
               if EventObj.ctrlKey then
               begin
                 // Prevent ie control from selecting body of view link
                 FMouseDownCancelled := True;
                 Result := S_OK;
               end;
             
             if FCancelSelectableOnDown then
             begin
               FMouseDownCancelled := True;
               Result := S_OK;
             end;
           end;
         end;
       end;
  end;
end;

function TCustomHTMLRegionDesigner.DoMouseUp(EventObj: IHTMLEventObj): HRESULT;
var
  Region: Integer;
  LHandled: Boolean;
begin
  Result := S_FALSE;
  case EventObj.button of
    1: begin  // Left button pressed
         if InClickableRegion(EventObj, Region) then
         begin
           SetClickableRegionCursor(EventObj);
                                          
           if not FClickRegionOnDown then
             if Assigned(FOnClickRegion) then
               FOnClickRegion(Self, EventObj, Region);
           if FMouseUpCancelClickableRegion then
             Result := S_OK;
           if FCancelClickableOnUp then
             if IsClickableElement(EventObj.srcElement) then
               Result := S_OK;
         end
         else if InNonEditableRegion(EventObj) then
         begin
           SetNonEditableRegionCursor(EventObj);
           if not FClickNonEditableRegionOnDown then
             if Assigned(FOnClickNonEditable) then
               FOnClickNonEditable(Self, EventObj, LHandled);
           if FMouseUpCanceNonEditableRegion then
             Result := S_OK;
           if FCancelClickableOnUp then
             if IsClickableElement(EventObj.srcElement) then
               Result := S_OK;
         end;
         if FMouseDownCancelled then
         begin
           FMouseDownCancelled := False;
           Result := S_OK;
         end;
       end;
  end;
end;

function TCustomHTMLRegionDesigner.DoBeforeDeactivate(EventObj: IHTMLEventObj): HRESULT;
begin
  Result := S_FALSE;
  if not IsPrimaryDocumentEvent(EventObj) then
  begin
    // Temporary.  Eventually allow some regions to get the edit focus.
    // Prevent asp controls from getting focus because we are no longer
    // using the frozen property.
    //Result := S_OK;
  end;
end;

function TCustomHTMLRegionDesigner.PreHandleEvent(inEvtDispId: Integer;
  const pIEventObj: IHTMLEventObj): HRESULT;
begin
  Result := inherited PreHandleEvent(inEvtDispId, pIEventObj);
  case inEvtDispId of
    DISPID_HTMLELEMENTEVENTS_ONBEFOREDEACTIVATE:
      Result := DoBeforeDeactivate(piEventObj);
    DISPID_HTMLELEMENTEVENTS_ONBEFOREACTIVATE:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS_ONBEFOREEDITFOCUS:
      Result := S_FALSE;
      //Prevent edit focus?  Doesn't work.
      //  if not IsPrimaryDocumentEvent(pIEventObj) then
      //    Result := S_OK;
    DISPID_HTMLELEMENTEVENTS2_ONFOCUSIN:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS2_ONFOCUSOUT:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS_ONMOUSEMOVE:
      Result := DoMouseMove(piEventObj);
    DISPID_HTMLELEMENTEVENTS_ONMOUSEDOWN:
      Result := DoMouseDown(piEventObj);
    DISPID_HTMLELEMENTEVENTS_ONMOUSEUP:
      Result := DoMouseUp(piEventObj);
    DISPID_HTMLELEMENTEVENTS_ONKEYDOWN:
      Result := DoKeyDown(piEventObj);
    DISPID_HTMLELEMENTEVENTS_ONKEYUP:
      Result := DoKeyUp(piEventObj);
    DISPID_HTMLELEMENTEVENTS_ONKEYPRESS:
      Result := DoKeyPress(piEventObj);
  end;
end;

function TCustomHTMLRegionDesigner.TranslateAccelerator(inEvtDispId: Integer;
      const pIEventObj: IHTMLEventObj): HRESULT;
begin
  Result := inherited TranslateAccelerator(inEvtDispId, pIEventObj);
  case inEvtDispId of
    DISPID_HTMLELEMENTEVENTS_ONKEYDOWN,
    DISPID_HTMLELEMENTEVENTS_ONKEYUP:
      if pIEventObj.keyCode = VK_DELETE then
      begin
        //if not (csEnabled in WebBrowser.CommandState(IDM_DELETE)) then
        if WebBrowser.GetIsContentPage then
        begin
          case WebBrowser.CurrentElementType of
            cetAtCursor,
            cetTextRange:
              if not WebBrowser.GetIsEditableElement(
                WebBrowser.CurrentElement, [efInnerRequired]) then
               Result := S_OK;
            cetControlRange:
              if not WebBrowser.GetIsEditableElement(
                WebBrowser.CurrentElement.parentElement, [efInnerRequired]) then
                Result := S_OK;
          end;
        end;
      end;
  end;
end;

function TCustomHTMLRegionDesigner.PostEditorEventNotify(inEvtDispId: Integer;
  const pIEventObj: IHTMLEventObj): HRESULT;
begin
  Result := inherited PreHandleEvent(inEvtDispId, pIEventObj);
  case inEvtDispId of
    DISPID_HTMLELEMENTEVENTS_ONBEFOREDEACTIVATE:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS_ONBEFOREACTIVATE:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS_ONBEFOREEDITFOCUS:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS2_ONFOCUSIN:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS2_ONFOCUSOUT:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS_ONMOUSEMOVE:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS_ONMOUSEDOWN:
      Result := DoPostEditEventMouseDown(piEventObj);
    DISPID_HTMLELEMENTEVENTS_ONMOUSEUP:
      Result := S_FALSE;
  end;
end;

function TCustomHTMLRegionDesigner.PostHandleEvent(inEvtDispId: Integer;
  const pIEventObj: IHTMLEventObj): HRESULT;
begin
  Result := inherited PreHandleEvent(inEvtDispId, pIEventObj);
  case inEvtDispId of
    DISPID_HTMLELEMENTEVENTS_ONBEFOREDEACTIVATE:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS_ONBEFOREACTIVATE:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS_ONBEFOREEDITFOCUS:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS2_ONFOCUSIN:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS2_ONFOCUSOUT:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS_ONMOUSEMOVE:
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS_ONMOUSEDOWN:
      //Result := DoPostMouseDown(piEventObj);
      Result := S_FALSE;
    DISPID_HTMLELEMENTEVENTS_ONMOUSEUP:
      Result := S_FALSE;
  end;
end;

{ TCustomBodyGridBehavior }

procedure TCustomBodyGridBehavior.AddGridBehaviors;
var
  Document: IHTMLDocument2;
  I: Integer;
  MSPositioning: OleVariant;
  E: IHTMLElement;
  Len: Integer;
  Col: IHTMLElementCollection;
  MC: IMarkupContainer2;
begin
  if Element <> nil then
  begin
    Document := Element.document as IHTMLDocument2;
    MC := Document as IMarkupContainer2;
    if FBehaviorsDocVersion <> MC.GetVersionNumber then
    begin
      FBehaviorsDocVersion := MC.GetVersionNumber;
      Col := Element.all as IHTMLElementCollection;
      Len := Col.length;
      for I := 0 to Len - 1 do
      begin
        E := Col.item(I, I) as IHTMLElement;
        MSPositioning := E.getAttribute(sMSPositioning, 0);
                                                 
        if Supports(E, IHTMLDivElement) or GridInfo.IsCustomContainer(E) then
          AddGridBehavior(MSPositioning, E);
      end;
    end;
  end;
end;

function TCustomBodyGridBehavior.AddGridBehavior(MSPositioning: OleVariant; Element: IHTMLElement): Boolean;
var
  E2: IHTMLElement2;
begin
  Result := False;
  if IsGridPositioning(MSPositioning) then
  begin
    Result := True;
    E2 := Element as IHTMLElement2;
    if VarIsNull(E2.runtimeStyle.getAttribute(sHasGrid, 0)) then
    begin
      FGridWrapper.AddBehavior(Element);
      E2.runtimeStyle.setAttribute(sHasGrid, 'true', 0);
    end;
  end;
end;

procedure TCustomBodyGridBehavior.BehaviorCreated(
  Sender: TCustomBehaviorWrapper; const Behavior: TCustomElementBehavior);
begin
  FBehaviors.Add(Behavior);
  // GridInfo shouldn't have been created.  Check this.
  Assert(TCustomGridBehavior(Behavior).FGridInfo = nil);
  // All behaviors share same manager.
  TCustomGridBehavior(Behavior).GridInfo := GridInfo;
end;

procedure TCustomBodyGridBehavior.BehaviorDestroyed(
  Sender: TCustomBehaviorWrapper; const Behavior: TCustomElementBehavior);
var
  Idx: Integer;
begin
  Idx := FBehaviors.IndexOf(Behavior);
  if Idx <> -1 then
    FBehaviors.Delete(Idx);
end;

destructor TCustomBodyGridBehavior.Destroy;
begin
  FBehaviors.Free;
  FGridWrapper.Free;
  inherited;
end;

function TCustomBodyGridBehavior.Detach: HRESULT;
var
  E2: IHTMLElement2;
begin
  while FBehaviors.Count > 0 do
  begin
    E2 := TCustomElementBehavior(FBehaviors[0]).Element as IHTMLElement2;
    if (E2 <> nil) and not VarIsNull(E2.runtimeStyle.getAttribute(sHasGrid, 0)) then
      E2.runtimeStyle.setAttribute(sHasGrid, null, 0);
    FGridWrapper.RemoveBehavior(TCustomElementBehavior(FBehaviors[0]));
  end;
  FGridWrapper.GUID := '';  { do not localize }
  Result := inherited Detach;
end;

procedure TCustomBodyGridBehavior.GetComClass(Sender: TComComponent;
  var ComClass: TComClass);
begin
  ComClass := TCustomGridBehavior;
end;

procedure TCustomBodyGridBehavior.Initialize;
begin
  inherited;
  GridInfo.OnInvalidateGrid := InvalidateGrid;
  FBehaviors := TList.Create;
  FGridWrapper := TCustomBehaviorWrapper.Create(nil);
  FGridWrapper.GUID := '{036F13F7-E081-46C3-964C-A74A145D4DE5}';  { do not localize }
  FGridWrapper.OnGetComClass := GetComClass;
  FGridWrapper.URL := 'taggrid';        { do not localize }
  // Namespace must be '' to attach to asp controls
  FGridWrapper.Namespace := '';
  FGridWrapper.OnBehaviorCreated := BehaviorCreated;
  FGridWrapper.OnBehaviorDestroy := BehaviorDestroyed;
  FGridWrapper.Factory := GetBehaviorWrapper.Factory;
end;

{ THTMLEditDesignerImpl }

constructor THTMLEditDesignerImpl.Create(
  AComponent: TCustomHTMLEditDesigner);
begin
  FComponent := AComponent;
  Supports(FComponent, IHTMLEditDesigner, FComponentIntf);
  Assert(FComponentIntf <> nil);
  FComponent.FDesignerImpl := Self;
end;

procedure THTMLEditDesignerImpl.DisconnectComponent;
begin
  if FComponent <> nil then
  begin
    FComponent.FActive := False;
    FComponent.FDesignerImpl := nil;
    FComponentIntf := nil;
    FComponent := nil;
  end;
end;

destructor THTMLEditDesignerImpl.Destroy;
begin
  DisconnectComponent;
  inherited;
end;

function THTMLEditDesignerImpl.PostEditorEventNotify(inEvtDispId: Integer;
  const pIEventObj: IHTMLEventObj): HRESULT;
begin
  if FComponentIntf <> nil then
    Result := FComponentIntf.PostEditorEventNotify(inEvtDispId, pIEventObj)
  else
    Result := S_FALSE;
end;

function THTMLEditDesignerImpl.PostHandleEvent(inEvtDispId: Integer;
  const pIEventObj: IHTMLEventObj): HRESULT;
begin
  if FComponentIntf <> nil then
    Result := FComponentIntf.PostHandleEvent(inEvtDispId, pIEventObj)
  else
    Result := S_FALSE;
end;

function THTMLEditDesignerImpl.PreHandleEvent(inEvtDispId: Integer;
  const pIEventObj: IHTMLEventObj): HRESULT;
begin
  if FComponentIntf <> nil then
    Result := FComponentIntf.PreHandleEvent(inEvtDispId, pIEventObj)
  else
    Result := S_FALSE;
end;

function THTMLEditDesignerImpl.TranslateAccelerator(inEvtDispId: Integer;
  const pIEventObj: IHTMLEventObj): HRESULT;
begin
  if FComponentIntf <> nil then
    Result := FComponentIntf.TranslateAccelerator(inEvtDispId, pIEventObj)
  else
    Result := S_FALSE;
end;

{ TCustomSelectionDesigner }

procedure TCustomSelectionDesigner.AdjustSelectionRect;
var
  I: Integer;
  E2: IHTMLElement2;
begin
  // Adjust the rect if it was not dragged from top/left to bottom/right.
  if (FSelectionRect.Left > FSelectionRect.Right) then
  begin
    I := FSelectionRect.Right;
    FSelectionRect.Right := FSelectionRect.Left;
    FSelectionRect.Left := I;
  end;
  if (FSelectionRect.Top > FSelectionRect.Bottom) then
  begin
    I := FSelectionRect.Bottom;
    FSelectionRect.Bottom := FSelectionRect.Top;
    FSelectionRect.Top := I;
  end;
  if Supports(WebBrowser.Document2.body, IHTMLElement2, E2) then
    OffsetRect(FSelectionRect, E2.scrollLeft, E2.scrollTop);
end;

function TCustomSelectionDesigner.CalcMousePt(
  EventObj: IHTMLEventObj): TPoint;
begin
  Result := Point(EventObj.screenX, EventObj.screenY);
  ScreenToClient(WebBrowser.InetExplorerServerHandle, Result);
  if (Result.X > FSrcElementXY.X + FSrcElement.offsetWidth) then
    Result.X := FSrcElementXY.X + FSrcElement.offsetWidth;
  if (Result.Y > FSrcElementXY.Y + FSrcElement.offsetHeight) then
    Result.Y := FSrcElementXY.Y + FSrcElement.offsetHeight;
  if (Result.X + FSrcBody.scrollLeft < FSrcElementXY.X) then
    Result.X := FSrcElementXY.X;
  if (Result.Y + FSrcBody.scrollTop < FSrcElementXY.Y) then
    Result.Y := FSrcElementXY.Y;
end;

procedure TCustomSelectionDesigner.CancelSelection;
begin
  {$IFDEF DEVELOPERS}
  OutputDebugString('TCustomSelectionDesigner.CancelSelection');
  {$ENDIF}
  FSelectionStarted := False;
  ClearSelectionRect;
  FDrawPrevious := False;
  WebBrowser.OverrideCursor := FOverrideCursorState;
  RestoreBrowserCursor(WebBrowser);
  FSrcElement := nil;
  FSrcBody := nil;
  ReleaseCapture;
end;

procedure TCustomSelectionDesigner.ClearSelectionRect;
begin
  if not FDrawPrevious then exit;
  FCanvas.Handle := GetDC(WebBrowser.InetExplorerServerHandle);
  FCanvas.Rectangle(FSelectionRect);
  FCanvas.Handle := 0;
end;

destructor TCustomSelectionDesigner.Destroy;
begin
  FreeAndNil(FCanvas);
  inherited;
end;

function TCustomSelectionDesigner.DoMouseDown(
  EventObj: IHTMLEventObj): HRESULT;
begin
  Result := S_OK;
  FOverrideCursorState := WebBrowser.OverrideCursor;
  WebBrowser.OverrideCursor := True;
  SetCursor(LoadCursor(0, IDC_CROSS));
  FInitialPt := Point(EventObj.screenX, EventObj.screenY);
  ScreenToClient(WebBrowser.InetExplorerServerHandle, FInitialPt);
  FDrawPrevious := False;
  SetCapture(WebBrowser.InetExplorerServerHandle);
  FSelectionStarted := True;
  FSrcElement := EventObj.srcElement;
  FSrcBody := FSrcElement as IHTMLElement2;
  while not Supports(FSrcBody, IHTMLBodyElement) do
    FSrcBody := (FSrcBody as IHTMLElement).parentElement as IHTMLElement2;
                                                                 
  while not Supports(FSrcElement, IHTMLBodyElement) and
     not Supports(FSrcElement, IHTMLDivElement) and
     not Supports(FSrcElement, IHTMLSpanElement) and
     not Supports(FSrcElement, IHTMLTableCell) do
    FSrcElement := FSrcElement.parentElement;
  FSrcElementXY := CalcElementXY(FSrcElement);
  {$IFDEF DEVELOPERS}
  OutputDebugString(PChar(Format('Selection Source Element: %s', [FSrcElement.tagName])));
  {$ENDIF}
end;

function TCustomSelectionDesigner.DoMouseMove(
  EventObj: IHTMLEventObj): HRESULT;
var
  P: TPoint;
begin
  Result := S_FALSE;
  if EventObj.button <> 1 then exit;
  P := CalcMousePt(EventObj);
  ClearSelectionRect;
  FDrawPrevious := True;
                                                                              
  FCanvas.Handle := GetDC(WebBrowser.InetExplorerServerHandle);
  FSelectionRect := Rect(FInitialPt.X, FInitialPt.Y, P.X, P.Y);
  FCanvas.Rectangle(FSelectionRect);
  FCanvas.Handle := 0;
  Result := S_OK;
end;

function TCustomSelectionDesigner.DoMouseUp(
  EventObj: IHTMLEventObj): HRESULT;
begin
  Result := S_OK;
  FSelectionRect.BottomRight := CalcMousePt(EventObj);
  FSelectionStarted := False;
  ClearSelectionRect;
  FDrawPrevious := False;
  SelectControls;
  WebBrowser.OverrideCursor := FOverrideCursorState;
  RestoreBrowserCursor(WebBrowser);
  ReleaseCapture;
  FSrcElement := nil;
  FSrcBody := nil;
end;

function TCustomSelectionDesigner.PreHandleEvent(inEvtDispId: Integer;
  const pIEventObj: IHTMLEventObj): HRESULT;
begin
  Result := S_FALSE;
  if (not pIEventObj.shiftKey) then
  begin
    if FSelectionStarted then
      CancelSelection;
    exit;
  end;
  case inEvtDispId of
    DISPID_HTMLELEMENTEVENTS_ONMOUSEMOVE:
      if FSelectionStarted then
        Result := DoMouseMove(piEventObj);
    DISPID_HTMLELEMENTEVENTS_ONMOUSEDOWN:
      Result := DoMouseDown(piEventObj);
    DISPID_HTMLELEMENTEVENTS_ONMOUSEUP:
      if FSelectionStarted then
        Result := DoMouseUp(piEventObj);
  end;
end;

procedure TCustomSelectionDesigner.SelectControls;
var
  I: Integer;
  ControlRange: IHTMLControlRange;
  SelectRange: Boolean;
  E: IHTMLElement;
  E2: IHTMLElement2;
  CtrlElement: IHTMLControlElement;
  ElementCol: IHTMLElementCollection;
  Union: TRect;
  HTMLRect: IHTMLRect;
begin
  if Supports(FSrcElement, IHTMLElement2, E2) and
     Supports(E2.createControlRange, IHTMLControlRange, ControlRange) and
     Supports(FSrcElement.all, IHTMLElementCollection, ElementCol) then
  begin
    AdjustSelectionRect;
    SelectRange := False;
    for I := 0 to ElementCol.length - 1 do
    begin
      // Only select elements that are contained within the FScrElement
      if Supports(ElementCol.item(I, I), IHTMLElement, E) and
         not FSrcElement.contains(E) or
         Supports(E.parentElement, IHTMLTable) or
         Supports(E.parentElement, IHTMLTableSection) or
         Supports(E.parentElement, IHTMLTableRow) then continue;
      if Supports(ElementCol.item(I, I), IHTMLControlElement, CtrlElement) then
      begin
        E := CtrlElement as IHTMLElement;
        HTMLRect := (E as IHTMLElement2).getBoundingClientRect;
        if IntersectRect(Union, FSelectionRect, Rect(HTMLRect.Left, HTMLRect.Top, HTMLRect.Right, HTMLRect.Bottom)) then
        try
          ControlRange.add(CtrlElement);
          SelectRange := True;
        except
        end;
      end
      else
        if Supports(ElementCol.item(I, I), IHTMLElement2, E2) then
          if (E2.currentStyle as IHTMLCurrentStyle2).hasLayout then
          begin
            HTMLRect := E2.getBoundingClientRect;
            if IntersectRect(Union, FSelectionRect, Rect(HTMLRect.Left, HTMLRect.Top, HTMLRect.Right, HTMLRect.Bottom)) then
            begin
              (ControlRange as IHTMLControlRange2).addElement(E2 as IHTMLElement);
              SelectRange := True;
            end;
          end;
    end;
    if SelectRange then
      ControlRange.select;
  end;
end;

procedure TCustomSelectionDesigner.SetActive(const Value: Boolean);
begin
  inherited;
  if Value then
  begin
    FCanvas := TCanvas.Create;
    FCanvas.Brush.Style := bsClear;
    FCanvas.Pen.Style := psDot;
    FCanvas.Pen.Mode := pmXor;
    FCanvas.Pen.Width := 1;
    FCanvas.Pen.Color := clWhite;
  end
  else
    FreeAndNil(FCanvas);
end;

function TCustomSelectionDesigner.TranslateAccelerator(
  inEvtDispId: Integer; const pIEventObj: IHTMLEventObj): HRESULT;
begin
  {$IFDEF DEVELOPERS}
  if (inEvtDispId = DISPID_HTMLELEMENTEVENTS_ONKEYUP) and FSelectionStarted then
    OutputDebugString('TCustomSelectionDesigner.TranslateAccelerator KeyUp');
  {$ENDIF}
  Result := S_FALSE;
  if (inEvtDispId = DISPID_HTMLELEMENTEVENTS_ONKEYUP) and FSelectionStarted then
    CancelSelection;
end;

end.

