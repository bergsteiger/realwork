unit fsAdmin;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\fsAdmin.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "Admin" MUID: (4AA5128C0195)
// Имя типа: "Tfs_Admin"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimAdmin_utAdmin_UserType
 , Admin_FormDefinitions_Controls
 , AdminInterfaces
 , l3TreeInterfaces
 , PrimGroupList_admGroupList_UserType
 , PrimUserList_admUserList_UserType
 , PrimUserProperty_admUseProperties_UserType
;

type
 Tfs_Admin = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
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
   class function Instance: Tfs_Admin;
    {* Метод получения экземпляра синглетона Tfs_Admin }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_Admin
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , l3StringIDEx
 , SysUtils
 , l3Base
 //#UC START# *4AA5128C0195impl_uses*
 //#UC END# *4AA5128C0195impl_uses*
;

{$If NOT Defined(NoVCM)}
var g_Tfs_Admin: Tfs_Admin = nil;
 {* Экземпляр синглетона Tfs_Admin }

const
 {* Локализуемые строки GroupCaptionLocalConstants }
 str_fszGroup_Navigator_admGroupListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fszGroup_Navigator_admGroupListCaption'; rValue : 'Группы пользователей');
  {* Заголовок зоны "Group" фабрики сборки форм "Admin$FSF" }
 {* Локализуемые строки Admin }
 str_fsAdminCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsAdminCaption'; rValue : '#1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088');
  {* Заголовок фабрики сборки форм "Admin$FSF" }

procedure Tfs_AdminFree;
 {* Метод освобождения экземпляра синглетона Tfs_Admin }
begin
 l3Free(g_Tfs_Admin);
end;//Tfs_AdminFree

function Tfs_Admin.CfAdminParentUtAdminNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для cfAdmin }
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
 {* Обработчик OnNeedMakeForm для UserList }
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
 {* Обработчик OnNeedMakeForm для UserProperty }
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
 {* Обработчик OnNeedMakeForm для Group }
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

class function Tfs_Admin.Instance: Tfs_Admin;
 {* Метод получения экземпляра синглетона Tfs_Admin }
begin
 if (g_Tfs_Admin = nil) then
 begin
  l3System.AddExitProc(Tfs_AdminFree);
  g_Tfs_Admin := Create;
 end;
 Result := g_Tfs_Admin;
end;//Tfs_Admin.Instance

class function Tfs_Admin.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_Admin <> nil;
end;//Tfs_Admin.Exists

procedure Tfs_Admin.InitFields;
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

class function Tfs_Admin.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_Admin.GetInstance

initialization
 str_fszGroup_Navigator_admGroupListCaption.Init;
 {* Инициализация str_fszGroup_Navigator_admGroupListCaption }
 str_fsAdminCaption.Init;
 {* Инициализация str_fsAdminCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(Admin)
end.
