unit ColumnAlignHorisontallyTest;

interface

uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
;

type
 TColumnAlignHorisontallyTest = class(TTableToolsTest)
  {* Выравнивание текста в колонке горизотально. }
  procedure ApplyTools(const aRange: IedRange);
   {* Вызвать инструмент для таблицы }
 end;//TColumnAlignHorisontallyTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
