unit PrimNavigatorOptions_Form;
 {* ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimNavigatorOptions_Form.pas"
// ���������: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimNavigator_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Common_Strange_Controls
;

type
 TPrimNavigatorOptionsForm = class(TPrimNavigatorForm)
  {* ���� }
  public
   {$If NOT Defined(NoVCM)}
   procedure Cut; override;
    {* �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Paste; override;
    {* ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Undo; override;
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Redo; override;
    {* ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SelectAll; override;
    {* �������� �� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Deselect; override;
    {* ����� ��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Copy; override;
    {* ���������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Info; override;
   procedure Execute; override;
 end;//TPrimNavigatorOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3TreeInterfaces
 , DynamicTreeUnit
 , nsNodes
 , SysUtils
 , nsNavigatorTreeStruct
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimNavigatorOptionsForm.Cut;
 {* �������� }
//#UC START# *4951285702E1_4C87A47E0036_var*
//#UC END# *4951285702E1_4C87A47E0036_var*
begin
//#UC START# *4951285702E1_4C87A47E0036_impl*
 !!! Needs to be implemented !!!
//#UC END# *4951285702E1_4C87A47E0036_impl*
end;//TPrimNavigatorOptionsForm.Cut
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimNavigatorOptionsForm.Paste;
 {* ������� }
//#UC START# *49EDFA3701B0_4C87A47E0036_var*
//#UC END# *49EDFA3701B0_4C87A47E0036_var*
begin
//#UC START# *49EDFA3701B0_4C87A47E0036_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFA3701B0_4C87A47E0036_impl*
end;//TPrimNavigatorOptionsForm.Paste
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimNavigatorOptionsForm.Undo;
 {* ������ }
//#UC START# *49EDFCA2006D_4C87A47E0036_var*
//#UC END# *49EDFCA2006D_4C87A47E0036_var*
begin
//#UC START# *49EDFCA2006D_4C87A47E0036_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFCA2006D_4C87A47E0036_impl*
end;//TPrimNavigatorOptionsForm.Undo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimNavigatorOptionsForm.Redo;
 {* ������� }
//#UC START# *49EDFCB100BC_4C87A47E0036_var*
//#UC END# *49EDFCB100BC_4C87A47E0036_var*
begin
//#UC START# *49EDFCB100BC_4C87A47E0036_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFCB100BC_4C87A47E0036_impl*
end;//TPrimNavigatorOptionsForm.Redo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimNavigatorOptionsForm.SelectAll;
 {* �������� �� }
//#UC START# *49EE01AA02BE_4C87A47E0036_var*
//#UC END# *49EE01AA02BE_4C87A47E0036_var*
begin
//#UC START# *49EE01AA02BE_4C87A47E0036_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EE01AA02BE_4C87A47E0036_impl*
end;//TPrimNavigatorOptionsForm.SelectAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimNavigatorOptionsForm.Deselect;
 {* ����� ��������� }
//#UC START# *49EE01BC022E_4C87A47E0036_var*
//#UC END# *49EE01BC022E_4C87A47E0036_var*
begin
//#UC START# *49EE01BC022E_4C87A47E0036_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EE01BC022E_4C87A47E0036_impl*
end;//TPrimNavigatorOptionsForm.Deselect
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimNavigatorOptionsForm.Copy;
 {* ���������� }
//#UC START# *4C7D0C7B0185_4C87A47E0036_var*
//#UC END# *4C7D0C7B0185_4C87A47E0036_var*
begin
//#UC START# *4C7D0C7B0185_4C87A47E0036_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0C7B0185_4C87A47E0036_impl*
end;//TPrimNavigatorOptionsForm.Copy
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimNavigatorOptionsForm.Delete;
 {* ������� }
//#UC START# *4C7D0CC90052_4C87A47E0036_var*
//#UC END# *4C7D0CC90052_4C87A47E0036_var*
begin
//#UC START# *4C7D0CC90052_4C87A47E0036_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0CC90052_4C87A47E0036_impl*
end;//TPrimNavigatorOptionsForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimNavigatorOptionsForm.Info;
//#UC START# *4C87A50402CC_4C87A47E0036_var*
//#UC END# *4C87A50402CC_4C87A47E0036_var*
begin
//#UC START# *4C87A50402CC_4C87A47E0036_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C87A50402CC_4C87A47E0036_impl*
end;//TPrimNavigatorOptionsForm.Info

procedure TPrimNavigatorOptionsForm.Execute;
//#UC START# *4C87A52E02F7_4C87A47E0036_var*
//#UC END# *4C87A52E02F7_4C87A47E0036_var*
begin
//#UC START# *4C87A52E02F7_4C87A47E0036_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C87A52E02F7_4C87A47E0036_impl*
end;//TPrimNavigatorOptionsForm.Execute

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimNavigatorOptionsForm);
 {* ����������� PrimNavigatorOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
