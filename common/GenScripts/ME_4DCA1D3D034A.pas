unit HorzMergeCells;

interface

uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
;

type
 THorzMergeCells = class(TTableToolsTest)
  {* ����������� ����� �� �����������. }
  procedure ApplyTools(const aRange: IedRange);
   {* ������� ���������� ��� ������� }
 end;//THorzMergeCells
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
