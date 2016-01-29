unit fsAdmin;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/fsAdmin.pas"
// Начат: 07.09.2009 18:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Администратор::Admin::View::Admin::Admin::Admin$FSF
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  ,
  AdminInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx,
  PrimUserProperty_admUseProperties_UserType,
  PrimGroupList_admGroupList_UserType,
  PrimUserList_admUserList_UserType,
  PrimAdmin_utAdmin_UserType,
  Admin_FormDefinitions_Controls
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  l3TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
  Tfs_Admin = {final fsf} class(TvcmFormSetFactory)
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
   function CfAdminParentUtAdminNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для cfAdmin }
   function UserListParentAdmUserListNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для UserList }
   function UserPropertyChildAdmUsePropertiesNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для UserProperty }
   function GroupNavigatorAdmGroupListNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Group }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_Admin;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_Admin
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  l3Base {a},
  l3MessageID,
  SysUtils
  ;
{$IfEnd} //Admin

{$If defined(Admin)}


// start class Tfs_Admin

var g_Tfs_Admin : Tfs_Admin = nil;

procedure Tfs_AdminFree;
begin
 l3Free(g_Tfs_Admin);
end;

class function Tfs_Admin.Instance: Tfs_Admin;
begin
 if (g_Tfs_Admin = nil) then
 begin
  l3System.AddExitProc(Tfs_AdminFree);
  g_Tfs_Admin := Create;
 end;
 Result := g_Tfs_Admin;
end;

var
    { Локализуемые строки GroupCaptionLocalConstants }
   str_fszGroup_Navigator_admGroupListCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fszGroup_Navigator_admGroupListCaption'; rValue : 'Группы пользователей');
    { Заголовок зоны "Group" фабрики сборки форм "Admin$FSF" }

var
    { Локализуемые строки Admin$FSFCaptionLocalConstants }
   str_fsAdminCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsAdminCaption'; rValue : '#1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088');
    { Заголовок фабрики сборки форм "Admin$FSF" }

// start class Tfs_Admin

function Tfs_Admin.CfAdminParentUtAdminNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsAdmin;
begin
 if Supports(aDataSource, IsdsAdmin, l_UseCase) then
  try
//#UC START# *4FFBFE3800EENeedMake_impl*
   aNew := l_UseCase.dsAdmin;
//#UC END# *4FFBFE3800EENeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Admin.CfAdminParentUtAdminNeedMakeForm

function Tfs_Admin.UserListParentAdmUserListNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsAdmin;
begin
 if Supports(aDataSource, IsdsAdmin, l_UseCase) then
  try
//#UC START# *4FFBFFD7007BNeedMake_impl*
   aNew := l_UseCase.dsUserList;
//#UC END# *4FFBFFD7007BNeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Admin.UserListParentAdmUserListNeedMakeForm

function Tfs_Admin.UserPropertyChildAdmUsePropertiesNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsAdmin;
begin
 if Supports(aDataSource, IsdsAdmin, l_UseCase) then
  try
//#UC START# *4FFC005400EENeedMake_impl*
   aNew := l_UseCase.dsUserProperty;
//#UC END# *4FFC005400EENeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Admin.UserPropertyChildAdmUsePropertiesNeedMakeForm

function Tfs_Admin.GroupNavigatorAdmGroupListNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsAdmin;
begin
 if Supports(aDataSource, IsdsAdmin, l_UseCase) then
  try
//#UC START# *4FFBFF43018BNeedMake_impl*
   aNew := l_UseCase.dsGroupsList;
//#UC END# *4FFBFF43018BNeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Admin.GroupNavigatorAdmGroupListNeedMakeForm

class function Tfs_Admin.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_Admin <> nil;
end;//Tfs_Admin.Exists

procedure Tfs_Admin.InitFields;
 {-}
begin
 inherited;
 with AddZone('cfAdmin', vcm_ztParent, fm_cfAdminForm) do
 begin
  UserType := utAdmin;
  with AddZone('UserList', vcm_ztParent, fm_efUserList) do
  begin
   UserType := admUserList;
   OnNeedMakeForm := UserListParentAdmUserListNeedMakeForm;
  end;
  with AddZone('UserProperty', vcm_ztChild, fm_efUserProperty) do
  begin
   UserType := admUseProperties;
   OnNeedMakeForm := UserPropertyChildAdmUsePropertiesNeedMakeForm;
  end;
  OnNeedMakeForm := CfAdminParentUtAdminNeedMakeForm;
 end;
 with AddZone('Group', vcm_ztNavigator, fm_efGroupList) do
 begin
  Caption := str_fszGroup_Navigator_admGroupListCaption.AsCStr;
  UserType := admGroupList;
  OnNeedMakeForm := GroupNavigatorAdmGroupListNeedMakeForm;
 end;
 Caption := str_fsAdminCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_Admin.InitFields

{$If not defined(NoVCM)}
class function Tfs_Admin.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_Admin.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //Admin

initialization
{$If defined(Admin)}
// Инициализация str_fszGroup_Navigator_admGroupListCaption
 str_fszGroup_Navigator_admGroupListCaption.Init;
{$IfEnd} //Admin
{$If defined(Admin)}
// Инициализация str_fsAdminCaption
 str_fsAdminCaption.Init;
{$IfEnd} //Admin

end.