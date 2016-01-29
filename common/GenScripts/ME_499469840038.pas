unit vcmFormDispatcherInterfaces;

interface

uses
 l3IntfUses
 , vcmExternalInterfaces
;

type
 IvcmFormDispatcherListener = interface(IvcmBase)
  procedure StartNewMainForm;
   {* ���������� ����� ��������� ������� ����� }
 end;//IvcmFormDispatcherListener
 
 IvcmFormDispatcherNotify = interface(IvcmBase)
  {* ���������� � �������� ���������� ���� }
  procedure AddListener(const aListener: IvcmFormDispatcherListener);
  procedure RemoveListener(const aListener: IvcmFormDispatcherListener);
 end;//IvcmFormDispatcherNotify
 
implementation

uses
 l3ImplUses
;

end.
