unit TB97ExtInterfaces;

interface

uses
 l3IntfUses
;

type
 ITB97Ctrl = interface
  {* ��������� �������������� �� ������������� ������������ ������������ �� toolbar-� }
  procedure DoFitToWidth(aWidth: Integer);
  procedure DoUnFitToWidth(aWidth: Integer);
  procedure Expand;
 end;//ITB97Ctrl
 
implementation

uses
 l3ImplUses
;

end.
