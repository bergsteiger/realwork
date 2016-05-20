unit Translation_WarningBaloon_Form;
 {* ����� � ��������������� ��� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Translation_WarningBaloon_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "Translation_WarningBaloon" MUID: (4EE22F340060)
// ��� ����: "TTranslation_WarningBaloonForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimWarningBaloonOptions_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TTranslation_WarningBaloonForm = {final} class(TPrimWarningBaloonOptionsForm, Translation_WarningBaloonFormDef)
  {* ����� � ��������������� ��� �������� }
   Entities : TvcmEntities;
 end;//TTranslation_WarningBaloonForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , Translation_WarningBaloonKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TTranslation_WarningBaloonForm);
 {* ����������� Translation_WarningBaloon }
{$IfEnd} // NOT Defined(NoScripts)
 fm_Translation_WarningBaloonForm.SetFactory(TTranslation_WarningBaloonForm.Make);
 {* ����������� ������� ����� Translation_WarningBaloon }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
