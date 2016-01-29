unit kwIterateSubDescriptors;

interface

uses
 l3IntfUses
 , kwSubPanelFromStackWord
 , evSubPn
 , tfwScriptingInterfaces
;

type
 TkwIterateSubDescriptors = class(TkwSubPanelFromStackWord)
  {* ���������� ��� SubDescriptot �� SubPanel, ������� ����� ���� ������������ (!). ����� ������ �������� �� ����� ��������������/��������� ���������. � �� ������� �� ���� �����������.
������:
[code]
@ aWord aLayerID aSubPanel ItarateSubDescriptors
[code]
aLayerID - ����, � ������� ������������ ��������
aSubPanel - ������� ���������.
aWord - ������� ��� ��������� ����:
[code]
PROCEDURE CheckDescription OBJECT IN aSubDescription
 // � ����� ������������ ���������� aSubDescription
;
[code]
��� ���������� ������ ��������� �� aSubDescription ���� ����� �������: subdescriptor:GetDrawType � �.�. }
  procedure DoWithSubPanel(aControl: TevCustomSubPanel;
   const aCtx: TtfwContext);
 end;//TkwIterateSubDescriptors
 
implementation

uses
 l3ImplUses
;

end.
