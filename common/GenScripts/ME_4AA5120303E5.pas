unit Admin_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Admin_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , AdminInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
 , PrimAdmin_utAdmin_UserType
 , Admin_FormDefinitions_Controls
 , l3TreeInterfaces
 , PrimUserList_admUserList_UserType
 , PrimUserProperty_admUseProperties_UserType
 , PrimGroupList_admGroupList_UserType
 , PrimGroupPropertyOptions_Form
 , PrimForbidAutoregistrationOptions_Form
 , PrimUserListOptions_Form
 , PrimUserPropertyOptions_Form
 , PrimGroupListOptions_Form
 , PrimAdminOptions_Form
;

const
 fm_efGroupProperty: TvcmFormDescriptor = (rFormID : (rName : 'efGroupProperty'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefGroupProperty }

const
 fm_efForbidAutoregistration: TvcmFormDescriptor = (rFormID : (rName : 'efForbidAutoregistration'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefForbidAutoregistration }

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

 GroupPropertyFormDef = interface
  {* Идентификатор формы GroupProperty }
  ['{F213AE84-ECF9-427D-8B89-53C6221D1F27}']
 end;//GroupPropertyFormDef

 TefGroupProperty = {final} class(TPrimGroupPropertyOptionsForm, GroupPropertyFormDef)
  {* Свойства группы }
 end;//TefGroupProperty

 ForbidAutoregistrationFormDef = interface
  {* Идентификатор формы ForbidAutoregistration }
  ['{5D4153F1-D087-4AF8-A4ED-39411EB7A1A3}']
 end;//ForbidAutoregistrationFormDef

 TefForbidAutoregistration = {final} class(TPrimForbidAutoregistrationOptionsForm, ForbidAutoregistrationFormDef)
  {* Запретить авторегистрацию }
 end;//TefForbidAutoregistration

 TefUserList = {final} class(TPrimUserListOptionsForm, UserListFormDef)
 end;//TefUserList

 TefUserProperty = {final} class(TPrimUserPropertyOptionsForm, UserPropertyFormDef)
  {* Свойства пользователя }
 end;//TefUserProperty

 TefGroupList = {final} class(TPrimGroupListOptionsForm, GroupListFormDef)
  {* Группы пользователей }
 end;//TefGroupList

 TcfAdminForm = {final} class(TPrimAdminOptionsForm, AdminFormFormDef)
  {* Администрирование пользователей }
 end;//TcfAdminForm

 TAdminModule = class
  public
   procedure OpenUserList(const aContainer: IvcmContainer);
   function ShowRenameGroupDialog(const aData: IbsEditGroupName): Integer;
 end;//TAdminModule
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , PrimGroupProperty_admCreateGroup_UserType
 , PrimGroupProperty_admRenameGroup_UserType
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , deAdmin
 , sdsAdmin
 , DataAdapter
 , deNode
 , l3String
 , l3MessageID
 , SysUtils
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , GroupPropertyKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ForbidAutoregistrationKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , UserListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , UserPropertyKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , GroupListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , AdminFormKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

var g_Tfs_Admin: Tfs_Admin = nil;
 {* Экземпляр синглетона Tfs_Admin }

const
 {* Локализуемые строки GroupCaptionLocalConstants }
 str_fszGroup_Navigator_admGroupListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fszGroup_Navigator_admGroupListCaption'; rValue : 'Группы пользователей');
  {* Заголовок зоны "Group" фабрики сборки форм "Admin$FSF" }
 {* Локализуемые строки Admin$FSFCaptionLocalConstants }
 str_fsAdminCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsAdminCaption'; rValue : '#1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088');
  {* Заголовок фабрики сборки форм "Admin$FSF" }

const
 {* Локализуемые строки ut_ForbidAutoregistrationLocalConstants }
 str_ut_ForbidAutoregistrationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_ForbidAutoregistrationCaption'; rValue : 'Запретить авторегистрацию');
  {* Заголовок пользовательского типа "Запретить авторегистрацию" }

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

{$If NOT Defined(NoVCM)}
class function Tfs_Admin.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA5128C0195_var*
//#UC END# *4FFE854A009B_4AA5128C0195_var*
begin
//#UC START# *4FFE854A009B_4AA5128C0195_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA5128C0195_impl*
end;//Tfs_Admin.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

procedure TAdminModule.OpenUserList(const aContainer: IvcmContainer);
//#UC START# *4AA512AA00C5_4AA5120303E5_var*
//#UC END# *4AA512AA00C5_4AA5120303E5_var*
begin
//#UC START# *4AA512AA00C5_4AA5120303E5_impl*
 // Данные для инициализации сборки администратор
 if DefDataAdapter.AdministratorLogin then
  Tfs_Admin.Make(TsdsAdmin.Make(
                  TdeAdmin.Make(
                   TdeNode.Make(defDataAdapter.GetGroupsTree),
                   TdeNode.Make(defDataAdapter.GetUsersTree)
                  )
                 ), aContainer);
//#UC END# *4AA512AA00C5_4AA5120303E5_impl*
end;//TAdminModule.OpenUserList

function TAdminModule.ShowRenameGroupDialog(const aData: IbsEditGroupName): Integer;
var l_Form: IvcmEntityForm;
//#UC START# *4AA8E2C60357_4AA5120303E5_var*
const
 cUserType: array [Boolean] of TvcmUserType = (Ord(admCreateGroup), Ord(admRenameGroup));
//#UC END# *4AA8E2C60357_4AA5120303E5_var*
begin
//#UC START# *4AA8E2C60357_4AA5120303E5_impl*
 l_Form := TefGroupProperty.Make(aData,
                                   nil,
                                   vcm_ztManualModal,
                                   cUserType[not l3IsNil(aData.Name)]);
 Result := l_Form.ShowModal;
//#UC END# *4AA8E2C60357_4AA5120303E5_impl*
end;//TAdminModule.ShowRenameGroupDialog

initialization
 str_fszGroup_Navigator_admGroupListCaption.Init;
 {* Инициализация str_fszGroup_Navigator_admGroupListCaption }
 str_fsAdminCaption.Init;
 {* Инициализация str_fsAdminCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefGroupProperty);
 {* Регистрация GroupProperty }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefForbidAutoregistration);
 {* Регистрация ForbidAutoregistration }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_ForbidAutoregistrationCaption.Init;
 {* Инициализация str_ut_ForbidAutoregistrationCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefUserList);
 {* Регистрация UserList }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efUserList.SetFactory(TefUserList.Make);
 {* Регистрация фабрики формы UserList }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefUserProperty);
 {* Регистрация UserProperty }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efUserProperty.SetFactory(TefUserProperty.Make);
 {* Регистрация фабрики формы UserProperty }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefGroupList);
 {* Регистрация GroupList }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efGroupList.SetFactory(TefGroupList.Make);
 {* Регистрация фабрики формы GroupList }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TcfAdminForm);
 {* Регистрация AdminForm }
{$IfEnd} // NOT Defined(NoScripts)
 fm_cfAdminForm.SetFactory(TcfAdminForm.Make);
 {* Регистрация фабрики формы AdminForm }
{$IfEnd} // Defined(Admin)

end.
