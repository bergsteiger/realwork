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
 // UserList

 // UserProperty

 // cfAdmin

 // Group

 Tfs_Admin = {final} class(TvcmFormSetFactory)
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function cfAdmin_Parent_utAdmin_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для cfAdmin }
   function UserList_Parent_admUserList_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для UserList }
   function UserProperty_Child_admUseProperties_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для UserProperty }
   function Group_Navigator_admGroupList_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Group }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_Admin;
    {* Метод получения экземпляра синглетона Tfs_Admin }
 end;//Tfs_Admin
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
var g_Tfs_Admin: Tfs_Admin = nil;
 {* Экземпляр синглетона Tfs_Admin }

const
 {* Локализуемые строки GroupCaptionLocalConstants }
 str_fszGroup_Navigator_admGroupListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fszGroup_Navigator_admGroupListCaption'; rValue : 'Группы пользователей');
  {* Заголовок зоны "Group" фабрики сборки форм "Admin$FSF" }
 {* Локализуемые строки Admin$FSFCaptionLocalConstants }
 str_fsAdminCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsAdminCaption'; rValue : '#1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088');
  {* Заголовок фабрики сборки форм "Admin$FSF" }

procedure Tfs_AdminFree;
 {* Метод освобождения экземпляра синглетона Tfs_Admin }
begin
 l3Free(g_Tfs_Admin);
end;//Tfs_AdminFree

function Tfs_Admin.cfAdmin_Parent_utAdmin_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для cfAdmin }
//#UC START# *1007F0CF991F_4AA5128C0195_var*
//#UC END# *1007F0CF991F_4AA5128C0195_var*
begin
//#UC START# *1007F0CF991F_4AA5128C0195_impl*
 !!! Needs to be implemented !!!
//#UC END# *1007F0CF991F_4AA5128C0195_impl*
end;//Tfs_Admin.cfAdmin_Parent_utAdmin_NeedMakeForm

function Tfs_Admin.UserList_Parent_admUserList_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для UserList }
//#UC START# *720A775B67FA_4AA5128C0195_var*
//#UC END# *720A775B67FA_4AA5128C0195_var*
begin
//#UC START# *720A775B67FA_4AA5128C0195_impl*
 !!! Needs to be implemented !!!
//#UC END# *720A775B67FA_4AA5128C0195_impl*
end;//Tfs_Admin.UserList_Parent_admUserList_NeedMakeForm

function Tfs_Admin.UserProperty_Child_admUseProperties_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для UserProperty }
//#UC START# *8649E2AD1CE7_4AA5128C0195_var*
//#UC END# *8649E2AD1CE7_4AA5128C0195_var*
begin
//#UC START# *8649E2AD1CE7_4AA5128C0195_impl*
 !!! Needs to be implemented !!!
//#UC END# *8649E2AD1CE7_4AA5128C0195_impl*
end;//Tfs_Admin.UserProperty_Child_admUseProperties_NeedMakeForm

function Tfs_Admin.Group_Navigator_admGroupList_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Group }
//#UC START# *40E91BB8FEEC_4AA5128C0195_var*
//#UC END# *40E91BB8FEEC_4AA5128C0195_var*
begin
//#UC START# *40E91BB8FEEC_4AA5128C0195_impl*
 !!! Needs to be implemented !!!
//#UC END# *40E91BB8FEEC_4AA5128C0195_impl*
end;//Tfs_Admin.Group_Navigator_admGroupList_NeedMakeForm

class function Tfs_Admin.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_Admin <> nil;
end;//Tfs_Admin.Exists

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

procedure Tfs_Admin.InitFields;
//#UC START# *47A042E100E2_4AA5128C0195_var*
//#UC END# *47A042E100E2_4AA5128C0195_var*
begin
//#UC START# *47A042E100E2_4AA5128C0195_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA5128C0195_impl*
end;//Tfs_Admin.InitFields

class function Tfs_Admin.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA5128C0195_var*
//#UC END# *4FFE854A009B_4AA5128C0195_var*
begin
//#UC START# *4FFE854A009B_4AA5128C0195_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA5128C0195_impl*
end;//Tfs_Admin.GetInstance

initialization
 str_fszGroup_Navigator_admGroupListCaption.Init;
 {* Инициализация str_fszGroup_Navigator_admGroupListCaption }
 str_fsAdminCaption.Init;
 {* Инициализация str_fsAdminCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(Admin)
end.
