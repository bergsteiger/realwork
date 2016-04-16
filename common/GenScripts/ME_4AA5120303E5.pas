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
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , AdminInterfaces
;

type
 TAdminModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
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
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3String
;

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(Admin)
end.
