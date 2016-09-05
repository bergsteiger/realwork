unit dsInternetAgent;
 {* Реализация области вывода Интернет-агента }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\InternetAgent\dsInternetAgent.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsInternetAgent" MUID: (49ECA9AA0000)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , InternetAgentInterfaces
 , l3Interfaces
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
 _InitDataType_ = Il3CString;
 _FormDataSourceType_ = IdsInternetAgent;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}
 TdsInternetAgent = {final} class(_vcmFormDataSource_, IdsInternetAgent)
  {* Реализация области вывода Интернет-агента }
  protected
   function Get_URL: WideString;
 end;//TdsInternetAgent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3String
 , l3InterfacesMisc
 , SysUtils
 , l3Base
 //#UC START# *49ECA9AA0000impl_uses*
 //#UC END# *49ECA9AA0000impl_uses*
;

type _Instance_R_ = TdsInternetAgent;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}

function TdsInternetAgent.Get_URL: WideString;
//#UC START# *49EDE45A02EB_49ECA9AA0000get_var*
//#UC END# *49EDE45A02EB_49ECA9AA0000get_var*
begin
//#UC START# *49EDE45A02EB_49ECA9AA0000get_impl*
 Result := l3WideString(PartData);
//#UC END# *49EDE45A02EB_49ECA9AA0000get_impl*
end;//TdsInternetAgent.Get_URL
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
