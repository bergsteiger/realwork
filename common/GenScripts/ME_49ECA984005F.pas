unit sdsInternetAgent;
 {* Реализация прецедента Интернет-агента }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\InternetAgent\sdsInternetAgent.pas"
// Стереотип: "UseCaseControllerImp"

{$Include nsDefine.inc}

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
;

type _Instance_R_ = TsdsInternetAgent;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}

function TsdsInternetAgent.pm_GetMainViewArea: IdsInternetAgent;
//#UC START# *4A37A70E01DE_49ECA984005Fget_var*
//#UC END# *4A37A70E01DE_49ECA984005Fget_var*
begin
//#UC START# *4A37A70E01DE_49ECA984005Fget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A37A70E01DE_49ECA984005Fget_impl*
end;//TsdsInternetAgent.pm_GetMainViewArea

{$If NOT Defined(NoVCM)}
procedure TsdsInternetAgent.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_49ECA984005F_var*
//#UC END# *4938F7E702B7_49ECA984005F_var*
begin
//#UC START# *4938F7E702B7_49ECA984005F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_49ECA984005F_impl*
end;//TsdsInternetAgent.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
