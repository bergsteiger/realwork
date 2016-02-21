unit WarningBaloon_Form;
 {* ������ � ��������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\WarningBaloon_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimWarningBaloonOptions_Form
 , Common_FormDefinitions_Controls
;

type
 TWarningBaloonForm = {final} class(TPrimWarningBaloonOptionsForm, WarningBaloonFormDef)
  {* ������ � ��������������� }
 end;//TWarningBaloonForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , WarningBaloonKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TWarningBaloonForm);
 {* ����������� WarningBaloon }
{$IfEnd} // NOT Defined(NoScripts)
 fm_WarningBaloonForm.SetFactory(TWarningBaloonForm.Make);
 {* ����������� ������� ����� WarningBaloon }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
