unit kwPopEditorSelectCells;

interface

uses
 l3IntfUses
 , kwSelectCellsWord
;

type
 TkwPopEditorSelectCells = class(TkwSelectCellsWord)
  {* *������:* aStartCell aStartRow aFinshCell aFinishRow anEditorControl pop:editor:SelectCells
*��������:* �������� �������� ����� � ������� ���� ������� �� ��������� (aStartCell, aRowCell) �� �������� (aFinishCell, aFinishRow). ������ ������ ��� ��������� � �������. ��������� ������� � ������� �� ����� ��������. ��������� aStartCell aStartRow aFinshCell aFinishRow - Integer
*������:*
[code] 
0 0 2 2 focused:control:push pop:editor:SelectCells
[code] 
*���������:* �������� �������� ����� � ������� �� (0, 0) �� (2, 2) � �������� ���������.
*����������:* � ������ ������ ������ ���� ������ ���� ��������, ����� ��������� ����� ������������.
*���������� 2:* ����� � ��������� ������ ������ ���� �������� �� ������ ����. �����  �������� ��������� �� ������. }
  function IsVertical: Boolean;
   {* ��� ��������� ���� �������� ������ ����. }
 end;//TkwPopEditorSelectCells
 
implementation

uses
 l3ImplUses
;

end.
