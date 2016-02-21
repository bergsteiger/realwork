unit fsInternetAgent;
 {* Сборка форм для прецедента Интернет-агент }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\fsInternetAgent.pas"
// Стереотип: "VCMFormSetFactory"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , InternetAgent_Form
 , InternetAgentInterfaces
;

type
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 , SysUtils
 , l3Base
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

initialization
 str_fsInternetAgentCaption.Init;
 {* Инициализация str_fsInternetAgentCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
