unit PrimAdmin_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimAdmin_Form.pas"
// ���������: "VCMContainer"

{$Include nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 , vtProportionalPanel
 , vtSizeablePanel
 , vtPanel
 , l3StringIDEx
;

type
 // Parent

 // Child

 TPrimAdminForm = class(TvcmContainerForm)
  private
   f_BackgroundPanel: TvtProportionalPanel;
    {* ���� ��� �������� BackgroundPanel }
   f_PropertyZone: TvtSizeablePanel;
    {* ���� ��� �������� PropertyZone }
   f_TreeZone: TvtPanel;
    {* ���� ��� �������� TreeZone }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property BackgroundPanel: TvtProportionalPanel
    read f_BackgroundPanel;
 end;//TPrimAdminForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , Admin_Users_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ������������ ������ utAdminLocalConstants }
 str_utAdminCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utAdminCaption'; rValue : '����������������� �������������');
  {* ��������� ����������������� ���� "����������������� �������������" }

procedure TPrimAdminForm.InitFields;
//#UC START# *47A042E100E2_4AFB0146035B_var*
//#UC END# *47A042E100E2_4AFB0146035B_var*
begin
//#UC START# *47A042E100E2_4AFB0146035B_impl*
 inherited;
 ActiveControl := TreeZone;
//#UC END# *47A042E100E2_4AFB0146035B_impl*
end;//TPrimAdminForm.InitFields

{$If NOT Defined(NoVCM)}
procedure TPrimAdminForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_4AFB0146035B_var*
//#UC END# *4A8E8F2E0195_4AFB0146035B_var*
begin
//#UC START# *4A8E8F2E0195_4AFB0146035B_impl*
 inherited;
 with BackgroundPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
 with TreeZone do
 begin
  Align := alClient;
  BevelOuter := bvNone;
  Constraints.MinHeight := 100;
 end;
 with PropertyZone do
 begin
  ResizeAreaWidth := 5;
  SizeableSides := [szTop];
  SplitterBevel := bvRaised;
  Align := alBottom;
  Height := 195;
  BevelOuter := bvNone;
 end;
//#UC END# *4A8E8F2E0195_4AFB0146035B_impl*
end;//TPrimAdminForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_utAdminCaption.Init;
 {* ������������� str_utAdminCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimAdminForm);
 {* ����������� PrimAdmin }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
