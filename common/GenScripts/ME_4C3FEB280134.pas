unit ChangeAllTablesTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , evCustomEditor
 , PrimTextLoad_Form
;

type
 TChangeAllTablesTest = class(TTextViaEditorProcessor)
  {* ������ �� ����� ��������� ���������. }
  procedure ApplyEditorTool(aEditor: TevCustomEditor);
   {* ����� ����������� �� ��������� }
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
 end;//TChangeAllTablesTest
 
implementation

uses
 l3ImplUses
 , evTypes
 , TestFrameWork
;

end.
