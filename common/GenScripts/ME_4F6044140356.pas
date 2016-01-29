unit kwPopEditorSelectCellsVertical;

interface

uses
 l3IntfUses
 , kwSelectCellsWord
;

type
 TkwPopEditorSelectCellsVertical = class(TkwSelectCellsWord)
  {* *������:* aStartCell aStartRow aFinshCell aFinishRow anEditorControl pop:editor:SelectCellsVertical
*��������:* �������� �������� ����� � ������� ���� ������� �� ��������� (aStartCell, aRowCell) �� �������� (aFinishCell, aFinishRow). ������ ������ ��� ��������� � �������. ��������� ������� � ������� �� ����� ��������. ��������� aStartCell aStartRow aFinshCell aFinishRow - Integer
*������:*
[code] 
0 0 2 2 focused:control:push pop:editor:SelectCellsVertical
[code] 
*���������:* �������� �������� ����� � ������� �� (0, 0) �� (2, 2) � �������� ���������.
*����������:* � ������ ������ ������ ���� ������ ���� ��������, ����� ��������� ����� ������������.
*���������� 2:* ����� � ��������� ������ ������ ���� �������� �� ������ ����. �����  �������� ��������� �� ������. }
  function IsVertical: Boolean;
   {* ��� ��������� ���� �������� ������ ����. }
 end;//TkwPopEditorSelectCellsVertical
 
implementation

uses
 l3ImplUses
;

end.
