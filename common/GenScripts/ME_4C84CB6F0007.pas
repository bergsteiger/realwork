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
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure History; override;
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure OkExt; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
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

{$If NOT Defined(NoVCM)}
procedure TBaseChatWindowOptionsForm.Delete;
 {* Удалить }
//#UC START# *4C7D0CC90052_4C84CB6F0007_var*
//#UC END# *4C7D0CC90052_4C84CB6F0007_var*
begin
//#UC START# *4C7D0CC90052_4C84CB6F0007_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0CC90052_4C84CB6F0007_impl*
end;//TBaseChatWindowOptionsForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

procedure TBaseChatWindowOptionsForm.History;
//#UC START# *4C84CC2E0253_4C84CB6F0007_var*
//#UC END# *4C84CC2E0253_4C84CB6F0007_var*
begin
//#UC START# *4C84CC2E0253_4C84CB6F0007_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C84CC2E0253_4C84CB6F0007_impl*
end;//TBaseChatWindowOptionsForm.History

{$If NOT Defined(NoVCM)}
procedure TBaseChatWindowOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4C762C910358_4C84CB6F0007_var*
//#UC END# *4C762C910358_4C84CB6F0007_var*
begin
//#UC START# *4C762C910358_4C84CB6F0007_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762C910358_4C84CB6F0007_impl*
end;//TBaseChatWindowOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TBaseChatWindowOptionsForm.OkExt;
 {* OK }
//#UC START# *4C762D9B0224_4C84CB6F0007_var*
//#UC END# *4C762D9B0224_4C84CB6F0007_var*
begin
//#UC START# *4C762D9B0224_4C84CB6F0007_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762D9B0224_4C84CB6F0007_impl*
end;//TBaseChatWindowOptionsForm.OkExt
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TBaseChatWindowOptionsForm);
 {* Регистрация BaseChatWindowOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
