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
  {* Базовый класс для главной формы приложения построенного на библиотеке vcm }
  function DoMakeClone(aNeedShow: Boolean): TvcmMainForm;
  procedure BecomeMainForm;
  function LimitOpenedWindowsCount: Boolean;
  procedure UpdateMainCaption;
  procedure DoExitApplication;
  function StatusBar: IafwStatusBar;
   {* объект, отображающий строку статуса. }
  function Status: IafwStatus;
   {* строка статуса. }
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
