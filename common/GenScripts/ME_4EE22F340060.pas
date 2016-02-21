unit Translation_WarningBaloon_Form;
 {* ����� � ��������������� ��� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Translation_WarningBaloon_Form.pas"
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
 TTranslation_WarningBaloonForm = {final} class(TPrimWarningBaloonOptionsForm, Translation_WarningBaloonFormDef)
  {* ����� � ��������������� ��� �������� }
 end;//TTranslation_WarningBaloonForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , Translation_WarningBaloonKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TTranslation_WarningBaloonForm);
 {* ����������� Translation_WarningBaloon }
{$IfEnd} // NOT Defined(NoScripts)
 fm_Translation_WarningBaloonForm.SetFactory(TTranslation_WarningBaloonForm.Make);
 {* ����������� ������� ����� Translation_WarningBaloon }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
