unit PrimInternetAgent_Module;
 {* Модуль для [Интернет-агента|$144575249] }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\PrimInternetAgent_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , nsLogEvent
;

type
 TnsOpenInternetAgentEvent = class(TnsLogEvent)
  public
   class procedure Log;
 end;//TnsOpenInternetAgentEvent

 TPrimInternetAgentModule = {abstract} class
  {* Модуль для [Интернет-агента|$144575249] }
  protected
   procedure InternetAgent;
    {* Новости онлайн }
  public
   procedure MakeInternetAgent(const anURL: Il3CString;
    const aContainer: IvcmContainer);
    {* Создаёт область вывода Интернет-агента }
 end;//TPrimInternetAgentModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3Base
 , DataAdapter
 , nsTypes
 , afwFacade
 , afwInterfaces
 , nsConst
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , sdsInternetAgent
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 , LoggingUnit
;

class procedure TnsOpenInternetAgentEvent.Log;
//#UC START# *4B14DF4201A3_4B14DF1F0101_var*
//#UC END# *4B14DF4201A3_4B14DF1F0101_var*
begin
//#UC START# *4B14DF4201A3_4B14DF1F0101_impl*
 GetLogger.AddEvent(LE_OPEN_INTERNET_AGENT, MakeParamsList);
//#UC END# *4B14DF4201A3_4B14DF1F0101_impl*
end;//TnsOpenInternetAgentEvent.Log

procedure TPrimInternetAgentModule.MakeInternetAgent(const anURL: Il3CString;
 const aContainer: IvcmContainer);
 {* Создаёт область вывода Интернет-агента }
//#UC START# *49ECAADA03C7_49EC739C0100_var*
var
 l_Cont: IvcmContainer;
//#UC END# *49ECAADA03C7_49EC739C0100_var*
begin
//#UC START# *49ECAADA03C7_49EC739C0100_impl*
 if Assigned(aContainer) then
  l_Cont := aContainer
 else
  l_Cont := DefaultContainer;

 Tfs_InternetAgent.Make(TsdsInternetAgent.Make(anURL), l_Cont);
//#UC END# *49ECAADA03C7_49EC739C0100_impl*
end;//TPrimInternetAgentModule.MakeInternetAgent

procedure TPrimInternetAgentModule.InternetAgent;
 {* Новости онлайн }
//#UC START# *4A979E9B0245_49EC739C0100_var*
//#UC END# *4A979E9B0245_49EC739C0100_var*
begin
//#UC START# *4A979E9B0245_49EC739C0100_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A979E9B0245_49EC739C0100_impl*
end;//TPrimInternetAgentModule.InternetAgent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
