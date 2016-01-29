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
  {* Тесты разбиения таблиц }
  function GetLineCount: Integer;
   {* Количество строчек (текста), на которое нужно сдинуть курсор перед разбиванием табилцы на две. }
  procedure ApplyTools(const aRange: IedRange);
   {* Вызвать инструмент для таблицы }
 end;//TSplitTableTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
;

end.
