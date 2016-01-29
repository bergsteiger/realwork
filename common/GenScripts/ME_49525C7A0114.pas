unit vcmMainForm;

interface

uses
 l3IntfUses
 , vcmMainFormModelPart
 , afwInterfaces
 , vcmInterfaces
;

type
 TvcmMainForm = class(TvcmMainFormModelPart, IafwMainForm, IvcmContainerMaker)
  {* ������� ����� ��� ������� ����� ���������� ������������ �� ���������� vcm }
  function DoMakeClone(aNeedShow: Boolean): TvcmMainForm;
  procedure BecomeMainForm;
  function LimitOpenedWindowsCount: Boolean;
  procedure UpdateMainCaption;
  procedure DoExitApplication;
  function StatusBar: IafwStatusBar;
   {* ������, ������������ ������ �������. }
  function Status: IafwStatus;
   {* ������ �������. }
  function MakeContainer: IvcmContainer;
 end;//TvcmMainForm
 
implementation

uses
 l3ImplUses
 , vcmIEntityList
 , vcmMainFormRes
 , vcmDockManagerList
 , vcmLockListenerList
 , vcmFormDispatcherListenerList
 , TtfwClassRef_Proxy
 , vcmMenuManager
 , vcmFormsUtils
 , Menus
 , SysUtils
 , vcmEntityForm
 , vcmForm
 , vcmMessages
;

end.
