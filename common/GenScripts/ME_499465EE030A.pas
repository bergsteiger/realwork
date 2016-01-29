unit vcmToolbarsInterfaces;

interface

uses
 l3IntfUses
 , vcmExternalInterfaces
;

type
 IvcmToolbarsCustomizeListener = interface(IvcmBase)
  {* ��������� ������� ��������� ������� ������������ }
  procedure BeforeCustomize;
   {* ���������� ����� ������� ���� �������������� ������� ������������ }
 end;//IvcmToolbarsCustomizeListener
 
 IvcmToolbarsCustomizeNotify = interface(IvcmBase)
  {* ���������� � �������� �������������� ������ ������������ }
  procedure AddListener(const aListener: IvcmToolbarsCustomizeListener);
  procedure RemoveListener(const aListener: IvcmToolbarsCustomizeListener);
 end;//IvcmToolbarsCustomizeNotify
 
 IvcmToolbarsCustomize = interface(IvcmBase)
  {* ��������� ������� ������������ }
 end;//IvcmToolbarsCustomize
 
implementation

uses
 l3ImplUses
;

end.
