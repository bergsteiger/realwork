unit PrimDockedWarning_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimDockedWarning_Form.pas"
// ���������: "VCMForm"
// ������� ������: "PrimDockedWarning" MUID: (4EA59DA70226)
// ��� ����: "TPrimDockedWarningForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimWarningOptions_Form
 , Document_Strange_Controls
 , DocumentAndListInterfaces
 , l3StringIDEx
;

type
 _WarningUserTypes_Parent_ = TPrimWarningOptionsForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\WarningUserTypes.imp.pas}
 TPrimDockedWarningForm = class(_WarningUserTypes_)
  protected
   procedure WarningQueryClose(aSender: TObject); override;
    {* ���������� ������� Warning.OnQueryClose }
  public
   procedure Warning_BecomeActive_Test(const aParams: IvcmTestParamsPrim);
   procedure Warning_BecomeActive_Execute(aSubID: TnsWarningSub);
   procedure Warning_BecomeActive(const aParams: IvcmExecuteParamsPrim);
   procedure Warning_SwitchActive_Test(const aParams: IvcmTestParamsPrim);
   procedure Warning_SwitchActive_Execute(aSubID: TnsWarningSub);
   procedure Warning_SwitchActive(const aParams: IvcmExecuteParamsPrim);
 end;//TPrimDockedWarningForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , WarningUserTypes_Warning_UserType
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , F1Like_InternalOperations_Controls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
;

type
 // PrintOperationsInclude

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\WarningUserTypes.imp.pas}

procedure TPrimDockedWarningForm.WarningQueryClose(aSender: TObject);
 {* ���������� ������� Warning.OnQueryClose }
//#UC START# *2FE2CD3A0C24_4EA59DA70226_var*
//#UC END# *2FE2CD3A0C24_4EA59DA70226_var*
begin
//#UC START# *2FE2CD3A0C24_4EA59DA70226_impl*
 op_Switcher_SetFirstPageActive.Call(Container);
//#UC END# *2FE2CD3A0C24_4EA59DA70226_impl*
end;//TPrimDockedWarningForm.WarningQueryClose

procedure TPrimDockedWarningForm.Warning_BecomeActive_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4AE9DF12018A_4EA59DA70226test_var*
//#UC END# *4AE9DF12018A_4EA59DA70226test_var*
begin
//#UC START# *4AE9DF12018A_4EA59DA70226test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (UserType = Warning);
 // http://mdp.garant.ru/pages/viewpage.action?pageId=269081712
 // http://mdp.garant.ru/pages/viewpage.action?pageId=274464961
//#UC END# *4AE9DF12018A_4EA59DA70226test_impl*
end;//TPrimDockedWarningForm.Warning_BecomeActive_Test

procedure TPrimDockedWarningForm.Warning_BecomeActive_Execute(aSubID: TnsWarningSub);
//#UC START# *4AE9DF12018A_4EA59DA70226exec_var*
//#UC END# *4AE9DF12018A_4EA59DA70226exec_var*
begin
//#UC START# *4AE9DF12018A_4EA59DA70226exec_impl*
 PositionOnRequestedSub(aSubID);
//#UC END# *4AE9DF12018A_4EA59DA70226exec_impl*
end;//TPrimDockedWarningForm.Warning_BecomeActive_Execute

procedure TPrimDockedWarningForm.Warning_BecomeActive(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IWarning_BecomeActive_Params) do
  Self.Warning_BecomeActive_Execute(SubID);
end;//TPrimDockedWarningForm.Warning_BecomeActive

procedure TPrimDockedWarningForm.Warning_SwitchActive_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4AE9DF3602B2_4EA59DA70226test_var*
//#UC END# *4AE9DF3602B2_4EA59DA70226test_var*
begin
//#UC START# *4AE9DF3602B2_4EA59DA70226test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (UserType = Warning);
 // http://mdp.garant.ru/pages/viewpage.action?pageId=269081712
 // http://mdp.garant.ru/pages/viewpage.action?pageId=274464961
//#UC END# *4AE9DF3602B2_4EA59DA70226test_impl*
end;//TPrimDockedWarningForm.Warning_SwitchActive_Test

procedure TPrimDockedWarningForm.Warning_SwitchActive_Execute(aSubID: TnsWarningSub);
//#UC START# *4AE9DF3602B2_4EA59DA70226exec_var*
//#UC END# *4AE9DF3602B2_4EA59DA70226exec_var*
begin
//#UC START# *4AE9DF3602B2_4EA59DA70226exec_impl*
 PositionOnRequestedSub(aSubID);
//#UC END# *4AE9DF3602B2_4EA59DA70226exec_impl*
end;//TPrimDockedWarningForm.Warning_SwitchActive_Execute

procedure TPrimDockedWarningForm.Warning_SwitchActive(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IWarning_SwitchActive_Params) do
  Self.Warning_SwitchActive_Execute(SubID);
end;//TPrimDockedWarningForm.Warning_SwitchActive

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimDockedWarningForm);
 {* ����������� PrimDockedWarning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
