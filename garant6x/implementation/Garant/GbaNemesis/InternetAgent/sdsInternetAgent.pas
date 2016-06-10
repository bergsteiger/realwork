unit sdsInternetAgent;
 {* Реализация прецедента Интернет-агента }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\InternetAgent\sdsInternetAgent.pas"
// Стереотип: "UseCaseControllerImp"
// Элемент модели: "TsdsInternetAgent" MUID: (49ECA984005F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , InternetAgentInterfaces
 , l3Interfaces
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
 , l3NotifyPtrList
;

type
 _InitDataType_ = Il3CString;
 _SetType_ = IsdsInternetAgent;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}
 TsdsInternetAgent = class(_vcmFormSetDataSourceWithoutData_, IsdsInternetAgent)
  {* Реализация прецедента Интернет-агента }
  private
   f_MainViewArea: IvcmViewAreaControllerRef;
    {* Поле для области вывода MainViewArea }
  protected
   function pm_GetMainViewArea: IdsInternetAgent;
   function DoGet_MainViewArea: IdsInternetAgent;
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TsdsInternetAgent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsInternetAgent
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceRef
 {$IfEnd} // NOT Defined(NoVCM)
;

{$If NOT Defined(NoVCM)}
type _Instance_R_ = TsdsInternetAgent;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}

function TsdsInternetAgent.pm_GetMainViewArea: IdsInternetAgent;
//#UC START# *4A37A70E01DE_49ECA984005Fget_var*
//#UC END# *4A37A70E01DE_49ECA984005Fget_var*
begin
 if (f_MainViewArea = nil) then
 begin
  f_MainViewArea := TvcmViewAreaControllerRef.Make;
  //#UC START# *4A37A70E01DE_49ECA984005Fget_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *4A37A70E01DE_49ECA984005Fget_init*
 end;//f_MainViewArea = nil
 if f_MainViewArea.IsEmpty
  //#UC START# *4A37A70E01DE_49ECA984005Fget_need*
  // - условие создания ViewArea
  //#UC END# *4A37A70E01DE_49ECA984005Fget_need*
  then
   f_MainViewArea.Referred := DoGet_MainViewArea;
 Result := IdsInternetAgent(f_MainViewArea.Referred);
end;//TsdsInternetAgent.pm_GetMainViewArea

function TsdsInternetAgent.DoGet_MainViewArea: IdsInternetAgent;
//#UC START# *4A37A70E01DE_49ECA984005Farea_var*
//#UC END# *4A37A70E01DE_49ECA984005Farea_var*
begin
//#UC START# *4A37A70E01DE_49ECA984005Farea_impl*
 Result := TdsInternetAgent.Make(Self, InitialUseCaseData);
//#UC END# *4A37A70E01DE_49ECA984005Farea_impl*
end;//TsdsInternetAgent.DoGet_MainViewArea

procedure TsdsInternetAgent.ClearFields;
begin
 f_MainViewArea := nil;
 inherited;
end;//TsdsInternetAgent.ClearFields

procedure TsdsInternetAgent.ClearAreas;
 {* Очищает ссылки на области ввода }
begin
 if (f_MainViewArea <> nil) then f_MainViewArea.Referred := nil;
 inherited;
end;//TsdsInternetAgent.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
