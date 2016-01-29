unit sdsQuery;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Consultation"
// Автор: Морозов М.А
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Consultation/sdsQuery.pas"
// Начат: 2006/04/07 08:36:15
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Пользовательские сервисы::Consultation::Consultation::Consultation::TsdsQuery
//
// Бизнес объект прецедента "Поисковый запрос"
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
  ConsultationInterfaces,
  dsQuery
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  QueryCardInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsQueryClass = class of dsQuery.TdsQuery;

 _InitDataType_ = IdeQuery;
 _SetType_ = IsdsQuery;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}
 TsdsQuery = {final ucc} class(_vcmFormSetDataSourceWithoutData_, IsdsQuery)
  {* Бизнес объект прецедента "Поисковый запрос" }
 private
 // private fields
   f_dsQuery : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsQuery}
   f_dsSaveLoad : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsSaveLoad}
 protected
 // realized methods
   function pm_GetDsQuery: IdsQuery;
   function DoGet_dsQuery: IdsQuery;
   function pm_GetDsSaveLoad: IdsSaveLoad;
   function DoGet_dsSaveLoad: IdsSaveLoad;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   function GetQueryClass: TdsQueryClass; virtual;
 end;//TsdsQuery
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsSaveLoad
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3Base,
  SysUtils,
  vcmFormDataSourceRef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsQuery;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}

// start class TsdsQuery

function TsdsQuery.GetQueryClass: TdsQueryClass;
//#UC START# *492FEE0000FD_492FECE300EA_var*
//#UC END# *492FEE0000FD_492FECE300EA_var*
begin
//#UC START# *492FEE0000FD_492FECE300EA_impl*
 Result := TdsQuery;
//#UC END# *492FEE0000FD_492FECE300EA_impl*
end;//TsdsQuery.GetQueryClass

function TsdsQuery.pm_GetDsQuery: IdsQuery;
//#UC START# *492F006F00BE_492FECE300EAget_var*
//#UC END# *492F006F00BE_492FECE300EAget_var*
begin
 if (f_dsQuery = nil) then
 begin
  f_dsQuery := TvcmViewAreaControllerRef.Make;
  //#UC START# *492F006F00BE_492FECE300EAget_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *492F006F00BE_492FECE300EAget_init*
 end;//f_dsQuery = nil
 if f_dsQuery.IsEmpty
  //#UC START# *492F006F00BE_492FECE300EAget_need*
  // - условие создания ViewArea
  //#UC END# *492F006F00BE_492FECE300EAget_need*
  then
   f_dsQuery.Referred := DoGet_dsQuery;
 Result := IdsQuery(f_dsQuery.Referred);
end;

function TsdsQuery.DoGet_dsQuery: IdsQuery;
//#UC START# *492F006F00BE_492FECE300EAarea_var*
//#UC END# *492F006F00BE_492FECE300EAarea_var*
begin
//#UC START# *492F006F00BE_492FECE300EAarea_impl*
 Result := GetQueryClass.Make(Self, InitialUseCaseData);
//#UC END# *492F006F00BE_492FECE300EAarea_impl*
end;//TsdsQuery.DoGet_dsQuery

function TsdsQuery.pm_GetDsSaveLoad: IdsSaveLoad;
//#UC START# *492F00890059_492FECE300EAget_var*
//#UC END# *492F00890059_492FECE300EAget_var*
begin
 if (f_dsSaveLoad = nil) then
 begin
  f_dsSaveLoad := TvcmViewAreaControllerRef.Make;
  //#UC START# *492F00890059_492FECE300EAget_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *492F00890059_492FECE300EAget_init*
 end;//f_dsSaveLoad = nil
 if f_dsSaveLoad.IsEmpty
  //#UC START# *492F00890059_492FECE300EAget_need*
  // - условие создания ViewArea
  //#UC END# *492F00890059_492FECE300EAget_need*
  then
   f_dsSaveLoad.Referred := DoGet_dsSaveLoad;
 Result := IdsSaveLoad(f_dsSaveLoad.Referred);
end;

function TsdsQuery.DoGet_dsSaveLoad: IdsSaveLoad;
//#UC START# *492F00890059_492FECE300EAarea_var*
//#UC END# *492F00890059_492FECE300EAarea_var*
begin
//#UC START# *492F00890059_492FECE300EAarea_impl*
 Result := TdsSaveLoad.Make(Self);
//#UC END# *492F00890059_492FECE300EAarea_impl*
end;//TsdsQuery.DoGet_dsSaveLoad

{$If not defined(NoVCM)}
procedure TsdsQuery.ClearAreas;
 {-}
begin
 if (f_dsQuery <> nil) then f_dsQuery.Referred := nil;
 if (f_dsSaveLoad <> nil) then f_dsSaveLoad.Referred := nil;
 inherited;
end;//TsdsQuery.ClearAreas
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.