unit kwPopEditorResizeTableColumnEX;

interface

uses
 l3IntfUses
 , kwEditorFromStackTableColumnResize
 , Classes
;

type
 TkwPopEditorResizeTableColumnEX = class(TkwEditorFromStackTableColumnResize)
  {* �������� ������ ������� �������. ������:
[code]   aDelta aKeys aCol aRow editor:ResizeTableColumnEX[code]
[panel]
 * aCol - ����� ������, ������� �����
 * aRow - ����� ������
 * aKeys - �������, ������� ��� ��������� ��������.
 * aDelta - �������� ������� (������������� - ������, ������������� - �����).
[panel] }
 end;//TkwPopEditorResizeTableColumnEX
 
implementation

uses
 l3ImplUses
 , tfwScriptingInterfaces
;

end.
