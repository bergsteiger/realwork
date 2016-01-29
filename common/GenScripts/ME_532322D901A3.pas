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
   {* ����������� ������� vgRect }
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
   {* ���������� ��� ������������ ��������. }
 end;//TvgRemindersList
 
 TvgRemindersLine = class(Tl3InterfacedComponent, Il3WndProcListener, IafwTabSheetControl, IafwControlDock, Il3WndProcRetListener, IvgRemindersLine, IvcmComponentContainer, IvcmResourceHolder, IvcmMainFormDependent, Il3SelectedTabDependent)
  procedure UpdateReminders;
  procedure UpdateReminder(aIndex: Integer);
   {* �������� ��������, ������� � ��������� ��������� ������ }
  function ReminderBounds(aIndex: Integer;
   anImageOnly: Boolean): TRect; overload;
  function ReminderBounds(aReminder: TvgReminder;
   anImageOnly: Boolean): TRect; overload;
  function PrevVisibleReminder(aReminder: TvgReminder): TvgReminder; overload;
  procedure DoChanged;
  procedure CalcPopupFormBounds(aReminder: TvgReminder);
   {* ��������� ������������ ������� ������������ ������ }
  procedure BeginUpdate;
  procedure EndUpdate;
  procedure AdjustPopupFormPosition(aReminder: TvgReminder;
   aTailLocked: Boolean;
   aCanMoveLine: Boolean); overload;
   {* ������� ����� � ����� ������. ���� ����, ������ � "�����". }
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
   {* ��������� f_HorzPos � f_VertPos }
  procedure CheckZOrder;
  procedure RestoreWindowTimerProc(Sender: TObject);
  procedure LockActivateProcessing;
  procedure UnlockActivateProcessing;
  procedure AdjustPopupFormPosition(aTailLocked: Boolean;
   aCanMoveLine: Boolean); overload;
  procedure PageInactive;
   {* �������� �������� ����� �� ��������. }
  procedure PageActive;
   {* �������� ����� ��������. }
  function Weight: Integer;
   {* ��� ����������, ����������� ��� ���������� ��������. }
  function GetDockControl(const aDockable: IafwDockableControl): TWinControl;
  procedure WndProcListenerNotify(Msg: PCWPStruct;
   var theResult: Tl3HookProcResult);
  procedure WndProcRetListenerNotify(Msg: PCWPRetStruct;
   var theResult: Tl3HookProcResult);
  procedure ControlDropped(aControl: TControl);
  procedure RemindersLineFormDestroyed;
  function IsInMove: Boolean;
   {* ����� ������� }
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
   {* ���������� ��� ������� ������� ����� }
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
