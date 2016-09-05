unit Admin_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Admin_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "Admin" MUID: (4AA5120303E5)
// Имя типа: "TAdminModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TAdminModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TAdminModule
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation
 {$IfEnd} // NOT Defined(NoVCM)
 , Admin_Services
 , AdminInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimGroupProperty_admCreateGroup_UserType
 , PrimGroupProperty_admRenameGroup_UserType
 , l3String
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , deNode
 , DataAdapter
 , sdsAdmin
 , deAdmin
 , SysUtils
 , l3Base
 , fsAdmin
 , GroupProperty_Form
 , ForbidAutoregistration_Form
 , UserList_Form
 , UserProperty_Form
 , GroupList_Form
 , Admin_Form
 , Admin_FormDefinitions_Controls
 //#UC START# *4AA5120303E5impl_uses*
 //#UC END# *4AA5120303E5impl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TAdminServiceImpl = {final} class(TvcmModuleContractImplementation, IAdminService)
  public
   function ShowRenameGroupDialog(const aData: IbsEditGroupName): Integer;
   procedure OpenUserList(const aContainer: IvcmContainer);
   class function Instance: TAdminServiceImpl;
    {* Метод получения экземпляра синглетона TAdminServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TAdminServiceImpl

var g_TAdminServiceImpl: TAdminServiceImpl = nil;
 {* Экземпляр синглетона TAdminServiceImpl }

procedure TAdminServiceImplFree;
 {* Метод освобождения экземпляра синглетона TAdminServiceImpl }
begin
 l3Free(g_TAdminServiceImpl);
end;//TAdminServiceImplFree

function TAdminServiceImpl.ShowRenameGroupDialog(const aData: IbsEditGroupName): Integer;
var
 __WasEnter : Boolean;
//#UC START# *4AA8E2C60357_4AA5120303E5_var*
const
 cUserType: array [Boolean] of TvcmUserType = (Ord(admCreateGroup), Ord(admRenameGroup));
var
 l_Form : IvcmEntityForm;
//#UC END# *4AA8E2C60357_4AA5120303E5_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA8E2C60357_4AA5120303E5_impl*
 l_Form := TefGroupProperty.Make(aData,
                                   nil,
                                   vcm_ztManualModal,
                                   cUserType[not l3IsNil(aData.Name)]);
 Result := l_Form.ShowModal;
//#UC END# *4AA8E2C60357_4AA5120303E5_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TAdminServiceImpl.ShowRenameGroupDialog

procedure TAdminServiceImpl.OpenUserList(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AA512AA00C5_4AA5120303E5_var*
//#UC END# *4AA512AA00C5_4AA5120303E5_var*
begin
 __WasEnter := vcmEnterFactory;
 try
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
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TAdminServiceImpl.OpenUserList

class function TAdminServiceImpl.Instance: TAdminServiceImpl;
 {* Метод получения экземпляра синглетона TAdminServiceImpl }
begin
 if (g_TAdminServiceImpl = nil) then
 begin
  l3System.AddExitProc(TAdminServiceImplFree);
  g_TAdminServiceImpl := Create;
 end;
 Result := g_TAdminServiceImpl;
end;//TAdminServiceImpl.Instance

class function TAdminServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TAdminServiceImpl <> nil;
end;//TAdminServiceImpl.Exists

class procedure TAdminModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TefGroupProperty);
 aList.Add(TefForbidAutoregistration);
 aList.Add(TefUserList);
 aList.Add(TefUserProperty);
 aList.Add(TefGroupList);
 aList.Add(TcfAdminForm);
end;//TAdminModule.GetEntityForms

initialization
 TAdminService.Instance.Alien := TAdminServiceImpl.Instance;
 {* Регистрация TAdminServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(Admin)
end.
