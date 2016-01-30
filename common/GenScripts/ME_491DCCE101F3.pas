unit dsQuery;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\dsQuery.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , QueryCardInterfaces
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
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _InitDataType_ = IdeQuery;
 {$Include vcmFormDataSource.imp.pas}
 TdsQuery = {final} class(_vcmFormDataSource_, IdsQuery)
  private
   f_IsQuerySaved: Boolean;
  protected
   function pm_GetQuery: IdeQuery;
   function pm_GetIsQuerySaved: Boolean;
   procedure pm_SetIsQuerySaved(aValue: Boolean);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
 end;//TdsQuery
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3InterfacesMisc
 , SysUtils
 , l3Base
;

type _Instance_R_ = TdsQuery;

{$Include vcmFormDataSource.imp.pas}

function TdsQuery.pm_GetQuery: IdeQuery;
//#UC START# *491DC9970093_491DCCE101F3get_var*
//#UC END# *491DC9970093_491DCCE101F3get_var*
begin
//#UC START# *491DC9970093_491DCCE101F3get_impl*
 Result := PartData;
//#UC END# *491DC9970093_491DCCE101F3get_impl*
end;//TdsQuery.pm_GetQuery

function TdsQuery.pm_GetIsQuerySaved: Boolean;
//#UC START# *491DC9AE0355_491DCCE101F3get_var*
//#UC END# *491DC9AE0355_491DCCE101F3get_var*
begin
//#UC START# *491DC9AE0355_491DCCE101F3get_impl*
 Result := f_IsQuerySaved;
//#UC END# *491DC9AE0355_491DCCE101F3get_impl*
end;//TdsQuery.pm_GetIsQuerySaved

procedure TdsQuery.pm_SetIsQuerySaved(aValue: Boolean);
//#UC START# *491DC9AE0355_491DCCE101F3set_var*
//#UC END# *491DC9AE0355_491DCCE101F3set_var*
begin
//#UC START# *491DC9AE0355_491DCCE101F3set_impl*
 f_IsQuerySaved := aValue;
//#UC END# *491DC9AE0355_491DCCE101F3set_impl*
end;//TdsQuery.pm_SetIsQuerySaved

procedure TdsQuery.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_491DCCE101F3_var*
//#UC END# *479731C50290_491DCCE101F3_var*
begin
//#UC START# *479731C50290_491DCCE101F3_impl*
 f_IsQuerySaved := false;
 inherited;
//#UC END# *479731C50290_491DCCE101F3_impl*
end;//TdsQuery.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
