unit vtNavigator;
 {* - управляет стыковкой(отстыковкой) закладок;
- управляет режимом автоскрытия; минимизирует навигатор;
- изменяет размер навигатора; }

// Модуль: "w:\common\components\gui\Garant\VT\vtNavigator.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtNavigator" MUID: (4C8A252E01C2)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , ElPgCtlConsts
 , l3ProtoObject
 , afwCustomCommonControl
 , vtCustomCommonPanel
 , vcmExternalInterfaces
 , Classes
 , ElPgCtl
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
 , Types
 , Windows
 , Graphics
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3WinControlCanvas
 {$If NOT Defined(NoTB97)}
 , tb97Ctls
 {$IfEnd} // NOT Defined(NoTB97)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Forms
 , afwInterfaces
 , l3TabbedContainersDispatcher
 , l3ObjectList
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *4C8A252E01C2intf_uses*
 //#UC END# *4C8A252E01C2intf_uses*
;

const
 CM_npAfterUndock = WM_USER + 1;
 CM_npChangeActivate = WM_USER + 3;
  {* используется при необходимости изменить активность }
 CM_npDeleteFromList = WM_USER + 4;
  {* удалить навигатор из списка навигатора, который его породил wParam содержит pointer на удаляемый навигатор }
 CM_npDoActionWithFormControls = WM_USER + 5;
  {* асинхронно посылается после пристыковывания плавающего навигатора на форму }
 CM_npTabPositionChanged = WM_USER + 6;
  {* уведомляем компоненты об изменении расположения закладок }
 CM_npDockToFloatWindow = WM_USER + 7;
  {* сделать форму (закладку) плавающей. WParam - указатель на компонент который нужно отстыковать }
 PM_ISACTIVECONTROL = ElPgCtlConsts.PM_ISACTIVECONTROL;

type
 RnpPageControl = class of TnpPageControl;

 RnpFloatingWindow = class of TnpFloatingWindow;

 RvtNavigator = class of TvtNavigatorPrim;

 TnpObject = class(Tl3ProtoObject)
 end;//TnpObject

 TNavigatorState = (
  nsNormal
  , nsMinimized
  , nsAutoHide
 );//TNavigatorState

 TnpDrawSplitterType = (
  dstErase
  , dstPaint
 );//TnpDrawSplitterType

 TnpDrawSplitterTypes = set of TnpDrawSplitterType;

 TnpCustomControl = class(TafwCustomCommonControl)
 end;//TnpCustomControl

 TnpCustomPanel = class(TvtCustomCommonPanel, IvcmDockType)
  protected
   function Get_ControlIsPanel: Boolean;
 end;//TnpCustomPanel

 TnpHideDirect = (
  {* направление скрытия навигатора в режиме nsAutoHide }
  hdNone
  , hdHide
  , hdShow
 );//TnpHideDirect

 TnpChangeLink = class(TnpObject)
  {* используется для уведомления об изменении состояния навигатора (nsAutoHide, nsNormal, nsMinimized) }
  private
   f_OnStateChanged: TNotifyEvent;
  public
   property OnStateChanged: TNotifyEvent
    read f_OnStateChanged
    write f_OnStateChanged;
 end;//TnpChangeLink

 TOnSaveSizeNavigator = procedure(Sender: TObject;
  aSize: Integer) of object;
  {* возникает при уничтожении навигатора, чтобы клиент мог сохранить размеры навигатора }

 TOnLoadSizeNavigator = procedure(Sender: TObject;
  var aSize: Integer) of object;

 TnpFloatWindowState = (
  fwsNormal
  , fwsMinimized
 );//TnpFloatWindowState

 TvtNavigatorPrim = class;

 TnpPageControl = class(TElCustomPageControl)
  {* pagecontrol используемый в навигаторе }
  private
   f_Navigator: TvtNavigatorPrim;
  private
   procedure CMDockNotification(var Message: TCMDockNotification); message CM_DOCKNOTIFICATION;
    {* при изменении видимости первого пристыковыванного компонента показываем навигатор }
   procedure PMIsActiveControl(var Message: TMessage); message PM_ISACTIVECONTROL;
    {* определяет активен ли компонент. Если навигатор находится в свернутом состоянии, то компонент в любом случае не активен }
   procedure PMSetActivePageWithControl(var Message: TMessage); message PM_SETACTIVEPAGEWITHCONTROL;
    {* при активации закладки, если навигатор был свернут, то он разворачивается }
   procedure WMKeyDown(var Msg: TWMKeyDown); message WM_KEYDOWN;
   procedure WMSysKeyDown(var Msg: TWMSysKeyDown); message WM_SYSKEYDOWN;
   procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
  protected
   function IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
   procedure Notification(AComponent: TComponent;
    Operation: TOperation); override;
   {$If NOT Defined(NoVCL)}
   procedure GetSiteInfo(Client: TControl;
    var InfluenceRect: TRect;
    MousePos: TPoint;
    var CanDock: Boolean); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure RequestTabPosition; override;
  public
   constructor Create(AOwner: TComponent); override;
   {$If NOT Defined(NoVCL)}
   procedure DockDrop(Source: TDragDockObject;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure DoActivePrevPage; override;
 end;//TnpPageControl

 TnpSurface = class;

 TnpContainerSurface = class(TnpCustomControl)
  private
   f_Surface: TnpSurface;
  private
   procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    {* иначе границы toolbar-ов не прорисовываются }
  protected
   procedure pm_SetSurface(aValue: TnpSurface);
  public
   class function Make(aSurface: TnpSurface): TnpContainerSurface;
  public
   property Surface: TnpSurface
    read f_Surface
    write pm_SetSurface;
 end;//TnpContainerSurface

 TnpSplitter = class;

 TnpHeaderPrim = class;

 TnpSurface = class(TnpCustomControl)
  {* Подложка. На подложке лежат TnpHeader (заголовок ) и PageControl }
  private
   f_Link: TnpChangeLink;
   f_Container: TnpContainerSurface;
   f_PageControl: TnpPageControl;
   f_Header: TnpHeaderPrim;
   f_Navigator: TvtNavigatorPrim;
  protected
   f_Splitter: TnpSplitter;
  private
   procedure InitAutoHidePosition;
    {* обновить Left окна }
   procedure OnStateChanged(Sender: TObject);
   procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
  protected
   procedure pm_SetPageControl(aValue: TnpPageControl);
   procedure pm_SetHeader(aValue: TnpHeaderPrim);
   function pm_GetSize: Integer;
   procedure pm_SetNavigator(aValue: TvtNavigatorPrim);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure Paint; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   procedure SetSizeMini;
   procedure DefineSplitterAlign;
   constructor Create(AOwner: TComponent); override;
  public
   property PageControl: TnpPageControl
    read f_PageControl
    write pm_SetPageControl;
   property Header: TnpHeaderPrim
    read f_Header
    write pm_SetHeader;
   property Size: Integer
    read pm_GetSize;
   property Navigator: TvtNavigatorPrim
    read f_Navigator
    write pm_SetNavigator;
 end;//TnpSurface

 TnpSplitter = class(TnpCustomControl)
  {* сплиттер используемый в навигаторе }
  private
   f_MouseDownPoint: TPoint;
   f_LastMovingPoint: TPoint;
   f_IsHideButtonDown: Boolean;
   f_HideButtonHint: THintWindow;
    {* подсказка к кнопке "скрыть\развернуть" }
   f_IsMouseDown: Boolean;
  protected
   f_Surface: TnpSurface;
  private
   procedure splShowHint(X: Integer;
    Y: Integer);
   procedure splHideHint;
   function CreateButtonHint: THintWindow;
   procedure UpdateCursor(aButton: Boolean = True);
   procedure DrawButton(aCanvas: TCanvas = nil);
   function GetButtonRect: TRect;
    {* определяет прямоугольник для кнопки }
   procedure SetSizeCursor;
    {* устанавливает курсор для изменения размеров }
   function IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
   procedure WMKeyDown(var Msg: TWMKeyDown); message WM_KEYDOWN;
   procedure WMSysKeyDown(var Msg: TWMSysKeyDown); message WM_SYSKEYDOWN;
   procedure CNKeyDown(var Msg: TWMKeyDown); message CN_KEYDOWN;
   procedure CNSysKeyDown(var Msg: TWMSysKeyDown); message CN_SYSKEYDOWN;
   procedure WMMouseLeave(var Msg: TMessage); message WM_MOUSELEAVE;
  protected
   procedure pm_SetIsHideButtonDown(aValue: Boolean);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure MouseMove(Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure MouseUp(Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure MouseDown(Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure Paint; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   constructor Create(AOwner: TComponent); override;
  protected
   property IsHideButtonDown: Boolean
    read f_IsHideButtonDown
    write pm_SetIsHideButtonDown;
   property HideButtonHint: THintWindow
    read f_HideButtonHint
    write f_HideButtonHint;
    {* подсказка к кнопке "скрыть\развернуть" }
   property IsMouseDown: Boolean
    read f_IsMouseDown
    write f_IsMouseDown;
 end;//TnpSplitter

 TnpButton = class;

 TnpHeaderPrim = class(TnpCustomControl)
  {* панель отображающаяся в навигаторе. Содержит кнопки включения(отключения автоскрытия) и скрытия панели до размеров вкладки. Событие OnMouseDown инициализирует перетаскиваение активного компонента. }
  private
   f_Canvas: Tl3WinControlCanvas;
   f_Link: TnpChangeLink;
   f_CloseButton: TnpButton;
   f_HideButton: TnpButton;
   f_AutoHideButton: TnpButton;
   f_IsDragBegining: Boolean;
    {* определяет была ли инициализирована операция Control.IsDragBegining от заголовка. }
   f_CloseImage: TImageIndex;
   f_AutoHideOnImage: TImageIndex;
   f_AutoHideOffImage: TImageIndex;
   f_HideLeftImage: TImageIndex;
   f_HideRightImage: TImageIndex;
   f_HideUpImage: TImageIndex;
   f_HideDownImage: TImageIndex;
   f_Size: Integer;
   f_ButtonsImageList: TCustomImageList;
   f_Navigator: TvtNavigatorPrim;
  private
   procedure HideCloseButton;
   procedure ShowCloseButton(const aHandler: IvcmFormHandler);
   procedure CloseButtonVisible(aValue: Boolean);
    {* изменить видимость кнопки закрыть, установить кнопку видимой без установленного обработчика OnClick нельзя }
   procedure UpdateImages;
   procedure UpdateSize;
   procedure UpdatePositions;
   procedure UpdateHideImage;
   procedure UpdateCloseImage;
   procedure UpdateAutoHideImage;
   function GetRectLines: TRect;
   procedure DoStateChanged;
   procedure OnStateChanged(Sender: TObject);
   procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
   function pm_GetAlign: TAlign;
   procedure pm_SetAlign(aValue: TAlign);
   procedure pm_SetCloseImage(aValue: TImageIndex);
   procedure pm_SetAutoHideOnImage(aValue: TImageIndex);
   procedure pm_SetAutoHideOffImage(aValue: TImageIndex);
   procedure pm_SetHideLeftImage(aValue: TImageIndex);
   procedure pm_SetHideRightImage(aValue: TImageIndex);
   procedure pm_SetHideUpImage(aValue: TImageIndex);
   procedure pm_SetHideDownImage(aValue: TImageIndex);
   function pm_GetSize: Integer;
   procedure pm_SetSize(aValue: Integer);
   function pm_GetOnHide: TNotifyEvent;
   procedure pm_SetOnHide(aValue: TNotifyEvent);
   function pm_GetOnAutoHide: TNotifyEvent;
   procedure pm_SetOnAutoHide(aValue: TNotifyEvent);
   procedure pm_SetButtonsImageList(aValue: TCustomImageList);
   procedure pm_SetNavigator(aValue: TvtNavigatorPrim);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure MouseDown(Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure Paint; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure AdjustClientRect(var Rect: TRect); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   constructor Create(AOwner: TComponent); override;
  protected
   property IsDragBegining: Boolean
    read f_IsDragBegining
    write f_IsDragBegining;
    {* определяет была ли инициализирована операция Control.IsDragBegining от заголовка. }
  public
   property CloseButton: TnpButton
    read f_CloseButton;
   property HideButton: TnpButton
    read f_HideButton;
   property AutoHideButton: TnpButton
    read f_AutoHideButton;
   property Align: TAlign
    read pm_GetAlign
    write pm_SetAlign;
   property CloseImage: TImageIndex
    read f_CloseImage
    write pm_SetCloseImage;
   property AutoHideOnImage: TImageIndex
    read f_AutoHideOnImage
    write pm_SetAutoHideOnImage;
   property AutoHideOffImage: TImageIndex
    read f_AutoHideOffImage
    write pm_SetAutoHideOffImage;
   property HideLeftImage: TImageIndex
    read f_HideLeftImage
    write pm_SetHideLeftImage;
   property HideRightImage: TImageIndex
    read f_HideRightImage
    write pm_SetHideRightImage;
   property HideUpImage: TImageIndex
    read f_HideUpImage
    write pm_SetHideUpImage;
   property HideDownImage: TImageIndex
    read f_HideDownImage
    write pm_SetHideDownImage;
   property Size: Integer
    read pm_GetSize
    write pm_SetSize;
   property OnHide: TNotifyEvent
    read pm_GetOnHide
    write pm_SetOnHide;
   property OnAutoHide: TNotifyEvent
    read pm_GetOnAutoHide
    write pm_SetOnAutoHide;
   property ButtonsImageList: TCustomImageList
    read f_ButtonsImageList
    write pm_SetButtonsImageList;
   property Navigator: TvtNavigatorPrim
    read f_Navigator
    write pm_SetNavigator;
 end;//TnpHeaderPrim

 TnpButtonType = (
  {* Тип кнопки }
  nbtAutoHide
  , nbtMinimize
  , nbtClose
 );//TnpButtonType

 TnpButton = class({$If NOT Defined(NoTB97)}
 TCustomToolbarButton97
 {$IfEnd} // NOT Defined(NoTB97)
 )
  {* кнопки использующиеся в TvtNavigator }
  private
   f_BtnType: TnpButtonType;
   f_Navigator: TvtNavigatorPrim;
  private
   procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
   procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
  public
   constructor Create(aOwner: TComponent;
    aNavigator: TvtNavigatorPrim;
    aBtnType: TnpButtonType); reintroduce;
   function MakeHint: AnsiString;
 end;//TnpButton

 TnpFloatingWindow = class(Tl3Form, IafwFloatingWindow)
  {* плавающая форма содержащая плавающий навигатор. Форма создается если NewTarget отстыкованного компонента = nil. Форму можно перемещать за TnpHeader. При этом вызывается метод IsDragBegining первого компонента активной вкладки f_PageControl.ActivePage.Controls[0], если компонент не был пристыкован, то форма перемещается в место где была отпущена рамка. }
  private
   f_SizeNormal: Integer;
   f_CloseDisabled: Boolean;
   f_ReactivateDisabled: Boolean;
   f_Navigator: TvtNavigatorPrim;
   f_State: TnpFloatWindowState;
    {* состояние плавающего окна }
   f_FloatID: Integer;
  private
   function GetGripperRect: TRect;
   function GetGripperHeight: Integer;
   function CheckGripperCursor: Boolean;
   {$If Defined(Nemesis)}
   procedure UpdateFloatWindowsBounds;
   {$IfEnd} // Defined(Nemesis)
   procedure OnChangeState(Sender: TObject);
   procedure OnCloseWindow(Sender: TObject);
   procedure FormOnResize(Sender: TObject);
   procedure FormClose(Sender: TObject;
    var Action: TCloseAction);
   procedure OnTabSheetClick(Sender: TObject;
    Page: TElTabSheet);
   procedure OnDockDrop(Sender: TObject;
    Source: TDragDockObject;
    X: Integer;
    Y: Integer);
   procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
   procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
   procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
   procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
   procedure pm_SetState(aValue: TnpFloatWindowState); virtual;
   function GetNavigatorClass: RvtNavigator; virtual;
   procedure DisableClose;
   procedure DisableReactivate;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   function CloseQuery: Boolean; override;
    {* CloseQuery is called automatically when an attempt is made to close the form. CloseQuery can allow the form to close by returning true, or prevent the form from closing by returning false.

As implemented in TCustomForm, CloseQuery polls any MDI children by calling their CloseQuery methods. If no child form aborts the close, CloseQuery then calls the OnCloseQuery event handler, if it exists, to determine if the close should be allowed. If no such event handler exists, CloseQuery returns true. }
   {$IfEnd} // NOT Defined(NoVCL)
  public
   {$If NOT Defined(NoVCL)}
   constructor CreateNew(AOwner: TComponent;
    Dummy: Integer = 0); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   property Navigator: TvtNavigatorPrim
    read f_Navigator
    write f_Navigator;
   property State: TnpFloatWindowState
    read f_State
    write pm_SetState;
    {* состояние плавающего окна }
   property FloatID: Integer
    read f_FloatID
    write f_FloatID;
 end;//TnpFloatingWindow

 TvtNavigatorPrim = class(TnpCustomPanel, IvcmState, IvcmToolbarNotifier, IafwTabSheetControl, IvcmFormHandlersPublisher, Il3SelectedTabDependent)
  private
   f_Surface: TnpSurface;
   f_MainForm: TCustomForm;
    {* главная форма на которой находится навигатор }
   f_ClickOnTab: Boolean;
    {* пользователь щелкнул на закладке }
   f_SplitterRect: TRect;
   f_ActiveControl: TControl;
    {* элемент управления на активной закладке перед отстыковкой }
   f_IsInitDockDrop: Boolean;
   f_ClickPoint: TPoint;
    {* точка клика по отношению к координатам навигатора }
   f_DockRect: TRect;
   f_EndDockClient: TControl;
   f_NavigatorList: Tl3ObjectList;
   f_ParentNavigatorHandle: THandle;
   f_ImportNavigator: TvtNavigatorPrim;
    {* при осуществлении стыковки компонента если свойство заполнено, то импортиртируются все закладки из плавающего навигатора после чего он удаляется }
   f_ExportPageControl: TnpPageControl;
   f_FloatNavigator: TnpFloatingWindow;
    {* плавающий навигатор в котором находится TvtNavigator }
   f_SetCursorResize: Boolean;
   f_MouseDown: Boolean;
   f_HideDirect: TnpHideDirect;
   f_DblClickUnDock: Boolean;
    {* закладка была отстыкована по DblClick-у }
   f_CountUndock: Integer;
    {* счетчик отстыкованных по DblClick-у закладок, нужен для каскадного расположения отстыкованных закладок }
   f_ParentRestore: Boolean;
    {* родительской окно было восстановлено }
   f_RelativeNavigator: TvtNavigatorPrim;
   f_FormWasMinimized: Boolean;
    {* форма была минимизирована }
   f_IsFloatingOnShow: Boolean;
   f_TimerFloat: TTimer;
    {* используется для эффекта всплывание }
   f_TimerDelay: TTimer;
    {* используется при генерации задержки в режиме автоскрытие с задержкой }
   f_DoDelay: Boolean;
   f_IsDelay: Boolean;
    {* переменная устанавливается при изменении состояния навигатора, сбрасывается при наступлении события OnTimer }
   f_DockInSelf: Boolean;
    {* если форма плавает и клиент отстыкован в никуда, то стыкуем его обратно }
   f_ChangeLinks: Tl3ObjectList;
    {* в списке содержатся TNotifyEvent клиентов подписанных на нотификацию об измнении состояния навигатора }
   {$If Defined(Nemesis)}
   f_PageDeactivated: Boolean;
   {$IfEnd} // Defined(Nemesis)
   {$If Defined(Nemesis)}
   f_ParentMainForm: TCustomForm;
   {$IfEnd} // Defined(Nemesis)
   f_SizeNormalLoaded: Boolean;
   f_SizeMini: Integer;
   f_Swim: Boolean;
   f_Activate: Boolean;
    {* активизирует, деактивизирует навигатор }
   f_PageControl: TnpPageControl;
   f_Float: Boolean;
   f_State: TNavigatorState;
   f_ShowActivePageInHeader: Boolean;
    {* выводить иконку и название активной закладки в заголовке навигатора }
   f_AutoHideOffHint: AnsiString;
   f_AutoHideOnHint: AnsiString;
   f_MinimizedOnHint: AnsiString;
   f_MinimizedOffHint: AnsiString;
   f_CloseHint: AnsiString;
   f_OnSaveSize: TOnSaveSizeNavigator;
   f_OnLoadSize: TOnLoadSizeNavigator;
   f_AutoHideFloat: Boolean;
   f_DelayIntervalOnShow: Integer;
   f_DelayIntervalOnHide: Integer;
   f_DelayOnAutoHide: Boolean;
   f_SingleFloatNavigator: Boolean;
   f_SizeEmpty: Integer;
   f_SizeNormal: Integer;
   f_OnStateChange: TNotifyEvent;
   f_UnDockFromFloat: Boolean;
   f_NavigatorOnForm: TvtNavigatorPrim;
    {* навигатор от которого произошел данный навигатор. Метод нужен для того чтобы методы возвращали все навигаторы которое произошли от навигатора на форме }
  protected
   f_Header: TnpHeaderPrim;
  private
   function CorrectSize(aSizeNormal: Integer): Integer;
    {* откорректировать размер }
   function RelativeAlign: TAlign;
    {* выравнивание навигатора - соседа }
   function FindRelative(aAlign: TAlign): TvtNavigatorPrim;
    {* найти навигатор на той же форме с указанным выравниванием. Делаем допущение, что на форме может быть только один навигатор с указанным типом выравнивания }
   function CalcBounds(aSizeNormal: Integer): TRect;
    {* вычислить новые границы с указанным нормальным размером }
   function CalcSize(const aBounds: TRect): Integer;
    {* вычисляет размер }
   function CorrectBounds(const aBounds: TRect): TRect;
    {* корректирует новые размеры навигатора. Необходимо при перетаскивании навигатора и при сплиттинге }
   procedure UpdateSize;
   procedure AutoUpdateSize;
   procedure ResetDragInfo;
    {* сбрасывает флаги используемые при перетаскивании }
   function IsUndockByUser: Boolean;
    {* True, если закладки отстыкованы пользователем }
   procedure OnDblClickUndock(var CanUnDock: Boolean;
    aControl: TControl);
    {* не разрешаем отстыковывать закладку, пристыковываем её на форму }
   procedure CreateSurface;
   procedure CreateHeader;
   procedure CreatePageControl;
   procedure InitMainForm(aOwner: TComponent);
   procedure RecalcSize;
   procedure SetSize(aValue: Integer;
    aControl: TControl = nil);
    {* устанавливает размер навигатора в зависимости от Align }
   procedure UpdateState;
    {* действует используя State }
   procedure PlaceSurface;
   procedure AttachSurface;
   procedure DetachSurface;
   procedure SetSizeMini;
   procedure DoAutoHide;
    {* подготавливает компоненты при включении режима автоскрытия }
   function CalcNewFloatBounds: TRect;
   procedure SetDockRect(DragDockObject: TDragDockObject);
   procedure InitDrag(aControl: TControl);
   function CheckControl(aControl: TControl): Boolean;
   function DoLoadSize: Integer;
   function FindFloatNavigator: TnpFloatingWindow;
    {* возвращает плавающий навигатор, если он не создан, то nil }
   procedure UpdateCloseButton;
   function GetNewBoundsFromPoint(X: Integer;
    Y: Integer): TRect;
   procedure AddNavigator(P: TnpFloatingWindow);
   procedure AutoHideUpdate;
   procedure CloseDelay;
   procedure DelNavigator(P: TnpFloatingWindow);
   function DockToFloatNavigator(aControl: TControl): TnpFloatingWindow;
    {* если клиент компонента не пристыкован ни к одному навигатору, то он автоматически пристыковывается к плавающему навигатору }
   procedure Minimized;
   procedure DoSaveSize;
   procedure DrawSplit(const aRect: TRect);
   procedure InitDockDrop;
   procedure ModeAutoUpdate;
   procedure ModeHide;
   procedure ModeNormalUpdate;
   procedure ModeStateUpdate;
    {* скрывает (если ничего не пристыковано) / показывает PageControl }
   procedure ModeStateUpdateAfter;
    {* посылает сообщение CM_npAfterUndock }
   procedure MovePagesToNavigator(var Value: TvtNavigatorPrim;
    DockControl: TControl);
   procedure OpenDelay;
   procedure PaintSpliter(X: Integer;
    Y: Integer;
    aDrawSplitterType: TnpDrawSplitterTypes);
   procedure OnEndDockControl(Sender: TObject;
    Target: TObject;
    X: Integer;
    Y: Integer);
   procedure OnTabSheetClick(Sender: TObject;
    Page: TElTabSheet);
   procedure OnHide(Sender: TObject);
   procedure OnAutoHide(Sender: TObject);
   procedure OnPageControlResize(Sender: TObject);
   procedure OnPageControlChange(Sender: TObject);
   procedure OnTimerFloat(Sender: TObject);
   procedure OnTimerDelay(Sender: TObject);
   procedure OnPageControlUnDock(Sender: TObject;
    Client: TControl;
    NewTarget: TWinControl;
    var Allow: Boolean);
   procedure OnStartDragControl(Sender: TObject;
    aDragControl: TControl);
   {$If Defined(Nemesis)}
   procedure OnFormPositionDockRect(Sender: TObject;
    DragDockObject: TDragDockObject);
   {$IfEnd} // Defined(Nemesis)
   procedure SetSelfSize(aSize: Integer);
   procedure DoSplit;
   procedure SetUndockSize;
   function GetNavigatorSizeNormal(aControl: TControl): Integer;
   function GetDockRect(aDockSize: Integer = -1): TRect;
   procedure NormalUpdateSize;
   procedure ModeShow;
   procedure DoActivate(aActive: Boolean);
   procedure CMnpChangeActivate(var Message: TMessage); message CM_npChangeActivate;
   procedure CMAfterUndock(var Message: TMessage); message CM_npAfterUndock;
   procedure CMDelNavFromList(var Message: TMessage); message CM_npDeleteFromList;
   procedure CMNPDoActionWithFormControls(var Message: TMessage); message CM_npDoActionWithFormControls;
   procedure CMnpDockToFloatWindow(var Message: TMessage); message CM_npDockToFloatWindow;
   procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
   function pm_GetRelativeNavigator: TvtNavigatorPrim;
   function pm_GetClientControl: TWinControl;
   function pm_GetSizeMini: Integer;
   procedure pm_SetSwim(aValue: Boolean);
   procedure pm_SetActivate(aValue: Boolean);
   function pm_GetIsMinimized: Boolean;
   function pm_GetPages(anIndex: Integer): TElTabSheet;
   function pm_GetActivePageIndex: Integer;
   procedure pm_SetActivePageIndex(aValue: Integer);
   function pm_GetPageCount: Integer;
   procedure pm_SetFloat(aValue: Boolean);
   function pm_GetState: TNavigatorState;
   procedure pm_SetState(aValue: TNavigatorState);
   procedure pm_SetShowActivePageInHeader(aValue: Boolean);
   function pm_GetImages: TCustomImageList;
   procedure pm_SetImages(aValue: TCustomImageList);
   procedure pm_SetDelayOnAutoHide(aValue: Boolean);
   procedure pm_SetSingleFloatNavigator(aValue: Boolean);
   function pm_GetAlign: TAlign; virtual;
   procedure pm_SetAlign(aValue: TAlign); virtual;
   procedure pm_SetSizeEmpty(aValue: Integer);
   procedure pm_SetSizeNormal(aValue: Integer);
   function pm_GetButtonsImageList: TCustomImageList;
   procedure pm_SetButtonsImageList(aValue: TCustomImageList);
   function pm_GetCloseImage: TImageIndex;
   procedure pm_SetCloseImage(aValue: TImageIndex);
   function pm_GetAutoHideOnImage: TImageIndex;
   procedure pm_SetAutoHideOnImage(aValue: TImageIndex);
   function pm_GetAutoHideOffImage: TImageIndex;
   procedure pm_SetAutoHideOffImage(aValue: TImageIndex);
   function pm_GetHideLeftImage: TImageIndex;
   procedure pm_SetHideLeftImage(aValue: TImageIndex);
   function pm_GetHideRightImage: TImageIndex;
   procedure pm_SetHideRightImage(aValue: TImageIndex);
   function pm_GetHideUpImage: TImageIndex;
   procedure pm_SetHideUpImage(aValue: TImageIndex);
   function pm_GetHideDownImage: TImageIndex;
   procedure pm_SetHideDownImage(aValue: TImageIndex);
   procedure pm_SetNavigatorOnForm(aValue: TvtNavigatorPrim);
   procedure DoStateChanged(aNavigatorState: Boolean = False); virtual;
   function GetPageControlClass: RnpPageControl; virtual;
   function GetFloatingWindowClass: RnpFloatingWindow; virtual;
   procedure UpdateMainForm(aNewMainForm: TCustomForm);
   function AutoHideOffHintStored: Boolean;
    {* "Функция определяющая, что свойство AutoHideOffHint сохраняется" }
   function AutoHideOnHintStored: Boolean;
    {* "Функция определяющая, что свойство AutoHideOnHint сохраняется" }
   function MinimizedOnHintStored: Boolean;
    {* "Функция определяющая, что свойство MinimizedOnHint сохраняется" }
   function MinimizedOffHintStored: Boolean;
    {* "Функция определяющая, что свойство MinimizedOffHint сохраняется" }
   function CloseHintStored: Boolean;
    {* "Функция определяющая, что свойство CloseHint сохраняется" }
   function SaveState(out theState: IUnknown;
    aStateType: TvcmStateType): Boolean;
   function LoadState(const theState: IUnknown;
    aStateType: TvcmStateType): Boolean;
   procedure PageInactive;
    {* активная закладка стала не активной. }
   procedure PageActive;
    {* закладка стала активной. }
   function pm_GetWeight: Integer;
   procedure SmallToolbarSize(aValue: Integer);
   procedure Publish(const aCloseHandler: IvcmFormHandler);
   procedure TabBecomeActive;
   procedure TabBecomeInactive;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure Resize; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure SetBounds(ALeft: Integer;
    ATop: Integer;
    AWidth: Integer;
    AHeight: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure SetParent(AParent: TWinControl); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure Notification(AComponent: TComponent;
    Operation: TOperation); override;
   {$If NOT Defined(NoVCL)}
   procedure DockOver(Source: TDragDockObject;
    X: Integer;
    Y: Integer;
    State: TDragState;
    var Accept: Boolean); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure GetSiteInfo(Client: TControl;
    var InfluenceRect: TRect;
    MousePos: TPoint;
    var CanDock: Boolean); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure SetName(const aValue: TComponentName); override;
   {$If NOT Defined(NoVCL)}
   procedure PositionDockRect(DragDockObject: TDragDockObject); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure AfterDestroyCalled; override;
   procedure ClearFields; override;
  public
   procedure RegisterStateChanged(aLink: TnpChangeLink);
    {* подписать клиента на нотификацию об изменении состояния навигатора }
   procedure UnRegisterStateChanged(aLink: TnpChangeLink);
    {* отписать клиента от нотификации об изменении состояния навигатора }
   function IsActiveControl(aControl: TControl): Boolean;
   function MinBtnHint: AnsiString;
   procedure AssignNav(aDest: TvtNavigatorPrim);
   procedure hCBT(Code: Integer;
    WParam: WPARAM;
    LParam: LPARAM);
    {* сообщение получаемое от WH_CBT }
   procedure hGetMessage(aMessage: PMsg);
   procedure Assign(Source: TPersistent); override;
   constructor Create(AOwner: TComponent); override;
   {$If NOT Defined(NoVCL)}
   procedure DockDrop(Source: TDragDockObject;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
  protected
   property RelativeNavigator: TvtNavigatorPrim
    read pm_GetRelativeNavigator;
    {* навигатор сосед }
   property ClientControl: TWinControl
    read pm_GetClientControl;
    {* клиентский компонент, с которым граничит навигатор }
   property SizeMini: Integer
    read pm_GetSizeMini;
   property Swim: Boolean
    read f_Swim
    write pm_SetSwim;
   property Activate: Boolean
    read f_Activate
    write pm_SetActivate;
    {* активизирует, деактивизирует навигатор }
   property NavigatorOnForm: TvtNavigatorPrim
    read f_NavigatorOnForm
    write pm_SetNavigatorOnForm;
    {* навигатор от которого произошел данный навигатор. Метод нужен для того чтобы методы возвращали все навигаторы которое произошли от навигатора на форме }
  public
   property IsMinimized: Boolean
    read pm_GetIsMinimized;
   property Pages[anIndex: Integer]: TElTabSheet
    read pm_GetPages;
   property ActivePageIndex: Integer
    read pm_GetActivePageIndex
    write pm_SetActivePageIndex;
   property PageCount: Integer
    read pm_GetPageCount;
   property PageControl: TnpPageControl
    read f_PageControl;
   property Float: Boolean
    read f_Float
    write pm_SetFloat;
   property State: TNavigatorState
    read pm_GetState
    write pm_SetState;
   property ShowActivePageInHeader: Boolean
    read f_ShowActivePageInHeader
    write pm_SetShowActivePageInHeader;
    {* выводить иконку и название активной закладки в заголовке навигатора }
   property AutoHideOffHint: AnsiString
    read f_AutoHideOffHint
    write f_AutoHideOffHint
    stored AutoHideOffHintStored;
   property AutoHideOnHint: AnsiString
    read f_AutoHideOnHint
    write f_AutoHideOnHint
    stored AutoHideOnHintStored;
   property MinimizedOnHint: AnsiString
    read f_MinimizedOnHint
    write f_MinimizedOnHint
    stored MinimizedOnHintStored;
   property MinimizedOffHint: AnsiString
    read f_MinimizedOffHint
    write f_MinimizedOffHint
    stored MinimizedOffHintStored;
   property CloseHint: AnsiString
    read f_CloseHint
    write f_CloseHint
    stored CloseHintStored;
   property OnSaveSize: TOnSaveSizeNavigator
    read f_OnSaveSize
    write f_OnSaveSize;
   property OnLoadSize: TOnLoadSizeNavigator
    read f_OnLoadSize
    write f_OnLoadSize;
   property Images: TCustomImageList
    read pm_GetImages
    write pm_SetImages;
   property AutoHideFloat: Boolean
    read f_AutoHideFloat
    write f_AutoHideFloat;
   property DelayIntervalOnShow: Integer
    read f_DelayIntervalOnShow
    write f_DelayIntervalOnShow;
   property DelayIntervalOnHide: Integer
    read f_DelayIntervalOnHide
    write f_DelayIntervalOnHide;
   property DelayOnAutoHide: Boolean
    read f_DelayOnAutoHide
    write pm_SetDelayOnAutoHide;
   property SingleFloatNavigator: Boolean
    read f_SingleFloatNavigator
    write pm_SetSingleFloatNavigator;
   property Align: TAlign
    read pm_GetAlign
    write pm_SetAlign;
   property SizeEmpty: Integer
    read f_SizeEmpty
    write pm_SetSizeEmpty;
   property SizeNormal: Integer
    read f_SizeNormal
    write pm_SetSizeNormal;
   property OnStateChange: TNotifyEvent
    read f_OnStateChange
    write f_OnStateChange;
   property UnDockFromFloat: Boolean
    read f_UnDockFromFloat
    write f_UnDockFromFloat;
   property ButtonsImageList: TCustomImageList
    read pm_GetButtonsImageList
    write pm_SetButtonsImageList;
   property CloseImage: TImageIndex
    read pm_GetCloseImage
    write pm_SetCloseImage;
   property AutoHideOnImage: TImageIndex
    read pm_GetAutoHideOnImage
    write pm_SetAutoHideOnImage;
   property AutoHideOffImage: TImageIndex
    read pm_GetAutoHideOffImage
    write pm_SetAutoHideOffImage;
   property HideLeftImage: TImageIndex
    read pm_GetHideLeftImage
    write pm_SetHideLeftImage;
   property HideRightImage: TImageIndex
    read pm_GetHideRightImage
    write pm_SetHideRightImage;
   property HideUpImage: TImageIndex
    read pm_GetHideUpImage
    write pm_SetHideUpImage;
   property HideDownImage: TImageIndex
    read pm_GetHideDownImage
    write pm_SetHideDownImage;
 end;//TvtNavigatorPrim

 //#UC START# *52BAC7A10261ci*
 //#UC END# *52BAC7A10261ci*
 //#UC START# *52BAC7A10261cit*
 //#UC END# *52BAC7A10261cit*
 TnpHeader = class(TnpHeaderPrim)
 //#UC START# *52BAC7A10261publ*
 public
   property CloseImage default 6;
     {* - иконка для кнопки "Закрыть" плавающего навигатора. }
   property AutoHideOnImage default 0;
     {* - иконка для кнопки "Автоскрытие". }
   property AutoHideOffImage default 1;
     {* - иконка для кнопки "Автоскрытие". }
   property HideLeftImage default 2;
     {* - иконка для кнопки "Скрыть навигатор". }
   property HideRightImage default 3;
     {* - иконка для кнопки "Скрыть навигатор". }
   property HideUpImage default 4;
     {* - иконка для кнопки "Скрыть навигатор". }
   property HideDownImage default 5;
     {* - иконка для кнопки "Скрыть навигатор". }
 //#UC END# *52BAC7A10261publ*
 end;//TnpHeader

 //#UC START# *4C8A252E01C2ci*
 //#UC END# *4C8A252E01C2ci*
 //#UC START# *4C8A252E01C2cit*
 //#UC END# *4C8A252E01C2cit*
 TvtNavigator = {final} class(TvtNavigatorPrim)
  {* - управляет стыковкой(отстыковкой) закладок;
- управляет режимом автоскрытия; минимизирует навигатор;
- изменяет размер навигатора; }
 //#UC START# *4C8A252E01C2publ*
 protected
   property Swim default True;
 published
   property AutoHideOffHint;
   property AutoHideOnHint;
   property MinimizedOnHint;
   property MinimizedOffHint;
   property CloseHint;
   property OnSaveSize;
   property OnLoadSize;
   property Images;
   property AutoHideFloat default False;
   property DelayIntervalOnShow default 0;
   property DelayIntervalOnHide default 1000;
   property DelayOnAutoHide default False;
   property SingleFloatNavigator default True;
   property Align default alTop;
   property SizeEmpty;
   property SizeNormal;
   property OnStateChange;
   property UnDockFromFloat;
   property ButtonsImageList;
     {* - ImageList для кнопок. }
   property CloseImage default 6;
     {* - иконка для кнопки "Закрыть" плавающего навигатора. }
   property AutoHideOnImage default 0;
     {* - иконка для кнопки "Автоскрытие". }
   property AutoHideOffImage default 1;
     {* - иконка для кнопки "Автоскрытие". }
   property HideLeftImage default 2;
     {* - иконка для кнопки "Скрыть навигатор". }
   property HideRightImage default 3;
     {* - иконка для кнопки "Скрыть навигатор". }
   property HideUpImage default 4;
     {* - иконка для кнопки "Скрыть навигатор". }
   property HideDownImage default 5;
     {* - иконка для кнопки "Скрыть навигатор". }
   property Alignment;
   property Anchors;
   property AutoSize;
   property BevelInner;
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
   property DockSite default True;
   property DragCursor;
   property DragKind;
   property DragMode;
   property Enabled;
   property FullRepaint;
   property Font;
   property ParentBiDiMode;
   property ParentColor;
   property ParentCtl3D;
   property ParentFont;
   property ParentShowHint;
   property PopupMenu;
   property ShowHint;
   property TabOrder;
   property TabStop;
   property Visible;
   property OnCanResize;
   property OnClick;
   property OnConstrainedResize;
   property OnContextPopup;
   property OnDockDrop;
   property OnDockOver;
   property OnDblClick;
   property OnDragDrop;
   property OnDragOver;
   property OnEndDrag;
   property OnEnter;
   property OnExit;
   property OnGetSiteInfo;
   property OnMouseDown;
   property OnMouseMove;
   property OnMouseUp;
   property OnResize;
   property OnStartDrag;
   property OnUnDock;
 //#UC END# *4C8A252E01C2publ*
 end;//TvtNavigator
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3StringIDEx
 , vtNavigatorFormList
 , vtNavigatorRes
 , npControlsList
 , npNavigatorList
 , vtNavigatorUtils
 , OvcController
 , OvcConst
 , l3Base
 , Math
 , l3MinMax
 , l3String
 , SysUtils
 , l3CustomControlCanvas
 , l3Defaults
 , vtNavigatorFormListPrim
 , vtNavigatorForm
 , vcmForm
 , vcmEntityForm
 , vcmUtils
 , l3PopupControlService
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4C8A252E01C2impl_uses*
 //#UC END# *4C8A252E01C2impl_uses*
;

type
 TnpDoActionWithFormControl = (
  {* Действие, которое надо выполнить с компонентом на форме, который никуда не привязан }
  acRedraw
   {* компонент нужно перерисовать. Используется после отпускания и перерисовки splitter-а навигатора, иначе на компонентах с Align = alNone, оставалась полоса от сплиттера, т.к. их никто не перерисовывал (cq: 00015856). }
  , acUpInZOrder
   {* поднять по оси, чтобы после пристыковки навигатора, на заслонить лежащий в этом месте компонент }
 );//TnpDoActionWithFormControl

const
 {* Локализуемые строки Button Hints }
 str_cAutoHideOffHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cAutoHideOffHint'; rValue : 'Зафиксировать панель навигации');
  {* 'Зафиксировать панель навигации' }
 str_cAutoHideOnHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cAutoHideOnHint'; rValue : 'Сворачивать панель навигации');
  {* 'Сворачивать панель навигации' }
 str_cMinimizedOnHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cMinimizedOnHint'; rValue : 'Свернуть');
  {* 'Свернуть' }
 str_cMinimizedOffHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cMinimizedOffHint'; rValue : 'Развернуть');
  {* 'Развернуть' }
 str_cCloseHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cCloseHint'; rValue : 'Прикрепить навигатор');
  {* 'Прикрепить навигатор' }
 {* Локализуемые строки Error messages }
 str_cemIndexOutOfPageCount: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cemIndexOutOfPageCount'; rValue : 'Индекс %d выходит за пределы количества компонентов навигатора');
  {* 'Индекс %d выходит за пределы количества компонентов навигатора' }
 str_cemNavigatorAlreadyExists: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cemNavigatorAlreadyExists'; rValue : 'Добавляемый в список навигатор уже существует в списке родителя');
  {* 'Добавляемый в список навигатор уже существует в списке родителя' }
 str_cemDeleteNavigatorNotExists: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cemDeleteNavigatorNotExists'; rValue : 'Удаляемый навигатор в списке родителя отсутствует');
  {* 'Удаляемый навигатор в списке родителя отсутствует' }
 cspSize = 7;
  {* ширина сплиттера }
 cspButtonSize = 100;
  {* ширина/высота кнопки по умолчанию }
 cIntervalLine = 2;
  {* интервал между линиями }
 cBorderWidth = 2;
  {* ширина линии }
 cLinesHeight = 2 * cBorderWidth + cIntervalLine;
  {* область в которой будут нарисованы линии }
 cOffsetSecondLine = cBorderWidth + cIntervalLine;
  {* смещение для второй линии }
 cButtonSize = 21;
  {* размер кнопки заголовка }
 cIntervalButtonLine = 1;
  {* расстояние между кнопккой и линией }
 cIntervalHeaderButton = 2;
  {* расстояние между заголовком и кнопкой }
 cHeaderSize = 21 + 2 * cIntervalButtonLine;
 cBmpHideLeft = 'HIDELEFT';
 cBmpHideRight = 'HIDERIGHT';
 cBmpHideTop = 'HIDETOP';
 cBmpHideBottom = 'HIDEBOTTOM';
 cBmpAutoHideOff = 'AUTOHIDEOFF';
 cBmpAutoHideOn = 'AUTOHIDEON';
 cBmpClose = 'CLOSE';
 cInitSize = 5;
  {* пустой навигатор }
 cDefaultNormalSize = 200;
  {* нормальный размер навигатора }
 cMinNormalSize = 70;
  {* минимальный нормальный размер навигатора, если меньше, то он сворачивается }
 cMinClientControlSize = 100;
  {* минимальная ширина компонента с Align = alClient, который соседствует с навигатором }
 cFloatMinimized = $0001;
  {* флаги определяющие состояние плавающего окна. Когда vcm форма стыкуется к плавающему навигатору, то у нее читается флаг состояния. Он используется для  установки навигатора в то состояние, в котором он находился когда в нём была форма.
минимизирован }

function TnpCustomPanel.Get_ControlIsPanel: Boolean;
//#UC START# *476A5BBD03D9_52B9922001E1get_var*
//#UC END# *476A5BBD03D9_52B9922001E1get_var*
begin
//#UC START# *476A5BBD03D9_52B9922001E1get_impl*
 Result := False;
//#UC END# *476A5BBD03D9_52B9922001E1get_impl*
end;//TnpCustomPanel.Get_ControlIsPanel

function TnpPageControl.IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
//#UC START# *52B9A8F00082_52B99259019E_var*
var
 l_Controller: TOvcController;
//#UC END# *52B9A8F00082_52B99259019E_var*
begin
//#UC START# *52B9A8F00082_52B99259019E_impl*
 Result := False;
 l_Controller := GetDefController;
 if Assigned(l_Controller) then
  with l_Controller.EntryCommands do
   if TranslateUsing([], TMessage(Msg), GetTickCount) = ccShortCut then
   begin
    Msg.Result := 0;  {indicate that this message was processed}
    Result := True;
   end;//TranslateUsing([], TMessage(Msg), GetTickCount) = ccShortCut
//#UC END# *52B9A8F00082_52B99259019E_impl*
end;//TnpPageControl.IsHandledShortcut

procedure TnpPageControl.CMDockNotification(var Message: TCMDockNotification);
 {* при изменении видимости первого пристыковыванного компонента показываем навигатор }
//#UC START# *52B9AAC50136_52B99259019E_var*
//#UC END# *52B9AAC50136_52B99259019E_var*
begin
//#UC START# *52B9AAC50136_52B99259019E_impl*
 inherited;
 case Message.NotifyRec.ClientMsg of
  CM_VISIBLECHANGED:
   if Boolean(Message.NotifyRec.MsgWParam) then
    if f_Navigator.Float then
    { Если при создании плавающего навигатора в OnPageControlUnDock подают
      Client.Visible, то FMgrState(True) не вызывается, навигатор не отображается.
      Когда клиента показывают, то показываем и навигатор. }
     f_Navigator.f_FloatNavigator.Visible := True;
    else
     f_Navigator.InitDockDrop;
 end;//case Message.NotifyRec.ClientMsg
//#UC END# *52B9AAC50136_52B99259019E_impl*
end;//TnpPageControl.CMDockNotification

procedure TnpPageControl.PMIsActiveControl(var Message: TMessage);
 {* определяет активен ли компонент. Если навигатор находится в свернутом состоянии, то компонент в любом случае не активен }
//#UC START# *52B9AB590246_52B99259019E_var*
//#UC END# *52B9AB590246_52B99259019E_var*
begin
//#UC START# *52B9AB590246_52B99259019E_impl*
 inherited;
 Message.ResultLo := 1;
 // если закладка свернута, то она не активна
 Message.ResultHi := Integer((ActivePage = TElTabSheet(Message.WParam)) and (f_Navigator.State = nsNormal));
//#UC END# *52B9AB590246_52B99259019E_impl*
end;//TnpPageControl.PMIsActiveControl

procedure TnpPageControl.PMSetActivePageWithControl(var Message: TMessage);
 {* при активации закладки, если навигатор был свернут, то он разворачивается }
//#UC START# *52B9ABE70151_52B99259019E_var*
//#UC END# *52B9ABE70151_52B99259019E_var*
begin
//#UC START# *52B9ABE70151_52B99259019E_impl*
 inherited;
 if f_Navigator.State <> nsNormal then
  f_Navigator.State := nsNormal;
//#UC END# *52B9ABE70151_52B99259019E_impl*
end;//TnpPageControl.PMSetActivePageWithControl

procedure TnpPageControl.WMKeyDown(var Msg: TWMKeyDown);
//#UC START# *52B9AC2801E0_52B99259019E_var*
//#UC END# *52B9AC2801E0_52B99259019E_var*
begin
//#UC START# *52B9AC2801E0_52B99259019E_impl*
 if not IsHandledShortcut(Msg) then
  inherited;
//#UC END# *52B9AC2801E0_52B99259019E_impl*
end;//TnpPageControl.WMKeyDown

procedure TnpPageControl.WMSysKeyDown(var Msg: TWMSysKeyDown);
//#UC START# *52B9AC3F01E2_52B99259019E_var*
//#UC END# *52B9AC3F01E2_52B99259019E_var*
begin
//#UC START# *52B9AC3F01E2_52B99259019E_impl*
 if not IsHandledShortcut(Msg) then
  inherited;
//#UC END# *52B9AC3F01E2_52B99259019E_impl*
end;//TnpPageControl.WMSysKeyDown

procedure TnpPageControl.WMEraseBkgnd(var Message: TMessage);
//#UC START# *52B9ACA10057_52B99259019E_var*
//#UC END# *52B9ACA10057_52B99259019E_var*
begin
//#UC START# *52B9ACA10057_52B99259019E_impl*
 Message.Result := 1;
//#UC END# *52B9ACA10057_52B99259019E_impl*
end;//TnpPageControl.WMEraseBkgnd

constructor TnpPageControl.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_52B99259019E_var*
//#UC END# *47D1602000C6_52B99259019E_var*
begin
//#UC START# *47D1602000C6_52B99259019E_impl*
 inherited;
 ControlStyle := ControlStyle + [csNoDesignVisible];
 TabStop := True;
 DrawFocusRect := True;
 ShowBorder := False;
 Font.Charset := RUSSIAN_CHARSET;
//#UC END# *47D1602000C6_52B99259019E_impl*
end;//TnpPageControl.Create

procedure TnpPageControl.Notification(AComponent: TComponent;
 Operation: TOperation);
//#UC START# *4F884378016A_52B99259019E_var*
//#UC END# *4F884378016A_52B99259019E_var*
begin
//#UC START# *4F884378016A_52B99259019E_impl*
 inherited;
 if (Operation = opRemove) and (AComponent is TControl) then
  TnpControlsList.Instance.DeleteControl(TControl(AComponent));
//#UC END# *4F884378016A_52B99259019E_impl*
end;//TnpPageControl.Notification

{$If NOT Defined(NoVCL)}
procedure TnpPageControl.DockDrop(Source: TDragDockObject;
 X: Integer;
 Y: Integer);
//#UC START# *4F8851380274_52B99259019E_var*
//#UC END# *4F8851380274_52B99259019E_var*
begin
//#UC START# *4F8851380274_52B99259019E_impl*
 if not f_Navigator.Float then
  TnpControlsList.Instance.AddControl(f_Navigator, Source.Control);
 inherited;
//#UC END# *4F8851380274_52B99259019E_impl*
end;//TnpPageControl.DockDrop
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TnpPageControl.GetSiteInfo(Client: TControl;
 var InfluenceRect: TRect;
 MousePos: TPoint;
 var CanDock: Boolean);
//#UC START# *52B9A6A80336_52B99259019E_var*
//#UC END# *52B9A6A80336_52B99259019E_var*
begin
//#UC START# *52B9A6A80336_52B99259019E_impl*
 inherited GetSiteInfo(Client, InfluenceRect, MousePos, CanDock);
 if CanDock then
  if Assigned(f_Navigator.OnGetSiteInfo) then
   f_Navigator.OnGetSiteInfo(Self, Client, InfluenceRect, MousePos, CanDock);
//#UC END# *52B9A6A80336_52B99259019E_impl*
end;//TnpPageControl.GetSiteInfo
{$IfEnd} // NOT Defined(NoVCL)

procedure TnpPageControl.RequestTabPosition;
//#UC START# *52B9A7B2027D_52B99259019E_var*
//#UC END# *52B9A7B2027D_52B99259019E_var*
begin
//#UC START# *52B9A7B2027D_52B99259019E_impl*
 inherited;
 if Assigned(f_Navigator) then
  if Assigned(f_Navigator.Parent) then
    (* Проверяем parent, потому что иначе при отстыковке закладки при попытке
       получить Handle получим исключение что parent не определен. *)
   DoNotifyControls(f_Navigator, CM_npTabPositionChanged, 0, 0);
//#UC END# *52B9A7B2027D_52B99259019E_impl*
end;//TnpPageControl.RequestTabPosition

procedure TnpPageControl.DoActivePrevPage;
//#UC START# *52B9A85201C2_52B99259019E_var*
//#UC END# *52B9A85201C2_52B99259019E_var*
begin
//#UC START# *52B9A85201C2_52B99259019E_impl*
 if (f_Navigator.State = nsNormal) and (PageCount = 1) then
  f_Navigator.State := nsMinimized
 else 
  inherited;
//#UC END# *52B9A85201C2_52B99259019E_impl*
end;//TnpPageControl.DoActivePrevPage

procedure TnpContainerSurface.pm_SetSurface(aValue: TnpSurface);
//#UC START# *52B9AF720263_52B9AED10282set_var*
//#UC END# *52B9AF720263_52B9AED10282set_var*
begin
//#UC START# *52B9AF720263_52B9AED10282set_impl*
 f_Surface := aValue;
//#UC END# *52B9AF720263_52B9AED10282set_impl*
end;//TnpContainerSurface.pm_SetSurface

class function TnpContainerSurface.Make(aSurface: TnpSurface): TnpContainerSurface;
//#UC START# *52B9AFE90213_52B9AED10282_var*
//#UC END# *52B9AFE90213_52B9AED10282_var*
begin
//#UC START# *52B9AFE90213_52B9AED10282_impl*
 Result := Create(aSurface);
 with Result do
 begin
  Parent := aSurface;
  Align := alClient;
  Surface := aSurface;
 end;//with Result
//#UC END# *52B9AFE90213_52B9AED10282_impl*
end;//TnpContainerSurface.Make

procedure TnpContainerSurface.WMEraseBkgnd(var Message: TWMEraseBkgnd);
 {* иначе границы toolbar-ов не прорисовываются }
//#UC START# *52B9B0560033_52B9AED10282_var*
//#UC END# *52B9B0560033_52B9AED10282_var*
begin
//#UC START# *52B9B0560033_52B9AED10282_impl*
 Message.Result := 1;
//#UC END# *52B9B0560033_52B9AED10282_impl*
end;//TnpContainerSurface.WMEraseBkgnd

procedure TnpSurface.pm_SetPageControl(aValue: TnpPageControl);
//#UC START# *52BABD9C03B7_52B9AF0A027Cset_var*
//#UC END# *52BABD9C03B7_52B9AF0A027Cset_var*
begin
//#UC START# *52BABD9C03B7_52B9AF0A027Cset_impl*
 if (f_PageControl <> aValue) then
 begin
  f_PageControl := aValue;
  if (f_PageControl <> nil) then
  begin
   f_PageControl.Parent := f_Container;
   f_PageControl.Align := alClient;
  end;//f_PageControl <> nil
 end;//f_PageControl <> Value
//#UC END# *52BABD9C03B7_52B9AF0A027Cset_impl*
end;//TnpSurface.pm_SetPageControl

procedure TnpSurface.pm_SetHeader(aValue: TnpHeaderPrim);
//#UC START# *52BABDB6021C_52B9AF0A027Cset_var*
//#UC END# *52BABDB6021C_52B9AF0A027Cset_var*
begin
//#UC START# *52BABDB6021C_52B9AF0A027Cset_impl*
 if (f_Header <> aValue) then
 begin
  f_Header := aValue;
  if (f_Header <> nil) then
  begin
   f_Header.Parent := f_Container.Parent;
   f_Header.Align := alTop;
  end;//f_Header <> nil
 end;//f_Header <> Value
//#UC END# *52BABDB6021C_52B9AF0A027Cset_impl*
end;//TnpSurface.pm_SetHeader

function TnpSurface.pm_GetSize: Integer;
//#UC START# *52BAC0430151_52B9AF0A027Cget_var*
//#UC END# *52BAC0430151_52B9AF0A027Cget_var*
begin
//#UC START# *52BAC0430151_52B9AF0A027Cget_impl*
 case f_Navigator.Align of
  alBottom, alTop: Result := Height;
  alLeft, alRight: Result := Width;
 else
  Result := Width;
 end;//case f_Navigator.Align
//#UC END# *52BAC0430151_52B9AF0A027Cget_impl*
end;//TnpSurface.pm_GetSize

procedure TnpSurface.pm_SetNavigator(aValue: TvtNavigatorPrim);
//#UC START# *52BC48CC01E9_52B9AF0A027Cset_var*
//#UC END# *52BC48CC01E9_52B9AF0A027Cset_var*
begin
//#UC START# *52BC48CC01E9_52B9AF0A027Cset_impl*
 if f_Navigator <> nil then
  f_Navigator.UnRegisterStateChanged(f_Link);

 f_Navigator := aValue;

 if f_Navigator <> nil then
  f_Navigator.RegisterStateChanged(f_Link);
//#UC END# *52BC48CC01E9_52B9AF0A027Cset_impl*
end;//TnpSurface.pm_SetNavigator

procedure TnpSurface.InitAutoHidePosition;
 {* обновить Left окна }
//#UC START# *52BAC11201BE_52B9AF0A027C_var*
//#UC END# *52BAC11201BE_52B9AF0A027C_var*
begin
//#UC START# *52BAC11201BE_52B9AF0A027C_impl*
 if (f_Navigator.State = nsAutoHide) then
 case f_Navigator.Align of
  alRight: Left := f_Navigator.Parent.ClientWidth - Self.Width;
  alBottom: Top := f_Navigator.Parent.ClientHeight - Self.Height;
 end;//case f_Navigator.Align
//#UC END# *52BAC11201BE_52B9AF0A027C_impl*
end;//TnpSurface.InitAutoHidePosition

procedure TnpSurface.OnStateChanged(Sender: TObject);
//#UC START# *52BAC1220315_52B9AF0A027C_var*
//#UC END# *52BAC1220315_52B9AF0A027C_var*
begin
//#UC START# *52BAC1220315_52B9AF0A027C_impl*
 f_Splitter.Visible := (*(f_Navigator.State <> nsMinimized) and*)
                      not f_Navigator.Float and
                      (f_Navigator.PageControl.PageCount > 0);
//#UC END# *52BAC1220315_52B9AF0A027C_impl*
end;//TnpSurface.OnStateChanged

procedure TnpSurface.SetSizeMini;
//#UC START# *52BAC1450146_52B9AF0A027C_var*
//#UC END# *52BAC1450146_52B9AF0A027C_var*
begin
//#UC START# *52BAC1450146_52B9AF0A027C_impl*
 case f_Navigator.Align of
  alBottom, alTop: Height := f_Navigator.SizeMini;
  alLeft, alRight: Width := f_Navigator.SizeMini;
 end;//case f_Navigator.Align
//#UC END# *52BAC1450146_52B9AF0A027C_impl*
end;//TnpSurface.SetSizeMini

procedure TnpSurface.DefineSplitterAlign;
//#UC START# *52BAC14E0369_52B9AF0A027C_var*
//#UC END# *52BAC14E0369_52B9AF0A027C_var*
begin
//#UC START# *52BAC14E0369_52B9AF0A027C_impl*
 case f_Navigator.Align of
  alTop: f_Splitter.Align := alBottom;
  alLeft: f_Splitter.Align := alRight;
  alRight: f_Splitter.Align := alLeft;
  alBottom: f_Splitter.Align := alTop;
 end;//case f_Navigator.Align
//#UC END# *52BAC14E0369_52B9AF0A027C_impl*
end;//TnpSurface.DefineSplitterAlign

procedure TnpSurface.WMEraseBkgnd(var Message: TMessage);
//#UC START# *52BAC0A1016B_52B9AF0A027C_var*
//#UC END# *52BAC0A1016B_52B9AF0A027C_var*
begin
//#UC START# *52BAC0A1016B_52B9AF0A027C_impl*
 Message.Result := 1;
//#UC END# *52BAC0A1016B_52B9AF0A027C_impl*
end;//TnpSurface.WMEraseBkgnd

procedure TnpSurface.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52B9AF0A027C_var*
//#UC END# *479731C50290_52B9AF0A027C_var*
begin
//#UC START# *479731C50290_52B9AF0A027C_impl*
 l3Free(f_Link);
 inherited;
//#UC END# *479731C50290_52B9AF0A027C_impl*
end;//TnpSurface.Cleanup

constructor TnpSurface.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_52B9AF0A027C_var*
//#UC END# *47D1602000C6_52B9AF0A027C_var*
begin
//#UC START# *47D1602000C6_52B9AF0A027C_impl*
 inherited;
 f_Container := TnpContainerSurface.Make(Self);
 //f_Panel := TvtPanel.Create(Self);
 //f_Panel.Parent := Self;
 //f_Panel.Align := alClient;
 f_Splitter := TnpSplitter.Create(Self{, f_Panel});
 with f_Splitter do
 begin
  Parent := Self;
  Align := alRight;
  Width := cspSize;
  f_Surface := Self;
 end;
 f_Link := TnpChangeLink.Create;
 f_Link.OnStateChanged := OnStateChanged;
//#UC END# *47D1602000C6_52B9AF0A027C_impl*
end;//TnpSurface.Create

{$If NOT Defined(NoVCL)}
procedure TnpSurface.Paint;
//#UC START# *5028A60300AD_52B9AF0A027C_var*
 procedure npDrawGradient(aRect       : TRect;
                          aBeginColor : TColor = clBtnHighlight;
                          aEndColor   : TColor = clBtnShadow);
 var
  lI         : Integer;
  lStartRGB  : array[0..2] of Byte;
  lEndRGB    : array[0..2] of Byte;
  lStartC    : TColor;
  lEndC      : TColor;
  lColors    : Word;
  lRDist, lGDist, lBDist : Integer;
  lRTmp, lGTmp, lBTmp : Integer;
 begin//npDrawGradient
  // цвета
  lStartC := ColorToRGB(aBeginColor);
  lEndC := ColorToRGB(aEndColor);
  // массив с исходными цветами (lStartC)
  lStartRGB[0] := GetRValue(lStartC);
  lStartRGB[1] := GetGValue(lStartC);
  lStartRGB[2] := GetBValue(lStartC);
  // массив с конечными цветами (lEndC)
  lEndRGB[0] := GetRValue(lEndC);
  lEndRGB[1] := GetGValue(lEndC);
  lEndRGB[2] := GetBValue(lEndC);
  // расстояние между каждым цветом
  lRDist := Abs(lEndRGB[0] - lStartRGB[0]);
  lGDist := Abs(lEndRGB[1] - lStartRGB[1]);
  lBDist := Abs(lEndRGB[2] - lStartRGB[2]);
  // количество цветов которые будут нарисованы
  lColors := aRect.Right - aRect.Left;
  for lI := 0 to Pred(lColors) do
    with Canvas do
    begin
     // красный
     lRTmp := MulDiv(lI, lRDist, Pred(lColors));
     if lStartRGB[0] > lEndRGB[0] then
      lRTmp := - lRTmp;
     // зеленый
     lGTmp := MulDiv(lI, lGDist, Pred(lColors));
     if lStartRGB[1] > lEndRGB[1] then
      lGTmp := - lGTmp;
     // синий
     lBTmp := MulDiv(lI, lBDist, Pred(lColors));
     if lStartRGB[2] > lEndRGB[2] then
      lBTmp := - lBTmp;
     // установим цвет и нарисуем
     Pen.Color :=  RGB(
      (lStartRGB[0] + lRTmp),
      (lStartRGB[1] + lGTmp),
      (lStartRGB[2] + lBTmp));
     MoveTo(aRect.Left + lI, aRect.Top);
     LineTo(aRect.Left + lI, aRect.Bottom);
    end;//with Canvas
 end;//npDrawGradient
var
 l_R : TRect;
//#UC END# *5028A60300AD_52B9AF0A027C_var*
begin
//#UC START# *5028A60300AD_52B9AF0A027C_impl*
 if (csDesigning in ComponentState) then
 begin
  l_R := ClientRect;
  with Canvas do
  begin
   with Pen do
   begin
    Color := clBlack;
    Width := 1;
   end;//with Pen
   Rectangle(l_R);
  end;//with Canvas
  InflateRect(l_R, -1, -1);
  npDrawGradient(l_R, clRed, clMaroon);
 end//csDesigning in ComponentState
 else
 begin
  (* Заливаем только когда на подложке никого нет, иначе у компонентов слетает
     то, что нарисовали в WMNCPaint *)
  if Assigned(f_Navigator) and Assigned(f_Navigator.PageControl) and
   (f_Navigator.PageControl.PageCount = 0) then
  with Canvas do
  begin
   Brush.Color := clWhite{clBtnFace};
   FillRect(ClientRect);
  end;//with Canvas
 end;//csDesigning in ComponentState
//#UC END# *5028A60300AD_52B9AF0A027C_impl*
end;//TnpSurface.Paint
{$IfEnd} // NOT Defined(NoVCL)

procedure TnpSplitter.pm_SetIsHideButtonDown(aValue: Boolean);
//#UC START# *52BAB00903A4_52B9B0AA0105set_var*
//#UC END# *52BAB00903A4_52B9B0AA0105set_var*
begin
//#UC START# *52BAB00903A4_52B9B0AA0105set_impl*
 if (f_IsHideButtonDown <> aValue) then
 begin
  f_IsHideButtonDown := aValue;
  DrawButton;
 end;//f_IsHideButtonDown <> Value
//#UC END# *52BAB00903A4_52B9B0AA0105set_impl*
end;//TnpSplitter.pm_SetIsHideButtonDown

procedure TnpSplitter.splShowHint(X: Integer;
 Y: Integer);
//#UC START# *52BABB100388_52B9B0AA0105_var*
var
 l_HintRect : TRect;
 l_Hint     : String;
 l_Temp     : TRect;
 l_Window   : THintWindow;
 l_Monitor  : TMonitor;
//#UC END# *52BABB100388_52B9B0AA0105_var*
begin
//#UC START# *52BABB100388_52B9B0AA0105_impl*
 // Опустим будущее окно под курсор
 Inc(X, 16);
 // Окно
 l_Window := CreateButtonHint;
 // Hint
 l_Hint := f_Surface.Navigator.MinBtnHint;
 // Размещение окна
 l_Monitor := Screen.MonitorFromPoint(Mouse.CursorPos);
 if not Assigned(l_Monitor) then
  Exit;
 l_Temp.TopLeft := ClientToScreen(Point(X, Y));
 // Посчитаем размер прямоугольника учитывая ограничения текущим монитором
 l_HintRect := l_Window.CalcHintRect(l_Monitor.WorkareaRect.Right - l_Temp.Left,
  l_Hint, nil);
 l_Temp.Right := l_Temp.Left + l_HintRect.Right;
 l_Temp.Bottom := l_Temp.Top + l_HintRect.Bottom;
 // Покажем
 l_Window.ActivateHint(l_Temp, l_Hint);
//#UC END# *52BABB100388_52B9B0AA0105_impl*
end;//TnpSplitter.splShowHint

procedure TnpSplitter.splHideHint;
//#UC START# *52BABB57018D_52B9B0AA0105_var*
//#UC END# *52BABB57018D_52B9B0AA0105_var*
begin
//#UC START# *52BABB57018D_52B9B0AA0105_impl*
 if HideButtonHint <> nil then
  HideButtonHint.ReleaseHandle;
//#UC END# *52BABB57018D_52B9B0AA0105_impl*
end;//TnpSplitter.splHideHint

function TnpSplitter.CreateButtonHint: THintWindow;
//#UC START# *52BABB61000E_52B9B0AA0105_var*
//#UC END# *52BABB61000E_52B9B0AA0105_var*
begin
//#UC START# *52BABB61000E_52B9B0AA0105_impl*
 if HideButtonHint = nil then
 begin
  HideButtonHint := THintWindow.Create(Self);
  with HideButtonHint do
  begin
   Color:= GetSysColor(COLOR_INFOBK);
   Canvas.Brush.Color:= GetSysColor(COLOR_INFOBK);
   Canvas.Font:= Self.Font;
   Canvas.Font.Color:= GetSysColor(COLOR_INFOTEXT);
   Canvas.Pen.Color:= clBlack;
  end;//with HideButtonHint
 end;//HideButtonHint = nil
 Result := HideButtonHint;
//#UC END# *52BABB61000E_52B9B0AA0105_impl*
end;//TnpSplitter.CreateButtonHint

procedure TnpSplitter.UpdateCursor(aButton: Boolean = True);
//#UC START# *52BABB7902B0_52B9B0AA0105_var*
//#UC END# *52BABB7902B0_52B9B0AA0105_var*
begin
//#UC START# *52BABB7902B0_52B9B0AA0105_impl*
 if aButton then
  Cursor := crHandPoint
 else
  SetSizeCursor;
 // это нужно, чтобы при смене курсора компонента поменялся курсор на экране
 Windows.SetCursor(Screen.Cursors[Cursor]);
//#UC END# *52BABB7902B0_52B9B0AA0105_impl*
end;//TnpSplitter.UpdateCursor

procedure TnpSplitter.DrawButton(aCanvas: TCanvas = nil);
//#UC START# *52BABB8900D4_52B9B0AA0105_var*
const
 cButtonState : array [Boolean] of Integer = (0, DFCS_PUSHED);
var
 l_Rect    : TRect;
 l_Center  : Integer;

 procedure DrawArrow(aY     : Integer;
                     aColor : TColor);
 var
  l_Delta   : Integer;
  l_Left    : Boolean;
    {* - стрелка указывает влево. }
  l_Index   : Integer;
 begin//DrawArrow
  // куда указывает стрелка
  l_Left := (Align = alRight);
  if f_Surface.Navigator.IsMinimized then
   l_Left := not l_Left;
  // инициализируем дельту
  if l_Left then
   l_Delta := 0
  else
   l_Delta := Pred(l_Rect.Right) - l_Rect.Left;
  // первая точка
  for l_Index := l_Rect.Left to Pred(l_Rect.Right) do
  begin
   with aCanvas do
   begin
    Pixels[l_Index, aY - l_Delta] := aColor;
    Pixels[l_Index, aY + l_Delta] := aColor;
   end;//with aCanvas
   if l_Left then
    Inc(l_Delta)
   else
    Dec(l_Delta);
  end;//for l_Index
 end;//DrawArrow
//#UC END# *52BABB8900D4_52B9B0AA0105_var*
begin
//#UC START# *52BABB8900D4_52B9B0AA0105_impl*
 if not Assigned(aCanvas) then
  aCanvas := Canvas;
 // область расположения
 l_Rect := GetButtonRect;
 // кнопка
 DrawFrameControl(aCanvas.Handle,
                  l_Rect,
                  DFC_BUTTON, DFCS_BUTTONPUSH or cButtonState[IsHideButtonDown]);
 // нужно доделать если появится такое выравнивание
 //Assert((Align <> alTop) and (Align <> alBottom));
 // точка стрелочки
 l_Center := (l_Rect.Top + l_Rect.Bottom) div 2;
 // рисуем
 InflateRect(l_Rect, -1, -1);
 DrawArrow(l_Center, clBlue);
//#UC END# *52BABB8900D4_52B9B0AA0105_impl*
end;//TnpSplitter.DrawButton

function TnpSplitter.GetButtonRect: TRect;
 {* определяет прямоугольник для кнопки }
//#UC START# *52BABB9A02AB_52B9B0AA0105_var*
 function lDefineSize(const aSize : Integer) : Integer;
 begin//lDefineSize
  if (cspButtonSize > aSize) then
   Result := aSize div 3
  else
   Result := cspButtonSize;
 end;//lDefineSize

var
 l_Size : Integer;
//#UC END# *52BABB9A02AB_52B9B0AA0105_var*
begin
//#UC START# *52BABB9A02AB_52B9B0AA0105_impl*
 SetRectEmpty(Result);
 // горизонтальный сплиттер
 if (Width > Height) then
 begin
  l_Size := lDefineSize(ClientWidth);
  Result.Left := (ClientWidth - l_Size) div 2;
  Result.Right := Result.Left + l_Size;
  Result.Top := 0;
  Result.Bottom := ClientHeight;
 end//Width > Height
 // вертикальный сплиттер
 else
 begin
  l_Size := lDefineSize(ClientHeight);
  Result.Top := (ClientHeight - l_Size) div 2;
  Result.Bottom := Result.Top + l_Size;
  Result.Left := 0;
  Result.Right := ClientWidth;
 end;//Width > Height
 Inc(Result.Left);
//#UC END# *52BABB9A02AB_52B9B0AA0105_impl*
end;//TnpSplitter.GetButtonRect

procedure TnpSplitter.SetSizeCursor;
 {* устанавливает курсор для изменения размеров }
//#UC START# *52BABBD102EC_52B9B0AA0105_var*
//#UC END# *52BABBD102EC_52B9B0AA0105_var*
begin
//#UC START# *52BABBD102EC_52B9B0AA0105_impl*
 case f_Surface.Navigator.Align of
  alLeft, alRight: Cursor := crHSplit;
  alTop, alBottom: Cursor := crVSplit;
 end;//case f_Surface.Navigator.Align of
//#UC END# *52BABBD102EC_52B9B0AA0105_impl*
end;//TnpSplitter.SetSizeCursor

function TnpSplitter.IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
//#UC START# *52BABBE6027E_52B9B0AA0105_var*
var
 l_Controller : TOvcController;
//#UC END# *52BABBE6027E_52B9B0AA0105_var*
begin
//#UC START# *52BABBE6027E_52B9B0AA0105_impl*
 Result := False;
 l_Controller := GetDefController;
 if Assigned(l_Controller) then
  with l_Controller.EntryCommands do
   if TranslateUsing([], TMessage(Msg), GetTickCount) = ccShortCut then
   begin
    Msg.Result := 0;  {indicate that this message was processed}
    Result := True;
   end;//TranslateUsing([], TMessage(Msg), GetTickCount) = ccShortCut
//#UC END# *52BABBE6027E_52B9B0AA0105_impl*
end;//TnpSplitter.IsHandledShortcut

procedure TnpSplitter.WMKeyDown(var Msg: TWMKeyDown);
//#UC START# *52BAB80A032F_52B9B0AA0105_var*
//#UC END# *52BAB80A032F_52B9B0AA0105_var*
begin
//#UC START# *52BAB80A032F_52B9B0AA0105_impl*
 if not IsHandledShortcut(Msg) then
  inherited;
//#UC END# *52BAB80A032F_52B9B0AA0105_impl*
end;//TnpSplitter.WMKeyDown

procedure TnpSplitter.WMSysKeyDown(var Msg: TWMSysKeyDown);
//#UC START# *52BAB8250200_52B9B0AA0105_var*
//#UC END# *52BAB8250200_52B9B0AA0105_var*
begin
//#UC START# *52BAB8250200_52B9B0AA0105_impl*
 if not IsHandledShortcut(Msg) then
  inherited;
//#UC END# *52BAB8250200_52B9B0AA0105_impl*
end;//TnpSplitter.WMSysKeyDown

procedure TnpSplitter.CNKeyDown(var Msg: TWMKeyDown);
//#UC START# *52BAB838013D_52B9B0AA0105_var*
//#UC END# *52BAB838013D_52B9B0AA0105_var*
begin
//#UC START# *52BAB838013D_52B9B0AA0105_impl*
 if not IsHandledShortcut(Msg) then
  inherited;
//#UC END# *52BAB838013D_52B9B0AA0105_impl*
end;//TnpSplitter.CNKeyDown

procedure TnpSplitter.CNSysKeyDown(var Msg: TWMSysKeyDown);
//#UC START# *52BAB8530216_52B9B0AA0105_var*
//#UC END# *52BAB8530216_52B9B0AA0105_var*
begin
//#UC START# *52BAB8530216_52B9B0AA0105_impl*
 if not IsHandledShortcut(Msg) then
  inherited;
//#UC END# *52BAB8530216_52B9B0AA0105_impl*
end;//TnpSplitter.CNSysKeyDown

procedure TnpSplitter.WMMouseLeave(var Msg: TMessage);
//#UC START# *5374D62902DC_52B9B0AA0105_var*
//#UC END# *5374D62902DC_52B9B0AA0105_var*
begin
//#UC START# *5374D62902DC_52B9B0AA0105_impl*
 splHideHint;
 inherited;
//#UC END# *5374D62902DC_52B9B0AA0105_impl*
end;//TnpSplitter.WMMouseLeave

procedure TnpSplitter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52B9B0AA0105_var*
//#UC END# *479731C50290_52B9B0AA0105_var*
begin
//#UC START# *479731C50290_52B9B0AA0105_impl*
 splHideHint;
 FreeAndNil(f_HideButtonHint);
 inherited;
//#UC END# *479731C50290_52B9B0AA0105_impl*
end;//TnpSplitter.Cleanup

constructor TnpSplitter.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_52B9B0AA0105_var*
//#UC END# *47D1602000C6_52B9B0AA0105_var*
begin
//#UC START# *47D1602000C6_52B9B0AA0105_impl*
 inherited;
 // Видимость изменится при добавлении первой закладки
 ControlStyle := ControlStyle + [csNoDesignVisible];
 Visible := False;
 Cursor := crHSplit;
 f_IsHideButtonDown := False;
 IsMouseDown := False;
//#UC END# *47D1602000C6_52B9B0AA0105_impl*
end;//TnpSplitter.Create

{$If NOT Defined(NoVCL)}
procedure TnpSplitter.MouseMove(Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *48E22B250241_52B9B0AA0105_var*
var
 l_Types  : TnpDrawSplitterTypes;
 l_Button : Boolean;
 l_TME: TTrackMouseEvent;
//#UC END# *48E22B250241_52B9B0AA0105_var*
begin
//#UC START# *48E22B250241_52B9B0AA0105_impl*
 l_TME.cbSize := SizeOf(TTrackMouseEvent);
 l_TME.dwFlags := TME_LEAVE;
 l_TME.hwndTrack := Handle;
 TrackMouseEvent(l_TME);

 // Курсор вышел за пределы сплиттера, освободим захват курсора:
 if not PtInRect(ClientRect, Point(X, Y)) then
 begin
  // Если перетаскивают, то ничего делать не нужно:
  if not IsMouseDown and (GetCapture = Handle) then
    ReleaseCapture;
  // Мы перетаскиваем поэтому подсказку надо спрятать:
  splHideHint;
 end;//if not PtInRect(ClientRect, Point(X, Y)) then
 if not (ssLeft in Shift) then
 begin
  if not GetParentForm(Self).Active then
   Exit;
  l_Button := PtInRect(GetButtonRect, Point(X, Y));
  // Установим курсор:
  UpdateCursor(l_Button);
  // Покажем подсказку:
  if l_Button then
   splShowHint(X, Y)
  else
   splHideHint;
 end//not (ssLeft in Shift) 
 else
 // Сплиттер перетаскивают:
 if IsMouseDown then
 begin
  l_Types := [dstErase, dstPaint];
  if IsHideButtonDown then
  begin
   // Отожмем кнопку:
   IsHideButtonDown := False;
   // изменим курсор
   UpdateCursor(False);
   // Первая отрисовка, очищать не надо:
   l_Types := [dstPaint];
  end;//IsHideButtonDown
  // Нарисуем сплиттер:
  with Mouse.CursorPos do
   f_Surface.Navigator.PaintSpliter(X, Y, l_Types);
 end;//if IsMouseDown then
//#UC END# *48E22B250241_52B9B0AA0105_impl*
end;//TnpSplitter.MouseMove
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TnpSplitter.MouseUp(Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *4E7896270076_52B9B0AA0105_var*
//#UC END# *4E7896270076_52B9B0AA0105_var*
begin
//#UC START# *4E7896270076_52B9B0AA0105_impl*
 splHideHint;
 IsMouseDown := False;
 if not (Button = mbLeft) then
  Exit;
 with f_Surface.Navigator do
 begin
  // Изменение размеров навигатора:
  if not IsHideButtonDown then
  begin
   // Удалим нарисованный сплиттер:
   PaintSpliter(Mouse.CursorPos.X, Mouse.CursorPos.Y, [dstErase]);
   Perform(CM_npDoActionWithFormControls, Ord(acRedraw), 0);
   // Изменим размеры навигатора:
   if not PointsEqual(f_MouseDownPoint, Mouse.CursorPos) then
   begin
    DoSplit;
    AutoHideUpdate;
   end;//if not PointsEqual(f_MouseDownPoint, Mouse.CursorPos) then
  end//if not IsHideButtonDown then
  // развернём/свернём навигатор
  else
  begin
   IsHideButtonDown := False;
   State := TNavigatorState(IfThen(State = nsMinimized, Ord(nsNormal), Ord(nsMinimized)));
  end;//if not PointsEqual(f_MouseDownPoint, Mouse.CursorPos) then
 end;//with f_Surface.Navigator do
//#UC END# *4E7896270076_52B9B0AA0105_impl*
end;//TnpSplitter.MouseUp
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TnpSplitter.MouseDown(Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *4F88473B03CD_52B9B0AA0105_var*
//#UC END# *4F88473B03CD_52B9B0AA0105_var*
begin
//#UC START# *4F88473B03CD_52B9B0AA0105_impl*
 if (Button = mbLeft) then
 begin
  IsMouseDown := True;
  // запомним, чтобы определить в MouseUp, что пользователь двигал мыш
  f_MouseDownPoint := Mouse.CursorPos;
  // кнопка нажата
  if PtInRect(GetButtonRect, Point(X, Y)) then
   IsHideButtonDown := True
  else
  begin
   // нарисуем сплиттер
   with Mouse.CursorPos do
    f_Surface.Navigator.PaintSpliter(X, Y, [dstPaint]);
  end;//PtInRect(GetButtonRect, Point(X, Y))
 end;//Button = mbLeft
//#UC END# *4F88473B03CD_52B9B0AA0105_impl*
end;//TnpSplitter.MouseDown
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TnpSplitter.Paint;
//#UC START# *5028A60300AD_52B9B0AA0105_var*
var
 l_R : TRect;
//#UC END# *5028A60300AD_52B9B0AA0105_var*
begin
//#UC START# *5028A60300AD_52B9B0AA0105_impl*
 l_R := ClientRect;
 with Canvas do
 begin
  // заливаем
  Brush.Color := cGarant2011BackColor{clBtnFace};
  FillRect(l_R);
  // рисуем справа, слева линии clShadow
  Pen.Color := clBtnShadow;
  if (f_Surface.Navigator.Align <> alLeft) then
  begin
   MoveTo(l_R.Left, l_R.Top);
   LineTo(l_R.Left, l_R.Bottom);
  end;//Surface.Navigator.Align <> alLeft
  if (f_Surface.Navigator.Align <> alRight) then
  begin
   MoveTo(Pred(l_R.Right), l_R.Top);
   LineTo(Pred(l_R.Right), l_R.Bottom);
  end;//Surface.Navigator.Align <> alRight
 end;//with Canvas
 // рисуем кнопку сплиттера
 DrawButton;
//#UC END# *5028A60300AD_52B9B0AA0105_impl*
end;//TnpSplitter.Paint
{$IfEnd} // NOT Defined(NoVCL)

function TnpHeaderPrim.pm_GetAlign: TAlign;
//#UC START# *52BAC726019F_52BABCB3015Cget_var*
//#UC END# *52BAC726019F_52BABCB3015Cget_var*
begin
//#UC START# *52BAC726019F_52BABCB3015Cget_impl*
 Result := inherited Align;
//#UC END# *52BAC726019F_52BABCB3015Cget_impl*
end;//TnpHeaderPrim.pm_GetAlign

procedure TnpHeaderPrim.pm_SetAlign(aValue: TAlign);
//#UC START# *52BAC726019F_52BABCB3015Cset_var*
//#UC END# *52BAC726019F_52BABCB3015Cset_var*
begin
//#UC START# *52BAC726019F_52BABCB3015Cset_impl*
 inherited Align := aValue;
 UpdatePositions;
//#UC END# *52BAC726019F_52BABCB3015Cset_impl*
end;//TnpHeaderPrim.pm_SetAlign

procedure TnpHeaderPrim.pm_SetCloseImage(aValue: TImageIndex);
//#UC START# *52BAC77E0213_52BABCB3015Cset_var*
//#UC END# *52BAC77E0213_52BABCB3015Cset_var*
begin
//#UC START# *52BAC77E0213_52BABCB3015Cset_impl*
 if (f_CloseImage <> aValue) then
 begin
  f_CloseImage := aValue;
  UpdateCloseImage;
  UpdateHideImage;
 end;//f_CloseImage <> Value
//#UC END# *52BAC77E0213_52BABCB3015Cset_impl*
end;//TnpHeaderPrim.pm_SetCloseImage

procedure TnpHeaderPrim.pm_SetAutoHideOnImage(aValue: TImageIndex);
//#UC START# *52BAC83B035F_52BABCB3015Cset_var*
//#UC END# *52BAC83B035F_52BABCB3015Cset_var*
begin
//#UC START# *52BAC83B035F_52BABCB3015Cset_impl*
 if (f_AutoHideOnImage <> aValue) then
 begin
  f_AutoHideOnImage := aValue;
  UpdateAutoHideImage;
 end;//f_AutoHideOnImage <> Value
//#UC END# *52BAC83B035F_52BABCB3015Cset_impl*
end;//TnpHeaderPrim.pm_SetAutoHideOnImage

procedure TnpHeaderPrim.pm_SetAutoHideOffImage(aValue: TImageIndex);
//#UC START# *52BAC84C0124_52BABCB3015Cset_var*
//#UC END# *52BAC84C0124_52BABCB3015Cset_var*
begin
//#UC START# *52BAC84C0124_52BABCB3015Cset_impl*
 if (f_AutoHideOffImage <> aValue) then
 begin
  f_AutoHideOffImage := aValue;
  UpdateAutoHideImage;
 end;//f_AutoHideOffImage <> Value
//#UC END# *52BAC84C0124_52BABCB3015Cset_impl*
end;//TnpHeaderPrim.pm_SetAutoHideOffImage

procedure TnpHeaderPrim.pm_SetHideLeftImage(aValue: TImageIndex);
//#UC START# *52BAC8920025_52BABCB3015Cset_var*
//#UC END# *52BAC8920025_52BABCB3015Cset_var*
begin
//#UC START# *52BAC8920025_52BABCB3015Cset_impl*
 if (f_HideLeftImage <> aValue) then
 begin
  f_HideLeftImage := aValue;
  DoStateChanged;
 end;//f_HideLeftImage <> Value
//#UC END# *52BAC8920025_52BABCB3015Cset_impl*
end;//TnpHeaderPrim.pm_SetHideLeftImage

procedure TnpHeaderPrim.pm_SetHideRightImage(aValue: TImageIndex);
//#UC START# *52BAC89D020A_52BABCB3015Cset_var*
//#UC END# *52BAC89D020A_52BABCB3015Cset_var*
begin
//#UC START# *52BAC89D020A_52BABCB3015Cset_impl*
 if (f_HideRightImage <> aValue) then
 begin
  f_HideRightImage := aValue;
  DoStateChanged;
 end;//f_HideRightImage <> Value
//#UC END# *52BAC89D020A_52BABCB3015Cset_impl*
end;//TnpHeaderPrim.pm_SetHideRightImage

procedure TnpHeaderPrim.pm_SetHideUpImage(aValue: TImageIndex);
//#UC START# *52BAC8A7004C_52BABCB3015Cset_var*
//#UC END# *52BAC8A7004C_52BABCB3015Cset_var*
begin
//#UC START# *52BAC8A7004C_52BABCB3015Cset_impl*
 if (f_HideUpImage <> aValue) then
 begin
  f_HideUpImage := aValue;
  UpdateHideImage;
 end;//f_HideUpImage <> Value
//#UC END# *52BAC8A7004C_52BABCB3015Cset_impl*
end;//TnpHeaderPrim.pm_SetHideUpImage

procedure TnpHeaderPrim.pm_SetHideDownImage(aValue: TImageIndex);
//#UC START# *52BAC8AF036E_52BABCB3015Cset_var*
//#UC END# *52BAC8AF036E_52BABCB3015Cset_var*
begin
//#UC START# *52BAC8AF036E_52BABCB3015Cset_impl*
 if (f_HideDownImage <> aValue) then
 begin
  f_HideDownImage := aValue;
  UpdateHideImage;
 end;//f_HideDownImage <> Value
//#UC END# *52BAC8AF036E_52BABCB3015Cset_impl*
end;//TnpHeaderPrim.pm_SetHideDownImage

function TnpHeaderPrim.pm_GetSize: Integer;
//#UC START# *52BAC8FB0112_52BABCB3015Cget_var*
//#UC END# *52BAC8FB0112_52BABCB3015Cget_var*
begin
//#UC START# *52BAC8FB0112_52BABCB3015Cget_impl*
 Result := f_Size;
//#UC END# *52BAC8FB0112_52BABCB3015Cget_impl*
end;//TnpHeaderPrim.pm_GetSize

procedure TnpHeaderPrim.pm_SetSize(aValue: Integer);
//#UC START# *52BAC8FB0112_52BABCB3015Cset_var*
//#UC END# *52BAC8FB0112_52BABCB3015Cset_var*
begin
//#UC START# *52BAC8FB0112_52BABCB3015Cset_impl*
 if (f_Size <> aValue) then
 begin
  f_Size := aValue;
  UpdateSize;
 end;//f_Size <> Value
//#UC END# *52BAC8FB0112_52BABCB3015Cset_impl*
end;//TnpHeaderPrim.pm_SetSize

function TnpHeaderPrim.pm_GetOnHide: TNotifyEvent;
//#UC START# *52BAC9740089_52BABCB3015Cget_var*
//#UC END# *52BAC9740089_52BABCB3015Cget_var*
begin
//#UC START# *52BAC9740089_52BABCB3015Cget_impl*
 Result := HideButton.OnClick;
//#UC END# *52BAC9740089_52BABCB3015Cget_impl*
end;//TnpHeaderPrim.pm_GetOnHide

procedure TnpHeaderPrim.pm_SetOnHide(aValue: TNotifyEvent);
//#UC START# *52BAC9740089_52BABCB3015Cset_var*
//#UC END# *52BAC9740089_52BABCB3015Cset_var*
begin
//#UC START# *52BAC9740089_52BABCB3015Cset_impl*
 HideButton.OnClick := aValue;
//#UC END# *52BAC9740089_52BABCB3015Cset_impl*
end;//TnpHeaderPrim.pm_SetOnHide

function TnpHeaderPrim.pm_GetOnAutoHide: TNotifyEvent;
//#UC START# *52BAC993024A_52BABCB3015Cget_var*
//#UC END# *52BAC993024A_52BABCB3015Cget_var*
begin
//#UC START# *52BAC993024A_52BABCB3015Cget_impl*
 Result := AutoHideButton.OnClick;
//#UC END# *52BAC993024A_52BABCB3015Cget_impl*
end;//TnpHeaderPrim.pm_GetOnAutoHide

procedure TnpHeaderPrim.pm_SetOnAutoHide(aValue: TNotifyEvent);
//#UC START# *52BAC993024A_52BABCB3015Cset_var*
//#UC END# *52BAC993024A_52BABCB3015Cset_var*
begin
//#UC START# *52BAC993024A_52BABCB3015Cset_impl*
 AutoHideButton.OnClick := aValue;
//#UC END# *52BAC993024A_52BABCB3015Cset_impl*
end;//TnpHeaderPrim.pm_SetOnAutoHide

procedure TnpHeaderPrim.pm_SetButtonsImageList(aValue: TCustomImageList);
//#UC START# *52BACA3F0292_52BABCB3015Cset_var*
//#UC END# *52BACA3F0292_52BABCB3015Cset_var*
begin
//#UC START# *52BACA3F0292_52BABCB3015Cset_impl*
 if f_ButtonsImageList <> aValue then
 begin
//  {$IfDef NavigatorPanelNeedsTb97}
  AutoHideButton.Images := aValue;
  HideButton.Images := aValue;
  CloseButton.Images := aValue;
//  {$EndIf NavigatorPanelNeedsTb97}
  f_ButtonsImageList := aValue;
 end;
//#UC END# *52BACA3F0292_52BABCB3015Cset_impl*
end;//TnpHeaderPrim.pm_SetButtonsImageList

procedure TnpHeaderPrim.pm_SetNavigator(aValue: TvtNavigatorPrim);
//#UC START# *52BC48D00331_52BABCB3015Cset_var*
//#UC END# *52BC48D00331_52BABCB3015Cset_var*
begin
//#UC START# *52BC48D00331_52BABCB3015Cset_impl*
 if (f_Navigator <> aValue) then
 begin
  if f_Navigator <> nil then
   f_Navigator.UnRegisterStateChanged(f_Link);

  f_Navigator := aValue;

  if f_Navigator <> nil then
   f_Navigator.RegisterStateChanged(f_Link);
 end;//f_Navigator <> Value
//#UC END# *52BC48D00331_52BABCB3015Cset_impl*
end;//TnpHeaderPrim.pm_SetNavigator

procedure TnpHeaderPrim.HideCloseButton;
//#UC START# *52BACD510230_52BABCB3015C_var*
//#UC END# *52BACD510230_52BABCB3015C_var*
begin
//#UC START# *52BACD510230_52BABCB3015C_impl*
 if (CloseButton <> nil) then
  with CloseButton do
  begin
   OnClick := nil;
   CloseButtonVisible(False);
  end;//with CloseButton
//#UC END# *52BACD510230_52BABCB3015C_impl*
end;//TnpHeaderPrim.HideCloseButton

procedure TnpHeaderPrim.ShowCloseButton(const aHandler: IvcmFormHandler);
//#UC START# *52BACD6D0047_52BABCB3015C_var*
//#UC END# *52BACD6D0047_52BABCB3015C_var*
begin
//#UC START# *52BACD6D0047_52BABCB3015C_impl*
 if Assigned(aHandler.Handler) AND
    aHandler.CanHaveCloseButtonInNavigator then
 begin
  if (f_CloseButton <> nil) then
   with CloseButton do
   begin
    OnClick := aHandler.Handler;
    Hint := l3Str(aHandler.Hint);
    CloseButtonVisible(True);
   end//with CloseButton do
 end//Assigned(aHandler.Handler)
 else
  HideCloseButton;
//#UC END# *52BACD6D0047_52BABCB3015C_impl*
end;//TnpHeaderPrim.ShowCloseButton

procedure TnpHeaderPrim.CloseButtonVisible(aValue: Boolean);
 {* изменить видимость кнопки закрыть, установить кнопку видимой без установленного обработчика OnClick нельзя }
//#UC START# *52BACD9A0283_52BABCB3015C_var*
//#UC END# *52BACD9A0283_52BABCB3015C_var*
begin
//#UC START# *52BACD9A0283_52BABCB3015C_impl*
 if Assigned(CloseButton.OnClick) then
  CloseButton.Visible := aValue
 else
 if not aValue then
  CloseButton.Hide;
//#UC END# *52BACD9A0283_52BABCB3015C_impl*
end;//TnpHeaderPrim.CloseButtonVisible

procedure TnpHeaderPrim.UpdateImages;
//#UC START# *52BACDF902D8_52BABCB3015C_var*
//#UC END# *52BACDF902D8_52BABCB3015C_var*
begin
//#UC START# *52BACDF902D8_52BABCB3015C_impl*
 UpdateAutoHideImage;
 UpdateHideImage;
 UpdateCloseImage;
//#UC END# *52BACDF902D8_52BABCB3015C_impl*
end;//TnpHeaderPrim.UpdateImages

procedure TnpHeaderPrim.UpdateSize;
//#UC START# *52BACE0703DA_52BABCB3015C_var*
//#UC END# *52BACE0703DA_52BABCB3015C_var*
begin
//#UC START# *52BACE0703DA_52BABCB3015C_impl*
 case Align of
  alLeft, alRight: Width := f_Size;
  alTop, alBottom: Height := f_Size;
 else
  Height := f_Size;
 end;//case Align
//#UC END# *52BACE0703DA_52BABCB3015C_impl*
end;//TnpHeaderPrim.UpdateSize

procedure TnpHeaderPrim.UpdatePositions;
//#UC START# *52BACE0F03BF_52BABCB3015C_var*
  procedure lp_Left;
  begin//lp_Left
   AutoHideButton.Align := alLeft;
   HideButton.Align := alRight;
   CloseButton.Align := alRight;
   // Поставим кнопку закрыть перед кнопкой скрыть:
   if HideButton.Visible and CloseButton.Visible then
    CloseButton.Left := HideButton.Left - 1;
  end;//lp_Left

  procedure lp_Right;
  begin//lp_Right
   AutoHideButton.Align := alRight;
   HideButton.Align := alLeft;
   CloseButton.Align := alLeft;
   // Поставим кнопку закрыть перед кнопкой скрыть:
   if HideButton.Visible and CloseButton.Visible then
    CloseButton.Left := HideButton.BoundsRect.Right + 1;
  end;//lp_Right

  procedure lp_Top;
  begin//lp_Top
   AutoHideButton.Align := alTop;
   HideButton.Align := alBottom;
   CloseButton.Align := alBottom;
   // Поставим кнопку закрыть перед кнопкой скрыть:
   if HideButton.Visible and CloseButton.Visible then
    CloseButton.Top := HideButton.Top - 1;
  end;//lp_Top

  procedure lp_Bottom;
  begin//lp_Bottom
   AutoHideButton.Align := alBottom;
   HideButton.Align := alTop;
   CloseButton.Align := alTop;
   // Поставим кнопку закрыть перед кнопкой скрыть:
   if HideButton.Visible and CloseButton.Visible then
    CloseButton.Top := HideButton.BoundsRect.Bottom + 1;
  end;//lp_Bottom
//#UC END# *52BACE0F03BF_52BABCB3015C_var*
begin
//#UC START# *52BACE0F03BF_52BABCB3015C_impl*
 AutoHideButton.Align := alNone;
 CloseButton.Align := alNone;
 HideButton.Align := alNone;
 if Navigator = nil then
  Exit;
 if Navigator.Float then
  lp_Left
 else
 case Navigator.Align of
  alLeft: lp_Left;
  alRight: lp_Right;
  alTop: lp_Top;
  alBottom: lp_Bottom;
 end;//case Align of
//#UC END# *52BACE0F03BF_52BABCB3015C_impl*
end;//TnpHeaderPrim.UpdatePositions

procedure TnpHeaderPrim.UpdateHideImage;
//#UC START# *52BACE1A006B_52BABCB3015C_var*
//#UC END# *52BACE1A006B_52BABCB3015C_var*
begin
//#UC START# *52BACE1A006B_52BABCB3015C_impl*
 if not f_Navigator.f_Float then
 begin
  if f_Navigator.State <> nsMinimized then
   case f_Navigator.Align of
    alRight:
     begin
//      {$IfDef NavigatorPanelNeedsTb97}
      HideButton.ImageIndex := f_HideRightImage;
//      {$Else}
//      HideButton.Glyph.LoadFromResourceName(HInstance, cBmpHideRight);
//      {$EndIf NavigatorPanelNeedsTb97}
     end;//alRight
    alLeft:
     begin
//      {$IfDef NavigatorPanelNeedsTb97}
      HideButton.ImageIndex := f_HideLeftImage;
//      {$Else}
//      HideButton.Glyph.LoadFromResourceName(HInstance, cBmpHideLeft);
//      {$EndIf NavigatorPanelNeedsTb97}
     end;//alLeft
   end//f_Navigator.Align
  else
   case f_Navigator.Align of
    alRight:
     begin
//      {$IfDef NavigatorPanelNeedsTb97}
      HideButton.ImageIndex := f_HideLeftImage;
//      {$Else}
//      HideButton.Glyph.LoadFromResourceName(HInstance, cBmpHideLeft);
//      {$EndIf NavigatorPanelNeedsTb97}
     end;//alRight
    alLeft:
     begin
//      {$IfDef NavigatorPanelNeedsTb97}
      HideButton.ImageIndex := f_HideRightImage;
//      {$Else}
//      HideButton.Glyph.LoadFromResourceName(HInstance, cBmpHideRight);
//      {$EndIf NavigatorPanelNeedsTb97}
     end;//alLeft
   end;//case f_Navigator.Align
 end//not f_Navigator.f_Float
 else
//  {$IfDef NavigatorPanelNeedsTb97}
  HideButton.ImageIndex := f_AutoHideOnImage;
//  {$EndIf NavigatorPanelNeedsTb97}
//#UC END# *52BACE1A006B_52BABCB3015C_impl*
end;//TnpHeaderPrim.UpdateHideImage

procedure TnpHeaderPrim.UpdateCloseImage;
//#UC START# *52BACE520121_52BABCB3015C_var*
//#UC END# *52BACE520121_52BABCB3015C_var*
begin
//#UC START# *52BACE520121_52BABCB3015C_impl*
// {$IfDef NavigatorPanelNeedsTB97}
 CloseButton.ImageIndex := f_CloseImage;
// {$Else}
// CloseButton.Glyph.LoadFromResourceName(HInstance, cBmpClose);
// {$EndIf NavigatorPanelNeedsTB97}
//#UC END# *52BACE520121_52BABCB3015C_impl*
end;//TnpHeaderPrim.UpdateCloseImage

procedure TnpHeaderPrim.UpdateAutoHideImage;
//#UC START# *52BACE6303BA_52BABCB3015C_var*
//#UC END# *52BACE6303BA_52BABCB3015C_var*
begin
//#UC START# *52BACE6303BA_52BABCB3015C_impl*
 if not f_Navigator.f_Float then
 begin
  case f_Navigator.State of
   nsAutoHide:
//    {$IfDef NavigatorPanelNeedsTB97}
    AutoHideButton.ImageIndex := f_AutoHideOffImage;
//    {$Else}
//    AutoHideButton.Glyph.LoadFromResourceName(HInstance, cBmpAutoHideOn);
//    {$EndIf NavigatorPanelNeedsTB97}
   else
//    {$IfDef NavigatorPanelNeedsTB97}
    AutoHideButton.ImageIndex := f_AutoHideOnImage;
//    {$Else}
//    AutoHideButton.Glyph.LoadFromResourceName(HInstance, cBmpAutoHideOff);
//    {$EndIf NavigatorPanelNeedsTB97}
  end;//case f_Navigator.Stat
 end//not f_Navigator.f_Float
 else
 begin
  if f_Navigator.f_FloatNavigator.State = fwsMinimized then
//   {$IfDef NavigatorPanelNeedsTB97}
   AutoHideButton.ImageIndex := f_HideDownImage
//   {$Else}
//   AutoHideButton.Glyph.LoadFromResourceName(HInstance, cBmpHideBottom)
//   {$EndIf NavigatorPanelNeedsTB97}
  else
//   {$IfDef NavigatorPanelNeedsTB97}
   AutoHideButton.ImageIndex := f_HideUpImage;
//   {$Else}
//   AutoHideButton.Glyph.LoadFromResourceName(HInstance, cBmpHideTop);
//   {$EndIf NavigatorPanelNeedsTB97}
 end;//not f_Navigator.f_Float
//#UC END# *52BACE6303BA_52BABCB3015C_impl*
end;//TnpHeaderPrim.UpdateAutoHideImage

function TnpHeaderPrim.GetRectLines: TRect;
//#UC START# *52BACE6F03E3_52BABCB3015C_var*
 function lp_FreeRect: TRect;
 var
  l_Index: Integer;
 begin
  Result := BoundsRect;
  for l_Index := 0 to Pred(ControlCount) do
   if Controls[l_Index].Visible then
    case Align of
     alLeft, alRight:
      case Controls[l_Index].Align of
       alTop: Result.Top := Max(Result.Top, Controls[l_Index].BoundsRect.Bottom);
       alBottom: Result.Bottom := Min(Result.Bottom, Controls[l_Index].BoundsRect.Top);
      else
       Assert(False);
      end;//case Controls[l_Index] of
     alTop, alBottom:
      case Controls[l_Index].Align of
       alLeft: Result.Left := Max(Result.Left, Controls[l_Index].BoundsRect.Right);
       alRight: Result.Right := Min(Result.Right, Controls[l_Index].BoundsRect.Left);
      else
       Assert(False);
      end;//case Controls[l_Index] of
    end;//case Navigator.Align of
 end;//lp_FreeRect
//#UC END# *52BACE6F03E3_52BABCB3015C_var*
begin
//#UC START# *52BACE6F03E3_52BABCB3015C_impl*
 Result := lp_FreeRect;
  // - свободная область для вывода линий;
 with Result do
  case Align of
   alLeft, alRight: Windows.InflateRect(Result, - ((Width - cLinesHeight) div 2), 0);
     // - расположим линии по середине навигатора;
   alTop, alBottom: Windows.InflateRect(Result, 0, - ((Height - cLinesHeight) div 2));
     // - расположим линии по середине навигатора;
  end;//case Navigator.Align of
//#UC END# *52BACE6F03E3_52BABCB3015C_impl*
end;//TnpHeaderPrim.GetRectLines

procedure TnpHeaderPrim.DoStateChanged;
//#UC START# *52BACE8501F5_52BABCB3015C_var*
//#UC END# *52BACE8501F5_52BABCB3015C_var*
begin
//#UC START# *52BACE8501F5_52BABCB3015C_impl*
 with f_Navigator do
 begin
  UpdateHideImage;
  UpdateAutoHideImage;
  if f_Navigator.Float then
   with AutoHideButton do
   begin
    GroupIndex := 0;
    Down := False;
   end//with AutoHideButton
  else
   case State of
    nsMinimized:
     begin
      HideButton.Visible := True;
      AutoHideButton.Visible := False;
      CloseButtonVisible(False);
     end;//nsMinimized
    nsNormal:
     begin
      HideButton.Visible := True;
      AutoHideButton.Down := True;
      AutoHideButton.Visible := True;
      CloseButtonVisible(True);
     end;//nsNormal
    nsAutoHide:
     begin
      with AutoHideButton do
      begin
       Down := False;
       Visible := True;
      end;//AutoHideButton
      HideButton.Visible := f_Navigator.f_HideDirect = hdShow;
      CloseButtonVisible(HideButton.Visible);
     end;//nsAutoHide
   end;//case State
 end;//with f_Navigator
//#UC END# *52BACE8501F5_52BABCB3015C_impl*
end;//TnpHeaderPrim.DoStateChanged

procedure TnpHeaderPrim.OnStateChanged(Sender: TObject);
//#UC START# *52BACE8C01C7_52BABCB3015C_var*
//#UC END# *52BACE8C01C7_52BABCB3015C_var*
begin
//#UC START# *52BACE8C01C7_52BABCB3015C_impl*
 DoStateChanged;
//#UC END# *52BACE8C01C7_52BABCB3015C_impl*
end;//TnpHeaderPrim.OnStateChanged

procedure TnpHeaderPrim.WMEraseBkgnd(var Message: TWMEraseBkgnd);
//#UC START# *52BAC39100F8_52BABCB3015C_var*
//#UC END# *52BAC39100F8_52BABCB3015C_var*
begin
//#UC START# *52BAC39100F8_52BABCB3015C_impl*
 Message.Result := 1;
//#UC END# *52BAC39100F8_52BABCB3015C_impl*
end;//TnpHeaderPrim.WMEraseBkgnd

procedure TnpHeaderPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52BABCB3015C_var*
//#UC END# *479731C50290_52BABCB3015C_var*
begin
//#UC START# *479731C50290_52BABCB3015C_impl*
 if (f_Navigator <> nil) then
  f_Navigator.UnRegisterStateChanged(f_Link);
 f_Navigator := nil;

 FreeAndNil(f_Canvas);
 FreeAndNil(f_CloseButton);
 FreeAndNil(f_AutoHideButton);
 FreeAndNil(f_HideButton);
 FreeAndNil(f_Link);
 inherited;
//#UC END# *479731C50290_52BABCB3015C_impl*
end;//TnpHeaderPrim.Cleanup

constructor TnpHeaderPrim.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_52BABCB3015C_var*
  procedure SetBtn(var aBtn : TnpButton;
                   aBtnType : TnpButtonType;
                   const aGlyphID : String);
  begin//SetBtn
   aBtn := TnpButton.Create(Self, TvtNavigator(aOwner), aBtnType);
   with aBtn do
   begin
    Name := aGlyphID;
    Parent := Self;
    Height := cButtonSize;
    Width := cButtonSize;
    Left := cIntervalButtonLine;
    Top := cIntervalButtonLine;
    Flat := True;
    Glyph.LoadFromResourceName(HInstance, aGlyphID);
   end;//with aBtn do
   if csDesigning in Self.ComponentState  then
     aBtn.Visible := False;
  end;//SetBtn
//#UC END# *47D1602000C6_52BABCB3015C_var*
begin
//#UC START# *47D1602000C6_52BABCB3015C_impl*
 inherited Create(AOwner);
 ControlStyle := ControlStyle + [csNoDesignVisible];
 Cursor := crSizeAll;
 f_Canvas := Tl3CustomControlCanvas.Create(Self);
 f_AutoHideOnImage := 0;
 f_AutoHideOffImage := 1;
 f_HideLeftImage := 2;
 f_HideRightImage := 3;
 f_CloseImage := 6;
 f_HideUpImage := 4;
 f_HideDownImage := 5;
 Size := cHeaderSize;
 f_Link := TnpChangeLink.Create;
 f_Link.OnStateChanged := OnStateChanged;
 SetBtn(f_AutoHideButton, nbtAutoHide, cBmpAutoHideOff);
 with AutoHideButton do
 begin
  AllowAllUp := True;
  GroupIndex := 1;
  Down := True;
 end;
 SetBtn(f_HideButton, nbtMinimize, cBmpHideLeft);
 SetBtn(f_CloseButton, nbtClose,    cBmpClose);
 UpdatePositions;
//#UC END# *47D1602000C6_52BABCB3015C_impl*
end;//TnpHeaderPrim.Create

{$If NOT Defined(NoVCL)}
procedure TnpHeaderPrim.MouseDown(Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *4F88473B03CD_52BABCB3015C_var*
var
 l_Control : TControl;
//#UC END# *4F88473B03CD_52BABCB3015C_var*
begin
//#UC START# *4F88473B03CD_52BABCB3015C_impl*
 if Button = mbLeft then
 begin
  if not Assigned(f_Navigator.f_PageControl.ActivePage) then
   Exit
  else
  if f_Navigator.f_PageControl.ActivePage.ControlCount = 0 then
   Exit;
  l_Control := f_Navigator.f_PageControl.ActivePage.Controls[0];
  f_Navigator.InitDrag(l_Control);
  f_IsDragBegining := True;
  f_Navigator.f_ActiveControl := l_Control;
  l_Control.BeginDrag(False);
 end;
 inherited MouseDown(Button, Shift, X, Y);
//#UC END# *4F88473B03CD_52BABCB3015C_impl*
end;//TnpHeaderPrim.MouseDown
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TnpHeaderPrim.Paint;
//#UC START# *5028A60300AD_52BABCB3015C_var*
  procedure lp_DrawFrame(aRect : TRect);
  begin//lp_DrawFrame
   Frame3D(Canvas, aRect, clBtnHighlight, clBtnShadow, 1);
   //Frame3D(Canvas, aRect, clBtnShadow, clBtnShadow, 1);
  end;//lp_DrawFrame

  procedure lp_PaintLine(ABelow: Integer);
  var
   lRect: TRect;
  begin//lp_PaintLine
   lRect := GetRectLines;
   { горизонталь }
   if (Self.Width > Self.Height) then
   begin
    lRect.Top := lRect.Top + ABelow;
    lRect.Bottom := lRect.Top + cBorderWidth;
   { вертикаль }
   end//Self.Width > Self.Height
   else
   begin
    lRect.Left := lRect.Left + ABelow;
    lRect.Right := lRect.Left + cBorderWidth;
   end;//Self.Width > Self.Height

   if Self.Width > Self.Height then
    Inc(lRect.Bottom)
   else
    Inc(lRect.Right);

   Frame3D(Self.Canvas, lRect, clBtnHighlight, clBtnShadow, 1);
  end;//lp_PaintLine

  procedure lp_DrawActivePage;
  var
   lRect    : TRect;
   lCaption : String;
  begin//lp_DrawActivePage
   if Assigned(f_Navigator.PageControl.ActivePage) then
   begin
    with Canvas do
    begin
     if f_Navigator.State = nsMinimized then
      Exit;
     (* рамка *)
     lp_DrawFrame(ClientRect);
     (* выводимая область *)
     lRect := GetRectLines;
     lRect.Top := 0;
     lRect.Bottom := ClientHeight;
     (* иконка *)
     with f_Navigator.f_PageControl do
      if Assigned(Images) and (ActivePage.ImageIndex <> -1) and
       (ActivePage.ImageIndex < Images.Count) then
      begin
       with Images do
        Draw(Self.Canvas, lRect.Left, (Self.Height - Height) div 2,
         ActivePage.ImageIndex, True);
       lRect.Left := lRect.Left + Images.Width + 2;
      end;//Assigned(Images) and (ActivePage.ImageIndex <> -1)..
     (* текст *)
     InflateRect(lRect, -1, -1);
     lCaption := f_Navigator.PageControl.ActivePage.Caption;
     f_Canvas.Font.AssignFont(Font);
     f_Canvas.BeginPaint;
     try
      f_Canvas.DrawText(l3PCharLen(lCaption),
                       lRect,
                       DT_VCENTER      or
                       DT_END_ELLIPSIS or
                       DT_SINGLELINE);
     finally
      f_Canvas.EndPaint;
     end;//try..finally
    end;//with Canvas
   end;//Assigned(f_Navigator.PageControl.ActivePage)
  end;//lp_DrawActivePage

var
  lRect: TRect;
//#UC END# *5028A60300AD_52BABCB3015C_var*
begin
//#UC START# *5028A60300AD_52BABCB3015C_impl*
 inherited;
 lRect := ClientRect;
 with Canvas do
 begin
  Brush.Color := cGarant2011ToolbarsColor{clBtnFace};
  FillRect(lRect);
  if f_Navigator.State = nsMinimized then
   Exit;
  (* навигатор находится в режиме автоскрытия и сейчас должна быть видна только
     кнопка AutoHideButton *)
  HideButton.Visible := not ((f_Navigator.State = nsAutoHide) and
   (f_Navigator.f_Surface.Size <= f_Navigator.SizeMini));
  CloseButtonVisible(HideButton.Visible);
  (* выводим иконку и название закладки *)
  if f_Navigator.ShowActivePageInHeader then
  begin
   if HideButton.Visible then
    lp_DrawActivePage;
  end//f_Navigator.ShowActivePageInHeader
  (* рисуем полосы *)
  else
  begin
   (* видна только кнопка AutoHideButton *)
   if not HideButton.Visible then
    Exit;
   if (f_Navigator.State <> nsMinimized) and
    (f_Navigator.f_HideDirect <> hdHide) then
   begin
    if f_Navigator.f_Float then
     InflateRect(lRect, -1, -1);
    lp_DrawFrame(lRect);
    { Первая линия }
    lp_PaintLine(0);
    { Подадим смещения для второй линии }
    lp_PaintLine(cOffsetSecondLine);
   end;//f_Navigator.State <> nsMinimized..
  end;//f_Navigator.ShowActivePageInHeader
 end;//with Canvas
//#UC END# *5028A60300AD_52BABCB3015C_impl*
end;//TnpHeaderPrim.Paint
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TnpHeaderPrim.AdjustClientRect(var Rect: TRect);
//#UC START# *508F957E0283_52BABCB3015C_var*
//#UC END# *508F957E0283_52BABCB3015C_var*
begin
//#UC START# *508F957E0283_52BABCB3015C_impl*
 inherited;
 InflateRect(Rect, - cIntervalHeaderButton, - cIntervalHeaderButton);
//#UC END# *508F957E0283_52BABCB3015C_impl*
end;//TnpHeaderPrim.AdjustClientRect
{$IfEnd} // NOT Defined(NoVCL)

constructor TnpButton.Create(aOwner: TComponent;
 aNavigator: TvtNavigatorPrim;
 aBtnType: TnpButtonType);
//#UC START# *52BAC32B010A_52BAC22601F8_var*
//#UC END# *52BAC32B010A_52BAC22601F8_var*
begin
//#UC START# *52BAC32B010A_52BAC22601F8_impl*
 inherited Create(AOwner);
 // inherited
 ShowHint := True;
 ControlStyle := ControlStyle + [csNoDesignVisible];
 // internal
 f_Navigator := aNavigator;
 f_BtnType := aBtnType;
//#UC END# *52BAC32B010A_52BAC22601F8_impl*
end;//TnpButton.Create

function TnpButton.MakeHint: AnsiString;
//#UC START# *52BAC34B0242_52BAC22601F8_var*
//#UC END# *52BAC34B0242_52BAC22601F8_var*
begin
//#UC START# *52BAC34B0242_52BAC22601F8_impl*
 Result := '';
 case f_BtnType of
  nbtAutoHide:
   // навигатор на форме
   if not f_Navigator.Float then
   begin
    if (f_Navigator.State = nsAutoHide) then
      Result := f_Navigator.AutoHideOffHint
    else
      Result := f_Navigator.AutoHideOnHint
   end//not f_Navigator.Float
   // плавающий навигатор
   else
   if (f_Navigator.f_FloatNavigator.State = fwsMinimized) then
    Result := f_Navigator.MinimizedOffHint
   else
    Result := f_Navigator.MinimizedOnHint;
  nbtMinimize:
   // навигатор на форме
   if not f_Navigator.Float then
   begin
    // навигатор скрыт
    if f_Navigator.State = nsMinimized then
     Result := f_Navigator.MinimizedOffHint
    // навигатор нормальный
    else
     Result := f_Navigator.MinimizedOnHint;
   end//not f_Navigator.Float
   // плавающий навигатор
   else
    Result := f_Navigator.CloseHint;
 else
  Result := Hint;
 end;//case f_BtnType of
//#UC END# *52BAC34B0242_52BAC22601F8_impl*
end;//TnpButton.MakeHint

procedure TnpButton.CMHintShow(var Message: TCMHintShow);
//#UC START# *52BAC30A020A_52BAC22601F8_var*
//#UC END# *52BAC30A020A_52BAC22601F8_var*
begin
//#UC START# *52BAC30A020A_52BAC22601F8_impl*
 Message.HintInfo.HintStr := MakeHint;
 inherited;
//#UC END# *52BAC30A020A_52BAC22601F8_impl*
end;//TnpButton.CMHintShow

procedure TnpButton.WMMouseMove(var Message: TWMMouseMove);
//#UC START# *52BAC31903DB_52BAC22601F8_var*
//#UC END# *52BAC31903DB_52BAC22601F8_var*
begin
//#UC START# *52BAC31903DB_52BAC22601F8_impl*
 inherited;
 Windows.SetCursor(Screen.Cursors[crDefault]);
//#UC END# *52BAC31903DB_52BAC22601F8_impl*
end;//TnpButton.WMMouseMove

procedure TnpFloatingWindow.pm_SetState(aValue: TnpFloatWindowState);
//#UC START# *52BD71C101CD_52BACEF001CBset_var*
var
 lFlag : Integer;
{$IfDef Nemesis}
 l_Index : Integer;
{$EndIf Nemesis}

 function lfnMinimizedSize : Integer;
 begin//lfnMinimizedSize
  with f_Navigator do
   Result := f_Header.Height + PageControl.MaxTabHeight;
 end;//lfnMinimizedSize
//#UC END# *52BD71C101CD_52BACEF001CBset_var*
begin
//#UC START# *52BD71C101CD_52BACEF001CBset_impl*
 if aValue = f_State then
  Exit;
 f_State := aValue;
 // текущий стиль окна
 lFlag := GetWindowLong(Handle, GWL_STYLE);
 case f_State of
  // свернём навигатор
  fwsMinimized:
  begin
   Self.Height := lfnMinimizedSize;
   lFlag := lFlag xor WS_THICKFRAME;
  end;//fwsMinimized
  // развернём навигатор
  fwsNormal:
  begin
   // если плавающий был создан минимизированным, то используем высоту навигатора
   // на форме для его разворачивания
   if f_SizeNormal <= lfnMinimizedSize then
    f_SizeNormal := f_Navigator.NavigatorOnForm.Height;
   Height := f_SizeNormal;
   lFlag := lFlag  or WS_THICKFRAME;
  end;//fwsNormal
 end;//case f_State
 // изменим стиль окна
 SetWindowLong(Handle, GWL_STYLE, lFlag);
 // перерисуем
 Perform(CM_BORDERCHANGED, 0, 0);
 f_Navigator.f_Header.UpdateAutoHideImage;
 {$IfDef Nemesis}
 // нужно обновить информацию о состоянии плавающей формы
 with Navigator.PageControl do
  for l_Index := 0 to Pred(PageCount) do
   if (Pages[l_Index].ControlCount > 0) and
    (Pages[l_Index].Controls[0] is TvcmForm) then
    TvcmForm(Pages[l_Index].Controls[0]).FloatWindowState :=
     IfThen((f_State = fwsMinimized), cFloatMinimized);
 {$EndIf Nemesis}
//#UC END# *52BD71C101CD_52BACEF001CBset_impl*
end;//TnpFloatingWindow.pm_SetState

function TnpFloatingWindow.GetGripperRect: TRect;
//#UC START# *52BD73E2039B_52BACEF001CB_var*
//#UC END# *52BD73E2039B_52BACEF001CB_var*
begin
//#UC START# *52BD73E2039B_52BACEF001CB_impl*
 // положение в пределах Desctop
 GetWindowRect(Handle, Result);
 // размеры навигатора
 OffsetRect(Result, -Result.Left, -Result.Top);
 // уменьшим чтобы не заслонять рамку
 InflateRect(Result, -GetSystemMetrics(SM_CXSIZEFRAME), -GetSystemMetrics(SM_CYSIZEFRAME));
 // область отрисовки gripper
 Result.Top := Result.Bottom - GetGripperHeight;
//#UC END# *52BD73E2039B_52BACEF001CB_impl*
end;//TnpFloatingWindow.GetGripperRect

function TnpFloatingWindow.GetGripperHeight: Integer;
//#UC START# *52BD73F900BF_52BACEF001CB_var*
//#UC END# *52BD73F900BF_52BACEF001CB_var*
begin
//#UC START# *52BD73F900BF_52BACEF001CB_impl*
 Result := GetSystemMetrics(SM_CYHSCROLL);
//#UC END# *52BD73F900BF_52BACEF001CB_impl*
end;//TnpFloatingWindow.GetGripperHeight

function TnpFloatingWindow.CheckGripperCursor: Boolean;
//#UC START# *52BD740F023F_52BACEF001CB_var*
var
 l_Rect : TRect;
//#UC END# *52BD740F023F_52BACEF001CB_var*
begin
//#UC START# *52BD740F023F_52BACEF001CB_impl*
 Result := False;
 // навигатор в свернутом состоянии, гриппер у него отсутствием
 if (f_State = fwsMinimized) then
  Exit;
 // получим позицию окна
 GetWindowRect(Handle, l_Rect);
 // вычислим положение gripper-а на экране
 l_Rect.Left := l_Rect.Right - GetGripperHeight;
 l_Rect.Top := l_Rect.Bottom - GetGripperHeight;
 // 
 if PtInRect(l_Rect, Mouse.CursorPos) then
  Result := True;
//#UC END# *52BD740F023F_52BACEF001CB_impl*
end;//TnpFloatingWindow.CheckGripperCursor

{$If Defined(Nemesis)}
procedure TnpFloatingWindow.UpdateFloatWindowsBounds;
//#UC START# *52BD742402DA_52BACEF001CB_var*
var
 l_Index : Integer;
 l_R : TRect;
//#UC END# *52BD742402DA_52BACEF001CB_var*
begin
//#UC START# *52BD742402DA_52BACEF001CB_impl*
 if Assigned(f_Navigator) and Assigned(f_Navigator.PageControl) then
  with f_Navigator.PageControl do
   for l_Index := 0 to Pred(PageCount) do
    if (Pages[l_Index].ControlCount > 0) and
       (Pages[l_Index].Controls[0] is TvcmForm) then
     with TvcmForm(Pages[l_Index].Controls[0]) do
     begin
      l_R := Self.BoundsRect;
      with l_R do
       Bottom := Top + Self.f_SizeNormal;
      FloatWindowBounds := l_R;
     end;//TvcmForm(Pages[l_Index].Controls[0])
//#UC END# *52BD742402DA_52BACEF001CB_impl*
end;//TnpFloatingWindow.UpdateFloatWindowsBounds
{$IfEnd} // Defined(Nemesis)

procedure TnpFloatingWindow.OnChangeState(Sender: TObject);
//#UC START# *52BD745C0104_52BACEF001CB_var*
//#UC END# *52BD745C0104_52BACEF001CB_var*
begin
//#UC START# *52BD745C0104_52BACEF001CB_impl*
 if f_State = High(TnpFloatWindowState) then
  State := Low(TnpFloatWindowState)
 else
  State := Succ(f_State);
//#UC END# *52BD745C0104_52BACEF001CB_impl*
end;//TnpFloatingWindow.OnChangeState

procedure TnpFloatingWindow.OnCloseWindow(Sender: TObject);
//#UC START# *52BD74650377_52BACEF001CB_var*
//#UC END# *52BD74650377_52BACEF001CB_var*
begin
//#UC START# *52BD74650377_52BACEF001CB_impl*
 (* Пристыкуем компоненты к навигаторам на форме *)
 with f_Navigator.PageControl do
  while PageCount > 0 do
   if Pages[0].ControlCount > 0 then
    TnpControlsList.Instance.DockOnForm(Pages[0].Controls[0]);
//#UC END# *52BD74650377_52BACEF001CB_impl*
end;//TnpFloatingWindow.OnCloseWindow

procedure TnpFloatingWindow.FormOnResize(Sender: TObject);
//#UC START# *52BD74710051_52BACEF001CB_var*
//#UC END# *52BD74710051_52BACEF001CB_var*
begin
//#UC START# *52BD74710051_52BACEF001CB_impl*
 if (f_State = fwsNormal) then
  f_SizeNormal := Self.Height;
 {$IfDef Nemesis}
 UpdateFloatWindowsBounds;
 {$EndIf Nemesis}
//#UC END# *52BD74710051_52BACEF001CB_impl*
end;//TnpFloatingWindow.FormOnResize

procedure TnpFloatingWindow.FormClose(Sender: TObject;
 var Action: TCloseAction);
//#UC START# *52BD748B0337_52BACEF001CB_var*
//#UC END# *52BD748B0337_52BACEF001CB_var*
begin
//#UC START# *52BD748B0337_52BACEF001CB_impl*
 if f_CloseDisabled then
  Action := caHide
 else
  Action := caFree;
//#UC END# *52BD748B0337_52BACEF001CB_impl*
end;//TnpFloatingWindow.FormClose

procedure TnpFloatingWindow.OnTabSheetClick(Sender: TObject;
 Page: TElTabSheet);
//#UC START# *52BD74BD0029_52BACEF001CB_var*
//#UC END# *52BD74BD0029_52BACEF001CB_var*
begin
//#UC START# *52BD74BD0029_52BACEF001CB_impl*
 // развернём окно, если свернуто
 State := fwsNormal;
 // начнем перетаскивание
 f_Navigator.OnTabSheetClick(Sender, Page);
//#UC END# *52BD74BD0029_52BACEF001CB_impl*
end;//TnpFloatingWindow.OnTabSheetClick

procedure TnpFloatingWindow.OnDockDrop(Sender: TObject;
 Source: TDragDockObject;
 X: Integer;
 Y: Integer);
//#UC START# *52BD74D2028D_52BACEF001CB_var*
//#UC END# *52BD74D2028D_52BACEF001CB_var*
begin
//#UC START# *52BD74D2028D_52BACEF001CB_impl*
 {$IfDef Nemesis}
 if Source.Control is TvcmForm then
  TvcmForm(Source.Control).FloatID := f_FloatID;
 {$EndIf Nemesis}
//#UC END# *52BD74D2028D_52BACEF001CB_impl*
end;//TnpFloatingWindow.OnDockDrop

function TnpFloatingWindow.GetNavigatorClass: RvtNavigator;
//#UC START# *52BD752A00D3_52BACEF001CB_var*
//#UC END# *52BD752A00D3_52BACEF001CB_var*
begin
//#UC START# *52BD752A00D3_52BACEF001CB_impl*
 Result := TvtNavigator;
//#UC END# *52BD752A00D3_52BACEF001CB_impl*
end;//TnpFloatingWindow.GetNavigatorClass

procedure TnpFloatingWindow.WMNCCalcSize(var Message: TWMNCCalcSize);
//#UC START# *52BD728700B7_52BACEF001CB_var*
//#UC END# *52BD728700B7_52BACEF001CB_var*
begin
//#UC START# *52BD728700B7_52BACEF001CB_impl*
 inherited;
 case f_State of
  fwsNormal:
   with Message.CalcSize_Params.rgrc[0] do
    Dec(Bottom, GetSystemMetrics(SM_CYHSCROLL));
  fwsMinimized:
   InflateRect(Message.CalcSize_Params.rgrc[0], -GetSystemMetrics(SM_CXBORDER), -GetSystemMetrics(SM_CYBORDER));
 end;//case f_State
//#UC END# *52BD728700B7_52BACEF001CB_impl*
end;//TnpFloatingWindow.WMNCCalcSize

procedure TnpFloatingWindow.WMNCPaint(var Message: TMessage);
//#UC START# *52BD729D02CC_52BACEF001CB_var*
var
 l_DC : HDC;
 l_R  : TRect;
//#UC END# *52BD729D02CC_52BACEF001CB_var*
begin
//#UC START# *52BD729D02CC_52BACEF001CB_impl*
 l_DC := GetWindowDC(Handle);
 try
  case f_State of
   fwsNormal:
   begin
    // Рисуем рамку
    inherited;
    // Нарисуем скроллер
    with Canvas.Brush do
    begin
     Color := clBtnFace;
     Style := bsSolid;
    end;//with Canvas.Brush
    l_R := GetGripperRect;
    // мы вычислили всё честно, DrawFrameControl почему то отрисовывает рамку
    // на один пиксел меньше, поэтому увеличим
    InflateRect(l_R, 1, 1);
    // рисуем
    DrawFrameControl(l_DC, l_R, DFC_SCROLL, DFCS_SCROLLSIZEGRIP);
   end;//fwsNormal
   fwsMinimized:
   begin
    Windows.GetWindowRect(Handle, l_R);
    OffsetRect(l_R, -l_R.Left, -l_R.Top);
    DrawEdge(l_DC, l_R, EDGE_RAISED, BF_RECT or BF_FLAT);
   end;//fwsMinimized
  end;//case f_State
 finally
  ReleaseDC(Handle, l_DC);
 end;//try..finally
//#UC END# *52BD729D02CC_52BACEF001CB_impl*
end;//TnpFloatingWindow.WMNCPaint

procedure TnpFloatingWindow.WMNCHitTest(var Message: TWMNCHitTest);
//#UC START# *52BD72BD00B9_52BACEF001CB_var*
//#UC END# *52BD72BD00B9_52BACEF001CB_var*
begin
//#UC START# *52BD72BD00B9_52BACEF001CB_impl*
 inherited;
 if CheckGripperCursor then
  Message.Result := HTBOTTOMRIGHT;
//#UC END# *52BD72BD00B9_52BACEF001CB_impl*
end;//TnpFloatingWindow.WMNCHitTest

procedure TnpFloatingWindow.WMEraseBkgnd(var Message: TWMEraseBkgnd);
//#UC START# *52BD72DE0167_52BACEF001CB_var*
//#UC END# *52BD72DE0167_52BACEF001CB_var*
begin
//#UC START# *52BD72DE0167_52BACEF001CB_impl*
 Message.Result := 1;
//#UC END# *52BD72DE0167_52BACEF001CB_impl*
end;//TnpFloatingWindow.WMEraseBkgnd

procedure TnpFloatingWindow.DisableClose;
//#UC START# *4E79FED900C6_52BACEF001CB_var*
//#UC END# *4E79FED900C6_52BACEF001CB_var*
begin
//#UC START# *4E79FED900C6_52BACEF001CB_impl*
 Assert(FormStyle = fsStayOnTop);
 f_CloseDisabled := True;
//#UC END# *4E79FED900C6_52BACEF001CB_impl*
end;//TnpFloatingWindow.DisableClose

procedure TnpFloatingWindow.DisableReactivate;
//#UC START# *4E7A0D9401F6_52BACEF001CB_var*
//#UC END# *4E7A0D9401F6_52BACEF001CB_var*
begin
//#UC START# *4E7A0D9401F6_52BACEF001CB_impl*
 Assert(FormStyle = fsStayOnTop);
 f_ReactivateDisabled := True;
//#UC END# *4E7A0D9401F6_52BACEF001CB_impl*
end;//TnpFloatingWindow.DisableReactivate

procedure TnpFloatingWindow.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52BACEF001CB_var*
//#UC END# *479731C50290_52BACEF001CB_var*
begin
//#UC START# *479731C50290_52BACEF001CB_impl*
 f_CloseDisabled := False;
 f_ReactivateDisabled := False;
 inherited;
//#UC END# *479731C50290_52BACEF001CB_impl*
end;//TnpFloatingWindow.Cleanup

{$If NOT Defined(NoVCL)}
procedure TnpFloatingWindow.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_52BACEF001CB_var*
//#UC END# *48C7925A02E5_52BACEF001CB_var*
begin
//#UC START# *48C7925A02E5_52BACEF001CB_impl*
 inherited CreateParams(Params);
 with Params do
 begin
  if (Parent = nil) and (ParentWindow = 0) then
  begin
   Style := Style or WS_POPUP;
   ExStyle := ExStyle and not WS_EX_APPWINDOW or WS_EX_TOOLWINDOW;
  end;
  Style := Style and not WS_CAPTION;
  case f_State of
   fwsNormal:
    Style := Style or WS_THICKFRAME;
   fwsMinimized:
    Style := Style and not WS_THICKFRAME;
  end;//case f_State
 end;//with Params
//#UC END# *48C7925A02E5_52BACEF001CB_impl*
end;//TnpFloatingWindow.CreateParams
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
function TnpFloatingWindow.CloseQuery: Boolean;
 {* CloseQuery is called automatically when an attempt is made to close the form. CloseQuery can allow the form to close by returning true, or prevent the form from closing by returning false.

As implemented in TCustomForm, CloseQuery polls any MDI children by calling their CloseQuery methods. If no child form aborts the close, CloseQuery then calls the OnCloseQuery event handler, if it exists, to determine if the close should be allowed. If no such event handler exists, CloseQuery returns true. }
//#UC START# *4980403E021E_52BACEF001CB_var*
var
 l_Index : Integer;
 lPC    : TnpPageControl;
//#UC END# *4980403E021E_52BACEF001CB_var*
begin
//#UC START# *4980403E021E_52BACEF001CB_impl*
 Result := inherited CloseQuery;
 if Result then
  f_FloatID := 0;
 l_Index := 0;
 lPC := f_Navigator.PageControl;
 while Result and (l_Index <= Pred(lPC.PageCount)) do
 begin
  if (lPC.Pages[l_Index].ControlCount > 0) and
   (lPC.Pages[l_Index].Controls[0] is TCustomForm) then
   Result := TCustomForm(lPC.Pages[l_Index].Controls[0]).CloseQuery;
  Inc(l_Index);
 end;//while Result and (l_Index <= Pred(lPC.PageCount))
//#UC END# *4980403E021E_52BACEF001CB_impl*
end;//TnpFloatingWindow.CloseQuery
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
constructor TnpFloatingWindow.CreateNew(AOwner: TComponent;
 Dummy: Integer = 0);
//#UC START# *4F9007B20376_52BACEF001CB_var*
//#UC END# *4F9007B20376_52BACEF001CB_var*
begin
//#UC START# *4F9007B20376_52BACEF001CB_impl*
 inherited CreateNew(AOwner);
 Caption := 'Плавающий навигатор';
 BorderIcons := [];
 FormStyle := fsStayOnTop;
 OnClose := FormClose;
 OnResize := FormOnResize;
 f_FloatID := 0;
 f_State := fwsNormal;
 f_Navigator := GetNavigatorClass.Create(Self);
 f_Navigator.Parent := Self;
 f_Navigator.f_FloatNavigator := Self;
 f_Navigator.Float := True;
 f_Navigator.Align := alClient;
 with f_Navigator.PageControl do
 begin
  Visible := True;
  //Assert(not Assigned(OnTabSheetClick));
  // - закомментировал, т.к. падало при отдочивании оглавления
  OnTabSheetClick := Self.OnTabSheetClick;
  // http://mdp.garant.ru/pages/viewpage.action?pageId=344754050&focusedCommentId=346751217&#comment-346751217
  Assert(not Assigned(OnDockDrop));
  OnDockDrop := Self.OnDockDrop;
  // http://mdp.garant.ru/pages/viewpage.action?pageId=344754050&focusedCommentId=346750985#comment-346750985
  Align := alClient;
 end;//with f_Navigator.PageControl
 with f_Navigator.f_Header do
 begin
  Visible := True;
  OnHide := OnCloseWindow;
  OnAutoHide := OnChangeState;
 end;//with f_Navigator.Header
 f_Navigator.DockSite := False;
 {$IfDef Nemesis}
 DefaultMonitor := dmDesktop;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=569239659
 {$EndIf Nemesis}
//#UC END# *4F9007B20376_52BACEF001CB_impl*
end;//TnpFloatingWindow.CreateNew
{$IfEnd} // NOT Defined(NoVCL)

function TvtNavigatorPrim.pm_GetRelativeNavigator: TvtNavigatorPrim;
//#UC START# *52BC2DA80151_52BAD1C40174get_var*
//#UC END# *52BC2DA80151_52BAD1C40174get_var*
begin
//#UC START# *52BC2DA80151_52BAD1C40174get_impl*
 if not Assigned(f_RelativeNavigator) then
  f_RelativeNavigator := FindRelative(RelativeAlign);
 Result := f_RelativeNavigator;
//#UC END# *52BC2DA80151_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetRelativeNavigator

function TvtNavigatorPrim.pm_GetClientControl: TWinControl;
//#UC START# *52BC2DE7032A_52BAD1C40174get_var*
var
 l_Index: Integer;
//#UC END# *52BC2DE7032A_52BAD1C40174get_var*
begin
//#UC START# *52BC2DE7032A_52BAD1C40174get_impl*
 Result := nil;
 if Assigned(Parent) then
  for l_Index := 0 to Pred(Parent.ControlCount) do
   if Parent.Controls[l_Index] is TWinControl then
    with TWinControl(Parent.Controls[l_Index]) do
     if (Align = alClient) then
     begin
      Result := TWinControl(Parent.Controls[l_Index]);
      Break;
     end;//if (Align = alClient) then
//#UC END# *52BC2DE7032A_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetClientControl

function TvtNavigatorPrim.pm_GetSizeMini: Integer;
//#UC START# *52BC2E2D011E_52BAD1C40174get_var*
var
 lRect : TRect;
 lSize : Integer;
//#UC END# *52BC2E2D011E_52BAD1C40174get_var*
begin
//#UC START# *52BC2E2D011E_52BAD1C40174get_impl*
 Result := 0;
 if (f_SizeMini > -1) and (f_PageControl.PageCount > 0) then
 begin
  Result := f_SizeMini;
  Exit;
 end;
 with TnpPageControl(f_PageControl) do
 begin
  if (PageCount > 0) then
  begin
   // иначе не посчитается область закладок в CalcTabAreaSize, потому что ни
   // одна закладка не видима
   if (PageCount = 1) and not Pages[0].TabVisible then
    Pages[0].TabVisible := True;
   lSize := f_PageControl.MaxTabHeight + 20;
   // клиентская область, формы
   lRect := Rect(0, 0, lSize, lSize);
   AdjustClientRect(lRect);
   // область закладок
   case TabPosition of
    etpTop: Result := lRect.Top;
    etpBottom: Result := lSize - lRect.Bottom;
    etpLeft: Result := lRect.Left;
    etpRight: Result := lSize - lRect.Right;
   end;//case TabPosition
   // добавим ширину сплиттера, у плавающего навигатора сплиттер отсутствует,
   // его не учитываем
   if not f_Navigator.Float then
    Inc(Result, cspSize);
   // кешируем результат
   f_SizeMini := Result;
  end;//PageCount > 0
 end;//with TnpPageControl(f_PageControl)
//#UC END# *52BC2E2D011E_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetSizeMini

procedure TvtNavigatorPrim.pm_SetSwim(aValue: Boolean);
//#UC START# *52BC2E6203D8_52BAD1C40174set_var*
//#UC END# *52BC2E6203D8_52BAD1C40174set_var*
begin
//#UC START# *52BC2E6203D8_52BAD1C40174set_impl*
 f_Swim := aValue;
 DoStateChanged;
//#UC END# *52BC2E6203D8_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetSwim

procedure TvtNavigatorPrim.pm_SetActivate(aValue: Boolean);
//#UC START# *52BC2E81013F_52BAD1C40174set_var*
//#UC END# *52BC2E81013F_52BAD1C40174set_var*
begin
//#UC START# *52BC2E81013F_52BAD1C40174set_impl*
 if f_Activate <> aValue then
 begin
  // Не показываем навигатор, если окно минизированно
  if aValue and npIsWindowMinimized(f_MainForm) then
   Exit;
  f_Activate := aValue;
  if f_Float then
  begin
   case aValue of
    True:
     SetWindowPos(f_FloatNavigator.Handle, HWND_TOPMOST, 0, 0, 0, 0,
      SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW);
    False:
     SetWindowPos(f_FloatNavigator.Handle, 0, 0, 0, 0, 0,
      SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE or SWP_HIDEWINDOW);
   end;
   f_FloatNavigator.Visible := aValue;
   // - иначе огребаем рассинхронизацию
//   {$IfDef vtNavUseDebugLog}
//   l3System.Msg2Log(Format('NAV NavigatorActivate = %d', [Integer(Value)]));
//   {$EndIf vtNavUseDebugLog}
  end
  else
  if not f_Activate then
   f_Surface.f_Splitter.splHideHint;
 end;
//#UC END# *52BC2E81013F_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetActivate

function TvtNavigatorPrim.pm_GetIsMinimized: Boolean;
//#UC START# *52BC2F7A018F_52BAD1C40174get_var*
//#UC END# *52BC2F7A018F_52BAD1C40174get_var*
begin
//#UC START# *52BC2F7A018F_52BAD1C40174get_impl*
 Result := f_State = nsMinimized;
//#UC END# *52BC2F7A018F_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetIsMinimized

function TvtNavigatorPrim.pm_GetPages(anIndex: Integer): TElTabSheet;
//#UC START# *52BC2FAA0390_52BAD1C40174get_var*
//#UC END# *52BC2FAA0390_52BAD1C40174get_var*
begin
//#UC START# *52BC2FAA0390_52BAD1C40174get_impl*
 Result := f_PageControl.Pages[anIndex];
//#UC END# *52BC2FAA0390_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetPages

function TvtNavigatorPrim.pm_GetActivePageIndex: Integer;
//#UC START# *52BC2FFB0208_52BAD1C40174get_var*
//#UC END# *52BC2FFB0208_52BAD1C40174get_var*
begin
//#UC START# *52BC2FFB0208_52BAD1C40174get_impl*
 Result := f_PageControl.ActivePageIndex;
//#UC END# *52BC2FFB0208_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetActivePageIndex

procedure TvtNavigatorPrim.pm_SetActivePageIndex(aValue: Integer);
//#UC START# *52BC2FFB0208_52BAD1C40174set_var*
//#UC END# *52BC2FFB0208_52BAD1C40174set_var*
begin
//#UC START# *52BC2FFB0208_52BAD1C40174set_impl*
 f_PageControl.ActivePageIndex := aValue;
//#UC END# *52BC2FFB0208_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetActivePageIndex

function TvtNavigatorPrim.pm_GetPageCount: Integer;
//#UC START# *52BC303702E2_52BAD1C40174get_var*
//#UC END# *52BC303702E2_52BAD1C40174get_var*
begin
//#UC START# *52BC303702E2_52BAD1C40174get_impl*
 Result := f_PageControl.PageCount;
//#UC END# *52BC303702E2_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetPageCount

procedure TvtNavigatorPrim.pm_SetFloat(aValue: Boolean);
//#UC START# *52BC3164027D_52BAD1C40174set_var*
//#UC END# *52BC3164027D_52BAD1C40174set_var*
begin
//#UC START# *52BC3164027D_52BAD1C40174set_impl*
 f_Float := aValue;
 DoStateChanged;
//#UC END# *52BC3164027D_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetFloat

function TvtNavigatorPrim.pm_GetState: TNavigatorState;
//#UC START# *52BC31BA023D_52BAD1C40174get_var*
//#UC END# *52BC31BA023D_52BAD1C40174get_var*
begin
//#UC START# *52BC31BA023D_52BAD1C40174get_impl*
 Result := f_State;
//#UC END# *52BC31BA023D_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetState

procedure TvtNavigatorPrim.pm_SetState(aValue: TNavigatorState);
//#UC START# *52BC31BA023D_52BAD1C40174set_var*
//#UC END# *52BC31BA023D_52BAD1C40174set_var*
begin
//#UC START# *52BC31BA023D_52BAD1C40174set_impl*
 if (aValue <> f_State) then
 begin
  if (f_State = nsAutoHide) then
  begin
   f_TimerFloat.Enabled := False;
   f_TimerDelay.Enabled := False;
  end;//f_State = nsAutoHide
  f_State := aValue;
  // При открытии приложения изначально панели должны быть скрыты в авторежиме:
  if f_State = nsAutoHide then
   f_TimerFloat.Enabled := True;
  UpdateState;
  DoStateChanged(True);
 end;//Value <> f_State
//#UC END# *52BC31BA023D_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetState

procedure TvtNavigatorPrim.pm_SetShowActivePageInHeader(aValue: Boolean);
//#UC START# *52BC320E037B_52BAD1C40174set_var*
//#UC END# *52BC320E037B_52BAD1C40174set_var*
begin
//#UC START# *52BC320E037B_52BAD1C40174set_impl*
 f_ShowActivePageInHeader := aValue;
 f_Header.Invalidate;
//#UC END# *52BC320E037B_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetShowActivePageInHeader

function TvtNavigatorPrim.pm_GetImages: TCustomImageList;
//#UC START# *52BC350C00A3_52BAD1C40174get_var*
//#UC END# *52BC350C00A3_52BAD1C40174get_var*
begin
//#UC START# *52BC350C00A3_52BAD1C40174get_impl*
 Result := f_PageControl.Images;
//#UC END# *52BC350C00A3_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetImages

procedure TvtNavigatorPrim.pm_SetImages(aValue: TCustomImageList);
//#UC START# *52BC350C00A3_52BAD1C40174set_var*
//#UC END# *52BC350C00A3_52BAD1C40174set_var*
begin
//#UC START# *52BC350C00A3_52BAD1C40174set_impl*
 f_PageControl.Images := aValue;
//#UC END# *52BC350C00A3_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetImages

procedure TvtNavigatorPrim.pm_SetDelayOnAutoHide(aValue: Boolean);
//#UC START# *52BC35CD014E_52BAD1C40174set_var*
//#UC END# *52BC35CD014E_52BAD1C40174set_var*
begin
//#UC START# *52BC35CD014E_52BAD1C40174set_impl*
 if not aValue then
  f_TimerDelay.Enabled := False;
 f_DelayOnAutoHide := aValue;
 f_DoDelay := aValue;
//#UC END# *52BC35CD014E_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetDelayOnAutoHide

procedure TvtNavigatorPrim.pm_SetSingleFloatNavigator(aValue: Boolean);
//#UC START# *52BC360D034F_52BAD1C40174set_var*
//#UC END# *52BC360D034F_52BAD1C40174set_var*
begin
//#UC START# *52BC360D034F_52BAD1C40174set_impl*
 f_SingleFloatNavigator := aValue;
//#UC END# *52BC360D034F_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetSingleFloatNavigator

function TvtNavigatorPrim.pm_GetAlign: TAlign;
//#UC START# *52BC365D0137_52BAD1C40174get_var*
//#UC END# *52BC365D0137_52BAD1C40174get_var*
begin
//#UC START# *52BC365D0137_52BAD1C40174get_impl*
 Result := inherited Align;
//#UC END# *52BC365D0137_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetAlign

procedure TvtNavigatorPrim.pm_SetAlign(aValue: TAlign);
//#UC START# *52BC365D0137_52BAD1C40174set_var*
//#UC END# *52BC365D0137_52BAD1C40174set_var*
begin
//#UC START# *52BC365D0137_52BAD1C40174set_impl*
 if aValue <> Align then
 begin
  case aValue of
   alTop:
   begin
    inherited Align := aValue;
    f_Header.Align := alLeft;
    f_PageControl.TabPosition := etpTop;
   end;
   alLeft:
   begin
    inherited Align := aValue;
    f_Header.Align := alTop;
    f_PageControl.TabPosition := etpLeft;
   end;
   alRight:
   begin
    inherited Align := aValue;
    f_Header.Align := alTop;
    f_PageControl.TabPosition := etpRight;
   end;
   alBottom:
    begin
     inherited Align := aValue;
     f_Header.Align := alLeft;
     f_PageControl.TabPosition := etpBottom;
    end;
   else
    begin
     if not f_Float then
     begin
      inherited Align := alTop;
      f_Header.Align := alLeft;
     end
     else
     begin
      inherited Align := aValue;
      f_Header.Align := alTop;
     end;
     f_PageControl.TabPosition := etpTop;
    end;
  end;
  f_Surface.DefineSplitterAlign;
  f_Header.UpdateImages;
  ModeStateUpdate;
 end;//Value <> Align
//#UC END# *52BC365D0137_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetAlign

procedure TvtNavigatorPrim.pm_SetSizeEmpty(aValue: Integer);
//#UC START# *52BC36B202C9_52BAD1C40174set_var*
//#UC END# *52BC36B202C9_52BAD1C40174set_var*
begin
//#UC START# *52BC36B202C9_52BAD1C40174set_impl*
 f_SizeEmpty := aValue;
 AttachSurface;
 SetSize(aValue);
//#UC END# *52BC36B202C9_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetSizeEmpty

procedure TvtNavigatorPrim.pm_SetSizeNormal(aValue: Integer);
//#UC START# *52BC36FC016D_52BAD1C40174set_var*
 procedure lp_SetSize(aControl : TControl);
 begin
  case Self.Align of
   alTop, alBottom: aControl.Height := f_SizeNormal;
   alLeft, alRight: aControl.Width := f_SizeNormal;
  end;//case Self.Align of
 end;//lp_SetSize
//#UC END# *52BC36FC016D_52BAD1C40174set_var*
begin
//#UC START# *52BC36FC016D_52BAD1C40174set_impl*
 f_SizeNormal := aValue;
 (* Не закладок не нужно и размер устанавливать *)
 if not Assigned(f_PageControl) or (f_PageControl.PageCount = 0) then
  Exit;
 f_SizeNormal := CorrectSize(f_SizeNormal);
 //CheckSize(f_SizeNormal);
 (* AutoHide *)
 case f_State of
  nsAutoHide:
   lp_SetSize(f_Surface);
  nsNormal:
   lp_SetSize(Self);
 end;//case f_State of
 if (f_State = nsAutoHide) and (Align = alRight) then
  f_Surface.Left := Parent.ClientWidth - f_Surface.Width;
//#UC END# *52BC36FC016D_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetSizeNormal

function TvtNavigatorPrim.pm_GetButtonsImageList: TCustomImageList;
//#UC START# *52BC37B80233_52BAD1C40174get_var*
//#UC END# *52BC37B80233_52BAD1C40174get_var*
begin
//#UC START# *52BC37B80233_52BAD1C40174get_impl*
 Result := f_Header.ButtonsImageList;
//#UC END# *52BC37B80233_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetButtonsImageList

procedure TvtNavigatorPrim.pm_SetButtonsImageList(aValue: TCustomImageList);
//#UC START# *52BC37B80233_52BAD1C40174set_var*
//#UC END# *52BC37B80233_52BAD1C40174set_var*
begin
//#UC START# *52BC37B80233_52BAD1C40174set_impl*
 f_Header.ButtonsImageList := aValue;
//#UC END# *52BC37B80233_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetButtonsImageList

function TvtNavigatorPrim.pm_GetCloseImage: TImageIndex;
//#UC START# *52BC38190127_52BAD1C40174get_var*
//#UC END# *52BC38190127_52BAD1C40174get_var*
begin
//#UC START# *52BC38190127_52BAD1C40174get_impl*
 Result := f_Header.CloseImage;
//#UC END# *52BC38190127_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetCloseImage

procedure TvtNavigatorPrim.pm_SetCloseImage(aValue: TImageIndex);
//#UC START# *52BC38190127_52BAD1C40174set_var*
//#UC END# *52BC38190127_52BAD1C40174set_var*
begin
//#UC START# *52BC38190127_52BAD1C40174set_impl*
 f_Header.CloseImage := aValue;
//#UC END# *52BC38190127_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetCloseImage

function TvtNavigatorPrim.pm_GetAutoHideOnImage: TImageIndex;
//#UC START# *52BC38290235_52BAD1C40174get_var*
//#UC END# *52BC38290235_52BAD1C40174get_var*
begin
//#UC START# *52BC38290235_52BAD1C40174get_impl*
 Result := f_Header.AutoHideOnImage;
//#UC END# *52BC38290235_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetAutoHideOnImage

procedure TvtNavigatorPrim.pm_SetAutoHideOnImage(aValue: TImageIndex);
//#UC START# *52BC38290235_52BAD1C40174set_var*
//#UC END# *52BC38290235_52BAD1C40174set_var*
begin
//#UC START# *52BC38290235_52BAD1C40174set_impl*
 f_Header.AutoHideOnImage := aValue;
//#UC END# *52BC38290235_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetAutoHideOnImage

function TvtNavigatorPrim.pm_GetAutoHideOffImage: TImageIndex;
//#UC START# *52BC38560093_52BAD1C40174get_var*
//#UC END# *52BC38560093_52BAD1C40174get_var*
begin
//#UC START# *52BC38560093_52BAD1C40174get_impl*
 Result := f_Header.AutoHideOffImage;
//#UC END# *52BC38560093_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetAutoHideOffImage

procedure TvtNavigatorPrim.pm_SetAutoHideOffImage(aValue: TImageIndex);
//#UC START# *52BC38560093_52BAD1C40174set_var*
//#UC END# *52BC38560093_52BAD1C40174set_var*
begin
//#UC START# *52BC38560093_52BAD1C40174set_impl*
 f_Header.AutoHideOffImage := aValue;
//#UC END# *52BC38560093_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetAutoHideOffImage

function TvtNavigatorPrim.pm_GetHideLeftImage: TImageIndex;
//#UC START# *52BC386603CA_52BAD1C40174get_var*
//#UC END# *52BC386603CA_52BAD1C40174get_var*
begin
//#UC START# *52BC386603CA_52BAD1C40174get_impl*
 Result := f_Header.HideLeftImage;
//#UC END# *52BC386603CA_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetHideLeftImage

procedure TvtNavigatorPrim.pm_SetHideLeftImage(aValue: TImageIndex);
//#UC START# *52BC386603CA_52BAD1C40174set_var*
//#UC END# *52BC386603CA_52BAD1C40174set_var*
begin
//#UC START# *52BC386603CA_52BAD1C40174set_impl*
 f_Header.HideLeftImage := aValue;
//#UC END# *52BC386603CA_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetHideLeftImage

function TvtNavigatorPrim.pm_GetHideRightImage: TImageIndex;
//#UC START# *52BC38770142_52BAD1C40174get_var*
//#UC END# *52BC38770142_52BAD1C40174get_var*
begin
//#UC START# *52BC38770142_52BAD1C40174get_impl*
 Result := f_Header.HideRightImage;
//#UC END# *52BC38770142_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetHideRightImage

procedure TvtNavigatorPrim.pm_SetHideRightImage(aValue: TImageIndex);
//#UC START# *52BC38770142_52BAD1C40174set_var*
//#UC END# *52BC38770142_52BAD1C40174set_var*
begin
//#UC START# *52BC38770142_52BAD1C40174set_impl*
 f_Header.HideRightImage := aValue;
//#UC END# *52BC38770142_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetHideRightImage

function TvtNavigatorPrim.pm_GetHideUpImage: TImageIndex;
//#UC START# *52BC38840249_52BAD1C40174get_var*
//#UC END# *52BC38840249_52BAD1C40174get_var*
begin
//#UC START# *52BC38840249_52BAD1C40174get_impl*
 Result := f_Header.HideUpImage;
//#UC END# *52BC38840249_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetHideUpImage

procedure TvtNavigatorPrim.pm_SetHideUpImage(aValue: TImageIndex);
//#UC START# *52BC38840249_52BAD1C40174set_var*
//#UC END# *52BC38840249_52BAD1C40174set_var*
begin
//#UC START# *52BC38840249_52BAD1C40174set_impl*
 f_Header.HideUpImage := aValue;
//#UC END# *52BC38840249_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetHideUpImage

function TvtNavigatorPrim.pm_GetHideDownImage: TImageIndex;
//#UC START# *52BC38920251_52BAD1C40174get_var*
//#UC END# *52BC38920251_52BAD1C40174get_var*
begin
//#UC START# *52BC38920251_52BAD1C40174get_impl*
 Result := f_Header.HideDownImage;
//#UC END# *52BC38920251_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetHideDownImage

procedure TvtNavigatorPrim.pm_SetHideDownImage(aValue: TImageIndex);
//#UC START# *52BC38920251_52BAD1C40174set_var*
//#UC END# *52BC38920251_52BAD1C40174set_var*
begin
//#UC START# *52BC38920251_52BAD1C40174set_impl*
 f_Header.HideDownImage := aValue;
//#UC END# *52BC38920251_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetHideDownImage

procedure TvtNavigatorPrim.pm_SetNavigatorOnForm(aValue: TvtNavigatorPrim);
//#UC START# *52CED0F20285_52BAD1C40174set_var*
//#UC END# *52CED0F20285_52BAD1C40174set_var*
begin
//#UC START# *52CED0F20285_52BAD1C40174set_impl*
 f_NavigatorOnForm := aValue;
 if (aValue <> nil) then
  f_ParentNavigatorHandle := aValue.Handle
 else
  f_ParentNavigatorHandle := 0;
//#UC END# *52CED0F20285_52BAD1C40174set_impl*
end;//TvtNavigatorPrim.pm_SetNavigatorOnForm

function TvtNavigatorPrim.CorrectSize(aSizeNormal: Integer): Integer;
 {* откорректировать размер }
//#UC START# *52BD5F51022B_52BAD1C40174_var*
//#UC END# *52BD5F51022B_52BAD1C40174_var*
begin
//#UC START# *52BD5F51022B_52BAD1C40174_impl*
 Result := aSizeNormal;
 with CorrectBounds(CalcBounds(aSizeNormal)) do
  case Self.Align of
   alLeft, alRight: Result := Right - Left;
   alTop, alBottom: Result := Bottom - Top;
  end;//case Self.Align
//#UC END# *52BD5F51022B_52BAD1C40174_impl*
end;//TvtNavigatorPrim.CorrectSize

function TvtNavigatorPrim.RelativeAlign: TAlign;
 {* выравнивание навигатора - соседа }
//#UC START# *52BD5F720354_52BAD1C40174_var*
//#UC END# *52BD5F720354_52BAD1C40174_var*
begin
//#UC START# *52BD5F720354_52BAD1C40174_impl*
 Result := alNone;
 case Self.Align of
  alLeft: Result := alRight;
  alRight: Result := alLeft;
  alTop: Result := alBottom;
  alBottom: Result := alTop;
 end;//case Self.Align of
//#UC END# *52BD5F720354_52BAD1C40174_impl*
end;//TvtNavigatorPrim.RelativeAlign

function TvtNavigatorPrim.FindRelative(aAlign: TAlign): TvtNavigatorPrim;
 {* найти навигатор на той же форме с указанным выравниванием. Делаем допущение, что на форме может быть только один навигатор с указанным типом выравнивания }
//#UC START# *52BD5F9E0274_52BAD1C40174_var*
var
 l_Index: Integer;
//#UC END# *52BD5F9E0274_52BAD1C40174_var*
begin
//#UC START# *52BD5F9E0274_52BAD1C40174_impl*
 Result := nil;
 if Assigned(Parent) then
  with Parent do
   for l_Index := 0 to Pred(ControlCount) do
    if (Controls[l_Index] is TvtNavigator) and
     (Controls[l_Index].Align = aAlign) then
    begin
     Result := TvtNavigator(Controls[l_Index]); 
     Break;
    end;//if (Controls[l_Index] is TvtNavigator) and
//#UC END# *52BD5F9E0274_52BAD1C40174_impl*
end;//TvtNavigatorPrim.FindRelative

function TvtNavigatorPrim.CalcBounds(aSizeNormal: Integer): TRect;
 {* вычислить новые границы с указанным нормальным размером }
//#UC START# *52BD5FCF0121_52BAD1C40174_var*
//#UC END# *52BD5FCF0121_52BAD1C40174_var*
begin
//#UC START# *52BD5FCF0121_52BAD1C40174_impl*
 Result := BoundsRect;
 case Align of
  alLeft: Result.Right := Result.Left + aSizeNormal;
  alRight: Result.Left := Result.Right - aSizeNormal;
  alTop: Result.Bottom := Result.Top + aSizeNormal;
  alBottom: Result.Top := Result.Bottom - aSizeNormal;
 end;//case Align of
//#UC END# *52BD5FCF0121_52BAD1C40174_impl*
end;//TvtNavigatorPrim.CalcBounds

function TvtNavigatorPrim.CalcSize(const aBounds: TRect): Integer;
 {* вычисляет размер }
//#UC START# *52BD5FEF0063_52BAD1C40174_var*
//#UC END# *52BD5FEF0063_52BAD1C40174_var*
begin
//#UC START# *52BD5FEF0063_52BAD1C40174_impl*
 Result := 0;
 with aBounds do
  case Align of
   alLeft, alRight: Result := Right - Left;
   alTop, alBottom: Result := Bottom - Top;
  end;//case Align of
//#UC END# *52BD5FEF0063_52BAD1C40174_impl*
end;//TvtNavigatorPrim.CalcSize

function TvtNavigatorPrim.CorrectBounds(const aBounds: TRect): TRect;
 {* корректирует новые размеры навигатора. Необходимо при перетаскивании навигатора и при сплиттинге }
//#UC START# *52BD60180199_52BAD1C40174_var*
 procedure lp_MinSize;
 {* - сожмем навигатор, занятой области он не оставил даже минимального
      пространства (cMinNormalSize + cMinClientControlSize).}
 var
  l_Rect   : TRect;
  l_Client : TRect;
  l_Size   : Integer;
 begin
  if Assigned(RelativeNavigator) then
  begin
   l_Size := cMinNormalSize + cMinClientControlSize;
   l_Rect := BoundsRect;
   l_Client := Parent.ClientRect;
   case Align of
    alLeft:
     begin
      if (l_Rect.Right > l_Client.Right - l_Size) and
       (Width > cMinNormalSize) then
      begin
       Width := l_Client.Right - l_Size - l_Rect.Left;
       Result.Right := l_Client.Right - l_Size;
      end;//if (l_Rect.Right > l_Client.Right - l_Size) and
     end;//alLeft
    alRight:
     begin
      if (l_Rect.Left < l_Client.Left + l_Size) and
       (Width > cMinNormalSize) then
      begin
       Width := l_Rect.Right - (l_Client.Left + l_Size);
       Result.Left := l_Client.Left + l_Size;
      end;//if (l_Rect.Left < l_Client.Left + l_Size) and
     end;//alRight
   end;//case Align of
  end;//if Assigned(RelativeNavigator) then
 end;//lp_CorrectAfterRestore

 procedure lp_ConflictWithBusyRect;
 {* - установим размер навигатора в зависимости от уже занятой области. }

  function BusyRectOnParent: TRect;
    {* - область занятая клиентским компонентом и навигатором. }
  var
   l_Control  : TWinControl;
   l_TempSize : Integer;
   l_Size     : Integer;
   l_Rect     : TRect;
  begin
   SetRectEmpty(Result);
   l_Control := ClientControl;
   if Assigned(l_Control) then
   begin
    Result := l_Control.BoundsRect;
    if Assigned(RelativeNavigator) then
    begin
     l_Size := cMinClientControlSize;
     l_Rect := RelativeNavigator.BoundsRect;
     l_TempSize := CalcSize(l_Rect);
     if l_TempSize < cMinNormalSize then
      l_TempSize := cMinNormalSize;
     Inc(l_Size, l_TempSize);
     case RelativeNavigator.Align of
      alLeft:
       begin
        Result.Left := l_Rect.Left;
        Result.Right := l_Rect.Left + l_Size;
       end;
      alRight:
       begin
        Result.Right := l_Rect.Right;
        Result.Left := l_Rect.Right - l_Size
       end;
      alTop:
       begin
        Result.Top := l_Rect.Top;
        Result.Bottom := l_Rect.Top - l_Size;
       end;
      alBottom:
       begin
        Result.Bottom := l_Rect.Bottom;
        Result.Top := l_Rect.Bottom - l_Size;
       end;
     end;//case RelativeNavigator of
    end//if Assigned(RelativeNavigator) then
    else
     case Self.Align of
      alLeft: Result.Left := Result.Right;
     else
      Assert(False);
     end;//Case Self.Align
   end;//if Assigned(l_Control) then
  end;//BusyRectOnParent

 var
  l_Rect: TRect;
 begin
  l_Rect := BusyRectOnParent;
  case Self.Align of
   alLeft:
    if Result.Right > l_Rect.Left then
     if Result.Left + cMinNormalSize > l_Rect.Left then
      Result.Right := Result.Left + cMinNormalSize
     else
      Result.Right := l_Rect.Left;
   alRight:
    if Result.Left < l_Rect.Right then
     if Result.Right - cMinNormalSize < l_Rect.Right then
      Result.Left := Result.Right - cMinNormalSize
     else
     Result.Left := l_Rect.Right;
   alTop:
    if Result.Bottom > l_Rect.Top then
     if Result.Top + cMinNormalSize > l_Rect.Top then
      Result.Bottom := Result.Top + cMinNormalSize
     else
      Result.Bottom := l_Rect.Top;
   alBottom:
    if Result.Top > l_Rect.Bottom then
     if Result.Bottom - cMinNormalSize > l_Rect.Bottom then
      Result.Top := Result.Bottom - cMinNormalSize
     else
     Result.Top := l_Rect.Bottom;
  end;//case Self.Align of
 end;//lp_ConflictWithBusyRect

 procedure lp_CorrectBounds;
 {* - если навигатор выходит за пределы то откорректируем. }
 var
  l_Rect   : TRect;
  l_Client : TRect;
 begin//lp_CorrectBounds
  l_Rect := BoundsRect;
  l_Client := Parent.ClientRect;
  case Align of
   alLeft:
    if l_Rect.Left < l_Client.Left then
    begin
     Windows.OffsetRect(l_Rect, l_Client.Left - l_Rect.Left, 0);
     BoundsRect := l_Rect;
    end;//if l_Rect.Left < l_Client.Left then
   alRight:
    if l_Rect.Right > l_Client.Right then
    begin
     Windows.OffsetRect(l_Rect, l_Client.Right - l_Rect.Right, 0);
     BoundsRect := l_Rect;
    end;//if l_Rect.Right > l_Client.Right then
   alTop:
    if l_Rect.Top < l_Client.Top then
    begin
     Windows.OffsetRect(l_Rect, 0, l_Client.Top - l_Rect.Top);
     BoundsRect := l_Rect;
    end;//if l_Rect.Top < l_Client.Top then
   alBottom:
    if l_Rect.Bottom > l_Client.Bottom then
    begin
     Windows.OffsetRect(l_Rect, 0, l_Client.Bottom - l_Rect.Bottom);
     BoundsRect := l_Rect;
    end;//if l_Rect.Top < l_Client.Top then
  end;//case RelativeNavigator.Align of
 end;//lp_CorrectBounds

var
 l_CurrentSize : Integer;
 l_NewSize     : Integer;
//#UC END# *52BD60180199_52BAD1C40174_var*
begin
//#UC START# *52BD60180199_52BAD1C40174_impl*
 Result := aBounds;
 if Assigned(ClientControl) then
 begin
  l_CurrentSize := CalcSize(BoundsRect);
  l_NewSize := CalcSize(aBounds);
  if l_NewSize >= l_CurrentSize then
  begin
   lp_CorrectBounds;
   // Если при изменении размеров формы мы достигли минимального размера
   // навигатора, более уже ничего сделать нельзя
   if not ((l_NewSize = l_CurrentSize) and (f_SizeNormal = cMinNormalSize)) then
   begin
    lp_MinSize;
    lp_ConflictWithBusyRect;
   end;//if not ((l_NewSize = l_CurrentSize)
  end;//if l_NewSize >= l_CurrentSize then
 end;//if Assigned(l_Control) then
//#UC END# *52BD60180199_52BAD1C40174_impl*
end;//TvtNavigatorPrim.CorrectBounds

procedure TvtNavigatorPrim.UpdateSize;
//#UC START# *52BD604900EC_52BAD1C40174_var*
//#UC END# *52BD604900EC_52BAD1C40174_var*
begin
//#UC START# *52BD604900EC_52BAD1C40174_impl*
 if f_State = nsAutoHide then
  AutoUpdateSize
 else
  NormalUpdateSize;
//#UC END# *52BD604900EC_52BAD1C40174_impl*
end;//TvtNavigatorPrim.UpdateSize

procedure TvtNavigatorPrim.AutoUpdateSize;
//#UC START# *52BD60530301_52BAD1C40174_var*
var
 lDelta: Integer;
 lBounds: TRect;
//#UC END# *52BD60530301_52BAD1C40174_var*
begin
//#UC START# *52BD60530301_52BAD1C40174_impl*
 // Размер
 if f_HideDirect = hdHide then
  lDelta := SizeMini
 else
  lDelta := SizeNormal;
 if Swim then
 begin
  // Текущий размер
  lBounds := f_Surface.BoundsRect;
  // Новый размер
  with lBounds do
   case Self.Align of
    alLeft: Right := Left + lDelta;
    alRight: Left := Right - lDelta;
    alTop: Bottom := Top + lDelta;
    alBottom: Top := Bottom - lDelta;
   end;//case Self.Align
  // Применим
  f_Surface.BoundsRect := lBounds;
 end//Swim
 else
  SetSelfSize(lDelta);
//#UC END# *52BD60530301_52BAD1C40174_impl*
end;//TvtNavigatorPrim.AutoUpdateSize

procedure TvtNavigatorPrim.ResetDragInfo;
 {* сбрасывает флаги используемые при перетаскивании }
//#UC START# *52BD60960071_52BAD1C40174_var*
//#UC END# *52BD60960071_52BAD1C40174_var*
begin
//#UC START# *52BD60960071_52BAD1C40174_impl*
 f_Header.f_IsDragBegining := False;
 f_ClickOnTab := False;
//#UC END# *52BD60960071_52BAD1C40174_impl*
end;//TvtNavigatorPrim.ResetDragInfo

function TvtNavigatorPrim.IsUndockByUser: Boolean;
 {* True, если закладки отстыкованы пользователем }
//#UC START# *52BD60BF0233_52BAD1C40174_var*
//#UC END# *52BD60BF0233_52BAD1C40174_var*
begin
//#UC START# *52BD60BF0233_52BAD1C40174_impl*
 Assert(f_Header <> nil);
 Result := f_Header.f_IsDragBegining or (f_ClickOnTab and not f_DblClickUnDock);
//#UC END# *52BD60BF0233_52BAD1C40174_impl*
end;//TvtNavigatorPrim.IsUndockByUser

procedure TvtNavigatorPrim.OnDblClickUndock(var CanUnDock: Boolean;
 aControl: TControl);
 {* не разрешаем отстыковывать закладку, пристыковываем её на форму }
//#UC START# *52BD615702DB_52BAD1C40174_var*
//#UC END# *52BD615702DB_52BAD1C40174_var*
begin
//#UC START# *52BD615702DB_52BAD1C40174_impl*
 f_DblClickUnDock := True;
 if f_Float then
 begin
  CanUnDock := False;
  TnpControlsList.Instance.DockOnForm(aControl);
  f_DblClickUnDock := False;
 end;//f_Float
//#UC END# *52BD615702DB_52BAD1C40174_impl*
end;//TvtNavigatorPrim.OnDblClickUndock

procedure TvtNavigatorPrim.CreateSurface;
//#UC START# *52BD619100C0_52BAD1C40174_var*
//#UC END# *52BD619100C0_52BAD1C40174_var*
begin
//#UC START# *52BD619100C0_52BAD1C40174_impl*
 f_Surface := TnpSurface.Create(Self);
 with f_Surface do
 begin
  Navigator := Self;
  Parent := Self;
  Align := alClient;
 end;//with f_Surface
//#UC END# *52BD619100C0_52BAD1C40174_impl*
end;//TvtNavigatorPrim.CreateSurface

procedure TvtNavigatorPrim.CreateHeader;
//#UC START# *52BD619A032E_52BAD1C40174_var*
//#UC END# *52BD619A032E_52BAD1C40174_var*
begin
//#UC START# *52BD619A032E_52BAD1C40174_impl*
 f_Header := TnpHeader.Create(Self);
 f_Surface.Header := f_Header;
 f_Header.Navigator := Self;
 f_Header.Width := f_Header.Size;
 f_Header.OnUnDock := OnPageControlUnDock;
 f_Header.OnHide := OnHide;
 f_Header.OnAutoHide := OnAutoHide;
//#UC END# *52BD619A032E_52BAD1C40174_impl*
end;//TvtNavigatorPrim.CreateHeader

procedure TvtNavigatorPrim.CreatePageControl;
//#UC START# *52BD61A40323_52BAD1C40174_var*
//#UC END# *52BD61A40323_52BAD1C40174_var*
begin
//#UC START# *52BD61A40323_52BAD1C40174_impl*
 f_PageControl := GetPageControlClass.Create(Self);
 f_Surface.PageControl := f_PageControl;
 with f_PageControl do
 begin
  Name := Self.Name;
  f_Navigator := Self;
  DockSite := True;
  Flat := True;
  OnUnDock := Self.OnPageControlUnDock;
  OnTabSheetClick := Self.OnTabSheetClick;
  OnChange := Self.OnPageControlChange;
  OnResize := Self.OnPageControlResize;
  DragPageControl := True;
  OnStartDragControl := Self.OnStartDragControl;
  OnDblClickUndock := Self.OnDblClickUndock;
 end;//with f_PageControl
//#UC END# *52BD61A40323_52BAD1C40174_impl*
end;//TvtNavigatorPrim.CreatePageControl

procedure TvtNavigatorPrim.InitMainForm(aOwner: TComponent);
//#UC START# *52BD61C202D9_52BAD1C40174_var*

 function lp_GetParentForm(aForm: TCustomForm): TCustomForm;
 var
  l_Control: TControl;
 begin
  Result := nil;
  l_Control := aForm;
  while (l_Control.Parent <> nil) do
  begin
   l_Control := l_Control.Parent;
   if (l_Control is TCustomForm) and (l_Control.Parent = nil) then
   begin
    Result := TCustomForm(l_Control);
    Break;
   end;
  end;
 end;

var
 lOwner : TComponent;
 l_ContainerForm: IafwMainFormContainer;
//#UC END# *52BD61C202D9_52BAD1C40174_var*
begin
//#UC START# *52BD61C202D9_52BAD1C40174_impl*
 lOwner := aOwner;
 while Assigned(lOwner) do
 begin
  if (lOwner.Owner = Application) and (lOwner is TCustomForm) then
  begin
   if (TCustomForm(lOwner).Parent = nil) then
   begin
    f_MainForm := TCustomForm(lOwner);
    Break;
   end
   else
   begin
    f_MainForm := lp_GetParentForm(TCustomForm(lOwner));
    {$If defined(Nemesis) AND not defined(NoVCM)}
    if Supports(f_MainForm, IafwMainFormContainer, l_ContainerForm) then
    try
     f_ParentMainForm := l_ContainerForm.CurrentMainForm;
    finally
     l_ContainerForm := nil;
    end
    else
     f_ParentMainForm := f_MainForm;
    {$IfEnd}
    // - http://mdp.garant.ru/pages/viewpage.action?pageId=596174840
    Break;
   end;
  end;//(lOwner.Owner = Application) and (lOwner is TCustomForm)
  lOwner := lOwner.Owner;
 end;//while Assigned(lOwner)
//#UC END# *52BD61C202D9_52BAD1C40174_impl*
end;//TvtNavigatorPrim.InitMainForm

procedure TvtNavigatorPrim.RecalcSize;
//#UC START# *52BD61E101FF_52BAD1C40174_var*
var
 lWinPosInfo : Cardinal;
//#UC END# *52BD61E101FF_52BAD1C40174_var*
begin
//#UC START# *52BD61E101FF_52BAD1C40174_impl*
 lWinPosInfo := BeginDeferWindowPos(1);
 try
  with f_Surface do
   DeferWindowPos(lWinPosInfo, Handle, 0, 0, 0, Width, Height, SWP_FRAMECHANGED);
 finally
  EndDeferWindowPos(lWinPosInfo);
 end;//try..finally
//#UC END# *52BD61E101FF_52BAD1C40174_impl*
end;//TvtNavigatorPrim.RecalcSize

procedure TvtNavigatorPrim.SetSize(aValue: Integer;
 aControl: TControl = nil);
 {* устанавливает размер навигатора в зависимости от Align }
//#UC START# *52BD61F501E5_52BAD1C40174_var*
//#UC END# *52BD61F501E5_52BAD1C40174_var*
begin
//#UC START# *52BD61F501E5_52BAD1C40174_impl*
 if not Assigned(aControl) then
  aControl := Self; 
 case Self.Align of
  alLeft, alRight: aControl.Width := aValue;
  alTop, alBottom: aControl.Height := aValue;
 end;//case Self.Align
//#UC END# *52BD61F501E5_52BAD1C40174_impl*
end;//TvtNavigatorPrim.SetSize

procedure TvtNavigatorPrim.UpdateState;
 {* действует используя State }
//#UC START# *52BD625A0013_52BAD1C40174_var*
//#UC END# *52BD625A0013_52BAD1C40174_var*
begin
//#UC START# *52BD625A0013_52BAD1C40174_impl*
 with f_PageControl do
 begin
  f_Header.Visible := PageCount > 0;
  Visible := PageCount > 0;
 end;
 case f_State of
  nsAutoHide: DoAutoHide;
  nsMinimized:
   begin
    AttachSurface;
    Minimized;
   end;//Minimized
  nsNormal:
   begin
    AttachSurface;
    pm_SetSizeNormal(f_SizeNormal);
   end;//nsNormal
 end;//case f_State
 (* Пересчитаем размер клиентской области *)
 if f_State <> nsAutoHide then
  RecalcSize;
 UpdateCloseButton; 
//#UC END# *52BD625A0013_52BAD1C40174_impl*
end;//TvtNavigatorPrim.UpdateState

procedure TvtNavigatorPrim.PlaceSurface;
//#UC START# *52BD627B0350_52BAD1C40174_var*
var
 l_Left, l_Top, l_Width, l_Height: Integer;
//#UC END# *52BD627B0350_52BAD1C40174_var*
begin
//#UC START# *52BD627B0350_52BAD1C40174_impl*
 if State <> nsAutoHide then
  Exit;
 case Align of
  alBottom, alTop:
   begin
    f_Surface.Width := Width;
    if Align = alBottom then
     f_Surface.Top := Self.Parent.ClientHeight - f_Surface.Height
    else
     f_Surface.Top := Self.Top;
   end;//alBottom, alTop:
  alLeft, alRight:
   begin
    f_Surface.Top := Top;
    f_Surface.Height := Height;
    if Align = alRight then
     f_Surface.Left := Self.Parent.ClientWidth - f_Surface.Width;
   end;//alLeft, alRight:
 end;//case Align of
//#UC END# *52BD627B0350_52BAD1C40174_impl*
end;//TvtNavigatorPrim.PlaceSurface

procedure TvtNavigatorPrim.AttachSurface;
//#UC START# *52BD628801D8_52BAD1C40174_var*
//#UC END# *52BD628801D8_52BAD1C40174_var*
begin
//#UC START# *52BD628801D8_52BAD1C40174_impl*
 with f_Surface do
 begin
  Parent := Self;
  Align := alClient;
 end;//with f_Surface do
//#UC END# *52BD628801D8_52BAD1C40174_impl*
end;//TvtNavigatorPrim.AttachSurface

procedure TvtNavigatorPrim.DetachSurface;
//#UC START# *52BD62920263_52BAD1C40174_var*
//#UC END# *52BD62920263_52BAD1C40174_var*
begin
//#UC START# *52BD62920263_52BAD1C40174_impl*
 with f_Surface do
 begin
  Align := alNone;
  Parent := Self.Parent;
  PlaceSurface;
 end;//with f_Surface do
 Perform(CM_npDoActionWithFormControls, Ord(acUpInZOrder), 0);
//#UC END# *52BD62920263_52BAD1C40174_impl*
end;//TvtNavigatorPrim.DetachSurface

procedure TvtNavigatorPrim.SetSizeMini;
//#UC START# *52BD629A02DA_52BAD1C40174_var*
//#UC END# *52BD629A02DA_52BAD1C40174_var*
begin
//#UC START# *52BD629A02DA_52BAD1C40174_impl*
 SetSize(SizeMini);
//#UC END# *52BD629A02DA_52BAD1C40174_impl*
end;//TvtNavigatorPrim.SetSizeMini

procedure TvtNavigatorPrim.DoAutoHide;
 {* подготавливает компоненты при включении режима автоскрытия }
//#UC START# *52BD62A70122_52BAD1C40174_var*
//#UC END# *52BD62A70122_52BAD1C40174_var*
begin
//#UC START# *52BD62A70122_52BAD1C40174_impl*
 if (f_PageControl.PageCount = 0) then
  Exit;
 f_TimerDelay.Enabled := True;
 f_HideDirect := hdHide;
 DetachSurface;
 with f_Surface do
 begin
  SetSizeMini;
  InitAutoHidePosition;
 end;//with f_Surface
 SetSizeMini;
//#UC END# *52BD62A70122_52BAD1C40174_impl*
end;//TvtNavigatorPrim.DoAutoHide

function TvtNavigatorPrim.CalcNewFloatBounds: TRect;
//#UC START# *52BD62C20057_52BAD1C40174_var*
const
 cMultiplier = 20;
var
 l_Left    : Integer;
 l_Top     : Integer;
 l_Height  : Integer;
 l_Width   : Integer;
 l_Monitor : TRect;
 l_Cursor  : TPoint;
 l_Dist    : Integer;
 l_Rect    : TRect;
//#UC END# *52BD62C20057_52BAD1C40174_var*
begin
//#UC START# *52BD62C20057_52BAD1C40174_impl*
 l_Height := 0;
 l_Width := 0;
 l_Cursor := Mouse.CursorPos;
 if IsUndockByUser then
 begin
  l_Left := l_Cursor.X - f_ClickPoint.X;
  l_Top := l_Cursor.Y - f_ClickPoint.Y;
 end//IsUndockByUser
 else
 begin
  Windows.GetWindowRect(Handle, l_Rect);
  l_Left := l_Rect.Left;
  l_Top := l_Rect.Top;
 end;//IsUndockByUser
 (* Сместим плавающий навигатор относительно навигатора на форме *)
 if f_DblClickUnDock or not IsUndockByUser then
 begin
  Inc(f_CountUndock);
  if f_CountUndock > 10 then
   f_CountUndock := 1;
  l_Dist := f_CountUndock * cMultiplier;
  l_Monitor := Screen.MonitorFromPoint(l_Cursor).BoundsRect;
  (* Сместим вверх или вниз *)
  if l_Top + l_Dist < l_Monitor.Bottom then
   Inc(l_Top, l_Dist)
  else
   Dec(l_Top, l_Dist);
  (* Для навигаторов справа, внизу сдвигаем рамку плавающего навигатора вверх,
     влево *)
  if Align in [alRight, alBottom] then
   l_Dist := -l_Dist;
  (* Сместим вправо или влево *)
  if l_Left + l_Dist < l_Monitor.Right then
   Inc(l_Left, l_Dist)
  else
   Dec(l_Left, l_Dist);
  f_DblClickUnDock := False;
 end;
 (* Размеры нового навигатора *)
 if f_Float then
  with f_FloatNavigator do
  begin
   l_Height := Height;
   l_Width := Width;
  end//with f_FloatNavigator
 else
 begin
  // Так нужно делать потому, что в режиме автоскрытия размеры меняются, а
  // размер рамки должен быть как у прикрепленного навигатора
  case Align of
   alLeft, alRight:
    begin
     l_Height := Height;
     l_Width := f_SizeNormal;
    end;//alLeft, alRight
   alTop, alBottom:
    begin
     l_Width := Width;
     l_Height := f_SizeNormal;
    end;//alTop, alBottom
  end;//case Align
 end;//f_Float
 (* Положение плавающего навигатора *)
 Result := Rect(l_Left, l_Top, l_Left + l_Width, l_Top  + l_Height);
//#UC END# *52BD62C20057_52BAD1C40174_impl*
end;//TvtNavigatorPrim.CalcNewFloatBounds

procedure TvtNavigatorPrim.SetDockRect(DragDockObject: TDragDockObject);
//#UC START# *52BD62DB03DF_52BAD1C40174_var*
//#UC END# *52BD62DB03DF_52BAD1C40174_var*
begin
//#UC START# *52BD62DB03DF_52BAD1C40174_impl*
 if (State = nsAutoHide) and (f_PageControl.PageCount > 0) then
  DragDockObject.DockRect := GetDockRect(f_SizeNormal)
 else
 if f_PageControl.PageCount = 0 then
  DragDockObject.DockRect := GetDockRect(GetNavigatorSizeNormal(DragDockObject.Control));
//#UC END# *52BD62DB03DF_52BAD1C40174_impl*
end;//TvtNavigatorPrim.SetDockRect

procedure TvtNavigatorPrim.InitDrag(aControl: TControl);
//#UC START# *52BD6318023E_52BAD1C40174_var*
//#UC END# *52BD6318023E_52BAD1C40174_var*
begin
//#UC START# *52BD6318023E_52BAD1C40174_impl*
 { Получим размеры будущей формы }
 if f_Float then
  f_DockRect := f_FloatNavigator.BoundsRect
 else
  f_DockRect := GetDockRect(f_SizeNormal);

 { Навигатор может быть плавающим и его видимые размеры (размеры PageControl-а)
   больше чем сам TvtNavigator в связи с этим рассчитаем положение мышы,
   чтобы не зависеть от размеров TvtNavigator }
 f_ClickPoint.X := f_DockRect.Left - Mouse.CursorPos.X;
 f_ClickPoint.X := Abs(f_ClickPoint.X);
 f_ClickPoint.Y := f_DockRect.Top - Mouse.CursorPos.Y;
 f_ClickPoint.Y := Abs(f_ClickPoint.Y);
 { Размеры навигатора были получены в экранных координатах, пересчитаем }
 OffsetRect(f_DockRect, -f_DockRect.Left, -f_DockRect.Top);

 { Для отрисовки тени }
 {$IfDef Nemesis}
 if aControl is TvcmForm then
  TvcmForm(aControl).OnPositionDockRect := OnFormPositionDockRect;
 {$EndIf Nemesis}
//#UC END# *52BD6318023E_52BAD1C40174_impl*
end;//TvtNavigatorPrim.InitDrag

function TvtNavigatorPrim.CheckControl(aControl: TControl): Boolean;
//#UC START# *52BD634A02F3_52BAD1C40174_var*
var
 l_Index: Integer;
//#UC END# *52BD634A02F3_52BAD1C40174_var*
begin
//#UC START# *52BD634A02F3_52BAD1C40174_impl*
 l_Index := 0;
 Result := True;
 while Result and (l_Index <= Pred(f_PageControl.PageCount)) do
 begin
  if (f_PageControl.Pages[l_Index].ControlCount > 0) then
   Result := not (f_PageControl.Pages[l_Index].Controls[0] = aControl)
  else
   Result := True; 
  (* такой компонент уже есть, проверим его позицию *)
  if not Result then
   aControl.Align := alClient;
  Inc(l_Index);
 end;//while Result and (l_Index <= Pred(f_PageControl.PageCount))
//#UC END# *52BD634A02F3_52BAD1C40174_impl*
end;//TvtNavigatorPrim.CheckControl

function TvtNavigatorPrim.DoLoadSize: Integer;
//#UC START# *52BD63660252_52BAD1C40174_var*
//#UC END# *52BD63660252_52BAD1C40174_var*
begin
//#UC START# *52BD63660252_52BAD1C40174_impl*
 Result := -1;
 if Assigned(f_OnLoadSize) then
  f_OnLoadSize(Self, Result);
//#UC END# *52BD63660252_52BAD1C40174_impl*
end;//TvtNavigatorPrim.DoLoadSize

function TvtNavigatorPrim.FindFloatNavigator: TnpFloatingWindow;
 {* возвращает плавающий навигатор, если он не создан, то nil }
//#UC START# *52BD637E01DC_52BAD1C40174_var*
var
 Index: Integer;
//#UC END# *52BD637E01DC_52BAD1C40174_var*
begin
//#UC START# *52BD637E01DC_52BAD1C40174_impl*
 Result := nil;
 Index := 0;
 while (Index <= Application.ComponentCount - 1) and (Result = nil) do
 begin
  if Application.Components[Index] is TnpFloatingWindow then
    Result := Application.Components[Index] as TnpFloatingWindow;
  Inc(Index);
 end;
//#UC END# *52BD637E01DC_52BAD1C40174_impl*
end;//TvtNavigatorPrim.FindFloatNavigator

procedure TvtNavigatorPrim.UpdateCloseButton;
//#UC START# *52BD640D0313_52BAD1C40174_var*
var
 l_Index : Integer;
//#UC END# *52BD640D0313_52BAD1C40174_var*
begin
//#UC START# *52BD640D0313_52BAD1C40174_impl*
 if (f_Header <> nil) then
 begin
  if (f_State <> nsMinimized) then
  begin
   with PageControl do
    if (ActivePage <> nil) and
       (ActivePage.ControlCount > 0) then
    begin
     if TvtNavigatorFormList.Instance.FindData(TvtFormHandlerID_C(ActivePage.Controls[0]), l_Index) then
      f_Header.ShowCloseButton(TvtNavigatorFormList.Instance.Items[l_Index].CloseHandler)
     else
      f_Header.HideCloseButton;
    end//if PageControl.ActivePage <> nil then
    else
     f_Header.HideCloseButton;
  end
  else
   f_Header.HideCloseButton;
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=602933962 
 end;
//#UC END# *52BD640D0313_52BAD1C40174_impl*
end;//TvtNavigatorPrim.UpdateCloseButton

function TvtNavigatorPrim.GetNewBoundsFromPoint(X: Integer;
 Y: Integer): TRect;
//#UC START# *52BD64230135_52BAD1C40174_var*
//#UC END# *52BD64230135_52BAD1C40174_var*
begin
//#UC START# *52BD64230135_52BAD1C40174_impl*
 Result := BoundsRect;
 case Align of
  alLeft: Result.Right := X;
  alRight:
   begin
    Result.Left := X;
    (* После перетаскивания оставляем курсор в области сплиттера *)
    Dec(Result.Left, cspSize);
   end;
  alTop: Result.Bottom := Y;
  alBottom: Result.Top := Y;
 end;//case Align of
//#UC END# *52BD64230135_52BAD1C40174_impl*
end;//TvtNavigatorPrim.GetNewBoundsFromPoint

procedure TvtNavigatorPrim.AddNavigator(P: TnpFloatingWindow);
//#UC START# *52BD644A002B_52BAD1C40174_var*
//#UC END# *52BD644A002B_52BAD1C40174_var*
begin
//#UC START# *52BD644A002B_52BAD1C40174_impl*
 if (f_NavigatorList.IndexOf(P) = -1) then
  f_NavigatorList.Add(P);
//#UC END# *52BD644A002B_52BAD1C40174_impl*
end;//TvtNavigatorPrim.AddNavigator

procedure TvtNavigatorPrim.AutoHideUpdate;
//#UC START# *52BD645E0355_52BAD1C40174_var*
const
  SizeSensitive = 6;
var
 lSaveDirect  : TnpHideDirect;
 lIsNavigator : Boolean;
 lRect        : TRect;
//#UC END# *52BD645E0355_52BAD1C40174_var*
begin
//#UC START# *52BD645E0355_52BAD1C40174_impl*
 if f_State <> nsAutoHide then
  Exit;
 if (not f_Surface.f_Splitter.IsHideButtonDown or f_TimerFloat.Enabled) and
    (Self.Parent.Handle <> GetCapture) and
    (f_State <> nsMinimized) and
    not f_MouseDown and
    (f_PageControl.PageCount > 0) then
 begin
  if not f_IsDelay then
  begin
   if f_DoDelay and not ((f_HideDirect = hdHide) and (f_DelayIntervalOnShow = 0)) then
    OpenDelay
   else
   begin
    lSaveDirect := f_HideDirect;
    Windows.GetWindowRect(f_Surface.Handle, lRect);
    lIsNavigator := PtInRect(lRect, Mouse.CursorPos);
    if (f_HideDirect = hdShow) and not lIsNavigator then
     f_HideDirect := hdHide
    else
    if (f_HideDirect = hdHide) and lIsNavigator then
     f_HideDirect := hdShow;

    if lSaveDirect <> f_HideDirect then
     if f_AutoHideFloat then
     begin
      if f_HideDirect = hdShow then
       f_IsFloatingOnShow := True;
      f_TimerFloat.Enabled := True;
     end//f_AutoHideFloat
     else
      ModeAutoUpdate;
   end;//f_DoDelay and not ((f_HideDirect = hdHide) and (f_DelayIntervalOnShow = 0))
  end;//not f_IsDelay
 end//(not Surface.Splitter.IsHideButtonDown or f_TimerFloat.Enabled)
 else
 if f_AutoHideFloat then
  if not f_IsFloatingOnShow then
   f_TimerFloat.Enabled := False;
//#UC END# *52BD645E0355_52BAD1C40174_impl*
end;//TvtNavigatorPrim.AutoHideUpdate

procedure TvtNavigatorPrim.CloseDelay;
//#UC START# *52BD64760236_52BAD1C40174_var*
//#UC END# *52BD64760236_52BAD1C40174_var*
begin
//#UC START# *52BD64760236_52BAD1C40174_impl*
 f_TimerDelay.Enabled := False;
 f_IsDelay := False;
 f_DoDelay := False;
 AutoHideUpdate;
 f_DoDelay := True;
//#UC END# *52BD64760236_52BAD1C40174_impl*
end;//TvtNavigatorPrim.CloseDelay

procedure TvtNavigatorPrim.DelNavigator(P: TnpFloatingWindow);
//#UC START# *52BD64810357_52BAD1C40174_var*
var
 Index: Integer;
//#UC END# *52BD64810357_52BAD1C40174_var*
begin
//#UC START# *52BD64810357_52BAD1C40174_impl*
 Index := f_NavigatorList.IndexOf(P);
 if (Index <> -1) then
  f_NavigatorList.Delete(Index);
//#UC END# *52BD64810357_52BAD1C40174_impl*
end;//TvtNavigatorPrim.DelNavigator

function TvtNavigatorPrim.DockToFloatNavigator(aControl: TControl): TnpFloatingWindow;
 {* если клиент компонента не пристыкован ни к одному навигатору, то он автоматически пристыковывается к плавающему навигатору }
//#UC START# *52BD64B202A8_52BAD1C40174_var*
var
  lIsCreate: Boolean;

  procedure SetFloatingSize(aNavigator : TnpFloatingWindow;
                            aControl   : TControl);
  var
   l_Parent : TControl;
  begin//SetFloatingSize
   aNavigator.Width := aControl.Width;
   aNavigator.Height := aControl.Height;
   l_Parent := aControl.Parent;
   while True do
   begin
    if not Assigned(l_Parent) then
     Break;
    if (l_Parent is TnpFloatingWindow) then
    begin
     aNavigator.Width := l_Parent.Width;
     aNavigator.Height := l_Parent.Height;
     Break;
    end;//l_Parent is TnpFloatingWindow
    l_Parent := l_Parent.Parent;
   end;//while True
  end;//SetFloatingSize

  function CreateNavigator : TnpFloatingWindow;
  var
   l_Owner : TComponent;
   l_Rect  : TRect;
   {$IfDef Nemesis}
   l_ParentForm: TCustomForm;
   {$EndIf Nemesis}
  begin//CreateNavigator
   SetRectEmpty(l_Rect);
   if f_Float then
    l_Owner := f_FloatNavigator.Owner
   else
    l_Owner := Self;
   Result := GetFloatingWindowClass.CreateNew(l_Owner);
   Result.Navigator.AssignNav(Self);
   SetFloatingSize(Result, aControl);
   with Result.f_Navigator do
   begin
    f_SingleFloatNavigator := Self.f_SingleFloatNavigator;
    f_UnDockFromFloat := Self.f_UnDockFromFloat;
    f_Header.Size := Self.f_Header.Size;
   end;//with Result.f_Navigator
   { Зарегистрируем плаващий навигатор }
   if f_Float then
   begin
    f_NavigatorOnForm.AddNavigator(Result);
    Result.f_Navigator.NavigatorOnForm := f_NavigatorOnForm;
   end//f_Float
   else
   begin
    AddNavigator(Result);
    Result.f_Navigator.NavigatorOnForm := Self;
   end;//f_Float
   {$IfDef Nemesis}
   if (aControl is TvcmForm) then
   begin
    { Определим идентификатор навигатора }
    if (TvcmForm(aControl).FloatID > 0) and not f_Float then
     Result.FloatID := TvcmForm(aControl).FloatID
    else
     Result.FloatID := RandomRange(1, 1000);
    // если закладку отстыковали не перетаскиванием, а по DblClick-у или
    // программно, то восстанавливаем размер плавающей формы
    if not IsUndockByUser then
     l_Rect := TvcmForm(aControl).FloatWindowBounds;
   end;
   {$EndIf Nemesis}
   { Положение нового навигатора }
   if IsRectEmpty(l_Rect) then
    l_Rect := CalcNewFloatBounds;

   // Проверяем не вылазием ли мы за границы видимой рабочей области экрана
   // http://mdp.garant.ru/pages/viewpage.action?pageId=331187752
   l_Rect := vcmUtils.vcmCheckWindowBounds(l_Rect);

   Result.BoundsRect := l_Rect;
   { Не показываем если пристыковали невидимый объект (см. CMDockNotification) }
   {$IfDef Nemesis}
   l_ParentForm := GetParentForm(Self);
   if (aControl Is TvcmEntityForm) then
    Result.Visible := aControl.Visible and
                      TvcmEntityForm(aControl).FloatingVisible and
                      (l_ParentForm <> nil) and
                      l_ParentForm.Visible
    // - http://mdp.garant.ru/pages/viewpage.action?pageId=587161831
   else
   {$EndIf Nemesis}
    Result.Visible := aControl.Visible;
   (* устанавливаем здесь, потому, что vcl умничает и в процедуре SetVisible
    устанавливает окно там, где находится главное окно приложения, а мы хотим
    там где отпустил пользователь *)
   Result.BoundsRect := l_Rect;
   {$IfDef Nemesis}
    { Состояние навигатора }
    if not IsUndockByUser and ((TvcmForm(aControl).FloatWindowState and
      cFloatMinimized) = cFloatMinimized) then
     Result.State := fwsMinimized;
   {$EndIf Nemesis}
  end;//CreateNavigator

  function DockToExistsFloat(var aFindingWindow : TnpFloatingWindow) : Boolean;
  {$IfDef Nemesis}
  var
   l_Index : Integer;
   lFloat : TnpFloatingWindow;
  {$EndIf Nemesis}
  begin//DockToExistsFloat
   Result := False;
   {$IfDef Nemesis}
   if (aControl is TvcmForm) and (TvcmForm(aControl).FloatID > 0) then
   begin
    for l_Index := 0 to Pred(TnpNavigatorList.Instance.Count) do
    begin
     if TvtNavigator(TnpNavigatorList.Instance[l_Index]).Float then
     begin
      lFloat := TvtNavigator(TnpNavigatorList.Instance[l_Index]).f_FloatNavigator;
      if (lFloat.FloatID  = TvcmForm(aControl).FloatID) and
       // Т.к. регистрируются навигаторы для всех главных окон выбираем только
       // те, которые принадлежат форме, от которой отстыковываем
       (lFloat.Navigator.f_MainForm = f_ParentMainForm) then
      begin
       Result := True;
       aFindingWindow := lFloat;
       aControl.ManualDock(lFloat.Navigator.PageControl);
       Break;
      end;//lFloat.FloatID  = TvcmForm(aControl).FloatID..
     end;//TvtNavigator(TnpNavigatorList.Instance[l_Index]).Float
    end;//for l_Index
   end;//(aControl is TvcmForm) and (TvcmForm(aControl).FloatID > 0)
   {$EndIf Nemesis}
  end;//DockToExistsFloat
//#UC END# *52BD64B202A8_52BAD1C40174_var*
begin
//#UC START# *52BD64B202A8_52BAD1C40174_impl*
 Result := nil;
 lIsCreate := False;
 if (aControl <> nil) then
 begin
  { Компонент был вытащен из плавающего навигатора и ни к кому не пристыкован }
  if f_DockInSelf then
    aControl.ManualDock(f_PageControl)
  { Новый плавающий }
  else
  begin
   { Один плавающий на всех }
   if f_SingleFloatNavigator then
     Result := FindFloatNavigator
   else
   { Пристыковываем к навигатору по идентификатору }
// !! временно задействовал
// !! проблема: при переключении конфигураций, если в обеих есть плавающие навигаторы
// !! в DockToExistsFloat форма дочится к _старому_(!) плавающему навигатору, который умрёт,
// !! когда до него долетит CM_RELEASE (он и не умер-то до сих пор потому, что сообщение
// !! в очереди
//
// !! выключил - зацикливание в каком-то специфическом случае. Видимо, проблему пристыковки
// !! надо как-то по-другому решать.
//   afw.ProcessMessages;
   if not IsUndockByUser and DockToExistsFloat(Result) then
    Exit;
   if (Result = nil) then
   begin
    Result := CreateNavigator;
    lIsCreate := True;
   end;//Result = nil
   f_ClickOnTab := False;
   if f_Header.f_IsDragBegining then
   begin
    f_Header.f_IsDragBegining := False;
    Result.f_Navigator.MovePagesToNavigator(Self, aControl);
   end//f_Header.f_IsDragBegining
   else
   begin
    aControl.ManualDock(Result.Navigator.PageControl);
    {$IfDef Nemesis}
    if (aControl Is TvcmEntityForm) then
     TvcmEntityForm(aControl).CheckFloatingVisibility;
    {$EndIf Nemesis}
   end;//f_Header.f_IsDragBegining
   { Новый навигатор }
   if lIsCreate then
   begin
    with Result do
    begin
     Constraints.MinHeight := f_Navigator.pm_GetSizeMini + f_Navigator.f_Header.Height;
     Constraints.MinWidth := Constraints.MinHeight * 2;
     with f_Navigator.f_PageControl.Pages[0].Controls[0] do
     begin
      UndockWidth := Result.Width;
      UndockHeight := Result.Height;
     end;//with f_Navigator.f_PageControl.Pages[0].Controls[0]
    end;//with Result
   end;//lIsCreate
  end;//f_DockInSelf
 end;//aControl <> nil
//#UC END# *52BD64B202A8_52BAD1C40174_impl*
end;//TvtNavigatorPrim.DockToFloatNavigator

procedure TvtNavigatorPrim.Minimized;
//#UC START# *52BD64EC0294_52BAD1C40174_var*
//#UC END# *52BD64EC0294_52BAD1C40174_var*
begin
//#UC START# *52BD64EC0294_52BAD1C40174_impl*
 if not f_Float then
 begin
  f_HideDirect := hdNone;
  if f_State = nsMinimized then
   ModeHide
  else
   ModeNormalUpdate;
 end;//not f_Float
//#UC END# *52BD64EC0294_52BAD1C40174_impl*
end;//TvtNavigatorPrim.Minimized

procedure TvtNavigatorPrim.DoSaveSize;
//#UC START# *52BD64F60307_52BAD1C40174_var*
//#UC END# *52BD64F60307_52BAD1C40174_var*
begin
//#UC START# *52BD64F60307_52BAD1C40174_impl*
 if Assigned(f_OnSaveSize) then
  f_OnSaveSize(Self, f_SizeNormal);
//#UC END# *52BD64F60307_52BAD1C40174_impl*
end;//TvtNavigatorPrim.DoSaveSize

procedure TvtNavigatorPrim.DrawSplit(const aRect: TRect);
//#UC START# *52BD65070210_52BAD1C40174_var*
var
 l_DC            : HDC;
 l_OldBrush      : HBrush;
 l_DesktopHandle : HWND;
 l_Brush         : TBrush;
//#UC END# *52BD65070210_52BAD1C40174_var*
begin
//#UC START# *52BD65070210_52BAD1C40174_impl*
 l_DesktopHandle := GetDesktopWindow;
 l_DC := GetDCEx(l_DesktopHandle, 0, DCX_CACHE or DCX_LOCKWINDOWUPDATE);
 try
  l_Brush := TBrush.Create;
  try
   l_Brush.Bitmap := AllocPatternBitmap(clBlack, clWhite);
   l_OldBrush := SelectObject(l_DC, l_Brush.Handle);
   try
    with f_SplitterRect do
     PatBlt(l_DC, Left, Top, Right - Left, Bottom - Top, PATINVERT);
   finally
    SelectObject(l_DC, l_OldBrush);
   end;{try..finally}
  finally
   FreeAndNil(l_Brush);
  end;{try..finally}
 finally
  ReleaseDC(l_DesktopHandle, l_DC);
 end;{try..finally}
//#UC END# *52BD65070210_52BAD1C40174_impl*
end;//TvtNavigatorPrim.DrawSplit

procedure TvtNavigatorPrim.InitDockDrop;
//#UC START# *52BD653001BE_52BAD1C40174_var*
//#UC END# *52BD653001BE_52BAD1C40174_var*
begin
//#UC START# *52BD653001BE_52BAD1C40174_impl*
 if not f_IsInitDockDrop then
 begin
  f_Header.Visible := True;
  if not f_Float then
   ModeStateUpdate;
  f_IsInitDockDrop := True;
 end;
//#UC END# *52BD653001BE_52BAD1C40174_impl*
end;//TvtNavigatorPrim.InitDockDrop

procedure TvtNavigatorPrim.ModeAutoUpdate;
//#UC START# *52BD656B01FB_52BAD1C40174_var*
//#UC END# *52BD656B01FB_52BAD1C40174_var*
begin
//#UC START# *52BD656B01FB_52BAD1C40174_impl*
 if (f_State = nsAutoHide) then
 begin
  if (f_PageControl.DockClientCount = 0) then
  begin
   SetSizeMini;
   f_PageControl.Visible := False;
   f_Header.Visible := False;
  end//f_PageControl.DockClientCount = 0
  else
  if f_HideDirect = hdShow then
   ModeShow
  else
   ModeHide;
 end;//f_State = nsAutoHide
//#UC END# *52BD656B01FB_52BAD1C40174_impl*
end;//TvtNavigatorPrim.ModeAutoUpdate

procedure TvtNavigatorPrim.ModeHide;
//#UC START# *52BD6597029C_52BAD1C40174_var*
//#UC END# *52BD6597029C_52BAD1C40174_var*
begin
//#UC START# *52BD6597029C_52BAD1C40174_impl*
 UpdateSize;
//#UC END# *52BD6597029C_52BAD1C40174_impl*
end;//TvtNavigatorPrim.ModeHide

procedure TvtNavigatorPrim.ModeNormalUpdate;
//#UC START# *52BD65A40367_52BAD1C40174_var*
//#UC END# *52BD65A40367_52BAD1C40174_var*
begin
//#UC START# *52BD65A40367_52BAD1C40174_impl*
 if (f_PageControl.PageCount > 0) then
 begin
  if f_State = nsNormal then
  begin
   SetSelfSize(f_SizeNormal);
   f_PageControl.Visible := True;
   f_Header.Visible := True;
  end;
 end//f_PageControl.PageCount > 0
 else
 begin
  f_PageControl.Visible := False;
  f_Header.Visible := False;
  case Self.Align of
   alTop, alBottom:
    Self.Height := f_SizeEmpty;
   alLeft, alRight:
    Self.Width := f_SizeEmpty;
  end;//case Self.Align
 end;//f_PageControl.PageCount > 0
//#UC END# *52BD65A40367_52BAD1C40174_impl*
end;//TvtNavigatorPrim.ModeNormalUpdate

procedure TvtNavigatorPrim.ModeStateUpdate;
 {* скрывает (если ничего не пристыковано) / показывает PageControl }
//#UC START# *52BD65DF01E3_52BAD1C40174_var*
//#UC END# *52BD65DF01E3_52BAD1C40174_var*
begin
//#UC START# *52BD65DF01E3_52BAD1C40174_impl*
 case f_State of
  nsAutoHide:
   ModeAutoUpdate;
 else
  ModeNormalUpdate;
 end;//case f_State
//#UC END# *52BD65DF01E3_52BAD1C40174_impl*
end;//TvtNavigatorPrim.ModeStateUpdate

procedure TvtNavigatorPrim.ModeStateUpdateAfter;
 {* посылает сообщение CM_npAfterUndock }
//#UC START# *52BD661D0125_52BAD1C40174_var*
//#UC END# *52BD661D0125_52BAD1C40174_var*
begin
//#UC START# *52BD661D0125_52BAD1C40174_impl*
 PostMessage(Handle, CM_npAfterUndock, 0, 0);
//#UC END# *52BD661D0125_52BAD1C40174_impl*
end;//TvtNavigatorPrim.ModeStateUpdateAfter

procedure TvtNavigatorPrim.MovePagesToNavigator(var Value: TvtNavigatorPrim;
 DockControl: TControl);
//#UC START# *52BD665B0244_52BAD1C40174_var*
 procedure DoDockControl;
 begin//DoDockControl
  if DockControl <> nil then
  begin
   if DockControl is TForm then
     TForm(DockControl).OnEndDock := nil;
   DockControl.ManualDock(f_PageControl);
   SetUndockSize;
  end;//DockControl <> nil
 end;//DoDockControl

var
 Index, l_ImageIndex: Integer;
 l_DockControl: TControl;
//#UC END# *52BD665B0244_52BAD1C40174_var*
begin
//#UC START# *52BD665B0244_52BAD1C40174_impl*
 if (Value <> nil) then
 begin
  Value.f_PageControl.OnUnDock := nil;
  try
   { Установим TElCustomPageControl.Images }
   if f_PageControl.Images <> nil then
     Value.Images := f_PageControl.Images;
   { Переместим в "TElCustomPageControl приемник" DockControl который пользователь тащит.
     Это не делается в цикле потому что в этот момент закладки на которой он
     был расположен уже нет }
   DoDockControl;
   { Идем по закладкам из одного PageControl в другой }
   Index := Pred(Value.f_PageControl.PageCount);
   while (Index >= 0) do
   begin
    if (Value.f_PageControl.Pages[0].ControlCount > 0) then
     l_DockControl := Value.f_PageControl.Pages[0].Controls[0]
    else
     l_DockControl := nil;
    if (l_DockControl = nil) then
     Value.f_PageControl.RemovePage(Value.f_PageControl.Pages[0])
    else
    begin
     { Запомним ImageIndex }
     l_ImageIndex := Value.f_PageControl.Pages[0].ImageIndex;
     if l_DockControl is TForm then
       TForm(l_DockControl).OnEndDock := nil;
     l_DockControl.ManualDock(f_PageControl);
     { Установим ImageIndex }
     if l_DockControl.Parent is TElTabSheet then
      TElTabSheet(l_DockControl.Parent).ImageIndex := l_ImageIndex;
    end;//l_DockControl <> nil
    Dec(Index);
   end;//Index >= 0
   Value.SetUndockSize;
   { Установим активную закладку }
   if Value.f_ActiveControl <> nil then
    if Value.f_ActiveControl = DockControl then
     f_PageControl.ActivePage := TElTabSheet(DockControl.Parent)
    else
     for Index := 0 to Pred(f_PageControl.PageCount) do
      if f_PageControl.Pages[Index].Controls[0] = Value.f_ActiveControl then
      begin
       f_PageControl.ActivePage := f_PageControl.Pages[Index];
       Exit;
      end;
  finally
   Value.f_PageControl.OnUnDock := Value.OnPageControlUnDock;
   with Value do
   begin
    ModeStateUpdateAfter;
    Value.f_Header.Visible := False;
   end;
   f_Header.Visible := True;
   Value := nil;
  end;
 end//Value <> nil
 else
  DoDockControl;
 ModeNormalUpdate;
 {$IfDef Nemesis}
 if f_Float and
   (f_FloatNavigator <> nil) then
  f_FloatNavigator.Visible := True;
 {$EndIf Nemesis} 
//#UC END# *52BD665B0244_52BAD1C40174_impl*
end;//TvtNavigatorPrim.MovePagesToNavigator

procedure TvtNavigatorPrim.OpenDelay;
//#UC START# *52BD669D02AB_52BAD1C40174_var*
//#UC END# *52BD669D02AB_52BAD1C40174_var*
begin
//#UC START# *52BD669D02AB_52BAD1C40174_impl*
 f_IsDelay := True;
 if f_HideDirect = hdHide then
  f_TimerDelay.Interval := f_DelayIntervalOnShow
 else
  f_TimerDelay.Interval := f_DelayIntervalOnHide;
 f_TimerDelay.Enabled := True;
//#UC END# *52BD669D02AB_52BAD1C40174_impl*
end;//TvtNavigatorPrim.OpenDelay

procedure TvtNavigatorPrim.PaintSpliter(X: Integer;
 Y: Integer;
 aDrawSplitterType: TnpDrawSplitterTypes);
//#UC START# *52BD66F600F4_52BAD1C40174_var*
var
 l_Rect  : TRect;
 l_Point : TPoint;

  function lp_CalcSplitRect: TRect;
  var
   lPoint : TPoint;
  begin
   lPoint := ScreenToClient(Point(X, Y));
   if dstPaint in aDrawSplitterType then
    case Self.Align of
     alTop, alBottom:
      begin
       Result.Left := 0;
       Result.Right := Self.Width;
       Result.Top := lPoint.Y + cspSize div 2;
       Result.Bottom := Result.Top + cspSize;
      end;
     alLeft, alRight:
      begin
       Result.Left := lPoint.X + cspSize div 2;
       Result.Right := Result.Left + cspSize;
       Result.Top := 0;
       Result.Bottom := Self.Height;
      end;
    end;
  end;

 procedure lp_MinusPageSize;
 var
  l_Limit: Integer;
 begin
  { Установим ограничения }
  l_Limit := pm_GetSizeMini - cspSize;
  case Self.Align of
   alLeft: l_Rect.Left := l_Rect.Left + l_Limit;
   alRight: l_Rect.Right := l_Rect.Right - l_Limit;
   alTop: l_Rect.Top := l_Rect.Top + l_Limit;
   alBottom: l_Rect.Bottom := l_Rect.Bottom - l_Limit;
  end;//case Self.Align of
 end;//lp_CheckPageSize
//#UC END# *52BD66F600F4_52BAD1C40174_var*
begin
//#UC START# *52BD66F600F4_52BAD1C40174_impl*
 { Пересчитаем координаты навигатора в координаты родительского окна }
 l_Point := Parent.ScreenToClient(Point(X, Y));
 l_Rect := Parent.ClientRect;
 { Ограничения на изменение размера }
 if not (aDrawSplitterType = [dstErase]) then
  l_Rect := CorrectBounds(l_Rect);
 lp_MinusPageSize;
 if PtInRect(l_Rect, l_Point) then
 begin
  { Старый сплиттер }
  if dstErase in aDrawSplitterType then
   DrawSplit(f_SplitterRect);
  { Новый сплиттер }
  if dstPaint in aDrawSplitterType then
  begin
   l_Rect := lp_CalcSplitRect;
   l_Point.X := l_Rect.Left;
   l_Point.Y := l_Rect.Top;
   l_Point := Self.ClientToScreen(l_Point);
   f_SplitterRect := l_Rect;
   with f_SplitterRect do
   begin
    Right := l_Point.X + (Left - Right);
    Bottom := l_Point.Y + (Bottom - Top);
    Left := l_Point.X;
    Top := l_Point.Y;
   end;//with f_SplitterRect do
   DrawSplit(f_SplitterRect);
  end;//if dstPaint in aDrawSplitterType then
 end;//if PtInRect(l_Rect, l_Point) then
//#UC END# *52BD66F600F4_52BAD1C40174_impl*
end;//TvtNavigatorPrim.PaintSpliter

procedure TvtNavigatorPrim.OnEndDockControl(Sender: TObject;
 Target: TObject;
 X: Integer;
 Y: Integer);
//#UC START# *52BD6A4C0348_52BAD1C40174_var*
var
 Index: Integer;
 l_Control : TControl;
//#UC END# *52BD6A4C0348_52BAD1C40174_var*
begin
//#UC START# *52BD6A4C0348_52BAD1C40174_impl*
 if (f_ExportPageControl <> nil) then
 begin
  f_PageControl.OnUnDock := nil;
  for Index := Pred(f_PageControl.PageCount) downto 0 do
  begin
   l_Control := f_PageControl.Pages[Index].Controls[0];
   if l_Control is TForm then
    TForm(l_Control).OnEndDock := nil;
   l_Control.ManualDock(f_ExportPageControl);
  end;//for Index
  f_ExportPageControl := nil;
 end//f_ExportPageControl <> nil
 else
 if (f_Header.f_IsDragBegining) or
    (f_Float and (f_PageControl.PageCount = 1)) then
 begin
  with f_FloatNavigator do
  begin
   // Установим новую позицию окна
   BoundsRect := CalcNewFloatBounds;
   {$IfDef Nemesis}
   // Обновим информацию о положении окна у TvcmForm`s
   UpdateFloatWindowsBounds;
   {$EndIf Nemesis}
  end;//with f_FloatNavigator
  f_Header.f_IsDragBegining := False;
 end;//(f_Header.f_IsDragBegining) or (f_Float and (f_PageControl.PageCount = 1))
 TForm(f_EndDockClient).OnEndDock := nil;
//#UC END# *52BD6A4C0348_52BAD1C40174_impl*
end;//TvtNavigatorPrim.OnEndDockControl

procedure TvtNavigatorPrim.OnTabSheetClick(Sender: TObject;
 Page: TElTabSheet);
//#UC START# *52BD6A7F0011_52BAD1C40174_var*
//#UC END# *52BD6A7F0011_52BAD1C40174_var*
begin
//#UC START# *52BD6A7F0011_52BAD1C40174_impl*
 f_ClickOnTab := True;
 f_Header.f_IsDragBegining := False;
 if f_State = nsMinimized then
  State := nsNormal;
 if (Page.ControlCount > 0) then
 begin
  InitDrag(Page.Controls[0]);
  if not Mouse.IsDragging then
   Page.Controls[0].BeginDrag(False);
 end;//Page.ControlCount > 0
//#UC END# *52BD6A7F0011_52BAD1C40174_impl*
end;//TvtNavigatorPrim.OnTabSheetClick

procedure TvtNavigatorPrim.OnHide(Sender: TObject);
//#UC START# *52BD6A960020_52BAD1C40174_var*
//#UC END# *52BD6A960020_52BAD1C40174_var*
begin
//#UC START# *52BD6A960020_52BAD1C40174_impl*
 if State = nsMinimized then
  State := nsNormal
 else
  State := nsMinimized;
//#UC END# *52BD6A960020_52BAD1C40174_impl*
end;//TvtNavigatorPrim.OnHide

procedure TvtNavigatorPrim.OnAutoHide(Sender: TObject);
//#UC START# *52BD6AC300B2_52BAD1C40174_var*
//#UC END# *52BD6AC300B2_52BAD1C40174_var*
begin
//#UC START# *52BD6AC300B2_52BAD1C40174_impl*
 if State = nsAutoHide then
  State := nsNormal
 else
  State := nsAutoHide;
//#UC END# *52BD6AC300B2_52BAD1C40174_impl*
end;//TvtNavigatorPrim.OnAutoHide

procedure TvtNavigatorPrim.OnPageControlResize(Sender: TObject);
//#UC START# *52BD6B500014_52BAD1C40174_var*
//#UC END# *52BD6B500014_52BAD1C40174_var*
begin
//#UC START# *52BD6B500014_52BAD1C40174_impl*
 SetUndockSize;
//#UC END# *52BD6B500014_52BAD1C40174_impl*
end;//TvtNavigatorPrim.OnPageControlResize

procedure TvtNavigatorPrim.OnPageControlChange(Sender: TObject);
//#UC START# *52BD6B6801D6_52BAD1C40174_var*
var
 l_Size : Integer;
//#UC END# *52BD6B6801D6_52BAD1C40174_var*
begin
//#UC START# *52BD6B6801D6_52BAD1C40174_impl*
 if (f_PageControl.PageCount = 0) then
 begin
  f_PageControl.Visible := False; // костыль для http://mdp.garant.ru/pages/viewpage.action?pageId=324009991
                                  // http://mdp.garant.ru/pages/viewpage.action?pageId=324009991&focusedCommentId=330141913
  if f_Float then
   f_FloatNavigator.Close
  else
  begin
   (* запомним текущий нормальный размер *)
   l_Size := f_Surface.Size;
   // Устанавливаем только для нормального размера
   if f_State = nsNormal then
    f_SizeNormal := l_Size;
   (* сохраним размер *)
   DoSaveSize;
   pm_SetSizeEmpty(f_SizeEmpty);
  end;//f_Float
 end//f_PageControl.PageCount = 0
 else
  f_Header.Invalidate;
 UpdateCloseButton;
 DoStateChanged;
//#UC END# *52BD6B6801D6_52BAD1C40174_impl*
end;//TvtNavigatorPrim.OnPageControlChange

procedure TvtNavigatorPrim.OnTimerFloat(Sender: TObject);
//#UC START# *52BD6B710302_52BAD1C40174_var*
const
 clDelta = 30;
var
 lDelta  : Integer;
 lDist   : Integer;
 lLimit  : Integer;
 lIsExit : Boolean;
 lBounds : TRect;
//#UC END# *52BD6B710302_52BAD1C40174_var*
begin
//#UC START# *52BD6B710302_52BAD1C40174_impl*
 lIsExit := False;
 // Определим приращение
 if (f_HideDirect = hdHide) then
 begin
  lDelta := -clDelta;
  lDist := -clDelta;
  lLimit := SizeMini;
 end//f_HideDirect = hdHide
 else
 begin
  lDelta := clDelta;
  lDist := clDelta;
  lLimit := f_SizeNormal;
 end;//f_HideDirect = hdHide
 // Текущие размеры
 lBounds := f_Surface.BoundsRect;
 // Опредим не достигли ли мы пределного сворачивания/разворачивания
 case Align of
  alLeft, alRight:
   if f_HideDirect = hdHide then
    lIsExit := (f_Surface.Width + lDist <= lLimit) or
     (f_Surface.Width + lDelta < lLimit)
   else
    lIsExit := (f_Surface.Width + lDist >= lLimit) or
     (f_Surface.Width + lDelta > lLimit);
  alTop, alBottom:
   if f_HideDirect = hdHide then
    lIsExit := (f_Surface.Height + lDist <= lLimit)  or
     (f_Surface.Height + lDelta < lLimit)
   else
    lIsExit := (f_Surface.Height + lDist >= lLimit)  or
     (f_Surface.Height + lDelta > lLimit);
 end;//case Align
 // Устновим новый размер
 case Align of
  alLeft:
   with lBounds do
   begin
    if lIsExit then
     Right := Left + lLimit
    else
     Inc(Right, lDelta);
   end;
  alRight:
   with lBounds do
    if lIsExit then
     Left := Right - lLimit
    else
     Dec(Left, lDelta);
  alTop:
   with lBounds do
    if lIsExit then
     Bottom := Top + lLimit
    else
     Inc(Bottom, lDelta);
  alBottom:
   with lBounds do
    if lIsExit then
     Top := Bottom - lLimit
    else
     Inc(Top, lDelta);
 end;//case Align
 // Устновим новые размеры
 Windows.SetWindowPos(f_Surface.Handle, 0, lBounds.Left, lBounds.Top,
  lBounds.Right - lBounds.Left, lBounds.Bottom - lBounds.Top, SWP_NOACTIVATE or
   SWP_NOZORDER);
//#UC END# *52BD6B710302_52BAD1C40174_impl*
end;//TvtNavigatorPrim.OnTimerFloat

procedure TvtNavigatorPrim.OnTimerDelay(Sender: TObject);
//#UC START# *52BD6B7E0075_52BAD1C40174_var*
//#UC END# *52BD6B7E0075_52BAD1C40174_var*
begin
//#UC START# *52BD6B7E0075_52BAD1C40174_impl*
 CloseDelay;
//#UC END# *52BD6B7E0075_52BAD1C40174_impl*
end;//TvtNavigatorPrim.OnTimerDelay

procedure TvtNavigatorPrim.OnPageControlUnDock(Sender: TObject;
 Client: TControl;
 NewTarget: TWinControl;
 var Allow: Boolean);
//#UC START# *52BD6BDB0195_52BAD1C40174_var*
 procedure SetEndDockProcedure;
 begin//SetEndDockProcedure
  if (Client is TForm) then
  begin
   TForm(Client).OnEndDock := OnEndDockControl;
   f_EndDockClient := Client;
  end;//Client is TForm
 end;//SetEndDockProcedure
//#UC END# *52BD6BDB0195_52BAD1C40174_var*
begin
//#UC START# *52BD6BDB0195_52BAD1C40174_impl*
 SetUndockSize;
 if (NewTarget <> Self) then
 begin
  { Импортируем в PageControl }
  if Allow and (NewTarget <> nil) and f_Header.f_IsDragBegining and
   (NewTarget is TnpPageControl) then
  begin
   f_ExportPageControl := NewTarget as TnpPageControl;
   SetEndDockProcedure;
   ResetDragInfo;
   Allow := False;
  end;//Allow and (NewTarget <> nil) and f_Header.f_IsDragBegining
  if Allow then
  begin
   if f_Float then
    Allow := (NewTarget <> nil) or ((f_PageControl.PageCount > 1) and
     f_UnDockFromFloat and
     not f_SingleFloatNavigator and not f_Header.f_IsDragBegining);
   if Allow then
   begin
    if not f_Float then
     ModeStateUpdateAfter;
    f_DockInSelf := False;
    if (f_PageControl.PageCount = 1) then
    begin
     if f_Float then
     begin
      if NewTarget <> nil then
       f_FloatNavigator.Close
      else
       if not f_UnDockFromFloat then
        f_DockInSelf := True;
     end;//f_Float
    end//f_PageControl.PageCount = 1
    { NewTarget - используя f_ImportNavigator  примет все закладки текущего навигатора }
    else
    if (NewTarget <> nil) and (NewTarget is TvtNavigator) and
      f_Header.f_IsDragBegining then
     TvtNavigator(NewTarget).f_ImportNavigator := Self;
    { Клиент ни к кому не пристыкован }
    if NewTarget = nil then
     if Client is TForm then
     begin
      Allow := False;
      PostMessage(Handle, CM_npDockToFloatWindow, Integer(Client), 0);
     end;//if Client is TForm then
   end;//if Allow then
  end;
  if not Allow then
   if f_Float then
    if Client is TForm then
     SetEndDockProcedure;
 end//NewTarget <> Self
 else
  Allow := False;
 if Allow then
  ResetDragInfo;
//#UC END# *52BD6BDB0195_52BAD1C40174_impl*
end;//TvtNavigatorPrim.OnPageControlUnDock

procedure TvtNavigatorPrim.OnStartDragControl(Sender: TObject;
 aDragControl: TControl);
//#UC START# *52BD6C000396_52BAD1C40174_var*
//#UC END# *52BD6C000396_52BAD1C40174_var*
begin
//#UC START# *52BD6C000396_52BAD1C40174_impl*
 if (aDragControl is TForm) then
 begin
  TForm(aDragControl).OnEndDock := OnEndDockControl;
  f_EndDockClient := aDragControl;
 end;//aDragControl is TForm
//#UC END# *52BD6C000396_52BAD1C40174_impl*
end;//TvtNavigatorPrim.OnStartDragControl

{$If Defined(Nemesis)}
procedure TvtNavigatorPrim.OnFormPositionDockRect(Sender: TObject;
 DragDockObject: TDragDockObject);
//#UC START# *52BD6C1F0372_52BAD1C40174_var*
//#UC END# *52BD6C1F0372_52BAD1C40174_var*
begin
//#UC START# *52BD6C1F0372_52BAD1C40174_impl*
 if (DragDockObject.DragTarget = nil) then
  DragDockObject.DockRect := CalcNewFloatBounds;
//#UC END# *52BD6C1F0372_52BAD1C40174_impl*
end;//TvtNavigatorPrim.OnFormPositionDockRect
{$IfEnd} // Defined(Nemesis)

procedure TvtNavigatorPrim.SetSelfSize(aSize: Integer);
//#UC START# *52BD6DC7031F_52BAD1C40174_var*
//#UC END# *52BD6DC7031F_52BAD1C40174_var*
begin
//#UC START# *52BD6DC7031F_52BAD1C40174_impl*
 case Self.Align of
  alTop, alBottom: Self.Height := aSize;
  alLeft, alRight: Self.Width := aSize;
 end;
//#UC END# *52BD6DC7031F_52BAD1C40174_impl*
end;//TvtNavigatorPrim.SetSelfSize

procedure TvtNavigatorPrim.DoSplit;
//#UC START# *52BD6DE601F7_52BAD1C40174_var*
 function lp_CalcPoint: TPoint;

  procedure lp_OffsetPoint(var aPoint: TPoint);
  var
   l_AddSize: Integer;
  begin
   // Размер сплиттера:
   case Align of
    alLeft, alRight: l_AddSize := f_Surface.f_Splitter.Width;
    alTop, alBottom: l_AddSize := f_Surface.f_Splitter.Height;
   else
    l_AddSize := 0;
   end;//case Align of
   // Увеличим размер:
   if l_AddSize > 0 then
   begin
    l_AddSize := l_AddSize div 2;
    case Align of
     alLeft, alRight: Inc(aPoint.X, l_AddSize);
     alTop, alBottom: Inc(aPoint.Y, l_AddSize);
    end;//case Align of
   end;//if l_AddSize > 0 then
  end;//lp_OffsetPoint

  procedure lp_CorrentPoint(var aPoint: TPoint);
  var
   l_SizeMini   : Integer;
   l_ParentRect : TRect;
  begin
   l_SizeMini := pm_GetSizeMini + 4;
   l_ParentRect := Parent.ClientRect;
   // Право
   if aPoint.X > (l_ParentRect.Right - l_SizeMini) then
    aPoint.X := l_ParentRect.Right - l_SizeMini
   else
    // Лево
    if aPoint.X < l_ParentRect.Left + l_SizeMini then
     aPoint.X := l_ParentRect.Left + l_SizeMini;
   // Верх
   if aPoint.Y < l_ParentRect.Top + l_SizeMini then
    aPoint.Y := l_ParentRect.Top + l_SizeMini
   else
    // Низ
    if aPoint.Y > (l_ParentRect.Bottom - l_SizeMini) then
     aPoint.Y := l_ParentRect.Bottom - l_SizeMini;
  end;//lp_CorrentPoint

 begin
  // Получим точку отпускания:
  Result := Parent.ScreenToClient(Mouse.CursorPos);
  // Откорретируем, чтобы она не была меньше минимальных размеров:
  lp_CorrentPoint(Result);
  // Определим размер навигатора таким образом, чтобы после применения новых
  // размеров курсор мыши располагался по середине сплиттера:
  lp_OffsetPoint(Result);
 end;//lp_CalcPoint

 function lp_CalcSize(const aPoint: TPoint): Integer;
 var
  l_NewBounds: TRect;
 begin
  Result := 0;
  l_NewBounds := CorrectBounds(GetNewBoundsFromPoint(aPoint.X, aPoint.Y));
  with l_NewBounds do
   case Align of
    alLeft, alRight:
     Result := Right - Left;
    alTop, alBottom:
     Result := Bottom - Top;
   end;//case Self.Align of
 end;//lp_CalcSize

 procedure lp_ApplyNewSize(const aSize: Integer);
 begin
  // Минимизируем навигатор, если ширину установили меньше допустимой:
  if aSize < cMinNormalSize then
   State := nsMinimized
  else
  // Установим новый размер:
  begin
   f_SizeNormal := aSize;
   if IsMinimized then
    State := nsNormal
   else
    if f_State <> nsMinimized then
     pm_SetSizeNormal(f_SizeNormal);
  end;//if l_NewSize < cMinNormalSize then
 end;//lp_ApplyNewSize
//#UC END# *52BD6DE601F7_52BAD1C40174_var*
begin
//#UC START# *52BD6DE601F7_52BAD1C40174_impl*
  // 1 - определим точку отпускания;
  // 2 - расчитаем новый размер;
  // 3 - применим новые размеры;
 lp_ApplyNewSize(lp_CalcSize(lp_CalcPoint));
//#UC END# *52BD6DE601F7_52BAD1C40174_impl*
end;//TvtNavigatorPrim.DoSplit

procedure TvtNavigatorPrim.SetUndockSize;
//#UC START# *52BD6E0B0379_52BAD1C40174_var*
var
 l_Index: Integer;
//#UC END# *52BD6E0B0379_52BAD1C40174_var*
begin
//#UC START# *52BD6E0B0379_52BAD1C40174_impl*
 for l_Index := 0 to f_PageControl.PageCount - 1 do
 begin
  with f_PageControl.Pages[l_Index] do
  begin
   if (ControlCount > 0) then
    if f_Float then
    begin
     Controls[0].UndockHeight := Self.Height;
     Controls[0].UndockWidth := Self.Width;
    end//f_Float
    else
    begin
     Controls[0].UndockHeight := f_PageControl.Height;
     Controls[0].UndockWidth := f_PageControl.Width;
    end;//f_Float
  end;//with f_PageControl.Pages[l_Index]
 end;//for l_Index
//#UC END# *52BD6E0B0379_52BAD1C40174_impl*
end;//TvtNavigatorPrim.SetUndockSize

function TvtNavigatorPrim.GetNavigatorSizeNormal(aControl: TControl): Integer;
//#UC START# *52BD6E53030E_52BAD1C40174_var*
var
 l_Parent     : TWinControl;
 l_Navigator  : TvtNavigator;
 l_SizeNormal : Integer;
//#UC END# *52BD6E53030E_52BAD1C40174_var*
begin
//#UC START# *52BD6E53030E_52BAD1C40174_impl*
 if (f_PageControl.PageCount <> 0) then
  Result := f_SizeNormal
 else
 begin
  l_SizeNormal := DoLoadSize;
  if l_SizeNormal > 0 then
   Result := l_SizeNormal
  else
   Result := aControl.Width;
  l_Parent := aControl.Parent;
  while True do
  begin
   if not Assigned(l_Parent) then
    Break;
   if l_Parent is TElCustomPageControl then
   begin
    l_Navigator := TvtNavigator(l_Parent.Owner);
    Result := l_Navigator.SizeNormal;
    Break;
   end;
   l_Parent := l_Parent.Parent;
  end;
 end;
//#UC END# *52BD6E53030E_52BAD1C40174_impl*
end;//TvtNavigatorPrim.GetNavigatorSizeNormal

function TvtNavigatorPrim.GetDockRect(aDockSize: Integer = -1): TRect;
//#UC START# *52BD6E7A02BA_52BAD1C40174_var*
const
 cDockSize = 50;
//#UC END# *52BD6E7A02BA_52BAD1C40174_var*
begin
//#UC START# *52BD6E7A02BA_52BAD1C40174_impl*
 if aDockSize = -1 then
  aDockSize := cDockSize;
 GetWindowRect(Self.Handle, Result);
 { Область докинга }
 case Self.Align of
  alBottom:
   with Result do
    Top := Bottom - aDockSize;
  alTop:
   with Result do
    Bottom := Top + aDockSize;
  alLeft:
   with Result do
    Right := Left + aDockSize;
  alRight:
   with Result do
    Left := Right - aDockSize;
 end;//case Self.Align
//#UC END# *52BD6E7A02BA_52BAD1C40174_impl*
end;//TvtNavigatorPrim.GetDockRect

procedure TvtNavigatorPrim.DoStateChanged(aNavigatorState: Boolean = False);
//#UC START# *52BD6EAC0226_52BAD1C40174_var*
var
 l_Index : Integer;
//#UC END# *52BD6EAC0226_52BAD1C40174_var*
begin
//#UC START# *52BD6EAC0226_52BAD1C40174_impl*
 (* ChangeLinks  *)
 for l_Index := 0 to Pred(f_ChangeLinks.Count) do
  with TnpChangeLink(f_ChangeLinks[l_Index]) do
   if Assigned(OnStateChanged) then
    OnStateChanged(Self);
 if aNavigatorState and Assigned(f_OnStateChange) then
  f_OnStateChange(Self);
//#UC END# *52BD6EAC0226_52BAD1C40174_impl*
end;//TvtNavigatorPrim.DoStateChanged

function TvtNavigatorPrim.GetPageControlClass: RnpPageControl;
//#UC START# *52BD6ECD0365_52BAD1C40174_var*
//#UC END# *52BD6ECD0365_52BAD1C40174_var*
begin
//#UC START# *52BD6ECD0365_52BAD1C40174_impl*
 Result := TnpPageControl;
//#UC END# *52BD6ECD0365_52BAD1C40174_impl*
end;//TvtNavigatorPrim.GetPageControlClass

function TvtNavigatorPrim.GetFloatingWindowClass: RnpFloatingWindow;
//#UC START# *52BD6EE2010C_52BAD1C40174_var*
//#UC END# *52BD6EE2010C_52BAD1C40174_var*
begin
//#UC START# *52BD6EE2010C_52BAD1C40174_impl*
 Result := TnpFloatingWindow;
//#UC END# *52BD6EE2010C_52BAD1C40174_impl*
end;//TvtNavigatorPrim.GetFloatingWindowClass

procedure TvtNavigatorPrim.RegisterStateChanged(aLink: TnpChangeLink);
 {* подписать клиента на нотификацию об изменении состояния навигатора }
//#UC START# *52BD6F1D0237_52BAD1C40174_var*
//#UC END# *52BD6F1D0237_52BAD1C40174_var*
begin
//#UC START# *52BD6F1D0237_52BAD1C40174_impl*
 if (f_ChangeLinks = nil) then 
  Exit;
 if f_ChangeLinks.IndexOf(aLink) = -1 then
  f_ChangeLinks.Add(aLink);
//#UC END# *52BD6F1D0237_52BAD1C40174_impl*
end;//TvtNavigatorPrim.RegisterStateChanged

procedure TvtNavigatorPrim.UnRegisterStateChanged(aLink: TnpChangeLink);
 {* отписать клиента от нотификации об изменении состояния навигатора }
//#UC START# *52BD6F4901D6_52BAD1C40174_var*
var
 l_Index : Integer;
//#UC END# *52BD6F4901D6_52BAD1C40174_var*
begin
//#UC START# *52BD6F4901D6_52BAD1C40174_impl*
 if (f_ChangeLinks = nil) then
  Exit;
 l_Index := f_ChangeLinks.IndexOf(aLink);
 if l_Index <> -1 then
  f_ChangeLinks.Delete(l_Index);
//#UC END# *52BD6F4901D6_52BAD1C40174_impl*
end;//TvtNavigatorPrim.UnRegisterStateChanged

function TvtNavigatorPrim.IsActiveControl(aControl: TControl): Boolean;
//#UC START# *52BD6F8E02BA_52BAD1C40174_var*
//#UC END# *52BD6F8E02BA_52BAD1C40174_var*
begin
//#UC START# *52BD6F8E02BA_52BAD1C40174_impl*
 Result := False;
 if Assigned(f_PageControl) then
  Result := f_PageControl.IsActiveControl(aControl);
//#UC END# *52BD6F8E02BA_52BAD1C40174_impl*
end;//TvtNavigatorPrim.IsActiveControl

function TvtNavigatorPrim.MinBtnHint: AnsiString;
//#UC START# *52BD6FBC0045_52BAD1C40174_var*
//#UC END# *52BD6FBC0045_52BAD1C40174_var*
begin
//#UC START# *52BD6FBC0045_52BAD1C40174_impl*
 Result := f_Header.HideButton.MakeHint;
//#UC END# *52BD6FBC0045_52BAD1C40174_impl*
end;//TvtNavigatorPrim.MinBtnHint

procedure TvtNavigatorPrim.AssignNav(aDest: TvtNavigatorPrim);
//#UC START# *52BD70000390_52BAD1C40174_var*
//#UC END# *52BD70000390_52BAD1C40174_var*
begin
//#UC START# *52BD70000390_52BAD1C40174_impl*
 ButtonsImageList := aDest.ButtonsImageList;
 AutoHideOffImage := aDest.AutoHideOffImage;
 AutoHideOnImage := aDest.AutoHideOnImage;
 CloseImage := aDest.CloseImage;
 HideDownImage := aDest.HideDownImage;
 HideLeftImage := aDest.HideLeftImage;
 HideRightImage := aDest.HideRightImage;
 HideUpImage := aDest.HideUpImage;
 CloseHint := aDest.CloseHint;
 AutoHideOffHint := aDest.AutoHideOffHint;
 AutoHideOnHint := aDest.AutoHideOnHint;
 MinimizedOffHint := aDest.MinimizedOffHint;
 MinimizedOnHint := aDest.MinimizedOnHint;
//#UC END# *52BD70000390_52BAD1C40174_impl*
end;//TvtNavigatorPrim.AssignNav

procedure TvtNavigatorPrim.hCBT(Code: Integer;
 WParam: WPARAM;
 LParam: LPARAM);
 {* сообщение получаемое от WH_CBT }
//#UC START# *52BD705202C5_52BAD1C40174_var*
//#UC END# *52BD705202C5_52BAD1C40174_var*
begin
//#UC START# *52BD705202C5_52BAD1C40174_impl*
 case Code of
  HCBT_MINMAX:
   if Assigned(f_MainForm) and f_MainForm.HandleAllocated then
    if (THandle(WParam) = f_MainForm.Handle) then
     // Чтобы у двух окон при минимизации не оставались плавающие навигаторы
     if ((LoWord(LParam) and SW_MINIMIZE) = SW_MINIMIZE) then
     begin
      Activate := False;
      f_FormWasMinimized := True;
     end
     else
      if ((LoWord(LParam) and SW_RESTORE) = SW_RESTORE) then
       f_ParentRestore := True;
 end;//case Code of
//#UC END# *52BD705202C5_52BAD1C40174_impl*
end;//TvtNavigatorPrim.hCBT

procedure TvtNavigatorPrim.hGetMessage(aMessage: PMsg);
//#UC START# *52BD70850139_52BAD1C40174_var*

 function lpIsDropDown(aWnd : THandle) : Boolean;
 var
  lControl    : TWinControl;
  lDropWindow : IafwDropDownWindow;
 begin
  Result := False;
  lControl := FindControl(aWnd);
  if Assigned(lControl) then
   if Supports(lControl, IafwDropDownWindow, lDropWindow) then
   try
    Result := True;
   finally
    lDropWindow := nil;
   end
   else
    Result := not Assigned(lControl.Parent) and not Assigned(lControl.Owner);
 end;

 procedure lp_CorrectSize;
 begin
  // При восстановлении формы, откорректируем размер навигаторов
  with CorrectBounds(CalcBounds(SizeNormal)) do
   case Self.Align of
    alLeft, alRight:
     if Right - Left <> f_SizeNormal then
      SizeNormal := Right - Left;
    alBottom, alTop:
     if Bottom - Top <> f_SizeNormal then
      SizeNormal := Bottom - Top;
   end;//case Self.Align of
 end;//lp_CorrectSize

 function CheckWindowUnderCursor: Boolean;
 var
  l_CurPos: TPoint;
  l_Window: THandle;
  l_Class: string;
  l_ClassLen: Integer;
 begin // http://mdp.garant.ru/pages/viewpage.action?pageId=296095220
  if GetCursorPos(l_CurPos) then
  begin
   l_Window := WindowFromPoint(l_CurPos);
   Result := (not Tl3PopupControlService.Instance.IsPopupControlWindow(l_Window));
  end //GetCursorPos
  else
   Result := False;
 end; //CheckWindowUnderCursor

var
 lIsAct   : Boolean;
 lActWnd  : THandle;
 l_Activate: Boolean;
//#UC END# *52BD70850139_52BAD1C40174_var*
begin
//#UC START# *52BD70850139_52BAD1C40174_impl*
 if csDestroying in ComponentState then
  Exit;
 case aMessage.message of
  WM_MOUSEMOVE:
   if (f_State = nsAutoHide) and CheckWindowUnderCursor then
    AutoHideUpdate;
  WM_SIZE:
  begin
   (* Изменился размер родительского окна, изменим размер плавающего навигатора *)
   if Assigned(Parent) and Parent.HandleAllocated and
    (aMessage.hwnd = Parent.Handle) then
   begin
    if (f_State = nsAutoHide) then
     Resize;
    // Если форму минимизировали, то ничего не делаем
    if ((not f_Float) and (not f_FormWasMinimized))
     {$IfDef Nemesis}
      and ((LoWord(aMessage^.LParam) <> Parent.ClientWidth) or
       (HiWord(aMessage^.LParam) <> Parent.Clientheight))
     {$EndIf Nemesis} then
      // - http://mdp.garant.ru/pages/viewpage.action?pageId=564993305
    begin
     if f_ParentRestore then
      f_ParentRestore := False;
     lp_CorrectSize;
    end;
    // Форму разворачивают после минимизации
    if f_FormWasMinimized and f_ParentRestore then
    begin
     f_FormWasMinimized := False;
     f_ParentRestore := False;
    end;//if f_FormWasMinimized and f_ParentRestore then
   end;//if Assigned(Parent)
  end;//WM_SIZE
  WM_ACTIVATE:
  begin
   (* Минимизировать главное окно *)
   if {$IfDef Nemesis}(not f_MainForm.HandleAllocated) or{$EndIf Nemesis}
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=573672384
     ((f_MainForm.Handle = THandle(aMessage.hwnd)) and
     Boolean(HiWord(aMessage.wParam))) then
    Activate := False
   (* Какое-то окно получило фокус, если окно, которое принадлежит главной
      форме, то активируем, в противном случае деактивируем *)
   else
   begin
    lIsAct := LoWord(aMessage.WParam) <> WA_INACTIVE;
    if lIsAct then
    begin
     lActWnd := aMessage.hwnd;
     if lpIsDropDown(lActWnd) then
      Exit;
     (* Показали модальную форму, прячем навигатор и выходим *)
     if npIsModalForm(lActWnd) then
     begin
      DoActivate(False);
      Exit;
     end;
     (* Активировали плавающую форму *)
     if not npIsInFloatNavigator(lActWnd) and npIsFloatingForm(lActWnd) then
     begin
      DoActivate(True);
      Exit;
     end;
    end
    else
    begin
    (* Окну aMessage.hwnd пришло сообщение о деактивации, handle активированного
       окна содержится в THandle(aMessage.lParam). Если окно принадлежит
       главному окну навигатора ничего не делаем или активируем, в противном
       случае спрячем *)
     lActWnd := THandle(aMessage.lParam);
     (* Информацию о деактивации нет смысла обрабатывать если фокус не ушел на
        рабочий стол, потому что когда придет, через HOOK сообщение об активации
        окна, то мы спрячем навигаторы если активировалось окно другой главной
        формы, или совсем чужое окно *)
     if  lActWnd <> HWND_DESKTOP then
      Exit;
    end;
    (* Изменим состояние *)
    l_Activate := npGetActivationValue(Self, f_MainForm, lActWnd);
    // - http://mdp.garant.ru/pages/viewpage.action?pageId=570120392
    DoActivate(l_Activate);
   end;
  end;
 end;
//#UC END# *52BD70850139_52BAD1C40174_impl*
end;//TvtNavigatorPrim.hGetMessage

procedure TvtNavigatorPrim.NormalUpdateSize;
//#UC START# *52CECF5600E7_52BAD1C40174_var*
//#UC END# *52CECF5600E7_52BAD1C40174_var*
begin
//#UC START# *52CECF5600E7_52BAD1C40174_impl*
 case f_State of
  nsMinimized: SetSelfSize(SizeMini);
  nsNormal: SetSelfSize(SizeNormal);
 end;//case f_State
//#UC END# *52CECF5600E7_52BAD1C40174_impl*
end;//TvtNavigatorPrim.NormalUpdateSize

procedure TvtNavigatorPrim.ModeShow;
//#UC START# *52CFCE2D03DE_52BAD1C40174_var*
//#UC END# *52CFCE2D03DE_52BAD1C40174_var*
begin
//#UC START# *52CFCE2D03DE_52BAD1C40174_impl*
 UpdateSize;
//#UC END# *52CFCE2D03DE_52BAD1C40174_impl*
end;//TvtNavigatorPrim.ModeShow

procedure TvtNavigatorPrim.UpdateMainForm(aNewMainForm: TCustomForm);
//#UC START# *54102F6E00A4_52BAD1C40174_var*
//#UC END# *54102F6E00A4_52BAD1C40174_var*
begin
//#UC START# *54102F6E00A4_52BAD1C40174_impl*
 f_MainForm := aNewMainForm;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=564993305
//#UC END# *54102F6E00A4_52BAD1C40174_impl*
end;//TvtNavigatorPrim.UpdateMainForm

procedure TvtNavigatorPrim.DoActivate(aActive: Boolean);
//#UC START# *5448CCD000FF_52BAD1C40174_var*
//#UC END# *5448CCD000FF_52BAD1C40174_var*
begin
//#UC START# *5448CCD000FF_52BAD1C40174_impl*
 (* Иначе при активизации приложения по заголовку окна окно навигатора могло
    находится под главным, кроме того наблюдались мерцания (показывали,
    скрывали, показывали) *)
 PostMessage(Handle, CM_npChangeActivate, Integer(aActive), 0);
//#UC END# *5448CCD000FF_52BAD1C40174_impl*
end;//TvtNavigatorPrim.DoActivate

procedure TvtNavigatorPrim.CMnpChangeActivate(var Message: TMessage);
//#UC START# *52BAD30B01CD_52BAD1C40174_var*
var
 l_Activate : Boolean;
//#UC END# *52BAD30B01CD_52BAD1C40174_var*
begin
//#UC START# *52BAD30B01CD_52BAD1C40174_impl*
 l_Activate := Boolean(Message.WParam);
 if l_Activate then
 begin
  if {$If defined(Nemesis) AND not defined(NoVCM)} f_PageDeactivated or {$IfEnd}
    ((f_FloatNavigator <> nil) AND f_FloatNavigator.f_ReactivateDisabled) then
   Exit;
 end;
 Activate := l_Activate;
//#UC END# *52BAD30B01CD_52BAD1C40174_impl*
end;//TvtNavigatorPrim.CMnpChangeActivate

procedure TvtNavigatorPrim.CMAfterUndock(var Message: TMessage);
//#UC START# *52BAD3540031_52BAD1C40174_var*
//#UC END# *52BAD3540031_52BAD1C40174_var*
begin
//#UC START# *52BAD3540031_52BAD1C40174_impl*
 ModeStateUpdate;
//#UC END# *52BAD3540031_52BAD1C40174_impl*
end;//TvtNavigatorPrim.CMAfterUndock

procedure TvtNavigatorPrim.CMDelNavFromList(var Message: TMessage);
//#UC START# *52BAD36C00B4_52BAD1C40174_var*
//#UC END# *52BAD36C00B4_52BAD1C40174_var*
begin
//#UC START# *52BAD36C00B4_52BAD1C40174_impl*
 DelNavigator(Pointer(Message.wParam));
//#UC END# *52BAD36C00B4_52BAD1C40174_impl*
end;//TvtNavigatorPrim.CMDelNavFromList

procedure TvtNavigatorPrim.CMNPDoActionWithFormControls(var Message: TMessage);
//#UC START# *52BAD37C031A_52BAD1C40174_var*
var
 l_Index   : Integer;
 l_Control : TControl;
//#UC END# *52BAD37C031A_52BAD1C40174_var*
begin
//#UC START# *52BAD37C031A_52BAD1C40174_impl*
 for l_Index := Pred(Parent.ControlCount) downto 0 do
 begin
  l_Control := Parent.Controls[l_Index];
  if not (l_Control is TvtNavigator)and not (l_Control is TnpSurface) and
   (l_Control.Align = alNone) then
   case TnpDoActionWithFormControl(Message.WParam) of
    acRedraw:
     if l_Control is TWinControl then
      Windows.RedrawWindow(TWinControl(l_Control).Handle, nil, 0,
       RDW_FRAME or RDW_INVALIDATE or RDW_INTERNALPAINT);
    acUpInZOrder:
     l_Control.BringToFront;
   end;//case TnpDoActionWithFormControl(Message.WParam) of
 end;//for l_Index := Pred(Parent.ControlCount) downto 0 do
//#UC END# *52BAD37C031A_52BAD1C40174_impl*
end;//TvtNavigatorPrim.CMNPDoActionWithFormControls

procedure TvtNavigatorPrim.CMnpDockToFloatWindow(var Message: TMessage);
//#UC START# *52BAD3E80090_52BAD1C40174_var*
var
 l_Control : TControl;
 l_Float   : TnpFloatingWindow;
//#UC END# *52BAD3E80090_52BAD1C40174_var*
begin
//#UC START# *52BAD3E80090_52BAD1C40174_impl*
 if (Message.WParam > 0) and (not (csDestroying in ComponentState)) then
 begin
  l_Control := TControl(Message.WParam);
  l_Float := DockToFloatNavigator(l_Control);
  // ни к кому не пристыковали, такого не может быть
  Assert(Assigned(l_Float));
  {$IfDef Nemesis}
  // если форму пристыковали к уже существующему навигатору, то нужно обновить
  // FloatWindowBounds
  if (l_Control is TvcmForm) then
   TvcmForm(l_Control).FloatWindowBounds := l_Float.BoundsRect;
  {$EndIf Nemesis}
 end;//(Message.WParam > 0) and (not (csDestroying in ComponentState))
//#UC END# *52BAD3E80090_52BAD1C40174_impl*
end;//TvtNavigatorPrim.CMnpDockToFloatWindow

procedure TvtNavigatorPrim.WMEraseBkgnd(var Message: TWMEraseBkgnd);
//#UC START# *52BAD43803E3_52BAD1C40174_var*
//#UC END# *52BAD43803E3_52BAD1C40174_var*
begin
//#UC START# *52BAD43803E3_52BAD1C40174_impl*
 Message.Result := 1;
//#UC END# *52BAD43803E3_52BAD1C40174_impl*
end;//TvtNavigatorPrim.WMEraseBkgnd

function TvtNavigatorPrim.AutoHideOffHintStored: Boolean;
 {* "Функция определяющая, что свойство AutoHideOffHint сохраняется" }
//#UC START# *33C27CC2ACDD_52BAD1C40174_var*
//#UC END# *33C27CC2ACDD_52BAD1C40174_var*
begin
//#UC START# *33C27CC2ACDD_52BAD1C40174_impl*
 Result := f_AutoHideOffHint <> str_cAutoHideOffHint.AsStr;
//#UC END# *33C27CC2ACDD_52BAD1C40174_impl*
end;//TvtNavigatorPrim.AutoHideOffHintStored

function TvtNavigatorPrim.AutoHideOnHintStored: Boolean;
 {* "Функция определяющая, что свойство AutoHideOnHint сохраняется" }
//#UC START# *61AC8642D7EF_52BAD1C40174_var*
//#UC END# *61AC8642D7EF_52BAD1C40174_var*
begin
//#UC START# *61AC8642D7EF_52BAD1C40174_impl*
 Result := f_AutoHideOnHint <> str_cAutoHideOnHint.AsStr;
//#UC END# *61AC8642D7EF_52BAD1C40174_impl*
end;//TvtNavigatorPrim.AutoHideOnHintStored

function TvtNavigatorPrim.MinimizedOnHintStored: Boolean;
 {* "Функция определяющая, что свойство MinimizedOnHint сохраняется" }
//#UC START# *8B031BED9702_52BAD1C40174_var*
//#UC END# *8B031BED9702_52BAD1C40174_var*
begin
//#UC START# *8B031BED9702_52BAD1C40174_impl*
 Result := f_MinimizedOnHint <> str_cMinimizedOnHint.AsStr;
//#UC END# *8B031BED9702_52BAD1C40174_impl*
end;//TvtNavigatorPrim.MinimizedOnHintStored

function TvtNavigatorPrim.MinimizedOffHintStored: Boolean;
 {* "Функция определяющая, что свойство MinimizedOffHint сохраняется" }
//#UC START# *B9B2E2BB624D_52BAD1C40174_var*
//#UC END# *B9B2E2BB624D_52BAD1C40174_var*
begin
//#UC START# *B9B2E2BB624D_52BAD1C40174_impl*
 Result := f_MinimizedOffHint <> str_cMinimizedOffHint.AsStr;
//#UC END# *B9B2E2BB624D_52BAD1C40174_impl*
end;//TvtNavigatorPrim.MinimizedOffHintStored

function TvtNavigatorPrim.CloseHintStored: Boolean;
 {* "Функция определяющая, что свойство CloseHint сохраняется" }
//#UC START# *7A36423C7FB3_52BAD1C40174_var*
//#UC END# *7A36423C7FB3_52BAD1C40174_var*
begin
//#UC START# *7A36423C7FB3_52BAD1C40174_impl*
 Result := f_CloseHint <> str_cCloseHint.AsStr;
//#UC END# *7A36423C7FB3_52BAD1C40174_impl*
end;//TvtNavigatorPrim.CloseHintStored

function TvtNavigatorPrim.SaveState(out theState: IUnknown;
 aStateType: TvcmStateType): Boolean;
//#UC START# *4683E75B01D8_52BAD1C40174_var*
//#UC END# *4683E75B01D8_52BAD1C40174_var*
begin
//#UC START# *4683E75B01D8_52BAD1C40174_impl*
{$ifdef Nemesis}
 Result := f_PageControl.SaveState(theState, aStateType);
{$endif Nemesis}
//#UC END# *4683E75B01D8_52BAD1C40174_impl*
end;//TvtNavigatorPrim.SaveState

function TvtNavigatorPrim.LoadState(const theState: IUnknown;
 aStateType: TvcmStateType): Boolean;
//#UC START# *4683E79D0331_52BAD1C40174_var*
//#UC END# *4683E79D0331_52BAD1C40174_var*
begin
//#UC START# *4683E79D0331_52BAD1C40174_impl*
{$ifdef Nemesis}
 Result := f_PageControl.LoadState(theState, aStateType);
{$endif Nemesis}
//#UC END# *4683E79D0331_52BAD1C40174_impl*
end;//TvtNavigatorPrim.LoadState

procedure TvtNavigatorPrim.PageInactive;
 {* активная закладка стала не активной. }
//#UC START# *473DB05D033A_52BAD1C40174_var*
//#UC END# *473DB05D033A_52BAD1C40174_var*
begin
//#UC START# *473DB05D033A_52BAD1C40174_impl*
 {$If defined(Nemesis) AND not defined(NoVCM)}
 f_PageDeactivated := True;
 {$IfEnd}
 DoActivate(False);
//#UC END# *473DB05D033A_52BAD1C40174_impl*
end;//TvtNavigatorPrim.PageInactive

procedure TvtNavigatorPrim.PageActive;
 {* закладка стала активной. }
//#UC START# *473DB06A01A8_52BAD1C40174_var*
//#UC END# *473DB06A01A8_52BAD1C40174_var*
begin
//#UC START# *473DB06A01A8_52BAD1C40174_impl*
 {$If defined(Nemesis) AND not defined(NoVCM)}
 f_PageDeactivated := False;
 {$IfEnd}
 DoActivate(True);
//#UC END# *473DB06A01A8_52BAD1C40174_impl*
end;//TvtNavigatorPrim.PageActive

function TvtNavigatorPrim.pm_GetWeight: Integer;
//#UC START# *473DB083030D_52BAD1C40174get_var*
//#UC END# *473DB083030D_52BAD1C40174get_var*
begin
//#UC START# *473DB083030D_52BAD1C40174get_impl*
 Result := 0;
//#UC END# *473DB083030D_52BAD1C40174get_impl*
end;//TvtNavigatorPrim.pm_GetWeight

procedure TvtNavigatorPrim.SmallToolbarSize(aValue: Integer);
//#UC START# *476965D302A1_52BAD1C40174_var*
//#UC END# *476965D302A1_52BAD1C40174_var*
begin
//#UC START# *476965D302A1_52BAD1C40174_impl*
 if Assigned(f_Header) then
  f_Header.Size := aValue;
//#UC END# *476965D302A1_52BAD1C40174_impl*
end;//TvtNavigatorPrim.SmallToolbarSize

procedure TvtNavigatorPrim.Publish(const aCloseHandler: IvcmFormHandler);
//#UC START# *47CFAAC70224_52BAD1C40174_var*
var
 l_Class: TvtNavigatorForm;
//#UC END# *47CFAAC70224_52BAD1C40174_var*
begin
//#UC START# *47CFAAC70224_52BAD1C40174_impl*
 l_Class := TvtNavigatorForm.Create(aCloseHandler);
 try
  TvtNavigatorFormList.Instance.Add(l_Class);
  aCloseHandler.Form.FreeNotification(Self);
 finally
  FreeAndNil(l_Class);
 end;//try..finally
 UpdateCloseButton;
//#UC END# *47CFAAC70224_52BAD1C40174_impl*
end;//TvtNavigatorPrim.Publish

procedure TvtNavigatorPrim.TabBecomeActive;
//#UC START# *54868B67034A_52BAD1C40174_var*
//#UC END# *54868B67034A_52BAD1C40174_var*
begin
//#UC START# *54868B67034A_52BAD1C40174_impl*
 PageActive;
//#UC END# *54868B67034A_52BAD1C40174_impl*
end;//TvtNavigatorPrim.TabBecomeActive

procedure TvtNavigatorPrim.TabBecomeInactive;
//#UC START# *54868B84029F_52BAD1C40174_var*
//#UC END# *54868B84029F_52BAD1C40174_var*
begin
//#UC START# *54868B84029F_52BAD1C40174_impl*
 PageInactive;
//#UC END# *54868B84029F_52BAD1C40174_impl*
end;//TvtNavigatorPrim.TabBecomeInactive

procedure TvtNavigatorPrim.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_52BAD1C40174_var*
//#UC END# *478CF34E02CE_52BAD1C40174_var*
begin
//#UC START# *478CF34E02CE_52BAD1C40174_impl*
 if (Source is TvtNavigator) then
  AssignNav(TvtNavigatorPrim(Source))
 else
  inherited;
//#UC END# *478CF34E02CE_52BAD1C40174_impl*
end;//TvtNavigatorPrim.Assign

procedure TvtNavigatorPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52BAD1C40174_var*
//#UC END# *479731C50290_52BAD1C40174_var*
begin
//#UC START# *479731C50290_52BAD1C40174_impl*
 TnpNavigatorList.Instance.UnReg(Self);
 DoSaveSize;

 if f_Float then
 begin
  f_FloatNavigator.f_Navigator := nil;
  PostMessage(f_ParentNavigatorHandle, CM_npDeleteFromList,
   Integer(Pointer(f_FloatNavigator)), 0);
 end;//f_Float
 l3Free(f_NavigatorList);
 FreeAndNil(f_TimerDelay);
 FreeAndNil(f_TimerFloat);

 if (f_Header <> nil) then
 begin
  if (f_Header.Navigator <> nil) then
  begin
   Assert(f_Header.Navigator = Self);
   Self.UnRegisterStateChanged(f_Header.f_Link);
   f_Header.Navigator := nil;
  end;//f_Header.Navigator <> nil
 end;//f_Header <> nil
 FreeAndNil(f_Header);

 inherited;
//#UC END# *479731C50290_52BAD1C40174_impl*
end;//TvtNavigatorPrim.Cleanup

constructor TvtNavigatorPrim.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_52BAD1C40174_var*
//#UC END# *47D1602000C6_52BAD1C40174_var*
begin
//#UC START# *47D1602000C6_52BAD1C40174_impl*
 inherited Create(AOwner);
 f_NavigatorList := Tl3ObjectList.Create;
 (* Зарегистрируемся *)
 TnpNavigatorList.Instance.Reg(Self);
 (* Главная форма, которой принадлежит навигатор *)
 InitMainForm(AOwner);
 (* interited *)
 Width := cInitSize;
 if not (csDesigning in ComponentState) then
  BevelOuter := bvNone;
 DockSite := True;
 (* self *)
 f_SizeMini := -1;
 f_CountUndock := 0;
 f_HideDirect := hdNone;
 f_ChangeLinks := Tl3ObjectList.Create;
 f_State := nsNormal;
 f_IsFloatingOnShow := False;
 f_IsInitDockDrop := False;
 f_ShowActivePageInHeader := True;
 f_UnDockFromFloat := True;
 f_SingleFloatNavigator := True;
 f_SetCursorResize := False;
 f_SizeEmpty := cInitSize;
 f_SizeNormal := cDefaultNormalSize;
 f_Swim := True;
 f_IsDelay := False;
 f_DoDelay := False;
 f_DelayIntervalOnShow := 0;
 f_DelayIntervalOnHide := 1000;
 f_DelayOnAutoHide := False;
 f_TimerDelay := TTimer.Create(Self);
 f_TimerDelay.Enabled := False;
 f_TimerDelay.OnTimer := OnTimerDelay;
 f_AutoHideFloat := False;
 f_TimerFloat := TTimer.Create(Self);
 f_TimerFloat.Enabled := False;
 f_TimerFloat.Interval := 1;
 f_TimerFloat.OnTimer := OnTimerFloat;
 (* TnpSurface *)
 CreateSurface;
 (* TnpHeader *)
 CreateHeader;
 (* TnpPageControl *)
 CreatePageControl;
 (* Необходимо устанавливать здесь, потому, что в SetAlign используются
    TnpHeader, TnpPageControl *)
 Align := alLeft;
 f_CloseHint := str_vtBtnCloseHint.AsStr;
 f_AutoHideOffHint := str_vtAutoHideOffHint.AsStr;
 f_AutoHideOnHint := str_vtAutoHideOnHint.AsStr;
 f_MinimizedOffHint := str_vtMinimizedOffHint.AsStr;
 f_MinimizedOnHint := str_vtMinimizedOnHint.AsStr;
 f_FormWasMinimized := False;
//#UC END# *47D1602000C6_52BAD1C40174_impl*
end;//TvtNavigatorPrim.Create

{$If NOT Defined(NoVCL)}
procedure TvtNavigatorPrim.Resize;
//#UC START# *4CC8417A0288_52BAD1C40174_var*
//#UC END# *4CC8417A0288_52BAD1C40174_var*
begin
//#UC START# *4CC8417A0288_52BAD1C40174_impl*
 inherited Resize;
 if not f_Float then
  PlaceSurface
 else
  f_SizeNormal := f_FloatNavigator.Width;
//#UC END# *4CC8417A0288_52BAD1C40174_impl*
end;//TvtNavigatorPrim.Resize
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtNavigatorPrim.SetBounds(ALeft: Integer;
 ATop: Integer;
 AWidth: Integer;
 AHeight: Integer);
//#UC START# *4F2A599E0283_52BAD1C40174_var*
//#UC END# *4F2A599E0283_52BAD1C40174_var*
begin
//#UC START# *4F2A599E0283_52BAD1C40174_impl*
 {$IfDef DesignTimeLibrary}
 if Align = alNone then
  inherited
 else
 begin
  case Align of
   alLeft, alRight: AWidth := 20;
   alTop, alBottom: AHeight := 20;
  end;
  inherited;
 end;//case Align
 {$Else DesignTimeLibrary}
 (* Нельзя устанавливать навигатору без закладок ширину (высоту) больше
    f_SizeEmpty. Это может происходить в результате чтения размеров компонента из
    настроек *)
 if not Assigned(f_PageControl) or (f_PageControl.PageCount = 0) then
 begin
  case Align of
   alBottom, alTop:
    begin
     if (AHeight <= f_SizeEmpty) or (AHeight = SizeMini) then
      inherited
     else
      inherited SetBounds(ALeft, ATop, AWidth, Height);
    end;//alBottom, alTop
   alLeft, alRight:
    begin
     if (AWidth <= f_SizeEmpty) or (AWidth = SizeMini) then
      inherited
     else
      inherited SetBounds(ALeft, ATop, Width, AHeight);
    end;//alLeft, alRight
   else
    inherited;
  end;//case Align
  Exit;
 end;//not Assigned(f_PageControl) or (f_PageControl.PageCount = 0)
 inherited;
 {$EndIf DesignTimeLibrary}
//#UC END# *4F2A599E0283_52BAD1C40174_impl*
end;//TvtNavigatorPrim.SetBounds
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtNavigatorPrim.SetParent(AParent: TWinControl);
//#UC START# *4F71E1460089_52BAD1C40174_var*
//#UC END# *4F71E1460089_52BAD1C40174_var*
begin
//#UC START# *4F71E1460089_52BAD1C40174_impl*
 inherited;
 DoNotifyControls(Self, CM_npTabPositionChanged, 0, 0);
//#UC END# *4F71E1460089_52BAD1C40174_impl*
end;//TvtNavigatorPrim.SetParent
{$IfEnd} // NOT Defined(NoVCL)

procedure TvtNavigatorPrim.Notification(AComponent: TComponent;
 Operation: TOperation);
//#UC START# *4F884378016A_52BAD1C40174_var*
var
 l_Item : Integer;
//#UC END# *4F884378016A_52BAD1C40174_var*
begin
//#UC START# *4F884378016A_52BAD1C40174_impl*
 inherited Notification(aComponent, Operation);
 if (Operation = opRemove) then
 begin
  if TvtNavigatorFormList.Instance.FindData(TvtFormHandlerID_C(aComponent), l_Item) then
  begin
   AComponent.RemoveFreeNotification(Self);
   TvtNavigatorFormList.Instance.Delete(l_Item);
   UpdateCloseButton;
  end;//if TvtNavigatorFormList.Instance.FindData(l_Form, l_Item) then
 end;//if (Operation = opRemove) then
//#UC END# *4F884378016A_52BAD1C40174_impl*
end;//TvtNavigatorPrim.Notification

{$If NOT Defined(NoVCL)}
procedure TvtNavigatorPrim.DockDrop(Source: TDragDockObject;
 X: Integer;
 Y: Integer);
//#UC START# *4F8851380274_52BAD1C40174_var*
var
 lImageIndex : Integer;
 lIsEmpty    : Boolean;
//#UC END# *4F8851380274_52BAD1C40174_var*
begin
//#UC START# *4F8851380274_52BAD1C40174_impl*
 lImageIndex := -1;
 lIsEmpty := f_PageControl.PageCount = 0;
 f_IsInitDockDrop := False;
 if ((f_ImportNavigator <> nil) and (f_ImportNavigator <> Self)) or
  (f_ImportNavigator = nil) and CheckControl(Source.Control) then
 begin
  if Source.Control.Parent is TElTabSheet then
   lImageIndex := TElTabSheet(Source.Control.Parent).ImageIndex;
  if (f_PageControl.PageCount = 0) then
   f_SizeNormal := GetNavigatorSizeNormal(Source.Control);
  //f_PageControl.DockDrop(Source, X, Y);
  inherited DockDrop(Source, X, Y);
  MovePagesToNavigator(f_ImportNavigator, Source.Control);
  if Source.Control.Parent is TElTabSheet then
   TElTabSheet(Source.Control.Parent).ImageIndex := lImageIndex;
  if Source.Control.Visible then
   InitDockDrop;
 end;//((f_ImportNavigator <> nil) and (f_ImportNavigator <> Self))
 (* сбрасываем значения f_SizeNormal, которые были установлены навигатору до
    появления закладок в SetBounds, чтобы при нормализации он не был
    равен свернутому состоянию *)
 if (f_PageControl.PageCount = 1) and (f_State = nsMinimized) then
  f_SizeNormal := cDefaultNormalSize;
 UpdateState;
 {$IfDef Nemesis}
 if f_Float then
  f_FloatNavigator.UpdateFloatWindowsBounds;
 {$EndIf Nemesis}
 (* Обработчик отстыковки *)
 if lIsEmpty and not Assigned(f_PageControl.OnUnDock) then
  f_PageControl.OnUnDock := OnPageControlUnDock;
 (* не заслоняем компоненты, которые лежат в этом же месте *)
 if lIsEmpty and (f_PageControl.PageCount > 0) then
  PostMessage(Handle, CM_npDoActionWithFormControls, Ord(acUpInZOrder), 0);
//#UC END# *4F8851380274_52BAD1C40174_impl*
end;//TvtNavigatorPrim.DockDrop
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtNavigatorPrim.DockOver(Source: TDragDockObject;
 X: Integer;
 Y: Integer;
 State: TDragState;
 var Accept: Boolean);
//#UC START# *50FD32F103CA_52BAD1C40174_var*
 procedure pm_SetSizeNormal;
 var
  lParent: TWinControl;
  lNavigator: TvtNavigator;
 begin//pm_SetSizeNormal
  lNavigator := nil;

  if f_PageControl.PageCount = 0 then
  begin
   lParent := Source.Control.Parent;
   while (lNavigator = nil) and (lParent <> nil) do
    if lParent is TvtNavigator then
      lNavigator := lParent as TvtNavigator
    else
      lParent := lParent.Parent;
  end;

  if lNavigator <> nil then
   f_SizeNormal := lNavigator.SizeNormal;
 end;//pm_SetSizeNormal
//#UC END# *50FD32F103CA_52BAD1C40174_var*
begin
//#UC START# *50FD32F103CA_52BAD1C40174_impl*
 inherited DockOver(Source, X, Y, State, Accept);
 Accept := f_Activate;
 if Accept then
 begin
  SetDockRect(Source);
  Accept := True;
 end;//Accept
//#UC END# *50FD32F103CA_52BAD1C40174_impl*
end;//TvtNavigatorPrim.DockOver
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtNavigatorPrim.GetSiteInfo(Client: TControl;
 var InfluenceRect: TRect;
 MousePos: TPoint;
 var CanDock: Boolean);
//#UC START# *52B9A6A80336_52BAD1C40174_var*
//#UC END# *52B9A6A80336_52BAD1C40174_var*
begin
//#UC START# *52B9A6A80336_52BAD1C40174_impl*
 CanDock := f_Activate;
 if CanDock then
 begin
  inherited GetSiteInfo(Client, InfluenceRect, MousePos, CanDock);
  if (f_PageControl.PageCount = 0) and CanDock then
   InfluenceRect := GetDockRect;
 end;//CanDock
//#UC END# *52B9A6A80336_52BAD1C40174_impl*
end;//TvtNavigatorPrim.GetSiteInfo
{$IfEnd} // NOT Defined(NoVCL)

procedure TvtNavigatorPrim.SetName(const aValue: TComponentName);
//#UC START# *52BC212F023F_52BAD1C40174_var*
//#UC END# *52BC212F023F_52BAD1C40174_var*
begin
//#UC START# *52BC212F023F_52BAD1C40174_impl*
 inherited SetName(aValue);
 if Assigned(f_PageControl) then
  f_PageControl.Name := aValue;
//#UC END# *52BC212F023F_52BAD1C40174_impl*
end;//TvtNavigatorPrim.SetName

{$If NOT Defined(NoVCL)}
procedure TvtNavigatorPrim.PositionDockRect(DragDockObject: TDragDockObject);
//#UC START# *52BC260803B0_52BAD1C40174_var*
var
 l_Rect : TRect;
//#UC END# *52BC260803B0_52BAD1C40174_var*
begin
//#UC START# *52BC260803B0_52BAD1C40174_impl*
 if (f_PageControl.PageCount = 0) or (State = nsAutoHide) then
 begin
  l_Rect := GetDockRect;
  if PtInRect(l_Rect, DragDockObject.DragPos) then
  begin
   SetDockRect(DragDockObject);
   Exit;
  end;//PtInRect(l_Rect, DragDockObject.DragPos)
 end;//(f_PageControl.PageCount = 0) or (State = nsAutoHide)
 inherited PositionDockRect(DragDockObject);
//#UC END# *52BC260803B0_52BAD1C40174_impl*
end;//TvtNavigatorPrim.PositionDockRect
{$IfEnd} // NOT Defined(NoVCL)

procedure TvtNavigatorPrim.AfterDestroyCalled;
//#UC START# *52BC2B9401F3_52BAD1C40174_var*
//#UC END# *52BC2B9401F3_52BAD1C40174_var*
begin
//#UC START# *52BC2B9401F3_52BAD1C40174_impl*
 (* f_ChangeLinks удаляем после всех, потому, что в Inherited-е компоненты
    описывается от нотификации *)
 l3Free(f_ChangeLinks);
 inherited;
//#UC END# *52BC2B9401F3_52BAD1C40174_impl*
end;//TvtNavigatorPrim.AfterDestroyCalled

procedure TvtNavigatorPrim.ClearFields;
begin
 AutoHideOffHint := '';
 AutoHideOnHint := '';
 MinimizedOnHint := '';
 MinimizedOffHint := '';
 CloseHint := '';
 inherited;
end;//TvtNavigatorPrim.ClearFields

//#UC START# *52BAC7A10261impl*
//#UC END# *52BAC7A10261impl*

//#UC START# *4C8A252E01C2impl*
{$R *.RES}
//#UC END# *4C8A252E01C2impl*

initialization
 str_cAutoHideOffHint.Init;
 {* Инициализация str_cAutoHideOffHint }
 str_cAutoHideOnHint.Init;
 {* Инициализация str_cAutoHideOnHint }
 str_cMinimizedOnHint.Init;
 {* Инициализация str_cMinimizedOnHint }
 str_cMinimizedOffHint.Init;
 {* Инициализация str_cMinimizedOffHint }
 str_cCloseHint.Init;
 {* Инициализация str_cCloseHint }
 str_cemIndexOutOfPageCount.Init;
 {* Инициализация str_cemIndexOutOfPageCount }
 str_cemNavigatorAlreadyExists.Init;
 {* Инициализация str_cemNavigatorAlreadyExists }
 str_cemDeleteNavigatorNotExists.Init;
 {* Инициализация str_cemDeleteNavigatorNotExists }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnpCustomControl);
 {* Регистрация TnpCustomControl }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnpCustomPanel);
 {* Регистрация TnpCustomPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnpPageControl);
 {* Регистрация TnpPageControl }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnpContainerSurface);
 {* Регистрация TnpContainerSurface }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnpSurface);
 {* Регистрация TnpSurface }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnpSplitter);
 {* Регистрация TnpSplitter }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnpHeaderPrim);
 {* Регистрация TnpHeaderPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnpButton);
 {* Регистрация TnpButton }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnpFloatingWindow);
 {* Регистрация TnpFloatingWindow }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtNavigatorPrim);
 {* Регистрация TvtNavigatorPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnpHeader);
 {* Регистрация TnpHeader }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtNavigator);
 {* Регистрация TvtNavigator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
