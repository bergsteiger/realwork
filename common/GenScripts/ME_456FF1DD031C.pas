unit StartUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\StartUnit.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , SecurityUnit
 , BaseTypesUnit
 , ExternalObjectUnit
 , SettingsUnit
 , BannerUnit
 , DocumentUnit
 , FoldersUnit
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
  function Get_protection_error: Integer;
  function Get_rest_trial_days_count: Integer;
  function Get_autoregistration_status: Boolean;
  procedure Set_autoregistration_status(aValue: Boolean); { can raise AccessDenied }
  function Get_administrator_email: IString;
  procedure Set_administrator_email(const aValue: IString);
  function Get_administrator_phone: IString;
  procedure Set_administrator_phone(const aValue: IString);
  procedure login(login: PAnsiChar;
   password: PAnsiChar); { can raise WrongAuthentication, NoMoreProfiles, XMLImportRunning, ShutdownInited, TrialPeriodExpired, AlreadyLogged, AccountDisabled, NoMoreConnections }
   {* Начало работы с системой. При успешном завершении подключается к базе, прописанной в параметрах, как база по умолчанию и возвращает интерфейс ICommon. }
  procedure guest_login; { can raise NoMoreProfiles, LicenceViolation, XMLImportRunning, ShutdownInited, TrialPeriodExpired, NoMoreConnections }
   {* Начало работы с системой пользователя-гостя. При успешном завершении подключается к базе, прописанной в параметрах, как база по умолчанию и возвращает интерфейс ICommon. }
  procedure logout;
   {* Окончание работы с системой. }
  procedure autoregistration(name: PAnsiChar;
   login: PAnsiChar;
   password: PAnsiChar;
   email: PAnsiChar); { can raise WrongAuthentication, NoMoreProfiles, LicenceViolation, XMLImportRunning, ShutdownInited, TrialPeriodExpired, NoMoreConnections, AutoregistrationDisabled }
   {* Аналогично login но с регистрацией нового пользователя. email - адрес, на который в последствии может быть выслана информация о пользователе (логин, пароль) }
  procedure send_user_info_by_email(email: PAnsiChar); { can raise SMTPServerAddressNotDefined, SMTPServerNotFound, UserNotFound, BadSMTPReply, SMTPAuthorizationFailed }
   {* Проверяет наличие указанного адреса в базе. Если адрес найден,  высылает на него информацию о пользователе. }
  function is_server_alive: Boolean;
   {* возвращает true если сервер доступен, false иначе }
  procedure logout_without_xml_backup;
   {* K274827650 }
  property protection_error: Integer
   read Get_protection_error;
   {* Ошибка защиты. }
  property rest_trial_days_count: Integer
   read Get_rest_trial_days_count;
   {* Колличество оставшихся триальных дней. Если `== 0` - триальный период истек; если `< 0` триальный период не установлен. }
  property autoregistration_status: Boolean
   read Get_autoregistration_status
   write Set_autoregistration_status;
   {* статус авторегистрации }
  property administrator_email: IString
   read Get_administrator_email
   write Set_administrator_email;
   {* Почта администратора }
  property administrator_phone: IString
   read Get_administrator_phone
   write Set_administrator_phone;
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
  function Get_base_date: TDate;
  function Get_license_restrictions: TLicenseRestrictions;
  function get_document_on_number(number: Integer;
   out document: IDocument;
   out missing_info: IMissingInfo): Boolean;
   {* Возвращает документ (Document) по заданному внутреннему ("гарантовскому") номеру. }
  procedure start_processing_folder_notification(var notifier: IExternalFoldersChangeNotifier);
   {* Установить нотификацию изменения папок. }
  function is_explanatory_dictionary_exist: Boolean;
   {* Проверяет существует (доступен) ли в системе Толковый словарь.
Возвращает true в случае, если толковый словарь существует. }
  function is_pharm_exist: Boolean;
  function check_internal: Boolean;
   {* проверка является ли база с лицензионными настройками - "для внутреннего использования" }
  procedure show_pictures_on_number(number: Integer); { can raise WorkingParamsNotFound, ExternalApplicationError }
   {* показывает рисунки для заданного топика (функциональность внутренней версии) }
  function get_complect_name: IString;
  function auto_show_help: Boolean;
   {* показывать ли помощь при первом запуске после инсталяции. }
  function get_product_type: TProductType;
   {* получить тип установленного продукта }
  function get_splash_screen(is_start: Boolean;
   x: short;
   y: short;
   flash_available: Boolean): ISplashScreen;
   {* Получить сплеш }
  function get_settings_manager: ISettingsManager;
   {* Получить менеджер настроек }
  function is_eo_enabled: Boolean;
   {* доступен ли модуль ЭО. }
  function get_base_type: TBaseType;
   {* Тип базы }
  procedure create_folder_notification_queue;
   {* Создать очередь обработки папочных нотификаций }
  function get_banner: IBanner; { can raise CanNotFindData }
   {* Получить баннер }
  function is_trimmed_publish_source_exists: Boolean;
   {* Есть ли усеченный индекс Источник опубликования }
  function get_scripts_system_dictionary: IStream;
   {* словарь для скриптов (К271754146) }
  function get_picture(id: Integer): IExternalObject; { can raise CanNotFindData }
  function is_erase_of_inactive_users_enabled: Boolean;
   {* включена ли поддержка удаления пользователей, которые давно не пользовались системой }
  function get_encrypted_complect_id: IString;
   {* получить зашифрованный идентификатор комплекта }
  property base_date: TDate
   read Get_base_date;
  property license_restrictions: TLicenseRestrictions
   read Get_license_restrictions;
   {* Лицензионные ограничения на количество пользователей }
 end;//ICommon

 IComponentManager = interface
  ['{C92D07EF-D91F-4CDD-BD8E-FC8DF18CC42C}']
  procedure start; { can raise StorageLocked, LicenceViolation, ConfigurationsNotDefined, IPAddressNotFound, InvalidBase, NoServer, BadNetworkConfig, ServerVersionNotValid, WorkingParamsNotFound, NoMoreConnections, MorphoNotExists, InternalApplicationError, InvalidUserDatastore, ServerIsStarting }
  procedure stop;
 end;//IComponentManager

 IAssemblyInfo = interface
  ['{D5DBA4D0-D3CD-43ED-9E01-CC854B442DA1}']
  function Get_is_debug: Boolean;
  function Get_is_desktop: Boolean;
  function Get_is_commerce: Boolean;
  function Get_first_start: Boolean;
  procedure Set_first_start(aValue: Boolean);
  function Get_server_capacity: TCapacity;
  property is_debug: Boolean
   read Get_is_debug;
  property is_desktop: Boolean
   read Get_is_desktop;
  property is_commerce: Boolean
   read Get_is_commerce;
  property first_start: Boolean
   read Get_first_start
   write Set_first_start;
  property server_capacity: TCapacity
   read Get_server_capacity;
   {* Разрядность сервера }
 end;//IAssemblyInfo

class function make: BadFactoryType; { can raise XMLImportRunning }
class function make: BadFactoryType;
class function make: BadFactoryType;
class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType; { can raise XMLImportRunning }
var
 l_Inst : IAuthorization;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : ICommon;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IComponentManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IAssemblyInfo;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
