unit MergeCellsTest;

interface

uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
;

type
 TMergeCellsTest = class(TTableToolsTest)
  {* ����������� ����� � �������. }
  procedure ApplyTools(const aRange: IedRange);
   {* ������� ���������� ��� ������� }
 end;//TMergeCellsTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
