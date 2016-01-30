unit vcmFormDispatcherInterfaces;
 {* ���������� ��� ������ � ����������� ���� }

// ������: "w:\common\components\gui\Garant\VCM\vcmFormDispatcherInterfaces.pas"
// ���������: "Interfaces"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
;

type
 IvcmFormDispatcherListener = interface(IvcmBase)
  ['{BABDE672-E93F-47FE-977B-BA11D6250821}']
  procedure StartNewMainForm;
   {* ���������� ����� ��������� ������� ����� }
 end;//IvcmFormDispatcherListener

 IvcmFormDispatcherNotify = interface(IvcmBase)
  {* ���������� � �������� ���������� ���� }
  ['{B91EBDC9-90C1-4165-BD33-8EB57BA4DACA}']
  procedure AddListener(const aListener: IvcmFormDispatcherListener);
  procedure RemoveListener(const aListener: IvcmFormDispatcherListener);
 end;//IvcmFormDispatcherNotify
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
