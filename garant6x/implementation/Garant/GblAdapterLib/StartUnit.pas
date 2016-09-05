unit StartUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/StartUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Start
//
//
// ��� ����� ����������� ��� ��� "������-������".
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
{ - ��������������� �������� IAuthorization. }

ICommon = interface;
{ - ��������������� �������� ICommon. }

IComponentManager = interface;
{ - ��������������� �������� IComponentManager. }

IAssemblyInfo = interface;
{ - ��������������� �������� IAssemblyInfo. }


// ������������, ����� �� ������ �� ������ IP ������ ��� ������ ������� (��������� �������: ���
// �������� ������� ����������).
EIPAddressNotFound = class (Exception);

// ����������� ��� �������� ����.
EInvalidBase = class (Exception);

// ������������ � ������, ����� �� �����-�� �������� ������ �������� �����������.
ENoServer = class (Exception);

// ������������, ���� � ������� 10 ������ �� ������ ����� �� ������� �� �� ���� �� IP �������� ��
// ������-������� (��������� �������: firewall ��������� `incoming connection` �� �����, �������
// ���������� ACE/TAO ��� �������� ������).
EBadNetworkConfig = class (Exception);

// �� ����� ����� SMTP �������
ESMTPServerAddressNotDefined = class (Exception);

// ���������� �� ����� ����������� c SMTP ��������. �������� ���� �������� ������ � ��� �����
// ������ �������.
ESMTPServerNotFound = class (Exception);

// ������������ �� ������
EUserNotFound = class (Exception);

EServerVersionNotValid = class (Exception);

// ���������� ������ �������
EInternalServerError = class (Exception);

// �� ������� ���������, ����������� ��� ������ ����������.
EWorkingParamsNotFound = class (Exception);

EBadSMTPReply = class (Exception);

ESettingsRestoreFails = class (Exception);

// ������ ��� ������ �������� ����������
EExternalApplicationError = class (Exception);

EAlreadyLogged = class (Exception);

// �����������
PCapacity = ^TCapacity;
TCapacity = (
	C_32
	, C_64
);

// ��� ��������
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

// ��������� ����������� �� �������� �������
ESMTPAuthorizationFailed = class (Exception);

// ����������� �����������.
EMorphoNotExists = class (Exception);

// ��� ��������
PBaseType = ^TBaseType;
TBaseType = (
	BT_UNKNOWN // ����������� ��� (����������� data.org)
	, BT_TRIAL // ��������������� ������
	, BT_COMMERCIAL // ������������ ����
	, BT_NON_COMMERCIAL // �� ������������ ����
	, BT_DEMO // ����������
);

// ������ � ��������� gcm
EInternalApplicationError = class (Exception);

// ����� ���� ������� ������ �� desktop ������ - ������������� � ����� ���� ������������ (���-�� ��
// ����������� �������� settings)
EInvalidUserDatastore = class (Exception);

// ������ �������, ��������� � �������� �������������
EServerIsStarting = class (Exception);

// ��������� ������������ ��������
PLicenseRestrictions = ^TLicenseRestrictions;
TLicenseRestrictions = packed record
	rUsers: Longword; // ����������� ���������� ������� �������������
	rPermanentUsers: Longword; // ����������� ���������� ������������� � ���������� ��������
end;

// ��������� ������������ ��������� ����������� � �������, �������� ���������� ��������� ������,
// ��������� ���������� � ���������.
IAuthorization = interface (IInterface) ['{A49B3BF6-B27F-4D79-A67E-C51AF7F67855}']
	function DontUseMe: Pointer;
	// ����� ��������������
	procedure GetAdministratorEmail (out aRet {: IString}); stdcall;
	procedure SetAdministratorEmail (const aAdministratorEmail: IString); stdcall;

	// ������� ��������������
	procedure GetAdministratorPhone (out aRet {: IString}); stdcall;
	procedure SetAdministratorPhone (const aAdministratorPhone: IString); stdcall;

	// ���������� login �� � ������������ ������ ������������. email - �����, �� ������� � �����������
	// ����� ���� ������� ���������� � ������������ (�����, ������)
	procedure Autoregistration (
		const aName: PAnsiChar;
		const aLogin: PAnsiChar;
		const aPassword: PAnsiChar;
		const aEmail: PAnsiChar
	); stdcall; // can raise EWrongAuthentication, ENoMoreProfiles, ELicenceViolation, EXMLImportRunning, EShutdownInited, ETrialPeriodExpired, ENoMoreConnections, EAutoregistrationDisabled

	// ������ ���������������
	function GetAutoregistrationStatus (): Bytebool; stdcall;
	procedure SetAutoregistrationStatus (aAutoregistrationStatus: Bytebool); stdcall;

	// ������ ������ � �������� ������������-�����. ��� �������� ���������� ������������ � ����,
	// ����������� � ����������, ��� ���� �� ��������� � ���������� ��������� ICommon.
	procedure GuestLogin (); stdcall; // can raise ENoMoreProfiles, ELicenceViolation, EXMLImportRunning, EShutdownInited, ETrialPeriodExpired, ENoMoreConnections

	// ���������� true ���� ������ ��������, false �����
	function IsServerAlive (): Bytebool; stdcall;

	// ������ ������ � ��������. ��� �������� ���������� ������������ � ����, ����������� �
	// ����������, ��� ���� �� ��������� � ���������� ��������� ICommon.
	procedure Login (
		const aLogin: PAnsiChar;
		const aPassword: PAnsiChar
	); stdcall; // can raise EWrongAuthentication, ENoMoreProfiles, EXMLImportRunning, EShutdownInited, ETrialPeriodExpired, EAlreadyLogged, EAccountDisabled, ENoMoreConnections

	// ��������� ������ � ��������.
	procedure Logout (); stdcall;

	// K274827650
	procedure LogoutWithoutXmlBackup (); stdcall;

	// ������ ������.
	function GetProtectionError (): Longint; stdcall;

	// ����������� ���������� ��������� ����. ���� `== 0` - ��������� ������ �����; ���� `< 0`
	// ��������� ������ �� ����������.
	function GetRestTrialDaysCount (): Longint; stdcall;

	// ��������� ������� ���������� ������ � ����. ���� ����� ������,  �������� �� ���� ���������� �
	// ������������.
	procedure SendUserInfoByEmail (
		const aEmail: PAnsiChar
	); stdcall; // can raise ESMTPServerAddressNotDefined, ESMTPServerNotFound, EUserNotFound, EBadSMTPReply, ESMTPAuthorizationFailed
end;

// ��������� ������������ ������ � �������� ���������������� �������, ��������� �� "��������� ����"
// ��� ����������.
ICommon = interface (IInterface) ['{E07B0F92-C20B-4AB2-84A3-33BC2AF4659C}']
	function DontUseMe: Pointer;
	// ���������� �� ������ ��� ������ ������� ����� ����������.
	function AutoShowHelp (): Bytebool; stdcall;

	procedure GetBaseDate (out a: TDate); stdcall;

	// �������� �������� �� ���� � ������������� ����������� - "��� ����������� �������������"
	function CheckInternal (): Bytebool; stdcall;

	// ������� ������� ��������� �������� �����������
	procedure CreateFolderNotificationQueue (); stdcall;

	// �������� ������
	procedure GetBanner (
		out aRet {: IBanner}
	); stdcall; // can raise ECanNotFindData

	// ��� ����
	function GetBaseType (): TBaseType; stdcall;

	procedure GetComplectName (
		out aRet {: IString}
	); stdcall;

	// ���������� �������� (Document) �� ��������� ����������� ("�������������") ������.
	function GetDocumentOnNumber (
		aNumber: Longint;
		out aDocument {: IDocument};
		out aMissingInfo {: IMissingInfo}
	): Bytebool; stdcall;

	// �������� ������������� ������������� ���������
	procedure GetEncryptedComplectId (
		out aRet {: IString}
	); stdcall;

	procedure GetPicture (
		aId: Longint;
		out aRet {: IExternalObject}
	); stdcall; // can raise ECanNotFindData

	// �������� ��� �������������� ��������
	function GetProductType (): TProductType; stdcall;

	// ������� ��� �������� (�271754146)
	procedure GetScriptsSystemDictionary (
		out aRet {: IStream}
	); stdcall;

	// �������� �������� ��������
	procedure GetSettingsManager (
		out aRet {: ISettingsManager}
	); stdcall;

	// �������� �����
	procedure GetSplashScreen (
		aIsStart: Bytebool;
		aX: Smallint;
		aY: Smallint;
		aFlashAvailable: Bytebool;
		out aRet {: ISplashScreen}
	); stdcall;

	// ������� ����� ������������� ������
	function IsEarlyInstalled (): Bytebool; stdcall;

	// �������� �� ������ ��.
	function IsEoEnabled (): Bytebool; stdcall;

	// �������� �� ��������� �������� �������������, ������� ����� �� ������������ ��������
	function IsEraseOfInactiveUsersEnabled (): Bytebool; stdcall;

	// ��������� ���������� (��������) �� � ������� �������� �������.
	// ���������� true � ������, ���� �������� ������� ����������.
	function IsExplanatoryDictionaryExist (): Bytebool; stdcall;

	function IsPharmExist (): Bytebool; stdcall;

	// ���� �� ��������� ������ �������� �������������
	function IsTrimmedPublishSourceExists (): Bytebool; stdcall;

	// ������������ ����������� �� ���������� �������������
	procedure GetLicenseRestrictions (out a: TLicenseRestrictions); stdcall;

	// ���������� ������� ��� ��������� ������ (���������������� ���������� ������)
	procedure ShowPicturesOnNumber (
		aNumber: Longint
	); stdcall; // can raise EWorkingParamsNotFound, EExternalApplicationError

	// ���������� ����������� ��������� �����.
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

	// ����������� �������
	function GetServerCapacity (): TCapacity; stdcall;
end;

const

 { ��������� �������� ��� ����������� �������� �� ������� ���������� }
	PATH_TO_PICTURES = '-PathToPictures';
	PATH_TO_EXECUTABLE = '-PathToPicturesExecutable';

 { ��������� ��� ����������� ���������� }
	EO_ENABLED = '-EOEnable';
 { ��������� �� ������ ��. ��-��������� �������, ��� ���������. }

implementation
end.