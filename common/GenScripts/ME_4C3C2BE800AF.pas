unit ColumnAlignHorisontallyTest;

interface

uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
;

type
 TColumnAlignHorisontallyTest = class(TTableToolsTest)
  {* ������������ ������ � ������� ������������. }
  procedure ApplyTools(const aRange: IedRange);
   {* ������� ���������� ��� ������� }
 end;//TColumnAlignHorisontallyTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
