unit AdminDomainInterfaces;
 {* Администрирование }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Model\AdminDomainInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "AdminDomainInterfaces" MUID: (49903C95009E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , SysUtils
 , l3Interfaces
;

type
 EdsMaxLengthExceed = class(Exception)
  {* Превышена допустимая длинна строки }
  private
   f_MaxLength: Integer;
    {* Поле для свойства MaxLength }
  public
   constructor Create; reintroduce;
  public
   property MaxLength: Integer
    read f_MaxLength;
 end;//EdsMaxLengthExceed

 InsAdminInfo = interface
  {* Информация об администраторе }
  ['{61BE9766-54B8-4A29-A794-8E08259285B1}']
  function pm_GetHasEmail: Boolean;
  function pm_GetHasPhone: Boolean;
  function pm_GetPhone: Il3CString;
  procedure pm_SetPhone(const aValue: Il3CString); { can raise EdsMaxLengthExceed }
  function pm_GetEmail: Il3CString;
  procedure pm_SetEmail(const aValue: Il3CString); { can raise EdsMaxLengthExceed }
  property HasEmail: Boolean
   read pm_GetHasEmail;
  property HasPhone: Boolean
   read pm_GetHasPhone;
  property Phone: Il3CString
   read pm_GetPhone
   write pm_SetPhone;
  property Email: Il3CString
   read pm_GetEmail
   write pm_SetEmail;
 end;//InsAdminInfo

 (*
 nsUserProperty = interface
  function Get_UID: Integer;
  function Get_GroupUID: Integer;
  function Get_Login: Il3CString;
  function Get_Name: Il3CString;
  function Get_Mail: Il3CString;
  function Get_IsChanged: Boolean;
  procedure Set_IsChanged(aValue: Boolean);
  function Get_IsNewUser: Boolean;
  function Get_CanBuyConsulting: Boolean;
  function Get_IsSystem: Boolean;
  function Get_IsPrivileged: Boolean;
  function Get_DontDeleteIdle: Boolean;
  function HasUserProfile: Boolean;
  function HasPassword: Boolean;
  procedure SaveUserProfile(const aName: Tl3WString;
   const aMail: Tl3WString;
   aCanBuyConsulting: Boolean;
   aIsPrivileged: Boolean;
   aDontDeleteIdle: Boolean;
   const aPassword: Tl3WString;
   aGroupUID: Integer;
   IsPasswordChanged: Boolean = False);
  procedure SaveUserInfo(const aName: Tl3WString;
   const aMail: Tl3WString;
   const aPassword: Tl3WString;
   IsPasswordChanged: Boolean = False);
  property UID: Integer
   read Get_UID;
  property GroupUID: Integer
   read Get_GroupUID;
  property Login: Il3CString
   read Get_Login;
  property Name: Il3CString
   read Get_Name;
  property Mail: Il3CString
   read Get_Mail;
  property IsChanged: Boolean
   read Get_IsChanged
   write Set_IsChanged;
  property IsNewUser: Boolean
   read Get_IsNewUser;
  property CanBuyConsulting: Boolean
   read Get_CanBuyConsulting;
  property IsSystem: Boolean
   read Get_IsSystem;
  property IsPrivileged: Boolean
   read Get_IsPrivileged;
  property DontDeleteIdle: Boolean
   read Get_DontDeleteIdle;
 end;//nsUserProperty
 *)

 InsUserProperty = interface
  ['{1DD2D30F-4FAB-4F0C-B591-CB76CADDB345}']
  function Get_UID: Integer;
  function Get_GroupUID: Integer;
  function Get_Login: Il3CString;
  function Get_Name: Il3CString;
  function Get_Mail: Il3CString;
  function Get_IsChanged: Boolean;
  procedure Set_IsChanged(aValue: Boolean);
  function Get_IsNewUser: Boolean;
  function Get_CanBuyConsulting: Boolean;
  function Get_IsSystem: Boolean;
  function Get_IsPrivileged: Boolean;
  function Get_DontDeleteIdle: Boolean;
  function HasUserProfile: Boolean;
  function HasPassword: Boolean;
  procedure SaveUserProfile(const aName: Tl3WString;
   const aMail: Tl3WString;
   aCanBuyConsulting: Boolean;
   aIsPrivileged: Boolean;
   aDontDeleteIdle: Boolean;
   const aPassword: Tl3WString;
   aGroupUID: Integer;
   IsPasswordChanged: Boolean = False);
  procedure SaveUserInfo(const aName: Tl3WString;
   const aMail: Tl3WString;
   const aPassword: Tl3WString;
   IsPasswordChanged: Boolean = False);
  property UID: Integer
   read Get_UID;
  property GroupUID: Integer
   read Get_GroupUID;
  property Login: Il3CString
   read Get_Login;
  property Name: Il3CString
   read Get_Name;
  property Mail: Il3CString
   read Get_Mail;
  property IsChanged: Boolean
   read Get_IsChanged
   write Set_IsChanged;
  property IsNewUser: Boolean
   read Get_IsNewUser;
  property CanBuyConsulting: Boolean
   read Get_CanBuyConsulting;
  property IsSystem: Boolean
   read Get_IsSystem;
  property IsPrivileged: Boolean
   read Get_IsPrivileged;
  property DontDeleteIdle: Boolean
   read Get_DontDeleteIdle;
 end;//InsUserProperty

implementation

uses
 l3ImplUses
;

end.
