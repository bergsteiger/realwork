unit NOT_COMPLETED_PrimMainOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\NOT_COMPLETED_PrimMainOptions_Form.pas"
// Стереотип: "VCMMainForm"
// Элемент модели: "PrimMainOptions" MUID: (4C8A210E018C)
// Имя типа: "TPrimMainOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimMain_Form
 , F1_Application_Template_InternalOperations_Controls
 , vtPanel
 {$If Defined(Nemesis)}
 , nscNavigator
 {$IfEnd} // Defined(Nemesis)
;

type
 TPrimMainOptionsForm = class(TPrimMainForm)
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure Help_HelpTopics_Test(const aParams: IvcmTestParamsPrim);
   procedure Help_HelpTopics_Execute(const aParams: IvcmExecuteParamsPrim);
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

procedure TPrimMainOptionsForm.Help_HelpTopics_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8A27DA0087_4C8A210E018Ctest_var*
//#UC END# *4C8A27DA0087_4C8A210E018Ctest_var*
begin
//#UC START# *4C8A27DA0087_4C8A210E018Ctest_impl*
 if (Application.HelpFile = '') then
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4C8A27DA0087_4C8A210E018Ctest_impl*
end;//TPrimMainOptionsForm.Help_HelpTopics_Test

procedure TPrimMainOptionsForm.Help_HelpTopics_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8A27DA0087_4C8A210E018Cexec_var*
//#UC END# *4C8A27DA0087_4C8A210E018Cexec_var*
begin
//#UC START# *4C8A27DA0087_4C8A210E018Cexec_impl*
 Application.HelpSystem.ShowTopicHelp(cHelpStartPage, '');
//#UC END# *4C8A27DA0087_4C8A210E018Cexec_impl*
end;//TPrimMainOptionsForm.Help_HelpTopics_Execute

{$If NOT Defined(NoVCM)}
procedure TPrimMainOptionsForm.MakeControls;
begin
 inherited;
 f_ClientZone.Parent := Self;
 f_LeftNavigator.Parent := ClientZone;
{$If Defined(HasRightNavigator)}
 f_RightNavigator.Parent := ClientZone;
{$IfEnd} // Defined(HasRightNavigator)

end;//TPrimMainOptionsForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimMainOptionsForm);
 {* Регистрация PrimMainOptions }
{$IfEnd} // NOT Defined(NoScripts)

end.
