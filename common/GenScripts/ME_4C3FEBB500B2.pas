unit OldNSRCFlagCnahge;

interface

uses
 l3IntfUses
 , ChangeAllTablesTest
 , evCustomEditor
;

type
 TOldNSRCFlagCnahge = class(TChangeAllTablesTest)
  {* �������� ���� "�������� � �������������" �� ���� �������� � ���������. }
  procedure ApplyEditorTool(aEditor: TevCustomEditor);
   {* ����� ����������� �� ��������� }
 end;//TOldNSRCFlagCnahge
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
