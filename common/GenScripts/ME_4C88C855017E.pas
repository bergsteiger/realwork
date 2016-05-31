unit PrimAttributeSelectOptions_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimAttributeSelectOptions_Form.pas"
// ���������: "VCMContainer"
// ������� ������: "PrimAttributeSelectOptions" MUID: (4C88C855017E)
// ��� ����: "TPrimAttributeSelectOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimAttributeSelect_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimAttributeSelectOptionsForm = class(TPrimAttributeSelectForm)
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimAttributeSelectOptionsForm

implementation

uses
 l3ImplUses
 , SearchLite_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C88C855017Eimpl_uses*
 //#UC END# *4C88C855017Eimpl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimAttributeSelectOptionsForm.InitEntities;
 {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
begin
 inherited;
 with Entities.Entities do
 begin
  ShowInContextMenu(en_Result, op_ClearAll, True);
  ShowInToolbar(en_Result, op_ClearAll, True);
  ShowInContextMenu(en_Result, op_Cancel, True);
  ShowInToolbar(en_Result, op_Cancel, True);
  ShowInContextMenu(en_Result, op_OkExt, True);
  ShowInToolbar(en_Result, op_OkExt, True);
 end;//with Entities.Entities
end;//TPrimAttributeSelectOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimAttributeSelectOptionsForm);
 {* ����������� PrimAttributeSelectOptions }
{$IfEnd} // NOT Defined(NoScripts)

end.
