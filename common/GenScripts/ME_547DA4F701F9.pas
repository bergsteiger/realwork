unit evLinkedToolPanel;

interface

uses
 l3IntfUses
 , evToolPanel
 , evVisualInterfaces
 , Controls
 , Messages
;

type
 TevCustomLinkedToolPanel = class(TevCustomToolPanel, IevLinkedToolWindow)
  {* ������� ����� ��� ���������������� �������, ����������� � Control'�� }
  function Control: TWinControl;
   {* ����������� �������, � �������� ��������� ������. }
 end;//TevCustomLinkedToolPanel
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
