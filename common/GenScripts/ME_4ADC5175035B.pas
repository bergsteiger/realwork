unit nsWindowsList;

interface

uses
 l3IntfUses
 , nsWindowsListPrim
;

type
 TnsWindowsList = class(TnsWindowsListPrim)
  {* ����� ����������� ������� ���� }
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TnsWindowsList
 
implementation

uses
 l3ImplUses
;

end.
