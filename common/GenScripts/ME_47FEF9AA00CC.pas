unit dsListInfo;
 {* Информация о списке. }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\List\dsListInfo.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , WorkWithListInterfaces
 , l3Interfaces
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
;

type
 _InitDataType_ = Il3CString;
 _UseCaseControllerType_ = IsdsListNameHolder;
 {$Include vcmFormDataSourceWithFlexUseCaseControllerType.imp.pas}
 TdsListInfo = {final} class(_vcmFormDataSourceWithFlexUseCaseControllerType_, IdsListInfo)
  {* Информация о списке. }
  private
   f_Info: Il3CString;
  protected
   function pm_GetInfo: Tl3WString;
   function pm_GetListName: Il3CString;
   function pm_GetShortListName: Il3CString;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure GotData; override;
    {* - данные изменились. }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TdsListInfo
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3String
 , SysUtils
 , l3InterfacesMisc
 , l3Base
;

type _Instance_R_ = TdsListInfo;

{$Include vcmFormDataSourceWithFlexUseCaseControllerType.imp.pas}

function TdsListInfo.pm_GetInfo: Tl3WString;
//#UC START# *49005EDD006C_47FEF9AA00CCget_var*
//#UC END# *49005EDD006C_47FEF9AA00CCget_var*
begin
//#UC START# *49005EDD006C_47FEF9AA00CCget_impl*
 if (f_Info <> nil) then
  Result := f_Info.AsWStr
 else
  l3AssignNil(Result);
//#UC END# *49005EDD006C_47FEF9AA00CCget_impl*
end;//TdsListInfo.pm_GetInfo

function TdsListInfo.pm_GetListName: Il3CString;
//#UC START# *49005EEC0338_47FEF9AA00CCget_var*
//#UC END# *49005EEC0338_47FEF9AA00CCget_var*
begin
//#UC START# *49005EEC0338_47FEF9AA00CCget_impl*
 Result := UseCaseController.ListName
//#UC END# *49005EEC0338_47FEF9AA00CCget_impl*
end;//TdsListInfo.pm_GetListName

function TdsListInfo.pm_GetShortListName: Il3CString;
//#UC START# *49005EF9034C_47FEF9AA00CCget_var*
//#UC END# *49005EF9034C_47FEF9AA00CCget_var*
begin
//#UC START# *49005EF9034C_47FEF9AA00CCget_impl*
 Result := UseCaseController.ShortListName
//#UC END# *49005EF9034C_47FEF9AA00CCget_impl*
end;//TdsListInfo.pm_GetShortListName

procedure TdsListInfo.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47FEF9AA00CC_var*
//#UC END# *479731C50290_47FEF9AA00CC_var*
begin
//#UC START# *479731C50290_47FEF9AA00CC_impl*
 f_Info := nil;
 inherited;
//#UC END# *479731C50290_47FEF9AA00CC_impl*
end;//TdsListInfo.Cleanup

{$If NOT Defined(NoVCM)}
procedure TdsListInfo.GotData;
 {* - данные изменились. }
//#UC START# *492ACF630072_47FEF9AA00CC_var*
//#UC END# *492ACF630072_47FEF9AA00CC_var*
begin
//#UC START# *492ACF630072_47FEF9AA00CC_impl*
 inherited;
 f_Info := PartData;
//#UC END# *492ACF630072_47FEF9AA00CC_impl*
end;//TdsListInfo.GotData
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
