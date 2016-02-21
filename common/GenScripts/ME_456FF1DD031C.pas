unit StartUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\StartUnit.pas"
// ���������: "Interfaces"

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
   {* ������ ������ � ��������. ��� �������� ���������� ������������ � ����, ����������� � ����������, ��� ���� �� ��������� � ���������� ��������� ICommon. }
  procedure guest_login; { can raise NoMoreProfiles, LicenceViolation, XMLImportRunning, ShutdownInited, TrialPeriodExpired, NoMoreConnections }
   {* ������ ������ � �������� ������������-�����. ��� �������� ���������� ������������ � ����, ����������� � ����������, ��� ���� �� ��������� � ���������� ��������� ICommon. }
  procedure logout;
   {* ��������� ������ � ��������. }
  procedure autoregistration(name: PAnsiChar;
   login: PAnsiChar;
   password: PAnsiChar;
   email: PAnsiChar); { can raise WrongAuthentication, NoMoreProfiles, LicenceViolation, XMLImportRunning, ShutdownInited, TrialPeriodExpired, NoMoreConnections, AutoregistrationDisabled }
   {* ���������� login �� � ������������ ������ ������������. email - �����, �� ������� � ����������� ����� ���� ������� ���������� � ������������ (�����, ������) }
  procedure send_user_info_by_email(email: PAnsiChar); { can raise SMTPServerAddressNotDefined, SMTPServerNotFound, UserNotFound, BadSMTPReply, SMTPAuthorizationFailed }
   {* ��������� ������� ���������� ������ � ����. ���� ����� ������,  �������� �� ���� ���������� � ������������. }
  function is_server_alive: Boolean;
   {* ���������� true ���� ������ ��������, false ����� }
  procedure logout_without_xml_backup;
   {* K274827650 }
  property protection_error: Integer
   read Get_protection_error;
   {* ������ ������. }
  property rest_trial_days_count: Integer
   read Get_rest_trial_days_count;
   {* ����������� ���������� ��������� ����. ���� `== 0` - ��������� ������ �����; ���� `< 0` ��������� ������ �� ����������. }
  property autoregistration_status: Boolean
   read Get_autoregistration_status
   write Set_autoregistration_status;
   {* ������ ��������������� }
  property administrator_email: IString
   read Get_administrator_email
   write Set_administrator_email;
   {* ����� �������������� }
  property administrator_phone: IString
   read Get_administrator_phone
   write Set_administrator_phone;
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
  function Get_base_date: TDate;
  function Get_license_restrictions: TLicenseRestrictions;
  function get_document_on_number(number: Integer;
   out document: IDocument;
   out missing_info: IMissingInfo): Boolean;
   {* ���������� �������� (Document) �� ��������� ����������� ("�������������") ������. }
  procedure start_processing_folder_notification(var notifier: IExternalFoldersChangeNotifier);
   {* ���������� ����������� ��������� �����. }
  function is_explanatory_dictionary_exist: Boolean;
   {* ��������� ���������� (��������) �� � ������� �������� �������.
���������� true � ������, ���� �������� ������� ����������. }
  function is_pharm_exist: Boolean;
  function check_internal: Boolean;
   {* �������� �������� �� ���� � ������������� ����������� - "��� ����������� �������������" }
  procedure show_pictures_on_number(number: Integer); { can raise WorkingParamsNotFound, ExternalApplicationError }
   {* ���������� ������� ��� ��������� ������ (���������������� ���������� ������) }
  function get_complect_name: IString;
  function auto_show_help: Boolean;
   {* ���������� �� ������ ��� ������ ������� ����� ����������. }
  function get_product_type: TProductType;
   {* �������� ��� �������������� �������� }
  function get_splash_screen(is_start: Boolean;
   x: short;
   y: short;
   flash_available: Boolean): ISplashScreen;
   {* �������� ����� }
  function get_settings_manager: ISettingsManager;
   {* �������� �������� �������� }
  function is_eo_enabled: Boolean;
   {* �������� �� ������ ��. }
  function get_base_type: TBaseType;
   {* ��� ���� }
  procedure create_folder_notification_queue;
   {* ������� ������� ��������� �������� ����������� }
  function get_banner: IBanner; { can raise CanNotFindData }
   {* �������� ������ }
  function is_trimmed_publish_source_exists: Boolean;
   {* ���� �� ��������� ������ �������� ������������� }
  function get_scripts_system_dictionary: IStream;
   {* ������� ��� �������� (�271754146) }
  function get_picture(id: Integer): IExternalObject; { can raise CanNotFindData }
  function is_erase_of_inactive_users_enabled: Boolean;
   {* �������� �� ��������� �������� �������������, ������� ����� �� ������������ �������� }
  function get_encrypted_complect_id: IString;
   {* �������� ������������� ������������� ��������� }
  property base_date: TDate
   read Get_base_date;
  property license_restrictions: TLicenseRestrictions
   read Get_license_restrictions;
   {* ������������ ����������� �� ���������� ������������� }
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
   {* ����������� ������� }
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
