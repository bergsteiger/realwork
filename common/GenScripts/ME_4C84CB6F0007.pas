unit BaseChatWindowOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\BaseChatWindowOptions_Form.pas"
// Стереотип: "VCMContainer"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseChatWindow_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_Chat_Controls
;

type
 TBaseChatWindowOptionsForm = class(TBaseChatWindowForm)
  public
   procedure Chat_History_Execute(const aParams: IvcmExecuteParamsPrim);
 end;//TBaseChatWindowOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TBaseChatWindowOptionsForm.Chat_History_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C84CC2E0253_4C84CB6F0007exec_var*
//#UC END# *4C84CC2E0253_4C84CB6F0007exec_var*
begin
//#UC START# *4C84CC2E0253_4C84CB6F0007exec_impl*
 TdmStdRes.MakeChatDispatcher.OpenChatHistoryByID(UserID);
//#UC END# *4C84CC2E0253_4C84CB6F0007exec_impl*
end;//TBaseChatWindowOptionsForm.Chat_History_Execute

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TBaseChatWindowOptionsForm);
 {* Регистрация BaseChatWindowOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
