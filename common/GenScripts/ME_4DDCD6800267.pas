unit ChangesBetweenEditons_Form;
 {* ��������� � ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\Forms\ChangesBetweenEditons_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimChangesBetweenEditons_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_ChangesBetweenEditonsForm: TvcmFormDescriptor = (rFormID : (rName : 'ChangesBetweenEditonsForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TChangesBetweenEditonsForm }

type
 ChangesBetweenEditonsFormDef = interface
  {* ������������� ����� ChangesBetweenEditons }
  ['{E8402096-B641-4FAE-B341-69369D1BB399}']
 end;//ChangesBetweenEditonsFormDef

 TChangesBetweenEditonsForm = {final} class(TPrimChangesBetweenEditonsForm, ChangesBetweenEditonsFormDef)
  {* ��������� � ��������� }
 end;//TChangesBetweenEditonsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ChangesBetweenEditonsKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChangesBetweenEditonsForm);
 {* ����������� ChangesBetweenEditons }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ChangesBetweenEditonsForm.SetFactory(TChangesBetweenEditonsForm.Make);
 {* ����������� ������� ����� ChangesBetweenEditons }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
