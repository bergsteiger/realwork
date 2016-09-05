unit StartUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\StartUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "Start" MUID: (456FF1DD031C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , FoldersUnit
 , DocumentUnit
 , ExternalObjectUnit
 , SettingsUnit
 , SearchUnit
 , SecurityUnit
 , BannerUnit
;

const
 {* параметры инишника для отображения картинок во внешнем приложении }
 PATH_TO_PICTURES: PAnsiChar = -PathToPictures;
 PATH_TO_EXECUTABLE: PAnsiChar = -PathToPicturesExecutable;
 {* Константы для электронной отчётности }
 EO_ENABLED: PAnsiChar = -EOEnable;
  {* подключён ли модуль ЭО. По-умолчанию считаем, что подключён. }

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
  BT_UNKNOWN
   {* Неизвестный тип (отсутствует data.org) }
  , BT_TRIAL
   {* Ознакомительная версия }
  , BT_COMMERCIAL
   {* Коммерческая база }
  , BT_NON_COMMERCIAL
   {* Не коммерческая база }
  , BT_DEMO
   {* Демоверсия }
 );//TBaseType

 InternalApplicationError = class
  {* ошибка в механизме gcm }
 end;//InternalApplicationError

 InvalidUserDatastore = class
  {* может быть брошено только на desktop версии - сигнализирует о битой базе пользовалетя (что-то из содержимого каталога settings) }
 end;//InvalidUserDatastore

 IAuthorization = interface
  {* Интерфейс обеспечивает начальную авторизацию в системе, открытие выбранного комплекта данных, получение информации о комплекте. }
  ['{A49B3BF6-B27F-4D79-A67E-C51AF7F67855}']
  function GetProtectionError: Integer; stdcall;
  function GetRestTrialDaysCount: Integer; stdcall;
  function GetAutoregistrationStatus: ByteBool; stdcall;
  procedure SetAutoregistrationStatus(const aValue: ByteBool); stdcall; { can raise AccessDenied }
  procedure GetAdministratorEmail; stdcall;
  procedure SetAdministratorEmail(const aValue); stdcall;
  procedure GetAdministratorPhone; stdcall;
  procedure SetAdministratorPhone(const aValue); stdcall;
  procedure Login(login: PAnsiChar;
   password: PAnsiChar); stdcall; { can raise WrongAuthentication, NoMoreProfiles, XMLImportRunning, ShutdownInited, TrialPeriodExpired, AlreadyLogged, AccountDisabled, NoMoreConnections }
   {* Начало работы с системой. При успешном завершении подключается к базе, прописанной в параметрах, как база по умолчанию и возвращает интерфейс ICommon. }
  procedure GuestLogin; stdcall; { can raise NoMoreProfiles, LicenceViolation, XMLImportRunning, ShutdownInited, TrialPeriodExpired, NoMoreConnections }
   {* Начало работы с системой пользователя-гостя. При успешном завершении подключается к базе, прописанной в параметрах, как база по умолчанию и возвращает интерфейс ICommon. }
  procedure Logout; stdcall;
   {* Окончание работы с системой. }
  procedure Autoregistration(name: PAnsiChar;
   login: PAnsiChar;
   password: PAnsiChar;
   email: PAnsiChar); stdcall; { can raise WrongAuthentication, NoMoreProfiles, LicenceViolation, XMLImportRunning, ShutdownInited, TrialPeriodExpired, NoMoreConnections, AutoregistrationDisabled }
   {* Аналогично login но с регистрацией нового пользователя. email - адрес, на который в последствии может быть выслана информация о пользователе (логин, пароль) }
  procedure SendUserInfoByEmail(email: PAnsiChar); stdcall; { can raise SMTPServerAddressNotDefined, SMTPServerNotFound, UserNotFound, BadSMTPReply, SMTPAuthorizationFailed }
   {* Проверяет наличие указанного адреса в базе. Если адрес найден,  высылает на него информацию о пользователе. }
  function IsServerAlive: ByteBool; stdcall;
   {* возвращает true если сервер доступен, false иначе }
  procedure LogoutWithoutXmlBackup; stdcall;
   {* K274827650 }
  property ProtectionError: Integer
   read GetProtectionError;
   {* Ошибка защиты. }
  property RestTrialDaysCount: Integer
   read GetRestTrialDaysCount;
   {* Колличество оставшихся триальных дней. Если `== 0` - триальный период истек; если `< 0` триальный период не установлен. }
  property AutoregistrationStatus: ByteBool
   read GetAutoregistrationStatus
   write SetAutoregistrationStatus;
   {* статус авторегистрации }
  property AdministratorEmail: 
   read GetAdministratorEmail
   write SetAdministratorEmail;
   {* Почта администратора }
  property AdministratorPhone: 
   read GetAdministratorPhone
   write SetAdministratorPhone;
   {* Телефон администратора }
 end;//IAuthorization

 ServerIsStarting = class
  {* сервер запущен, находится в процессе инициализации }
 end;//ServerIsStarting

 TLicenseRestrictions = record
  {* Различные лицензионные счетчики }
  users: Cardinal;
   {* Разрешенное количество обычных пользователей }
  permanent_users: Cardinal;
   {* Разрешенное количество пользователей с постоянным доступом }
 end;//TLicenseRestrictions

 ICommon = interface
  {* Интерфейс обеспечивает доступ к основной функциональности системы, доступной из "Основного меню" или навигатора. }
  ['{E07B0F92-C20B-4AB2-84A3-33BC2AF4659C}']
  procedure GetBaseDate; stdcall;
  procedure GetLicenseRestrictions; stdcall;
  function GetDocumentOnNumber(number: Integer;
   out document: IDocument;
   out missing_info: IMissingInfo): ByteBool; stdcall;
   {* Возвращает документ (Document) по заданному внутреннему ("гарантовскому") номеру. }
  procedure StartProcessingFolderNotification(var notifier: IExternalFoldersChangeNotifier); stdcall;
   {* Установить нотификацию изменения папок. }
  function IsExplanatoryDictionaryExist: ByteBool; stdcall;
   {* Проверяет существует (доступен) ли в системе Толковый словарь.
Возвращает true в случае, если толковый словарь существует. }
  function IsPharmExist: ByteBool; stdcall;
  function CheckInternal: ByteBool; stdcall;
   {* проверка является ли база с лицензионными настройками - "для внутреннего использования" }
  procedure ShowPicturesOnNumber(number: Integer); stdcall; { can raise WorkingParamsNotFound, ExternalApplicationError }
   {* показывает рисунки для заданного топика (функциональность внутренней версии) }
  procedure GetComplectName(out aRet
   {* IString }); stdcall;
  function AutoShowHelp: ByteBool; stdcall;
   {* показывать ли помощь при первом запуске после инсталяции. }
  function GetProductType: TProductType; stdcall;
   {* получить тип установленного продукта }
  procedure GetSplashScreen(is_start: Boolean;
   x: short;
   y: short;
   flash_available: Boolean;
   out aRet
   {* ISplashScreen }); stdcall;
   {* Получить сплеш }
  procedure GetSettingsManager(out aRet
   {* ISettingsManager }); stdcall;
   {* Получить менеджер настроек }
  function IsEoEnabled: ByteBool; stdcall;
   {* доступен ли модуль ЭО. }
  function GetBaseType: TBaseType; stdcall;
   {* Тип базы }
  procedure CreateFolderNotificationQueue; stdcall;
   {* Создать очередь обработки папочных нотификаций }
  procedure GetBanner(out aRet
   {* IBanner }); stdcall; { can raise CanNotFindData }
   {* Получить баннер }
  function IsTrimmedPublishSourceExists: ByteBool; stdcall;
   {* Есть ли усеченный индекс Источник опубликования }
  procedure GetScriptsSystemDictionary(out aRet
   {* IStream }); stdcall;
   {* словарь для скриптов (К271754146) }
  procedure GetPicture(id: Integer;
   out aRet
   {* IExternalObject }); stdcall; { can raise CanNotFindData }
  function IsEraseOfInactiveUsersEnabled: ByteBool; stdcall;
   {* включена ли поддержка удаления пользователей, которые давно не пользовались системой }
  procedure GetEncryptedComplectId(out aRet
   {* IString }); stdcall;
   {* получить зашифрованный идентификатор комплекта }
  function IsEarlyInstalled: ByteBool; stdcall;
   {* признак ранее установленной версии }
  property BaseDate: 
   read GetBaseDate;
  property LicenseRestrictions: 
   read GetLicenseRestrictions;
   {* Лицензионные ограничения на количество пользователей }
 end;//ICommon

 IComponentManager = interface
  ['{C92D07EF-D91F-4CDD-BD8E-FC8DF18CC42C}']
  procedure Start; stdcall; { can raise StorageLocked, LicenceViolation, ConfigurationsNotDefined, IPAddressNotFound, InvalidBase, NoServer, BadNetworkConfig, ServerVersionNotValid, WorkingParamsNotFound, NoMoreConnections, MorphoNotExists, InternalApplicationError, InvalidUserDatastore, ServerIsStarting }
  procedure Stop; stdcall;
 end;//IComponentManager

 IAssemblyInfo = interface
  ['{D5DBA4D0-D3CD-43ED-9E01-CC854B442DA1}']
  function GetIsDebug: ByteBool; stdcall;
  function GetIsDesktop: ByteBool; stdcall;
  function GetIsCommerce: ByteBool; stdcall;
  function GetFirstStart: ByteBool; stdcall;
  procedure SetFirstStart(const aValue: ByteBool); stdcall;
  function GetServerCapacity: TCapacity; stdcall;
  property IsDebug: ByteBool
   read GetIsDebug;
  property IsDesktop: ByteBool
   read GetIsDesktop;
  property IsCommerce: ByteBool
   read GetIsCommerce;
  property FirstStart: ByteBool
   read GetFirstStart
   write SetFirstStart;
  property ServerCapacity: TCapacity
   read GetServerCapacity;
   {* Разрядность сервера }
 end;//IAssemblyInfo

implementation

uses
 l3ImplUses
;

end.
