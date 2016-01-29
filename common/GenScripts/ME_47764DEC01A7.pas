unit afwApplication;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , afwInterfaces
 , l3Core
 , afwFacade
;

type
 TafwApplication = class(Tl3CacheableBase, IafwSettingsSource, IafwApplication)
  {* "Стандартная" реализация приложения AFW. }
  function DoGetIsTrialMode: Boolean;
  function DoGetTabInterfaceType: TafwTabInterfaceType;
  function MakeApplicationData: IafwApplicationData;
  function MakeSettings: IafwSettings;
  function DoGetIsInternal: Boolean;
  function MakeLocaleInfo: IafwLocaleInfo;
  procedure DefineLocaleInfo;
  procedure DoApplyActiveLanguage(const aTarget: IafwResources);
  function MakePermanentSettings: IafwSettingsPrim;
  procedure DoLockKeyboard;
  procedure DoUnLockKeyboard;
  procedure GetAskClearClipboardProc(out aProc: TafwAskClearClipboardProc);
  function BaseId: AnsiString;
   {* базовый идентификатор настройки. Используется как первая часть пути для идентификаторов настроек. }
  procedure ApplyActiveLanguage(const aTarget: IafwResources);
  function CurrentMainForm: IafwMainForm;
   {* текущая основная форма. }
  function Settings: IafwSettings;
   {* интерфейс настроек передаваемый объекту. }
  function PrintManager: IafwPrintManager;
   {* менеджер печати. }
  function UserQuery: IafwUserQuery;
   {* "Ворота" для запроса пользователя. }
  function IsInternal: Boolean;
   {* определяет версию приложения (внутренняя, коммерческая). Если флаг установлен, то версия используется внутри компании и может содержать отличия в поведении.
Изменение инициировано запросом: OIT500019874. }
  function LocaleInfo: IafwLocaleInfo;
   {* информация о локали. }
  function Data: IafwApplicationData;
   {* - данные приложения. }
  function MakeLongProcessVisualizer(const aCaption: IafwCString;
   anAttachWnd: THandle;
   anInitialTimeout: Cardinal;
   anImageList: TafwCustomImageList;
   anImageIndex: Integer): IafwLongProcessVisualizer;
  function PermanentSettings: IafwSettingsPrim;
  procedure LockKeyBoard;
  procedure UnlockKeyBoard;
  function AskClearClipboardProc: TafwAskClearClipboardProc;
  function IsTrialMode: Boolean;
  function TabInterfaceType: TafwTabInterfaceType;
 end;//TafwApplication
 
 TafwApplicationClass = class of TafwApplication;
  {* Ссылка на TafwApplication. }
 
 TafwImplementation = class(Tafw)
  {* Метакласс, реализующий "стандартным" образом точку входа в интерфейсы библиотеки AFW. }
  function GetApplicationClass: TafwApplicationClass;
   {* Класс реализации приложения. }
 end;//TafwImplementation
 
implementation

uses
 l3ImplUses
 , l3LocaleInfo
 , afwLongProcessVisualizer
 , SysUtils
 , l3Base
 , Forms
 , afwSettingsImplSing
 , afwSettingsImplemented
 , Classes
;

end.
