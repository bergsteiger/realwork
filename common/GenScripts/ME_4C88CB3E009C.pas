unit PrimListInfoOptions_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\PrimListInfoOptions_Form.pas"
// ���������: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimListInfo_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimListInfoOptionsForm = class(TPrimListInfoForm)
  public
   {$If NOT Defined(NoVCM)}
   procedure Copy; override;
    {* ���������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Print; override;
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintDialog; override;
    {* ������... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintPreview; override;
    {* ��������������� �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Paste; override;
    {* ������� }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimListInfoOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , afwInterfaces
 , afwFacade
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimListInfoOptionsForm.Copy;
 {* ���������� }
//#UC START# *4951284902BD_4C88CB3E009C_var*
//#UC END# *4951284902BD_4C88CB3E009C_var*
begin
//#UC START# *4951284902BD_4C88CB3E009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4951284902BD_4C88CB3E009C_impl*
end;//TPrimListInfoOptionsForm.Copy
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListInfoOptionsForm.Print;
 {* ������ }
//#UC START# *49521D8E0295_4C88CB3E009C_var*
//#UC END# *49521D8E0295_4C88CB3E009C_var*
begin
//#UC START# *49521D8E0295_4C88CB3E009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *49521D8E0295_4C88CB3E009C_impl*
end;//TPrimListInfoOptionsForm.Print
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListInfoOptionsForm.PrintDialog;
 {* ������... }
//#UC START# *495220DE0298_4C88CB3E009C_var*
//#UC END# *495220DE0298_4C88CB3E009C_var*
begin
//#UC START# *495220DE0298_4C88CB3E009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220DE0298_4C88CB3E009C_impl*
end;//TPrimListInfoOptionsForm.PrintDialog
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListInfoOptionsForm.PrintPreview;
 {* ��������������� �������� }
//#UC START# *495220F2033A_4C88CB3E009C_var*
//#UC END# *495220F2033A_4C88CB3E009C_var*
begin
//#UC START# *495220F2033A_4C88CB3E009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220F2033A_4C88CB3E009C_impl*
end;//TPrimListInfoOptionsForm.PrintPreview
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListInfoOptionsForm.Paste;
 {* ������� }
//#UC START# *49EDFA3701B0_4C88CB3E009C_var*
//#UC END# *49EDFA3701B0_4C88CB3E009C_var*
begin
//#UC START# *49EDFA3701B0_4C88CB3E009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFA3701B0_4C88CB3E009C_impl*
end;//TPrimListInfoOptionsForm.Paste
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimListInfoOptionsForm);
 {* ����������� PrimListInfoOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
