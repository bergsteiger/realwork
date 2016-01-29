unit TableToolsTest;

interface

uses
 l3IntfUses
 , TableToolsTestPrim
 , PrimTextLoad_Form
;

type
 TTableToolsTest = class(TTableToolsTestPrim)
  {* “есты инструментов работы с таблицами }
  procedure CheckOperation(aForm: TPrimTextLoadForm);
   {* ѕроверка после применени€ инструмента. }
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
