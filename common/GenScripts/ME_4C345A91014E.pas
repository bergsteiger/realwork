unit TableToolsTest;

interface

uses
 l3IntfUses
 , TableToolsTestPrim
 , PrimTextLoad_Form
;

type
 TTableToolsTest = class(TTableToolsTestPrim)
  {* ����� ������������ ������ � ��������� }
  procedure CheckOperation(aForm: TPrimTextLoadForm);
   {* �������� ����� ���������� �����������. }
 end;//TTableToolsTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 , evCursorTools
;

end.
