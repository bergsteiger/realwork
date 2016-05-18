unit ForbidAutoregistration_Form;
 {* ��������� ��������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\ForbidAutoregistration_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "ForbidAutoregistration" MUID: (4AA8E405032A)
// ��� ����: "TefForbidAutoregistration"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimForbidAutoregistrationOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_efForbidAutoregistration: TvcmFormDescriptor = (rFormID : (rName : 'efForbidAutoregistration'; rID : 0); rFactory : nil);
  {* ������������� ����� TefForbidAutoregistration }

type
 TefForbidAutoregistration = class;

 ForbidAutoregistrationFormDef = interface
  {* ������������� ����� ForbidAutoregistration }
  ['{5D4153F1-D087-4AF8-A4ED-39411EB7A1A3}']
 end;//ForbidAutoregistrationFormDef

 TefForbidAutoregistration = {final} class(TPrimForbidAutoregistrationOptionsForm, ForbidAutoregistrationFormDef)
  {* ��������� ��������������� }
 end;//TefForbidAutoregistration
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 , ForbidAutoregistration_ut_ForbidAutoregistration_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ForbidAutoregistrationKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* ������������ ������ ut_ForbidAutoregistrationLocalConstants }
 str_ut_ForbidAutoregistrationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_ForbidAutoregistrationCaption'; rValue : '��������� ���������������');
  {* ��������� ����������������� ���� "��������� ���������������" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefForbidAutoregistration);
 {* ����������� ForbidAutoregistration }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_ForbidAutoregistrationCaption.Init;
 {* ������������� str_ut_ForbidAutoregistrationCaption }
{$IfEnd} // Defined(Admin)

end.
