unit dsListInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/List/dsListInfo.pas"
// Начат: 29.07.2005 17.07
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::ListDataSources::TdsListInfo
//
// Информация о списке.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces,
  WorkWithListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3NotifyPtrList
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsListInfo;
 _InitDataType_ = Il3CString;
 _UseCaseControllerType_ = IsdsListNameHolder;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourceWithFlexUseCaseControllerType.imp.pas}
 TdsListInfo = {final vac} class(_vcmFormDataSourceWithFlexUseCaseControllerType_, IdsListInfo)
  {* Информация о списке. }
 private
 // private fields
   f_Info : Il3CString;
 protected
 // realized methods
   function pm_GetInfo: Tl3WString;
   function pm_GetListName: Il3CString;
   function pm_GetShortListName: Il3CString;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   procedure GotData; override;
     {* - данные изменились. }
   {$IfEnd} //not NoVCM
 end;//TdsListInfo
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3String,
  SysUtils,
  l3InterfacesMisc,
  l3Base
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsListInfo;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourceWithFlexUseCaseControllerType.imp.pas}

// start class TdsListInfo

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
//#UC START# *479731C50290_47FEF9AA00CC_var*
//#UC END# *479731C50290_47FEF9AA00CC_var*
begin
//#UC START# *479731C50290_47FEF9AA00CC_impl*
 f_Info := nil;
 inherited;
//#UC END# *479731C50290_47FEF9AA00CC_impl*
end;//TdsListInfo.Cleanup

{$If not defined(NoVCM)}
procedure TdsListInfo.GotData;
//#UC START# *492ACF630072_47FEF9AA00CC_var*
//#UC END# *492ACF630072_47FEF9AA00CC_var*
begin
//#UC START# *492ACF630072_47FEF9AA00CC_impl*
 inherited;
 f_Info := PartData;
//#UC END# *492ACF630072_47FEF9AA00CC_impl*
end;//TdsListInfo.GotData
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.