unit PrimInternetAgent_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/InternetAgent/PrimInternetAgent_Module.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Встроенные продукты::InternetAgent::View::InternetAgent::PrimInternetAgent$FP
//
// Модуль для [Интернет-агента|$144575249]
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
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  InternetAgentInterfaces,
  PrimInternetAgent_Form,
  InternetAgent_Form,
  nsLogEvent,
  l3StringIDEx
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  ,
  fsInternetAgent
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  InternetAgentKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsOpenInternetAgentEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log;
 end;//TnsOpenInternetAgentEvent

 TPrimInternetAgentModule = {abstract formspack} class(TvcmModule)
  {* Модуль для [Интернет-агента|$144575249] }
 protected
  procedure Loaded; override;
  class procedure GetEntityForms(aList : TvcmClassList); override;
 protected
 // protected methods
   procedure opInternetAgentTest(const aParams: IvcmTestParamsPrim);
     {* Новости онлайн }
   procedure opInternetAgent(const aParams: IvcmExecuteParamsPrim);
     {* Новости онлайн }
 public
 // public methods
   class procedure MakeInternetAgent(const anURL: Il3CString;
     const aContainer: IvcmContainer);
     {* Создаёт область вывода Интернет-агента }
 end;//TPrimInternetAgentModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base {a},
  l3MessageID,
  SysUtils,
  sdsInternetAgent
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  LoggingUnit,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces,
  DataAdapter,
  nsTypes,
  afwFacade,
  afwInterfaces,
  nsConst
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_InternetAgent_opInternetAgent
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  vcmModuleDef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimInternetAgentModule

class procedure TPrimInternetAgentModule.MakeInternetAgent(const anURL: Il3CString;
  const aContainer: IvcmContainer);
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
end;//TPrimInternetAgentModule.MakeInternetAgent
// start class TnsOpenInternetAgentEvent

class procedure TnsOpenInternetAgentEvent.Log;
//#UC START# *4B14DF4201A3_4B14DF1F0101_var*
//#UC END# *4B14DF4201A3_4B14DF1F0101_var*
begin
//#UC START# *4B14DF4201A3_4B14DF1F0101_impl*
 GetLogger.AddEvent(LE_OPEN_INTERNET_AGENT, MakeParamsList);
//#UC END# *4B14DF4201A3_4B14DF1F0101_impl*
end;//TnsOpenInternetAgentEvent.Log

procedure TPrimInternetAgentModule.opInternetAgentTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4A979E9B0245_49EC739C0100test_var*
//#UC END# *4A979E9B0245_49EC739C0100test_var*
begin
//#UC START# *4A979E9B0245_49EC739C0100test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := defDataAdapter.IsInternetAgentEnabled;
 aParams.Op.Flag[vcm_ofVisible] := aParams.Op.Flag[vcm_ofEnabled];
//#UC END# *4A979E9B0245_49EC739C0100test_impl*
end;//TPrimInternetAgentModule.opInternetAgentTest

procedure TPrimInternetAgentModule.opInternetAgent(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A979E9B0245_49EC739C0100exec_var*
//#UC END# *4A979E9B0245_49EC739C0100exec_var*
begin
//#UC START# *4A979E9B0245_49EC739C0100exec_impl*
 {if afw.Application.LocaleInfo.Language = afw_lngEnglish then
  MakeInternetAgent(l3CStr(ciitEnglishGarant), DefaultContainer)
 else}
  MakeInternetAgent(l3CStr(ciitGarant), DefaultContainer);
 TnsOpenInternetAgentEvent.Log;
//#UC END# *4A979E9B0245_49EC739C0100exec_impl*
end;//TPrimInternetAgentModule.opInternetAgent

procedure TPrimInternetAgentModule.Loaded;
begin
 inherited;
 PublishOp('opInternetAgent', opInternetAgent, opInternetAgentTest);
end;

class procedure TPrimInternetAgentModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TInternetAgentForm);
end;

{$IfEnd} //not Admin AND not Monitorings

end.