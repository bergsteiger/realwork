unit MergeTablesTest;

interface

uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
;

type
 TMergeTablesTest = class(TTableToolsTest)
  {* Тестирование объединения таблиц }
  procedure ApplyTools(const aRange: IedRange);
   {* Вызвать инструмент для таблицы }
 end;//TMergeTablesTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
