{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{
  Misc helpful URLs:

  Implementing a Custom Download Manager
  http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/ext/overview/downloadmgr.asp

  Programming and Reusing the Browser Overviews and Tutorials
  http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/overview/prog_browser_ovw_entry.asp

  About Asynchronous Pluggable Protocols
  http://msdn.microsoft.com/workshop/networking/pluggable/overview/overview.asp

  Element Behaviors in Internet Explorer 5.5
  http://msdn.microsoft.com/msdnmag/issues/1200/cutting/cutting1200.asp

  Binary Behaviors in Internet Explorer 5.5
  http://msdn.microsoft.com/msdnmag/issues/01/01/cutting/cutting0101.asp

  HOWTO: Handle Script Errors as a WebBrowser Control Host
  http://support.microsoft.com/default.aspx?scid=KB;EN-US;q261003

  WebBrowser Customization
  http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/hosting/wbcustomization.asp

  Viva Components!
  http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dndude/html/dude01032000.asp

  The following is the HTML necessary to have IE instantial an element behavior.

  <HTML XMLNS:CUSTOM>
    <HEAD>
      <OBJECT ID="customFactory" CLASSID="clsid:D979404F-4FDD-465F-86DD-64E1B34AA6BA"></OBJECT>
      <?IMPORT NAMESPACE="CUSTOM" IMPLEMENTATION="#customFactory" />
    </HEAD>
    <BODY>
    <CUSTOM:TEST></CUSTOM:TEST>
    </BODY>
  </HTML>

  IElementBehaviorFactory::FindBehavior

  http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/behaviors/reference/ifaces/elementnamespacefactory2/ielementnamespacefactory2.asp

  "Specify the case of the bstrBehavior parameter to be all caps when using
   this method with element behaviors; for attached behaviors specify the
   bstrBehavior parameter in lower case."

  Note: After initially browsing to about:blank the format of the document loaded
        loaded in the browser is unicode.  Therefore to change the encoding to
        ansi you must call LoadFromFile/Stream with ansi data.

}

                                                                                                         

unit WebBrowserEx;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Controls,
  Vcl.Graphics, Vcl.OleCtrls, Winapi.ActiveX, SHDocVw, MSHTML, mshtmcid, idoc,
  System.Contnrs, Mshtmdid, Winapi.URLMon
  {$IFDEF EVENTSINKSUBCOMPONENTS}
  , MSHTMLEvents, SHDocVwEvents;
  {$ELSE}
  ;
  {$ENDIF}

const
  // From mshtml.h
  SID_SHTMLEditServices: TGUID = '{3050f7f9-98b5-11cf-bb82-00aa00bdce0b}';
  //  SID_SElementBehaviorFactory = IID_IElementBehaviorFactory;

  // From downloadmgr.h
  SID_SDownloadManager: TGUID = '{988934A4-064B-11D3-BB80-00104B35E7F9}';

  // SHLGUID.H
  SID_STopLevelBrowser: TGUID = '{4C96BE40-915C-11CF-99D3-00AA004AE837}';

  // From mshtmhst.h  (undocumented)
  CGID_MSHTML: TGUID = '{DE4BA900-59CA-11CF-9592-444553540000}';
  CGID_DocHostCommandHandler: TGUID = '{f38bc242-b950-11d1-8918-00c04fc2c836}';
  DOCHOSTUIDBLCLK_DEFAULT = 0;
  DOCHOSTUIDBLCLK_SHOWPROPERTIES = 1;
  DOCHOSTUIDBLCLK_SHOWCODE = 2;

  // Constants from mshtml.h  (why aren't these in the IDL file!!)
  ELEMENTNAMESPACEFLAGS_ALLOWANYTAG = 1;
  ELEMENTNAMESPACEFLAGS_QUERYFORUNKNOWNTAGS = 2;

  //  IID_IHTMLDocument2: TGUID = '{332C4425-26CB-11D0-B483-00C04FD90119}';
  CLSID_HTMLDocument: TGUID = '{25336920-03F9-11CF-8FD0-00AA00686F13}';

  OLECMDID_OPENNEWWINDOW = 7050;

  GUID_TriEditCommandGroup: TGUID = '{2582F1C0-084E-11d1-9A0E-006097C9B344}';

type
  TControlBorder = (cb3D, cbNone);
  TWebBrowserEx = class;

{ TCustomWebBrowserComponent }

  TCustomWebBrowserComponent = class(TComponent)
  private
    FWebBrowser: TWebBrowserEx;
    FOnBrowserChanged: TNotifyEvent;
  protected
    procedure CheckWebBrowserAssigned;
    procedure CheckDocumentAssigned;
    procedure SetWebBrowser(const Value: TWebBrowserEx); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    property WebBrowser: TWebBrowserEx read FWebBrowser write SetWebBrowser;
    property OnBrowserChanged: TNotifyEvent read FOnBrowserChanged write FOnBrowserChanged;
  end;

{ TWebBrowserServiceProvider }

  TWebBrowserServiceProvider = class(TCustomWebBrowserComponent)
  protected
    FServiceGUID: TGUID;
    procedure SetWebBrowser(const Value: TWebBrowserEx); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ServiceGUID: TGUID read FServiceGUID write FServiceGUID;
  end;

{ TEventDispatchEx }

  TEventDispatchEx = class(TObject, IUnknown, IDispatch)
  private
    FActive: Boolean;
    FConnection: Longint;
    FInternalCount: Integer;
    procedure SetActive(const Value: Boolean);
  protected
    FIID: TGUID;
    function GetEventInterface: IInterface; virtual; abstract;
    { IUnknown }
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function QueryInterface(const IID: TGUID; out Obj): HRESULT; virtual; stdcall;
    { IDispatch }
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount: Integer; LocaleID: Integer; DispIDs: Pointer): HRESULT;
      stdcall;
    function GetTypeInfo(Index: Integer; LocaleID: Integer;
      out TypeInfo): HRESULT; stdcall;
    function GetTypeInfoCount(out Count: Integer): HRESULT; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult: Pointer; ExcepInfo: Pointer;
      ArgErr: Pointer): HRESULT; stdcall;
    function DoInvoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
      VarResult, ExcepInfo, ArgErr: Pointer): HRESULT; virtual;
  public
    destructor Destroy; override;
    property Active: Boolean read FActive write SetActive;
    property IID: TGUID read FIID;
  end;

{ THTMLElementEventDispatch }

  THTMLElementEventDispatch = class(TEventDispatchEx)
  private
    FHTMLElement: IHTMLElement;
  protected
    function GetEventInterface: IInterface; override;
    function DoInvoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
      VarResult, ExcepInfo, ArgErr: Pointer): HRESULT; override;
    function QueryInterface(const IID: TGUID; out Obj): HRESULT; override; stdcall;
  public
    procedure AfterConstruction; override;
    property HTMLElement: IHTMLElement read FHTMLElement write FHTMLElement;
  end;

{ TWebBrowserEventDispatch }

  TWebBrowserEventDispatch = class(TEventDispatchEx)
  protected
    FWebBrowser: TWebBrowserEx;
  public
    property WebBrowser: TWebBrowserEx read FWebBrowser;
  end;

{ TDocEventDispatch - HTMLDocumentEvents2 event sink }

  TDocEventDispatch = class(TWebBrowserEventDispatch)
  protected
    function GetEventInterface: IInterface; override;
    function DoInvoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
      VarResult, ExcepInfo, ArgErr: Pointer): HRESULT; override;
  public
    procedure AfterConstruction; override;
  end;

{ TIFrameDocEventDispatch - used to prevent editing of iframes }

  TIFrameDocEventDispatch = class(TDocEventDispatch)
  private
    FDocument: IHTMLDocument2;
  protected
    function GetEventInterface: IInterface; override;
    function DoInvoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
      VarResult, ExcepInfo, ArgErr: Pointer): HRESULT; override;
  public
    property Document: IHTMLDocument2 read FDocument write FDocument;
  end;

{ TWndEventDispatch - HTMLWindowEvents2 event sink }

  TWndEventDispatch = class(TWebBrowserEventDispatch)
  protected
    function GetEventInterface: IInterface; override;
    function GetHTMLWindow2: IHTMLWindow2;
    function DoInvoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
      VarResult, ExcepInfo, ArgErr: Pointer): HRESULT; override;
  public
    procedure AfterConstruction; override;
    property HTMLWindow2: IHTMLWindow2 read GetHTMLWindow2;
  end;

{ TWebBrowserEvents2Dispatch - DWebBrowserEvents2 event sink }

  TWebBrowserEvents2Dispatch = class(TWebBrowserEventDispatch)
  protected
    function GetEventInterface: IInterface; override;
    procedure DoStatusTextChange(const Text: WideString); virtual;
    procedure DoProgressChange(Progress: Integer; ProgressMax: Integer); virtual;
    procedure DoCommandStateChange(Command: TOleEnum; Enable: WordBool); virtual;
    procedure DoDownloadBegin; virtual;
    procedure DoDownloadComplete; virtual;
    procedure DoTitleChange(const Text: WideString); virtual;
    procedure DoPropertyChange(const szProperty: WideString); virtual;
    procedure DoBeforeNavigate2(const pDisp: IDispatch; var URL: OleVariant; var Flags: OleVariant; var TargetFrameName: OleVariant; var PostData: OleVariant; var Headers: OleVariant; var Cancel: WordBool); virtual;
    procedure DoNewWindow2(var ppDisp: IDispatch; var Cancel: WordBool); virtual;
    procedure DoNavigateComplete2(const pDisp: IDispatch; var URL: OleVariant); virtual;
    procedure DoDocumentComplete(const pDisp: IDispatch; var URL: OleVariant); virtual;
    procedure DoOnQuit; virtual;
    procedure DoOnVisible(Visible: WordBool); virtual;
    procedure DoOnToolBar(ToolBar: WordBool); virtual;
    procedure DoOnMenuBar(MenuBar: WordBool); virtual;
    procedure DoOnStatusBar(StatusBar: WordBool); virtual;
    procedure DoOnFullScreen(FullScreen: WordBool); virtual;
    procedure DoOnTheaterMode(TheaterMode: WordBool); virtual;
    procedure DoWindowSetResizable(Resizable: WordBool); virtual;
    procedure DoWindowSetLeft(Left: Integer); virtual;
    procedure DoWindowSetTop(Top: Integer); virtual;
    procedure DoWindowSetWidth(Width: Integer); virtual;
    procedure DoWindowSetHeight(Height: Integer); virtual;
    procedure DoWindowClosing(IsChildWindow: WordBool; var Cancel: WordBool); virtual;
    procedure DoClientToHostWindow(var CX: Integer; var CY: Integer); virtual;
    procedure DoSetSecureLockIcon(SecureLockIcon: Integer); virtual;
    procedure DoFileDownload(var Cancel: WordBool); virtual;
    procedure DoNavigateError(const pDisp: IDispatch; var URL: OleVariant; var Frame: OleVariant; var StatusCode: OleVariant; var Cancel: WordBool); virtual;
    procedure DoPrintTemplateInstantiation(const pDisp: IDispatch); virtual;
    procedure DoPrintTemplateTeardown(const pDisp: IDispatch); virtual;
    procedure DoUpdatePageStatus(const pDisp: IDispatch; var nPage: OleVariant; var fDone: OleVariant); virtual;
    procedure DoPrivacyImpactedStateChange(bImpacted: WordBool); virtual;
    function DoInvoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
      VarResult, ExcepInfo, ArgErr: Pointer): HRESULT; override;
  public
    procedure AfterConstruction; override;
  end;

{ TWebBrowserEx }

  TCurrentElementType = (cetUndefined, cetNone, cetAtCursor, cetTextRange, cetControlRange);
  TElementEditableFlag = (efInnerOrOuterRequired, efInnerRequired, efOuterRequired, efSelectableControlRequired);
  TElementEditableFlags = set of TElementEditableFlag;
  TCommandState = (csSupported, csEnabled, csChecked);
  TCommandStates = set of TCommandState;
  TCommandStateArray = array of _tagOLECMD;
  TWebBrowserEvent = procedure(Sender: TWebBrowserEx; Event: IHTMLEventObj) of object;
  TWebBrowserEventWordBool = function(Sender: TWebBrowserEx; Event: IHTMLEventObj): WordBool of object;
  TWebBrowserNotifyEvent = procedure(Sender: TWebBrowserEx) of object;
  TWndActivateEvent = procedure(Sender: TWebBrowser; Activate: Boolean;
    var hr: HRESULT) of object;
  TCustomWebBrowserCommandUpdater = class;
  TGetExternalDispatchEvent = procedure (Sender: TObject; out ExternalDisp: IDispatch) of object;
  TStatusTextChangeEvent = procedure (Sender: TObject; const Text: string) of object;
  TControlSelectEvent = function(Sender: TWebBrowser; const EventObj: IHTMLEventObj): WordBool of object;
  TControlMoveEvent = function(Sender: TWebBrowser; const EventObj: IHTMLEventObj; DispID: Integer): WordBool of object;
  TControlResizeEvent = function(Sender: TWebBrowser; const EventObj: IHTMLEventObj; DispID: Integer): WordBool of object;
  TResolveRelativePathEvent = procedure(Sender: TWebBrowser; var Path: string) of object;
  TGetDropTargetEvent = procedure(Sender: TObject; const pDropTarget: IDropTarget;
    out ppDropTarget: IDropTarget) of object;
  TShowContextMenuEvent = procedure(Sender: TObject; dwID: UINT; ppt: PtagPOINT; const pcmdtReserved: IUnknown;
     const pdispReserved: IDispatch; var Result: HRESULT) of object;
  TInitMenuPopupEvent = procedure(Sender: TObject; Menu: HMENU; Pos: SmallInt; SystemMenu: Boolean) of object;
  TWindowClosingEvent = procedure(Sender: TObject; IsChildWindow: Boolean; var Cancel: WordBool) of object;
  TGetSelectionObjectEvent = procedure(Sender: TObject; var ppSelectionObject: IHTMLSelectionObject) of object;
  TGetActiveDocumentEvent = procedure(Sender: TObject; var ppDocumentObject: IHTMLDocument) of object;
  TGetHostInfoEvent = function(Sender: TObject; var pInfo: _DOCHOSTUIINFO): HRESULT of object;
  TGetAmbientControlEvent = function(Sender: TObject; var Flags: Integer): HRESULT of object;
  TPreProcessMessageEvent = procedure(Sender: TObject; var Msg: TMsg; out Handled: Boolean) of object;
  TInterceptMouseMessageEvent = procedure(Sender: TObject; var Message: TMessage; out Handled: Boolean) of object;
  TGetElementOfViewLinkDocumentEvent = procedure(Sender: TObject; ADocument: IHTMLDocument; out AElement: IHTMLElement) of object;
  TGetIsEditableElementEvent = procedure(Sender: TObject; AElement: IHTMLElement; AFlags: TElementEditableFlags; out AIsEditable: Boolean) of object;
  TGetIsContentPageEvent = procedure(Sender: TObject; out AIsContentPage: Boolean) of object;
  TGetViewLinkDocumentsEvent = procedure(Sender: TObject; CmdId: TOleEnum; var pDocuments: IInterfaceList) of object;
  TWebBrowserEx = class(TWebBrowser, IUnknown, IDispatch, IDocHostUIHandler, IDocHostUIHandler2,
    IDocHostShowUI, IServiceProvider, IOleCommandTarget, IHTMLChangeSink)
  private
    FBeforeLoadFromStream: TWebBrowserNotifyEvent;
    FBeforeDestroy: TWebBrowserNotifyEvent;
    FUserMode: WordBool;
    FURL: String;
    FControlBorder: TControlBorder;
    FShowScrollBar: Boolean;
    FFlatScrollBar: Boolean;
    FHTMLSelectionObject: IHTMLSelectionObject;
    FHasFocus: Boolean;
    {$IFDEF EVENTSINKSUBCOMPONENTS}
    FDocEventDispatch: TMSHTMLHTMLDocumentEvents2;
    FWndEventDispatch: TMSHTMLHTMLWindowEvents2;
    FWebBrowserEvents2Dispatch: TSHDocVwDWebBrowserEvents2;
    {$ELSE}
    FDocEventDispatch: TDocEventDispatch;
    FWndEventDispatch: TWndEventDispatch;
    FWebBrowserEvents2Dispatch: TWebBrowserEvents2Dispatch;
    {$ENDIF}
    FChangeLog: IHTMLChangeLog;
    FDocEventDispatchCounter: IUnknown;
    FWndEventDispatchCounter: IUnknown;
    FWebBrowserEvents2DispatchCounter: IUnknown;
    FOnMouseOut: TMouseMoveEvent;
    FOnMouseOver: TMouseMoveEvent;
    FAfterUpdate: TNotifyEvent;
    FBeforeUpdate: TNotifyEvent;
    FOnError: TNotifyEvent;
    FOnSelectStart: TNotifyEvent;
    FOnRowExit: TNotifyEvent;
    FOnRowEnter: TNotifyEvent;
    FOnErrorUpdate: TNotifyEvent;
    FOnLoad: TNotifyEvent;
    FOnHelp: TNotifyEvent;
    FOnUnLoad: TNotifyEvent;
    FOnFocus: TNotifyEvent;
    FOnBlur: TNotifyEvent;
    FOnScroll: TNotifyEvent;
    FOnWndResize: TNotifyEvent;
    FBeforeUnload: TNotifyEvent;
    FOnDocWndActivate: TWndActivateEvent;
    FOnFrameWndActivate: TWndActivateEvent;
    FServiceProviders: TComponentList;
    FCommandUpdater: TCustomWebBrowserCommandUpdater;
    FOnReadyStateChange: TNotifyEvent;
    FOnGetExternalDispatch: TGetExternalDispatchEvent;
    FOnStatusTextChange: TStatusTextChangeEvent;
    FOnSelectionChange: TWebBrowserEvent;
    FOnUpdateCommands: TNotifyEvent;
    FOnCancelMode: TNotifyEvent;
    FOnGetDropTarget: TGetDropTargetEvent;
    FOnWindowClosing: TWindowClosingEvent;
    FDisplayServices: IDisplayServices;
    FCaret: IHTMLCaret;
    FMarkupServices: IMarkupServices2;
    FPrimarySelectionServices: ISelectionServices;
    FDefInetExplorerServerProc: Pointer;
    FDefShellObjViewProc: Pointer;
    FShellDocObjViewHandle: THandle;
    FInetExplorerServerHandle: THandle;
    FShellDocObjInstance: Pointer;
    FInetExplorerServerInstance: Pointer;
    FUseDivBlock: Boolean;
    FUseTheme: Boolean;
    FHooksSet: Boolean;
    FAutoComplete: Boolean;
    FOnControlSelect: TControlSelectEvent;
    FOnResolveRelativePath: TResolveRelativePathEvent;
    FOnShowContextMenu: TShowContextMenuEvent;
    FOnInitMenuPopup: TInitMenuPopupEvent;
    FOnOpenNewWindow: TNotifyEvent;
    FOnReloadDocument: TWebBrowserNotifyEvent;
    FOnControlMove: TControlMoveEvent;
    FOnControlResize: TControlResizeEvent;
    FBaseURL: string;
    FOnChange: TNotifyEvent;
    FOnGetSelectionObject: TGetSelectionObjectEvent;
    FOnGetActiveDocument: TGetActiveDocumentEvent;
    FOnGetViewLinkDocuments: TGetViewLinkDocumentsEvent;
    FOnGetElementOfViewLinkDocument: TGetElementOfViewLinkDocumentEvent;
    FOnGetIsEditableElement: TGetIsEditableElementEvent;
    FOnGetIsContentPage: TGetIsContentPageEvent;
    FOnBeforeEditFocus: TWebBrowserEventWordBool;
    FOnGetHostInfo: TGetHostInfoEvent;
    FOnGetAmbientControlInfo: TGetAmbientControlEvent;
    FOnPreProcessMessage: TPreProcessMessageEvent;
    FOnInterceptMouseMessage: TInterceptMouseMessageEvent;
    FCurrentElement: IHTMLElement;
    FCurrentElementType: TCurrentElementType;
    procedure SetUserMode(const Value: WordBool);
    function GetTag(Index: Integer): IHTMLElement;
    function GetDocument2: IHTMLDocument2;
    procedure SetURL(Value: String);
    function GetActiveElement: IHTMLElement;
    function GetCount: Integer;
    procedure SetControlBorder(const Value: TControlBorder);
    procedure SetFlatScrollBar(const Value: Boolean);
    procedure SetShowScrollBar(const Value: Boolean);
    function GetWindow: IHTMLWindow2;
    function GetServiceProvider: IServiceProvider;
    function GetHTMLEditServices: IHTMLEditServices2;
    function GetCommandTarget: IOleCommandTarget;
    function GetDocument3: IHTMLDocument3;
    function GetDisplayServices: IDisplayServices;
    function GetHighlightRenderingServices: IHighlightRenderingServices;
    function GetMarkupServices: IMarkupServices2;
    function GetPrimaryMarkupContainer: IMarkupContainer2;
    function GetDocument4: IHTMLDocument4;
    function GetIHTMLNamespaceCollection: IHTMLNamespaceCollection;
    function GetModified: Boolean;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    function GetCaret: IHTMLCaret;
    procedure CMRecreatewnd(var Message: TMessage); message CM_RECREATEWND;
    procedure SetCommandUpdater(const Value: TCustomWebBrowserCommandUpdater);
    procedure WMParentNotify(var Message: TWMParentNotify); message WM_PARENTNOTIFY;
    function GetOverrideCursor: Boolean;
    procedure SetOverrideCursor(const Value: Boolean);
    procedure SetModified(const Value: Boolean);
    function GetActiveDocument: IHTMLDocument;
    function GetCurrentElement: IHTMLElement;
    function GetCurrentElementType: TCurrentElementType;
    procedure ClearCurrentElement;
  protected
    FBackEnabled: Boolean;
    FForwardEnabled: Boolean;
    procedure ShellWndProc(var Message: TMessage; Wnd: HWnd; WndProc: Pointer);
    procedure DestroyWindowHandle; override;
    procedure DoStatusTextChange(const Text: string);
    procedure DoResolveRelativePath(var Path: string);
    function  DoOnControlSelect(const EventObj: IHTMLEventObj): WordBool; safecall;
    function  DoOnControlMove(const EventObj: IHTMLEventObj;
      DispID: Integer): WordBool;
    function  DoOnControlResize(const EventObj: IHTMLEventObj;
      DispID: Integer): WordBool;
    function  DoBeforeEditFocus(const EventObj: IHTMLEventObj;
      const DispID: Integer): WordBool;
    procedure DoCommandStateChange(Command: TOleEnum; Enable: WordBool);
    procedure DoUpdateCommands;
    procedure Loaded; override;
    procedure HookChildWindows;
    procedure UnHookChildWindows;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ShellDocObjWndProc(var Message: TMessage);
    procedure InetExplorerServerWndProc(var Message: TMessage);

    { IDispatch }
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
    { IDocHostShowUI }
    function ShowMessage(hwnd: THandle;lpstrText: POLESTR;lpstrCaption: POLESTR;
      dwType: longint;lpstrHelpFile: POLESTR;dwHelpContext: longint;
      var plResult: LRESULT): HRESULT; stdcall;
    function ShowHelp(hwnd: THandle; pszHelpFile: POLESTR; uCommand: UINT;
      dwData: longint; ptMouse: TPoint; var pDispachObjectHit: IDispatch): HRESULT; stdcall;
    { IDocHostUIHandler }
    function EnableModeless(fEnable: Integer): HResult; stdcall;
    function FilterDataObject(const pDO: IDataObject; out ppDORet: IDataObject): HResult; stdcall;
    function GetDropTarget(const pDropTarget: IDropTarget; out ppDropTarget: IDropTarget): HResult; stdcall;
    function GetExternal(out ppDispatch: IDispatch): HResult; stdcall;
    function GetHostInfo(var pInfo: _DOCHOSTUIINFO): HResult; stdcall;
    function GetOptionKeyPath(out pchKey: PWideChar; dw: UINT): HResult; stdcall;
    function HideUI: HResult; stdcall;
    function OnDocWindowActivate(fActivate: Integer): HResult; stdcall;
    function OnFrameWindowActivate(fActivate: Integer): HResult; stdcall;
    function ResizeBorder(var prcBorder: tagRECT; const pUIWindow: IOleInPlaceUIWindow;
      fRameWindow: Integer): HResult; stdcall;
    function ShowUI(dwID: UINT; const pActiveObject: IOleInPlaceActiveObject;
      const pCommandTarget: IOleCommandTarget; const pFrame: IOleInPlaceFrame;
      const pDoc: IOleInPlaceUIWindow): HResult; stdcall;
    function TranslateAccelerator(var lpmsg: tagMSG; var pguidCmdGroup: TGUID; nCmdID: UINT): HResult; stdcall;
    function TranslateUrl(dwTranslate: UINT; pchURLIn: PWideChar; out ppchURLOut: PWideChar): HResult; stdcall;
    function UpdateUI: HResult; stdcall;
    { IDocHostUIHandler2 }
    function GetOverrideKeyPath(out pchKey: PWideChar; dw: DWORD): HRESULT; stdcall;

    function OnFocus(fGotFocus: BOOL): HResult; stdcall;

    { IServiceProvider }
    function QueryService(const rsid: TGUID; const iid: TGUID; out Obj): HRESULT; stdcall;

    { IOleCommandTarget }
    function QueryStatus(CmdGroup: PGUID; cCmds: Cardinal;
      prgCmds: POleCmd; CmdText: POleCmdText): HResult; stdcall;
    function Exec(CmdGroup: PGUID; nCmdID, nCmdexecopt: DWORD;
      const vaIn: OleVariant; var vaOut: OleVariant): HResult; stdcall;
{    function QueryStatus(const pguidCmdGroup: PGUID; cCmds: UINT; prgCmds: POleCmd;
      pCmdText: PtagOLECMDTEXT): HResult; stdcall;
    function Exec(const pguidCmdGroup: PGUID; nCmdID: UINT; nCmdexecopt: UINT;
      pvaIn: POleVariant; pvaOut: POleVariant): HResult; stdcall;}

    { IHTMLChangeSink }
    function Notify: HRESULT; stdcall;

    { TOleControl }
    procedure InvokeEvent(DispID: TDispID; var Params: TDispParams); override;
    procedure MouseOut(Shift: TShiftState; X, Y: Integer); dynamic;
    procedure MouseOver(Shift: TShiftState; X, Y: Integer); dynamic;
    procedure DoError; dynamic;
    procedure DoBeforeUpdate; dynamic;
    procedure DoAfterUpdate; dynamic;
    procedure DoReadyStateChange; dynamic;

    { TWndEventDispatch events }
    procedure DoWndResize; dynamic;
    procedure DoScroll; dynamic;
    procedure DoFocus; dynamic;
    procedure DoBlur; dynamic;
    procedure DoHelp; dynamic;
    procedure DoLoad; dynamic;
    procedure DoUnLoad; dynamic;
    procedure DoBeforeUnLoad; dynamic;

    { TDocEventDispatch }
    procedure ErrorUpdate; dynamic;
    procedure RowEnter; dynamic;
    procedure RowExit; dynamic;
    procedure SelectStart; dynamic;
    procedure SelectionChange; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function PreProcessMessage(var Msg: TMsg): Boolean; override;
    procedure DoCommand(const CmdStr: String); overload;
    procedure DoCommand(const Cmd: TOleEnum; InParam: OleVariant;
      OutParam: OleVariant); overload;
    function CommandState(const CmdID: TOleEnum): TCommandStates; overload;
    function CommandState(Cmds: TCommandStateArray): TCommandStateArray; overload;
    function ShowContextMenu(dwID: UINT; ppt: PtagPOINT; const pcmdtReserved: IUnknown;
       const pdispReserved: IDispatch): HResult; stdcall;
    procedure ForceSelectionChange;
    procedure Bold;
    function Focused: Boolean; override;
    procedure Italic;
    procedure Underline;
    procedure CutToClipBoard;
    procedure CopyToClipBoard;
    procedure PasteFromClipBoard;
    procedure Delete;
    procedure Undo;
    procedure Redo;
    procedure SelectAll;

    procedure Clear;
    function SelLength: Integer;
    function Selection: IHTMLSelectionObject;
    procedure CreateBookmark;
    procedure Overwrite;
    function GetViewLinkDocuments(CmdId: TOleEnum): IInterfaceList;
    function GetElementOfViewLinkDocument(ADocument: IHTMLDocument): IHTMLElement;
    function GetIsEditableElement(AElement: IHTMLElement; AFlags: TElementEditableFlags): Boolean;
    function GetIsContentPage: Boolean;

    { Print Operations }
    procedure Print;
    procedure PageSetup;
    procedure PrintPreview;

    { File Operations }
    procedure ClearDirtyFlag;
    procedure Open;
    procedure Save;
    procedure SaveAs;
    procedure LoadFromStream(S: TStream);
    procedure LoadFromFile(const FileName: string); virtual;
    procedure SaveToStream(S: TStream);
    procedure SaveToFile(const FileName: string); virtual;
    procedure ViewSource;

    function GetSelectionServices: ISelectionServices;

    procedure RegisterServiceProvider(Provider: TWebBrowserServiceProvider);
    procedure UnRegisterServiceProvider(Provider: TWebBrowserServiceProvider);

    property BackEnabled: Boolean read FBackEnabled;
    property Caret: IHTMLCaret read GetCaret;
    property CommandUpdater: TCustomWebBrowserCommandUpdater read FCommandUpdater write SetCommandUpdater;
    property ForwardEnabled: Boolean read FForwardEnabled;
    property CommandTarget: IOleCommandTarget read GetCommandTarget;
    property DisplayServices: IDisplayServices read GetDisplayServices;
    property Document2: IHTMLDocument2 read GetDocument2;
    property Document3: IHTMLDocument3 read GetDocument3;
    property Document4: IHTMLDocument4 read GetDocument4;
    property HTMLEditServices: IHTMLEditServices2 read GetHTMLEditServices;
    property HighlightRenderingServices: IHighlightRenderingServices read GetHighlightRenderingServices;
    property MarkupServices: IMarkupServices2 read GetMarkupServices;
    property Modified: Boolean read GetModified write SetModified;
    property Namespaces: IHTMLNamespaceCollection read GetIHTMLNamespaceCollection;
    property OverrideCursor: Boolean read GetOverrideCursor write SetOverrideCursor;
    property PrimaryMarkupContainer: IMarkupContainer2 read GetPrimaryMarkupContainer;
    property ServiceProvider: IServiceProvider read GetServiceProvider;
    property SelectionServices: ISelectionServices read GetSelectionServices;
    property  ShellDocObjViewHandle: THandle read FShellDocObjViewHandle;
    property InetExplorerServerHandle: THandle read FInetExplorerServerHandle;
    property ActiveElement: IHTMLElement read GetActiveElement;
    property Count: Integer read GetCount;
    property Tags[Index: Integer]: IHTMLElement read GetTag;
    property Window: IHTMLWindow2 read GetWindow;
    {$IFNDEF EVENTSINKSUBCOMPONENTS}
    property DocEvents: TDocEventDispatch read FDocEventDispatch;
    property WndEvents: TWndEventDispatch read FWndEventDispatch;
    property WebBrowserEvents: TWebBrowserEvents2Dispatch read FWebBrowserEvents2Dispatch;
    {$ENDIF}
    property CurrentElement: IHTMLElement read GetCurrentElement;
    property CurrentElementType: TCurrentElementType read GetCurrentElementType;
  published
    property AutoComplete: Boolean read FAutoComplete write FAutoComplete;
    property ActiveDocument: IHTMLDocument read GetActiveDocument;
    property BaseURL: string read FBaseURL write FBaseURL;
    property BeforeDestroy: TWebBrowserNotifyEvent read FBeforeDestroy write FBeforeDestroy;
    {$IFDEF EVENTSINKSUBCOMPONENTS}
    property DocEvents: TMSHTMLHTMLDocumentEvents2 read FDocEventDispatch
      write FDocEventDispatch;
    property WndEvents: TMSHTMLHTMLWindowEvents2 read FWndEventDispatch
      write FWndEventDispatch;
    property WebBrowserEvents: TSHDocVwDWebBrowserEvents2 read FWebBrowserEvents2Dispatch
      write FWebBrowserEvents2Dispatch;
    {$ENDIF}
    property Constraints;
    property FlatScrollBar: Boolean read FFlatScrollBar write SetFlatScrollBar default False;
    property ShowScrollBar: Boolean read FShowScrollBar write SetShowScrollBar default True;
    property ControlBorder: TControlBorder read FControlBorder write SetControlBorder;
    property UserMode: WordBool read FUserMode write SetUserMode;
    property UseDivBlock: Boolean read FUseDivBlock write FUseDivBlock;
    property UseTheme: Boolean read FUseTheme write FUseTheme;
    property URL: String read FURL write SetURL;
    property BeforeLoadFromStream: TWebBrowserNotifyEvent read FBeforeLoadFromStream
      write FBeforeLoadFromStream;
    property BeforeUpdate: TNotifyEvent read FBeforeUpdate write FBeforeUpdate;
    property AfterUpdate: TNotifyEvent read FAfterUpdate write FAfterUpdate;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnDblClick;
    property OnCancelMode: TNotifyEvent read FOnCancelMode write FOnCancelMode;
    property OnClick;
    property OnError: TNotifyEvent read FOnError write FOnError;
    property OnErrorUpdate: TNotifyEvent read FOnErrorUpdate write FOnErrorUpdate;
    property OnGetAmbientControlInfo: TGetAmbientControlEvent read FOnGetAmbientControlInfo write FOnGetAmbientControlInfo;
    property OnGetHostInfo: TGetHostInfoEvent read FOnGetHostInfo write FOnGetHostInfo;
    property OnReloadDocument: TWebBrowserNotifyEvent read FOnReloadDocument write FOnReloadDocument;
    property OnResolveRelativePath: TResolveRelativePathEvent read FOnResolveRelativePath
      write FOnResolveRelativePath;
    property OnPreprocessMessage: TPreProcessMessageEvent read FOnPreprocessMessage write FOnPreprocessMessage;
    property OnInterceptMouseMessage: TInterceptMouseMessageEvent read FOnInterceptMouseMessage write FOnInterceptMouseMessage;
    { IDocHostUIHandler }
    property OnDocWndActivate: TWndActivateEvent read FOnDocWndActivate write FOnDocWndActivate;
    property OnFrameWndActivate: TWndActivateEvent read FOnFrameWndActivate write FOnFrameWndActivate;
    property OnGetExternalDispatch: TGetExternalDispatchEvent read FOnGetExternalDispatch write FOnGetExternalDispatch;
    property OnStatusTextChange: TStatusTextChangeEvent read FOnStatusTextChange write FOnStatusTextChange;
    property OnGetDropTarget: TGetDropTargetEvent read FOnGetDropTarget write FOnGetDropTarget;
    property OnGetSelectionObject: TGetSelectionObjectEvent read FOnGetSelectionObject write FOnGetSelectionObject;
    property OnGetActiveDocument: TGetActiveDocumentEvent read FOnGetActiveDocument write FOnGetActiveDocument;
    property OnGetViewLinkDocuments: TGetViewLinkDocumentsEvent read FOnGetViewLinkDocuments write FOnGetViewLinkDocuments;
    property OnGetElementOfViewLinkDocument: TGetElementOfViewLinkDocumentEvent read FOnGetElementOfViewLinkDocument write FOnGetElementOfViewLinkDocument;
    property OnGetIsEditableElement: TGetIsEditableElementEvent read FOnGetIsEditableElement write FOnGetIsEditableElement;
    property OnGetIsContentPage: TGetIsContentPageEvent read FOnGetIsContentPage write FOnGetIsContentPage;
    property OnShowContextMenu: TShowContextMenuEvent read FOnShowContextMenu write FOnShowContextMenu;
    property OnInitMenuPopup: TInitMenuPopupEvent read FOnInitMenuPopup write FOnInitMenuPopup;
    property OnOpenNewWindow: TNotifyEvent read FOnOpenNewWindow write FOnOpenNewWindow;
    property OnWindowClosing: TWindowClosingEvent read FOnWindowClosing write FOnWindowClosing;
    { TWndEventDispatch events }
    property BeforeUnload: TNotifyEvent read FBeforeUnload write FBeforeUnload;
    property OnBlur: TNotifyEvent read FOnBlur write FOnBlur;
//    property OnFocus: TNotifyEvent read FOnFocus write FOnFocus;
    property OnHelp: TNotifyEvent read FOnHelp write FOnHelp;
    property OnLoad: TNotifyEvent read FOnLoad write FOnLoad;
    property OnUnLoad: TNotifyEvent read FOnUnLoad write FOnUnLoad;
    property OnWndResize: TNotifyEvent read FOnWndResize write FOnWndResize;
    property OnScroll: TNotifyEvent read FOnScroll write FOnScroll;

    { TDocEventDispatch events }
    property OnReadyStateChange: TNotifyEvent read FOnReadyStateChange
      write FOnReadyStateChange;
    property OnSelectionChange: TWebBrowserEvent read FOnSelectionChange
      write FOnSelectionChange;
    property OnBeforeEditFocus: TWebBrowserEventWordBool read FOnBeforeEditFocus
      write FOnBeforeEditFocus;

    { WebBrowser Events }
    property OnUpdateCommands: TNotifyEvent read FOnUpdateCommands write FOnUpdateCommands;
    property OnControlSelect: TControlSelectEvent read FOnControlSelect write FOnControlSelect;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseOut: TMouseMoveEvent read FOnMouseOut write FOnMouseOut;
    property OnMouseOver: TMouseMoveEvent read FOnMouseOver write FOnMouseOver;
    property OnRowEnter: TNotifyEvent read FOnRowEnter write FOnRowEnter;
    property OnRowExit: TNotifyEvent read FOnRowExit write FOnRowExit;
    property OnSelectStart: TNotifyEvent read FOnSelectStart write FOnSelectStart;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnControlMove: TControlMoveEvent read FOnControlMove write FOnControlMove;
    property OnControlResize: TControlResizeEvent read FOnControlResize write FOnControlResize;
  end;

{ TWebBrowserCommandUpdater

    This class was introduced to minimize the impact of calling QueryStatus
    multiple times with only a single command ID.  This class collects all of
    the command IDs to be queried and queries them at one time thus saving
    multiple calls.  Actions can simply check CommandUpdater.CommandState
    to retrieve the state of a registered command. }

  // So far we only have identifiers for the property changes that affect asp controls
  TElementProperty = (epWidth, epHeight);
  TElementProperties = set of TElementProperty;
  TCommandUpdaterEvent = procedure(Sender: TCustomWebBrowserCommandUpdater;
    CmdID: Cardinal) of object;
  TCommandUpdaterBeforeExecuteEvent = procedure(Sender: TCustomWebBrowserCommandUpdater; CmdID: Cardinal; var Executed: Boolean) of object;
  TSaveActionStateEvent = procedure(Sender: TCustomWebBrowserCommandUpdater; Action: TObject;
    State: TCommandState; Value: Boolean) of object;
  TGetActionStateEvent = procedure(Sender: TCustomWebBrowserCommandUpdater;
    Action: TObject; State: TCommandState; var Value: Boolean; var HaveState: Boolean) of object;
  TElementPropertiesChangedEvent = procedure(Sender: TCustomWebBrowserCommandUpdater; Element: IHTMLElement;
   Properties: TElementProperties) of object;
  TFilterCommandStateEvent = procedure(Sender: TCustomWebBrowserCommandUpdater;
   CmdID: TOleEnum; var State: TCommandStates) of object;
  TCustomWebBrowserCommandUpdater = class(TCustomWebBrowserComponent)
  private
    FCmds: TCommandStateArray;
    FOnUpdateCommands: TCommandUpdaterEvent;
    FBeforeCommand: TCommandUpdaterBeforeExecuteEvent;
    FAfterCommand: TCommandUpdaterEvent;
    FOnGetActionState: TGetActionStateEvent;
    FOnSaveActionState: TSaveActionStateEvent;
    FOnElementPropertiesChanged: TElementPropertiesChangedEvent;
    FOnFilterCommandState: TFilterCommandStateEvent;
    procedure QuickSort(L, R: Integer);
    function Find(const CmdID: TOleEnum; var Index: Integer): Boolean;
  protected
    procedure SetWebBrowser(const Value: TWebBrowserEx); override;
  public
    function CommandState(CmdID: TOleEnum): TCommandStates;
    procedure DoElementPropertiesChanged(Element: IHTMLElement; Properties: TElementProperties);
    procedure DoAfterCommand(CmdID: Cardinal);
    procedure DoBeforeCommand(CmdID: Cardinal; var Executed: Boolean);
    function GetActionState(Action: TObject; State: TCommandState; Value: Boolean): Boolean;
    procedure RegisterCommand(CmdID: Cardinal);
    procedure RegisterCommands(CmdIDs: array of Cardinal);
    procedure SaveActionState(Action: TObject; State: TCommandState; Value: Boolean);
    procedure UnRegisterCommand(CmdID: Cardinal);
    procedure UnRegisterCommands(CmdIDs: array of Cardinal);
    // UpdateCommands can optionally update a single command or all registered
    // commands, the default is all commands.
    procedure UpdateCommands(CmdID: Cardinal = 0);
    property AfterCommand: TCommandUpdaterEvent read FAfterCommand write FAfterCommand;
    property BeforeCommand: TCommandUpdaterBeforeExecuteEvent read FBeforeCommand write FBeforeCommand;
    property OnUpdateCommands: TCommandUpdaterEvent read FOnUpdateCommands
      write FOnUpdateCommands;
    property OnGetActionState: TGetActionStateEvent read FOnGetActionState
      write FOnGetActionState;
    property OnSaveActionState: TSaveActionStateEvent read FOnSaveActionState
      write FOnSaveActionState;
    property OnElementPropertiesChanged: TElementPropertiesChangedEvent read FOnElementPropertiesChanged
      write FOnElementPropertiesChanged;
    property OnFilterCommandState: TFilterCommandStateEvent read FOnFilterCommandState write FOnFilterCommandState;
  end;

   TWebBrowserCommandUpdater = class(TCustomWebBrowserCommandUpdater)
   published
    property WebBrowser;
    property AfterCommand;
    property BeforeCommand;
    property OnBrowserChanged;
    property OnUpdateCommands;
    property OnGetActionState;
    property OnSaveActionState;
    property OnElementPropertiesChanged;
   end;

function SafeCreateRange(WebBrowserEx: TWebBrowserEx): IDispatch;
function SafeCreateControlRange(WebBrowserEx: TWebBrowserEx): IHTMLControlRange;


implementation

uses Vcl.Forms, Vcl.Menus, System.Variants, System.Win.ComObj, ExDispID, Vcl.Dialogs,
  Winapi.ShlObj, WBComp, IEConst;

const
  // Constants from mshtmhst.h
  DOCHOSTUIFLAG_DIALOG    = $1;
  DOCHOSTUIFLAG_DISABLE_HELP_MENU = $2;
  DOCHOSTUIFLAG_NO3DBORDER        = $4;
  DOCHOSTUIFLAG_SCROLL_NO = $8;
  DOCHOSTUIFLAG_DISABLE_SCRIPT_INACTIVE   = $10;
  DOCHOSTUIFLAG_OPENNEWWIN        = $20;
  DOCHOSTUIFLAG_DISABLE_OFFSCREEN = $40;
  DOCHOSTUIFLAG_FLAT_SCROLLBAR    = $80;
  DOCHOSTUIFLAG_DIV_BLOCKDEFAULT  = $100;
  DOCHOSTUIFLAG_ACTIVATE_CLIENTHIT_ONLY   = $200;
  DOCHOSTUIFLAG_OVERRIDEBEHAVIORFACTORY   = $400;
  DOCHOSTUIFLAG_CODEPAGELINKEDFONTS       = $800;
  DOCHOSTUIFLAG_URL_ENCODING_DISABLE_UTF8 = $1000;
  DOCHOSTUIFLAG_URL_ENCODING_ENABLE_UTF8  = $2000;
  DOCHOSTUIFLAG_ENABLE_FORMS_AUTOCOMPLETE = $4000;
  DOCHOSTUIFLAG_ENABLE_INPLACE_NAVIGATION = $10000;
  DOCHOSTUIFLAG_IME_ENABLE_RECONVERSION   = $20000;
  DOCHOSTUIFLAG_THEME     = $40000;
  DOCHOSTUIFLAG_NOTHEME   = $80000;
  DOCHOSTUIFLAG_NOPICS    = $100000;
  DOCHOSTUIFLAG_NO3DOUTERBORDER   = $200000;
  DOCHOSTUIFLAG_DISABLE_EDIT_NS_FIXUP	= $400000;
  DOCHOSTUIFLAG_LOCAL_MACHINE_ACCESS_CHECK	= $800000;
  DOCHOSTUIFLAG_DISABLE_UNTRUSTEDPROTOCOL	= $1000000;
  DOCHOSTUIFLAG_ENABLE_ACTIVEX_BLOCK_MODE = $2000000;
  DOCHOSTUIFLAG_ENABLE_ACTIVEX_PROMPT_MODE = $4000000;
  DOCHOSTUIFLAG_ENABLE_ACTIVEX_DEFAULT_MODE = $8000000;

procedure OutputDebugString(P: PChar);
begin
//  Windows.OutputDebugString(P);
end;

procedure BuildPositionalDispIds (pDispIds: PDispIdList; const dps: TDispParams);
var
  i: integer;
begin
                                                                                   
  Assert (pDispIds <> nil);

  { by default, directly arrange in reverse order }
  for i := 0 to dps.cArgs - 1 do
    pDispIds^ [i] := dps.cArgs - 1 - i;

  { check for named args }
  if (dps.cNamedArgs <= 0) then Exit;

  { parse named args }
  for i := 0 to dps.cNamedArgs - 1 do
    pDispIds^ [dps.rgdispidNamedArgs^ [i]] := i;
end;

function SafeCreateControlRange(WebBrowserEx: TWebBrowserEx): IHTMLControlRange;
var
  Selection: IHTMLSelectionObject;
begin
  Result := nil;
  if WebBrowserEx = nil then exit;
  try
    Selection := WebBrowserEx.Selection;
    if Selection <> nil then
      if Selection.type_ = 'None' then
        Result := nil
      else
        Supports(Selection.createRange, IHTMLControlRange, Result)
    else
      Result := nil;
  except
    // Silent exceptions that occur when document is
    //  <body><frameset rows="*,5*"/><html></html></body>
    Result := nil;
  end;
end;

function SafeCreateRange(WebBrowserEx: TWebBrowserEx): IDispatch;
var
  Selection: IHTMLSelectionObject;
begin
  Result := nil;
  if WebBrowserEx = nil then exit;
  try
    Selection := WebBrowserEx.Selection;
    if (Selection <> nil) and (Selection.type_ <> 'None') then
      Result := Selection.createRange
    else
      Result := nil;
  except
    // Silent exceptions that occur when document is
    //  <body><frameset rows="*,5*"/><html></html></body>
    Result := nil;
  end;
end;

{ TCustomWebBrowserComponent }

procedure TCustomWebBrowserComponent.CheckDocumentAssigned;
begin
  CheckWebBrowserAssigned;
  if WebBrowser.Document = nil then
    raise Exception.Create(sNoPageLoaded);
end;

procedure TCustomWebBrowserComponent.CheckWebBrowserAssigned;
begin
  if FWebBrowser = nil then
    raise Exception.CreateFmt(sWebBrowserNotAssigned, [Name]);
end;

procedure TCustomWebBrowserComponent.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FWebBrowser) then
    FWebBrowser := nil;
end;

procedure TCustomWebBrowserComponent.SetWebBrowser(const Value: TWebBrowserEx);
begin
  if FWebBrowser <> Value then
  begin
    if Assigned(FWebBrowser) then
      FWebBrowser.RemoveFreeNotification(Self);
    FWebBrowser := Value;
    if Assigned(FWebBrowser) then
      FWebBrowser.FreeNotification(Self);
    if Assigned(FOnBrowserChanged) then
      FOnBrowserChanged(Self);
  end;
end;

{ TEventDispatchEx }

destructor TEventDispatchEx.Destroy;
begin
  //  Don't set active here because this will result in a recursive call to destroy
  //SetActive(False);
  inherited;
end;

function TEventDispatchEx.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams;
  pDispIds: PDispIdList; VarResult, ExcepInfo, ArgErr: Pointer): HRESULT;
begin
  Result := DISP_E_MEMBERNOTFOUND;
end;

function TEventDispatchEx.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TEventDispatchEx.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HRESULT;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TEventDispatchEx.GetTypeInfoCount(out Count: Integer): HRESULT;
begin
  Count := 0;
  Result := S_OK;
end;

function TEventDispatchEx.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HRESULT;
var
  dps: TDispParams absolute Params;
  bHasParams: boolean;
  pDispIds: PDispIdList;
  iDispIdsSize: integer;
begin
                                                                                   
  { validity checks }
  if (Flags AND DISPATCH_METHOD = 0) then
    raise Exception.Create(Format(SClassSinkingError, [ClassName]));

  { build pDispIds array. this maybe a bit of overhead but it allows us to
    sink named-argument calls such as Excel's AppEvents, etc! }
  pDispIds := nil;
  iDispIdsSize := 0;
  bHasParams := (dps.cArgs > 0);
  if (bHasParams) then
  begin
    iDispIdsSize := dps.cArgs * SizeOf (TDispId);
    GetMem (pDispIds, iDispIdsSize);
  end;

  try
    { rearrange dispids properly }
    if (bHasParams) then
      BuildPositionalDispIds(pDispIds, dps);
    Result := DoInvoke(DispId, IID, LocaleID, Flags, dps, pDispIds, VarResult,
      ExcepInfo, ArgErr);
  finally
    { free pDispIds array }
    if (bHasParams) then FreeMem (pDispIds, iDispIdsSize);
  end;
end;

function TEventDispatchEx.QueryInterface(const IID: TGUID;
  out Obj): HRESULT;
begin
  if GetInterface(IID, Obj) then
  begin
    Result := S_OK;
    Exit;
  end;
  if IsEqualIID(IID, FIID) then
  begin
    GetInterface(IDispatch, Obj);
    Result := S_OK;
    Exit;
  end;
  Result := E_NOINTERFACE;
end;

procedure TEventDispatchEx.SetActive(const Value: Boolean);
var
  Intf: IInterface;
begin
  if FActive <> Value then
  begin
    FActive := Value;
    Intf := GetEventInterface;
    if Intf <> nil then
      if FActive then
        InterfaceConnect(Intf, FIID, Self, FConnection)
      else
        InterfaceDisconnect(Intf, FIID, FConnection);
  end;
end;

function TEventDispatchEx._AddRef: Integer;
begin
  Result := InterlockedIncrement(FInternalCount);
end;

function TEventDispatchEx._Release: Integer;
begin
  Result := InterlockedDecrement(FInternalCount);
  if Result = 0 then
    Destroy;
end;

{ TDocEventDispatch }

procedure TDocEventDispatch.AfterConstruction;
begin
  inherited;
  FIID := DIID_HTMLDocumentEvents2;
end;

function TDocEventDispatch.GetEventInterface: IInterface;
begin
  Result := nil;
  if Assigned(WebBrowser) and not (csDestroying in WebBrowser.ComponentState) then
    Result := WebBrowser.Document2;
end;

function TDocEventDispatch.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HRESULT;

  function GetShiftState: TShiftState;
  begin
    Result := [];
    if WebBrowser.Window.Event.altKey then
      Include(Result, ssAlt);
    if WebBrowser.Window.Event.ctrlKey then
      Include(Result, ssCtrl);
    if WebBrowser.Window.Event.shiftKey then
      Include(Result, ssShift);
  end;

var
  KeyCh: Char;
  KeyWord: Word;
  IsLocked: OleVariant;
begin
  Result := DISP_E_MEMBERNOTFOUND;
  if not Assigned(WebBrowser) then exit;
  {$IFDEF DEVELOPERS}
//  OutputDebugString(PChar(Format('%x', [Dispid])));
  with WebBrowser, WebBrowser.Window.Event do
    case DispID of
      DISPID_HTMLDOCUMENTEVENTS2_ONHELP: OutputDebugString('HTMLDOCEVENTS2_ONHELP');
      DISPID_HTMLDOCUMENTEVENTS2_ONCLICK: OutputDebugString('HTMLDOCEVENTS2_ONCLICK');
      DISPID_HTMLDOCUMENTEVENTS2_ONDBLCLICK: OutputDebugString('HTMLDOCEVENTS2_ONDBLCLICK');
      DISPID_HTMLDOCUMENTEVENTS2_ONKEYDOWN: OutputDebugString('HTMLDOCEVENTS2_ONKEYDOWN');
      DISPID_HTMLDOCUMENTEVENTS2_ONKEYUP: OutputDebugString('HTMLDOCEVENTS2_ONKEYUP');
      DISPID_HTMLDOCUMENTEVENTS2_ONKEYPRESS: OutputDebugString('HTMLDOCEVENTS2_ONKEYPRESS');
      DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEDOWN: OutputDebugString('HTMLDOCEVENTS2_ONMOUSEDOWN');
      DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEMOVE: OutputDebugString('HTMLDOCEVENTS2_ONMOUSEMOVE');
      DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEUP: OutputDebugString('HTMLDOCEVENTS2_ONMOUSEUP');
      DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEOUT: OutputDebugString('HTMLDOCEVENTS2_ONMOUSEOUT');
      DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEOVER: OutputDebugString('HTMLDOCEVENTS2_ONMOUSEOVER');
      DISPID_HTMLDOCUMENTEVENTS2_ONREADYSTATECHANGE: OutputDebugString('HTMLDOCEVENTS2_ONREADYSTATECHANGE');
      DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREUPDATE: OutputDebugString('HTMLDOCEVENTS2_ONBEFOREUPDATE');
      DISPID_HTMLDOCUMENTEVENTS2_ONAFTERUPDATE: OutputDebugString('HTMLDOCEVENTS2_ONAFTERUPDATE');
      DISPID_HTMLDOCUMENTEVENTS2_ONROWEXIT: OutputDebugString('HTMLDOCEVENTS2_ONROWEXIT');
      DISPID_HTMLDOCUMENTEVENTS2_ONROWENTER: OutputDebugString('HTMLDOCEVENTS2_ONROWENTER');
      DISPID_HTMLDOCUMENTEVENTS2_ONDRAGSTART: OutputDebugString('HTMLDOCEVENTS2_ONDRAGSTART');
      DISPID_HTMLDOCUMENTEVENTS2_ONSELECTSTART: OutputDebugString('HTMLDOCEVENTS2_ONSELECTSTART');
      DISPID_HTMLDOCUMENTEVENTS2_ONERRORUPDATE: OutputDebugString('HTMLDOCEVENTS2_ONERRORUPDATE');
      DISPID_HTMLDOCUMENTEVENTS2_ONCONTEXTMENU: OutputDebugString('HTMLDOCEVENTS2_ONCONTEXTMENU');
      DISPID_HTMLDOCUMENTEVENTS2_ONSTOP: OutputDebugString('HTMLDOCEVENTS2_ONSTOP');
      DISPID_HTMLDOCUMENTEVENTS2_ONROWSDELETE: OutputDebugString('HTMLDOCEVENTS2_ONROWSDELETE');
      DISPID_HTMLDOCUMENTEVENTS2_ONROWSINSERTED: OutputDebugString('HTMLDOCEVENTS2_ONROWSINSERTED');
      DISPID_HTMLDOCUMENTEVENTS2_ONCELLCHANGE: OutputDebugString('HTMLDOCEVENTS2_ONCELLCHANGE');
      DISPID_HTMLDOCUMENTEVENTS2_ONPROPERTYCHANGE: OutputDebugString('HTMLDOCEVENTS2_ONPROPERTYCHANGE');
      DISPID_HTMLDOCUMENTEVENTS2_ONDATASETCHANGED: OutputDebugString('HTMLDOCEVENTS2_ONDATASETCHANGED');
      DISPID_HTMLDOCUMENTEVENTS2_ONDATAAVAILABLE: OutputDebugString('HTMLDOCEVENTS2_ONDATAAVAILABLE');
      DISPID_HTMLDOCUMENTEVENTS2_ONDATASETCOMPLETE: OutputDebugString('HTMLDOCEVENTS2_ONDATASETCOMPLETE');
      DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREEDITFOCUS: OutputDebugString('HTMLDOCEVENTS2_ONBEFOREEDITFOCUS');
      DISPID_HTMLDOCUMENTEVENTS2_ONSELECTIONCHANGE: OutputDebugString('DISPID_HTMLDOCUMENTEVENTS2_ONSELECTIONCHANGE');
      DISPID_HTMLDOCUMENTEVENTS2_ONCONTROLSELECT: OutputDebugString('HTMLDOCEVENTS2_ONCONTROLSELECT');
      DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEWHEEL: OutputDebugString('HTMLDOCEVENTS2_ONMOUSEWHEEL');
      DISPID_HTMLDOCUMENTEVENTS2_ONFOCUSIN: OutputDebugString('HTMLDOCEVENTS2_ONFOCUSIN');
      DISPID_HTMLDOCUMENTEVENTS2_ONFOCUSOUT: OutputDebugString('HTMLDOCEVENTS2_ONFOCUSOUT');
      DISPID_HTMLDOCUMENTEVENTS2_ONACTIVATE: OutputDebugString('HTMLDOCEVENTS2_ONACTIVATE');
      DISPID_HTMLDOCUMENTEVENTS2_ONDEACTIVATE: OutputDebugString('HTMLDOCEVENTS2_ONDEACTIVATE');
      DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREACTIVATE: OutputDebugString('HTMLDOCEVENTS2_ONBEFOREACTIVATE');
      DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREDEACTIVATE: OutputDebugString('HTMLDOCEVENTS2_ONBEFOREDEACTIVATE');
    else
      OutputDebugString(PChar('HTMLDOCEVENT = ' + IntToStr(DispID)));
    end;
  {$ENDIF}
    case DispID of
      DISPID_ONRESIZESTART,
      DISPID_ONRESIZE,
      DISPID_ONRESIZEEND:
        begin
          OleVariant(VarResult^) := WebBrowser.DoOnControlResize(IUnknown(dps.rgvarg^[pDispIds^[0]].unkval) as IHTMLEventObj, DispID);
          Result := S_OK;
        end;
      DISPID_ONMOVESTART,
      DISPID_ONMOVE,
      DISPID_ONMOVEEND:
        begin
          OleVariant(VarResult^) := WebBrowser.DoOnControlMove(IUnknown(dps.rgvarg^[pDispIds^[0]].unkval) as IHTMLEventObj, DispID);
          Result := S_OK;
        end;
      DISPID_HTMLDOCUMENTEVENTS2_ONCONTROLSELECT:
        begin
          OleVariant(VarResult^) := WebBrowser.DoOnControlSelect(IUnknown(dps.rgvarg^[pDispIds^[0]].unkval) as IHTMLEventObj);
          Result := S_OK;
        end;
//      DISPID_HTMLDOCUMENTEVENTS2_ONHELP:;
      DISPID_HTMLDOCUMENTEVENTS2_ONSELECTIONCHANGE:
        begin
          WebBrowser.ClearCurrentElement;
          WebBrowser.SelectionChange;
          Result := S_OK;
        end;
      DISPID_HTMLDOCUMENTEVENTS2_ONCLICK: WebBrowser.Click;
      DISPID_HTMLDOCUMENTEVENTS2_ONDBLCLICK: WebBrowser.DblClick;
      DISPID_HTMLDOCUMENTEVENTS2_ONKEYDOWN:
        try
          KeyWord := WebBrowser.Window.Event.KeyCode;
          WebBrowser.KeyDown(KeyWord, GetShiftState);
          OleVariant (VarResult^) := WebBrowser.Window.Event.KeyCode = KeyWord;
        except
        end;
      DISPID_HTMLDOCUMENTEVENTS2_ONKEYUP:
        begin
          KeyWord := WebBrowser.Window.Event.KeyCode;
          WebBrowser.KeyUp(KeyWord, GetShiftState);
// Assigning to the keycode here cause an Access denied error and further problems see bug 165902
//          KeyCode := KeyWord;
        end;
      DISPID_HTMLDOCUMENTEVENTS2_ONKEYPRESS:
        begin
          KeyCh := Chr(WebBrowser.Window.Event.KeyCode);
          WebBrowser.KeyPress(KeyCh);
//          KeyCode := Ord(KeyCh);
        end;
      DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEDOWN:
        begin
          WebBrowser.MouseDown(TMouseButton(WebBrowser.Window.Event.button),
            GetShiftState, WebBrowser.Window.Event.x, WebBrowser.Window.Event.y);
          // Prevent elements with the Design_Time_Lock attribute from being dragged
          if WebBrowser.Window.Event.button = 1 then
          begin
            IsLocked := WebBrowser.Window.event.srcElement.getAttribute('Design_Time_Lock', 0);  { do not localize }
            if not VarIsNull(IsLocked) and IsLocked then
            begin
              OleVariant(VarResult^) := not WordBool(IsLocked);
              Result := S_False;
            end
            else
            begin
              WebBrowser.CommandTarget.Exec(@CGID_MSHTML, IDM_2D_POSITION,
                OLECMDEXECOPT_DODEFAULT, True, POleVariant(nil)^);
              Result := S_OK;
            end;
          end;
        end;
      DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEMOVE:
        WebBrowser.MouseMove(GetShiftState, WebBrowser.Window.Event.x, WebBrowser.Window.Event.y);
      DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEUP:
      begin
        WebBrowser.MouseUp(TMouseButton(WebBrowser.Window.Event.button),
          GetShiftState, WebBrowser.Window.Event.x, WebBrowser.Window.Event.y);
        WebBrowser.CommandTarget.Exec(@CGID_MSHTML, IDM_2D_POSITION,
          OLECMDEXECOPT_DODEFAULT, False, POleVariant(nil)^);
      end;
      DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEOUT: WebBrowser.MouseOut(GetShiftState, WebBrowser.Window.Event.x, WebBrowser.Window.Event.y);
      DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEOVER: WebBrowser.MouseOver(GetShiftState, WebBrowser.Window.Event.x, WebBrowser.Window.Event.y);
      DISPID_HTMLDOCUMENTEVENTS2_ONREADYSTATECHANGE: WebBrowser.DoReadyStateChange;
      DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREUPDATE: WebBrowser.DoBeforeUpdate;
      DISPID_HTMLDOCUMENTEVENTS2_ONAFTERUPDATE: WebBrowser.DoAfterUpdate;
      DISPID_HTMLDOCUMENTEVENTS2_ONROWEXIT: WebBrowser.RowExit;
      DISPID_HTMLDOCUMENTEVENTS2_ONROWENTER: WebBrowser.RowEnter;
      DISPID_HTMLDOCUMENTEVENTS2_ONDRAGSTART:
        begin
          // Prevent elements with the Design_Time_Lock attribute from being dragged
          IsLocked := WebBrowser.Window.event.srcElement.getAttribute('Design_Time_Lock', 0);  { do not localize }
          if not VarIsNull(IsLocked) and IsLocked then
          begin
            OleVariant(VarResult^) := not WordBool(IsLocked);
            Result := S_False;
          end;
        end;
      DISPID_HTMLDOCUMENTEVENTS2_ONSELECTSTART: WebBrowser.SelectStart;
      DISPID_HTMLDOCUMENTEVENTS2_ONERRORUPDATE: WebBrowser.ErrorUpdate;
      DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREEDITFOCUS:
        begin
          with IUnknown(dps.rgvarg^[pDispIds^[0]].unkval) as IHTMLEventObj do
            if (WideCompareText(srcElement.tagName, 'input') = 0) or            { do not localize }
               (WideCompareText(srcElement.tagName, 'textarea') = 0) or         { do not localize }
               (WideCompareText(srcElement.tagName, 'select') = 0) then         { do not localize }
            begin
              with IUnknown(dps.rgvarg^[pDispIds^[0]].unkval) as IHTMLEventObj do
                cancelBubble := True;
              OleVariant(VarResult^) := False;
              Result := S_False;
            end
            else
              Result := inherited DoInvoke(DispID, IID, LocaleID, Flags, dps, pDispIds,
                VarResult, ExcepInfo, ArgErr);
        end;
    else
      Result := inherited DoInvoke(DispID, IID, LocaleID, Flags, dps, pDispIds,
         VarResult, ExcepInfo, ArgErr);
//      if Result <> S_OK then
//        OutputDebugString(PChar(Format('Doc event not handled %x', [Dispid])));
    end;
end;

{ TWndEventDispatch }

procedure TWndEventDispatch.AfterConstruction;
begin
  inherited;
  FIID := DIID_HTMLWindowEvents2;
end;

function TWndEventDispatch.GetEventInterface: IInterface;
begin
  Result := nil;
  if Assigned(WebBrowser) and not (csDestroying in WebBrowser.ComponentState) and
     Assigned(WebBrowser.Document) then
    Result := WebBrowser.Window;
end;

function TWndEventDispatch.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HRESULT;
begin
  Result := DISP_E_MEMBERNOTFOUND;
  if not Assigned(WebBrowser) then exit;
  with WebBrowser do
    case DispID of
      DISPID_HTMLWINDOWEVENTS_ONLOAD  : DoLoad;
      DISPID_HTMLWINDOWEVENTS_ONUNLOAD:
      begin
        ClearCurrentElement;
        DoUnload;
      end;
      DISPID_HTMLWINDOWEVENTS_ONHELP  : DoHelp;
      DISPID_HTMLWINDOWEVENTS_ONFOCUS : DoFocus;
      DISPID_HTMLWINDOWEVENTS_ONBLUR  : DoBlur;
      DISPID_HTMLWINDOWEVENTS_ONERROR : DoError;//!!!
      DISPID_HTMLWINDOWEVENTS_ONRESIZE: DoWndResize;
      DISPID_HTMLWINDOWEVENTS_ONSCROLL: DoScroll;
      DISPID_HTMLWINDOWEVENTS_ONBEFOREUNLOAD: DoBeforeUnload;
    else
      Result := E_NOTIMPL;
//      OutputDebugString('TWndEventDispatch.Invoke - Unhandled Event');
    end;
end;

function TWndEventDispatch.GetHTMLWindow2: IHTMLWindow2;
begin
  Result := GetEventInterface as IHTMLWindow2;
end;

{ TWebBrowserEventDispatch }

procedure TWebBrowserEvents2Dispatch.AfterConstruction;
begin
  inherited;
  FIID := DIID_DWebBrowserEvents2;
end;

function TWebBrowserEvents2Dispatch.GetEventInterface: IInterface;
begin
  Result := WebBrowser.DefaultInterface;
end;

procedure TWebBrowserEvents2Dispatch.DoBeforeNavigate2(
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
begin
  // Check pDisp ID to ensure that it's for the top level document
  if pDisp <> WebBrowser.ControlInterface as IDispatch then exit;
  if WebBrowser.Modified then
    Cancel := True;
  WebBrowser.FDocEventDispatch.Active := False;
  WebBrowser.FChangeLog := nil;
end;

procedure TWebBrowserEvents2Dispatch.DoClientToHostWindow(var CX,
  CY: Integer);
begin
  {$IFDEF DEVELOPERS}
  OutputDebugString('DoClientToHostWindow');
  {$ENDIF}
//!!
end;

procedure TWebBrowserEvents2Dispatch.DoCommandStateChange(Command: TOleEnum;
  Enable: WordBool);
begin
  if Command = CSC_UPDATECOMMANDS then
    WebBrowser.CommandUpdater.UpdateCommands
  else if Command = CSC_NAVIGATEFORWARD then
    WebBrowser.FForwardEnabled := Enable
  else if Command = CSC_NAVIGATEBACK then
    WebBrowser.FBackEnabled := Enable;
end;

procedure TWebBrowserEvents2Dispatch.DoDocumentComplete(
  const pDisp: IDispatch; var URL: OleVariant);
begin
  // Check pDisp ID to ensure that it's for the top level document
  if pDisp <> (WebBrowser.ControlInterface as IDispatch) then exit;
  with WebBrowser do
  begin
    FDisplayServices := nil;
    FCaret := nil;
    FMarkupServices := nil;
    FPrimarySelectionServices := nil;
    if (FInetExplorerServerInstance = nil) then
      if HandleAllocated then
      begin
        HookChildWindows;
        {$IFDEF EVENTSINKSUBCOMPONENTS}
        FDocEventDispatch.Connect(Document2);
        FWndEventDispatch.Connect(Window);
        {$ELSE}
        if PrimaryMarkupContainer <> nil then
          PrimaryMarkupContainer.CreateChangeLog(WebBrowser as IHTMLChangeSink, FChangeLog, 1, 0);
        FDocEventDispatch.Active := True;
        FWndEventDispatch.Active := True;
        FWebBrowserEvents2Dispatch.Active := True;
        {$ENDIF}
      end
      else
        if Assigned(FOnReloadDocument) then
          FOnReloadDocument(WebBrowser);
  end;
end;

procedure TWebBrowserEvents2Dispatch.DoDownloadBegin;
begin
end;

procedure TWebBrowserEvents2Dispatch.DoDownloadComplete;
begin
end;

procedure TWebBrowserEvents2Dispatch.DoFileDownload(var Cancel: WordBool);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoNavigateComplete2(
  const pDisp: IDispatch; var URL: OleVariant);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoNavigateError(
  const pDisp: IDispatch; var URL, Frame, StatusCode: OleVariant;
  var Cancel: WordBool);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoNewWindow2(var ppDisp: IDispatch;
  var Cancel: WordBool);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoOnFullScreen(FullScreen: WordBool);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoOnMenuBar(MenuBar: WordBool);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoOnQuit;
begin
end;

procedure TWebBrowserEvents2Dispatch.DoOnStatusBar(StatusBar: WordBool);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoOnTheaterMode(
  TheaterMode: WordBool);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoOnToolBar(ToolBar: WordBool);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoOnVisible(Visible: WordBool);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoPrintTemplateInstantiation(
  const pDisp: IDispatch);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoPrintTemplateTeardown(
  const pDisp: IDispatch);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoPrivacyImpactedStateChange(
  bImpacted: WordBool);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoProgressChange(Progress,
  ProgressMax: Integer);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoPropertyChange(
  const szProperty: WideString);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoSetSecureLockIcon(
  SecureLockIcon: Integer);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoStatusTextChange(
  const Text: WideString);
begin
  WebBrowser.DoStatusTextChange(Text);
end;

procedure TWebBrowserEvents2Dispatch.DoTitleChange(const Text: WideString);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoUpdatePageStatus(
  const pDisp: IDispatch; var nPage, fDone: OleVariant);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoWindowClosing(
  IsChildWindow: WordBool; var Cancel: WordBool);
begin
  with WebBrowser do
    if Assigned(FOnWindowClosing) then
      FOnWindowClosing(WebBrowser, IsChildWindow, Cancel);
end;

procedure TWebBrowserEvents2Dispatch.DoWindowSetHeight(Height: Integer);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoWindowSetLeft(Left: Integer);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoWindowSetResizable(
  Resizable: WordBool);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoWindowSetTop(Top: Integer);
begin
end;

procedure TWebBrowserEvents2Dispatch.DoWindowSetWidth(Width: Integer);
begin
end;

function TWebBrowserEvents2Dispatch.DoInvoke (DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HRESULT;
type
  POleVariant = ^OleVariant;
begin
  Result := DISP_E_MEMBERNOTFOUND;
  case DispId of
    DISPID_STATUSTEXTCHANGE:
    begin
      DoStatusTextChange(dps.rgvarg^ [pDispIds^ [0]].bstrval);
      Result := S_OK;
    end;
    DISPID_PROGRESSCHANGE:
    begin
      DoProgressChange(dps.rgvarg^[pDispIds^[0]].lval, dps.rgvarg^[pDispIds^[1]].lval);
      Result := S_OK;
    end;
    DISPID_COMMANDSTATECHANGE:
    begin
      DoCommandStateChange(TOleEnum(dps.rgvarg^[pDispIds^[0]].lval), dps.rgvarg^[pDispIds^[1]].vbool);
      Result := S_OK;
    end;
    DISPID_DOWNLOADBEGIN:
    begin
      DoDownloadBegin;
      Result := S_OK;
    end;
    DISPID_DOWNLOADCOMPLETE:
    begin
      DoDownloadComplete;
      Result := S_OK;
    end;
    DISPID_TITLECHANGE:
    begin
      DoTitleChange(dps.rgvarg^[pDispIds^[0]].bstrval);
      Result := S_OK;
    end;
    DISPID_PROPERTYCHANGE:
    begin
      DoPropertyChange (dps.rgvarg^[pDispIds^[0]].bstrval);
      Result := S_OK;
    end;
                                                                   
    DISPID_BEFORENAVIGATE2,
    DISPID_BEFORENAVIGATE:
    begin
      {$IFDEF DEVELOPERS}
      OutputDebugString('DoBeforeNavigate/2');
      {$ENDIF}
      DoBeforeNavigate2(IDispatch(dps.rgvarg^[pDispIds^[0]].dispval),
        POleVariant(dps.rgvarg^[pDispIds^[1]].pvarval)^,
        POleVariant(dps.rgvarg^[pDispIds^[2]].pvarval)^,
        POleVariant(dps.rgvarg^[pDispIds^[3]].pvarval)^,
        POleVariant(dps.rgvarg^[pDispIds^[4]].pvarval)^,
        POleVariant(dps.rgvarg^[pDispIds^[5]].pvarval)^,
        dps.rgvarg^[pDispIds^[6]].pbool^);
      Result := S_OK;
    end;
    DISPID_NEWWINDOW2:
    begin
      DoNewWindow2(IDispatch(dps.rgvarg^[pDispIds^[0]].pdispval^),
        dps.rgvarg^[pDispIds^[1]].pbool^);
      Result := S_OK;
    end;
    DISPID_NAVIGATECOMPLETE2:
    begin
      DoNavigateComplete2(IDispatch(dps.rgvarg^[pDispIds^[0]].dispval),
        POleVariant(dps.rgvarg^[pDispIds^[1]].pvarval)^);
      Result := S_OK;
    end;
    DISPID_DOCUMENTCOMPLETE:
    begin
      DoDocumentComplete(IDispatch(dps.rgvarg^[pDispIds^[0]].dispval),
        POleVariant(dps.rgvarg^[pDispIds^[1]].pvarval)^);
      Result := S_OK;
    end;
    DISPID_ONQUIT:
    begin
      DoOnQuit;
      Result := S_OK;
    end;
    DISPID_ONVISIBLE:
    begin
      DoOnVisible(dps.rgvarg^[pDispIds^[0]].vbool);
      Result := S_OK;
    end;
    DISPID_ONTOOLBAR:
    begin
      DoOnToolBar(dps.rgvarg^[pDispIds^[0]].vbool);
      Result := S_OK;
    end;
    DISPID_ONMENUBAR:
    begin
      DoOnMenuBar(dps.rgvarg^[pDispIds^[0]].vbool);
      Result := S_OK;
    end;
    DISPID_ONSTATUSBAR:
    begin
      DoOnStatusBar(dps.rgvarg^[pDispIds^[0]].vbool);
      Result := S_OK;
    end;
    DISPID_ONFULLSCREEN:
    begin
      DoOnFullScreen(dps.rgvarg^[pDispIds^[0]].vbool);
      Result := S_OK;
    end;
    DISPID_ONTHEATERMODE:
    begin
      DoOnTheaterMode(dps.rgvarg^[pDispIds^[0]].vbool);
      Result := S_OK;
    end;
    DISPID_WINDOWSETRESIZABLE:
    begin
      DoWindowSetResizable(dps.rgvarg^[pDispIds^[0]].vbool);
      Result := S_OK;
    end;
    DISPID_WINDOWSETLEFT:
    begin
      DoWindowSetLeft(dps.rgvarg^[pDispIds^[0]].lval);
      Result := S_OK;
    end;
    DISPID_WINDOWSETTOP:
    begin
      DoWindowSetTop(dps.rgvarg^[pDispIds^[0]].lval);
      Result := S_OK;
    end;
    DISPID_WINDOWSETWIDTH:
    begin
      DoWindowSetWidth(dps.rgvarg^[pDispIds^[0]].lval);
      Result := S_OK;
    end;
    DISPID_WINDOWSETHEIGHT:
    begin
      DoWindowSetHeight(dps.rgvarg^[pDispIds^[0]].lval);
      Result := S_OK;
    end;
    DISPID_WINDOWCLOSING:
    begin
      DoWindowClosing(dps.rgvarg^[pDispIds^[0]].vbool, dps.rgvarg^ [pDispIds^ [1]].pbool^);
      Result := S_OK;
    end;
    DISPID_CLIENTTOHOSTWINDOW:
    begin
      DoClientToHostWindow(dps.rgvarg^[pDispIds^[0]].plval^, dps.rgvarg^ [pDispIds^ [1]].plval^);
      Result := S_OK;
    end;
    DISPID_SETSECURELOCKICON:
    begin
      DoSetSecureLockIcon(dps.rgvarg^[pDispIds^[0]].lval);
      Result := S_OK;
    end;
    DISPID_FILEDOWNLOAD:
    begin
      DoFileDownload(dps.rgvarg^[pDispIds^[0]].pbool^);
      Result := S_OK;
    end;
    DISPID_NAVIGATEERROR:
    begin
      DoNavigateError(IDispatch(dps.rgvarg^[pDispIds^[0]].dispval),
        POleVariant(dps.rgvarg^[pDispIds^[1]].pvarval)^,
        POleVariant(dps.rgvarg^[pDispIds^[2]].pvarval)^,
        POleVariant(dps.rgvarg^[pDispIds^[3]].pvarval)^,
        dps.rgvarg^[pDispIds^[4]].pbool^);
      Result := S_OK;
    end;
    DISPID_PRINTTEMPLATEINSTANTIATION:
    begin
      DoPrintTemplateInstantiation(IDispatch(dps.rgvarg^[pDispIds^[0]].dispval));
      Result := S_OK;
    end;
    DISPID_PRINTTEMPLATETEARDOWN:
    begin
      DoPrintTemplateTeardown(IDispatch(dps.rgvarg^[pDispIds^[0]].dispval));
      Result := S_OK;
    end;
    DISPID_UPDATEPAGESTATUS:
    begin
      DoUpdatePageStatus(IDispatch(dps.rgvarg^[pDispIds^[0]].dispval),
        POleVariant(dps.rgvarg^[pDispIds^[1]].pvarval)^,
        POleVariant(dps.rgvarg^[pDispIds^[2]].pvarval)^);
      Result := S_OK;
    end;
    DISPID_PRIVACYIMPACTEDSTATECHANGE:
    begin
      DoPrivacyImpactedStateChange(dps.rgvarg^[pDispIds^[0]].vbool);
      Result := S_OK;
    end;
  end;
end;

{ TWebBrowserEx }

constructor TWebBrowserEx.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FShowScrollBar := True;
  {$IFDEF EVENTSINKSUBCOMPONENTS}
  FDocEventDispatch := TMSHTMLHTMLDocumentEvents2.Create(Self);
  FDocEventDispatch.Name := 'InternalDocEventDispatch';
  FDocEventDispatch.SetSubComponent(True);
  FWndEventDispatch := TMSHTMLHTMLWindowEvents2.Create(Self);
  FWndEventDispatch.Name := 'InternalWndEventDispatch';  { do not localize }
  FWndEventDispatch.SetSubComponent(True);
  FWebBrowserEvents2Dispatch := TSHDocVwDWebBrowserEvents2.Create(Self);
  FWebBrowserEvents2Dispatch.Name := 'InternalWebBrowserEvents2Dispatch';   { do not localize }
  FWebBrowserEvents2Dispatch.SetSubComponent(True);
  FWebBrowserEvents2Dispatch.Connect(DefaultInterface);
  {$ELSE}
  FDocEventDispatch := TDocEventDispatch.Create;
  FDocEventDispatch.FWebBrowser := Self;
  FWndEventDispatch := TWndEventDispatch.Create;
  FWndEventDispatch.FWebBrowser := Self;
  FWebBrowserEvents2Dispatch := TWebBrowserEvents2Dispatch.Create;
  FWebBrowserEvents2Dispatch.FWebBrowser := Self;
  FWebBrowserEvents2Dispatch.Active := True;
  {$ENDIF}
  FDocEventDispatchCounter := FDocEventDispatch as IUnknown;
  FWndEventDispatchCounter := FWndEventDispatch as IUnknown;
  FWebBrowserEvents2DispatchCounter := FWebBrowserEvents2Dispatch as IUnknown;
  FCommandUpdater := TCustomWebBrowserCommandUpdater.Create(Self);
  FCommandUpdater.WebBrowser := Self;
  FCommandUpdater.SetSubComponent(True);
  FCommandUpdater.Name := 'InternalCommandUpdater';   { do not localize }
end;

destructor TWebBrowserEx.Destroy;
begin
  FPrimarySelectionServices := nil;
  inherited Destroy;
{$IFNDEF EVENTSINKSUBCOMPONENTS}
  FDocEventDispatch.Active := False;
  FWndEventDispatch.Active := False;
  FWebBrowserEvents2Dispatch.Active := False;
  FDocEventDispatch.FWebBrowser := nil;
  FWndEventDispatch.FWebBrowser := nil;
  FWebBrowserEvents2Dispatch.FWebBrowser := nil;
{$ENDIF}
  FreeAndNil(FServiceProviders);
end;

procedure TWebBrowserEx.Bold;
begin
  DoCommand('Bold');  { do not localize }
end;

procedure TWebBrowserEx.Clear;
begin
//!!
end;

{function TWebBrowserEx.CommandState(const CmdStr: String): TCommandState;
var
  FHTMLSelectionObject: IHTMLSelectionObject;
  FHTMLRange: IDispatch;
  FHTMLTxtRange: IHTMLTxtRange;
begin
  Result := False;
  FHTMLSelectionObject := Document2.Get_Selection;
  if Assigned(FHTMLSelectionObject) then
  begin
    FHTMLRange := FHTMLSelectionObject.createRange;
    if Assigned(FHTMLRange) then
    begin
      FHTMLRange.QueryInterface(IHTMLTxtRange, FHTMLTxtRange);
      // IHTMLControlRange
      if Assigned(FHTMLTxtRange) then
        Result := FHTMLTxtRange.queryCommandState(CmdStr);
    end;
  end
  else
    Result := False;
end;}

procedure TWebBrowserEx.CopyToClipBoard;
begin
  DoCommand('Copy');  { do not localize }
end;

procedure TWebBrowserEx.CreateBookmark;
begin
//!!
end;

procedure TWebBrowserEx.CutToClipBoard;
begin
  DoCommand('Cut');  { do not localize }
end;

procedure TWebBrowserEx.Delete;
begin
  DoCommand('Delete');  { do not localize }
end;

procedure TWebBrowserEx.DoCommand(const CmdStr: String);
var
  RetVal: OleVariant;
  LDocument2: IHTMLDocument2;
begin
  LDocument2 := GetActiveDocument as IHTMLDocument2;
  if LDocument2 <> nil then
    if LDocument2.QueryCommandSupported(CmdStr) then
      LDocument2.execCommand(CmdStr, True, RetVal);
end;

procedure TWebBrowserEx.DoCommand(const Cmd: TOleEnum; InParam: OleVariant;
  OutParam: OleVariant);
begin
  if CommandTarget <> nil then
    CommandTarget.Exec(@CGID_MSHTML, Cmd, OLECMDEXECOPT_DODEFAULT, InParam, OutParam);
end;

function TWebBrowserEx.EnableModeless(fEnable: Integer): HResult;
begin
  Result := S_FALSE;
//  Result := S_OK;
end;

function TWebBrowserEx.FilterDataObject(const pDO: IDataObject;
  out ppDORet: IDataObject): HResult;
begin
  Result := S_FALSE;
  ppDORet := nil;
end;

function TWebBrowserEx.GetActiveElement: IHTMLElement;
var
  LDocument2: IHTMLDocument2;
begin
  LDocument2 := Document2;
  if LDocument2 <> nil then
    Result := LDocument2.ActiveElement
  else
    Result := nil;
end;

function TWebBrowserEx.GetCount: Integer;
var
  LDocument2: IHTMLDocument2;
begin
  LDocument2 := Document2;
  if LDocument2 <> nil then
    Result := LDocument2.All.Length
  else
    Result := 0;
end;

function TWebBrowserEx.GetCurrentElementType: TCurrentElementType;
begin
  if FCurrentElementType = cetUndefined then
    GetCurrentElement;
  Result := FCurrentElementType;
end;

function TWebBrowserEx.GetCurrentElement: IHTMLElement;
var
  Range: IDispatch;
  TxtRange: IHTMLTxtRange;
  CtrlRange: IHTMLControlRange;
  MarkupPointer: IMarkupPointer;
begin
  if (FCurrentElementType = cetUndefined) or (FCurrentElementType = cetNone) then
  begin
    Assert((DisplayServices <> nil) and
       not (csDesigning in ComponentState));
    Range := SafeCreateRange(Self);
    if Supports(Range, IHTMLControlRange, CtrlRange) then
    begin
      FCurrentElement := CtrlRange.item(0);
      FCurrentElementType := cetControlRange;
    end
    // Check for Text to work around problem where parent element is block elemement
    // preceding cursor
    else if Supports(Range, IHTMLTxtRange, TxtRange) and (TxtRange.Text <> '') then
    //else if Supports(Range, IHTMLTxtRange, TxtRange) then
    begin
      FCurrentElement := TxtRange.parentElement;
      FCurrentElementType := cetTextRange;
    end
    else
    begin
      // Very slow
      OleCheck(MarkupServices.CreateMarkupPointer(MarkupPointer));
      Caret.MoveMarkupPointerToCaret(MarkupPointer);
      MarkupPointer.CurrentScope(FCurrentElement);
      if FCurrentElement <> nil then
        FCurrentElementType := cetAtCursor
      else
        // This may mean that we are still loading
        FCurrentElementType := cetNone;
    end;
  end;
  Result := FCurrentElement;
end;

function TWebBrowserEx.GetDocument2: IHTMLDocument2;
begin
  Supports(Document, IHTMLDocument2, Result);
end;

function TWebBrowserEx.GetDocument3: IHTMLDocument3;
begin
  Supports(Document, IHTMLDocument3, Result);
end;

function TWebBrowserEx.GetDocument4: IHTMLDocument4;
begin
  Supports(Document, IHTMLDocument4, Result);
end;

function TWebBrowserEx.GetIHTMLNamespaceCollection: IHTMLNamespaceCollection;
var
  LDocument4: IHTMLDocument4;
begin
  LDocument4 := Document4;
  if LDocument4 <> nil then
    Result := LDocument4.Namespaces as IHTMLNamespaceCollection;
end;

function TWebBrowserEx.GetDropTarget(const pDropTarget: IDropTarget;
  out ppDropTarget: IDropTarget): HResult;
begin
  if Assigned(FOnGetDropTarget) then
  begin
    ppDropTarget := nil;
    FOnGetDropTarget(Self, pDropTarget, ppDropTarget);
    if ppDropTarget <> nil then
      Result := S_OK
    else
      Result := E_NOTIMPL;
  end
  else
    Result := E_NOTIMPL;
end;

function TWebBrowserEx.GetExternal(out ppDispatch: IDispatch): HResult;
begin
  if Assigned(FOnGetExternalDispatch) then
    FOnGetExternalDispatch(Self, ppDispatch)
  else
    ppDispatch := nil;
  Result := S_OK;
end;

function TWebBrowserEx.GetHostInfo(var pInfo: _DOCHOSTUIINFO): HResult;
const
  BorderStyle: array[TControlBorder] of Integer = (0, DOCHOSTUIFLAG_NO3DBORDER);
  ScrollBarStyle: array[Boolean] of Integer = (DOCHOSTUIFLAG_SCROLL_NO, 0);
  ThemeStyle: array[Boolean] of Integer = (DOCHOSTUIFLAG_NOTHEME, DOCHOSTUIFLAG_THEME);
  AutoCompleteOption: array[Boolean] of Integer = (0, DOCHOSTUIFLAG_ENABLE_FORMS_AUTOCOMPLETE);
  DefaultBlock: array[Boolean] of Integer = (0, DOCHOSTUIFLAG_DIV_BLOCKDEFAULT);
begin
  FillChar(pInfo, SizeOf(pInfo), 0);
  pInfo.cbSize := SizeOf(_DOCHOSTUIINFO);
  pInfo.dwFlags := BorderStyle[FControlBorder] or ScrollBarStyle[FShowScrollBar] or
    ThemeStyle[UseTheme] or AutoCompleteOption[FAutoComplete] or DefaultBlock[UseDivBlock];
  pInfo.dwDoubleClick := 0;//DOCHOSTUIDBLCLK_SHOWPROPERTIES;
  if Assigned(FOnGetHostInfo) then
    Result := FOnGetHostInfo(Self, pInfo)
  else
    Result := S_OK;
end;

function TWebBrowserEx.GetOptionKeyPath(out pchKey: PWideChar;
  dw: UINT): HResult;
begin
  pchKey := nil;
  Result := S_FALSE;  // Use the default registry settings
end;

function TWebBrowserEx.GetTag(Index: Integer): IHTMLElement;
var
  LDocument2: IHTMLDocument2;
begin
  LDocument2 := Document2;
  if LDocument2 <> nil then
    Result := Document2.All.Item(null, Index) as IHTMLElement
  else
    Result := nil;
end;

function TWebBrowserEx.HideUI: HResult;
begin
  Result := S_OK;
end;

function TWebBrowserEx.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
var
  AmbientControlFlags: Integer;
begin
  Result := inherited Invoke(DispID, IID, LocaleID, Flags, Params, VarResult,
    ExcepInfo, ArgErr);
  if (Flags and DISPATCH_PROPERTYGET <> 0) and (VarResult <> nil) then
  begin
    Result := S_OK;
    case DispID of
      DISPID_AMBIENT_DLCONTROL:
      begin
        Result := DISP_E_MEMBERNOTFOUND;
        if Assigned(FOnGetAmbientControlInfo) then
        begin
          AmbientControlFlags := DLCTL_DLIMAGES or DLCTL_VIDEOS or DLCTL_BGSOUNDS;
          Result := FOnGetAmbientControlInfo(Self, AmbientControlFlags);
          PVariant(VarResult)^ := AmbientControlFlags;
        end
      end;
//      DISPID_AMBIENT_USERAGENT = -5513;
//      DISPID_SECURITYDOMAIN    = -5514;
//      DISPID_AMBIENT_PALETTE:
//        Result := DISP_E_MEMBERNOTFOUND;
      DISPID_AMBIENT_USERMODE:
        PVariant(VarResult)^ := FUserMode;
    else
      Result := DISP_E_MEMBERNOTFOUND;
(*
//        AmbientControlFlags := DLCTL_DLIMAGES or DLCTL_VIDEOS or DLCTL_BGSOUNDS;
        TVarData(PVariant(VarResult)^).VType := VT_I4;
//        TVarData(PVariant(VarResult)^).VInteger := AmbientControlFlags;
        if Assigned(FOnGetAmbientControlInfo) then
        begin
          Result := FOnGetAmbientControlInfo(Self, AmbientControlFlags);
          TVarData(PVariant(VarResult)^).VInteger := AmbientControlFlags;
        end
      end;
//      DISPID_AMBIENT_USERAGENT = -5513;
//      DISPID_SECURITYDOMAIN    = -5514;
//      DISPID_AMBIENT_PALETTE:
//        Result := DISP_E_MEMBERNOTFOUND;
      DISPID_AMBIENT_USERMODE:
      begin
        TVarData(PVariant(VarResult)^).VType := VT_I4;
        TVarData(PVariant(VarResult)^).VBoolean := FUserMode;
      end;
    else
      Result := DISP_E_MEMBERNOTFOUND;
*)
    end;
  end;
end;

procedure TWebBrowserEx.Italic;
begin
  DoCommand('Italic');  { do not localize }
end;

function TWebBrowserEx.OnDocWindowActivate(fActivate: Integer): HResult;
begin
  Result := S_OK;
{  if Assigned(FOnDocWndActivate) then
    FOnDocWndActivate(Self, fActivate = 1, Result);
  Result := S_OK;}
end;

function TWebBrowserEx.OnFrameWindowActivate(fActivate: Integer): HResult;
begin
  Result := S_OK;
  if Assigned(FOnFrameWndActivate) then
    FOnFrameWndActivate(Self, fActivate = 1, Result)
  else
    Result := S_OK;
end;

procedure TWebBrowserEx.Open;
begin
  DoCommand(IDM_OPEN, EmptyParam, EmptyParam);
end;

procedure TWebBrowserEx.Overwrite;
begin
  DoCommand('Overwrite');  { do not localize }
end;

procedure TWebBrowserEx.PasteFromClipBoard;
begin
  DoCommand('Paste');  { do not localize }
end;

procedure TWebBrowserEx.Print;
begin
  DoCommand(IDM_PRINT, EmptyParam, EmptyParam);
end;

procedure TWebBrowserEx.PrintPreview;
begin
//!!
end;

procedure TWebBrowserEx.PageSetup;
begin
  DoCommand(IDM_PAGESETUP, EmptyParam, EmptyParam);
end;

function TWebBrowserEx.ResizeBorder(var prcBorder: tagRECT;
  const pUIWindow: IOleInPlaceUIWindow; fRameWindow: Integer): HResult;
begin
  Result := S_OK;
//!!
end;

procedure TWebBrowserEx.Save;
var
  AFile: IPersistFile;
begin
  if Supports(Document, IPersistFile, AFile) and (AFile.IsDirty <> S_FALSE) then
    OleCheck(AFile.Save(nil, True));
end;

procedure TWebBrowserEx.SaveAs;
begin
  DoCommand(IDM_SAVEAS, EmptyParam, EmptyParam);
end;

procedure TWebBrowserEx.SelectAll;
begin
  DoCommand(IDM_SELECTALL, EmptyParam, EmptyParam);
end;

function TWebBrowserEx.SelLength: Integer;
var
  LDocument2: IHTMLDocument2;
  FHTMLRange: IDispatch;
  FHTMLTxtRange: IHTMLTxtRange;
begin
  Result := -1;
//  if (Document2 = nil) or (FDocEventsConnection = 0) then exit;
  if FHTMLSelectionObject = nil then
  begin
    LDocument2 := Document2;
    if LDocument2 <> nil then
      FHTMLSelectionObject := Document2.Get_Selection
    else
      Exit;
  end;      
  if Assigned(FHTMLSelectionObject) then
  begin
    FHTMLRange := FHTMLSelectionObject.createRange;
    if Assigned(FHTMLRange) then
    begin
      FHTMLRange.QueryInterface(IHTMLTxtRange, FHTMLTxtRange);
      if Assigned(FHTMLTxtRange) then
        Result := Length(FHTMLTxtRange.Get_Text);
    end;
  end
  else
    Result := -1;
end;

procedure TWebBrowserEx.SetControlBorder(const Value: TControlBorder);
begin
  FControlBorder := Value;
end;

procedure TWebBrowserEx.SetFlatScrollBar(const Value: Boolean);
begin
  FFlatScrollBar := Value;
end;

procedure TWebBrowserEx.SetShowScrollBar(const Value: Boolean);
begin
  FShowScrollBar := Value;
end;

procedure TWebBrowserEx.SetURL(Value: String);
begin
  FURL := Value;
  FUserMode := True;
  if csDesigning in ComponentState then
    Value := 'about:blank';  { do not localize }
  if not (csLoading in ComponentState) then
    Navigate(FURL);
end;

procedure TWebBrowserEx.SetUserMode(const Value: WordBool);
var
  FOleControl: IOleControl;
begin
  FUserMode := Value;
  if Supports(DefaultDispatch, IOleControl, FOleControl) then
    FOleControl.OnAmbientPropertyChange(DISPID_AMBIENT_USERMODE);
end;

function TWebBrowserEx.ShowContextMenu(dwID: UINT; ppt: PtagPOINT;
  const pcmdtReserved: IUnknown; const pdispReserved: IDispatch): HResult;
var
  LDocument2: IHTMLDocument2;
  E: IHTMLElement;
  P: TPoint;
  S: string;
  LPopupMenu: TPopupMenu;
  Handled: Boolean;
begin
  if Supports(pdispReserved, IHTMLElement, E) then
    S := E.tagName;
  P := Point(ppt.x, ppt.y);
  P := ScreenToClient(P);
  LDocument2 := Document2;
  if LDocument2 <> nil then
    E := Document2.elementFromPoint(P.x, P.y);
  Handled := False;
  DoContextPopup(Point(ppt.x, ppt.y), Handled);
  if not Handled then
  begin
    LPopupMenu := GetPopupMenu;
    if (LPopupMenu <> nil) and LPopupMenu.AutoPopup then
    begin
      SendCancelMode(nil);
      LPopupMenu.PopupComponent := Self;
      PopupMenu.Popup(ppt.x, ppt.y);
      Result := S_OK;
    end else
    begin
      Result := S_FALSE;
      if Assigned(FOnShowContextMenu) then
        FOnShowContextMenu(Self, dwID, ppt, pcmdtReserved, pdispReserved, Result);
    end;
  end else
    Result := S_OK;
end;

{ IDocHostShowUI }

function TWebBrowserEx.ShowHelp(hwnd: THandle;
  pszHelpFile: POLESTR; uCommand: UINT; dwData: longint;
  ptMouse: TPoint; var pDispachObjectHit: IDispatch): HRESULT;
begin
  Result := S_OK;
end;

function TWebBrowserEx.ShowMessage(hwnd: THandle;lpstrText: POLESTR;
  lpstrCaption: POLESTR; dwType: longint; lpstrHelpFile: POLESTR;
  dwHelpContext: longint; var plResult: LRESULT): HRESULT; stdcall;
begin
  Result := S_FALSE;
end;

function TWebBrowserEx.ShowUI(dwID: UINT;
  const pActiveObject: IOleInPlaceActiveObject;
  const pCommandTarget: IOleCommandTarget; const pFrame: IOleInPlaceFrame;
  const pDoc: IOleInPlaceUIWindow): HResult;
begin
  Result := S_FALSE;
end;

function TWebBrowserEx.PreProcessMessage(var Msg: TMsg): Boolean;
var
  KeyMsg: TWMKey;
  Form: TCustomForm;
  Handled: Boolean;
begin
  Result := False;
  if Assigned(FOnPreProcessMessage) then
  begin
    FOnPreProcessMessage(Self, Msg, Handled);
    if Handled then
    begin
      Result := True;
      Exit;
    end;
  end;
  if Msg.message = WM_KEYDOWN then
  begin
    Form := GetParentForm(Self);
    if Assigned(Form) then
    begin
      KeyMsg.Msg := Msg.message;
      KeyMsg.CharCode := Msg.wParam;
      KeyMsg.KeyData := Msg.lParam;
      Result := (KeyboardStateToShiftState <> []) and Form.IsShortCut(KeyMsg);
    end;
  end;
end;

function TWebBrowserEx.TranslateAccelerator(var lpmsg: tagMSG;
  var pguidCmdGroup: TGUID; nCmdID: UINT): HResult;
var
  Form: TCustomForm;
//  Msg: TWMKey;
//  ShortCut: TShortCut;
  Pt: TPoint;
begin
  Result := S_FALSE;
  case lpMsg.message of
    WM_CLOSE: exit;
    WM_SYSKEYDOWN:
      if (GetAsyncKeyState(VK_MENU) < 0) and (lpMsg.wParam = VK_F10) then
        if PopupMenu <> nil then
        begin
          Pt := ClientToScreen(Point(Left, Top));
          PopupMenu.Popup(Pt.X, Pt.Y);
        end;
    WM_KEYDOWN:
      begin
        // Fix bug 200750 Check the virtual keycode
        if ((lpMsg.wParam and $FF) = Ord('N')) then
          if (GetAsyncKeyState(VK_CONTROL) < 0) then
          begin
            Result := S_OK;
            exit;
          end;
      end;
  end;
  Form := GetParentForm(Self);
  if Assigned(Form) then
  begin
{    Msg.Msg := lpmsg.message;
    Msg.CharCode := lpmsg.wParam;
    Msg.KeyData := lpmsg.lParam;
    if (KeyboardStateToShiftState <> []) and Form.IsShortCut(Msg) then
    begin
      lpmsg.message := Msg.Msg;
      lpmsg.wParam := Msg.CharCode;
      lpmsg.lParam := Msg.KeyData;
      Result := S_FALSE;
    end
    else}
      if Form.Perform(lpMsg.message, lpmsg.wParam, lpmsg.lParam) = 0 then
        Result := S_FALSE
      else
        Result := S_OK;
  end;
end;

function TWebBrowserEx.TranslateUrl(dwTranslate: UINT;
  pchURLIn: PWideChar; out ppchURLOut: PWideChar): HResult;
begin
  ppchURLOut := nil;
  Result := S_FALSE;
end;

procedure TWebBrowserEx.Underline;
begin
  DoCommand('Underline');  { do not localize }
end;

procedure TWebBrowserEx.Undo;
begin
  DoCommand(IDM_UNDO, EmptyParam, EmptyParam);
end;

function TWebBrowserEx.UpdateUI: HResult;
begin
  Result := E_NOTIMPL;
end;

function TWebBrowserEx.Selection: IHTMLSelectionObject;
var
  LDocument2: IHTMLDocument2;
begin
  LDocument2 := Document2;
  if LDocument2 <> nil then
    Result := Document2.Get_Selection
  else
    Result := nil;
  if Assigned(FOnGetSelectionObject) then
    FOnGetSelectionObject(Self, Result);
end;

procedure TWebBrowserEx.Redo;
begin
  DoCommand(IDM_REDO, EmptyParam, EmptyParam);
end;

function TWebBrowserEx.GetOverrideKeyPath(out pchKey: PWideChar;
  dw: DWORD): HRESULT;
{var
  Key: WideString;
  Len: Integer;}
begin
{  Key := 'Software\\MyCompany\\MyApp';
  Len := Length(Key);
  pchKey := CoTaskMemAlloc(Len + sizeof(WCHAR));
  Move(Key, pchKey, Len + sizeof(WCHAR));}
  pchKey := nil; // HKEY_CURRENT_USER/Software/YourCompany/YourApp
//  Result := S_OK;
  Result := E_NOTIMPL;
end;

function TWebBrowserEx.GetServiceProvider: IServiceProvider;
begin
  Result := Document2 as IServiceProvider;
end;

function TWebBrowserEx.GetHTMLEditServices: IHTMLEditServices2;
begin
  Result := nil;
  if Assigned(ServiceProvider) then
    OleCheck(ServiceProvider.QueryService(SID_SHTMLEditServices, IID_IHTMLEditServices, Result));
end;

function TWebBrowserEx.GetHighlightRenderingServices: IHighlightRenderingServices;
begin
  Result := Document2 as IHighlightRenderingServices;
end;

procedure TWebBrowserEx.SaveToStream(S: TStream);
var
  Stream: IPersistStreamInit;
  Adapter: IStream;
begin
  if not Assigned(Document) then
    raise Exception.Create(sNoPageLoaded);
  if Supports(Document, IPersistStreamInit, Stream) then
  begin
    Adapter := TStreamAdapter.Create(S);
    OleCheck(Stream.Save(Adapter, false));
    // Adapter freed on IInterface.Release
  end;
end;

type
  TStreamLoadMoniker = class(TInterfacedObject, IMoniker)
  private
    FStream: TStream;
    FMoniker: IMoniker;
    FBaseURL: string;
  protected
    function BindToObject(const bc: IBindCtx; const mkToLeft: IMoniker;
      const iidResult: TGUID; out vResult): HRESULT; stdcall;
    function BindToStorage(const bc: IBindCtx; const mkToLeft: IMoniker;
      const iid: TGUID; out vObj): HRESULT; stdcall;
    function CommonPrefixWith(const mkOther: IMoniker;
      out mkPrefix: IMoniker): HRESULT; stdcall;
    function ComposeWith(const mkRight: IMoniker;
      fOnlyIfNotGeneric: LongBool; out mkComposite: IMoniker): HRESULT; stdcall;
    function Enum(fForward: LongBool;
      out enumMoniker: IEnumMoniker): HRESULT; stdcall;
    function GetClassID(out classID: TGUID): HRESULT; stdcall;
    function GetDisplayName(const bc: IBindCtx; const mkToLeft: IMoniker;
      out pszDisplayName: PWideChar): HRESULT; stdcall;
    function GetSizeMax(out cbSize: Int64): HRESULT; stdcall;
    function GetTimeOfLastChange(const bc: IBindCtx;
      const mkToLeft: IMoniker; out filetime: _FILETIME): HRESULT; stdcall;
    function Hash(out dwHash: Integer): HRESULT; stdcall;
    function Inverse(out mk: IMoniker): HRESULT; stdcall;
    function IsDirty: HRESULT; stdcall;
    function IsEqual(const mkOtherMoniker: IMoniker): HRESULT; stdcall;
    function IsRunning(const bc: IBindCtx; const mkToLeft: IMoniker;
      const mkNewlyRunning: IMoniker): HRESULT; stdcall;
    function IsSystemMoniker(out dwMksys: Integer): HRESULT; stdcall;
    function Load(const stm: IStream): HRESULT; stdcall;
    function ParseDisplayName(const bc: IBindCtx; const mkToLeft: IMoniker;
      pszDisplayName: PWideChar; out chEaten: Integer;
      out mkOut: IMoniker): HRESULT; stdcall;
    function Reduce(const bc: IBindCtx; dwReduceHowFar: Integer;
      mkToLeft: PIMoniker; out mkReduced: IMoniker): HRESULT; stdcall;
    function RelativePathTo(const mkOther: IMoniker;
      out mkRelPath: IMoniker): HRESULT; stdcall;
    function Save(const stm: IStream; fClearDirty: LongBool): HRESULT; stdcall;
  public
    constructor Create(AStream: TStream; BaseURL: string);
  end;

procedure TWebBrowserEx.LoadFromStream(S: TStream);
var
  Moniker: IPersistMoniker;
  BindCtx: IBindCtx;
  LBaseUrl: string;
begin
  if Assigned(FBeforeLoadFromStream) then
    FBeforeLoadFromStream(Self);
  if (Length(Path) > 0) and Supports(Document2, IPersistMoniker, Moniker) then
  begin
    OleCheck(CreateBindCtx(0, BindCtx));
    LBaseUrl := BaseUrl;
    if LBaseUrl = '' then
      LBaseUrl := 'c:';  // prevent invalid parameter
    OleCheck(Moniker.Load(LongBool(0), TStreamLoadMoniker.Create(S, LBaseURL), BindCtx, STGM_READ));
  end;
end;

procedure TWebBrowserEx.ViewSource;
begin
// !!
end;

function TWebBrowserEx.GetActiveDocument: IHTMLDocument;
var
  LDocument: IHTMLDocument;
begin
  if Assigned(FOnGetActiveDocument) then
  begin
    FOnGetActiveDocument(Self, LDocument);
    Result := LDocument as IHTMLDocument2;
  end
  else
    Result := Document2;
end;

function TWebBrowserEx.GetViewLinkDocuments(CmdId: TOleEnum): IInterfaceList;
var
  LDocuments: IInterfaceList;
begin
  if Assigned(FOnGetViewLinkDocuments) then
  begin
    FOnGetViewLinkDocuments(Self, CmdId, LDocuments);
    Result := LDocuments;
  end
  else
    Result := nil;
end;

function TWebBrowserEx.GetElementOfViewLinkDocument(ADocument: IHTMLDocument): IHTMLElement;
var
  LElement: IHTMLElement;
begin
   if Assigned(FOnGetElementOfViewLinkDocument) then
  begin
    FOnGetElementOfViewLinkDocument(Self, ADocument, LElement);
    Result := LElement;
  end
  else
    Result := nil;
end;

function TWebBrowserEx.GetIsEditableElement(AElement: IHTMLElement; AFlags: TElementEditableFlags): Boolean;
var
  LIsEditable: Boolean;
begin
   if Assigned(FOnGetIsEditableElement) then
  begin
    FOnGetIsEditableElement(Self, AElement, AFlags,LIsEditable);
    Result := LIsEditable;
  end
  else
    Result := True;
end;

function TWebBrowserEx.GetIsContentPage: Boolean;
var
  LIs: Boolean;
begin
   if Assigned(FOnGetIsEditableElement) then
  begin
    FOnGetIsContentPage(Self, LIs);
    Result := LIs;
  end
  else
    Result := False;
end;

function TWebBrowserEx.GetCommandTarget: IOleCommandTarget;
var
  LDocument2: IHTMLDocument2;
begin
  Result := nil;
  if not HandleAllocated then exit;
  LDocument2 := GetActiveDocument as IHTMLDocument2;
  if LDocument2 <> nil then
    Result := LDocument2 as IOleCommandTarget;
end;

function TWebBrowserEx.GetWindow: IHTMLWindow2;
var
  LDocument2: IHTMLDocument2;
begin
  Result := nil;
  if not HandleAllocated then exit;
  LDocument2 := Document2;
  if LDocument2 <> nil then
    Result := LDocument2.parentWindow;
end;

                                                                                                       
procedure TWebBrowserEx.InvokeEvent(DispID: TDispID;
  var Params: TDispParams);
begin
  inherited InvokeEvent(DispID, Params);
  if (FWebBrowserEvents2Dispatch = nil) or
     HandleAllocated and Assigned(FWebBrowserEvents2Dispatch) and FWebBrowserEvents2Dispatch.Active then exit;
  case DispID of
    DISPID_DOCUMENTCOMPLETE:
      begin
        FDisplayServices := nil;
        FCaret := nil;
        FMarkupServices := nil;
        FPrimarySelectionServices := nil;
        if (FInetExplorerServerInstance = nil) then
          if HandleAllocated then
          begin
            HookChildWindows;
            {$IFDEF EVENTSINKSUBCOMPONENTS}
            FDocEventDispatch.Connect(Document2);
            FWndEventDispatch.Connect(Window);
            {$ELSE}
            FDocEventDispatch.Active := True;
            FWndEventDispatch.Active := True;
            FWebBrowserEvents2Dispatch.Active := True;
            {$ENDIF}
          end
          else
            if Assigned(FOnReloadDocument) then
              FOnReloadDocument(Self);
      end;
    DISPID_BEFORENAVIGATE2:
      begin
        {$IFDEF EVENTSINKSUBCOMPONENTS}
        FDocEventDispatch.Disconnect;
        {$ELSE}
        FDocEventDispatch.Active := False;
        {$ENDIF}
      end;
  end;
end;

procedure TWebBrowserEx.MouseOut(Shift: TShiftState; X,
  Y: Integer);
begin
  if Assigned(FOnMouseOut) then FOnMouseOut(Self, Shift, X, Y);
end;

procedure TWebBrowserEx.MouseOver(Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseOver) then FOnMouseOver(Self, Shift, X, Y);
end;

procedure TWebBrowserEx.DoAfterUpdate;
begin
  if Assigned(FAfterUpdate) then FAfterUpdate(Self);
end;

procedure TWebBrowserEx.DoBeforeUpdate;
begin
  if Assigned(FBeforeUpdate) then FBeforeUpdate(Self);
end;

procedure TWebBrowserEx.DoError;
begin
  if Assigned(FOnError) then FOnError(Self);
end;

procedure TWebBrowserEx.ErrorUpdate;
begin
  if Assigned(FOnErrorUpdate) then FOnErrorUpdate(Self);
end;

procedure TWebBrowserEx.RowEnter;
begin
  if Assigned(FOnRowEnter) then FOnRowEnter(Self);
end;

procedure TWebBrowserEx.RowExit;
begin
  if Assigned(FOnRowExit) then FOnRowExit(Self);
end;

procedure TWebBrowserEx.SelectStart;
begin
  if Assigned(FOnSelectStart) then FOnSelectStart(Self);
end;

{
  Here are the interfaces that are queries for...

  Format:
  Service <(first_8_digits_of_guid)> -> IID <(first_8_digits_of_guid)>

  SID_STopLevelBrowser -> ???
  SID_STopLevelBrowser -> IShellBrowser
  ??? -> IUnknown
  ??? -> IShellBrowser
  ??? -> IUnknown
  SID_STopWindow -> ISearchContext
  ??? -> IUnknown
  SID_STopLevelBrowser -> IOleCommandTarget
  IShellBrowser -> IShellBrowser
  SID_STopLevelBrowser -> IServiceProvider
  SID_STopLevelBrowser -> IServiceProvider
  IMimeInfo -> IMimeInfo
  SID_STopLevelBrowser -> IOleCommandTarget
  ??? -> ???
  SID_STopLevelBrowser -> IOleCommandTarget
  IOleUndoManager -> IOleUndoManager
  IPersistMoniker -> IPersistMoniker
  SID_STopLevelBrowser (4c96be40) -> IServiceProvider (6d5140c1)
  HTMLFrameBase (3050f312) -> HTMLFrameBase (3050f312)
  ??? -> IUnknown
  HTMLObjectElement -> HTMLObjectElement
  ??? -> ???
  ??? -> IUnknown
  ??? -> IUnknown
  ??? -> IUnknown
  IElementBehaviorFactory -> IElementBehaviorFactory
  ??? -> ???
  SID_STopLevelBrowser (4c96be40) -> IServiceProvider (6d5140c1)
  ??? -> IUnknown
  ??? -> IUnknown
  ??? -> IUnknown
  GopherProtocol -> GopherProtocol
  ??? -> IUnknown
  ??? -> IUnknown
  SID_STopLevelBrowser (4c96be40) -> IServiceProvider (6d5140c1)
  SID_STopLevelBrowser (4c96be40) -> IServiceProvider (6d5140c1)
  SID_STopLevelBrowser (4c96be40) -> IOleCommandTarget
  SID_STopLevelBrowser (4c96be40) -> IOleWindow
  IShellBrowser -> IShellBrowser
  SID_STopWindow -> ISearchContext
  ??? -> ???
  SID_STopLevelBrowser (4c96be40) -> IOleCommandTarget
  ??? -> IUnknown
  ??? -> IUnknown
  ??? -> IUnknown
  SID_STopLevelBrowser (4c96be40) -> IUrlHistoryStg
  SID_STopLevelBrowser (4c96be40) -> IShellBrowser
  SID_SEditCommandTarget (3050f4b5) -> IOleCommandTarget
  SID_SEditCommandTarget (3050f4b5) -> IOleCommandTarget
  SID_STopLevelBrowser (4c96be40) -> IServiceProvider (6d5140c1)

}
function TWebBrowserEx.QueryService(const rsid: TGUID; const iid: TGUID;
  out Obj): HRESULT;
var
  I: Integer;
  Temp: TWebBrowserServiceProvider;
begin
//  OutputDebugString(PChar('Service ' + GUIDToString(rsid)));
//  OutputDebugString(PChar('iid ' + GUIDToString(iid)));
  Result := E_NOINTERFACE;
  if (Result <> S_OK) and Assigned(FServiceProviders) and not (csDesigning in ComponentState) then
  begin
    for I := 0 to FServiceProviders.Count - 1 do
    begin
      Temp := TWebBrowserServiceProvider(FServiceProviders[I]);
//      OutputDebugString(PChar(GUIDToString(Temp.ServiceGUID)));
      if (IsEqualGUID(rsid, Temp.ServiceGUID) or IsEqualGUID(iid, Temp.ServiceGUID))
        and Supports(Temp, iid, Obj) then
      begin
        Result := S_OK;
        Break;
      end;
    end;
  end;
  if (Result <> S_OK) and Supports(Self, rsid) and Supports(Self, iid, Obj) then
    Result := S_OK
end;

procedure TWebBrowserEx.DoLoad;
begin
  if Assigned(FOnLoad) then FOnLoad(Self);
end;

procedure TWebBrowserEx.DoHelp;
begin
  if Assigned(FOnHelp) then FOnHelp(Self);
end;

procedure TWebBrowserEx.DoUnLoad;
begin
  if Assigned(FOnUnLoad) then FOnUnLoad(Self);
end;

procedure TWebBrowserEx.DoBlur;
begin
  if Assigned(FOnBlur) then FOnBlur(Self);
end;

procedure TWebBrowserEx.DoFocus;
begin
  if Assigned(FOnFocus) then FOnFocus(Self);
end;

procedure TWebBrowserEx.DoWndResize;
begin
  if Assigned(FOnWndResize) then FOnWndResize(Self);
end;

procedure TWebBrowserEx.DoScroll;
begin
  if Assigned(FOnScroll) then FOnScroll(Self);
end;

function TWebBrowserEx.DoBeforeEditFocus(const EventObj: IHTMLEventObj;
  const DispID: Integer): WordBool;
begin
  if Assigned(FOnBeforeEditFocus) then
    Result := FOnBeforeEditFocus(Self, EventObj)
  else
    Result := False;    
end;

procedure TWebBrowserEx.DoBeforeUnLoad;
begin
  if Assigned(FBeforeUnload) then FBeforeUnload(Self);
end;

procedure TWebBrowserEx.DoCommandStateChange(Command: TOleEnum;
  Enable: WordBool);
begin
end;

function TWebBrowserEx.CommandState(const CmdID: TOleEnum): TCommandStates;
var
  C: TCommandStateArray;
  LEditable: Boolean;
begin
  Result := [];
  if Document2 <> nil then
  begin
    SetLength(C, 1);
    C[0].cmdID := CmdID;
    C[0].cmdf := 0;
    CommandState(C);
    if C[0].cmdf and OLECMDF_ENABLED = OLECMDF_ENABLED then
      Include(Result, csEnabled);
    if C[0].cmdf and OLECMDF_SUPPORTED = OLECMDF_SUPPORTED then
      Include(Result, csSupported);
    if C[0].cmdf and OLECMDF_LATCHED = OLECMDF_LATCHED then
      Include(Result, csChecked);

    if (csEnabled in Result) and CommandUpdater.WebBrowser.GetIsContentPage then
    begin
      LEditable := True;
      case CmdId of
        IDM_CUT,
        IDM_PASTE,
        IDM_DELETE:
          case CommandUpdater.WebBrowser.CurrentElementType of
            cetAtCursor,
            cetTextRange:
              LEditable := CommandUpdater.WebBrowser.GetIsEditableElement(
                CommandUpdater.WebBrowser.CurrentElement, [efInnerRequired]);
            cetControlRange:
              LEditable := CommandUpdater.WebBrowser.GetIsEditableElement(
                CommandUpdater.WebBrowser.CurrentElement.parentElement, [efInnerRequired]);
          end;
        IDM_SELECTALL:
          if not CommandUpdater.WebBrowser.GetIsEditableElement(
            CommandUpdater.WebBrowser.Document2.body, [efInnerRequired]) then
          begin
            LEditable := False;
          end;
      end;
      if not LEditable then
      begin
        Exclude(Result, csEnabled);
        Exclude(Result, csChecked);
      end;
    end;
  end;
end;

function TWebBrowserEx.CommandState(Cmds: TCommandStateArray): TCommandStateArray;
begin
  SetLength(Result, 0);
  if Assigned(Document2) then
    CommandTarget.QueryStatus(@CGID_MSHTML, Length(Cmds), @Cmds[0], nil);
end;

procedure TWebBrowserEx.LoadFromFile(const FileName: string);
var
  AFile: IPersistFile;
  Stream: TFileStream;
begin
  if Supports(Document, IPersistFile, AFile) and (AFile.IsDirty <> S_FALSE) then
    case MessageDlg(sSaveCurrentFile, mtConfirmation, mbYesNoCancel, 0) of
      mrYes: OleCheck(AFile.Save(nil, True));
      mrCancel: exit;
    end;
  Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    if Trim(BaseURL) = '' then
      BaseURL := ExtractFilePath(FileName);
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TWebBrowserEx.SaveToFile(const FileName: string);
var
  AFile: IPersistFile;
  wFileName: WideString;
begin
  if Supports(Document, IPersistFile, AFile) then
  begin
    wFileName := FileName;
    AFile.Save(@wFileName, True);
  end;
end;

procedure TWebBrowserEx.RegisterServiceProvider(
  Provider: TWebBrowserServiceProvider);
begin
  if Provider = nil then
    raise Exception.Create(sNilProvider);
  if IsEqualGUID(Provider.ServiceGUID, GUID_NULL) then
    raise Exception.Create(sInvalidServiceProviderGUID);
  if not Assigned(FServiceProviders) then
    FServiceProviders := TComponentList.Create(False);
  if FServiceProviders.IndexOf(Provider) < 0 then
    FServiceProviders.Add(Provider);
end;

procedure TWebBrowserEx.UnRegisterServiceProvider(
  Provider: TWebBrowserServiceProvider);
var
  Idx: Integer;
begin
  if not (csDestroying in ComponentState) then
  begin
    Idx := FServiceProviders.IndexOf(Provider);
    if Idx <> -1 then
      FServiceProviders.Extract(Provider);
  end;
  if FServiceProviders.Count = 0 then
    FreeAndNil(FServiceProviders);
end;

function TWebBrowserEx.GetDisplayServices: IDisplayServices;
begin
  if FDisplayServices = nil then
    FDisplayServices := Document2 as IDisplayServices;
  Result := FDisplayServices;
end;

function TWebBrowserEx.GetMarkupServices: IMarkupServices2;
begin
  if FMarkupServices = nil then
    FMarkupServices := Document as IMarkupServices2;
  Result := FMarkupServices;
end;

function TWebBrowserEx.GetPrimaryMarkupContainer: IMarkupContainer2;
begin
  Result := Document as IMarkupContainer2;
end;

function TWebBrowserEx.GetSelectionServices: ISelectionServices;
begin
  if FPrimarySelectionServices = nil then
    OleCheck(HTMLEditServices.GetSelectionServices(PrimaryMarkupContainer, FPrimarySelectionServices));
  Result := FPrimarySelectionServices;
end;

function TWebBrowserEx.Exec(CmdGroup: PGUID; nCmdID, nCmdexecopt: DWORD;
  const vaIn: OleVariant; var vaOut: OleVariant): HResult;
var
  LDocument2: IHTMLDocument2;
begin
  // Used to handle script errors in a custom manner
  Result := S_OK;
  if Assigned(CmdGroup) then
  begin
    if IsEqualGUID(CmdGroup^, CGID_DocHostCommandHandler) then
      case nCmdID of
        OLECMDID_SHOWSCRIPTERROR:
          begin
            LDocument2 := Document2;
            if LDocument2 <> nil then
                                                                            
              //LDocument2.parentWindow.event.reason;
          end;
        OLECMDID_OPENNEWWINDOW:
          begin
            if Assigned(FOnOpenNewWindow) then
              FOnOpenNewWindow(Self)
            else
              Result := OLECMDERR_E_NOTSUPPORTED;
          end;
      else
        Result := OLECMDERR_E_NOTSUPPORTED;
      end
    else
      Result := OLECMDERR_E_UNKNOWNGROUP;
    {else if IsEqualGUID(CmdGroup^, CGID_Explorer) then
      case nCmdId of
        58:
          begin
            if @vaOut <> nil then
              vaOut := ControlInterface as IDispatch;
            Result := S_OK;
          end;
      else
        Result := OLECMDERR_E_NOTSUPPORTED;
      end}
  end else
    Result := OLECMDERR_E_UNKNOWNGROUP;
end;

function TWebBrowserEx.QueryStatus(CmdGroup: PGUID; cCmds: Cardinal;
  prgCmds: POleCmd; CmdText: POleCmdText): HResult;
begin
//  Result := S_OK;
  Result := E_NOTIMPL;
end;

procedure TWebBrowserEx.DoReadyStateChange;
begin
  if Assigned(FOnReadyStateChange) then
    FOnReadyStateChange(Self);
end;

procedure TWebBrowserEx.DoStatusTextChange(const Text: string);
begin
  if Assigned(FOnStatusTextChange) then
    FOnStatusTextChange(Self, Text);
end;

procedure TWebBrowserEx.Loaded;
begin
  inherited;
  if Length(FURL) > 0 then
    Navigate(FURL);
end;

// Call when selection has changed but browser does not notify
procedure TWebBrowserEx.ForceSelectionChange;
begin
  ClearCurrentElement;
  SelectionChange;
end;

procedure TWebBrowserEx.ClearCurrentElement;
begin
  FCurrentElement := nil;
  FCurrentElementType := cetUndefined;
end;

procedure TWebBrowserEx.SelectionChange;
begin
  if Assigned(FOnSelectionChange) then
    FOnSelectionChange(Self, Window.event);
end;

procedure TWebBrowserEx.DoUpdateCommands;
begin
  if Assigned(FOnUpdateCommands) then
    FOnUpdateCommands(Self);
end;

function TWebBrowserEx.GetModified: Boolean;
var
  AFile: IPersistFile;
begin
  Result := False;
  if Assigned(Document) and Supports(Document, IPersistFile, AFile) then
    Result := AFile.IsDirty = S_OK;
end;

procedure TWebBrowserEx.CMCancelMode(var Message: TCMCancelMode);
begin
  inherited;
  if Assigned(FOnCancelMode) then
    FOnCancelMode(Self);
end;

function TWebBrowserEx.Notify: HRESULT;
begin
  if Assigned(FOnChange) then FOnChange(Self);
  Result := S_OK;
end;

function TWebBrowserEx.OnFocus(fGotFocus: BOOL): HResult;
begin
  Result := inherited OnFocus(fGotFocus);
  // The following code is necessary so that the control properly regains focus
  // when tabbing into the webbrowser control.
  if fGotFocus and Assigned(Document2) then
    Document2.parentWindow.focus;
end;

function TWebBrowserEx.GetCaret: IHTMLCaret;
begin
  if FCaret = nil then
    OleCheck(DisplayServices.GetCaret(FCaret));
  Result := FCaret;
end;

procedure TWebBrowserEx.CMRecreatewnd(var Message: TMessage);
begin
  inherited;
end;

procedure TWebBrowserEx.InetExplorerServerWndProc(var Message: TMessage);
var
  ParentForm: TCustomForm;
  Handled: Boolean;
begin
  // Prevent a beep when Alt keys are pressed (like for menus)
  if (Message.Msg = WM_SYSCOMMAND) or ((Message.Msg = WM_SYSKEYDOWN) and (Message.WParam = VK_MENU)) then
  begin
    Message.Result := 1;
    Exit;
  end;
  case Message.Msg of
    WM_SETCURSOR,
    WM_RBUTTONUP,
    WM_RBUTTONDOWN,
    WM_LBUTTONUP,
    WM_MOUSEMOVE,
    WM_LBUTTONDOWN:
      if Assigned(FOnInterceptMouseMessage) then
      begin
        FOnInterceptMouseMessage(Self, Message, Handled);
        if Handled then
        begin
          Exit;
        end;
      end;
  end;


  Message.Result := CallWindowProc(FDefInetExplorerServerProc,
    FInetExplorerServerHandle, Message.Msg, Message.WParam, Message.LParam);
  case Message.Msg of
    WM_SETFOCUS:
      begin
        // Catching this message allows us to set the Active control to the
        // WebBrowser itself which keeps VCL in sync with the real active control
        // which makes things like tabbing work correctly.
        if (csDestroying in ComponentState) or not CanFocus then exit;
        FHasFocus := True;
        GetParentForm(Self).ActiveControl := Self;
      end;
    WM_KILLFOCUS: FHasFocus := False;
    WM_SHOWWINDOW:
      begin
        if Message.WParam <> 0 then exit;
        ParentForm := GetParentForm(Self, False);
        if Assigned(ParentForm) and Assigned(FBeforeDestroy) then
          FBeforeDestroy(Self);
      end;
    WM_NCDESTROY: UnHookChildWindows;
    WM_INITMENUPOPUP:
      if Assigned(FOnInitMenuPopup) then
        with TWMInitMenuPopup(Message) do
          FOnInitMenuPopup(Self, MenuPopup, Pos, SystemMenu);
  end;
end;

procedure TWebBrowserEx.ShellDocObjWndProc(var Message: TMessage);
var
  LDocument: IHTMLDocument;
begin
  // Hooking this wndproc is necessary to allow the WebBrowser control to
  // properly regain focus when the application loses then regains focus.
  Message.Result := CallWindowProc(FDefShellObjViewProc, FShellDocObjViewHandle,
    Message.Msg, Message.WParam, Message.LParam);
  case Message.Msg of
    WM_SETFOCUS:
      begin
        if (csDestroying in ComponentState) or not CanFocus then exit;
        GetParentForm(Self).ActiveControl := Self;
        LDocument := GetActiveDocument;
        // Try two different calls for setting focus.  IHTMLDocument4.focus works when setting
        // the focus back to the designer after displaying a modal dialog (e.g.; background color).
        // It doesn't seem to work when activating the designer by clicking a tab.
        // IHTMLDocument2.parentWindow.focus works when moving between tabs.  However, if editing
        // a template IHTMLDocument2.parentWindow.focus causes the template editor to lose focus
        // and the body element to receive focus.  Situations when this occur include when template editing
        // include click on the "design" bottom tab and when template editing and click on the webform1.aspx top tab.
        if Assigned(LDocument) then
          (LDocument as IHTMLDocument4).focus;
        if not Focused then
          // Previous method doesn't always work so try this
          if Assigned(Document2) then
            Document2.parentwindow.focus;
      end;
    WM_NCDESTROY: UnHookChildWindows;
  end;
end;

procedure TWebBrowserEx.DestroyWindowHandle;
begin
  FDocEventDispatch.Active := False;
  FWndEventDispatch.Active := False;
  FWebBrowserEvents2Dispatch.Active := False;
  inherited;
  FInetExplorerServerHandle := 0;
  FShellDocObjViewHandle := 0;
end;

procedure TWebBrowserEx.ShellWndProc(var Message: TMessage; Wnd: HWnd;
  WndProc: Pointer);
begin
  try
    with Message do
      Result := CallWindowProc(WndProc, Wnd, Msg, WParam, LParam);
  except
    Vcl.Forms.Application.HandleException(Self);
  end;
end;

procedure TWebBrowserEx.SetCommandUpdater(
  const Value: TCustomWebBrowserCommandUpdater);
begin
  if FCommandUpdater <> Value then
  begin
    if Assigned(FCommandUpdater) then
      FCommandUpdater.RemoveFreeNotification(Self);
    FCommandUpdater := Value;
    if Assigned(FCommandUpdater) then
      FCommandUpdater.FreeNotification(Self);
  end;
end;

procedure TWebBrowserEx.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FCommandUpdater) then
    FCommandUpdater := nil;
end;

procedure TWebBrowserEx.HookChildWindows;
begin
  if csDesigning in ComponentState then exit;
  // Hook child windows to catch destroywnd messages
  if (FShellDocObjViewHandle <> 0) or (FInetExplorerServerHandle <> 0) then
    raise Exception.Create(SChildWindowsAlreadyHooked);
  FShellDocObjViewHandle := Winapi.Windows.GetWindow(Handle, GW_CHILD);
  if (FShellDocObjViewHandle <> 0) and not FHooksSet then
  begin
    FInetExplorerServerInstance := System.Classes.MakeObjectInstance(InetExplorerServerWndProc);
    FHooksSet := True;
    FShellDocObjInstance := System.Classes.MakeObjectInstance(ShellDocObjWndProc);
    if IsWindowUnicode(FShellDocObjViewHandle) then
    begin
      FDefShellObjViewProc := Pointer(GetWindowLongW(FShellDocObjViewHandle, GWL_WNDPROC));
      SetWindowLongW(FShellDocObjViewHandle, GWL_WNDPROC, Longint(FShellDocObjInstance));
    end
    else
    begin
      FDefShellObjViewProc := Pointer(GetWindowLong(FShellDocObjViewHandle, GWL_WNDPROC));
      SetWindowLong(FShellDocObjViewHandle, GWL_WNDPROC, Longint(FShellDocObjInstance));
    end;
    FInetExplorerServerHandle := Winapi.Windows.GetWindow(FShellDocObjViewHandle, GW_CHILD);
    if IsWindowUnicode(FInetExplorerServerHandle) then
    begin
      FDefInetExplorerServerProc := Pointer(GetWindowLongW(FInetExplorerServerHandle, GWL_WNDPROC));
      SetWindowLongW(FInetExplorerServerHandle, GWL_WNDPROC, Longint(FInetExplorerServerInstance));
    end
    else
    begin
      FDefInetExplorerServerProc := Pointer(GetWindowLong(FInetExplorerServerHandle, GWL_WNDPROC));
      SetWindowLong(FInetExplorerServerHandle, GWL_WNDPROC, Longint(FInetExplorerServerInstance));
    end;
  end;
end;

procedure TWebBrowserEx.WMParentNotify(var Message: TWMParentNotify);
begin
  inherited;
  case Message.Event of
    WM_DESTROY: UnHookChildWindows;
  end;
end;

function TWebBrowserEx.GetOverrideCursor: Boolean;
var
  POut: OleVariant;
begin
  POut := False;
  if Assigned(CommandTarget) then
    CommandTarget.Exec(@CGID_MSHTML, IDM_OVERRIDE_CURSOR, OLECMDEXECOPT_DONTPROMPTUSER,
      POleVariant(nil)^, POut);
  Result := POut;
end;

procedure TWebBrowserEx.SetOverrideCursor(const Value: Boolean);
var
  PIn: OleVariant;
  ViewLinkDocuments: IInterfaceList;
  I: Integer;
  LCommandTarget: IOleCommandTarget;
begin
  PIn := Value;
  if Assigned(CommandTarget) then
    CommandTarget.Exec(@CGID_MSHTML, IDM_OVERRIDE_CURSOR, OLECMDEXECOPT_DONTPROMPTUSER,
      PIn, POleVariant(nil)^);
  ViewLinkDocuments := GetViewLinkDocuments(IDM_OVERRIDE_CURSOR);
  if ViewLinkDocuments <> nil then
  begin
    PIn := Value;
    for I := 0 to ViewLinkDocuments.Count - 1 do
    begin
      LCommandTarget := ViewLinkDocuments[I] as IOleCommandTarget;
      if LCommandTarget <> nil then
        LCommandTarget.Exec(@CGID_MSHTML, IDM_OVERRIDE_CURSOR, OLECMDEXECOPT_DONTPROMPTUSER,
          PIn, POleVariant(nil)^);
    end;
  end;

end;

procedure TWebBrowserEx.UnHookChildWindows;
begin
  FDocEventDispatch.Active := False;
  FWndEventDispatch.Active := False;
  FWebBrowserEvents2Dispatch.Active := False;
  if FShellDocObjViewHandle <> 0 then
  begin
    SetWindowLongW(FShellDocObjViewHandle, GWL_WNDPROC, IntPtr(FDefShellObjViewProc));
    System.Classes.FreeObjectInstance(FShellDocObjInstance);
    FShellDocObjViewHandle := 0;
    FShellDocObjInstance := nil;
  end;
  if FInetExplorerServerHandle <> 0 then
  begin
    SetWindowLongW(FInetExplorerServerHandle, GWL_WNDPROC,
      IntPtr(FDefInetExplorerServerProc));
    System.Classes.FreeObjectInstance(FInetExplorerServerInstance);
    FInetExplorerServerHandle := 0;
    FInetExplorerServerInstance := nil;
  end;
  FHooksSet := (FInetExplorerServerHandle <> 0) or (FShellDocObjViewHandle <> 0);
end;

function TWebBrowserEx.DoOnControlSelect(
  const EventObj: IHTMLEventObj): WordBool;
begin
  Result := True;
  if Assigned (FOnControlSelect) then
    Result := OnControlSelect(Self, EventObj);
end;

function TWebBrowserEx.DoOnControlMove(const EventObj: IHTMLEventObj;
  DispID: Integer): WordBool;
begin
  Result := True;
  if Assigned (FOnControlMove) then
    Result := OnControlMove(Self, EventObj, DispID);
end;

function TWebBrowserEx.DoOnControlResize(const EventObj: IHTMLEventObj;
  DispID: Integer): WordBool;
begin
  Result := True;
  if Assigned (FOnControlResize) then
    Result := OnControlResize(Self, EventObj, DispID);
end;

procedure TWebBrowserEx.DoResolveRelativePath(var Path: string);
begin
  Path := '';
  if Assigned(FOnResolveRelativePath) then
    FOnResolveRelativePath(Self, Path);
end;

function EnumChildProc(hWnd: THandle; lParam: LongInt): Bool; stdcall; export;
begin
  Result := False;
  if TWebBrowserEx(lParam).FHasFocus then exit;
  TWebBrowserEx(lParam).FHasFocus := GetForegroundWindow = hWnd;
end;

function TWebBrowserEx.Focused: Boolean;
begin
  Result := inherited Focused or FHasFocus;
end;

procedure TWebBrowserEx.ClearDirtyFlag;
var
  AStream: IPersistStreamInit;
begin
  if Supports(Document, IPersistStreamInit, AStream) and (AStream.IsDirty <> S_FALSE) then
    OleCheck(AStream.Save(nil, True));
end;

procedure TWebBrowserEx.SetModified(const Value: Boolean);
var
  PIn: OleVariant;
begin
  PIn := Value;
  // CommandTarget is nil when loading browser before the designer is shown.
  if CommandTarget <> nil then
    CommandTarget.Exec(@CGID_MSHTML, IDM_SETDIRTY, OLECMDEXECOPT_DONTPROMPTUSER, PIn, POleVariant(nil)^);
end;

{ THTMLElementEventDispatch }

procedure THTMLElementEventDispatch.AfterConstruction;
begin
  inherited;
  FIID := DIID_HTMLElementEvents2;
end;

function THTMLElementEventDispatch.GetEventInterface: IInterface;
begin
  Result := FHTMLElement;
end;

function THTMLElementEventDispatch.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HRESULT;
begin
  Result := E_NOTIMPL;
  {$IFDEF DEVELOPERS}
  case DispID of
    DISPID_HTMLELEMENTEVENTS_ONHELP: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONHELP');
    DISPID_HTMLELEMENTEVENTS_ONCLICK: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONCLICK');
    DISPID_HTMLELEMENTEVENTS_ONDBLCLICK: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONDBLCLICK');
    DISPID_HTMLELEMENTEVENTS_ONKEYPRESS: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONKEYPRESS');
    DISPID_HTMLELEMENTEVENTS_ONKEYDOWN: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONKEYDOWN');
    DISPID_HTMLELEMENTEVENTS_ONKEYUP: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONKEYUP');
    DISPID_HTMLELEMENTEVENTS_ONMOUSEOUT: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONMOUSEOUT');
    DISPID_HTMLELEMENTEVENTS_ONMOUSEOVER: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONMOUSEOVER');
    DISPID_HTMLELEMENTEVENTS_ONMOUSEMOVE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONMOUSEMOVE');
    DISPID_HTMLELEMENTEVENTS_ONMOUSEDOWN: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONMOUSEDOWN');
    DISPID_HTMLELEMENTEVENTS_ONMOUSEUP: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONMOUSEUP');
    DISPID_HTMLELEMENTEVENTS_ONSELECTSTART: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONSELECTSTART');
    DISPID_HTMLELEMENTEVENTS_ONFILTERCHANGE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONFILTERCHANGE');
    DISPID_HTMLELEMENTEVENTS_ONDRAGSTART: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONDRAGSTART');
    DISPID_HTMLELEMENTEVENTS_ONBEFOREUPDATE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONBEFOREUPDATE');
    DISPID_HTMLELEMENTEVENTS_ONAFTERUPDATE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONAFTERUPDATE');
    DISPID_HTMLELEMENTEVENTS_ONERRORUPDATE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONERRORUPDATE');
    DISPID_HTMLELEMENTEVENTS_ONROWEXIT: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONROWEXIT');
    DISPID_HTMLELEMENTEVENTS_ONROWENTER: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONROWENTER');
    DISPID_HTMLELEMENTEVENTS_ONDATASETCHANGED: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONDATASETCHANGED');
    DISPID_HTMLELEMENTEVENTS_ONDATAAVAILABLE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONDATAAVAILABLE');
    DISPID_HTMLELEMENTEVENTS_ONDATASETCOMPLETE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONDATASETCOMPLETE');
    DISPID_HTMLELEMENTEVENTS_ONLOSECAPTURE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONLOSECAPTURE');
    DISPID_HTMLELEMENTEVENTS_ONPROPERTYCHANGE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONPROPERTYCHANGE');
    DISPID_HTMLELEMENTEVENTS_ONSCROLL: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONSCROLL');
    DISPID_HTMLELEMENTEVENTS_ONFOCUS: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONFOCUS');
    DISPID_HTMLELEMENTEVENTS_ONBLUR: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONBLUR');
    DISPID_HTMLELEMENTEVENTS_ONRESIZE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONRESIZE');
    DISPID_HTMLELEMENTEVENTS_ONDRAG: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONDRAG');
    DISPID_HTMLELEMENTEVENTS_ONDRAGEND: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONDRAGEND');
    DISPID_HTMLELEMENTEVENTS_ONDRAGENTER: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONDRAGENTER');
    DISPID_HTMLELEMENTEVENTS_ONDRAGOVER: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONDRAGOVER');
    DISPID_HTMLELEMENTEVENTS_ONDRAGLEAVE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONDRAGLEAVE');
    DISPID_HTMLELEMENTEVENTS_ONDROP: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONDROP');
    DISPID_HTMLELEMENTEVENTS_ONBEFORECUT: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONBEFORECUT');
    DISPID_HTMLELEMENTEVENTS_ONCUT: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONCUT');
    DISPID_HTMLELEMENTEVENTS_ONBEFORECOPY: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONBEFORECOPY');
    DISPID_HTMLELEMENTEVENTS_ONCOPY: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONCOPY');
    DISPID_HTMLELEMENTEVENTS_ONBEFOREPASTE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONBEFOREPASTE');
    DISPID_HTMLELEMENTEVENTS_ONPASTE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONPASTE');
    DISPID_HTMLELEMENTEVENTS_ONCONTEXTMENU: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONCONTEXTMENU');
    DISPID_HTMLELEMENTEVENTS_ONROWSDELETE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONROWSDELETE');
    DISPID_HTMLELEMENTEVENTS_ONROWSINSERTED: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONROWSINSERTED');
    DISPID_HTMLELEMENTEVENTS_ONCELLCHANGE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONCELLCHANGE');
    DISPID_HTMLELEMENTEVENTS_ONREADYSTATECHANGE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONREADYSTATECHANGE');
    DISPID_HTMLELEMENTEVENTS_ONBEFOREEDITFOCUS: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONBEFOREEDITFOCUS');
    DISPID_HTMLELEMENTEVENTS_ONLAYOUTCOMPLETE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONLAYOUTCOMPLETE');
    DISPID_HTMLELEMENTEVENTS_ONPAGE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONPAGE');
    DISPID_HTMLELEMENTEVENTS_ONBEFOREDEACTIVATE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONBEFOREDEACTIVATE');
    DISPID_HTMLELEMENTEVENTS_ONBEFOREACTIVATE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONBEFOREACTIVATE');
    DISPID_HTMLELEMENTEVENTS_ONMOVE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONMOVE');
    DISPID_HTMLELEMENTEVENTS_ONCONTROLSELECT: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONCONTROLSELECT');
    DISPID_HTMLELEMENTEVENTS_ONMOVESTART: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONMOVESTART');
    DISPID_HTMLELEMENTEVENTS_ONMOVEEND: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONMOVEEND');
    DISPID_HTMLELEMENTEVENTS_ONRESIZESTART: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONRESIZESTART');
    DISPID_HTMLELEMENTEVENTS_ONRESIZEEND: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONRESIZEEND');
    DISPID_HTMLELEMENTEVENTS_ONMOUSEENTER: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONMOUSEENTER');
    DISPID_HTMLELEMENTEVENTS_ONMOUSELEAVE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONMOUSELEAVE');
    DISPID_HTMLELEMENTEVENTS_ONMOUSEWHEEL: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONMOUSEWHEEL');
    DISPID_HTMLELEMENTEVENTS_ONACTIVATE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONACTIVATE');
    DISPID_HTMLELEMENTEVENTS_ONDEACTIVATE: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONDEACTIVATE');
    DISPID_HTMLELEMENTEVENTS_ONFOCUSIN: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONFOCUSIN');
    DISPID_HTMLELEMENTEVENTS_ONFOCUSOUT: OutputDebugString('DISPID_HTMLELEMENTEVENTS_ONFOCUSOUT');
  end;
  {$ENDIF}
end;

function THTMLElementEventDispatch.QueryInterface(const IID: TGUID;
  out Obj): HRESULT;
begin
  Result := inherited QueryInterface(IID, Obj);
  if Result <> S_OK then
  begin
    if Supports(Self, IDispatch, Obj) then
      Result := S_OK;
  end;
end;

{ TWebBrowserServiceProvider }

constructor TWebBrowserServiceProvider.Create(AOwner: TComponent);
begin
  inherited;
  FServiceGUID := GUID_NULL;
end;

destructor TWebBrowserServiceProvider.Destroy;
begin
  if Assigned(WebBrowser) then
    WebBrowser.UnRegisterServiceProvider(Self);
  inherited;
end;

procedure TWebBrowserServiceProvider.SetWebBrowser(
  const Value: TWebBrowserEx);
begin
  if Assigned(WebBrowser) and (Value <> WebBrowser) then
    WebBrowser.UnRegisterServiceProvider(Self);
  inherited;
  if Assigned(Value) then
    Value.RegisterServiceProvider(Self);
end;

{ TCustomWebBrowserCommandUpdater }

function TCustomWebBrowserCommandUpdater.CommandState(CmdID: TOleEnum): TCommandStates;
var
  I: Integer;
begin
  Result := [];
  if Find(CmdID, I) then
    if FCmds[I].cmdID = CmdID then
    begin
      if FCmds[I].cmdf and OLECMDF_ENABLED = OLECMDF_ENABLED then
        Include(Result, csEnabled);
      if FCmds[I].cmdf and OLECMDF_SUPPORTED = OLECMDF_SUPPORTED then
        Include(Result, csSupported);
      if FCmds[I].cmdf and OLECMDF_LATCHED = OLECMDF_LATCHED then
        Include(Result, csChecked);
      if Assigned(FOnFilterCommandState) then
        FOnFilterCommandState(Self, CmdID, Result);
    end;
end;

procedure TCustomWebBrowserCommandUpdater.DoElementPropertiesChanged(Element: IHTMLElement; Properties: TElementProperties);
begin
  if Assigned(FOnElementPropertiesChanged) then
    FOnElementPropertiesChanged(Self, Element, Properties);
end;

procedure TCustomWebBrowserCommandUpdater.DoAfterCommand(CmdID: Cardinal);
begin
  if Assigned(FAfterCommand) then
    FAfterCommand(Self, CmdID);
end;

procedure TCustomWebBrowserCommandUpdater.DoBeforeCommand(CmdID: Cardinal; var Executed: Boolean);
begin
  Executed := False;
  if Assigned(FBeforeCommand) then
    FBeforeCommand(Self, CmdID, Executed);
end;

function TCustomWebBrowserCommandUpdater.Find(const CmdID: TOleEnum;
  var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  if not Assigned(WebBrowser) then exit;
  L := 0;
  H := Length(FCmds) - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Integer(FCmds[I].cmdID - CmdID);
    if C < 0 then L := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
        Result := True;
    end;
  end;
  Index := L;
end;

function TCustomWebBrowserCommandUpdater.GetActionState(Action: TObject;
  State: TCommandState; Value: Boolean): Boolean;
begin
  if Assigned(FOnGetActionState) then
    FOnGetActionState(Self, Action, State, Value, Result)
  else
    Result := False;
end;

procedure TCustomWebBrowserCommandUpdater.QuickSort(L, R: Integer);
var
  I, J, P: Integer;
  Temp: _tagOLECMD;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while FCmds[I].cmdID < FCmds[P].cmdID do Inc(I);
      while FCmds[J].cmdID > FCmds[P].cmdID do Dec(J);
      if I <= J then
      begin
        Temp := FCmds[I];
        FCmds[I] := FCmds[J];
        FCmds[J] := Temp;
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J);
    L := I;
  until I >= R;
end;

procedure TCustomWebBrowserCommandUpdater.RegisterCommand(CmdID: Cardinal);
begin
  if CmdID = 0 then exit;
  SetLength(FCmds, Length(FCmds) + 1);
  FCmds[Length(FCmds) - 1].cmdID := CmdID;
  QuickSort(0, Length(FCmds) - 1);
end;

procedure TCustomWebBrowserCommandUpdater.RegisterCommands(
  CmdIDs: array of Cardinal);
var
  I: Integer;
begin
  for I := 0 to Length(CmdIDs) - 1 do
    RegisterCommand(CmdIDs[I]);
end;

procedure TCustomWebBrowserCommandUpdater.SaveActionState(Action: TObject;
  State: TCommandState; Value: Boolean);
begin
  if Assigned(FOnSaveActionState) then
    FOnSaveActionState(Self, Action, State, Value);
end;

procedure TCustomWebBrowserCommandUpdater.SetWebBrowser(
  const Value: TWebBrowserEx);
begin
  inherited;
  if Assigned(Value) then
  begin
    Value.CommandUpdater := Self;
    Value.FreeNotification(Self);
  end;
end;

procedure TCustomWebBrowserCommandUpdater.UnRegisterCommand(CmdID: Cardinal);
var
  idx: Integer;
  I: Integer;
begin
  idx := 0;
  while (idx < Length(FCmds)) and (FCmds[idx].cmdID <> CmdID) do
    Inc(idx);
  if idx = Length(FCmds) then exit;
  for I := idx to Length(FCmds) - 2 do
    FCmds[I] := FCmds[I + 1];
  SetLength(FCmds, Length(FCmds) - 1);
end;

procedure TCustomWebBrowserCommandUpdater.UnRegisterCommands(
  CmdIDs: array of Cardinal);
var
  I: Integer;
begin
  for I := 0 to Length(CmdIDs) - 1 do
    UnRegisterCommand(CmdIDs[I]);
end;

procedure TCustomWebBrowserCommandUpdater.UpdateCommands(CmdID: Cardinal);
var
  CommandTarget: IOleCommandTarget;
  Idx: Integer;
  Len: Integer;
begin
  if not Assigned(WebBrowser) or not Assigned(WebBrowser.Document) or
     (csDestroying in WebBrowser.ComponentState) or (Length(FCmds) = 0) then exit;
  Idx := 0;
  if (CmdID = 0) or Find(CmdID, Idx) then
  begin
    if CmdID <> 0 then
      Len := 1
    else
      Len := Length(FCmds);
    if Supports(WebBrowser.Document2, IOleCommandTarget, CommandTarget) then
      CommandTarget.QueryStatus(@CGID_MSHTML, Len, @FCmds[Idx], nil);
    WebBrowser.DoUpdateCommands;
  end;
  if Assigned(FOnUpdateCommands) then
    FOnUpdateCommands(Self, CmdID);
end;

{ TStreamLoadMoniker }

function TStreamLoadMoniker.BindToObject(const bc: IBindCtx;
  const mkToLeft: IMoniker; const iidResult: TGUID; out vResult): HRESULT;
begin
  Result := FMoniker.BindToObject(bc, mkToLeft, iidResult, vResult);
end;

function TStreamLoadMoniker.BindToStorage(const bc: IBindCtx;
  const mkToLeft: IMoniker; const iid: TGUID; out vObj): HRESULT;
begin
  Result := MK_E_NOSTORAGE;
  if IsEqualGUID(iid, IID_IStream) and
     Supports(TStreamAdapter.Create(FStream), IStream, vObj) then
    Result := S_OK;
end;

function TStreamLoadMoniker.CommonPrefixWith(const mkOther: IMoniker;
  out mkPrefix: IMoniker): HRESULT;
begin
  Result := FMoniker.CommonPrefixWith(mkOther, mkPrefix);
end;

function TStreamLoadMoniker.ComposeWith(const mkRight: IMoniker;
  fOnlyIfNotGeneric: LongBool; out mkComposite: IMoniker): HRESULT;
begin
  Result := FMoniker.ComposeWith(mkRight, fOnlyIfNotGeneric, mkComposite);
end;

constructor TStreamLoadMoniker.Create(AStream: TStream; BaseURL: string);
begin
  FStream := AStream;
  FBaseURL := BaseURL;
  Assert(BaseUrl <> '');
                                                       
  OleCheck(CreateURLMoniker(nil, StringToOleStr(FBaseUrl), FMoniker));  { do not localize }
end;

function TStreamLoadMoniker.Enum(fForward: LongBool;
  out enumMoniker: IEnumMoniker): HRESULT;
begin
  Result := FMoniker.Enum(fForward, enumMoniker);
end;

function TStreamLoadMoniker.GetClassID(out classID: TGUID): HRESULT;
begin
  Result := FMoniker.GetClassID(classID);
end;

function TStreamLoadMoniker.GetDisplayName(const bc: IBindCtx;
  const mkToLeft: IMoniker; out pszDisplayName: PWideChar): HRESULT;
begin
  Result := FMoniker.GetDisplayName(bc, mkToLeft, pszDisplayName);
end;

function TStreamLoadMoniker.GetSizeMax(out cbSize: Int64): HRESULT;
begin
  Result := FMoniker.GetSizeMax(cbSize);
end;

function TStreamLoadMoniker.GetTimeOfLastChange(const bc: IBindCtx;
  const mkToLeft: IMoniker; out filetime: _FILETIME): HRESULT;
begin
  Result := FMoniker.GetTimeOfLastChange(bc, mkToLeft, filetime);
end;

function TStreamLoadMoniker.Hash(out dwHash: Integer): HRESULT;
begin
  Result := FMoniker.Hash(dwHash);
end;

function TStreamLoadMoniker.Inverse(out mk: IMoniker): HRESULT;
begin
  Result := FMoniker.Inverse(mk);
end;

function TStreamLoadMoniker.IsDirty: HRESULT;
begin
  Result := FMoniker.IsDirty;
end;

function TStreamLoadMoniker.IsEqual(const mkOtherMoniker: IMoniker): HRESULT;
begin
  Result := FMoniker.IsEqual(mkOtherMoniker);
end;

function TStreamLoadMoniker.IsRunning(const bc: IBindCtx; const mkToLeft,
  mkNewlyRunning: IMoniker): HRESULT;
begin
  Result := FMoniker.IsRunning(bc, mkToLeft, mkNewlyRunning);
end;

function TStreamLoadMoniker.IsSystemMoniker(out dwMksys: Integer): HRESULT;
begin
  Result := FMoniker.IsSystemMoniker(dwMksys);
end;

function TStreamLoadMoniker.Load(const stm: IStream): HRESULT;
begin
  Result := Load(stm);
end;

function TStreamLoadMoniker.ParseDisplayName(const bc: IBindCtx;
  const mkToLeft: IMoniker; pszDisplayName: PWideChar;
  out chEaten: Integer; out mkOut: IMoniker): HRESULT;
begin
  Result := FMoniker.ParseDisplayName(bc, mkToLeft, pszDisplayName, chEaten, mkOut);
end;

function TStreamLoadMoniker.Reduce(const bc: IBindCtx; dwReduceHowFar: Integer;
  mkToLeft: PIMoniker; out mkReduced: IMoniker): HRESULT;
begin
  Result := FMoniker.Reduce(bc, dwReduceHowFar, mkToLeft, mkReduced);
end;

function TStreamLoadMoniker.RelativePathTo(const mkOther: IMoniker;
  out mkRelPath: IMoniker): HRESULT;
begin
  Result := FMoniker.RelativePathTo(mkOther, mkRelPath);
end;

function TStreamLoadMoniker.Save(const stm: IStream;
  fClearDirty: LongBool): HRESULT;
begin
  Result := FMoniker.Save(stm, fClearDirty);
end;

{ TIFrameDocEventDispatch }

function TIFrameDocEventDispatch.DoInvoke(DispID: Integer;
  const IID: TGUID; LocaleID: Integer; Flags: Word; var dps: TDispParams;
  pDispIds: PDispIdList; VarResult, ExcepInfo, ArgErr: Pointer): HRESULT;
var
  EventObj: IHTMLEventObj;
begin
  Result := DISP_E_MEMBERNOTFOUND;
  case DispID of
    DISPID_HTMLDOCUMENTEVENTS2_ONCLICK,
    DISPID_HTMLDOCUMENTEVENTS2_ONDBLCLICK:
//    DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREEDITFOCUS,
//    DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEOVER:
      begin
        OleVariant (VarResult^) := False;
        if Supports(IUnknown(dps.rgvarg^ [pDispIds^ [0]].unkVal), IHTMLEventObj, EventObj) then
          with IUnknown(dps.rgvarg^ [pDispIds^ [0]].unkVal) as IHTMLEventObj do
            cancelBubble := True;
        Result := S_OK;
      end;
  end;
  {$IFDEF SAVE_DEVELOPERS}
//  OutputDebugString(PChar(Format('%x', [Dispid])));
    case DispID of
      DISPID_HTMLDOCUMENTEVENTS2_ONHELP: OutputDebugString('iframe:ONHELP');
      DISPID_HTMLDOCUMENTEVENTS2_ONCLICK:
        begin
          OleVariant (VarResult^) := False;
          if Supports(IUnknown(dps.rgvarg^ [pDispIds^ [0]].unkVal), IHTMLEventObj, EventObj) then
            with IUnknown(dps.rgvarg^ [pDispIds^ [0]].unkVal) as IHTMLEventObj do
              cancelBubble := True;
          OutputDebugString('iframe:ONCLICK');
          Result := S_OK;
        end;
      DISPID_HTMLDOCUMENTEVENTS2_ONDBLCLICK:
        begin
          OleVariant (VarResult^) := False;
          if Supports(IUnknown(dps.rgvarg^ [pDispIds^ [0]].unkVal), IHTMLEventObj, EventObj) then
            with IUnknown(dps.rgvarg^ [pDispIds^ [0]].unkVal) as IHTMLEventObj do
              cancelBubble := True;
          OutputDebugString('iframe:ONDBLCLICK');
          Result := S_OK;
        end;
      DISPID_HTMLDOCUMENTEVENTS2_ONKEYDOWN: OutputDebugString('iframe:ONKEYDOWN');
      DISPID_HTMLDOCUMENTEVENTS2_ONKEYUP: OutputDebugString('iframe:ONKEYUP');
      DISPID_HTMLDOCUMENTEVENTS2_ONKEYPRESS: OutputDebugString('iframe:ONKEYPRESS');
      DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEDOWN: OutputDebugString('iframe:ONMOUSEDOWN');
      DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEMOVE:
        begin
//          OleVariant (VarResult^) := False;
//          (IUnknown(dps.rgvarg^ [pDispIds^ [0]].unkval) as IHTMLEventObj).cancelBubble := True;
          OutputDebugString('iframe:iframe:ONMOUSEMOVE');
          Result := S_OK;
        end;
      DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEUP: OutputDebugString('iframe:ONMOUSEUP');
      DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEOUT: OutputDebugString('iframe:ONMOUSEOUT');
      DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEOVER:
        begin
          OleVariant (VarResult^) := False;
          if Supports(IUnknown(dps.rgvarg^ [pDispIds^ [0]].unkVal), IHTMLEventObj, EventObj) then
            with IUnknown(dps.rgvarg^ [pDispIds^ [0]].unkVal) as IHTMLEventObj do
              cancelBubble := True;
          OutputDebugString('iframe:ONMOUSEOVER');
          Result := S_OK;
        end;
      DISPID_HTMLDOCUMENTEVENTS2_ONREADYSTATECHANGE: OutputDebugString('iframe:ONREADYSTATECHANGE');
      DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREUPDATE: OutputDebugString('iframe:ONBEFOREUPDATE');
      DISPID_HTMLDOCUMENTEVENTS2_ONAFTERUPDATE: OutputDebugString('iframe:ONAFTERUPDATE');
      DISPID_HTMLDOCUMENTEVENTS2_ONROWEXIT: OutputDebugString('iframe:ONROWEXIT');
      DISPID_HTMLDOCUMENTEVENTS2_ONROWENTER: OutputDebugString('iframe:ONROWENTER');
      DISPID_HTMLDOCUMENTEVENTS2_ONDRAGSTART: OutputDebugString('iframe:ONDRAGSTART');
      DISPID_HTMLDOCUMENTEVENTS2_ONSELECTSTART: OutputDebugString('iframe:ONSELECTSTART');
      DISPID_HTMLDOCUMENTEVENTS2_ONERRORUPDATE: OutputDebugString('iframe:ONERRORUPDATE');
      DISPID_HTMLDOCUMENTEVENTS2_ONCONTEXTMENU: OutputDebugString('iframe:ONCONTEXTMENU');
      DISPID_HTMLDOCUMENTEVENTS2_ONSTOP: OutputDebugString('iframe:ONSTOP');
      DISPID_HTMLDOCUMENTEVENTS2_ONROWSDELETE: OutputDebugString('iframe:ONROWSDELETE');
      DISPID_HTMLDOCUMENTEVENTS2_ONROWSINSERTED: OutputDebugString('iframe:ONROWSINSERTED');
      DISPID_HTMLDOCUMENTEVENTS2_ONCELLCHANGE: OutputDebugString('iframe:ONCELLCHANGE');
      DISPID_HTMLDOCUMENTEVENTS2_ONPROPERTYCHANGE: OutputDebugString('iframe:ONPROPERTYCHANGE');
      DISPID_HTMLDOCUMENTEVENTS2_ONDATASETCHANGED: OutputDebugString('iframe:ONDATASETCHANGED');
      DISPID_HTMLDOCUMENTEVENTS2_ONDATAAVAILABLE: OutputDebugString('iframe:ONDATAAVAILABLE');
      DISPID_HTMLDOCUMENTEVENTS2_ONDATASETCOMPLETE: OutputDebugString('iframe:ONDATASETCOMPLETE');
      DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREEDITFOCUS:
        begin
          OleVariant (VarResult^) := False;
          if Supports(IUnknown(dps.rgvarg^ [pDispIds^ [0]].unkVal), IHTMLEventObj, EventObj) then
            with IUnknown(dps.rgvarg^ [pDispIds^ [0]].unkVal) as IHTMLEventObj do
              cancelBubble := True;
          OutputDebugString('iframe:ONBEFOREEDITFOCUS');
          Result := S_OK;
        end;
      DISPID_HTMLDOCUMENTEVENTS2_ONSELECTIONCHANGE: OutputDebugString('DISPID_HTMLDOCUMENTEVENTS2_ONSELECTIONCHANGE');
      DISPID_HTMLDOCUMENTEVENTS2_ONCONTROLSELECT: OutputDebugString('iframe:ONCONTROLSELECT');
      DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEWHEEL: OutputDebugString('iframe:ONMOUSEWHEEL');
      DISPID_HTMLDOCUMENTEVENTS2_ONFOCUSIN:
        begin
          if Supports(IUnknown(dps.rgvarg^ [pDispIds^ [0]].unkVal), IHTMLEventObj, EventObj) then
            EventObj.cancelBubble := True;
          OutputDebugString('iframe:ONFOCUSIN');
          Result := S_OK;
        end;
      DISPID_HTMLDOCUMENTEVENTS2_ONFOCUSOUT: OutputDebugString('iframe:ONFOCUSOUT');
      DISPID_HTMLDOCUMENTEVENTS2_ONACTIVATE: OutputDebugString('iframe:ONACTIVATE');
      DISPID_HTMLDOCUMENTEVENTS2_ONDEACTIVATE: OutputDebugString('iframe:ONDEACTIVATE');
      DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREACTIVATE: OutputDebugString('iframe:ONBEFOREACTIVATE');
      DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREDEACTIVATE: OutputDebugString('iframe:ONBEFOREDEACTIVATE');
    else
//      Result := inherited DoInvoke(DispID, IID, LocaleID, Flags, dps, pDispIds,
//         VarResult, ExcepInfo, ArgErr);
      OutputDebugString(PChar('HTMLDOCEVENT = ' + IntToStr(DispID)));
    end;
  {$ENDIF}
end;

function TIFrameDocEventDispatch.GetEventInterface: IInterface;
begin
  Result := Document;
end;

initialization
  // Required for Cut and Copy to work within the MSTHML control
  OleInitialize(nil);
finalization
  OleUnInitialize;
end.

