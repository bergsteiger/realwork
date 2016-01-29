unit TableToolsTestPrim;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , evEditorInterfaces
 , PrimTextLoad_Form
;

type
 TTableToolsTestPrim = class(TTextViaEditorProcessor)
  procedure ApplyTools(const aRange: IedRange);
   {* ������� ���������� ��� ������� }
  procedure CheckOperation(aForm: TPrimTextLoadForm);
   {* �������� ����� ���������� �����������. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
 end;//TTableToolsTestPrim
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
