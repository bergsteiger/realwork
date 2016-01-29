{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{   XP Themes (c) Akzhan Abdulin                     }
{                                                    }
{====================================================}
{$INCLUDE elpack2.inc}
{$IFDEF ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$ELSE}
{$IFDEF LINUX}
{$I ../ElPack.inc}
{$ELSE}
{$I ..\ElPack.inc}
{$ENDIF}
{$ENDIF}

unit ElPgCtl;

// $Id: ElPgCtl.pas,v 1.1 2007/03/21 08:43:43 lulin Exp $
// $Log: ElPgCtl.pas,v $
// Revision 1.1  2007/03/21 08:43:43  lulin
// - ЭлПак переехал в каталог для рудиментов.
//
// Revision 1.79  2007/03/20 15:25:16  lulin
// - bug fix: не обновлялся текст закладок.
//
// Revision 1.78  2006/12/08 10:21:13  mmorozov
// - change: стиль отрисовки для FlatTabs;
//
// Revision 1.77  2006/12/07 14:20:58  mmorozov
// - new: используем единые настройки для компонента с вкладками (CQ: OIT5-23819);
//

interface

uses
  Classes,
  SysUtils,
  {$ifdef MSWINDOWS}
  Windows,
  Messages,
  {$endif}
  Consts,
  Graphics,
  Controls,
  Forms,
  Menus,
  CommCtrl,
  ExtCtrls,
{$IFDEF VCL_4_USED}
  ImgList,
{$ENDIF}
{$IFDEF VCL_6_USED}
  Types,
{$ENDIF}
{$IFDEF USE_SOUND_MAP}
  ElSndMap,
{$ENDIF}
{$IFDEF ELPACK_USE_IMAGEFORM}
  ElImgFrm,
{$ENDIF}
{$IFDEF ELPACK_USE_STYLEMANAGER}
  ElStyleMan,
{$ENDIF}
  ElList,
  ElVCLUtils,
  ElUxTheme,
  ElTmSchema,
  ElXPThemedControl,
  ElPgCtlConsts,
  //dbugintf,
  ElStrUtils

  {$IfDef ElPackNeedEverest}
  ,
  l3Base,
  afwCustomCommonControl
  {$EndIf ElPackNeedEverest}
  {$IfDef Nemesis}
  ,
  vcmInterfaces,
  vcmExternalInterfaces
  {$EndIf Nemesis}
  ;

const
  PM_REFRESHACTIVEPAGE = WM_USER + 7434;

{$Include ElPgCtlInterfaces.inc}

type

  TElTabStyle = (etsTabs, etsButtons, etsFlatButtons, etsNetTabs, etsFlatTabs, etsAngledTabs);
  TElTabPosition = (etpTop, etpBottom, etpRight, etpLeft);
  TElTabDrawState = (edsBackground, edsEdges, edsContents);
  TElPageScrollBtnState = (pbsNone, pbsLeftBtnOver, pbsLeftBtnDown,
    pbsLeftBtnHeld, pbsRightBtnOver, pbsRightBtnDown, pbsRightBtnHeld);
  TElCloseBtnMode = (cbmNone, cbmActive, cbmAll);

  TElCustomPageControl = class;
  TElTabSheet = class;
  TElTab = class;

  TElOnTabSheetClickEvent = procedure(Sender: TObject;
    Page: TElTabSheet) of object;

  TElMeasureTabEvent = procedure(Sender: TObject; Canvas: TCanvas; Page:
    TElTabSheet;
    var Size: TSize) of object;

  TElPaintTabEvent = procedure(Sender: TObject; Canvas: TCanvas; Page:
    TElTabSheet; Rect: TRect; DrawStep: TElTabDrawState; var DefaultDrawing:
    boolean) of object;

  TElTabGetImageEvent = procedure(Sender: TObject; PageIndex: integer;
    var ImageIndex: integer) of object;
  TElTabChangingEvent = procedure(Sender: TObject; NewPage: TElTabSheet;
    var AllowChange: Boolean) of object;

  TElStartDragControl = procedure (Sender: TObject; aDragControl: TControl) of Object;

  TElTabSheet = class(
                      {$IfDef ElPackNeedEverest}
                      TafwCustomCommonControl
                      {$Else  ElPackNeedEverest}
                      TCustomControl
                      {$EndIf ElPackNeedEverest}
                      , IelTabSheet
                      )
  private
  // messages
    procedure PMActivePrevPage(var Message : TMessage);
      message PM_ACTIVEPREVPAGE;
      {* - сделать активной предыдущую активную "М. Морозов" }
    procedure PMIsActiveControl(var Message : TMessage);
      message PM_ISACTIVECONTROL;
      {* - является ли активной "М. Морозов" }
    procedure PMSetActivePageWithControl(var Message : TMessage);
      message PM_SETACTIVEPAGEWITHCONTROL;
      {* - сделать активной "М. Морозов" }
    procedure PMActivateAndShow(var Message : TMessage);
      message PM_ACTIVATEANDSHOW;
      {* - сделать активной и показать "М. Морозов" }
    procedure PMSetFirstActive(var Message: TMessage);
      message PM_SETFIRSTACTIVE;
      {* - сделать активной первую закладку. }
  private
  // IelTabSheet
    procedure WeightChanged;
      {* - вес компонента был изменен, надо переразместить компоненты. }
  private
  // internal methods
    procedure NotifyPageChanged(const aActive : Boolean);
      {* - уведомить компоненты о смене закладки. "М. Морозов"}
  protected
    FOnShow: TNotifyEvent;
    FOnHide: TNotifyEvent;
    FTabColor: TColor;
    FPageControl: TElCustomPageControl;
    FImageIndex: integer;
    FTabVisible: Boolean;
    FCaption: TElFString;
    FTabEnabled: Boolean;
    FTabMenu: TPopupMenu;
{$IFDEF ELPACK_UNICODE}
    FHint: TElFString;
{$ENDIF}
    FUseTabColor: Boolean;
    FUseFontForTabs: Boolean;
    FCloseBtnEnabled: Boolean;
    FTabShowing: Boolean;
    FRect: TRect;
    FComplete: boolean;
    FLine: integer;
    FShown: boolean;
    FShowCloseButton: Boolean;
    FCloseBtnRect: TRect;
    FCloseBtnDown: boolean;
{$IFDEF ELPACK_USE_STYLEMANAGER}
    FStyleMgrLink: TElStyleMgrChangeLink;
    FStyleManager: TElStyleManager;
    FStyleName: string;
{$ENDIF}
    FCreating: Integer;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMShowingChanged(var Message: TMessage); message
      CM_SHOWINGCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message
      CM_ENABLEDCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;

    procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure ELThemeChanged(var Message: TMessage); message EL_THEMECHANGED;
    procedure WMIsThemedControl(var Message: TMessage); message
      WM_ISTHEMEDCONTROL;
    procedure SetTabShowing(Value: Boolean);
    procedure UpdateTabShowing;
    function GetPageIndex: Integer;
    procedure SetPageIndex(Value: Integer);
    function GetBtnTheme: HTheme;
    function GetScrollTheme: HTheme;
    function GetCloseBtnTheme: HTheme;
    function GetTabTheme: HTheme;
    function GetUseXPThemes: Boolean;
    procedure SetShowCloseButton(Value: Boolean);

    procedure TriggerShowEvent; virtual;
    procedure TriggerHideEvent; virtual;
    procedure SetTabColor(Value: TColor);
    procedure SetPageControl(Value: TElCustomPageControl);
    procedure SetImageIndex(Value: integer);
    procedure SetTabVisible(Value: Boolean);
    procedure SetCaption(Value: TElFString);
    function GetTabIndex: Integer;


    procedure SetTabEnabled(Value: Boolean);
    procedure SetTabMenu(Value: TPopupMenu);
    procedure CreateWnd; override;
    procedure ReadState(Reader: TReader); override;
{$IFDEF ELPACK_USE_STYLEMANAGER}
    procedure SetStyleManager(Value: TElStyleManager); virtual;
    procedure SetStyleName(const Value: string); virtual;
    procedure StyleMgrChange(Sender: TObject);
    procedure UpdateStyle;
{$ENDIF}

{$IFDEF ELPACK_UNICODE}
    procedure SetHint(Value: TElFString);
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
{$ENDIF}

{$IFNDEF VCL_4_USED}
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
{$ENDIF}

    procedure SetUseTabColor(Value: Boolean);
    function CloseButtonVisible: Boolean;
    procedure SetUseFontForTabs(Value: Boolean);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetCloseBtnEnabled(Value: Boolean);
    function GetInheritedHint: string;
    procedure BeginCreate;
    procedure EndCreate;

    property TabShowing: Boolean read FTabShowing;
    {$IfDef ElPackNeedEverest}
    procedure Cleanup;
      override;
      {-}
    {$EndIf ElPackNeedEverest}
  public
    constructor Create(AOwner: TComponent); override;
    {$IfNDef ElPackNeedEverest}
    destructor Destroy; override;
    {$EndIf  ElPackNeedEverest}
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    {$ifdef MSWINDOWS}
    function IsThemeApplied: Boolean;
    {$endif}

    property TabIndex: Integer read GetTabIndex;
    property TabTheme: HTheme read GetTabTheme;
    property BtnTheme: HTheme read GetBtnTheme;
    property ScrollTheme: HTheme read GetScrollTheme;
    property CloseBtnTheme: HTheme read GetCloseBtnTheme;
    property UseXPThemes: Boolean read GetUseXPThemes;
  published
    property TabColor: TColor read FTabColor write SetTabColor default
      clBtnFace;

    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;

    property PageControl: TElCustomPageControl read FPageControl write SetPageControl;
    property ImageIndex: integer read FImageIndex write SetImageIndex default
      -1;
    property TabVisible: Boolean read FTabVisible write SetTabVisible default
      true;
    property Caption: TElFString read FCaption write SetCaption;
    property PageIndex: Integer read GetPageIndex write SetPageIndex stored
      False;
    property TabEnabled: Boolean read FTabEnabled write SetTabEnabled default
      true;
    property TabMenu: TPopupMenu read FTabMenu write SetTabMenu;
    property UseTabColor: Boolean read FUseTabColor write SetUseTabColor default
    false;
    property ShowCloseButton: Boolean read FShowCloseButton write
    SetShowCloseButton default false;
{$IFDEF ELPACK_UNICODE}
    property Hint: TElFString read FHint write SetHint;
{$ENDIF}
    property UseFontForTabs: Boolean read FUseFontForTabs write SetUseFontForTabs
    default true;
{$IFDEF ELPACK_USE_STYLEMANAGER}
    property StyleManager: TElStyleManager read FStyleManager write
      SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
{$ENDIF}
    property CloseBtnEnabled: Boolean read FCloseBtnEnabled write
    SetCloseBtnEnabled default true;

    // inherited properties
    property Color default clBtnFace;
    property ParentColor default false;
    property Visible;
{$IFDEF VCL_4_USED}
    property BorderWidth;
    property Constraints;
{$ENDIF}
    property DragMode;
    property Enabled;
    property Font;
    property ParentFont;
    property Left stored false;
    property Top stored false;
{$IFDEF VCL_5_USED}
    property OnContextPopup;
{$ENDIF}
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF VCL_4_USED}
    property OnResize;
{$ENDIF}
    property OnStartDrag;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
  end;

  TElTabClass = class of TElTab;

  TElPageCloseQueryEvent = procedure(Sender: TObject; Page: TElTabSheet;
    var CanClose: Boolean) of object;

  {$IfDef Nemesis}
  IpcHistory = interface(IInterface)
  ['{1C5CE696-EACE-459D-AF75-618708683301}']
  // private methods
    function pm_GetGuidForm : TGUID;
      {-}
    procedure pm_SetGuidForm(const Value : TGUID);
      {-}
    function pm_GetIsActiveEmpty: Boolean;
      {-}
    procedure pm_SetIsActiveEmpty(aValue: Boolean);
      {-}
    function pm_GetEmptyPageName : String;
      {-}
    procedure pm_SetEmptyPageName(const Value : String);
      {-}
  // public methods
    procedure Assign(const aHistory : IpcHistory);
      {-}
    procedure Clear;
      {-}
  // public properties
    property IsActiveEmpty: Boolean
      read  pm_GetIsActiveEmpty
      write pm_SetIsActiveEmpty;
      {* - True если активная закладка пустая }
    property GuidForm : TGUID
      read pm_GetGuidForm
      write pm_SetGuidForm;
      {-}
    property EmptyPageName : String
      read pm_GetEmptyPageName
      write pm_SetEmptyPageName;
      {-}
  end;

  TpcHistory = class(TInterfacedObject, IpcHistory)
  private
  // property methods
    f_IsActiveEmpty : Boolean;
    f_GuidForm      : TGUID;
    f_EmptyPageName : String;
  private
  // property methods
    function pm_GetIsActiveEmpty : Boolean;
      {-}
    procedure pm_SetIsActiveEmpty(aValue : Boolean);
      {-}
    function pm_GetGuidForm : TGUID;
      {-}
    procedure pm_SetGuidForm(const Value : TGUID);
      {-}
    function pm_GetEmptyPageName : String;
      {-}
    procedure pm_SetEmptyPageName(const Value : String);
      {-}
  public
  // public methods
    constructor Create;
      {-}
    procedure Assign(const aHistory : IpcHistory);
      {-}
    procedure Clear;
      {-}
  end;
  {$EndIf Nemesis}

  TStackPointers = class{$IfDef ElPackNeedEverest}(Tl3Base){$EndIf}
    {* - стек указателей. }
  private
  // internal fields
    f_List   : array of Pointer;
    f_Offset : Integer;
  private
  // internal methods
    function GetCount: Integer;
      {-}
    procedure SetCount(const Value : Integer);
      {-}
    procedure InitList;
      {-}
    procedure Move(aUp : Boolean);
      {-}
  protected
    {$IfDef ElPackNeedEverest}
    procedure Cleanup;
      override;
      {-}
    {$EndIf ElPackNeedEverest}
  public
  // public methods
    {$IfDef ElPackNeedEverest}
    constructor Create(anObject : TObject = nil);
      override;
      {-}
    {$Else}
    constructor Create;
      {-}
    {$EndIf  ElPackNeedEverest}
   {$IfNDef ElPackNeedEverest}
   destructor Destroy;
     override;
     {-}
   {$EndIf  ElPackNeedEverest}
   procedure Pop(const aValue : Pointer);
     {-}
   function Push : Pointer;
     {-}
  public
  // public methods
   property Count : Integer
     read GetCount
     write SetCount;
     {-}
  end;

  TElOnDblClickUnDock = procedure(var CanUnDock : Boolean;
                                  aControl      : TControl) of Object;
    {* - DblClick на закладке приводит к отстыковке формы. }

  TElCustomPageControl = class(TElXPThemedControl
                               {$IFDEF Nemesis}
                               ,IvcmState
                               {$ENDIF})
  private
  // internal fields
    {$ifdef Nemesis}
    FHistory: IpcHistory;
      {* - при стыковке новой закладке загружаем историю потому, что история
           приходит раньше чем пристыковываются формы. }
    {$endif Nemesis}
    FActivesStack: TStackPointers;
      {* - стек активных закладок // "М. Морозов" }
    FOnTabSheetClick: TElOnTabSheetClickEvent;
      {* - вызывается при щелчке на закладке. }
    FOnDblClickUndock: TElOnDblClickUnDock;
      {* - вызывается при отстыковке закладки по DblClick. }
    FFocusOnTabIfNotControls: Boolean;
      {-}
    FActiveTabAfterDelete: Integer;
      {* - если индекс определен (не равен -1), то закладка с этим индексом
           будет всегда новой активной при удалении закладок из PageControl-а. }
  private
  // internal methods
    function GetNextTabFromStack(aRemoveTab : TElTabSheet) : TElTabSheet;
      {-}
    procedure DoTabSheetClick(aTabSheet : TElTabSheet);
      {-}
    {$IfDef Nemesis}
    procedure ArrangePagesByWeight;
      {* - расположить закладки по весовым коэфициентам. }
    {$EndIf Nemesis}
    function TriggerOnDblClickUnDock(aControl : TControl) : Boolean;
      {-}
  protected
  // ptotected methods
    procedure DoStartDragControl(aControl: TControl);
      virtual;
      {-}
    procedure DoEndDragControl;
      virtual;
      {-}
  protected
    FDragPageControl: Boolean;
    FOnStartDragControl: TElStartDragControl;
    FOnEndDragControl: TNotifyEvent;
    FTab: TElTab;
    FRecalcTabPos: Boolean;
    FLines: Integer;
    FScrollLeftRect,
    FScrollRightRect: TRect;
    FTabsPos: TPoint;
    FTabsSize: TSize;
    FMemDC: HDC;
    FScrollBtnState: TElPageScrollBtnState;
    {$ifdef MSWINDOWS}
    FSaveCapture: HWND;
    {$endif}
    FScrollTimer: TTimer;
    FTabIndex: integer;
    FBtnTheme: HTheme;
    FScrollTheme: HTheme;
    FCloseBtnTheme: HTheme;
    FHintCoords: TPoint;
    FHintTimer: TTimer;
    FHintWnd: THintWindow;
    FNoDTAlert: Boolean;
    FDragTab: TElTabSheet;
    FDoStartDrag: integer;
    FDragPos : TPoint;
    FDraggablePages: boolean;
{$IFDEF USE_SOUND_MAP}
    FActivateSound: TElSoundName;
{$ENDIF}
    FActivePage: TElTabSheet;
    FActiveTabColor: TColor;
    //FBackground: TBitmap;
    //FBackgroundType: TElBkGndType;
    FDownTab: TElTabSheet;
    FDrawFocus: Boolean;
    FDummyCaption: string;
    FFirstTab: TElTabSheet;
    FNoSetFirstTab: boolean;
    FFlat: Boolean;
    FGradientEndColor: TColor;
    FGradientStartColor: TColor;
    FGradientSteps: Integer;
    FHotTrack: Boolean;
    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FAImageChangeLink: TChangeLink;
    FAlphaImages: TImageList;
{$IFDEF ELPACK_USE_IMAGEFORM}
    FImgForm: TElImageForm;
    FImgFormChLink: TImgFormChangeLink;
{$ENDIF}
    FInactiveTabColor: TColor;
    FMinTabHeight: Integer;
    FMinTabWidth: Integer;
    FMultiLine: Boolean;
    FNewDockSheet: TElTabSheet;
    FOnChange: TNotifyEvent;
    FOnGetImageIndex: TElTabGetImageEvent;
    FOnMeasureTab: TElMeasureTabEvent;
    FOnChanging: TElTabChangingEvent;
    FPages: TElList;
    FRaggedRight: Boolean;
    FScrollOpposite: Boolean;
    FShowBorder: Boolean;
    FShowImages: Boolean;
    FShowTabs: Boolean;
{$IFDEF USE_SOUND_MAP}
    FSoundMap: TElSoundMap;
{$ENDIF}
    FStyle: TElTabStyle;
    FTabHeight: DWORD;
    FTabPosition: TElTabPosition;
    FTabWidth: DWORD;
    //FTmpBmp: TBitmap;
    FTrackTab: TElTabSheet;
    FUndockingPage: TElTabSheet;
    FTabBkColor: TColor;
{$IFNDEF VCL_4_USED}
    FOnResize: TNotifyEvent;
{$ENDIF}
    FOnClosePageQuery: TElPageCloseQueryEvent;
    FHotTrackFont: TFont;
    FShowTabHints: Boolean;
    FSavvyMode: Boolean;
    FFlatTabBorderColor: TColor;
    FTabBkColorNetStyle: TColor;
    FVerticalSideCaptions: Boolean;
    FActiveTabFont: TFont;
    FUseActiveTabFont: Boolean;
    FTabCursor: TCursor;
{$IFDEF ELPACK_UNICODE}
    FHint: TElFString;
{$ENDIF}
    FOnDrawTab: TElPaintTabEvent;
    FDefaultPage: TElTabSheet;
    FCloseBtnMode: TElCloseBtnMode;
    FCenterTabCaptions: Boolean;
    FUpdateCount: Integer;
    FUpdated: Integer;
    FTabClass: TElTabClass;
    FCreating : Integer;
{$IFDEF VCL_4_USED}
    procedure Resize; override;
{$ELSE}
    procedure Resize; virtual;
{$ENDIF}
    {$ifdef MSWINDOWS}
    function GetThemedClassName: WideString; override;
    procedure FreeThemeHandle; override;
    procedure CreateThemeHandle; override;
    {$endif}
    function CanChange(NewPage: TElTabSheet): Boolean; virtual;
    function CanScrollLeft: Boolean;
    procedure Change; virtual;
    procedure ChangeActivePage(Page: TElTabSheet);
    procedure DoDrawTabs(ACanvas: TCanvas; Rect: TRect; DoDraw: boolean; var Size:
        TSize);
    function GetBtnTheme: HTheme;
    function GetScrollTheme: HTheme;
    function GetTabTheme: HTheme;
    function MeasureSheet(ACanvas: TCanvas; Sheet: TElTabSheet): TSize;

    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
      WM_WINDOWPOSCHANGED;
    procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;

    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMLButtonDown(var Message: TWMLBUTTONDOWN); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLBUTTONUP); message WM_LBUTTONUP;
    procedure WMRButtonUp(var Message: TWMRBUTTONUP); message WM_RBUTTONUP;
    procedure WMMouseMove(var Message: TMessage); message WM_MOUSEMOVE;
    procedure ELThemeChanged(var Message: TMessage); message EL_THEMECHANGED;
    procedure WMIsThemedControl(var Message: TMessage); message
      WM_ISTHEMEDCONTROL;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure CMShowingChanged(var Message: TMessage); message
      CM_SHOWINGCHANGED;
    procedure CMControlListChange(var Message: TMessage); message
      CM_CONTROLLISTCHANGE;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message
      CM_DESIGNHITTEST;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
{$IFDEF VCL_4_USED}
    procedure CMDockClient(var Message: TCMDockClient); message CM_DOCKCLIENT;
    procedure CMDockNotification(var Message: TCMDockNotification); message
      CM_DOCKNOTIFICATION;
{$ENDIF}
    procedure CMFocusChanged(var Message: TMessage); message CM_FOCUSCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message
      CM_SYSCOLORCHANGE;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
{$IFDEF VCL_4_USED}
    procedure CMUnDockClient(var Message: TCMUnDockClient); message
      CM_UNDOCKCLIENT;
{$ENDIF}
{$IFDEF VCL_4_USED}
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message
      WM_LBUTTONDBLCLK;
{$ENDIF}
    procedure SelectFirstTab;
    procedure CreateHandle; override;
    procedure CreateParams(var Params: TCreateParams); override;
{$IFDEF VCL_4_USED}
    procedure DockOver(Source: TDragDockObject; X, Y: Integer; State:
      TDragState;
      var Accept: Boolean); override;
    procedure DoAddDockClient(Client: TControl; const ARect: TRect); override;
    procedure DoRemoveDockClient(Client: TControl); override;
{$ENDIF}
    function GetActivePageIndex: Integer;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
{$IFDEF VCL_4_USED}
    function GetDockClientFromMousePos(MousePos: TPoint): TControl;
{$ENDIF}
    function GetPageCount: Integer;
{$IFDEF VCL_4_USED}
    function GetPageFromDockClient(Client: TControl): TElTabSheet;
{$ENDIF}
    function GetPages(index: integer): TelTabSheet;

{$IFDEF VCL_4_USED}
    procedure GetSiteInfo(Client: TControl; var InfluenceRect: TRect; MousePos:
      TPoint; var CanDock: Boolean); override;
{$ENDIF}

    function GetTabIndex: Integer;
    // procedure ImageChange(Sender : TObject);
    procedure ImageFormChange(Sender: TObject);
    procedure ImageListChange(Sender: TObject);
    procedure InsertPage(TabSheet: TElTabSheet); virtual;
    procedure MakeTabVisible(ATabSheet: TElTabSheet);
    procedure RebuildTabs(ResetFirstItem: boolean);
    // procedure RedoTmpBmp;
    procedure RemovePage(TabSheet: TElTabSheet); virtual;
    procedure SetActivePage(Value: TElTabSheet);
    procedure SetActivePageIndex(const Value: Integer);
    procedure SetActiveTabColor(Value: TColor);
    //procedure SetBackground(newValue: TBitmap);
    //procedure SetBackgroundType(newValue: TElBkGndType);
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure SetDrawFocus(Value: Boolean);
    procedure SetFirstTab(Value: TElTabSheet);
    procedure SetFlat(newValue: Boolean);
    //procedure SetGradientEndColor(newValue : TColor);
    //procedure SetGradientStartColor(newValue : TColor);
    //procedure SetGradientSteps(newValue : integer);
    procedure SetHotTrack(newValue: Boolean);
{$IFDEF ELPACK_USE_IMAGEFORM}
    procedure SetImageForm(newValue: TElImageForm);
{$ENDIF}
    procedure SetImages(const newValue: TCustomImageList);
    procedure SetAlphaImages(newValue: TImageList);
    procedure SetInactiveTabColor(Value: TColor);
    procedure SetMinTabHeight(Value: Integer);
    procedure SetMinTabWidth(Value: Integer);
    procedure SetMultiLine(newValue: Boolean);
    procedure SetRaggedRight(const Value: Boolean);
    procedure SetScrollOpposite(const Value: Boolean);
    procedure SetShowBorder(Value: Boolean);
    procedure SetShowImages(newValue: Boolean);
    procedure SetShowTabs(Value: Boolean);
    procedure SetStyle(newValue: TElTabStyle);
    procedure SetTabHeight(newValue: DWORD);
    function GetMaxTabHeight : Integer;
    procedure SetTabIndex(const Value: integer);
    procedure SetTabPosition(newValue: TElTabPosition);
    procedure SetTabWidth(newValue: DWORD);
    procedure ShowControl(AControl: TControl); override;
    procedure UpdateActivePage; virtual;
    procedure UpdateTab(TabSheet: TElTabSheet);
    function CanScrollRight: Boolean;
    procedure SetHotTrackFont(Value: TFont);
    procedure HotTrackFontChange(Sender: TObject);
    procedure Paint; override;
    procedure SetScrollBtnState(Value: TElPageScrollBtnState);
    procedure SetTrackTab(Value: TElTabSheet);
    procedure OnScrollTimer(Sender: TObject);
    procedure SetTabBkColor(Value: TColor);
    function HasVisibleTabs: Boolean;
    function DoHitTest(X, Y: integer; var Res: integer): boolean;
    procedure UpdateMultilineOrder;
    procedure TriggerGetImageEvent(PageIndex: integer; var ImageIndex: integer);
      virtual;
    procedure TriggerMeasureTabEvent(Canvas: TCanvas; Page: TElTabSheet; var
      Size: TSize); virtual;
{$IFDEF ELPACK_USE_IMAGEFORM}
    procedure IFMRepaintChildren(var Message: TMessage); message
      IFM_REPAINTCHILDREN;
{$ENDIF}
{$IFDEF ELPACK_USE_IMAGEFORM}
    procedure IFMEffectiveSize(var Message: TMessage); message
      IFM_EFFECTIVESIZE;
    procedure IFMCanPaintBkgnd(var Message: TMessage); message
      IFM_CANPAINTBKGND;
{$ENDIF}
    procedure PMRefreshActivePage(var Message: TMessage); message
      PM_REFRESHACTIVEPAGE;
    procedure OnHintTimer(Sender: TObject); virtual;
    procedure SetSavvyMode(Value: Boolean);
    procedure SetFlatTabBorderColor(Value: TColor);
    procedure SetTabBkColorNetStyle(Value: TColor);
    procedure SetVerticalSideCaptions(Value: Boolean);
    procedure SetDraggablePages(Value: boolean);

{$IFDEF ELPACK_UNICODE}
    procedure SetHint(Value: TElFString);

    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
{$ENDIF}
    procedure SetActiveTabFont(Value: TFont);
    procedure SetUseActiveTabFont(Value: Boolean);
    procedure ActiveTabFontChange(Sender: TObject);
    procedure TriggerDrawTabEvent(Canvas: TCanvas; Page: TElTabSheet; Rect:
      TRect; DrawStep:
      TElTabDrawState; var DefaultDrawing: boolean); virtual;
    procedure SetCloseButtonMode(Value: TElCloseBtnMode);
    procedure TriggerClosePageQueryEvent(Sheet: TElTabSheet; var CanClose:
      boolean); virtual;
    procedure ChangeScale(M, D: Integer); override;
    procedure WndProc(var Message: TMessage); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure SetCenterTabCaptions(Value: Boolean);
    procedure ReadDrawFocus(Reader: TReader);
    procedure AdjustClientRect(var Rect: TRect); {$ifndef VCL_4_USED}virtual;{$else}override;{$endif}
    {$ifndef VCL_4_USED}
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    {$endif}
    procedure IntMouseDown(XPos, YPos : integer);
    procedure IntLButtonUp(XPos, YPos : integer);
    procedure IntRButtonUp(XPos, YPos : integer);
    procedure IntMouseMove(XPos, YPos : integer);
    procedure IntKeyDown(var Key : Word);
    procedure Realign;
    procedure RecalcTabPositions;
    function CalcTabAreaSize: TSize; virtual;
    procedure DrawTabs(ACanvas: TCanvas; R: TRect; DoDraw: boolean; var Size:
        TSize);
    function GetRotatedFont(Canvas: TCanvas; RotationAngle: integer): HFont;
    procedure ReorderPages(MaxRows: integer);
    procedure SetTabClass(Value: TElTabClass);
    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure BeginCreate;
    procedure EndCreate;
    procedure RequestTabPosition;
      virtual;
      {* - уведомляет об изменении TabPosition. //М. Морозов. }
    property ScrollBtnState: TElPageScrollBtnState read FScrollBtnState write
    SetScrollBtnState;
    property TabTheme: HTheme read GetTabTheme;
    (*
    property Background: TBitmap read FBackground write SetBackground;
    property BackgroundType: TElBkGndType read FBackgroundType write
        SetBackgroundType default bgtColorFill;
    property GradientEndColor: TColor read FGradientEndColor write
        SetGradientEndColor;
    property GradientStartColor: TColor read FGradientStartColor write
        SetGradientStartColor;
    property GradientSteps: Integer read FGradientSteps write SetGradientSteps default 16;
    *)
  public
  // public methods
  //////////////////////////////////////////////////////////////////////////////
    function GetActiveControl: TControl;
      {* - // "М. Морозов" }
    function IsActiveControl(aControl: TControl): Boolean;
      {* - // "М. Морозов" }
    procedure DoActivePrevPage;
      virtual;
      {* - // "М. Морозов" }
    function GetPageWithControl(aControl : TControl) : TElTabSheet;
      {* - // "М. Морозов" }
    procedure SetActivePageWithControl(aControl : TControl);
      {* - // "М. Морозов" }
    function GetTotalTabsWidth(ACanvas : TCanvas) : Integer;
      {* - возвращает ширину всех закладок, вне зависимости от видимости. "М. Морозов" }
    procedure CheckFirstTab(ACanvas : TCanvas);
      {* - если все закладки помещаются, то устанавливаем FFirstTab = fPages[0]. "М. Морозов" }
    {$IfDef Nemesis}
    procedure LoadHistory;
      {* - устанавливает активную закладку используя историю. }
    procedure SaveHistory(const theHistory : IpcHistory);
      {* - сохраняет активную закладку в истории. }
    function SaveState(out theState : IUnknown; aStateType   : TvcmStateType): Boolean;
      {* - записываем текущее состояние. }
    function LoadState(const aState : IUnknown; aStateType   : TvcmStateType): Boolean;
      {* - получаем значение из истории и кладем текущее состояние. }
    {$EndIf Nemesis}
  //////////////////////////////////////////////////////////////////////////////
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FindNextPage(CurPage: TElTabSheet; GoForward, CheckTabVisible,
      CheckTabEnabled: Boolean): TElTabSheet;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    procedure SelectNextPage(GoForward: Boolean);
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    function TabFromPoint(Point: TPoint): TElTabSheet;
    procedure UpdateTabs(Immediate: boolean);
    function NewPage: TElTabSheet;
    procedure Loaded; override;
    procedure BeginUpdate;
    procedure EndUpdate;
    property ActivePageIndex: Integer read GetActivePageIndex write SetActivePageIndex;
    property FirstTab: TElTabSheet read FFirstTab write SetFirstTab;
    property PageCount: Integer read GetPageCount;
    property Pages[index: integer]: TElTabSheet read GetPages;
    property TrackTab: TElTabSheet read FTrackTab write SetTrackTab;
    property BtnTheme: HTheme read FBtnTheme;
    property ScrollTheme: HTheme read FScrollTheme;
    property CloseBtnTheme: HTheme read FCloseBtnTheme;
    property TabBkColorNetStyle: TColor read FTabBkColorNetStyle write
      SetTabBkColorNetStyle nodefault;
    property TabClass: TElTabClass read FTabClass write SetTabClass;
  //////////////////////////////////////////////////////////////////////////////
    property OnDblClickUndock : TElOnDblClickUnDock
      read FOnDblClickUndock
      write FOnDblClickUndock;
      {* - событие возникает при отстыковки закладки по DblClick-у. }
    property MaxTabHeight : Integer
      read GetMaxTabHeight;
      {* - текущий максимальный размер закладки (М. Морозов) }
    property FocusOnTabIfNotControls : Boolean
      read FFocusOnTabIfNotControls
      write FFocusOnTabIfNotControls;
      {* - когда закладка становиться активной, то отдавать фокус tab-у если у
           него нет компонентов. }
    property OnStartDragControl: TElStartDragControl
      read FOnStartDragControl write
      FOnStartDragControl;
      {-}
    property OnEndDragControl: TNotifyEvent
      read FOnEndDragControl
      write FOnEndDragControl;
      {-}
    property OnTabSheetClick : TElOnTabSheetClickEvent
      read FOnTabSheetClick
      write FOnTabSheetClick;
      {-}
    property ActiveTabAfterDelete: Integer
      read FActiveTabAfterDelete
      write FActiveTabAfterDelete
      default -1;
  //////////////////////////////////////////////////////////////////////////////
{$IFDEF USE_SOUND_MAP}
    property ActivateSound: TElSoundName read FActivateSound write
      FActivateSound;
{$ENDIF}
    property ActiveTabColor: TColor read FActiveTabColor write SetActiveTabColor
    default clBtnFace;
    property Color default clBtnFace;
    property DrawFocusRect: Boolean read FDrawFocus write SetDrawFocus default
      false;
    property Flat: Boolean read FFlat write SetFlat default false;
    property HotTrack: Boolean read FHotTrack write SetHotTrack default true;
{$IFDEF ELPACK_USE_IMAGEFORM}
    property ImageForm: TElImageForm read FImgForm write SetImageForm;
{$ENDIF}
    property Images: TCustomImageList read FImages write SetImages;
    property AlphaForImages: TImageList read FAlphaImages write SetAlphaImages;
    property InactiveTabColor: TColor read FInactiveTabColor write
    SetInactiveTabColor default clBtnFace;
    property MinTabHeight: Integer read FMinTabHeight write SetMinTabHeight
      default
    40;
    property MinTabWidth: Integer read FMinTabWidth write SetMinTabWidth default
      40;
    property Multiline: Boolean read FMultiLine write SetMultiLine default
      false;
    property OnChanging: TElTabChangingEvent read FOnChanging write FOnChanging;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnGetImageIndex: TElTabGetImageEvent read FOnGetImageIndex write
    FOnGetImageIndex;
    property OnMeasureTab: TElMeasureTabEvent read FOnMeasureTab write
    FOnMeasureTab;
    property RaggedRight: Boolean read FRaggedRight write SetRaggedRight default
      false;
    property ScrollOpposite: Boolean read FScrollOpposite write SetScrollOpposite
      default false;
    property ShowBorder: Boolean read FShowBorder write SetShowBorder default
      true;
    property ShowImages: Boolean read FShowImages write SetShowImages default
      true;
    property ShowTabs: Boolean read FShowTabs write SetShowTabs default true;
{$IFDEF USE_SOUND_MAP}
    property SoundMap: TElSoundMap read FSoundMap write FSoundMap;
{$ENDIF}
    property Style: TElTabStyle read FStyle write SetStyle default etsTabs;
    property TabHeight: DWORD read FTabHeight write SetTabHeight default 0;
    property TabIndex: Integer read GetTabIndex write SetTabIndex default -1;
    property TabPosition: TElTabPosition read FTabPosition write SetTabPosition
      default etpTop;
    property TabWidth: DWORD read FTabWidth write SetTabWidth default 0;
    property HotTrackFont: TFont read FHotTrackFont write SetHotTrackFont;
    property TabBkColor: TColor read FTabBkColor write SetTabBkColor default
    clBtnFace;
    property ActivePage: TElTabSheet read FActivePage write SetActivePage;
    property ShowTabHints: Boolean read FShowTabHints write FShowTabHints default
    true;
    property SavvyMode: Boolean read FSavvyMode write SetSavvyMode default
      false;
    property FlatTabBorderColor: TColor read FFlatTabBorderColor write
      SetFlatTabBorderColor default clBtnShadow;
    property VerticalSideCaptions: Boolean read FVerticalSideCaptions write
    SetVerticalSideCaptions default true;
    property DraggablePages: boolean read FDraggablePages write SetDraggablePages
      default false;
    property ActiveTabFont: TFont read FActiveTabFont write SetActiveTabFont;
    property UseActiveTabFont: Boolean read FUseActiveTabFont write
    SetUseActiveTabFont default false;
    property TabCursor: TCursor read FTabCursor write FTabCursor default
      crDefault;
    property OnDrawTab: TElPaintTabEvent read FOnDrawTab write FOnDrawTab;
    property DefaultPage: TElTabSheet read FDefaultPage write FDefaultPage;
    property CloseButtonMode: TElCloseBtnMode read FCloseBtnMode write
      SetCloseButtonMode default cbmNone;
    property CenterTabCaptions: Boolean read FCenterTabCaptions write
    SetCenterTabCaptions default false;

{$IFDEF ELPACK_UNICODE}
    property Hint: TElFString read FHint write SetHint;
{$ENDIF}
{$IFNDEF VCL_4_USED}
    property OnResize: TNotifyEvent read FOnResize write FOnResize;
{$ELSE}
    property OnResize;
{$ENDIF}
    property OnClosePageQuery: TElPageCloseQueryEvent read FOnClosePageQuery
      write FOnClosePageQuery;

{$IFDEF VCL_5_USED}
    property OnContextPopup;
{$ENDIF}

{$IFDEF VCL_4_USED}
    property Anchors;
    property Constraints;
    property DockSite;
    property DockOrientation;
    property DragKind;

    property OnStartDock;
    property OnUnDock;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
{$ENDIF}
    property DragPageControl: Boolean read FDragPageControl
     write FDragPageControl default False;
  end;

  TElPageControl = class(TElCustomPageControl)
  published
  // properties
    property OnStartDragControl;
    property OnEndDragControl;
    property OnTabSheetClick;
    property ActiveTabAfterDelete;
{$IFDEF USE_SOUND_MAP}
    property ActivateSound;
{$ENDIF}
    property ActiveTabColor;
    property Color;
    property DrawFocusRect;
    property Flat;
    property HotTrack;
{$IFDEF ELPACK_USE_IMAGEFORM}
    property ImageForm;
{$ENDIF}
    property Images;
    property AlphaForImages;
    property InactiveTabColor;
    property MinTabHeight;
    property MinTabWidth;
    property Multiline;
    property OnChanging;
    property OnChange;
    property OnGetImageIndex;
    property OnMeasureTab;
    property RaggedRight;
    property ScrollOpposite;
    property ShowBorder;
    property ShowImages;
    property ShowTabs;
{$IFDEF USE_SOUND_MAP}
    property SoundMap;
{$ENDIF}
    property Style;
    property TabHeight;
    property TabIndex;
    property TabPosition;
    property TabWidth;
    property HotTrackFont;
    property TabBkColor;
    property ActivePage;
    property ShowTabHints;
    property SavvyMode;
    property FlatTabBorderColor;
    property VerticalSideCaptions;
    property DraggablePages;
    property ActiveTabFont;
    property UseActiveTabFont;
    property TabCursor;
    property OnDrawTab;
    property DefaultPage;
    property CloseButtonMode;
    property CenterTabCaptions;

{$IFDEF ELPACK_UNICODE}
    property Hint;
{$ENDIF}
    property OnResize;
    property OnClosePageQuery;
    property Align;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property TabOrder;
    property TabStop;
    property ShowHint;
    property Visible;
    property UseXPThemes;

    property OnDblClick;
    property OnStartDrag;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnEnter;
    property OnExit;
{$IFDEF VCL_5_USED}
    property OnContextPopup;
{$ENDIF}

{$IFDEF VCL_4_USED}
    property Anchors;
    property Constraints;
    property DockSite;
    property DockOrientation;
    property DragKind;

    property OnStartDock;
    property OnUnDock;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
{$ENDIF}
    property DragPageControl;
  end;

  TElTab = class(TObject)
  private
    FOwner: TElCustomPageControl;
    procedure Draw(ACanvas: TCanvas; R: TRect; TabSheet: TElTabSheet);
    function GetBtnTheme: HTheme;
    function GetScrollTheme: HTheme;
    function GetTabTheme: HTheme;
    function GetCloseBtnTheme: HTheme;
    function GetTabPosition: TElTabPosition;
  protected
    function GetOuterMargin: Integer; virtual;
    function GetInnerMargin: Integer; virtual;
    procedure DrawTabContents(Canvas: TCanvas; R: TRect; TabSheet: TElTabSheet);
      virtual;
    procedure DrawSpace(Canvas: TCanvas; var cx, cy: integer; mx, my: integer);
      virtual;
    function CanDrawTab(ActiveDraw: boolean): Boolean; virtual;
    function GetAscend: Integer; virtual;
    procedure AdjustDrawingSize(Active: boolean; var R: TRect); virtual;
    procedure AdjustTabSize(var Size: TSize); virtual;
    procedure AdjustFillSize(After: boolean; var R: TRect; TabSheet:
      TElTabSheet); virtual;
    procedure DrawTabLine(Canvas: TCanvas; R: TRect); virtual;
    procedure FillSpace(Canvas: TCanvas; Rect: TRect); virtual;
    procedure FillTab(Canvas: TCanvas; Rect: TRect; TabSheet: TElTabSheet);
      virtual;
    procedure DrawButtons(Canvas: TCanvas; LeftRect, RightRect: TRect; CSL, CSR:
      boolean); virtual;
    function GetRowMargin: Integer; virtual;

    function IsThemeApplied: Boolean;
    procedure DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
      TElTabSheet);
      virtual; abstract;
    procedure DrawCloseButton(Canvas: TCanvas; var R: TRect; TabSheet:
      TElTabSheet);
      virtual;
    function GetContentMargin: Integer; virtual;
    procedure FixupTab(Canvas: TCanvas; R: TRect; TabSheet: TElTabSheet);
      virtual;
    procedure AdjustFocusRect(var R: TRect); virtual;
    property TabTheme: HTheme read GetTabTheme;
    property BtnTheme: HTheme read GetBtnTheme;
    property ScrollTheme: HTheme read GetScrollTheme;
    property CloseBtnTheme: HTheme read GetCloseBtnTheme;
    property TabPosition: TElTabPosition read GetTabPosition;
  public
    constructor Create(Owner: TElCustomPageControl);
  end;

  TElStdTab = class(TElTab)
  private
  protected
    function GetOuterMargin: Integer; override;
    function CanDrawTab(ActiveDraw: boolean): Boolean; override;
    function GetAscend: Integer; override;
    procedure AdjustDrawingSize(Active: boolean; var R: TRect); override;
    procedure AdjustTabSize(var Size: TSize); override;
    procedure DrawTabLine(Canvas: TCanvas; R: TRect); override;
    procedure AdjustFillSize(After: boolean; var R: TRect; TabSheet:
      TElTabSheet); override;
    procedure FillTab(Canvas: TCanvas; Rect: TRect; TabSheet: TElTabSheet);
      override;
    procedure DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
      TElTabSheet);
      override;
  public
  end;

  TElBtnTab = class(TElTab)
  private
  protected
    function GetInnerMargin: Integer; override;
    procedure DrawSpace(Canvas: TCanvas; var cx, cy: integer; mx, my: integer);
      override;
    procedure AdjustTabSize(var Size: TSize); override;
    function GetRowMargin: Integer; override;
    procedure FillTab(Canvas: TCanvas; Rect: TRect; TabSheet: TElTabSheet);
      override;
    procedure DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
      TElTabSheet);
      override;
  end;

  TElFlatBtnTab = class(TElTab)
  private
  protected
    function GetInnerMargin: Integer; override;
    procedure DrawSpace(Canvas: TCanvas; var cx, cy: integer; mx, my: integer);
      override;
    procedure AdjustTabSize(var Size: TSize); override;
    procedure AdjustFillSize(After: boolean; var R: TRect; TabSheet:
      TElTabSheet); override;
    function GetRowMargin: Integer; override;
    procedure FillTab(Canvas: TCanvas; Rect: TRect; TabSheet: TElTabSheet);
      override;
    procedure DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
      TElTabSheet);
      override;
  end;

  TElNetTab = class(TElTab)
  private
  protected
    procedure AdjustTabSize(var Size: TSize); override;
    function GetInnerMargin: Integer; override;
    procedure DrawSpace(Canvas: TCanvas; var cx, cy: integer; mx, my: integer);
      override;
    function CanDrawTab(ActiveDraw: boolean): Boolean; override;
    procedure AdjustDrawingSize(Active: boolean; var R: TRect); override;
    function GetOuterMargin: Integer; override;
    procedure DrawTabLine(Canvas: TCanvas; R: TRect); override;
    function GetAscend: Integer; override;
    procedure FillSpace(Canvas: TCanvas; Rect: TRect); override;
    procedure AdjustFillSize(After: boolean; var R: TRect; TabSheet:
      TElTabSheet); override;
    procedure FillTab(Canvas: TCanvas; Rect: TRect; TabSheet: TElTabSheet);
      override;
    procedure DrawButtons(Canvas: TCanvas; LeftRect, RightRect: TRect; CSL, CSR:
      boolean); override;
    procedure DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
      TElTabSheet);
      override;
  end;

  TEl2DFlatTab = class(TElTab)
  private
  protected
    procedure AdjustDrawingSize(Active: boolean; var R: TRect); override;
    procedure AdjustFillSize(After: boolean; var R: TRect; TabSheet:
      TElTabSheet); override;
    procedure AdjustTabSize(var Size: TSize); override;
    function CanDrawTab(ActiveDraw: boolean): Boolean; override;
    procedure DrawTabLine(Canvas: TCanvas; R: TRect); override;
    function GetAscend: Integer; override;
    function GetInnerMargin: Integer; override;
    function GetOuterMargin: Integer; override;
    procedure FillTab(Canvas: TCanvas; Rect: TRect; TabSheet: TElTabSheet);
      override;
    procedure DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
      TElTabSheet);
      override;
  end;

  TElAngledTab = class(TElTab)
  private
    SaveDCState: Integer;
  protected
    function CanDrawTab(ActiveDraw: boolean): Boolean; override;
    procedure DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
      TElTabSheet);
      override;
    procedure DrawTabLine(Canvas: TCanvas; R: TRect); override;
    procedure AdjustFillSize(After: boolean; var R: TRect; TabSheet:
      TElTabSheet); override;
    procedure AdjustDrawingSize(Active: boolean; var R: TRect); override;
    procedure AdjustTabSize(var Size: TSize); override;
    procedure FillTab(Canvas: TCanvas; Rect: TRect; TabSheet: TElTabSheet);
      override;
    function GetAscend: Integer; override;
    function GetInnerMargin: Integer; override;
    function GetOuterMargin: Integer; override;
    function GetContentMargin: Integer; override;
    procedure CreateTabPoints(R: TRect; Points: PPoint);
    procedure FixupTab(Canvas: TCanvas; R: TRect; TabSheet: TElTabSheet);
      override;
    procedure AdjustFocusRect(var R: TRect); override;
  end;

implementation

uses
  ElTools,
  ElExtBkgnd

  {$IfDef ElPackNeedEverest}
  ,
  l3Interfaces,
  l3String
  {$EndIf ElPackNeedEverest}

  {$IfDef Nemesis}
  ,
  vtUtils
  {$EndIf Nemesis}
  ;

const

  Margin = 4;
  ButtonWidth = 15;
  AngledOffset = 9;

// var TotalRepaints : integer;


{$ifdef MSWINDOWS}
procedure IntMapWindowPoints(SrcWnd, DstWnd: HWND; var Rect: TRect; Transform:
  integer);
begin
  ScreenToClient(DstWnd, Rect.TopLeft);
  ScreenToClient(DstWnd, Rect.BottomRight);
end;
{$endif}

procedure TElTabSheet.TriggerShowEvent;
begin
  if Assigned(FOnShow) then FOnShow(Self);
end;

procedure TElTabSheet.TriggerHideEvent;
begin
  if Assigned(FOnHide) then FOnHide(Self);
end;



procedure TElTabSheet.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  if Showing then
    TriggerShowEvent
  else
    if not Showing then
    TriggerHideEvent;
  (*
  if TabVisible and (FPageControl <> nil) then
    FPageControl.RebuildTabs(false);
  *)
end;

constructor TElTabSheet.Create(AOwner: TComponent);
begin
  BeginCreate;

  inherited;
  Color := clBtnFace;
  TabColor := clBtnFace;
  Align := alClient;
  ControlStyle := ControlStyle + [csAcceptsControls];
  ControlStyle := ControlStyle - [csNoDesignVisible];
  Visible := false;
  FTabVisible := true;
  FTabEnabled := true;
  FImageIndex := -1;
  FShowCloseButton := false;
  FCloseBtnDown := false;
  CloseBtnEnabled := true;
  FUseFontForTabs := true;
{$IFDEF ELPACK_USE_STYLEMANAGER}
  FStyleMgrLink := TElStyleMgrChangeLink.Create;
  FStyleMgrLink.OnChange := StyleMgrChange;
{$ENDIF}

  EndCreate;
end;

procedure TElTabSheet.SetTabColor(Value: TColor);
begin
  if FTabColor <> Value then
  begin
    FTabColor := Value;
    if Parent <> nil then
      TElCustomPageControl(Parent).UpdateTab(Self);
  end;
end;

procedure TElTabSheet.SetPageControl(Value: TElCustomPageControl);
begin
  if FPageControl <> Value then
  begin
    if FPageControl <> nil then
      FPageControl.RemovePage(Self);
    FPageControl := Value;
    Parent := FPageControl;
    if FPageControl <> nil then
    begin
      FPageControl.InsertPage(Self);
      if TabVisible and (FPageControl <> nil) then
        FPageControl.UpdateTab(Self);

      if FPageControl.ActivePage = nil then
        FPageControl.ActivePage := Self;
    end;
    {$IFDEF MSWINDOWS}
    if ThemesAvailable and HandleAllocated then
      SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or
        SWP_NOZORDER or SWP_FRAMECHANGED);
    {$ENDIF}
  end;
end;

procedure TElTabSheet.SetImageIndex(Value: integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    if TabVisible and (FPageControl <> nil) then
      FPageControl.UpdateTab(Self);
  end;
end;

procedure TElTabSheet.SetTabVisible(Value: Boolean);
begin
  if FTabVisible <> Value then
  begin
    FTabVisible := Value;
    UpdateTabShowing;
  end;
end;

procedure TElTabSheet.SetCaption(Value: TElFString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    if TabVisible and (FPageControl <> nil) then
      FPageControl.RebuildTabs(false);
  end;
end;

procedure TElTabSheet.SetTabShowing(Value: Boolean);
begin
  if FTabShowing <> Value then
  begin
    FTabShowing := Value;
    FPageControl.RebuildTabs(true);
  end;
end;

procedure TElTabSheet.UpdateTabShowing;
begin
  SetTabShowing((FPageControl <> nil) and FTabVisible);
end;

function TElTabSheet.GetPageIndex: Integer;
begin
  if FPageControl <> nil then
    Result := FPageControl.FPages.IndexOf(Self)
  else
    Result := -1;
end;

procedure TElTabSheet.SetPageIndex(Value: Integer);
var
  i, MaxPageIndex: Integer;
begin
  if FPageControl <> nil then
  begin
    MaxPageIndex := FPageControl.FPages.Count - 1;
    if Value > MaxPageIndex then
      raise
        EListError.CreateFmt('%d is an invalid PageIndex value.  PageIndex must be ' +
        'between 0 and %d', [Value, MaxPageIndex]);
    i := TabIndex;
    FPageControl.FPages.Move(PageIndex, Value);
    if i >= 0 then
      FPageControl.RebuildTabs(false);
  end;
end;

procedure TElTabSheet.CMFontChanged(var Message: TMessage);
begin
  if TabVisible and (FPageControl <> nil) then
    FPageControl.RebuildTabs(false);
  inherited;
  //Invalidate;
end;

procedure TElTabSheet.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if TabVisible and (FPageControl <> nil) then
    FPageControl.RebuildTabs(false);
  Invalidate;
end;

{$IfDef ElPackNeedEverest}
procedure TElTabSheet.Cleanup;
{$Else  ElPackNeedEverest}
destructor TElTabSheet.Destroy;
{$EndIf ElPackNeedEverest}
begin
  if FPageControl <> nil then
  begin
    FPageControl.RemovePage(Self);
  end;
{$IFDEF ELPACK_USE_STYLEMANAGER}
  StyleManager := nil;
  FreeAndNil(FStyleMgrLink);
{$ENDIF}
  inherited;
end;

function TElTabSheet.GetTabIndex: Integer;
var
  i: integer;
begin
  result := 0;
  if not FTabShowing then
    result := -1
  else
    for i := 0 to PageIndex - 1 do
      if TElTabSheet(FPageControl.FPages[I]).FTabShowing then
        Inc(result);
end;

procedure TElTabSheet.Notification(AComponent: TComponent; Operation:
  TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent = PageControl) then
      PageControl := nil;
    if AComponent = FTabMenu then
      TabMenu := nil;
{$IFDEF ELPACK_USE_STYLEMANAGER}
    if (AComponent = FStyleManager) then
      StyleManager := nil;
{$ENDIF}
  end;
end;

procedure TElTabSheet.SetShowCloseButton(Value: Boolean);
begin
  if Value <> ShowCloseButton then
  begin
    FCloseBtnDown := false;
    FShowCloseButton := Value;
    if HandleAllocated and (FPageControl <> nil) and
      (FPageControl.CloseButtonMode <> cbmNone) then
      FPageControl.UpdateTabs(true);
  end;
end;

procedure TElTabSheet.NotifyPageChanged(const aActive : Boolean);
  {* - уведомить компоненты о смене закладки. "М. Морозов"}

{$IfDef Nemesis}
  procedure NotifyComponent(const aComponent : TComponent);
  var
   l_Notify : IvcmTabSheetControl;
  begin
   // компонент поддерживает интерфейс IelTabSheetControl
   if Supports(aComponent, IvcmTabSheetControl, l_Notify) then
   try
    case aActive of
     True:
      l_Notify.PageActive;
     False:
      l_Notify.PageInactive;
    end;
   finally
    l_Notify := nil;
   end;{try..finally}
  end;//NotifyComponent

  procedure NotifyComponents(const aParent : TComponent);
  var
   l_Index : Integer;
  begin
   for l_Index := 0 to Pred(aParent.ComponentCount) do
   begin
    NotifyComponent(aParent.Components[l_Index]);
    // уведомление компонентов текущего
    NotifyComponents(aParent.Components[l_Index]);
   end;//for l_Index := 0 to Pred(aParent.ComponentCount) do
  end;//NotifyComponents

var
 l_Index : Integer;
{$EndIf Nemesis}
begin
 {$IfDef Nemesis}
 for l_Index := 0 to Pred(ControlCount) do
 begin
  // уведомим компонент на закладке
  NotifyComponent(Controls[l_Index]);
  // уведомим все вложенные компоненты
  NotifyComponents(Controls[l_Index]);
 end;//for l_Index := 0 to Pred(ControlCount) do
 {$EndIf Nemesis}
end;//NotifyPageChanged

procedure TElTabSheet.WeightChanged;
  {* - вес компонента был изменен, надо переразместить компоненты. }
begin
 {$IfDef Nemesis}
  PageControl.ArrangePagesByWeight;
 {$EndIf Nemesis}
end;

procedure TElTabSheet.PMSetFirstActive(var Message: TMessage);
  // message PM_SETFIRSTACTIVE;
  {* - сделать активной первую закладку. }
begin
 if FPageControl.PageCount > 0 then
  FPageControl.ActivePage := FPageControl.Pages[0];
 // Сообщение обработано
 Message.ResultLo := 1;
end;

procedure TElTabSheet.PMActivateAndShow(var Message : TMessage);
 //message PM_ACTIVATEANDSHOW;
begin
 // развернуть навигатор если он был свернут
 SendMessage(FPageControl.Handle, PM_SETACTIVEPAGEWITHCONTROL,
  Integer(Self), 0);
 // активировать закладку
 FPageControl.ActivePage := Self;
 LongRec(Message.Result).Lo := 1;
end;

procedure TElTabSheet.PMSetActivePageWithControl(var Message : TMessage);
 //message PM_SETACTIVEPAGEWITHCONTROL;
begin
 FPageControl.ActivePage := Self;
 LongRec(Message.Result).Lo := 1;
end;

procedure TElTabSheet.PMIsActiveControl(var Message : TMessage);
 //message PM_ISACTIVECONTROL;
var
 lResult : DWORD;
begin
 lResult := SendMessage(FPageControl.Handle,
                        PM_ISACTIVECONTROL,
                        Integer(Self),
                        0);
 { Операция обработана родителем }
 if Boolean(LongRec(lResult).Lo) then
  Message.ResultHi := LongRec(lResult).Hi
 { Определяется активностью закладки }
 else
  Message.ResultHi := Integer(FPageControl.ActivePage = Self);
 Message.ResultLo := 1;
end;

procedure TElTabSheet.PMActivePrevPage(var Message : TMessage);
 //message PM_ACTIVEPREVPAGE;
begin
 FPageControl.DoActivePrevPage;
 LongRec(Message.Result).Lo := 1;
end;

procedure TElTabSheet.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
var
  RW,
    R1,
    R2: TRect;
  s: integer;
  R {,
    Rect}: TRect;
{$IFDEF ELPACK_USE_IMAGEFORM}
  ACtl: TWinControl;
  BgRect: TRect;
{$ENDIF}
  Canvas: TCanvas;
begin
  if IsThemeApplied then
  begin
    GetWindowRect(Handle, RW);
    IntMapWindowPoints(0, Handle, RW, 2);
    //DrawThemeParentBackground(Handle, Msg.DC, RW);
    R2 := RW;
    // hide borders
    if PageControl.ShowBorder then
      s := 1
    else
      s := 2;
    // this conversion has been made intentionally to hide borders that might be not drawn
    RW := ClientRect;
    GetThemeBackgroundContentRect(TabTheme, Msg.DC, TABP_PANE, TIS_NORMAL, RW,
      R1);
    Inc(RW.Left, (RW.Left - R1.Left) * s);
    Inc(RW.Top, (RW.Top - R1.Top) * s);
    Inc(RW.Right, (RW.Right - R1.Right) * s);
    Inc(RW.Bottom, (RW.Bottom - R1.Bottom) * s);

    if PageControl.ShowTabs and (PageControl.Style in [etsTabs, etsNetTabs,
      etsFlatTabs, etsAngledTabs]) then
    begin
      case PageControl.TabPosition of
        etpTop: RW.Top := RW.Top + (R2.Top - R1.Top);
        etpBottom: RW.Bottom := RW.Bottom + (R2.Bottom - R1.Bottom);
        etpRight: RW.Right := RW.Right + (R2.Right - R1.Right);
        etpLeft: RW.Left := RW.Left + (R2.Left - R1.Left);
      end;
    end;
    R := ClientRect;
    DrawThemeBackground(TabTheme, Msg.DC, TABP_PANE, TIS_NORMAL, RW, nil);
  end
  else
  begin
    Canvas := Self.Canvas;
    Canvas.Handle := Msg.DC;

    R := ClientRect;

{$IFDEF ELPACK_USE_IMAGEFORM}
    if (FPageControl <> nil) and (FPageControl.FImgForm <> nil) and (not
      (csDesigning in FPageControl.FImgForm.ComponentState)) then
    begin
      if (FPageControl.FImgForm.Control <> Self) then
      begin
        if (FPageControl.FImgForm.Control <> FPageControl) then
        begin
          ACtl := FPageControl.FImgForm.GetRealControl;
          BgRect := R;
          BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
          BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
        end
        else
        begin
          ACtl := FPageControl.FImgForm.GetRealControl;
          BgRect := R;
          BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
          BgRect.TopLeft := ACtl.Parent.ScreenToClient(BgRect.TopLeft);
          Dec(BgRect.Left, FPageControl.Left);
          Dec(BgRect.Top, FPageControl.Top);
        end;
        FPageControl.FImgForm.PaintBkgnd(Canvas.Handle, R, BgRect.TopLeft,
          false);
      end;
    end
    else
{$ENDIF}
    begin
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := Color;
      Canvas.FillRect(R);
    end;
    Canvas.Handle := 0;
  end;
  Msg.result := 1;
end;

procedure TElTabSheet.SetTabEnabled(Value: Boolean);
begin
  if FTabEnabled <> Value then
  begin
    FTabEnabled := Value;
    if TabShowing then
      FPageControl.UpdateTabs(false);
  end;
end;

procedure TElTabSheet.SetTabMenu(Value: TPopupMenu);
begin
  if FTabMenu <> Value then
  begin
{$IFDEF D_5_UP}
    if FTabMenu <> nil then
      if not (csDestroying in FTabMenu.ComponentState) then
        FTabMenu.RemoveFreeNotification(Self);
{$ENDIF}
    FTabMenu := Value;
    if FTabMenu <> nil then
      FTabMenu.FreeNotification(Self);
  end;
end;

{$IFDEF ELPACK_USE_STYLEMANAGER}

procedure TElTabSheet.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
{$IFDEF VCL_5_USED}
    if (FStyleManager <> nil) and (not (csDestroying in
      FStyleManager.ComponentState)) then
      FStyleManager.RemoveFreeNotification(Self);
{$ENDIF}
    if FStyleManager <> nil then
      FStyleManager.UnregisterChanges(FStyleMgrLink);
    FStyleManager := Value;
    if FStyleManager <> nil then
    begin
      FStyleManager.FreeNotification(Self);
      FStyleManager.RegisterChanges(FStyleMgrLink);
      UpdateStyle;
    end;
  end;
end;

procedure TElTabSheet.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
  begin
    FStyleName := Value;
    UpdateStyle;
  end;
end;

procedure TElTabSheet.StyleMgrChange(Sender: TObject);
begin
  UpdateStyle;
end;

procedure TElTabSheet.UpdateStyle;
begin
  if ComponentState * [csLoading, csReading] <> [] then
    exit;
  if FStyleManager <> nil then
  begin
    if HandleAllocated and Visible then
      SendMessage(Handle, WM_SETREDRAW, 0, 0);
    FStyleManager.ApplyStyle(Self, StyleName);
    if HandleAllocated and Visible then
    begin
      SendMessage(Handle, WM_SETREDRAW, 1, 0);
      Invalidate;
    end;
  end;
end;
{$ENDIF}

(*
function TElCustomPageControl.CanChange(NewPage : TElTabSheet): Boolean;
begin
  result := True;
  if Assigned(FOnChanging) then FOnChanging(Self, NewPage, result);
end;
*)

function TElCustomPageControl.CanScrollLeft: Boolean;
var
  i: integer;
begin
  result := false;
  if Multiline or (FirstTab = nil) then
    exit
  else
    for i := FirstTab.PageIndex - 1 downto 0 do
    begin
      if TElTabSheet(FPages[i]).TabVisible then
      begin
        result := true;
        exit;
      end;
    end;
end;

function TElCustomPageControl.CanChange(NewPage: TElTabSheet): Boolean;
begin
  result := (NewPage = nil) or (NewPage.TabEnabled or (csDesigning in
    ComponentState));
  if Assigned(FOnChanging) then
    FOnChanging(Self, NewPage, result);
end;

{$IfDef Nemesis}

procedure TElCustomPageControl.SaveHistory(const theHistory : IpcHistory);
var
 lForm : IvcmEntityForm; 
begin
 theHistory.Clear;
 if not Assigned(ActivePage) then
  Exit;
 { Закладка с компонентом }
 if (ActivePage.ControlCount > 0) and
  Supports(ActivePage.Controls[0], IvcmEntityForm, lForm) then
 try
  theHistory.GuidForm := lForm.GUID;
 finally
  lForm := nil;
 end
 { Фиктивная закладка }
 else
 begin
  theHistory.IsActiveEmpty := True;
  theHistory.EmptyPageName := ActivePage.Name;
 end;
end;

function TElCustomPageControl.SaveState(out theState: IUnknown;
 aStateType: TvcmStateType): Boolean;
var
 l_History: IpcHistory;
begin
 Result := False;
 if ActivePage <> nil then
 begin
  Case aStateType of
   vcm_stPosition :
   begin
    l_History := TpcHistory.Create;
    SaveHistory(l_History);
    theState := l_History;
    //ActivePage := Pages[0];
    Result := True;
   end;//vcm_stPosition
  end;//Case aStateType
 end;
end;

procedure TElCustomPageControl.LoadHistory;
var
 l_Index : Integer;
 l_Form  : IvcmEntityForm;
begin
 if Assigned(FHistory) and (PageCount > 0) then
 begin
  for l_Index := 0 to Pred(PageCount) do
  begin
   { Установить фиктивную закладку }
   if FHistory.IsActiveEmpty then
   begin
    if Pages[l_Index].Name = FHistory.EmptyPageName then
    begin
     ActivePage := Pages[l_Index];
     Break;
    end;
   end
   { Найти закладку с компонентом }
   else
   if (Pages[l_Index].ControlCount > 0) and
    Supports(Pages[l_Index].Controls[0], IvcmEntityForm, l_Form) then
   try
    if IsEqualGUID(l_Form.Guid, FHistory.GuidForm) then
    begin
     ActivePage := Pages[l_Index];
     Break;
    end;
   finally
    l_Form := nil;
   end;
  end; // for l_Index := 0 to Pred(PageCount) do
 end;// if Assigned(FHistory) and (PageCount > 0) then
end;

function TElCustomPageControl.LoadState(const aState: IUnknown;
 aStateType: TvcmStateType): Boolean;
var
 lHistory : IpcHistory;
begin
 Case aStateType of
  vcm_stPosition :
  begin
   if Succeeded(aState.QueryInterface(IpcHistory, lHistory)) then
   begin
    FHistory.Assign(lHistory);
    SaveHistory(lHistory);
    LoadHistory;
    Result := True;
   end//Succeeded(aState.QueryInterface(IpcHistory, l_History))
   else
    Result := false;
  end;//vcm_stPosition
  else
   Result := false;
 end;//Case aStateType
end;

{$ENDIF}

function TElCustomPageControl.IsActiveControl(aControl: TControl): Boolean;
begin
 Result := False;
 if Assigned(aControl) then
  Result := aControl = GetActiveControl;
end;

function TElCustomPageControl.GetActiveControl: TControl;
begin
 Result := nil;
 if Assigned(FActivePage) and (FActivePage.ControlCount > 0) then
  Result := FActivePage.Controls[0];
end;

function TElCustomPageControl.GetPageWithControl(aControl : TControl) : TElTabSheet;
var
 l_Index : Integer;
begin
 Result := nil;
 for l_Index := 0 to Pred(FPages.Count) do
  with Pages[l_Index] do
  if (ControlCount > 0) and (Controls[0] = aControl) then
  begin
   Result := Pages[l_Index];
   Break;
  end;
end;

procedure TElCustomPageControl.SetActivePageWithControl(aControl : TControl);
var
 lPage : TElTabSheet;
begin
 lPage := GetPageWithControl(aControl);
 if Assigned(lPage) then
  ActivePage := lPage;
end;

procedure TElCustomPageControl.DoActivePrevPage;
var
 lPrevPage : Pointer;
begin
 if FPages.Count < 2 then
  Exit;
 { Выгрузим текущую активную }
 if Assigned(FActivePage) then
  FActivesStack.Push;
 { Выгрузим предыдущую }
 lPrevPage := FActivesStack.Push;
 { Закладку уже удалили }
 if FPages.IndexOf(lPrevPage) = -1 then
  Exit;
 { Индекс предыдущей совпадет с индексом текущей } 
 if TElTabSheet(lPrevPage).PageIndex = ActivePageIndex then
 begin
  if FPages.Count > 1 then
   if TElTabSheet(lPrevPage).PageIndex > 0 then
    ActivePageIndex := 0
   else
    ActivePageIndex := 1;
 end
 { Предыдущая есть }
 else
  ActivePage := TElTabSheet(lPrevPage);
end;

procedure TElCustomPageControl.DoTabSheetClick(aTabSheet : TElTabSheet);
begin
 if Assigned(FOnTabSheetClick) then
  FOnTabSheetClick(Self, aTabSheet);
end;

function TElCustomPageControl.TriggerOnDblClickUnDock(aControl : TControl) : Boolean;
begin
 Result := True;
 if Assigned(FOnDblClickUnDock) then
  FOnDblClickUndock(Result, aControl);
end;

procedure TElCustomPageControl.DoStartDragControl(aControl: TControl);
begin
 if Assigned(FOnStartDragControl) then
  FOnStartDragControl(Self, aControl);
end;

procedure TElCustomPageControl.DoEndDragControl;
begin
  if Assigned(FOnEndDragControl) then
    FOnEndDragControl(Self);
end;

procedure TElCustomPageControl.Change;
begin
 // Запишем в стек "М. Морозов"
 if Assigned(FActivePage) then
  FActivesStack.Pop(Pointer(ActivePage));
 {$IfDef Nemesis}
 SaveHistory(FHistory); 
 {$EndIf Nemesis}
{$IFDEF USE_SOUND_MAP}
  if SoundMap <> nil then
    SoundMap.Play(FActivateSound);
{$ENDIF}
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TElCustomPageControl.ChangeActivePage(Page: TElTabSheet);
var
  ParentForm: TCustomForm;

  procedure lpChangeChildrenShowing(const aControl : TWinControl;
                                    const aValue   : Boolean);
  var
   l_Index: Integer;
   l_Showing: PBoolean;
  begin
   if Assigned(aControl) then
    for l_Index := 0 to Pred(aControl.ControlCount) do
     if aControl.Controls[l_Index] is TCustomForm then
      with aControl.Controls[l_Index] do
      begin
       l_Showing := @TWinControl(aControl.Controls[l_Index]).Showing;
       l_Showing^ := aValue;
      end;
  end;//lpChangeChildrenShowing

begin
  if FActivePage <> Page then
  begin
    ParentForm := GetParentForm(Self);
    if (ParentForm <> nil) and (FActivePage <> nil) and
      FActivePage.ContainsControl(ParentForm.ActiveControl) then
    begin
      ParentForm.ActiveControl := FActivePage;
      if ParentForm.ActiveControl <> FActivePage then
      begin
        TabIndex := FActivePage.TabIndex;
        exit;
      end;
    end;
    if Page <> nil then
    begin
      Page.Visible := True;
      lpChangeChildrenShowing(FActivePage, True);
      Page.BringToFront;
      // Realign;
      if (ParentForm <> nil) and (FActivePage <> nil) and
        (ParentForm.ActiveControl = FActivePage) then
        if Page.CanFocus then
          ParentForm.ActiveControl := Page
        else
          ParentForm.ActiveControl := Self;
    end;
    if FActivePage <> nil then
    begin
      FActivePage.Visible := False;
      lpChangeChildrenShowing(FActivePage, False);
      if FSavvyMode then
        FActivePage.DestroyHandle;
    end;
    FActivePage := Page;
    Realign;
    if FSavvyMode and (FActivePage <> nil) and HandleAllocated and (not
      FActivePage.HandleAllocated) then
      FActivePage.UpdateControlState;
    if (ParentForm <> nil) and (FActivePage <> nil) and
      (ParentForm.ActiveControl = FActivePage) then
      FActivePage.SelectFirst;
    Change;
  end;
end;

procedure TElCustomPageControl.CMControlListChange(var Message: TMessage);
begin
  inherited;
  if not (csDestroying in ComponentState) and
  (TObject(Message.wParam) is TElTabSheet)
  then
  begin
    //HandleNeeded;
    //RebuildTabs(false);
  end;
end;

procedure TElCustomPageControl.CMDesignHitTest(var Message: TCMDesignHitTest);
var
  ATabSheet: TElTabSheet;
  P: TPoint;
  Px: TPoint;
  i: integer;
begin
  Px := SmallPointToPoint(Message.Pos);
  i := HTNOWHERE;
  if DoHitTest(Px.x, Px.y, i) then
    Message.Result := 1;

  P := Px;
  ATabSheet := TabFromPoint(P);
  if (ATabSheet <> nil) and (ATabSheet <> ActivePage) then
  begin
    Message.result := 1;
  end;
end;

procedure TElCustomPageControl.CMDialogKey(var Message: TCMDialogKey);
begin
  if (Focused or Windows.IsChild(Handle, Windows.GetFocus)) and
    (Message.CharCode = VK_TAB) and (GetKeyState(VK_CONTROL) < 0) and
    ShowTabs then
  begin
    SelectNextPage(GetKeyState(VK_SHIFT) >= 0);
    Message.result := 1;
  end
  else
    inherited;
end;

{$IFDEF VCL_4_USED}
procedure TElCustomPageControl.CMDockClient(var Message: TCMDockClient);
var
 IsVisible : Boolean;
 DockCtl   : TControl;
 l_Tab     : TElTabSheet;
begin
 Message.result := 0;
 FNewDockSheet := TElTabSheet.Create(Self);
 try
  try
   DockCtl := Message.DockSource.Control;
   if DockCtl is TCustomForm then
     FNewDockSheet.Caption := TCustomForm(DockCtl).Caption;
   FNewDockSheet.PageControl := Self;
   // Копируем ImageList
   if (DockCtl.Parent is TElTabSheet) then
   begin
    l_Tab := TElTabSheet(DockCtl.Parent);
    if Assigned(l_Tab.PageControl.Images) then
    begin
     Images := l_Tab.PageControl.Images;
     if l_Tab.ImageIndex <= Pred(Images.Count) then
      FNewDockSheet.ImageIndex := l_Tab.ImageIndex;
    end;
   end;//if (DockCtl.Parent is TElTabSheet) then
   DockCtl.Dock(Self, Message.DockSource.DockRect);
   {$IfDef Nemesis}
    ArrangePagesByWeight;
    LoadHistory;
   {$EndIf Nemesis}
  except
    FNewDockSheet.Free;
    raise;
  end;
  IsVisible := DockCtl.Visible;
  FNewDockSheet.TabVisible := IsVisible;
  if IsVisible then ActivePage := FNewDockSheet;
  DockCtl.Align := alClient;
 finally
   FNewDockSheet := nil;
 end;
end;

procedure TElCustomPageControl.CMDockNotification(var Message: TCMDockNotification);
var
  I    : integer;
  S    : string;
  Page : TElTabSheet;
begin
  Page := GetPageFromDockClient(Message.Client);
  if Page <> nil then
    case Message.NotifyRec.ClientMsg of
      {$IfDef ElPackNeedEverest}
      CM_TEXTCHANGED:
      begin
       S := l3Str(Il3CString(Message.NotifyRec.MsgLParam));
       { Search for first CR/LF and end string there }
       for i := 1 to Length(S) do
         if S[i] in [#13, #10] then
         begin
           SetLength(S, i - 1);
           Break;
         end;
       Page.Caption := S;
      end;//CM_TEXTCHANGED
      {$EndIf ElPackNeedEverest}
      WM_SETTEXT:
        begin
          S := PChar(Message.NotifyRec.MsgLParam);
          { Search for first CR/LF and end string there }
          for i := 1 to Length(S) do
            if S[i] in [#13, #10] then
            begin
              SetLength(S, i - 1);
              Break;
            end;
          Page.Caption := S;
        end;
      CM_VISIBLECHANGED:
        Page.TabVisible := Boolean(Message.NotifyRec.MsgWParam);
    end;
  inherited;
end;
{$ENDIF}

procedure TElCustomPageControl.CMFocusChanged(var Message: TMessage);
begin
  inherited;
  UpdateTabs(false);
end;

procedure TElCustomPageControl.CMFontChanged(var Message: TMessage);
begin
  inherited;
  if ParentFont then
  begin
    HotTrackFont.Name := Font.Name;
    HotTrackFont.Size := Font.Size;
  end;
  Canvas.Font.Assign(Font);
  UpdateTabs(false);
end;

procedure TElCustomPageControl.CMColorChanged(var Message: TMessage);
begin
  inherited;
  if not HasVisibleTabs then
    Invalidate;
  if (Style = etsNetTabs) and not (csLoading in ComponentState) then
    TabBkColorNetStyle := IncColor(Color, 20, 20, 20);
  if ShowBorder then
    UpdateTabs(false);
end;

procedure TElCustomPageControl.CMSysColorChange(var Message: TMessage);
begin
  inherited;
  if not HasVisibleTabs then
    Invalidate;
  UpdateTabs(false);
end;

{$IFDEF VCL_4_USED}

procedure TElCustomPageControl.CMUnDockClient(var Message: TCMUnDockClient);
var
  Page: TElTabSheet;
begin
  inherited;
  Message.result := 0;
  Page := GetPageFromDockClient(Message.Client);
  if Page <> nil then
  begin
    FUndockingPage := Page;
    Message.Client.Align := alNone;
  end;
end;
{$ENDIF}

procedure TElCustomPageControl.SelectFirstTab;
var
  i: integer;
begin
  if (FirstTab = nil) and (not (csLoading in ComponentState)) then
  begin
    for i := 0 to FPages.Count - 1 do
    begin
      if TElTabSheet(FPages[i]).TabVisible then
      begin
        FirstTab := TElTabSheet(FPages[i]);
        break;
      end;
    end;
  end;
end;

procedure TElCustomPageControl.CreateHandle;
begin
  inherited CreateHandle;
  SelectFirstTab;
end;

procedure TElCustomPageControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or WS_CLIPCHILDREN;
  Params.WindowClass.style := Params.WindowClass.style or CS_HREDRAW or
    CS_VREDRAW;
end;

{$IFDEF VCL_4_USED}

procedure TElCustomPageControl.DockOver(Source: TDragDockObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  R: TRect;
begin
  GetWindowRect(Handle, R);
  Source.DockRect := R;
  DoDockOver(Source, X, Y, State, Accept);
end;

procedure TElCustomPageControl.DoAddDockClient(Client: TControl; const ARect: TRect);
begin
  if FNewDockSheet <> nil then
    Client.Parent := FNewDockSheet;
end;

procedure TElCustomPageControl.DoRemoveDockClient(Client: TControl);
var
  APage: TElTabSheet;
  lNextTabSheet : TElTabSheet;
begin
  if (FUndockingPage <> nil) then
  begin
    lNextTabSheet := GetNextTabFromStack(FUndockingPage);
    // если следующая активная из стека определена, то используем ее
    if Assigned(lNextTabSheet) then
     APage := lNextTabSheet
    else
    // ищем следующую
    begin
     if ActivePage = FUndockingPage then
      APage := FindNextPage(ActivePage, true, true, false)
     else
      APage := ActivePage;
    end;

    FUndockingPage.Free;
    FUndockingPage := nil;
    ActivePage := APage;
    DoEndDragControl;
  end;
end;
{$ENDIF}

function TElCustomPageControl.GetActivePageIndex: Integer;
begin
  if ActivePage <> nil then
    Result := ActivePage.GetPageIndex
  else
    Result := -1;
end;

procedure TElCustomPageControl.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  i: integer;
begin
  for i := 0 to FPages.Count - 1 do
    Proc(TComponent(FPages[i]));
end;

{$IFDEF VCL_4_USED}
function TElCustomPageControl.GetDockClientFromMousePos(MousePos: TPoint): TControl;
var
  Page: TElTabSheet;
begin
  Result := nil;
  if DockSite then
  begin
    Page := TabFromPoint(MousePos);
    if (Page <> nil) and (Page.ControlCount > 0) then
    begin
      Result := Page.Controls[0];
      if Result.HostDockSite <> Self then
        Result := nil;
    end;
  end;
end;
{$ENDIF}

function TElCustomPageControl.GetPageCount: integer;
begin
  result := FPages.Count;
end; { GetPageCount }

{$IFDEF VCL_4_USED}
function TElCustomPageControl.GetPageFromDockClient(Client: TControl): TElTabSheet;
var
  i: integer;
begin
  result := nil;
  if Client = nil then
  begin
    result := nil;
    exit;
  end;
  for i := 0 to PageCount - 1 do
  begin
    if (Client.Parent = Pages[i]) and (Client.HostDockSite = Self) then
    begin
      result := Pages[i];
      exit;
    end;
  end;
end;
{$ENDIF}

function TElCustomPageControl.GetPages(index: integer): TelTabSheet;
{ Returns the value of data member FPages[index ]. }
begin
  result := FPages[index];
end; { GetPages }

{$IFDEF VCL_4_USED}
procedure TElCustomPageControl.GetSiteInfo(Client: TControl; var InfluenceRect: TRect;
  MousePos: TPoint; var CanDock: Boolean);
begin
  CanDock := GetPageFromDockClient(Client) = nil;
  inherited GetSiteInfo(Client, InfluenceRect, MousePos, CanDock);
end;
{$ENDIF}

function TElCustomPageControl.GetTabIndex: integer;
var
  i: integer;
begin
  result := -1;
  if ActivePage <> nil then
  begin
    if ActivePage.TabShowing then
      result := ActivePage.TabIndex
    else
    begin
      for i := ActivePage.PageIndex + 1 to PageCount - 1 do
        if Pages[i].TabShowing then
        begin
          result := Pages[i].TabIndex;
          break;
        end;
      if result = -1 then
      begin
        for i := ActivePage.PageIndex - 1 downto 0 do
          if Pages[i].TabShowing then
          begin
            result := Pages[i].TabIndex;
            break;
          end;
      end;
    end;
  end;
end;

(*
procedure TElCustomPageControl.ImageChange(Sender : TObject);
begin
  if ((FBackground.Height = 0) or (FBackground.Width = 0)) then
    BackgroundType := bgtColorFill
  else
  begin
    RedoTmpBmp;
    Invalidate;
    if ActivePAge <> nil then
      ActivePage.Invalidate;
  end;
end;
*)

procedure TElCustomPageControl.ImageFormChange(Sender: TObject);
begin
  // RedoTmpBmp;
  Invalidate;
  UpdateTabs(false);
  if ActivePage <> nil then
    ActivePage.Invalidate;
end;

procedure TElCustomPageControl.ImageListChange(Sender: TObject);
begin
  RebuildTabs(false);
end;

procedure TElCustomPageControl.InsertPage(TabSheet: TElTabSheet);
var
  b: boolean;
begin
  b := HasVisibleTabs;
  if FPages.IndexOf(TabSheet) = -1 then
  begin
    FPages.Add(TabSheet);
    TabSheet.FPageControl := Self;
    {$ifdef MSWINDOWS}
    if IsThemeApplied then
      SetWindowPos(TabSheet.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
        SWP_NOOWNERZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or
        SWP_FRAMECHANGED);
    {$endif}
    TabSheet.UpdateTabShowing;
    RecalcTabPositions;
    if Multiline then UpdateMultilineOrder;
    if (b <> HasVisibleTabs) or Multiline then
      RebuildTabs(false);
    Invalidate;
    //Update;
  end;
end;

procedure TElCustomPageControl.MakeTabVisible(ATabSheet: TElTabSheet);
begin
  if HandleAllocated and ShowTabs then
  begin
    if (not Multiline) then
    begin
      if (FirstTab <> nil) then
      begin
        if FirstTab.PageIndex < ATabSheet.PageIndex then
        begin
          if (not ATabSheet.FShown) or not ATabSheet.FComplete then
          begin
            if not ATabSheet.TabVisible then
              exit;
            while (not ATabSheet.FComplete) and (FirstTab <> ATabSheet) do
            begin
              FRecalcTabPos := true;
              FirstTab := FindNextPage(FirstTab, true, true, false);
            end;
          end;
        end
        else
        if FirstTab.PageIndex > ATabSheet.PageIndex then
          FirstTab := ATabSheet;
      end
      else
        FirstTab := ATabSheet;
    end;
  end;
end;

procedure TElCustomPageControl.RebuildTabs(ResetFirstItem: boolean);
begin
  if FUpdateCount > 0 then
  begin
    if ResetFirstItem then
      FUpdated := FUpdated or $00020000
    else
      FUpdated := FUpdated or $00010000;
  end
  else
  begin
    if ResetFirstItem and (FPages.Count > 0) then
    begin
     // if (not Multiline) or (FLines = 1) then
      begin
        FFirstTab := FindNextPage(nil, true, true, false);
        RecalcTabPositions;
        if Multiline then
          UpdateMultilineOrder;
      end;
    end;
    //UpdateTabs(false);
    if HandleAllocated then
      Realign;
    Invalidate;
  end;
end;

(*
procedure TElCustomPageControl.RedoTmpBmp;
var BgRect,
    BgRect2 : TRect;
begin
  if BackgroundType in [bgtHorzGradient, bgtVertGradient, bgtColorFill, bgtCenterBitmap] then
  begin
    FTmpBmp.FreeImage;
  end else
  begin
    if (ClientWidth <> 0) and (ClientHeight <> 0) then
    begin
      FTmpBmp.Height := ClientHeight - 1;
      FTmpBmp.Width := ClientWidth - 1;
      BgRect := ClientRect;
      BgRect2 := BgRect;
      OffsetRect(BgRect2, BgRect2.Left, BgRect2.Top);
      ElExtBkgnd.ExtDrawBkgnd(FTmpBmp.Canvas.Handle, BgRect, BgRect, BgRect, BgRect2, false, Color, Color,  Background, BackgroundType);
    end;
  end;
end;
*)

function TElCustomPageControl.GetNextTabFromStack(aRemoveTab : TElTabSheet) : TElTabSheet; 
var
 lNextActive : Pointer;
begin
 Result := nil;
 // удаляемая была активной
 if not (csDestroying in ComponentState) and (aRemoveTab = ActivePage) then
 begin
  // вызгрузим текущую активную
  FActivesStack.Push;
  // предыдущая активная
  lNextActive := FActivesStack.Push;
  if (FPages.IndexOf(lNextActive) = -1) then
   Exit;
  // предыдущая активная в стеке
  Result := TElTabSheet(lNextActive);
 end;
end;

procedure TElCustomPageControl.RemovePage(TabSheet: TElTabSheet);
var
  NextTab         : TElTabSheet;
  ActiveFromStack : TElTabSheet;
  b, b1           : boolean;
begin
  b := hasVisibleTabs;
  if FFirstTab = TabSheet then
    FFirstTab := FindNextPage(FFirstTab, true, not (csDesigning in
      ComponentState), false);
  b1 := TabSheet = ActivePage;
  if b1 then
   if (FActiveTabAfterDelete <> -1) and (FActiveTabAfterDelete < FPages.Count) then
    NextTab := TElTabSheet(FPages[FActiveTabAfterDelete])
   else
    NextTab := FindNextPage(TabSheet,
                            True,
                            not (csDesigning in ComponentState),
                            false)
  else
    NextTab := nil;

  if DefaultPage = TabSheet then
    DefaultPage := nil;
  if NextTab = TabSheet then NextTab := nil;
  TabSheet.FPageControl := nil;
  FPages.Remove(TabSheet);
{$IFDEF VCL_4_USED}
  if FUndockingPage = Tabsheet then
    FUndockingPage := nil;
{$ENDIF}
  if FDownTab = TabSheet then
    FDownTab := nil;
  if FTrackTab = TabSheet then
    FTrackTab := nil;
  if FirstTab = TabSheet then
    FFirstTab := nil;

  if Assigned(NextTab) or (PageCount < 1) then
  begin
   if ActivePage = TabSheet then
   begin
    (* М. Морозов: берем предыдущую активную из стека, если её нет, то
       устанавливаем следущую. *)
    ActiveFromStack := GetNextTabFromStack(TabSheet);
    if Assigned(ActiveFromStack) then
     SetActivePage(ActiveFromStack)
    else
     SetActivePage(NextTab);
   end;
  end
  else
   Change;
  RecalcTabPositions;
  if Multiline then UpdateMultilineOrder;
  if (b <> HasVisibleTabs) or Multiline then
  begin
    RebuildTabs(false);
  end;
  Invalidate;
end;

procedure TElCustomPageControl.SetActivePage(Value: TElTabSheet);
var
{$IFNDEF VER90}
  Form: TCustomForm;
{$ELSE}
  Form: TForm;
{$ENDIF}
  lCurrentActive : TElTabSheet;
  lNewActive     : TElTabSheet;
begin
  if FActivePage <> Value then
  begin
    // запомним для рассылки нотификации о смене активной закладки "М. Морозов"
    lCurrentActive := ActivePage;
    lNewActive     := Value;

    if (csLoading in ComponentState) then
      FActivePage := Value
    else
    begin
      if ((Value <> nil) and (Value.PageControl <> Self)) or (not
        CanChange(Value)) then
        exit;
      ChangeActivePage(Value);
      if Value = nil then
        TabIndex := -1
      else
      begin
        if Value = FActivePage then
          if Value.TabIndex <> -1 then
            TabIndex := Value.TabIndex;
        MakeTabVisible(Value);
      end;
      UpdateMultilineOrder;
      UpdateTabs(false);
    end;
    if ComponentState * [csReading, csReading, csLoading, csDestroying] = []
      then
    begin
      Form := GetParentForm(self);
      if not FNoDTAlert then
        if (Form <> nil) and (Form.Designer <> nil) then
          Form.Designer.Modified;
      FNoDTAlert := false;
    end;
    // разошлем нотификацию "М. Морозов"
    if Assigned(lCurrentActive) then
     lCurrentActive.NotifyPageChanged(False);
    if Assigned(lNewActive) then
     lNewActive.NotifyPageChanged(True);
  end;
end;

procedure TElCustomPageControl.SetActivePageIndex(const Value: Integer);
begin
  if (Value > -1) and (Value < PageCount) then
  begin
    if ActivePage <> Pages[Value] then
      ActivePage := Pages[Value];
  end
  else
    ActivePage := nil;
end;

procedure TElCustomPageControl.SetActiveTabColor(Value: TColor);
begin
  if FActiveTabColor <> Value then
  begin
    FActiveTabColor := Value;
    if ShowTabs and (ActivePage <> nil) and (ActivePage.TabShowing) then
      UpdateTabs(false);
  end;
end;

(*
procedure TElCustomPageControl.SetBackground(newValue: TBitmap);
begin
  FBackground.Assign(newValue);
  if (FBackground.Empty) and (FBackGroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap]) then BackgroundType := bgtColorFill;
end; {SetBackground}

procedure TElCustomPageControl.SetBackgroundType(newValue: TElBkGndType);
begin
  if (FBackgroundType <> newValue) then
  begin
    FBackgroundType := newValue;
    if (FBackground.Empty) and (FBackGroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap])
       then FBackgroundType := bgtColorFill;
    RedoTmpBmp;
    Invalidate;
    if ActivePage <> nil then
      ActivePage.Invalidate;
  end; {if}
end; {SetBackgroundType}
*)

procedure TElCustomPageControl.SetChildOrder(Child: TComponent; Order: Integer);
begin
  TElTabSheet(Child).PageIndex := Order;
end;

procedure TElCustomPageControl.SetDrawFocus(Value: Boolean);
begin
  if FDrawFocus <> Value then
  begin
    FDrawFocus := Value;
    UpdateTabs(false);
  end;
end;

procedure TElCustomPageControl.SetFirstTab(Value: TElTabSheet);
begin
  if FFirstTab <> Value then
  begin
    FFirstTab := Value;
    //if not Multiline then
    if FRecalcTabPos then
    begin
      RecalcTabPositions;
      if Multiline then
        UpdateMultilineOrder;
    end
    else
      UpdateTabs(false);
  end;
end;

procedure TElCustomPageControl.SetFlat(newValue: Boolean);
{ Sets data member FFlatButtons to newValue. }
begin
  if (FFlat <> newValue) then
  begin
    FFlat := newValue;
    UpdateTabs(false);
    Invalidate;
  end; { if }
end; { SetFlatButtons }

(*

procedure TElCustomPageControl.SetGradientEndColor(newValue : TColor);
{ Sets data member FGradientEndColor to newValue. }
begin
  if (FGradientEndColor <> newValue) then
  begin
    FGradientEndColor := newValue;
    if (FBackgroundType = bgtHorzGradient) or (FBackgroundType = bgtVertGradient) then
    begin
      if ActivePage <> nil then
        ActivePage.Invalidate;
    end;
  end;  { if }
end;  { SetGradientEndColor }

procedure TElCustomPageControl.SetGradientStartColor(newValue : TColor);
{ Sets data member FGradientStartColor to newValue. }
begin
  if (FGradientStartColor <> newValue) then
  begin
    FGradientStartColor := newValue;
    if (FBackgroundType = bgtHorzGradient) or (FBackgroundType = bgtVertGradient) then
    begin
      if ActivePage <> nil then
        ActivePage.Invalidate;
    end;
  end;  { if }
end;  { SetGradientStartColor }

procedure TElCustomPageControl.SetGradientSteps(newValue : integer);
{ Sets data member FGradientSteps to newValue. }
begin
  if (FGradientSteps <> newValue) and (newValue > 0) then
  begin
    FGradientSteps := newValue;
    if (FBackgroundType = bgtHorzGradient) or (FBackgroundType = bgtVertGradient) then
    begin
      if ActivePage <> nil then
        ActivePage.Invalidate;
    end;
  end;  { if }
end;  { SetGradientSteps }

*)

procedure TElCustomPageControl.SetHotTrack(newValue: Boolean);
{ Sets data member FHotTrack to newValue. }
begin
  if FHotTrack <> newValue then
  begin
    FHotTrack := newValue;
    UpdateTabs(false);
  end; { if }
end; { SetHotTrack }

{$IFDEF ELPACK_USE_IMAGEFORM}

procedure TElCustomPageControl.SetImageForm(newValue: TElImageForm);
begin
  if (FImgForm <> newValue) then
  begin
    if FImgForm <> nil then
    begin
{$IFDEF VCL_5_USED}
      if not (csDestroying in FImgForm.ComponentState) then
        FImgForm.RemoveFreeNotification(Self);
{$ENDIF}
      FImgForm.UnregisterChanges(FImgFormChLink);
    end;
    FImgForm := newValue;
    if (newValue <> nil) then
    begin
      newValue.FreeNotification(Self);
      FImgForm.RegisterChanges(FImgFormChLink);
    end;
    UpdateTabs(false);
    if not (csDesigning in ComponentState) then
    begin
      if ActivePage <> nil then
        ActivePage.Invalidate;
    end;
  end; { if }
end; { SetImageForm }
{$ENDIF}

procedure TElCustomPageControl.SetImages(const newValue: TCustomImageList);
{ Sets data member FImages to newValue. }
begin
  if (FImages <> newValue) then
  begin
    if FImages <> nil then
    begin
{$IFDEF VCL_5_USED}
      if not (csDestroying in FImages.ComponentState) then
        FImages.RemoveFreeNotification(Self);
{$ENDIF}
      FImages.UnRegisterChanges(FImageChangeLink);
    end;
    FImages := newValue;
    if FImages <> nil then
    begin
      FImages.RegisterChanges(FImageChangeLink);
      FImages.FreeNotification(Self);
    end;
    RebuildTabs(false);
  end; { if }
end; { SetImages }

procedure TElCustomPageControl.SetAlphaImages(newValue: TImageList);
{ Sets data member FAlphaImages to newValue. }
begin
  if (FAlphaImages <> newValue) then
  begin
    if FAlphaImages <> nil then
    begin
{$IFDEF VCL_5_USED}
      if not (csDestroying in FAlphaImages.ComponentState) then
        FAlphaImages.RemoveFreeNotification(Self);
{$ENDIF}
      FAlphaImages.UnRegisterChanges(FAImageChangeLink);
    end;
    FAlphaImages := newValue;
    if FAlphaImages <> nil then
    begin
      FAlphaImages.RegisterChanges(FAImageChangeLink);
      FAlphaImages.FreeNotification(Self);
    end;
    RebuildTabs(false);
  end; { if }
end; { SetAlphaImages }

procedure TElCustomPageControl.SetInactiveTabColor(Value: TColor);
begin
  if FInactiveTabColor <> Value then
  begin
    FInactiveTabColor := Value;
    if ShowTabs then
      UpdateTabs(false);
  end;
end;

procedure TElCustomPageControl.SetMinTabHeight(Value: Integer);
begin
  if FMinTabHeight <> Value then
  begin
    FMinTabHeight := Value;
    RebuildTabs(false);
  end;
end;

procedure TElCustomPageControl.SetMinTabWidth(Value: Integer);
begin
  if FMinTabWidth <> Value then
  begin
    FMinTabWidth := Value;
    RebuildTabs(false);
  end;
end;

procedure TElCustomPageControl.SetMultiLine(newValue: Boolean);
{ Sets data member FMultiLine to newValue. }
begin
  if (FMultiLine <> newValue) then
  begin
    if newValue and (Style = etsAngledTabs) then
      raise
        Exception.Create('Multiline style is not supported for angled tabs');
    FMultiLine := newValue;
    RebuildTabs(true);
  end; { if }
end; { SetMultiLine }

procedure TElCustomPageControl.SetRaggedRight(const Value: Boolean);
begin
  if (FRaggedRight <> Value) then
  begin
    FRaggedRight := Value;
    if Multiline then
      RebuildTabs(true);
  end;
end;

procedure TElCustomPageControl.SetScrollOpposite(const Value: Boolean);
begin
  if (FScrollOpposite <> Value) then
  begin
    FScrollOpposite := Value;
    if Multiline then
      UpdateTabs(false);
  end;
end;

procedure TElCustomPageControl.SetShowBorder(Value: Boolean);
begin
  if FShowBorder <> Value then
  begin
    FShowBorder := Value;
    RebuildTabs(true);
    {$ifdef MSWINDOWS}
    if IsThemeApplied and (ActivePage <> nil) and ActivePAge.HandleAllocated then
    begin
      ActivePage.Invalidate;
      SetWindowPos(ActivePage.Handle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or
        SWP_NOZORDER or SWP_FRAMECHANGED);
      //RedrawWindow(ActivePage.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ERASE);
    end;
    {$endif}
    Invalidate;
    Realign;
    if ActivePage <> nil then ActivePage.Invalidate;
    if (csDesigning in ComponentState) then
      Update;
  end;
end;

procedure TElCustomPageControl.SetShowImages(newValue: Boolean);
{ Sets data member FShowImages to newValue. }
begin
  if (FShowImages <> newValue) then
  begin
    FShowImages := newValue;
    RebuildTabs(false);
  end; { if }
end; { SetShowImages }

procedure TElCustomPageControl.SetShowTabs(Value: Boolean);
begin
  if FShowTabs <> Value then
  begin
    FShowTabs := Value;
    RebuildTabs(false);
  end;
end;

procedure TElCustomPageControl.SetStyle(newValue: TElTabStyle);
{ Sets data member FButtonStyle to newValue. }
begin
  if (FStyle <> newValue) then
  begin
    FStyle := newValue;
    case FStyle of
      etsTabs: TabClass := TElStdTab;
      etsButtons: TabClass := TElBtnTab;
      etsFlatButtons: TabClass := TElFlatBtnTab;
      etsNetTabs:
        begin
          TabClass := TElNetTab;
          if not (csLoading in ComponentState) then
            TabBkColorNetStyle := IncColor(Color, 20, 20, 20);
        end;
      etsFlatTabs: TabClass := TEl2DFlatTab;
      etsAngledTabs:
        if Multiline then
          raise
            Exception.Create('Multiline style is not supported for angled tabs')
        else
          TabClass := TElAngledTab;
    end;
    RebuildTabs(false);
    Invalidate;
  end; { if }
end; { SetButtonStyle }

function TElCustomPageControl.GetMaxTabHeight : Integer;
var
 l_Index : Integer;
 lSize  : TSize;
 lBmp   : TBitmap;
 lR     : TRect;
begin
 Result := FTabHeight;
 if Result = 0 then
 begin
  (* Подготовим канву *)
  lBmp := TBitmap.Create;
  try
   lR  := ClientRect;
    with lBmp do
    begin
     Width := lR.Right - lR.Left;
     Height := lR.Bottom - lR.Top;
     Handle := CreateCompatibleBitmap(Self.Canvas.Handle, Width, Height);
    end;
    (* Вычислим закладку с максимальным размером *)
    for l_Index := 0 to Pred(FPages.Count) do
    begin
     lSize := MeasureSheet(lBmp.Canvas, TElTabSheet(FPages[l_Index]));
     case FTabPosition of
      etpBottom, etpTop:
       Result := Max(Result, lSize.cy);
      etpLeft, etpRight:
       Result := Max(Result, lSize.cx);
     end;
    end;
  finally
   FreeAndNil(lBmp);
  end;
 end;
end;

procedure TElCustomPageControl.SetTabHeight(newValue: DWORD);
{ Sets data member FTabHeight to newValue. }
begin
  if (FTabHeight <> newValue) then
  begin
    FTabHeight := newValue;
    RebuildTabs(false);
  end; { if }
end; { SetTabHeight }

procedure TElCustomPageControl.SetTabIndex(const Value: integer);
var
  APage: TElTabSheet;
  i, r: integer;
begin
  if csLoading in ComponentState then
    FTabIndex := Value
  else
    if Value <> -1 then
  begin
    r := 0;
    for i := 0 to FPages.Count - 1 do
    begin
      if Pages[i].TabVisible then
      begin
        if (R = Value) then
        begin
          APage := Pages[i];
          if (APage <> nil) and (APage <> ActivePage) then
            ActivePage := APage;
          break;
        end;
        inc(r);
      end;
    end;
  end
  else
    ActivePage := nil;
end;

procedure TElCustomPageControl.SetTabPosition(newValue: TElTabPosition);
begin
  if (FTabPosition <> newValue) then
  begin
    FTabPosition := newValue;
    RebuildTabs(true);
    realign;
    RequestTabPosition;
  end; { if }
end; { SetTabPosition }

procedure TElCustomPageControl.SetTabWidth(newValue: DWORD);
{ Sets data member FTabWidth to newValue. }
begin
  if (FTabWidth <> newValue) then
  begin
    FTabWidth := newValue;
    RebuildTabs(false);
  end; { if }
end; { SetTabWidth }

procedure TElCustomPageControl.ShowControl(AControl: TControl);
begin
  if (AControl is TElTabSheet) and (TElTabSheet(AControl).PageControl = Self)
    then
    SetActivePage(TElTabSheet(AControl));
  inherited ShowControl(AControl);
end;

procedure TElCustomPageControl.TriggerMeasureTabEvent(Canvas: TCanvas; Page:
  TElTabSheet; var Size: TSize);
begin
  Size.cx := 0;
  Size.cy := 0;
  if Assigned(OnMeasureTab) then
    OnMeasureTab(Self, Canvas, Page, Size);
end;

procedure TElCustomPageControl.UpdateActivePage;
begin
  if TabIndex >= 0 then
    SetActivePage(TElTabSheet(FPages[TabIndex]))
  else
    SetActivePage(nil);
end;

procedure TElCustomPageControl.UpdateTab(TabSheet: TElTabSheet);
begin
  UpdateTabs(false);
end;

procedure TElCustomPageControl.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
begin
  Msg.result := 1;
end;

procedure TElCustomPageControl.WMSize(var Msg: TWMSize);
begin
//  if not (BackgroundType in [bgtColorFill, bgtCenterBitmap]) then RedoTmpBmp;
  inherited;
{$IFNDEF VCL_4_USED}
  Resize;
{$ENDIF}
end; { WMSize }

procedure TElCustomPageControl.BeginCreate;
begin
end;

procedure TElCustomPageControl.EndCreate;
begin
end;

procedure TElCustomPageControl.RequestTabPosition;
//virtual;
begin

end;

constructor TElCustomPageControl.Create(AOwner: TComponent);
begin
  BeginCreate;

  inherited;
  ControlStyle := [csDoubleClicks, csOpaque];
  FActivesStack := TStackPointers.Create;
  FPages := TElList.Create;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FAImageChangeLink := TChangeLink.Create;
  FAImageChangeLink.OnChange := ImageListChange;
{$IFDEF ELPACK_USE_IMAGEFORM}
  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
{$ENDIF}
(*
  FBackground := TBitmap.Create;
  FBackground.OnChange := ImageChange;
  FBackgroundType := bgtColorFill;
  FGradientSteps := 16;
*)
  FVerticalSideCaptions := true;
  //FTmpBmp := TBitmap.Create;
  FActiveTabColor := clBtnFace;
  FInactiveTabColor := clBtnFace;
  Color := clBtnFace;
  FShowBorder := true;
  FTabIndex := -1;
  Width := 289;
  Height := 193;
  FMinTabWidth := 40;
  FMinTabHeight := 40;
  FShowImages := true;
  FShowTabs := true;
  TabClass := TElStdTab;
  FHotTrack := true;
  FHotTrackFont := TFont.Create;
  FHotTrackFont.OnChange := HotTrackFontChange;
  FHotTrackFont.Color := clBlue; // clHighlight;
  FActiveTabFont := TFont.Create;
  FActiveTabFont.OnChange := ActiveTabFontChange;
  FTabBkColor := clBtnFace;
  FShowTabHints := true;
  FHintTimer := TTimer.Create(nil);
  FHintTimer.OnTimer := OnHintTimer;
  FlatTabBorderColor := clBtnShadow;
  FDoStartDrag := -1;
  FTabsSize.cx := -1;
  FTabsSize.cy := -1;
  FDraggablePages := false;
  FTabCursor := crDefault;

  //////////////////////////////////////////////////////////////////////////////
  FActiveTabAfterDelete := -1;
  FFocusOnTabIfNotControls := False;
  {$IfDef Nemesis}
  FHistory := TpcHistory.Create;
  UseXPThemes := False;
  {$EndIf Nemesis}
  //////////////////////////////////////////////////////////////////////////////

  EndCreate;
end;

destructor TElCustomPageControl.Destroy;
var
  i: integer;
begin
  FreeAndNil(FActivesStack);
  {$IfDef Nemesis}
  if Assigned(FHistory) then
   FHistory := nil;
  {$EndIf Nemesis}
  FHintTimer.Free;
  if FHintWnd <> nil then
    ShowWindow(FHintWnd.Handle, SW_HIDE);
  FHintTimer := nil;
  if FScrollTimer <> nil then
    FScrollTimer.Free;
  FScrollTimer := nil;
  for i := 0 to FPages.Count - 1 do
    TElTabSheet(FPages[i]).FPageControl := nil;
  FreeAndNil(FActiveTabFont);
  FreeAndNil(FHotTrackFont);
  FreeAndNil(FImageChangeLink);
  FreeAndNil(FAImageChangeLink);
  FreeAndNil(FPages);
{$IFDEF ELPACK_USE_IMAGEFORM}
  FreeAndNil(FImgFormChLink);
{$ENDIF}
  //FBackground.Free;
  //FTmpBmp.Free;
  FreeAndNil(FTab);
  inherited;
end;

function TElCustomPageControl.FindNextPage(CurPage: TElTabSheet; GoForward,
  CheckTabVisible, CheckTabEnabled: Boolean): TElTabSheet;
var
  i, StartIndex: integer;
begin
  if FPages.Count <> 0 then
  begin
    StartIndex := FPages.IndexOf(CurPage);
    if StartIndex = -1 then
      if GoForward then
        StartIndex := FPages.Count - 1
      else
        StartIndex := 0;
    i := StartIndex;
    repeat
      if GoForward then
      begin
        Inc(I);
        if i = FPages.Count then
          i := 0;
      end
      else
      begin
        if i = 0 then
          i := FPages.Count;
        Dec(I);
      end;
      result := FPages[i];
      if (not CheckTabVisible or result.TabVisible) and
        ((not CheckTabEnabled) or (Result.TabEnabled or (csDesigning in
          ComponentState))) then
       exit;
    until i = StartIndex;
  end;
  result := nil;
end;

procedure TElCustomPageControl.Notification(AComponent: TComponent; Operation:
  TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent = FImages) then
      Images := nil;
    if (AComponent = FAlphaImages) then
      AlphaForImages := nil;
{$IFDEF ELPACK_USE_IMAGEFORM}
    if (AComponent = FImgForm) then
      ImageForm := nil;
{$ENDIF}
  end;
end;

procedure TElCustomPageControl.SelectNextPage(GoForward: Boolean);
var
  Page: TElTabSheet;
begin
  Page := FindNextPage(ActivePage, GoForward, True, True);
  if (Page <> nil) and (Page <> ActivePage) then
  begin
    TabIndex := Page.TabIndex;
  end;
end;

procedure TElCustomPageControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  {$IFNDEF VCL_4_USED}
  if not (csLoading in ComponentState) then
    Resize;
  {$ENDIF}
  // UpdateTabs;
end;

function TElCustomPageControl.TabFromPoint(Point: TPoint): TElTabSheet;
var
  i: integer;
  ASheet: TElTabSheet;
  R: TRect;
begin
  if (ActivePage <> nil) and ActivePage.FShown then
  begin
    R := ActivePage.FRect;
    Inc(R.Right);
    Inc(R.Bottom);
    if PtInRect(R, Point) then
    begin
      result := ActivePage;
      exit;
    end;
  end;
  for i := 0 to FPages.Count - 1 do
  begin
    ASheet := TElTabSheet(FPages[i]);
    if (ASheet <> ActivePage) and (ASheet.FShown) then
    begin
      R := ASheet.FRect;
      Inc(R.Right);
      Inc(R.Bottom);
      if PtInRect(R, Point) then
      begin
        result := ASheet;
        exit;
      end;
    end;
  end;
  result := nil;
end;

procedure TElCustomPageControl.UpdateTabs(Immediate: boolean);
var
  R: TRect;
  //Flags: integer;
  P: PRect;
  ASize : TSize;
begin
  if (not HandleAllocated) or (not ShowTabs) then exit;
  if FUpdateCount > 0 then
  begin
    if Immediate then
      FUpdated := FUpdated or $0002
    else
      FUpdated := FUpdated or $0001;
  end
  else
  begin
    FUpdated := 0;
    //R := BoundsRect;
    //OffsetRect(R, -Left, -Top);
    ASize := FTabsSize;
    case TabPosition of
      etpLeft: R := Rect(0, 0, ASize.cx, ASize.cy);
      etpRight: R := Rect(Width - ASize.cx, 0, Width, ASize.cy);
      etpTop: R := Rect(0, 0, ASize.cx, ASize.cy);
      etpBottom: R := Rect(0, Height - ASize.cy, ASize.cx, Height);
    end;

    (*
    Flags := RDW_INVALIDATE or RDW_NOCHILDREN;
    if Immediate then
      Flags := Flags or RDW_ERASENOW or RDW_UPDATENOW;
    *)
    P := nil;
    case TabPosition of
      etpLeft:
        if Width >= FTabsSize.cx then P := @R;
      etpRight:
        if Width >= FTabsSize.cx then P := @R;
      etpTop:
        if Height >= FTabsSize.cy then P := @R;
      etpBottom:
        if Height >= FTabsSize.cy then P := @R;
    end;
    // SendDebug('UpdateTabs at ' + IntToStr(GetTickCount));

    //RedrawWindow(Handle, P, 0, Flags);
    if P <> nil then
      InvalidateRect(Handle, P, false)
    else
    begin
      R := ClientRect;
      P := @R;
      InvalidateRect(Handle, P, false);
    end;
    if Immediate then Update;
  end;
end;

function TElCustomPageControl.CanScrollRight: Boolean;
var
  i: integer;
begin
  result := false;
  if Multiline or (FirstTab = nil) then
    exit
  else
  begin
    for i := FirstTab.PageIndex to FPages.Count - 1 do
    begin
      if TElTabSheet(FPages[i]).TabVisible and (not
        TElTabSheet(FPages[i]).FComplete) then
      begin
        result := true;
        exit;
      end;
    end;
  end;
end;

procedure TElCustomPageControl.SetHotTrackFont(Value: TFont);
begin
 FHotTrackFont.Assign(Value);
end;

procedure TElCustomPageControl.HotTrackFontChange(Sender: TObject);
begin
  if HotTrack and (FTrackTab <> nil) then
    UpdateTabs(false);
end;

procedure TElCustomPageControl.Paint;
var
  R,
    R1: TRect;
  DC: HDC;
  TmpBmp: TBitmap;
{$IFDEF ELPACK_USE_IMAGEFORM}
  ACtl: TWinControl;
  ax,
    ay: integer;
  P: TPoint;
{$ENDIF}
  ASize: TSize;
  Clp: TRect;
  BorderSides: TElBorderSides;
  HasVP : boolean;

begin

  // Morozov
  if Mouse.IsDragging then
   Exit;

  //R := inherited GetClientRect;
  R := ClientRect;
  // OffsetRect(R, -R.Left, -R.Top);

  {.$ifndef CLX_USED}
  DC := Canvas.Handle;
  {.$else}
  //DC := QPaintDevice_handle(QPainter_device(Canvas.Handle));
  {.$endif}

  HasVP := HasVisibleTabs;

  if ShowTabs and HasVP then
  begin
    TmpBmp := TBitmap.Create;
    TmpBmp.Width := R.Right - R.Left;
    TmpBmp.Height := R.Bottom - R.Top;
    TmpBmp.Handle := CreateCompatibleBitmap(DC, R.Right - R.Left, R.Bottom -
      R.Top);
  end
  else
    TmpBmp := nil;

  ASize := FTabsSize;
  R := ClientRect;

  if ShowBorder and (Style in [etsTabs, etsNetTabs, etsFlatTabs, etsAngledTabs])
    {$ifdef MSWINDOWS}and not IsThemeApplied{$endif} then
  begin
    if ShowTabs and HasVP then
    begin
      case TabPosition of
        etpLeft: R := Rect(ASize.cx{ - GetSystemMetrics(SM_CXEDGE)}, 0, Width,
          ASize.cy);
        etpRight: R := Rect(0, 0, Width - ASize.cx {+
          GetSystemMetrics(SM_CXEDGE)}, ASize.cy);
        etpTop: R := Rect(0, ASize.cy{ - GetSystemMetrics(SM_CYEDGE)}, Width,
          Height);
        etpBottom: R := Rect(0, 0, Width, Height - ASize.cy{ +
          GetSystemMetrics(SM_CYEDGE)});
      end;
    end
    else
    begin
      R := ClientRect;
    end;
    BorderSides := AllBorderSides;
    if ShowTabs and HasVisibleTabs then
      case TabPosition of
        etpLeft: Exclude(BorderSides, ebsLeft);
        etpRight: Exclude(BorderSides, ebsRight);
        etpTop: Exclude(BorderSides, ebsTop);
        etpBottom: Exclude(BorderSides, ebsBottom);
      end;

    if Style = etsFlatTabs then
      DrawFlatFrameEx2(DC, R, FlatTabBorderColor, Color, false, true,
        BorderSides, fbtColorLineBorder, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow)
    else
    begin
      DrawButtonFrameEx3(Canvas.Handle, R, not Flat, false, clBtnFace{Color}, false, BorderSides);
      if not Flat then
        InflateRect(R, -2, -2)
      else
        InflateRect(R, -1, -1);
    end;
    //
  end;
  if ShowTabs and HasVP then
  begin
    case TabPosition of
      etpLeft: R := Rect(0, 0, ASize.cx, ASize.cy);
      etpRight: R := Rect(Width - ASize.cx, 0, Width, ASize.cy);
      etpTop: R := Rect(0, 0, ASize.cx, ASize.cy);
      etpBottom: R := Rect(0, Height - ASize.cy, ASize.cx, Height);
    end;
    DrawTabs(TmpBmp.Canvas, R, true, ASize);
    //DrawTabs(Canvas, R, true, ASize);

    Clp := R;

    (* М. Морозов ########################################################### *)
    (* При отсутствии границ нужно выделять активную закладку. Досконально
       разобраться пока не удалось где нужно поместить изменения, потому они
       здесь *)
    if (TabPosition = etpLeft) and not ShowBorder then
     Inc(Clp.Right);
    (* ###################################################################### *)

    bitblt(DC, Clp.Left, Clp.Top, Clp.Right - Clp.Left, Clp.Bottom - Clp.Top,
      TmpBmp.Canvas.Handle, Clp.Left, Clp.Top, { 0, 0,} SRCCOPY);
  end;
  TmpBmp.Free;

  if HasVP then exit;

  //R := ClientRect;
  R1 := Canvas.ClipRect;

  {$ifdef MSWINDOWS}
  if IsThemeApplied and
    Succeeded(DrawThemeBackground(Theme, Canvas.Handle, TABP_BODY, 0, R, @R1)) then
    Exit;
  {$endif}

{$IFDEF ELPACK_USE_IMAGEFORM}
  if (FImgForm <> nil) and (not (csDesigning in
    FImgForm.GetRealControl.ComponentState)) then
  begin
    if (FImgForm.Control <> Self) then
    begin
      ACtl := FImgForm.GetRealControl;
      R1 := R;
      R.TopLeft := ClientToScreen(R.TopLeft);
      P := Parent.ClientToScreen(Point(Left, Top));
      ax := R.Left - P.x;
      ay := R.Top - P.y;

      R.BottomRight := ClientToScreen(R.BottomRight);
      R.TopLeft := ACtl.ScreenToClient(R.TopLeft);
      R.BottomRight := ACtl.ScreenToClient(R.BottomRight);

      FImgForm.PaintBkgnd(Handle, R1, Point(R.Left - ax, R.Top - ay), false);
    end;
  end
  else
{$ENDIF}
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(R);
  end;
end;

{$IFDEF VCL_4_USED}
procedure TElCustomPageControl.WMLButtonDblClk(var Message: TWMLButtonDblClk);
var
  DockCtl: TControl;
begin
  inherited;
  DockCtl := GetDockClientFromMousePos(SmallPointToPoint(Message.Pos));
  if (DockCtl <> nil) and (FScrollBtnState = pbsNone) and
    TriggerOnDblClickUnDock(DockCtl) then
   DockCtl.ManualDock(nil, nil, alNone);
end;
{$ENDIF}


procedure TElCustomPageControl.WMKeyDown(var Message: TWMKeyDown);
begin
  inherited;
  IntKeyDown(Message.CharCode);
end;

procedure TElCustomPageControl.SetScrollBtnState(Value: TElPageScrollBtnState);
begin
  if FScrollBtnState <> Value then
  begin
    if (not (FScrollBtnState in [pbsLeftBtnDown, pbsRightBtnDown])) and
      (Value in [pbsLeftBtnDown, pbsRightBtnDown]) then
    begin
      FScrollTimer := TTimer.Create(nil);
      FScrollTimer.Enabled := false;
      FScrollTimer.OnTimer := OnScrollTimer;
      FScrollTimer.Interval := 250;
      FScrollTimer.Enabled := true;
    end;
    FScrollBtnState := Value;
    if not (FScrollBtnState in [pbsLeftBtnDown, pbsRightBtnDown]) then
    begin
      FScrollTimer.Free;
      FScrollTimer := nil;
    end;
    UpdateTabs(false);
  end;
end;

procedure TElCustomPageControl.SetTrackTab(Value: TElTabSheet);
begin
  if FTrackTab <> Value then
  begin
    FTrackTab := Value;
    if HotTrack {$ifdef MSWINDOWS}or IsThemeApplied{$endif} then
      UpdateTabs(false);
  end;
end;


procedure TElCustomPageControl.WMLButtonDown(var Message: TWMLBUTTONDOWN);
begin
{$IFDEF VCL_4_USED}
  if DragMode = dmAutomatic then
  begin
    BeginAutoDrag;
    Exit;
  end;
{$ENDIF}
  inherited;
  //with ScreenToClient(Point(Message.XPos, Message.YPos)) do
    IntMouseDown(Message.XPos, Message.YPos);
end;

procedure TElCustomPageControl.WMLButtonUp(var Message: TWMLBUTTONUP);
begin
  inherited;
    IntLButtonUp(Message.XPos, Message.YPos);
end;

function TElCustomPageControl.DoHitTest(X, Y: integer; var Res: integer): boolean;
var
  P: TPoint;
  R: TRect;
  ASheet: TElTabSheet;
begin
  R.TopLeft := FTabsPos;
  R.Right := FTabsPos.x + FTabsSize.cx;
  R.Bottom := FTabsPos.y + FTabsSize.cy;

  p := Point(X, Y);

  result := false;

  if PtInRect(FScrollLeftRect, p) then
  begin
    if ScrollBtnState = pbsNone then
      ScrollBtnState := pbsLeftBtnOver
    else
      if ScrollBtnState = pbsLeftBtnHeld then
      ScrollBtnState := pbsLeftBtnDown
    else
      if ScrollBtnState = pbsRightBtnDown then
      ScrollBtnState := pbsRightBtnHeld
    else
      if ScrollBtnState = pbsRightBtnOver then
      ScrollBtnState := pbsNone;
    result := true;
  end
  else
  begin
    if ScrollBtnState = pbsLeftBtnDown then
      ScrollBtnState := pbsLeftBtnHeld
    else
      if ScrollBtnState = pbsLeftBtnOver then
      ScrollBtnState := pbsNone;

    if PtInRect(FScrollRightRect, p) then
    begin
      if ScrollBtnState = pbsNone then
        ScrollBtnState := pbsRightBtnOver
      else
        if ScrollBtnState = pbsRightBtnHeld then
        ScrollBtnState := pbsRightBtnDown;
      result := true;
    end
    else
      if ScrollBtnState = pbsRightBtnOver then
      ScrollBtnState := pbsNone
    else
      if ScrollBtnState = pbsRightBtnDown then
      ScrollBtnState := pbsRightBtnHeld;
  end;

  if PtInRect(R, P) then
  begin
    //Res := HTBORDER;
    ASheet := TabFromPoint(p);
    if (ASheet <> nil) and (ASheet.TabEnabled or (csDesigning in ComponentState)) then
    begin
      TrackTab := ASheet;
      exit;
    end
  end;
  TrackTab := nil;
  (*if (ScrollBtnState in [pbsLeftBtnOver, pbsRightBtnOver]) then
    ScrollBtnState := pbsNone;*)
end;

procedure TElCustomPageControl.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    with ScreenToClient(Point(Message.XPos, Message.YPos)) do
    DoHitTest(X, Y, Message.Result);
end;

procedure TElCustomPageControl.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if (Message.LParam = 0) or (Message.LParam = Integer(Self)) then
  begin
    TrackTab := nil;
    if (ScrollBtnState in [pbsLeftBtnOver, pbsRightBtnOver]) then
      ScrollBtnState := pbsNone;
    if FHintWnd <> nil then
      ShowWindow(FhintWnd.Handle, SW_HIDE);
    FHintTimer.Enabled := false;
  end;
end;

procedure TElCustomPageControl.OnScrollTimer(Sender: TObject);
begin
  if (ScrollBtnState = pbsLeftBtnDown) and (CanScrollLeft) then
    FirstTab := FindNextPage(FirstTab, false, true, false)
  else
    if (ScrollBtnState = pbsRightBtnDown) and (CanScrollRight) then
    FirstTab := FindNextPage(FirstTab, true, true, false)
  {else
    FScrollTimer.Enabled := false
  }
    ;
end;

procedure TElCustomPageControl.SetTabBkColor(Value: TColor);
begin
  if FTabBkColor <> Value then
  begin
    FTabBkColor := Value;
    UpdateTabs(false);
  end;
end;

function TElCustomPageControl.HasVisibleTabs: Boolean;
var
  i: integer;
begin
  result := false;
  for i := 0 to FPages.Count - 1 do
  begin
    if TElTabSheet(FPages[i]).TabVisible then
    begin
      result := true;
      exit;
    end;
  end;
end;

function TElCustomPageControl.NewPage: TElTabSheet;
begin
  Result := TElTabSheet.Create(Self);
  Result.PageControl := Self;
end;

{$IfDef Nemesis}
procedure TElCustomPageControl.ArrangePagesByWeight;
  {* - расположить закладки по весовым коэфициентам. }

 function lp_Control(const aIndex: Integer): IvcmTabSheetControl;
 begin
  Result := nil;
  if (Pages[aIndex].ControlCount > 0) then
   Supports(Pages[aIndex].Controls[0], IvcmTabSheetControl, Result);
 end;//lp_Control

var
 J          : Integer;
 l_Pred     : IvcmTabSheetControl;
 l_Current  : IvcmTabSheetControl;
 l_Stop     : Boolean;
begin
 l_Stop := False;
 while not l_Stop do
 begin
  l_Stop := True;
  for J := 1 to Pred(FPages.Count) do
  begin
   l_Pred := lp_Control(Pred(J));
   if Assigned(l_Pred) then
   begin
    l_Current := lp_Control(J);
    if Assigned(l_Current) and (l_Current.Weight > 0) and
      ((l_Current.Weight < l_Pred.Weight) or (l_Pred.Weight < 0)) then
    begin
     Pages[J].PageIndex := Pred(J);
     l_Stop := False;
    end;//if Assigned(l_Current) and (l_Current.Weight > 0) and
   end;//if Assigned(l_Pred) then
  end;//for J := 1 to Pred(FPages.Count) do
 end;//while not l_Stop do
end;//ArrangePagesByWeight

{$EndIf Nemesis}

procedure TElCustomPageControl.Loaded;
begin
  Realign;
  inherited;
  FNoDTAlert := true;
  HandleNeeded;

  RecalcTabPositions;

  SelectFirstTab;

  // UpdateTabs(true);

  if ActivePage <> nil then
    ActivePage.Visible := true;
  TabBkColorNetStyle := IncColor(ColorToRGB(Color), 20, 20, 20);
  if (DefaultPage <> nil) and (DefaultPage.PageControl = Self)
    {and (DefaultPage.tabVisible)} then
    ActivePage := DefaultPage
  else
    FNoSetFirstTab := false;
  UpdateStyle;
end;

procedure TElCustomPageControl.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTALLKEYS or DLGC_WANTARROWS;
end;


procedure TElCustomPageControl.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  PostMessage(Handle, PM_REFRESHACTIVEPAGE, 0, 0);
  // if Multiline then
end;

procedure TElCustomPageControl.Resize;
begin
{$IFNDEF VCL_4_USED}
  if Assigned(FOnResize) then FOnResize(Self);
{$ELSE}
  inherited;
{$ENDIF}

  (*
  if Multiline then
  begin
    RecalcTabPositions;
    UpdateMultilineOrder;
    Realign;
  end;
  *)
  // RebuildTabs(not Multiline);
  RebuildTabs(true);
end;

procedure TElCustomPageControl.UpdateMultilineOrder;
var
  i: integer;
begin
  if MultiLine and (ActivePage <> nil) and (Style in [etsTabs, etsNetTabs,
    etsFlatTabs, etsAngledTabs]) then
  begin
    if (ActivePage.FLine < FLines - 1) then
    begin
      for i := 0 to FPages.Count - 1 do
      begin
        if TElTabSheet(FPages[i]).FLine = ActivePage.FLine + 1 then
        begin
          FirstTab := TElTabSheet(FPages[i]);
          RecalcTabPositions;
          break;
        end;
      end;
    end;
  end;
end;

procedure TElCustomPageControl.TriggerGetImageEvent(PageIndex: integer; var
  ImageIndex: integer);
begin
  if assigned(FOnGetImageIndex) then
    FOnGetImageIndex(Self, PageIndex, ImageIndex);
end;

{$IFDEF ELPACK_USE_IMAGEFORM}

procedure TElCustomPageControl.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  if ShowTabs then
    UpdateTabs(false);
  Broadcast(Message);
end;
{$ENDIF}

procedure TElCustomPageControl.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
{$IFDEF ELPACK_USE_IMAGEFORM}
  Perform(IFM_REPAINTCHILDREN, 0, 0);
{$ENDIF}
end;

{$IFDEF ELPACK_USE_IMAGEFORM}
procedure TElCustomPageControl.IFMEffectiveSize(var Message: TMessage);
begin
  inherited;
  if Message.lParam <> 0 then
  begin
    PRect(Message.lParam)^ := BoundsRect;
    OffsetRect(PRect(Message.lParam)^, -Left, -Top);
  end;
end;

procedure TElCustomPageControl.IFMCanPaintBkgnd(var Message: TMessage);
begin
  Message.Result := 1;
end;
{$ENDIF}

procedure TElCustomPageControl.PMRefreshActivePage(var Message: TMessage);
var
  ASheet: TElTabSheet;
begin
  ASheet := ActivePage;
  if ASheet <> nil then
  begin
    FActivePage := nil;
    ActivePage := ASheet;
  end;
end;

procedure TElCustomPageControl.WMRButtonUp(var Message: TWMRBUTTONUP);
begin
  inherited;
  //with ScreenToClient(Point(Message.XPos, Message.YPos)) do
    IntRButtonUp(Message.XPos, Message.YPos);
end;

procedure TElCustomPageControl.SetDraggablePages(Value: boolean);
begin
  FDraggablePages := Value;
  FDoStartDrag := -1;
end;

procedure TElCustomPageControl.SetCloseButtonMode(Value: TElCloseBtnMode);
begin
  if FCloseBtnMode <> Value then
  begin
    FCloseBtnMode := Value;
    RebuildTabs(false);
  end;
end;


constructor TElTab.Create(Owner: TElCustomPageControl);
begin
  inherited Create;
  FOwner := Owner;
end;

function TElTab.GetOuterMargin: Integer;
begin
  Result := 0;
end;

function TElTab.GetInnerMargin: Integer;
begin
  Result := 0;
end;

procedure TElTab.DrawTabContents(Canvas: TCanvas; R: TRect; TabSheet:
  TElTabSheet);
var
  FPageControl: TElCustomPageControl;
  SR, R2: TRect;
  Bmp: TBitmap;
  AFont: HFont;
  amBMP: TBitmap;
  i
  , x, y
  : integer;
  Size: TSize;
  ImIdx: integer;
  aPosition: TElTabPosition;

const
  CenterFlags: array[boolean] of Cardinal = (DT_LEFT, DT_CENTER);
  SingleLineFlags: array[boolean] of Cardinal = (DT_SINGLELINE, 0);

begin

  FPageControl := FOwner;
  SR := R;
  if (FPageControl.FActivePage = TabSheet) and (FPageControl.UseActiveTabFont)
    then
    Canvas.Font.Assign(FPageControl.ActiveTabFont)
  else
    if FPageControl.HotTrack and (FPageControl.FTrackTab = TabSheet) and
      (TabSheet.TabEnabled) then
    Canvas.Font.Assign(FPageControl.HotTrackFont)
  else
    if (not TabSheet.ParentFont) and TabSheet.UseFontForTabs then
    Canvas.Font.Assign(TabSheet.Font)
  else
    Canvas.Font.Assign(FPageControl.Font);
  if (not TabSheet.TabEnabled) then
    Canvas.Font.Color := clBtnShadow;
  case FPageControl.TabPosition of
    etpLeft:
      AFont := FOwner.GetRotatedFont(Canvas, 900);
    etpRight:
      AFont := FOwner.GetRotatedFont(Canvas, -900);
  else
    AFont := FOwner.GetRotatedFont(Canvas, 0);
  end;
  Canvas.Font.Handle := AFont;
  case FPageControl.TabPosition of
    etpTop,
      etpBottom:
      begin
        inc(R.Left, GetContentMargin);
        dec(R.Right, GetContentMargin);
      end;
    etpLeft,
      etpRight:
      begin
        if FPageControl.VerticalSideCaptions then
        begin
          dec(R.Bottom, GetContentMargin);
          inc(R.Top, GetContentMargin);
        end
        else
        begin
          inc(R.Left, GetContentMargin);
          dec(R.Right, GetContentMargin);
        end;
      end;
  end;

  if (not FPageControl.VerticalSideCaptions) then
    aPosition := etpTop
  else
    aPosition := FPageControl.FTabPosition;

  imidx := TabSheet.ImageIndex;
  if imidx = -1 then
    FPageControl.TriggerGetImageEvent(TabSheet.PageIndex, imidx);

  if (FPageControl.Images <> nil) and (FPageControl.ShowImages) and (imidx <> -1)
    then
  begin
    {$IFNDEF DesignTimeLibrary}
    if InRange(0, FPageControl.Images.Count - 1, ImIdx) then
    {$ENDIF}
    begin
      BMP := TBitmap.Create;
      BMP.Width := FPageControl.Images.Width;
      BMP.Height := FPageControl.Images.Height;

      case aPosition of
        etpTop,
          etpBottom:
          begin
            R2.Left := R.Left;
            R2.Top := R.Top + Max(0, (R.Bottom - R.Top - bmp.Height) div 2);
            R2.Right := Min(R.Right, R.Left + Bmp.Width);
            R2.Bottom := Min(R.Bottom, R2.Top + Bmp.Height);
          end;
        etpLeft:
          begin
            R2.Top := Max(R.Top, R.Bottom - Bmp.Height);
            R2.Left := R.Left + Max(0, (R.Right - R.Left - bmp.Width) div 2);
            R2.Bottom := R.Bottom;
            (******************************************************************)
              R2.Right := Min(R.Right, R2.Left + Bmp.Width);
            (* М. Морозов.  ****************************************************

              Bugfix: У картинки отрезался один пиксел.

              R2.Right := Min(R.Right, R.Left + Bmp.Width);

              Description:

              R2.Right вычисляется с учетом центрирования картинки, поэтому
              может получится, что R2.Left (4) > R.Left (3) и при
              R2.Right (19) := R.Left (3) + Bmp.Width (16) может поличиться, что
              R2.Right (19) - R2.Left (4) < Bmp.Width (16).

            *******************************************************************)
          end;
        etpRight:
          begin
            R2.Top := R.Top;
            R2.Left := R.Left + Max(0, (R.Right - R.Left - bmp.Width) div 2);
            R2.Bottom := Min(R.Bottom, R2.Top + Bmp.Height);
            (*М. Морозов. См. комментарий выше. ********************************)
            //R2.Right := Min(R.Right, R.Left + Bmp.Width);
            R2.Right := Min(R.Right, R2.Left + Bmp.Width);
            (******************************************************************)
          end;
      end;

      Bmp.Canvas.CopyRect(Rect(0, 0, R2.Right - R2.Left, R2.Bottom - R2.Top),
        Canvas, R2);

      FPageControl.Images.Draw(BMP.Canvas, 0, 0, ImIdx);
      if Assigned(FPageControl.AlphaForImages) and (InRange(0,
        FPageControl.AlphaForImages.Count - 1, ImIdx)) then
      begin
        amBMP := TBitmap.Create;
        amBMP.Width := FPageControl.AlphaForImages.Width;
        amBMP.Height := FPageControl.AlphaForImages.Height;
        ImageList_DrawEx(FPageControl.AlphaForImages.Handle, ImIdx,
          amBMP.Canvas.Handle, 0, 0, 0, 0,
          clNone, clNone, ILD_Normal);

        AlphaCopyRect2(Canvas.Handle, R2, BMP.Canvas.Handle,
          Rect(0, 0, R2.Right - R2.Left, R2.Bottom - R2.Top), amBMP, 255);

        amBMP.Free;
      end
      else
        Canvas.CopyRect(R2, BMP.Canvas, Rect(0, 0, R2.Right - R2.Left, R2.Bottom
          - R2.Top));

      BMP.Free;
    end;
    case aPosition of
      etpTop,
        etpBottom:
        inc(R.Left, FPageControl.Images.Width + Margin);
      etpLeft:
        dec(R.Bottom, FPageControl.Images.Height + Margin);
      etpRight:
        inc(R.Top, FPageControl.Images.Height + Margin);
    end;
  end;
{$IFDEF ELPACK_UNICODE}
  if WidePos(ElFCRLF, TabSheet.Caption) > 0 then
  begin
    ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(WideString(TabSheet.Caption)),
      Length(TabSheet.Caption), R2, DT_CALCRECT);
    Size.cx := R2.Right - R2.Left;
    Size.cy := R2.Bottom - R2.Top;
  end
  else
    GetTextExtentPoint32W(Canvas.Handle, PWideChar(TabSheet.Caption),
      Length(TabSheet.Caption), Size);
{$ELSE}
  if Pos(ElFCRLF, TabSheet.Caption) > 0 then
  begin
    DrawText(Canvas.Handle, PChar(TabSheet.Caption), Length(TabSheet.Caption),
      R2, DT_CALCRECT);
    Size.cx := R2.Right - R2.Left;
    Size.cy := R2.Bottom - R2.Top;
  end
  else
    GetTextExtentPoint32(Canvas.Handle, PChar(TabSheet.Caption),
      Length(TabSheet.Caption), Size);
{$ENDIF}
  if (FPageControl.TabPosition in [etpLeft, etpRight]) and
    FPageControl.VerticalSideCaptions then
  begin
    i := Size.cx;
    Size.cx := Size.cy;
    Size.cy := i;
  end;
  if (FPageControl.TabPosition in [etpLeft, etpRight]) and
    FPageControl.VerticalSideCaptions then
  begin
    R.Left := Max(R.Left, R.Left + (R.Right - R.Left - Size.cx) div 2);
  end
  else
  begin
    R.Top := Max(R.Top, R.Top + (R.Bottom - R.Top - Size.cy) div 2);
  end;
  x := 0;
  y := 0;
  case aPosition of
    etpTop,
      etpBottom:
      begin
        x := R.Left;
        y := R.Top;
      end;
    etpLeft:
      begin
        x := R.Left;
        y := R.Bottom;
      end;
    etpRight:
      begin
        x := R.Right;
        y := R.Top;
      end;
  end;

  Canvas.Brush.Style := bsClear;
{$IFDEF ELPACK_UNICODE}
  if aPosition in [etpTop, etpBottom] then
    DrawTextW(Canvas.Handle, PWideChar(TabSheet.Caption),
      Length(TabSheet.Caption), R, SingleLineFlags[WidePos(ElFCRLF,
      TabSheet.Caption) > 0] or CenterFlags[FPageControl.CenterTabCaptions])
  else
    ExtTextOutW(Canvas.Handle, x, y, ETO_CLIPPED, @R,
      PWideChar(TabSheet.Caption), Length(TabSheet.Caption), nil);
{$ELSE}
  if (aPosition in [etpTop, etpBottom]) then
    DrawText(Canvas.Handle, PChar(TabSheet.Caption), Length(TabSheet.Caption),
      R, SingleLineFlags[Pos(ElFCRLF, TabSheet.Caption) > 0] or
      CenterFlags[FPageControl.CenterTabCaptions])
  else
    ExtTextOut(Canvas.Handle, x, y, ETO_CLIPPED, @R, PChar(TabSheet.Caption),
      Length(TabSheet.Caption), nil);
{$ENDIF}
  if FPageControl.DrawFocusRect and FPageControl.Focused and
    (TabSheet = FPageControl.ActivePage) then
  begin
    Canvas.Pen.Color := FPageControl.Font.Color;
    AdjustFocusRect(SR);
    ElVCLUtils.DrawFocus(Canvas, SR);
  end;
end;

procedure TElTab.DrawSpace(Canvas: TCanvas; var cx, cy: integer; mx, my:
  integer);
begin
  // intentionally left blank
end;

function TElTab.CanDrawTab(ActiveDraw: boolean): Boolean;
begin
  result := not ActiveDraw;
end;

procedure TElTab.AdjustDrawingSize(Active: boolean; var R: TRect);
begin
  // intentionally left blank
end;

function TElTab.GetAscend: Integer;
begin
  Result := 0;
end;

procedure TElTab.Draw(ACanvas: TCanvas; R: TRect; TabSheet: TElTabSheet);
var
  DefDraw: boolean;
  PgCtl: TElCustomPageControl;
begin
  PgCtl := FOwner;
  PgCtl.TriggerDrawTabEvent(ACanvas, TabSheet, r, edsBackground, DefDraw);
  if DefDraw then
    FillTab(ACanvas, R, TabSheet);

  PgCtl.TriggerDrawTabEvent(ACanvas, TabSheet, r, edsEdges, DefDraw);
  if DefDraw then
    DrawTabEdges(ACanvas, R, TabSheet);
  if TabSheet.CloseButtonVisible then
    DrawCloseButton(ACanvas, R, TabSheet);
  InflateRect(R, -(Margin div 2), -(Margin div 2));
  PgCtl.TriggerDrawTabEvent(ACanvas, TabSheet, r, edsContents, DefDraw);
  if DefDraw then
    DrawTabContents(ACanvas, R, TabSheet);
  InflateRect(R, Margin div 2, Margin div 2);
  FixupTab(ACanvas, R, TabSheet);
end;

procedure TElTab.DrawCloseButton(Canvas: TCanvas; var R: TRect; TabSheet:
  TElTabSheet);
const
  HMargin = Margin div 2;
var
  {$ifdef MSWINDOWS}
  iStateId: integer;
  {$endif}
  sx, sy: integer;
//  pc: integer;
  tr: Trect;
begin
  {$IFDEF MSWINDOWS}
  sx := GetSystemMetrics(SM_CXMENUSIZE {SM_CXSIZE});
  sy := GetSystemMetrics(SM_CYMENUSIZE {SM_CYSIZE});
  {$ELSE}
  sx := 15;
  sy := 15;
  {$ENDIF}
  if R.Bottom - R.Top - Margin < sy then
  begin
    dec(sx, (sy - (R.Bottom - R.Top - Margin)));
    dec(sy, (sy - (R.Bottom - R.Top - Margin)));
    if sx < 0 then sx := 0;
    if sy < 0 then sy := 0;
  end;
{
  if IsThemeApplied then
  begin
    sx := sx - sx div 4;
    sy := sy - sy div 4;
  end;
}
  case FOwner.TabPosition of
    etpTop:
      begin
        TabSheet.FCloseBtnRect := Rect(R.Right - HMargin - sx,
          R.Top + HMargin,
          R.Right - HMargin,
          R.Top + HMargin + sy);
        if FOwner.Style = etsAngledTabs then
          OffsetRect(TabSheet.FCloseBtnRect, -Margin, Margin);
        R.Right := TabSheet.FCloseBtnRect.Left;
      end;
    etpBottom:
      begin
        TabSheet.FCloseBtnRect := Rect(R.Right - HMargin - sy,
          R.Bottom - HMargin - sy,
          R.Right - HMargin,
          R.Bottom - HMargin);
        R.Right := TabSheet.FCloseBtnRect.Left;
        if FOwner.Style = etsAngledTabs then
          OffsetRect(TabSheet.FCloseBtnRect, -Margin, -Margin);
      end;
    etpLeft:
      begin
        TabSheet.FCloseBtnRect := Rect(R.Left + HMargin,
          R.Top + HMargin,
          R.Left - HMargin + sx,
          R.Top - HMargin + sy);
        if FOwner.Style = etsAngledTabs then
          OffsetRect(TabSheet.FCloseBtnRect, Margin, Margin);
        R.Top := TabSheet.FCloseBtnRect.Bottom;
      end;
    etpRight:
      begin
        TabSheet.FCloseBtnRect := Rect(R.Right + HMargin - sy,
          R.Bottom + HMargin - sy,
          R.Right - HMargin,
          R.Bottom - HMargin);
        if FOwner.Style = etsAngledTabs then
          OffsetRect(TabSheet.FCloseBtnRect, -Margin, -Margin);
        R.Bottom := TabSheet.FCloseBtnRect.Top;
      end;
  end;

  tr := TabSheet.FCloseBtnRect;

  {$ifdef MSWINDOWS}
  if IsThemeApplied then
  begin
    with TabSheet do
      if not CloseBtnEnabled then
        iStateId := SBS_DISABLED
      else
        if FCloseBtnDown and (PageIndex = FPageControl.ActivePageIndex) then
        iStateId := SBS_PUSHED
      else
        iStateId := SBS_NORMAL;

    DrawThemeBackground(CloseBtnTheme, Canvas.Handle, WP_SMALLCLOSEBUTTON,
      iStateId, tr, nil)
  end
  else
  {$endif}
  begin
    DrawButtonFrameEx3(Canvas.Handle, tr, not FOwner.Flat,
      TabSheet.CloseBtnEnabled and TabSheet.FCloseBtnDown and (TabSheet.PageIndex = FOwner.ActivePageIndex),
      FOwner.Color, false, AllBorderSides);
//    pc := Canvas.Pen.Color;
    if TabSheet.CloseBtnEnabled then
    begin
      Canvas.Pen.Color := clBtnText;
      with Canvas do
        with tr do
        begin
          MoveTo(Left + 1 + 3, Top + 1 + 3);
          LineTo(Right - 1 - 4, Bottom - 1 - 4);
          MoveTo(Left + 1 + 3, Bottom - 1 - 5);
          LineTo(Right - 1 - 4, Top + 1 + 2);

          MoveTo(Left + 1 + 3 + 1, Top + 1 + 3);
          LineTo(Right - 1 - 4 + 1, Bottom - 1 - 4);
          MoveTo(Left + 1 + 3 + 1, Bottom - 1 - 5);
          LineTo(Right - 1 - 4 + 1, Top + 1 + 2);
        end;
    end
    else
    begin
      Canvas.Pen.Color := clBtnHighlight;
      OffsetRect(tr, 1, 1);
      with Canvas do
        with tr do
        begin
          MoveTo(Left + 1 + 3, Top + 1 + 3);
          LineTo(Right - 1 - 4, Bottom - 1 - 4);
          MoveTo(Left + 1 + 3, Bottom - 1 - 5);
          LineTo(Right - 1 - 4, Top + 1 + 2);

          MoveTo(Left + 1 + 3 + 1, Top + 1 + 3);
          LineTo(Right - 1 - 4 + 1, Bottom - 1 - 4);
          MoveTo(Left + 1 + 3 + 1, Bottom - 1 - 5);
          LineTo(Right - 1 - 4 + 1, Top + 1 + 2);
        end;
      Canvas.Pen.Color := clBtnShadow;
      OffsetRect(tr, -1, -1);
      with Canvas do
        with tr do
        begin
          MoveTo(Left + 1 + 3, Top + 1 + 3);
          LineTo(Right - 1 - 4, Bottom - 1 - 4);
          MoveTo(Left + 1 + 3, Bottom - 1 - 5);
          LineTo(Right - 1 - 4, Top + 1 + 2);

          MoveTo(Left + 1 + 3 + 1, Top + 1 + 3);
          LineTo(Right - 1 - 4 + 1, Bottom - 1 - 4);
          MoveTo(Left + 1 + 3 + 1, Bottom - 1 - 5);
          LineTo(Right - 1 - 4 + 1, Top + 1 + 2);
        end;
    end;
//    Canvas.Pen.Color := pc;
  end;
end;

procedure TElTab.AdjustTabSize(var Size: TSize);
begin
  // intentionally left blank
end;

procedure TElTab.AdjustFillSize(After: boolean; var R: TRect; TabSheet:
  TElTabSheet);
begin
  if After then
    InflateRect(R, 1, 1)
  else
    InflateRect(R, -1, -1);
end;

procedure TElTab.DrawTabLine(Canvas: TCanvas; R: TRect);
begin
  // intentionally left blank
end;

procedure TElTab.FillSpace(Canvas: TCanvas; Rect: TRect);
var
  R: TRect;
  OldP: TPoint;
begin
  {$ifdef MSWINDOWS}
  if IsThemeApplied then
  begin
    R := Rect;

    OldP := Point(FOwner.Left, FOwner.Top);

    SetMapMode(Canvas.Handle, MM_ANISOTROPIC);
    SetViewPortOrgEx(Canvas.Handle, -OldP.x, -OldP.y, @OldP);
    SendMessage(FOwner.Parent.Handle, WM_ERASEBKGND, Canvas.Handle, 0);
    SetViewPortOrgEx(Canvas.Handle, OldP.x, OldP.y, nil);
    SetMapMode(Canvas.Handle, MM_TEXT);
  end
  else
  {$endif}
  begin
    Canvas.Brush.Color := FOwner.TabBkColor;
    Canvas.FillRect(Rect);
  end;
end;

procedure TElTab.FillTab(Canvas: TCanvas; Rect: TRect; TabSheet:
  TElTabSheet);
begin
  AdjustFillSize(false, Rect, TabSheet);
{$IFDEF ELPACK_USE_IMAGEFORM}
  if (FOwner.FImgForm = nil) or (csDesigning in
    FOwner.ComponentState) then
{$ENDIF}
  begin
    Canvas.Brush.Style := bsSolid;
    if TabSheet.UseTabColor then
      Canvas.Brush.Color := TabSheet.TabColor
    else
      if TabSheet = FOwner.FActivePage then
      Canvas.Brush.Color := FOwner.FActiveTabColor
    else
      Canvas.Brush.Color := FOwner.FInactiveTabColor;
    Canvas.FillRect(Rect);
  end;
  AdjustFillSize(true, Rect, TabSheet);
end;

procedure TElTab.DrawButtons(Canvas: TCanvas; LeftRect, RightRect: TRect; CSL,
  CSR: boolean);
var
  {$ifdef MSWINDOWS}
  iPartId: Integer;
  iStateId: Integer;
  {$endif}
begin
  {$ifdef MSWINDOWS}
  if IsThemeApplied then
  begin
    if FOwner.TabPosition in [etpLeft, etpRight] then
    begin
      if FOwner.TabPosition = etpLeft then
        iPartId := SPNP_DOWN
      else
        iPartId := SPNP_UP;
      if CSL then
      begin
        if FOwner.ScrollBtnState = pbsLeftBtnDown then
        begin
          iStateId := DNS_PRESSED;
        end
        else
        begin
          iStateId := DNS_NORMAL;
        end;
      end
      else
      begin
        iStateId := DNS_DISABLED;
      end;
    end
    else
    begin
      iPartId := SPNP_DOWNHORZ;
      if CSL then
      begin
        if FOwner.ScrollBtnState = pbsLeftBtnDown then
        begin
          iStateId := DNHZS_PRESSED;
        end
        else
        begin
          iStateId := DNHZS_NORMAL;
        end;
      end
      else
      begin
        iStateId := DNHZS_DISABLED;
      end;
    end;
    DrawThemeBackground(ScrollTheme, Canvas.Handle, iPartId, iStateId, LeftRect, nil);
    if FOwner.TabPosition in [etpLeft, etpRight] then
    begin
      if FOwner.TabPosition = etpLeft then
        iPartId := SPNP_UP
      else
        iPartId := SPNP_DOWN;
      if CSR then
      begin
        if FOwner.ScrollBtnState = pbsRightBtnDown then
        begin
          iStateId := UPS_PRESSED;
        end
        else
        begin
          iStateId := UPS_NORMAL;
        end;
      end
      else
      begin
        iStateId := UPS_DISABLED;
      end;
    end
    else
    begin
      iPartId := SPNP_UPHORZ;
      if CSR then
      begin
        if FOwner.ScrollBtnState = pbsRightBtnDown then
        begin
          iStateId := UPHZS_PRESSED;
        end
        else
        begin
          iStateId := UPHZS_NORMAL;
        end;
      end
      else
      begin
        iStateId := UPHZS_DISABLED;
      end;
    end;

    DrawThemeBackground(ScrollTheme, Canvas.Handle, iPartId, iStateId, RightRect, nil);
  end
  else
  {$endif}
  begin
    DrawButtonFrameEx3(Canvas.Handle, LeftRect, not FOwner.Flat,
      FOwner.ScrollBtnState = pbsLeftBtnDown,
        FOwner.Color, false, AllBorderSides);
    DrawButtonFrameEx3(Canvas.Handle, RightRect, not FOwner.Flat,
      FOwner.ScrollBtnState = pbsRightBtnDown,
        FOwner.Color, false, AllBorderSides);
    case FOwner.TabPosition of
      etpTop,
        etpBottom:
        begin
          ElVCLUtils.DrawArrow(Canvas, eadLeft, LeftRect, clBtnText, csl);
          ElVCLUtils.DrawArrow(Canvas, eadRight, RightRect, clBtnText, csr);
        end;
      etpLeft:
        begin
          ElVCLUtils.DrawArrow(Canvas, eadDown, LeftRect, clBtnText, csl);
          ElVCLUtils.DrawArrow(Canvas, eadUp, RightRect, clBtnText, csr);
        end;
      etpRight:
        begin
          ElVCLUtils.DrawArrow(Canvas, eadUp, LeftRect, clBtnText, csl);
          ElVCLUtils.DrawArrow(Canvas, eadDown, RightRect, clBtnText, csr);
        end;
    end;
  end;
end;

function TElTab.GetRowMargin: Integer;
begin
  Result := 0;
end;

function TElStdTab.GetOuterMargin: Integer;
begin
  Result := 2;
end;

function TElStdTab.CanDrawTab(ActiveDraw: boolean): Boolean;
begin
  result := ActiveDraw;
end;

function TElStdTab.GetAscend: Integer;
begin
  Result := 2;
end;

procedure TElStdTab.AdjustDrawingSize(Active: boolean; var R: TRect);
var
  FPageControl: TElCustomPageControl;
begin
  if Active then
  begin
    FPageControl := FOwner;
    case FPageControl.TabPosition of
      etpLeft:
        begin
          //inc(R.Right);
          dec(R.Left, GetAscend);
          inc(R.Bottom, GetOuterMargin);
          dec(R.Top, GetOuterMargin);
        end;
      etpTop:
        begin
          //inc(R.Top);
          dec(R.Top, GetAscend);
          dec(R.Left, GetOuterMargin);
          inc(R.Right, GetOuterMargin);
        end;
      etpRight:
        begin
          //dec(R.Left);
          inc(R.Right, GetAscend);
          inc(R.Bottom, GetOuterMargin);
          dec(R.Top, GetOuterMargin);
        end;
      etpBottom:
        begin
          dec(R.Top);
          inc(R.Bottom, GetAscend);
          dec(R.Left, GetOuterMargin);
          inc(R.Right, GetOuterMargin);
        end;
    end;
  end;
end;

procedure TElStdTab.DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
  TElTabSheet);
const
  ROUND_CORNER_SIZE = 2;
var
  iPartId: Integer;
  iStateId: Integer;
begin
  {$ifdef MSWINDOWS}
  if IsThemeApplied and (TabPosition = etpTop) then
  begin
    if TabSheet = FOwner.FActivePage then
    begin
      iPartId := TABP_TOPTABITEM;
      iStateId := TIS_SELECTED;
    end
    else
    begin
      iPartId := TABP_TABITEM;
      if TabSheet = FOwner.FTrackTab then
      begin
        iStateId := TIS_HOT;
      end
      else
      begin
        if TabSheet = FOwner.FDownTab then
        begin
          iStateId := TIS_FOCUSED;
        end
        else
        begin
          iStateId := TIS_NORMAL;
        end;
      end;
    end;
    if not TabSheet.Enabled then
    begin
      iStateId := TIS_DISABLED;
    end;
    case FOwner.TabPosition of
      etpLeft:
        inc(R.Right, 1);
      etpRight:
        dec(R.Left, 1);
      etpTop:
        inc(R.Bottom, 1);
      etpBottom:
        dec(R.Bottom, 1);
    end;
    DrawThemeBackground(TabTheme, Canvas.Handle, iPartId, iStateId, R, nil);
    GetThemeBackgroundContentRect(TabTheme, Canvas.Handle, iPartId, iStateId, R,
      R);
    case FOwner.TabPosition of
      etpLeft:
        dec(R.Right, 1);
      etpRight:
        inc(R.Left, 1);
      etpTop:
        dec(R.Bottom, 1);
      etpBottom:
        inc(R.Bottom, 1);
    end;
  end
  else
  {$endif}
  begin
    Canvas.Pen.Color := clBtnHighlight;
    case FOwner.TabPosition of
      etpLeft:
        with Canvas do
        begin
          MoveTo(r.right - 1, r.top);
          LineTo(r.left + ROUND_CORNER_SIZE, r.top);
          LineTo(r.left, r.top + ROUND_CORNER_SIZE);
          LineTo(r.left, r.bottom - ROUND_CORNER_SIZE);

          (* shadow *)
          if FOwner.Flat then
            Pen.Color := clBtnShadow
          else
            Pen.Color := cl3DDkShadow;
          MoveTo(r.left + 1, r.bottom - 2);
          LineTo(r.left + ROUND_CORNER_SIZE, r.bottom - 1);
          LineTo(r.right - 1, r.bottom - 1);

          (* shade *)
          if not FOwner.Flat then
          begin
            Pen.Color := clBtnShadow;
            MoveTo(r.left + ROUND_CORNER_SIZE, r.bottom - 2);
            LineTo(r.right - 1, r.bottom - 2);
          end;
          if TabSheet = FOwner.FActivePage then
            if FOwner.ShowBorder then
            begin
              if not FOwner.Flat then
              begin
                Pixels[R.Right - 1, R.Bottom - 2] := clBtnShadow;
                Pixels[R.Right - 1, R.Bottom - 1] := cl3DDkShadow;
              end
              else
              begin
                Pixels[R.Right - 1, R.Bottom - 1] := clBtnShadow;
              end;
            end;
        end;
      etpTop:
        with Canvas do
        begin
          (* highlight *)
          Pen.Color := clBtnHighlight;
          MoveTo(r.left, r.bottom - 1);
          LineTo(r.left, r.top + ROUND_CORNER_SIZE);
          LineTo(r.left + ROUND_CORNER_SIZE, r.top);
          LineTo(r.right - ROUND_CORNER_SIZE, r.top);

          (* shadow *)
          if FOwner.Flat then
            Pen.Color := clBtnShadow
          else
            Pen.Color := cl3DDkShadow;
          // SelectObject(dc, hbPen);
          MoveTo(R.right - 2, R.Top + 1);
          LineTo(R.right - 1, r.top + ROUND_CORNER_SIZE);
          LineTo(R.right - 1, r.bottom);

          (* shade *)
          if not FOwner.Flat then
          begin
            Pen.Color := clBtnShadow;
            MoveTo(r.right - 2, r.top + ROUND_CORNER_SIZE);
            LineTo(r.right - 2, r.bottom - 1);
          end;
        end;
      etpRight:
        with Canvas do
        begin
          MoveTo(r.left + 1, r.top);
          LineTo(r.right - ROUND_CORNER_SIZE - 1, r.top);
          LineTo(r.right - 1, r.top + ROUND_CORNER_SIZE);

          (* shadow *)
          if FOwner.Flat then
            Pen.Color := clBtnShadow
          else
            Pen.Color := cl3DDkShadow;
          LineTo(r.right - 1, r.bottom - ROUND_CORNER_SIZE - 1);
          LineTo(r.right - ROUND_CORNER_SIZE - 1, r.bottom - 1);
          LineTo(r.left, r.bottom - 1);

          (* shade *)
          if not FOwner.Flat then
          begin
            Pen.Color := clBtnShadow;
            MoveTo(r.right - 2, r.top + 2);
            LineTo(r.right - 2, r.bottom - 2);
            MoveTo(r.right - 3, r.bottom - 2);
            LineTo(r.left - 1, r.bottom - 2);
          end;
        end;
      etpBottom:
        with Canvas do
        begin
          (* highlight *)

          MoveTo(r.left, r.top + 2);
          LineTo(r.left, r.bottom - ROUND_CORNER_SIZE - 1);
          LineTo(r.left + ROUND_CORNER_SIZE, r.bottom - 1);

          (* shadow *)
          if FOwner.Flat then
            Pen.Color := clBtnShadow
          else
            Pen.Color := cl3DDkShadow;
          LineTo(r.right - ROUND_CORNER_SIZE - 1, r.bottom - 1);
          LineTo(r.right, r.bottom - ROUND_CORNER_SIZE - 2);
          MoveTo(r.right - 1, r.bottom - ROUND_CORNER_SIZE - 1);
          LineTo(r.right - 1, r.top + 1);

          (* shade *)
          if not FOwner.Flat then
          begin
            Pen.Color := clBtnShadow;
            MoveTo(r.left + ROUND_CORNER_SIZE, r.bottom - 2);
            LineTo(r.right - 2, r.bottom - 2);
            MoveTo(r.right - 2, r.bottom - ROUND_CORNER_SIZE - 1);
            LineTo(r.right - 2, r.top);
          end;
        end;
    end;
    InflateRect(r, -1, -1);
  end;
end;

procedure TElStdTab.AdjustTabSize(var Size: TSize);
var
  R,
    R1: TRect;
  pid,
    sid: integer;
begin
  {$ifdef MSWINDOWS}
  if IsThemeApplied then
  begin
    pid := TABP_TOPTABITEM;
    sid := TIS_SELECTED;
    R := Rect(0, 0, Size.cx, Size.cy);
    GetThemeBackgroundContentRect(TabTheme, FOwner.Canvas.Handle,
      pid, sid, R, R1);
    if FOwner.TabPosition in [etpLeft, etpRight] then
    begin
      inc(Size.cy, (R1.Left - R.Left) + (R.Right - R1.Right));
      inc(Size.cx, (R1.Top - R.Top) + (R.Bottom - R1.Bottom));
    end
    else
    begin
      inc(Size.cx, (R1.Left - R.Left) + (R.Right - R1.Right));
      inc(Size.cy, (R1.Top - R.Top) + (R.Bottom - R1.Bottom));
    end;
  end
  else
  {$endif}
  begin
    inc(Size.cx, 2);
    inc(Size.cy, 2);
  end;
end;

procedure TElStdTab.DrawTabLine(Canvas: TCanvas; R: TRect);
var
  ASheet: TElTabSheet;
  R1: TRect;
begin
  ASheet := FOwner.ActivePage;

  {$ifdef MSWINDOWS}
  if IsThemeApplied then
  begin
    case FOwner.TabPosition of
      etpTop:
        begin
          R.Top := R.Bottom - 1;
          inc(R.Bottom, 2);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(ASheet.FRect.Left, R.Top, ASheet.FRect.Right, R.Bottom);
            // InflateRect(R1, 1, 0);
            with R1 do
              ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
      etpBottom:
        begin
          if FOwner.Flat then
            R.Bottom := R.Top + 1
          else
            R.Bottom := R.Top + 2;
          dec(R.Top);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(ASheet.FRect.Left, R.Top, ASheet.FRect.Right, R.Bottom);
            // InflateRect(R1, 1, 0);
            with R1 do
              ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
      etpLeft:
        begin
          R.Left := R.Right - 2;
          //inc(R.Right);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(R.Left, ASheet.FRect.Top, R.Right, ASheet.FRect.Bottom);
            InflateRect(R1, 0, 1);
            with R1 do
              ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
      etpRight:
        begin
          if FOwner.Flat then
            R.Right := R.Left + 1
          else
            R.Right := R.Left + 2;
          dec(R.Left, 1);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(R.Left, ASheet.FRect.Top, R.Right, ASheet.FRect.Bottom);
            InflateRect(R1, 0, 1);
            with R1 do
              ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
    end;
      DrawThemeBackground(TabTheme, Canvas.Handle, TABP_PANE, 0, R, nil);
    exit;
  end;
  {$endif}
  with Canvas do
    case FOwner.TabPosition of
      etpTop:
        begin
          Pen.Color := clBtnHighlight;
          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Bottom - 1);
            LineTo(R.Right, R.Bottom - 1);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              MoveTo(R.Left, R.Bottom - 1);
              LineTo(ASheet.FRect.Left  - 1, R.Bottom - 1);
            end;
            if ASheet.FRect.Right + 2 < R.Right then
            begin
              MoveTo(ASheet.FRect.Right  + 1, R.Bottom - 1);
              LineTo(R.Right, R.Bottom - 1);
            end;
          end;
        end;
      etpBottom:
        begin
          R.Bottom := R.Top + 2;
          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            if FOwner.Flat then
              DrawEdge(Handle, R, BDR_RAISEDINNER, BF_BOTTOM)
            else
              DrawEdge(Handle, R, BDR_RAISED, BF_BOTTOM);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              R1 := Rect(R.Left, R.Top, ASheet.FRect.Left - 1, R.Bottom);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_BOTTOM)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_BOTTOM);
            end;
            if ASheet.FRect.Right < R.Right then
            begin
              R1 := Rect(ASheet.FRect.Right, R.Top, R.Right, R.Bottom);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_BOTTOM)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_BOTTOM);
            end;
          end;

          if FOwner.ShowBorder then
          begin
            Pixels[R.Left, R.Bottom - 1] := clBtnHighlight;
            Pixels[R.Left, R.Bottom - 2] := clBtnHighlight;
            if FOwner.Flat then
              Pixels[R.Right - 1, R.Bottom - 2] := clBtnShadow
            else
              Pixels[R.Right - 1, R.Bottom - 2] := cl3DDkShadow;
          end;
        end;
      etpLeft:
        begin
          Pen.Color := clBtnHighlight;
          Dec(R.Bottom);

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Right - 1, R.Top);
            LineTo(R.Right - 1, R.Bottom);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              MoveTo(R.Right - 1, R.Top);
              LineTo(R.Right - 1, ASheet.FRect.Top - 1);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              MoveTo(R.Right - 1, ASheet.FRect.Bottom);
              LineTo(R.Right - 1, R.Bottom);
            end;
          end;
          if FOwner.ShowBorder then
          begin
            if not FOwner.Flat then
            begin
              Pixels[R.Right - 1, R.Bottom - 1] := clBtnShadow;
              Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
            end
            else
            begin
              Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
            end;
          end
          (*# Морозов. М. ######################################################
            Смотри комментарии в AdjustClientRect.
            ##################################################################*)
          else
          begin
           Pen.Color := clBtnFace;
           MoveTo(R.Right, R.Top);
           LineTo(R.Right, Succ(R.Bottom));
          end;
          (*##################################################################*)

          inc(R.Bottom);
        end;
      etpRight:
        begin
          R.Right := R.Left + 2;
          Dec(R.Bottom);

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            if FOwner.Flat then
              DrawEdge(Handle, R, BDR_RAISEDINNER, BF_RIGHT)
            else
              DrawEdge(Handle, R, BDR_RAISED, BF_RIGHT);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              R1 := Rect(R.Left, R.Top, R.Right, ASheet.FRect.Top - 1);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_RIGHT)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_RIGHT);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              R1 := Rect(R.Left, ASheet.FRect.Bottom + 1, R.Right, R.Bottom);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_RIGHT)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_RIGHT);
            end;
          end;

          if FOwner.ShowBorder then
          begin
            Pixels[R.Right - 2, R.Top] := clBtnHighlight;
            Pixels[R.Right - 1, R.Top] := clBtnHighlight;
            if not FOwner.Flat then
            begin
              Pixels[R.Right - 2, R.Bottom] := cl3DDkShadow;
              Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
            end
            else
            begin
              Pixels[R.Right - 2, R.Bottom] := clBtnShadow;
              Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
            end;
          end;
          
          inc(R.Bottom);
        end;
    end;
end;

procedure TElStdTab.AdjustFillSize(After: boolean; var R: TRect; TabSheet:
  TElTabSheet);
begin
  inherited;
  if TabSheet = FOwner.FActivePage then
    case FOwner.TabPosition of
      etpTop:
        begin
          if After then
          begin
            dec(R.Right);
            dec(R.Bottom);
          end
          else
          begin
            inc(R.Right);
            inc(R.Bottom);
          end;
        end;
      etpBottom:
        begin
          if After then
          begin
            inc(R.Top);
          //inc(R.Bottom);
          //dec(R.Right);
          end
          else
          begin
            dec(R.Top);
          //dec(R.Bottom);
          // inc(R.Right);
          end;
        end;
      etpLeft:
        begin
          if After then
          begin
          //dec(R.Left);
            dec(R.Right);
          //dec(R.Bottom);
          end
          else
          begin
          //inc(R.Left);
            inc(R.Right);
          //inc(R.Bottom);
          end;
        end;
      etpRight:
        begin
          if After then
          begin
            inc(R.Left, 2);
          //dec(R.Right);
          //dec(R.Bottom);
          end
          else
            dec(R.Left, 2);
          //inc(R.Right);
          //inc(R.Bottom);
        end;
    end
  else
  begin
    case FOwner.TabPosition of
      etpBottom:
        begin
        end;
      etpRight:
        begin
        end;
    end;
  end;
end;

procedure TElStdTab.FillTab(Canvas: TCanvas; Rect: TRect; TabSheet:
  TElTabSheet);
{$IFDEF ELPACK_USE_IMAGEFORM}
var
  ACtl: TWinControl;
  BgRect: TRect;
{$ENDIF}
begin
  AdjustFillSize(false, Rect, TabSheet);
{$IFDEF ELPACK_USE_IMAGEFORM}
  if (FOwner.FImgForm = nil) or (csDesigning in
    FOwner.ComponentState) then
{$ENDIF}
  begin
    Canvas.Brush.Style := bsSolid;
    if TabSheet.UseTabColor then
      Canvas.Brush.Color := TabSheet.TabColor
    else
      if TabSheet = FOwner.FActivePage then
      Canvas.Brush.Color := FOwner.FActiveTabColor
    else
      Canvas.Brush.Color := FOwner.FInactiveTabColor;
    Canvas.FillRect(Rect);
{$IFDEF ELPACK_USE_IMAGEFORM}
  end
  else
    if TabSheet = FOwner.FActivePage then
  begin
    if (FOwner.FImgForm.Control <> FOwner) then
    begin
      ACtl := FOwner.FImgForm.GetRealControl;

      BgRect.Left := FOwner.Left;
      BgRect.Top := FOwner.Top;

      BgRect.TopLeft :=
        FOwner.Parent.ClientToScreen(BgRect.TopLeft);
      BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);

      FOwner.FImgForm.PaintBkgnd(Canvas.Handle, Rect,
        BgRect.TopLeft, false);
    end;
{$ENDIF}
  end;
  AdjustFillSize(true, Rect, TabSheet);
end;

function TElBtnTab.GetInnerMargin: Integer;
begin
  Result := Margin;
end;

procedure TElBtnTab.DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
  TElTabSheet);
var
  b: boolean;
  iPartId: Integer;
  iStateId: Integer;
begin
  {$ifdef MSWINDOWS}
  if IsThemeApplied then
  begin
    iPartId := BP_PUSHBUTTON;
    if TabSheet.Enabled then
    begin
      if TabSheet = FOwner.FActivePage then
      begin
        iStateId := PBS_PRESSED;
      end
      else
      begin
        if TabSheet = FOwner.FTrackTab then
        begin
          iStateId := PBS_HOT;
        end
        else
        begin
          if TabSheet = FOwner.FDownTab then
          begin
            iStateId := PBS_PRESSED;
          end
          else
          begin
            iStateId := PBS_NORMAL;
          end;
        end;
      end;
    end
    else
    begin
      iStateId := PBS_DISABLED;
    end;
    DrawThemeBackground(BtnTheme, Canvas.Handle, iPartId, iStateId, R, nil);
    GetThemeBackgroundContentRect(BtnTheme, Canvas.Handle, iPartId, iStateId, R,
      R);
  end
  else
  {$endif}
  begin
    b := (TabSheet = FOwner.ActivePage) or
      ((TabSheet = FOwner.FDownTab) and
      (TabSheet = FOwner.FTrackTab));
    DrawButtonFrameEx3(Canvas.Handle, R, not FOwner.Flat, b,
      FOwner.ActiveTabColor, FOwner.Flat, AllBorderSides);
    InflateRect(R, -2, -2);
  end;
end;

procedure TElBtnTab.DrawSpace(Canvas: TCanvas; var cx, cy: integer; mx, my:
  integer);
begin
  case FOwner.TabPosition of
    etpTop,
      etpBottom:
      begin
        inc(cx, GetInnerMargin);
      end;
    etpLeft:
      begin
        inc(cy, GetInnerMargin);
      end;
    etpRight:
      begin
        inc(cy, GetInnerMargin);
      end;
  end;
end;

procedure TElBtnTab.AdjustTabSize(var Size: TSize);
var
  R,
    R1: TRect;
  pid,
    sid: integer;
begin
  {$ifdef MSWINDOWS}
  if IsThemeApplied then
  begin
    pid := BP_PUSHBUTTON;
    sid := PBS_HOT;
    R := Rect(0, 0, Size.cx, Size.cy);
    GetThemeBackgroundContentRect(BtnTheme, FOwner.Canvas.Handle,
      pid, sid, R, R1);
    if FOwner.TabPosition in [etpLeft, etpRight] then
    begin
      inc(Size.cy, (R1.Left - R.Left) + (R.Right - R1.Right));
      inc(Size.cx, (R1.Top - R.Top) + (R.Bottom - R1.Bottom));
    end
    else
    begin
      inc(Size.cx, (R1.Left - R.Left) + (R.Right - R1.Right));
      inc(Size.cy, (R1.Top - R.Top) + (R.Bottom - R1.Bottom));
    end;
  end
  else
  {$endif}
  begin
    inc(Size.cx, 4);
    inc(Size.cy, 4);
  end;
end;

function TElBtnTab.GetRowMargin: Integer;
begin
  Result := 2;
end;

function TElFlatBtnTab.GetInnerMargin: Integer;
begin
  Result := Margin * 2 + 2;
end;

procedure TElFlatBtnTab.DrawSpace(Canvas: TCanvas; var cx, cy: integer; mx,
  my: integer);
begin
  {$ifdef MSWINDOWS}
  if not IsThemeApplied then
  {$endif}
  begin
    case FOwner.TabPosition of
      etpTop,
        etpBottom:
        begin
          inc(cx, (GetInnerMargin - 2) div 2);
          Canvas.Pen.Color := clBtnShadow;
          Canvas.MoveTo(cx - 1, cy);
          Canvas.LineTo(cx - 1, cy + my);
          Canvas.Pen.Color := clBtnHighlight;
          Canvas.MoveTo(cx, cy);
          Canvas.LineTo(cx, cy + my);
          inc(cx, (GetInnerMargin - 2) div 2);
        end;
      etpLeft:
        begin
          dec(cy, (GetInnerMargin - 2) div 2);

          Canvas.Pen.Color := clBtnHighlight;
          Canvas.MoveTo(cx, cy + 1);
          Canvas.LineTo(cx + mx, cy + 1);
          Canvas.Pen.Color := clBtnShadow;
          Canvas.MoveTo(cx, cy);
          Canvas.LineTo(cx + mx, cy);
          dec(cy, (GetInnerMargin - 2) div 2);
        end;
      etpRight:
        begin
          inc(cy, (GetInnerMargin - 2) div 2);

          Canvas.Pen.Color := clBtnShadow;
          Canvas.MoveTo(cx, cy - 1);
          Canvas.LineTo(cx + mx, cy - 1);
          Canvas.Pen.Color := clBtnHighlight;
          Canvas.MoveTo(cx, cy);
          Canvas.LineTo(cx + mx, cy);

          inc(cy, (GetInnerMargin - 2) div 2);
        end;
    end;
  end
  {$ifdef MSWINDOWS}
  else
    inherited;
  {$endif}
end;

procedure TElFlatBtnTab.DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet
  : TElTabSheet);
var
  iPartId: Integer;
  iStateId: Integer;
begin
  {$ifdef MSWINDOWS}
  if IsThemeApplied then
  begin
    iPartId := BP_PUSHBUTTON;
    if TabSheet.Enabled then
    begin
      if TabSheet = FOwner.FActivePage then
      begin
        iStateId := PBS_PRESSED;
      end
      else
      begin
        if TabSheet = FOwner.FTrackTab then
        begin
          iStateId := PBS_HOT;
        end
        else
        begin
          if TabSheet = FOwner.FDownTab then
          begin
            iStateId := PBS_PRESSED;
          end
          else
          begin
            iStateId := PBS_NORMAL;
          end;
        end;
      end;
    end
    else
    begin
      iStateId := PBS_DISABLED;
    end;
    if iStateId <> PBS_NORMAL then
    begin
      DrawThemeBackground(BtnTheme, Canvas.Handle, iPartId, iStateId, R, nil);
    end;
    GetThemeBackgroundContentRect(BtnTheme, Canvas.Handle, iPartId, iStateId, R,
      R);
  end
  else
  {$endif}
  begin
    if TabSheet = FOwner.FActivePage then
    begin
      DrawButtonFrameEx3(Canvas.Handle, R, false, true,
        FOwner.ActiveTabColor, FOwner.Flat, AllBorderSides);
    end
    else
      if (TabSheet = FOwner.FDownTab) and
      (TabSheet = FOwner.FTrackTab) then
    begin
      DrawButtonFrameEx3(Canvas.Handle, R, false, true,
        FOwner.ActiveTabColor, FOwner.Flat, AllBorderSides);
    end
    else
      if TabSheet = FOwner.FTrackTab then
    begin
      DrawButtonFrameEx3(Canvas.Handle, R, false, false,
        FOwner.InactiveTabColor, FOwner.Flat, AllBorderSides);
    end;
    InflateRect(R, -2, -2);
  end;
end;

procedure TElFlatBtnTab.AdjustTabSize(var Size: TSize);
var
  R,
    R1: TRect;
  pid,
    sid: integer;
begin
  {$ifdef MSWINDOWS}
  if IsThemeApplied then
  begin
    pid := BP_PUSHBUTTON;
    sid := PBS_HOT;
    R := Rect(0, 0, Size.cx, Size.cy);
    GetThemeBackgroundContentRect(BtnTheme, FOwner.Canvas.Handle,
      pid, sid, R, R1);
    if FOwner.TabPosition in [etpLeft, etpRight] then
    begin
      inc(Size.cy, (R1.Left - R.Left) + (R.Right - R1.Right));
      inc(Size.cx, (R1.Top - R.Top) + (R.Bottom - R1.Bottom));
    end
    else
    begin
      inc(Size.cx, (R1.Left - R.Left) + (R.Right - R1.Right));
      inc(Size.cy, (R1.Top - R.Top) + (R.Bottom - R1.Bottom));
    end;
  end
  else
  {$endif}
  begin
    inc(Size.cx, 4);
    inc(Size.cy, 4);
  end;
end;

procedure TElFlatBtnTab.AdjustFillSize(After: boolean; var R: TRect; TabSheet
  : TElTabSheet);
begin
  if (TabSheet = FOwner.FActivePage) or
    (TabSheet = FOwner.FDownTab) or
    (TabSheet = FOwner.FTrackTab) then
  begin
    if After then
      InflateRect(R, 1, 1)
    else
      InflateRect(R, -1, -1);
  end;
end;

function TElFlatBtnTab.GetRowMargin: Integer;
begin
  Result := 2;
end;

procedure TElNetTab.DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
  TElTabSheet);
var
  iPartId: Integer;
  iStateId: Integer;
begin
  (*
  if IsThemeApplied and (TabPosition = etpTop) then
  begin
    if TabSheet = FOwner.FActivePage then
    begin
      iPartId := TABP_TOPTABITEM;
        iStateId := TIS_SELECTED;
    end
    else
    begin
      iPartId := TABP_TABITEM;
      if TabSheet = FOwner.FTrackTab then
      begin
        iStateId := TIS_HOT;
      end
      else
      begin
        if TabSheet = FOwner.FDownTab then
        begin
          iStateId := TIS_FOCUSED;
        end
        else
        begin
          iStateId := TIS_NORMAL;
        end;
      end;
    end;
    if not TabSheet.Enabled then
    begin
      iStateId := TIS_DISABLED;
    end;
    if (iStateId <> TIS_NORMAL) or (iPartId = TABP_TOPTABITEM) then
    begin
      DrawThemeBackground(TabTheme, Canvas.Handle, iPartId, iStateId, R, nil);
      GetThemeBackgroundContentRect(TabTheme, Canvas.Handle, iPartId, iStateId, R, R);
    end
    else
    begin
      DrawThemeBackground(TabTheme, Canvas.Handle, TABP_BODY, 0, R, nil);
      GetThemeBackgroundContentRect(TabTheme, Canvas.Handle, TABP_BODY, 0, R, R);
    end;
  end
  else
  *)
  {$ifdef MSWINDOWS}
  if IsThemeApplied and (TabPosition = etpTop) then
  begin
    if TabSheet = FOwner.FActivePage then
    begin
      iPartId := TABP_TOPTABITEM;
      iStateId := TIS_SELECTED;
    end
    else
    begin
      iPartId := TABP_TABITEM;
      if TabSheet = FOwner.FTrackTab then
      begin
        iStateId := TIS_HOT;
      end
      else
      begin
        if TabSheet = FOwner.FDownTab then
        begin
          iStateId := TIS_FOCUSED;
        end
        else
        begin
          iStateId := TIS_NORMAL;
        end;
      end;
    end;
    if not TabSheet.Enabled then
    begin
      iStateId := TIS_DISABLED;
    end;
    case FOwner.TabPosition of
      etpLeft:
        inc(R.Right, 1);
      etpRight:
        dec(R.Left, 1);
      etpTop:
        inc(R.Bottom, 1);
      etpBottom:
        dec(R.Bottom, 1);
    end;
    DrawThemeBackground(TabTheme, Canvas.Handle, iPartId, iStateId, R, nil);
    GetThemeBackgroundContentRect(TabTheme, Canvas.Handle, iPartId, iStateId, R,
      R);
    case FOwner.TabPosition of
      etpLeft:
        dec(R.Right, 1);
      etpRight:
        inc(R.Left, 1);
      etpTop:
        dec(R.Bottom, 1);
      etpBottom:
        inc(R.Bottom, 1);
    end;
  end
  else
  {$endif}
  begin
    if TabSheet = FOwner.FActivePage then
    begin
      Canvas.Pen.Color := IncColor(clBtnHighlight, 20, 20, 20);

      case FOwner.TabPosition of
        etpLeft:
          with Canvas do
          begin
            MoveTo(r.right - 1, r.top);
            LineTo(r.left, r.top);
            LineTo(r.left, r.bottom + 1);

            (* shadow *)
            if FOwner.Flat then
              Pen.Color := clBtnShadow
            else
              Pen.Color := cl3DDkShadow;
            MoveTo(r.left + 1, r.bottom);
            LineTo(r.right, r.bottom);
          end;
        etpTop:
          with Canvas do
          begin
            (* highlight *)
            MoveTo(r.left, r.bottom - 1);
            LineTo(r.left, r.top);
            LineTo(r.right, r.top);

            (* shadow *)
            if FOwner.Flat then
              Pen.Color := clBtnShadow
            else
              Pen.Color := cl3DDkShadow;
            MoveTo(r.right - 1, r.top + 1);
            LineTo(r.right - 1, r.bottom - 1);
          end;
        etpRight:
          with Canvas do
          begin
            MoveTo(r.left, r.top);
            LineTo(r.right, r.top);

            (* shadow *)
            if FOwner.Flat then
              Pen.Color := clBtnShadow
            else
              Pen.Color := cl3DDkShadow;
            LineTo(r.right, r.bottom + 1);
            MoveTo(r.left, r.bottom);
            LineTo(r.right, r.bottom);
          end;
        etpBottom:
          with Canvas do
          begin
            (* highlight *)

            MoveTo(r.left, r.top);
            LineTo(r.left, r.bottom + 1);

            (* shadow *)
            if FOwner.Flat then
              Pen.Color := clBtnShadow
            else
              Pen.Color := cl3DDkShadow;

            MoveTo(r.right, r.top);
            LineTo(r.right, r.bottom);
            LineTo(r.left, r.bottom);
          end;
      end;
    end;
    InflateRect(r, -1, -1);
  end;
end;

procedure TElNetTab.AdjustTabSize(var Size: TSize);
var
  R,
    R1: TRect;
  pid,
    sid: integer;
begin
  {$ifdef MSWINDOWS}
  if IsThemeApplied then
  begin
    pid := TABP_TOPTABITEM;
    sid := TIS_SELECTED;
    R := Rect(0, 0, Size.cx, Size.cy);
    GetThemeBackgroundContentRect(TabTheme, FOwner.Canvas.Handle,
      pid, sid, R, R1);
    if FOwner.TabPosition in [etpLeft, etpRight] then
    begin
      inc(Size.cy, (R1.Left - R.Left) + (R.Right - R1.Right));
      inc(Size.cx, (R1.Top - R.Top) + (R.Bottom - R1.Bottom));
    end
    else
    begin
      inc(Size.cx, (R1.Left - R.Left) + (R.Right - R1.Right));
      inc(Size.cy, (R1.Top - R.Top) + (R.Bottom - R1.Bottom));
    end;
  end
  else
  {$endif}
  begin
    inc(Size.cx, 4);
    inc(Size.cy, 4);
  end;
end;

function TElNetTab.GetInnerMargin: Integer;
begin
  Result := 3;
end;

procedure TElNetTab.DrawSpace(Canvas: TCanvas; var cx, cy: integer; mx, my:
  integer);
begin
  {$ifdef MSWINDOWS}
  if IsThemeApplied and (TabPosition = etpTop) then
  begin
    inherited;
  end
  else
  {$endif}
  begin
    case FOwner.TabPosition of
      etpTop:
        begin
          inc(cx, GetInnerMargin div 2);
          Canvas.Pen.Color := clBtnFace;
          Canvas.MoveTo(cx, cy);
          Canvas.LineTo(cx, cy + my - GetInnerMargin - 1);
          inc(cx, GetInnerMargin div 2);
        end;
      etpBottom:
        begin
          inc(cx, GetInnerMargin div 2);
          Canvas.Pen.Color := clBtnFace;
          Canvas.MoveTo(cx, cy + GetInnerMargin);
          Canvas.LineTo(cx, cy + my - 1);
          inc(cx, GetInnerMargin div 2);
        end;
      etpLeft:
        begin
          dec(cy, GetInnerMargin div 2);
          Canvas.Pen.Color := clBtnFace;
          Canvas.MoveTo(cx, cy);
          Canvas.LineTo(cx + mx - GetInnerMargin - 1, cy);
          dec(cy, GetInnerMargin div 2);
        end;
      etpRight:
        begin
          inc(cy, GetInnerMargin div 2);
          Canvas.Pen.Color := clBtnFace;
          Canvas.MoveTo(cx + GetInnerMargin, cy);
          Canvas.LineTo(cx + mx, cy);
          inc(cy, GetInnerMargin div 2);
        end;
    end;
  end;
end;

function TElNetTab.CanDrawTab(ActiveDraw: boolean): Boolean;
begin
  result := ActiveDraw;
end;

procedure TElNetTab.AdjustDrawingSize(Active: boolean; var R: TRect);
var
  FPageControl: TElCustomPageControl;
begin
  if Active then
  begin
    FPageControl := FOwner;
    case FPageControl.TabPosition of
      etpLeft:
        begin
          inc(R.Bottom);
          dec(R.Top);
        end;
      etpTop:
        begin
          dec(R.Left);
          inc(R.Right);
        end;
      etpRight:
        begin
          inc(R.Bottom);
          dec(R.Top);
        end;
      etpBottom:
        begin
          dec(R.Left);
          inc(R.Right);
        end;
    end;
  end;
end;

function TElNetTab.GetOuterMargin: Integer;
begin
  Result := 4;
end;

procedure TElNetTab.DrawTabLine(Canvas: TCanvas; R: TRect);
var
  ASheet: TElTabSheet;
  R1: TRect;
begin
  ASheet := FOwner.ActivePage;

  (*
  if IsThemeApplied then
  begin
    case FOwner.TabPosition of
      etpTop:
        begin
          R.Top := R.Bottom - 1;
          inc(R.Bottom, 2);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(ASheet.FRect.Left, R.Top, ASheet.FRect.Right, R.Bottom);
            with R1 do
              ExcludeCliprect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
      etpBottom:
        begin
          R.Bottom := R.Top + 1;
          dec(R.Top);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(ASheet.FRect.Left, R.Top, ASheet.FRect.Right, R.Bottom);
            with R1 do
              ExcludeCliprect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
      etpLeft:
        begin
          R.Left := R.Right - 2;
          //inc(R.Right);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(R.Left, ASheet.FRect.Top, R.Right, ASheet.FRect.Bottom);
            with R1 do
              ExcludeCliprect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
      etpRight:
        begin
          R.Right := R.Left + 2;
          dec(R.Left, 1);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(R.Left, ASheet.FRect.Top, R.Right, ASheet.FRect.Bottom);
            with R1 do
              ExcludeCliprect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
    end;
    DrawThemeBackground(TabTheme, Canvas.Handle, TABP_PANE, 0, R, nil);
    exit;
  end;
  *)

  {$ifdef MSWINDOWS}
  if IsThemeApplied then
  begin
    case FOwner.TabPosition of
      etpTop:
        begin
          R.Top := R.Bottom - 1;
          inc(R.Bottom, 2);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(ASheet.FRect.Left, R.Top, ASheet.FRect.Right, R.Bottom);
            // InflateRect(R1, 1, 0);

            with R1 do
              ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
      etpBottom:
        begin
          if FOwner.Flat then
            R.Bottom := R.Top + 1
          else
            R.Bottom := R.Top + 2;
          dec(R.Top);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(ASheet.FRect.Left, R.Top, ASheet.FRect.Right, R.Bottom);
            // InflateRect(R1, 1, 0);
            with R1 do
              ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
      etpLeft:
        begin
          R.Left := R.Right - 2;
          //inc(R.Right);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(R.Left, ASheet.FRect.Top, R.Right, ASheet.FRect.Bottom);
            InflateRect(R1, 0, 1);
            with R1 do
              ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
      etpRight:
        begin
          if FOwner.Flat then
            R.Right := R.Left + 1
          else
            R.Right := R.Left + 2;
          dec(R.Left, 1);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(R.Left, ASheet.FRect.Top, R.Right, ASheet.FRect.Bottom);
            InflateRect(R1, 0, 1);
            with R1 do
              ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
    end;
    DrawThemeBackground(TabTheme, Canvas.Handle, TABP_PANE, 0, R, nil);
    exit;
  end;
  {$endif}
  ASheet := FOwner.ActivePage;
  with Canvas do
    case FOwner.TabPosition of
      etpTop:
        begin
          Pen.Color := clBtnHighlight;
          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Bottom - 1);
            LineTo(R.Right, R.Bottom - 1);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              MoveTo(R.Left, R.Bottom - 1);
              LineTo(ASheet.FRect.Left, R.Bottom - 1);
            end;
            if ASheet.FRect.Right < R.Right then
            begin
              MoveTo(ASheet.FRect.Right, R.Bottom - 1);
              LineTo(R.Right, R.Bottom - 1);
            end;
          end;
        end;
      etpBottom:
        begin
          if not FOwner.Flat then
            Pen.Color := cl3DDkShadow
          else
            Pen.Color := clBtnShadow;
          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Top);
            LineTo(R.Right, R.Top);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              MoveTo(R.Left, R.Top);
              LineTo(ASheet.FRect.Left, R.Top);
            end;
            if ASheet.FRect.Right < R.Right then
            begin
              MoveTo(ASheet.FRect.Right + 1, R.Top);
              LineTo(R.Right, R.Top);
            end;
          end;
        end;
      etpLeft:
        begin
          Pen.Color := clBtnHighlight;
          Dec(R.Bottom);

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Right - 1, R.Top);
            LineTo(R.Right - 1, R.Bottom);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              MoveTo(R.Right - 1, R.Top);
              LineTo(R.Right - 1, ASheet.FRect.Top);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              MoveTo(R.Right - 1, ASheet.FRect.Bottom);
              LineTo(R.Right - 1, R.Bottom);
            end;
          end;
          if FOwner.ShowBorder then
          begin
            if not FOwner.Flat then
            begin
              Pixels[R.Right - 1, R.Bottom - 1] := clBtnShadow;
              Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
            end
            else
            begin
              Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
            end;
          end;
          inc(R.Bottom);
        end;
      etpRight:
        begin
          if not FOwner.Flat then
            Pen.Color := cl3DDkShadow
          else
            Pen.Color := clBtnShadow;

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Top);
            LineTo(R.Left, R.Bottom);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              MoveTo(R.Left, R.Top);
              LineTo(R.Left, ASheet.FRect.Top);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              MoveTo(R.Left, ASheet.FRect.Bottom + 1);
              LineTo(R.Left, R.Bottom);
            end;
          end;

        (*
        if FOwner.ShowBorder then
        begin
          Pixels[R.Right - 2, R.Top] := clBtnHighlight;
          Pixels[R.Right - 1, R.Top] := clBtnHighlight;
          if not FOwner.Flat then
          begin
            Pixels[R.Right - 2, R.Bottom] := cl3DDkShadow;
            Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
          end
          else
          begin
            Pixels[R.Right - 2, R.Bottom] := clBtnShadow;
            Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
          end;
        end;
        inc(R.Bottom);
        *)
        end;
    end;
end;

(*
begin
  with Canvas do
  case FOwner.TabPosition of
    etpTop:
      begin
        Pen.Color := clBtnHighlight;
        MoveTo(R.Left, R.Bottom - 1);
        LineTo(R.Right, R.Bottom - 1);
      end;
    etpBottom:
      begin
        if not FOwner.Flat then
          Pen.Color := cl3DDkShadow
        else
          Pen.Color := clBtnShadow;
        MoveTo(R.Left, R.Top);
        LineTo(R.Right, R.Top);
      end;
    etpLeft:
      begin
        Pen.Color := clBtnHighlight;
        Dec(R.Bottom);
        MoveTo(R.Right - 1, R.Top);
        LineTo(R.Right - 1, R.Bottom);
        if FOwner.ShowBorder then
        begin
          if not FOwner.Flat then
          begin
            Pixels[R.Right - 1, R.Bottom - 1] := clBtnShadow;
            Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
          end
          else
          begin
            Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
          end;
        end;
        inc(R.Bottom);
      end;
    etpRight:
      begin
        if not FOwner.Flat then
          Pen.Color := cl3DDkShadow
        else
          Pen.Color := clBtnShadow;
        MoveTo(R.Left, R.Top);
        LineTo(R.Left, R.Bottom);
      end;
  end;
end;
*)

function TElNetTab.GetAscend: Integer;
begin
  Result := 2;
end;

procedure TElNetTab.FillSpace(Canvas: TCanvas; Rect: TRect);
begin
  {$ifdef MSWINDOWS}
  if IsThemeApplied and (TabPosition = etpTop) then
  begin
    inherited;
  end
  else
  {$endif}
  begin
    Canvas.Brush.Color := FOwner.TabBkColorNetStyle;
    Canvas.FillRect(Rect);
  end;
end;

procedure TElNetTab.AdjustFillSize(After: boolean; var R: TRect; TabSheet:
  TElTabSheet);
begin
  inherited;
  if TabSheet = FOwner.FActivePage then
    case FOwner.TabPosition of
      etpTop:
        begin
          if After then
          begin
            dec(R.Right);
            dec(R.Bottom);
          end
          else
          begin
            inc(R.Right);
            inc(R.Bottom);
          end;
        end;
      etpBottom:
        begin
          if After then
          begin
            inc(R.Top, 2);
            dec(R.Bottom);
            dec(R.Right);
          end
          else
          begin
            dec(R.Top, 2);
            inc(R.Bottom);
            inc(R.Right);
          end;
        end;
      etpLeft:
        begin
          if After then
          begin
            dec(R.Right, 2);
            dec(R.Bottom);
          end
          else
          begin
            inc(R.Right, 2);
            inc(R.Bottom);
          end;
        end;
      etpRight:
        begin
          if After then
          begin
            inc(R.Left, 2);
            dec(R.Right);
            dec(R.Bottom);
          end
          else
            dec(R.Left, 2);
          inc(R.Right);
          inc(R.Bottom);
        end;
    end;
end;

procedure TElNetTab.FillTab(Canvas: TCanvas; Rect: TRect; TabSheet:
  TElTabSheet);
begin
  if TabSheet = FOwner.FActivePage then inherited;
end;

procedure TElNetTab.DrawButtons(Canvas: TCanvas; LeftRect, RightRect: TRect;
  CSL, CSR: boolean);
var
  PageControl: TElCustomPageControl;
  ColorRight,
    ColorLeft: TColor;
begin
  {$ifdef MSWINDOWS}
  if IsThemeApplied then
  begin
    inherited;
  end
  else
  {$endif}
  begin
    PageControl := FOwner;

    if CSL and (PageControl.FScrollBtnState in [pbsLeftBtnOver, pbsLeftBtnDown])
      then
      DrawButtonFrameEx3(Canvas.Handle, LeftRect, false,
        PageControl.FScrollBtnState = pbsLeftBtnDown, PageControl.Color,
          PageControl.Flat, AllBorderSides);
    if CSR and (PageControl.FScrollBtnState in [pbsRightBtnOver,
      pbsRightBtnDown]) then
      DrawButtonFrameEx3(Canvas.Handle, RightRect, false,
        PageControl.FScrollBtnState = pbsRightBtnDown, PageControl.Color,
          PageControl.Flat, AllBorderSides);

    if PageControl.FScrollBtnState = pbsLeftBtnDown then
      ColorLeft := clBtnHighlight
    else
      ColorLeft := cl3DDkShadow;
    if PageControl.FScrollBtnState = pbsRightBtnDown then
      ColorRight := clBtnHighlight
    else
      ColorRight := cl3DDkShadow;

    case PageControl.TabPosition of
      etpTop,
        etpBottom:
        begin
          ElVCLUtils.DrawArrow(Canvas, eadLeft, LeftRect, ColorLeft, csl);
          ElVCLUtils.DrawArrow(Canvas, eadRight, RightRect, ColorRight, csr);
        end;
      etpLeft:
        begin
          ElVCLUtils.DrawArrow(Canvas, eadDown, LeftRect, ColorLeft, csl);
          ElVCLUtils.DrawArrow(Canvas, eadUp, RightRect, ColorRight, csr);
        end;
      etpRight:
        begin
          ElVCLUtils.DrawArrow(Canvas, eadUp, LeftRect, ColorLeft, csl);
          ElVCLUtils.DrawArrow(Canvas, eadDown, RightRect, ColorRight, csr);
        end;
    end;
  end;
end;

{$ifdef MSWINDOWS}

function TElCustomPageControl.GetThemedClassName: WideString;
begin
  Result := 'TAB';
end;

procedure TElCustomPageControl.CreateThemeHandle;
begin
  inherited;
  if ThemesAvailable then
  begin
    FBtnTheme := OpenThemeData(Handle, PWideChar(WideString('BUTTON')));
    FScrollTheme := OpenThemeData(Handle, PWideChar(WideString('SPIN')));
    FCloseBtnTheme := OpenThemeData(Handle, PWideChar(WideString('WINDOW')));
  end
  else
  begin
    FBtnTheme := 0;
    FScrollTheme := 0;
    FCloseBtnTheme := 0;
  end;
end;

procedure TElCustomPageControl.FreeThemeHandle;
begin
  inherited;
  if ThemesAvailable then
  begin
    CloseThemeData(FBtnTheme);
    CloseThemeData(FScrollTheme);
    CloseThemeData(FCloseBtnTheme);
  end;
  FBtnTheme := 0;
  FScrollTheme := 0;
  FCloseBtnTheme := 0;
end;

{$endif}

procedure TElCustomPageControl.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  if FDoStartDrag = 1 then
    Message.Result := 1
  else
  begin
    with Message do
      if CursorWnd = Handle then
      begin
        GetCursorPos(P);
        p := ScreenToClient(p);
        if ShowTabs and (TabFromPoint(p) <> nil) then
        begin
          Windows.SetCursor(Screen.Cursors[TabCursor]);
          Message.Result := 1;
        end
        else
          inherited;
      end
      else
        inherited;
  end;
end;

type THackHintWindow = class(THintWindow) end;

procedure TElCustomPageControl.OnHintTimer(Sender: TObject);
var
  ASheet: TElTabSheet;
  R: TRect;
  P: TPoint;
  mx, my: integer;
  S: string;

  function GetCursorHeightMargin: Integer;
  var
    IconInfo: TIconInfo;
    BitmapInfoSize: DWORD;
    BitmapBitsSize: DWORD;
    Bitmap: PBitmapInfoHeader;
    Bits: Pointer;
    BytesPerScanline, ImageSize: DWORD;
  {$WARNINGS OFF}

    function FindScanline(Source: Pointer; MaxLen: Cardinal;
      Value: Cardinal): Cardinal; assembler;
    asm
                PUSH    ECX
                MOV     ECX,EDX
                MOV     EDX,EDI
                MOV     EDI,EAX
                POP     EAX
                REPE    SCASB
                MOV     EAX,ECX
                MOV     EDI,EDX
    end;

  begin
      { Default value is entire icon height }
    Result := GetSystemMetrics(SM_CYCURSOR);
    if GetIconInfo(GetCursor, IconInfo) then
    try
      GetDIBSizes(IconInfo.hbmMask, BitmapInfoSize, BitmapBitsSize);
      Bitmap := AllocMem(BitmapInfoSize + BitmapBitsSize);
      try
        Bits := Pointer(Longint(Bitmap) + BitmapInfoSize);
        if GetDIB(IconInfo.hbmMask, 0, Bitmap^, Bits^) and
          (Bitmap^.biBitCount = 1) then
        begin
            { Point Bits to the end of this bottom-up bitmap }
          with Bitmap^ do
          begin
            BytesPerScanline := ((biWidth * biBitCount + 31) and not 31) div 8;
            ImageSize := biWidth * BytesPerScanline;
            Bits := Pointer(Integer(Bits) + BitmapBitsSize - ImageSize);
              { Use the width to determine the height since another mask bitmap
                may immediately follow }
            Result := FindScanline(Bits, ImageSize, $FF);
              { In case the and mask is blank, look for an empty scanline in the
                xor mask. }
            if (Result = 0) and (biHeight >= 2 * biWidth) then
              Result := FindScanline(Pointer(Integer(Bits) - ImageSize),
                ImageSize, $00);
            Result := Result div BytesPerScanline;
          end;
          Dec(Result, IconInfo.yHotSpot);
        end;
      finally
        FreeMem(Bitmap, BitmapInfoSize + BitmapBitsSize);
      end;
    finally
      if IconInfo.hbmColor <> 0 then DeleteObject(IconInfo.hbmColor);
      if IconInfo.hbmMask <> 0 then DeleteObject(IconInfo.hbmMask);
    end;
  end;

  function GetHint(Control: TElTabSheet): string;
  var
    HintInfo: THintInfo;
    CanShow: Boolean;
  begin
    HintInfo.HintControl := Control;
    HintInfo.HintPos := P;
    Inc(HintInfo.HintPos.Y, GetCursorHeightMargin);
    HintInfo.HintMaxWidth := Screen.Width;
    HintInfo.HintColor := Application.HintColor;
    HintInfo.CursorRect := Control.BoundsRect;
    HintInfo.HintStr := GetShortHint(TElTabSheet(Control).GetInheritedHint);
    HintInfo.ReshowTimeout := 0;
    HintInfo.HideTimeout := Application.HintHidePause;
    HintInfo.HintWindowClass := HintWindowClass;
    HintInfo.HintData := nil;
    CanShow := Control.Perform(CM_HINTSHOW, 0, Longint(@HintInfo)) = 0;
    if CanShow and Assigned(Application.OnShowHint) then
      Application.OnShowHint(HintInfo.HintStr, CanShow, HintInfo);
    if CanShow and (HintInfo.HintStr <> '') then
    begin
      result := HintInfo.HintStr;
    end;
  end;

begin
  FHintTimer.Enabled := false;
  ASheet := TabFromPoint(FHintCoords);
  P := ClientToScreen(FHintCoords);

  if ASheet = nil then exit;
  S := GetHint(ASheet);
  if StrLen(PChar(S)) = 0 then
    exit;
  if FHintWnd = nil then
    FHintWnd := HintWindowClass.Create(Self);

  FHintWnd.
  Canvas.Font.Charset := Font.Charset;
{$IFDEF VCL_4_USED}
  mx := Screen.DesktopWidth + Screen.DesktopLeft;
  my := Screen.DesktopHeight + Screen.DesktopTop;
{$ELSE}
  mx := GetSystemMetrics(SM_CXSCREEN);
  my := GetSystemMetrics(SM_CYSCREEN);
{$ENDIF}

  R := FHintWnd.CalcHintRect(Screen.Width, S, nil);
  OffsetRect(R, P.X, P.Y + GetCursorHeightMargin);
{$IFDEF VCL_4_USED}
  if R.Left < Screen.DesktopLeft then
    OffsetRect(R, Screen.DesktopLeft - R.Left, 0);
  if R.Top < Screen.DesktopTop then
    OffsetRect(R, 0, Screen.DesktopTop - R.Top);
{$ELSE}
  if R.Left < 0 then OffsetRect(R, -R.Left, 0);
  if R.Top < 0 then OffsetRect(R, 0, -R.Top);
{$ENDIF}
  if R.Right > mx then OffsetRect(R, -(R.Right - mx), 0);
  if R.Bottom > my then OffsetRect(R, -(R.Bottom - my), 0);

  Application.HideHint;
  FHintWnd.Hide;
  FHintWnd.Color := Application.HintColor;
  FHintWnd.ActivateHint(R, S);
end;

procedure TElCustomPageControl.WMMouseMove(var Message: TMessage);
begin
  inherited;
  IntMouseMove(TWMMouseMove(Message).XPos, TWMMouseMove(Message).YPos);
end;

procedure TElCustomPageControl.WMIsThemedControl(var Message: TMessage);
begin
  Message.Result := Theme;
end;

procedure TElCustomPageControl.ELThemeChanged(var Message: TMessage);
begin
  if ThemesAvailable and UseXPThemes then
  begin
    FreeThemeHandle;
    CreateThemeHandle;
    SetWindowPos(
      Handle,
      0,
      0, 0, 0, 0,
      SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER
      );
    RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ERASE);
    Realign;
  end;
  Message.Result := 1;
end;

procedure TElCustomPageControl.SetSavvyMode(Value: Boolean);
var
  i: integer;
begin
  if FSavvyMode <> Value then
  begin
    FSavvyMode := Value;
    for i := 0 to PageCount - 1 do
      if FSavvyMode then
      begin
        if (Pages[i] <> ActivePage) and (Pages[i].HandleAllocated) then
          Pages[i].DestroyHandle;
      end
      else
      begin
        if (Pages[i] <> ActivePage) and (not Pages[i].HandleAllocated) then
          Pages[i].UpdateControlState;
      end;
  end;
end;

procedure TElCustomPageControl.SetFlatTabBorderColor(Value: TColor);
begin
  if FFlatTabBorderColor <> Value then
  begin
    FFlatTabBorderColor := Value;
    if Style = etsFlatTabs then
    begin
      if ShowTabs then
        UpdateTabs(false);
      if (ActivePage <> nil) and ActivePage.Visible then
        ActivePage.Invalidate;
    end;
  end;
end;

procedure TElCustomPageControl.SetTabBkColorNetStyle(Value: TColor);
begin
  if FTabBkColorNetStyle <> Value then
  begin
    FTabBkColorNetStyle := Value;
    if (Style = etsNetTabs) and ShowTabs then
      UpdateTabs(false);
  end;
end;

procedure TElCustomPageControl.SetVerticalSideCaptions(Value: Boolean);
begin
  if FVerticalSideCaptions <> Value then
  begin
    FVerticalSideCaptions := Value;
    RebuildTabs(true);
  end;
end;

{$IFDEF ELPACK_UNICODE}

procedure TElCustomPageControl.CMHintShow(var Message: TMessage);
var
  T: WideChar;
  HintInfo: PHintInfo;
  l: integer;
  S: string;
  WS: string;
begin
  inherited;
  HintInfo := PHintInfo(Message.lParam);
  if Length(FHint) = 0 then
  begin
    HintInfo.hintStr := '';
    exit;
  end;

  S := GetShortHint(inherited Hint);
  if HintInfo.HintStr = S then
  begin
    WS := GetShortHintW(FHint);
  end
  else
  begin
    S := FHint;
    WS := FHint;
  end;

  l := Length(S) + 1 + Length(WS) * 2;
  SetLength(HintInfo.HintStr, l + 4);
  Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);

  Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
  T := #0;
  Move(T, HintInfo.HintStr[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, HintInfo.HintStr[l + 3], sizeof(T));
end;

procedure TElCustomPageControl.SetHint(Value: TElFString);
var
  S: string;
  i,
    l: integer;
  T: WideChar;
begin
  FHint := Value;

  S := FHint;
  i := Length(S);
  l := Length(S) + 1 + Length(FHint) * 2;
  SetLength(S, l + 4);
  S[i + 1] := #0;

  Move(FHint[1], S[i + 2], Length(FHint) * 2);
  T := #0;
  Move(T, S[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, S[l + 3], sizeof(T));
  inherited Hint := S;
end;

{$ENDIF}

procedure TElCustomPageControl.SetActiveTabFont(Value: TFont);
begin
 FActiveTabFont.Assign(Value);
end;

procedure TElCustomPageControl.SetUseActiveTabFont(Value: Boolean);
begin
  if FUseActiveTabFont <> Value then
  begin
    FUseActiveTabFont := Value;
    if ShowTabs then
      UpdateTabs(true);
  end;
end;

procedure TElCustomPageControl.ActiveTabFontChange(Sender: TObject);
begin
  if (FActivePage <> nil) and UseActiveTabFont and ShowTabs then
    UpdateTabs(false);
end;

procedure TElCustomPageControl.TriggerDrawTabEvent(Canvas: TCanvas; Page: TElTabSheet;
  Rect: TRect;
  DrawStep: TElTabDrawState; var DefaultDrawing: boolean);
begin
  DefaultDrawing := true;
  if assigned(FOnDrawTab) then
    FOnDrawTab(Self, Canvas, Page, Rect, DrawStep, DefaultDrawing);
end;

procedure TElCustomPageControl.TriggerClosePageQueryEvent(Sheet: TElTabSheet; var
  CanClose: boolean);
begin
  if assigned(FOnClosePageQuery) then FOnClosePageQuery(Self, Sheet, CanClose);
end;

procedure TElCustomPageControl.ChangeScale(M, D: Integer);
begin
  inherited;
  if not ParentFont then
   Font.Size := MulDiv(Font.Size, M, D);
  ActiveTabFont.Size := MulDiv(ActiveTabFont.Size, M, D);
  HotTrackFont.Size := MulDiv(HotTrackFont.Size, M, D);
end;

procedure TElCustomPageControl.WndProc(var Message: TMessage);
type
  LPRECT = ^TRect;
  LPTTCItem = ^TTCItem;
var
  i: integer;
begin
  case Message.Msg of
    TCM_GETCURSEL:
      Message.Result := TabIndex;
    TCM_SETCURSEL:
      begin
        Message.Result := TabIndex;
        TabIndex := Message.WParam;
      end;
    TCM_ADJUSTRECT: //???
{
Calculates a tab control's display area given a window rectangle, or calculates the window rectangle
that would correspond to a specified display area. You can send this message explicitly or by using
the TabCtrl_AdjustRect macro.

TCM_ADJUSTRECT
    wParam = (WPARAM) (BOOL) fLarger;
    lParam = (LPARAM) (LPRECT) prc;

Parameters
fLarger
Operation to perform. If this parameter is TRUE, prc specifies a display rectangle and receives the
corresponding window rectangle. If this parameter is FALSE, prc specifies a window rectangle and
receives the corresponding display area.
prc
Address of a RECT structure that specifies the given rectangle and receives the calculated rectangle.
Return Values
No return value.

Remarks
This message applies only to tab controls that are at the top. It does not apply to tab controls
that are on the sides or bottom.
}
      begin
        Message.Result := 0;
        if Assigned(LPRECT(Message.LParam)) then
          with LPRECT(Message.LParam)^ do
            if Boolean(Message.WParam) then
            begin // ???
              Left := FTabsPos.X;
              Top := FTabsPos.Y;
              Right := FTabsSize.cx;
              Bottom := FTabsSize.cy;
            end
            else
            begin // ???
              Left := FTabsPos.X;
              Top := FTabsPos.Y;
              Right := FTabsSize.cx;
              Bottom := FTabsSize.cy;
            end;
      end;
    TCM_DELETEALLITEMS:
      begin
        try
          for i := FPages.Count - 1 downto 0 do
            TElTabSheet(FPages[i]).Free;
          Message.Result := Integer(True);
        except
          Message.Result := Integer(False);
        end;
      end;
    TCM_DELETEITEM:
      begin
        try
          i := Message.WParam;
          Message.Result := Integer((FPages.Count > 0) and (i >= 0) and (i <
            FPages.Count));
          if Boolean(Message.Result) then TElTabSheet(FPages[i]).Free;
        except
          Message.Result := Integer(False);
        end;
      end;
{$IFDEF D_4_UP}
    TCM_DESELECTALL:
      Message.Result := Message.WParam;
{$ENDIF}
    TCM_GETCURFOCUS: //??? (or TabFromPoint ... )
      Message.Result := TabIndex;
    TCM_SETCURFOCUS:
        {
        Remarks
        If the tab control has the TCS_BUTTONS style (button mode), the tab with the focus may be different
        from the selected tab. For example, when a tab is selected, the user can press the arrow keys to set
        the focus to a different tab without changing the selected tab. In button mode, TCM_SETCURFOCUS sets
        the input focus to the button associated with the specified tab, but it does not change the selected tab.
        }
      begin
        i := Message.WParam;
        if (FPages.Count > 0) and
          (i >= 0) and
          (i < FPages.Count) then
          TabIndex := i;
      end;
{$IFDEF D_4_UP}
    TCM_GETEXTENDEDSTYLE,
      TCM_SETEXTENDEDSTYLE: // TCS_EX_FLATSEPARATORS, TCS_EX_REGISTERDROP
      Message.Result := 0;
{$ENDIF}
    TCM_GETIMAGELIST:
      begin
        if Assigned(Images) then
          Message.Result := Images.Handle
        else
          Message.Result := 0;
      end;
    TCM_GETITEM:
      begin
        i := Message.WParam;
        Message.Result := Integer(
          (FPages.Count > 0) and
          (i >= 0) and
          (i < FPages.Count) and
          Assigned(LPTTCItem(Message.LParam))
          );
        if Boolean(Message.Result) then
        try
          with LPTTCItem(Message.LParam)^ do
          begin // ???
                {mask: UINT;
                dwState: UINT;
                dwStateMask: UINT;
                pszText: PAnsiChar;
                cchTextMax: Integer;
                iImage: Integer;
                lParam: LPARAM;}
            if (mask xor TCIF_TEXT) <> 0 then
              pszText := PAnsiChar(Pages[i].Caption);
            if (mask xor TCIF_IMAGE) <> 0 then
            begin
              iImage := Pages[i].ImageIndex;
              if iImage = -1 then
                TriggerGetImageEvent(Pages[i].PageIndex, iImage);
            end;
                // TCIF_PARAM unsuported
          end;
          Message.Result := Integer(True);
        except
          Message.Result := Integer(False);
        end;
      end;
    TCM_GETITEMCOUNT:
      Message.Result := PageCount;
    TCM_GETITEMRECT:
      begin
        try
          i := Message.WParam;
          Message.Result := Integer(
            (FPages.Count > 0) and
            (i >= 0) and
            (i < FPages.Count) and
            Assigned(LPRECT(Message.LParam))
            );
          if Boolean(Message.Result) then
            with LPRECT(Message.LParam)^ do
            begin //???
              Left := 0;
              Top := 0;
              Right := 0;
              Bottom := 0;
            end;
        except
          Message.Result := Integer(False);
        end;
      end;
    TCM_GETROWCOUNT: //???
      Message.Result := 0;
    TCM_GETTOOLTIPS:
      Message.Result := 0;
{$IFDEF D_4_UP}
    TCM_GETUNICODEFORMAT:
      Message.Result := 1;
    TCM_HIGHLIGHTITEM:
      Message.Result := 0;
{$ENDIF}
    TCM_HITTEST:
      Message.Result := TabIndex;
    TCM_INSERTITEM:
      begin
        with NewPage do
        begin
          i := Message.WParam;
          if PageIndex <> i then
            if (i >= 0) and
              (i < FPages.Count) then
              PageIndex := 1
            else
              PageIndex := FPages.Count - 1;
          Message.Result := PageIndex;
          if Assigned(LPTTCItem(Message.LParam)) then
            with LPTTCItem(Message.LParam)^ do
            begin
                   {
                      tagTCITEMA = packed record
                        mask: UINT;
                        dwState: UINT;
                        dwStateMask: UINT;
                        pszText: PAnsiChar;
                        cchTextMax: Integer;
                        iImage: Integer;
                        lParam: LPARAM;
                      end;
                   }
              if (mask xor TCIF_TEXT) <> 0 then
                Caption := StrPas(pszText);
              if (mask xor TCIF_IMAGE) <> 0 then
                ImageIndex := iImage;
                   // TCIF_PARAM unsuported
            end;
        end;
        Message.Result := TabIndex;
      end;
    TCM_REMOVEIMAGE:
      begin
        i := Message.WParam;
        if Assigned(Images) and (i >= 0) and (i < Images.Count) then
          Images.Delete(i);
      end;
    TCM_SETIMAGELIST:
      begin
        if Assigned(Images) then
        begin
          Message.Result := Images.Handle;
          Images.Handle := Message.LParam;
        end
        else
        begin
          Message.Result := 0;
          if Message.LParam <> 0 then
            with TImageList.Create(Self) do
              Handle := Message.LParam;
        end;
      end;
    TCM_SETITEM:
      begin
        i := Message.WParam;
        Message.Result := Integer(
          (FPages.Count > 0) and
          (i >= 0) and
          (i < FPages.Count) and
          Assigned(LPTTCItem(Message.LParam))
          );
        if Boolean(Message.Result) then
          with LPTTCItem(Message.LParam)^ do
          begin
            if (mask xor TCIF_TEXT) <> 0 then
              Pages[i].Caption := StrPas(pszText);
            if (mask xor TCIF_IMAGE) <> 0 then
              Pages[i].ImageIndex := iImage;
          end;
      end;
    TCM_SETITEMEXTRA: // no supported TabSheet user binary metadata
      Message.Result := Integer(False);
    TCM_SETITEMSIZE:
      begin
        Message.Result := MAKELPARAM(TabWidth, TabHeight);
        TabWidth := LoWord(Message.LParam);
        TabHeight := HiWord(Message.LParam);
      end;
{$IFDEF D_4_UP}
    TCM_SETMINTABWIDTH:
      begin
        Message.Result := MinTabWidth;
        MinTabWidth := Message.LParam;
      end;
{$ENDIF}
    TCM_SETPADDING: ;
    TCM_SETTOOLTIPS: ;
{$IFDEF D_4_UP}
    TCM_SETUNICODEFORMAT:
      Message.Result := 1;
{$ENDIF}
  else
    inherited;
  end;
end;

procedure TElCustomPageControl.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
  begin
    {$IFNDEF USE_SOUND_MAP}
      Filer.DefineProperty('ActivateSound', FakeValue, nil, false);
      Filer.DefineProperty('SoundMap', FakeValue, nil, false);
    {$ENDIF}
    {$IFNDEF ELPACK_USE_IMAGEFORM}
      Filer.DefineProperty('ImageForm', FakeValue, nil, false);
    {$ENDIF}
    Filer.DefineProperty('BorderWidth', FakeInteger, nil, false);
    Filer.DefineProperty('Caption', FakeStr, nil, false);
    Filer.DefineProperty('FirstTab', FakeStr, nil, false);
  end;
  Filer.DefineProperty('DrawFocus', ReadDrawFocus, nil, false);
end;

procedure TElCustomPageControl.SetCenterTabCaptions(Value: Boolean);
begin
  if FCenterTabCaptions <> Value then
  begin
    FCenterTabCaptions := Value;
    if ShowTabs then
      UpdateTabs(false);
  end;
end;

procedure TElCustomPageControl.BeginUpdate;
begin
  inc(FUpdateCount);
  (*
  if (FUpdateCount = 1) and HandleAllocated then
    SendMessage(Handle, WM_SETREDRAW, 0, 0);
  *)
end;

procedure TElCustomPageControl.EndUpdate;
begin
  dec(FUpdateCount);
  (*
  if (FUpdateCount = 0) and HandleAllocated then
  begin
    SendMessage(Handle, WM_SETREDRAW, 1, 0);
    Invalidate;
  end;
  *)
  if (FUpdateCount = 0) and (FUpdated > 0) then
  begin
    if FUpdated shr 16 = 2 then
    begin
      RebuildTabs(true);
      exit;
    end
    else
      if FUpdated shr 16 = 1 then
      RebuildTabs(false);

    if FUpdated and $0000FFFF = 1 then
      UpdateTabs(false)
    else
      if FUpdated and $0000FFFF = 2 then
      UpdateTabs(true);
  end;
end;

procedure TElCustomPageControl.ReadDrawFocus(Reader: TReader);
begin
  DrawFocusRect := Reader.ReadBoolean;
end;

{$IFNDEF VCL_4_USED}
procedure TElCustomPageControl.AlignControls(AControl: TControl; var Rect: TRect);
begin
  AdjustClientRect(Rect);
  inherited;
end;
{$ENDIF}

procedure TElCustomPageControl.AdjustClientRect(var Rect: TRect);
var
  ASize: TSize;
  EdgeSize: integer;
begin
  inherited;
  if ShowTabs then
  begin
    if (FTabsSize.cx = -1) and (FTabsSize.cy = -1) then
    begin
      ASize := CalcTabAreaSize;
      FTabsSize := ASize;
    end
    else
      ASize := FTabsSize;

    if {$ifdef MSWINDOWS}(not IsThemeApplied) and {$endif}((ShowBorder and (Style in [etsTabs, etsNetTabs,
      etsFlatTabs, etsAngledTabs])) and HasVisibleTabs) then
    begin
      begin
        {$ifdef MSWINDOWS}
        if TabPosition in [etpTop, etpBottom] then
          EdgeSize := GetSystemMetrics(SM_CXEDGE)
        else
          EdgeSize := GetSystemMetrics(SM_CYEDGE);
        {$else}
          EdgeSize := 2;
        {$endif}
      end;
    end
    else
    begin
      EdgeSize := 0;
    end;
    case TabPosition of
      etpTop:
        begin
          ASize.cy := min(ASize.cy, Rect.Bottom - Rect.Top);
          inc(Rect.Top, ASize.cy - EdgeSize);
          FTabsPos.x := 0;
          FTabsPos.y := 0;
        end;
      etpBottom:
        begin
          {if ASize.cy > 0 then
            inc(ASize.cy);
          } ASize.cy := min(ASize.cy, Rect.Bottom - Rect.Top);
          dec(Rect.Bottom, ASize.cy - EdgeSize);
          FTabsPos.x := 0;
          FTabsPos.y := Height - ASize.cy;
        end;
      etpRight:
        begin
          {if ASize.cx > 0 then
            inc(ASize.cx);
          }
          ASize.cx := min(ASize.cx, Rect.Right - Rect.Left);
          dec(Rect.Right, ASize.cx - EdgeSize);
          FTabsPos.x := Width - ASize.cx;
          FTabsPos.y := 0;
        end;
      etpLeft:
        begin
          ASize.cx := min(ASize.cx, Rect.Right - Rect.Left);
          inc(Rect.Left, ASize.cx - EdgeSize);

          FTabsPos.x := 0;
          FTabsPos.y := 0;
        end;
    end;
  end
  else
  begin
    FTabsSize.cx := 0;
    FTabsSize.cy := 0;
  end;
  if {$ifdef MSWINDOWS}(not IsThemeApplied) and {$endif}ShowBorder and (Style in [etsTabs, etsNetTabs,
    etsFlatTabs, etsAngledTabs]) then
   InflateRect(rect, {$ifdef MSWINDOWS}-GetSystemMetrics(SM_CXEDGE){$else}-2{$endif},
                     {$ifdef MSWINDOWS}-GetSystemMetrics(SM_CYEDGE){$else}-2{$endif});
end;

procedure TElCustomPageControl.IntMouseDown(XPos, YPos : integer);
var
  p: TPoint;
  TabSheet: TElTabSheet;
{$IFDEF VCL_4_USED}
  DockCtl: TControl;
{$ENDIF}

  procedure lpScrollLeft;
  begin
   if CanScrollLeft then
   begin
    ScrollBtnState := pbsLeftBtnDown;
    FirstTab := FindNextPage(FirstTab, false, true, false);
   end;
  end;

  procedure lpScrollRight;
  begin
   if CanScrollRight then
   begin
    ScrollBtnState := pbsRightBtnDown;
    FirstTab := FindNextPage(FirstTab, true, true, false);
   end;
  end;

begin
  if FDraggablePages then
  begin
    FDragPos := Point(XPos, YPos);
    FDoStartDrag := 0;
    // FDragTab := FActivePage;
    if FMultiLine then
      FDragTab := FActivePage;
  end;

  p := Point(XPos, YPos);

  // TabSheet := nil;

  if PtInRect(FScrollLeftRect, p) then
  begin
   if TabPosition = etpLeft then
    lpScrollRight
   else
    lpScrollLeft;
    exit;
  end
  else
  if PtInRect(FScrollRightRect, p) then
  begin
   if TabPosition = etpLeft then
    lpScrollLeft
   else
    lpScrollRight;
    exit;
  end
  else
  begin
    TabSheet := TabFromPoint(P);
    if TabSheet <> nil then
    begin
      DoTabSheetClick(TabSheet);
      if PtInRect(TabSheet.FCloseBtnRect, p) and TabSheet.CloseButtonVisible and
        TabSheet.CloseBtnEnabled and (not (csDesigning in ComponentState)) then
      begin
        TabSheet.FCloseBtnDown := true;
        UpdateTab(TabSheet);
{
        if Assigned(FOnClosePageQuery) then
          FOnClosePageQuery(Self, CanClose, TabSheet)
        else
          CanClose := true;
        if CanClose then RemovePage(TabSheet);
}
      end;
      if (Style in [etsFlatButtons, etsButtons, etsTabs, etsNetTabs,
       etsFlatTabs, etsAngledTabs]) then
      begin
        if ActivePage <> TabSheet then
          ActivePage := TabSheet
        {$IfDef Nemesis}
        ;
        (* Фокус передаётся самому верхнему (первому встреченному) компоненту,
           у которого нет Controls *)
        if not (csDesigning in ComponentState) then
         vtFocusWinControlEx(ActivePage, FFocusOnTabIfNotControls);
        {$Else}
        else
        if CanFocus and (not Focused) and TabStop then
          SetFocus;
        {$EndIf Nemesis}
      end
      else
      begin
        if (TabSheet.TabEnabled or (csDesigning in ComponentState)) then
        begin
          FDownTab := TabSheet;
          UpdateTabs(false);
        end;
      end;
    end;
  end;

{$IFDEF VCL_4_USED}
  if (Style in [etsTabs, etsNetTabs, etsFlatTabs, etsAngledTabs]) then
  begin
    DockCtl := GetDockClientFromMousePos(P);
    if (DockCtl <> nil) and FDragPageControl then
    begin
      DockCtl.BeginDrag(False);
      DoStartDragControl(DockCtl);
    end;
  end;
{$ENDIF}
  if FDraggablePages and (not FMultiLine) then
    FDragTab := FActivePage;

end;

procedure TElCustomPageControl.IntRButtonUp(XPos, YPos : integer);
var
  p : TPoint;
  TabSheet : TElTabSheet;
  Menu     : TPopupMenu;
begin
  (*
  if FSaveCapture <> 0 then
    SetCapture(FSaveCapture)
  else
    ReleaseCapture;
  FSaveCapture := 0;
  *)
  p := Point(XPos, YPos);
  //dec(p.x, Left);
  //dec(p.y, Top);
  if (not PtInRect(FScrollRightRect, p)) and (not PtInRect(FScrollLeftRect, p))
    then
  begin
    Menu := nil;
    TabSheet := TabFromPoint(P);
    if (TabSheet <> nil) then
    begin
      Menu := TabSheet.TabMenu;
      if Menu = nil then
        Menu := TabSheet.PopupMenu;
      if Menu <> nil then
        Menu.PopupComponent := TabSheet;
    end;
    if Menu = nil then
    begin
      Menu := PopupMenu;
      if Menu <> nil then
        Menu.PopupComponent := Self;
    end;
    if Menu <> nil then
    begin
      Inc(P.x, Left);
      inc(p.y, Top);
      P := Parent.ClientToScreen(p);
      Menu.Popup(p.X, p.Y);
    end;
  end;
end;


procedure TElCustomPageControl.IntLButtonUp(XPos, YPos : integer);
var
  p: TPoint;
  TabSheet, SwpPage: TElTabSheet;
  oldpos, newpos, i: integer;
  canclose: boolean;
begin
  {$ifdef MSWINDOWS}
  if FSaveCapture <> 0 then
    SetCapture(FSaveCapture)
  else
    ReleaseCapture;
  FSaveCapture := 0;
  {$endif}

  if (FTrackTab <> nil) and (FTrackTab = FDownTab) and (Style in [etsButtons,
    etsFlatButtons]) then
  begin
    if ActivePage <> FTrackTab then
      ActivePage := FTrackTab
    else
      if CanFocus and not Focused then
      SetFocus;
  end;
  FDownTab := nil;
  ScrollBtnState := pbsNone;

  p := Point(XPos, YPos);

  TabSheet := TabFromPoint(p);

  if (TabSheet <> nil) and TabSheet.FCloseBtnDown and
    PtInRect(TabSheet.FCloseBtnRect, p) then
  begin
    CanClose := true;
    TriggerClosePageQueryEvent(TabSheet, CanClose);
    if CanClose then
    begin
      RemovePage(TabSheet);
      TabSheet := nil;
    end
    else
    begin
      TabSheet.FCloseBtnDown := false;
      UpdateTab(TabSheet);
    end;
  end;

  if (FDraggablePages) and (FDoStartDrag = 1) and (TabSheet <> nil) then
  begin
{
    p.x := TWMNCMouseMove(Message).XCursor;
    p.y := TWMNCMouseMove(Message).YCursor;
    p := parent.ScreenToClient(p);
    dec(p.x, left);
    dec(p.y, top);
}
    if TabSheet <> FActivePage then
    begin
      oldpos := FDragTab.PageIndex;
(*
      if FMultiLine then
      begin
        FDragTab.PageIndex := TabSheet.PageIndex;
        TabSheet.PageIndex := oldpos;
        ActivePageIndex := {oldpos}FDragTab.PageIndex;
      end
      else
      begin
*)
      newpos := TabSheet.PageIndex;
      if oldpos < newpos then
      begin
        i := oldpos + 1;
        while (i <= newpos) do
        begin
          SwpPage := GetPages(i);
          SwpPage.PageIndex := i - 1;
          inc(i);
        end;
        dec(i);
      end
      else
      begin
        i := oldpos - 1;
        while (i >= newpos) do
        begin
          SwpPage := GetPages(i);
          SwpPage.PageIndex := i + 1;
          dec(i);
        end;
        inc(i);
      end;

      FDragTab.PageIndex := i;
      ActivePageIndex := i;
//      end;
      RebuildTabs(true);
    end;
  end;
  FDoStartDrag := -1;
  perform(WM_SETCURSOR, Handle, 0);
end;

procedure TElCustomPageControl.IntMouseMove(XPos, YPos : integer);
var
  p: TPoint;
  TabSheet: TElTabSheet;
begin
  p := Point(XPos, YPos);

  TabSheet := TabFromPoint(p);

  if (TabSheet <> nil) and TabSheet.FCloseBtnDown and not
    PtInRect(TabSheet.FCloseBtnRect, p) then
  begin
    TabSheet.FCloseBtnDown := false;
    UpdateTab(TabSheet);
  end;

  if (FDraggablePages) and (FDoStartDrag > -1) and ((FDragPos.x <> P.x) or (FDragPos.y <> P.y)) then
  begin
    if FDragTab = TabSheet then
    begin
      if FDoStartDrag = 0 then
      begin
        FDoStartDrag := 1;
        SetCursor(Screen.Cursors[DragCursor]);
      end;
    end
    else
      if FDoStartDrag = 0 then
      FDoStartDrag := -1;
  end;

  if (FHintCoords.x <> XPos) or
     (FHintCoords.y <> YPos) then
  begin
    if FHintWnd <> nil then
      ShowWindow(FhintWnd.Handle, SW_HIDE);
    FHintTimer.Enabled := false;
    if TabSheet <> nil then
    begin
      FHintCoords := Point(XPos, YPos);
      if ShowTabHints then
        FHintTimer.Enabled := true;
    end;
  end;
end;

procedure TElCustomPageControl.IntKeyDown(var Key : Word);
var
  Done: Boolean;
  tmp: TElTabSheet;
  tmpidx: integer;
begin
  if ShowTabs then
  begin
    if ((FTabPosition in [etpTop, etpBottom]) and (Key = VK_LEFT)) or
       ((FTabPosition in [etpLeft, etpRight]) and (Key = VK_UP)) then
    begin
      Done := False;
      tmpidx := ActivePageIndex;
      while (tmpidx > 0) and not Done do
      begin
        tmpidx := tmpidx - 1;
        tmp := Pages[tmpidx];
        Done := tmp.TabVisible and tmp.TabEnabled;
      end;
      if Done then
        ActivePageIndex := tmpidx;
      Key := 0;
    end;
    if ((FTabPosition in [etpTop, etpBottom]) and (Key = VK_RIGHT)) or
       ((FTabPosition in [etpLeft, etpRight]) and (Key = VK_DOWN)) then
    begin
      Done := False;
      tmpidx := ActivePageIndex;
      while (tmpidx < PageCount - 1) and not Done do
      begin
        tmpidx := tmpidx + 1;
        tmp := Pages[tmpidx];
        Done := tmp.TabVisible and tmp.TabEnabled;
      end;
      if Done then
        ActivePageIndex := tmpidx;
      Key := 0;
    end;
  end;
end;

procedure TElCustomPageControl.Realign;
var R : TRect;
//    i : integer;
begin
  if FActivePage <> nil then
  begin
   FTabsSize.cx := -1;
   FTabsSize.cy := -1;
   R := ClientRect;
   AdjustClientRect(R);
   FActivePage.BoundsRect := R;
  end;
// Изменяли размеры всем закладкам, не очень понятно зачем...
//  for i := 0 to PageCount - 1 do
//  begin
//    Pages[i].BoundsRect := R;
//  end;
end;

procedure TElCustomPageControl.RecalcTabPositions;
var HasVP : boolean;
    R     : TRect;
    TmpBmp: TBitmap;
    ASize : TSize;
    DC : HDC;

  function HasVisiblePages: boolean;
  var
    i: integer;
  begin
    result := true;
    for i := 0 to FPages.Count - 1 do
    begin
      if Pages[i].Visible then
        exit;
    end;
    result := false;
  end;

begin
  FRecalcTabPos := true;
  HasVP := HasVisiblePages;//HasVisibleTabs;
  if HasVP then
  begin
    if (FTabsSize.cx = -1) and (FTabsSize.cy = -1) then
    begin
      ASize := CalcTabAreaSize;
      FTabsSize := ASize;
    end
    else
      ASize := FTabsSize;

    case TabPosition of
      etpLeft: R := Rect(0, 0, ASize.cx, ASize.cy);
      etpRight: R := Rect(Width - ASize.cx, 0, Width, ASize.cy);
      etpTop: R := Rect(0, 0, ASize.cx, ASize.cy);
      etpBottom: R := Rect(0, Height - ASize.cy, ASize.cx, Height);
    end;
    TmpBmp := TBitmap.Create;
    TmpBmp.Width := R.Right - R.Left;
    TmpBmp.Height := R.Bottom - R.Top;
    DC := GetDC(Handle);
    TmpBmp.Handle := CreateCompatibleBitmap(DC, R.Right - R.Left, R.Bottom -
      R.Top);
    ReleaseDC(Handle, DC);
    DrawTabs(TmpBmp.Canvas, R, false, ASize);
    TmpBmp.Free;
  end;

  FRecalcTabPos := false;
end;

function TElCustomPageControl.CalcTabAreaSize: TSize;
var
  R: TRect;
begin
  if ShowTabs then
  begin
    R := BoundsRect;
    OffsetRect(R, -Left, -Top);
    Result.cx := 0;
    Result.cy := 0;
    DrawTabs(Canvas, R, false, Result);
  end
  else
  begin
    Result.cx := 0;
    Result.cy := 0;
  end;
end;

function TElCustomPageControl.GetTotalTabsWidth(ACanvas : TCanvas) : Integer;
 // Morozov
var
 l_Index     : Integer;
 l_Sheet     : TElTabSheet;
 l_SheetSize : TSize;
begin
 Result := 0;
 Inc(Result, FTab.GetOuterMargin * 2);
 for l_Index := 0 to Pred(FPages.Count) do
 begin
  l_Sheet := TElTabSheet(FPages[l_Index]);
  l_SheetSize := MeasureSheet(ACanvas, l_Sheet);
  case TabPosition of
   etpTop, etpBottom:
    Result := Result + l_SheetSize.cx + FTab.GetInnerMargin;
   etpLeft, etpRight:
    Result := Result + l_SheetSize.cy + FTab.GetInnerMargin;
  end;//case TabPosition of
 end;//for l_Index := 0 to Pred(FPages.Count) do
end;//GetTotalTabsWidth

procedure TElCustomPageControl.CheckFirstTab(ACanvas : TCanvas);
var
 l_TotalWidth : Integer;
 l_Compare    : Integer;
begin
 l_Compare := 0;
 if not Assigned(FFirstTab) or (Assigned(FFirstTab) and
   (FPages.IndexOf(FFirstTab) = 0)) then
  Exit;
 // Необходимый размер для размещения всех закладок без прокрутки
 l_TotalWidth := GetTotalTabsWidth(ACanvas);
 // Физический размер
 case TabPosition of
   etpTop, etpBottom:
    l_Compare := Self.Width;
   etpLeft, etpRight:
    l_Compare := Self.Height;
 end;
 // Уберем прокрутку, если закладки могут быть размещены полностью
 if l_TotalWidth <= l_Compare then
  FFirstTab := TElTabSheet(fPages.List^[0]);
end;

procedure TElCustomPageControl.DoDrawTabs(ACanvas: TCanvas; Rect: TRect; DoDraw:
    boolean; var Size: TSize);
var
  i, j: integer;
  SheetSize: TSize;
  sx, sy,
    cx, cy: integer;
  mx, my: integer;
  tx, ty: integer;
  TR: TRect;
  First,
    sf: boolean;
  curMargin: integer;
  ASheet,
    ASheet2: TElTabSheet;
  csl,
    csr: boolean;
  ScrollRect: TRect;
  bmp: TBitmap;
  brfl,
    dap: boolean;
  curRow: integer;
  b: boolean;
  {$ifndef MSWINDOWS}
  AVal : TSize;
  {$endif}
begin

  // Morozov
  CheckFirstTab(ACanvas);

  if FirstTab <> nil then
    j := FPages.IndexOf(FirstTab)
  else
    j := 0;
  sx := 0;
  sy := 0;

  if Multiline then
  begin
    // Multiline drawing
    SetRectEmpty(FScrollLeftRect);
    SetRectEmpty(FScrollRightRect);

    mx := 0;
    my := 0;
    tx := 0;
    ty := 0;
    curRow := 0;

    // first determine where the tabs will be located
    i := j;
    sf := true;
    First := true;
    brfl := false;
    if (FPages.Count > 0) then
    repeat
      ASheet := FPages[i];
      if (not sf) and (i = j) then break;
      sf := false;
      if ASheet.TabVisible then
      begin
        SheetSize := MeasureSheet(ACanvas, ASheet);
        if DoDraw or FRecalcTabPos then
          ASheet.FRect.BottomRight := TPoint(SheetSize);

        case TabPosition of
          etpTop,
            etpBottom:
            begin
              if not First then
                CurMargin := FTab.GetInnerMargin
              else
                CurMargin := 0;
              if brfl or (tx + SheetSize.cx + CurMargin > Width)
                then
              begin
              // go to new row
                inc(ty, my + FTab.GetRowMargin);
                mx := 0;
                inc(CurRow);
                if (tx + SheetSize.cx + CurMargin > Width) then
                begin
                  if First then
                  begin
                    SheetSize.cx := Width - FTab.GetOuterMargin * 2;
                    ASheet.FRect.Right := Width - FTab.GetOuterMargin * 2;
                  end;
                end;
                tx := FTab.GetOuterMargin;
                First := true;
              end
              else
              begin
                First := false;
              end;
              tx := tx + SheetSize.cx + CurMargin;
              my := Max(my, SheetSize.cy);
              if DoDraw or FRecalcTabPos then
                ASheet.FLine := CurRow;
            end;
          etpLeft,
            etpRight:
            begin
              if not First then
                CurMargin := FTab.GetInnerMargin
              else
                CurMargin := 0;
              if brfl or (ty + SheetSize.cy + CurMargin > Height) then
              begin
              // go to new row
                inc(tx, mx + FTab.GetRowMargin);
                my := 0;
                inc(CurRow);
                if (ty + SheetSize.cy + CurMargin > Height) then
                begin
                  if First then
                  begin
                    SheetSize.cy := Height - FTab.GetOuterMargin * 2;
                    ASheet.FRect.Bottom := Height - FTab.GetOuterMargin * 2;
                  end;
                end;
                ty := FTab.GetOuterMargin;
                First := true;
              end
              else
              begin
                First := false;
              end;
              ty := ty + SheetSize.cy + FTab.GetInnerMargin;
              mx := Max(mx, SheetSize.cx);
              if DoDraw or FRecalcTabPos then
                ASheet.FLine := CurRow;
            end;
        end;
        brfl := false;
      end;

    // increment counter
      inc(i);
      if i = FPages.Count then
      begin
        i := 0;
        brfl := true;
      end;
    until false;

    if (FPages.Count > 0) then
    begin
      case TabPosition of
        etpTop,
          etpBottom:
          begin
            inc(ty, FTab.GetAscend + my);
            if DoDraw or FRecalcTabPos then
              for i := 0 to FPages.Count - 1 do
              begin
                ASheet := FPages[i];
                if ASheet.TabVisible then
                  ASheet.FRect.Bottom := my;
              end;
          end;
        etpLeft,
          etpRight:
          begin
            inc(tx, FTab.GetAscend + mx);
            if DoDraw or FRecalcTabPos then
              for i := 0 to FPages.Count - 1 do
              begin
                ASheet := FPages[i];
                if ASheet.TabVisible then
                  ASheet.FRect.Right := mx;
              end;
          end;
      end;
    end;

    case TabPosition of
      etpTop,
        etpBottom:
        begin
          Size.cx := Width;
          Size.cy := ty;
        end;
      etpLeft,
        etpRight:
        begin
          Size.cy := Height;
          Size.cx := tx;
        end;
    end;

    // if we do not need painting, just return the size
    if not (DoDraw or FRecalcTabPos) then
    begin
      (*
      with PageControl do
        case TabPosition of
          etpTop,
            etpBottom:
            begin
              Size.cx := Width;
              Size.cy := ty;
            end;
          etpLeft,
            etpRight:
            begin
              Size.cy := Height;
              Size.cx := tx;
            end;
        end;
      *)
      exit;
    end;

    FLines := CurRow + 1;

    if (FPages.Count > 0) then
      if not RaggedRight then
        ReorderPages(CurRow + 1);

    if not DoDraw then exit;

    for i := 0 to FPages.Count - 1 do
    begin
      if TElTabSheet(FPages[i]).TabVisible then
      begin
        if TabPosition in [etpLeft, etpRight] then
        begin
          TElTabSheet(FPages[i]).FRect.Right :=
            TElTabSheet(FPages[i]).FRect.Left + mx;
        end
        else
        begin
          TElTabSheet(FPages[i]).FRect.Bottom :=
            TElTabSheet(FPages[i]).FRect.Top + my;
        end;
      end;
    end;

    ASheet2 := nil;

    // define "reference points" that are used during painting
      case TabPosition of
        etpTop:
          begin
            sx := 0;
            sy := 0;
            if (FPages.Count > 0) then
              inc(sy, FTab.GetAscend);
          end;
        etpBottom:
          begin
            sx := 0;
            sy := Height - my;
            if (FPages.Count > 0) then
              dec(sy, FTab.GetAscend);
          end;
        etpLeft:
          begin
            sx := 0;
            sy := 0;
            //OLD sy := Height - 1;

            if (FPages.Count > 0) then
              inc(sx, FTab.GetAscend);
          end;
        etpRight:
          begin
            sx := Width - mx;
            sy := 0;
            if (FPages.Count > 0) then
              dec(sx, FTab.GetAscend);
          end;
      end;

    cx := sx;
    cy := sy;

    // perform drawing
    i := j;
    sf := true;
    CurRow := -1;
    if (FPages.Count > 0) then
      repeat
        ASheet := FPages[i];
        if (not sf) and (i = j) then break;
        sf := false;
      // only draw visible tabs
        if ASheet.TabVisible then
        begin
        // if new row is started,
          if ASheet.FLine <> CurRow then
          begin
          // set start coords for the new page
          // First := true;
          // ASheet2 := nil;
            if CurRow >= 0 then
              case TabPosition of
                etpTop:
                  begin
                    cx := sx;
                    cy := cy + my + FTab.GetRowMargin;
                  end;
                etpBottom:
                  begin
                    cx := sx;
                    cy := cy - my - FTab.GetRowMargin;
                  end;
                etpLeft:
                  begin
                    cy := sy;
                    cx := cx + mx + FTab.GetRowMargin;
                  end;
                etpRight:
                  begin
                    cy := sy;
                    cx := cx - mx - FTab.GetRowMargin;
                  end;
              end;
            CurRow := ASheet.FLine;

            case TabPosition of
              etpTop,
                etpBottom:
                inc(cx, FTab.GetOuterMargin);
              etpLeft:
              //OLD dec(cy, FTab.GetOuterMargin);
                inc(cy, FTab.GetOuterMargin);
              etpRight:
                inc(cy, FTab.GetOuterMargin);
            end
          end
          else
          begin
            case TabPosition of
              etpTop,
                etpBottom:
                inc(cx, ASheet2.FRect.Right - ASheet2.FRect.Left);
              etpLeft:
              //OLD dec(cy, ASheet2.FRect.Bottom - ASheet2.FRect.Top);
                inc(cy, ASheet2.FRect.Bottom - ASheet2.FRect.Top);
              etpRight:
                inc(cy, ASheet2.FRect.Bottom - ASheet2.FRect.Top);
            end;
            if not FRecalcTabPos then
              FTab.DrawSpace(ACanvas, cx, cy, mx, my);
          end;

        //if FPageControl.TabPosition <> etpLeft then
          begin
          // define size for the tab
            TR.Left := cx;
            TR.Top := cy;
            TR.Right := cx + ASheet.FRect.Right;
            TR.Bottom := cy + ASheet.FRect.Bottom;
        {end
        else
        begin
          TR.Left  := cx;
          TR.Top   := cy - ASheet.FRect.Bottom - 1;
          TR.Right := cx + ASheet.FRect.Right;
          TR.Bottom:= cy;
        }
          end;

          ASheet.FRect := TR;
          FTab.AdjustDrawingSize(false, TR);
          ASheet.FComplete := true;

          if ((ASheet <> ActivePage) or FTab.CanDrawTab(false)) then
          begin
            FTab.Draw(ACanvas, TR, ASheet);
            ASheet.FShown := true;
          end;
          ASheet2 := ASheet;
        // First := false;
        end;

      // increment counter
        inc(i);
        if i = FPages.Count then
          i := 0;
      until false;

    ASheet := ActivePage;
    if (ASheet <> nil) and FTab.CanDrawTab(true) {and ASheet.FTabShowing} then
    begin
      TR := ASheet.FRect;
      FTab.AdjustDrawingSize(true, TR);
      ASheet.FComplete := true;
      FTab.Draw(ACanvas, TR, ASheet);
      ASheet.FShown := true;
    end;
    if not FRecalcTabPos then
      FTab.DrawTabLine(ACanvas, Rect);
  end
  else
  begin
    mx := 0;
    my := 0;
    tx := 0;
    ty := 0;

    // measure tabs
    for i := 0 to FPages.Count - 1 do
    begin
      ASheet := TElTabSheet(FPages[i]);
      if (not ASheet.TabVisible) then
        Continue;
      SheetSize := MeasureSheet(ACanvas, ASheet);

      mx := Max(mx, SheetSize.cx);
      my := Max(my, SheetSize.cy);
      // calculate total height/width
      case TabPosition of
        etpTop,
          etpBottom:
          tx := tx + SheetSize.cx + FTab.GetInnerMargin;
        etpLeft,
          etpRight:
          ty := ty + SheetSize.cy + FTab.GetInnerMargin;
      end;
      // possibly store the size of the sheet for further references
      if DoDraw or FRecalcTabPos then
        ASheet.FRect.BottomRight := TPoint(SheetSize);
    end;

    if (FPages.Count > 0) then
    begin
      case TabPosition of
        etpTop,
          etpBottom:
          begin
            if DoDraw or FRecalcTabPos then
              for i := 0 to FPages.Count - 1 do
              begin
                ASheet := FPages[i];
                if ASheet.TabVisible then
                  ASheet.FRect.Bottom := my;
              end;
          end;
        etpLeft,
          etpRight:
          begin
            if DoDraw or FRecalcTabPos then
              for i := 0 to FPages.Count - 1 do
              begin
                ASheet := FPages[i];
                if ASheet.TabVisible then
                  ASheet.FRect.Right := mx;
              end;
          end;
      end;
    end;

    case TabPosition of
      etpTop,
        etpBottom:
        begin
          Size.cx := Width;
          Size.cy := my;
          if ShowTabs and HasVisibleTabs then
            inc(Size.cy, FTab.GetAscend);
        end;
      etpLeft,
        etpRight:
        begin
          Size.cy := Height;
          Size.cx := mx;
          if ShowTabs and HasVisibleTabs then
            inc(Size.cx, FTab.GetAscend);
        end;
    end;

    // if drawing was not required, we just return the size of the tabs area
    if not (DoDraw or FRecalcTabPos) then exit;

    // add side margins
    if TabPosition in [etpLeft, etpRight] then
      inc(ty, FTab.GetOuterMargin * 2)
    else
      inc(tx, FTab.GetOuterMargin * 2);

    // now we define max bounds for the tabs
    case TabPosition of
      etpTop,
        etpBottom:
        mx := Width;
      etpLeft,
        etpRight:
        my := Height;
    end;

    case TabPosition of
      etpTop:
        begin
          sx := 0;
          sy := 0;
          {
          if (PageControl.FPages.Count > 0) then
            inc(sy, FTab.GetAscend);
          }
        end;
      etpBottom:
        begin
          sx := 0;
          sy := Height - my;
          if (FPages.Count > 0) then
            dec(sy, FTab.GetAscend);
        end;
      etpLeft:
        begin
          sx := 0;
          sy := 0;
          {
          if (PageControl.FPages.Count > 0) then
            inc(sx, FTab.GetAscend);
          }
        end;
      etpRight:
        begin
          sx := Width - mx;
          sy := 0;
          if (FPages.Count > 0) then
            dec(sx, FTab.GetAscend);
        end;
    end;

    cx := sx;
    cy := sy;

    if (FPages.Count > 0) then
    begin
      case TabPosition of
        etpTop:
          inc(cy, FTab.GetAscend);
        etpLeft:
          inc(cx, FTab.GetAscend);
      end;
    end;

    ASheet2 := nil;
    // ASheet := nil;
    First := true;
    dap := false;
    {$ifndef MSWINDOWS}
    QStyle_scrollBarExtent(Application.Style.Handle, @AVal);
    {$endif}
    // copy background to be drawn for arrows
    case TabPosition of
      etpTop,
        etpBottom:
        begin
          FScrollLeftRect :=
            Classes.Rect(Rect.Right - 2 * {$ifdef MSWINDOWS}GetSystemMetrics(SM_CXHSCROLL){$else}AVal.cx{$endif},
              Rect.Top + Margin,
            Rect.Right - {$ifdef MSWINDOWS}GetSystemMetrics(SM_CXHSCROLL){$else}AVal.cx{$endif}, Rect.Top + Margin +
              {$ifdef MSWINDOWS}GetSystemMetrics(SM_CYHSCROLL){$else}AVal.cy{$endif});
          FScrollRightRect :=
            Classes.Rect(Rect.Right - {$ifdef MSWINDOWS}GetSystemMetrics(SM_CXHSCROLL){$else}AVal.cx{$endif}, Rect.Top +
              Margin,
            Rect.Right, Rect.Top + Margin + {$ifdef MSWINDOWS}GetSystemMetrics(SM_CYHSCROLL){$else}AVal.cy{$endif});
          ScrollRect :=
            Classes.Rect(Rect.Right - 2 * {$ifdef MSWINDOWS}GetSystemMetrics(SM_CXHSCROLL){$else}AVal.cx{$endif},
              Rect.Top + Margin,
            Rect.Right, Rect.Top + Margin + {$ifdef MSWINDOWS}GetSystemMetrics(SM_CYHSCROLL){$else}AVal.cy{$endif});
        end;
      etpLeft:
        begin
          FScrollRightRect :=
            Classes.Rect(Rect.Left + Margin, Rect.Bottom - 2 *
              {$ifdef MSWINDOWS}GetSystemMetrics(SM_CYVSCROLL){$else}AVal.cy{$endif},
            Rect.Left + Margin + {$ifdef MSWINDOWS}GetSystemMetrics(SM_CXVSCROLL){$else}AVal.cx{$endif}, Rect.Bottom -
              {$ifdef MSWINDOWS}GetSystemMetrics(SM_CYVSCROLL){$else}AVal.cy{$endif});
          FScrollLeftRect :=
            Classes.Rect(Rect.Left + Margin, Rect.Bottom -
              {$ifdef MSWINDOWS}GetSystemMetrics(SM_CYVSCROLL){$else}AVal.cy{$endif},
            Rect.Left + Margin + {$ifdef MSWINDOWS}GetSystemMetrics(SM_CXVSCROLL){$else}AVal.cx{$endif}, Rect.Bottom);
          ScrollRect :=
            Classes.Rect(Rect.Left + Margin, Rect.Bottom - 2 *
              {$ifdef MSWINDOWS}GetSystemMetrics(SM_CYVSCROLL){$else}AVal.cy{$endif},
            Rect.Left + Margin + {$ifdef MSWINDOWS}GetSystemMetrics(SM_CXVSCROLL){$else}AVal.cx{$endif}, Rect.Bottom);
        end;
      etpRight:
        begin
          FScrollLeftRect :=
            Classes.Rect(Rect.Left + Margin, Rect.Bottom - 2 *
              {$ifdef MSWINDOWS}GetSystemMetrics(SM_CYVSCROLL){$else}AVal.cy{$endif},
            Rect.Left + Margin + {$ifdef MSWINDOWS}GetSystemMetrics(SM_CXVSCROLL){$else}AVal.cx{$endif}, Rect.Bottom -
              {$ifdef MSWINDOWS}GetSystemMetrics(SM_CYVSCROLL){$else}AVal.cy{$endif});
          FScrollRightRect :=
            Classes.Rect(Rect.Left + Margin, Rect.Bottom -
              {$ifdef MSWINDOWS}GetSystemMetrics(SM_CYVSCROLL){$else}AVal.cy{$endif},
            Rect.Left + Margin + {$ifdef MSWINDOWS}GetSystemMetrics(SM_CXVSCROLL){$else}AVal.cx{$endif}, Rect.Bottom);
          ScrollRect :=
            Classes.Rect(Rect.Left + Margin, Rect.Bottom - 2 *
              {$ifdef MSWINDOWS}GetSystemMetrics(SM_CYVSCROLL){$else}AVal.cy{$endif},
            Rect.Left + Margin + {$ifdef MSWINDOWS}GetSystemMetrics(SM_CXVSCROLL){$else}AVal.cx{$endif}, Rect.Bottom);
        end;
    end;
    Bmp := nil;
    if not FRecalcTabPos then
    begin
      Bmp := TBitmap.Create;
      Bmp.Width := ScrollRect.Right - ScrollRect.Left;
      Bmp.Height := ScrollRect.Bottom - ScrollRect.Top;
      Bmp.Canvas.CopyRect(Classes.Rect(0, 0, Bmp.Width, Bmp.Height), ACanvas,
        ScrollRect);
    end;

    ASheet := nil;

    // draw tabs one by one
    for i := j to FPages.Count - 1 do
    begin
      if (not TElTabSheet(FPages[i]).TabVisible) then Continue;
      ASheet := TElTabSheet(FPages[i]);

      (*
      sx := cx;
      sy := cy;
      *)
      case TabPosition of
        etpTop,
          etpBottom:
          if cx > mx then break;
        etpLeft:
          //OLD if cy < 0 then break;
          if cy > my then break;
        etpRight:
          if cy > my then break;
      end;
      // for tabs make an offset for the first tab
      if First then
        case TabPosition of
          etpTop,
            etpBottom:
            inc(cx, FTab.GetOuterMargin);
          etpLeft:
            //OLD dec(cy, FTab.GetOuterMargin);
            inc(cy, FTab.GetOuterMargin);
          etpRight:
            inc(cy, FTab.GetOuterMargin);
        end
      else
      begin
        case TabPosition of
          etpTop,
            etpBottom:
            inc(cx, ASheet2.FRect.Right - ASheet2.FRect.Left);
          etpLeft:
            //OLD dec(cy, ASheet2.FRect.Bottom - ASheet2.FRect.Top);
            inc(cy, ASheet2.FRect.Bottom - ASheet2.FRect.Top);
          etpRight:
            inc(cy, ASheet2.FRect.Bottom - ASheet2.FRect.Top);
        end;
        if not FRecalcTabPos then
          FTab.DrawSpace(ACanvas, cx, cy, mx, my);
      end;

      // if TabPosition <> etpLeft then
      begin
        // define size for the tab
        TR.Left := cx;
        TR.Top := cy;
        TR.Right := cx + ASheet.FRect.Right;
        TR.Bottom := cy + ASheet.FRect.Bottom;
      end;

      ASheet.FRect := TR;
      FTab.AdjustDrawingSize(false, TR);
      case TabPosition of
        etpTop,
          etpBottom:
          begin
            b := CanScrollLeft or (TR.Right > mx);
            if b then
            begin
              if (TR.Right <= ScrollRect.Left) then
                ASheet.FComplete := true;
            end
            else
              if (TR.Right <= mx) then
              ASheet.FComplete := true;
          end;
        etpLeft:
          begin
            b := CanScrollLeft or (TR.Bottom > my);
            if b then
            begin
              if (TR.Bottom <= ScrollRect.Bottom) then
                ASheet.FComplete := true;
            end
            else
              if (TR.Bottom <= my) then
              ASheet.FComplete := true;
          end;
        etpRight:
          begin
            b := CanScrollLeft or (TR.Bottom > my);
            if b then
            begin
              if (TR.Bottom <= ScrollRect.Bottom) then
                ASheet.FComplete := true;
            end
            else
              if (TR.Bottom <= my) then
              ASheet.FComplete := true;
          end;
      end;

      if (ASheet = ActivePage) then dap := true;
      if ((ASheet <> ActivePage) or FTab.CanDrawTab(false)) then
      begin
        if not FRecalcTabPos then
          FTab.Draw(ACanvas, TR, ASheet);
        ASheet.FShown := true;
      end;
      ASheet2 := ASheet;
      First := false;
    end;

    if ASheet <> nil then
    begin
      case TabPosition of
        etpTop,
          etpBottom:
          if (tx > Width) and
            (ASheet.FRect.Right > Width - FTab.GetOuterMargin)
              then
            ASheet.FComplete := false;
        etpLeft,
          etpRight:
          if (ty > Height) and
            (ASheet.FRect.Bottom > Height - FTab.GetOuterMargin)
              then
            ASheet.FComplete := false;
      end;
    end;

    // draw ActivePage if we are in Tabs style
    ASheet := ActivePage;
    if (ASheet <> nil) and FTab.CanDrawTab(true) and ASheet.FTabShowing and dap
      then
    begin
      TR := ASheet.FRect;
      FTab.AdjustDrawingSize(true, TR);
      case TabPosition of
        etpTop,
          etpBottom:
          begin
            b := CanScrollLeft or (TR.Right > mx);
            if b then
            begin
              if (TR.Right <= ScrollRect.Left) then
                ASheet.FComplete := true;
            end
            else
              if (TR.Right <= mx) then
              ASheet.FComplete := true;
          end;
        etpLeft:
          begin
            b := CanScrollLeft or (TR.Bottom > my);
            if b then
            begin
              if (TR.Bottom <= ScrollRect.Bottom) then
                ASheet.FComplete := true;
            end
            else
              if (TR.Bottom <= my) then
              ASheet.FComplete := true;
          end;
        etpRight:
          begin
            b := CanScrollLeft or (TR.Bottom > my);
            if b then
            begin
              if (TR.Bottom <= ScrollRect.Bottom) then
                ASheet.FComplete := true;
            end
            else
              if (TR.Bottom <= my) then
              ASheet.FComplete := true;
          end;
      end;

      if not FRecalcTabPos then
        FTab.Draw(ACanvas, TR, ASheet);
      ASheet.FShown := true;
      ASheet.FRect := TR;
    end;

    if not FRecalcTabPos then
      FTab.DrawTabLine(ACanvas, Rect);

    if TabPosition = etpLeft then
     csl := CanScrollRight
    else
     csl := CanScrollLeft;
    if TabPosition = etpLeft then
     csr := CanScrollLeft
    else
     csr := CanScrollRight;
    if csl or csr then
    begin
      if not FRecalcTabPos then
      begin
        ACanvas.CopyRect(ScrollRect, Bmp.Canvas, Classes.Rect(0, 0, Bmp.Width,
          Bmp.Height));
        FTab.DrawButtons(ACanvas, FScrollLeftRect,
          FScrollRightRect, csl, csr);
      end;
    end
    else
    begin
      SetRectEmpty(FScrollLeftRect);
      SetRectEmpty(FScrollRightRect);
    end;
    if not FRecalcTabPos then Bmp.Free;
  end;
end;

procedure TElCustomPageControl.DrawTabs(ACanvas: TCanvas; R: TRect; DoDraw: boolean;
    var Size: TSize);
var
  i: integer;
  ASheet: TElTabSheet;
{$IFDEF ELPACK_USE_IMAGEFORM}
  BgRect: TRect;
  ACtl: TWinControl;
{$ENDIF}

begin
  if DoDraw then
{$IFDEF ELPACK_USE_IMAGEFORM}
    if not IsThemeApplied and (FImgForm <> nil) and (not
      (csDesigning in ComponentState)) then
    begin
      if (FImgForm.Control <> Self) then
      begin
        ACtl := FImgForm.GetRealControl;

        BgRect.Left := Left;
        BgRect.Top := Top;

        BgRect.TopLeft := Parent.ClientToScreen(BgRect.TopLeft);
        BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
      end
      else
        BgRect.TopLeft := R.TopLeft;

      FImgForm.PaintBkgnd(ACanvas.Handle, R, BgRect.TopLeft,
        false);
    end
    else
{$ENDIF}
      FTab.FillSpace(ACanvas, R);

  if DoDraw or FRecalcTabPos then
  begin
    FLines := 0;

    for i := 0 to FPages.Count - 1 do
    begin
      ASheet := TElTabSheet(FPages[i]);
      SetRectEmpty(ASheet.FRect);
      ASheet.FLine := -1;
      ASheet.FComplete := false;
      ASheet.FShown := false;
    end;
  end;
  DoDrawTabs(ACanvas, R, DoDraw, Size);
end;

function TElCustomPageControl.GetBtnTheme: HTheme;
begin
  Result := FBtnTheme;
end;

function TElCustomPageControl.GetRotatedFont(Canvas: TCanvas; RotationAngle:
    integer): HFont;
var
  LogFont: TLogFont;
begin
  GetObject(Canvas.Font.Handle, SizeOf(LogFont), @LogFont);
  with LogFont do
  begin
    if (RotationAngle <> lfEscapement) and (FVerticalSideCaptions)
      then
    begin
      if RotationAngle = 0 then
        lfOutPrecision := OUT_DEFAULT_PRECIS
      else
        lfOutPrecision := OUT_TT_ONLY_PRECIS;
      lfEscapement := RotationAngle;
      lfOrientation := lfEscapement;
    end;
  end;
  Result := CreateFontIndirect(LogFont);
end;

function TElCustomPageControl.GetScrollTheme: HTheme;
begin
  Result := ScrollTheme;
end;

function TElCustomPageControl.GetTabTheme: HTheme;
begin
  Result := Theme;
end;

function TElCustomPageControl.MeasureSheet(ACanvas: TCanvas; Sheet: TElTabSheet):
    TSize;
var
  AFont: HFont;
  R,
    R1: TRect;
  t, i: integer;
{$IFDEF VCL_4_USED}
  TM: tagTextMetricA;
{$ELSE}
  TM: TTextMetricA;
{$ENDIF}
  pid,
    sid: integer;
  ATheme: HTheme;
  ACaption,
    TCaption: TElFString;
  P: PElFChar;
  imidx: integer;
begin
  begin
    TriggerMeasureTabEvent(ACanvas, Sheet, result);
    if (Result.cx = 0) and (Result.cy = 0) then
    begin
      if (FActivePage = Sheet) and (UseActiveTabFont) then
        ACanvas.Font.Assign(ActiveTabFont)
      else
        if HotTrack and (FTrackTab = Sheet) then
        ACanvas.Font.Assign(HotTrackFont)
      else
        if (not Sheet.ParentFont) and Sheet.UseFontForTabs then
        ACanvas.Font.Assign(Sheet.Font)
      else
        ACanvas.Font.Assign(Font);

      case TabPosition of
        etpLeft:
          AFont := GetRotatedFont(ACanvas, 900);
        etpRight:
          AFont := GetRotatedFont(ACanvas, -900);
      else
        AFont := GetRotatedFont(ACanvas, 0);
      end;
      ACanvas.Font.Handle := AFont;
      R.Left := 0;
      R.Top := 0;
      R.Right := 0;
      R.Bottom := 0;
      if Length(Sheet.Caption) = 0 then
      begin
{$IFDEF ELPACK_UNICODE}
        GetTextMetrics(ACanvas.Handle, TM);
{$ELSE}
        GetTextMetrics(ACanvas.Handle, TM);
{$ENDIF}
        t := Abs(TM.tmHeight);
        if (TabPosition in [etpLeft, etpRight]) and VerticalSideCaptions then
        begin
          Result.cx := t;
          Result.cy := Max(10, MinTabHeight);
        end
        else
        begin
          Result.cy := t;
          Result.cx := Max(10, MinTabWidth);
        end;
        if (FImages <> nil) and ShowImages then
          case TabPosition of
            etpTop,
              etpBottom:
              begin
                Inc(Result.cx, FImages.Width + Margin);
                if (Result.cy < FImages.Height) then
                  Result.cy := FImages.Height;
              end;
            etpLeft,
              etpRight:
              begin
                if VerticalSideCaptions then
                begin
                  Inc(Result.cy, FImages.Height + Margin);
                  if (Result.cx < FImages.Width) then
                    Result.cx := FImages.Width;
                end
                else
                begin
                  Inc(Result.cx, FImages.Width + Margin);
                  if (Result.cy < FImages.Height) then
                    Result.cy := FImages.Height;
                end;
              end;
          end;
      end
      else
        with ACanvas do
        begin
          ACaption := Sheet.Caption;

          {$ifdef MSWINDOWS}
          if IsThemeApplied then
          begin
            if (FTab is TElStdTab) or (FTab is TElNetTab) or (FTab is
              TEl2DFlatTab) then
            begin
              pid := TABP_TABITEM;
              if not Sheet.Enabled then
                sid := TIS_DISABLED
              else
                if Sheet = FActivePage then
              begin
                pid := TABP_TOPTABITEM;
                sid := TTIS_SELECTED;
              end
              else
              begin
                pid := TABP_TABITEM;
                if Sheet = FTrackTab then
                begin
                  sid := TIS_HOT;
                end
                else
                begin
                  if Sheet = FDownTab then
                  begin
                    sid := TIS_FOCUSED;
                  end
                  else
                  begin
                    sid := TIS_NORMAL;
                  end;
                end;
              end;
            //pid := TABP_TOPTABITEM;
            //sid := TTIS_SELECTED;
            end
            else
            begin
              pid := BP_PUSHBUTTON;
              if Sheet.Enabled then
              begin
                if Sheet = FActivePage then
                begin
                  sid := PBS_PRESSED;
                end
                else
                begin
                  if Sheet = FTrackTab then
                  begin
                    sid := PBS_HOT;
                  end
                  else
                  begin
                    if Sheet = FDownTab then
                    begin
                      sid := PBS_PRESSED;
                    end
                    else
                    begin
                      sid := PBS_NORMAL;
                    end;
                  end;
                end;
              end
              else
              begin
                sid := PBS_DISABLED;
              end;
            end;
            if (FTab is TElStdTab) or (FTab is TElNetTab) or (FTab is
              TEl2DFlatTab) then
              ATheme := TabTheme
            else
              ATheme := BtnTheme;
{$IFDEF ELPACK_UNICODE}
            if WidePos(ElFCRLF, ACaption) > 0 then
              ElVCLUtils.DrawTextW(Handle, PWideChar(WideString(ACaption)),
                Length(ACaption), R, DT_CALCRECT)
{$ELSE}
            if Pos(ElFCRLF, ACaption) > 0 then
              DrawText(Handle, PChar(ACaption), Length(ACaption), R, DT_CALCRECT)
{$ENDIF}
            else
            begin
              GetThemeTextExtent(ATheme, Handle, pid, sid,
                PWideChar(WideString(ACaption)), Length(ACaption), DT_LEFT, nil,
                R);
            end;
            Result.cx := R.Right - R.Left;
            Result.cy := R.Bottom - R.Top;
            if (TabPosition in [etpLeft, etpRight]) and VerticalSideCaptions
              then
            begin
              i := Result.cx;
              Result.cx := Result.cy;
              Result.cy := i;
            end;
            if (FImages <> nil) and ShowImages then
              case TabPosition of
                etpTop,
                  etpBottom:
                  begin
                    Inc(Result.cx, FImages.Width + Margin);
                    if (Result.cy < FImages.Height) then
                      Result.cy := FImages.Height;
                  end;
                etpLeft,
                  etpRight:
                  begin
                    if VerticalSideCaptions then
                    begin
                      Inc(Result.cy, FImages.Height + Margin);
                      if (Result.cx < FImages.Width) then
                        Result.cx := FImages.Width;
                    end
                    else
                    begin
                      Inc(Result.cx, FImages.Width + Margin);
                      if (Result.cy < FImages.Height) then
                        Result.cy := FImages.Height;
                    end;
                  end;
              end;
            if (not (FTab is TElFlatBtnTab)) or (sid <> PBS_NORMAL) then
            begin
            // GetThemeBackgroundExtent(ATheme, Handle, pid, sid, @R, R1);
              GetThemeBackgroundContentRect(ATheme, Handle, pid, sid, R, R1);
              if (TabPosition in [etpLeft, etpRight]) and VerticalSideCaptions
                then
              begin
                inc(Result.cy, (R1.Left - R.Left) + (R.Right - R1.Right));
                inc(Result.cx, (R1.Top - R.Top) + (R.Bottom - R1.Bottom));
              end
              else
              begin
                inc(Result.cx, (R1.Left - R.Left) + (R.Right - R1.Right));
                inc(Result.cy, (R1.Top - R.Top) + (R.Bottom - R1.Bottom));
              end;
            end;
          end
          else
          {$endif}
          begin
            if (not (TabPosition in [etpLeft, etpRight])) or (not VerticalSideCaptions) then
            begin
              TCaption := '';
              P := PElFChar(ACaption);
              while P^ <> #0 do
              begin
                if P^ <> '&' then
                begin
                  TCaption := TCaption + P^;
                  inc(p);
                end
                else
                begin
                  inc(p);
                  if P^ = #0 then
                    break
                  else
                    TCaption := TCaption + P^;
                  inc(p);
                end;
              end;
              ACaption := TCaption;
            end;

{$IFDEF ELPACK_UNICODE}
            if WidePos(ElFCRLF, ACaption) > 0 then
            begin
              ElVCLUtils.DrawTextW(Handle, PWideChar(WideString(ACaption)),
                Length(ACaption), R, DT_CALCRECT);
              Result.cx := R.Right - R.Left;
              Result.cy := R.Bottom - R.Top;
            end
            else
              GetTextExtentPoint32W(Handle, PWideChar(ACaption),
                Length(ACaption), Result);
{$ELSE}
            if Pos(ElFCRLF, ACaption) > 0 then
            begin
              DrawText(Handle, PChar(string(ACaption)), Length(ACaption), R,
                DT_CALCRECT);
              Result.cx := R.Right - R.Left;
              Result.cy := R.Bottom - R.Top;
            end
            else
              GetTextExtentPoint32(Handle, PChar(ACaption), Length(ACaption),
                Result);
{$ENDIF}
            if (TabPosition in [etpLeft, etpRight]) and VerticalSideCaptions then
            begin
              i := Result.cx;
              Result.cx := Result.cy;
              Result.cy := i;
            end;

            imidx := Sheet.ImageIndex;
            if imidx = -1 then
              TriggerGetImageEvent(Sheet.PageIndex, imidx);
            if (FImages <> nil) and ShowImages and (imidx <> -1) then
              case TabPosition of
                etpTop,
                  etpBottom:
                  begin
                    Inc(Result.cx, FImages.Width + Margin);
                    if (Result.cy < FImages.Height) then
                      Result.cy := FImages.Height;
                  end;
                etpLeft,
                  etpRight:
                  begin
                    if VerticalSideCaptions then
                    begin
                      Inc(Result.cy, FImages.Height + Margin);
                      if (Result.cx < FImages.Width) then
                        Result.cx := FImages.Width;
                    end
                    else
                    begin
                      Inc(Result.cx, FImages.Width + Margin);
                      if (Result.cy < FImages.Height) then
                        Result.cy := FImages.Height;
                    end;
                  end;
              end;
          end;
        end;
      case TabPosition of
        etpTop,
          etpBottom:
          begin
            Inc(Result.cx, Margin * 2 + Margin);
            Inc(Result.cy, Margin);
          end;
        etpLeft,
          etpRight:
          begin
            if VerticalSideCaptions then
            begin
              Inc(Result.cy, Margin * 2 + Margin);
              Inc(Result.cx, Margin);
            end
            else
            begin
              Inc(Result.cx, Margin * 2 + Margin);
              Inc(Result.cy, Margin);
            end;
          end;
      end;
      if Sheet.CloseButtonVisible then
      begin
        i := min({$ifdef MSWINDOWS}GetSystemMetrics(SM_CXMENUSIZE){$else}15{$endif}, Result.cy - 1);
        inc(Result.cx, i + Margin div 2);
      end;

      FTab.AdjustTabSize(Result);

      if TabWidth > 0 then
        Result.cx := TabWidth;
      if TabHeight > 0 then
        Result.cy := TabHeight;
    end;
  end;
end;

procedure TElCustomPageControl.ReorderPages(MaxRows: integer);
var
  TmpSheet,
    BreakSheet: TElTabSheet;

  function TabsOnRow(RowIndex: integer; var LastTab: TElTabSheet): integer;
  var
    i: integer;
    ASheet: TElTabSheet;
  begin
    Result := 0;
    LastTab := nil;
    for i := 0 to FPages.Count - 1 do
    begin
      ASheet := TElTabSheet(FPages[i]);
      if ASheet.TabVisible then
      begin
        if ASheet.FLine = RowIndex then
        begin
          LastTab := ASheet;
          inc(Result);
        end;
      end;
    end;
  end;

  function DoReorder(BreakSheet: TElTabSheet): integer;
  var
    CurRow: integer;
    i, j: integer;
    mx, my,
      tx, ty: integer;
    ASheet: TElTabSheet;
    sf,
      First,
      brfl: boolean;
    SheetSize: TSize;
    CurMargin: integer;
  begin
    mx := 0;
    my := 0;
    tx := 0;
    ty := 0;

    CurRow := 0;

      if FirstTab <> nil then
        j := FPages.IndexOf(FirstTab)
      else
        j := 0;

    i := j;
    sf := true;
    First := true;
    brfl := false;
    repeat
      ASheet := FPages[i];
      if (not sf) and (i = j) then break;
      sf := false;
      if ASheet.TabVisible then
      begin
        SheetSize := TSize(ASheet.FRect.BottomRight);

        case TabPosition of
          etpTop,
            etpBottom:
            begin
              if not First then
                CurMargin := FTab.GetInnerMargin
              else
                CurMargin := 0;
              if (ASheet = BreakSheet) or brfl or (tx + SheetSize.cx + CurMargin > Width) then
              begin
                  // go to new row
                inc(ty, my + FTab.GetRowMargin);
                mx := 0;
                inc(CurRow);
                if (tx + SheetSize.cx + CurMargin > Width) then
                begin
                  if First then
                  begin
                    SheetSize.cx := Width - FTab.GetOuterMargin * 2;
                    ASheet.FRect.Right := Width - FTab.GetOuterMargin * 2;
                  end;
                end;
                tx := FTab.GetOuterMargin;
                First := true;
              end
              else
              begin
                First := false;
              end;
              tx := tx + SheetSize.cx + CurMargin;
              my := Max(my, SheetSize.cy);
              ASheet.FLine := CurRow;
            end;
          etpLeft,
            etpRight:
            begin
              if not First then
                CurMargin := FTab.GetInnerMargin
              else
                CurMargin := 0;
              if (ASheet = BreakSheet) or brfl or (ty + SheetSize.cy + CurMargin
                > Height) then
              begin
                  // go to new row
                inc(tx, mx + FTab.GetRowMargin);
                my := 0;
                inc(CurRow);
                if (ty + SheetSize.cy + CurMargin > Height) then
                begin
                  if First then
                  begin
                    SheetSize.cy := Height - FTab.GetOuterMargin *
                      2;
                    ASheet.FRect.Bottom := Height -
                      FTab.GetOuterMargin * 2;
                  end;
                end;
                ty := FTab.GetOuterMargin;
                First := true;
              end
              else
              begin
                First := false;
              end;
              ty := ty + SheetSize.cy + FTab.GetInnerMargin;
              mx := Max(mx, SheetSize.cx);
              ASheet.FLine := CurRow;
            end;
        end;
        brfl := false;
      end;

        // increment counter
      inc(i);
      if i = FPages.Count then
      begin
        i := 0;
        brfl := true;
      end;
    until false;

    result := CurRow + 1;
  end;

  procedure AlignTabs(MaxRows: integer);
  var
    i, j: integer;
    L: TElList;
    ASheet: TElTabSheet;
    tx,
      ty: integer;
    acc,
      res,
      scale: double;
    togo,
    leftto: integer;
  begin
    L := TElList.Create;
    for i := 0 to MaxRows - 1 do
    begin
       // build a row
      L.Clear;
      for j := 0 to FPages.Count - 1 do
      begin
        ASheet := TElTabSheet(FPages[j]);
        if ASheet.TabVisible then
        begin
          if ASheet.FLine = i then
          begin
            L.Add(ASheet);
          end;
        end;
      end;
      tx := 0;
      ty := 0;
      acc := 0;
      togo := 0;
      leftto := 0;
      if L.Count = 0 then
      begin
        tx := 1;
        ty := 1;
      end
      else
      for j := 0 to L.Count - 1 do
      begin
        case TabPosition of
          etpLeft,
            etpRight:
            begin
              inc(ty, TElTabSheet(L[j]).FRect.Bottom);
              if j > 0 then inc(ty, FTab.GetInnerMargin);
            end;
          etpTop,
            etpBottom:
            begin
              inc(tx, TElTabSheet(L[j]).FRect.Right);
              if j > 0 then inc(tx, FTab.GetInnerMargin);
            end;
        end;
      end;
      scale := 1;
      case TabPosition of
        etpLeft,
          etpRight:
          begin
            scale := (Height - FTab.GetOuterMargin * 2) / ty;
            leftto := Height - FTab.GetOuterMargin * 2;
          end;
        etpTop,
          etpBottom:
          begin
            scale := (Width - FTab.GetOuterMargin * 2) / tx;
            leftto := Width - FTab.GetOuterMargin * 2;
          end;
      end;

      for j := 0 to L.Count - 1 do
      begin
        case TabPosition of
          etpLeft,
            etpRight:
            begin
              res := TElTabSheet(L[j]).FRect.Bottom * scale;
              acc := acc + frac(res);
              TElTabSheet(L[j]).FRect.Bottom := Trunc(res);
              inc(togo, Trunc(res));
            end;
          etpTop,
            etpBottom:
            begin
              res := TElTabSheet(L[j]).FRect.Right * scale;
              acc := acc + frac(res);
              TElTabSheet(L[j]).FRect.Right := Trunc(res);
              inc(togo, Trunc(res));
            end;
        end;
      end;
      if (L.Count > 0) and (acc > 0) then
      begin
        case TabPosition of
          etpLeft,
            etpRight:
            begin
              inc(TElTabSheet(L.Last).FRect.Bottom, round(acc));
              if togo + round(acc) > leftto then
                dec(TElTabSheet(L.Last).FRect.Bottom);
            end;
          etpTop,
            etpBottom:
            begin
              inc(TElTabSheet(L.Last).FRect.Right, round(acc));
              if togo + round(acc) > leftto then
                dec(TElTabSheet(L.Last).FRect.Right);
            end;
        end;
      end;
    end;
    L.Free;
  end;

begin
  if MaxRows > 1 then
  begin
    if TabsOnRow(MaxRows - 1, TmpSheet) < TabsOnRow(MaxRows - 2, BreakSheet) - 1
      then
    begin
      if DoReorder(BreakSheet) > MaxRows then
        DoReorder(nil);
    end;
  end;
  AlignTabs(MaxRows);
end;

procedure TElCustomPageControl.SetTabClass(Value: TElTabClass);
begin
  if FTabClass <> Value then
  begin
    if FTab <> nil then
      FTab.Free;
    FTabClass := Value;
    FTab := FTabClass.Create(Self);
  end;
end;

procedure TElCustomPageControl.WMMouseWheel(var Msg: TWMMouseWheel);
var
  Dy : integer;
  sl : integer;
begin
  if Multiline then
  begin
    if IsWinNT or IsWin98 then
       SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @sl, SPIF_SENDCHANGE)
    else
       sl := 3;
    if sl = 0 then
      sl := 1;
    Dy := Msg.WheelDelta div (MOUSE_WHEEL_DELTA div sl);
    if Dy <> 0 then
    begin
      if DY > 0 then
      begin
        if TabIndex > 0 then
          TabIndex := TabIndex - 1;
      end
      else
      begin
        if TabIndex < PageCount - 1 then
          TabIndex := TabIndex + 1;
      end
    end;
  end;
end;

{$ifdef MSWINDOWS}
function TElTabSheet.IsThemeApplied: Boolean;
begin
  Result := Assigned(PageControl) and PageControl.IsThemeApplied();
end;
{$endif}
function TElTabSheet.GetBtnTheme: HTheme;
begin
  if Assigned(PageControl) then
    Result := PageControl.BtnTheme
  else
    Result := 0;
end;

function TElTabSheet.GetScrollTheme: HTheme;
begin
  if Assigned(PageControl) then
    Result := PageControl.ScrollTheme
  else
    Result := 0;
end;

function TElTabSheet.GetTabTheme: HTheme;
begin
  if Assigned(PageControl) then
    Result := PageControl.Theme
  else
    Result := 0;
end;

function TElTabSheet.GetCloseBtnTheme: HTheme;
begin
  if Assigned(PageControl) then
    Result := PageControl.CloseBtnTheme
  else
    Result := 0;
end;

procedure TElTabSheet.WMNCCalcSize(var Message: TWMNCCalcSize);
var
  R, R1: TRect;
begin
  if IsThemeApplied then
  begin
    if PageControl.ShowBorder then
    begin
      R := Message.CalcSize_Params.rgrc[0];
      inherited;
      R := Message.CalcSize_Params.rgrc[0];
      if Succeeded(GetThemeBackgroundContentRect(TabTheme, Canvas.Handle,
        TABP_PANE, 0, R, R1)) then
      begin
        {
        // page control will draw our line
        if PageControl.ShowTabs and (PageControl.Style in [etsTabs, etsNetTabs]) then
        begin
          case PageControl.TabPosition of
            etpTop: R1.Top := R.Top;
            etpBottom: R1.Bottom := R.Bottom;
            etpRight: R1.Right := R.Right;
            etpLeft: R1.Left := R.Left;
          end;
        end;
        }
        Message.CalcSize_Params.rgrc[0] := R1;
      end;
    end;
  end
  else
    inherited;
end;

procedure TElTabSheet.WMNCPaint(var Message: TMessage);
var
  RC,
    R1,
    R2,
    RW: TRect;
  DC: HDC;
  s: integer;
begin
  if not IsThemeApplied then
  begin
    inherited;
  end
  else
  begin
    DC := GetWindowDC(Handle);
    Windows.GetClientRect(Handle, RC);
    GetWindowRect(Handle, RW);
    IntMapWindowPoints(0, Handle, RW, 2);
    OffsetRect(RC, -RW.Left, -RW.Top);
    ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
    OffsetRect(RW, -RW.Left, -RW.Top);
    R2 := RW;

    if PageControl.ShowBorder then
      s := 0
    else
      s := 1;

    GetThemeBackgroundContentRect(TabTheme, DC, TABP_PANE, 0, RW, R1);
    Inc(RW.Left, (RW.Left - R1.Left) * s);
    Inc(RW.Top, (RW.Top - R1.Top) * s);
    Inc(RW.Right, (RW.Right - R1.Right) * s);
    Inc(RW.Bottom, (RW.Bottom - R1.Bottom) * s);

    if PageControl.ShowTabs and (PageControl.Style in [etsTabs, etsNetTabs,
      etsFlatTabs, etsAngledTabs]) then
    begin
      case PageControl.TabPosition of
        etpTop: RW.Top := RW.Top + (R2.Top - R1.Top);
        etpBottom: RW.Bottom := RW.Bottom + (R2.Bottom - R1.Bottom);
        etpRight: RW.Right := RW.Right + (R2.Right - R1.Right);
        etpLeft: RW.Left := RW.Left + (R2.Left - R1.Left);
      end;
    end;

    DrawThemeBackground(TabTheme, DC, TABP_PANE, 0, RW, @R2);
    ReleaseDC(Handle, DC);
  end;
end;

function TElTab.GetBtnTheme: HTheme;
begin
  if Assigned(FOwner) then
  begin
    Result := FOwner.BtnTheme;
  end
  else
  begin
    Result := 0;
  end;
end;

function TElTab.GetScrollTheme: HTheme;
begin
  if Assigned(FOwner) then
  begin
    Result := FOwner.ScrollTheme;
  end
  else
  begin
    Result := 0;
  end;
end;

function TElTab.GetTabTheme: HTheme;
begin
  if Assigned(FOwner) then
  begin
    Result := FOwner.TabTheme;
  end
  else
  begin
    Result := 0;
  end;
end;

function TElTab.GetCloseBtnTheme: HTheme;
begin
  if Assigned(FOwner) then
  begin
    Result := FOwner.CloseBtnTheme;
  end
  else
  begin
    Result := 0;
  end;
end;

function TElTab.IsThemeApplied: Boolean;
begin
  Result := Assigned(FOwner) and FOwner.IsThemeApplied;
end;

function TElTab.GetTabPosition: TElTabPosition;
begin
  Result := etpTop;
  if Assigned(FOwner) and Assigned(FOwner) then
  begin
    Result := FOwner.TabPosition;
  end;
end;

function TElTab.GetContentMargin: Integer;
begin
  Result := Margin;
end;

procedure TElTab.FixupTab(Canvas: TCanvas; R: TRect; TabSheet: TElTabSheet);
begin
  // intentionally left blank
end;

procedure TElTab.AdjustFocusRect(var R: TRect);
begin
  // intentionally left blank
end;

procedure TElBtnTab.FillTab(Canvas: TCanvas; Rect: TRect;
  TabSheet: TElTabSheet);
begin
  if not IsThemeApplied then
  begin
    inherited;
  end;
end;

procedure TElFlatBtnTab.FillTab(Canvas: TCanvas; Rect: TRect;
  TabSheet: TElTabSheet);
begin
  if not IsThemeApplied then
  begin
    inherited;
  end;
end;

procedure TElTabSheet.WMIsThemedControl(var Message: TMessage);
begin
  Message.Result := FPageControl.Theme;
end;

procedure TElTabSheet.ELThemeChanged(var Message: TMessage);
begin
  if ThemesAvailable and UseXPThemes then
  begin
    SetWindowPos(
      Handle,
      0,
      0, 0, 0, 0,
      SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER
      );
    RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ERASE);
  end;
  Message.Result := 1;
end;

function TElTabSheet.GetUseXPThemes: Boolean;
begin
  Result := Assigned(PageControl) and PageControl.UseXPThemes;
end;

procedure TElTabSheet.CreateWnd;
begin
  inherited;
  {$ifdef MSWINDOWS}
  if ThemesAvailable then
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER or SWP_FRAMECHANGED);
  {$endif}
end;

procedure TElTabSheet.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);

  if Reader.Parent is TElCustomPageControl then
    PageControl := TElCustomPageControl(Reader.Parent);
end;

procedure TElTabSheet.CMDialogChar(var Message: TCMDialogChar);
begin
  if Enabled and TabVisible and IsAccel(Message.CharCode, Caption) then
  begin
    FPageControl.ActivePage := Self;
  end
  else
    inherited;
end;

{$IFNDEF VCL_4_USED}

procedure TElTabSheet.WMSize(var Msg: TWMSize);
begin
  inherited;
end;

procedure TElTabSheet.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
end;

{$ENDIF}

{$IFDEF ELPACK_UNICODE}

procedure TElTabSheet.CMHintShow(var Message: TMessage);
var
  T: WideChar;
  HintInfo: PHintInfo;
  l: integer;
  S: string;
  WS: WideString;
begin
  inherited;
  HintInfo := PHintInfo(Message.lParam);
  if Length(FHint) = 0 then
  begin
    HintInfo.hintStr := '';
    exit;
  end;

  S := GetShortHint(inherited Hint);
  if HintInfo.HintStr = S then
  begin
    WS := GetShortHintW(FHint);
  end
  else
  begin
    S := FHint;
    WS := FHint;
  end;

  l := Length(S) + 1 + Length(WS) * 2;
  SetLength(HintInfo.HintStr, l + 4);
  Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);

  Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
  T := #0;
  Move(T, HintInfo.HintStr[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, HintInfo.HintStr[l + 3], sizeof(T));
end;

procedure TElTabSheet.SetHint(Value: TElFString);
var
  S: string;
  i,
    l: integer;
  T: WideChar;
begin
  FHint := Value;

  S := FHint;
  i := Length(S);
  l := Length(S) + 1 + Length(FHint) * 2;
  SetLength(S, l + 4);
  S[i + 1] := #0;

  Move(FHint[1], S[i + 2], Length(FHint) * 2);
  T := #0;
  Move(T, S[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, S[l + 3], sizeof(T));
  inherited Hint := S;
end;

{$ENDIF}

procedure TElTabSheet.SetUseTabColor(Value: Boolean);
begin
  if FUseTabColor <> Value then
  begin
    FUseTabColor := Value;
    if Parent <> nil then
      TElCustomPageControl(Parent).UpdateTab(Self);
  end;
end;

function TElTabSheet.CloseButtonVisible: Boolean;
begin
  Result := ShowCloseButton and
    ((FPageControl = nil) or
    ((FPageControl.CloseButtonMode = cbmAll) or
    ((FPageControl.CloseButtonMode = cbmActive) and
    (FPageControl.ActivePage = self)
    )
    )
    );
end;

procedure TElTabSheet.SetUseFontForTabs(Value: Boolean);
begin
  if FUseFontForTabs <> Value then
  begin
    FUseFontForTabs := Value;
    if (not ParentFont) and TabVisible and (FPageControl <> nil) then
      FPageControl.RebuildTabs(false);
  end;
end;

procedure TElTabSheet.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or WS_CLIPCHILDREN;
  Params.WindowClass.style := Params.WindowClass.style or CS_HREDRAW or
    CS_VREDRAW;
end;

procedure TElTabSheet.SetCloseBtnEnabled(Value: Boolean);
begin
  if FCloseBtnEnabled <> Value then
  begin
    FCloseBtnEnabled := Value;
    if Parent <> nil then
      TElCustomPageControl(Parent).UpdateTab(Self);
  end;
end;

function TElTabSheet.GetInheritedHint: string;
begin
  Result := inherited Hint;
end;

procedure TElTabSheet.BeginCreate;
begin
  inc(FCreating);
end;

procedure TElTabSheet.EndCreate;
begin
  dec(FCreating);
end;


procedure TEl2DFlatTab.AdjustDrawingSize(Active: boolean; var R: TRect);
var
  FPageControl: TElCustomPageControl;
begin
  if Active then
  begin
    FPageControl := FOwner;
    case FPageControl.TabPosition of
      etpLeft:
        begin
          inc(R.Bottom);
          dec(R.Top);
        end;
      etpTop:
        begin
          dec(R.Left);
          inc(R.Right);
        end;
      etpRight:
        begin
          inc(R.Bottom);
          dec(R.Top);
        end;
      etpBottom:
        begin
          dec(R.Left);
          inc(R.Right);
        end;
    end;
  end;
end;

procedure TEl2DFlatTab.AdjustFillSize(After: boolean; var R: TRect; TabSheet
  : TElTabSheet);
begin
  inherited;
  if TabSheet = FOwner.FActivePage then
    case FOwner.TabPosition of
      etpTop:
        begin
          if After then
          begin
            dec(R.Right);
            dec(R.Bottom);
          end
          else
          begin
            inc(R.Right);
            inc(R.Bottom);
          end;
        end;
      etpBottom:
        begin
          if After then
          begin
            inc(R.Top);
            dec(R.Bottom);
            dec(R.Right);
          end
          else
          begin
            dec(R.Top);
            inc(R.Bottom);
            inc(R.Right);
          end;
        end;
      etpLeft:
        begin
          if After then
          begin
            dec(R.Right);
            dec(R.Bottom);
          end
          else
          begin
            inc(R.Right);
            inc(R.Bottom);
          end;
        end;
      etpRight:
        begin
          if After then
          begin
            inc(R.Left);
            dec(R.Right);
            dec(R.Bottom);
          end
          else
            dec(R.Left);
          inc(R.Right);
          inc(R.Bottom);
        end;
    end;
end;

procedure TEl2DFlatTab.AdjustTabSize(var Size: TSize);
var
  R,
    R1: TRect;
  pid,
    sid: integer;
begin
  if IsThemeApplied then
  begin
    pid := TABP_TOPTABITEM;
    sid := TIS_SELECTED;
    R := Rect(0, 0, Size.cx, Size.cy);
    GetThemeBackgroundContentRect(TabTheme, FOwner.Canvas.Handle,
      pid, sid, R, R1);
    if FOwner.TabPosition in [etpLeft, etpRight] then
    begin
      inc(Size.cy, (R1.Left - R.Left) + (R.Right - R1.Right));
      inc(Size.cx, (R1.Top - R.Top) + (R.Bottom - R1.Bottom));
    end
    else
    begin
      inc(Size.cx, (R1.Left - R.Left) + (R.Right - R1.Right));
      inc(Size.cy, (R1.Top - R.Top) + (R.Bottom - R1.Bottom));
    end;
  end
  else
  begin
    inc(Size.cx, 2);
    inc(Size.cy, 2);
  end;
end;

function TEl2DFlatTab.CanDrawTab(ActiveDraw: boolean): Boolean;
begin
  result := ActiveDraw;
end;

procedure TEl2DFlatTab.DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
  TElTabSheet);

  procedure lp_DrawInactive;
  const
   c_Margin = 3;
  begin
   // Приступим к отрисовке:
   Canvas.Pen.Color := FOwner.FlatTabBorderColor;
   case FOwner.TabPosition of
    etpLeft, etpRight:
     with Canvas do
     begin
      // Верхняя горизонтальная линия:
      if Pred(TabSheet.TabIndex) <> FOwner.ActivePageIndex then
      begin
       MoveTo(r.left + c_Margin, Succ(r.Top));
       LineTo(r.right - c_Margin, Succ(r.Top));
      end;
      // Нижняя горизонтальная линия:
      if TabSheet.TabIndex = Pred(FOwner.PageCount) then
      begin
       MoveTo(r.left + c_Margin, Pred(r.Bottom));
       LineTo(r.right - c_Margin, Pred(r.Bottom));
      end;
     end;//with Canvas do
    etpTop, etpBottom:
     with Canvas do
     begin
      // Левая вертикальная линия:
      if (TabSheet.TabIndex = 0) then
      begin
       MoveTo(Succ(r.left), r.top + c_Margin);
       LineTo(Succ(r.left), r.bottom - c_Margin);
      end;
      // Правая вертикальная линия:
      if (Succ(TabSheet.TabIndex) <> FOwner.ActivePageIndex) then
      begin
       MoveTo(Pred(r.right), r.top + c_Margin);
       LineTo(Pred(r.right), r.bottom - c_Margin);
      end;
     end;//with Canvas do
   end;//case FOwner.TabPosition of
  end;

var
  iPartId: Integer;
  iStateId: Integer;
begin
  if IsThemeApplied and (TabPosition = etpTop) then
  begin
    if TabSheet = FOwner.FActivePage then
    begin
      iPartId := TABP_TOPTABITEM;
      iStateId := TIS_SELECTED;
    end
    else
    begin
      iPartId := TABP_TABITEM;
      if TabSheet = FOwner.FTrackTab then
      begin
        iStateId := TIS_HOT;
      end
      else
      begin
        if TabSheet = FOwner.FDownTab then
        begin
          iStateId := TIS_FOCUSED;
        end
        else
        begin
          iStateId := TIS_NORMAL;
        end;
      end;
    end;
    if not TabSheet.Enabled then
    begin
      iStateId := TIS_DISABLED;
    end;
    if (iStateId <> TIS_NORMAL) or (iPartId = TABP_TOPTABITEM) then
    begin
      DrawThemeBackground(TabTheme, Canvas.Handle, iPartId, iStateId, R, nil);
      GetThemeBackgroundContentRect(TabTheme, Canvas.Handle, iPartId, iStateId,
        R, R);
    end
    else
    begin
      DrawThemeBackground(TabTheme, Canvas.Handle, TABP_BODY, 0, R, nil);
      GetThemeBackgroundContentRect(TabTheme, Canvas.Handle, TABP_BODY, 0, R,
        R);
    end;
  end
  else
  begin
    if TabSheet = FOwner.FActivePage then
    begin
      Canvas.Pen.Color := FOwner.FlatTabBorderColor;
        // IncColor(clBtnHighlight, 20, 20, 20);

      case FOwner.TabPosition of
        etpLeft:
          with Canvas do
          begin
            MoveTo(r.right - 1, r.top);
            LineTo(r.left, r.top);
            LineTo(r.left, r.bottom + 1);

            MoveTo(r.left + 1, r.bottom);
            LineTo(r.right, r.bottom);

            MoveTo(r.Right - 1, r.Top);
            LineTo(r.Right - 1, r.Bottom);
          end;
        etpTop:
          with Canvas do
          begin
            (* highlight *)
            MoveTo(r.left, r.bottom - 1);
            LineTo(r.left, r.top);
            LineTo(r.right, r.top);

            MoveTo(r.right - 1, r.top + 1);
            LineTo(r.right - 1, r.bottom - 1);

            MoveTo(r.left, r.bottom - 1);
            LineTo(r.right - 1, r.bottom - 1);
          end;
        etpRight:
          with Canvas do
          begin
            MoveTo(r.left, r.top);
            LineTo(r.right, r.top);

            LineTo(r.right, r.bottom + 1);
            MoveTo(r.left, r.bottom);
            LineTo(r.right, r.bottom);

            MoveTo(r.left, r.top);
            LineTo(r.left, r.bottom);
          end;
        etpBottom:
          with Canvas do
          begin
            (* highlight *)

            MoveTo(r.left, r.top);
            LineTo(r.left, r.bottom + 1);

            MoveTo(r.right, r.top);
            LineTo(r.right, r.bottom);
            LineTo(r.left, r.bottom);

            MoveTo(r.left, r.top);
            LineTo(r.right, r.top);
          end;
      end;
    end
    else
     lp_DrawInactive;
    InflateRect(r, -1, -1);
  end;
end;

procedure TEl2DFlatTab.DrawTabLine(Canvas: TCanvas; R: TRect);
var
  ASheet: TElTabSheet;
  R1: TRect;
begin
  ASheet := FOwner.ActivePage;

  {$ifdef MSWINDOWS}
  if IsThemeApplied then
  begin
    case FOwner.TabPosition of
      etpTop:
        begin
          R.Top := R.Bottom - 1;
          inc(R.Bottom, 2);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(ASheet.FRect.Left, R.Top, ASheet.FRect.Right, R.Bottom);
            with R1 do
              ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
      etpBottom:
        begin
          R.Bottom := R.Top + 1;
          dec(R.Top);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(ASheet.FRect.Left, R.Top, ASheet.FRect.Right, R.Bottom);
            with R1 do
              ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
      etpLeft:
        begin
          R.Left := R.Right - 2;
          //inc(R.Right);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(R.Left, ASheet.FRect.Top, R.Right, ASheet.FRect.Bottom);
            with R1 do
              ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
      etpRight:
        begin
          R.Right := R.Left + 2;
          dec(R.Left, 1);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(R.Left, ASheet.FRect.Top, R.Right, ASheet.FRect.Bottom);
            with R1 do
              ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
    end;
    DrawThemeBackground(TabTheme, Canvas.Handle, TABP_PANE, 0, R, nil);
    exit;
  end;
  {$endif}
  Canvas.Pen.Color := FOwner.FlatTabBorderColor;

  ASheet := FOwner.ActivePage;
  with Canvas do
    case FOwner.TabPosition of
      etpTop:
        begin
          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Bottom - 1);
            LineTo(R.Right, R.Bottom - 1);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              MoveTo(R.Left, R.Bottom - 1);
              LineTo(ASheet.FRect.Left, R.Bottom - 1);
            end;
            if ASheet.FRect.Right < R.Right then
            begin
              MoveTo(ASheet.FRect.Right - 1, R.Bottom - 1);
              LineTo(R.Right, R.Bottom - 1);
            end;
          end;
        end;
      etpBottom:
        begin
          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Top);
            LineTo(R.Right, R.Top);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              MoveTo(R.Left, R.Top);
              LineTo(ASheet.FRect.Left, R.Top);
            end;
            if ASheet.FRect.Right < R.Right then
            begin
              MoveTo(ASheet.FRect.Right + 1, R.Top);
              LineTo(R.Right, R.Top);
            end;
          end;
        end;
      etpLeft:
        begin
          Dec(R.Bottom);

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Right - 1, R.Top);
            LineTo(R.Right - 1, R.Bottom);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              MoveTo(R.Right - 1, R.Top);
              LineTo(R.Right - 1, ASheet.FRect.Top);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              MoveTo(R.Right - 1, ASheet.FRect.Bottom + 1);
              LineTo(R.Right - 1, R.Bottom);
            end;
          end;
          (*
          if FOwner.ShowBorder then
          begin
            {$ifndef CLX_USED}
            if not FOwner.Flat then
            begin
              Pixels[R.Right - 1, R.Bottom - 1] := clBtnShadow;
              Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
            end
            else
            begin
              Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
            end;
            {$else}
            if not FOwner.Flat then
            begin
              Pixels[R.Right - 1, R.Bottom - 1] := clBtnShadow;
              Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
            end
            else
            begin
              Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
            end;
            {$endif}
          end;
          *)
          inc(R.Bottom);
        end;
      etpRight:
        begin

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Top);
            LineTo(R.Left, R.Bottom);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              MoveTo(R.Left, R.Top);
              LineTo(R.Left, ASheet.FRect.Top);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              MoveTo(R.Left, ASheet.FRect.Bottom + 1);
              LineTo(R.Left, R.Bottom);
            end;
          end;

        (*
        if FOwner.ShowBorder then
        begin
          Pixels[R.Right - 2, R.Top] := clBtnHighlight;
          Pixels[R.Right - 1, R.Top] := clBtnHighlight;
          if not FOwner.Flat then
          begin
            Pixels[R.Right - 2, R.Bottom] := cl3DDkShadow;
            Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
          end
          else
          begin
            Pixels[R.Right - 2, R.Bottom] := clBtnShadow;
            Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
          end;
        end;
        inc(R.Bottom);
        *)
        end;
    end;
end;

function TEl2DFlatTab.GetAscend: Integer;
begin
  Result := 2;
end;

function TEl2DFlatTab.GetInnerMargin: Integer;
begin
  Result := 2;
end;

function TEl2DFlatTab.GetOuterMargin: Integer;
begin
  Result := 4;
end;

procedure TEl2DFlatTab.FillTab(Canvas: TCanvas; Rect: TRect; TabSheet:
  TElTabSheet);
{$IFDEF ELPACK_USE_IMAGEFORM}
var
  ACtl: TWinControl;
  BgRect: TRect;
{$ENDIF}
begin
  AdjustFillSize(false, Rect, TabSheet);
{$IFDEF ELPACK_USE_IMAGEFORM}
  if (FOwner.FImgForm = nil) or (csDesigning in
    FOwner.ComponentState) then
{$ENDIF}
  begin
    Canvas.Brush.Style := bsSolid;
    if TabSheet.UseTabColor then
      Canvas.Brush.Color := TabSheet.TabColor
    else
      if TabSheet = FOwner.FActivePage then
      Canvas.Brush.Color := FOwner.FActiveTabColor
    else
      Canvas.Brush.Color := FOwner.FInactiveTabColor;
    Canvas.FillRect(Rect);
{$IFDEF ELPACK_USE_IMAGEFORM}
  end
  else
    if TabSheet = FOwner.FActivePage then
  begin
    if (FOwner.FImgForm.Control <> FOwner) then
    begin
      ACtl := FOwner.FImgForm.GetRealControl;

      BgRect.Left := FOwner.Left;
      BgRect.Top := FOwner.Top;

      BgRect.TopLeft :=
        FOwner.Parent.ClientToScreen(BgRect.TopLeft);
      BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);

      FOwner.FImgForm.PaintBkgnd(Canvas.Handle, Rect,
        BgRect.TopLeft, false);
    end;
{$ENDIF}
  end;
  AdjustFillSize(true, Rect, TabSheet);
end;

function TElAngledTab.CanDrawTab(ActiveDraw: boolean): Boolean;
begin
  result := true //not ActiveDraw;
end;

procedure TElAngledTab.DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
  TElTabSheet);
begin
  begin
    // if TabSheet = FOwner.FActivePage then
    begin
      Canvas.Pen.Color := clBtnShadow;

      case FOwner.TabPosition of
        etpLeft:
          with Canvas do
          begin
            if FOwner.Flat then
              Pen.Color := clBtnShadow
            else
              Pen.Color := cl3DDkShadow;

            MoveTo(r.right, r.bottom + 1);
            LineTo(r.left, r.bottom - AngledOffset);
            if not FOwner.Flat then
            begin
              Canvas.Pen.Color := clBtnShadow;
              MoveTo(r.right, r.bottom - 1);
              LineTo(r.left, r.bottom - AngledOffset - 1);
            end;

            Canvas.Pen.Color := clBtnHighlight;
            LineTo(r.left, r.top + AngledOffset);
            LineTo(R.right, r.top - 1);
          end;
        etpTop:
          with Canvas do
          begin
            Canvas.Pen.Color := clBtnHighlight;
            MoveTo(r.left, r.bottom - 1);
            LineTo(r.left + AngledOffset - 1, r.top);
            LineTo(r.right - AngledOffset, r.top);

            if FOwner.Flat then
              Pen.Color := clBtnShadow
            else
              Pen.Color := cl3DDkShadow;

            LineTo(r.right, r.bottom - 1);
            if not FOwner.Flat then
            begin
              Canvas.Pen.Color := clBtnShadow;
              MoveTo(r.right - 1, r.bottom - 1);
              LineTo(R.right - AngledOffset - 1, r.top);
            end;
          end;
        etpRight:
          with Canvas do
          begin
            Canvas.Pen.Color := clBtnHighlight;
            MoveTo(r.left, r.top);
            LineTo(r.right - 1, r.top + AngledOffset);

            if FOwner.Flat then
              Pen.Color := clBtnShadow
            else
              Pen.Color := cl3DDkShadow;

            LineTo(r.right - 1, r.bottom - AngledOffset);
            LineTo(r.left, r.bottom);

            if not FOwner.Flat then
            begin
              Canvas.Pen.Color := clBtnShadow;
              MoveTo(r.left, r.bottom - 1);
              LineTo(r.right - 1, r.bottom - AngledOffset - 1);
              MoveTo(r.right - 2, r.bottom - AngledOffset - 1);
              LineTo(r.right - 2, r.top + AngledOffset);
            end;
          end;
        etpBottom:
          with Canvas do
          begin
            (* highlight *)
            Canvas.Pen.Color := cl3DDkShadow;
            Canvas.Pen.Color := clBtnHighlight;

            MoveTo(r.left { - 1}, r.top);
            LineTo(r.left + AngledOffset {- 1}, r.bottom - 1);

            if FOwner.Flat then
              Pen.Color := clBtnShadow
            else
              Pen.Color := cl3DDkShadow;
            MoveTo(r.left + AngledOffset, r.bottom - 1);
            LineTo(r.right - AngledOffset, r.bottom - 1);
            LineTo(r.right, r.top);

            if not FOwner.Flat then
            begin
              Canvas.Pen.Color := clBtnShadow;
              MoveTo(r.left + AngledOffset + 1, r.bottom - 2);
              LineTo(r.right - AngledOffset, r.bottom - 2);
              MoveTo(r.right - 1, r.top);
              LineTo(r.right - AngledOffset - 1, r.bottom - 1);
            end;
          end;
      end;
    end;
    InflateRect(r, -1, -1);
  end;
end;

procedure TElAngledTab.DrawTabLine(Canvas: TCanvas; R: TRect);
var
  ASheet: TElTabSheet;
  R1: TRect;
begin
  ASheet := FOwner.ActivePage;

  with Canvas do
    case FOwner.TabPosition of
      etpTop:
        begin
          Pen.Color := clBtnHighlight;
          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Bottom - 1);
            LineTo(R.Right, R.Bottom - 1);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              MoveTo(R.Left, R.Bottom - 1);
              LineTo(ASheet.FRect.Left { - 2}, R.Bottom - 1);
            end;
            if ASheet.FRect.Right - 1 < R.Right then
            begin
              MoveTo(ASheet.FRect.Right + 1, R.Bottom - 1);
              LineTo(R.Right, R.Bottom - 1);
            end;
          end;
        end;
      etpBottom:
        begin
          if FOwner.Flat then
            R.Bottom := R.Top + 1
          else
            R.Bottom := R.Top + 2;

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            if FOwner.Flat then
              DrawEdge(Handle, R, BDR_RAISEDINNER, BF_BOTTOM)
            else
              DrawEdge(Handle, R, BDR_RAISED, BF_BOTTOM);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              R1 := Rect(R.Left, R.Top, ASheet.FRect.Left + 1, R.Bottom);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_BOTTOM)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_BOTTOM);
            end;
            if ASheet.FRect.Right < R.Right then
            begin
              R1 := Rect(ASheet.FRect.Right - 1, R.Top, R.Right, R.Bottom);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_BOTTOM)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_BOTTOM);
            end;
          end;

          if FOwner.ShowBorder then
          begin
            Pixels[R.Left, R.Bottom - 1] := clBtnHighlight;
            Pixels[R.Left, R.Bottom - 2] := clBtnHighlight;
            if FOwner.Flat then
              Pixels[R.Right - 1, R.Bottom - 2] := clBtnShadow
            else
              Pixels[R.Right - 1, R.Bottom - 2] := cl3DDkShadow;
          end;
        end;
      etpLeft:
        begin
          Canvas.Pen.Color := clRed;
          Canvas.Pen.Color := clBtnHighlight;
          Dec(R.Bottom);

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Right - 1, R.Top);
            LineTo(R.Right - 1, R.Bottom);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              MoveTo(R.Right - 1, R.Top);
              LineTo(R.Right - 1, ASheet.FRect.Top + 1);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              MoveTo(R.Right - 1, ASheet.FRect.Bottom + 1);
              LineTo(R.Right - 1, R.Bottom);
            end;
          end;
          if FOwner.ShowBorder then
          begin
            if not FOwner.Flat then
            begin
              Pixels[R.Right - 1, R.Bottom - 1] := clBtnShadow;
              Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
            end
            else
            begin
              Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
            end;
          end;
          inc(R.Bottom);
        end;
      etpRight:
        begin
          if FOwner.Flat then
            R.Right := R.Left + 1
          else
            R.Right := R.Left + 2;
          Dec(R.Bottom);

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            if FOwner.Flat then
              DrawEdge(Handle, R, BDR_RAISEDINNER, BF_RIGHT)
            else
              DrawEdge(Handle, R, BDR_RAISED, BF_RIGHT);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              R1 := Rect(R.Left, R.Top, R.Right, ASheet.FRect.Top + 1);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_RIGHT)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_RIGHT);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              R1 := Rect(R.Left, ASheet.FRect.Bottom - 1, R.Right, R.Bottom);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_RIGHT)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_RIGHT);
            end;
          end;

          if FOwner.ShowBorder then
          begin
            Pixels[R.Right - 2, R.Top] := clBtnHighlight;
            Pixels[R.Right - 1, R.Top] := clBtnHighlight;
            if not FOwner.Flat then
            begin
              Pixels[R.Right - 2, R.Bottom] := cl3DDkShadow;
              Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
            end
            else
            begin
              Pixels[R.Right - 2, R.Bottom] := clBtnShadow;
              Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
            end;
          end;
          inc(R.Bottom);
        end;
    end;
end;

procedure TElAngledTab.AdjustFillSize(After: boolean; var R: TRect; TabSheet
  : TElTabSheet);
begin
  inherited;
  //if TabSheet = FOwner.FActivePage then
  case FOwner.TabPosition of
    etpTop:
      begin
        if After then
        begin
          dec(R.Right);
          dec(R.Bottom);
        end
        else
        begin
          inc(R.Right);
          inc(R.Bottom);
        end;
      end;
    etpBottom:
      begin
        if After then
        begin
          inc(R.Top);
          //inc(R.Bottom);
          //dec(R.Right);
        end
        else
        begin
          dec(R.Top);
          //dec(R.Bottom);
          // inc(R.Right);
        end;
      end;
    etpLeft:
      begin
        if After then
        begin
          //dec(R.Left);
          dec(R.Right);
          //dec(R.Bottom);
        end
        else
        begin
          //inc(R.Left);
          inc(R.Right);
          //inc(R.Bottom);
        end;
      end;
    etpRight:
      begin
        if After then
        begin
          inc(R.Left, 2);
          //dec(R.Right);
          //dec(R.Bottom);
        end
        else
          dec(R.Left, 2);
          //inc(R.Right);
          //inc(R.Bottom);
      end;
  (*
  end
  else
  begin
    case FOwner.TabPosition of
      etpBottom:
        begin
        end;
      etpRight:
        begin
        end;
    end;
  *)
  end;
end;

procedure TElAngledTab.AdjustDrawingSize(Active: boolean; var R: TRect);
var
  FPageControl: TElCustomPageControl;
begin
  //if Active then
  begin
    FPageControl := FOwner;
    case FPageControl.TabPosition of
      etpLeft:
        begin
          //inc(R.Right);
          dec(R.Left, GetAscend);
          inc(R.Bottom, GetOuterMargin);
          dec(R.Top, GetOuterMargin);
        end;
      etpTop:
        begin
          //inc(R.Top);
          dec(R.Top, GetAscend);
          dec(R.Left, GetOuterMargin);
          inc(R.Right, GetOuterMargin);
        end;
      etpRight:
        begin
          //dec(R.Left);
          inc(R.Right, GetAscend);
          inc(R.Bottom, GetOuterMargin);
          dec(R.Top, GetOuterMargin);
        end;
      etpBottom:
        begin
          dec(R.Top);
          inc(R.Bottom, GetAscend);
          dec(R.Left, GetOuterMargin);
          inc(R.Right, GetOuterMargin);
        end;
    end;
  end;
end;

procedure TElAngledTab.AdjustTabSize(var Size: TSize);
begin
  if FOwner.TabPosition in [etpLeft, etpRight] then
  begin
    inc(Size.cy, 2 + AngledOffset);
    inc(Size.cx, 2);
  end
  else
  begin
    inc(Size.cx, 2 + AngledOffset);
    inc(Size.cy, 2);
  end;
end;

procedure TElAngledTab.FillTab(Canvas: TCanvas; Rect: TRect; TabSheet:
  TElTabSheet);
var
{$IFDEF ELPACK_USE_IMAGEFORM}
  ACtl: TWinControl;
  BgRect: TRect;
{$ENDIF}
  Points: array[0..4] of TPoint;
  r: TRect;
  NRgn: HRgn;
  pc: integer;
begin
  R := Rect;
  AdjustFillSize(false, Rect, TabSheet);

  CreateTabPoints(R, @Points);
  pc := 4;
  if (TabSheet <> FOwner.FActivePage) and
    (TabSheet <> FOwner.FirstTab) then
  begin
    case FOwner.TabPosition of
      etpLeft:
        begin
          Points[3] := Point(R.Left + (R.Right - R.Left) div 2, R.Top +
            AngledOffset div 2);
          Points[4] := Point(R.Right, R.Top + AngledOffset - 1);
        end;
      etpTop:
        begin
          Points[0] := Point(R.Left + AngledOffset div 2, R.Top + (R.Bottom -
            R.Top) div 2);
          Points[4] := Point(R.Left + AngledOffset, R.Bottom);
        end;
      etpRight:
        begin
          Points[0] := Point(R.Left + (R.Right - R.Left - 1) div 2, R.Top +
            AngledOffset div 2);
          Points[4] := Point(R.Left, R.Top + AngledOffset - 1);
        end;
      etpBottom:
        begin
          Points[0] := Point(R.Left + AngledOffset div 2, R.Top + (R.Bottom -
            R.Top) div 2);
          Points[4] := Point(R.Left + AngledOffset, R.Top);
        end;
    end;
    pc := 5;
  end;

  SaveDCState := SaveDC(Canvas.Handle);
  NRgn := CreatePolygonRgn(Points, pc, WINDING);
  SelectClipRgn(Canvas.Handle, NRgn);

{$IFDEF ELPACK_USE_IMAGEFORM}
  if (FOwner.FImgForm = nil) or (csDesigning in
    FOwner.ComponentState) then
{$ENDIF}
  begin
    Canvas.Brush.Style := bsSolid;
    if TabSheet.UseTabColor then
      Canvas.Brush.Color := TabSheet.TabColor
    else
      if TabSheet = FOwner.FActivePage then
      Canvas.Brush.Color := FOwner.FActiveTabColor
    else
      Canvas.Brush.Color := FOwner.FInactiveTabColor;
    FillRgn(Canvas.Handle, NRgn, Canvas.Brush.Handle);
    Canvas.Brush.Style := bsClear;
{$IFDEF ELPACK_USE_IMAGEFORM}
  end
  else
    if TabSheet = FOwner.FActivePage then
  begin
    if (FOwner.FImgForm.Control <> FOwner) then
    begin
      ACtl := FOwner.FImgForm.GetRealControl;

      BgRect.Left := FOwner.Left;
      BgRect.Top := FOwner.Top;

      BgRect.TopLeft :=
        FOwner.Parent.ClientToScreen(BgRect.TopLeft);
      BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);

      FOwner.FImgForm.PaintBkgnd(Canvas.Handle, Rect,
        BgRect.TopLeft, false);
    end;
{$ENDIF}
  end;
  DeleteObject(NRgn);
  AdjustFillSize(true, Rect, TabSheet);
end;

function TElAngledTab.GetAscend: Integer;
begin
  Result := 2;
end;

function TElAngledTab.GetInnerMargin: Integer;
begin
  Result := -5;
end;

function TElAngledTab.GetOuterMargin: Integer;
begin
  Result := 4;
end;

function TElAngledTab.GetContentMargin: Integer;
begin
  Result := AngledOffset;
end;

procedure TElAngledTab.CreateTabPoints(R: TRect; Points: PPoint);
begin
  case FOwner.TabPosition of
    etpLeft:
      begin
        Points^ := Point(r.right, r.bottom + 1);
        Inc(Points);
        Points^ := Point(r.left, r.bottom - AngledOffset {+ 1});
        Inc(Points);
        Points^ := Point(r.left, r.top + AngledOffset {- 1});
        Inc(Points);
        Points^ := Point(r.right, r.top - 1);
      end;
    etpTop:
      begin
        Points^ := Point(r.left - 1, r.bottom);
        Inc(Points);
        Points^ := Point(r.left + AngledOffset - 1, r.top);
        Inc(Points);
        Points^ := Point(r.right - AngledOffset + 1, r.top);
        Inc(Points);
        Points^ := Point(r.right + 1, r.bottom);
      end;
    etpRight:
      begin
        Points^ := Point(r.left, r.top { - 1});
        Inc(Points);
        Points^ := Point(r.right, r.top + AngledOffset {- 1});
        Inc(Points);
        Points^ := Point(r.right, r.bottom - AngledOffset);
        Inc(Points);
        Points^ := Point(r.left, r.bottom);
      end;
    etpBottom:
      begin
        Points^ := Point(r.left {- 1}, r.top);
        Inc(Points);
        Points^ := Point(r.left + AngledOffset {- 1}, r.bottom);
        Inc(Points);
        Points^ := Point(r.right - AngledOffset + 1, r.bottom);
        Inc(Points);
        Points^ := Point(r.right + 1, r.top);
      end;
  end;
end;

procedure TElAngledTab.FixupTab(Canvas: TCanvas; R: TRect; TabSheet:
  TElTabSheet);
begin
  RestoreDC(Canvas.Handle, SaveDCState);
end;

procedure TElAngledTab.AdjustFocusRect(var R: TRect);
begin
  if FOwner.TabPosition in [etpLeft, etpRight] then
  begin
    InflateRect(R, 0, -5);
  end
  else
  begin
    InflateRect(R, -5, 0);
  end;
  // AdjustDrawingSize(FOwner.FActivePage = TabSheet, R);
  inherited;
end;

{$IfDef Nemesis}
{ TpcHistory }

constructor TpcHistory.Create;
begin
 inherited Create;
 f_IsActiveEmpty := False;
end;

function TpcHistory.pm_GetIsActiveEmpty : Boolean;
begin
 Result := f_IsActiveEmpty;
end;

function TpcHistory.pm_GetGuidForm : TGUID;
begin
 Result := f_GuidForm;
end;

procedure TpcHistory.pm_SetGuidForm(const Value : TGUID);
begin
 f_GuidForm := Value;
end;

function TpcHistory.pm_GetEmptyPageName : String;
begin
 Result := f_EmptyPageName;
end;

procedure TpcHistory.pm_SetEmptyPageName(const Value : String);
begin
 f_EmptyPageName := Value;
end;

procedure TpcHistory.pm_SetIsActiveEmpty(aValue : Boolean);
begin
 f_IsActiveEmpty := aValue;
end;

procedure TpcHistory.Clear;
begin
 f_IsActiveEmpty := False;
 f_EmptyPageName := '';
 FillChar(f_GuidForm, SizeOf(TGUID), 0);
end;

procedure TpcHistory.Assign(const aHistory : IpcHistory);
begin
 f_IsActiveEmpty := aHistory.IsActiveEmpty;
 f_GuidForm := aHistory.GuidForm;
 f_EmptyPageName := aHistory.EmptyPageName;
end;
{$EndIf Nemesis}

{ TStackPointers }

{$IfDef ElPackNeedEverest}
constructor TStackPointers.Create(anObject : TObject = nil);
//override;
{$Else}
constructor TStackPointers.Create;
{$EndIf  ElPackNeedEverest}
begin
 inherited Create;
 f_Offset := -1;
 SetLength(f_List, 10);
 InitList;
end;

{$IfDef ElPackNeedEverest}
procedure TStackPointers.Cleanup;
{$Else  ElPackNeedEverest}
destructor TStackPointers.Destroy;
{$EndIf ElPackNeedEverest}
begin
 f_List := nil;
 inherited;
end;

function TStackPointers.GetCount: Integer;
begin
 Result := High(f_List);
end;

procedure TStackPointers.InitList;
var
 l_Index : Integer;
begin
 f_Offset := -1;
 for l_Index := Low(f_List) to High(f_List) do
  f_List[l_Index] := nil;
end;

procedure TStackPointers.Move(aUp : Boolean);
var
 l_Index, I, J : Integer;
begin
 if aUp and (f_Offset = High(f_List)) then
 begin
  f_Offset := -1;
  Exit;
 end;
 if f_Offset <> -1 then
 begin
  { Инициализация }
  I := f_Offset;
  if not aUp and (f_Offset = 0) then
   Inc(I);
  J := High(f_List);
  if aUp then
   Dec(J);
  { Переместим }
   { Вверх }
   if aUp then
    for l_Index := J downto I do
     f_List[Succ(l_Index)] := f_List[l_Index]
   { Вниз }
   else
    for l_Index := I to J do
     f_List[Pred(l_Index)] := f_List[l_Index];
 end;
 { Новое смещение }
 if aUp then
   Inc(f_Offset)
 else
  if f_Offset > 0 then
   Dec(f_Offset);
end;

procedure TStackPointers.Pop(const aValue : Pointer);
begin
 if f_Offset = -1 then
  f_Offset := High(f_List)
 { Переместим ниже }
 else
  Move(False);
 { Запомним }
 f_List[High(f_List)] := aValue;
end;

function TStackPointers.Push : Pointer;
begin
 Result := f_List[High(f_List)];
 { Выгрузили последний, выходим }
 if f_Offset = High(f_List) then
 begin
  f_Offset := -1;
  Exit;
 end;
 { Переместим выше }
 Move(True);
end;

procedure TStackPointers.SetCount(const Value: Integer);
begin
 if Value > 0 then
  SetLength(f_List, Value);
 InitList;
end;

end.

(*

Version History

2/1/2004

  Unicode hints were shown wrong. Fixed. 

10/25/2003

  Fixed TabHints
  Fixed drawing of tab background with tabs enabled and tab positions other than top

05/31/2003

  Improved alignment speed

05/24/2003

  Popup menus stopped working for tabs. Fixed.

05/04/2003

  Added mouse wheel processing

03/30/2003

  CLX adaptation complete

03/28/2003

  PageControl was remade to operate with client area only

02/12/2003

  Added TElTabSheet.CloseBtnEnabled property

02/08/2003

  Added support for multiline tab captions (are they really needed? :)

01/27/2003

  OnChanging was fired twice when changing TabIndex or calling SelectNextPage. Fixed.

01/14/2003

  Fixed the bug with disabled sheets that didn't make children disabled

12/31/2002

  Centered captions added (CenterTabCaptions property)
  UseFontForTabs property for TElTabSheet added

12/23/2002

  OnGetImageIndex event was not correctly handled

12/01/2002

  Fixed different painting issues

11/27/2002

  For pages with image index = -1 image size is not taken into account when
  calculating tab size

11/18/2002

  Added TCM_ messages

11/11/2002

  Improved arrow keys behaviour

10/19/2002

  TabSheet font is now taken into account when drawing tab caption

10/08/2002

  Fixed setting of the background color in .NetTabs style

10/04/2002

  Remade background drawing on tabsheets.

09/24/2002

  Fixed width calculation for items with hot keys (&)

09/16/2002

  Improved background painting

09/08/2002

  Close button for every (or active only) tab added.

07/11/2002

  Default page becomes active only when it is visible now

06/27/2002

  DefaultPage property added. It can be set in design-time to force activation
  of specified page

05/27/2002

  Added OnDrawTab and changed parameter list for OnMeasureTab

05/15/2002

  Added UseActiveTabFont and ActiveTabFont properties. They let you specify separate
  font for active tab.
  Added TabCursor property

05/05/2002

  Added TabSheet.UseTabColor property to enable use of TabColor (which was useless previously)

05/03/2002

  Added cursor for drag'n'drop operations

04/25/2002

  Added drag'n'drop of the pages.

04/18/2002

  When the page is removed, the next page was erroneously activated. Fixed.

03/21/2002

  Controls on tab sheets didn't get accelerator chars. Fixed.

03/19/2002

  Fixed hint showing - now one can track the hint given

03/10/2002

  PopupComponent is set to tabsheet or pagecontrol when PopupMenu is shown.

03/06/2002

  Added unicode hint

02/28/2002

  VerticalSideCaptions property added.

02/24/2002

  Improved enabling of ScrollRight button in case when the last tab fits
  into view, but is covered with the button

02/22/2002

  Added TabBkColorNetStyle property to control background color of the tabs in NetTabs style.
  Accessible only in run-time

02/03/2002

  Added AngledTabs type

01/14/2002

  Added Shortcuts support for Top/Bottom tab orientations.

01/04/2002

  Slightly improved size calculation and painting of tabs with XP styles enabled
  and images assigned to tabs

12/24/2001

  ShowImages is now True by default.
  ShowImages is now taken into account when calculating the size of the tabs

12/21/2001

  Fixed size calculation and painting of tabs with XP styles enabled

11/28/2001

  Added FlatTabs style

11/21/2001

  Fixed the problem with tab space transparent background with XP styles enabled

10/24/2001

  Now it's possible to set ShowBorder to false with XP styles enabled.

10/21/2001

  Improved painting of tab line when XP styles are enabled.

10/16/2001

  Fixed painting of tab backgrounds when XP styles are enabled.

10/15/2001

  Fixed painting of shadows in TabSheets when XP styles are enabled.
  ActivePage is forcefully made visible when the page control is loaded from
  resource

10/10/2001

  Tab hints are  shown now (optionally).
  TabEnabled behavior improved. Now disabled tab functions in design-time and
  is completely disabled in run-time.

10/09/2001 (c) Akzhan Abdulin

  Windows XP Themes Support Added.

10/03/2001

  Fixed drawing of the line when tab style is in [tabs, net tabs], ShowBorder = false
  and tab position is in [right, bottom]

09/16/2001

  Fixed repainting bug that happened when size of the control is less than some limit

08/30/2001

  Problems with docking fixed
  Problem with ActivePage initial setting fixed
  Now the tab is activated on MouseDown in [Tabs, NetTabs] styles

*)


