unit MergeTablesTest;

interface

uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
;

type
 TMergeTablesTest = class(TTableToolsTest)
  {* ������������ ����������� ������ }
  procedure ApplyTools(const aRange: IedRange);
   {* ������� ���������� ��� ������� }
 end;//TMergeTablesTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
