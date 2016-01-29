unit kwPopEditorResizeTableColumnEX;

interface

uses
 l3IntfUses
 , kwEditorFromStackTableColumnResize
 , Classes
;

type
 TkwPopEditorResizeTableColumnEX = class(TkwEditorFromStackTableColumnResize)
  {* Изменить размер колонки таблицы. Пример:
[code]   aDelta aKeys aCol aRow editor:ResizeTableColumnEX[code]
[panel]
 * aCol - номер ячейки, которую тянем
 * aRow - номер строки
 * aKeys - клавиша, нажатая при изменении размеров.
 * aDelta - смещение колонки (положительное - вправо, отрицательное - влево).
[panel] }
 end;//TkwPopEditorResizeTableColumnEX
 
implementation

uses
 l3ImplUses
 , tfwScriptingInterfaces
;

end.
