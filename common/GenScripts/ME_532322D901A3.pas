unit vgRemindersLine;

interface

uses
 l3IntfUses
 , l3InterfacedComponent
 , l3Interfaces
 , afwInterfaces
 , afwDockingInterfaces
 , NewRemindersInterfaces
 , vcmExternalInterfaces
 , vcmInterfaces
 , l3TabbedContainersDispatcher
 , Controls
 , vgRemindersLineForm
 , ImgList
 , ExtCtrls
 , Types
 , Windows
 , vtPopupFormModelPart
 , Classes
 , vg_objects
 , vcmUserControls
 , Menus
 , l3ProtoDataContainer
;

type
 TvgReminder = class(Tl3InterfacedComponent, IvcmDatasourceChangeListener, IvgReminder)
  procedure FlashTimer(Sender: TObject);
  procedure DoChange;
  procedure ImageClick(Sender: TObject);
  procedure MouseDown(Sender: TObject;
   Button: TMouseButton;
   Shift: TShiftState;
   X: Single;
   Y: Single);
  procedure MouseUp(Sender: TObject;
   Button: TMouseButton;
   Shift: TShiftState;
   X: Single;
   Y: Single);
  procedure UpdateControls;
   {* Пересчитать размеры vgRect }
  procedure DoClick(out aHandled: Boolean);
  procedure UpdateAction;
  procedure DoPopupFormVisibleChanged(aVisible: Boolean);
  procedure DoVisibleChanged(aVisible: Boolean);
  procedure AfterBaloonHidden(Sender: TObject);
  procedure UpdateTextRectColor;
  procedure Click;
  procedure UpdateImage;
  procedure ReleaseResources;
  procedure DataSourceChanged(aControl: TControl);
 end;//TvgReminder
 
 TvgRemindersList = class(Tl3ProtoDataContainer)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TvgRemindersList
 
 TvgRemindersLine = class(Tl3InterfacedComponent, Il3WndProcListener, IafwTabSheetControl, IafwControlDock, Il3WndProcRetListener, IvgRemindersLine, IvcmComponentContainer, IvcmResourceHolder, IvcmMainFormDependent, Il3SelectedTabDependent)
  procedure UpdateReminders;
  procedure UpdateReminder(aIndex: Integer);
   {* Обновить картинку, размеры и положение контролов медали }
  function ReminderBounds(aIndex: Integer;
   anImageOnly: Boolean): TRect; overload;
  function ReminderBounds(aReminder: TvgReminder;
   anImageOnly: Boolean): TRect; overload;
  function PrevVisibleReminder(aReminder: TvgReminder): TvgReminder; overload;
  procedure DoChanged;
  procedure CalcPopupFormBounds(aReminder: TvgReminder);
   {* Посчитать расположение баллона относительно медали }
  procedure BeginUpdate;
  procedure EndUpdate;
  procedure AdjustPopupFormPosition(aReminder: TvgReminder;
   aTailLocked: Boolean;
   aCanMoveLine: Boolean); overload;
   {* Двигает форму к своей медали. Если надо, меняет её "хвост". }
  function PrevVisibleReminder(aIndex: Integer): TvgReminder; overload;
  procedure ReminderMouseDown(Sender: TvgReminder;
   Button: TMouseButton);
  procedure ReminderMouseUp(Sender: TvgReminder;
   Button: TMouseButton);
  procedure ClosePopupForm;
  procedure BringPopupFormToFront;
  procedure ReminderClick(aReminder: TvgReminder);
  function MainFormHandle: HWND;
  function VisiblePopupForm: TvtPopupFormModelPart;
  procedure BoundsChanged(aLeft: Integer;
   aTop: Integer;
   aWidth: Integer;
   aHeight: Integer);
  procedure SendSyncPosition;
  procedure OffsetLine(aShiftX: Integer;
   aShiftY: Integer);
  procedure FixPosition;
   {* Посчитать f_HorzPos и f_VertPos }
  procedure CheckZOrder;
  procedure RestoreWindowTimerProc(Sender: TObject);
  procedure LockActivateProcessing;
  procedure UnlockActivateProcessing;
  procedure AdjustPopupFormPosition(aTailLocked: Boolean;
   aCanMoveLine: Boolean); overload;
  procedure PageInactive;
   {* активная закладка стала не активной. }
  procedure PageActive;
   {* закладка стала активной. }
  function Weight: Integer;
   {* вес компонента, учитывается при размещении закладок. }
  function GetDockControl(const aDockable: IafwDockableControl): TWinControl;
  procedure WndProcListenerNotify(Msg: PCWPStruct;
   var theResult: Tl3HookProcResult);
  procedure WndProcRetListenerNotify(Msg: PCWPRetStruct;
   var theResult: Tl3HookProcResult);
  procedure ControlDropped(aControl: TControl);
  procedure RemindersLineFormDestroyed;
  function IsInMove: Boolean;
   {* Линию двигают }
  procedure CorrectBounds(var aLeft: Integer;
   var aTop: Integer;
   var aWidth: Integer;
   var aHeight: Integer);
  procedure UpdateActions;
  function Count: Integer;
  function OwnedComponent: TComponent;
  procedure SyncPosition;
  procedure ReleaseResources;
  procedure MainFormChanged(aForm: TControl);
   {* Вызывается при измении главной формы }
  procedure TabBecomeActive;
  procedure TabBecomeInactive;
 end;//TvgRemindersLine
 
implementation

uses
 l3ImplUses
 , SysUtils
 , vgTypes
 , vtPngImgList
 , vtInterfaces
 , l3ListenersManager
 , l3MinMax
 , Messages
 , l3String
 , Math
 , vg_controls
 , vg_scene
 , vtPopupForm
 , l3Defaults
 , l3Base
 , l3Core
 , vgReminderConsts
 , Forms
 , afwFacade
 , vgReminderWithAction
 , vgRemindersLineManager
 , l3ByteList
 , vgRemindersLineNotificationProxy
 , l3DwmApi
 , vgRemindersLineTabbedContainerNotificationProxy
 , TtfwClassRef_Proxy
 , RemindersLineWordsPack
 , ReminderWordsPack
 , RTLConsts
;

end.
