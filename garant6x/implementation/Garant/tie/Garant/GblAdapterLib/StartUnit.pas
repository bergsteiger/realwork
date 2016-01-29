unit StartUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/StartUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Start
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  BaseTypesUnit,
  FoldersUnit,
  DocumentUnit,
  ExternalObjectUnit,
  SettingsUnit,
  SearchUnit,
  SecurityUnit,
  BannerUnit
  ;

type
 IPAddressNotFound = class
  {* Возбуждается, когда не надено ни одного IP адреса для машины клиента (вероятные причины: нет активных сетевых соединений). }
 end;//IPAddressNotFound

 InvalidBase = class
  {* Отсутствует или неверная база. }
 end;//InvalidBase

 NoServer = class
  {* Возбуждается в случае, когда по каким-то причинам сервер оказался недоступным. }
 end;//NoServer

 BadNetworkConfig = class
  {* Возбуждается, если в течении 10 секунд не пришел ответ от сервера ни на один из IP адрессов на машине-клиенте (вероятные причины: firewall блокирует `incoming connection` на порты, которые использует ACE/TAO при обратном вызове). }
 end;//BadNetworkConfig

 SMTPServerAddressNotDefined = class
  {* Не задан адрес SMTP сервера }
 end;//SMTPServerAddressNotDefined

 SMTPServerNotFound = class
  {* Приложение не может соединиться c SMTP сервером. Возможно была допущена ошибка в при вводе адреса сервера. }
 end;//SMTPServerNotFound

 UserNotFound = class
  {* Пользователь не найден }
 end;//UserNotFound

 ServerVersionNotValid = class
 end;//ServerVersionNotValid

 InternalServerError = class
  {* Внутренняя ошибка сервера }
 end;//InternalServerError

 WorkingParamsNotFound = class
  {* Не найдены параметры, необходимые для работы приложения. }
 end;//WorkingParamsNotFound

 BadSMTPReply = class
 end;//BadSMTPReply

 SettingsRestoreFails = class
 end;//SettingsRestoreFails

 ExternalApplicationError = class
  {* Ошибка при работе внешнего приложения }
 end;//ExternalApplicationError

 AlreadyLogged = class
 end;//AlreadyLogged

const
  { параметры инишника для отображения картинок во внешнем приложении }
 PATH_TO_PICTURES : PAnsiChar = -PathToPictures;
 PATH_TO_EXECUTABLE : PAnsiChar = -PathToPicturesExecutable;

type
 TCapacity = (
  {* Разрядность }
   C_32
 , C_64
 );//TCapacity

 TProductType = (
  {* тип продукта }
   PT_UNKNOWN
 , PT_DVD
 , PT_MOBILE
 , PT_FILESERVER
 , PT_DESKTOP
 , PT_CLIENTSERVER
 , PT_SUPERMOBILE
 );//TProductType

 AccountDisabled = class
 end;//AccountDisabled

 NoMoreConnections = class
 end;//NoMoreConnections

 SMTPAuthorizationFailed = class
  {* Неудачная авторизация на почтовом сервере }
 end;//SMTPAuthorizationFailed

 MorphoNotExists = class
  {* отсутствует морфоиндекс. }
 end;//MorphoNotExists

 TBaseType = (
  {* Тип оболочки }
   BT_UNKNOWN // Неизвестный тип (отсутствует data.org)
 , BT_TRIAL // Ознакомительная версия
 , BT_COMMERCIAL // Коммерческая база
 , BT_NON_COMMERCIAL // Не коммерческая база
 , BT_DEMO // Демоверсия
 );//TBaseType

 InternalApplicationError = class
  {* ошибка в механизме gcm }
 end;//InternalApplicationError

 InvalidUserDatastore = class
  {* может быть брошено только на desktop версии - сигнализирует о битой базе пользовалетя (что-то из содержимого каталога settings) }
 end;//InvalidUserDatastore

 IAuthorization = interface(IUnknown)
  {* Интерфейс обеспечивает начальную авторизацию в системе, открытие выбранного комплекта данных, получение информации о комплекте. }
   ['{A49B3BF6-B27F-4D79-A67E-C51AF7F67855}']
   function GetProtectionError: Integer; stdcall;
   function GetRestTrialDaysCount: Integer; stdcall;
   function GetAutoregistrationStatus: ByteBool; stdcall;
   procedure SetAutoregistrationStatus(aValue: Boolean); stdcall;
   function GetAdministratorEmail: IString; stdcall;
   procedure SetAdministratorEmail(const aValue: IString); stdcall;
   function GetAdministratorPhone: IString; stdcall;
   procedure SetAdministratorPhone(const aValue: IString); stdcall;
   procedure Login(aLogin: PAnsiChar;
    aPassword: PAnsiChar); stdcall; // can raise WrongAuthentication, NoMoreProfiles, XMLImportRunning, ShutdownInited, TrialPeriodExpired, AlreadyLogged, AccountDisabled, NoMoreConnections
     {* Начало работы с системой. При успешном завершении подключается к базе, прописанной в параметрах, как база по умолчанию и возвращает интерфейс ICommon. }
   procedure GuestLogin; stdcall; // can raise NoMoreProfiles, LicenceViolation, XMLImportRunning, ShutdownInited, TrialPeriodExpired, NoMoreConnections
     {* Начало работы с системой пользователя-гостя. При успешном завершении подключается к базе, прописанной в параметрах, как база по умолчанию и возвращает интерфейс ICommon. }
   procedure Logout; stdcall;
     {* Окончание работы с системой. }
   procedure Autoregistration(aName: PAnsiChar;
    aLogin: PAnsiChar;
    aPassword: PAnsiChar;
    aEmail: PAnsiChar); stdcall; // can raise WrongAuthentication, NoMoreProfiles, LicenceViolation, XMLImportRunning, ShutdownInited, TrialPeriodExpired, NoMoreConnections, AutoregistrationDisabled
     {* Аналогично login но с регистрацией нового пользователя. email - адрес, на который в последствии может быть выслана информация о пользователе (логин, пароль) }
   procedure SendUserInfoByEmail(aEmail: PAnsiChar); stdcall; // can raise SMTPServerAddressNotDefined, SMTPServerNotFound, UserNotFound, BadSMTPReply, SMTPAuthorizationFailed
     {* Проверяет наличие указанного адреса в базе. Если адрес найден,  высылает на него информацию о пользователе. }
   function IsServerAlive: ByteBool; stdcall;
     {* возвращает true если сервер доступен, false иначе }
   procedure LogoutWithoutXmlBackup; stdcall;
     {* K274827650 }
   property protection_error: Integer
     read GetProtectionError;
     {* Ошибка защиты. }
   property rest_trial_days_count: Integer
     read GetRestTrialDaysCount;
     {* Колличество оставшихся триальных дней. Если `== 0` - триальный период истек; если `< 0` триальный период не установлен. }
   property autoregistration_status: ByteBool
     read GetAutoregistrationStatus
     write SetAutoregistrationStatus;
     {* статус авторегистрации }
   property administrator_email: IString
     read GetAdministratorEmail
     write SetAdministratorEmail;
     {* Почта администратора }
   property administrator_phone: IString
     read GetAdministratorPhone
     write SetAdministratorPhone;
     {* Телефон администратора }
 end;//IAuthorization

 ServerIsStarting = class
  {* сервер запущен, находится в процессе инициализации }
 end;//ServerIsStarting

const
  { Константы для электронной отчётности }
 EO_ENABLED : PAnsiChar = -EOEnable;
  { подключён ли модуль ЭО. По-умолчанию считаем, что подключён. }

type
 TLicenseRestrictions = record
  {* Различные лицензионные счетчики }
   users : Cardinal; // Разрешенное количество обычных пользователей
   permanent_users : Cardinal; // Разрешенное количество пользователей с постоянным доступом
 end;//TLicenseRestrictions

 ICommon = interface(IUnknown)
  {* Интерфейс обеспечивает доступ к основной функциональности системы, доступной из "Основного меню" или навигатора. }
   ['{E07B0F92-C20B-4AB2-84A3-33BC2AF4659C}']
   function GetBaseDate: TDate; stdcall;
   function GetLicenseRestrictions: TLicenseRestrictions; stdcall;
   function GetDocumentOnNumber(aNumber: Integer;
    out aDocument: IDocument;
    out aMissingInfo: IMissingInfo): ByteBool; stdcall;
     {* Возвращает документ (Document) по заданному внутреннему ("гарантовскому") номеру. }
   procedure StartProcessingFolderNotification(var aNotifier: IExternalFoldersChangeNotifier); stdcall;
     {* Установить нотификацию изменения папок. }
   function IsExplanatoryDictionaryExist: ByteBool; stdcall;
     {* Проверяет существует (доступен) ли в системе Толковый словарь.
Возвращает true в случае, если толковый словарь существует. }
   function IsPharmExist: ByteBool; stdcall;
   function CheckInternal: ByteBool; stdcall;
     {* проверка является ли база с лицензионными настройками - "для внутреннего использования" }
   procedure ShowPicturesOnNumber(aNumber: Integer); stdcall; // can raise WorkingParamsNotFound, ExternalApplicationError
     {* показывает рисунки для заданного топика (функциональность внутренней версии) }
   procedure GetComplectName(out aRet {: IString}); stdcall;
   function AutoShowHelp: ByteBool; stdcall;
     {* показывать ли помощь при первом запуске после инсталяции. }
   function GetProductType: TProductType; stdcall;
     {* получить тип установленного продукта }
   procedure GetSplashScreen(aIsStart: Boolean;
    aX: short;
    aY: short;
    aFlashAvailable: Boolean; out aRet {: ISplashScreen}); stdcall;
     {* Получить сплеш }
   procedure GetSettingsManager(out aRet {: ISettingsManager}); stdcall;
     {* Получить менеджер настроек }
   function IsEoEnabled: ByteBool; stdcall;
     {* доступен ли модуль ЭО. }
   function GetBaseType: TBaseType; stdcall;
     {* Тип базы }
   procedure CreateFolderNotificationQueue; stdcall;
     {* Создать очередь обработки папочных нотификаций }
   procedure GetBanner(out aRet {: IBanner}); stdcall; // can raise CanNotFindData
     {* Получить баннер }
   function IsTrimmedPublishSourceExists: ByteBool; stdcall;
     {* Есть ли усеченный индекс Источник опубликования }
   procedure GetScriptsSystemDictionary(out aRet {: IStream}); stdcall;
     {* словарь для скриптов (К271754146) }
   procedure GetPicture(aId: Integer; out aRet {: IExternalObject}); stdcall; // can raise CanNotFindData
   function IsEraseOfInactiveUsersEnabled: ByteBool; stdcall;
     {* включена ли поддержка удаления пользователей, которые давно не пользовались системой }
   procedure GetEncryptedComplectId(out aRet {: IString}); stdcall;
     {* получить зашифрованный идентификатор комплекта }
   property base_date: TDate
     read GetBaseDate;
   property license_restrictions: TLicenseRestrictions
     read GetLicenseRestrictions;
     {* Лицензионные ограничения на количество пользователей }
 end;//ICommon

 IComponentManager = interface(IUnknown)
   ['{C92D07EF-D91F-4CDD-BD8E-FC8DF18CC42C}']
   procedure Start; stdcall; // can raise StorageLocked, LicenceViolation, ConfigurationsNotDefined, IPAddressNotFound, InvalidBase, NoServer, BadNetworkConfig, ServerVersionNotValid, WorkingParamsNotFound, NoMoreConnections, MorphoNotExists, InternalApplicationError, InvalidUserDatastore, ServerIsStarting
   procedure Stop; stdcall;
 end;//IComponentManager

 IAssemblyInfo = interface(IUnknown)
   ['{D5DBA4D0-D3CD-43ED-9E01-CC854B442DA1}']
   function GetIsDebug: ByteBool; stdcall;
   function GetIsDesktop: ByteBool; stdcall;
   function GetIsCommerce: ByteBool; stdcall;
   function GetFirstStart: ByteBool; stdcall;
   procedure SetFirstStart(aValue: Boolean); stdcall;
   function GetServerCapacity: TCapacity; stdcall;
   property is_debug: ByteBool
     read GetIsDebug;
   property is_desktop: ByteBool
     read GetIsDesktop;
   property is_commerce: ByteBool
     read GetIsCommerce;
   property first_start: ByteBool
     read GetFirstStart
     write SetFirstStart;
   property server_capacity: TCapacity
     read GetServerCapacity;
     {* Разрядность сервера }
 end;//IAssemblyInfo

implementation

end.