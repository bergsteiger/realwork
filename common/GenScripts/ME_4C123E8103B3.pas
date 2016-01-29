unit MergeCellsTest;

interface

uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
;

type
 TMergeCellsTest = class(TTableToolsTest)
  {* Объединение ячеек в таблице. }
  procedure ApplyTools(const aRange: IedRange);
   {* Вызвать инструмент для таблицы }
 end;//TMergeCellsTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
