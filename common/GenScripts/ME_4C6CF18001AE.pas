unit SplitTableTest;

interface

uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
 , PrimTextLoad_Form
;

type
 TSplitTableTest = class(TTableToolsTest)
  {* ����� ��������� ������ }
  function GetLineCount: Integer;
   {* ���������� ������� (������), �� ������� ����� ������� ������ ����� ����������� ������� �� ���. }
  procedure ApplyTools(const aRange: IedRange);
   {* ������� ���������� ��� ������� }
 end;//TSplitTableTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
;

end.
