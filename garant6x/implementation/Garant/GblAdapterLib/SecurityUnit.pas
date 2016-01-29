unit SecurityUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/SecurityUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Security
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
	, DynamicTreeUnit
	//#UC START# *4423F94903C8_45EEAA96039C_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_45EEAA96039C_UNIT_FOR_Stream*
	;

type

IUserProfile = interface;
{ - ��������������� �������� IUserProfile. }

IUserFilter = interface;
{ - ��������������� �������� IUserFilter. }

IProfileNode = interface;
{ - ��������������� �������� IProfileNode. }

IUidList = interface;
{ - ��������������� �������� IUidList. }

IUserManager = interface;
{ - ��������������� �������� IUserManager. }

IGroupNode = interface;
{ - ��������������� �������� IGroupNode. }


// �������� ������ ��������������
EWrongAuthentication = class (Exception);

// ���������� ������ �������� �������������
ENoMoreProfiles = class (Exception);

// ������� ������� ����������� � ������ ������ ������������
EUserActive = class (Exception);

// ��������� ������������ ��������
ELicenceViolation = class (Exception);

// ������� ������� ������� �� ������� �������
EXMLImportRunning = class (Exception);

// ������ ������������ ��� ��������������� � �������
ELoginDuplicate = class (Exception);

// ��������� � ������ ������� ����������� � ������ ���������� ������ �������.
EShutdownInited = class (Exception);

// ����� ��������������� ������ �������
ETrialPeriodExpired = class (Exception);

// ��������������� ��������� ��������������� �������
EAutoregistrationDisabled = class (Exception);

// ������ ������� ����� ������������� � ����������������� ������
ENoMorePrivilegedProfiles = class (Exception);

// ���������� � ������������
IUserProfile = interface (IEntityBase) ['{600B24EC-1FB9-40F2-A6FC-E89397679F80}']
	function CanBuyConsulting (): Bytebool; stdcall;

	procedure GetLogin (
		out aRet {: IString}
	); stdcall;

	procedure GetMail (
		out aRet {: IString}
	); stdcall;

	procedure GetName (
		out aRet {: IString}
	); stdcall;

	function GetUid (): Longint; stdcall;

	// ������������� ������, � ������� ����������� ������������.
	function GetGroupId (): TUid; stdcall;

	function HasPassword (): Bytebool; stdcall;

	// ����������������� ������������
	function IsPrivileged (): Bytebool; stdcall;

	function IsSystem (): Bytebool; stdcall;
end;

// ������ ��� ������ �������������
IUserFilter = interface (IFilterForTree) ['{A3970144-43FB-4E18-BBBB-7B246074873E}']
	function GetFlags (): Longword; stdcall;
	procedure SetFlags (aFlags: Longword); stdcall;

	// ������������� ������ �� ������� ���������� ����������� ����������
	function GetGroupUid (): TUid; stdcall;
	procedure SetGroupUid (aGroupUid: TUid); stdcall;
end;

// ���� � ������ �������������
IProfileNode = interface (INodeBase) ['{A5ED9F82-E286-4359-839E-021E436CA65E}']
	function GetUid (): TUid; stdcall;
end;

IUidList = interface(IInterface)
['{A75B8B20-685F-4F9B-A39F-960F9B086944}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    function  pm_GetItem(anIndex: Integer): TUid; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TUid); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TUid): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TUid); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
  // public properties
    property  Items[anIndex: Integer]: TUid
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - �������� ������. }
end;//IUidList

// ����� ��� ������ � ��������������. �������� ����� ��� ��������� ������ �������������.
IUserManager = interface (IInterface) ['{F9017C5B-D7D9-4DD0-8E29-BD24E6BA051E}']
	function DontUseMe: Pointer;
	// ����� �� ��������� ����������������� �������������
	function CanCreatePrivilegedUser (): Bytebool; stdcall; // can raise EAccessDenied

	// ������� ��� ������
	procedure ChangeGroupName (
		aUid: TUid;
		const aName: PAnsiChar
	); stdcall; // can raise EAccessDenied, ECanNotFindData, ELoginDuplicate

	procedure ChangeUserGroup (
		aUserId: TUid;
		aGroupId: TUid
	); stdcall; // can raise EAccessDenied, ECanNotFindData

	// ��������� ���������� ������������ �� �����������
	// ������. ������������ ���������������� �� uid.
	procedure ChangeUserInfo (
		aUid: TUid;
		const aName: PAnsiChar;
		const aMail: PAnsiChar
	); stdcall; // can raise EAccessDenied, ECanNotFindData, ELicenceViolation, EXMLImportRunning

	// ��������� ������ ������������. ������������ ���������������� �� uid.
	procedure ChangeUserPassword (
		aUid: TUid;
		const aPassword: PAnsiChar
	); stdcall; // can raise EAccessDenied, ECanNotFindData, EWrongAuthentication, ELicenceViolation, EXMLImportRunning

	procedure ChangeUsersGroup (
		const aIdList: IUidList;
		aGroupId: TUid
	); stdcall; // can raise EAccessDenied, ECanNotFindData

	// ������� ������ � �������� ������
	procedure CreateGroup (
		const aName: PAnsiChar
	); stdcall; // can raise EAccessDenied, EWrongAuthentication, EXMLImportRunning, ELoginDuplicate

	procedure CreateUserWithRights (
		const aName: PAnsiChar;
		const aLogin: PAnsiChar;
		const aPassword: PAnsiChar;
		const aMail: PAnsiChar;
		aCanBuyConsulting: Bytebool;
		aIsPrivileged: Bytebool;
		aGroupId: TUid
	); stdcall; // can raise EWrongAuthentication, ENoMoreProfiles, EXMLImportRunning, ELoginDuplicate, ETrialPeriodExpired, ENoMorePrivilegedProfiles

	// ������� ������ � �������� ���������������
	procedure DeleteGroup (
		aUid: TUid
	); stdcall; // can raise EAccessDenied, ECanNotFindData

	procedure DeleteUser (
		aUid: TUid
	); stdcall; // can raise EAccessDenied, ECanNotFindData, EUserActive

	// ������� ������ �������������. ���������� ������ �������������, ������� ������� �� �������.
	procedure DeleteUsers (
		const aList: IUidList;
		out aRet {: IUidList}
	); stdcall; // can raise EAccessDenied

	// ��������� ������ ������, ����������� ������� ������
	procedure GetActiveUsersListForNetOneUserVersion (
		out aRet {: IStringList}
	); stdcall; // can raise ECanNotFindData

	// ���������� ������� �������� �������� ������ ������������ ��� ����� ������������� (true - ������
	// ���������)
	function GetConsultingPaymentForNewbies (): Bytebool; stdcall;

	// �������� ������ �����
	procedure GetGroupsTree (
		out aRet {: INodeBase}
	); stdcall;

	// �������� ������ ������ ���� �� ������� �������� ����� ������ �������������
	procedure GetNonsearchableBlocksForGroup (
		aUid: TUid;
		out aRet {: INodeIdList}
	); stdcall; // can raise EAccessDenied, EInternalDatabaseError

	procedure GetSelfProfile (
		out aRet {: IUserProfile}
	); stdcall; // can raise ECanNotFindData

	// �������� ������ ������������� ��� ������ � �������� ���������������
	procedure GetUsersTree (
		out aRet {: INodeBase}
	); stdcall;

	// ����� �� ������� ������������
	function HasSharedFilters (
		aUid: TUid
	): Bytebool; stdcall;

	// ����� �� ������������ ���� �����
	function IsErasable (
		aUid: TUid
	): Bytebool; stdcall;

	procedure LogoutUser (
		aUid: TUid
	); stdcall; // can raise EAccessDenied, ECanNotFindData

	// ��������� ������ � ������� ���������� ������ �������������.
	procedure LogoutUsers (
		const aList: IUidList
	); stdcall; // can raise EAccessDenied

	// ��������� �������� ������ ������������ ��� ���� �������������
	procedure SetConsultingPaymentForAll (
		aIsAllowed: Bytebool
	); stdcall; // can raise EAccessDenied

	// ��������� �������� ������ ������������ ��� ����� �������������
	procedure SetConsultingPaymentForNewbies (
		aIsAllowed: Bytebool
	); stdcall; // can raise EAccessDenied

	// ������ ����� �� ������ ������������ ��� ��������� ������ �������������.
	procedure SetConsultingRights (
		const aList: IUidList;
		aIsPaymentAllowed: Bytebool
	); stdcall; // can raise EAccessDenied, EInternalDatabaseError

	// ��������� �������� - ����� �� ������� ������������
	procedure SetErasableState (
		aUid: TUid;
		aState: Bytebool
	); stdcall;

	// ���������� ������ ������ ���� �� ������� �������� ����� ������ �������������
	procedure SetNonsearchableBlocksForGroup (
		aUid: TUid;
		const aBlocksIds: INodeIdList
	); stdcall; // can raise EAccessDenied, ECanNotFindData

	// ���������� ����� �������������������
	procedure SetPrivilegedRights (
		const aList: IUidList;
		aIsPrivileged: Bytebool
	); stdcall; // can raise EAccessDenied, EXMLImportRunning, ENoMorePrivilegedProfiles

	// ������������� ������ �������� �� ������� ������������ uid ������ � ������������ �� ���������
	// state
	procedure SetSharedFiltersState (
		aUid: TUid;
		aState: Bytebool
	); stdcall;

	// ��������� �������� - ����� �� ������ ������������ ������� �� ������������
	procedure UserCanBuyConsulting (
		aUid: TUid;
		aIsAllowed: Bytebool
	); stdcall; // can raise EAccessDenied, ECanNotFindData, ELicenceViolation, EXMLImportRunning

	// ���������� �������� ������������������� ��� ������������
	procedure UserIsPrivileged (
		aUid: TUid;
		aIsPrivileged: Bytebool
	); stdcall; // can raise EAccessDenied, EXMLImportRunning, ENoMorePrivilegedProfiles
end;

// ���� ������ �����
IGroupNode = interface (IProfileNode) ['{1EA308E6-3D7C-4A5C-A1DB-3CA087F94096}']
	// ���� �� � ������ ������������
	function HasUsers (): Bytebool; stdcall; // can raise EAccessDenied, ECanNotFindData
end;

const

 { UserFilterFlags }
	UFF_USER_ACTIVE = Longword(1);
	UFF_USER_NOT_ACTIVE = Longword(2);
	UFF_USER_SYSTEM = Longword(4);
	UFF_USER_NOT_SYSTEM = Longword(8);
	UFF_USER_NOT_CURRENT = Longword(16);
	UFF_GUEST_USER = Longword(32);
	UFF_NOT_GUEST_USER = Longword(64);
	UFF_USER_CAN_BUY_CONSULTING = Longword(128);
	UFF_USER_CANT_BUY_CONSULTING = Longword(256);
	UFF_USER_PRIVILEGED = Longword(512);
	UFF_USER_NOT_PRIVILEGED = Longword(1024);
	UFF_GROUP_UID = Longword(2048);
 { ������� ������������� ������ �������� ������ }
	UFF_NOT_GROUPPED_USERS = Longword(4096);
 { ������������, �������� ������ � ������ ��� }
	UFF_CHAT_CONTACT_LIST_USERS = Longword(8192);
 { ������ �� ������������, ������� �������� � ������ ��������� ��� ���� �������� ������������ }

 { ��������� � ������� ����� ��������� ������������ � ����� ������ �� �����������. }
	PNT_LOGGED_FLAG = TNodeType(1);
 { ������������ � ������ ������ �������� � ������� }
	PNT_SYSTEM_FLAG = TNodeType(2);
 { ������� ����������� }
	PNT_EXIT_FLAG = TNodeType(4);
	PNT_PRIVILEGED_FLAG = TNodeType(8);

 { ���������, ��������� � �������� }
	GROUP_ALL_ID = TUid(0);
 { ������������� ������ "���" }

implementation
end.