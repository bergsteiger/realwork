unit kwPopEditorResizeTableColumn;

interface

uses
 l3IntfUses
 , kwEditorFromStackTableColumnResize
;

type
 TkwPopEditorResizeTableColumn = class(TkwEditorFromStackTableColumnResize)
  {* �������� ������ ������� �������. ������:
[code]   aDelta aCol aRow editor:ResizeTableColumn [code]
[panel]
 * aCol - ����� ������, ������� �����
 * aRow - ����� ������
 * aDelta - �������� ������� (������������� - ������, ������������� - �����).
[panel] }
 end;//TkwPopEditorResizeTableColumn
 
implementation

uses
 l3ImplUses
;

end.
