unit AACContainer_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContainer_Form.pas"
// ���������: "VCMFinalContainer"
// ������� ������: "AACContainer" MUID: (4FF2E95602D8)
// ��� ����: "TAACContainerForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , AACTextContainerPrim_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_AACContainerForm: TvcmFormDescriptor = (rFormID : (rName : 'AACContainerForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TAACContainerForm }

type
 TAACContainerForm = class;

 AACContainerFormDef = interface
  {* ������������� ����� AACContainer }
  ['{548CB0E3-A19F-4AD8-A785-C6FB8E70BF73}']
 end;//AACContainerFormDef

 TAACContainerForm = {final} class(TAACTextContainerPrimForm, AACContainerFormDef)
 end;//TAACContainerForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , AACContainerKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TAACContainerForm);
 {* ����������� AACContainer }
{$IfEnd} // NOT Defined(NoScripts)
 fm_AACContainerForm.SetFactory(TAACContainerForm.Make);
 {* ����������� ������� ����� AACContainer }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
