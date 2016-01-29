unit SecurityUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/SecurityUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Security
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
  DynamicTreeUnit
  ;

const
  { UserFilterFlags }
 UFF_USER_ACTIVE : Cardinal = 1;
 UFF_USER_NOT_ACTIVE : Cardinal = 2;
 UFF_USER_SYSTEM : Cardinal = 4;
 UFF_USER_NOT_SYSTEM : Cardinal = 8;
 UFF_USER_NOT_CURRENT : Cardinal = 16;
 UFF_GUEST_USER : Cardinal = 32;
 UFF_NOT_GUEST_USER : Cardinal = 64;
 UFF_USER_CAN_BUY_CONSULTING : Cardinal = 128;
 UFF_USER_CANT_BUY_CONSULTING : Cardinal = 256;
 UFF_USER_PRIVILEGED : Cardinal = 512;
 UFF_USER_NOT_PRIVILEGED : Cardinal = 1024;
 UFF_GROUP_UID : Cardinal = 2048;
  { ������� ������������� ������ �������� ������ }
 UFF_NOT_GROUPPED_USERS : Cardinal = 4096;
  { ������������, �������� ������ � ������ ��� }
 UFF_CHAT_CONTACT_LIST_USERS : Cardinal = 8192;
  { ������ �� ������������, ������� �������� � ������ ��������� ��� ���� �������� ������������ }

type
 WrongAuthentication = class
  {* �������� ������ �������������� }
 end;//WrongAuthentication

 NoMoreProfiles = class
  {* ���������� ������ �������� ������������� }
 end;//NoMoreProfiles

 UserActive = class
  {* ������� ������� ����������� � ������ ������ ������������ }
 end;//UserActive

 LicenceViolation = class
  {* ��������� ������������ �������� }
 end;//LicenceViolation

 XMLImportRunning = class
  {* ������� ������� ������� �� ������� ������� }
 end;//XMLImportRunning

 LoginDuplicate = class
  {* ������ ������������ ��� ��������������� � ������� }
 end;//LoginDuplicate

 ShutdownInited = class
  {* ��������� � ������ ������� ����������� � ������ ���������� ������ �������. }
 end;//ShutdownInited

const
  { ��������� � ������� ����� ��������� ������������ � ����� ������ �� �����������. }
 PNT_LOGGED_FLAG : TNodeType = 1;
  { ������������ � ������ ������ �������� � ������� }
 PNT_SYSTEM_FLAG : TNodeType = 2;
  { ������� ����������� }
 PNT_EXIT_FLAG : TNodeType = 4;
 PNT_PRIVILEGED_FLAG : TNodeType = 8;

type
 IUserProfile = interface(IEntityBase)
  {* ���������� � ������������ }
   ['{600B24EC-1FB9-40F2-A6FC-E89397679F80}']
   function GetGroupId: TUid; stdcall;
   procedure GetLogin(out aRet {: IString}); stdcall;
   function HasPassword: ByteBool; stdcall;
   procedure GetName(out aRet {: IString}); stdcall;
   procedure GetMail(out aRet {: IString}); stdcall;
   function GetUid: Integer; stdcall;
   function IsSystem: ByteBool; stdcall;
   function CanBuyConsulting: ByteBool; stdcall;
   function IsPrivileged: ByteBool; stdcall;
     {* ����������������� ������������ }
   property group_id: TUid
     read GetGroupId;
     {* ������������� ������, � ������� ����������� ������������. }
 end;//IUserProfile

 IUserFilter = interface(IFilterForTree)
  {* ������ ��� ������ ������������� }
   ['{A3970144-43FB-4E18-BBBB-7B246074873E}']
   function GetFlags: Cardinal; stdcall;
   procedure SetFlags(aValue: Cardinal); stdcall;
   function GetGroupUid: TUid; stdcall;
   procedure SetGroupUid(aValue: TUid); stdcall;
   property flags: Cardinal
     read GetFlags
     write SetFlags;
   property group_uid: TUid
     read GetGroupUid
     write SetGroupUid;
     {* ������������� ������ �� ������� ���������� ����������� ���������� }
 end;//IUserFilter

 IProfileNode = interface(INodeBase)
  {* ���� � ������ ������������� }
   ['{A5ED9F82-E286-4359-839E-021E436CA65E}']
   function GetUid: TUid; stdcall;
 end;//IProfileNode

 TrialPeriodExpired = class
  {* ����� ��������������� ������ ������� }
 end;//TrialPeriodExpired

 IUidList = array of TUid;
  {* ������ ������������� }

 AutoregistrationDisabled = class
  {* ��������������� ��������� ��������������� ������� }
 end;//AutoregistrationDisabled

 NoMorePrivilegedProfiles = class
  {* ������ ������� ����� ������������� � ����������������� ������ }
 end;//NoMorePrivilegedProfiles

 IUserManager = interface(IUnknown)
  {* ����� ��� ������ � ��������������. �������� ����� ��� ��������� ������ �������������. }
   ['{F9017C5B-D7D9-4DD0-8E29-BD24E6BA051E}']
   procedure CreateUserWithRights(aName: PAnsiChar;
    aLogin: PAnsiChar;
    aPassword: PAnsiChar;
    aMail: PAnsiChar;
    aCanBuyConsulting: Boolean;
    aIsPrivileged: Boolean;
    aGroupId: TUid); stdcall; // can raise WrongAuthentication, NoMoreProfiles, XMLImportRunning, LoginDuplicate, TrialPeriodExpired, NoMorePrivilegedProfiles
   procedure DeleteUser(aUid: TUid); stdcall; // can raise AccessDenied, CanNotFindData, UserActive
   procedure ChangeUserInfo(aUid: TUid;
    aName: PAnsiChar;
    aMail: PAnsiChar); stdcall; // can raise AccessDenied, CanNotFindData, LicenceViolation, XMLImportRunning
     {* ��������� ���������� ������������ �� �����������
������. ������������ ���������������� �� uid. }
   procedure ChangeUserPassword(aUid: TUid;
    aPassword: PAnsiChar); stdcall; // can raise AccessDenied, CanNotFindData, WrongAuthentication, LicenceViolation, XMLImportRunning
     {* ��������� ������ ������������. ������������ ���������������� �� uid. }
   procedure ChangeUserGroup(aUserId: TUid;
    aGroupId: TUid); stdcall; // can raise AccessDenied, CanNotFindData
   procedure ChangeUsersGroup(const aIdList: IUidList;
    aGroupId: TUid); stdcall; // can raise AccessDenied, CanNotFindData
   procedure UserCanBuyConsulting(aUid: TUid;
    aIsAllowed: Boolean); stdcall; // can raise AccessDenied, CanNotFindData, LicenceViolation, XMLImportRunning
     {* ��������� �������� - ����� �� ������ ������������ ������� �� ������������ }
   procedure UserIsPrivileged(aUid: TUid;
    aIsPrivileged: Boolean); stdcall; // can raise AccessDenied, XMLImportRunning, NoMorePrivilegedProfiles
     {* ���������� �������� ������������������� ��� ������������ }
   procedure LogoutUser(aUid: TUid); stdcall; // can raise AccessDenied, CanNotFindData
   procedure GetSelfProfile(out aRet {: IUserProfile}); stdcall; // can raise CanNotFindData
   procedure SetConsultingPaymentForAll(aIsAllowed: Boolean); stdcall; // can raise AccessDenied
     {* ��������� �������� ������ ������������ ��� ���� ������������� }
   procedure SetConsultingPaymentForNewbies(aIsAllowed: Boolean); stdcall; // can raise AccessDenied
     {* ��������� �������� ������ ������������ ��� ����� ������������� }
   function GetConsultingPaymentForNewbies: ByteBool; stdcall;
     {* ���������� ������� �������� �������� ������ ������������ ��� ����� ������������� (true - ������ ���������) }
   procedure DeleteUsers(const aList: IUidList; out aRet {: IUidList}); stdcall; // can raise AccessDenied
     {* ������� ������ �������������. ���������� ������ �������������, ������� ������� �� �������. }
   procedure LogoutUsers(const aList: IUidList); stdcall; // can raise AccessDenied
     {* ��������� ������ � ������� ���������� ������ �������������. }
   procedure SetConsultingRights(const aList: IUidList;
    aIsPaymentAllowed: Boolean); stdcall; // can raise AccessDenied, InternalDatabaseError
     {* ������ ����� �� ������ ������������ ��� ��������� ������ �������������. }
   procedure SetPrivilegedRights(const aList: IUidList;
    aIsPrivileged: Boolean); stdcall; // can raise AccessDenied, XMLImportRunning, NoMorePrivilegedProfiles
     {* ���������� ����� ������������������� }
   function CanCreatePrivilegedUser: ByteBool; stdcall; // can raise AccessDenied
     {* ����� �� ��������� ����������������� ������������� }
   procedure GetActiveUsersListForNetOneUserVersion(out aRet {: IStringList}); stdcall; // can raise CanNotFindData
     {* ��������� ������ ������, ����������� ������� ������ }
   procedure GetGroupsTree(out aRet {: INodeBase}); stdcall;
     {* �������� ������ ����� }
   procedure GetUsersTree(out aRet {: INodeBase}); stdcall;
     {* �������� ������ ������������� ��� ������ � �������� ��������������� }
   procedure CreateGroup(aName: PAnsiChar); stdcall; // can raise AccessDenied, WrongAuthentication, XMLImportRunning, LoginDuplicate
     {* ������� ������ � �������� ������ }
   procedure DeleteGroup(aUid: TUid); stdcall; // can raise AccessDenied, CanNotFindData
     {* ������� ������ � �������� ��������������� }
   procedure SetNonsearchableBlocksForGroup(aUid: TUid;
    const aBlocksIds: INodeIdList); stdcall; // can raise AccessDenied, CanNotFindData
     {* ���������� ������ ������ ���� �� ������� �������� ����� ������ ������������� }
   procedure GetNonsearchableBlocksForGroup(aUid: TUid; out aRet {: INodeIdList}); stdcall; // can raise AccessDenied, InternalDatabaseError
     {* �������� ������ ������ ���� �� ������� �������� ����� ������ ������������� }
   procedure ChangeGroupName(aUid: TUid;
    aName: PAnsiChar); stdcall; // can raise AccessDenied, CanNotFindData, LoginDuplicate
     {* ������� ��� ������ }
   function HasSharedFilters(aUid: TUid): ByteBool; stdcall;
     {* ����� �� ������� ������������ }
   procedure SetSharedFiltersState(aUid: TUid;
    aState: Boolean); stdcall;
     {* ������������� ������ �������� �� ������� ������������ uid ������ � ������������ �� ��������� state }
   function IsErasable(aUid: TUid): ByteBool; stdcall;
     {* ����� �� ������������ ���� ����� }
   procedure SetErasableState(aUid: TUid;
    aState: Boolean); stdcall;
     {* ��������� �������� - ����� �� ������� ������������ }
 end;//IUserManager

const
  { ���������, ��������� � �������� }
 GROUP_ALL_ID : TUid = 0;
  { ������������� ������ "���" }

type
 IGroupNode = interface(IProfileNode)
  {* ���� ������ ����� }
   ['{1EA308E6-3D7C-4A5C-A1DB-3CA087F94096}']
   function HasUsers: ByteBool; stdcall; // can raise AccessDenied, CanNotFindData
     {* ���� �� � ������ ������������ }
 end;//IGroupNode

implementation

end.