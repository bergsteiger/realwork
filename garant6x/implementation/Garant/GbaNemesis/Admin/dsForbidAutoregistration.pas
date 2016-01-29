unit dsForbidAutoregistration;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Admin"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Admin/dsForbidAutoregistration.pas"
// Начат: 20.05.2007
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Администратор::Admin::Admin::Admin::TdsForbidAutoregistration
//
// Запрет авторегистрации
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
  AdminInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  AdminDomainInterfaces
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 _FormDataSourceType_ = IdsForbidAutoregistration;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsForbidAutoregistration = {final vac} class(_vcmFormDataSourcePrim_, IdsForbidAutoregistration)
  {* Запрет авторегистрации }
 private
 // private fields
   f_NeedForbid : Boolean;
 protected
 // realized methods
   function pm_GetPhone: Il3CString;
   procedure pm_SetPhone(const aValue: Il3CString);
   function pm_GetEmail: Il3CString;
   procedure pm_SetEmail(const aValue: Il3CString);
   function Get_NeedForbid: Boolean;
   procedure Set_NeedForbid(aValue: Boolean);
 protected
 // overridden protected methods
   procedure InitFields; override;
 end;//TdsForbidAutoregistration
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  DataAdapter,
  l3String,
  l3InterfacesMisc,
  SysUtils,
  l3Base
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

type _Instance_R_ = TdsForbidAutoregistration;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

const
   { Limits }
  c_MaxLength = 50;

// start class TdsForbidAutoregistration

function TdsForbidAutoregistration.pm_GetPhone: Il3CString;
//#UC START# *491D96B9006E_491D9D81001Dget_var*
//#UC END# *491D96B9006E_491D9D81001Dget_var*
begin
//#UC START# *491D96B9006E_491D9D81001Dget_impl*
 Result := DefDataAdapter.AdminInfo.Phone;
//#UC END# *491D96B9006E_491D9D81001Dget_impl*
end;//TdsForbidAutoregistration.pm_GetPhone

procedure TdsForbidAutoregistration.pm_SetPhone(const aValue: Il3CString);
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

procedure TdsForbidAutoregistration.pm_SetEmail(const aValue: Il3CString);
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

{$IfEnd} //Admin

end.