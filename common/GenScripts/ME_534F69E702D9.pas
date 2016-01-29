unit vcmTabbedContainerForm;

interface

uses
 l3IntfUses
 , vcmChromeLikeTabbedContainerForm
 , vcmExternalInterfaces
 , afwInterfaces
 , vcmChromeLikeTypes
 , vcmMainMenuStripForChromeLike
 , Menus
 , vcmEntityForm
 , Forms
 , l3Bitmap
 , Messages
 , Graphics
 , l3TabbedContainersDispatcher
 , Types
 , vcmInterfaces
 , Controls
 , Classes
 , ChromeLikeTabSetControlPrim
 , ChromeLikeTabSetControl
 , ChromeLikeInterfaces
;

type
 TvcmTabbedContainerForm = class(TvcmChromeLikeTabbedContainerForm, IvcmFlashingWindow, IafwMainFormContainer, IvcmMenuHolder)
  procedure DecoratorBackgroundChanged(aBitmap: TBitmap;
   aNeedDrawBackground: Boolean);
  function Make: TvcmTabbedContainerForm;
  function MakeWithChild(aChild: TForm;
   const aTabParams: Il3TabParams): TvcmTabbedContainerForm;
  procedure ResetClosing;
  procedure UpdateMenu(aFormWithMenu: TForm);
  procedure EnableRemindersActivity;
  procedure DisableRemindersActivity;
  function CanBeDocked(const aPoint: TPoint;
   aForm: TForm): Boolean;
  procedure UpdateContainedFormsActions;
  procedure DisableOthers(aSelectedForm: TForm);
  procedure UpdateContainerCaption;
  procedure SetFocusToSelectedForm;
  procedure DoGiveFocusToContainedForm;
  procedure vcmTabbedContainerCloseQuery(Sender: TObject;
   var CanClose: Boolean);
  procedure NotifyComponentsMainFormChanged(aForm: TvcmEntityForm);
  procedure NotifyComponentsSelectionChanged(aNewSelectedForm: TvcmEntityForm);
  procedure NotifyContainedFormsOnClosing;
  function GetInnerEntityForm: IvcmEntityForm;
  procedure WMClose(var aMessage: TWMClose);
  procedure WMEnable(var aMessage: TWMEnable);
  procedure WMCopyData(var aMessage: TWMCopyData);
  procedure WMWindowPosChanged(var aMessage: TWMWindowPosChanged);
  procedure WMSetFocus(var aMessage: TWMSetFocus);
  procedure WMSysCommand(var aMessage: TWMSysCommand);
  procedure StartFlashing;
  procedure StopFlashing;
  function CurrentMainForm: TafwCustomForm;
  procedure UpdateFormCaption(aForm: TafwCustomForm);
  function MainMenu: TMenuItem;
  function DoGetTabSetParent: TWinControl;
  function DoMakeClone: Il3TabbedContainer;
  procedure DockToAnother(const aMousePoint: TPoint;
   aForm: TForm);
 end;//TvcmTabbedContainerForm
 
implementation

uses
 l3ImplUses
 , vcmTabbedContainerFormDispatcher
 , vcmTabbedContainerRes
 , ChromeLikeTabParams
 , vcmFormSetHistory
 , vcmMainMenuBuilder
 , TtfwClassRef_Proxy
 , vcmMenuManager
 , vcmFormsUtils
 , SysUtils
 , vcmForm
 , vcmMessages
;

end.
