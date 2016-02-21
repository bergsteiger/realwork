unit PrimMainOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimMainOptions_Form.pas"
// Стереотип: "VCMMainForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimMain_Form
 , F1_Application_Template_InternalOperations_Controls
;

type
 TPrimMainOptionsForm = class(TPrimMainForm)
  public
   procedure HelpTopics; override;
 end;//TPrimMainOptionsForm

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vtNavigator
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , nsConst
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TPrimMainOptionsForm.HelpTopics;
//#UC START# *4C8A27DA0087_4C8A210E018C_var*
//#UC END# *4C8A27DA0087_4C8A210E018C_var*
begin
//#UC START# *4C8A27DA0087_4C8A210E018C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A27DA0087_4C8A210E018C_impl*
end;//TPrimMainOptionsForm.HelpTopics

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimMainOptionsForm);
 {* Регистрация PrimMainOptions }
{$IfEnd} // NOT Defined(NoScripts)

end.
