unit dsForbidAutoregistration;
 {* Запрет авторегистрации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\dsForbidAutoregistration.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsForbidAutoregistration" MUID: (491D9D81001D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , AdminInterfaces
 , l3Interfaces
 , AdminDomainInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
;

type
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsForbidAutoregistration = {final} class(_vcmFormDataSourcePrim_, IdsForbidAutoregistration)
  {* Запрет авторегистрации }
  private
   f_NeedForbid: Boolean;
  protected
   function pm_GetPhone: Il3CString;
   procedure pm_SetPhone(const aValue: Il3CString); { can raise EdsMaxLengthExceed }
   function pm_GetEmail: Il3CString;
   procedure pm_SetEmail(const aValue: Il3CString); { can raise EdsMaxLengthExceed }
   function Get_NeedForbid: Boolean;
   procedure Set_NeedForbid(aValue: Boolean);
   procedure InitFields; override;
 end;//TdsForbidAutoregistration
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , DataAdapter
 , l3String
 , l3InterfacesMisc
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
const
 c_MaxLength = 50;

type _Instance_R_ = TdsForbidAutoregistration;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

function TdsForbidAutoregistration.pm_GetPhone: Il3CString;
//#UC START# *491D96B9006E_491D9D81001Dget_var*
//#UC END# *491D96B9006E_491D9D81001Dget_var*
begin
//#UC START# *491D96B9006E_491D9D81001Dget_impl*
 Result := DefDataAdapter.AdminInfo.Phone;
//#UC END# *491D96B9006E_491D9D81001Dget_impl*
end;//TdsForbidAutoregistration.pm_GetPhone

procedure TdsForbidAutoregistration.pm_SetPhone(const aValue: Il3CString); { can raise EdsMaxLengthExceed }
//#UC START# *491D96B9006E_491D9D81001Dset_var*
//#UC END# *491D96B9006E_491D9D81001Dset_var*
begin
//#UC START# *491D96B9006E_491D9D81001Dset_impl*
 if l3Len(aValue) > c_MaxLength then
  raise EdsMaxLengthExceed.Create(c_MaxLength);
 DefDataAdapter.AdminInfo.Phone := aValue;
//#UC END# *491D96B9006E_491D9D81001Dset_impl*
end;//TdsForbidAutoregistration.pm_SetPhone

function TdsForbidAutoregistration.pm_GetEmail: Il3CString;
//#UC START# *491D96D0039F_491D9D81001Dget_var*
//#UC END# *491D96D0039F_491D9D81001Dget_var*
begin
//#UC START# *491D96D0039F_491D9D81001Dget_impl*
 Result := DefDataAdapter.AdminInfo.Email;
//#UC END# *491D96D0039F_491D9D81001Dget_impl*
end;//TdsForbidAutoregistration.pm_GetEmail

procedure TdsForbidAutoregistration.pm_SetEmail(const aValue: Il3CString); { can raise EdsMaxLengthExceed }
//#UC START# *491D96D0039F_491D9D81001Dset_var*
//#UC END# *491D96D0039F_491D9D81001Dset_var*
begin
//#UC START# *491D96D0039F_491D9D81001Dset_impl*
 if l3Len(aValue) > c_MaxLength then
  raise EdsMaxLengthExceed.Create(c_MaxLength);
 DefDataAdapter.AdminInfo.Email := aValue;
//#UC END# *491D96D0039F_491D9D81001Dset_impl*
end;//TdsForbidAutoregistration.pm_SetEmail

function TdsForbidAutoregistration.Get_NeedForbid: Boolean;
//#UC START# *4B02D4DD00FC_491D9D81001Dget_var*
//#UC END# *4B02D4DD00FC_491D9D81001Dget_var*
begin
//#UC START# *4B02D4DD00FC_491D9D81001Dget_impl*
 Result := f_NeedForbid;
//#UC END# *4B02D4DD00FC_491D9D81001Dget_impl*
end;//TdsForbidAutoregistration.Get_NeedForbid

procedure TdsForbidAutoregistration.Set_NeedForbid(aValue: Boolean);
//#UC START# *4B02D4DD00FC_491D9D81001Dset_var*
//#UC END# *4B02D4DD00FC_491D9D81001Dset_var*
begin
//#UC START# *4B02D4DD00FC_491D9D81001Dset_impl*
 f_NeedForbid := aValue;
//#UC END# *4B02D4DD00FC_491D9D81001Dset_impl*
end;//TdsForbidAutoregistration.Set_NeedForbid

procedure TdsForbidAutoregistration.InitFields;
//#UC START# *47A042E100E2_491D9D81001D_var*
//#UC END# *47A042E100E2_491D9D81001D_var*
begin
//#UC START# *47A042E100E2_491D9D81001D_impl*
 inherited;
 f_NeedForbid := false;
//#UC END# *47A042E100E2_491D9D81001D_impl*
end;//TdsForbidAutoregistration.InitFields
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(Admin)
end.
