unit npControlsList;

interface

uses
 l3IntfUses
 , npControlsListPrim
;

type
 TnpControlsList = class(TnpControlsListPrim)
  {* ������ ����������� �� �����, �� ������� ���� ����������� ����������. }
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TnpControlsList
 
implementation

uses
 l3ImplUses
;

end.
