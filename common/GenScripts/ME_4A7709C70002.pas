unit Text_Form;
 {* ����� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Text_Form.pas"
// ���������: "VCMFinalContainer"
// ������� ������: "Text" MUID: (4A7709C70002)
// ��� ����: "TTextForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ExTextOptions_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TTextForm = {final} class(TExTextOptionsForm, TextFormDef)
  {* ����� ��������� }
   Entities : TvcmEntities;
 end;//TTextForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TextKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TTextForm);
 {* ����������� Text }
{$IfEnd} // NOT Defined(NoScripts)
 fm_TextForm.SetFactory(TTextForm.Make);
 {* ����������� ������� ����� Text }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
