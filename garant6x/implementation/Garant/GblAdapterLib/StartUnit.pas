unit StartUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/StartUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Start
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	, BaseTypesUnit
	, FoldersUnit
	, DocumentUnit
	, ExternalObjectUnit
	, SettingsUnit
	, SearchUnit
	, SecurityUnit
	, BannerUnit
	//#UC START# *4423F94903C8_456FF1DD031C_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_456FF1DD031C_UNIT_FOR_Stream*
	;

type

IAuthorization = interface;
{ - предварительное описание IAuthorization. }

ICommon = interface;
{ - предварительное описание ICommon. }

IComponentManager = interface;
{ - предварительное описание IComponentManager. }

IAssemblyInfo = interface;
{ - предварительное описание IAssemblyInfo. }


// Возбуждается, когда не надено ни одного IP адреса для машины клиента (вероятные причины: нет
// активных сетевых соединений).
EIPAddressNotFound = class (Exception);

// Отсутствует или неверная база.
EInvalidBase = class (Exception);

// Возбуждается в случае, когда по каким-то причинам сервер оказался недоступным.
ENoServer = class (Exception);

// Возбуждается, если в течении 10 секунд не пришел ответ от сервера ни на один из IP адрессов на
// машине-клиенте (вероятные причины: firewall блокирует `incoming connection` на порты, которые
// использует ACE/TAO при обратном вызове).
EBadNetworkConfig = class (Exception);

// Не задан адрес SMTP сервера
ESMTPServerAddressNotDefined = class (Exception);

// Приложение не может соединиться c SMTP сервером. Возможно была допущена ошибка в при вводе
// адреса сервера.
ESMTPServerNotFound = class (Exception);

// Пользователь не найден
EUserNotFound = class (Exception);

EServerVersionNotValid = class (Exception);

// Внутренняя ошибка сервера
EInternalServerError = class (Exception);

// Не найдены параметры, необходимые для работы приложения.
EWorkingParamsNotFound = class (Exception);

EBadSMTPReply = class (Exception);

ESettingsRestoreFails = class (Exception);

// Ошибка при работе внешнего приложения
EExternalApplicationError = class (Exception);

EAlreadyLogged = class (Exception);

// Разрядность
PCapacity = ^TCapacity;
TCapacity = (
	C_32
	, C_64
);

// тип продукта
PProductType = ^TProductType;
TProductType = (
	PT_UNKNOWN
	, PT_DVD
	, PT_MOBILE
	, PT_FILESERVER
	, PT_DESKTOP
	, PT_CLIENTSERVER
	, PT_SUPERMOBILE
);

EAccountDisabled = class (Exception);

ENoMoreConnections = class (Exception);

// Неудачная авторизация на почтовом сервере
ESMTPAuthorizationFailed = class (Exception);

// отсутствует морфоиндекс.
EMorphoNotExists = class (Exception);

// Тип оболочки
PBaseType = ^TBaseType;
TBaseType = (
	BT_UNKNOWN // Неизвестный тип (отсутствует data.org)
	, BT_TRIAL // Ознакомительная версия
	, BT_COMMERCIAL // Коммерческая база
	, BT_NON_COMMERCIAL // Не коммерческая база
	, BT_DEMO // Демоверсия
);

// ошибка в механизме gcm
EInternalApplicationError = class (Exception);

// может быть брошено только на desktop версии - сигнализирует о битой базе пользовалетя (что-то из
// содержимого каталога settings)
EInvalidUserDatastore = class (Exception);

// сервер запущен, находится в процессе инициализации
EServerIsStarting = class (Exception);

// Различные лицензионные счетчики
PLicenseRestrictions = ^TLicenseRestrictions;
TLicenseRestrictions = packed record
	rUsers: Longword; // Разрешенное количество обычных пользователей
	rPermanentUsers: Longword; // Разрешенное количество пользователей с постоянным доступом
end;

// Интерфейс обеспечивает начальную авторизацию в системе, открытие выбранного комплекта данных,
// получение информации о комплекте.
IAuthorization = interface (IInterface) ['{A49B3BF6-B27F-4D79-A67E-C51AF7F67855}']
	function DontUseMe: Pointer;
	// Почта администратора
	procedure GetAdministratorEmail (out aRet {: IString}); stdcall;
	procedure SetAdministratorEmail (const aAdministratorEmail: IString); stdcall;

	// Телефон администратора
	procedure GetAdministratorPhone (out aRet {: IString}); stdcall;
	procedure SetAdministratorPhone (const aAdministratorPhone: IString); stdcall;

	// Аналогично login но с регистрацией нового пользователя. email - адрес, на который в последствии
	// может быть выслана информация о пользователе (логин, пароль)
	procedure Autoregistration (
		const aName: PAnsiChar;
		const aLogin: PAnsiChar;
		const aPassword: PAnsiChar;
		const aEmail: PAnsiChar
	); stdcall; // can raise EWrongAuthentication, ENoMoreProfiles, ELicenceViolation, EXMLImportRunning, EShutdownInited, ETrialPeriodExpired, ENoMoreConnections, EAutoregistrationDisabled

	// статус авторегистрации
	function GetAutoregistrationStatus (): Bytebool; stdcall;
	procedure SetAutoregistrationStatus (aAutoregistrationStatus: Bytebool); stdcall;

	// Начало работы с системой пользователя-гостя. При успешном завершении подключается к базе,
	// прописанной в параметрах, как база по умолчанию и возвращает интерфейс ICommon.
	procedure GuestLogin (); stdcall; // can raise ENoMoreProfiles, ELicenceViolation, EXMLImportRunning, EShutdownInited, ETrialPeriodExpired, ENoMoreConnections

	// возвращает true если сервер доступен, false иначе
	function IsServerAlive (): Bytebool; stdcall;

	// Начало работы с системой. При успешном завершении подключается к базе, прописанной в
	// параметрах, как база по умолчанию и возвращает интерфейс ICommon.
	procedure Login (
		const aLogin: PAnsiChar;
		const aPassword: PAnsiChar
	); stdcall; // can raise EWrongAuthentication, ENoMoreProfiles, EXMLImportRunning, EShutdownInited, ETrialPeriodExpired, EAlreadyLogged, EAccountDisabled, ENoMoreConnections

	// Окончание работы с системой.
	procedure Logout (); stdcall;

	// K274827650
	procedure LogoutWithoutXmlBackup (); stdcall;

	// Ошибка защиты.
	function GetProtectionError (): Longint; stdcall;

	// Колличество оставшихся триальных дней. Если `== 0` - триальный период истек; если `< 0`
	// триальный период не установлен.
	function GetRestTrialDaysCount (): Longint; stdcall;

	// Проверяет наличие указанного адреса в базе. Если адрес найден,  высылает на него информацию о
	// пользователе.
	procedure SendUserInfoByEmail (
		const aEmail: PAnsiChar
	); stdcall; // can raise ESMTPServerAddressNotDefined, ESMTPServerNotFound, EUserNotFound, EBadSMTPReply, ESMTPAuthorizationFailed
end;

// Интерфейс обеспечивает доступ к основной функциональности системы, доступной из "Основного меню"
// или навигатора.
ICommon = interface (IInterface) ['{E07B0F92-C20B-4AB2-84A3-33BC2AF4659C}']
	function DontUseMe: Pointer;
	// показывать ли помощь при первом запуске после инсталяции.
	function AutoShowHelp (): Bytebool; stdcall;

	procedure GetBaseDate (out a: TDate); stdcall;

	// проверка является ли база с лицензионными настройками - "для внутреннего использования"
	function CheckInternal (): Bytebool; stdcall;

	// Создать очередь обработки папочных нотификаций
	procedure CreateFolderNotificationQueue (); stdcall;

	// Получить баннер
	procedure GetBanner (
		out aRet {: IBanner}
	); stdcall; // can raise ECanNotFindData

	// Тип базы
	function GetBaseType (): TBaseType; stdcall;

	procedure GetComplectName (
		out aRet {: IString}
	); stdcall;

	// Возвращает документ (Document) по заданному внутреннему ("гарантовскому") номеру.
	function GetDocumentOnNumber (
		aNumber: Longint;
		out aDocument {: IDocument};
		out aMissingInfo {: IMissingInfo}
	): Bytebool; stdcall;

	// получить зашифрованный идентификатор комплекта
	procedure GetEncryptedComplectId (
		out aRet {: IString}
	); stdcall;

	procedure GetPicture (
		aId: Longint;
		out aRet {: IExternalObject}
	); stdcall; // can raise ECanNotFindData

	// получить тип установленного продукта
	function GetProductType (): TProductType; stdcall;

	// словарь для скриптов (К271754146)
	procedure GetScriptsSystemDictionary (
		out aRet {: IStream}
	); stdcall;

	// Получить менеджер настроек
	procedure GetSettingsManager (
		out aRet {: ISettingsManager}
	); stdcall;

	// Получить сплеш
	procedure GetSplashScreen (
		aIsStart: Bytebool;
		aX: Smallint;
		aY: Smallint;
		aFlashAvailable: Bytebool;
		out aRet {: ISplashScreen}
	); stdcall;

	// признак ранее установленной версии
	function IsEarlyInstalled (): Bytebool; stdcall;

	// доступен ли модуль ЭО.
	function IsEoEnabled (): Bytebool; stdcall;

	// включена ли поддержка удаления пользователей, которые давно не пользовались системой
	function IsEraseOfInactiveUsersEnabled (): Bytebool; stdcall;

	// Проверяет существует (доступен) ли в системе Толковый словарь.
	// Возвращает true в случае, если толковый словарь существует.
	function IsExplanatoryDictionaryExist (): Bytebool; stdcall;

	function IsPharmExist (): Bytebool; stdcall;

	// Есть ли усеченный индекс Источник опубликования
	function IsTrimmedPublishSourceExists (): Bytebool; stdcall;

	// Лицензионные ограничения на количество пользователей
	procedure GetLicenseRestrictions (out a: TLicenseRestrictions); stdcall;

	// показывает рисунки для заданного топика (функциональность внутренней версии)
	procedure ShowPicturesOnNumber (
		aNumber: Longint
	); stdcall; // can raise EWorkingParamsNotFound, EExternalApplicationError

	// Установить нотификацию изменения папок.
	procedure StartProcessingFolderNotification (
		const aNotifier: IExternalFoldersChangeNotifier
	); stdcall;
end;

IComponentManager = interface (IInterface) ['{C92D07EF-D91F-4CDD-BD8E-FC8DF18CC42C}']
	function DontUseMe: Pointer;
	procedure Start (); stdcall; // can raise EStorageLocked, ELicenceViolation, EConfigurationsNotDefined, EIPAddressNotFound, EInvalidBase, ENoServer, EBadNetworkConfig, EServerVersionNotValid, EWorkingParamsNotFound, ENoMoreConnections, EMorphoNotExists, EInternalApplicationError, EInvalidUserDatastore, EServerIsStarting

	procedure Stop (); stdcall;
end;

IAssemblyInfo = interface (IInterface) ['{D5DBA4D0-D3CD-43ED-9E01-CC854B442DA1}']
	function DontUseMe: Pointer;
	function GetFirstStart (): Bytebool; stdcall;
	procedure SetFirstStart (aFirstStart: Bytebool); stdcall;

	function GetIsCommerce (): Bytebool; stdcall;

	function GetIsDebug (): Bytebool; stdcall;

	function GetIsDesktop (): Bytebool; stdcall;

	// Разрядность сервера
	function GetServerCapacity (): TCapacity; stdcall;
end;

const

 { параметры инишника для отображения картинок во внешнем приложении }
	PATH_TO_PICTURES = '-PathToPictures';
	PATH_TO_EXECUTABLE = '-PathToPicturesExecutable';

 { Константы для электронной отчётности }
	EO_ENABLED = '-EOEnable';
 { подключён ли модуль ЭО. По-умолчанию считаем, что подключён. }

implementation
end.