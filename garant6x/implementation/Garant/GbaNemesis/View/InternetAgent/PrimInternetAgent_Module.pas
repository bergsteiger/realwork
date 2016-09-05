unit PrimInternetAgent_Module;
 {* Модуль для [Интернет-агента|$144575249] }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\PrimInternetAgent_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "PrimInternetAgent" MUID: (49EC739C0100)
// Имя типа: "TPrimInternetAgentModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsLogEvent
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TnsOpenInternetAgentEvent = class(TnsLogEvent)
  public
   class procedure Log;
 end;//TnsOpenInternetAgentEvent

 TPrimInternetAgentModule = {abstract} class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Модуль для [Интернет-агента|$144575249] }
  private
   procedure opInternetAgentTest(const aParams: IvcmTestParamsPrim);
   procedure opInternetAgentExecute(const aParams: IvcmExecuteParamsPrim);
  protected
   procedure Loaded; override;
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimInternetAgentModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Services_Contracts
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , DataAdapter
 , nsTypes
 , afwFacade
 , afwInterfaces
 , nsConst
 , sdsInternetAgent
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , LoggingUnit
 , SysUtils
 , InternetAgent_Form
 , fsInternetAgent
 //#UC START# *49EC739C0100impl_uses*
 //#UC END# *49EC739C0100impl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TInternetAgentServiceImpl = {final} class(TvcmModuleContractImplementation, IInternetAgentService)
  public
   procedure MakeInternetAgent(const anURL: Il3CString;
    const aContainer: IvcmContainer);
    {* Создаёт область вывода Интернет-агента }
   class function Instance: TInternetAgentServiceImpl;
    {* Метод получения экземпляра синглетона TInternetAgentServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TInternetAgentServiceImpl

var g_TInternetAgentServiceImpl: TInternetAgentServiceImpl = nil;
 {* Экземпляр синглетона TInternetAgentServiceImpl }

procedure TInternetAgentServiceImplFree;
 {* Метод освобождения экземпляра синглетона TInternetAgentServiceImpl }
begin
 l3Free(g_TInternetAgentServiceImpl);
end;//TInternetAgentServiceImplFree

class procedure TnsOpenInternetAgentEvent.Log;
//#UC START# *4B14DF4201A3_4B14DF1F0101_var*
//#UC END# *4B14DF4201A3_4B14DF1F0101_var*
begin
//#UC START# *4B14DF4201A3_4B14DF1F0101_impl*
 GetLogger.AddEvent(LE_OPEN_INTERNET_AGENT, MakeParamsList);
//#UC END# *4B14DF4201A3_4B14DF1F0101_impl*
end;//TnsOpenInternetAgentEvent.Log

procedure TInternetAgentServiceImpl.MakeInternetAgent(const anURL: Il3CString;
 const aContainer: IvcmContainer);
 {* Создаёт область вывода Интернет-агента }
var
 __WasEnter : Boolean;
//#UC START# *49ECAADA03C7_49EC739C0100_var*
var
 l_Cont: IvcmContainer;
//#UC END# *49ECAADA03C7_49EC739C0100_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *49ECAADA03C7_49EC739C0100_impl*
 if Assigned(aContainer) then
  l_Cont := aContainer
 else
  l_Cont := DefaultContainer;

 Tfs_InternetAgent.Make(TsdsInternetAgent.Make(anURL), l_Cont);
//#UC END# *49ECAADA03C7_49EC739C0100_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TInternetAgentServiceImpl.MakeInternetAgent

class function TInternetAgentServiceImpl.Instance: TInternetAgentServiceImpl;
 {* Метод получения экземпляра синглетона TInternetAgentServiceImpl }
begin
 if (g_TInternetAgentServiceImpl = nil) then
 begin
  l3System.AddExitProc(TInternetAgentServiceImplFree);
  g_TInternetAgentServiceImpl := Create;
 end;
 Result := g_TInternetAgentServiceImpl;
end;//TInternetAgentServiceImpl.Instance

class function TInternetAgentServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TInternetAgentServiceImpl <> nil;
end;//TInternetAgentServiceImpl.Exists

procedure TPrimInternetAgentModule.opInternetAgentTest(const aParams: IvcmTestParamsPrim);
//#UC START# *57971D020184_49EC739C0100test_var*
//#UC END# *57971D020184_49EC739C0100test_var*
begin
//#UC START# *57971D020184_49EC739C0100test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := defDataAdapter.IsInternetAgentEnabled;
 aParams.Op.Flag[vcm_ofVisible] := aParams.Op.Flag[vcm_ofEnabled];
//#UC END# *57971D020184_49EC739C0100test_impl*
end;//TPrimInternetAgentModule.opInternetAgentTest

procedure TPrimInternetAgentModule.opInternetAgentExecute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *57971D020184_49EC739C0100exec_var*
//#UC END# *57971D020184_49EC739C0100exec_var*
begin
//#UC START# *57971D020184_49EC739C0100exec_impl*
 {if afw.Application.LocaleInfo.Language = afw_lngEnglish then
  MakeInternetAgent(l3CStr(ciitEnglishGarant), DefaultContainer)
 else}
  TInternetAgentService.Instance.MakeInternetAgent(l3CStr(ciitGarant), DefaultContainer);
 TnsOpenInternetAgentEvent.Log;
//#UC END# *57971D020184_49EC739C0100exec_impl*
end;//TPrimInternetAgentModule.opInternetAgentExecute

procedure TPrimInternetAgentModule.Loaded;
begin
 inherited;
 PublishOp('opInternetAgent', opInternetAgentExecute, opInternetAgentTest);
end;//TPrimInternetAgentModule.Loaded

class procedure TPrimInternetAgentModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TInternetAgentForm);
end;//TPrimInternetAgentModule.GetEntityForms

initialization
 TInternetAgentService.Instance.Alien := TInternetAgentServiceImpl.Instance;
 {* Регистрация TInternetAgentServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
