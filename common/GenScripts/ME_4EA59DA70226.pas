unit PrimDockedWarning_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimDockedWarning_Form.pas"
// ���������: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimWarningOptions_Form
 , Document_Strange_Controls
 , WarningUserTypes_Warning_UserType
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _WarningUserTypes_Parent_ = TPrimWarningOptionsForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\WarningUserTypes.imp.pas}
 TPrimDockedWarningForm = class(_WarningUserTypes_)
  protected
   procedure WarningQueryClose(aSender: TObject); override;
    {* ���������� ������� Warning.OnQueryClose }
  public
   procedure BecomeActive; override;
   procedure SwitchActive; override;
   {$If NOT Defined(NoVCM)}
   procedure Print; override;
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimDockedWarningForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , F1Like_InternalOperations_Controls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3StringIDEx
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

procedure TPrimDockedWarningForm.BecomeActive;
//#UC START# *4AE9DF12018A_4EA59DA70226_var*
//#UC END# *4AE9DF12018A_4EA59DA70226_var*
begin
//#UC START# *4AE9DF12018A_4EA59DA70226_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE9DF12018A_4EA59DA70226_impl*
end;//TPrimDockedWarningForm.BecomeActive

procedure TPrimDockedWarningForm.SwitchActive;
//#UC START# *4AE9DF3602B2_4EA59DA70226_var*
//#UC END# *4AE9DF3602B2_4EA59DA70226_var*
begin
//#UC START# *4AE9DF3602B2_4EA59DA70226_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE9DF3602B2_4EA59DA70226_impl*
end;//TPrimDockedWarningForm.SwitchActive

{$If NOT Defined(NoVCM)}
procedure TPrimDockedWarningForm.Print;
 {* ������ }
//#UC START# *49521D8E0295_4EA59DA70226_var*
//#UC END# *49521D8E0295_4EA59DA70226_var*
begin
//#UC START# *49521D8E0295_4EA59DA70226_impl*
 !!! Needs to be implemented !!!
//#UC END# *49521D8E0295_4EA59DA70226_impl*
end;//TPrimDockedWarningForm.Print
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimDockedWarningForm);
 {* ����������� PrimDockedWarning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
