unit PrimPictureInfoOptions_Form;
 {* ���������� � �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimPictureInfoOptions_Form.pas"
// ���������: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimPictureInfo_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimPictureInfoOptionsForm = class(TPrimPictureInfoForm)
  {* ���������� � �������� }
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
   procedure Cancel; override;
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimPictureInfoOptionsForm
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
procedure TPrimPictureInfoOptionsForm.Cut;
 {* �������� }
//#UC START# *4951285702E1_4C86319003CD_var*
//#UC END# *4951285702E1_4C86319003CD_var*
begin
//#UC START# *4951285702E1_4C86319003CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4951285702E1_4C86319003CD_impl*
end;//TPrimPictureInfoOptionsForm.Cut
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPictureInfoOptionsForm.Paste;
 {* ������� }
//#UC START# *49EDFA3701B0_4C86319003CD_var*
//#UC END# *49EDFA3701B0_4C86319003CD_var*
begin
//#UC START# *49EDFA3701B0_4C86319003CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFA3701B0_4C86319003CD_impl*
end;//TPrimPictureInfoOptionsForm.Paste
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPictureInfoOptionsForm.Cancel;
 {* ������ }
//#UC START# *4C762C910358_4C86319003CD_var*
//#UC END# *4C762C910358_4C86319003CD_var*
begin
//#UC START# *4C762C910358_4C86319003CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762C910358_4C86319003CD_impl*
end;//TPrimPictureInfoOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPictureInfoOptionsForm);
 {* ����������� PrimPictureInfoOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
