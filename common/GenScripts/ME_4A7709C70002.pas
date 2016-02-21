unit Text_Form;
 {* ����� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Text_Form.pas"
// ���������: "VCMFinalContainer"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ExTextOptions_Form
 , Common_FormDefinitions_Controls
;

type
 TTextForm = {final} class(TExTextOptionsForm, TextFormDef)
  {* ����� ��������� }
 end;//TTextForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TextKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TTextForm);
 {* ����������� Text }
{$IfEnd} // NOT Defined(NoScripts)
 fm_TextForm.SetFactory(TTextForm.Make);
 {* ����������� ������� ����� Text }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
