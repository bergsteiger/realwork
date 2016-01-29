unit StartUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/StartUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Start
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

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

const
  { ��������� �������� ��� ����������� �������� �� ������� ���������� }
 PATH_TO_PICTURES : PAnsiChar = -PathToPictures;
 PATH_TO_EXECUTABLE : PAnsiChar = -PathToPicturesExecutable;

type
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
   BT_UNKNOWN // ����������� ��� (����������� data.org)
 , BT_TRIAL // ��������������� ������
 , BT_COMMERCIAL // ������������ ����
 , BT_NON_COMMERCIAL // �� ������������ ����
 , BT_DEMO // ����������
 );//TBaseType

 InternalApplicationError = class
  {* ������ � ��������� gcm }
 end;//InternalApplicationError

 InvalidUserDatastore = class
  {* ����� ���� ������� ������ �� desktop ������ - ������������� � ����� ���� ������������ (���-�� �� ����������� �������� settings) }
 end;//InvalidUserDatastore

 IAuthorization = interface(IUnknown)
  {* ��������� ������������ ��������� ����������� � �������, �������� ���������� ��������� ������, ��������� ���������� � ���������. }
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
     {* ������ ������ � ��������. ��� �������� ���������� ������������ � ����, ����������� � ����������, ��� ���� �� ��������� � ���������� ��������� ICommon. }
   procedure GuestLogin; stdcall; // can raise NoMoreProfiles, LicenceViolation, XMLImportRunning, ShutdownInited, TrialPeriodExpired, NoMoreConnections
     {* ������ ������ � �������� ������������-�����. ��� �������� ���������� ������������ � ����, ����������� � ����������, ��� ���� �� ��������� � ���������� ��������� ICommon. }
   procedure Logout; stdcall;
     {* ��������� ������ � ��������. }
   procedure Autoregistration(aName: PAnsiChar;
    aLogin: PAnsiChar;
    aPassword: PAnsiChar;
    aEmail: PAnsiChar); stdcall; // can raise WrongAuthentication, NoMoreProfiles, LicenceViolation, XMLImportRunning, ShutdownInited, TrialPeriodExpired, NoMoreConnections, AutoregistrationDisabled
     {* ���������� login �� � ������������ ������ ������������. email - �����, �� ������� � ����������� ����� ���� ������� ���������� � ������������ (�����, ������) }
   procedure SendUserInfoByEmail(aEmail: PAnsiChar); stdcall; // can raise SMTPServerAddressNotDefined, SMTPServerNotFound, UserNotFound, BadSMTPReply, SMTPAuthorizationFailed
     {* ��������� ������� ���������� ������ � ����. ���� ����� ������,  �������� �� ���� ���������� � ������������. }
   function IsServerAlive: ByteBool; stdcall;
     {* ���������� true ���� ������ ��������, false ����� }
   procedure LogoutWithoutXmlBackup; stdcall;
     {* K274827650 }
   property protection_error: Integer
     read GetProtectionError;
     {* ������ ������. }
   property rest_trial_days_count: Integer
     read GetRestTrialDaysCount;
     {* ����������� ���������� ��������� ����. ���� `== 0` - ��������� ������ �����; ���� `< 0` ��������� ������ �� ����������. }
   property autoregistration_status: ByteBool
     read GetAutoregistrationStatus
     write SetAutoregistrationStatus;
     {* ������ ��������������� }
   property administrator_email: IString
     read GetAdministratorEmail
     write SetAdministratorEmail;
     {* ����� �������������� }
   property administrator_phone: IString
     read GetAdministratorPhone
     write SetAdministratorPhone;
     {* ������� �������������� }
 end;//IAuthorization

 ServerIsStarting = class
  {* ������ �������, ��������� � �������� ������������� }
 end;//ServerIsStarting

const
  { ��������� ��� ����������� ���������� }
 EO_ENABLED : PAnsiChar = -EOEnable;
  { ��������� �� ������ ��. ��-��������� �������, ��� ���������. }

type
 TLicenseRestrictions = record
  {* ��������� ������������ �������� }
   users : Cardinal; // ����������� ���������� ������� �������������
   permanent_users : Cardinal; // ����������� ���������� ������������� � ���������� ��������
 end;//TLicenseRestrictions

 ICommon = interface(IUnknown)
  {* ��������� ������������ ������ � �������� ���������������� �������, ��������� �� "��������� ����" ��� ����������. }
   ['{E07B0F92-C20B-4AB2-84A3-33BC2AF4659C}']
   function GetBaseDate: TDate; stdcall;
   function GetLicenseRestrictions: TLicenseRestrictions; stdcall;
   function GetDocumentOnNumber(aNumber: Integer;
    out aDocument: IDocument;
    out aMissingInfo: IMissingInfo): ByteBool; stdcall;
     {* ���������� �������� (Document) �� ��������� ����������� ("�������������") ������. }
   procedure StartProcessingFolderNotification(var aNotifier: IExternalFoldersChangeNotifier); stdcall;
     {* ���������� ����������� ��������� �����. }
   function IsExplanatoryDictionaryExist: ByteBool; stdcall;
     {* ��������� ���������� (��������) �� � ������� �������� �������.
���������� true � ������, ���� �������� ������� ����������. }
   function IsPharmExist: ByteBool; stdcall;
   function CheckInternal: ByteBool; stdcall;
     {* �������� �������� �� ���� � ������������� ����������� - "��� ����������� �������������" }
   procedure ShowPicturesOnNumber(aNumber: Integer); stdcall; // can raise WorkingParamsNotFound, ExternalApplicationError
     {* ���������� ������� ��� ��������� ������ (���������������� ���������� ������) }
   procedure GetComplectName(out aRet {: IString}); stdcall;
   function AutoShowHelp: ByteBool; stdcall;
     {* ���������� �� ������ ��� ������ ������� ����� ����������. }
   function GetProductType: TProductType; stdcall;
     {* �������� ��� �������������� �������� }
   procedure GetSplashScreen(aIsStart: Boolean;
    aX: short;
    aY: short;
    aFlashAvailable: Boolean; out aRet {: ISplashScreen}); stdcall;
     {* �������� ����� }
   procedure GetSettingsManager(out aRet {: ISettingsManager}); stdcall;
     {* �������� �������� �������� }
   function IsEoEnabled: ByteBool; stdcall;
     {* �������� �� ������ ��. }
   function GetBaseType: TBaseType; stdcall;
     {* ��� ���� }
   procedure CreateFolderNotificationQueue; stdcall;
     {* ������� ������� ��������� �������� ����������� }
   procedure GetBanner(out aRet {: IBanner}); stdcall; // can raise CanNotFindData
     {* �������� ������ }
   function IsTrimmedPublishSourceExists: ByteBool; stdcall;
     {* ���� �� ��������� ������ �������� ������������� }
   procedure GetScriptsSystemDictionary(out aRet {: IStream}); stdcall;
     {* ������� ��� �������� (�271754146) }
   procedure GetPicture(aId: Integer; out aRet {: IExternalObject}); stdcall; // can raise CanNotFindData
   function IsEraseOfInactiveUsersEnabled: ByteBool; stdcall;
     {* �������� �� ��������� �������� �������������, ������� ����� �� ������������ �������� }
   procedure GetEncryptedComplectId(out aRet {: IString}); stdcall;
     {* �������� ������������� ������������� ��������� }
   property base_date: TDate
     read GetBaseDate;
   property license_restrictions: TLicenseRestrictions
     read GetLicenseRestrictions;
     {* ������������ ����������� �� ���������� ������������� }
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
     {* ����������� ������� }
 end;//IAssemblyInfo

implementation

end.