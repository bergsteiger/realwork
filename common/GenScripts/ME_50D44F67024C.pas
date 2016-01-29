unit kwPopEditorCheckWithEtalon;

interface

uses
 l3IntfUses
 , tfwWordWorker
 , kwCompiledWordWorker
 , tfwScriptingInterfaces
;

type
 TkwPopEditorCheckWithEtalon = class(TtfwWordWorker)
  {* *��������:*
�������������� �������� �������� ������ �� ������������ ��� ������. ���������� ������ �� ��������� ��������� ������ ����� ��������� �������. ��������� ���� � ������ NNN.shapes - ��� NNN - ����� ����� (��������! ��� ����� ����� ���������� � TK) . ���� �� ����� �� ������������ �������, �� �� ���������. � ��� ���������� � ����� ��������� �����. ���� ������ ��� �����������, �� ������������ ��������� ����� ������ ����� � ��������. ���� ��������� �� ������, �� �� ���� ����� �������� (���� ����� ��������� �� ���������) � ����� ������� ������� ��������� ��������� ������.
*������:*
[code]
anEditor pop:editor:CheckWithEtalon aProc
[code]
��� anEditor - ��������� �� ��������, � ������� ����� ��������� ���������. aProc - ���������, ���������� ���������.
*������:*
[code]
focused:control:push pop:editor:CheckWithEtalon "��������� ������ �������"
[code]
��������� ��������� � ���������, ��� ��������� ����� ����� ���������� ������� "��������� ������ �������". }
  function CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker;
 end;//TkwPopEditorCheckWithEtalon
 
implementation

uses
 l3ImplUses
 , kwCompiledCheckWithEtalon
;

end.
