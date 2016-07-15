unit sdsQuery;
 {* Бизнес объект прецедента "Поисковый запрос" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\sdsQuery.pas"
// Стереотип: "UseCaseControllerImp"
// Элемент модели: "TsdsQuery" MUID: (492FECE300EA)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ConsultationInterfaces
 , QueryCardInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
 , dsQuery
;

type
 TdsQueryClass = class of TdsQuery;

 _InitDataType_ = IdeQuery;
 _SetType_ = IsdsQuery;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}
 TsdsQuery = {final} class(_vcmFormSetDataSourceWithoutData_, IsdsQuery)
  {* Бизнес объект прецедента "Поисковый запрос" }
  private
   f_dsQuery: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsQuery }
   f_dsSaveLoad: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsSaveLoad }
  protected
   function GetQueryClass: TdsQueryClass; virtual;
   function pm_GetDsQuery: IdsQuery;
   function DoGet_DsQuery: IdsQuery;
   function pm_GetDsSaveLoad: IdsSaveLoad;
   function DoGet_DsSaveLoad: IdsSaveLoad;
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TsdsQuery
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsSaveLoad
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceRef
 {$IfEnd} // NOT Defined(NoVCM)
;

type _Instance_R_ = TsdsQuery;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}

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
end;//TsdsQuery.pm_GetDsQuery

function TsdsQuery.DoGet_DsQuery: IdsQuery;
//#UC START# *492F006F00BE_492FECE300EAarea_var*
//#UC END# *492F006F00BE_492FECE300EAarea_var*
begin
//#UC START# *492F006F00BE_492FECE300EAarea_impl*
 Result := GetQueryClass.Make(Self, InitialUseCaseData);
//#UC END# *492F006F00BE_492FECE300EAarea_impl*
end;//TsdsQuery.DoGet_DsQuery

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
end;//TsdsQuery.pm_GetDsSaveLoad

function TsdsQuery.DoGet_DsSaveLoad: IdsSaveLoad;
//#UC START# *492F00890059_492FECE300EAarea_var*
//#UC END# *492F00890059_492FECE300EAarea_var*
begin
//#UC START# *492F00890059_492FECE300EAarea_impl*
 Result := TdsSaveLoad.Make(Self);
//#UC END# *492F00890059_492FECE300EAarea_impl*
end;//TsdsQuery.DoGet_DsSaveLoad

procedure TsdsQuery.ClearFields;
begin
 f_dsQuery := nil;
 f_dsSaveLoad := nil;
 inherited;
end;//TsdsQuery.ClearFields

{$If NOT Defined(NoVCM)}
procedure TsdsQuery.ClearAreas;
 {* Очищает ссылки на области ввода }
begin
 if (f_dsQuery <> nil) then f_dsQuery.Referred := nil;
 if (f_dsSaveLoad <> nil) then f_dsSaveLoad.Referred := nil;
 inherited;
end;//TsdsQuery.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
