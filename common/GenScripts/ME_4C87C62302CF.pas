unit PrimQueryCardOptions_Form;
 {* �������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCardOptions_Form.pas"
// ���������: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimQueryCard_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Search_Strange_Controls
;

type
 TPrimQueryCardOptionsForm = class(TPrimQueryCardForm)
  {* �������� �������� }
  public
   {$If NOT Defined(NoVCM)}
   procedure Print; override;
    {* ������ }
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
   procedure ShowSpecial; override;
    {* ���������� ����������� }
   {$If NOT Defined(NoVCM)}
   procedure Copy; override;
    {* ���������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintDialog; override;
    {* ������... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintPreview; override;
    {* ��������������� �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ExpandCollapse; override;
   procedure DeleteAll; override;
   procedure CreateAttr; override;
   procedure OpenTreeSelection; override;
 end;//TPrimQueryCardOptionsForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , DataAdapter
 , SysUtils
 , nsQueryInterfaces
 , evControlParaTools
 , l3String
 , evControlParaConst
 , evQueryCardInt
 , afwFacade
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimQueryCardOptionsForm.Print;
 {* ������ }
//#UC START# *49521D8E0295_4C87C62302CF_var*
//#UC END# *49521D8E0295_4C87C62302CF_var*
begin
//#UC START# *49521D8E0295_4C87C62302CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *49521D8E0295_4C87C62302CF_impl*
end;//TPrimQueryCardOptionsForm.Print
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimQueryCardOptionsForm.Paste;
 {* ������� }
//#UC START# *49EDFA3701B0_4C87C62302CF_var*
//#UC END# *49EDFA3701B0_4C87C62302CF_var*
begin
//#UC START# *49EDFA3701B0_4C87C62302CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFA3701B0_4C87C62302CF_impl*
end;//TPrimQueryCardOptionsForm.Paste
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimQueryCardOptionsForm.Undo;
 {* ������ }
//#UC START# *49EDFCA2006D_4C87C62302CF_var*
//#UC END# *49EDFCA2006D_4C87C62302CF_var*
begin
//#UC START# *49EDFCA2006D_4C87C62302CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFCA2006D_4C87C62302CF_impl*
end;//TPrimQueryCardOptionsForm.Undo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimQueryCardOptionsForm.Redo;
 {* ������� }
//#UC START# *49EDFCB100BC_4C87C62302CF_var*
//#UC END# *49EDFCB100BC_4C87C62302CF_var*
begin
//#UC START# *49EDFCB100BC_4C87C62302CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFCB100BC_4C87C62302CF_impl*
end;//TPrimQueryCardOptionsForm.Redo
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimQueryCardOptionsForm.ShowSpecial;
 {* ���������� ����������� }
//#UC START# *4A7C18B20241_4C87C62302CF_var*
//#UC END# *4A7C18B20241_4C87C62302CF_var*
begin
//#UC START# *4A7C18B20241_4C87C62302CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A7C18B20241_4C87C62302CF_impl*
end;//TPrimQueryCardOptionsForm.ShowSpecial

{$If NOT Defined(NoVCM)}
procedure TPrimQueryCardOptionsForm.Copy;
 {* ���������� }
//#UC START# *4C7D0C7B0185_4C87C62302CF_var*
//#UC END# *4C7D0C7B0185_4C87C62302CF_var*
begin
//#UC START# *4C7D0C7B0185_4C87C62302CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0C7B0185_4C87C62302CF_impl*
end;//TPrimQueryCardOptionsForm.Copy
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimQueryCardOptionsForm.Delete;
 {* ������� }
//#UC START# *4C7D0CC90052_4C87C62302CF_var*
//#UC END# *4C7D0CC90052_4C87C62302CF_var*
begin
//#UC START# *4C7D0CC90052_4C87C62302CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0CC90052_4C87C62302CF_impl*
end;//TPrimQueryCardOptionsForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimQueryCardOptionsForm.PrintDialog;
 {* ������... }
//#UC START# *495220DE0298_4C87C62302CF_var*
//#UC END# *495220DE0298_4C87C62302CF_var*
begin
//#UC START# *495220DE0298_4C87C62302CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220DE0298_4C87C62302CF_impl*
end;//TPrimQueryCardOptionsForm.PrintDialog
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimQueryCardOptionsForm.PrintPreview;
 {* ��������������� �������� }
//#UC START# *495220F2033A_4C87C62302CF_var*
//#UC END# *495220F2033A_4C87C62302CF_var*
begin
//#UC START# *495220F2033A_4C87C62302CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220F2033A_4C87C62302CF_impl*
end;//TPrimQueryCardOptionsForm.PrintPreview
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimQueryCardOptionsForm.ExpandCollapse;
//#UC START# *4C2E116E0315_4C87C62302CF_var*
//#UC END# *4C2E116E0315_4C87C62302CF_var*
begin
//#UC START# *4C2E116E0315_4C87C62302CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2E116E0315_4C87C62302CF_impl*
end;//TPrimQueryCardOptionsForm.ExpandCollapse

procedure TPrimQueryCardOptionsForm.DeleteAll;
//#UC START# *4C2E117F022C_4C87C62302CF_var*
//#UC END# *4C2E117F022C_4C87C62302CF_var*
begin
//#UC START# *4C2E117F022C_4C87C62302CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2E117F022C_4C87C62302CF_impl*
end;//TPrimQueryCardOptionsForm.DeleteAll

procedure TPrimQueryCardOptionsForm.CreateAttr;
//#UC START# *4C2E118B010B_4C87C62302CF_var*
//#UC END# *4C2E118B010B_4C87C62302CF_var*
begin
//#UC START# *4C2E118B010B_4C87C62302CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2E118B010B_4C87C62302CF_impl*
end;//TPrimQueryCardOptionsForm.CreateAttr

procedure TPrimQueryCardOptionsForm.OpenTreeSelection;
//#UC START# *4C2E11960124_4C87C62302CF_var*
//#UC END# *4C2E11960124_4C87C62302CF_var*
begin
//#UC START# *4C2E11960124_4C87C62302CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2E11960124_4C87C62302CF_impl*
end;//TPrimQueryCardOptionsForm.OpenTreeSelection

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimQueryCardOptionsForm);
 {* ����������� PrimQueryCardOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
