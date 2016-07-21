unit SecurityUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\SecurityUnit.pas"
// ���������: "Interfaces"
// ������� ������: "Security" MUID: (45EEAA96039C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , DynamicTreeUnit
 , DynamicTreeDefinesUnit
;

const
 UFF_USER_ACTIVE: Cardinal = 1;
 UFF_USER_NOT_ACTIVE: Cardinal = 2;
 UFF_USER_SYSTEM: Cardinal = 4;
 UFF_USER_NOT_SYSTEM: Cardinal = 8;
 UFF_USER_NOT_CURRENT: Cardinal = 16;
 UFF_GUEST_USER: Cardinal = 32;
 UFF_NOT_GUEST_USER: Cardinal = 64;
 UFF_USER_CAN_BUY_CONSULTING: Cardinal = 128;
 UFF_USER_CANT_BUY_CONSULTING: Cardinal = 256;
 UFF_USER_PRIVILEGED: Cardinal = 512;
 UFF_USER_NOT_PRIVILEGED: Cardinal = 1024;
 UFF_GROUP_UID: Cardinal = 2048;
  {* ������� ������������� ������ �������� ������ }
 UFF_NOT_GROUPPED_USERS: Cardinal = 4096;
  {* ������������, �������� ������ � ������ ��� }
 UFF_CHAT_CONTACT_LIST_USERS: Cardinal = 8192;
  {* ������ �� ������������, ������� �������� � ������ ��������� ��� ���� �������� ������������ }
 {* ��������� � ������� ����� ��������� ������������ � ����� ������ �� �����������. }
 PNT_LOGGED_FLAG: TNodeType = 1;
  {* ������������ � ������ ������ �������� � ������� }
 PNT_SYSTEM_FLAG: TNodeType = 2;
  {* ������� ����������� }
 PNT_EXIT_FLAG: TNodeType = 4;
 PNT_PRIVILEGED_FLAG: TNodeType = 8;
 {* ���������, ��������� � �������� }
 GROUP_ALL_ID: TUid = 0;
  {* ������������� ������ "���" }

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

 IUserProfile = interface(IEntityBase)
  {* ���������� � ������������ }
  ['{600B24EC-1FB9-40F2-A6FC-E89397679F80}']
  function GetGroupId: TUid; stdcall; { can raise AccessDenied }
  procedure GetLogin(out aRet
   {* IString }); stdcall;
  function HasPassword: ByteBool; stdcall;
  procedure GetName(out aRet
   {* IString }); stdcall;
  procedure GetMail(out aRet
   {* IString }); stdcall;
  function GetUid: Integer; stdcall;
  function IsSystem: ByteBool; stdcall;
  function CanBuyConsulting: ByteBool; stdcall;
  function IsPrivileged: ByteBool; stdcall;
   {* ����������������� ������������ }
  property GroupId: TUid
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
  property Flags: Cardinal
   read GetFlags
   write SetFlags;
  property GroupUid: TUid
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

 IUserManager = interface
  {* ����� ��� ������ � ��������������. �������� ����� ��� ��������� ������ �������������. }
  ['{F9017C5B-D7D9-4DD0-8E29-BD24E6BA051E}']
  procedure CreateUserWithRights(name: PAnsiChar;
   login: PAnsiChar;
   password: PAnsiChar;
   mail: PAnsiChar;
   can_buy_consulting: Boolean;
   is_privileged: Boolean;
   group_id: TUid); stdcall; { can raise WrongAuthentication, NoMoreProfiles, XMLImportRunning, LoginDuplicate, TrialPeriodExpired, NoMorePrivilegedProfiles }
  procedure DeleteUser(uid: TUid); stdcall; { can raise AccessDenied, CanNotFindData, UserActive }
  procedure ChangeUserInfo(uid: TUid;
   name: PAnsiChar;
   mail: PAnsiChar); stdcall; { can raise AccessDenied, CanNotFindData, LicenceViolation, XMLImportRunning }
   {* ��������� ���������� ������������ �� �����������
������. ������������ ���������������� �� uid. }
  procedure ChangeUserPassword(uid: TUid;
   password: PAnsiChar); stdcall; { can raise AccessDenied, CanNotFindData, WrongAuthentication, LicenceViolation, XMLImportRunning }
   {* ��������� ������ ������������. ������������ ���������������� �� uid. }
  procedure ChangeUserGroup(user_id: TUid;
   group_id: TUid); stdcall; { can raise AccessDenied, CanNotFindData }
  procedure ChangeUsersGroup(const id_list: IUidList;
   group_id: TUid); stdcall; { can raise AccessDenied, CanNotFindData }
  procedure UserCanBuyConsulting(uid: TUid;
   is_allowed: Boolean); stdcall; { can raise AccessDenied, CanNotFindData, LicenceViolation, XMLImportRunning }
   {* ��������� �������� - ����� �� ������ ������������ ������� �� ������������ }
  procedure UserIsPrivileged(uid: TUid;
   is_privileged: Boolean); stdcall; { can raise AccessDenied, XMLImportRunning, NoMorePrivilegedProfiles }
   {* ���������� �������� ������������������� ��� ������������ }
  procedure LogoutUser(uid: TUid); stdcall; { can raise AccessDenied, CanNotFindData }
  procedure GetSelfProfile(out aRet
   {* IUserProfile }); stdcall; { can raise CanNotFindData }
  procedure SetConsultingPaymentForAll(is_allowed: Boolean); stdcall; { can raise AccessDenied }
   {* ��������� �������� ������ ������������ ��� ���� ������������� }
  procedure SetConsultingPaymentForNewbies(is_allowed: Boolean); stdcall; { can raise AccessDenied }
   {* ��������� �������� ������ ������������ ��� ����� ������������� }
  function GetConsultingPaymentForNewbies: ByteBool; stdcall;
   {* ���������� ������� �������� �������� ������ ������������ ��� ����� ������������� (true - ������ ���������) }
  procedure DeleteUsers(const list: IUidList;
   out aRet
   {* IUidList }); stdcall; { can raise AccessDenied }
   {* ������� ������ �������������. ���������� ������ �������������, ������� ������� �� �������. }
  procedure LogoutUsers(const list: IUidList); stdcall; { can raise AccessDenied }
   {* ��������� ������ � ������� ���������� ������ �������������. }
  procedure SetConsultingRights(const list: IUidList;
   is_payment_allowed: Boolean); stdcall; { can raise AccessDenied, InternalDatabaseError }
   {* ������ ����� �� ������ ������������ ��� ��������� ������ �������������. }
  procedure SetPrivilegedRights(const list: IUidList;
   is_privileged: Boolean); stdcall; { can raise AccessDenied, XMLImportRunning, NoMorePrivilegedProfiles }
   {* ���������� ����� ������������������� }
  function CanCreatePrivilegedUser: ByteBool; stdcall; { can raise AccessDenied }
   {* ����� �� ��������� ����������������� ������������� }
  procedure GetActiveUsersListForNetOneUserVersion(out aRet
   {* IStringList }); stdcall; { can raise CanNotFindData }
   {* ��������� ������ ������, ����������� ������� ������ }
  procedure GetGroupsTree(out aRet
   {* INodeBase }); stdcall;
   {* �������� ������ ����� }
  procedure GetUsersTree(out aRet
   {* INodeBase }); stdcall;
   {* �������� ������ ������������� ��� ������ � �������� ��������������� }
  procedure CreateGroup(name: PAnsiChar); stdcall; { can raise AccessDenied, WrongAuthentication, XMLImportRunning, LoginDuplicate }
   {* ������� ������ � �������� ������ }
  procedure DeleteGroup(uid: TUid); stdcall; { can raise AccessDenied, CanNotFindData }
   {* ������� ������ � �������� ��������������� }
  procedure SetNonsearchableBlocksForGroup(uid: TUid;
   const blocks_ids: INodeIdList); stdcall; { can raise AccessDenied, CanNotFindData }
   {* ���������� ������ ������ ���� �� ������� �������� ����� ������ ������������� }
  procedure GetNonsearchableBlocksForGroup(uid: TUid;
   out aRet
   {* INodeIdList }); stdcall; { can raise AccessDenied, InternalDatabaseError }
   {* �������� ������ ������ ���� �� ������� �������� ����� ������ ������������� }
  procedure ChangeGroupName(uid: TUid;
   name: PAnsiChar); stdcall; { can raise AccessDenied, CanNotFindData, LoginDuplicate }
   {* ������� ��� ������ }
  function HasSharedFilters(uid: TUid): ByteBool; stdcall;
   {* ����� �� ������� ������������ }
  procedure SetSharedFiltersState(uid: TUid;
   state: Boolean); stdcall;
   {* ������������� ������ �������� �� ������� ������������ uid ������ � ������������ �� ��������� state }
  function IsErasable(uid: TUid): ByteBool; stdcall;
   {* ����� �� ������������ ���� ����� }
  procedure SetErasableState(uid: TUid;
   state: Boolean); stdcall;
   {* ��������� �������� - ����� �� ������� ������������ }
 end;//IUserManager

 IGroupNode = interface(IProfileNode)
  {* ���� ������ ����� }
  ['{1EA308E6-3D7C-4A5C-A1DB-3CA087F94096}']
  function HasUsers: ByteBool; stdcall; { can raise AccessDenied, CanNotFindData }
   {* ���� �� � ������ ������������ }
 end;//IGroupNode

implementation

uses
 l3ImplUses
;

end.
