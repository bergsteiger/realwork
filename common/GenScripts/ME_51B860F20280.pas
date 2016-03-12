unit PrimDictionOptions_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimDictionOptions_Form.pas"
// ���������: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDiction_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimDictionOptionsForm = class(TPrimDictionForm)
  public
   {$If NOT Defined(NoVCM)}
   procedure Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
    {* ���������� ��� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
    {* �������� ��� }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimDictionOptionsForm
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
procedure TPrimDictionOptionsForm.Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
 {* ���������� ��� }
//#UC START# *4BDAF7880236_51B860F20280test_var*
//#UC END# *4BDAF7880236_51B860F20280test_var*
begin
//#UC START# *4BDAF7880236_51B860F20280test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7880236_51B860F20280test_impl*
end;//TPrimDictionOptionsForm.Tree_ExpandAll_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimDictionOptionsForm.Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
 {* �������� ��� }
//#UC START# *4BDAF7A2005C_51B860F20280test_var*
//#UC END# *4BDAF7A2005C_51B860F20280test_var*
begin
//#UC START# *4BDAF7A2005C_51B860F20280test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7A2005C_51B860F20280test_impl*
end;//TPrimDictionOptionsForm.Tree_CollapseAll_Test
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimDictionOptionsForm);
 {* ����������� PrimDictionOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
