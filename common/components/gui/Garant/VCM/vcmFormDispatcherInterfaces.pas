unit vcmFormDispatcherInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/vcmFormDispatcherInterfaces.pas"
// �����: 12.02.2009 21:25
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::VCM::vcmFormDispatcherInterfaces
//
// ���������� ��� ������ � ����������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces
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
{$IfEnd} //not NoVCM

implementation

end.