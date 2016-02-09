unit PrimInternetAgent_Module;
 {* Модуль для [Интернет-агента|$144575249] }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\PrimInternetAgent_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimInternetAgent_Form
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
 , InternetAgentInterfaces
 , nsLogEvent
;

const
 fm_InternetAgentForm: TvcmFormDescriptor = (rFormID : (rName : 'InternetAgentForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TInternetAgentForm }

type
 InternetAgentFormDef = interface
  {* Идентификатор формы InternetAgent$F }
  ['{4953CF3C-7760-41BE-BBC7-7CA06BAE484D}']
 end;//InternetAgentFormDef

 TInternetAgentForm = {final} class(TPrimInternetAgentForm, InternetAgentFormDef)
  {* Новости онлайн }
 end;//TInternetAgentForm

 // InternetAgent

 Tfs_InternetAgent = {final} class(TvcmFormSetFactory)
  {* Сборка форм для прецедента Интернет-агент }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function InternetAgent_Parent_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для InternetAgent }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_InternetAgent;
    {* Метод получения экземпляра синглетона Tfs_InternetAgent }
 end;//Tfs_InternetAgent

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
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , InternetAgentKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 , SysUtils
 , LoggingUnit
;

var g_Tfs_InternetAgent: Tfs_InternetAgent = nil;
 {* Экземпляр синглетона Tfs_InternetAgent }

const
 {* Локализуемые строки InternetAgentCaptionLocalConstants }
 str_fsInternetAgentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsInternetAgentCaption'; rValue : 'Интернет-агент');
  {* Заголовок фабрики сборки форм "InternetAgent" }

procedure Tfs_InternetAgentFree;
 {* Метод освобождения экземпляра синглетона Tfs_InternetAgent }
begin
 l3Free(g_Tfs_InternetAgent);
end;//Tfs_InternetAgentFree

function Tfs_InternetAgent.InternetAgent_Parent_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для InternetAgent }
//#UC START# *4C922F4CC339_49F586610347_var*
//#UC END# *4C922F4CC339_49F586610347_var*
begin
//#UC START# *4C922F4CC339_49F586610347_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C922F4CC339_49F586610347_impl*
end;//Tfs_InternetAgent.InternetAgent_Parent_NeedMakeForm

class function Tfs_InternetAgent.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_InternetAgent <> nil;
end;//Tfs_InternetAgent.Exists

class function Tfs_InternetAgent.Instance: Tfs_InternetAgent;
 {* Метод получения экземпляра синглетона Tfs_InternetAgent }
begin
 if (g_Tfs_InternetAgent = nil) then
 begin
  l3System.AddExitProc(Tfs_InternetAgentFree);
  g_Tfs_InternetAgent := Create;
 end;
 Result := g_Tfs_InternetAgent;
end;//Tfs_InternetAgent.Instance

procedure Tfs_InternetAgent.InitFields;
//#UC START# *47A042E100E2_49F586610347_var*
//#UC END# *47A042E100E2_49F586610347_var*
begin
//#UC START# *47A042E100E2_49F586610347_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_49F586610347_impl*
end;//Tfs_InternetAgent.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_InternetAgent.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_49F586610347_var*
//#UC END# *4FFE854A009B_49F586610347_var*
begin
//#UC START# *4FFE854A009B_49F586610347_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_49F586610347_impl*
end;//Tfs_InternetAgent.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

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

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TInternetAgentForm);
 {* Регистрация InternetAgent$F }
{$IfEnd} // NOT Defined(NoScripts)
 fm_InternetAgentForm.SetFactory(TInternetAgentForm.Make);
 {* Регистрация фабрики формы InternetAgent$F }
 str_fsInternetAgentCaption.Init;
 {* Инициализация str_fsInternetAgentCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
