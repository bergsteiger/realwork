unit nscTaskPanelInterfaces;

interface

uses
 l3IntfUses
 , vcmTaskPanelInterfaces
;

type
 InscOperationNode = interface
  {* ���� �������� ������ ����� }
  procedure CaptionChanged;
   {* ���������� �������� �������� }
 end;//InscOperationNode
 
implementation

uses
 l3ImplUses
;

end.
