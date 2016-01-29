unit kwPopEditorSelectCells;

interface

uses
 l3IntfUses
 , kwSelectCellsWord
;

type
 TkwPopEditorSelectCells = class(TkwSelectCellsWord)
  {* *Формат:* aStartCell aStartRow aFinshCell aFinishRow anEditorControl pop:editor:SelectCells
*Описание:* Выделяет диапазон ячеек с помощью мыши начиная от начальной (aStartCell, aRowCell) до конечной (aFinishCell, aFinishRow). Курсор должен уже находится в таблице. Положение курсора в таблице не имеет значения. Параметры aStartCell aStartRow aFinshCell aFinishRow - Integer
*Пример:*
[code] 
0 0 2 2 focused:control:push pop:editor:SelectCells
[code] 
*Результат:* Выделяет диапазон ячеек в таблице от (0, 0) до (2, 2) у текущего редактора.
*Примечание:* В каждой ячейке должен быть только один параграф, иначе выделение будет неправильным.
*Примечание 2:* Текст в начальной ячейке должен быть выровнен по левому краю. Иначе  появится сообщение об ошибке. }
  function IsVertical: Boolean;
   {* При выделении мышь движется сверху вниз. }
 end;//TkwPopEditorSelectCells
 
implementation

uses
 l3ImplUses
;

end.
