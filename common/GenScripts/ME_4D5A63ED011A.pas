unit SplitCellTest;

interface

uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
 , PrimTextLoad_Form
;

type
 TSplitCellTest = class(TTableToolsTest)
  {* Тест разделения ячеек }
  function GetLineCount: Integer;
  function GetTabCount: Integer;
  procedure ApplyTools(const aRange: IedRange);
   {* Вызвать инструмент для таблицы }
 end;//TSplitCellTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
;

end.
