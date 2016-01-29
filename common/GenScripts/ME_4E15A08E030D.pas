unit nscStatusBar;

interface

uses
 l3IntfUses
 , TB97Tlbr
 , afwInterfaces
 , nscNewInterfaces
 , ExtCtrls
 , l3ProtoObjectRefList
 , Messages
 , Classes
 , Controls
 , l3ProtoObject
 , TB97
;

type
 TnscStatusBarDock = class(TDock97, IafwAlwaysOnTopControl)
 end;//TnscStatusBarDock
 
 TnscStatusBar = class(TCustomToolbar97, IafwStatusBar, InscStatusBarItemsVisualizer)
  procedure SetLink;
  procedure ReleaseLink;
  procedure DoUpdateStrings(const aStrings: TafwStatusInfo;
   aCheckActions: Boolean;
   aDelayed: Boolean);
  procedure TimerProc(Sender: TObject);
  procedure FireUpUpdateStringsTimer;
  procedure UpdateStringsTimerProc(Sender: TObject);
  function AllVisiblePanelsText: AnsiString;
  procedure WMGetText(var Msg: TWMGetText);
  procedure WMGetTextLength(var Msg: TWMGetTextLength);
  procedure UpdateStrings(const aStrings: TafwStatusInfo);
  procedure RegisterProvider(const aProvider: InscStatusBarItemsProvider);
  procedure UnregisterProvider(const aProvider: InscStatusBarItemsProvider);
 end;//TnscStatusBar
 
implementation

uses
 l3ImplUses
 , SysUtils
 , afwFacade
 , tb97GraphicControl
 , vcmBaseMenuManager
 , ActnList
 , Graphics
 , vcmBase
 , l3MinMax
 , l3Base
 , l3InterfacesMisc
 , l3String
 , nscSizeGripPanel
 , nscStatusBarButton
 , nscStatusBarPanel
 , nscStatusBarSep
 , tb97Ctls
 , StatusBarUtils
 , TtfwClassRef_Proxy
 , StatusBarWords
;

type
 TOperationInternalDef = class(Tl3ProtoObject)
  procedure Create(const aDef: InscStatusBarItemDef;
   const aProvider: InscStatusBarItemsProvider);
 end;//TOperationInternalDef
 
end.
