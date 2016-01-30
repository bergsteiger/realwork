unit MemoryUsage_Form;
 {* ������������ ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\MemoryUsage_Form.pas"
// ���������: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , MemoryUsagePrim_Form
 , l3StringIDEx
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_MemoryUsageForm: TvcmFormDescriptor = (rFormID : (rName : 'MemoryUsageForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TMemoryUsageForm }

type
 MemoryUsageFormDef = interface
  {* ������������� ����� MemoryUsage }
  ['{239C1E38-C6A8-4737-8D22-0F6E2D5E4762}']
 end;//MemoryUsageFormDef

 TMemoryUsageForm = {final} class(TMemoryUsagePrimForm, MemoryUsageFormDef)
  {* ������������ ������� }
 end;//TMemoryUsageForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , MemoryUsageKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ������������ ������ ut_MemoryUsageLocalConstants }
 str_ut_MemoryUsageCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_MemoryUsageCaption'; rValue : '������������ �������');
  {* ��������� ����������������� ���� "������������ �������" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMemoryUsageForm);
 {* ����������� MemoryUsage }
{$IfEnd} // NOT Defined(NoScripts)
 fm_MemoryUsageForm.SetFactory(TMemoryUsageForm.Make);
 {* ����������� ������� ����� MemoryUsage }
 str_ut_MemoryUsageCaption.Init;
 {* ������������� str_ut_MemoryUsageCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
