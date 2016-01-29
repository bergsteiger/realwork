unit dsQuery;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Consultation"
// Автор: Морозов М.А
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Consultation/dsQuery.pas"
// Начат: 06.04.2006 17.27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Пользовательские сервисы::Consultation::Consultation::Consultation::TdsQuery
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
  QueryCardInterfaces
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
  l3NotifyPtrList
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsQuery;
 _InitDataType_ = IdeQuery;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}
 TdsQuery = {final vac} class(_vcmFormDataSource_, IdsQuery)
 private
 // private fields
   f_IsQuerySaved : Boolean;
 protected
 // realized methods
   function pm_GetQuery: IdeQuery;
   function pm_GetIsQuerySaved: Boolean;
   procedure pm_SetIsQuerySaved(aValue: Boolean);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 end;//TdsQuery
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3InterfacesMisc,
  SysUtils,
  l3Base
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsQuery;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}

// start class TdsQuery

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
//#UC START# *479731C50290_491DCCE101F3_var*
//#UC END# *479731C50290_491DCCE101F3_var*
begin
//#UC START# *479731C50290_491DCCE101F3_impl*
 f_IsQuerySaved := false;
 inherited;
//#UC END# *479731C50290_491DCCE101F3_impl*
end;//TdsQuery.Cleanup

{$IfEnd} //not Admin AND not Monitorings

end.