unit kwIterateSubDecriptorsOnSubPanel;

interface

uses
 l3IntfUses
 , kwSubPanelFromStackWord
 , tfwScriptingInterfaces
 , evSubPn
 , evSubPanelSub
;

type
 TkwIterateSubDecriptorsOnSubPanel = class(TkwSubPanelFromStackWord)
  {* ���������� ��� SubDescriptot �� SubPanel, ������� *����� ����* ���������� (!). �.�. �������� �� Visible �� ������������. ���� ��� �����, �� ����� ���������� � ��������. 
������:
[code]
@ aWord aLayerID aSubPanel IterateSubDecriptorsOnSubPanel
[code]
aLayerID - ����, � ������� ������������ ��������
aSubPanel - ������� ���������.
aWord - ������� ��� ��������� ����:
[code]
PROCEDURE CheckDescription OBJECT IN aSubDescription INTEGER IN aHandle
 // � ����� ������������ ���������� aSubDescription
;
[code]
��� ���������� ������ ��������� �� aSubDescription ���� ����� �������: subdescriptor:GetDrawType � �.�.
aHandle - ����� ����, � �������� �������� �����. }
  procedure PushObjData(const aCtx: TtfwContext;
   aSubDescription: TevSubDescriptor;
   aSubPanelSub: TevSubPanelSub);
  procedure DoWithSubPanel(aControl: TevCustomSubPanel;
   const aCtx: TtfwContext);
 end;//TkwIterateSubDecriptorsOnSubPanel
 
implementation

uses
 l3ImplUses
 , evSubPanelSubCollection
 , evSubPanelSubArray
;

end.
