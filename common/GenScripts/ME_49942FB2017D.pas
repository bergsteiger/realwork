unit vcmLocalInterfaces;

interface

uses
 l3IntfUses
 , l3Interfaces
 , vcmUserControls
;

type
 IvcmFormSetDataSourceListener = interface(Il3Notify)
  {* ��������� ������� ������ ������� ������ }
  procedure DataChanged;
   {* ������ ���������� }
 end;//IvcmFormSetDataSourceListener
 
 IvcmDock = interface
  {* ��������� �������������� dock-�� toolbar-�� }
 end;//IvcmDock
 
implementation

uses
 l3ImplUses
;

end.
