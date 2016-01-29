unit HorzMergeCells;

interface

uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
;

type
 THorzMergeCells = class(TTableToolsTest)
  {* Объединение ячеек по горизонтали. }
  procedure ApplyTools(const aRange: IedRange);
   {* Вызвать инструмент для таблицы }
 end;//THorzMergeCells
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
