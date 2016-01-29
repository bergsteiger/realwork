unit kwPopEditorResizeTableColumn;

interface

uses
 l3IntfUses
 , kwEditorFromStackTableColumnResize
;

type
 TkwPopEditorResizeTableColumn = class(TkwEditorFromStackTableColumnResize)
  {* »зменить размер колонки таблицы. ѕример:
[code]   aDelta aCol aRow editor:ResizeTableColumn [code]
[panel]
 * aCol - номер €чейки, которую т€нем
 * aRow - номер строки
 * aDelta - смещение колонки (положительное - вправо, отрицательное - влево).
[panel] }
 end;//TkwPopEditorResizeTableColumn
 
implementation

uses
 l3ImplUses
;

end.
