unit StartUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\StartUnit.pas"
// ���������: "Interfaces"
// ������� ������: "Start" MUID: (456FF1DD031C)

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
 {* ��������� �������� ��� ����������� �������� �� ������� ���������� }
 PATH_TO_PICTURES: PAnsiChar = -PathToPictures;
 PATH_TO_EXECUTABLE: PAnsiChar = -PathToPicturesExecutable;
 {* ��������� ��� ����������� ���������� }
 EO_ENABLED: PAnsiChar = -EOEnable;
  {* ��������� �� ������ ��. ��-��������� �������, ��� ���������. }

type
 IPAddressNotFound = class
  {* ������������, ����� �� ������ �� ������ IP ������ ��� ������ ������� (��������� �������: ��� �������� ������� ����������). }
 end;//IPAddressNotFound

 InvalidBase = class
  {* ����������� ��� �������� ����. }
 end;//InvalidBase

 NoServer = class
  {* ������������ � ������, ����� �� �����-�� �������� ������ �������� �����������. }
 end;//NoServer

 BadNetworkConfig = class
  {* ������������, ���� � ������� 10 ������ �� ������ ����� �� ������� �� �� ���� �� IP �������� �� ������-������� (��������� �������: firewall ��������� `incoming connection` �� �����, ������� ���������� ACE/TAO ��� �������� ������). }
 end;//BadNetworkConfig

 SMTPServerAddressNotDefined = class
  {* �� ����� ����� SMTP ������� }
 end;//SMTPServerAddressNotDefined

 SMTPServerNotFound = class
  {* ���������� �� ����� ����������� c SMTP ��������. �������� ���� �������� ������ � ��� ����� ������ �������. }
 end;//SMTPServerNotFound

 UserNotFound = class
  {* ������������ �� ������ }
 end;//UserNotFound

 ServerVersionNotValid = class
 end;//ServerVersionNotValid

 InternalServerError = class
  {* ���������� ������ ������� }
 end;//InternalServerError

 WorkingParamsNotFound = class
  {* �� ������� ���������, ����������� ��� ������ ����������. }
 end;//WorkingParamsNotFound

 BadSMTPReply = class
 end;//BadSMTPReply

 SettingsRestoreFails = class
 end;//SettingsRestoreFails

 ExternalApplicationError = class
  {* ������ ��� ������ �������� ���������� }
 end;//ExternalApplicationError

 AlreadyLogged = class
 end;//AlreadyLogged

 TCapacity = (
  {* ����������� }
  C_32
  , C_64
 );//TCapacity

 TProductType = (
  {* ��� �������� }
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
  {* ��������� ����������� �� �������� ������� }
 end;//SMTPAuthorizationFailed

 MorphoNotExists = class
  {* ����������� �����������. }
 end;//MorphoNotExists

 TBaseType = (
  {* ��� �������� }
  BT_UNKNOWN
   {* ����������� ��� (����������� data.org) }
  , BT_TRIAL
   {* ��������������� ������ }
  , BT_COMMERCIAL
   {* ������������ ���� }
  , BT_NON_COMMERCIAL
   {* �� ������������ ���� }
  , BT_DEMO
   {* ���������� }
 );//TBaseType

 InternalApplicationError = class
  {* ������ � ��������� gcm }
 end;//InternalApplicationError

 InvalidUserDatastore = class
  {* ����� ���� ������� ������ �� desktop ������ - ������������� � ����� ���� ������������ (���-�� �� ����������� �������� settings) }
 end;//InvalidUserDatastore

 IAuthorization = interface
  {* ��������� ������������ ��������� ����������� � �������, �������� ���������� ��������� ������, ��������� ���������� � ���������. }
  ['{A49B3BF6-B27F-4D79-A67E-C51AF7F67855}']
  function GetProtectionError: Integer; stdcall;
  function GetRestTrialDaysCount: Integer; stdcall;
  function GetAutoregistrationStatus: ByteBool; stdcall;
  procedure SetAutoregistrationStatus(const aValue: ByteBool); stdcall; { can raise AccessDenied }
  function GetAdministratorEmail: IString; stdcall;
  procedure SetAdministratorEmail(const aValue: IString); stdcall;
  function GetAdministratorPhone: IString; stdcall;
  procedure SetAdministratorPhone(const aValue: IString); stdcall;
  procedure Login(login: PAnsiChar;
   password: PAnsiChar); stdcall; { can raise WrongAuthentication, NoMoreProfiles, XMLImportRunning, ShutdownInited, TrialPeriodExpired, AlreadyLogged, AccountDisabled, NoMoreConnections }
   {* ������ ������ � ��������. ��� �������� ���������� ������������ � ����, ����������� � ����������, ��� ���� �� ��������� � ���������� ��������� ICommon. }
  procedure GuestLogin; stdcall; { can raise NoMoreProfiles, LicenceViolation, XMLImportRunning, ShutdownInited, TrialPeriodExpired, NoMoreConnections }
   {* ������ ������ � �������� ������������-�����. ��� �������� ���������� ������������ � ����, ����������� � ����������, ��� ���� �� ��������� � ���������� ��������� ICommon. }
  procedure Logout; stdcall;
   {* ��������� ������ � ��������. }
  procedure Autoregistration(name: PAnsiChar;
   login: PAnsiChar;
   password: PAnsiChar;
   email: PAnsiChar); stdcall; { can raise WrongAuthentication, NoMoreProfiles, LicenceViolation, XMLImportRunning, ShutdownInited, TrialPeriodExpired, NoMoreConnections, AutoregistrationDisabled }
   {* ���������� login �� � ������������ ������ ������������. email - �����, �� ������� � ����������� ����� ���� ������� ���������� � ������������ (�����, ������) }
  procedure SendUserInfoByEmail(email: PAnsiChar); stdcall; { can raise SMTPServerAddressNotDefined, SMTPServerNotFound, UserNotFound, BadSMTPReply, SMTPAuthorizationFailed }
   {* ��������� ������� ���������� ������ � ����. ���� ����� ������,  �������� �� ���� ���������� � ������������. }
  function IsServerAlive: ByteBool; stdcall;
   {* ���������� true ���� ������ ��������, false ����� }
  procedure LogoutWithoutXmlBackup; stdcall;
   {* K274827650 }
  property ProtectionError: Integer
   read GetProtectionError;
   {* ������ ������. }
  property RestTrialDaysCount: Integer
   read GetRestTrialDaysCount;
   {* ����������� ���������� ��������� ����. ���� `== 0` - ��������� ������ �����; ���� `< 0` ��������� ������ �� ����������. }
  property AutoregistrationStatus: ByteBool
   read GetAutoregistrationStatus
   write SetAutoregistrationStatus;
   {* ������ ��������������� }
  property AdministratorEmail: IString
   read GetAdministratorEmail
   write SetAdministratorEmail;
   {* ����� �������������� }
  property AdministratorPhone: IString
   read GetAdministratorPhone
   write SetAdministratorPhone;
   {* ������� �������������� }
 end;//IAuthorization

 ServerIsStarting = class
  {* ������ �������, ��������� � �������� ������������� }
 end;//ServerIsStarting

 TLicenseRestrictions = record
  {* ��������� ������������ �������� }
  users: Cardinal;
   {* ����������� ���������� ������� ������������� }
  permanent_users: Cardinal;
   {* ����������� ���������� ������������� � ���������� �������� }
 end;//TLicenseRestrictions

 ICommon = interface
  {* ��������� ������������ ������ � �������� ���������������� �������, ��������� �� "��������� ����" ��� ����������. }
  ['{E07B0F92-C20B-4AB2-84A3-33BC2AF4659C}']
  function GetBaseDate: TDate; stdcall;
  function GetLicenseRestrictions: TLicenseRestrictions; stdcall;
  function GetDocumentOnNumber(number: Integer;
   out document: IDocument;
   out missing_info: IMissingInfo): ByteBool; stdcall;
   {* ���������� �������� (Document) �� ��������� ����������� ("�������������") ������. }
  procedure StartProcessingFolderNotification(var notifier: IExternalFoldersChangeNotifier); stdcall;
   {* ���������� ����������� ��������� �����. }
  function IsExplanatoryDictionaryExist: ByteBool; stdcall;
   {* ��������� ���������� (��������) �� � ������� �������� �������.
���������� true � ������, ���� �������� ������� ����������. }
  function IsPharmExist: ByteBool; stdcall;
  function CheckInternal: ByteBool; stdcall;
   {* �������� �������� �� ���� � ������������� ����������� - "��� ����������� �������������" }
  procedure ShowPicturesOnNumber(number: Integer); stdcall; { can raise WorkingParamsNotFound, ExternalApplicationError }
   {* ���������� ������� ��� ��������� ������ (���������������� ���������� ������) }
  function GetComplectName: IString; stdcall;
  function AutoShowHelp: ByteBool; stdcall;
   {* ���������� �� ������ ��� ������ ������� ����� ����������. }
  function GetProductType: TProductType; stdcall;
   {* �������� ��� �������������� �������� }
  function GetSplashScreen(is_start: Boolean;
   x: short;
   y: short;
   flash_available: Boolean): ISplashScreen; stdcall;
   {* �������� ����� }
  function GetSettingsManager: ISettingsManager; stdcall;
   {* �������� �������� �������� }
  function IsEoEnabled: ByteBool; stdcall;
   {* �������� �� ������ ��. }
  function GetBaseType: TBaseType; stdcall;
   {* ��� ���� }
  procedure CreateFolderNotificationQueue; stdcall;
   {* ������� ������� ��������� �������� ����������� }
  function GetBanner: IBanner; stdcall; { can raise CanNotFindData }
   {* �������� ������ }
  function IsTrimmedPublishSourceExists: ByteBool; stdcall;
   {* ���� �� ��������� ������ �������� ������������� }
  function GetScriptsSystemDictionary: IStream; stdcall;
   {* ������� ��� �������� (�271754146) }
  function GetPicture(id: Integer): IExternalObject; stdcall; { can raise CanNotFindData }
  function IsEraseOfInactiveUsersEnabled: ByteBool; stdcall;
   {* �������� �� ��������� �������� �������������, ������� ����� �� ������������ �������� }
  function GetEncryptedComplectId: IString; stdcall;
   {* �������� ������������� ������������� ��������� }
  property BaseDate: TDate
   read GetBaseDate;
  property LicenseRestrictions: TLicenseRestrictions
   read GetLicenseRestrictions;
   {* ������������ ����������� �� ���������� ������������� }
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
   {* ����������� ������� }
 end;//IAssemblyInfo

implementation

uses
 l3ImplUses
;

end.
