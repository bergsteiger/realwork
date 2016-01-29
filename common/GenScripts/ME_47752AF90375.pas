unit afwFacade;

interface

uses
 l3IntfUses
 , afwInterfaces
 , Controls
 , Messages
 , l3ProtoObject
 , l3MessagesService
 , l3FormsService
 , Forms
 , Classes
 , l3KeyboardLayoutService
 , l3TabService
;

type
 TafwCustomForm = afwInterfaces.TafwCustomForm;
 
 TafwControlFocusHook = procedure(aControl: TWinControl;
  aGot: Boolean);
 
 TafwControlMessageHook = procedure(aControl: TWinControl;
  const aMessage: TMessage);
 
 TafwIsAcceptableControlForTabNavigationHook = function(aControl: TWinControl): Boolean;
 
 TafwDoTabHook = function(aControl: TControl;
  aShift: Boolean): Boolean;
 
 TafwMessagesService = class(Tl3ProtoObject, Il3MessagesService)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure ProcessMessages;
 end;//TafwMessagesService
 
 TafwFormsService = class(Tl3ProtoObject, Il3FormsService)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function GetAnotherParentForm(Component: TPersistent): TCustomForm;
  function GetMainForm(Component: TPersistent): TCustomForm;
  function GetParentForm(Component: TPersistent): TCustomForm;
  function GetTopParentForm(Component: TPersistent): TCustomForm;
 end;//TafwFormsService
 
 TafwKeyboardLayoutService = class(Tl3ProtoObject, Il3KeyboardLayoutService)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure TryActivateKeyboardLayout;
 end;//TafwKeyboardLayoutService
 
 TafwTabService = class(Tl3ProtoObject, Il3TabService)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function HasTabs: Boolean;
 end;//TafwTabService
 
 Tafw = class
  {* Метакласс, реализующий точку входа в интерфейсы библиотеки AFW. }
  function NeedFixWMSIZE(aControl: TWinControl): Boolean;
  procedure TryActivateKeyboardLayout;
  function Application: IafwApplication;
   {* приложение AFW. }
  procedure BeginOp;
   {* начать операцию, внутри которой нельзя убивать контролы. }
  procedure EndOp;
   {* закончить операцию, внутри которой нельзя убивать контролы. }
  function InOp: Boolean;
  function IsObjectLocked(aControl: TObject): Boolean;
  function GetParentForm(Component: TPersistent): TafwCustomForm;
  function GetAnotherParentForm(Component: TPersistent): TafwCustomForm;
  function GetTopParentForm(Component: TPersistent): TafwCustomForm;
  function GetMainForm(Component: TPersistent): TafwCustomForm;
  procedure ProcessMessages;
  function Settings: IafwSettings;
   {* для работы с настройками системы. }
  procedure LockActionUpdate;
   {* Запретить обновление операций }
  procedure UnlockActionUpdate;
   {* Разрешить обновление операций }
  function IsActionUpdateLocked: Boolean;
   {* Обновление операций запрещено }
  function PermanentSettings: IafwSettingsPrim;
  function IsMenuLocked(const aControl: IafwMenuUnlockedPostBuild): Boolean;
  procedure ControlDestroying(const aControl: IafwMenuUnlockedPostBuild);
 end;//Tafw
 
 Rafw = class of Tafw;
  {* Ссылка на класс Tafw. }
 
implementation

uses
 l3ImplUses
 , afwSettingsImplSing
 , afwSettingsImplemented
 , Windows
 , SysUtils
;

type
 TafwHackPersistent = class(TPersistent)
  {* Для доступа к скрытой части TPersistent. }
 end;//TafwHackPersistent
 
end.
